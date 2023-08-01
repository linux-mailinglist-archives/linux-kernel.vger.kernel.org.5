Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9375A76B6D5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjHAOIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbjHAOI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:08:28 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D37B213C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 07:08:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwcutQ52bJsd3rhAQh7AGNEsiy6gZuXjRe7WavOjun9Idau48NDT8UNnJfjq3dqASbVFK+rkydqyer69bfwL/K/CA4g+W22g7+zpIKhRjf24RhTjMpCikoSHpRixfPkfrA8YEdO+S6YoZSNYrXbFgRM2GZ/Qx/Mkx37q2LBrnXCNCnqRFwpLdCaPbpvtV9Ij/r82sKOMD2g8IMuhIcjnCSHB/utkkojHQTLzl46FoNHbb+BIOSqLPpB+xQvNzsDm/StMuH/Wsor/weqK46DVgwToJ7w6pEts6EpDq14Dp0J6MRr/O3uxhAs6dALDoE2UXrXWSQCDR/fS4D2OPeQb8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azS9Kkd5L/gx25me7YoWfbF3zTdam3nZ4Ddf7dljq1s=;
 b=NEi/SLBpzb2ni3RU3FVFHvtP+0x0Vo5a2Ks8c7pMC9jIXxjKXPrxyhZt71tUh9fd0hDWtVKDLuZHTKPgByCTcLX04vFfGqBz38ET/dxkiIB+w9Tw1CUWXlzrAZXNR7amQeXlFov63vT4dsvodB7FaJ+VUkBm4Gos7UMQecO6Nrvk1za/kgZ4o9dlucLPBlXewSzGYmtKxi7M5UX1HLSXRhDUApuziCuZcCbsFvDOPQDweJm76bOhdLGJ/ZmmYymJgZt7EGg/6siu6VKii/252jqdAeqLwfRU+QwovBGCpGeeGjwV1P2G46BvPGoCfFPrBsZDxU2ZUyCOfTfscpgCrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azS9Kkd5L/gx25me7YoWfbF3zTdam3nZ4Ddf7dljq1s=;
 b=CZG5+oTEqpNGZOiV+OhaGCHM2s/xPTyfUAwHK6doZiAupBwL2ZSVcd4lTVAYib5K76Q5730+ciM0vdqh9ZdoLVDq8xPQpkXWWXm3jHlu9q/vTSBlF1oq6nvebmO+MamUicUX2z3O4IAnQVHkRFtPQhxPLZ6W0ooyp4Nw3uM12uZek183QITmFPv5DEp2qNfrpfLRlQ2zJQVqY/a9UXyU/4dDNltn0Q7iCsvOGQGjNLXSEnL55FFjtS4harzAudq6t0m/ib2TaH2rbWdzXqxa3RbWQjhxc943GByBQFifgvp4NIDQb8brA6xA3JvBYgIJnS1IWnAZMmN3hZkQ+6ULWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7584.namprd12.prod.outlook.com (2603:10b6:8:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 14:08:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 14:08:21 +0000
Date:   Tue, 1 Aug 2023 11:08:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v2 1/8] iommu/arm-smmu-v3: Move ctx_desc out of s1_cfg
Message-ID: <ZMkR1KgvohRuNzn4@nvidia.com>
References: <20230731104833.800114-1-mshavit@google.com>
 <20230731184817.v2.1.I67ab103c18d882aedc8a08985af1fba70bca084e@changeid>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731184817.v2.1.I67ab103c18d882aedc8a08985af1fba70bca084e@changeid>
