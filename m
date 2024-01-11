Return-Path: <linux-kernel+bounces-23458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA6D82AD11
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDCF4B217D4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4852814A9E;
	Thu, 11 Jan 2024 11:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Op2JJO3W"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A9E14F8A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 11:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a27cd5850d6so557175866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704971552; x=1705576352; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j29OWMY+YhlAhxuY2wSmEUDqrXvXRySnRlcR4UOyYDs=;
        b=Op2JJO3W2PqjIFR4T57K8qxVHB+CrH4pPTmqkpDsMjxr1y+O7ktyp0XLn2D0Py/idi
         FS9HTdedHNiwk4fz9+bnI7Wc/DWK58f72u3segBIMV4H3dwF6OL4uvDCJWSvg97Ham/G
         oiqtcXzX9tZnIe9R+qlpHMpbtPTBHY1RZ6M9M8ePoLkgmPKOgq093G+Y/jjFcc//9FOv
         EV6jt28qERF32xFToJWBd7/cyih/Tdmgmdyd/jAaTJo9ATBf6Ko++kk4d+XE+oOOs6X0
         BN+ZLUPGG5+TX9UUXPMrPUdIaSICrELsl5DaKC9MqtaQwx4m+q428nPJWr6TeZzVlEia
         Rayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704971552; x=1705576352;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j29OWMY+YhlAhxuY2wSmEUDqrXvXRySnRlcR4UOyYDs=;
        b=NnftlFO1kJ+hUHfSgDOWU1gy4zbyqW1/RwvYLWBrVk2EKiGJZbW5PTiNTkwAlzADwv
         NML0fFn+044Qy4fWhHsm1vZ8h+RDnXTTgGS3iABOGEB7bbEOw4dxvBWPr6YKSSsB7gnH
         MJGcHrfnQ25+H9BWnuHh/5unVZRUglEJhXaB0hqloRbpT4FUL8FAdP2tdfzfbiFzWbwp
         EGgJIwzoXCG4cDGZc++S6qzOyi2EhtfAa3lAOPOME/aZYltVP3cYb4EXLREBUZRcTTjV
         Dwca2ZR5vFohTgB9Uv67u+oxdgdwuk6Hzc5awLoYNBJh9PAwWrRkLH7jAk5fs0NIQ3DS
         jvZg==
X-Gm-Message-State: AOJu0Yzpfc+8rU+2NBBz13NHttl68s0LkllccU1R87NN2zprUtQ17CA1
	V/MAaNAVCrgWXPSgpVq6ZA==
X-Google-Smtp-Source: AGHT+IGY6pvJzNC9IfqB8JzaqWEkmArbIRgldCVN55kJkASg2hLv2TIU1j+J2Sgavbv3ASVk8nPSEw==
X-Received: by 2002:a17:906:af13:b0:a29:a2d6:4e6d with SMTP id lx19-20020a170906af1300b00a29a2d64e6dmr423020ejb.79.1704971552107;
        Thu, 11 Jan 2024 03:12:32 -0800 (PST)
Received: from p183 ([46.53.248.125])
        by smtp.gmail.com with ESMTPSA id ca23-20020a170906a3d700b00a2bd01c2349sm442783ejb.169.2024.01.11.03.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 03:12:31 -0800 (PST)
Date: Thu, 11 Jan 2024 14:12:29 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Neal Gompa <neal@gompa.dev>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Jason Gunthorpe <jgg@nvidia.com>,
	jirislaby@kernel.org, dhowells@redhat.com,
	linux-kernel@vger.kernel.org, pinskia@gmail.com,
	kent.overstreet@linux.dev
Subject: Re: [PATCH 00/45] C++: Convert the kernel to C++
Message-ID: <80cc3496-0a30-4905-9d94-c492abb78c0d@p183>
References: <fa64c852-01c4-4e4c-8b89-14db5e0088d0@p183>
 <CAEg-Je9ahyp+asVHCcMr7KXYqDRzxJnQmqYcz1V+LH3ZEfT+Ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEg-Je9ahyp+asVHCcMr7KXYqDRzxJnQmqYcz1V+LH3ZEfT+Ww@mail.gmail.com>

On Thu, Jan 11, 2024 at 05:58:51AM -0500, Neal Gompa wrote:
> On Thu, Jan 11, 2024 at 5:56 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > > SFINAE giving inscrutable errors is why I'm saying C++20,
> > > since "concept" means you can get usable error messages.
> >
> > I'd say concepts are irrelevant for the kernel where standard library is
> > tightly controlled by the same people who write rest of the kernel and
> > no external users.
> >
> > static_assert() is all you need.
> 
> We have external users all the time, though. People who write external
> modules or new modules would fall in that classification. Why should
> it be harder for them?

static_assert gives filename:line which clearly points to the source of
an error.

Concepts are SFINAE replacement but if there is little SFINAE there will
be little concepts too.

Another quite silly thing with concepts (and with noexcept propagation)
is that programmer has to write an implementation then chop control flow
and put everything else into the requires. And then to keep both in sync.

This is an example from cppreference:

	template<typename T>
		requires Addable<T>
	T
	add(T a, T b)
	{
		return a + b;
	}

Guess what Addable<> is?

They are kind of nice for simple things:

	template<typename It>
	concept MinimalIterator = requires(It it) { ++it; *it; it++; };

