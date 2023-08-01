Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337E876B7DE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbjHAOmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbjHAOmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:42:36 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A9A1BE3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 07:42:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgAikMIP9AQ4xptOjP8BCAbKs+8KAtqZ2R58pdmfrAyghwtpPPPnMiVkz0MHObZ0iPEkpaKXAuKgyTQ2HQ5Vs+l06WtILYGz5awEOArvRa36HcPNMNvkQy7N1t+BZHR4NWnAvELiwz38+ckhft3HRQfoj8+X6GB7lI4j+rOM84IyLe4hCBFZSpr6ucUKaW6Bmsw8Cl6S/zQb1VAM1F1qhfH200vV2OuLIfdp3F3aqB54ozP6euuGsKSbshGl9LgaDKVnC0u2r1dKiOLhSPZLjJ+0Jh9a8mHaQpL7OX0fADxXEv1nI+YeFlKSLg219YCC7gsmvicxoWZo/QLzKRmfQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfMamGHA3iLT7aYijx9oLXaPHWSpaQS4RzylpY4Kj0k=;
 b=EZe5wTMfvU6golLl7iZf6t1/E+xJgdW3/3d2/mDJq8ERs1KsyHIH1BXvOgro5KZVGd1LK3YQ5gC7RohDcgefVsBBse6IEHc0BU185yGTtpWe1BEIwJWVoSEzxSDNleKc6pNhXfcudMmRjbBvBc1Diy6Az1y1zzLmilzaB4/sASGqEDowPvGjKeduJ0Xotn9fPqEnXff3wjxuu4N4VXcMRcDP2j1To/cejWbsawVDuYAo48E1ssmYJKsGQfsq7uDigKvreyZAiruZGWoNOibEXcoXCA0wmtyl5+s/iPGtAxlEKC42oPN472Y3cX/DAaBceuegfmcSuPOGPTQ3VRywbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfMamGHA3iLT7aYijx9oLXaPHWSpaQS4RzylpY4Kj0k=;
 b=s1NBTLz8M1mk4TvP8Gg2o9WPJMSIxGHt6DGLuN9UnrJvjiMMVqsv/L5Xmq1P6g3bufWIZ/BUnPOLdjFaFW6bTEdIFQhnb+TQH8lPhI/P0u+f4TuUy8WCEwhTJqS2vPCzH6WHp2IS+KTUAR39pwG18VzWJzvgzcg7NJxmg955NFP6/OUPp6GtH5ZgKaQxUjmiUT5g8lHxVyckAm9iJ6aVBgjlygceu4K1JJTnn4XZM1FUO2b862IuIPs6khvT3jXD+8teTAshlmrJ+uS8kgd9BfLQuE6HSKxMELmiRTwVFqeRqUF6OeiBIZSJNjEE+3Fjwc9x2c8Mu0Tb83qgJm2aJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB5005.namprd12.prod.outlook.com (2603:10b6:5:1be::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 14:42:32 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 14:42:32 +0000
Date:   Tue, 1 Aug 2023 11:42:30 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v2 7/8] iommu/arm-smmu-v3: Move CD table to
 arm_smmu_master
Message-ID: <ZMkZ1iHPPiF+lLqC@nvidia.com>
References: <20230731104833.800114-1-mshavit@google.com>
 <20230731184817.v2.7.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731184817.v2.7.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
