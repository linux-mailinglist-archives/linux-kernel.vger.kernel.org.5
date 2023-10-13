Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7A17C806F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjJMIg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjJMIg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:36:26 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2099.outbound.protection.outlook.com [40.107.20.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260ECA9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:36:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jxl3l3DSDfpNlLUscIOwiA+BelMLKGGhPiMi08NBwJdpEqhsQqEIHvdLMIOIP79QhQgJ1ZVukiN1AwZ464BB8zn/NIwH+s8G6tRnOezZAPE3p/5/PZBgRanlGtIBjeg7/AamnBwLSvT0o7IYyiw7gcbLdULy4Yn4onZLoNfNzQji18gbmX6PJzsDnV9XgW5L+yykoap92v2WndNBsGFOSjrSwjkfMAeVbGzGXWUNtjhaznFaLT3h0hg+vwIas1bLViLRCa7Bpn2fHHEsGuqpMZ2w/uwr3807P5Fi+yunX4+pQXM32aYywkgQQJWGMZk4p2ub0YrCC7Kw3nxmpZPZ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXDgKuc5gSwGS/J3ku41MRiw0eIi2ol+VfI8tTSFKeo=;
 b=AVFQK3Tuzqww0H3nieXCh/11LuArlEKXaeZ1480BV1PVg0QusumweWeUL5qXKFq63ihqI9fnlTiShR5ImsFxMGk5XyWtTibZZZnIj8THkQ1Ljwp3qHSPcD3xkNEsSCHn6uq1epUF6SS/TMLJXCeOXuxgMyd6kSZNxHzIiIzm55UGxm+Syfkmcyvmz7e+qK1LntaN4t7TB5imlrg3/EHq4zfIYs32uFZQuBZDPOu4GTNGh4ZxNz9gFArvDcij+wLVGKbNNX734isalYL0AI2g9YAtXNebqsVkpJNfwihd9A8Qj31eQ4g0b/PyQ8phynkiCKP+8ap24JHf4Qu29NRDhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXDgKuc5gSwGS/J3ku41MRiw0eIi2ol+VfI8tTSFKeo=;
 b=IY+xoAOF32fId+AsEOPXZ0MlOAPRq5D86TvIZ344GM/R53V/vqXVylnB03FdakGFoxIqcZmvX9SGaCgG+hQNmzrvd8G6uV7uTmSZQDnsMfzVOpACwMd7tgrLgmJG8bEXVUqBoMQnt9KEM7Acv9rwx2S5WVp+89UEs8M9FsSSt3g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by DB9PR02MB6858.eurprd02.prod.outlook.com (2603:10a6:10:21c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 08:36:21 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::4ba4:83a5:e60c:3a5d]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::4ba4:83a5:e60c:3a5d%7]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 08:36:21 +0000
