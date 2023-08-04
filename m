Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF525770421
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjHDPL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjHDPLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:11:48 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A458C4C0D;
        Fri,  4 Aug 2023 08:11:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Or9u4/jF0FrENp9NYIAX2kNP7uCKNR304iEhKCeI6p3CIF07QFHsW07IgMEhSRCQFaPcfHiqvv7zifUoTCEqMdK7EBf9/oRYd/QTzD4ZVTrwnbwvofcP+SXAgwe0c6PC5yDo4uSyl5knh48Zv96QJSehi6JFtDu6FB2VXOPAmHrHxuExDVWDJBLAPhR1wHYnSr7aAbSPxciVAt7LrE8FO1Gjmz11N0hyxIt37XxKLpWn5Btb/lkfLxCuEPJxxeJ5ENhhmUyRyNNaxy6ucLFasXbUCTkPtSnmh7pEzB0iMDqB6zpVcsGpYE1643dU2xxvDFqclZWwnI31QO4DlA5/rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LClNqNr4jHDoCc+3ZN0rCOV65ruhdO76AS3wOe1oD/w=;
 b=VQyZuaTPEKvTUAHhbiG1GumdYD7Lk73GdqDZ4wfH/7jplNgpKI08HDu9lr2uUk/4DRkhIMP+PRl/Gvy136Ua+CTaOzOE247US5lJhhLT0tSwhqyiApM05y7bAn6EsnUeNEY+cEWBO15PvI/4m6egafpqhy1qkkgdK5aYhFqmmXYbJTaDA1UzeSr2AuzrUC1lJY9aEh8D973ZvmLTHxYvjw6qzi/LJvIG/Ks4v4fIfVuuo1qQAy+0PXocbXjs8oWwGqcg7/v3nLFBTomoG9wbLENscKtZY8/jBiCcx1UD3SBRreAShZGJF9gEvkGsoB2PhviyEWrdg25mYEVrGewiWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LClNqNr4jHDoCc+3ZN0rCOV65ruhdO76AS3wOe1oD/w=;
 b=izHSysVQFVFkK2gffMfw9bHWwQ+3W4uy+n8EX4dcU1eVOWxlr3UajaPgPyRcHmqGKRxMHs+veBeTt84MaJN7HKLC2Gx9fS73JKnDLcfVs8ov4nMfOp5GRlIQpN9Hm/HhHl1xumLwYuZbe7TAdpEPTc1W5E0DiEBHyNEGXWUtxvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com (2603:10a6:10:368::16)
 by DBBPR04MB7980.eurprd04.prod.outlook.com (2603:10a6:10:1f0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 15:11:42 +0000
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::179f:1c4a:4573:acb9]) by DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::179f:1c4a:4573:acb9%4]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 15:11:42 +0000
Message-ID: <485cb11c-3e34-c4a3-bc63-87ac505b7bb0@nxp.com>
Date:   Fri, 4 Aug 2023 18:11:33 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 16/23] bus: Explicitly include correct DT includes
Content-Language: en-CA
To:     Rob Herring <robh@kernel.org>, soc@kernel.org,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <atenart@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jean-Marie Verdun <verdun@hpe.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Heiko Stuebner <heiko@sntech.de>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Has him <shiraz.linux.kernel@gmail.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Jay Fang <f.fangjian@huawei.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michal Simek <michal.simek@amd.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-rockchip@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-mediatek@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-pm@vger.kernel.org
References: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
 <20230803-dt-header-cleanups-for-soc-v2-16-d8de2cc88bff@kernel.org>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
