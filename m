Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070A97A562D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 01:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjIRXZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 19:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjIRXZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 19:25:30 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7902F97
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 16:25:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPscaggQPZqNCy0VtSDdRc+Mael2UtHE6GnqASrbUHj+2Vp2mNl/sFzUcEopYRGXLMxnw2dAF0UtWBsklEltGyF4sPMAdfLZkVF/rHyzzkvZHQ2Nf1zO9NA3javYDUqblBER3NGCpsRfNPqh4jIuwi59UfPQa+DKn+kyx0s8JkNWOsYRiwqOhkUyQqY2tUUUMN2lGxWgcva2WzQfF38SWrJeI0z9stmxAJj2njqMkLpLV1bO01fnE1pAcJXxsAwQ0m0vdVuhHCZLIdlrKt9UFhMJrDmGSPe6KwivUk0UInudwEmGVgwNR5Spm+MC/hYagXFDcLg2eUFnWD/eYHG6RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALUEUHc4QSqfYVs3PBYyaUAwdUbwh2wQnLONBgdxNtM=;
 b=cYzvZ5cmEtjRDGsib9MiJz00FXsRSn6vf6ECzwhv43WFtxCBgkJHQ6yB7o5FriwQz4FJDA2SyQs6xd4JlEoyMnlUwedtpJFiFL2pfmzENqyT+RH1Mr8OrU2SZffNfNAneGzspH6KET5Jn0Qg+5bzX9ycLtwXkuoEuB7yTgmk2RM0XL3SuoxatpTTEbuZhN2mtcITihGpGogtF3g4857JAy3J68DcAIt5x/dKXtIWWP4h2XKeDKv0G87AHcZwG16IWLu755kum/zlQNjE7SZuwidzBU6c7Wu+w2ErG73gwVn3UhyxNylSS/+bi0NGMs91uF9d4ggFpkcY2cejrFjDdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALUEUHc4QSqfYVs3PBYyaUAwdUbwh2wQnLONBgdxNtM=;
 b=dSq4mBDUv9WJSNB+3tRv3L+DT8hJr/ClpVFAe2IPO9ThODYK3fiTQ+wHjoj+mXf91jVFEZuLZlAI1n/nfM+l1OHGq5dy04SxUYTgaUXfPN52lJYcJn6CkTNzDnygfE8ymRURsn3aQiCDq7vno8sdQ83P9f+7QxH596He78y/V0bYa0QpEcu9SJwy8WcFxcETSNec1M9ofE1s7bDPuFhZamniMVsMgMu3IVyyGtcggTJcw5wqc+YhHMq26inQEN62+8ozJF6H939M5JvljU8SIc95uqGVcXEWtc37YMtTA4dwuG9vFTbw/YUPrbnQUWxK/betnMXXMnPe6cxQVquVLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB5860.namprd12.prod.outlook.com (2603:10b6:208:37b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 23:25:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 23:25:22 +0000
Date:   Mon, 18 Sep 2023 20:25:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        baolu.lu@linux.intel.com
Subject: Re: [PATCH v3 2/7] iommu: Decouple iommu_present() from bus ops
Message-ID: <20230918232521.GO13733@nvidia.com>
References: <cover.1694693889.git.robin.murphy@arm.com>
 <b7cd933aa7774ad687c695ebe5e00c17178a7542.1694693889.git.robin.murphy@arm.com>
 <20230918171216.GK13733@nvidia.com>
 <982143de-ec1e-aff4-e65f-77a38e48cf20@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <982143de-ec1e-aff4-e65f-77a38e48cf20@arm.com>
X-ClientProxiedBy: MN2PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:208:fc::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: 29c4cdd4-e125-4947-f6ec-08dbb89e8771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CsR/uf+3wC1bGHY6Jjx2OiPW3h2oMzN/r21Xn0TN9F+2dYEsJgwIypp3BSoLYBacn9Qduq7D4OWMuvUhHkhFP+S4Z23nImEZKzyYQmrUT7W3cr2M6HbiEkvIRSc25OgpyCw/UsOvaKc7+I0VNLTAerVrt7rP5AnvWbO2u3VMYLtsZMAGG94wA/ypyTRgb/baAVVUq/rbhL5nn0hluwpKxRPIYgk2Y+Xxn31pamqQsK1J7pM+jP6zcMmW2KTzFIkJ0fsoxRzt51gtri3VwjOI696anuEDWlmB+Q4xU5bI4+yCPa40r2KoJrYTLexbxwdCNNLwf354Agl2awIlSuOrZNhuttwTYIwButxn9Q55jG2px4RdsmattcZj2SnWUpBDLTbYf8RXGloildjySyGzlffO1NTpdq/QN3OctdrcbLhplNevO/wyYQfeEBItLEbCMz+nBKPVcZ7CNvje6CPAnEi+5+Y1sV+uCyUNkzHugDw5TcRwZWwl0/cK7/szQZdDLf45c2bsk314E77KqyRxa9csazoaSHpcAfmMagQx3plaYukCjKR7TFLQ9NSNYs9V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(136003)(376002)(186009)(1800799009)(451199024)(26005)(2616005)(1076003)(6506007)(6486002)(6512007)(36756003)(86362001)(33656002)(38100700002)(83380400001)(5660300002)(478600001)(41300700001)(66946007)(66556008)(66476007)(6916009)(316002)(8676002)(8936002)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SrMWZNe24sTeC7Vbqe9MUFkzRrI67JhnFW+WcCosen5i8j+TBpfW0RfU2gK5?=
 =?us-ascii?Q?MBIhdX7az3kOKThIc1MLeXk4X+wvuyQp2viqwHXbxfOpv0MsE5a9xe4mfKk9?=
 =?us-ascii?Q?1LfaR74RREaD36zxN+RIgNOoDbXOiM5o70ikXZ078z9j0ImNNJESthFl2Qcw?=
 =?us-ascii?Q?ZcNB0g3llXSta3Hd93BRD63ymi4B8BIshUtFw1QdiHT6aKIrWwNC0MUyd1ue?=
 =?us-ascii?Q?yY5UCot9s/kR9gQ04ZQP5S2O7Gc0ZzikNw6l84bjkbu2m0/YTb5hCKnXsNzp?=
 =?us-ascii?Q?KKEqgHxHGN6RR7Zzm+02YEWVUR8XQ0wkeKATZoflFLoViKDB24zr/EBvfAQ7?=
 =?us-ascii?Q?rFNqVa4Ji18QbgCeLD3YISWmHV33hdn4eu9TqvjPwabP6ne1nq79nui25uK+?=
 =?us-ascii?Q?7RtJrc8XdskYtUk28Eb8cNNgYql2emlqO3UwbbHjmqnOVjCIAfNphizRiNT4?=
 =?us-ascii?Q?f8Q2eoFdXqlS9V45A3QSOqlBUKSepHn0M7ulmPTWOhQK7ELZm4oqLxMjid4K?=
 =?us-ascii?Q?MbR6Vixdw3DfE+pDMj3MKRPX9PajvzBP1f0wnWliYZ+bD0lBeZqq+uJD1638?=
 =?us-ascii?Q?nEK2zS8aeEqAjIKDeziYV9ffvsx++2K+oxIsa3hccYxqq83H5eJjAUWTR5AB?=
 =?us-ascii?Q?mqR2bqnGdJk/lUDftn/YbganJggoLEI+Glkra928NObxACGkW4BbrNxQamMX?=
 =?us-ascii?Q?EY8q0ikQU0J8bTfDjxCKdhSXtp7T9vdFM1DjDfYl0mzQjI5s2VTmW/GrycE1?=
 =?us-ascii?Q?LrlPFLTMHBIXQsEHTq824HFN2+sB4XJbOO2Fl9DwSGRuxvq16Q+lNeCuhKXa?=
 =?us-ascii?Q?F4ZsINfJj6l1xEuMgx1bDUb5kBuaCUfNYLNPXKnqIwkgkNqt8+8TE5ViOD6y?=
 =?us-ascii?Q?U6BYhBwNuOFstOKiC0XVBwrgRtQYZFeNSRhu9OZpAGkR88TmQJ2mCcwSuZAL?=
 =?us-ascii?Q?8CWxwYB6n0bNF6GpNd9N+4t3S5Mud4aJtM308c0jGNA6AQ2xXdRAkdjKfhaj?=
 =?us-ascii?Q?myeM4QAs9r7PtvGcWVRT7c4vNFMgTa74jQ7uWVWsBjprB+PFpavsIzF0ul7t?=
 =?us-ascii?Q?PmE/V4uBojO8CrXevhwtD/YL9JAaeFjiFlOfmvZ2bf5c9mhxlYiK8NJ8HrBT?=
 =?us-ascii?Q?N9zs7R3Y1HBdxCtkVlxcZ3w1BavAIBcWt1Hx/7rAJH9SbwuYkqvwZOo74+sT?=
 =?us-ascii?Q?aKt6vWS5fnVujyn9ydldUoLGAL6TpcMNpSMLlbYL7kqDHEZBZDeHmD7ays0j?=
 =?us-ascii?Q?SAmFpsJWxWKCV78XL+JfdGxTcUEjKMTdWCJLf+7g2Angh1xr9xGhbE2lCR3p?=
 =?us-ascii?Q?ekPXbnOrN69xo3PdyHofnNuKwkGFqG5ObWb3sQ95jCzIXIIg/Lh5YP+YRDnN?=
 =?us-ascii?Q?adcD/UJffpdIbsZJVj9uwt0QZ2nZufeuhTIApr/5BqfD1lSly8eMRb72u39z?=
 =?us-ascii?Q?ljcco670PGeXHTqRAZ2stFjHgqi81+rXAKZugqLswRTzPtFRA6jelF/0W6L7?=
 =?us-ascii?Q?eaK6fHo0ZxsEIhr7OgreR+BrezoadZhSLBA4oWgMHZVGyhq8EGaXVcD0jsVu?=
 =?us-ascii?Q?ZWewyK5PfdzV0YJoXdo1rwfLRyDMZ1TTCOthNbFl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c4cdd4-e125-4947-f6ec-08dbb89e8771
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 23:25:22.1211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQpqrXvWh7bJwHN7ccOwJD7QgX+sxFyS7G4y9BxRnaH5x+VMkn/u++d70S2ys/ge
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5860
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 08:21:45PM +0100, Robin Murphy wrote:

> > ? It doesn't seem to use the iommu API so I guess all it is doing is
> > trying to fix some kind of probe ordering issue? Maybe the probe
> > ordering issue is already gone and we can just delete the check?
> 
> As I've said before, the correct fix for this one is [1]. I've sent it twice
> now, it just gets ignored :(

IMHO at this point just put it in this series and have Joerg take it
:(

> Hmm, I guess maybe I did get a bit hung up on the bus notion... Indeed I
> think this wouldn't really be any more inaccurate than the current
> behaviour, and might be arguably truer to the intent of the function
> (whatever that is) since in the new design any instance is effectively
> present for all relevant buses anyway. I've respun along these lines (but
> retaining the argument with some token validation) and I don't hate it, so
> I'll send that as v4.

Eventually tegra is going to need to pass in a real struct device to
get the domain, so at that moment we can switch it to use the device
API on that real struct device. So this definately seems good enough
for now.

Jason
