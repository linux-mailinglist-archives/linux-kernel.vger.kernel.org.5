Return-Path: <linux-kernel+bounces-15886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B4E8234FD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4291C2092D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1721CA93;
	Wed,  3 Jan 2024 18:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wbGSalma"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6141CA86;
	Wed,  3 Jan 2024 18:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VP7X/qZ2IMkULgTCF9gdyWFw0E6q7lrtfJy3uyvVhgUS1/N2U3grt3ro4qP5fIWxBCXeDQY79KMqEPZp1qbzXkuXI1R4vxV3a3px6Jxt4KJnMvg2tB0jUz4KNciJVCsBsZbx3pY68KQlPqHfdubdf7tMbM3P9Hn8j69+O1g2+M+hk3KZSV0gGrsLAaWaHtrQNK3ORDxNZW7iTsCrPCYpHi20XjmOuKcaRfgZD6tSarWcK5b+iSvP9iYb2vpc/2f9TSGl8Ch0DeXOPDHES8bc4zGRBPij8bNERvWkG2WlNbvukIgAaxVINHoVMFzF1Qz3GD+osaCsnXxCOXhc6ZOUXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCHKEIm5sl33nqqIhVG60rmG3u1vhJKt7gZDG8wzRqg=;
 b=k1tEdVrjiyTbe0lwB6BkDvraqwmI6u0aHHxvDzBAlk/B/VuJr3UPqQnJRevfJPLm438dI63GrauMYCwJ1u6gYmGJ9T9goo9UUhcBeF1qui3gPI4kly8PIiYzC31LBtTEYI8kEI3NGJ8LkZhR5dzQds4lfd5h87uR7PdnNCL3gqUTArh3+WMcNjAajOHygpHnLQEyZPUFkkWryA3TGuAQDlJs9TJYGvnSiUYP0BzCEhMYcERQgYMwbEbwBgQxtwboLQQyOVw6rpKDBdubCbfNQdQ3JnTE7hjepFTcpcLD+JAdGCNo29PM+T8TmTwYDXkUWkclH6ij1/KNaIMUyPlxEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCHKEIm5sl33nqqIhVG60rmG3u1vhJKt7gZDG8wzRqg=;
 b=wbGSalma5sNwZ2+uT9H9DoW21TZYWDsoRAToT9+G92hG/YcwdR6r3/XqTvaynlwKSjnk4U+K9LQT0o5q39CYLPap7GqPXJ5gvfiCs/4x9NHId8wQWiOMGAojpPvu44U5BFWC+SEY4kaw3peqFa0Qgq27jnTkQOv/5bonlxqlOfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by MN2PR12MB4344.namprd12.prod.outlook.com (2603:10b6:208:26e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 18:51:43 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::6452:1eb:50fa:311d]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::6452:1eb:50fa:311d%4]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 18:51:43 +0000
