Return-Path: <linux-kernel+bounces-4131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0E881783A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE83328105C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9525A853;
	Mon, 18 Dec 2023 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Pco9Tm+R"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EC54878F;
	Mon, 18 Dec 2023 17:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjkfOPSaH4tVYpVAXiTbVCJ67XbU3GdhSeA80xuJLKtTaMnQXoXHns/bfrTHcNd6oGKGNMXOQnQxvFWwKMTL+Qj/W38ggs3Z1e26Nw/yMQVCEYv3jHFS0yfVUHk7FV0/tBoLLMzqt6EnOgpS29EBnGeKglvteWbxKktdyV9JFpdS3+CbTo8T/TZVcKo3cVfr/piD54Y2cU+FfDl85MRVfek7FXDkyZ9k8uIqdy3+pjsOqEBeDGzlJg1bd6PlrRnQAKxw7yhkEfsbj6qErYsJSdF/nqZg2o3QUYP0PnqLnQMFtwDyolCNJKvOfTClhJ96L6McC54/Fzue4mNdErzoyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpQ5R2JZyQiRf+sYy3rRC1JAfQnnWTEuv6Ru6XckuUI=;
 b=MjkbHwC0DgfbgQVPMeOYFmoTcB58B9Zbqs27ouC4nU8N3RRhlapD/+TgrTSFAVes1x0LAjDnQ4MeD9ge7XiImAsBlCQYjbLHwrZsoHjI/LgJ93Ou8Z5BO2oH3Ibe5CSGKXeISDCr760CVNxtQtrZBDpXaja8R2sw+fUCpU7IbKjINy9r9kiK211uqVgfEFbQrNPOfNCY3W8xR7/3PS6e3VUyR8RWL9Vf3cd4CO/8ATupi01LWDmqnBm2s3ztAvKCAK3fh7QXVIQDqqBzDhxsvC8jJa1SzG+X+iM99rHKjk7NbLIidd6EO9Vk0zOr8bckdvaapwgYCzTyJw8R73JjxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpQ5R2JZyQiRf+sYy3rRC1JAfQnnWTEuv6Ru6XckuUI=;
 b=Pco9Tm+RgNi8P6axOTfLoUysiF7ElzbuYODx0qrVji736KMoidcTNxfE32UdLoKXtQ62GWq0Py/3j5P5jLzAAaGKzCZt7xnMCBtcj7bREBJgJYFzly9i4Mrzl5CRURlTMtJKGKbCogDoOGSGx1t1LYD0R1DODkVoGTgd7zOAbQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by LV2PR12MB5895.namprd12.prod.outlook.com (2603:10b6:408:173::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 17:13:47 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::e2:9f06:b82e:9a0f]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::e2:9f06:b82e:9a0f%3]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 17:13:47 +0000
Message-ID: <b519a7e0-77a7-44b4-809b-caf96536fe1c@amd.com>
Date: Mon, 18 Dec 2023 11:13:44 -0600
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3] ACPI: APEI: Skip initialization of GHES_ASSIST structures
 for Machine Check Architecture
Content-Language: en-US
To: linux-acpi@vger.kernel.org
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
 tony.luck@intel.com, bp@alien8.de, linux-kernel@vger.kernel.org,
 yazen.ghannam@amd.com, Avadhut Naik <avadhut.naik@amd.com>