X-ClientProxiedBy: CH2PR14CA0051.namprd14.prod.outlook.com
 (2603:10b6:610:56::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: e283802e-49af-450b-c7b0-08db9298c37c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aKCuL4zmQbVy+L6zl7K1Zz5fpk2uyDFEmm/HzOpEBgcqIzpFFjHUxxCPF13Mov/rs6YFhvCW08cRDrXuo46GblEUMoYbV9f+H1AY6Wl5PGuucUgr/RlcdDxQ5NUtEZ80/eobM8bA2HfwVTjLQ0AQb6h5LF27rdKrCtbO3mQEi/KxJSFexrSQXiVILL8uVqS3EOgZGTuCMm9AsCtTzSX+Gmbd9pbe4K7JipAEJnyGJmSiPBX1HvhoBnP3idikU7fm6CLs4qGsuQuV8qkUez7xz2/MWzJDjpGyzQgp85T0Sl8Ek/UDiKFR3olBiQgqo/LF6dH6Wl3e79VV5qikektpz3ko4ji7GXWiSIhGBYcZVzCqNroprJpnZJYRqqaGwEwWuowPXwcuhQ0nsnDWeHgSxwL0cb6YpTOiVHeQd7XUMzHmzNlhfVasT+mqn2QRbrHC+DROe8gtHFXf636JozWUT6B8+HX57yVFPGTEl9F2Lv1v83OzjNxJRzA1mwTfd/PtdrZhMuwqGj7PpnrNfNq7RzBvyVOXyEIXzFQaqXbO4ThZOBG6GFkdYKb2cDUjQ/Fi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199021)(4326008)(66556008)(41300700001)(8676002)(66946007)(6916009)(8936002)(5660300002)(66476007)(478600001)(2906002)(4744005)(316002)(86362001)(6512007)(38100700002)(6486002)(83380400001)(6506007)(26005)(36756003)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yqF/cR0c3yzYI8X26FBxqr2sBHweCZ2InpbCnScZBAGYFhGd26xgnXe/6q4F?=
 =?us-ascii?Q?H/8suLTsgOikxN1CddzvFxv+A96xfzvljw4oIpSS0t0gKkpckbDxxXLLcVHy?=
 =?us-ascii?Q?BylXLPTl/iZ73keUX9ketCkHVOQjJ1Qjq5yAVfcwfY3FQ93pE31+HpFvKfL3?=
 =?us-ascii?Q?y7nIqd5d5zHYi4+fUqNy0zhhCyYYpGrMbCW4k/qYjmj2mU17mN3q7dsQdmfi?=
 =?us-ascii?Q?ZhqCW+FAquhfLGUvI42CXMPTS3ziL57IyJzn1c6Bw0QdanfSSz6nabsDa/uB?=
 =?us-ascii?Q?nUSDeNoXqa2HrnLQTDsnSqBcHZ+kQV5qUDilHrQwHZN9nFIqKAZ5smjti52p?=
 =?us-ascii?Q?aJ6q/S79uso6k2Ab1SWHZt06OIuGDm29KKS46ABzp4usF6YoWJGdobR4htEV?=
 =?us-ascii?Q?esr+nYF2Rc9ZPHEgTtGsiTBXSMtQeyTAt4tWbRPhNtZDEA/GENyjHsaA783p?=
 =?us-ascii?Q?DGe5sLSwfRJxX6mWGcpz7Zh/UdFedlnKAABz0vNY8b7PxdHkOWlifZhEAyFa?=
 =?us-ascii?Q?+q7OIKcZo2RFgvHZR5gW41BfX7rwFfKPlz5jtvfeIOAFB+I9rJ63A436qcUd?=
 =?us-ascii?Q?KQ01dWOQaVDue2xgO9oeQbLFUJz+AsvBy5VW/Cgl5wME+khQILMP446W0YyX?=
 =?us-ascii?Q?FO51QVxaGqZ5WLfiySM5WjXb5YhErERv68fwo4O6y4Z0ZEmsoNgF3TwldNd8?=
 =?us-ascii?Q?rpUUzkPpRjgfsRowi3cuVOj0ZSBtjl4phSUTDszyY0lDdPzIShFM5LWpbfL0?=
 =?us-ascii?Q?2ZFssHEX0BerfNNojO6QP24mNVeJpuhJOZCKU/PjfGeQyHQOsJsr90/Py5qb?=
 =?us-ascii?Q?RWGbrxQK2us5BmXIgmZocF+QjaTn8iUIkjYmG4tqbMHsNZUzVus+VrRZXou3?=
 =?us-ascii?Q?TwDgLdiXmJsJ0bouveBue989BmG28Lkw9cwPQBsKKSAKPWyrxNDyd+RudDli?=
 =?us-ascii?Q?nDVQlceOXLhXIfTXUuO43GFI/fGAqUJSpeD2XzaIszYBOTSR2mCVYIIhMab1?=
 =?us-ascii?Q?uCPfZ77cyFPxWGyvge4x//sawb77gujU2QMIHb6G6Q228TTUXa4fb0K2lgOl?=
 =?us-ascii?Q?Y+PFqeSYDi3/y8FA8jretDj1d7SsexyRf0HPvfPmV06vs07kXvTC2S2Coe1N?=
 =?us-ascii?Q?pTzZxDHtl2z8U2ltkaj8dtrCI1djDTn1An4iXddUUyhZfj0svI4L2YLxTHGm?=
 =?us-ascii?Q?1/7SO3qpscV6gWbKH/XYQg9J+lbKvs9fFZ6OxJ6wH2qZldil63TPnUtl+p2K?=
 =?us-ascii?Q?sj0zMXNgywVbYIICiK2+EYTr2WQ3T9q+xHAnvPm2ERJ/dfQkAhNZ50EhDP+w?=
 =?us-ascii?Q?DEjxbKanidGeZ5nHVHLmfPTSdaGymR6sywK8bDr78HyAy3A2aEb6IJN9wvCI?=
 =?us-ascii?Q?YpQhNaXBh9zD6IKfS5O04O3TFnKugbOlebykwicJciitmBZG0sdAXVbq8rYL?=
 =?us-ascii?Q?lXJ0810ATgU07kMOg+mvjtZLV+oyU3nXqKNb3jrXjyYilAqAOt4vOD2U+kMV?=
 =?us-ascii?Q?kg+nCT3kS8ZgLAU16zOFONYbYpnHz6imkDlhvOOqgvSicOuVRzyLUDpRqpk7?=
 =?us-ascii?Q?eU0ncXHdIaXY3MxslgresoDSsgDkV8UQkd+J27sd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e283802e-49af-450b-c7b0-08db9298c37c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 14:08:21.8729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4SS214Inhlw6551L0LdWOX+Bk4qCmdobr5ZKrQpZQ1Y8apy+QtXVk6rXysrlh1E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7584
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

On Mon, Jul 31, 2023 at 06:48:11PM +0800, Michael Shavit wrote:
> s1_cfg describes the CD table that is inserted into an SMMU's STEs. It's
> weird for s1_cfg to also own ctx_desc which describes a CD that is
> inserted into that table. It is more appropriate for arm_smmu_domain to
> own ctx_desc.
> 
> Signed-off-by: Michael Shavit <mshavit@google.com>
> ---
> Changes in v2:
> - Undo over-reaching column alignment change
> 
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  2 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 23 ++++++++++---------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  6 +++--
>  3 files changed, 17 insertions(+), 14 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
