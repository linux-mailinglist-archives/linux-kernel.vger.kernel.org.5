Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEFF7D6144
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 07:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjJYFpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 01:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJYFpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 01:45:22 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2128.outbound.protection.outlook.com [40.107.13.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DAB12A;
        Tue, 24 Oct 2023 22:45:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6cWOpepCmUj3p00qR48c21TunIcByIgcUWs/07TweIhcJTFgod/T2w3upDTz65J8twIg9K+kJ+vCNKduYh+uJLKhFmrJSD/K2ISZXZYpr8mlmEvjEAMy0tD+Ol2JBMdQ0F/jL0eiSqGjABMhFmSLON+ESKMEs+LiF5aRDrGxUXpxnyb32lCzPlCYgFx4NopITAzLauknx2c0rpirePiAwXzSRfiw4Vs3HoZvGKFp6J/AnGRIKO3Ks6VqTpO0REbDhtYutqiGQ+lptWBop9RsIUV4beivKqcXqHwa5cH/s7u22HUbX4H4BAp0eDviwFWqtMlTMj1x03SOvfnFfgPcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rurFSdzdZnpqeRMmdL07P0ypIj9zX+Nx0vnxi0GCTVM=;
 b=UwBvocVGq/PdW+1vjaQixIcniBwrB7DHzL2Fg/QjMxcnr+z/166v+tFkpFJJYzG1lUcakuX2xOMDlxyJYuyLxUJLhmSFHi+rkAeK9k61u1cBVFv4owU4+/XCRW0WGv/yr7B4x7LBXP8yxIqzveSNNx6WYpYLlKL8zburqrbf2xLM7SbAeMUVWS/Gj5wv2/+ufU/clQ1s6XXnaj4cvde+z61bJNjJ3KowKyUrq7XdvP2xtE8+Y2Uuc0MgoSNP8k0SOYgnKuSFbJtt7xL9W68RojPQMMT1RAgTYeedQVKnaYxijgqSd/bsf+XWCGJjb8rVRwSzQS4gJDBhQC/s6EQ1pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rurFSdzdZnpqeRMmdL07P0ypIj9zX+Nx0vnxi0GCTVM=;
 b=DSAw1TMYB2gPBEk/lIkq0kkc0uDPVPon8eDcfzefqeln+vdytdBUD9bdAbDUsndTuRw70Nm3h8YuSyimz/zPimKHCXWdqbSN+fqkFZOAw5XGJS5hBosXRtsIDrj4VCVPy9fGJwFrqBob3CdkyQFeG/oxXCbKaFPHfbnBCs47ETc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by AS2PR02MB9953.eurprd02.prod.outlook.com (2603:10a6:20b:607::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Wed, 25 Oct
 2023 05:45:14 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::de22:5b04:df31:2d87]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::de22:5b04:df31:2d87%6]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 05:45:14 +0000
Message-ID: <f8d3a930-491c-e79f-47b4-618757b6bebf@axentia.se>
Date:   Wed, 25 Oct 2023 07:45:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4] mux: mmio: use reg property when parent device is not
 a syscon
