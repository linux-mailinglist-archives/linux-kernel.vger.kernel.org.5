Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68F775F2F5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjGXKXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbjGXKXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:23:10 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCD749CB;
        Mon, 24 Jul 2023 03:16:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5VE2Q4wfmvJA3mMyW7b/1Ekr1rlJz+qNuHwptHFMUCmKPkIs2c2+ZJ2N+vaHVLGF0HnQBr9kvk5vg82Rx4AZ9cg/GqW63NFXwcm2dIINft5Ob03aBgSQD4tUTDOKFjSL0jPHWNHXiusWcnym7n9rWqBiSfjv65Hcul5rGIYYVTlBW1nUE7AksOf9PkAT5U4W7/dqt7noG/y0Cvk+r9CtPDF8t99eU9SOFYjdwzy5xL+BnrFRUdnFqGt8+mXxOFJlBdmCuDOZA2EGHzzOSwhT8Pe/dn1EFmitSNfTdviUnrfDcjP2i1+fpkMv33dM/PdNUkSxh7Sm3qIvJ8g6G+UZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqT8oSwEa9++vxb79JInQpqu0VgkfTNbpytgkSgDVT8=;
 b=V12THPLIylfRy9bDgV8zzWYKc5yv3vpTaAvw4CGthxOAkP2INRejKSHQbMxnV1cUYmHeiQXGhvQnTEKyG7ASaTKGbpKJCbqcxR+fe7ySSsFF6x03AGy/m7k0J2yLoOncqzRL9LDmkWkd/xos3v0fVtj9jzOrd+U+bo/hoYQJ9xW2cuorIQFXjshRVfVytDX5zDEO7AP5EAb+139gljxoku3GhSVrRLmXSOMu1tlGX3TK7G1FfVcaO/ThMfh0kLXFx9BmqsNmxMDSjd1bzOK9JZnGc9QwvNygF4qIa4oPGC06iDKw4JjQH9rWqcxL6Bc8X7/5Izqr/kLi84TsTQyBOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqT8oSwEa9++vxb79JInQpqu0VgkfTNbpytgkSgDVT8=;
 b=ouCKOmRcG6BmLMuBG7aAlIS9syZ64phrMsZZ9PXpspcyiCdL3q3scktxdnxL0k9ws7e8CbjzADOEs2SJkzEERic+syQJUlzKHouMWIxIGHQREfRT81VZ7s610QFreY5iqoRMLwgsuYpGmTerIOoRfuEYJD2wudfqWsMGONqagMQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 10:16:48 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::be39:45a4:cd9b:4684]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::be39:45a4:cd9b:4684%3]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 10:16:48 +0000
Message-ID: <77b45165-e6bb-6ed1-f96c-90565740db2f@amd.com>
Date:   Mon, 24 Jul 2023 12:16:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/4] firmware: xilinx: Add version check for TRISTATE
 configuration
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
 <20230724084554.1924378-3-sai.krishna.potthuri@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230724084554.1924378-3-sai.krishna.potthuri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::7) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|BY5PR12MB4258:EE_
