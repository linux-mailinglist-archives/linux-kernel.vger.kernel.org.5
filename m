Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC51276FBCF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjHDISV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbjHDISR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:18:17 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CBA4697
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:18:06 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-686f19b6dd2so1361693b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691137086; x=1691741886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gg5cVCUNV3XHGOdEED3Q5WLBVqpxV2U0ovPUur9voag=;
        b=F4u5Br/6x69AAvjAgMCxCTVIJ5ywKIpqh2D36RfYxFp2q7yHZ27dzUJAmOqKW9pJqH
         h77oI985AoKugoObOdc3Mc/zCJp8iWso0lLemKvy9Xmn/8pVTaoSBFtTAJ59BV5ZBr+5
         c8P+FQ2fMtbyDkgiyzeqgrZDCOyvhFNWzy4zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691137086; x=1691741886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gg5cVCUNV3XHGOdEED3Q5WLBVqpxV2U0ovPUur9voag=;
        b=TN0cBBd1ihF5RKtQv/fEvq+GeR59bFr9qrPcfnqtV45NgA8co13qwvpPQEnkjm+qW7
         clkPqlNpkGzhEHzVFYPdypZGhNSi3cxq3cyGvBtlEs0EZeEO0MFev4HA8r7u+BWvBT7P
         fRovmBeAEUnWPFpJaux0XeU5ecAFrGpacXtkiSf3YKfOIbfqyro6NSe3LUUtIW0GSiW9
         9nU0NHSAJ2oZg0kBySPCnMFqU0sN4iFN+0ugM0gM6vxeyA1RsRZ8gXUg/MFF84bSxtpl
         CWOKpQjFcFlEzUBKOrSxqn4le2V7/EzCAAWglgPBTxmHGrI81cp8v5otiG3HxBDOx7Mz
         z4LQ==
X-Gm-Message-State: AOJu0YzdqxXRXz/fgH8BPCLajMgs3F2firh7Qdv6H6PBhPOqVk2zV3YX
        LvJ4Dvsrx9ozCh7Q4Mgs8GUNwQ==
X-Google-Smtp-Source: AGHT+IF0p+Ad31RQ2e8xZC4taMCW7aZqthbtutqmacSexOFcs3y+7j334dkNht2sO4v7wQdkEBZOuQ==
X-Received: by 2002:a05:6a20:2452:b0:13e:82ad:ff0a with SMTP id t18-20020a056a20245200b0013e82adff0amr1046163pzc.23.1691137086366;
        Fri, 04 Aug 2023 01:18:06 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ff12-20020a056a002f4c00b0067f2f7eccdcsm1043514pfb.193.2023.08.04.01.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:18:05 -0700 (PDT)
Date:   Fri, 4 Aug 2023 01:18:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Johan Hovold <johan@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] lib/ucs2_string: Add UCS-2 strscpy function
Message-ID: <202308040115.A4643B8@keescook>
References: <20230730161906.606163-1-luzmaximilian@gmail.com>
 <20230730161906.606163-2-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230730161906.606163-2-luzmaximilian@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2023 at 06:19:02PM +0200, Maximilian Luz wrote:
> Add a ucs2_strscpy() function for UCS-2 strings. The behavior is
> equivalent to the standard strscpy() function, just for 16-bit character
> UCS-2 strings.
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> ---
> 
> Changes in v5:
>  - Add ucs2_strscpy() instead of ucs2_strlcpy()
> 
> Patch introduced in v4.
> 
> ---
>  include/linux/ucs2_string.h |  1 +
>  lib/ucs2_string.c           | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/include/linux/ucs2_string.h b/include/linux/ucs2_string.h
> index cf3ada3e820e..c499ae809c7d 100644
> --- a/include/linux/ucs2_string.h
> +++ b/include/linux/ucs2_string.h
> @@ -10,6 +10,7 @@ typedef u16 ucs2_char_t;
>  unsigned long ucs2_strnlen(const ucs2_char_t *s, size_t maxlength);
>  unsigned long ucs2_strlen(const ucs2_char_t *s);
>  unsigned long ucs2_strsize(const ucs2_char_t *data, unsigned long maxlength);
> +ssize_t ucs2_strscpy(ucs2_char_t *dst, const ucs2_char_t *src, size_t count);
>  int ucs2_strncmp(const ucs2_char_t *a, const ucs2_char_t *b, size_t len);
>  
>  unsigned long ucs2_utf8size(const ucs2_char_t *src);
> diff --git a/lib/ucs2_string.c b/lib/ucs2_string.c
> index 0a559a42359b..b608129fcbdc 100644
> --- a/lib/ucs2_string.c
> +++ b/lib/ucs2_string.c
> @@ -32,6 +32,41 @@ ucs2_strsize(const ucs2_char_t *data, unsigned long maxlength)
>  }
>  EXPORT_SYMBOL(ucs2_strsize);
>  
> +ssize_t ucs2_strscpy(ucs2_char_t *dst, const ucs2_char_t *src, size_t count)
> +{
> +	long res;
> +
> +	/*
> +	 * Ensure that we have a valid amount of space. We need to store at
> +	 * least one NUL-character.
> +	 */
> +	if (count == 0 || WARN_ON_ONCE(count > INT_MAX))

Is "count" a measure of bytes or characters? It seems to be characters.
can you please add some kern-doc for this function to clarify this.
Also, I wonder if the above check should be "count > INT_MAX / 2" since
the INT_MAX is, generally, done in byte counts.

> +		return -E2BIG;
> +
> +	/*
> +	 * Copy at most 'count' bytes, return early if we find a

If "count" is characters, this comment should not say "bytes". :)

> +	 * NUL-terminator.
> +	 */
> +	for (res = 0; res < count; res++) {
> +		ucs2_char_t c;
> +
> +		c = src[res];
> +		dst[res] = c;
> +
> +		if (!c)
> +			return res;
> +	}
> +
> +	/*
> +	 * The loop above terminated without finding a NUL-terminator,
> +	 * exceeding the 'count': Enforce proper NUL-termination and return
> +	 * error.
> +	 */
> +	dst[count - 1] = 0;
> +	return -E2BIG;
> +}
> +EXPORT_SYMBOL(ucs2_strscpy);
> +
>  int
>  ucs2_strncmp(const ucs2_char_t *a, const ucs2_char_t *b, size_t len)
>  {
> -- 
> 2.41.0
> 

Otherwise looks good to me!

-- 
Kees Cook