Content-Language: sv-SE
To:     Andrew Davis <afd@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231023162659.81397-1-afd@ti.com>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <20231023162659.81397-1-afd@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVYP280CA0023.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:fa::26) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|AS2PR02MB9953:EE_
X-MS-Office365-Filtering-Correlation-Id: 0294a174-0f2a-4efc-6479-08dbd51d8f69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2SYJ8PH3z7Lx/rZInLa2dU3HTiintX7ivUHeYKpnv0HLnBp417Amq9F+IF++P6uf3HOJDceifqzzS/IdHOyn+m4+uH/1XQnkAuxnoQp9OhySkQ7aKATngHHzVqaB1UgSI7R3IkxYcrkG2t1LX73RZFqWS+Di1EzarRgWVST6YW/wk6xTMXUSP8l3if1j5or7EA6+JOBOaUzPWhNxH/sgQ2JP2QU9X2OItxTLNVICeFY5mw+otzWkNxrM5aJgli69hulz2ivbS6NFiTo/mFZuyRooy0EBHivQlN28oGPUShapLOJLMVuyzAN1wUBa5voLJ52ZDtHBiV5Lg9S7/bgkVkG0AvWafgMP+H0JgL/KoF4hhmvHPUuYN+9nb47+3rbPg01qKAWkHYy63McBKos0NlwsR12uG129onlzIV55v89ATBF3fX4948tKLZT6h+lpczIAJ4qmFTw40cZDqSyDeKezM6Yuu5yflOml/aSp14e5LKz6yVwTUjdgoSqSjjsrVithB105+idbdnaKptuK8FW/3kDDMXiJ2QrPIPJLWV7s3+P4HThKhDL13/WnuyYOA0y1O4FhKl6nhdd4yESPZQdllLV/523nDoVTrOw+YK4S5bvePAS25Zkqs6F8Ex/MtAyyd9QZufcmZ9VHTSRM2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(376002)(396003)(366004)(346002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(31686004)(83380400001)(8936002)(2906002)(4001150100001)(38100700002)(4326008)(26005)(8676002)(36756003)(2616005)(86362001)(6512007)(6506007)(31696002)(316002)(478600001)(966005)(5660300002)(6486002)(66476007)(66556008)(110136005)(41300700001)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1h1MW9SY0I3UjhWRno4OHdkWTE4Y3RhTkcxcGpvOUpkVjNPbW91dnhyM0pO?=
 =?utf-8?B?T2tGdDcrMG1ycWpCcW5oWnhCdW5CUVRYS2hpK0lObVh6SzUxKzdzdTZEQzhZ?=
 =?utf-8?B?NWhjL2ZIYmhERGUzbDRMdDBDaExwSCt1LzU2RXEzRjNITHhRWXpoWWoxbU1i?=
 =?utf-8?B?ZTJLam9sTVFpQzdOZkw2cU1tVUZqZzJuaWxCcTMxVi94RFdWNjF6cWVuQzdK?=
 =?utf-8?B?bTNQYkJQbk44bUF6czlVeEw2UzFSRmRMWnh6R1diV2dVbVFQcm0rY2pmZWVB?=
 =?utf-8?B?aVU3RHhoVlQxeHdEOWREcnZGOEZjMXoxamVWV0g5RjNXN0duQ2dlREU5L0Fh?=
 =?utf-8?B?MXJ0aERIU2F4S1o5OFpxMEZpLy9zbnlqVzVwZi8vRWNjSGZHT0FnK2U4enBp?=
 =?utf-8?B?Z2tnTDZtN3Nsbm92MnBzL3pseFdMM0FOaEMrL2N3bkEvb3VNMjVsb3N2a1lN?=
 =?utf-8?B?ZThyN2R5VXhsS0h5MTdRdzdZYWtqbFRrS1IrOEcwaDQ1a2Jmd2hURVl1d1E2?=
 =?utf-8?B?dldxZ1RWakx5OW1IKzA4U0F2S2paY0RqRElXczRqWmk2Z2RZQjlyQWRtMHJM?=
 =?utf-8?B?azhOUWRzWE9ya3dJLzJHNHZZS1E3dzFSZUxYbTFENkRXY3ZJbDBtWXI2enow?=
 =?utf-8?B?MUIzS0I1aGZIWnJTUWZpMEUvRjBNTzBLN24vQUV3ZE1TcVFuTm0rcDlZampW?=
 =?utf-8?B?blZJYXRzOENKUWJ2S0c4azd5YXArUW1lb2x0OW80dHFadytSamNhVkptc1Jy?=
 =?utf-8?B?MUZpeUxhSzV6MG9aMDVHdjJpTmNTdFFSNEZaTmRmenBJd2Z3d2ZvOHRVd0tF?=
 =?utf-8?B?Wk5RUnlrRFNwZHVvemxHcVRGeEEyUVY1cE1XeitTVU5OcGRoa05xOUFWR2lq?=
 =?utf-8?B?RUgwRisrTDNUM3pLWE50bWRSdVl6NTc0V3c0NXJqLzE1dUVuWjdZYWI2M3ZG?=
 =?utf-8?B?QmZFM2YxZUQzVVAwcXdFWXhIOTM1SkdXdCtUa0M0QTZKMTF0aXNIU2lxOEZp?=
 =?utf-8?B?T0ZKRUQrMStVYjJHODdpWEFmM245M3VRRTBiOFVmQTFpNFRoZmF0OFZxcVFy?=
 =?utf-8?B?aEQ1TEZ3YWt4NFZpSWZYODFZVDhpdnZ4V2VLZndCRUdxZm9ST05nYjhNWmZC?=
 =?utf-8?B?bEdKWHArdFQ2SkpTTDhycnFwNmNGSEd5bGd5TXNJRTZJZlhTVUZOYTkrNDBZ?=
 =?utf-8?B?WGdSNm1rMFFtVFE4UmtjYVVQcTk2aFdhNCtNM2JWSmg0VkUrd216cFhmY3Fw?=
 =?utf-8?B?WFJmRWdDaGxqUEF3TC9wZklIOEt4RzIzUldHTGFMcjRIVlhQSWxqQmV0V0JL?=
 =?utf-8?B?M1NzS2NNSWxDWTc5Ri9rU3BGa2dqaTFERjUxL0RiSmNLckJDL29Ha0tYTit2?=
 =?utf-8?B?V2tYaU5SSisxb1pLQjNtZG1LZE5VSjZ0UXIrdFZmQ2dacEQxYnU3UHJvdTh1?=
 =?utf-8?B?NVN3akU0YUx1U043K3VJRXg3QnZKRDFYd25aSDMyYXdCUUg4U2VzeERPSjg0?=
 =?utf-8?B?ejU5ZEZRWURRV0VxTXVWYURhKzJEN1YyaTlBOFllc0lsc00xcVhvVGZaajBy?=
 =?utf-8?B?Ymlvc0QwWGJhbTRQQU9CaGd0QzBRUnZwT2xkYlhRWHFBRnRCUFNia0dxUTdY?=
 =?utf-8?B?N0gzdTgrSnhQSWQxOVdVNVByL1VTaTE2blN2ajRYZW81cGFDTkJEVWRrdmVV?=
 =?utf-8?B?eklreUZndWVhM0FvNWZ6Mnp5NTlNM0N5bFBnekdrbzFoMkdIb0tFK2sxWmJk?=
 =?utf-8?B?cER6U2M5Nk5WWEtIU1JwdVpucE5xQkZJalhzK0taaWFaTWVxNkRLcmNyaFUz?=
 =?utf-8?B?cloxNG9HM1BOUjhEQTR2N2xDcmNmRDNIaWh5bk5xRlJsTzFFWTUyeGhDWEdR?=
 =?utf-8?B?S0dmdk9tUmtvdzdnZXRQWlVJb3J3KzFVTmJuMC9OL0tTM1RHSndvWXJCa2Jk?=
 =?utf-8?B?WGs4UWx2cDUwNm9XaUdaeEZKMk0yZlJ2TGlqM0JWblNZZGxPQkNPQnhQaVhC?=
 =?utf-8?B?Ujg3UWRSZVJMWUJMY3A0a1QwQ3FuazgyZWtUeEJ2S3NKdGlXMVkvTHdkOTA3?=
 =?utf-8?B?TmgxeEp1dVM0U1dVcUhwK1BxT256aDRBdkZzTjdCVks3OWVnK0lKcEhETDhZ?=
 =?utf-8?Q?HRf6pOKcPW1X8G1+TqK4v/JgD?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 0294a174-0f2a-4efc-6479-08dbd51d8f69
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 05:45:14.5804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2dI1KKDjpF/rr91yKqvngLEqYq+vY+AH6uwDeIlS0kNjZSEcnVeQTdRVaHwJk9pG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9953
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2023-10-23 at 18:26, Andrew Davis wrote:
> The DT binding for the reg-mux compatible states it can be used when the
> "parent device of mux controller is not syscon device". It also allows
> for a reg property. When the reg property is provided, use that to
> identify the address space for this mux. If not provided fallback to
> using the parent device as a regmap provider.
> 
> While here use dev_err_probe() in the error path to prevent printing
> a message on probe defer which now can happen in extra ways.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Nishanth Menon <nm@ti.com>
> ---
> 
> Changes from v3:
>  - Check for probe defer
> 
> Changes from v2:
>  - Rebased on v6.6-rc1
> 
> Changes from v1:
>  - Flip logic as suggested in v1[0]
> 
> [0] https://lore.kernel.org/lkml/1c27d9d4-b1cc-c158-90f7-f7e47e02c424@ti.com/T/
> 
>  drivers/mux/mmio.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c
> index fd1d121a584ba..07c99588ff999 100644
> --- a/drivers/mux/mmio.c
> +++ b/drivers/mux/mmio.c
> @@ -44,14 +44,17 @@ static int mux_mmio_probe(struct platform_device *pdev)
>  	int ret;
>  	int i;
>  
> -	if (of_device_is_compatible(np, "mmio-mux"))
> +	if (of_device_is_compatible(np, "mmio-mux")) {
>  		regmap = syscon_node_to_regmap(np->parent);
> -	else
> -		regmap = dev_get_regmap(dev->parent, NULL) ?: ERR_PTR(-ENODEV);
> +	} else {
> +		regmap = device_node_to_regmap(np);
> +		/* Fallback to checking the parent node on any error other than probe defer */
> +		if (IS_ERR(regmap) && regmap != ERR_PTR(-EPROBE_DEFER))
> +			regmap = dev_get_regmap(dev->parent, NULL) ?: ERR_PTR(-ENODEV);

I'm not too fond of overly long lines, and the coding style document
agrees with me. Also, please end comments with a period.

		/* Fallback to checking the parent node on "real" errors. */
		if (IS_ERR(regmap) && regmap != ERR_PTR(-EPROBE_DEFER)) {
			regmap = dev_get_regmap(dev->parent, NULL);
			if (!regmap)
				regmap = ERR_PTR(-ENODEV);
		}

> +	}
>  	if (IS_ERR(regmap)) {
>  		ret = PTR_ERR(regmap);
> -		dev_err(dev, "failed to get regmap: %d\n", ret);
> -		return ret;
> +		return dev_err_probe(dev, ret, "failed to get regmap\n");
>  	}

Now that you use dev_err_probe(), please drop the pointless ret
assignment:

 	if (IS_ERR(regmap))
		return dev_err_probe(dev, PTR_ERR(regmap),
				     "failed to get regmap\n");

With those changes, you can add "Acked-by: Peter Rosin <peda@axentia.se>",
so that Greg can pick it up.

Cheers,
Peter

>  
>  	ret = of_property_count_u32_elems(np, "mux-reg-masks");
