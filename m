Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49FA75F2FB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjGXKYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbjGXKWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:22:21 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328965FFA;
        Mon, 24 Jul 2023 03:15:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idWPm+Mik/wKDvJQqtMmzo/mVLrPnZJj8Wco3OrtbvRExNwS8nh2OJzj8te07nZKCWB8esRLuPOiW2OlWTBIcHUdP55xhqLTTTpDD3GXfE4cZ3NjgalPQ1AG7hdT4iVW19Ur8CfM0EnbPf+sKOG/43kig5pW0pjK6eyHIFOPUt4n8x2YS3MAM3FOdPQytGU6FkSDxOmXHe963yL10BaqPqXwTpqsjBJcI0ZX8bQFeJyyCXcmlrZ2Wg8OZgoyqVQYjkwpUlZIwrJwNF+q4nfjcup35gON/jP+CJgjPnzkIgpavrYytxrPXUwxr32b/ss2hm3C6FyicXoVzlpPZip8gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onu138zrTNg/wayi/BJ5fRStsXZomHj7RrT8tcgbJpU=;
 b=h4Jgpe6fB8NXBHe+wAIFsmPNxPWDEB1ww4HYGhka8JkDplZy+8a9ZNBfLRa2/KMJbGM9BTt95YVtr5trLODlnjCccTz2Uiw/Q4NfQF1/fsconxy1hKI/1Ncgqcbu+JbwFSzvpenPPQYWrNTc4Pcd0sA1HDMbNUYg65wM8A9/wBwTgN0xPGhFvGRRwtfv4c5BzMfBQnYdsUTaoSvU9g+biGd1qxuNh0g20jYeOD5MnaBT9XR9TFsVytHGC/Df1E5gWghB8yo6qu+pLDK5Jdm0Z11WEm1eYer+0sPC/NHGNxWCB4gACGZ6AjVMSoErR4TiB+/HaakqDcMxJDGnNAmcMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onu138zrTNg/wayi/BJ5fRStsXZomHj7RrT8tcgbJpU=;
 b=hMR8Z0+OVtgEaB7xSss768nnDofzH2+5mnz7CtNBJIflJFCDJjCZWnIm/dfNt1FOkpDENzUj/6HzXAe5ZvlDJ2a+gNqVCsv0doHjbxPiHoVLBl1FPGU/oCx4ZwI+zsSVGiww/8lsEcXLERivDD0vpnTubryttnHjnDolFvQhPVw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 10:14:35 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::be39:45a4:cd9b:4684]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::be39:45a4:cd9b:4684%3]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 10:14:34 +0000
Message-ID: <a38e51d5-d1dd-b0cc-e02e-a531b0d1d50b@amd.com>
Date:   Mon, 24 Jul 2023 12:14:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/4] firmware: xilinx: Add support to get platform
 information
Content-Language: en-US
To:     Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Ben Levinsky <ben.levinsky@amd.com>,
        Marek Vasut <marex@denx.de>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        saikrishna12468@gmail.com, git@amd.com
References: <20230724084554.1924378-1-sai.krishna.potthuri@amd.com>
 <20230724084554.1924378-2-sai.krishna.potthuri@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230724084554.1924378-2-sai.krishna.potthuri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|BY5PR12MB4258:EE_
