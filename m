Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447A880DFDA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 01:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345403AbjLLAF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 19:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345478AbjLLAFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 19:05:46 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2089.outbound.protection.outlook.com [40.92.102.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0505DB4;
        Mon, 11 Dec 2023 16:05:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgLtPsIeTjGTdyKVpP8umzLWwLXi0c1AH1hWVaeiQJiPDTbveGD3iiGu6y1CS0A+G29jEDxGPBpLjwZCW06oJSd7fmKSS1p5kVUPvgV/5rJ3cf4oCp0MA6WoHbqG9dJ7NVNjBsZWr05zQBplkEBQlyarKhg1RfMKwZwfBmootow2PUX6HZ3vbYPWQ1UwbhHeJA/inVB1cCTbbCXH5hYSECpN5blnlN+Itwip3sURa9NbFfaupi7SMpyZ52FXwQKcoGAAr9VrBBlINTsevfONvlwY9iR4LUIZ3+Z2v6Z7UarkLM3Q4pzSNKkLBBO/bPf5Uy0D3xBFbHmUNNy7fqPTmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwfZoU4rKG+O2DDRH0pULZuKZ9xSueVisdie4Qy9ztw=;
 b=DpK8sud9zCyQaA5Za/SV5l/RAfRrRkVCfmH/G5IdRDdhObgVS2qciQJPP/oUfvVAac6lXaajL/FG0RViPfItP9Lo4SSHHnqvjP4vnRjBwgKM6W4ejKUXFieTljEJfXkuY7M283Vrat3Ue2is0CzGHsdfOFLRPRdT6zU72K050ThaqQlvO+UvvwDH5WMsqftoZ1oJlB+PVMnPWQNq5+w/QfXYSbwtC8B4/6EVVq5RUArvqqMAvP9bd7XGrSXreqUy+Vj7okB76z1YDcgMTFTXmksbQf/IwUHc+6BKzg+ofRYFNpPHBT4/neXg2ZUvojUtunm0gOmoYB7P4nsX44PqMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwfZoU4rKG+O2DDRH0pULZuKZ9xSueVisdie4Qy9ztw=;
 b=axDryxlZ7/mqQgBSYkdoEMUvagploqaNaQI6tbUBCH/a5BZf8OvFKC7qcCOS9NiPdLBz8OjXnWuhOxsWxf6tRhjrkBT+HiOqzHnGwXa85LsnJvxFBqT+lu4GhRtknjQacA6SOd166yaJj1kjfIQ8DDe5/l4f2Z3qbiE3Ec9Imd1iq8nYBVrmkF9MrLPBOSXdR8PLr4A1AdFw/bsF1yiCI2mymG87+jjY9prTrx/JS1hMUo6J0smvpYVUhq5pEDlAkwmU0te81xFoqiNt4V3EZFhJ9q+cru017K6VASmjCWBmbG3tuRxOedHKKs6bqwulI8rCqCc71ydB8gRXm33ijQ==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN2P287MB0908.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:134::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.33; Tue, 12 Dec 2023 00:05:42 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3%7]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 00:05:42 +0000