References: <20231204192549.1953029-1-avadhut.naik@amd.com>
From: Avadhut Naik <avadnaik@amd.com>
In-Reply-To: <20231204192549.1953029-1-avadhut.naik@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0036.namprd11.prod.outlook.com
 (2603:10b6:806:d0::11) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|LV2PR12MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: 9630d21d-3d76-4042-30d4-08dbffecb228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EQ9yv7fyWiRdGA227Ze0GDLfBfOnTcLZ7U14nxCfkLQeRJGWRG3XkX6230uL2DtIoa39MtjWu5CQFSw7lxFo1B8n8kR8Z5qddJ8zuGjxtGvRlM4pGhJT90EQfgC/w8lctBYMM0wkgcbrw362/2ZKzy+33Cvs6PCm0wOJbgs/avQZ5PtoZD99+3N0KQRRVLPQvXOtmhB0A1cpHwYHiVLnqjyBTalZrPdjlDKdQrsybMJM5wqU6K7rZ5+EIP30voBYkQOSwq+Nk0trfP0qh5UrDe8VSb9JFwFOXfIXMYp3cH5p0xF8at/H9y/qM994YtA7fD80kfHbb5R9wLaBQMzA5yRFiaj6pmwKlwPvfyrq2lhlpk2KOQbsjDot5XxK/lHnSA/7ZNLTxELdgCC8D4CCn7ydNym2oEmBDsXmA7ZO9SwufO8i8J9Pf+wXF7Yr7jeSb48fZtu7HhvTJHK48ezpp5OyB/SEG009I2RFwZQMiAtnORPlqosAB14ffFGkPKJ17CvA84FCobqaArJn6GxZumijgtJWz2OP3GIC14P6YBBa6ReQXfZTnmq6CNRS75sDuBquc3HFIFUQ0BnJxrP7f8LP4BL5qgbiQ32ltERKHWNWLs1xxrR41P929PMbkAsXcVjY4X/GlXJWwfvaST2pBA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(376002)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(31696002)(36756003)(38100700002)(83380400001)(26005)(53546011)(6486002)(478600001)(2616005)(2906002)(66556008)(66476007)(6916009)(6666004)(6512007)(6506007)(316002)(8676002)(8936002)(4326008)(5660300002)(41300700001)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eE5xcGtSNFRJSlhXc0tRbFV0UzBaaDFwc0Y2YlIvbFZkelROZEdCcEo3L2VI?=
 =?utf-8?B?MDJtbDNWdzFCcFFaZVZMdlhHVTZoYkJFNWNFNWVXZGFjL1BBZDJvY3VEUE52?=
 =?utf-8?B?Z0NybjVBS0k2NllBKzFCVlQyS08yMTRzTG9BSDdTTTdqYm5TMVZ1UkNtNkdQ?=
 =?utf-8?B?MVlrMGlBOTNrVVVBNUYwekFlRUU3YVMrcHVmQ3J4a0d4VFVBb1VnVFQyVDN3?=
 =?utf-8?B?N2hoTkRFb05pSm1zaFczenpLM2llanhJRmk5L0JXZFJweHVFYTVEbEtYT0Qv?=
 =?utf-8?B?dHlsMit6cGpXOFg5RUw2cGdpSzhHNXIzNThBSEwvZUpES0F2NlE0VlowWDQ3?=
 =?utf-8?B?TTEyenRZOEg3VEgzUGFlWk9Nam03RW1HeXArZGQwSG0wZmRkZXlwZjYwTThC?=
 =?utf-8?B?MmY0c0JCVG5wSkxIcEdxRXBKaGhjV3NsUzBaUDg0WjFNakhSQ1d3Qks1VzQz?=
 =?utf-8?B?bmhnNFdNaS92US9BM0kwdzlWZll3SGpQVTFnUExUZVduWDhLd25JQkVROW1i?=
 =?utf-8?B?R0kwdmtIa0xwaHhzU1BQY2ZEY1hyMlcyYVhMWS9ZSUtBeUVSVnhuTHlwRm8y?=
 =?utf-8?B?ai96UEVzRW9mdnZjM1UyTE9SL0V2dkdrMFRnNTlQNWhmazc0WUtpYjhkZmUr?=
 =?utf-8?B?WmtvNHd0clFNYXU2UkVndGt5aU5TTVpKbForRmQyWjNhdXRvd0hQd2tqRWJI?=
 =?utf-8?B?MUJrSGxJNThVRVdhNlVpMTh0Z1VlODdnUCtQVE5TVlUxVHA4My9IUjhJcnNE?=
 =?utf-8?B?dk5iY0lHbXI1N3B5am1IQWt5U2tZM0Y2NXRxQVB5TmpWSjZ5QlVieVhScUc1?=
 =?utf-8?B?djR0YmM1NU1QSjFsWGMxQTZqVTlIZUY5R05PQ0srK2t4c3F4TkNURGxPeWJH?=
 =?utf-8?B?V3lGWjJtbVVkQ2p1QzEvelJ0QU5lUGJuNEJTelcwMlhIM01ZQkZLS3hNbTd1?=
 =?utf-8?B?MERFQ3ExTnFxT0ZBblFiMXo4Y3l0RXRYckJyblp6RUg1MnpKQXd1NmJCZDQ3?=
 =?utf-8?B?ZXpOYjFJWGpabjdPRXVUNjV1cEtWQk5GZmFEU3lEcWZwbjNKQk1EcDVEQnlv?=
 =?utf-8?B?VVhvKzZDdTZsZVV4MXhLc2w3eWFxb096ZFlhWkl1SExOT1FxaVdGQVdjZVBh?=
 =?utf-8?B?WVhCNHV2NDc0M0I1RUFTOVdIV1BvRDk5SDM5MUg1ZmZZZUVzK2loWGIzNVBi?=
 =?utf-8?B?VVlDS3pKVGhHM3FlUWljTFFkVjFqQWlBYjVlcFU1d044Nlp0S1owWXFqWit4?=
 =?utf-8?B?UStzS0ZBclpyN1RQL0hVMGlHTkpGY1BXZ2x3Sjk3ZEdSMmxTVW4wTEpycnJj?=
 =?utf-8?B?ZURnMnhCQ2xBSUMzbmQ0WUJmT1BzcXdiWmVremJUMFE0bFBLZnJGbjRybUxw?=
 =?utf-8?B?bEtFWXVyLzdPakhWenMzVWFETk1YUFo4Q1JQSjQvTE56QWtMQnVhU2VLb0lH?=
 =?utf-8?B?bHRoQW85dHJrUDRnNS90ZHVwekJuTGh5NE9iaEtCa1hMZjVHNkFkRXcvall3?=
 =?utf-8?B?d1hXLyszREVYU2lyOHgxblozQ1NYQk9DaXQ5SVBLNDJsd0sycVZVUVIvQkRG?=
 =?utf-8?B?OTRLRDB1NVU5Z0FCYVBLQUFHQ0dnTzVQSC9UcEhXSllvanlabTRMcHFjbzRq?=
 =?utf-8?B?c3RPY1BhQ3hRNW5jMHhFZHVwN0phQjRGd3Y1aEl5UEVoWmFiOVpCRWRSaDEr?=
 =?utf-8?B?YzBBQmppOEtkNDFSVkZ0L1Z6UDZVZ2RTZERpZjV4cUNoY2ttRjFYVDg2R3hq?=
 =?utf-8?B?VSs5SDZNbkhOZEJDSWJXY0d1TmFVZlUvZG9JZjh2MU9Va2VSSG5SSDFESFN2?=
 =?utf-8?B?T1ZaN0tITkxZaWRROUh6ZnFMK254S3JJdHQ5RndyLzJGTGdCL0NUdjR2SUlZ?=
 =?utf-8?B?QjhyYmZQRGdlbzJzbis0V3NIT0J2dHVTZVQ3SFZBejB1SndUaEtqZ3NmYkNY?=
 =?utf-8?B?dWZQQkVtMDlGUGFZa3JpNWJodkl2S1IvbG5mUjg2UDJPTlovNHdTZ1hIcDZO?=
 =?utf-8?B?MGVsaWh1SHN3QUVIM1orQUIzZ1pFTSsrNkNGcFJObk8wcUV2YUx1d3c1Myt5?=
 =?utf-8?B?SkQ4WVRMMXJEVHF0NTdJUXpCbElFZ2cyN2Fyc3lPQVFGU2lwUzY1VmlGQS9W?=
 =?utf-8?Q?dRXWQinrmfP4Hy5RTtI5M7q4l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9630d21d-3d76-4042-30d4-08dbffecb228
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 17:13:47.0810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IALryiALEFI3r8ml1Z/woxOy+X2EDDn+edonrH7AHfO+Kzf2/ChmUo9fZFqy65hyZ3tsJcSy48ALjdqUfd/pdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5895

