Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387417DF3C2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 14:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376471AbjKBN2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 09:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376414AbjKBN22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 09:28:28 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A0DD7;
        Thu,  2 Nov 2023 06:28:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFzWcgYKpPsyw+tKOSDJn+7krVD0/hHBNn42z1dhQTmoLELZkBJ/3Bz1ttjmSpc5STuOTEHjCBIJwRlU3GXZ4HPnrJWRodTb8Svp+My6NalzP9MB/qzbyv0aVDK6IZXEVQZzVnUD6xO9qkofSLlmm4ELtty4QJ7qXlgAbZBVp/UBE5XDk3xASlbXKS/izzjjAkLyGbgWoKBq7y7X/blYCzvAhCl2pEQQ5SEuLFMMyA/DxxOlK8bI5d9vgAGkTlpca4JFuHRDVjoT+dPsGwrKPqUkqKTKULGKFjDkEwj/VZRbiNkWic+IsLS0pi/z4rergqxA0SDk0Pl/4mbfN7c7FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVGlFMtO/oQJs9/CHsGlVEGXqiilM0rsVdh7xnjhylE=;
 b=IUfBMqn85CHfjxHuYsNmbpn4PVvfsZLIcrdlZWDbUbI042BeZgW5Zy0e+u7sUc2AoAr0lKW23FHYgSt/kZS53UMiWvOydeNgMJsW1HP+0ASTjvvBO4N/ajOHFOWOOg/gXrfnV6FljUb2VjnRIEfjsXL0W9TidGpCqe4XmxKZIqumMPnyBGGVclPKWfWveNHsGs2GooalfkxR5pVaTYqSIaR7hSz9IIJY1m8s2g+/0X01SHj8QWc+o1zQ4/dsF+2QHN20PPNru0pqYeGADcsMuAC/ztU+Yr6q89cPTPQRd3+/B8WpAQJUmJ7tKMEgURzdydeoMeumjEWbEs3d1BnTEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVGlFMtO/oQJs9/CHsGlVEGXqiilM0rsVdh7xnjhylE=;
 b=DfrLMU/YxABXcGLmgkBHNg/MvLy07vODcGHs+hyGkmTOxQ1F5BNXItUFcDcoK9f7w3LQRm1Z/g+id/QnOwZvZ9tV7OmT4SAea959WblQiWriDUo3RUhyLSx+HXsvm0FpRyuIzgGg8fp+9k/Vhagbfpcuf6w8bd/0OlUkqUcN3m8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BN9PR12MB5130.namprd12.prod.outlook.com (2603:10b6:408:137::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 13:28:20 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.6933.024; Thu, 2 Nov 2023
 13:28:19 +0000
Message-ID: <9cca73d6-9089-4a0f-af8d-fac2ca8cd30b@amd.com>
Date:   Thu, 2 Nov 2023 08:28:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] platform/x86/intel/wmi: thunderbolt: Use bus-based
 WMI interface
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, jithu.joseph@intel.com,
        maurice.ma@intel.com, hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231102042959.11816-1-W_Armin@gmx.de>
 <20231102042959.11816-4-W_Armin@gmx.de>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231102042959.11816-4-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0031.namprd05.prod.outlook.com (2603:10b6:8:2f::6)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BN9PR12MB5130:EE_
