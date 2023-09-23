Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2747AC3F3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 19:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjIWRcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 13:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjIWRcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 13:32:09 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B867136
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 10:32:03 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3ae0b0e9a68so2198662b6e.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 10:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695490322; x=1696095122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6gvvXDcU16cywZW5qlvx++3wmaqbF3rOKpU79fjE2DA=;
        b=JBV1HyzrtOIQdp6y4VafOxQcox3CAbZULaozUtJlsIgNHXE+iqebIJom+XcbR2U4tS
         mJd+p/61JrxTo58JAg6kild5nbDmqDRbXHlUxTolCYth4k3w+uI5GPpKrY3vPCI0OBVf
         RNS2ouzR9qCnvr86T75S6msPicSDxim8C8QZ4U2iLTlWsOlKaPAj6uWYpswv2E6edQp+
         PL1IPN15n838r0Ih0JSoy4WaWg3Ot95bMFAkhVZ7EnGytB7xKwlah+NSMXhPRSuS/LYH
         sSLN83kXmIR/j/9w+Zy3FHpj3eWw5iT3bW4oWsSz83AKNjlFY9q5Me4dUtXxFo7/Jeog
         okfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695490322; x=1696095122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gvvXDcU16cywZW5qlvx++3wmaqbF3rOKpU79fjE2DA=;
        b=AjVRDs8J5j74boOyyhWBPTEIiB9Jor/QQUlvncK0xvBkreXGx/AdhSUH3KRLfXKY/i
         X9njqO5vvN64rjkpl8zxJBF/baMxM5xVNTl8W3hTlw1uNnMpbzcT8zBeHkaS5Jgoayyc
         CtruAZcIj8EbaGIu2RoMZifA6fvPOA8gf+V2h51Twlu+insmdlH4JW9LmAWcTpvymXWl
         SHQsME/lAKpRX74r3ClGU/dGNitwgseT/wo3uqU2EMuWnP6lpv+ta2hLNDYHdsJy5TcP
         0IUrwfJ/gdGActOnJY8XmuiCRNBz1Rxs40/FL0b3jbNDmGU5YwACxrI7i5cTv5vIwh7G
         XxAg==
X-Gm-Message-State: AOJu0Yzu5NSm0EWoAH3H1vCt1pftMiN71/Fy5yKK5n0sRn6aT5CRwPuh
        rFmkCjHU119isCka5rQmp3GgOheHUNU=
X-Google-Smtp-Source: AGHT+IH1R5plTtx2ZeV0MFIuVMXVY9nSXiBJzqZqz1zZ3Z5cwG1k3VJBllqOCZJskhsQ58R2CUG34w==
X-Received: by 2002:a05:6870:2308:b0:1d5:5660:3ae0 with SMTP id w8-20020a056870230800b001d556603ae0mr3486958oao.20.1695490322568;
        Sat, 23 Sep 2023 10:32:02 -0700 (PDT)
Received: from atom0118 ([2405:201:c009:52e1:3075:4405:fdad:b3f9])
        by smtp.gmail.com with ESMTPSA id e22-20020a656896000000b00565e96d9874sm4518382pgt.89.2023.09.23.10.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 10:32:01 -0700 (PDT)
Date:   Sat, 23 Sep 2023 23:01:57 +0530
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     stefani@seibold.net
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org, shuah@kernel.org
Subject: Re: [PATCH v1] samples: kfifo: Fixes a typo
Message-ID: <20230923173157.GB159038@atom0118>
References: <20230817173636.78757-1-atulpant.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817173636.78757-1-atulpant.linux@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 11:06:36PM +0530, Atul Kumar Pant wrote:
> Fixes a typo in a comment.
> 
> Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> ---
>  samples/kfifo/dma-example.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/samples/kfifo/dma-example.c b/samples/kfifo/dma-example.c
> index 0cf27483cb36..112b0e427199 100644
> --- a/samples/kfifo/dma-example.c
> +++ b/samples/kfifo/dma-example.c
> @@ -80,7 +80,7 @@ static int __init example_init(void)
>  			break;
>  	}
>  
> -	/* put here your code to setup and exectute the dma operation */
> +	/* put here your code to setup and execute the dma operation */
>  	/* ... */
>  
>  	/* example: zero bytes received */
> @@ -109,7 +109,7 @@ static int __init example_init(void)
>  			break;
>  	}
>  
> -	/* put here your code to setup and exectute the dma operation */
> +	/* put here your code to setup and execute the dma operation */
>  	/* ... */
>  
>  	/* example: 5 bytes transmitted */
> -- 
> 2.25.1
> 

	Hi all, can someone review this change ?
