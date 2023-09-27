Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754607AFA61
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 07:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjI0Fwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 01:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjI0FwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 01:52:04 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A94DD;
        Tue, 26 Sep 2023 22:50:21 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 069EA5C279B;
        Wed, 27 Sep 2023 01:50:19 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 27 Sep 2023 01:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1695793819; x=1695880219; bh=o7
        81UB75dWtQPWqWz6T4vyY29QjIlXMO7I9AjykpvSs=; b=YOT4isX4Z7eoYa9AnX
        A+p+d+XSOzWhESZ3HtZ5f6sQlTcTZ8CrMeGEqmzqdI614EcFxdsaYTaPfsrHPncP
        hwMC4AOqd2j+thNvvcFUF+CoxfFGfucoKRlRHyOz0NZaeiL4W9I7Gz2kunvnHwaS
        4Q/9YvxoMperG28X25H3nf8af6f1T2CEHKX6hpkR8Ebx2MQPz2r2gzTu5SIU/5N4
        Zc8BwIT4MX5KmMeVXUYIBvITzHvAGKRpVK2MDSTVjQrtn0OS3YLGzlxgYKZGGU8c
        tsG3PMUGlsDG+i7a4U4U3W5+FJh23Jyc0EoEPbTHWUTpn556ioRFqs3SWiADyKui
        MZCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695793819; x=1695880219; bh=o781UB75dWtQP
        WqWz6T4vyY29QjIlXMO7I9AjykpvSs=; b=U1yJVQKvG270QvtV7tXFsPOcaZLLD
        yEEH2DxH+BOtgfVJJPX+5AawRPDaO9+TPqhh8raF0ml6dxYGFqoG1UmZyKy1VmZN
        KPT+bnVUmscNnHNdP5PDSx0MzZz2635/ofTrtwtfu9N2a0ICKfoR1K8N7/sdQwcA
        O9QcI3G3XAmq1pOd4KYqgJrA8ym7Jl46fNVpQqfLG9UbhTYlnfYMUaRV6ii2LLiU
        1NNsVcsQRWJZHE98+znNbq5/ytyP3em9yfVxJeEFMt799bq694UUVd5PgPnR0HZY
        wy4HRRppFkWcWMrFPyvd7SpKeaDyuoQuXhXwukboxKgxBDYBf53nIS7/g==
X-ME-Sender: <xms:mcITZX50sTS5Pr-ILjqro9fQJMD9vZ5yKgHCvUUcbutinozr9z2Tkg>
    <xme:mcITZc7pVc5RoY9WdgFmGpecTL4V5Q4Vds7CAudgFLpiLwkNZJe1pnTQOuYsTtqRH
    IhnchUbs7sJmJd_d9Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtddugdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpefhgefhteevtdeviedtgeffueevjeevtedvkefgvdekudfftdefledtudeljeej
    hfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdguvggsihgrnhdrohhrghdpghhith
    hhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:mcITZef46y8tcoyWOxRFgYpnQMVjCA9pnVenMPXV6VPbJ_hkt1cJDA>
    <xmx:mcITZYLw73TUyWwuDs9xMDoh13nl0-yvygoOoMiJh6jBaT_OnxJzEA>
    <xmx:mcITZbL3WQyKtGLuzdaCoVpoJ3cznnWz1dsvmmJbaW3RDVCLcs_2mQ>
    <xmx:m8ITZRjKb7WG-BlTVXG_sEcTSG2s2dAahe-0cD8NCNkVqFdej9kiwA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D043EB60089; Wed, 27 Sep 2023 01:50:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-957-ga1ccdb4cff-fm-20230919.001-ga1ccdb4c
MIME-Version: 1.0
Message-Id: <b70fa1d5-7f38-4511-ad2a-abe1b1ad5992@app.fastmail.com>
In-Reply-To: <20230927-strncpy-drivers-misc-c2port-core-c-v1-1-978f6d220a54@google.com>
References: <20230927-strncpy-drivers-misc-c2port-core-c-v1-1-978f6d220a54@google.com>
Date:   Wed, 27 Sep 2023 07:49:56 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Justin Stitt" <justinstitt@google.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] c2port: replace deprecated strncpy with strscpy
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023, at 07:20, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
>
> We expect `c2dev->name` to be NUL-terminated based on its usage with
> format strings:
> |       dev_info(c2dev->dev, "C2 port %s removed\n", c2dev->name);
>
> Moreover, NUL-padding is _not_ required as c2dev is zero-allocated:
> |       c2dev = kzalloc(sizeof(struct c2port_device), GFP_KERNEL);
>
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
>
> Let's also drop `C2PORT_NAME_LEN - 1` for `sizeof(dest)` which is more
> idiomatic strscpy usage.
>
> Link: 
> https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings 
> [1]
> Link: 
> https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html 
> [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