X-MS-Office365-Filtering-Correlation-Id: 46a79421-86ad-4479-d412-08db8c2f16fa
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e0LcrGWesnUGec3wTKEWc6GKSx1z0BUj+4NrH8CKLMzeKmELuLpbUL+POPAjCWQj4x+OEFdoCc1XRdjgaQP4JqS2m1zHwG8Jx5E8Ye9DCJ4bpYxg8jXimP+oBLHQFFXnm0xzBnk7A4XpxFmTaXjGb3KRSgbxFYofnIIZYNnH39Ab5adAlfyFxo3VNMeDST3xiUTXmFzX7qJsP4iRrSumk4E9fuFqU3yVmQNouCv6QIbQBFwn61EIeD4txrOAyVvNrt0npkDJ3UVypA9wAtY74y95N6zQj+lz4gDUA3fdA709xdmu2YK9nb4Zg+oA7AkLMlQpQJuS7tjYcJkYPv27wPoXCqeI+gumdTuuybkKcPKC7i/SO+Oox1yXYTXQ6yeWB/PvzOpmtcR4n9G4c686ggCl75BWEVPoh6tnsrSDyD5wA+CgKyHQS/j+QFxL79zQdgQP28y2CVMsqHc+TV17lbH9jlT1Y9SGM5IxdfY5eFT6Ha1UT9+Zso0UtFxv8704qgZW5coGN3/1Zw9dMA2QCBHoM7qE7NuiydwcuF8JLProq6+OpQCBhBQ1+izC1pHXpKce2b6+k7ia8roghMZLNo5yncel4cV4mDMwwRU3OEuSuIWlZhF+34J/suZGwxLwmJtq2VbdG8RJu6khiw3E5hXodddJxO5PUQj9zAwo9Kk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(86362001)(31686004)(31696002)(921005)(38100700002)(66556008)(478600001)(66476007)(41300700001)(4326008)(66946007)(110136005)(5660300002)(8936002)(44832011)(7416002)(8676002)(6486002)(6512007)(6666004)(2906002)(186003)(26005)(6506007)(316002)(83380400001)(53546011)(36756003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVVLZ25MN3N0bUd0RjF3NXQrcitJb2o0cHgycVB2SVFSZ3gyN3BqSTVweGlG?=
 =?utf-8?B?bk1seUZ4dFRMRU5KY0tZZG1OWlBDcjBaY1BBSXRqbE5DSG9UR3FWU2sxdWtI?=
 =?utf-8?B?RWVWVjRZMW1ESFpnaGl6ei9ELzJxYXNNWHhvT01Gb2lhdHY4RFIvUVMzdGdr?=
 =?utf-8?B?UHNwa0dxeGkyQWh2QXhqaEI4WURQTlYxcGg5VDVicG4xbUZyWndFejhraVBH?=
 =?utf-8?B?NWlEK0c1SnNzQk1vd1BZc1Fmd0Z1YXZLeDNld2Vwd2lJcVBLRnpPQjNXN1NE?=
 =?utf-8?B?N3orZ2RHbVdzYkJ4cEJNWjNRN0hDUVVNNk9ZQklTYWdnNWwxd053M09sTDdB?=
 =?utf-8?B?VFhyanJyTEJVeDBMWkVhSDVadVZyaUFuSDVGai9YUlorK01yOGl4R3Qzald3?=
 =?utf-8?B?SnpmajA0dmdsVzJyZ0U1WWY2V1VubEVBdEtNekg2NW1OL21WalZQcExjVE9m?=
 =?utf-8?B?MG9EbHFyQ3hqZzhUclNyejZWNjFERVVzVkFaWFdQbkx1TUNQUTZuMHdZTEJt?=
 =?utf-8?B?b2M1L0tNOEtQUDJqamxCdXZFUmZaR1Z2YTkxTS93RW53Vm4wK1lMOFYwdDJW?=
 =?utf-8?B?SWx0L21sc3ZJb3N2QmlQRThxMXpQK3hPM2pXUDlkaWkrS09tVU5rUCtGOHZI?=
 =?utf-8?B?Zk9XZGp5R2dkNVdkTGNTU2lwNllXY0FBL1NHNXpWck1VOXZSQVp5OFNRSW5q?=
 =?utf-8?B?VkY2UEovbjQ1RkVJM0FZQ0ZLbmhydWlaTDZmekJrYTA0MXBDQ3VUQ3dQdkJn?=
 =?utf-8?B?QUNwcXVVdDBqUG5nQU9QRldMRjdlOVZ4YWhBM0xrOU56WXpTSk5yUjJUcDM1?=
 =?utf-8?B?MkhiUU1DWFNNUnM1cU9rYVdRZEhiOHFlYUczeTk0Q2lLQnp2L3JFbkdMdHZj?=
 =?utf-8?B?V0R0T3R5bmdHRVVlMm9hZ0tOZ2ZOOXg2dHBEb1VhNUtNQjB5VkFuRnRoTHVT?=
 =?utf-8?B?cFBPYURwNmdsSFhTZXBIcWNwaFVZS1M1aUFBQUQ4RnlqNnFMaGtIWU5KRFly?=
 =?utf-8?B?ZWtpL1ZMZTFKOU4xblFCUkgvV204N2YzNE1pRjg1YnBaRUtYMDNIL2R2RkJ5?=
 =?utf-8?B?WnV4SG1SbFlXaGU0SWR2R1lPRzRINVdpZEZObXZ1MlZHQVFHNEg3UW4wVGJ1?=
 =?utf-8?B?NFZISjAxN2EvNFZhcTVQV3dpWm9OWDhHWVlVSXJVVlBWQ2lpZFhJd1lhT3c3?=
 =?utf-8?B?SmtSdFlDZ1dUT29ILzdVRHpUbWVsN2FWMW1JNGhoTHBlRFlBOVhvUWU3T0d4?=
 =?utf-8?B?NmJvTTkwc1k3RmtIVmdEUlh4bzR0b2VGek85bWNvbEF0Q0dvcnNNUlpoOTRP?=
 =?utf-8?B?Sk5LTURyQjJ6UWJZMW9LUzhwd0ZhWE5YRFRrUTRSUy93QzNmcnQ2QXA1dTlB?=
 =?utf-8?B?TWVqMmdUZW9iYngrbGd2Y1MwWW94NHRidmJpUzVTSHkxcWQ1TXMzUE5LbUkz?=
 =?utf-8?B?dlZod202c0dhdU9VdW1ZSDZrUmMzeUhaUFJ0ZHVwQmE2Skx3ZS9XemN3VHVI?=
 =?utf-8?B?NVYxZ1ZFR2xCc3FHTG8rMUN3Zmo3ZGY5MExKK0tPeUJSbGpvQmtlellaYjFU?=
 =?utf-8?B?MkMvK3NoQ2pRc2ZoVkI2VVNzMUlDYWJleTNXSEpXYS92dFZqeXo5RDdNY05i?=
 =?utf-8?B?dWIwSnQwVXpsOUNRdWNIQXowcCtqdldQMnlEYzlueTgwYmpzMFpBL252MFFj?=
 =?utf-8?B?bi80SENjMU1id3loSHdzVjdZZmlGWnBGUytra1RxOUFkbEdNMmFHcjBpcHFK?=
 =?utf-8?B?WXN0ZmI1bmxjOW1FMC9NV2RZWnVZdnFvaE5SZTdpaGxQeFpyL2d1MWUyQ1ln?=
 =?utf-8?B?a1pCSGlRaXVKN3VnazE2SlBDRURnNWpRRlY2Q3VoRGIwQkF2VDRoR241NnNm?=
 =?utf-8?B?TFV5RDBMZW5vcVZXelloV2wzbGNpUzFXeGdMd0ROcHJUeWhEbW9xaXZvbVd1?=
 =?utf-8?B?RlBmTVVwUmxNN2JTZ0hEVlhqN1Q1RjlqS3dZUXNGTXA0OG9FY2lRcGt6UWdV?=
 =?utf-8?B?K3JZWE1jQ3lVSUhCOTBRZFR1NEdKVGcrbXdyWnZ3TmV3eHI4YWlpZ0YxbE5k?=
 =?utf-8?B?N1h3ZTROckltR1dYOUhaNVdPK2dFUmowUXQxM1p3a2ZldzY4Q0xNNjZsVjJJ?=
 =?utf-8?Q?MCeziQRLFcT7cUYfM4IWmI85q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a79421-86ad-4479-d412-08db8c2f16fa
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 10:16:48.2851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IRV6tzUOjr4eDofnt0xCbw1R+GwspBZ2hrkjHTuaI+MtSqvucfcgOak2hNrB57Lg
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
> Support for configuring TRISTATE parameter is added in ZYNQMP PMUFW(Xilinx
> ZynqMP Platform Management Firmware) Configuration Param Set version 2.0.
> If the requested configuration is TRISTATE and platform is ZYNQMP then
> check the version before requesting Xilinx firmware to set the
> configuration.
> 
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> ---
>   drivers/firmware/xilinx/zynqmp.c     | 9 +++++++++
>   include/linux/firmware/xlnx-zynqmp.h | 2 ++
>   2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index f9498e7ea694..307717f24a98 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -1150,6 +1150,15 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_pinctrl_get_config);
>   int zynqmp_pm_pinctrl_set_config(const u32 pin, const u32 param,
>   				 u32 value)
>   {
> +	int ret;
> +
> +	if (pm_family_code == ZYNQMP_FAMILY_CODE &&
> +	    param == PM_PINCTRL_CONFIG_TRI_STATE) {
> +		ret = zynqmp_pm_feature(PM_PINCTRL_CONFIG_PARAM_SET);
> +		if (ret < PM_PINCTRL_PARAM_SET_VERSION)
> +			return -EOPNOTSUPP;
> +	}
> +
>   	return zynqmp_pm_invoke_fn(PM_PINCTRL_CONFIG_PARAM_SET, pin,
>   				   param, value, 0, NULL);
>   }
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index d7f94b42ad4c..6359eeea8dd7 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -34,6 +34,8 @@
>   /* PM API versions */
>   #define PM_API_VERSION_2	2
>   
> +#define PM_PINCTRL_PARAM_SET_VERSION	2
> +
>   #define ZYNQMP_FAMILY_CODE 0x23
>   #define VERSAL_FAMILY_CODE 0x26
>   

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
