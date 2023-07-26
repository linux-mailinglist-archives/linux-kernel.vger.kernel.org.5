Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D53763D24
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 19:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjGZRD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 13:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGZRDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:03:24 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B8810EC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 10:03:18 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id EC3DA5C019E;
        Wed, 26 Jul 2023 13:03:17 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 26 Jul 2023 13:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1690390997; x=1690477397; bh=pffJfAxWXhzPqO9RJUcLmLEFkSH/WJE9Vpj
        UyBhgoSs=; b=SALvpCzKcgZXLm3OywUOCz20SERT2uXtdYzioLk0cGE2gO6ePRe
        kuub08yT/wrbxvx9FglxWwvGMeZflBvA+2MCI+4MAP1yISd26rk6WLfHGh2VI6lp
        CW1VR4AjflWfr7AI2D8OCYaC460eIRKyo1FOJZdXjOHJQowFFFXdeYtFr3kjPKOq
        wTTgkObJksTY/wsKjQMZ/FGhv4StS9lFFgcAzVbaUfVn856ZToQfRVYvDhD5Rwyk
        C4OtkL6xJqkYJ+o9breA99zo5PpdmOot+VCw436ThBHqr7BxDtSafvxqr+Z/vDwv
        P9hOYbmGJwJqwYRd9fpJGP8JnPn4VSPqBaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1690390997; x=1690477397; bh=pffJfAxWXhzPqO9RJUcLmLEFkSH/WJE9Vpj
        UyBhgoSs=; b=iGLHxr763+TKShDHHm4Ozn8CKZdGBAcaDh5SIgmPFyGP7d0RL7y
        j54sttEtCBmcDbBmFUs1GXqiW+EqKj2ovXnHwIZxzpNRqRYK741a0TJ2B4yNRTbX
        26dtYvth8M71aqkvq4egnr1AfCMTOnq75pHfuXHERHL8yOpLlKPBHnETAafhJHxK
        z/1IOv45crukvGosp7VIu/VbmH25acnLCcOZP2LkcpIyo1hwIGAMzWTN1D6gbtpY
        RS8NVhV4OHY4S7mmofuJmXSBK5R2HLLbvlhbPNdOWNQdKeIewuBY1yBMo6UsVjWO
        Cx+AXruefBOs1+hlO/0iaVnw3LDv9P9ENJQ==
X-ME-Sender: <xms:1VHBZBSPQL1MGMGQ_hv8IQbfZ_oDtTER9QF6-wOEtxpseSDX6Os7Sw>
    <xme:1VHBZKz_bhsVPU27oCouqUG5upcChT1CtGXwCwWDCqBI7hHmqq7xhNPlzLUaZZh8c
    _HPqnTRRt8UViQPCwY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedvgddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:1VHBZG285zklzyTsPL2s1kmtspzM8pLkDUEBePYh2mv3gTQUi8xAnA>
    <xmx:1VHBZJCUVFo-DAAxEM7nSsDtyAWWGV4cJRVJUEvgCEwvckemYgInig>
    <xmx:1VHBZKhlgIQbvttwcxzcUs4PCr_afzaCfyTQdaDkYELMt4Taj2RlQA>
    <xmx:1VHBZDWaYvz76zD8BDxANvZm4lO6BTtwZ3_6HCfgv-CIp5iJZKq3sw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 410B6B6008D; Wed, 26 Jul 2023 13:03:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Mime-Version: 1.0
Message-Id: <034f0b5e-3c61-4392-8360-ebd57749d53e@app.fastmail.com>
In-Reply-To: <CAKwvOdnk+e_QmE+QpcqzntNVgf8mL+NOPtUggj4F__iTf_XD+A@mail.gmail.com>
References: <20230726143348.724611-1-arnd@kernel.org>
 <CAKwvOdnk+e_QmE+QpcqzntNVgf8mL+NOPtUggj4F__iTf_XD+A@mail.gmail.com>
Date:   Wed, 26 Jul 2023 19:02:55 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Nick Desaulniers" <ndesaulniers@google.com>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Kees Cook" <keescook@chromium.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Sami Tolvanen" <samitolvanen@google.com>,
        "Alexey Dobriyan" <adobriyan@gmail.com>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init: keep boot_command_line after init
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023, at 18:25, Nick Desaulniers wrote:
> On Wed, Jul 26, 2023 at 7:33=E2=80=AFAM Arnd Bergmann <arnd@kernel.org=
> wrote:
>>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The boot command line is not available after the init section gets di=
scarded,
>> so adding a permanent reference to it causes a link time warning:
>>
>> WARNING: modpost: vmlinux: section mismatch in reference: cmdline_loa=
d_proc_show+0x2 (section: .text) -> boot_command_line (section: .init.da=
ta)
>
> cmdline_load_proc_show is probably inlined, but should it also be
> marked __init?  It's lone call site seems to be __init AFAICT.
>

No, that's not what it does: cmdline_load_proc_show() is called
when someone reads /proc/cmdline_load from userspace. It's only
the function that creates this procfs file that is __init, but the
call happens later.

      Arnd
