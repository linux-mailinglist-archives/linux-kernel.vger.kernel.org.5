Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193C179D93F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbjILS51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjILS50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:57:26 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EDE12E;
        Tue, 12 Sep 2023 11:57:22 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 2EDF2320093B;
        Tue, 12 Sep 2023 14:57:19 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Tue, 12 Sep 2023 14:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1694545038; x=1694631438; bh=IO
        zvu/wQcUFkL4kn5T1Kjk+uNEL61aUsY9SPgQk7MK8=; b=fjRUzQkLRdHpPSr/bH
        YcTbtRZRnuegXtWvPvj4mVPNpYgtfr88rYTfbN928dcorgSUOF05+NBMYMgvl33t
        GXf4ud0A7HzXZ+jGZxjBFxZ/YyQ2wXJT4HZsShKYniX6FyJLLKeIOEAwb5VDHPAU
        OYj6kZU20rvku9KyiDuzDKI1OySYFFWJiqKfFtSmGMM8MsJpuDw/oCQ0cz8zkcoR
        u1RsINbT7mdE1onkHk6oBg3haf5cWbrly3f5h5HzATXHeMEwBlDR/CMqdq1cUUyQ
        /5Sycynrnnd2yiZex1o6yx4daJ86HeVLIR6EpzHB3jIJ73QGI2+4uKQ5DH7KozcI
        7Ufw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694545038; x=1694631438; bh=IOzvu/wQcUFkL
        4kn5T1Kjk+uNEL61aUsY9SPgQk7MK8=; b=UYXKWnLMfWop89e7j4f9N7jjtixK5
        CdgqFXswkYj/IVEA1NoNIbov+HV7iiYW9wjnxA/erO8gT0hIyTLtCBikUPMu8aAT
        j3Hf+dtTe61bsHupLyeBa+1FLsJYp26mjDgwC5cYkAyDZh+RBPn02gPguwob5qfJ
        LcnPmUp0GFNfydkk6wvLMPpe8KOzNTz62GfATX2NNDmPUDw18dB1kf8gZYN7eAkk
        gFM3I+9PT5vW+xTHOBbOJ6Peef7HjIdF49XLUjYio6BTRpUojXZwVhMM9m4fUzMA
        unzGyC6MnwsAU6rx+X34etqnnV0CeWdMNMJUJVhOYeOTUEjuqRwd69ghg==
X-ME-Sender: <xms:jrQAZTCQbmetTJDuFCCQR61VfTjAAOCjGDB-K3C8dqSN-evJlV86_Q>
    <xme:jrQAZZig1DMDWE_62DVpraDmk617hgxipymz-3rBAsH6Fn2KvIysmTAmsYeFKzpLS
    4tPEI9kdGvHz24zpLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeiiedgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdduhedmnecujfgurhepofgfggfkjghffffhvfevufgtsehttder
    tderredtnecuhfhrohhmpedflfgrnhcujfgvnhgurhhikhcuhfgrrhhrfdcuoehkvghrnh
    gvlhesjhhfrghrrhdrtggtqeenucggtffrrghtthgvrhhnpeffffeufefhiedvfeehgeev
    ffffffduvdduhfefjeekgeeviefhuddvgeekvddvhfenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkvghrnhgvlhesjhhfrghrrhdrtggt
X-ME-Proxy: <xmx:jrQAZelIUe3yeq58-Ap3xp3GqR2zs-LFhkq_HncTgOMURCKDaL6sbA>
    <xmx:jrQAZVzNzJwXgifUnRvbG7FbJ4JfQkS9annFNQz558KT-FgSwvQxPw>
    <xmx:jrQAZYTcxxjd7h28Rrpfcz1snySktoEscXU88QJld8PoW_O8Kz9BRw>
    <xmx:jrQAZdKXrtYBUrI-t_nS4nQjWDScGwY29_csWMpEGPUBsrC5Wt131w>
Feedback-ID: i0fc947c4:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 492CD15A0091; Tue, 12 Sep 2023 14:57:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <5a67051d-eb21-4a96-acc4-40f829a59e23@app.fastmail.com>
In-Reply-To: <CVH4GZXQFZ1F.2V5BIZNSKQ1FA@suppilovahvero>
References: <20230909161851.223627-1-kernel@jfarr.cc>
 <CVGFE6FRWFHR.DVG9NUQID4EA@suppilovahvero>
 <1d974586-1bf7-42e8-9dae-e5e41a3dbc9f@app.fastmail.com>
 <CVGVCYUGNKAI.1WYRZGI9HYDMC@suppilovahvero>
 <9580df76-c143-4077-8a39-b1fcc0ed37bd@app.fastmail.com>
 <CVH4GZXQFZ1F.2V5BIZNSKQ1FA@suppilovahvero>
Date:   Tue, 12 Sep 2023 20:56:57 +0200
From:   "Jan Hendrik Farr" <kernel@jfarr.cc>
To:     "Jarkko Sakkinen" <jarkko@kernel.org>, linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de,
        dhowells@redhat.com, vgoyal@redhat.com, keyrings@vger.kernel.org,
        akpm@linux-foundation.org, "Baoquan He" <bhe@redhat.com>,
        bhelgaas@google.com, lennart@poettering.net,
        "Luca Boccassi" <bluca@debian.org>
Subject: Re: [PATCH 0/1] x86/kexec: UKI support
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What sort of bottleneck does the EFI stub have so that we need yet
> another envelope?

Well I can come up with a few advantages of UKI compared to normal bzImage with builtin initrd and cmdline.

1. You already identified this one. Using addons to adjust your cmdline
2. I can use my normal initramfs generation tooling. Just install my compiled kernel, my distros install script will generate the initramfs. Then I package it up as a UKI. This will be a lot more awkward with a builtin initrd.
3. Measured boot. You can place PCR signatures in the UKI using systemd-measure. This will sign the expected PCR values for booting this UKI. I think with normal bzImage this will be a lot more difficult. If you place those PCR signatures in the builtin initrd this will change the kernel image which means now the values you signed no longer match (depending on how you measure the kernel; I don't think the normal EFI stub even measures the kernel in first place, but I could be mistaken about this)
4. UKIs are automatically recognized by systemd-boot

There's probably more reasons. The main reason for me to go with UKIs initially was the good tooling around them.

You could probably overcome some of these drawbacks in the default kernel EFI stub. For example it could also get a place to put signed PCR values. And it could also do TPM measurements. However in the process all you're doing is rebuilding what already exists today in systemd-stub and the tooling around UKIs.