Message-ID: <bab3e3d6-d6e6-4028-99f2-781cd811d3ce@amd.com>
Date: Wed, 3 Jan 2024 12:51:40 -0600
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
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0155.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::10) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|MN2PR12MB4344:EE_
X-MS-Office365-Filtering-Correlation-Id: c51f31f9-01a0-4d2e-666b-08dc0c8d074c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Db8dA7NZWSzRfcxYC13ratrA7ip6sh642afbs3WydiQkUP8hgtb+XhAWwWt6p45XknfZsBGkgFjT8YSoXh6uoWEoVujYebrCN9TdnUhflmb86IuOxJlSh+e9fYx2wd4P8FfvuPmuZSbslTT/dAYqCDAlDrVFJoU02OJ/ArNq8zPRbVuofaSpCWWX9d7WSS6ezGSyUMQ79YfMfkAWDz9z+61yQ8oVdoVJuBRc3wRFLiOwYRVuVOCkQAqV0B8RBTIJSQ7qSL+aCWsbdEV4KD4uQLq5WuPbNAqqajMIB8kQ7zEBhi3YRO6MCqXfkko69Ql3LuqySNeLhd4fK3DdETSzgsw+DlIL2B7wK7wuJaAgLrWKIS93Y2E0mBfeXRqHRnM8Wkha5TRdEMp5gg2z/9AijGvLNAV26ljWU3iVHOLVsmiWkLIcmc4EGaPqv81++NN+wK9bwjbQK62nb681/YCcDQ7izub2qQ9PEe5ZDufWlkG1KKbhvzplfj5KDiPE8peXRCzyG4c4Ah3bGkbbMpiNUMugVFjfrI/F9VL8ow6EfH0u+LafLst9HQ1kJFcqvWxqFsevehlx1SJvCXTwaN0KLVSRayHOdf8CXR0eFJ0jwlOHHr5Tet3KeWTWoEuxW9lTsEytWNNwbpGJ5PoProbz/w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(38100700002)(36756003)(31686004)(31696002)(86362001)(2616005)(26005)(6512007)(6506007)(53546011)(4326008)(8676002)(6486002)(478600001)(316002)(8936002)(83380400001)(66899024)(66946007)(66556008)(6916009)(66476007)(41300700001)(5660300002)(44832011)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUhUK2k2enM4QWdjUFpTOC9udWVVUm1wWUdhOGd2dVJUMXV1d2dGbXlZNGFq?=
 =?utf-8?B?S3NtRlZ4SVRpdVJWSFlOVm95YTMrc0ZTUzJUY1ZLNUpCSXhsaWpnbkFYTUJG?=
 =?utf-8?B?ZldHNFdESWN2WXF3d1BMQzVrcTBzSDBwN0YzWnh1Wk1KRnhMcDU5aVU1aXd1?=
 =?utf-8?B?ZVpMNlB3a3FPemNSd3FwWWkzM0g3eUNIL1R0VHR2eUZGRmVLZGMyVE42WFFn?=
 =?utf-8?B?L3BKMzd1WGROa1B2YXhBQWhsMFJ5S3dDTE51SCtITW4xc2drWmkvV2szQ1lq?=
 =?utf-8?B?MHYvZUo0MUNpcE5nU3BoUGJ1NnpMUDNCY1o5RGt5SUtDMGc4b1hKVTI0dkYx?=
 =?utf-8?B?WlExMmNVUGtjSktoYlJCVFZnLzBvV2lVYVRpalRoYWJObUorVkYxQkQ0cjhs?=
 =?utf-8?B?Vy9aQVVmZ3V6QiszZG5TanlhRUJPT3gxejVleVhheUI2N1lTWDRINjByWnBO?=
 =?utf-8?B?b0JjejZuRGdVMW15eTRhN0FaVWtlTDFmYlhEYzFzZENkcU5Cby9sWmpzYmJZ?=
 =?utf-8?B?UEIrT2NaZjA0MEExcldMZ01jS3Q1Uk5PaVNXcitmWGNCdTZaUXhNYTBVRWdY?=
 =?utf-8?B?WU9ydkl1VmRsaWc0SE1OdTlyNmpNWnpqdVo3OWtqanR5Ly8rbjVrc3Ftc0xX?=
 =?utf-8?B?b0FJS3I2MUlOSXA5c2p2dmJzYVNuc3BqU3ZEMytnZjZuMmxCaFhRQzgwMG80?=
 =?utf-8?B?UUc1bTNKRGhkUStOOEltaFl2NGFyOExWcnJQSTgzNTVrNEhuS2dPRFdXS1lq?=
 =?utf-8?B?d05CUVRNUnZkRHdOaitzSXgwUjFqTXE0dlhHRmdOaXdSUGJKUTRXWjlFWWMr?=
 =?utf-8?B?N1NBQXN2M3NZaVVqS2MvMSs1THRQZjh6ajhYaE1lOWMzOTkzUU9jOENFb0p2?=
 =?utf-8?B?cG5QRnlyM2NUQVUvZXlYeXRtekxYT0xTeU5HYUdzcmVXWEliNnA2N3FDSE5G?=
 =?utf-8?B?UGJ6aTBxSWNKNEZPdUJkU0dTZVR1bUZtcUxTdGZ1WFZZaUs0elEzVXc4THcr?=
 =?utf-8?B?MTQxZUU5OXBjZmowNGUreXRMMVBQWG9SekZ4UjVGckl2Y2M3ai9HdXduVktS?=
 =?utf-8?B?ZS9Hckwyd1c5UHdseG9pYmtLZWxISTBFL3FOUHRwN0NnVUt1Q0dVR09SSXBt?=
 =?utf-8?B?N2FHdzBWRjhTVXM5K1VrYzlaSmkwTXlNZTVpbU5zK3BNTGkvRFBaNUVhMExH?=
 =?utf-8?B?cW1KVUYvRDgySHdYYWpZL296aDBna0U3SGpGTUVOenU1Y2g4UFZ5RXZVeUdi?=
 =?utf-8?B?S09wWks2REFXOFV2M0tjcFRtdlFYVUhMWEsvZHN6cURDaC9RQ1JBUk9ua21o?=
 =?utf-8?B?Q3Rkck5zM3NXVitoVHNBTUVCMUdQNmRmUWd3RjBGaU80ZWQzeVpyYll6T3lt?=
 =?utf-8?B?eVJ1ZFBaVlhOYThIc3RHYm05VXIxTkNoZzNIZ1Qwc0hlcFpKZFduVXMzdlhu?=
 =?utf-8?B?d2lMQnVSTnBDMVdmVWVSbFpjNUNBK2Y2YWNiZjVuZ1RldDdhY2JXMWVYd3F2?=
 =?utf-8?B?N3JWaUlFQWNHa3dDeUwvS05OZ0dqdXg2WHlPTVlZd09oZDFQYjVIS0V1dVdE?=
 =?utf-8?B?Sk9qY3VIRllnS3JRRDg0WnFYRERaRTVuclVNdHFPNTBkazdmM05PMXdZM0o4?=
 =?utf-8?B?cDVUMU1DSFg2aW90WFZOSjhjR2paMUUrc2w4R2hLK1dGNDJ1RWkrcVFFYVF4?=
 =?utf-8?B?Rm1hM1ptUVJ4MXFoMW81c1JnRUQvVDgvN21zUkJna1dqN3I1NUNNbE1lbXNm?=
 =?utf-8?B?QldQdDJTNFE4NzRDdlhiUUhBRmczZHBvUFhOSW5sRnVJYzR1eW1WZlFEbjIw?=
 =?utf-8?B?ZWFTSUNSMHhzWm5aQTJLODdGRVNHL0NVZ1hob0NvYWxuT2JiTndCOTdLUDZ2?=
 =?utf-8?B?MHhRN2pxeVM2TFdLNEUzREQyYmpFckJhcERQUUFZaGUzME1RNi9Ib3NoZ0NL?=
 =?utf-8?B?ekwzZTI1MkFRVldrWHZQWXNWTnB6WStDZVlyL1d6aGVHeEJEbUhtTHhrTFR5?=
 =?utf-8?B?T2RHM0ZITXhXbUVHNENXcFFURDJ3aVN4UzJPQmExcnIyVFZ1cjZTdVFGKzEz?=
 =?utf-8?B?RDNaK2VmejBvYnBQTmRTOGFqYXNpSTVDODFEMG5jWnJQVGVLVldYYnlrOEs1?=
 =?utf-8?Q?/gNVs7eLgA+M/fNpKC9oKaQ0j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c51f31f9-01a0-4d2e-666b-08dc0c8d074c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 18:51:43.3442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tYUp+paZ7yMrP+ARu30CJkHqfIPvtr8XUbrox1x6rAkN9OkUUp3zxcKyqwWwP7rB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4344


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

Ack will fix the documentation and tcm parsing as suggested.


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

