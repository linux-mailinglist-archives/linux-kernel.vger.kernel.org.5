Return-Path: <linux-kernel+bounces-21547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA678290FE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB826B2508F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257683EA7D;
	Tue,  9 Jan 2024 23:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqRU+fXe"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2323E499;
	Tue,  9 Jan 2024 23:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6dddc655a60so1118314a34.2;
        Tue, 09 Jan 2024 15:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704843924; x=1705448724; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q5ZCfevwCuy2eIhN8UYPiiL0PwUWY0yuohYDJnAVWy8=;
        b=dqRU+fXePvc+PUn9xh0NHbeZXmym/YV4FM0D6hq8xJUoOTO4wZInUxa2+wd/gDuEDE
         qY8gz/qEQs5Nk0dAwpuwJsZAUUXnlc56e/TWvD/WeJOQ5PwtPVGn7WO+Gvq/LjGEvjnL
         zVkjAWc8QvHavLPxe4AWfweN98zkJyO/3Gkctylz4XcK6+xjnlnCnbdqEdYJ8DjfF08s
         oqxaQOxuNNIQe84TfyasYKk2moCYkFs4wDDSg6xOJvwogM4nqx8Q4kg0r8VCaxyljNZn
         CfVIJt+8rZqDMKUUUY39IOZMMlui3f2QoH6eFnNAeBYwxhb4fB5XlS4Utn2LXSQGahSL
         EZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704843924; x=1705448724;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5ZCfevwCuy2eIhN8UYPiiL0PwUWY0yuohYDJnAVWy8=;
        b=bnoXFK7NOyd4JvLmxRAdHpbC7gKDwT5sewimho49NVkxlPFmhjkqw7LANc8vwBDCjh
         l+NuTGxr49DsdtAcTdJCCcqxDZicWjNqzdLa90VU9RJve4A3EE9Dvq6Qwv/yomWUgSVt
         0yTGqE1nBYCRsPHZ8j7x3nkl1l/SfML6/KOVg7ehPtWLMhIwUDP1oM0UTjl0iHaAxAFy
         1oTvt+BkTe2UaQj0urbQMnpaX5TpMxuLW9RYt+kd4B5de9p70oKB154GDB/UnfY1HWqg
         riJLMznN95T6PHP+d21VWgBfIAaoXteWwuIG0ZDAa2hoqEEgI30WLJeFrvnh43Xs70oA
         gu+A==
X-Gm-Message-State: AOJu0YziwPQo0krLql/SV2EOGo5iRT1rkXAkvmrfwgtNnqlbtA9LsTRF
	2XVfOSfcSiwHrEwo3CJSevM=
X-Google-Smtp-Source: AGHT+IHbFJyEsmS3YSQ7oKQdu/bMRsyctydF1vgDZIAYqxikxDI1+T/YGdfqtJeH5aGhNrLxoSB2bA==
X-Received: by 2002:a05:6870:2385:b0:1fa:e2e4:d8d1 with SMTP id e5-20020a056870238500b001fae2e4d8d1mr303381oap.52.1704843924108;
        Tue, 09 Jan 2024 15:45:24 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id g8-20020a63e608000000b005cdb499acd0sm2204693pgh.42.2024.01.09.15.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 15:45:23 -0800 (PST)
Date: Wed, 10 Jan 2024 07:45:18 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
	andy@kernel.org, corbet@lwn.net
Subject: Re: [PATCH 0/7] Documentation: gpio: add character device userspace
 API documentation
Message-ID: <20240109234518.GA7839@rigel>
References: <20240109135952.77458-1-warthog618@gmail.com>
 <CAHp75Ve05bAK-ehZZ7XSci5VqR18cCb=hgnbFKXwy2QPkxo=pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Ve05bAK-ehZZ7XSci5VqR18cCb=hgnbFKXwy2QPkxo=pw@mail.gmail.com>

On Tue, Jan 09, 2024 at 10:00:26PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 9, 2024 at 4:00 PM Kent Gibson <warthog618@gmail.com> wrote:
> >
>
> Thanks a lot for doing this!
>

I hope it makes sense - I've been polishing it for a while to
the point that I might be missing the forest for the trees.

> ...
>
> >  Documentation/userspace-api/gpio/chardev.rst  | 114 ++++++++++++++++
> >  .../userspace-api/gpio/chardev_v1.rst         | 129 ++++++++++++++++++
>
> Shouldn't it be better to have chardev_v2.rst along with chardev.rst
> to be a link to it?
>

Didn't see any benefit to doing that.  As I see it, chardev.rst will
always be the latest.  If we do ever do a v3 then this doc will get the
renaming and link treatment then.

> ...
>
> May we actually state in the documentation that sysfs is subject to
> remove at some point?
>

So formally define what "deprecated" means?
Is that covered in the higher level documentation somewhere?
If so I'm more than happy to provide a reference.

Cheers,
Kent.

