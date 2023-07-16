Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A79D7550D8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 21:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjGPTIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 15:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGPTIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 15:08:46 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028F39F;
        Sun, 16 Jul 2023 12:08:45 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id BEE9F3200681;
        Sun, 16 Jul 2023 15:08:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 16 Jul 2023 15:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1689534521; x=1689620921; bh=198dGszsPL5rCtAIqXxHjuksCnuo9CK9kv+
        r+Qr4wn8=; b=QiFZbXyj6OcABjsbP3LqHaC77qXsza0to6u7gbpTK2jSFjxAvWm
        n0zIrD2bmZSxab0fDU8MU5zZLVlOZuojaJQgoG8YJBRFymAXqX+2ICmfyB2viSgK
        pxySbx4rJbOFCc25bCnGwCuRL425T484bu5rJA/Duiw4vUbjzr9SHqo50+3bpcoD
        PtXR22bJSawndwfk7ze/wz4zjaJyF231F4lkKgoPIvGqS8PNd7qffL8igXBYpflL
        H04ofs+84hoC6z2MfX5NAAHRg2GQarjjmr58cCY82QGwHG43vDEEV2r/d2xE1TJk
        0LRv4tSAvudBTQRrwFF2+u/nTftkioKdkWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1689534521; x=1689620921; bh=198dGszsPL5rCtAIqXxHjuksCnuo9CK9kv+
        r+Qr4wn8=; b=umV+cgHxRPbUdTeoRNVocqSk5O8gwQ7g/Nyw9mAAI8vdttwu/ea
        +L25mtkiwL0DMJqIDCxjvbcNVxagFXldB+lberRproyj/FB24HG9TxQ9N6ICShGC
        kNsTlCjbaGv+VLOVPkOSnI+AyALfaNKmQiUS7jBOLO8WkHC3NltINod6m9NEPu7X
        wU++W11jV4ptLLyyAlaL0YWWatLHr9CjvAiQlL8P+a2eyakKXZqd23+kpxh27i+I
        E8xoUcfPC0OgWAGwZsS7bKQEC941odK3XGyAqBv0fBA4h5yVkm1l/6QwoLbB2lL8
        L9glPnGZuY6h964ykuwNR5qvA3GKieRhAPw==
X-ME-Sender: <xms:OEC0ZMHVNZrdtNF1SGsjwTZ1xUcT00wppfXmNar-G03Mvxj3P7w13Q>
    <xme:OEC0ZFWF2bouWqBWwEVDFtKakloV4Hi2ErqGuEZjXxpzxdwjMHUDDN1kW-fEqYRQb
    z9Pu39Q_TbYFg>
X-ME-Received: <xmr:OEC0ZGJ7JJQQlz6KtmxsTjz-dTj3EXbzKxUQZu3hmywOwgut0cU_B42gtskOf2MuD9lWDHMBS1UXK3TJvCjXzGDyWwi42UQewHDjg7js_hM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgedtgddufeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeelhe
    ehudduueeggeejgfehueduffehveeukefgkeeufeeltdejteeiuedtkeekleenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:OEC0ZOEAntkWGt_UiADkznzXooCWCinorEJFwoBwCsM9-qp9LcQEhA>
    <xmx:OEC0ZCVKwMYbyJwvuyka3CF6cT76ySjGV5OQGtSy_xlrG5HBU4nLQg>
    <xmx:OEC0ZBNsf1MQ9MQIlCVFmz6VITZ21c63uZPapkHoWLf98AW_bYN4vQ>
    <xmx:OUC0ZGoAUcbpu_i97LAc6UqMrHXuZeSDX0OSb1rBhtuxwcO_9HM2Nw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Jul 2023 15:08:40 -0400 (EDT)
Date:   Sun, 16 Jul 2023 21:08:38 +0200
From:   Greg KH <greg@kroah.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Backporting commits for generating rpi dtb symbols to stable
Message-ID: <2023071611-lustiness-rename-8b47@gregkh>
References: <20230716162444.zzvkm4rh7s7lu37x@pali>
 <2023071644-earflap-amazingly-3989@gregkh>
 <20230716163852.jnd4u4ylvifgmpby@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230716163852.jnd4u4ylvifgmpby@pali>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2023 at 06:38:52PM +0200, Pali Rohár wrote:
> On Sunday 16 July 2023 18:32:42 Greg KH wrote:
> > On Sun, Jul 16, 2023 at 06:24:44PM +0200, Pali Rohár wrote:
> > > Hello,
> > > 
> > > I see that raspberry pi bootloader throws ton of warnings when supplied
> > > DTB file does not contain /__symbols__/ node.
> > > 
> > > On RPI 1B rev1 it looks like this:
> > > 
> > > dterror: no symbols found
> > > dterror: no symbols found
> > > dterror: no symbols found
> > > dterror: no symbols found
> > > dterror: no symbols found
> > > dterror: no symbols found
> > > dterror: no symbols found
> > > dterror: no symbols found
> > > dterror: no symbols found
> > > dterror: no symbols found
> > > 
> > > Bootloader also propagates these warnings to kernel via dtb property
> > > chosen/user-warnings and they can be read by simple command:
> > > 
> > > $ cat /sys/firmware/devicetree/base/chosen/user-warnings
> > > ...
> > > 
> > > Upstream Linux kernel build process by default does not generate
> > > /__symbols__/ node for DTB files, but DTB files provided by raspberrypi
> > > foundation have them for a longer time.
> > > 
> > > I wanted to look at this issue, but I figured out that it is already
> > > solved by just recent Aurelien's patches:
> > > 
> > > e925743edc0d ("arm: dts: bcm: Enable device-tree overlay support for RPi devices")
> > > 3cdba279c5e9 ("arm64: dts: broadcom: Enable device-tree overlay support for RPi devices")
> > > 
> > > My testing showed that /__symbols__/ node is required by rpi bootloader
> > > for overlay support even when overlayed DTB file does not use any DTB
> > > symbol (and reference everything via full node path). So seems that
> > > /__symbols__/ node is crucial for rpi bootloader even when symbols from
> > > them are not used at all.
> > > 
> > > So I would like to ask, would you consider backporting these two
> > > raspberry pi specific patches to stable kernel trees? Upstream kernel
> > > would get rid of those bootloader warnings and also allow users to use
> > > overlayed dtbs...
> > 
> > What kernel tree(s) should these be applied to?  What trees did you test
> > them for?
> > 
> > Also, adding dt-overlay support does not seem like a stable kernel fix,
> > as this isn't a bugfix from what I can tell, right?
> > 
> > thanks,
> > 
> > greg k-h
> 
> I wanted to discuss what do you think about it. As I wrote my motivation
> was to understood and get rid of those warnings "dterror: no symbols
> found" from bootloader when using DTB files from mainline kernel (as
> opposite of the DTB files from rpi foundation). And fix for it was just
> to generate DTB files from kernel via dtc's -@ parameter, same what are
> doing those mentioned patches (but they describe different problem for
> which is same fix). I thought that fixing those bootloader warnings is a
> bugfix.

Why not just use the next kernel version instead?  What's forcing you to
use an older stable kernel that didn't have dt-overlay support?

thanks,

greg k-h
