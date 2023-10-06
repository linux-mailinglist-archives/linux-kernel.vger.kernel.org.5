Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F077BB63F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjJFLS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjJFLSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:18:25 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56316CE;
        Fri,  6 Oct 2023 04:18:24 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id BCA313200B34;
        Fri,  6 Oct 2023 07:18:22 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 06 Oct 2023 07:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696591102; x=1696677502; bh=z5
        NdTY64ZepBsdx67FJPyl45pKLPoXCLJeK8YZK4KTE=; b=Gd4UGF/IcLw+Xib6jT
        m06c9O6Cr9obBggvEngJ8x9sqa0M9DfGCuG+qfHIpvARZ/7v1+iV/Rj+4k57f2GC
        al278tWK223bKXtlqciedkwiXs2erlMEdAAM7PRuL++xT4trZv3uTmeeUIvCmPnt
        pb1pBLbagouNs84wiDIhMYuHsUq/ZJpQvlALlckI4l5VZeH7RMwn3drVTyl1dCPm
        YpeGd0dzJezTH/a8XKQzctEHDCeYQbflhUNprpMOuInRttHF7XahI7TxZhRfiHbx
        3YuTFFuTvz75nrbBuX2G098Wq9bshpSAQ+ECYKTWv9sujW0Pzvvdo3UezaSmKRYq
        1/kQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696591102; x=1696677502; bh=z5NdTY64ZepBs
        dx67FJPyl45pKLPoXCLJeK8YZK4KTE=; b=cF2M6BaK0gq3qRq+/pmVE9NmpeiGN
        pluWDyr+VZ05Z7Kp+HL97837zlNXHASo494GJqgX9AOhzxY6VeBTI42tY1UMPJzc
        LWekEmxWExpqLPm4X9cd/+C1+qV2VBNe06+D9ChXvdNP6z/GMAFLVnXFh15xVI4N
        O9IGAQXVeGkptgKIHbWH+GAqkPsbHpHD/vG8ToRLEWSQu0ava82aLvwXWKY8GWW1
        0LHFKxbuAk/TCADxMdc4WmSrUpvHRbWWIPbqn4VlwyYYW2BfRWv69xtVulbg3kd4
        /5VOVSLXgE8HziHoE7htkPAFOBoYxPHXzuMXTDsCmJXSaCVXaNgGmX3jw==
X-ME-Sender: <xms:_ewfZS21i3ADiV4AptO8pa03qUZrttAZt90IyhLsa5FlhK_WBQxkLQ>
    <xme:_ewfZVGutMPcCsre88Xm-Touds5SPuDUWiAMze9jXh554QlDKXYI7uyIzMhAV-QQ2
    7slrF6w69f6Q6r6BAo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgeeigdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:_ewfZa5Wl5AJDfChousd-sseeCt99y6CH8SUdlpBXgzQh13Ftlzycg>
    <xmx:_ewfZT2om5lK2P10LhGj8lqcjEfjV4XSF8tHIRHYSAjZnHHzwczYeA>
    <xmx:_ewfZVE07Xo0tjfEDclLi-jaGGm7YsKWaRDkVNsV_CqttEGTNGmrUg>
    <xmx:_uwfZd98vbUA3RxZHl1d-yolxAg9XHMthMqGhSk45BtsRE5Tddb8PQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BEE2DB60089; Fri,  6 Oct 2023 07:18:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <37d3c19a-4106-45f9-ae2a-99bf41a8bab0@app.fastmail.com>
In-Reply-To: <20231004161038.2818327-10-gregory.clement@bootlin.com>
References: <20231004161038.2818327-1-gregory.clement@bootlin.com>
 <20231004161038.2818327-10-gregory.clement@bootlin.com>
Date:   Fri, 06 Oct 2023 13:18:00 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Gregory Clement" <gregory.clement@bootlin.com>,
        "Paul Burton" <paulburton@kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Vladimir Kondratiev" <vladimir.kondratiev@intel.com>,
        "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
        "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 09/11] MIPS: mobileye: Add EPM5 device tree
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023, at 18:10, Gregory CLEMENT wrote:
> +
> +	chosen {
> +		bootargs = "cca=5 earlycon console=ttyAMA2 ddr32_alias=0x40000000";
> +		stdout-path = "serial2:115200n8";
> +	};
> +

The bootargs should not be needed here, at least most of them:

- no need to set both console= and the stdout-path if you have
  earlycon support

- ddr32_alias=0x40000000 sounds like something that should be
  part of the dtb elsewhere and not require a command line argument.
  I assume this is needed to even build?

- For cca=, it looks like this is intended to be autodetected from
  the c0_config register. Does that not work for you for some reason?

     Arnd