X-ClientProxiedBy: YT4PR01CA0394.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB5005:EE_
X-MS-Office365-Filtering-Correlation-Id: 062512b8-3d3e-4da9-5aef-08db929d89b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pM7pPnPVMD1kjO5W1rKa5eTmOpygC9dlu9DbHAcM87fv8BqtkgAxM/H1W2XuxNJhVs0S3CbrNuv8II9gJ3/e6a8F8MUMDLhGUL8LGM0g7TGjn6wYMxQ0/zDIr9lzsIgDXqAMUa8ZMad1r9fut5lQGG1efYCgZI9TAifSzC5rQgDdvl6iN/5Pt8d/G4pr1vKJVpiaVPIOyYYmKp4jnP/GJSIpTMDXoZkPGj7O/xxB6qxEnpkWfgNNen1QjQrxmiCYwstX91baqJ9WD0ISFQojK21B88jQnSEhi/ZTVhMUhYZX7NZUAF8TLuopIibV2qu50Kzlt1wPuaDiEvjYIGoZ34bFTY78qSau6r6BJeJpu/GnEFu7OCgg3YuYVYky7SLqpHgK/UdYFTUHHD2c1gJQbogzD4BUZWSbeUcTn1FiKIW48APhOWsbQkF3CBJLJ9JuJtwEftNyoN+7SapfT3LMP912BKq8l/PIr96h5nzF4GjWt4Wx/+d4oI6/JEN9Manefj+mqsKw5K4nR1d+FeLWCSipXApl90fL2oSZJeNdCBUroE5h7NblCOWPq+UPq2hIXMUhNMIp4Gb0SOFKih0PDEofQxP0LTE03eEKN88lgCc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(451199021)(6512007)(5660300002)(186003)(66946007)(66556008)(66476007)(4326008)(6916009)(478600001)(6486002)(316002)(41300700001)(8936002)(8676002)(26005)(38100700002)(86362001)(6506007)(36756003)(2906002)(83380400001)(4744005)(2616005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EISd8blHxUyPhf+ozDVZcVhZMDpk2vmARxgYNnGvDvecQVrBjUVlD3LYZRHV?=
 =?us-ascii?Q?6Ak/yOGYYmaR+b1eYZ5IoTiRXp60nXfXC86XJt/6cRpk2vKus3K+Q6kVWnz/?=
 =?us-ascii?Q?A6SgpAnSJwu95YRdfPXMOK+ty+AJS6i7tSMH+Fi934X/y0TQv6AGoEgXgsNs?=
 =?us-ascii?Q?NIEWMH7JLhYrzFamK3dYFIBxu3cggMOgx1eiyGIfulJuCD7LK1mRp9OigjOc?=
 =?us-ascii?Q?6TFqLRNDDJ0HzzQRuU3qelJkCJKl4rRuX8586xGQS4taFq5JnuKbp3IpGpyg?=
 =?us-ascii?Q?YuTNOrr2Ny2bTLmYW5unUUIxP+zaA+bhq898GJnkH8zwB32Q3F8CBoQJnHkt?=
 =?us-ascii?Q?rwBQCewHcVdvv6oGLy/bdniNmJup46YidE/rPnWsNfZ8CMhFp1n/Am1ZqSHw?=
 =?us-ascii?Q?/pTMB4FCHXu9KT3iYF28djtsm/ec++Byd2qDVpbzlv++iE5v312q08MZT8mM?=
 =?us-ascii?Q?SR3skNSxj1aIsJqkjyfOlRJ77x+b2VvZTiUo8y4bf8YHwWwKS0IFHFChZNdS?=
 =?us-ascii?Q?ZTqj6pbsN6F0877lhO/A+WrVhfqyhNI5I74A5Dw3qP8puLkcTVM7fHm6C1vm?=
 =?us-ascii?Q?HHzdKogM22GZKmEaRPJCCeb/ARNjC7H5TOb8C/va96X4iDZ2Gik2064Q5jd2?=
 =?us-ascii?Q?OQ4i1gi0FErUmfhgzjf+9pqhR4hrx6yrfHwcGvNtRAcTWIRht1xl2HCTWfkR?=
 =?us-ascii?Q?2bjRMMioFuySTHsmnCEqGSXfL5wGa4sCp4v+um5StUiTQsNn4Gm4BfTNTPgR?=
 =?us-ascii?Q?ofX+AsNB7UCOW8F3ryU8IdkdmY4LR0suvqHE6ToguESES8snS5yaFNiWmv3t?=
 =?us-ascii?Q?YXHfH4jpagpWC1J7u2TADYl+9jgZvuvg90xQP+KOVSr/OPn8fdgmWJoILnJH?=
 =?us-ascii?Q?8ZEL687KExQOe5TcL+EmlfOxyUR0N+4Qhm/eOkzp9tPQqvHtcCnc+PLbmeRI?=
 =?us-ascii?Q?YWw9xbu7QIhUwJhQPdtgGjeS+qqDsOrzRtrgSNwtOwbGKJLeECbVGP6Tppyk?=
 =?us-ascii?Q?GsaD09YwVvdnPmqXJADFSrlO2VTlMLuEKnku4leAZm7qG0kXb55LXY51A6oe?=
 =?us-ascii?Q?0HURva3XLXTexAKf9DYTNuG9YcFZBYaYu5By8RHjphvbO+uJefy9CLeDLN0W?=
 =?us-ascii?Q?lyqcbPGVfGhgIyDoSTQkTC4iOjjRG68DanGS9pHcZuR5jm+hN1SBG++0VUOw?=
 =?us-ascii?Q?xj6DJQ7h4fIxNQTZdXR3ic/EWYZWy6Ycl3C9SIqTDLURSQQnSLrHoyReOBFi?=
 =?us-ascii?Q?/FwRZni9VpMnWZRFeCWGyHInLQzBowuzac9qNnddUmmHAclZodtrVwk881o6?=
 =?us-ascii?Q?3rl4qYaAcAZ0FCkC/lf+qT6ROrHRWF9GmuA4i6bWERHk92BSEb094qTIAMT0?=
 =?us-ascii?Q?X18gcfiY8G/PgVsjhDZTtOaP4qaiO2rm8YUxcwjbLwWL2zvFuudrX2Hf4Iam?=
 =?us-ascii?Q?WDxPmIL0NkjRkkBhgAF3tRL3U75tMafQSpea9N2XNSQ1sQ2aqbWdAowcdwmT?=
 =?us-ascii?Q?y9zld4psG2nXc55U2/zV9FV31WCySQ81Bb4CkqhRMeajvKum2LRw8CSK1Myd?=
 =?us-ascii?Q?hwfyUCu/O87eTPlC5PnbQbagegEOThxMvqlHDoUd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 062512b8-3d3e-4da9-5aef-08db929d89b0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 14:42:32.2202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MOGZbmKqCclAiuI9gj3v2SODSwi15DEcVz92P58BdMFtPV67k0lEYRVAi1p9PXOJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5005
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 06:48:17PM +0800, Michael Shavit wrote:
> With this change, each master will now own its own CD table instead of
> sharing one with other masters attached to the same domain. Attaching a
> stage 1 domain installs CD entries into the master's CD table. SVA
> writes its CD entries into each master's CD table if the domain is
> shared across masters.
> 
> Signed-off-by: Michael Shavit <mshavit@google.com>
> ---
> 
> Changes in v2:
> - Allocate CD table when it's first needed instead of on probe.
> 
> Changes in v1:
> - The master's CD table allocation was previously split to a different
>   commit. This change now atomically allocates the new CD table, uses
>   it, and removes the old one.
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 67 +++++++++------------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  6 +-
>  2 files changed, 32 insertions(+), 41 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
