Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC607A17B6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbjIOHoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjIOHoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:44:37 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21C898;
        Fri, 15 Sep 2023 00:44:32 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 6A51D5C01B2;
        Fri, 15 Sep 2023 03:44:32 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 15 Sep 2023 03:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1694763872; x=1694850272; bh=t1
        TmiRsmiqzGQ86IPASUaWxEPOm0MoyVw2BuHDcx1xw=; b=r8mv8zbFk6D6NxtTWI
        5mrt+5aqlY9VERclZBOqynYlvQFmz5g0VRZo1yQtWxu22/tCGM3RsYXzS+IDI+Nx
        FcvUBpqQtWHAhJyIeXwCD4wOE695pcAiHGwi2SrKMQ197aH5+A8sh0rCA5UuNnhP
        wU5GfJ8EZX1DQ1vfHNGuaYRId1AVnZW9Ggddi+Js4rZKmYwnDFNqBzs1hCPueP9V
        ssEqWtyH1LMJVA37Sk2SazF/+slcyLe0zB3lES4rMk4I+F7Jra0AmvZlF2fHvFoP
        ZEUPF1f4zKa1V1YbeuxdR4z3Bprd+dn+WJwLWDmVZFyfnzCYIF4egnQ2HF1+0raT
        wM/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1694763872; x=1694850272; bh=t1TmiRsmiqzGQ
        86IPASUaWxEPOm0MoyVw2BuHDcx1xw=; b=fv/Q9eaOSWkOsYmE3FHcAmRB+LB5F
        U83bqXTW6iJuNsmj2rkJj34MREv+3fcBw0S3ZyBxx4Lu+VbGOhBrkPTPHcQhzUkP
        pa24usN37PmVaErVKFLKydJlifoXjFY15ET4pMpILu/IPb9kW3tTAxZd0qAWmZzV
        kYRr7rMY4l4x/Jrn8+jqS1lK7cPu4mTonig6+VBvypJmmrKFkbT310hXDrrgkTIu
        44NIzymrx+Q3nuaSIXsW2t42zcvywND/jlM6x0CmmJkprpioJDT/Ag5vniwk+HME
        +lgEvEBrlbVgY85gM8/ay029ekva1WRWvM3D4mCUlGl04DrGKVPuW5yTQ==
X-ME-Sender: <xms:XgsEZbbmNwlr1ogpQPtnEPtRawXKaMsBvyLGx0-GY5hn5FC09_8qwA>
    <xme:XgsEZabb0vGSCHXB8EZgzGjSEuF6AMiIEYFoYLer-Xf_Qhty1OZasCi8Y05bPDbiX
    I7qZeovW8nWKFVQw1E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejuddguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:XgsEZd8Bh9B9KdCSbvwZ2Z_8bM3jhztBkPIKbODyIFDyNU7powaqtQ>
    <xmx:XgsEZRqSoXXBE5u8JpIsOERz1JHsmJ2D21fST2-sB7dYMd6ALowwtw>
    <xmx:XgsEZWpVSrcvXREUjU9Tq1n1EJ9_6JXI5AAJvtuAIS2l_rH50Iw54w>
    <xmx:YAsEZV1tBzIWo1lPwfryXJruaD56VNLgM_Sy1U9mE7q2zl3wlwuxqA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4D769B60089; Fri, 15 Sep 2023 03:44:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <bc27450a-74cd-49f5-bc88-f102b0edb345@app.fastmail.com>
In-Reply-To: <87sf7fvqiz.fsf@intel.com>
References: <20230913113801.1901152-1-arnd@kernel.org>
 <874jjwx44g.fsf@intel.com>
 <b2723c56-e2b0-4871-afbc-73cf6335ddca@app.fastmail.com>
 <CAK7LNAR9Jt0FQNRidcxY-OxMh7N238Xs33Tyj+dpTZ5wGow0wQ@mail.gmail.com>
 <763b1599-06b7-490e-9cbf-eb07f1deedb3@app.fastmail.com>
 <87sf7fvqiz.fsf@intel.com>
Date:   Fri, 15 Sep 2023 09:44:08 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Masahiro Yamada" <masahiroy@kernel.org>
Cc:     "Arnd Bergmann" <arnd@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Sakari Ailus" <sakari.ailus@iki.fi>,
        "Javier Martinez Canillas" <javierm@redhat.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: kbuild: explain handling optional dependencies
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023, at 09:34, Jani Nikula wrote:
>
> IS_REACHABLE() considered harmful.

Absolutely agreed, and I'm sorry I introduced it in the
first place in commit 9b174527e7b75 ("[media] Add and use
IS_REACHABLE macro").

At the time, it was only used by drivers/media, which used
to have a lot of open-coded instances of it and a lot of
wrong checks.

Having a formal syntax for it was an improvement for
drivers/media since it was more broken before, but it's
usually a mistake to use it when there is another solution,
and we probably should have tried harder to fix the
dependencies in drivers/media at the time.

      Arnd
