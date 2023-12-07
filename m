Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7F7807D7F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441948AbjLGBAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441924AbjLGBAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:00:48 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2100.outbound.protection.outlook.com [40.107.113.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B5FEE;
        Wed,  6 Dec 2023 17:00:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvj4DjlZ69Tn2CUN9f8beo49UKXt47y1cp/8kOgD8Ewg4svqGoiKs0J/GEWzvMkehz3jKWMnfuX0RenFefK3EKcz1jpCwH/tfy2XA1r4eiXAl+uVkZCoyW9dRImKpt1CIUwF2nCrCrpPUJjsVbFeHQN0sLvmnWPJvlX2M8vfSWhb8wPPWS5a6KWqJjIZgLKY+mYywAHqzLsiiNcNSDTAnpdbcFFaEuG2ydVqje3Yn8d9U42k3kQqxrhBTf4F6Qd6U8inY3cRA8VsFleit09IiQU7AHL3+XnTP7yh6eNfTxyuGxL/OVLaSi7wZwbUw2t+MgtjCzsS8ASVRvzyJV39Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwBmRh7liOsS0FPjA2FLvimHyZRzyLYeUnk33MIhMkE=;
 b=F2c+h02RRLGCkifC7YSpn1AGj18pMNEuLPmauRloGCa1cZiKFiwPrBjq6Mtaru5Zyxcvpn51tuchn+Tbo3yE/C5IpP0t+7uM3N1Sm0HRS8IO369b5cJrvsw5mXrh3qrovnUVTqvEh5rXt0Iz+BegkhoBCNVpzZzYP+yI13QkGrJTNTc1Oo6t1lnw0ff1iSo6wQ6NaTvE6FRzROCZmJWCDKFca8A6XS2WzUlFdOia3uQHrjPC16pO2Jzn/B/CSS3NwdCQm+hpBfbovNzKvYyz0N4NgsPejms9ModFY9a/xkoExRI8/w773CynkZwYrlTe3Qcr5kyqTK7Vie64bYVhPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwBmRh7liOsS0FPjA2FLvimHyZRzyLYeUnk33MIhMkE=;
 b=ZEFCyRw5vqTyJTRUC9J5hU40n/UDcAVX4NEhGFE7VjVgDGcocagtlL0T7kqRsXUCPVQzTBwSX77V27bRPUAAax+8Eml6fFlxyRtuIl42AcDw6b991hGsU9SM9GdNocyMaJUEv8wfNWLBXAY0tLorAD/LsPmi890ktkaZyZ6SUAU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OS3PR01MB8618.jpnprd01.prod.outlook.com
 (2603:1096:604:19c::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 01:00:51 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::5732:673b:846c:ed92]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::5732:673b:846c:ed92%4]) with mapi id 15.20.7091.010; Thu, 7 Dec 2023
 01:00:51 +0000
