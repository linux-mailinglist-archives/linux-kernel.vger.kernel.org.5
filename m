Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1AB7BB2D8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 10:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjJFILr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 04:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjJFILp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 04:11:45 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2072.outbound.protection.outlook.com [40.107.7.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695D8CA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 01:11:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTp3eT9zffctvdNh4J0Fyr8b8J9nidGG/98mVbdOFfWijRILNozkO6ZDG0GRcTgGW2p8hr+fY0Be0PmQbStJ8euEh2D8wQw6krHprJ/ZnRK4hT1o8HO8w0tXjOKCnsaJ6B/FCxQ8RTU/5vtg15MVxCXFd0Kh5RpICIJlhA0Bzyd6gDyhNiocmlgLaoAmUkcml7SpBYiO/Sz9WHFlJVBDAxMtfRpyPyr4NTVzYRCJDjwhBXvNBqRQHOYp/ePgNi1oms0KyTO1MDBB5yLTXKhmr3lUsP7fMYStA2TXikLzQc3OmOPOZCgl66X57T+mKAcJ8bCRa2YrdtW5fTig+PLV7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42wamGnd2DBv+kd21s4WKmNoTHyjZWUxafekWqRuhOA=;
 b=YotfxmW9zX65ksFtFOEmy3RS4w5U/YrPcW16HWHhBSQ3Vao4Zh0r5wmmQtWmCEkaMswzlYUERR/LcXFdO22nJKFdN0trLCauPLdg0NQzt23hoUS7UAmEB0ZdP8vYRIgv1g8nHCR9hnqK69r5DvQCzTrPloaZISAlC96OQ6lVYV8SuG9X+6kciTm1PrTxyR5NEE0AXlJPKulBlt4D03Fxgksrt1w7HiOO1zAxl1yd3ImXkx7BT/GPZCe+cNF1/g62W2qgGSYAdNfZ7RbKAEoINmqU+79OHVKp7lI76roepAmvfQo9dG9MHlVmGF4IRTJX1EH8PyTCSeXk+yH28bEiSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42wamGnd2DBv+kd21s4WKmNoTHyjZWUxafekWqRuhOA=;
 b=302sOy5V92lxO+M2wkS9s9peEB5oTV9HxffcgMOKF1HunD0t5Gx9NgraMfx2MZag+9R/OAn2yXNFxpIcZrlAB5K5Ky3RYlwAJjT4mnpJ0HvM5ZQMBZqC8RyY0+gf32ElyDO3RoRxz8vLJzCT5xYa9B/r9v3x3Qviswntj07gTNjfOZj12WbLFG0rLGNv6KSeewQI7rfEtY6afgBbTNwj0cD/D0EVWlv54BLbNBp3D1sBVxQ+ITVjwRo8Wh0mwDzm9b8ILlm3TEDcrqi7XhAj3oW7kvzfwWgHVkVC4e+SM+UgyqL6zsMqlMY60TZQ7bO3lom+wnO0NLwWaUwRH6PNRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by VI1PR04MB6847.eurprd04.prod.outlook.com (2603:10a6:803:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 6 Oct
 2023 08:11:39 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::edd3:f00:3088:6e61]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::edd3:f00:3088:6e61%4]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 08:11:37 +0000
Message-ID: <2b222a2a-f749-46e8-8489-b590dc2061cb@suse.com>
Date:   Fri, 6 Oct 2023 11:11:34 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] x86/tdx: Dump TDX version During the TD Bootup
Content-Language: en-US
To:     Yi Sun <yi.sun@intel.com>, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, peterz@infradead.org,
        x86@kernel.org
Cc:     kirill.shutemov@linux.intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, kai.huang@intel.com,
        linux-kernel@vger.kernel.org, heng.su@intel.com,
        yi.sun@linux.intel.com, Dongcheng Yan <dongcheng.yan@intel.com>