In-Reply-To: <20230803-dt-header-cleanups-for-soc-v2-16-d8de2cc88bff@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR07CA0020.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::33) To DB9PR04MB9380.eurprd04.prod.outlook.com
 (2603:10a6:10:368::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9380:EE_|DBBPR04MB7980:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f6b8a41-5b7c-4355-f475-08db94fd1c0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E8hWa6LySNFZyERpdjjlqYEefw6+BZDOiy0IeujDexNPEW3v3efrSBly/QiAGzQ9bMOtg1AVTHpuwu/i6KM+Jx8L6yC3XNTUwCx+qnbwGE48/RnIvUgEjF1juQJCVNmjO6NEVEmfAY/maFpj9unbrY2PHOlfuEkaisjN6KjpRkvJw6nP0f/nehX1FE7OOZH7kbaHNfZGa/4yN1nJQ/82EHTpEemTAkF/rVNKI6Si4GLFFO6HZ+OztNtCnwYTFRJ5L4nxpMFfUc9TF1qHIqlE0C/iSC7WuFDNI2akvfXc0itE+7AdPNxABT3cpM0CmfQ/WCTIWAmREtmJo0zttF3gW4neSBYpWEHwmxX1Tb9XhEf4zU8ipXMlZV++rX+2QtaTQOwO/WwW4o7sv96VYYI3ZQNJ5rtrCrHUwWb8OXaxHHI2UjOY36glJEmpF5IqH4DiyjNAa+Arz5tbTGANqLxNFDKllMoGwUfAHMvfWiU5VgppC1KOLT+oMJdUyG8ouC/er73Bs0lKjuqD4RHz6R28obOSFwMNr5pEW0wVOs740a2AAnZDg/H9clR6T/t99O/rsQxnMKH0aEEOwXg++DLwuU+0FaTWJ7dWEE6i5/zbEITolGLZUhWQEgMRdDmIByQ65mIVmDnhFeuoLpyt49YtmNVW2O6TAhYSK1NS8LqPY7UPtBB15A0GdBJCFUK2cDZUfvQosvA03t8Cj72ov8XBmjImEZ290cvcyFHjCoTjc90=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9380.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(186006)(1800799003)(451199021)(31686004)(66476007)(66556008)(66946007)(110136005)(4326008)(6636002)(478600001)(316002)(6486002)(53546011)(55236004)(26005)(6506007)(6666004)(41300700001)(8936002)(8676002)(52116002)(6512007)(83380400001)(44832011)(7416002)(7406005)(5660300002)(7366002)(2906002)(86362001)(36756003)(2616005)(31696002)(921005)(38350700002)(38100700002)(41080700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWl5Zm4xM2xzZVVwNUF0NUdZcHYxOXRnQi9jWVlHUk5FdmdXWGt5Y3hlZWhn?=
 =?utf-8?B?T2MydWJvMzA5aTExU1ZKcXRwQmljQlM4M1ZSVFZ0c1g4TzlhNGFaMzBLL1lF?=
 =?utf-8?B?TW5pZGJWTHFUMzBjVTBIRmNKZldvbFJoK0VpUzMreDdQL011VTNNY3lmNmRT?=
 =?utf-8?B?TTUvT2N6WndvMmJQSlh4b3BPR3k2UWpSR3Z4aVRqcjJlOVA2MGxid3FOZVRZ?=
 =?utf-8?B?WmtFVHZkc2FTYnZ0aURySXNXNGVBd2phZ2lQMjVRRDdXSlh4Y0ozMG4yOWFF?=
 =?utf-8?B?bGRkdVpWWE1PNHV6OHo3VmlWWWdHRU9SOW9XZllJR1lBVDZlZWRMZVBhcHNi?=
 =?utf-8?B?TTJVNzIrY3Avc1VZR3RqdTkyejlFYXpKWWc5ZGlVOUwwT2ljSzZjSWZYRUdi?=
 =?utf-8?B?MkZEdjUxVmp0SHhSc1pRR3FMNkFGYVg4OU94WlNOaHZxT2RPeTJJSWtkbDRa?=
 =?utf-8?B?SmU4WnBXbElvYkNtTmszVU1LQmpyQVNhNTBVK2gzL252YnlLTFZZc1B1VGRI?=
 =?utf-8?B?QjhXS29tQUwrTjB2RFNvTUpPUmJucjN2dGNWNnExa0JvZ0dCQ2M4SzRpaHV5?=
 =?utf-8?B?NGcwNkJUSHBmTUdlYzMvMzB4Y3kvL2dsM0l6TmxmWFdNSnpxTUFRdHZIb1Fj?=
 =?utf-8?B?T1RzbFQ0SFZtQmo5Q21uOWNuVFZjVE1vQzc4T2FqS3ZjUy95QUxzUnFycm1h?=
 =?utf-8?B?MmlKcDZsN29VVXQrY2Z6dEZPWXdrZ2RnM2dPTi9NQTF6b3Mram9ZajB2ajFT?=
 =?utf-8?B?aXNOdWxxQXk5UzQraDVNekxrd1RJY213M0g1ME82YUhZSWx3QXFkbmdpU2pO?=
 =?utf-8?B?akNYRURSVUxTcmxVT29xeGlISkJVcVZjdTFyZlgyaXZKeGRRam4zQXI5bG5C?=
 =?utf-8?B?enZJRXNGeGEvZmNnYzBaUVRicFVteCthYjk5RFlaVHdZdVJRVGhPTDM0U0h2?=
 =?utf-8?B?ZUQ2Yjhwcm1wSVBVaHd1ejdKTWNVOXBNaE4wL0s3N21IakRQSHhzN3BPeHZJ?=
 =?utf-8?B?UzlXcHJXTEYrNVY4bVVGc3pqQ1NpMENucmU0eEVjSDRERmF2cEdvS2tWVVda?=
 =?utf-8?B?NHEyamtoNnk5ajIyOWFzbktMdzhkRVBBTUczaU9qcEZzQjQ4aDQ2RUlQUi9G?=
 =?utf-8?B?Vm9Zb2N6cUs0YUd6bGRaUW9yR2FWZmNEbUpYdmxRZUlibm5LWjZpa1ljQk5j?=
 =?utf-8?B?eEd6Sm5iQ2xQWDFEY1phV3ZMc05iQTc5M3pEbnBrdjFkVFFrb3MzdVE5bldH?=
 =?utf-8?B?blNqMkFEZ3lIblFTOC8rcFR0cHQ5enE3ZS9HZGZEdTExc3paSldEUENqcG9p?=
 =?utf-8?B?RUNidzZhNGdsTEtlQlRlSVBuUndjZmwwbzQ1bnAwNDZtWU5kd1M3bnJuT3B1?=
 =?utf-8?B?eDFNTWdiZm9MV3B2NTFzSGZDQi91cExPemhOQ2htNHZIbldFZEN1bDZ1eGk4?=
 =?utf-8?B?bDJrNFlJeFdCeUVTWE9GckNqa2pDT3RJS3pUVmFXR3dhd01NaERXRVJwT3Iv?=
 =?utf-8?B?MklsQ0RjUU5lb2dmamN2TzhLOUtKaHlqVzNZRlRSeVAvc0hJNEUrZkVjYW1L?=
 =?utf-8?B?NUl3ZHAwTjhOZ1hRVzhVeis1bEVWb0h6VDVqYlQvWjRIZmw4KzhkeFl4Nm84?=
 =?utf-8?B?TmExbk1UKzNEYVZmSWdWb2o4TFl5MGRaZlY4NFFZdVRYV1BlYnMybUhpZmhW?=
 =?utf-8?B?TzBYZENJaTFLN1RqKzJ0OVhvaDEzbS94dVJxRDZkVjkvM0RvbmtQckZYNWNW?=
 =?utf-8?B?TVFUdXAvTmZIRSs2M3p4TVBBSEl3eXFSeUZBTmlDaUxyU0srZkprMWNpUjlN?=
 =?utf-8?B?T3N5VGpLbkRlN2NEM3dDUm9ob2ZodkJ5L2F1YWdqaWJtbWVwUkkwSUdFYjAw?=
 =?utf-8?B?MEdKKzNQT3doajVjUXhVN2dZZjFZK2xybHdMZzBoMWtGSFN3WWltTXdPRFFu?=
 =?utf-8?B?dnhwNFgza3U4U2ExYlFFZjRFYjlqV3BXVy9wemREeTRhalVUc1JyY3pxTWJC?=
 =?utf-8?B?akVXSVY5bmFlWTdTeDU4SjFibjZBV0x2dlpRTGw4TG84VmZRTHNCK2dVaGd6?=
 =?utf-8?B?WENXbndGbzM0N0xUSkJ4dmxuK3pYV1dPQ2RSS3ErWUluTUhrS1l4T2FoY0Ez?=
 =?utf-8?B?WXMxYkNEZlczckloVHA5SkxjSU1uc2ZCZzZjY1BmK2hybVFxUjJKQWc5R2FJ?=
 =?utf-8?B?cUE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6b8a41-5b7c-4355-f475-08db94fd1c0e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9380.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 15:11:42.5370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qwPJQgbYeCNOB28yLj0YdYb1lDAXIIPZhTfGSCpCLWGxU0pNBySRHyzXLNi/PgSQxo6sJz31YjXGil+r0BoYAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7980
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/4/2023 1:42 AM, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   drivers/bus/fsl-mc/fsl-mc-bus.c | 1 +
>   drivers/bus/fsl-mc/fsl-mc-msi.c | 2 --
>   drivers/bus/hisi_lpc.c          | 2 +-
>   drivers/bus/omap_l3_smx.c       | 1 -
>   drivers/bus/simple-pm-bus.c     | 2 ++
>   drivers/bus/sunxi-rsb.c         | 2 +-
>   drivers/bus/ti-pwmss.c          | 2 +-
>   7 files changed, 6 insertions(+), 6 deletions(-)
> 

For drivers/bus/fsl-mc bits:

Acked-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

---
Thanks & Best Regards, Laurentiu