X-MS-Office365-Filtering-Correlation-Id: ffa4e46b-1272-4f98-6767-08db8c2ec716
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wVu/rnS22K25wRU0iNzxwlF9DT/xPF02uyk9SZ0B57+KfGKbH7/X61kFq+TT13ntCFqEPCg3gK2IvXYSgxuAhI/9g8Kvr/BxgGJi1SaUMJ0Ik/6nVh9cGn2YwSzqrVE1bx6tFO61/KCV3RE4D8jLZSaUGbPAx0/Cbsp/zyrzeHwFCJ8LvkfZlszIJlTpXxt4cmt2wgq9qvIufTjlhOTzov9+Sd73lFVY3K0XolFoHEUmGijxOTkJhi7y2T/1UhxMrYMmNHlu7sWe5Uielo06Y2WXQnKE+R8Fybjtt1J6gTq++8o7qqslCTQgxIyqrb10hRtui7HrFYi4dseEHl8fWK2rptF6aHhfpTlkZ5jaglHJirnTNjv3b7OIhDn2DWV2V2K5u+0kXhqssRlGpQSeLVSQpE1VFovinsvxxieHMJsUxACL10NPqH6NfNZmX5g0KLCL8zLUUA+RscdwFtBwT8ehODQbmFVu4VrHTnj3JlqaBbta5CplG/ouxu4+BAII1IkywZZZ4aUOi1yJZ5u5Fi6HE6ak5WyraSJ9VwLvT7t0uB4F8v1iClPa6huaBqYLLpULwFnMKPCAEhWkhfV8jkD+bcUH5aHhoLPJ7L86l6d37yHs9p8f/efeSofBcB0unzR4nHNx2PYXEMkXCvu1kwi805ESaDetolab4K66DFU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(86362001)(31686004)(31696002)(921005)(38100700002)(66556008)(478600001)(66476007)(41300700001)(4326008)(66946007)(110136005)(5660300002)(8936002)(44832011)(7416002)(8676002)(6486002)(6512007)(6666004)(2906002)(186003)(26005)(6506007)(316002)(53546011)(36756003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHcxWWFuVEdpMHkrbUdSdUVZSk9EQ01tczdPckd4MGRRVjBxdngvejY1RWJl?=
 =?utf-8?B?T0hTTG1ONnY2SDZRbXJJMnJkbzJmWWt6c09FU1lMbjV2WDBUYXdWS05CazJl?=
 =?utf-8?B?Z0c5c2pyNkc0aTdxZXMzWW0ra1IwekozM1BNR0pRd2NCejU4SnRUUE44TG4v?=
 =?utf-8?B?Ym93TjVsZS9QOFZzRmJTVlA2THpyeTMrZ1B1M1VkWjIxUEpyRUxwZmtRR1Fo?=
 =?utf-8?B?b20yQkhvcWRMYy9sRCtlVGJrRGtWZjhvbmtlTmQwMUdJcXlCUnV0dUp5NVhy?=
 =?utf-8?B?U21sUVdBM0tsbEhkdUJ1UnJUbGV0T1MvTE9SQVVqd09JWHZxaVJMRjdyVlVJ?=
 =?utf-8?B?RU5aREgyb2xTS3JoNzVnVno3bEJCR1dPZ3dWOWJHUnZKYTA5TXRyN284eXRI?=
 =?utf-8?B?U1RwVEdEUFRYd1ZnMkliUUNhSkd2c29SY1VPcGJiaEQyTXI0QUYvbGpnRUZM?=
 =?utf-8?B?eGpUSFN2WGR0QlBjN3hqZksvSUR2ZDNwaHErZUp5MWZMNGJzOGlxTWx2U1Jq?=
 =?utf-8?B?eWpOUVdtWllPUXIrVTUzb1lqak1HaDRPTVlpV095aDZsaVpKSnZHN3QzaUZp?=
 =?utf-8?B?eldPQlV3d0RBUDRSaFZLTEF3bkhRVHpvVld3elRTamdMV0VMbVZXR2hrNm9J?=
 =?utf-8?B?REorbUs1RVRUYWZ4dmZSaEZvTG5rZmpPSnJENlNNS1lDZExyaW10L0phdXNw?=
 =?utf-8?B?YzViMzlzMXJhZEdGcG5ZMnRaSnBzQjlQOHpGQzc1ZkxpVFpYdDlUZVQ2SmN5?=
 =?utf-8?B?eG9aYzZyTUd6QlRiclNhU0I3ME8vWHR3eUJXTHFYZ0NsYzdmRm9IdE1FRU1X?=
 =?utf-8?B?L2I2R3A1S3RtT21wcjFOVTB1UDFiNUE2MWUrUjllM3pIMEZVMXhSQmVkZGs3?=
 =?utf-8?B?TUFkQnZlbUo1ZVAvU2ZmZG5hN3RUcG1pL21UQnVoWGpVMko4cUM1RkQ1aHE4?=
 =?utf-8?B?OUloMVgvVm0zY0hyTklQNU9yUm5Rell3RnVaaHV5VVc3YkJHZEVMZGJoYzN2?=
 =?utf-8?B?S08yNDR5RDhLcmhrUU1TVzdUWjh4T0hXbHFtWEFxb1FvRGQ2YjlrSFczUE00?=
 =?utf-8?B?anJFR1IzWEYwa1JDb2VYMStFNXFZYXdxaEhHaGxxVTBwaTdZVWVhanpFOEJr?=
 =?utf-8?B?OUJROTJsbng2SThmcURPWFg3djk1OEg5Z3I0MStiTm8vaDBMcUpVV0d2RUhu?=
 =?utf-8?B?b1hBZ1JYbVIzZVZzSS81eHlGaU51NHBac3pxeTIzQVhXWUlwTi8yc1Q2d3Bm?=
 =?utf-8?B?NkZydUVObWhpbDMrOTBiWUh0dTRXUFlSQ29zSGVHc2EyUTFXUmdHRGZXWVV4?=
 =?utf-8?B?dVYvdmtMTThYRTZwaE9mQllFWG9oL2t0enBUNVBwampGays3NDRNb2pNMzBh?=
 =?utf-8?B?OFRBQzdraWNGdXpZb2tmdVVVZTdJeEhWSWpSSVJ1UnRzN3Y2MmZCQWYyY3BL?=
 =?utf-8?B?NEpUVUZZZS9xM3lRRlhMSDNsamxvajJ3cVdRM2RYa3RISXArZmNxSjBtSkhm?=
 =?utf-8?B?VG5Wb2x3d2lVYTllVVZyZmZkTnF6ZjBNbTQ5OHNKSDZwTCtQaFRMM3VmbUNM?=
 =?utf-8?B?RVh5TjJFZjRoTm1meDluSjAyTHVHNTV6RDErVHFNalE4T1Z3Q0hyMWdkVDVW?=
 =?utf-8?B?MWJ6QnNYUml6VGlDUlgzdHFxUVpNSTFTdjhZb1E1TCtSSzA3NUp5WGQ0bnph?=
 =?utf-8?B?bldTMkNXQ0J3ajFadXFaMmVuQmM3Tm56QXBYRzF1VnA3VUpsT2NBdm5DRS83?=
 =?utf-8?B?czFnTVB1VFdqVEpUZWk2cVlxeXhjR1g1dk1rN2liZmM2bnRiSUxMenV2Y1k5?=
 =?utf-8?B?TUhoUjQyL2pMTXlUeXc1OTF4eUhMaGFkSkNDbUdKUkREVE5iZTBkK1RwMkpH?=
 =?utf-8?B?dHhudEFKZTBVUkhGSW45dXhqczV4MGoyMUJuSmFTN3YraXZkYUIydndPOG5n?=
 =?utf-8?B?UVJDbzZrM0dWUENVbzlURFBBKytWVC9QNi9BSlpXNkxyVWlOc3pTNXJKeUoy?=
 =?utf-8?B?VE9xcHVGM1NUbm84OWZOL0M4SzUzNlhuaGVxSStiYWxtaC9aVHlWM252SGRO?=
 =?utf-8?B?emF0aFJnVUVOSi9TSXU1RGNCOUMvRDB2eHVWeUlmQlRnbkthTmxsOG85RmJV?=
 =?utf-8?Q?qivfMeL+5Z8qSIq9CFZcoNvmr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa4e46b-1272-4f98-6767-08db8c2ec716
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 10:14:34.0952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2uyvBlW6tLJN5TSPqvvCl4qKxVoJeMGh0+Pt5cmXn0F5xqBM37B+6WqUT213lCFr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4258
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/23 10:45, Sai Krishna Potthuri wrote:
> From: Dhaval Shah <dhaval.r.shah@amd.com>
> 
> Add function to get family code and sub family code from the idcode. This
> family code and sub family code helps to identify the platform.
> Family code of any platform is on bits 21 to 27 and Sub family code is on
> bits 19 and 20.
> 
> Signed-off-by: Dhaval Shah <dhaval.r.shah@amd.com>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> ---
>   drivers/firmware/xilinx/zynqmp.c     | 42 ++++++++++++++++++++++++++++
>   include/linux/firmware/xlnx-zynqmp.h | 13 +++++++++
>   2 files changed, 55 insertions(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index a736db4a5825..f9498e7ea694 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -339,6 +339,8 @@ int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
>   
>   static u32 pm_api_version;
>   static u32 pm_tz_version;
> +static u32 pm_family_code;
> +static u32 pm_sub_family_code;
>   
>   int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset)
>   {
> @@ -404,6 +406,41 @@ int zynqmp_pm_get_chipid(u32 *idcode, u32 *version)
>   }
>   EXPORT_SYMBOL_GPL(zynqmp_pm_get_chipid);
>   
> +/**
> + * zynqmp_pm_get_family_info() - Get family info of platform
> + * @family:	Returned family code value
> + * @subfamily:	Returned sub-family code value
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_get_family_info(u32 *family, u32 *subfamily)
> +{
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +	u32 idcode;
> +	int ret;
> +
> +	/* Check is family or sub-family code already received */
> +	if (pm_family_code && pm_sub_family_code) {
> +		*family = pm_family_code;
> +		*subfamily = pm_sub_family_code;
> +		return 0;
> +	}
> +
> +	ret = zynqmp_pm_invoke_fn(PM_GET_CHIPID, 0, 0, 0, 0, ret_payload);
> +	if (ret < 0)
> +		return ret;
> +
> +	idcode = ret_payload[1];
> +	pm_family_code = FIELD_GET(GENMASK(FAMILY_CODE_MSB, FAMILY_CODE_LSB),
> +				   idcode);
> +	pm_sub_family_code = FIELD_GET(GENMASK(SUB_FAMILY_CODE_MSB,
> +					       SUB_FAMILY_CODE_LSB), idcode);
> +	*family = pm_family_code;
> +	*subfamily = pm_sub_family_code;
> +
> +	return 0;
> +}
> +
>   /**
>    * zynqmp_pm_get_trustzone_version() - Get secure trustzone firmware version
>    * @version:	Returned version value
> @@ -1911,6 +1948,11 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
>   	pr_info("%s Platform Management API v%d.%d\n", __func__,
>   		pm_api_version >> 16, pm_api_version & 0xFFFF);
>   
> +	/* Get the Family code and sub family code of platform */
> +	ret = zynqmp_pm_get_family_info(&pm_family_code, &pm_sub_family_code);
> +	if (ret < 0)
> +		return ret;
> +
>   	/* Check trustzone version number */
>   	ret = zynqmp_pm_get_trustzone_version(&pm_tz_version);
>   	if (ret)
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index f5da51677069..d7f94b42ad4c 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -34,6 +34,19 @@
>   /* PM API versions */
>   #define PM_API_VERSION_2	2
>   
> +#define ZYNQMP_FAMILY_CODE 0x23
> +#define VERSAL_FAMILY_CODE 0x26
> +
> +/* When all subfamily of platform need to support */
> +#define ALL_SUB_FAMILY_CODE		0x00
> +#define VERSAL_SUB_FAMILY_CODE		0x01
> +#define VERSALNET_SUB_FAMILY_CODE	0x03
> +
> +#define FAMILY_CODE_LSB	21
> +#define FAMILY_CODE_MSB	27
> +#define SUB_FAMILY_CODE_LSB	19
> +#define SUB_FAMILY_CODE_MSB	20

nit: It was likely easier to do it like below. You can avoid so many defines.

#define FAMILY_CODE_MASK	GENMASK(27, 21)
#define SUB_FAMILY_CODE_MASK	GENMASK(20, 19)


> +
>   /* ATF only commands */
>   #define TF_A_PM_REGISTER_SGI		0xa04
>   #define PM_GET_TRUSTZONE_VERSION	0xa03

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
