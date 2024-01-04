Return-Path: <linux-kernel+bounces-16910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1D78245EF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7281F23B68
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4663E24B25;
	Thu,  4 Jan 2024 16:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bBaTYONY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E5E24A02;
	Thu,  4 Jan 2024 16:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grXP7Sg+LJA5V4JtfACGGo1HvfM6Jvez9sT/CF9bmHq6ePWCpZh0sP3WGBOpncr2ff6yNJeRfUdsEBA8sjWUmBFDeFt9HrBjnf6F4zYqodGInX71Ps07OhhZIxLb6AaoXNq0X2pPiy3IhsPD0qKSQvlETzZ/yrz5P3DuZAV4AQCFrR0dYgT4hu8UiAAlSWl2Z5mt+nqAgfFxEKj7uNkk16zp/HRZ1S3lBShII/UYJpprj4F8f+wxguSPALGHMGAMkCamr9M3cuUTdUf7jVCnD9EKavxr7RpGHx6W3e5PIhwKGBg3XWJ5SSMpbbyvCTvbPlE5++XOjeMy6iQply/I3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAV5QqVxYo2usZMWLrzLfryKvHgrT5OEOIuD4GzlNyo=;
 b=YYOsh+iE2llWSiW9PQ2Ms6ni8t6GGJ46CcHHV3J3mNcrP1ZiW+DkLZ7Vv/7s1B9JtbRF3PCMWXnl1vaLqj2fA8IRmQH/QcQBmJzwzN6EcD+fC9yUeBEgyeSUW2AWv7rIxcUq1k4M1iuRp4Jv83hdscbvliIUQeGQjl4o/6+VqG843URkmT1zAjgOAF8EuhaK8n9Zx+cmuUr9rnrIskIZ65f9jvgpSGOl8py5AgfpKFE4AfTgTp8HyJbjTSiRo5Npn/oqb9PapYbDv+q+eaUh5OnaPZFRkPwnldPe2LjDYB+ZpvR3zJUHMMQzQX3alCL8onmrQiVD3lo7mBomF5olLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAV5QqVxYo2usZMWLrzLfryKvHgrT5OEOIuD4GzlNyo=;
 b=bBaTYONYHNFtMnddp9PNR8/7LpirXfs1vUney7C3FubDMtCIO9ZnJpMvqPkLumFfs1zSw/HpN0vpvZDEO/IXInNlAUocMdJ9vQxYwRpey3aCqQM8W6mo7/2grq4gxnwPjv8ZAHa6lnKAr+sGOLcDvSfaV6snvhfEm2YNOKovM9Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DM4PR12MB5277.namprd12.prod.outlook.com (2603:10b6:5:390::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 16:14:22 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::6452:1eb:50fa:311d]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::6452:1eb:50fa:311d%4]) with mapi id 15.20.7159.015; Thu, 4 Jan 2024
 16:14:22 +0000
Message-ID: <0fe87b36-2daf-4b4b-a6b0-28a4c6c599f3@amd.com>
Date: Thu, 4 Jan 2024 10:14:19 -0600
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v8 3/3] remoteproc: zynqmp: parse TCM from device tree
Content-Language: en-US
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: andersson@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 michal.simek@amd.com, ben.levinsky@amd.com,
 linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231215235725.1247350-1-tanmay.shah@amd.com>
 <20231215235725.1247350-4-tanmay.shah@amd.com> <ZZWkqYNqR2/Qq54m@p14s>
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <ZZWkqYNqR2/Qq54m@p14s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0234.namprd04.prod.outlook.com
 (2603:10b6:806:127::29) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DM4PR12MB5277:EE_
