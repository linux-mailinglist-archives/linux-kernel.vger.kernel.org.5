Return-Path: <linux-kernel+bounces-1548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FC1814FF4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49ED51C223B3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C303012D;
	Fri, 15 Dec 2023 19:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NibKwKnP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670503EA92
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 19:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5e3b9c14e46so8818437b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 11:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702667153; x=1703271953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vVnFmJCCfR01LuehN8Co2lUqd4r5c+j4EtSCAiB9EBs=;
        b=NibKwKnPH2SGw/HKkXSmnbmX2T8wUSDRgeQkzsLSmSUUclaWmOpFJC8cmeTubkjXXX
         fQLnftudWApH7Juz/BJrKjT7gAOvByDg4Pp/BNJYAb8lljuEb5TjjvKBPsNWf9EzDlLF
         lViOvN4zILb4B7Ylox8Jn015cFXvCBVhYnNv9gVZeVIz1A+5236+RlzadhUfifyKPWis
         zuOClUj4ZuF2pZhgPNQdJDQBpXE1OxzZHzIUFHX6dnSovIIacKolVK3L/+n0RlDUY6Cm
         Lo3IZgbhDL1jJDnyCt+wX9aqXHu4yDqy/hy7S85TnIo5FdENr/k00vNgS34C92N/QV2L
         OeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702667153; x=1703271953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVnFmJCCfR01LuehN8Co2lUqd4r5c+j4EtSCAiB9EBs=;
        b=Axc0mRPMSTE3uuKysHTb7jScmaEituetY+FrL7DZQvhOwFzfbXwuYaY9163aonkBku
         VdeFfxDWaoPovBoOtmLZCE9XDTfXCxTJLghx3wjFCgjZqK+HzjLd5fUL6s+Bsf1OKlb7
         L3123kOP8W0SZtfNILn0ECTqeCmMO1VDebIPN1laUNmeGeIGnu4iTLi//9wQbQiKHLJR
         WBTgVnbjHVNfXG6z/f1CFxgjpRrrw6HtVYXZcuVmhOugx4YdyxJKc8/AXilNH/PPlqIi
         ou9w4kaz4K1OIe9F53BOeS5Y9YUNrQ/ASMRQrZy8mXFHYN/CYELJdtBzPxgyWsdJooAT
         N0UA==
X-Gm-Message-State: AOJu0YwqF2xqD3Y9J4SoZkz+QoAJZfWGMeZOPYTcfxISKqz2dKm0wsvT
	KYidy8uLO2uFWUi1Ge7D/LeuI82WbPI=
X-Google-Smtp-Source: AGHT+IFgT+FKQk/P+pqJo3/xjAUYmQTLrHH89Av00/vpemeDRbZ66bXPyOr4yVGO7EMb4U2cGPujaQ==
X-Received: by 2002:a81:4807:0:b0:5e4:ac12:fc16 with SMTP id v7-20020a814807000000b005e4ac12fc16mr876480ywa.71.1702667153288;
        Fri, 15 Dec 2023 11:05:53 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:ffe6:85e9:752c:601b])
        by smtp.gmail.com with ESMTPSA id w135-20020a81498d000000b005e2f116e2f5sm109709ywa.32.2023.12.15.11.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 11:05:52 -0800 (PST)
Date: Fri, 15 Dec 2023 11:05:51 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 2/2] bitmap-str: Add missing header(s)
Message-ID: <ZXyjjzjFUzscO8ay@yury-ThinkPad>
References: <20231215184218.2005611-1-andriy.shevchenko@linux.intel.com>
 <20231215184218.2005611-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215184218.2005611-3-andriy.shevchenko@linux.intel.com>

On Fri, Dec 15, 2023 at 08:41:09PM +0200, Andy Shevchenko wrote:
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/bitmap-str.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/bitmap-str.h b/include/linux/bitmap-str.h
> index d758b4809a3a..53d3e1b32d3d 100644
> --- a/include/linux/bitmap-str.h
> +++ b/include/linux/bitmap-str.h
> @@ -2,6 +2,8 @@
>  #ifndef __LINUX_BITMAP_STR_H
>  #define __LINUX_BITMAP_STR_H
>  
> +#include <linux/types.h>

There's no sense in including this header without bitmap.h, and the
latter includes linux/types.h, so no need to include it here again.

If you want to make it more rigorous, you can do like this:

        #ifndef __LINUX_BITMAP_H
        #error "Don't include separately from linux/bitmap.h"
        #endif

>  int bitmap_parse_user(const char __user *ubuf, unsigned int ulen, unsigned long *dst, int nbits);
>  int bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp, int nmaskbits);
>  int bitmap_print_bitmask_to_buf(char *buf, const unsigned long *maskp, int nmaskbits,
> -- 
> 2.43.0.rc1.1.gbec44491f096

