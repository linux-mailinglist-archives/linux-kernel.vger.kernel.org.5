Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74ED3767CB3
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 09:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236583AbjG2HGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 03:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjG2HGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 03:06:45 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B5644B7;
        Sat, 29 Jul 2023 00:06:44 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 865D432001E9;
        Sat, 29 Jul 2023 03:06:41 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 29 Jul 2023 03:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1690614401; x=1690700801; bh=NI
        vjymVrF0OfhqAW91Z7X5TlcNoaaJ4R0+tcH2LzT1o=; b=YgN+gGQXZ3xKSZTGvw
        hlYG2I5iKcIEFwyhQwlrTQFJesGdRyMJnKZOZOrflqPH1s3yzWusFB/9fJx7v4f8
        h6sguOTMFeW4V5e5s8Z4OhwuXCCYrM+yTmsqN9eovDDmTMbg5sD4oBF3U64SBiko
        7ETu5lt5aWPdpZxcab4x4iQjozN+nB6IEBPA40q3djLGCMtZRKFiDUk2Uq0Z1kL+
        kJUgO6ZL49SZc/xFZ++yKxNH3VNb34c1y4YzOorhlzUx2oyGifLLlS1fCB9/QUu+
        pB+c5mDfwAMbhco5PVmsVt9dFFq+z0TfoEfYVYY4MeDK0SB6msGcfCTbKZfo5dql
        DLJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690614401; x=1690700801; bh=NIvjymVrF0Ofh
        qAW91Z7X5TlcNoaaJ4R0+tcH2LzT1o=; b=Ffzy6VefmzP5tff1uc+3abjSO/EoA
        WnWZ7aYWCPKrCm20XHzNpUKUYpO/BYQ+6cG9eiftCwhKJLjhTfGs1XcsiIL5YdZb
        /XI7tBJ7NlYd6bPvIvYKoyouXmBfJne7pkFcHWqm7IHkksp/95VEhSipZFwfRo+J
        TyQtLdkso6QsudSpTl/3mxrhXRhDXc4v+4nYus22Bbx/fDZsSygGfNrK+kfG0sO4
        72YZcPwghTt1WGEuM4et8aGIoinxGB33cl+9DAFpTjmMkwuH1vbMM1xbuutuzPxW
        0LbYSUEi859HjfFX5EchXbUaejV18hUtu9JSrYCSx38mA8s8/18HLSrjA==
X-ME-Sender: <xms:gLrEZFesPh_5X84W8RJYHM1ihULi8vU2txyqXN4U-IV3dl3Xe5GISg>
    <xme:gLrEZDOnrzaIIrlRr784JAJgASm0j2Q8sUJFElWk_OU9I1W-_r3JZ_XD_IJ16e1xo
    UUf3xRiGhccsydltT8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieejgdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreertdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnuges
    rghrnhgusgdruggvqeenucggtffrrghtthgvrhhnpeffheeugeetiefhgeethfejgfdtue
    fggeejleehjeeutefhfeeggefhkedtkeetffenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:gLrEZOhaZm2YjmL-4ZRbsAv0WfS3qNhRVx85_zG3KbLpdMf3YK5bwQ>
    <xmx:gLrEZO-QBM348EAqxrLBvzJnNAEq6_oFPQQyopq8jc1ZSa0bxN1m3g>
    <xmx:gLrEZBs0wH-CNNKc3uSCr2uvmv_V6lmb58tAw2UFHnPnqADp8gNViQ>
    <xmx:gbrEZCUrfcLtMzELDKHkSeNVdz-8GoSGm_CMV8K3mdD_EW5WWShBgA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BFCDEB60089; Sat, 29 Jul 2023 03:06:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Mime-Version: 1.0
Message-Id: <ef413a40-ddc4-4d23-bc56-23b7095ffc83@app.fastmail.com>
In-Reply-To: <CAJF2gTTC0BTOyWH4Zod1oRQaUpS9dE-6=otfpGOPcCcffrHohQ@mail.gmail.com>
References: <20230726145740.1765323-1-arnd@kernel.org>
 <CAJF2gTTC0BTOyWH4Zod1oRQaUpS9dE-6=otfpGOPcCcffrHohQ@mail.gmail.com>
Date:   Sat, 29 Jul 2023 09:06:19 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     guoren <guoren@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc:     "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] csky: fix old style declaration in module.c
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023, at 06:59, Guo Ren wrote:
> Thx Arnd,
>
> Reviewed-by: Guo Ren <guoren@kernel.org>
>
> You could directly put it in your next tree. If you need me to do
> that, please don't hesitate to let me know.

I don't currently plan to send a pull request for the warning
fixes, please just merge it through your own tree for 6.5 or
6.6.

I'd like to enable a few warning options (-Wextra, -Wrestrict,
-Wmissing-prototypes, ...) in the Kbuild for 6.6, but the Makefile
changes will probably go through the Kbuild tree or linux-mm,
and the fixes for existing warnings can just take their normal way.

     Arnd
