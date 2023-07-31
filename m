Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC33E7692B1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjGaKGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjGaKG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:06:28 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A57A4;
        Mon, 31 Jul 2023 03:06:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JX/L4zlwJeOaT63M4PgPCyEFLwdfkoZj411Za+W4oYaBuc1Eh1NouZ24VV8+zb36X4ygmiKQue17zFpc2JsaOdqZBO6kCbgMIZti2VuJdRkLWaHAbpWMMoF1xUlwt/s0vo4dCLwVpJsyfB5jgOXeHvXsyzu5zLpXvHVK8zLNiv4a2UelOW9H46lBBwnvWlkIaOesRfBnhxJWoE4cGZgnGrBIlfNpdRDAMxsonogL1nG5qb/0YJ9Wpyclfk7wQETcLejg+sG1AlgnA4wPj4BCbrFRVNNuInCNtjVhAM9UWuMIUKbpt0bUK77i7hxm1OoSO4CpjmqGQb7X8vH3/79XRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQv1B/WdNEDOt+hVhFNvC+myZ9PwJ/yS1O1cTsnlQec=;
 b=FxUZSAMeVhC15vnOPuNbZZKy/R+SZgpZj+hJuQBGLS++nYTAl0RKaSDMeJRVs04UGdjONLu34H3jiCMJiFf4BrA8jSEYUJleuLulOnTjRj/Ibcfd1LBVKBe0Y3NJWdQc8cIh8E42mmt2f02tgSwUIs67awY1OZyDhzfJ1O07J2Mevlso3/qF0p2+4qWlLGiBPWZUMqbrsI3VhNlVJQ+B/pSEkC/ONRRgT6A41RtpH+Z5K/R6bI5mEjCZfde7SoAQIBbxPNX0MRuOp8Y+T4KGKxgMGNHUL6nnzbhWs34XzYNOV3MA/iZ1kUFf2nL83+/aGvlKS5EzNbXSaU6cwRNrJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQv1B/WdNEDOt+hVhFNvC+myZ9PwJ/yS1O1cTsnlQec=;
 b=vJDeQtSOc5xFgOAgNvvzSpIDzzf76RTqx12hI/psNRKiOyL9eM63YfgGVthp5EW+67/qLuXzWV2h2wxDOPHKrf2qz1aJCgYYAsjX5t3kDsrvaBRb0jJ/4iyYf5/W1RYyZ7rfsnl7mtMnEPN1xjolJixb147loiN11ATp8b2m3f8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by MN0PR12MB6002.namprd12.prod.outlook.com (2603:10b6:208:37e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 10:06:22 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::7790:1431:1e52:44db]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::7790:1431:1e52:44db%4]) with mapi id 15.20.6631.026; Mon, 31 Jul 2023
 10:06:22 +0000
Message-ID: <58ad4a7f-49d6-bb62-2202-4f7b7564505c@amd.com>
Date:   Mon, 31 Jul 2023 12:06:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 4/4] pinctrl: pinctrl-zynqmp: Add support for
 output-enable and bias-high impedance
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
References: <20230731095026.3766675-1-sai.krishna.potthuri@amd.com>
 <20230731095026.3766675-5-sai.krishna.potthuri@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230731095026.3766675-5-sai.krishna.potthuri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::10) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|MN0PR12MB6002:EE_
