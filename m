Return-Path: <linux-kernel+bounces-32-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1539D813AFF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8081F2165C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A58D6A35A;
	Thu, 14 Dec 2023 19:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1dtyCUd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832096DD08
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 19:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5c08c47c055so83067337b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 11:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702583333; x=1703188133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=etA6k5Cw7mdYtsEDYoQF51pReZIpMv//ZV8ayVcLvW8=;
        b=H1dtyCUd+0FARIYWel1v8TIwIadFDYkcarj5JCftPnsGUHa/Kmkzu4FFDnxVcJnH7Y
         eoenFIe6/Zd9WmCeWDvgHo9QSR3wX8aeVdvGMR8A42EFMRsWeFouIf930Pb8+iCzzDk+
         S4G8hPOdWqibZkgqFGlfng8ZKooKErwlN64KdXkrtnBY8WDlusGwqwdiMGwXdkgP5LfK
         JmPLaauTItcg4yK2OlAnqdZJxsWXLPCdCvv/k78eIJzBiRMUjesYVfwE7FbxE+BKd4tG
         LgbD1aYQRazUGgxncvxJqY7d01zoCU6ZPavmJq0zLUuWHVAhzfSMHXJnjZUcXGiu1okH
         6fTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702583333; x=1703188133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etA6k5Cw7mdYtsEDYoQF51pReZIpMv//ZV8ayVcLvW8=;
        b=O4rnNkD3ES3PCieTqnX2XXVht9DCsPU/4SDzhIK2p+KCFflr3ZvFWet7B231lqw7aX
         MsO04PJ0aw14zE0S7qY2tf5++9j4kXw12ldz98roHD315g8cBqt/pMeq2aztvPsEk2ez
         UWfx6x5d3IX+MpyAxIqnahNzr9YL9jw+jxqn6wAa3U248bzsUCuFBnw0xUQ/OVUhNzd6
         Q+YjA96p7yLPbXCx8TMuO38YbGjSPykGZx9GkKqOBAsNiXK5WXtHl7SKiThR72+n+qZQ
         WQ8gbps8VYpwltWbfE4usoVEwMp4hLlHgWXbLyopBD+joQtNj5oLbRJdnQHJgqq+wsf3
         me8Q==
X-Gm-Message-State: AOJu0Yy0G1hDxpWowjER6NHjSoe90QF/zD5FUZIYqfA+JLIAofj24y/h
	pcO+pEehzXazGlk6NcNb7iI=
X-Google-Smtp-Source: AGHT+IHVLAhACMbrlwpppVWXwJ6uwwTzJ+evBj75hBh8yuPb56O4N964Nsu2KP/fttA7+wSTqzi6Tw==
X-Received: by 2002:a81:54c1:0:b0:5d7:1940:53bd with SMTP id i184-20020a8154c1000000b005d7194053bdmr8905236ywb.53.1702583331856;
        Thu, 14 Dec 2023 11:48:51 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:e177:373d:4717:ff6c])
        by smtp.gmail.com with ESMTPSA id c2-20020a81df02000000b005ca99793930sm5609088ywn.20.2023.12.14.11.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 11:48:51 -0800 (PST)
Date: Thu, 14 Dec 2023 11:48:50 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Alexander Potapenko <glider@google.com>
Cc: catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
	andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
	aleksander.lobakin@intel.com, linux@rasmusvillemoes.dk,
	alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, eugenis@google.com,
	syednwaris@gmail.com, william.gray@linaro.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v10-mte 1/7] lib/bitmap: add bitmap_{read,write}()
Message-ID: <ZXtcIqFhh1WMOGbG@yury-ThinkPad>
References: <20231214110639.2294687-1-glider@google.com>
 <20231214110639.2294687-2-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214110639.2294687-2-glider@google.com>

On Thu, Dec 14, 2023 at 12:06:33PM +0100, Alexander Potapenko wrote:
> From: Syed Nayyar Waris <syednwaris@gmail.com>
> 
> The two new functions allow reading/writing values of length up to
> BITS_PER_LONG bits at arbitrary position in the bitmap.
> 
> The code was taken from "bitops: Introduce the for_each_set_clump macro"
> by Syed Nayyar Waris with a number of changes and simplifications:
>  - instead of using roundup(), which adds an unnecessary dependency
>    on <linux/math.h>, we calculate space as BITS_PER_LONG-offset;
>  - indentation is reduced by not using else-clauses (suggested by
>    checkpatch for bitmap_get_value());
>  - bitmap_get_value()/bitmap_set_value() are renamed to bitmap_read()
>    and bitmap_write();
>  - some redundant computations are omitted.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
> Link: https://lore.kernel.org/lkml/fe12eedf3666f4af5138de0e70b67a07c7f40338.1592224129.git.syednwaris@gmail.com/
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Co-developed-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Yury Norov <yury.norov@gmail.com>