Message-ID: <87il5aomh1.wl-kuninori.morimoto.gx@renesas.com>
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Rob Herring <robh@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ASoC: audio-graph-card2: fix off by one in graph_parse_node_multi_nm()
In-Reply-To: <1032216f-902f-48f9-aa49-9d5ece8e87f2@moroto.mountain>
References: <1032216f-902f-48f9-aa49-9d5ece8e87f2@moroto.mountain>
User-Agent: Wanderlust/2.15.9 Emacs/27.1 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date:   Thu, 7 Dec 2023 01:00:50 +0000
X-ClientProxiedBy: TYCP286CA0341.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::9) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OS3PR01MB8618:EE_
X-MS-Office365-Filtering-Correlation-Id: 4166a4ef-9f63-4ebc-f3b0-08dbf6bff4b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eO1Ll+06LDfqPUFndy3qiFbJxIeGzMH+MG131yJg3aqNpwA1OSCt1kb2vYx5Xht4Ciu/etihrXw+Rb6HmUFQv7MAfKbMCpsOAQKnu4VYdaAliClaCWlfDz4QkB5Px4lAgd/J6Gri2q9G7krfOapYvWaTrfuMTPbRErOcRo45LkWTEULDfIXSqfaBIa8tnjkfL4yWaTwN84SeSU3NLrVqJDj65EKdHYwC7eUZ4NgAY8Hn7qixkNXT+KQYpb7pgmKkynC51d3JykQ+TQeivAFi2PC4nRhU0yx13aE+Jc4VwG23MI8JD8h934tHAUz0qXI12Wt3oRpTjWyhQYPsCdI9PqOhtSPwVnnM539IUuRggYGF/aeBbzHp03MflGLXVbaqJzY91v+A3/hTmRd047Z+emZYVwdvxpuyBw0dCwew9boIbQyjVx3Y+6H8zYLl7powUtiAOBN7Ycr+pIhzTG3LGJX3N/ZeRABSuXx6THf9i6a07NmrjtaWi9zH9AbPRt4+aS4vHdR+Qypgn8OUqI0GQMR/+++OHMuVi/UpFIm2QjUXKjE/9F3M+la5tLzqdAP8hqequq/CEO94Uuxe3xmm3eJgR0iQNB0sUq8BCCq3G1ZTQwQ6BDlAjmkknv60BQPxNH7GKbkvj/LbnJOHW9DgqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(136003)(346002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(38100700002)(8936002)(4326008)(8676002)(2906002)(6916009)(66556008)(66476007)(316002)(66946007)(36756003)(5660300002)(2013699003)(7416002)(38350700005)(54906003)(4744005)(2616005)(26005)(52116002)(6506007)(86362001)(6486002)(41300700001)(478600001)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5kDy+4ESosqAVYj3PnukDZfqFZ2L/uNDHrnlZNjF8GA1XenuNrkl0XFx5tTa?=
 =?us-ascii?Q?/EFFeRmXRaj1LiuJUWvqtjqcyMzCF5HTFSUo7o0M9FPVnnmSCA07W/++GdS3?=
 =?us-ascii?Q?PncNR1rFE7dcbvNjeyCB6zxqBpP9ebqOgysgl1HVmvNBK/R8EAlR/2TV8DBX?=
 =?us-ascii?Q?DscACNCSwqiUoN2qAxXS01l53JYtNYMmjLM1MPU+NXuFmjU/Umt9e+4aGZX4?=
 =?us-ascii?Q?lPqWR30CJsjpN88Ow70wvlh1XD+i9epR3UoGYvSa0HVhmYtrWb+r5xXrTpi9?=
 =?us-ascii?Q?89v/H9vvLQKymxWDVp8Er9hdFKdY/BPh8OeB9OSzgFtJnjJp+BIr/LcOCipm?=
 =?us-ascii?Q?zspo/YebQN/S/GjCKzRA3bXN6v7uZcTcSPGllp/rXXqPTlcgnZmEysGtyuWY?=
 =?us-ascii?Q?EG98Yla2c3SjPLQfJwJwBF5bB48AyYeznQ4qTXbkQGN84gvvnevTtDyCwJY2?=
 =?us-ascii?Q?Lca/zH5PlssI/DI0lkoJQyUzs65yLzCrMuUwUAttukzaDuUac8T8znKvotBZ?=
 =?us-ascii?Q?1YsoOl9bH76toIeJxo8IdopjboS3y6P2EZk4vSZ5uZ2BGDGzqsOFS4a/pCe6?=
 =?us-ascii?Q?g6BsfQQ5TAUSC+6hxxFgiY+MZi1vFyrmdqxRFGncIHKsWnPdc0YqfAE3V0wf?=
 =?us-ascii?Q?3Xx0NAjZvTQupa/dwE+/oFcXr19EWVjnvqCLDAAdn8LioHEYL2u8vn4LNLxT?=
 =?us-ascii?Q?4GJAJZ7ugmd0xLfkGRYC22+VcT9LJq2aVrzYWjB/tnXcDkw/Vq5IUZVkOa66?=
 =?us-ascii?Q?LWSg4CIf2JZ5Inw/cJHOHTr26muojDBmfgty8T2YuZnbjENreQKAey+/p+om?=
 =?us-ascii?Q?Pt8oxwxixUNwrWZ0ejgJYmEXnZ4hbefslePp1/L78SWOQTDgjzMkRWsLVUSQ?=
 =?us-ascii?Q?5PE4qESdhPcfKX1nkj/xKDCcz3mg3VzJVQWmi/GWQkax6EAZmEDCMVxvz97J?=
 =?us-ascii?Q?+wPqE0TJbX61geXlAriOZaWCbfh6iH6ChekI3GGUrpkxiuWtBpde5mz7kiny?=
 =?us-ascii?Q?BdlPQ8qc/M0dniyTK0Vxxx7B/OKjquWW0vvyVpOoyQvBc6PUSCIT4ybs7NYi?=
 =?us-ascii?Q?5PKrkwBZ2q3rN3Eux+9EQ3gTmAcFxAKnyxC8rNMQJsnc81RBYFvv1iH6CY+I?=
 =?us-ascii?Q?gB8mnwuGZ6fTtkH8XwC5bRt2gua4e2gufcvlq9xSWoe/k1KzUxqUd0I1dNcv?=
 =?us-ascii?Q?4oNOjzOeACbIXUKVUc4ksNipOrWFt+R5uOZ+GjZ019Jm1ygEueu6WYogADUY?=
 =?us-ascii?Q?tkU5ogcvJG5mrtnFOequVEJ2tiIJ2TaV94ksUlmfHltKGqhLU/rk8t2Z6tA0?=
 =?us-ascii?Q?0Ix/0FXZyNoLxowxPNeySEcfs5RTtjyGxdrGO8HhabMaRaOJZOqJBNuv35W9?=
 =?us-ascii?Q?uJQKj3eeJv8v3XWcZJcJ2YTw7QA8V8LzfwK+2chfXPinxYk155x1ilwbZvf3?=
 =?us-ascii?Q?kWkxg6vTzRYIG5NKKP9byDqMZaR+1tX36ZP2DUGfVmP1vNRiYByIZpIYXTR6?=
 =?us-ascii?Q?GIyFKbvfqz5aAbld2o9Tga1zdO4JkLMpLMZb+GK2LL2D6fbdXQAvxqXLfsok?=
 =?us-ascii?Q?6z24/nS9AxDSWiiN7TrWgjf9gmtAu2rrxqZdyfSXgWe5ZENuPqF8aL7hV8b5?=
 =?us-ascii?Q?QtxfguO+CawO7kIrwiwY1L0=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4166a4ef-9f63-4ebc-f3b0-08dbf6bff4b1
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 01:00:51.0300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9vhkYh1NaUoRZoFScantmgWPfxv4azV0q13mNvpGeEDeutlFjC3lnfnwI11fQ4AeE4GM8iT3iXKxUtzpzf2ro/cng253w6450ix3k6FuFmZCbUIlD4FosG0o6+5apny
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8618
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Dan

> The > comparison should be >= to avoid writing one element beyond the end
> of the dai_link->ch_maps[] array.  The dai_link->ch_maps[] array is
> allocated in graph_parse_node_multi() and it has "nm_max" elements.
> 
> Fixes: e2de6808df4a ("ASoC: audio-graph-card2: add CPU:Codec = N:M support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

> In this same function I was also concerned about these conditions:
> 
> if (cpu_idx > dai_link->num_cpus)
> if (codec_idx > dai_link->num_codecs)
> 
> But I wasn't able to see out how those idx variables are actually
> used.

These also ">=" I think.

Thank you for pointing it

Best regards
---
Renesas Electronics
Ph.D. Kuninori Morimoto
