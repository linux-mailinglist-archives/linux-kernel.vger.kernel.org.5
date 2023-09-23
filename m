Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83057AC2A2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 16:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjIWOYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 10:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjIWOYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 10:24:20 -0400
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D3919A;
        Sat, 23 Sep 2023 07:24:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695478990; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=T2KBF4yIjalK1ZzDEEM0bNBS6lrf1rzPibf611WAnNH6Vj0xTunIPujntuCeRexyyq9CDzFEumukC8m7vfaN02SKx+VLV/ovHo0wG1yHKmHvFTEI1FxRCePdQ4U5jyMA8Gk0wCA7ekmYJ4QcWIpoIWY7uuE+IqAO09QNiWlZErg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1695478990; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=WZ/aGCA500ed2bcHIimQvNXpZhLASpaAWul68HLtyGw=; 
        b=M77DzljXk6xpQujq654Kk9vs7HCjjuRSTg72l3/lw769poX2mZ9yZpNHro87Gr8TqivW9BHA3j1Kh8o33dWvSKmJg1kIzLn7pEHu5ufAnND563x63wSV8sPVHd+GYE7NP00a75Ng6t+45L+SevUlScckPUU8accni0XFdPUva4s=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1695478990;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=WZ/aGCA500ed2bcHIimQvNXpZhLASpaAWul68HLtyGw=;
        b=HIB8IY0kzqs3Ddq+mTUKr+78Mu8wosEADsTE/bbq6WTrTaXfoYwTkmn1GkjZYGNG
        uDSd7yQti2nKuCxcr4sz7/knfUb7kCndcoph2Wci1IZzz/cksZxUo5ziHtgHoKQGuEF
        MD7LhbGa+mGgOA9MFQI3O5JTZZpivQ5xB/zmussQ=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1695478959143581.0852754386215; Sat, 23 Sep 2023 19:52:39 +0530 (IST)
Date:   Sat, 23 Sep 2023 19:52:39 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Kees Cook" <keescook@chromium.org>
Cc:     "David Howells" <dhowells@redhat.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Christian Brauner" <brauner@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Qian Cai" <cai@redhat.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Tom Rix" <trix@redhat.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "llvm" <llvm@lists.linux.dev>,
        "linux-hardening" <linux-hardening@vger.kernel.org>
Message-ID: <18ac26bcc00.365acdab160974.4357076391181710171@siddh.me>
In-Reply-To: <20230922175407.work.754-kees@kernel.org>
References: <20230922175407.work.754-kees@kernel.org>
Subject: Re: [PATCH] watch_queue: Annotate struct watch_filter with
 __counted_by
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023 23:24:08 +0530, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct watch_filter.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: David Howells <dhowells@redhat.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Siddh Raman Pant <code@siddh.me>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Qian Cai <cai@redhat.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Tested with keyutils testsuite.

Tested-by: Siddh Raman Pant <code@siddh.me>

Thanks,
Siddh

> ---
>  include/linux/watch_queue.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/watch_queue.h b/include/linux/watch_queue.h
> index 45cd42f55d49..429c7b6afead 100644
> --- a/include/linux/watch_queue.h
> +++ b/include/linux/watch_queue.h
> @@ -32,7 +32,7 @@ struct watch_filter {
>  		DECLARE_BITMAP(type_filter, WATCH_TYPE__NR);
>  	};
>  	u32			nr_filters;	/* Number of filters */
> -	struct watch_type_filter filters[];
> +	struct watch_type_filter filters[] __counted_by(nr_filters);
>  };
>  
>  struct watch_queue {
> -- 
> 2.34.1
