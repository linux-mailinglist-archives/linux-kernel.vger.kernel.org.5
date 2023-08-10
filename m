Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4377781F6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 22:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbjHJULg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 16:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjHJULc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 16:11:32 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832B12703;
        Thu, 10 Aug 2023 13:11:32 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 63DF73200368;
        Thu, 10 Aug 2023 16:11:30 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 10 Aug 2023 16:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691698289; x=1691784689; bh=Ie
        xsvfw1cSN0AHILi8t7T6cxqy71VoAFUBCzH5RLnhA=; b=pBf73bu68l2HvbTjG9
        ++HMIMHmzqFZxtPdA0L2Y2inmvhCGFOlvLqE0Vcxt2G/QC+lTRtCEgv505ELAun8
        e2QijyLwAAfpqrLN+B/N+b8Erc2OPEfigQl30xvNm7PYuOgGKuK3xpDtU+H1k1pc
        zyGdSIRzRwStvHJDsruOmVwKtZjAsyimFHEU1qKROk4WOFlkL9RzFcm5NGWw4ujZ
        NqZJjyMJxLeSVqpsjzsvnLJY9Ekfaa4FWp55Z1ezRZ6J+WgTvhQi2bNpa41wgNn4
        tPhZMWe9PlGBAdCawKo3+glK+qPD9bpJ/4jGgIe6J5kG7gLmmALv0RFaMyHID11/
        l+PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691698289; x=1691784689; bh=Iexsvfw1cSN0A
        HILi8t7T6cxqy71VoAFUBCzH5RLnhA=; b=X7JthUmmG+TlMvALGhfqEmJdiJWfu
        bhvBx0RCHppI0rNQufuOcR5DRrJ1PYrUJH50uuhn21BOpPq/V3KU4sBG/o9/K/JN
        tfujqozoqjt1ZfelkMsuiychpc1lzf9JZD7i+1sylwbgL9Oltd7tmi5kzdWm10EV
        wqNQ/GsDMj0UvJjQ+Ulu82LP8j456l7iHzF15iW0o15yCmK39k5xCjM/OinmWQle
        fjitsC3Dl56j8Cs7gbkH5I/vLdEdIkd5UzmjXMXylmPSN3v044rjSL91sE+5G5kA
        lf2dyzOnw0lbG0qnm8bHjlaaebJtGtWCtd3L87jP5fyN/CK9LnDe5SAuQ==
X-ME-Sender: <xms:cETVZLlaHSWMOVJw0IHj0HpKR2m8q_UQ5WePy6mAhg4D9scaU_LbsA>
    <xme:cETVZO3yg4Xb3DgfO3-r2OSwOtPFHwD-EhoDVyr7FBGxm8Hc2JjzPC3BZJ-AqvMSD
    CzXOlVLui6h2dVPQYI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleeigddugeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:cUTVZBq1S9UkHFXOGOVIq5vwLQBH_ZexESAcGIF0XYH-miW3ODCZWw>
    <xmx:cUTVZDnkzJotSAZCUzCzmfNVgbFhooruhrdaeuJt0wEsuRi54IkL3g>
    <xmx:cUTVZJ0mGA2Woeh9TSPYRHiWhZwjMF1bpwHf9PjuC9NdKz2fo4ougQ>
    <xmx:cUTVZHOkTO8uLaiweAznPfPtmeIxQHpIMAa_x-SLb5klBmMIn6fHLw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E4940B60089; Thu, 10 Aug 2023 16:11:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <7e137ddd-a954-4a2e-89ac-5d2cb59775de@app.fastmail.com>
In-Reply-To: <20230810195422.2304827-2-keescook@chromium.org>
References: <20230810195141.never.338-kees@kernel.org>
 <20230810195422.2304827-2-keescook@chromium.org>
Date:   Thu, 10 Aug 2023 22:11:08 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Kees Cook" <keescook@chromium.org>,
        "Russell King" <linux@armlinux.org.uk>
Cc:     "Arnd Bergmann" <arnd@kernel.org>,
        "Lecopzer Chen" <lecopzer.chen@mediatek.com>,
        "Oleg Nesterov" <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Wolfram Sang" <wsa@kernel.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        "Russell King" <rmk+kernel@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ARM: ptrace: Restore syscall skipping for tracers
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023, at 21:54, Kees Cook wrote:
> Since commit 4e57a4ddf6b0 ("ARM: 9107/1: syscall: always store
> thread_info->abi_syscall"), the seccomp selftests "syscall_errno"
> and "syscall_faked" have been broken. Both seccomp and PTRACE depend
> on using the special value of "-1" for skipping syscalls. This value
> wasn't working because it was getting masked by __NR_SYSCALL_MASK in
> both PTRACE_SET_SYSCALL and get_syscall_nr().
>
> Explicitly test for -1 in PTRACE_SET_SYSCALL and get_syscall_nr(),
> leaving it exposed when present, allowing tracers to skip syscalls
> again.
>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Arnd Bergmann <arnd@kernel.org>
> Cc: Lecopzer Chen <lecopzer.chen@mediatek.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Fixes: 4e57a4ddf6b0 ("ARM: 9107/1: syscall: always store 
> thread_info->abi_syscall")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
