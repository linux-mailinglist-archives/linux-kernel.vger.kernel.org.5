Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B4D7D3F96
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 20:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjJWSxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 14:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjJWSxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:53:42 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CABF100;
        Mon, 23 Oct 2023 11:53:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcVLvkylOAQJ8PLz/PiC0tt81nvt2ANWwceKZuYick62y2uF7d4JLJblMXjjkhHU09tFaN7UgdaOYkAaDaL9EMXZRwpgWvT7YEZbifJjuFsmaN23GH9ObAjgIUvd+MPQ4mx8HE/c8njsbNHJs4ra04SkJk+yyFzgrQyEV0jJf5sZ5j0AgSmZlv/775xp6+E3135XXEbn0U01rMDxHNNKskAnAj1jXA4V1ghMiKzE0P8c7O7O8l+B4ZNoaG5+8665dMYcde0WmdXfc0U8KAjJOUA+Aed9Gp5zkKjVmpBtur83wqArGAomt8Xs0XiRfDjR5N398DrYLI3IGYo78otBeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMZ7JpkyzqpFAK4qylSuRvPrxXvFTcKg7CWDV8djZoc=;
 b=M5ej9fgEtX2gPrg8yJ9CpSH9zD9LzhRypFMVLGk56YhwCllK6N0LIYLyDEE6Qw3FEtGWFfl/Kmf22L4e0v1jAyx1wRyPJVqdnPOtEcF2EuyuqxhUmwIHngNYo935VUVafZtcG1EfDV+e0VaIBw9a8VG8sCNdPMBigfrMJd/2GCRXzV3qCfbBR/VqZ2sTYOl7oTLCZkqD6UtK7DY0SNF5AqStQ45gilh9SXzGe56SAFptZlrL7asGIN5zKjsCoCXourcIzmBy4+zgtjup1i/UmEl97MGNA5kHYgZlA1LWkYpetuwe0mMPa20ufPDPK/NvpcOtgA1aML13QTBYRhGoMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMZ7JpkyzqpFAK4qylSuRvPrxXvFTcKg7CWDV8djZoc=;
 b=FV3c6bdS2PAEDat2dQ2fjqlku54jKDOQAt70qcJBT9uYt1NVGvOTu6o8fMQ1NEVqbM/9r/Tf6FmK+ZRqt+QLCnbX1SsEikieUGaif5hs8zgmEi8zLVygvId7gQGYCrtVDd0fQLbmpcHnPl5g8kXVozRzKc3gpFHk4DMQCb4ahbw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by CH3PR08MB9685.namprd08.prod.outlook.com
 (2603:10b6:610:1d0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 18:53:34 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::e73c:270b:75f7:5302]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::e73c:270b:75f7:5302%4]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 18:53:34 +0000
Date:   Mon, 23 Oct 2023 13:53:26 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Anshul Dalal <anshulusr@gmail.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: input: bindings for Adafruit Seesaw
 Gamepad
Message-ID: <ZTbBJnwI5FWYfnFd@nixie71>
References: <20231017034356.1436677-1-anshulusr@gmail.com>
 <ZTW0p2WG3/m1Tx+Z@nixie71>
 <7ef752b4-915b-4f9d-8425-79df8195656b@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ef752b4-915b-4f9d-8425-79df8195656b@gmail.com>
X-ClientProxiedBy: SA0PR11CA0070.namprd11.prod.outlook.com
 (2603:10b6:806:d2::15) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|CH3PR08MB9685:EE_
