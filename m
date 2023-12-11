Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EAE80C361
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 09:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjLKIhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 03:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjLKIhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 03:37:10 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5619F8E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 00:37:16 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-548ce39b101so5878967a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 00:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702283834; x=1702888634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kk+v7bJA+s+/z+dyrix6s2ZzCkywqqH7xeqGtoowJ4M=;
        b=V1lbUJGVG/Y4K88ZC/JFiqrPjSsacoP3+6XYAxf37R53fxDWQKqBN9Q3L+VCbpOs4Q
         5zgWMFhO16X6s4o53NS/dDv5Bvzg2dLpllg99l6FBwu77rEGufSHCxeMJ7qtlBjQW4af
         jykLZCUqVW8BeNIt0R03kNwF+4xwSjl4bddhPR2l+ysjOdWJo1GPOAZU2Yhl+wY+Tqac
         3Hg5JJX5H0DxUBYmnyPYSI415otithPZ1ktvLeWSxai2j9Unh6vLENCVOD7XU6WSY12N
         4UPG27qpSA2N8REYLmsC9viECOFGVoknzhKO1Pt6hl6Wk1aTtuWClH7TX0hYvuXjRJP4
         Y/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702283834; x=1702888634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kk+v7bJA+s+/z+dyrix6s2ZzCkywqqH7xeqGtoowJ4M=;
        b=T+Jd5uRn4KMLINowLl8OV1rAvW59orxGEloHwtNtraAFwVs9oVskVM4kXeTBgRGZ1j
         aK+Znm0B9qIiY1z0jlZtN7qzBwXyhynv7CqR9OuOAtIBjANnXi3HoljHBGtynypcOlXG
         D0SWcRm9ze/OGg+IKRz9vnYKUC4Tyox3L/0oEjCjVoP8hVwGNRjvtScwQzG+sPhi76L0
         kRsiwu58u+ab6UNFn2u9YFfK/dNkdYZJ0CpUMo3gWcqg1xDAHVwrJROYDT4g+qaTy1fG
         RBcHTaagf3jfU9QmAzjeiuuc/QgeZz+usprTuDu6/hiiTNhycgqNTNIuzB4WqL4yQTFA
         gBUQ==
X-Gm-Message-State: AOJu0YyIEL5JxYSWEoMOnbzTTTk+ukAVIskk5rFkt28KEin6+JTCquen
        N21yOogJUxkINs9vmR5Q+STN+Q==
X-Google-Smtp-Source: AGHT+IEG5JSQm2KSmEMgLYIgzL0giz5RVNFyFtSLxep3//eMRo4F2TpSWWxGmz03vJPdf0dsfXEe5Q==
X-Received: by 2002:a17:907:94d4:b0:a1a:8399:e12d with SMTP id dn20-20020a17090794d400b00a1a8399e12dmr1373966ejc.64.1702283834471;
        Mon, 11 Dec 2023 00:37:14 -0800 (PST)
Received: from localhost (hf89.n1.ips.mtn.co.ug. [41.210.143.137])
        by smtp.gmail.com with ESMTPSA id tx17-20020a1709078e9100b00a1b75e0e061sm4496930ejc.130.2023.12.11.00.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 00:37:13 -0800 (PST)
Date:   Mon, 11 Dec 2023 11:37:07 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Tree Davies <tdavies@darkphysics.net>
Cc:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] Staging: rtl8192e: Remove variable bFirstSeg
Message-ID: <2cdb678d-b784-411e-8913-eb7666e08ccc@suswa.mountain>
References: <20231210193705.2131807-1-tdavies@darkphysics.net>
 <20231210193705.2131807-2-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231210193705.2131807-2-tdavies@darkphysics.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2023 at 11:37:02AM -0800, Tree Davies wrote:
> Remove variable bFirstSeg as it is defined but never used.
> 
> Signed-off-by: Tree Davies <tdavies@darkphysics.net>
> ---
>  drivers/staging/rtl8192e/rtllib.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
> index 0a8c44e497f5..c0a24826cd3b 100644
> --- a/drivers/staging/rtl8192e/rtllib.h
> +++ b/drivers/staging/rtl8192e/rtllib.h
> @@ -103,7 +103,6 @@ struct cb_desc {
>  	/* Tx Desc Related flags (8-9) */
>  	u8 bLastIniPkt:1;
>  	u8 bCmdOrInit:1;
> -	u8 bFirstSeg:1;
>  	u8 bLastSeg:1;
>  	u8 bEncrypt:1;
>  	u8 tx_dis_rate_fallback:1;

I don't think you can remove these.  They're part of the protocol for
talking to the firmware.

regards,
dan carpenter