Hi,

Any further feedback on this patch?

On 12/4/2023 13:25, Avadhut Naik wrote:
> To support GHES_ASSIST on Machine Check Architecture (MCA) error sources,
> a set of GHES structures is provided by the system firmware for each MCA
> error source. Each of these sets consists of a GHES structure for each MCA
> bank on each logical CPU, with all structures of a set sharing a common
> Related Source ID, equal to the Source ID of one of the MCA error source
> structures.[1] On SOCs with large core counts, this typically equates to
> tens of thousands of GHES_ASSIST structures for MCA under
> "/sys/bus/platform/drivers/GHES".
> 
> Support for GHES_ASSIST however, hasn't been implemented in the kernel. As
> such, the information provided through these structures is not consumed by
> Linux. Moreover, these GHES_ASSIST structures for MCA, which are supposed
> to provide supplemental information in context of an error reported by
> hardware, are setup as independent error sources by the kernel during HEST
> initialization.
> 
> Additionally, if the Type field of the Notification structure, associated
> with these GHES_ASSIST structures for MCA, is set to Polled, the kernel
> sets up a timer for each individual structure. The duration of the timer
> is derived from the Poll Interval field of the Notification structure. On
> SOCs with high core counts, this will result in tens of thousands of
> timers expiring periodically causing unnecessary preemptions and wastage
> of CPU cycles. The problem will particularly intensify if Poll Interval
> duration is not sufficiently high.
> 
> Since GHES_ASSIST support is not present in kernel, skip initialization
> of GHES_ASSIST structures for MCA to eliminate their performance impact.
> 
> [1] ACPI specification 6.5, section 18.7
> 
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Changes in v2:
> 1.	Since is_ghes_assist_struct() returns if any of the conditions is hit
> if-else-if chain is redundant. Replace it with just if statements.
> 2.	Fix formatting errors.
> 3.	Add Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Changes in v3:
> 1. Modify structure (mces) comment, per Tony's recommendation, to better
> reflect the structure's usage.
> ---
>  drivers/acpi/apei/hest.c | 51 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
> index 6aef1ee5e1bd..20d757687e3d 100644
> --- a/drivers/acpi/apei/hest.c
> +++ b/drivers/acpi/apei/hest.c
> @@ -37,6 +37,20 @@ EXPORT_SYMBOL_GPL(hest_disable);
>  
>  static struct acpi_table_hest *__read_mostly hest_tab;
>  
> +/*
> + * Since GHES_ASSIST is not supported, skip initialization of GHES_ASSIST
> + * structures for MCA.
> + * During HEST parsing, detected MCA error sources are cached from early
> + * table entries so that the Flags and Source Id fields from these cached
> + * values are then referred to in later table entries to determine if the
> + * encountered GHES_ASSIST structure should be initialized.
> + */
> +static struct {
> +	struct acpi_hest_ia_corrected *cmc;
> +	struct acpi_hest_ia_machine_check *mc;
> +	struct acpi_hest_ia_deferred_check *dmc;
> +} mces;
> +
>  static const int hest_esrc_len_tab[ACPI_HEST_TYPE_RESERVED] = {
>  	[ACPI_HEST_TYPE_IA32_CHECK] = -1,	/* need further calculation */
>  	[ACPI_HEST_TYPE_IA32_CORRECTED_CHECK] = -1,
> @@ -70,22 +84,54 @@ static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
>  		cmc = (struct acpi_hest_ia_corrected *)hest_hdr;
>  		len = sizeof(*cmc) + cmc->num_hardware_banks *
>  			sizeof(struct acpi_hest_ia_error_bank);
> +		mces.cmc = cmc;
>  	} else if (hest_type == ACPI_HEST_TYPE_IA32_CHECK) {
>  		struct acpi_hest_ia_machine_check *mc;
>  		mc = (struct acpi_hest_ia_machine_check *)hest_hdr;
>  		len = sizeof(*mc) + mc->num_hardware_banks *
>  			sizeof(struct acpi_hest_ia_error_bank);
> +		mces.mc = mc;
>  	} else if (hest_type == ACPI_HEST_TYPE_IA32_DEFERRED_CHECK) {
>  		struct acpi_hest_ia_deferred_check *mc;
>  		mc = (struct acpi_hest_ia_deferred_check *)hest_hdr;
>  		len = sizeof(*mc) + mc->num_hardware_banks *
>  			sizeof(struct acpi_hest_ia_error_bank);
> +		mces.dmc = mc;
>  	}
>  	BUG_ON(len == -1);
>  
>  	return len;
>  };
>  
> +/*
> + * GHES and GHESv2 structures share the same format, starting from
> + * Source Id and ending in Error Status Block Length (inclusive).
> + */
> +static bool is_ghes_assist_struct(struct acpi_hest_header *hest_hdr)
> +{
> +	struct acpi_hest_generic *ghes;
> +	u16 related_source_id;
> +
> +	if (hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR &&
> +	    hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR_V2)
> +		return false;
> +
> +	ghes = (struct acpi_hest_generic *)hest_hdr;
> +	related_source_id = ghes->related_source_id;
> +
> +	if (mces.cmc && mces.cmc->flags & ACPI_HEST_GHES_ASSIST &&
> +	    related_source_id == mces.cmc->header.source_id)
> +		return true;
> +	if (mces.mc && mces.mc->flags & ACPI_HEST_GHES_ASSIST &&
> +	    related_source_id == mces.mc->header.source_id)
> +		return true;
> +	if (mces.dmc && mces.dmc->flags & ACPI_HEST_GHES_ASSIST &&
> +	    related_source_id == mces.dmc->header.source_id)
> +		return true;
> +
> +	return false;
> +}
> +
>  typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
>  
>  static int apei_hest_parse(apei_hest_func_t func, void *data)
> @@ -114,6 +160,11 @@ static int apei_hest_parse(apei_hest_func_t func, void *data)
>  			return -EINVAL;
>  		}
>  
> +		if (is_ghes_assist_struct(hest_hdr)) {
> +			hest_hdr = (void *)hest_hdr + len;
> +			continue;
> +		}
> +
>  		rc = func(hest_hdr, data);
>  		if (rc)
>  			return rc;
> 
> base-commit: 629a3b49f3f957e975253c54846090b8d5ed2e9b

-- 
Thanks,
Avadhut Naik

