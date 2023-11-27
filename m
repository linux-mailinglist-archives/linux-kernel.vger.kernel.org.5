Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45B37FA604
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbjK0QRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjK0QRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:17:31 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04hn2245.outbound.protection.outlook.com [52.100.163.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5E199
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:17:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIP4RXh+ypTlXJ+uR9ayk27/hePk8KARb7fjLGRcBuOyXBmf8xxbrAsKhRUpVgsj/bwD5Ga7NI5xgrR0hTqm2yL4K42r+r34YnNnJqFsiV1ezNu55yIDRToK+UQSzT+Y6ioGpSw4q0SrOPwoiZryDl5d6p0yohMMVshl9gVC5xVAFF26kaOnn9cdfmt9lBuFemEs4anH2E91TKyqZVTpwVL1quaS3kYNLgvtl8Equ9xmZvABoSg8SxUjLMOUdcFqqqk6pONfVkuvXFDnT9HSCGxhJgFxBkmEniPNQXTklf4ADnnIiOyl4llhpZrgBScozBKqQWzxxx392yBkal2mRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LV4Qo84yqkkhE5n/AxX1cCkGXanBJAR199j1nc+Hg7k=;
 b=RXtq3VD2m1yh1WLDbOgWHYnXK9DBxb8jwXSGyZ5Xn079jlqF6ZlGa6bxp/cJ44wTfKZgVh6dKqfrx22Qti41Z89fdpqrypEKhZe+JOgf4iUb5ZR9ZdxMZyDZ/S13KVnLX1SauJGLNshEolN6WYJMqkPIk44BcMSg0j1JDA2MuAI7cpU1ZHQ0MbswZJmFPdtSbzB/fIX+HYVFM7xyptmfths/Nj34dHHbmYcQ5kf3O2Mc+tdsu27wV8J/rTsReNdj6oLaCU6DrTHvL1hDRQh9gUnSP0hsTxO8AOXW3HinawCB0MLzYfPokJhemDCODty60S2Rob8OgGoApcgdyeRVeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LV4Qo84yqkkhE5n/AxX1cCkGXanBJAR199j1nc+Hg7k=;
 b=tcQMdctLKr2ZzHw0ZSuwdQIL/m0mmyD247NijFBZCPbdm8nbyfrI/KfqnKgF7HVeRPqbpP/5o/uoN8NY3paqIymrVfuVxfwJ+pGX1/kRkXlmuDQuf6LWZ62hlFa1VpDJpYr8Y3bme9JexQVAOmQw+cXgyU7jBvOUZTOh8FJRobTjCiP4BfMeLvt+6+f3GEFvBREHrY4+iZHbC6AQOw/fDimWHdxLWln1tVdtq0x4gZeIcow7zs4eSkQWjmFzss9n/bTnOw/Tw+a6IgefL3HrQuQ4e1Kz0IRpGgee5+KjBkX5VoFrimuS81h6NxYr/kY3bLAMRUeLdxXKEKF6Z46tAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4081.namprd12.prod.outlook.com (2603:10b6:a03:20e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 16:17:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 16:17:33 +0000
Date:   Mon, 27 Nov 2023 12:17:32 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <20231127161732.GL436702@nvidia.com>
References: <20231121070619.9836-1-saeed@kernel.org>
 <20231121070619.9836-3-saeed@kernel.org>
 <2023112702-postal-rumbling-003f@gregkh>
 <20231127144017.GK436702@nvidia.com>
 <2023112752-pastel-unholy-c63d@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023112752-pastel-unholy-c63d@gregkh>
X-ClientProxiedBy: MN2PR15CA0022.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4081:EE_
X-MS-Office365-Filtering-Correlation-Id: 52309547-5c5e-4b55-0974-08dbef645c5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lv5Mmk6PsRyHvCemcueYYJuJLXFyYeqpnsOspcCDkGYh3PvnUC4IoPAbfybl?=
 =?us-ascii?Q?rXWPqY4auebI0+KlOXK/IoOvwyc4GO8vjkC+7/Qx3owLNBPlnZRofn5q6Zh2?=
 =?us-ascii?Q?XRmq47OG9zkCxCJGAlhnBtpTiDlw9L8Nmc11jQ2gBuvrBBuWE2SIShV3lPye?=
 =?us-ascii?Q?Z0FQpz+AClQ4LS+GOUT5Vq5VGp/TKSFzg/ZOJc/xzBG4UGjoJzV0rTLZSXhM?=
 =?us-ascii?Q?II14xP6UWjJOMPkPolfMdACuwfWQ20YQ5Nlxw4pegdZVRa3NIW5iSOKMm2IP?=
 =?us-ascii?Q?voCgFjqJ2klUwcLZP0aNtalN4SVSw+Xn5Hcl5EvkcEhrD9lPPi2OVI2/JLAw?=
 =?us-ascii?Q?0LC9zt5Q4ge09TlqKzBX/J7v5Yxf7tuULnqdssoKyVmw8wb+D9cS54+xuz0o?=
 =?us-ascii?Q?X5FXmjJGi569f8V4RRMt7LgELWZexs3UIeo6xiVJmK/20ApAyKBdr7Q+UoJ3?=
 =?us-ascii?Q?0boLsbzeO6koyPps2oaS8T8Th/Ea8vtRhCMSEOsX/Q4iQ0g2bjsZZrPLwLZl?=
 =?us-ascii?Q?VZmrzBN5yVX7sKl3LoZJpqy/vAP9I+TR/HdEj5A/OqElvNuSHbxFm8/6KwQU?=
 =?us-ascii?Q?UT6DI+mGjXT8V4SD9EpWqcvZPDhAHObE5t/+ZOdkG7QIyIGQjNMT2Pe+I6aJ?=
 =?us-ascii?Q?YHGP4zrFMVK77KrJ5qKGLAIaij5Uup1RjX3I7d0X89B+KPEZEsp/fsX8B0/g?=
 =?us-ascii?Q?yiO/ScXKXD3Xb/jVLff39A2hRye+StJlXb4lWAnp7FRp1YMBqE4x5zdYHi9Y?=
 =?us-ascii?Q?FS6x1Ou6SHUq5eIiAyTfV33xtfUkyQ6TErPUQL1ksaiiCHVfDrC8Jf8lv2yV?=
 =?us-ascii?Q?1nkAMKe8t+pYBAZGIlEPW8L+4pP0mRs421T54QDZ1HITA/29Sfi7GUA6vXyi?=
 =?us-ascii?Q?voSssMZKyVTSbCBKtUzNPHwHXC6CpMx62wiN5bgnm6it/s1Zf6XwoaAYSmGo?=
 =?us-ascii?Q?W471OqBA6AL19aPTowJeCmEkhv/jcpcbspPtuCSe4HyroR3SErJoLYUehQG+?=
 =?us-ascii?Q?Q6Qc0rgU/PzMFLahDp5Ol+kwlA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(13230031)(366004)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(2906002)(4744005)(41300700001)(66946007)(6512007)(54906003)(8676002)(8936002)(6916009)(316002)(66476007)(66556008)(478600001)(6486002)(6506007)(5660300002)(4326008)(2616005)(107886003)(26005)(1076003)(38100700002)(86362001)(36756003)(33656002)(27376004)(42413004);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7htOYTZEhXwawtX3Hpr0ioXDYZ6meev9w01aLFCuiKYpCLV8pm5fzkIh9tBy?=
 =?us-ascii?Q?GwCsnmwSb6X+znxL79ihJR9jds9f4b2edMRUXMks8bpj34w6tTK/0o3ycnRn?=
 =?us-ascii?Q?fcT/djVqhh4DyH2A3r4gbaHsCshslnveUTfjTlLG74xRbSED5e4vZ+ev6FSB?=
 =?us-ascii?Q?W3gIs8WEojE1gcMo0Lah8KjfQqckUaK8S6BEih/rBJhecKJysIR5Tg9rP1WC?=
 =?us-ascii?Q?5dsH4glmMgwmwV+C/GHhqcbcQcaNKNSZJcOklOKZIsLaMI2XFWEEyLeRE7ND?=
 =?us-ascii?Q?q5jRRwzjH40dpfcPDzrDl6BuD1Im75S3XySPh/oFM+85x66k5ILlD5/kbGob?=
 =?us-ascii?Q?vURefsdGJIaT8k8gfr4pH/xAQwpN32udUwZDBs4M8fJLnVGPQ13MTFwRUDWZ?=
 =?us-ascii?Q?0Ia4GSYzrWHEsk91Q580oaXXFrDMqoQMuJhhIYTjUiUC4BsK4oNq1vz16rmg?=
 =?us-ascii?Q?ZB1fpthsNf7wB+PPi/fhCarxHEirNdk5bRbU+bVXTMjrf50lyB8RfcdKIjRE?=
 =?us-ascii?Q?WrG+SalEIiDrJ43WZiBVcF25au0FV2acuxefHn7/w3poUxnSM0O7R7wXqaIs?=
 =?us-ascii?Q?bMP4atvB259R/6UnkRR9o6WkeGXbeLxCVGIKPT/nHfM3QA8osL/ZzHEUkoZf?=
 =?us-ascii?Q?nHrtZEvJRD4+MG48+pId0sR7FYOBdRIcAOj8WFB+xeIU0vPkSofwGMBtCtfo?=
 =?us-ascii?Q?Zu1V20qGksdiRzPaJxEOV2vpNd5oEOu+1BLIkjSrJHp1PuzDffL9iDwndsSS?=
 =?us-ascii?Q?TPqGbqgHQTrm5Dkrzn07B3XHfgdO5C3hMkgyrsV8ANK8ekXX0guaBXFbfBaB?=
 =?us-ascii?Q?4REG58/fGOE99xF0eO8I6G/uaGsJA0pvdFOXGZnOoJgyhdpRp9fYIilKHfRN?=
 =?us-ascii?Q?MuO+0YAsadVxzXVwzDEh9UR9o3j0ouNHVqVEQE11MtCnM++dBzFJ+52FpPWm?=
 =?us-ascii?Q?4nQzyEd7YeHe4vmuzvHpg0BhNABZ/DwRdaI/9KSZaJVq8OZ/9DGvs3gUbrQa?=
 =?us-ascii?Q?3MfnHqegnItqk2pCKXE56m5cseohpPrRIXXLjoHSocok0MF1m1y6IUODQ0v/?=
 =?us-ascii?Q?Np6yuqYmdDAzmfCqz9nPOiyoMT6IHuKwpss1QJlsUzMIgz6FhDygggqlyr2f?=
 =?us-ascii?Q?w2qIhNrC5rioWTjkmgDzcx0SlE9czFexmnRewXzIXnWkxv8o3nph9X644kcl?=
 =?us-ascii?Q?UryXz69I89FUmTFXCZeps2EB0DOOr8HO6Iee3Z7nBxzlhG7f4gv/mLtjBUqr?=
 =?us-ascii?Q?JoqEWH1nn//4sV4DeQN3NQNh4sx3MN1L5xaKBpeqGvr6haCEIgbyVAgF2CxV?=
 =?us-ascii?Q?H/18TA/kZDYZC+34NicXPy0u3YiHipPpyBLZgv96ewJVHXD/CCEtyg4Ymxrd?=
 =?us-ascii?Q?Van+TsS2f3fyO/IVm5CxXCbEzyO77YELlErbEm2CWFTQdz4baiR1lUloOWFY?=
 =?us-ascii?Q?ScYWhbjXH57BVIX0qKyUIORr8TO/dbHbHbaWpQ1KZiVQoczIr4GOOxTAZDlf?=
 =?us-ascii?Q?WgPNMlULaz6PIrXOyTOkNW7xcldDFXNcwdFXr51M/soYnglKq+FQSP/u+eZ7?=
 =?us-ascii?Q?sHFSjC33nEtKVVrfXNvtLkx3QnKfc3/7WpA7iR6Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52309547-5c5e-4b55-0974-08dbef645c5e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 16:17:33.0353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dN//322E4Z0l7Oc6Ws71zXwQIZDl8rWs32MQu5xXkZeQUpLhgDyPH8dQHN3UEofg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4081
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 03:51:10PM +0000, Greg Kroah-Hartman wrote:

> Ok, best of luck with this mess, I'll stop harping on it now and just
> point out all of the other issues here.  First off, you all need to get
> the network maintainers to agree that this driver is ok to do this way,
> and I don't think that has happened yet, so I'll wait on reviewing the
> series until that is resolved.

As I said already, I strongly disagree with the idea that the netdev
maintainers get a global veto on what happens with mlx5 devices just
because they sometimes have an ethernet port on the back of the card.

This module is primarily (but not exclusively) for rdma related
functionality, not netdev, and the RDMA maintainers Ack it.

Thanks,
Jason
