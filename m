Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA677F37CF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 22:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjKUVET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 16:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjKUVER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 16:04:17 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771C81A3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 13:04:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVHQtZ75g9J7GWHnIwRog5QMcXJzEBOebFkJzKN4Al15qZhOviIZQHkVthIKXukEb/h2/Y5cPGPxHrFUP5kxZRrjynWB2iaXEW8iVMNYZ+dgr1qmuf5O+4w/dA6ds1J9gZF3Qp6SuDb0zZZELd2EmtKI+nWc7a8sFd7eFpczBdDj7gLGGxGek73zVKXyXtq8XVLp9IRKVHMAEHRgxx+8uoqhVNEAdlvwT5Uogz7dXJb0kxrQdqhUnxPZh11AmBLNaV3JbpEvBC4pTnfFIGDZfIhOcndMQU9jql4aEijdXKDvCJG1SWHbuwb2hrjMnDvA6sBzsSqOmeXqPE6AlZsDyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0oL3cxrXT2QEvsM8FZYepY4gBIMA1/DDu2OfC1D6HA=;
 b=YNBZARgE5ThqB8iA0J3JPUdjFvV2y+/wwHfS2Pc8CzMEj570CPRJKB80gir5xhrFS+6JWkCvXem7aejWAoV+XuMJDsBOAYkfQvR3KtgF4QKOl8S2h0m/9nbTKjYC6TUKJHZTJf0w3BHbjdJskp+dA0Gc00015LWTVsfO5zWly0Agcdi+f+bjpVENRCT3hnKnv/gPZKY4HOULreg72YUF8w5s7PAaEoy9h7TmW9Juxo7i7SXF6wCby4kDnXEPnpymNH/S0917taU39gv+Vn1K/5PK6NRjB+zRcStRw9gOldlT9vauT+wFPa+tAD/Nudvl557p91ilSOKGawGG2JJhkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0oL3cxrXT2QEvsM8FZYepY4gBIMA1/DDu2OfC1D6HA=;
 b=GSbm6Vr/Qc7k0S9ZMiPRa/qTTCNuvU6JhMMRCQTPWsCUb7Lp3i5/S2fn3+cMeW51nl5klKRSgg8ZpQV7nLU88K9Sy0h7igzAmZIbPakaI9i19Ix4ILn6Q1///sxo5M7t26FqZnAQy3IsYwftcyrO0dzeoLOmU2nFqLf0tYSr1SCnPHZbMg49BoZ7NmrFI8QL7G/YNmPixT1iB53jmuvxbrTs4LjLYBIOm/fY1E9v8Sz8p5h81TXaIWEg5h70D5LB5/N4li7lGR3GkSIrnQ7uWAzgg3u8wclDlQ9XESL80qYRySVaVxdZ/PSdunmv0PHEyuYWSFFlqkXsPuomIHvX2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9134.namprd12.prod.outlook.com (2603:10b6:408:180::21)
 by PH7PR12MB5734.namprd12.prod.outlook.com (2603:10b6:510:1e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Tue, 21 Nov
 2023 21:04:09 +0000
Received: from LV8PR12MB9134.namprd12.prod.outlook.com
 ([fe80::46b5:b4c0:3712:504]) by LV8PR12MB9134.namprd12.prod.outlook.com
 ([fe80::46b5:b4c0:3712:504%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 21:04:09 +0000
Date:   Tue, 21 Nov 2023 13:04:06 -0800
From:   Saeed Mahameed <saeedm@nvidia.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        linux-kernel@vger.kernel.org, David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH V3 5/5] misc: mlx5ctl: Add umem reg/unreg ioctl
Message-ID: <ZV0bRpnhu/zWieTT@x130>
References: <20231121070619.9836-1-saeed@kernel.org>
 <20231121070619.9836-6-saeed@kernel.org>
 <20231121124456.7a6388c6@kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231121124456.7a6388c6@kernel.org>
X-ClientProxiedBy: BYAPR01CA0059.prod.exchangelabs.com (2603:10b6:a03:94::36)
 To LV8PR12MB9134.namprd12.prod.outlook.com (2603:10b6:408:180::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9134:EE_|PH7PR12MB5734:EE_
X-MS-Office365-Filtering-Correlation-Id: 026ab28e-7c69-45f1-820b-08dbead56717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ytkhllouVTU2uTG59qnUcJR6HAl9g4wzx65twvEqjHfmOyhpc/E947ZaW19Te2b43eEoe3MrDDld5atGpaS0vSTuxkEZm3m4jCLRzX5csCzlAfAXaUl45LZHHS7Rm4ySw5SDGa7pSteGyFnN5NxTM2kW2frwQEcWRnl0KcxoOKzuh/d/QEGsoP5hz5hbLH7/q4E1vv8n+Bfa5lZZCgt4nxkYbgogteCjr9xE9gDJk0IlJk4z3tYTIOhsZrfrfs9n6OwB2B07DMPnscQeMRQoXyzny13/HVgddrERAA6Me0zZNcstX4wehbQVSQpdnvVfjG2eW9l8puXyyfsg7jGuAqfR9sHAfYnoHcmtNy9Dwe595vFM/YjIViBQHcRHLRO2VhbGUNW4Xjr63/et5NidNjD6RJEx89ZXwQv9Tqn2SLG9RuR1gTi8hgmEwNOTJ9l60GvwUHO64JmhjnnfGMn/lnZQevqQqz8jfq/8zCQIAk09rvaOcFcWP6rTMNasPidM3Ks2ZqrIs3+iH+b7ZHRB3MN2ttypDJZxSoDpL8xpccETLxxuuCY2S4azIbCDuwgxdkhDaXI96PtscnKlV/tUDTww4Kir1kcTP2XUfGWKsE0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9134.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(366004)(396003)(136003)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(86362001)(6486002)(6666004)(6506007)(6916009)(66476007)(66946007)(66556008)(316002)(54906003)(6512007)(9686003)(38100700002)(26005)(33716001)(83380400001)(2906002)(478600001)(41300700001)(5660300002)(8676002)(8936002)(4326008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RqAA3ri3wg9fPd+CqA7J1yt9rMtT1lCNwuEA80Q7l7NDUNKkGSUytvjPOi9B?=
 =?us-ascii?Q?McA8sm0ynK5vcqtE4TXQYkbhKWdy1hemYvxWdI8oZqV1GJEWF8aTHjplCYK/?=
 =?us-ascii?Q?Tq2joq4MJDJZfwAFmK7qjDMfm5O+zmCUIX2uxy/cZLWVhbneCjOnJvDHAJx+?=
 =?us-ascii?Q?xV3/p4pODfMYeGBTQfRIsZTW3kqtbMDu0qmZmmC3PkmK5nhxosJAFZ/ii4G9?=
 =?us-ascii?Q?UySqPP9k0mNS5g7ugLN/aRvFZ6y5U32RHO3lxR4d31QpuCWJ+p3j87JJiaJW?=
 =?us-ascii?Q?Qe0byfmBfMfwagzVCEZ3KijbgSuqqzY5s69OjZMVi4B7VhymixHpHKu8IVnj?=
 =?us-ascii?Q?QxGLOIJ1RJuQyImjAQ96WNFb8fq+rfyv/FpjE1IvQn5BJldrrXkpjY5IbL+s?=
 =?us-ascii?Q?wIlekZsboBeyMh9vtjmEgicTTTzqoukljDnWDLM0jBFDlzuSBV2rIzHyAhcf?=
 =?us-ascii?Q?cavQ0x6NPvaYF88ITexP6IB12F5shwfDnVid8bQGQPdMOh2ogNfydYpEWEIh?=
 =?us-ascii?Q?BZHfRRlGj+buRvu9p9vum5H9L6Hdc3qlpDNQFxpRuGxhMIFhmLVJ9YUGh1iM?=
 =?us-ascii?Q?6mW0OWm9+lQbnR9mflI62h4OnxQPsRHSBXtDA0Lyju5uKtg4SJluTpVNjuop?=
 =?us-ascii?Q?d8onL+Y4deiTP09yqq7Tc6o4eL1+8McA8esi33LI+r5WMgVsALnxj/hcoIL5?=
 =?us-ascii?Q?vvtvxura3AFYcvI3jPbrt6/Hd1kMfMdHtV06NSvDs7BwuLjRdvY+674VDMET?=
 =?us-ascii?Q?nIVFXJK/PtQABHLY7oWErv3/e9aHzgzG0Ajs2Ja/PP6eIFDMqiiQqIznyzd7?=
 =?us-ascii?Q?pd019JiG6SjSU/8WhnZIF6qPFKUGSbGaFDs2hXKsvin6rZibKrBiYJfEh707?=
 =?us-ascii?Q?boUeQaoiiHALSQ6VLOSIE8FkEWCSyOVL5LmBOS6ZQgX2dzdasOcxgVwoA5zF?=
 =?us-ascii?Q?zDnFV6TfPZEvH+3e67QSnE66SlSeg1EOhTFmWckaTP6ymyDf0w8A50BxgGxW?=
 =?us-ascii?Q?VPNPZvmws1aUECTUBjycVd7/ujFeefBynIBTaG+tS0uXwfgOaKDcA918fYP1?=
 =?us-ascii?Q?nI+cbnvS14G98pFYNOgszk81Ca11lM20DxV+azOrFKkRuB93Zk3y/KKWGOW6?=
 =?us-ascii?Q?ctSEMpJRc0prg4SBajLC/8DAKxkdUNZjL/GuuGT1f91Izeoph8sP5HbfXSM6?=
 =?us-ascii?Q?2RF/Ed/0vtzUpidebzVUcGD8Cr/Nw0ul8TQLiWjV4ZGScaal/BBQwFlLZ/Cv?=
 =?us-ascii?Q?uCOJNJLCTmOsNzQkO4WRXKKL87xN2BLy+eV0pP3a7dn6aCOQxzmfnA05E6SI?=
 =?us-ascii?Q?kkg013UGO4BKytiPcaxa4icRRZU7vV8jm2xkxiciZ4wEj13al/zW+rYVkiNY?=
 =?us-ascii?Q?WSeouXZBqp4KSFSrPF+fncETLJ41lz4OqrE5MZ6beKdzsGny6QMAA3UU9Zua?=
 =?us-ascii?Q?BgLZ3+Ih5ww1dfcOmlWimUNL0ALLq8442LO8Db5IhQvtv1T4KlY5Q642iNHY?=
 =?us-ascii?Q?0bsphjT74qJDwNTVfEf8l7zn3d4lOdUpZBRk7G8fyqIMN4qSFfqKd/EG9vhP?=
 =?us-ascii?Q?AhRGj9t9dZuH/SNZu+DXZoZCn9mv+1FNnlsnAYJ+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 026ab28e-7c69-45f1-820b-08dbead56717
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9134.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 21:04:08.8001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJ5fw/FEWZ99Fq3dwTPiVw5CdbTO4sICvY+tUMBDO7uviy6mf1CWuXGkpmgWoCmcYzD+uncIIYbr2GTb6hjxCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5734
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Nov 12:44, Jakub Kicinski wrote:
>On Mon, 20 Nov 2023 23:06:19 -0800 Saeed Mahameed wrote:
>> high frequency diagnostic counters
>
>So is it a debug driver or not a debug driver?
>

High frequency _diagnostic_ counters are a very useful tool for
debugging a high performance chip. So yes this is for diagnostics/debug.

>Because I'm pretty sure some people want to have access to high freq
>counters in production, across their fleet. What's worse David Ahern
>has been pitching a way of exposing device counters which would be
>common across netdev.
>

This is not netdev, this driver is to support ConnectX chips and SoCs
with any stack, netdev/rdma/vdpa/virtio and internal chip units and
acceleration engines, add to that ARM core diagnostics in case of
Blue-Field DPUs. 

I am not looking for counting netdev ethernet packets in this driver.

I am also pretty sure David will also want an interface to access other
than netdev counters, to get more visibility on how a specific chip is
behaving.

>Definite nack on this patch.

Based on what ?


