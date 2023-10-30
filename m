Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10517DB9ED
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbjJ3M3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjJ3M3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:29:08 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41ACC9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 05:29:05 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c50ec238aeso61257811fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 05:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698668943; x=1699273743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7UKpbwqL+ANoEjbCv4Z4RqT2pwQ+PiCS3uUt13ox2/Y=;
        b=zFmPXfShBtrQOexUcZ3zhfkfyYpWPDSWLlTRiVIk4S5ybDjO1dvbcW20u4XFA2QssU
         POdz/fZf3Q8NwcGsBMUt7YPRUotCAcvHVRreHFClqza+d0RE/hlBze0bNoQUHFy/VMY0
         YS8V5iFK+IJJj6vtMq9rKAuTOk40zlwY5ujzsfF6B/dYZNCZLlnxDJSQvlBWZRNgfdk5
         C/+gaSNz2E8qHK0GGzWlMF9PukIbBiC8l64kR3yzWV+H7nOOVhgfyVI9szzYaGij0eU1
         7AdPtFzVbq1Nl/FZ0p46jIS5leHbTlzBlmAscToUKbRWAng+36milMqYrqSmiSIHa6qw
         8+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698668943; x=1699273743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UKpbwqL+ANoEjbCv4Z4RqT2pwQ+PiCS3uUt13ox2/Y=;
        b=YH5zNtHl3rA/75HZZdtGtDC+fbu3FfgXwkWbBZDOzDv6x2Aaql8EkkIlhCRLZxU23P
         OO4wOvtbVvXbHPXbI0HyEfbi+zO+aTclaM+/UK/Wia5tsXQdf5Aja/xn5bWTFcd4CHxk
         YQ77cF6A1/l4dSmV1wA1kx2C8FCj4SpqqTzVpGP5s7rINhXbbgbXcZLWy3mCHIvySCjk
         V1YQGq6d8FWbQMC7tXL92LzZzSpsy7+ykeuCKzccOiHAUNs1HNRYjRdgR1/WL9IUjREO
         qQjqvZjdDDwjWqldvrKdW298x8nZN1pp7zGddxPsdhrvWaId6n32o3kGCKhZIFTNeQF0
         qhNw==
X-Gm-Message-State: AOJu0YxFU7x82sZS9DHVp4p8sqwxR0/Sj9XU3FPF5KpIWUgp/NRaoc9R
        0zGllrreDpCGC6ZwOQQ1yALkTg==
X-Google-Smtp-Source: AGHT+IF33MHrB2gXQa3cyGUqHxSS7zkJJvW+X68u76LoqvgseSpCsTceucKyGh6krUBFt7XCUh8FGA==
X-Received: by 2002:a2e:9dd9:0:b0:2c5:2475:f848 with SMTP id x25-20020a2e9dd9000000b002c52475f848mr7781734ljj.15.1698668943524;
        Mon, 30 Oct 2023 05:29:03 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s13-20020a05600c45cd00b004083bc9ac90sm9184188wmo.24.2023.10.30.05.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 05:29:02 -0700 (PDT)
Date:   Mon, 30 Oct 2023 15:29:00 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Nancy Nyambura <nicymimz@gmail.com>
Cc:     nicydaniels@gmail.com, outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Staging: rts5208: Replace strncpy() with strscpy()
Message-ID: <9e125b7a-673a-4c69-8216-f8c519e5ae1c@kadam.mountain>
References: <20231030115939.48985-1-nicymimz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030115939.48985-1-nicymimz@gmail.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 02:59:34PM +0300, Nancy Nyambura wrote:
> warning found by checkpatch.pl script.I replaced the usage of strncpy()
> with strscpy() in the code(line 524) for the buf buffer to improve
> string copying.This is appropriate since strscpy() is used when you want
> to copy a NUL-terminated string and the destination buffer requires
> trailing NUL-padding.
> 
> Signed-off-by: Nancy Nyambura <nicymimz@gmail.com>
> ---
> Changes in v2:
>   - Make the commit message more clearer.

Hi Nancy,

Your commit message does not explain why you used strscpy() instead of
strscpy_pad().  I have written a blog that might be helpful.

https://staticthinking.wordpress.com/2023/10/30/strcpy-strncpy-strlcpy-and-strscpy/

regards,
dan carpenter