Message-ID: <ba8d31bf-28f5-d8a1-adff-1b9ea7c3a578@axentia.se>
Date:   Fri, 13 Oct 2023 10:36:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mux: Make it possible to select MULTIPLEXER if EXPERT
Content-Language: sv-SE, en-US
To:     William Kennington <william@wkennington.com>
Cc:     linux-kernel@vger.kernel.org
References: <20230926230712.516709-1-william@wkennington.com>
 <aa4591dd-b558-3401-4a19-362780ec321f@axentia.se>
 <CAD_4BXhWbUxuidM47poTKFYYruL5jdJyPUfoZvXnqwDNNLd98w@mail.gmail.com>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <CAD_4BXhWbUxuidM47poTKFYYruL5jdJyPUfoZvXnqwDNNLd98w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0113.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::19) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|DB9PR02MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: 43916d77-7492-4321-09c8-08dbcbc77a07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wob2WQUoR35LlwRQXveHOqI/dmX6Q1Xb/UxLm2D/qweJaDKQhu86yYJbVPag1LZ4wS/+7nZVaRHxoZTOz1/qikmsMFjbuC7SThY6Dn3Jp8m1VbQ/jmrOTRiW7RR0Vqr53DFQ+xf1hZZDg26jDPCtGjl2myv9t0voedTGgfO12mmJB1KcQ5FxTc2XLQNogw4CPlnoTc+N4ASdAxdmsoKaju8Y4JhTPyvX2+hiR7s3dMiDPRPjDBjSyq79ZCkAbpv5yadBd75wqx4KzU2toPfbb00eEP4MUjU8WyVp8wU+AaM4Q1359si1uFKVjVQ7Xs6dcWHFPGzNqmsOUj0er7vOKxP0q9mKtckMx7Iv8RSOQDMHO//0TOSD+V0a0BiCVfwcPPDm/NF+izxXZaOdU8JVT9h1yaT68CeGyCkUfO7zgjCIFTCSRSdTg93Xviw74QUJBs77mtU63vdUrogIrsUPMRMwSLOYeVq1OdCBeRsm+F2iL2aXAwwWcCEZ83/X2UEEk2NGJ6s8FJ8sJw9831yzROynKbG8+26M3G7PfGxAJtuOsdf67vF7Ns7f6h8f5FzPgbDjkkxs2tCWVOzN6OzjRxs9HT05SpexKC/XHQrjxzpykDIUHmbK4TP/RWLzJxVL/J9BtOv/vNAoWp8MjO3tZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(376002)(39840400004)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(31686004)(6506007)(83380400001)(26005)(38100700002)(6512007)(86362001)(4326008)(4001150100001)(2906002)(31696002)(6486002)(5660300002)(8936002)(8676002)(66476007)(6916009)(316002)(66946007)(66556008)(41300700001)(36756003)(2616005)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkRpSkZmNjJtamlOMUFjTzlMdk85Nml0aTRCYzlVczRtbU9YWHloOXpCN3g0?=
 =?utf-8?B?NFhCRnFhUXV5OTdHN21WZklwNWlhaFhoNHg5YzRVR2Z4R2s5MElrSTBtbVQ3?=
 =?utf-8?B?RDFMSzF1ck93ZVp0WEFidFhUblJEaDliZTVNTHkwWnpueU12S0ZzbWlGV3U2?=
 =?utf-8?B?YVY3aW1JUm9pcWpIMXhkRlpvVklSRlJxYkNWdXh2c250QnVIbllJQTgxb053?=
 =?utf-8?B?eW44TmxoMEpRQ0ZhNWJCYzFwdDBITHMvcXFxWHErbVdrdFNkcG9GS0huR1Vh?=
 =?utf-8?B?R00rUlQyeVhENCt0VU1qNlF5andNbGJaTXVWWmMzRTV5T2tFb1dOeTZVMTZO?=
 =?utf-8?B?UlQrdnN0WDFjcWFURGRCTjg4REFmcndYUTRwWFdoeWs5OU9JTW9yMUpXejJz?=
 =?utf-8?B?RUxsSWFCRVdJbGFwODNkRGdFU2M3QUxTdnR5SHNuRVl1cVo1ZnVZa0FwUG5B?=
 =?utf-8?B?bU5uSnRoMzgwRDVPRytxREhlWHdLSldiaVVPcFppMWJoSHB3Z292ZWU0RzNT?=
 =?utf-8?B?b3hqdWg5cDN0NzRMcmp1RTcweEs0cFFUbmFsaTdzWFFzRTRtcWdRdFl6bitF?=
 =?utf-8?B?RThndC82ZlV0dXROYWEvaW1WNG0rS1dnc0JWSEsvQ3JsdnFiSkE5UGRBU21J?=
 =?utf-8?B?L2xEN21QamNwMnRjY21zcGJlSHNoUmlyaWlldUE0TEwwV2hNaW9Mc0dtSitr?=
 =?utf-8?B?K3BpVlEzV3FSZzMwMXNiZXRNNGVKMjRrZ2JyY3R0dkpIUDlkRDZYZXMwbFgy?=
 =?utf-8?B?OENJOWlRN3ozN1hQN2NsdXZJNFVBMERydDJPbWxjMCtsdndGMm4zNFZleXhL?=
 =?utf-8?B?R0xyTWpSMWNOL1IzcUIxZ0FvelJJRENra3lGMENMelhWNXBMZVpvYXcyZWpz?=
 =?utf-8?B?U296Z0ltYW1TbW5odStWWVQ1VWl3K3Q2R3NWU3dnMEZaWHRza2dpc2JRRkto?=
 =?utf-8?B?b3ZWTUM1VHZrdmpRUWdiMWREbW11Y081bk52Ujl5UTIvOUZ6WENxWEF4TzZ2?=
 =?utf-8?B?UExMMVdWT3VSbU5sSlRESlVibm8rSGJPWEZ1a3NSck93SkRUYmpJNEJOQmFk?=
 =?utf-8?B?Y0ZsMGl6UnRUdG1nTUF1YnJuRHgvbktiSGFyWU5Cc2plNlUxNGgzOHVVS014?=
 =?utf-8?B?dTgvWnQ5VDdGTDdmNnVZSURVNXVXRlNYeHJvcDJDN043Rm40ZzF3ZVBMV2lB?=
 =?utf-8?B?VDZFREl5R1FJdXVJakNEY1RValVoY0Y4QjRmU1pnWmpZdFhIKzl5Mmh5MmdF?=
 =?utf-8?B?RE5WQ01DcnAxZ2tJS3pESnVRUTIweU1lNzFlT1Iwak82Um84bHdBRDFCaTUx?=
 =?utf-8?B?UG9lcGlMWktmQklPR2t0azBRSHVudW9hNTc0ai9DN0NPZmdxSmk0NWNqM1p1?=
 =?utf-8?B?U0lZNkRXc2pnVmVHQmU4c2MrNTVvTElBUVh6YXhXSzZBS1dZYi9nVld4bGJs?=
 =?utf-8?B?QzZUTlQvdEJKN0M2RThUSHB0RlpQSVlDdkpMSVd5a3h0cXpjaTRFcVpRbFE3?=
 =?utf-8?B?enpRcmRhZ0hYcG1yTFR3bVhSNnZXOEZ3dE1ZdFBTVWloQXBQSVpjRmkrbHZP?=
 =?utf-8?B?dDVUZjZ4QWxjUVhZQmxtYWp5RnRjcXZRU2FjUTNNNkRTSG9WRkwwWVEzNDhk?=
 =?utf-8?B?T2F6aG9qZG9IQzlDc2xiL25jTlZTSTZncFd5bWszaWczY2l6emN1RHpIOGxK?=
 =?utf-8?B?T2dsSDQ4akdUSmZVdmc5YW9JdEwrWFV5NE1ieFAzUFAzVzY2NkZpc2VBTG9Q?=
 =?utf-8?B?VDdzU0M3Q1hrK2VnWW1CNStKQUt2UDVnbUZOMk53VGp5NG9vN1FMQVBkb0tH?=
 =?utf-8?B?UEZzT3E0eGM0K0NmcithTll1VmViaG14K2twclZacFNhZjkrN1RSczdRK0Iz?=
 =?utf-8?B?eFAvK1pXMW5EY2gzSmNxcVRBMURFeEpkYTViZ0JITmVwZWxhNkxzeWpUQjZ3?=
 =?utf-8?B?K3B1c2hJL2pWYlEwVnA5djVNOG9hZWxyWHYrbG5NbWFUeUFldmpVUmNyWUhl?=
 =?utf-8?B?WFdKZ1E5TjZmS3hkbkpDRU5SSlpIbDNGQW9rODhONEJ1WWtJY2pjSm9qbHpK?=
 =?utf-8?B?dGRSZFgxWTJWcXRaVENndHI4UmVFVmxvNkRvbGRLRGFTQ2R4Q0tGclkrQ1Bz?=
 =?utf-8?Q?qVndz1c3Igly8R2pkmlugjA4s?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 43916d77-7492-4321-09c8-08dbcbc77a07
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 08:36:21.1102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +e45zfCMvfiBPaJEeubotC4UX7oUxk7PfWpt0fzWbVJm+s504X9epzZ72vnZ2dup
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6858
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

