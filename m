Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B757A147E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 05:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjIODk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 23:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjIODkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 23:40:25 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35DA270C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 20:40:21 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-27489f78e52so665833a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 20:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694749221; x=1695354021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=emL8gA7NYvcjlfqjFCfssMU1Dd1/VuC6P+GxTP1jKsg=;
        b=MyP9D0dSZY+fWf4QeF4UdYcx2K6f4ifR/RvqMLfDWZFAoiEbVe40OpTeNjLZBffFvt
         PXF/RkkUs9nETu7y8+Ew2+kq2I6i7L2qBiiw/Tsg8kKwUXGfZrPFJEg7v8STx/lEsbl1
         jbYqFT/1Z6Db4eklu8RuKWI9x3rSEhtPtA+qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694749221; x=1695354021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emL8gA7NYvcjlfqjFCfssMU1Dd1/VuC6P+GxTP1jKsg=;
        b=MBOIcplmncz5GSBRCHEuVx7HQeaoEChwAEklOjGpGyiHPsuEuTOkg9Urjk4nM9s6ht
         0K8avpHOlVWDVPacCndxfIfJGuJUslUCs8Z5M6dlbE5EM8XgHNsaTIGg5UtZfqaM+IJz
         9k+rvTU+fCqh+C8b01k9+uPCuIA53nx8MX2vyd3vP66dCd2U3MgJC5j52W1fM7ziy6VW
         07Fjv2Gi0M+Y4aILbRfEl3AqGRkU+xA0rwNa2TrSuq9ZeWYcu+YbK+JP09A3GVOX3yAj
         fVTMrzTZxGKtksz96H8RopQRY/bQLzwoUHjG+9EU4j3CRYipBvEs6pIQnxOLFmQbRKzS
         OIvA==
X-Gm-Message-State: AOJu0Yzek05n9kunO0+8WcAS+m9sH6b54Ma+2fdmi3VC/p7PytJF86uC
        EbY42BS3DXOtGw+NejaGKmPNNg==
X-Google-Smtp-Source: AGHT+IHrCMHvgrUBjySOfb5emjIZgc6gpCkZ0ynmYN2q5pu+0IiNfABJI4OWAU5wgyM1LCCux4SH3A==
X-Received: by 2002:a17:90b:3583:b0:268:7be6:29a5 with SMTP id mm3-20020a17090b358300b002687be629a5mr373511pjb.9.1694749221378;
        Thu, 14 Sep 2023 20:40:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902748c00b001b246dcffb7sm2330294pll.300.2023.09.14.20.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 20:40:20 -0700 (PDT)
Date:   Thu, 14 Sep 2023 20:40:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, qat-linux@intel.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] crypto: qat - refactor deprecated strncpy
Message-ID: <202309142039.F903B1C@keescook>
References: <20230913-strncpy-drivers-crypto-intel-qat-qat_common-qat_uclo-c-v1-1-88a6c07fc924@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913-strncpy-drivers-crypto-intel-qat-qat_common-qat_uclo-c-v1-1-88a6c07fc924@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 12:51:05AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> `buf` is expected to be NUL-terminated for its eventual use in
> `kstrtoul()` and NUL-padding is not required.
> 
> Due to the above, a suitable replacement is `strscpy` [2] due to the
> fact that it guarantees NUL-termination on the destination buffer.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/crypto/intel/qat/qat_common/qat_uclo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/intel/qat/qat_common/qat_uclo.c b/drivers/crypto/intel/qat/qat_common/qat_uclo.c
> index ce837bcc1cab..e2f82128043e 100644
> --- a/drivers/crypto/intel/qat/qat_common/qat_uclo.c
> +++ b/drivers/crypto/intel/qat/qat_common/qat_uclo.c
> @@ -200,7 +200,7 @@ static int qat_uclo_parse_num(char *str, unsigned int *num)
>  	unsigned long ae = 0;
>  	int i;
>  
> -	strncpy(buf, str, 15);
> +	strscpy(buf, str, sizeof(buf));
>  	for (i = 0; i < 16; i++) {
>  		if (!isdigit(buf[i])) {

I was initially worried when I saw this walking the entire contents, but
I see it is explicitly zeroed on the stack first, so this is fine:

        char buf[16] = {0};


Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>  			buf[i] = '\0';
> 
> ---
> base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> change-id: 20230913-strncpy-drivers-crypto-intel-qat-qat_common-qat_uclo-c-0f4b16830f59
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
