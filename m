Return-Path: <linux-kernel+bounces-33-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D9D813B00
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A4EEB2192A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDEB69794;
	Thu, 14 Dec 2023 19:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZyaZRBa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC6E6A33A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 19:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dbcc9d4b1aeso2415027276.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 11:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702583435; x=1703188235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yb+o2JAZQlVNKG7fXJf8P7vZ33idkTo9Rp/GDP3MtpI=;
        b=ZZyaZRBapR8cW6h1pRuxUs+s6pDFfI4m6qSl31TpDXDO6O3CYlVOwXcOhkqPZy8PoU
         xXDUXFdrQjQSYeWL2TkmjswSqIY6VVLEW/QJZPBX4dSkLpYMGyFVSVoOFkWjacLkePIF
         vN+4PtblmYitI4CbkEBBOVt53Mlsy+kv+u/gpoMrnTSZRUgG/tsbmTGmHoJNF3aNkyOe
         zA+n8L0y7OPZhaviR5vxz8BkLTD5d9zpbFUXed3qDqNlbjHzgYAh1tLTbT/4XxCp2N+W
         5kdGSlC9Jcfy1Ks4v7mXaobLma45XibATJhPKKusO8SRu9QaWjFmiqi0C3b2UBGB4ca/
         +86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702583435; x=1703188235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yb+o2JAZQlVNKG7fXJf8P7vZ33idkTo9Rp/GDP3MtpI=;
        b=EpWa8XyB4PyBv32Iaal3XcFko4kNqFNqJMCva7w8Sbw85yzJJurIBaLbwrzYFsfbVR
         Qss/AoyU3IFwMeq5R9ZDak815oj7RRAEbAaNpUaSYsJg/b7Rz1Qnwtnk/61O7LRizGAH
         Kt7r6t/ZmRJHgj5duEsusl5bZs8To9ehgKK/j1T4e0ht6yd4SvcwRDj8H0gYFkMdMfcU
         eRj8SlAaz2DIynZ1pTqekNY9Ml+LTNYX2hD4kXYcmcFineZgHFh6MTTQxfyyrd6EQlCQ
         jvLy9SuPn6WAL11Z0LvzCLqXjMMdg1t2SDyli4NEK+x1kt8U6rpAQOCbA3DXshVW7/Lq
         29DQ==
X-Gm-Message-State: AOJu0Yz7LejfZaj4GCfJ6p4QhBcTKVhb4jO0ZUq55Y78dW3X2A2EgAEo
	5SZAGgU/CH90MoTNVUQEmhY=
X-Google-Smtp-Source: AGHT+IHQtv8Bkdyj/eVShuOeEE465+EQ06MZQSlOgYCjkFXf7raQcerrdORSwd1NUFAQcykJo0l6UA==
X-Received: by 2002:a25:9242:0:b0:dbc:eded:5a92 with SMTP id e2-20020a259242000000b00dbceded5a92mr807872ybo.99.1702583434645;
        Thu, 14 Dec 2023 11:50:34 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:e177:373d:4717:ff6c])
        by smtp.gmail.com with ESMTPSA id z6-20020a5b0a46000000b00d9cc606c78csm4898350ybq.41.2023.12.14.11.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 11:50:34 -0800 (PST)
Date: Thu, 14 Dec 2023 11:50:33 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Alexander Potapenko <glider@google.com>
Cc: catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
	andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
	aleksander.lobakin@intel.com, linux@rasmusvillemoes.dk,
	alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, eugenis@google.com,
	syednwaris@gmail.com, william.gray@linaro.org
Subject: Re: [PATCH v10-mte 2/7] lib/test_bitmap: add tests for
 bitmap_{read,write}()
Message-ID: <ZXtciaxTKFBiui/X@yury-ThinkPad>
References: <20231214110639.2294687-1-glider@google.com>
 <20231214110639.2294687-3-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214110639.2294687-3-glider@google.com>

On Thu, Dec 14, 2023 at 12:06:34PM +0100, Alexander Potapenko wrote:
> Add basic tests ensuring that values can be added at arbitrary positions
> of the bitmap, including those spanning into the adjacent unsigned
> longs.
> 
> Two new performance tests, test_bitmap_read_perf() and
> test_bitmap_write_perf(), can be used to assess future performance
> improvements of bitmap_read() and bitmap_write():
> 
> [    0.431119][    T1] test_bitmap: Time spent in test_bitmap_read_perf:	615253
> [    0.433197][    T1] test_bitmap: Time spent in test_bitmap_write_perf:	916313
> 
> (numbers from a Intel(R) Xeon(R) Gold 6154 CPU @ 3.00GHz machine running
> QEMU).
> 
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 
Acked-by: Yury Norov <yury.norov@gmail.com>

