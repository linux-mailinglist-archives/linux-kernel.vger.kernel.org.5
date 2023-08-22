Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926BA7841D9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbjHVNTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjHVNTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:19:50 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BFF18B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 06:19:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5/IlPDcm5IUlvHXh6z5qiKDw21DuVD2M2L9lbklTHwGJMka+OCX4lQtVd0nRv1JXXfC6DHtlEgY8ax1jOIf14rE91YWssCUI95e44YRU8WoOrhx2lvCReTWRt8LjzyDnd7FyFdVet9MvCjWbMGYmBIhRTXkxtJ1Y6QhYuZkW/iFL+LlSjEEXwxyEJD85IF5jNp8NYIOWYii+iTw3ahiV3lkSgKvOpVwCeeZcFwFkOcWxrxvDA3iNSme8ioyh1Ga2XW0HEhix/OggdcblziO8SoD5dZYsEghcX2744SSVAMnFV7yI3teeY/ykEOzHZGscVJxY7J5xP82df7x+E9HWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePCMF8sHMjVgG3m+tbcSEMQD01JqzQGWGv1JYiNZTUA=;
 b=Z+/eG2K8bxfD9RxYHMbIDtvL5P2jEhqb9gAe+eTEmERvxix32ETJxbJWd5YRsiTAtouETrM3PduiWNdehPRm6Ba1rFHN2WLLKdBqx3jxg4MuctB5N8Lda2/HRBmvBdKJ/3dnojSBXtIbHnHnhn7EitjXZ6wwahJ5+qaLZp2mtwu+1W+LgG1oLaBU6jcfNflcrDIlnU91f5Y885ceH6ir86B0HrBOEmZOfa8VGs3mBRzGjJcxzXvW1gFGvSlYdQH198+xm5+C5neeBH9HtT7GtsFRhKnXMMga/jAtCHbaeQbfjusASoVW/qapbZhMcZc50HjzbujlE5Sy7P6rDNbEEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePCMF8sHMjVgG3m+tbcSEMQD01JqzQGWGv1JYiNZTUA=;
 b=H+YGeCqmw9vRTqwUtsbd7oMW/Pxmus2ulVz+qMK8jjVM2GedB0IZrJVe4j0LZ65SzuHCxh2ZXpLFboPRhyOaL2tyvpGCOp6aihcevuhLuN92dhREl/T7LnDa3kuSIf87OiW+WgP/3+JA4JslgbStoptPQuWjexEFQY3GKCRBaEKNtg2JPFpFLjUaIzuOrx8D3kZj2Wwzcwf1N+EKbSkDNNib+UtW6dnkvvcoqZqKEgG87z9/FO19dhnJno0LVZ3YTdtYYT+7TU1sOZFwn8OHl1fAOAzYR1qW3Ly0zw/VQo9X8+vgj7H9sSAusr1YZaGDK2R6VgJRXUBh9/Hoj6pHKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB7792.namprd12.prod.outlook.com (2603:10b6:510:281::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 13:19:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 13:19:45 +0000
Date:   Tue, 22 Aug 2023 10:19:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, nicolinc@nvidia.com,
        tina.zhang@intel.com, jean-philippe@linaro.org, will@kernel.org,
        robin.murphy@arm.com, Dawei Li <set_pte_at@outlook.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH v2 4/9] iommu/arm-smmu-v3-sva: Allocate new ASID from
 installed_smmus
Message-ID: <ZOS18J4ytKjHFT+N@nvidia.com>
References: <20230822105738.1607365-1-mshavit@google.com>
 <20230822185632.RFC.v2.4.I326c62dc062aed8d901d319aa665dbe983c7904c@changeid>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822185632.RFC.v2.4.I326c62dc062aed8d901d319aa665dbe983c7904c@changeid>