X-MS-Office365-Filtering-Correlation-Id: 10832080-e51a-44e4-5eef-08db91adca9b
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q7joxIcm080MxgWq3doR4xgCWYKH8h1b2f7TjUJj+NB1QLqgaAqnKg9jRoFNMGgU5iPNmXp9MCzsQvx3SRJgtoc2/EfWdBCAqVLDjCWB2qrUwy1fXQ6l5XYeQHCrO24Sc9I74ZYvuwC2vOBi/qtWuLPtcWzkEs7t8KVr6pdXRLkIa4esVUDDs6qsyIT8szfqj0QYRANoj/vE88RVZAte6lae9JookIlUWgGfa4iFdXKa4bbt8hwdtQSBddxAQ++PZ2Bp3ErqFCwYyrjHiuCD7eaYsNa9tTY9bzz0vFxrVHy8jebCwOIpIRWRpXmqUh+pbHX1sQHP0Nh3/wggBp8bCiDpFdnwiguQmB1z295iZewftarjL6AaBlOY7vFslSCTpeeXX4PMlniz4iryX8rKPDNWU0ZBznKgQ6Swc/9XObe2egptp5JIVpfvuw2g13nWDsd+eFhjKt312I1XziQ740NXp6J94V1LBg4dTibZ7cAxrjE+Dx4ZaTId773asfksB80S5A4ntlpR84B2jYQX51GJ5QbixM/d0rs4l1jmJbxugVcM+K8lK0Q2XONf+4XN4rTtiJ60G5kwCThc5Jzr3Xa3eoexlubhuiyeLucgvFdQiKFp6yGMmMOa+5u7BcyQVpOwHVrjaNVx/6vzuLYwaaoxX2YGBWslo9mZBdIkJpU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199021)(38100700002)(921005)(31696002)(86362001)(36756003)(6512007)(478600001)(6486002)(6666004)(2616005)(53546011)(186003)(26005)(8676002)(8936002)(6506007)(44832011)(7416002)(5660300002)(4326008)(66476007)(66556008)(66946007)(2906002)(31686004)(110136005)(41300700001)(316002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDdjZHRRVmlPMXlzeVJBcTNzY0kyWUhqOVM5VFdvTjNmSVUzT1o0TzVRRG1R?=
 =?utf-8?B?NHVmc2NBWUZGQkEvV1FZNzZVNkdCelBlMUNtYnhTSEZleEdJWitZU3hJU2R2?=
 =?utf-8?B?WTZRcExGbldaSFNNejJscjN0Nm83QXBJdE9ZR0VHUGRUMkhFWVBpdnJNV1ln?=
 =?utf-8?B?SFN0U0FWV014NG5Jcy9pK0M0bCsyVjIxYkxUTWgzdzZuT2pSWE0ybTdycjFa?=
 =?utf-8?B?MVJVZHpuRllXMzY0NWxhVmcrRmwrMWhDSlJtVTlrU3Y3L3FNeGlvSEwyUFlq?=
 =?utf-8?B?UXlRNGt6NkEwY0RrcllTVUZlNlVjSldPcGhlYlRTb1lGUmM3OEpDU1ppcjVk?=
 =?utf-8?B?WHp5R1gzNmk0NGY4SXV1akZ0VXFxVnlWeVRGcm8yS0dyN0lNcU5XVmN3M1dI?=
 =?utf-8?B?U1cyZ3BRbVl5c1VKaGhPdjN1TDh4S045bGY2TlJZVFRtQ2cwalErNzU5UlAv?=
 =?utf-8?B?SFFkd0plRnN6ZXpPUWNBTGF5cXVuS1I1bThoeVZPY1FjYUlHNjQ1R3hYMEwy?=
 =?utf-8?B?c2lnTnY1SFpNTFMzUGcxQUs3bmEyMnpTSzByL1pFWG8rekgxQU9EMHRlSU5Y?=
 =?utf-8?B?TVZ5bjAvK2drSFFyZGZtMi9palFuRklUei9zd0dDTkpIenVWVXpjVmdDWmNV?=
 =?utf-8?B?YUVWN2JCbWJpenlHclpPa3Q1SkQyTVNmTzRuMG1ESzNJV2R5OG5KWUlRWEd2?=
 =?utf-8?B?TzFReUIvZGgyRWdQalBrS0ZEUGpsUnpoanREYUZ6MDVkVWhwU1NPM0tMWlky?=
 =?utf-8?B?SEpNYzBOK1gwb3ErSG53MjhUNGNxTm9YanRPSzFXTnJrSlR3UFlBTys4aEpW?=
 =?utf-8?B?bDFvczdNbW15NGlyaVY1S3ZabGVVMk9ORDRXSTR6T3dQZ2QyN0k0M2J3YUJk?=
 =?utf-8?B?UnYzRVo5aHV3Nk8vSXVWeVVnc2wyRDZvdHQvMk00UytqRFZDdGdPYXMxZ3Fp?=
 =?utf-8?B?RDdkWk1qcm15UldLSm1XNFQvL1BJVnZqRkQraysyekM2TWxBb0cydi9rRkdn?=
 =?utf-8?B?T052YlgvRlFxK1RpMm5LKzdDNGh4cUFZWEdPd0F2Q1hoRVgvTk9JbGFrZi9l?=
 =?utf-8?B?ajUxaUlCQUc5RS9pOHA1MXZNZGZaN29Ob0hKUUZSTFVUN1BHQlhGZ1VJaTh0?=
 =?utf-8?B?b1Z0OXJsTkRBczZ0NG9QMGFJVzJ6TGVHeDlycWdPZGJzTHh6RW94L04wZVBG?=
 =?utf-8?B?WUZUSCtXV2kvMGdlL3lOdHJCNFZxWHJpd2Z4eHQ0R1BUMzZTUisyUHozSSt0?=
 =?utf-8?B?cHZsVlJFSkdoaGN0ZW9xOWJvUFN3Q3N5TkdySFk2TXdiK29wa2YwZ1dkeUd4?=
 =?utf-8?B?NThGMHduWmxzc1diUUlCRFA5S3NDd3EzcEFoZzJuWWlvSDJrZ1NkQXE1aU9i?=
 =?utf-8?B?VFJ2VnJCbFY4RDMvLzVXc2Radm1KaFgrdXNRZG80WmhCaTBtNWRiYmhJTWlh?=
 =?utf-8?B?eEZvSXNRSFhHMWZCOTdNcGJwWXJLQnVhWnBBWlMyN0JJQ3NDTWZDNzhybzNw?=
 =?utf-8?B?ZVNCcXNKeW5zVVFBQmFFU21PVmp2TDFBcDIyMjFja3U3TnlwQm1EZHFwMmNT?=
 =?utf-8?B?SG8xRjMxNEg2eWV3WlRGeW84QTQwWWU0WGprWk9udTc3bDlsZVZyVTJJdXVJ?=
 =?utf-8?B?MXMrbG5nYVdpT0RiU0pscEpld0RlREhDa1pWT3FPb3hsckt0RFMrNUx4MDVZ?=
 =?utf-8?B?alVybWJXQ0g0Y0p0d05LY0IvQUpoYlVGNVc4RmhqVG9nQ3gvNFBsV2J1Z3Jp?=
 =?utf-8?B?eFlzZmVLZVNBODZyQjNTRDE1Ym0vQlhQMFFEejZ0eFhLV0NpMys1alVkRjAy?=
 =?utf-8?B?dUM5NVAzNUVWTSttYnJWbDRrNC95Mm5aRytLaEhybHhVWnp6MXlZUzRUNWF2?=
 =?utf-8?B?M2V3RksrS1NDSEpaRGI2VlZGN0JDNWVQT0dINW5nWGZEKzFDZUVOQlMraFhB?=
 =?utf-8?B?a0hCeHNFU0hsdnFKcWtIUmtYb3c1OFRaUWI4M050OHJoMFE0L1RmZzNIdTJ5?=
 =?utf-8?B?endEL1BaVGRQUDM0N29wUTBIelBaaVI1NGdkRzYzVnNSSEhpL3N1SnBzWTd0?=
 =?utf-8?B?eEtXUUNLT3Eyb1VMdmhvcFIyTkdCUGZIaWxyWFB2NWdDbVEwWll1TFdsVnps?=
 =?utf-8?Q?JNPWwEdXUZ+daTj/QLW7NN21B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10832080-e51a-44e4-5eef-08db91adca9b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 10:06:21.9815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+jYWflippvEL4zA8BsVV17q6PFxz/ciPuSKXc/Kf5ax4oPi2yxhutmXnoRSY9Om
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6002
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/31/23 11:50, Sai Krishna Potthuri wrote:
> Add support to handle 'output-enable' and 'bias-high-impedance'
> configurations.
> 
> Using these pinctrl properties observed hang issues with older PMUFW(Xilinx
> ZynqMP Platform Management Firmware), hence reverted the patch.
> Commit 9989bc33c4894e075167 ("Revert "pinctrl: pinctrl-zynqmp: Add support
> for output-enable and bias-high-impedance"").
> 
> Support for configuring these properties added in PMUFW Configuration Set
> version 2.0. When there is a request for these configurations from pinctrl
> driver for ZynqMP platform, xilinx firmware driver checks for this version
> before configuring these properties to avoid the hang issue and proceeds
> further only when firmware version is >=2 otherwise it returns error.
> 
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> ---
>   drivers/pinctrl/pinctrl-zynqmp.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-zynqmp.c b/drivers/pinctrl/pinctrl-zynqmp.c
> index 8d2cb0999f2f..f2be341f73e1 100644
> --- a/drivers/pinctrl/pinctrl-zynqmp.c
> +++ b/drivers/pinctrl/pinctrl-zynqmp.c
> @@ -415,6 +415,10 @@ static int zynqmp_pinconf_cfg_set(struct pinctrl_dev *pctldev,
>   
>   			break;
>   		case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
> +			param = PM_PINCTRL_CONFIG_TRI_STATE;
> +			arg = PM_PINCTRL_TRI_STATE_ENABLE;
> +			ret = zynqmp_pm_pinctrl_set_config(pin, param, arg);
> +			break;
>   		case PIN_CONFIG_MODE_LOW_POWER:
>   			/*
>   			 * These cases are mentioned in dts but configurable
> @@ -423,6 +427,11 @@ static int zynqmp_pinconf_cfg_set(struct pinctrl_dev *pctldev,
>   			 */
>   			ret = 0;
>   			break;
> +		case PIN_CONFIG_OUTPUT_ENABLE:
> +			param = PM_PINCTRL_CONFIG_TRI_STATE;
> +			arg = PM_PINCTRL_TRI_STATE_DISABLE;
> +			ret = zynqmp_pm_pinctrl_set_config(pin, param, arg);
> +			break;
>   		default:
>   			dev_warn(pctldev->dev,
>   				 "unsupported configuration parameter '%u'\n",

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