2023-10-12 at 23:52, William Kennington wrote:
> On Wed, Sep 27, 2023 at 16:08 Peter Rosin <peda@axentia.se <mailto:peda@axentia.se>> wrote:
> 
>     Hi!
> 
>     2023-09-27 at 01:07, William A. Kennington III wrote:
>     > Right now, there is no way to enable multiplexer support unless another
>     > config option selects it. When using `allnoconfig` with CONFIG_EXPERT,
>     > this is deselected with no way to enable it.
> 
>     I fail to see how that would be useful? Why would you want the mux
>     core if there are no users?
> 
> 
> In this case the user is a custom configuration that is added per board following 
> Documentation/devicetree/bindings/arm/npcm/nuvoton,gcr.yaml

(That binding has recently been moved:
Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-gcr.yaml)

> 
> I suppose the problem is that ARCH_NPCM7XX doesn’t select MULTIPLEXER and MUX_MMIO. Maybe that’s the patch you are looking for? Nothing else that we use has a dt compatible string with mmio-mux or uses the functionality under the covers. This leads to our board config selecting it manually.

Perhaps? I think that's one way to do it.

I'm not sure about what exactly should select MULTIPLEXER in your case,
but the thinking is that whatever driver wants to use a mux controller
should be responsible for selecting the mux core.

Maybe that thinking needs revisiting?

When digging I'm finding nodes that wants to add mux controllers to the
npcm "gcr" syscon node in:

arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gbs.dts
arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dts
arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dts

But I then find no mention of any nodes wanting make use of those mux
controllers. My thinking is that whomever comes up with a dts that
actually has such nodes will also want to select drivers for those nodes.
And those drivers in turn should select MULTIPLEXER.

(The above olympus case is a bit suspect since the mux controller has no
label, and it is therefore needlessly difficult to reference the node
from a node that needs a mux controller)

Cheers,
Peter
