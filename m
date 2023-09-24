Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157497AC82B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 14:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjIXMzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 08:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIXMzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 08:55:07 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D3AFC;
        Sun, 24 Sep 2023 05:55:00 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 9BB575C00B4;
        Sun, 24 Sep 2023 08:54:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 24 Sep 2023 08:54:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1695560097; x=
        1695646497; bh=upcTOUv0s1EAQvf7LZF+X61mhFBEOsrezBxhi1tuN1E=; b=D
        Vj+DrDCuSDVaNNM2OxSmHfA4eQYRCtpwV8kzSHeTXErr+x19tfKbKqB1cIKFVjIC
        Suzy7TdPNazUvrrtiUKATWgPojNFZIHN3dEuL/GzP/nbaXRHS2CgkIiGZEfTLx3r
        GByWCKHd5As9VKKcJn+oHaZysZpZZWFYtMFH9bmdu+0iB4dqouPkuTneE7KchjZP
        UlWfgkxhUgcu0C14l2TF3X0OTkqYy1rUGIYoKV5F5Q4gxjPHqer3LHQnsHUx0BNn
        olK6q2GHj9KqBigfNEpS5QsKFZBJGRpZRvgHrFXHqHo/a8Eu1twOkh8n0u6uHekS
        AasGVJIwI1qz7emzPorhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695560097; x=1695646497; bh=upcTOUv0s1EAQ
        vf7LZF+X61mhFBEOsrezBxhi1tuN1E=; b=ozor45gGnPdBTUlpI9Gn3UIpBn1/7
        Cdy6Jb+e2IRZV2Z7yaiSU76MLWc4ZrVGl45WgRrYi0Tw0T9GZ+wpI8rVvpzWsRqD
        03AOL7NSiiCVo62DjSqYi2im/MRh3Als1S1KbAMLzur+7vukt3w3nLfP07byRFPw
        AJqBqh11x/4YQCk5WqwbGofrAmYtP7ZNEEPX+NGkqsa26mcVEyQkV5s72IZsAzzC
        giKqoeu1VxCwGECAEcdGdTO6nwMLyGfFVJJHJ6tz8A9SGCFFwtX6DuCLDbG0kqNK
        KmhJC215IemEYcQHpfZwHQ63XrMFywzvKLX5VQ7upxmfDNjKZ1Pl3eNJQ==
X-ME-Sender: <xms:oTEQZcRa6dWdP15_7XLqsKX9QtiePGFI_-HUq4_JNpLOUjbQ64iYPw>
    <xme:oTEQZZzZjaj5dpJ0FC066zlVmgKmo4m3WM2zWlVJ4Cns-DRIHIZQ8XqmibflxxwH1
    rn1spcTSJ5Hrvlr_U8>
X-ME-Received: <xmr:oTEQZZ0nGBGZ5eo0XNvqQ2V8uxpagKxztrH35GWzyuXyM_kYvzff6Uk3QrcDK3JyW7NOPNXsNhb2INgKP8aFD4q_SvgnuOyeXCY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelvddgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhepudehgeeuveetuedvkeekvdfgffelieeivdelhfet
    tedtveettefgffegjeefleeknecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:oTEQZQBYf-qKo_bj25wnk7uzD0U2kOBN9JkeI2rXv9o-BJvsI7Qj4w>
    <xmx:oTEQZVg8jJ3NvMN6R6AgcAhozpUrwFi3bD-u6bk1fintqhYwcBt4uw>
    <xmx:oTEQZcpd84R5h0reAkVDd5RGwHr_THcak0TMjZ4n3lOIZsoL11qPPQ>
    <xmx:oTEQZQX5Mm-JshwYDF5L_yy083R2F0ilOIcV9x3jheqLbtFvOwA3EQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Sep 2023 08:54:55 -0400 (EDT)
Date:   Sun, 24 Sep 2023 21:54:51 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux1394-devel@lists.sourceforge.net,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] firewire: Annotate struct fw_node with __counted_by
Message-ID: <20230924125451.GA329414@workstation.local>
Mail-Followup-To: Kees Cook <keescook@chromium.org>,
        linux1394-devel@lists.sourceforge.net,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230922175334.work.335-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922175334.work.335-kees@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 22, 2023 at 10:53:35AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct fw_node.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Cc: linux1394-devel@lists.sourceforge.net
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/firewire/core.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next branch, thanks.


Regards

Takashi Sakamoto