X-ClientProxiedBy: BL1PR13CA0449.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b20cc0-1929-4993-68fd-08dba31273e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mx6rhT0c8ToUqKa8eyrbky1qbnL8WJlVpzdnso8ZRdytTJ86IBI5wea2kr0cg4K47wJeDEOdTnfvp3abIHZpHZh3LhgjVGPwf546b4htXPZoELG6i18wk5FkHIs7IKeUp0dd9gc/kaHUlhFlgSJJjOvtllfB9CV/wmHm9RN/VCcxASjo81zt/2jpUGDsU7gDjVvJBC8QPuVloc7gy6P2PA715tPBqAzt6RMuFr4kPagznRsSEk+X3SSh86QlV6PKOz/GawYKfkSYWYfMZNSI6cFo9YFJyLxYwYSYYUfYYuDb/Ciij/DbuyhRQol1nQ6OH6l+nOuo/IivLE/qpTtd/cdRlEV+wLnh7NwrZrk8TqU1+6rTSD/9uAcmoPDl8diQUNXGx6rcrAP6wstopZ37DIGLxR/ViULoI1O5GXdHcCvBhqh3MHLL+CdrXXL1k0RP1fm2cPfgOokAVwvr8q9RlJVfGKWTqEJxgL+We2jwqyAraMyIzfY9X3oSD2i4CbZB93WDTrLRYWHBHYJo6jMgYuhJM/nt+pZOBcruNCZDtfUSxaNwNnxrrSY8pjhYDb/C09xDmPKCprCdH2LPP4mtT4EKzbXFMVVXBskGqYZ7Ib4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(1800799009)(186009)(451199024)(54906003)(6916009)(66476007)(66556008)(316002)(66946007)(6512007)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(478600001)(38100700002)(6486002)(6506007)(83380400001)(2906002)(7416002)(86362001)(5660300002)(26005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NGCGnJHm0aWuwf/2qstpLnTDiBSIeS/QRvwWdLcgzU43AkNNzfGqTwRZBRd6?=
 =?us-ascii?Q?ZGUrKdFc05u2NPsyk8oTlnTVf+7w62RBBfg1NfQK9rjYv1C7rFQtJv9/imYz?=
 =?us-ascii?Q?Iz4kebWV0MvyC88PRltkiwsMZiHUs3/E/xwPk9q+VmO6ZRuXPbN01Mq9Pk4N?=
 =?us-ascii?Q?+AcyBC8YPiREWfV33xhV/NPDxQgtodXtioZllbyAdUjlcEYoSLGLr/I38+Rt?=
 =?us-ascii?Q?IDKruPM1oxBMR2gsWwL+7CbfMpYP+n/vPGvqmWSCOWSXl4DipfG/UmTemlzO?=
 =?us-ascii?Q?AS0l+ALb5Wrb97gEWdiqQFxcakEip+TukyM7DhomU8ncRvz5AsID3Ktlv0Ko?=
 =?us-ascii?Q?NKHtAeMpEyHkaaN8+4IOO40SyRNCE8LfMFs09yueDMNFmdBVTBBlYU7A0SCi?=
 =?us-ascii?Q?xkzdiIEai+eblRzP3EeYF/wNXJig6MbOW9GDLiyLK6ROpgFC5RJrIl8r2cwl?=
 =?us-ascii?Q?H4cpMgFh1BdP4bce7ZG2rgqF5LRnORnerSljeIxL5FrmtPYpdFfeWqzS7qfQ?=
 =?us-ascii?Q?/C87yPnX+M/4TIbwZ2zFmmoAPTwBxAVOmM8Ts6LDpE1nzmQ2Io7nUtdr9Hd9?=
 =?us-ascii?Q?mbwTiGleLKp8GMrPHC1ueqGFTPUGoXqKe2HPVmwyXz0G8yGtEFSOJEbMmMN1?=
 =?us-ascii?Q?BP6Wh9JDjsVJqwXDW95NQKwYcDHSf3a7VHgSVJP9csX0/xtdjvcp8rk68xDH?=
 =?us-ascii?Q?2FyY0W8Gy5U10LI6W3K/+tSHwQu781THnBdlebCgj1R4sd1g+kgyRG8bAqdn?=
 =?us-ascii?Q?bTEokC/1Q3/P7ZzE9h4Al8GvfLhb5tFVfYkmVhN8IMDvKR2A/VP3zP8OZbc/?=
 =?us-ascii?Q?sXMpOjtn7Xgn19HrciOkxrWvcT0JiE6CjFExNIAw/vog6vkqvoZ3EbSNWoQG?=
 =?us-ascii?Q?D17uoVOojBQOBtWMhdLf6tU68P00tnpPrZZw8PTfrSRh13dzA14ZNjgQyMAr?=
 =?us-ascii?Q?b6itZ3rDTWka23tKtnXlYlq7+SQ9vQtpO6ZD3kZETXcG1TgoGUiAx6WEejp3?=
 =?us-ascii?Q?6/XAC8GnOGjVC2brix1BhQq+2tXHOQUu+Hhudj20s8/6DI1cyToluifWxa6Z?=
 =?us-ascii?Q?wYqJKhxJVLoecefO6o9loYkUSXs2SeQlyNCuGs328tTks9BrjRyr032SNso7?=
 =?us-ascii?Q?64Z6gIsY2MamgBQ/VthGWQy4F9CHhg3nZsvYrwtDfETT/OVRCpw32UD0+G5s?=
 =?us-ascii?Q?3eWUgEHXHlTr1SCke+8tkontziDskSKUYmfDGBsc7rnpBoYHXW8Ob1aV6K2A?=
 =?us-ascii?Q?HaW1nCKxmhBw5X7/ulK97O5vD4vRR3mTmpTAJuS5jR03nZQHTEuf8/THFSiU?=
 =?us-ascii?Q?nkybAkc0nRA9EctRnsldcva+J7zHC5L/A02gSAJjuCPCa3Vgw6G+XiaOmLha?=
 =?us-ascii?Q?L+4jhK/sDsxd3LkyUaVBZVZME/EsN1TzvcbW7LElNM7ZZzDB+W1dMywjyHdy?=
 =?us-ascii?Q?F8oGK/uMRmas9iCfJ13eY40s2MnPnHRgc9cnQZXG9kG99O2z+OytEo0C2rN+?=
 =?us-ascii?Q?gVr01cWlKYXsPdUT1fopk5t31kPKmAt4X7iE4e/2njEiK4DPe5l8ALQOT10v?=
 =?us-ascii?Q?tsJwFP1iwPLzyWpN6mgFoRUGiot2jCYDEg/o8w+n?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b20cc0-1929-4993-68fd-08dba31273e7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 13:19:45.4012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j7rL2VGR0pmzMPf7RZIDCV9S5nVlEydVrQ3ECToQW11dSh5Z8C71QEmbRySLusFE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7792
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 06:57:00PM +0800, Michael Shavit wrote:
> Pick an ASID that is within the supported range of all SMMUs that the
> domain is installed to.
> 
> Signed-off-by: Michael Shavit <mshavit@google.com>
> ---
> 
> (no changes since v1)
> 
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 23 +++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index fe88a7880ad57..92d2f8c4e90a8 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -66,6 +66,20 @@ static int arm_smmu_write_ctx_desc_devices(struct arm_smmu_domain *smmu_domain,
>  	return ret;
>  }
>  
> +static u32 arm_smmu_domain_max_asid_bits(struct arm_smmu_domain *smmu_domain)
> +{
> +	struct arm_smmu_master *master;
> +	unsigned long flags;
> +	u32 asid_bits = 16;
> +
> +	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> +	list_for_each_entry(master, &smmu_domain->devices,
> +			    domain_head)
> +		asid_bits = min(asid_bits, master->smmu->asid_bits);
> +	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
> +	return asid_bits;
> +}

I still don't like this, it is not locked properly. You release the
devices_lock which means the max_asid could change before we get to
arm_smmu_write_ctx_desc()

If you want to take this shortcut temporarily then a global max_asid
is probably a better plan. Change it to a per-master allocation later
to remove that.

Jason