X-MS-Office365-Filtering-Correlation-Id: 551397f8-3bd9-4519-bba9-08dbdba79442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lPDBoXNoU/6n9l5r5GBhEsitwIL+b20XZQdPgLvS3MpHpkfvQYobY7Dvr+lJk3bNsAL9H7PM4G9ZL3pJ9xFqmlBbTiDbguLI7suVG/3WO/mqGoa1PNaAHe9qAuAhhPBnVJ5PJ7kphE9owG72I2Xy1Kkj7rpMcKjtRre3qTzeYT+ixypwdvOjCvpcS60pyyvXJGpHiYM28KLJtQcwALGL+AW1wP2e749Bnep+X9NjZKCQN6M/+LySQ+/wXADYycq5ljCeZV2H/ZDeFS72Hj8mGp3ebi7bSn2mRX6J4wRuNfoSMwy8r1tS0go0+cb4QzXgJzCPdTlPzQUmYJa7XRPZKVM7hoAU46I7iMC7Bi3VAiWzCjuDzpe7Zje+oXazI8rq5o00EfhDCSAv8kcRjFtSbhSC6dIC98o/lCqTOkOUrqwrbU5CmH+nY6XSTLblsvYMFcynv6Rp/C4LxpF3OFsXR87P9kqOvfnE2YlV4oULV4KG+/pBDq3049UfxFpNbGiYoqyT8QESyqvQiGF1Nixy0752CBZEEGUHboTeDEwpPjQUeArWy9nzDsasUCMlRw18THTvvg4VX9PfowRp0475PBVKn45Q5cf+tt1tfP8ndcEoDH0klVrTjUTDMGgSkrsQoLIzY80zyp2bYJiMwyaCSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(39860400002)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(2906002)(6486002)(478600001)(36756003)(2616005)(26005)(41300700001)(38100700002)(31696002)(86362001)(83380400001)(53546011)(6506007)(6512007)(316002)(66946007)(66476007)(66556008)(44832011)(5660300002)(8676002)(4326008)(8936002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2JpcmZ1bmd4WGl6VVQ2c1kvZ2l6TTBMUzh5NFdXVjI5enI3SG9zRzhaaDla?=
 =?utf-8?B?NVpxMjJYWFNJR29Fd3JPT2RQeXVmYVVsSm1JNkZQRUp1dzg2WUI1K2psY0Jt?=
 =?utf-8?B?ckZDa1NmUnVFcmhRSXVWVlpiUlBnandNV3YrTWQwZUNBQ2ZOVTJnYUlwdFBk?=
 =?utf-8?B?YlBSVUtPWmVIOWdxcnh3T2ZXS1llTGRyUDBXNGZNa213TDFNNWZWamFxZ2Jo?=
 =?utf-8?B?L1gzTmZrOGhGSU4zYnB2andWN08zaEdMNm5GS0graWtWUTduSFgyTURJQTUr?=
 =?utf-8?B?UitYb2RiVkFqSHlEMWNqOHZLRDFYTWhyUEorZ0luN2J0Vyt3Qmp3a1V5U1M5?=
 =?utf-8?B?NytyekxrRkNkZE5vVWFVY1E2RGlpQ1A2Y0I5eTBVdG93MEtDVFBMMjA0dkFV?=
 =?utf-8?B?SENOTU9hN3R3TlBGZkNjUXRhMWhRTitQeldPZTlUQ2svb09sSXZiRS9EUjA5?=
 =?utf-8?B?Z0ZrVkVPMmtjblZoQms3c3BSTysxeml1YzZMd3c4UldLUXl3M0lVSGd1NWNn?=
 =?utf-8?B?Wms4ZG1jSTFLMnBTdGZlUWFiY29SSXFrMWRXaFBDNm9kcmU5blNBNnBHQU9i?=
 =?utf-8?B?Z1ByRnlCbVh4a3RCUU0xTE12K1hYNlBPY2dvUmJBWlg5ZWkwRTI1T2Y4bEVP?=
 =?utf-8?B?bXlFS2FNU0E3WHp5Y1JnWXd4cVpxdEhpODY5czJlM3NVNjBpQUYwM3diY3Yv?=
 =?utf-8?B?V2FlZ1drMjhkallMZDZKZzVBZXNaeVNDU2xDVzVtUExvUWpoM2tsdjZFL2I5?=
 =?utf-8?B?Ykg0d0tKays3cXRWcVFlKzJZMlhKZzUzOXkzMktoKzJTd2pkb2J1N1ZOR0ZN?=
 =?utf-8?B?c1RpemhXQ3QyVkxEWW9LRUczRDhRZGRDQ0lNalhZU0dGendReGtoaUpQRk9v?=
 =?utf-8?B?MGlVYXdtMEhycE1GWkpZYnhxMFFsNEErTkxZVEJaaERYcHVCY2pUOXVhWnU1?=
 =?utf-8?B?V1NPc2w0ZUwzcGhQQ3lnWTRJMG4renlFVUtocEFmb3JTVEIvMW94eHk1cVND?=
 =?utf-8?B?Wm5xODdNaU1VQlU3UmF5czQzL0tUeXZHOS96WFdUOWNMaXczUDZwRXltVE1Y?=
 =?utf-8?B?TU45MjcweWZPdWdTa1VURldrYmdEREs2dU1mbCtjWjRHY0VuRkgxTVlCUzdC?=
 =?utf-8?B?anFSRFJXMHVBUFZGcjNtS3NITnZFWGdlNkgxZElnbERibDVYWjdwSTVXVERK?=
 =?utf-8?B?RFpUNGtIUzhEMUV0L3hqdzJSazBFUEVDZUc5L2lMSU12WTUvTzBualYxbHhX?=
 =?utf-8?B?MzM3UHJuNTFxZk5nSHBQTHRHZGRieGI2aHFPTmtYbnVVMVMxTXhjMzJQUTJ1?=
 =?utf-8?B?NGR0OGJWV1BLbVRDZSsxREVDZW1yZTlDRXh6Zmt0R3YzcjZZclpyQ2xDaG50?=
 =?utf-8?B?R0JjODQ0bWxQc1dKeFdqNjFqbjRZKzgwa09XNm1LVitKTThMTnlFMEpCMHZt?=
 =?utf-8?B?eDBWQlgxNGhvc3VUQ1ZtczFObE1TOGJsRGhob2JnbnEwWXZSTUhOQWQwaDRp?=
 =?utf-8?B?WTh6QVdVR2lwOHJySjZpSjlhYmVGTE84eDMyb004RFdnNHZzUXBvZklkTThW?=
 =?utf-8?B?eTVoN096WkJpWjJ6Zk9aWHJjWUN2UVo3aThKaVRjbjh2eHlNd3BIZjNHYzVo?=
 =?utf-8?B?QkozdXFFRjN3L0p1b0ZjVDQ4bWo4dm5QajFURnZPZCtBRndxV3lVQk95UEpZ?=
 =?utf-8?B?VWxBYW1WMGVWM1p0aGJyaG45TUo3WFpTR2JCZ2lTSVliekFWa0N1eWFXSldv?=
 =?utf-8?B?MVV4dW54Y3JDS3haVEJQTURJOFgvZnpwLzBEa3BRWjFUbjJNTFBGKzZIaDJy?=
 =?utf-8?B?MWU1YUo3SitiYmp0ZFNGUlVnMTFpYUN3OTlndnVCWUxTa05xV1NrS2VYMmpF?=
 =?utf-8?B?OEFsdEZFOS9iRzlienI0eUFkNEZiczBGWFNwQ3haM3ZwT2h6dG1iQUpJbGxu?=
 =?utf-8?B?TXBNRE84V2dQWjlsa3pkdHlNSGVwY0c0eUFqcy91bHYxbDRNNjlOZGJxSmlT?=
 =?utf-8?B?YXpkc242VTRGc2VOSldCaHc4cklrLzBiVEFEa1ZBekNoVUt2SHNxdVhBbmRM?=
 =?utf-8?B?eGo3amMvcnlGQzNWVVlkUitQS2FNbUtDZmIxeVV5WjduNDdpWXRQNHhweVd6?=
 =?utf-8?Q?PsqhZrLwP2hgyd9ErCc3Nxsif?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 551397f8-3bd9-4519-bba9-08dbdba79442
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 13:28:19.8381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJy1cjzwx5rlIbz3oDy2Lwzls1Sb3G7Erq1Oyuocm4x9PZt2jkgKdklxYXDTeA6S1A24BqhbeAXU0S4Z259fjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5130
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/2023 23:29, Armin Wolf wrote:
> Currently, the driver still uses the legacy GUID-based interface
> to invoke WMI methods. Use the modern bus-based interface instead.
> 
> Tested on a Lenovo E51-80.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>   drivers/platform/x86/intel/wmi/thunderbolt.c | 3 +--
>   drivers/platform/x86/wmi.c                   | 1 +
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/wmi/thunderbolt.c b/drivers/platform/x86/intel/wmi/thunderbolt.c
> index fc333ff82d1e..e2ad3f46f356 100644
> --- a/drivers/platform/x86/intel/wmi/thunderbolt.c
> +++ b/drivers/platform/x86/intel/wmi/thunderbolt.c
> @@ -32,8 +32,7 @@ static ssize_t force_power_store(struct device *dev,
>   	mode = hex_to_bin(buf[0]);
>   	dev_dbg(dev, "force_power: storing %#x\n", mode);
>   	if (mode == 0 || mode == 1) {
> -		status = wmi_evaluate_method(INTEL_WMI_THUNDERBOLT_GUID, 0, 1,
> -					     &input, NULL);
> +		status = wmidev_evaluate_method(to_wmi_device(dev), 0, 1, &input, NULL);
>   		if (ACPI_FAILURE(status)) {
>   			dev_dbg(dev, "force_power: failed to evaluate ACPI method\n");
>   			return -ENODEV;
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 4c4effc883ae..58e7d5d535ba 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -107,6 +107,7 @@ static const char * const allow_duplicates[] = {
>   	"05901221-D566-11D1-B2F0-00A0C9062910",	/* wmi-bmof */
>   	"8A42EA14-4F2A-FD45-6422-0087F7A7E608",	/* dell-wmi-ddv */
>   	"44FADEB1-B204-40F2-8581-394BBDC1B651",	/* intel-wmi-sbl-fw-update */
> +	"86CCFD48-205E-4A77-9C48-2021CBEDE341",	/* intel-wmi-thunderbold */

s/thunderbold/thunderbolt/

>   	NULL
>   };
> 
> --
> 2.39.2
> 