X-MS-Office365-Filtering-Correlation-Id: efa8ecd5-70f4-42a1-512d-08dc0d40369d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pJf1fmTNUVDfcMbT/kE+UVO2FEUrAvf3/KfYgTfigsknlCOmNaPdx/S5eARIcJTKSEcoTxOgXslrP4UYl54D1Cc2ejCgZgcr3GoaPRvCzMF07jb/k/9lyf9HoxDtL1zOsDbSm+sBvp+ROhwqc9tkxya87VyC3+PW5ZXN9aVFyFkPIJIpicQguX+ln6ieCxEeWsxof3AmMF7KAERPydo4gntBUqmZf0dBjGfdKJbXFgVF2WE/5f4pKRBAAa6D4LDpxPxhydu4Guw0nqHG5c6jNniHF3iFtZ/Iol5GL8Pw6nrvDFInc/73/oFWLdPOCVSB9TgQnnUCUq+Me4aw2PtRESEK0Hsku1tEIlx0OW6nYO3quvMRIEutFM6GJt5Dr7C0wj3sBEw4wKNjc+whgY4X77RJPpto1mwQtaYcqYNSZuGZI53oRPTvra4epFVaj9Gf6XBoUX+CaJmCDKixcHu5t2fA6BMlYjYLr515pT9rQTcMF6iJFcr4TScPvBVnYklTTRyaWYnNxNqEyvinN0PI1YKlTd14OsOGXEmQSwbsRbjzrCas1T1KYNtw0hCLKWgrVUWdL81V6x4OrvuowTs+EnnUayd6GDKsbKBBO2d2fSQrsrB+yaifoXoSP0vA+0jnnlO1p/3VveSbDNmC3JrbFA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(346002)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(8676002)(478600001)(6666004)(8936002)(83380400001)(41300700001)(26005)(6512007)(5660300002)(53546011)(6506007)(6486002)(4326008)(6916009)(66556008)(66946007)(316002)(44832011)(2616005)(66476007)(31686004)(38100700002)(66899024)(2906002)(36756003)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zm43UXV0SGZuU2srMlpVK3Zkb3NjOHNGYlRxa0JkQVQ1NHBQbGtlMHNaS09t?=
 =?utf-8?B?Ujk4VlVFVXVrRXBtazN0QmxrVU5RaHVFRlI2dkp2VTNBanNWSWZHanByV3lR?=
 =?utf-8?B?N28wRkZQWjN2ckNPdEYyaWc5N1FUeUVxR3pZWmYzc1ZJL3hWanVabzNjZTlY?=
 =?utf-8?B?cVNHMEpRZEhFYi90SnZ2Nllyd1gvSDZKaCtqK1pLZmU3aUFRVnF3SytnWXhR?=
 =?utf-8?B?MkJaYlhpWDlkWit3Z09FTVY0N0tkZzZYK3NvcFQ4TnNJZ2F4d0NRQWhlZXJU?=
 =?utf-8?B?cVg4TlVrbVJTZGtrWnQyQWpwQlJzanBzV1hnMlVncGFwRGF5QWs1YXFMMXR1?=
 =?utf-8?B?djdYMXhzbUY1Z2JqakVkRnRZdFVKSldLZXJ5Y3AwcW8zU0ZIdTZZY0tUL1ls?=
 =?utf-8?B?K0pTK2FOVlhBSDlVd3ZSKzZzdXRhTm5vQ2liYWJ5azVkaE14RWZqNXR1b3lr?=
 =?utf-8?B?UStFaTY5MkFaWEhqbDI4WTJHY2RueGxCT2NxbjlVRGhTUzdQeXM5REpzV29v?=
 =?utf-8?B?S0trQUo2UkRlS0VlNEJqQjlMRXhSbVBmZGdISGorSkJaZHJQV3ArQ3NMSGZH?=
 =?utf-8?B?c3h0WEh2NG55cmVGTCsvbmZHQzdHUWNDTDEvaUFSMDUwdDBFMlMwbVliVU5j?=
 =?utf-8?B?emQwL2xZaExLWkExVDBqTXhMWnhOcFJWSHUrd1BsdjVYR2F5NGNiSjNvSW4z?=
 =?utf-8?B?WEdJWUx0eGFleTlHbmpZN1I2S3dsRUpUSVNYeWdxTU9oRkdwbnZLOE5ZUkJi?=
 =?utf-8?B?bU5DRDAxYnBGTTVtQ2xhUU9GeDhFZGNkZElCSStOY3NYZHNnTnlRUmdOaTJU?=
 =?utf-8?B?TFhDcEg2dzNHYmMwbmYybFdXUmtlcnNUMWxCMmFyOXp5d05ISjhoQS9JQzFD?=
 =?utf-8?B?bWVtQWZIaVNkbkJ4ZmtDaUZnZmplOFRQYi9RaXNhbG9SSytPVkVadXlMWTVH?=
 =?utf-8?B?VGtXaGtObDFoYUFKalU1WXlZK3VXN3loZE13a3krNUZCelFZenkzdGp6d2hB?=
 =?utf-8?B?U24veVhEZXhnREgzT2xTVkRRS004TVVHK3JOeWZwczJwSEFRWjNmLzN3WENN?=
 =?utf-8?B?dEFLMU8yTDlzMkhoQTd5eWJFTklxMUNhMVdlaTdNelg5WkhXejk5NHZaNVdC?=
 =?utf-8?B?R0k5S0s4RmZqT3Nwd0UwdDdIYUV4SkticFdyZllJMXdLTFRGaHVaeVc4UTZK?=
 =?utf-8?B?aFVDR1J0aDFYRFdCYmQ1Uytzbkg4TGszNnBBS1l1eG9aTTZhcy9JWHE5UFcv?=
 =?utf-8?B?U2Mvemh1YW8xUlc5ZW40bTU1VTZScEdoUFNSTWROZnQ1ZGZ3eUhER2J0OGJw?=
 =?utf-8?B?NHlxa1ZmOENDVnhFN2x4emhxVVBtMGQzVFpxSWlLbnNVbGFQZ0hENE0vNUJ5?=
 =?utf-8?B?Mkh3WCtDWksrZ0l1M3dTU0ZpRzlSM2RQZFRrT09XSlRBN2d0cFdiQ05kQlB0?=
 =?utf-8?B?UzhrLzVCTUFmZlpKai92MGxVWW5ER0dFazQrRnovcC9nUVRFczExR2ZuUGxS?=
 =?utf-8?B?cldIclUxaU5Ta1JUZVh1OSthM05VQTVpeVdmVVQ2cnBQaENDNW9wSVZwdzhv?=
 =?utf-8?B?NkVnNzZlNEpuSUJiOUdDMEZNS3lRdEZSa3d1TjMrWWtuZHVubzF5NWxoVnZO?=
 =?utf-8?B?YjlEL3hjSENWN3ZhZnlKa2lvcys4b1dmLzhXSm0rM3RMc0pSUDZIOFRDcGtn?=
 =?utf-8?B?cWpXY1pjTll6MDRoeEhQWVFndFhtbTIwdlk2MVJWWDBwVzdQeTFtNU9XNE1X?=
 =?utf-8?B?alpienBjODdzMEwrMEtSQVNib3RDWjZvWFJ4TDQyY2xRYzljekNqL2FTekI1?=
 =?utf-8?B?SFF1SmxzRFBEVnVNRjYxbjZDcVNRQmJvNHYyM2FBNWFtaTk1d3pnNXZ1UHB3?=
 =?utf-8?B?aWc2ci83UUFYZjJCUzIvUXptajRwU1lKeGl2ZmZaMWQ1UVZhcFp4TXRCZWY4?=
 =?utf-8?B?UTAzMVVFWlByNDBZb3g5K3ZwV0xLa1RRQTVrOEREQU16UGcxME1WUWN0dmJU?=
 =?utf-8?B?bERqZ3lKRFkyZ2hGaXQ0Y2lXSFduaHdxVHVQdGdOK3pjNnZHdHpqZXZ1dnZK?=
 =?utf-8?B?ZmJQaDVyQUdBam9xRUtuQjNucHZaNzRPbzJ1NEFwMWw1citWaEpFaXMxeVZu?=
 =?utf-8?Q?EHi5Iny3J6klQL30M2dlroHno?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa8ecd5-70f4-42a1-512d-08dc0d40369d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 16:14:22.6594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dAcxeoqA06Cv3czFizjETBJfil7AYBX5EVC2UFKf89ctQX3GMzzqCRa5Ua3lh2O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5277


