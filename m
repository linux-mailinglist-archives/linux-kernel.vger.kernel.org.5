Return-Path: <linux-kernel+bounces-18481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90994825E3B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 05:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB511C21A54
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 04:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EA41FDF;
	Sat,  6 Jan 2024 04:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhosMP+S"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97AD1842;
	Sat,  6 Jan 2024 04:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dbed9659496so12181276.0;
        Fri, 05 Jan 2024 20:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704516954; x=1705121754; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h1x2gNIr/WIAbQ1ZNzOSYJRRU8w0tdP5X24inX9f+L0=;
        b=XhosMP+Sqch7YX3avKC95YfiTXdXMDaqfjAJ1IwT3QQYQvwhRzb8Oislb8fh2l4rPI
         08xwtK8zhZhPN7bnzTh8YDu/oTtfxOJGGuQaDg74x8mDrRb2XVjhh4hOPxRyF4/jFF1O
         diWQE7riRjXubVrYKGKHGlMNf1ooLCGPTSOoFXzYhhbTrBC0hSexLRY0f8E3v1fni3/V
         IC6NOxnCm7Ax/FK30I34QilXva93pjxouUMV5xVdjW6TM9T2Y7j6CFM013pdQY8O2aCD
         1MWIHzIZUDC6JGDs57GVHz9MDdvkvgaqmGc/VPzzj9LfIJgM5Gqzecaax205dx6jxMWB
         Impg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704516954; x=1705121754;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1x2gNIr/WIAbQ1ZNzOSYJRRU8w0tdP5X24inX9f+L0=;
        b=LttynxTbsJcvNvqYjvPQawiurGV/w+GpBHpyn7r24jHDuiyGYtpVAQsaIdL1rO26Jd
         dYqigEzpZ/fLdpKHMVFXOG0RG/GFVvqc2mc5WI8Bs82bsUCmlltiJoFwaL3G3nLPBVjT
         gn9zN6p86ihDcYTwMRISwpYP3iWF1hPmWUIAA5XicYGR8enCn/LfZVOPUXBe1Bvg71XJ
         yg4fUMG4fehvvHAUfusJon18Bi2euI+jAwvaeIAtBV7TXlHE1GuV1qWibq+P14d/KSKH
         8acgubDWqsGyEjfoky98GnIqOuh2ct0Ws5fEwaxAR3LFLwqhbaCUkNS3PjCGtr6F+wBu
         N+OQ==
X-Gm-Message-State: AOJu0YwC3Iuf3AAs4/BnUu/bZYNB3xJQYyiSm2xyw3FKkKd7LoOua0fw
	5jTxMPRCx2YVJ25en5c/RyQ=
X-Google-Smtp-Source: AGHT+IHYXdXHoXXZq/8QrYbujSvvi8QBDHVvlGCiIZr6j5Iy8ItXwxDyfYqpa4yg5R+6xg2DXArkbQ==
X-Received: by 2002:a0d:e906:0:b0:5f0:d188:8588 with SMTP id s6-20020a0de906000000b005f0d1888588mr438273ywe.3.1704516954633;
        Fri, 05 Jan 2024 20:55:54 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id z8-20020a81f808000000b005d746ac7f6bsm694386ywm.69.2024.01.05.20.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 20:55:54 -0800 (PST)
Date: Fri, 5 Jan 2024 20:55:46 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Mahesh Bandewar =?utf-8?B?KOCkruCkueClh+CktiDgpKzgpILgpKHgpYfgpLXgpL4=?=
	=?utf-8?B?4KSwKQ==?= <maheshb@google.com>
Cc: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>,
	Don Hatchett <hatch@google.com>, Yuliang Li <yuliangli@google.com>,
	Mahesh Bandewar <mahesh@bandewar.net>,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCHv3 net-next 2/3] ptp: add ioctl interface for
 ptp_gettimex64any()
Message-ID: <ZZjdUlaYyHZSiwSM@hoboy.vegasvil.org>
References: <20240104212439.3276458-1-maheshb@google.com>
 <ZZczNlXzM8lrZgH5@hoboy.vegasvil.org>
 <CAF2d9jga9oc4OST6PMU=C9rz_NDrURCcLGx-1tP31U00z63vbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF2d9jga9oc4OST6PMU=C9rz_NDrURCcLGx-1tP31U00z63vbA@mail.gmail.com>

On Fri, Jan 05, 2024 at 09:51:40AM -0800, Mahesh Bandewar (महेश बंडेवार) wrote:

> POSIX clocks are employed in this series for syscall width
> measurement, potentially leading to misunderstandings about
> overlapping functionality. However, their roles are distinct and serve
> different purposes.

I don't see any difference in purposes.  The multi_clock_gettime call
is a more general solution.  Thus it will obviate the need for any new
PTP ioctls.

Thanks,
Richard

