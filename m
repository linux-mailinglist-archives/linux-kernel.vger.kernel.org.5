Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A8D7AD6F2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 13:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjIYLYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 07:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjIYLYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 07:24:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E35DF;
        Mon, 25 Sep 2023 04:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=CZlIUfCEZAaduIab/BeYk1An+kVppDAcETHyx1HtxZE=; b=OLKk7KzHiiGpF1sqjWKSHcWnBZ
        92q6oAsLH8WkTJ+FhxjcGNaRuF+h8XwsCxZhYYqda0aMpb2cL4VmSVVm/BkygQ4pqREJW/O9PEsoH
        kGpcMhAXZLjcT2iGMbS73ooDgePc0V9S2npQoXjzsW/GmDP0nW9GDTZdiPVJ1Q+Xj+IX5wXMqaCtE
        IFO648RpE+win1TFMnfxg5RDgEfDQvFgtgXf418BDPcR5oid/G6hnWo9eDcna1Wz9Bxek/r6HC7XD
        jkiltcKNHN6SeLrlkuv6M8SpYywXLT+jiqcyO63cHS7K67XKjPSzn9pbj1sVAWbU/7SkZZB0a8LC0
        WSmJI7FQ==;
Received: from [195.181.170.235] (helo=[172.31.28.226])
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qkjhM-001A2F-Jx; Mon, 25 Sep 2023 11:24:20 +0000
Message-ID: <cb5e785d19a15356d85bca11bebf7975c495e948.camel@infradead.org>
Subject: Re: [PATCH] virtio_console: Annotate struct port_buffer with
 __counted_by
From:   Amit Shah <amit@infradead.org>
To:     Kees Cook <keescook@chromium.org>, Amit Shah <amit@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        virtualization@lists.linux-foundation.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Date:   Mon, 25 Sep 2023 13:24:19 +0200
In-Reply-To: <20230922175115.work.059-kees@kernel.org>
References: <20230922175115.work.059-kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-09-22 at 10:51 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUND=
S
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>=20
> As found with Coccinelle[1], add __counted_by for struct port_buffer.
>=20
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/c=
ounted_by.cocci
>=20
> Cc: Amit Shah <amit@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/char/virtio_console.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.=
c
> index 680d1ef2a217..431e9e5bf9c1 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -106,7 +106,7 @@ struct port_buffer {
>  	unsigned int sgpages;
> =20
>  	/* sg is used if spages > 0. sg must be the last in is struct */
> -	struct scatterlist sg[];
> +	struct scatterlist sg[] __counted_by(sgpages);
>  };

Reviewed-by: Amit Shah <amit@kernel.org>

Greg, please pick this up.

Thanks,

		Amit