References: <20231006062855.875631-1-yi.sun@intel.com>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20231006062855.875631-1-yi.sun@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR2P278CA0036.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::14) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|VI1PR04MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f89b082-c102-425e-e6cb-08dbc643dcef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OyqViW/7SQYWOxOSAs3Kng1Dd0Rzq5wQgVRFsFhxyObeF1E+FJh7PkWGZYR8yJ2WxedVEq/VUGRBwRFK9sDi3l1BIGv17F7wtykLP+PkDFDrJu+aQT3GqTuy3CFN7ExBCPyLLjufUjGFLY0ybWzXf8ohBWdw32LfALQ0kGt8VujVAu3mBevhxFmqCq6Ylx7eMisUcMUrESKqC3vaFOfOBlbwmePhrBUoIgpAZttqFLzYxPm55BejsbFNG9AFOFwkRFv3uwQ6mCKQm71B7wvNoddxeOBmLEo23xDLLVcwzSQq60onZDgT+ompcggopRYKGDt9lDogQc6FxixF2D5bTAFucq9yR3B+ZJyCjXUULcfQOSkBruwUWucZXy9KpnV+M1iGaTzTY8v/DgEF5bDmayuERlL8Nbr5tFCgzgux9snx6Q2U6FYMuQCaCqiuF7xKAuIUVuavabgNrnpYt7BzG3Ossm5VisnZh2rit6CVGFbCsiPVo/F3EMEHagzC34maid4tB1vw+0YI64XjfB14Q/MXoFAgrPuuKye5b8nRIqFMqDluOdQ4Y4L7fY5OR8PTTMlp1tsjDCfm7VBtl8ZkGPEpQxaSV4Yo77RTRJ5TQ9Pwjzb5Hxv0DG4ibQE18b8QE8Ma6u7IxxLa8uma3m9EsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(66556008)(41300700001)(31686004)(6506007)(8936002)(31696002)(7416002)(5660300002)(2906002)(4326008)(6512007)(86362001)(36756003)(83380400001)(8676002)(316002)(6486002)(2616005)(66946007)(6666004)(478600001)(38100700002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzlaMGEvMGU5V0w2M2RwZmRmVTFmWnY0WS9yODFJQzVLNko4SmNkbG1kd3Qy?=
 =?utf-8?B?VnpScUhTQ0RqRld2OEp5UzQzNytlclFoNUpQZ1VOeWJHTWhxcjV6NkI1ZmVv?=
 =?utf-8?B?eVdhdmdRelZ0Vmc5RE9DQ2wzODVsZ3hraExEcEhsM2pFRmREM3lMSk1RTWQ5?=
 =?utf-8?B?dUJ1L0YwU1YxZVRyaHE2ZFl5K1RhOFVwVHNUT0NXUG5MZjJLOXlYRFFYcnZk?=
 =?utf-8?B?V1BUTlY0VUR1OERzaEtCWFN0RlMwdC9NeWtxV3ZhUlBBZ2NyZEVFRVJRR2cr?=
 =?utf-8?B?RVViSk9SL3dlRmxhS05tWUlxUzk0ZG1kNzJRRE5OR3AzRW5ZUm1lNzJLZVJ5?=
 =?utf-8?B?cGYzd2kyRitJL0pHMXNFY2d0ZkZTRXZ5QzNwbjVLZ1FydS9RTDVSQThGMDVz?=
 =?utf-8?B?M1kwSjRTUndSTFhNMGtxTXN3WGkreHhEVXV4eDkrK3lrZFQyTHhVVk9ETk1h?=
 =?utf-8?B?MGR5T1Z4VTJ1R0RtKytYdkxaSjBiRFlTVzhxWm4vWFJRVEE5VDFVRGU0amFP?=
 =?utf-8?B?MDFyZys1Yms5c1p2MnhCWDNoZFpqVU9ZRGdmRzZ6L0NsOUVyUGFSL1RSekQ2?=
 =?utf-8?B?Z2U4U0xXWXFrU05lV3J5MGFZMlZhZGovSTBuYWRlOXBwTmhGM21wNXFzNzhW?=
 =?utf-8?B?S3pqbjRZWFl6N2srZ1RRcCtiNURxeFRFTUxVSFlWTWU5MlRtWUR6WnlRMGdi?=
 =?utf-8?B?WHVhRi9NSTk4ajU2WDBmc1B3d1AwL0dTSm1aOEJWR1BPUWhMdDQwcmJ2UXhk?=
 =?utf-8?B?aGp0anpGQ1dsS1dENkRzTGErN1FWSGR4RXJ6Y3JqT0hWa3FRUUp2Ti82clJ2?=
 =?utf-8?B?V3ZIL05XaTlrYitRY0RXUlI5Um5EQWxLdTlZTDdTTmRjeEtXR3RyL0hYbXpl?=
 =?utf-8?B?N1pPQUJZWDhOY1UvQW5tUXhnU0NTak5NcDRlbUtzOFpWdi9Tc1luTlkzdlFl?=
 =?utf-8?B?UHZUL0NPaVJBOGlkK2ZHZGZWZ0l3d0FDMHJGeC9zdkZ2cGtocDJzZ2JzbUY5?=
 =?utf-8?B?b0txQUI3WFlyQzlZZW10dVBwRTJQNkh2ci9hWElkdHI5c1N1NWFFa2w2WjZF?=
 =?utf-8?B?YWN1Qi80eDhMdWZzTVlCdDFEQ3IwUVduZlVZRTIzMWtCTnFUUFIxSHkzdklM?=
 =?utf-8?B?TnJtYUJiNWxPdEF6ZTF3QXBCSVJHUHVDT090UG1WZkRManI5LzFnQm1qVDR1?=
 =?utf-8?B?RmQ5S3NLdVZRWlJUZ2ZYVmFBaUJXZmI5Q3FhYm9sS1ZDK0tzaFRzbEdwL1o0?=
 =?utf-8?B?K3pxOXR6UDc3RFZSbmxyUkpzM3pKUTJhQzRCTjN0Z0JUOXdseWRiTlBlV0pz?=
 =?utf-8?B?YkdEVTlVZE11ZG9SVGNObUpEV0F5U043dXB3SHhwb2ozMGg2WTh3WUQwY3pv?=
 =?utf-8?B?b2lPYnh6b08vS3krNklwbmZORkdLNWVvMjlTMFM5QlJ6V3hoMEdsaUZSMzUv?=
 =?utf-8?B?QnJSc2xENS9jZk9YRXdjWVVLTmx1c3BJTmJvSlJoWU1ZbjhKZ3hKQlBMcG8x?=
 =?utf-8?B?eXFsajRYaHpleEJGZkhZUjNNNGlObm1GYjlsQ0htVHNRZDhkWVBGWVUzbk5a?=
 =?utf-8?B?MU5SdXMzTjZMb3hYdFhNNXdUVkM2bDdaTDUvSEhMM0dERlpSNjVtaWxEZlRE?=
 =?utf-8?B?SDlPS2ViTVAzTW1JZ2ZqMVhBRlYzWjBGQ3l3UEkyS3lCVlBxVExkdDQ3cW9N?=
 =?utf-8?B?Vm1hZ2dnOWc1UFpMTTIrSmVkek1udTN4ODU2ZXc5OWZNcEFSSGlBUWJsMnc3?=
 =?utf-8?B?SlFjUnB0bmcwRTNBaUQweGIvWjNqdVh3RG1VM0Jua1JLVVRlSVk4Uk9KRE9q?=
 =?utf-8?B?SWg1dDF5YVg1citrd29xeTVQNW1ZRzVuZXFGR3dwQzE2TGFiZ2t1NGU2ZHRZ?=
 =?utf-8?B?UHlTSkp1c3pTdG5reTJpNVJvUitVK0dZelZranA4M0lmUXkzaHRXYkhWVk13?=
 =?utf-8?B?RjAzZkRvM043VmlwVmFSR2MxR2oxYlp0RXFsQ3NiUFY0V05wQTBUTWcyMjkw?=
 =?utf-8?B?Q0F3KzdYR3p2ZVUvQkNwdkZZbEhXZVQ2Tzl2Y3JOUE1GSlkvQ2NYb3RKOFpo?=
 =?utf-8?B?dTJsSmI5RHJIQzk4R0JYV1N2VzBIRjg3TXUwQXFGWkYwd0w1ZGI4WlF0RmlY?=
 =?utf-8?B?WnJSY0h6d2phNGIrM0lFRFJMY1VLSVQvWlpaZjRJTmRKa2NJbFN0MU41dmNV?=
 =?utf-8?Q?VuBLpqXhJbE/mg+BW4592dqWOPytUS53Hm8dSG3ETGN3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f89b082-c102-425e-e6cb-08dbc643dcef
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 08:11:37.7368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWiK/1WRSVQa9a9EAMMBsoZ0t43vX20sL4Db0twEuY8O1KbRm6skuzcENJ+kbwpQUhAR4pMATQCelXtvoOa6mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6847
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6.10.23 г. 9:28 ч., Yi Sun wrote:
> It is essential for TD users to be aware of the vendor and version of
> the current TDX. Additionally, they can reference the TDX version when
> reporting bugs or issues.
> 
> Furthermore, the applications or device drivers running in TD can achieve
> enhanced reliability and flexibility by following the TDX Module ABI
> specification, because there are significant differences between different
> versions of TDX, as mentioned in the "Intel® TDX Module Incompatibilities
> between v1.0 and v1.5" reference. Here are a few examples:
> 
> MSR Name		Index		Reason
> ----------------------------------------------
> IA32_UARCH_MISC_CTL	0x1B01		From v1.5
> IA32_ARCH_CAPABILITIES	0x010A		Changed in v1.5
> IA32_TSX_CTRL		0x0122		Changed in v1.5
> 
> CPUID Leaf	Sub-leaf	Reason
> ---------------------------------------
> 0x7		2		From v1.5
> 0x22		0		From v1.5
> 0x23		0~3		From v1.5
> 0x80000007	0		From v1.5
> 
> During TD initialization, the TDX version info can be obtained by calling
> TDG.SYS.RD. This will fetch the current version of TDX, including the major
> and minor version numbers and vendor ID.
> 
> The TDCALL TDG.SYS.RD originates from TDX version 1.5. If the error
> TDCALL_INVALID_OPERAND occurs, it should be treated as TDX version 1.0.
> 
> If the __tdcall_ret fails, expect a zero value for all tdx sys info.
> No additional error code is necessary to avoid introducing noise during
> the bootup.
> 
> Co-developed-by: Dongcheng Yan <dongcheng.yan@intel.com>
> Signed-off-by: Dongcheng Yan <dongcheng.yan@intel.com>
> Signed-off-by: Yi Sun <yi.sun@intel.com>
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 3e6dbd2199cf..991f7dc695bd 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -37,6 +37,24 @@
>   
>   #define TDREPORT_SUBTYPE_0	0
>   
> +/*
> + * TDX metadata base field id, used by TDCALL TDG.SYS.RD
> + * See TDX ABI Spec section 3.3.2.3 Global Metadata Fields
> + */
> +#define TDX_SYS_VENDOR_ID_FID		0x0800000200000000ULL
> +#define TDX_SYS_MINOR_FID		0x0800000100000003ULL
> +#define TDX_SYS_MAJOR_FID		0x0800000100000004ULL
> +#define TDX_VENDOR_INTEL		0x8086
> +
> +/*
> + * The global-scope metadata field via TDG.SYS.RD TDCALL
> + */
> +struct tdg_sys_info {
> +	u32 vendor_id;
> +	u16 major_version;
> +	u16 minor_version;
> +};
> +
>   /* Called from __tdx_hypercall() for unrecoverable failure */
>   noinstr void __noreturn __tdx_hypercall_failed(void)
>   {
> @@ -800,6 +818,60 @@ static bool tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
>   	return true;
>   }
>   
> +/*
> + * Parse the tdx module version info from the global-scope metadata fields.
> + *
> + * Refer to Intel TDX Application Binary Interface (ABI) section
> + * "TDG.SYS.RD".
> + */
> +static void tdg_get_sysinfo(struct tdg_sys_info *td_sys)
> +{
> +	u64 ret;
> +	struct tdx_module_args args = {
> +		.rdx = TDX_SYS_VENDOR_ID_FID,
> +	};
> +
> +	if (!td_sys)
> +		return;
> +
> +	memset(td_sys, 0, sizeof(struct tdg_sys_info));

So in case of an error this function would effectively zero out 
tdg_sys_info and not explicitly mention that something went wrong. Dunno 
how sensible or likely it is to get an error while requesting the ID_FID 
? Also why don't you check for errors on subsequent calls to TDG.SYS.RD ?

> +
> +	/*
> +	 * TDCALL leaf TDX_SYS_RD
> +	 * Input Field Identifier via RDX and get the output via R8.
> +	 */
> +	ret = __tdcall_ret(TDX_SYS_RD, &args);
> +	/*
> +	 * The TDCALL TDG.SYS.RD originates from TDX version 1.5.
> +	 * Treat TDCALL_INVALID_OPERAND error as TDX version 1.0.
> +	 * If other errors occur, return with zero td_sys.
> +	 */
> +	if (TDCALL_RETURN_CODE(ret) == TDCALL_INVALID_OPERAND)
> +		goto version_1_0;
> +	else if (ret)
> +		return;
> +
> +	td_sys->vendor_id = (u32)args.r8;
> +
> +	args.rdx = TDX_SYS_MAJOR_FID;
> +	__tdcall_ret(TDX_SYS_RD, &args);
> +
> +	td_sys->major_version = (u16)args.r8;
> +
> +	args.rdx = TDX_SYS_MINOR_FID;
> +	__tdcall_ret(TDX_SYS_RD, &args);
> +
> +	td_sys->minor_version = (u16)args.r8;
> +
> +	return;
> +
> +	/* TDX 1.0 does not have the TDCALL TDG.SYS.RD */
> +version_1_0:
> +	td_sys->vendor_id = TDX_VENDOR_INTEL;
> +	td_sys->major_version = 1;
> +	td_sys->minor_version = 0;
> +}
> +
>   void __init tdx_early_init(void)
>   {
>   	struct tdx_module_args args = {
> @@ -808,6 +880,7 @@ void __init tdx_early_init(void)
>   	};
>   	u64 cc_mask;
>   	u32 eax, sig[3];
> +	struct tdg_sys_info td_sys_info;
>   
>   	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2],  &sig[1]);
>   
> @@ -867,5 +940,9 @@ void __init tdx_early_init(void)
>   	 */
>   	x86_cpuinit.parallel_bringup = false;
>   
> -	pr_info("Guest detected\n");
> +	tdg_get_sysinfo(&td_sys_info);
> +
> +	pr_info("Guest detected. TDX version:%u.%u VendorID: %x\n",
> +		td_sys_info.major_version, td_sys_info.minor_version,
> +		td_sys_info.vendor_id);
>   }
> diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
> index f74695dea217..d326509832e6 100644
> --- a/arch/x86/include/asm/shared/tdx.h
> +++ b/arch/x86/include/asm/shared/tdx.h
> @@ -17,6 +17,7 @@
>   #define TDG_MR_REPORT			4
>   #define TDG_MEM_PAGE_ACCEPT		6
>   #define TDG_VM_WR			8
> +#define TDX_SYS_RD			11
>   
>   /* TDCS fields. To be used by TDG.VM.WR and TDG.VM.RD module calls */
>   #define TDCS_NOTIFY_ENABLES		0x9100000000000010
