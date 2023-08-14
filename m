Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84C877B0B1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 07:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbjHNFN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 01:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjHNFNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 01:13:54 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B880E5F
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 22:13:47 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 896765C00B3;
        Mon, 14 Aug 2023 01:13:43 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Mon, 14 Aug 2023 01:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=readahead.eu; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691990023; x=1692076423; bh=zk
        izbUTAIxQH29l5UUOkg2ZePPgXb8Du8bWmk2iGUB0=; b=rj2FkwixNHD4bwFkP7
        lSvb2txdrt6j1Fr8s5CPtkPZ641AC/I9j9F8dUikG7Rnp1xymF+f9EkoZBuscVPO
        39TWi2t7k7HF+9kyciBm2PY77ibC1umhAqWI45zUTLtNoWML9l0rMxNr6UtT8MG1
        OOhrE3CRXvpzp4AlvYKW+1QXU156dceQgKZW9p2VjGbXmiK88BblDHTsOEvwOQTo
        u/MLAQKFXEWWxUplYhTYm6DQ6s2PKFVf4wb4KZvgBtD7PpyO4E6+/2VptYoC1Ede
        TZNwyr0SrV663crgpkfzO4rjPYtcoMxfHL2LOMtFN9vQ7RTGcHnzGfES6Jvj5dg6
        fALA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1691990023; x=1692076423; bh=zkizbUTAIxQH2
        9l5UUOkg2ZePPgXb8Du8bWmk2iGUB0=; b=0Y2xraBVEdqJJj4IMWcEtgP5a8Z7S
        /tIVflGH+eubGkJ7dpu/Ko2uEv6oaGIiRA6+IMR0bzgh3jmS5d3rQXKgjLfraM9J
        97RQIZJfz5lHF48pVUzDuW0rN+iA3/+R+5iFTNmV6GkcMxOhDAdJew6in6ehfPC2
        n7VdsqXg2g0TzIHyCmmIn1zjmzlfxcOATTTIHi1R9bgm7DHEo1h44fAGOCRf0SHg
        8E7sYKk4HD9Goti4xQPNnMuos3IHNVIrq6NABtbUnI4R0IZWxWhSxE2LfEQZoKzW
        NE4a9Uu0slPjKDynVFpvIu2QUFa1N+DP/1XAJ7taCI2uw2XQ071S5FrGw==
X-ME-Sender: <xms:B7jZZCsNzOEOGWYDBHe5CsRQPFzd_uWIP5akoT_8D0c3a-3932f5pw>
    <xme:B7jZZHdZUC3BojfFoCRfVoKORLgqzCoKE_oLrdVZiI_30f80Hgi1KKtCWjiu4js_S
    R-0S49FN8N8AUL0WPs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddtfedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfffgr
    vhhiugcutfhhvghinhhssggvrhhgfdcuoegurghvihgusehrvggruggrhhgvrggurdgvuh
    eqnecuggftrfgrthhtvghrnhepfeelgeeuheeihfeuleefleehtdektdeihffguddvheef
    iefhveelhedvvdfhueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepuggrvhhiugesrhgvrggurghhvggrugdrvghu
X-ME-Proxy: <xmx:B7jZZNxZqx4Tl71ECeK9tX8sztpBZtuL-FggBVaT1DuBTmbb62owsg>
    <xmx:B7jZZNNWZOXLrosQZuRC_kpsIpE4ftcrIzuyJq8d-mVWuIrPwolmKg>
    <xmx:B7jZZC9OghKJCx5z4LxBxHkpaQ-ifCGcFT23xLazxUkytv7XV6wvWw>
    <xmx:B7jZZGZi8bdDaxxqg5dffDaIpLATCiGngpyImRK9FqtmZm_tSqjJzA>
Feedback-ID: id2994666:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EB5241700089; Mon, 14 Aug 2023 01:13:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <6feef7e0-ea72-412d-837e-34b6fdd3b869@app.fastmail.com>
In-Reply-To: <20230811115710.GA21779@redhat.com>
References: <20230807085203.819772-1-david@readahead.eu>
 <20230807-porzellan-rehkitz-9fde1b94dd6b@brauner>
 <20230811112911.GA22566@redhat.com>
 <20230811-perplex-installieren-899f5925534d@brauner>
 <20230811115710.GA21779@redhat.com>
Date:   Mon, 14 Aug 2023 07:13:09 +0200
From:   "David Rheinsberg" <david@readahead.eu>
To:     "Oleg Nesterov" <oleg@redhat.com>,
        "Christian Brauner" <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org, "Jan Kara" <jack@suse.cz>,
        "Kees Cook" <keescook@chromium.org>,
        "Alexander Mikhalitsyn" <alexander@mihalicyn.com>,
        "Luca Boccassi" <bluca@debian.org>
Subject: Re: [PATCH] pid: allow pidfds for reaped tasks
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

On Fri, Aug 11, 2023, at 1:57 PM, Oleg Nesterov wrote:
>> What code do we need to allow userspace to open a pidfd to a leader pid
>> even if it has already been exited and reaped (without also accidently
>> allowing to open non-lead pid pidfds)?
>
> I'll try to think more, but can you also explain why do we need this?
>
> See my another email. Can't we simply shift the pid_has_task(PIDTYPE_TGID)
> check from pidfd_prepare() to pidfd_create() ? (and then we can kill
> pidfd_prepare and rename __pidfd_prepare to pidfd_prepare).

Yes, the easiest solution would be to use `__pidfd_prepare()` and ensure that the caller only ever calls this on tg-leaders. This would work just fine, imo. And this was my initial approach.

I think Christian preferred an explicit assertion that ensures we do not accidentally hand out pidfds for non-tg-leaders. The question is thus whether there is an easy way to assert this even for reaped tasks? Or whether there is a simple way to flag a pid that was used as tg-leader? Or, ultimately, whether this has limited use and we should just use `__pidfd_prepare()`?

Thanks a lot!
David
