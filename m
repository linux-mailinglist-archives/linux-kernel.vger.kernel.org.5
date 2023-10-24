Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8857D5726
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343990AbjJXP7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343979AbjJXP7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:59:41 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827AF10C3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 08:59:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gencJqoM8trKUeFm3fQ4ZBEw+mdPW1NjHp+pbuMRTFPxylzs9DqIF5J+rSlZIvJphUHvLP3bPjWZMpnT8Tvd4uzsNqytvsouEIzzUozsLtlWKlv3Bapo6ZivDv3lue7OyIjGQ2edkI0QQXmu/rGi69U/ahSoEO3leZY1SBq8KmutrpYkSu9ZeLro5iREnZyHWiNfcsJ35E2mFeqoYgsFqKZOGzbPkKs+/2qNI5Kj/i/B1+oXfpttr4NEvVy8+nQzy8IrjCvxOWRRIxWheIZIMyF5HF4YG7SGKM7vDJ7FKqxhSykAEyngAbrYYNNkdqBZFMtspZOXc+zTDR7KlfB7Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GrfwRZJTicwXcvz1sjCSDMB9w+HjAai0sN+qjYnaPA=;
 b=f31EA+fclFm/2MrTiDTDix59NScLZ0h2Aou4NC0+NX3rTFfgtTiJLhroLJfS1V5kwE0T23tAOukENeb2a2waxvki5tMGfDrEnEgb47rKZO0lAM2mQMnzAt8FgX12qtgNZWf8cUfa6Nm14288TR+1jfLNuByryOgUSarsKJf3h8UHhZmGPLPCZeVkSJmcLIJtKW3m3+httpGYTHqbL9ypFOd7hoEtYbRAgDG1KibAkJO9dORDzaZ/Cn47jT32lnNCM9gvuA5yk7hMvaFVi8nxJ8O7UCUWqcbZCexM/WKqc2lEMJshf/iDkJgG9rFcbUFqxKfjaB986cD8uzruSK0qXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GrfwRZJTicwXcvz1sjCSDMB9w+HjAai0sN+qjYnaPA=;
 b=oTeZyqsRrcZQ0Cc02Ds2nCPMquBf9eIr26jhPDRHBozEMGyjAGSG1v2ra+AC1o6Ia72kKvhHz3T5/Ns/Y6dEzLQmc7c6iyXQDmGPIEtXgGe599JnYsR6IuKPbSNOHLo16riBVPb3Q0WzVg4Q6ABeRk6odDWk3jXVY10IU6+T7nMOsRQ24qIjqFa4sjcpAoWbar0HXWbK9/JyX/aZoeEYVeVYeWdxzkL+eSd7RwAymcZURjDV8H/SZOdZVo+vsM39+dQZ+MGie4jxxWKJkHlzKsVBjJ2056D2B+NuzyPd+pCXcaPxiLZzcdG/2TmHO4i0Ci9NXk7vzVI+1LiBGBYnjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5772.namprd12.prod.outlook.com (2603:10b6:8:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Tue, 24 Oct
 2023 15:59:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Tue, 24 Oct 2023
 15:59:35 +0000
Date:   Tue, 24 Oct 2023 12:59:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, baolu.lu@linux.intel.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        yi.l.liu@intel.com
Subject: Re: [PATCH v4] iommufd: Only enforce cache coherency in
 iommufd_hw_pagetable_alloc
Message-ID: <20231024155933.GL3952@nvidia.com>
References: <20231024012958.30842-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024012958.30842-1-nicolinc@nvidia.com>
X-ClientProxiedBy: DM6PR06CA0063.namprd06.prod.outlook.com
 (2603:10b6:5:54::40) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: dc2dd71d-5b01-4728-a00e-08dbd4aa3807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7WNIsP6hf7teqhoAvTHrCj+jl/yBTqOEArnUNkhRrbngIh21HL4n2LloI8IGxgPosPMFVcBC9nK6Y4jhaD6z6rqUkQUdWiZFhwNdRfDMsBrURVal96/1nn1je45l3msxxB6BdWQhga/BFLVIji11UXjWa7M0OlJ1leM+4TZrRGtR7EnvTsqmhiAn22hQQ+xKGnZFSo2vOaOIBxonGRUBe/pyQXi027z5fBIiV4Ya2DcTyy4HrsASDa7I4JmWBRgqs310NhslYLiHM4d41tKyNKDMCcLKVqTYPNrlbKo+TIHPr4V/Cg3Ew//JRqQgpidm52jd5ubM4J3pi+TVw3r6b9KuOmskEdfHzpFtTOlkZD1qGIKbeybiX4iAaBvhnNzS6wjviweJsNfPaI33AeOM3F8opsME6ElLOMnDyUVI5MI4CZNl8hsn9rXMGwhQge602ZYmDKd8HUcKeaEVz3QWEYyAooif9r8OpM5spwz2vRr21VwBdT2oE7H0MCj4mqqG1n/1K4rtu4wkSgu40QQG6gE4ezjW+hdhUD0HCLvtn4gnPFDkdtcLAPTSPTGM6tGToSSgUCjU2yaFwI3Z962+QzKuA2Zh9SIzYYh7ykB9Z9xoNQZNfFGNOIJjk/eyOjkZzvmB2Sh5sgtXEBLOMxPqJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(66476007)(316002)(6636002)(66556008)(37006003)(66946007)(478600001)(5660300002)(8676002)(8936002)(4326008)(6862004)(966005)(6486002)(6512007)(6506007)(41300700001)(2906002)(38100700002)(83380400001)(2616005)(26005)(1076003)(33656002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U7xJg/8zq8lyZoXWbPLGvidjAKL/1iCZ4ktok5E/CBQpibwL5pye6658Cch3?=
 =?us-ascii?Q?jH6d0hgFFx9JL6T7crdzHf4PNK90ylrfOsIJ77oaIprKK7iKDKrYWlHMPXdx?=
 =?us-ascii?Q?uBG1CzGvU1tTSnlLtHtxWHgGsmG35RHS1oBTELSShOPIl7hxzEVzruVUxMWc?=
 =?us-ascii?Q?eqej0QtSvIie/3rXu+wNqqSDnwKFbCKWqCucvjQp/qhVITv9jDcxDDKQavHw?=
 =?us-ascii?Q?ktvLLeFVd+GhhQB851F8gsKO3Y8lraCuwQfPBSq69IDoPwjRtOYY4RsEdsh5?=
 =?us-ascii?Q?uVJrPx8FgvUEa0hIoQmrFAk1/LWHmWgv/9lhSXmvSGEFzTrh7tvXL0BXhBoy?=
 =?us-ascii?Q?geKZSMlmQg2VpZp/5EqL5uA7bBY42fMUSTCHRZcpYwFhyw4/yMpIFWk3x8IK?=
 =?us-ascii?Q?e2ecivfe7/hOVO+axtTW99kYmGpGoepI4cSV4eBi/r8a2xBiGKauuA3twthA?=
 =?us-ascii?Q?izNbPp37h1Yli3yV2PDjLxBOv+mQc3W7zQPZhkDwLzbvRFoQGeGj/kr4zDLT?=
 =?us-ascii?Q?kdD8oPn4EqRqC8nyOBSxpS7fBp5TcwrGy0659YMLXm21c3mIyk9lvlUvS0o9?=
 =?us-ascii?Q?nz8/RWh9xowWR1H9SUwg1xgAmTzOkOh5wE0ocF6YYCuUVczCQTcbWHhbf5wP?=
 =?us-ascii?Q?PpzPC2XKgdo+5Vb7kpHZsqxjWBUxdLtC2QKqvZESI/Wv7MauiO2KVf5FBaZf?=
 =?us-ascii?Q?ZCyExZH/qukn6YdZxGTLq8QatY+yniYQeFh7dieJjoHrGpiakODJISVjUCJz?=
 =?us-ascii?Q?RUqVrxaaHO2QN8HTQFfZ6j4MMjnRlt7s/ag5rEPQAOWsvyGavY9R4I8RBug5?=
 =?us-ascii?Q?2eD0wyjv23v+1o7D/BazHZThP2ub7rRxP0rIbcSMRz7/de9F3tJbbBiKhaqd?=
 =?us-ascii?Q?/jnItScow6KdV6CetRKdZOQYb/10FC/shwJ+B894PXIrOZNwJrR3WiP/TQH8?=
 =?us-ascii?Q?aXHJdjjy+Lz7IjKl6WSIrk0VEV603d0rW36Qs7nqnDtvE4Xbzte6c1Fox1VY?=
 =?us-ascii?Q?aQAet3k765ueywP8+2lddqcjbMmuzpvKST9L5pg6XUSy9xHZJNy/zUz1VRm1?=
 =?us-ascii?Q?UXPVw3DNJfIBwgA6Sst0AfxPmr3xmAdXBYOhcg7Bjl4OQiAS4UTA40zzHdF1?=
 =?us-ascii?Q?2OX76hpBAtCUrqnx7J9AR1oD29h3KQnPA8GVozIlgwJtezYkK+PXM19a6iwz?=
 =?us-ascii?Q?7PFfavxL56Jldnq7OGhHq/itZSZsjlw9adkPgRRazu3Y78E4j37FV1qPTdau?=
 =?us-ascii?Q?YmNR3cmgHCRRzM8EnEYzsxRGZGl8EBSMDv+xbpjcFF6NSpLlB/8DBW8vhMMD?=
 =?us-ascii?Q?sFwHEoNGb7Emm5LDS17h5fxPf2Alz2GA8mphTMP9i+sYyjMd6lPl0naasXqh?=
 =?us-ascii?Q?X49aTETu1PJKGJswXBHhcnv2Crzt5nxcxwHE60oyE18vU6PBTvaDpxa9OUW2?=
 =?us-ascii?Q?7Sq84uDrmpLEL0ZIgPWZDUjQK89hvRyWI1jJ1uAoW2P0o08Ivq0vptIFpTWL?=
 =?us-ascii?Q?q+gXqyJxH81g3eX9YUXus5kPajQB0dHhaYJtdWu74iYnJEHRHxNezvHbfAKR?=
 =?us-ascii?Q?YU/BTjHirNSlv+qo3kZq+C+PozMmleD0lBItHDpw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2dd71d-5b01-4728-a00e-08dbd4aa3807
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 15:59:35.4638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2qAnCrfJnbS8fb46SCHYoSx6rd27cjJmHLeJHyXVocIlCWOhtJXbpBzvbHnpwS7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5772
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 06:29:58PM -0700, Nicolin Chen wrote:
> According to the conversation in the following link:
> https://lore.kernel.org/linux-iommu/20231020135501.GG3952@nvidia.com/
> 
> The enforce_cache_coherency should be set/enforced in the hwpt allocation
> routine. The iommu driver in its attach_dev() op should decide whether to
> reject or not a device that doesn't match with the configuration of cache
> coherency. Drop the enforce_cache_coherency piece in the attach/replace()
> and move the remaining "num_devices" piece closer to the refcount that is
> using it.
> 
> Accordingly drop its function prototype in the header and mark it static.
> Also add some extra comments to clarify the expected behaviors.
> 
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
> Changelog
> v4:
>  * Fixed a typo in commit log
>  * Added Reviewed-by from Kevin
> v3:
>  * Reworked the first line of the added commets.
> v2: https://lore.kernel.org/all/20231023035733.27378-1-nicolinc@nvidia.com/
>  * Dropped "fixes" tags and merged two patches into one (Jason)
>  * Added comments to the remaining enforce_cache_coherency call (Jason)
>    [Please feel free to rephrase, or let me know what to change.]
>  * Replace "num_devices++" with list_for_each_entry (Baolu)
> v1: https://lore.kernel.org/all/cover.1697848510.git.nicolinc@nvidia.com/
>  drivers/iommu/iommufd/device.c          | 20 ++------------------
>  drivers/iommu/iommufd/hw_pagetable.c    |  9 ++++++++-
>  drivers/iommu/iommufd/iommufd_private.h |  1 -
>  3 files changed, 10 insertions(+), 20 deletions(-)

Applied to for-next

Thanks,
Jason
