Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F83780269D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 20:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjLCTTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 14:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCTTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 14:19:46 -0500
Received: from mailrelay5-1.pub.mailoutpod2-cph3.one.com (mailrelay5-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:404::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947C7D6
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 11:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=rIA/VTAshu8TtbHwnRhRIY/l1QMC3eABQvOmudQt1/g=;
        b=sVEfynpC0ny4CWOUnhDfmUGjlEvTC2IpTC6ucwVB4ykc6YBFVqAMyAHTWyw8/p1+8qx9ZAA//ZNKm
         mgk/X8n0eAe0B0ZIoy5nnqxLc4NEmqyL+JHUk77uXNSoCSMlF7OHLGQQ8meRYrhY/iC6J+9pBSJZd+
         2A7CpJU9vAcIDsFs7+kgGtrBpHMOOzhIMWoMU9Oww06ZHJnXskd72fsv/gN5TeMxu+TygrqlsRAIkn
         DbztQOw13qFomHk67mrQkdabk3rDZEKbwyQM+mdBV98ujJyIExD3kFZMQeEcHfcZfrlGZyKQCvAuBD
         +eRz71mGIyOc7geZrSZ8B56Xj/zeiFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=rIA/VTAshu8TtbHwnRhRIY/l1QMC3eABQvOmudQt1/g=;
        b=2ytiNmKTQ2JnHyg1W4z5eLbB8CSVeaLDyP79SvslWWmrpyMJ/hTwcJNbwgMqXFxLxlzMnJkmt9dfh
         3pnW7g6Bg==
X-HalOne-ID: ec77c7d3-9210-11ee-b4a7-a71ee59276a3
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay5 (Halon) with ESMTPSA
        id ec77c7d3-9210-11ee-b4a7-a71ee59276a3;
        Sun, 03 Dec 2023 19:19:49 +0000 (UTC)
Date:   Sun, 3 Dec 2023 20:19:47 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 1/3] sparc: vdso: clean up build artifacts in
 arch/sparc/vdso/
Message-ID: <20231203191947.GA147536@ravnborg.org>
References: <20231203101418.1910661-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231203101418.1910661-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro.

On Sun, Dec 03, 2023 at 07:14:16PM +0900, Masahiro Yamada wrote:
> Currently, vdso-image-*.c, vdso*.so, vdso*.so.dbg are not cleaned
> because 'make clean' does not include include/config/auto.conf,
> resulting in $(vdso_img-y) being empty.
> 
> Add the build artifacts to 'targets' unconditionally.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Nice small fix/clean-ups.

This and the following two patches are:
Acked-by: Sam Ravnborg <sam@ravnborg.org>

> ---
> 
>  arch/sparc/vdso/Makefile | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
> index d08c3a0443f3..eb52d0666ffc 100644
> --- a/arch/sparc/vdso/Makefile
> +++ b/arch/sparc/vdso/Makefile
> @@ -24,11 +24,8 @@ targets += vdso.lds $(vobjs-y)
>  
>  # Build the vDSO image C files and link them in.
>  vdso_img_objs := $(vdso_img-y:%=vdso-image-%.o)
> -vdso_img_cfiles := $(vdso_img-y:%=vdso-image-%.c)
> -vdso_img_sodbg := $(vdso_img-y:%=vdso%.so.dbg)
>  obj-y += $(vdso_img_objs)
> -targets += $(vdso_img_cfiles)
> -targets += $(vdso_img_sodbg) $(vdso_img-y:%=vdso%.so)
> +targets += $(foreach x, 32 64, vdso-image-$(x).c vdso$(x).so vdso$(x).so.dbg)
>  
>  CPPFLAGS_vdso.lds += -P -C
>  
> -- 
> 2.40.1
> 