Message-ID: <MA0P287MB03321C6BF0556663B129A0E1FE8EA@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Tue, 12 Dec 2023 08:05:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] clk: sophgo: Add SG2042 clock generator driver
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        oe-kbuild@lists.linux.dev, Chen Wang <unicornxw@gmail.com>,
        aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
        guoren@kernel.org, jszhang@kernel.org, inochiama@outlook.com,
        samuel.holland@sifive.com
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev
References: <1a6e3fad-cbe2-461d-940c-601ab5197213@suswa.mountain>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <1a6e3fad-cbe2-461d-940c-601ab5197213@suswa.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [RNVkoVAqVWEupqnPK/J/FeKjzEJw05EU]
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <434edec6-4766-4944-9d0f-7067a5548d16@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN2P287MB0908:EE_
X-MS-Office365-Filtering-Correlation-Id: d4c86a93-261d-4349-7e89-08dbfaa61306
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VU4zL0Z3Z09zN3FMM29rYlcyYnppRk9YR3dFV3Iya3o0dGZYY3owTE1DV3F3?=
 =?utf-8?B?blo1Nkxlc0pzZmxIVXRnOTdRWDIxMC82ajlxd09FYXNLYk9OSytMejBRc2pX?=
 =?utf-8?B?b1lMRERKT3BIWFQ2NDdKSGEvL3FEUU1lb0JEaHBnMFV0MVFJQnFFTWtKOGht?=
 =?utf-8?B?SzV2V1FaVnh1d3hHQUNrUG5zYXdwK09oMFk3dUsvaVVYOWlWU0ROZU5oNFNC?=
 =?utf-8?B?bEk4bXFyS2diUUNTdzEyNmpNYTZ6cHhtbVVpYTFEcFV6ZlhBbjA5TlBNdXd5?=
 =?utf-8?B?RnowdXhmOFdnOTN4Qm9pU0dQSmVZbnFGZm9iZzJrQW91bGxGVVQrWTNwZWV2?=
 =?utf-8?B?dGdZSXBuZllPczE5bUVMRzZ0eVB0R3V3cTVhbDFvVWxPUCt3YkpRS01YMWU3?=
 =?utf-8?B?a1haaTNCd3ltZ255Zi82azBtUENvMXN3bGVpWktpeWdvQ1VJRGYyL3czNiti?=
 =?utf-8?B?czluSWYzL01UdEtqVkUzUkdpVXQzNEVRQ2dlNkg5b0wxWEtFamhtRzNMbms0?=
 =?utf-8?B?ZkZuK1dQYm1YY3lmZTRtR2NWRmlqN0IzS0FlUjVlNUNBLzB1Y1FoYlk3T2sz?=
 =?utf-8?B?dEdFTmZnaEVoQUU3akwvTHVMbWFFN1hQVmRVUzUzRUZpTGd6TFFFU2tjZkNU?=
 =?utf-8?B?QTQ4QUoreXErK0JxVWN0Q2x4TDdKYjJ6dVN1L2ZYL3RyZE5pMXRualJXZVdn?=
 =?utf-8?B?TWgxd1ZRQkJENEU5RzZDZE1qRU5aeXJTSTFyeWJVa01pY0Q0eG9VZzFzNFc5?=
 =?utf-8?B?WHRVbEhLejdvM3Y3SlRQYVhNa2F1dHBkbmJFQzJPKzh5cmVMYjh3Ym9xQzE4?=
 =?utf-8?B?TkcxZTV5Wm1IV0Y3ajFTaldmWHFRUUpSU2FwdVlBc0pTamtUVXlyWWFrUnpI?=
 =?utf-8?B?Z2JkWDRCTkJoNGRQaGhxejAyajQ0emZiUExKN095dHZ2UllaVHBIcTNhbjRs?=
 =?utf-8?B?RnhpQUxwaS8zN1l5WGRpaFlKWmFwcWhiQ3oycUgwRUo3NkthczZxWUpHRXZ5?=
 =?utf-8?B?SDVHNitMWE42ZjhwQzFremRMSjVmZm5tanZzTnAzUFh5Mnp5Mm9HYzRmM2Q5?=
 =?utf-8?B?dmJCSmNXelBCUFJ3MTJRVnNDMG5tYzM4dmNVWkt0eHdRZjBGcFF0UW9HNWYv?=
 =?utf-8?B?ZEg5allWTFpCcE8rY0VQTDhZTmxWbS9KRE5mSGZzTUFQZFBwRHVSVjVxSjd3?=
 =?utf-8?B?OWwwYzlPa1NVVnNlTExqbVNJaWhIUndBVzZsZ3FWek45U0ladDZHTnRlNnIv?=
 =?utf-8?B?eHg1UzR4RHgrSmFPNWpUc0ZIcXFxSElDaVo1SENMVHREVStsSVkxUWVPUnVF?=
 =?utf-8?B?VmdicW1LQmJKQUVncEVFNzRFV2Y4TkcxVzlERmpTL3RpcTUvcURaS3lCL0hu?=
 =?utf-8?B?K3JlU0tmdTBRWmplNmhNL0N4TnJ4ZDFQRGpPMFVZRkNsVEtNT3VMRDFJWm9n?=
 =?utf-8?B?YUxkSXFCeW9sN0FtdGVuNW40Tnl6dkZ2cHJOYjBDeU9xNndTNnF6aDBNMVRS?=
 =?utf-8?Q?ztT7AQ=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmtkeGg5V1ViQmJ4azEwR2pHUm1yNWY0a3VEWU05UVVWWUdmK21OL1NlTXpD?=
 =?utf-8?B?R2srWTN1VFhwUFdBZlFyTklsVTdnWXNOUnQyN2tUMktidk9mU2VYRS82VDdt?=
 =?utf-8?B?K044MHViWVFxV0pjN1VPdnFWajNZRHNmdXFiY0xvcWJ6NTkxSDQwVkk0M2Fu?=
 =?utf-8?B?ODcrMzIwcU13ZGRjbWNYUllhU1lBanVKMUpFcjJDVEJLZzMzOVBDV25JeFpI?=
 =?utf-8?B?TzFxcHhKQ0N6Y21KZ255d09oQ0J0dE9USEcyM2tGb3J3UGlhU3A1anY4dElV?=
 =?utf-8?B?bWQzZFV1ZVg0MEJUeTZtcCt6c09oaThuM2hHN3FQeVlycTl0T08xYW5vbFNy?=
 =?utf-8?B?ZnlEenlTcUYyQStONDRneTNqeHUxNWNyam81eDB4T203b2R2QXBRNmxmNlBK?=
 =?utf-8?B?WkNDcEx0VEtMT1V5Ti9sK2FKTU84bkdsbHNsKzdvZzlkTjlHT2g2V1AzbnBJ?=
 =?utf-8?B?Nkg4cnRFY1lsRnNqU3ZTQ005Uzk1eUhHWVlPTzV0UnhhNTRuQy94Tll3b1Np?=
 =?utf-8?B?VmhLVVdZTW02Tmp0T05CUHJWeGdnUWw1S2RzOUcyN25xQ2V3dGJMbWdXRzQ1?=
 =?utf-8?B?dVF2cmxNS3ArRmZIMnp0SktMRElsOW9hVE5iL1YzVGRTWGdQb0ZpbUZJTWxP?=
 =?utf-8?B?YlQyZytNZWpKbWNjSG9Jdjg1aG9Pd2Q0VWI2eU9JSnI4a25xQ0NZRVFhVW5T?=
 =?utf-8?B?NUU4M1JLRU9zOXJEVW9SRDBpakd5NVp2enlaTnNOdTNySE1Zbk1TWkRlR0dL?=
 =?utf-8?B?RHZMMFdIUHI2dGRiSXFKdCtoNS9tQW5sd01Td3JyMmZwUXFFLzU1NVVya1RO?=
 =?utf-8?B?U1JUcHVLVTY2amRkSDhTR0o5T3B1MXRFUE1VNHZGRW5sTDkyZnc0ajR4eTFZ?=
 =?utf-8?B?UUMyamlBSjd4TDBTMnp6N2RWeFFYV2xMVjluVlhuYkRrdkQwajVDL2hmVmlP?=
 =?utf-8?B?OWR2SUpobjVDRGtkUHc4Q1ZzeDVSbHBUYWI5M0FDd2lrakZ4RzY1S0c0Z3h2?=
 =?utf-8?B?RE5HR01iWHB2SnVWV0gyNDhCZnVrUzM5UU5CMWtoRWF4L3Y2cnVaV3g4bzhH?=
 =?utf-8?B?a0N5K0lFbktFTUFYL0ZSWlFzVE80emxxWmwxNnR6dGdvTGczYlZDWTRqTDds?=
 =?utf-8?B?TGE4ejlyUjgyNTV6c0tKVEk1c0tvYlNOWWxwZWs5c0NNbFlVQzA1bTJ3MEpi?=
 =?utf-8?B?QkpxNVY1cUJCVlpKb0c0eFh3VzlHTnBLRTkyNmZGVG81V0NEbXAvNkJwTmFy?=
 =?utf-8?B?bnQra2x0VHErT1dndjhuT042b2VGSk5MaFdVcE5RUlZoTko0c3o5U3dYLzNw?=
 =?utf-8?B?Q245VG5RVU83c05HdFJQT2FKeFhQZDRNQTRQV2lsekZxMXlIWDRDUzdaSmln?=
 =?utf-8?B?REhJMytFcm1Yd2JKQVpvUEJ4N3poWXhPWnpoQzZmdGFjcUlOODZtV2NsREZi?=
 =?utf-8?B?YmdLWFdwczFnZHhTOGxsa1J2UjRRQzdqTDgvb2tzL2xDUUVsTDBOWWppOElO?=
 =?utf-8?B?SVp6M09UVGVKTE0yeDZuK1BMTVFmcnQzYVFxK2R6RXFYTHlCRytuWC92WjBu?=
 =?utf-8?B?b1ZrRVJycitoTEozTTlFTkxnWkNLa2NCWk1LM1VTMjdNS1MwTTVoNnRmcWZz?=
 =?utf-8?Q?EhGOfM+FkI38RlKDf4ouhc8WiP0JLJYl6Dd13P5j99Tw=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c86a93-261d-4349-7e89-08dbfaa61306
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 00:05:41.1112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0908
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/12/9 14:22, Dan Carpenter wrote:
> Hi Chen,
>
> kernel test robot noticed the following build warnings:
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Wang/dt-bindings-soc-sophgo-Add-Sophgo-system-control-module/20231208-091702
> base:   b85ea95d086471afb4ad062012a4d73cd328fa86
> patch link:    https://lore.kernel.org/r/d1aa4f76f360ebd7b790a4786641f1b0188dbba8.1701997033.git.unicorn_wang%40outlook.com
> patch subject: [PATCH v6 3/4] clk: sophgo: Add SG2042 clock generator driver
> config: xtensa-randconfig-r071-20231208 (https://download.01.org/0day-ci/archive/20231208/202312081933.MUdHNASt-lkp@intel.com/config)
> compiler: xtensa-linux-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20231208/202312081933.MUdHNASt-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202312081933.MUdHNASt-lkp@intel.com/
>
> smatch warnings:
> drivers/clk/sophgo/clk-sophgo-sg2042.c:1282 sg2042_clk_init_clk_data() warn: passing zero to 'PTR_ERR'
Thank you, Dan. I will try to remove this warning in next revision.
>
> vim +/PTR_ERR +1282 drivers/clk/sophgo/clk-sophgo-sg2042.c
>
> 7c68ebea1041f9 Chen Wang 2023-12-08  1258  static int __init sg2042_clk_init_clk_data(
> 7c68ebea1041f9 Chen Wang 2023-12-08  1259  	struct device_node *node,
> 7c68ebea1041f9 Chen Wang 2023-12-08  1260  	int num_clks,
> 7c68ebea1041f9 Chen Wang 2023-12-08  1261  	struct sg2042_clk_data **pp_clk_data)
> 7c68ebea1041f9 Chen Wang 2023-12-08  1262  {
> 7c68ebea1041f9 Chen Wang 2023-12-08  1263  	int ret = 0;
> 7c68ebea1041f9 Chen Wang 2023-12-08  1264  	struct sg2042_clk_data *clk_data = NULL;
> 7c68ebea1041f9 Chen Wang 2023-12-08  1265  	struct device_node *np_syscon;
> 7c68ebea1041f9 Chen Wang 2023-12-08  1266
> 7c68ebea1041f9 Chen Wang 2023-12-08  1267  	np_syscon = of_parse_phandle(node, "sophgo,system-ctrl", 0);
> 7c68ebea1041f9 Chen Wang 2023-12-08  1268  	if (!np_syscon) {
> 7c68ebea1041f9 Chen Wang 2023-12-08  1269  		pr_err("failed to get system-ctrl node\n");
> 7c68ebea1041f9 Chen Wang 2023-12-08  1270  		ret = -EINVAL;
> 7c68ebea1041f9 Chen Wang 2023-12-08  1271  		goto error_out;
> 7c68ebea1041f9 Chen Wang 2023-12-08  1272  	}
> 7c68ebea1041f9 Chen Wang 2023-12-08  1273
> 7c68ebea1041f9 Chen Wang 2023-12-08  1274  	clk_data = kzalloc(struct_size(clk_data, onecell_data.hws, num_clks), GFP_KERNEL);
> 7c68ebea1041f9 Chen Wang 2023-12-08  1275  	if (!clk_data) {
> 7c68ebea1041f9 Chen Wang 2023-12-08  1276  		ret = -ENOMEM;
> 7c68ebea1041f9 Chen Wang 2023-12-08  1277  		goto error_out;
> 7c68ebea1041f9 Chen Wang 2023-12-08  1278  	}
> 7c68ebea1041f9 Chen Wang 2023-12-08  1279
> 7c68ebea1041f9 Chen Wang 2023-12-08  1280  	clk_data->regmap_syscon = device_node_to_regmap(np_syscon);
> 7c68ebea1041f9 Chen Wang 2023-12-08  1281  	if (IS_ERR_OR_NULL(clk_data->regmap_syscon)) {
> 7c68ebea1041f9 Chen Wang 2023-12-08 @1282  		pr_err("cannot get regmap_syscon %ld\n", PTR_ERR(clk_data->regmap_syscon));
>
> I don't think device_node_to_regmap() can return NULL, but if it could
> then it shouldn't be handled like this:
>
> https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/
>
>
> 7c68ebea1041f9 Chen Wang 2023-12-08  1283  		ret = -ENODEV;
> 7c68ebea1041f9 Chen Wang 2023-12-08  1284  		goto cleanup;
> 7c68ebea1041f9 Chen Wang 2023-12-08  1285  	}
> 7c68ebea1041f9 Chen Wang 2023-12-08  1286  	clk_data->iobase_syscon = of_iomap(np_syscon, 0);
> 7c68ebea1041f9 Chen Wang 2023-12-08  1287  	clk_data->iobase = of_iomap(node, 0);
> 7c68ebea1041f9 Chen Wang 2023-12-08  1288  	clk_data->onecell_data.num = num_clks;
> 7c68ebea1041f9 Chen Wang 2023-12-08  1289
> 7c68ebea1041f9 Chen Wang 2023-12-08  1290  	*pp_clk_data = clk_data;
> 7c68ebea1041f9 Chen Wang 2023-12-08  1291  	return ret;
> 7c68ebea1041f9 Chen Wang 2023-12-08  1292
> 7c68ebea1041f9 Chen Wang 2023-12-08  1293  cleanup:
> 7c68ebea1041f9 Chen Wang 2023-12-08  1294  	kfree(clk_data);
> 7c68ebea1041f9 Chen Wang 2023-12-08  1295
> 7c68ebea1041f9 Chen Wang 2023-12-08  1296  error_out:
> 7c68ebea1041f9 Chen Wang 2023-12-08  1297  	return ret;
> 7c68ebea1041f9 Chen Wang 2023-12-08  1298  }
>
