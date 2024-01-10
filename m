Return-Path: <linux-kernel+bounces-22377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 347DC829CDC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C968F1F212F5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5244BA88;
	Wed, 10 Jan 2024 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5xm1IAJ"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45E74B5D4;
	Wed, 10 Jan 2024 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d3f29fea66so22430455ad.3;
        Wed, 10 Jan 2024 06:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704898439; x=1705503239; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e/9dWRauMZBuRi++SgjhZBHsyG8goACmdz9DRp9Jp50=;
        b=k5xm1IAJcul95SdTkUFxGj3XS5valBHBPeC7GHKMbkGvRrBzDOTNwSd+mPWU48u6Jg
         NM6O3KRvpONyIyhTL29vWtUy6q8FbiyALOZ3QR3DuOH1OsLchGW4oeZfOCFNFE+MPNgS
         rlDqzs5xq5RlBMMSCjEeFECcAFRxUYAw+ac2O+YD7iYH0oTVFtoTwV47kkEvU/zOHPhH
         mUKWhhm0haH/9Df9HWyU1yHNKmoKudjzsBd4YDg5Debce6fI1iV9DeHgWwIpNGbyFs1N
         y7dTyyNJKcHKH00Yy7HP/tscBFHrykPxjOHlMP1JMQ8xeKtcOHzuhE7A0unYnVQzMH5S
         INFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704898439; x=1705503239;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e/9dWRauMZBuRi++SgjhZBHsyG8goACmdz9DRp9Jp50=;
        b=JQmS5hy76Bdz6+m+sdD4n4drk+bESUds/RlKPQbI2gSK6Sxdw26X5odPJRc8sYhxmz
         dpsCf/RtjsxoZ9hThnwWZyMN7bRIm8BJEEVAmeugB41nYeB79+h7dmfNES4+cpiraFYx
         nMrhL9tZOuzL2PjGQr4Pb6e+yzFiA38Yrci4gjM4ipIiLvrXoxR17+/Wld6CZGAXW2CZ
         cR/GnSyYVelH2OKnBzFF77PCIXR0Bx2VnfaXRZFTktrKnWx5wqqFxs0PgXBCGgvfX9AF
         M+w/XfdYab3sxoXmuQiA3KLQA4+6mp8PNv6+OG7jn7jpby/Ysm/2D3OwI8qhr9cBSMcF
         Vu8A==
X-Gm-Message-State: AOJu0YzMcjwXEIhBuLcYVGe6cLz5fotJR1mtLOoNx5BSCyypgLPcJJXf
	G3YkGLJDUItiwrLKhqWRY9U=
X-Google-Smtp-Source: AGHT+IE62QSxu0gPOzSCKUgd4ixfUjlGU9EIxV7fH9guI5EwsKtwcnf+WkzxBeYHD77WT5h5AH7UIQ==
X-Received: by 2002:a17:903:32cb:b0:1d4:9dc4:dd6d with SMTP id i11-20020a17090332cb00b001d49dc4dd6dmr1010646plr.85.1704898438917;
        Wed, 10 Jan 2024 06:53:58 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id i13-20020a170902eb4d00b001b7f40a8959sm3753012pli.76.2024.01.10.06.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 06:53:58 -0800 (PST)
Date: Wed, 10 Jan 2024 22:53:53 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Phil Howard <phil@gadgetoid.com>, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
	brgl@bgdev.pl, andy@kernel.org, corbet@lwn.net
Subject: Re: [PATCH 1/7] Documentation: gpio: add chardev userspace API
 documentation
Message-ID: <20240110145353.GA49291@rigel>
References: <20240109135952.77458-1-warthog618@gmail.com>
 <20240109135952.77458-2-warthog618@gmail.com>
 <CA+kSVo_347gS+w_7ZXFDi9qDtT1aw15qoWRJZAVSkfbHShz7kQ@mail.gmail.com>
 <20240110130158.GA28045@rigel>
 <CACRpkdY9yXknHVQMq09Ep_y_Hk6iOkNqDS8icAKFW+fLDdwi-Q@mail.gmail.com>
 <20240110143428.GA47193@rigel>
 <CACRpkdYSnQ9=RU+TXfzTzwRXorPOBaD8Z3YR5H=jYTFK_6PKJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYSnQ9=RU+TXfzTzwRXorPOBaD8Z3YR5H=jYTFK_6PKJw@mail.gmail.com>

On Wed, Jan 10, 2024 at 03:50:36PM +0100, Linus Walleij wrote:
> On Wed, Jan 10, 2024 at 3:34 PM Kent Gibson <warthog618@gmail.com> wrote:
> > On Wed, Jan 10, 2024 at 03:27:50PM +0100, Linus Walleij wrote:
>
> > > I like the current wording.
> >
> > Can you clarify which current wording?
> > Are you ok with the proposed chardev wording, or should I be more
> > closely following the sysfs?
>
> I think what you have in the current patch looks great.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>

Thanks - that is what I was hoping you meant but wanted to be 100% sure.

Cheers,
Kent.

