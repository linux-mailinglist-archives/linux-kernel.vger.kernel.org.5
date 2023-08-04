Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E70876FD2C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjHDJX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjHDJWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:22:55 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3871555A3;
        Fri,  4 Aug 2023 02:21:09 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 00DD9320055E;
        Fri,  4 Aug 2023 05:21:06 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 04 Aug 2023 05:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691140866; x=1691227266; bh=k1
        X+vaMpBouJwVK0uv5j8uGVwuFrKow2gsOSLZDmv60=; b=jqSoCCeE6kPowUkuPr
        cNMwSo+6p1rNsCjjkTwOdUPTLoy/Fb2FHptwsMawZQ9cSyOrjWELFIvTip9D03lQ
        APvt2z17cKe7zoodKB7HAXSoM4Bua5PSeVED2jZ6KDQ7fTa6IhHyjibeJys1igp0
        QDliyX731ZMCjQf/1ZOcGlmE8bnJV+JvwDNoa+YkGO9OrAoY8FCSGsrNyFhm/2gV
        lVW3ExrUAeKhg44f5wWy6RVJYMkbibBwSUTIyssYOZjuVqOtV1FJrOwzwtOtHbUU
        38xg1bUWRoNa8uDdatoBM2CK1Q6nqvZQgZ+awtTTcPwQ0ptzTMfY0qv0c3pYpzuh
        rOsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691140866; x=1691227266; bh=k1X+vaMpBouJw
        VK0uv5j8uGVwuFrKow2gsOSLZDmv60=; b=iMHSvNzYJLtI7gEax1dU+GFAYAGKt
        6LmXnocUMWjJmGxBlI7V8oNuMD65g7KeGqqMSpHn7bKIuu7w9tAUkRuGl1e/U2fQ
        HIO3Pm9p7m22a089mmZrBAlOAKGUcENsj+5gv84CZVARYSqut0D4Yqgh97A8Scb2
        6cH6d+07E3kUbcPWlfNr+USMpc5ncuIwn3jMFveCHo81X+z5NYN9VDzk9104fsgd
        ZU9/klIAhrJ2mgKzUTAvlabGNHOLVJkiwF5zcV38YQFKNFX7EglEkAf62bRNlLvd
        PlL2Qu/gCgcG8lDoBP9/orUaY2chVJK0v3ox8S5MKsVm5WhJBwdOW2T7g==
X-ME-Sender: <xms:AsPMZO2BFYX2pr_dqw8qRZmKX795vzHByNSoo57nk3l6XNogmkNM2Q>
    <xme:AsPMZBFcVZGaU6a-XEdCFeyV3ts0SOsu22fSL-FYn4xz2OBFBUNAfJ4AVg_xm6Lly
    heS8Olf5Xo-u3tcu7E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkeeggddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:AsPMZG7RGydb_7gyyy203_TLDQYywl2tFWThXO3loF-eiCuFbka_LQ>
    <xmx:AsPMZP1rTF8VEI3cBduNuD7NJYrdcm5pMuUbOrcDkVJpdYdXCAiM1g>
    <xmx:AsPMZBEND2wycagre7DG6OM1lgJDtiUPv0QlJFgMR4wALimP5K_b1A>
    <xmx:AsPMZJGbEEd1kRgpMVLItz2EoBVeKyz_z2v4cG68fGLOKGaUTXiuVQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E4E33B60089; Fri,  4 Aug 2023 05:21:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <ae2ad056-96de-41b7-8df4-1d9c0f5c469b@app.fastmail.com>
In-Reply-To: <5ade5d29-5d9d-0d68-c3d8-de61ca90bb81@linaro.org>
References: <20230804061811.3999129-1-danishanwar@ti.com>
 <5ade5d29-5d9d-0d68-c3d8-de61ca90bb81@linaro.org>
Date:   Fri, 04 Aug 2023 11:20:44 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "MD Danish Anwar" <danishanwar@ti.com>,
        "Peng Fan" <peng.fan@nxp.com>,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
        =?UTF-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@collabora.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Bjorn Andersson" <quic_bjorande@quicinc.com>,
        "Will Deacon" <will@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>, srk@ti.com,
        "Nishanth Menon" <nm@ti.com>,
        "Vignesh Raghavendra" <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux-OMAP <linux-omap@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: defconfig: Enable PRUSS as module
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023, at 11:11, Konrad Dybcio wrote:
> On 4.08.2023 08:18, MD Danish Anwar wrote:
>> Enables PRUSS as kernel module for TI SoCs.
>> 
>> Reviewed-by: Christian Gmeiner <christian.gmeiner@gmail.com>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
> As an outsider, I have no idea what this does, and the Kconfig help
> message doesn't say much more either.
>
> Could you please add a short summary about what sort of hardware
> is driven by this driver?

Any additional information would also help, but more importantly,
Danish please use a recipient list that has only the people on 'To:'
that would actually apply the patch (Nishanth and Vignesh) and
ask them to merge it, while having everyone else on Cc.

The problem with addressing a trivial patch to a dozen people
is that often everyone will think that someone else will take
care of it. If you address a patch to just one or two maintainers,
they are more likely to either apply it or tell you if you got
the wrong person instead of ignoring.

For defconfig patches adding platform specific lines, there are
two ways this can be handled:

a) the K3 maintainers pick it up into a branch and send a
   pull request to soc@kernel.org with all the defconfig
   changes, from where I pick that up. This usually works
   best.

b) you send it to soc@kernel.org yourself and I wait for
   an Ack from the K3 maintainers so I know they agree with
   the contents as well as being bypassed as maintainers on
   this occasion.

     Arnd