On 1/3/24 12:17 PM, Mathieu Poirier wrote:
> On Fri, Dec 15, 2023 at 03:57:25PM -0800, Tanmay Shah wrote:
> > ZynqMP TCM information is fixed in driver. Now ZynqMP TCM information
>
> s/"is fixed in driver"/"was fixed in driver"
>
> > is available in device-tree. Parse TCM information in driver
> > as per new bindings.
> > 
> > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > ---
> > 
> > Changes in v8:
> >   - parse power-domains property from device-tree and use EEMI calls
> >     to power on/off TCM instead of using pm domains framework
> >   - Remove checking of pm_domain_id validation to power on/off tcm
> >   - Remove spurious change
> > 
> > Changes in v7:
> >   - move checking of pm_domain_id from previous patch
> >   - fix mem_bank_data memory allocation
> > 
> >  drivers/remoteproc/xlnx_r5_remoteproc.c | 154 +++++++++++++++++++++++-
> >  1 file changed, 148 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > index 4395edea9a64..36d73dcd93f0 100644
> > --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> > +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > @@ -74,8 +74,8 @@ struct mbox_info {
> >  };
> >  
> >  /*
> > - * Hardcoded TCM bank values. This will be removed once TCM bindings are
> > - * accepted for system-dt specifications and upstreamed in linux kernel
> > + * Hardcoded TCM bank values. This will stay in driver to maintain backward
> > + * compatibility with device-tree that does not have TCM information.
> >   */
> >  static const struct mem_bank_data zynqmp_tcm_banks_split[] = {
> >  	{0xffe00000UL, 0x0, 0x10000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 64KB each */
> > @@ -878,6 +878,139 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
> >  	return ERR_PTR(ret);
> >  }
> >  
> > +static int zynqmp_r5_get_tcm_node_from_dt(struct zynqmp_r5_cluster *cluster)
> > +{
> > +	struct of_phandle_args out_args;
> > +	int tcm_reg_per_r5, tcm_pd_idx;
> > +	struct zynqmp_r5_core *r5_core;
> > +	int i, j, tcm_bank_count, ret;
> > +	struct platform_device *cpdev;
> > +	struct mem_bank_data *tcm;
> > +	struct device_node *np;
> > +	struct resource *res;
> > +	u64 abs_addr, size;
> > +	struct device *dev;
> > +
> > +	for (i = 0; i < cluster->core_count; i++) {
> > +		r5_core = cluster->r5_cores[i];
> > +		dev = r5_core->dev;
> > +		np = of_node_get(dev_of_node(dev));
> > +		tcm_pd_idx = 1;
> > +
> > +		/* we have address cell 2 and size cell as 2 */
> > +		tcm_reg_per_r5 = of_property_count_elems_of_size(np, "reg",
> > +								 4 * sizeof(u32));
> > +		if (tcm_reg_per_r5 <= 0) {
> > +			dev_err(dev, "can't get reg property err %d\n", tcm_reg_per_r5);
> > +			return -EINVAL;
> > +		}
> > +
> > +		/*
> > +		 * In lockstep mode, r5 core 0 will use r5 core 1 TCM
> > +		 * power domains as well. so allocate twice of per core TCM
>
> Twice of what?  Please use proper english in your multi line comments, i.e a
> capital letter for the first word and a dot at the end.  
>
> > +		 */
> > +		if (cluster->mode == LOCKSTEP_MODE)
> > +			tcm_bank_count = tcm_reg_per_r5 * 2;
> > +		else
> > +			tcm_bank_count = tcm_reg_per_r5;
> > +
> > +		r5_core->tcm_banks = devm_kcalloc(dev, tcm_bank_count,
> > +						  sizeof(struct mem_bank_data *),
> > +						  GFP_KERNEL);
> > +		if (!r5_core->tcm_banks)
> > +			ret = -ENOMEM;
> > +
> > +		r5_core->tcm_bank_count = tcm_bank_count;
> > +		for (j = 0; j < tcm_bank_count; j++) {
> > +			tcm = devm_kzalloc(dev, sizeof(struct mem_bank_data),
> > +					   GFP_KERNEL);
> > +			if (!tcm)
> > +				return -ENOMEM;
> > +
> > +			r5_core->tcm_banks[j] = tcm;
> > +
> > +			/*
> > +			 * In lockstep mode, get second core's TCM power domains id
> > +			 * after first core TCM parsing is done as
>
> There seems to be words missing at the end of the sentence, and there is no dot.
>
> > +			 */
> > +			if (j == tcm_reg_per_r5) {
> > +				/* dec first core node */
> > +				of_node_put(np);
> > +
> > +				/* get second core node */
> > +				np = of_get_next_child(cluster->dev->of_node, np);
> > +
> > +				/*
> > +				 * reset index of power-domains property list
> > +				 * for second core
> > +				 */
> > +				tcm_pd_idx = 1;
> > +			}
> > +
> > +			/* get power-domains id of tcm */
> > +			ret = of_parse_phandle_with_args(np, "power-domains",
> > +							 "#power-domain-cells",
> > +							 tcm_pd_idx,
> > +							 &out_args);
> > +			if (ret) {
> > +				dev_err(r5_core->dev,
> > +					"failed to get tcm %d pm domain, ret %d\n",
> > +					j, ret);
> > +				of_node_put(out_args.np);
>
> I'm pretty sure this isn't needed in error conditions since @out_args would not
> have been assigned.
>
> > +				return ret;
> > +			}
> > +			tcm->pm_domain_id = out_args.args[0];
> > +			of_node_put(out_args.np);
> > +			tcm_pd_idx++;
> > +
> > +			/*
> > +			 * In lockstep mode, we only need second core's power domain
> > +			 * ids. Other information from second core isn't needed so
> > +			 * ignore it. This forms table as zynqmp_tcm_banks_lockstep
>
> I don't understand the last sentence of this comment and it is missing a dot at
> the end.  Comments should be enlightening, the ones I found in this patch are
> sowing confusion.  
>
> > +			 */
> > +			if (j >= tcm_reg_per_r5)
> > +				contiue;
> > +
>
> This condition and the one above (j == tcm_reg_per_r5) is brittle and almost
> guaranteed to cause maintenance problems in the future.
>
> I understand your will to reuse as much code as possible but this is one of the
> rare cases where duplicating code is probably better.  Please introduce two new
> functions, i.e zynqmp_r5_get_tcm_node_from_dt_split() and
> zynqmp_r5_get_tcm_node_from_dt_lockstep(), and do all the necessary processing
> based on the use case.

Hi Mathieu,

I tried to implement this and it still looks hacky, as in lockstep mode unnecessary TCM is being allocated just to store power-domains.

Instead, I am taking another cleaner approach where, TCM is parsed in uniform way in both modes from device-tree during 

zynqmp_r5_core_init. However, during  "add_tcm_carveout_lockstep_mode" call, I will simply parse second core's TCM power-domains

from device-tree and turn it on.

I will implement this and send v9 after successful testing. I wanted to give you heads up on this approach. I hope it is fine.

Thanks,
Tanmay


>
> Thanks,
> Mathieu
>
> > +			/* get tcm address without translation */
> > +			ret = of_property_read_reg(np, j, &abs_addr, &size);
> > +			if (ret) {
> > +				of_node_put(np);
> > +				dev_err(dev, "failed to get reg property\n");
> > +				return ret;
> > +			}
> > +
> > +			/*
> > +			 * remote processor can address only 32 bits
> > +			 * so convert 64-bits into 32-bits. This will discard
> > +			 * any unwanted upper 32-bits.
> > +			 */
> > +			tcm->da = (u32)abs_addr;
> > +			tcm->size = (u32)size;
> > +
> > +			cpdev = to_platform_device(dev);
> > +			res = platform_get_resource(cpdev, IORESOURCE_MEM, j);
> > +			if (!res) {
> > +				of_node_put(np);
> > +				dev_err(dev, "failed to get tcm resource\n");
> > +				return -EINVAL;
> > +			}
> > +
> > +			tcm->addr = (u32)res->start;
> > +			tcm->bank_name = (char *)res->name;
> > +			res = devm_request_mem_region(dev, tcm->addr, tcm->size,
> > +						      tcm->bank_name);
> > +			if (!res) {
> > +				dev_err(dev, "failed to request tcm resource\n");
> > +				of_node_put(np);
> > +				return -EINVAL;
> > +			}
> > +		}
> > +	}
> > +
> > +	of_node_put(np);
> > +	return 0;
> > +}
> > +
> >  /**
> >   * zynqmp_r5_get_tcm_node()
> >   * Ideally this function should parse tcm node and store information
> > @@ -956,10 +1089,19 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
> >  	struct zynqmp_r5_core *r5_core;
> >  	int ret, i;
> >  
> > -	ret = zynqmp_r5_get_tcm_node(cluster);
> > -	if (ret < 0) {
> > -		dev_err(dev, "can't get tcm node, err %d\n", ret);
> > -		return ret;
> > +	r5_core = cluster->r5_cores[0];
> > +	if (of_find_property(r5_core->np, "reg", NULL)) {
> > +		ret = zynqmp_r5_get_tcm_node_from_dt(cluster);
> > +		if (ret) {
> > +			dev_err(dev, "can't get tcm node from dt, err %d\n", ret);
> > +			return ret;
> > +		}
> > +	} else {
> > +		ret = zynqmp_r5_get_tcm_node(cluster);
> > +		if (ret < 0) {
> > +			dev_err(dev, "can't get tcm node, err %d\n", ret);
> > +			return ret;
> > +		}
> >  	}
> >  
> >  	for (i = 0; i < cluster->core_count; i++) {
> > -- 
> > 2.25.1
> > 