X-MS-Office365-Filtering-Correlation-Id: b413e3d1-07be-4de8-da2a-08dbd3f95bbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +30G8vDV26fYygNp4fz1pg1BsNSft4evdhb/6dDfafko8l7f/0++CB6skg2lpcXMZ71PupDRAfoVnfNnbhg48zp9h3FgB1bRpJaDqsFvrEuj9FOSavmwuBP/fCeObIT8UZ51dZcCMUS7Dlsd8qL+3CKpGm0GJ7H+FekLu2bMZTmqPuNd8N0eRiZ6+m0f7WLisOmGVxqj7FGRuJUxPmrxwxrPTGLTaH5oLIhq8J5ya8Y9vgHYyMUFXQidy5UiYdTRq1m9LPFCJpwg06V4PocNbetEDeQKPjjYnzov34bkh10Y0VhxPO1DGqQxhA5zHd+kYi+6d19jVbTV9L1TniLzE33VUaJLN9azJvoPQ8ysZrCnqu4qHX0knFzTbcPnl2PsAyf7uPFwZxvnS7usPdJClN5QHKco9ofB1VposuF4dtadvqIw4wfCqracR3HBFWBbcQ9Gc5HaqVtsJqIkRzciP4lf0ThotJ4uE9VxTA6TRJrvS1JF3elIXzsioG8+GGPy7ZF0Lx/XU6lRlJ9aEW4GBHHBQpB/2vl5nSCed7E9MHU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(136003)(366004)(376002)(39830400003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(41300700001)(26005)(2906002)(7416002)(38100700002)(8676002)(8936002)(86362001)(4326008)(33716001)(83380400001)(9686003)(6512007)(6666004)(53546011)(6916009)(5660300002)(316002)(478600001)(6486002)(6506007)(54906003)(66556008)(66476007)(966005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gyZCP0N8Vr+3iRXvBNqK5x9MEqWKR4TGiBy5RneGKkBd5e8YoQofLtlsK8pH?=
 =?us-ascii?Q?IDDh9f/63JjnT/COrTfRG6ZolMcfSYpbdkUCA5KJlX7TLMqZWZYAV/8mvA2g?=
 =?us-ascii?Q?nygRav6/jzWlvErC0vQvhDSIy7bMtm7DoV4ASoh/RMZnbMERHYwn4ZcTu2Is?=
 =?us-ascii?Q?DH7oL4T+t2sdSOgyGhwB4gjL9hoogCqyWzfQY66ZBhiCYCV9mGZETUQ0ex8G?=
 =?us-ascii?Q?o7raiP6kUqR9CiJ67DADrTmk/nbpKJN0e6LzHbMkYAp558/LpPWf1gxsz/7c?=
 =?us-ascii?Q?29nnt2xZsZkict5VcmPE5C9CXcdAo+mYCfpwGas4FmMx+t9xJPA4fBlAztqm?=
 =?us-ascii?Q?nwIiZAszExXb7l1RBUv+TDjcSbiEJjn+PRpp4L/aZ3llDHG1UIDEIRh8hT43?=
 =?us-ascii?Q?eTH4Z11MC9QqkGc4iT4IKdGUTA1dooWMMb9mI7QvGrwW95jXhX1R0/PNkYk3?=
 =?us-ascii?Q?kHCA21Iuier/r+9cMgVHVzWsmNtp5wl45WoUn0wKakA6fX4WgtrHd0R7JGL1?=
 =?us-ascii?Q?x/hLRHsUIfUmn6lwEzubNau61R+BAxqTLRhipg/7oDeHu0fOUA+Ag9b5SzTj?=
 =?us-ascii?Q?jPnd4XllMn2zJp0ARitpOrZgd0Gt48ZrGO9cIagykredngmVDY4F8dQvphaU?=
 =?us-ascii?Q?0ql+QyA3M6kUlyCGPpz+JkjeulvYYEg2NBg+spN6c3aDhE2cu5hFmGWW/SpR?=
 =?us-ascii?Q?XTcNpsPApNKC+I4NjQZTEpQ5Vmy9euw6hL19PmtjJQGELuoUR4J66ILuiV3o?=
 =?us-ascii?Q?I0o6paShSmmksPiUa4RTqtNcRLyAlouz1pLOgeVliZ+R7VmEhh0e3whAFHUD?=
 =?us-ascii?Q?BhYSY1+Lkts+IBoWoegKX9lCyk1+lTljpCDhwIsI2NeqLk/ajgS/NFVGoD4w?=
 =?us-ascii?Q?TDI6ZyKOA9nzr+3SLe95xz6ed6x5y+mds01h9FWZeZAbFghcaBFVW1p93zr1?=
 =?us-ascii?Q?RbhNzKRRk48jlsQaSk16qj5rDPah0Z5b71qTNSe2oyX7HAT8HUgOgTgaOh8n?=
 =?us-ascii?Q?u9bSCTjhqna5EihRKfljORRh9W7UdSYZmBAarpqcnoVOX0W2H7TjJ571jFm5?=
 =?us-ascii?Q?pOK5qWKQDLfdp3Z5jnFT9ZvfIv4QBfrstlOuW98Bt4RDvmEnl1dcqJ8kR4sb?=
 =?us-ascii?Q?Pz7zIi2yHTLS3HpsjfCqjFRwHrUAEUY3bUDT0h0O7VeJMfne6j2+Dny1bd6Q?=
 =?us-ascii?Q?mDWxULIjPs0/FZreU8n8nBSGMs4mLcspzkTVqMEFOLsUCSkXQd4SFKDQsnlE?=
 =?us-ascii?Q?Ck1am/8gSfFRe0x8WXggaAun39m6HS5ksxONrt8dD10qxMsdbHO12jKla35/?=
 =?us-ascii?Q?X2V2/UNJ+0c1Md9ttbo1BsRF1dZjziZ8tdImAZdwkFBetR2m/QFnVF6e0eum?=
 =?us-ascii?Q?4SK58gFuci9m8EABgh28UuuLTPc/qs3uyfCr1hNunE7oqcdvuuaRVFqPVsVc?=
 =?us-ascii?Q?usLn+TgOm9iepK/NZOw6e08HDVlpQOrbskt/vLRBE5wLlLavsJItcKaeACP5?=
 =?us-ascii?Q?btTQFLYKaqrWrauW/R/+J+W2VIrHq2533yfI9NJa2tcxUSc5aiPS7RHZ2med?=
 =?us-ascii?Q?LUwHxXgVn5TvTU+yD8S36tGXmhnpTJlorDUoSbQS?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b413e3d1-07be-4de8-da2a-08dbd3f95bbb
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 18:53:34.6584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R864CUiqm4qz8RyYkYMsQHrzHSIo3SYHjeI/6Bh4SU4kQk59wony3AwLYaa16jXhzfCWZA70Yo/m/JAt96z0bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR08MB9685
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshul,

Thank you for this additional information.

On Mon, Oct 23, 2023 at 05:28:10PM +0530, Anshul Dalal wrote:
> Hello Jeff,
> 
> On 10/23/23 05:17, Jeff LaBundy wrote:
> > Hi Anshul,
> > 
> > On Tue, Oct 17, 2023 at 09:13:44AM +0530, Anshul Dalal wrote:
> >> Adds bindings for the Adafruit Seesaw Gamepad.
> >>
> >> The gamepad functions as an i2c device with the default address of 0x50
> >> and has an IRQ pin that can be enabled in the driver to allow for a rising
> >> edge trigger on each button press or joystick movement.
> >>
> >> Product page:
> >>   https://www.adafruit.com/product/5743
> >> Arduino driver:
> >>   https://github.com/adafruit/Adafruit_Seesaw
> >>
> >> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> >> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
> > 
> > Perhaps this ship has sailed, but is there any reason this simple device
> > cannot be added to Documentation/devicetree/bindings/trivial-devices.yaml
> > as opposed to having its own binding?
> > 
> > It has no vendor-specific properties, and the only properties are the
> > standard properties already understood by the I2C core. In case I have
> > misunderstood, please let me know.
> > 
> 
> The driver currently implements only a subset of the functionality in
> the Adafruit Seesaw specification. I eventually plan on adding adding
> full support for the Seesaw framework in the form of a driver for the
> atsamd09 seesaw breakout board:
> https://learn.adafruit.com/adafruit-seesaw-atsamd09-breakout
> 
> Then I think it would be better for this driver to use the newly exposed
> seesaw APIs by the atsamd09 driver instead of relying on kernel's i2c APIs.

The underlying functions used to implement I2C communication are orthogonal
to the binding. Whether you use the kernel's core I2C support, regmap, or
your own wrappers built on top of either have no bearing on whether or not
a binding is necessary.

The binding is used to define device tree properties that describe the
hardware and its constraints. Classic examples are things such as clock
frequency, regulator voltage, etc. Drivers often translate device tree
properties into register settings.

In the case of this device, the only thing the driver needs to know about
the hardware are its compatible string and I2C client address, both of
which are already supported in the common trivial devices binding [1].

> I would also like to add support for the provided interrupt pin later
> down the line which is documented in the binding along with description
> of the non-standard action button layout.

The trivial devices binding includes interrupts as well; please see [1].
My opinion is that the device's own documentation is responsible for
describing the product and anything unique about its physical layout.

> Above were my reasons for going for a standalone binding, please let me
> know if you disagree.

I don't see any need for a binding for this device because it has no vendor-
specific properties, and the only properties it does have are covered by
existing infrastructure.

My feedback is that this patch can be replaced with at most a two-line patch
to [1]. This is just my $.02; it is ultimately up to the maintainers. The
existing binding, albeit unnecessary, is nicely written either way :)

Kind regards,
Jeff LaBundy

[1] Documentation/devicetree/bindings/trivial-devices.yaml
