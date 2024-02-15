Return-Path: <linux-kernel+bounces-66178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D21C085582E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95551C2238A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FF2ECF;
	Thu, 15 Feb 2024 00:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+/A/kuC"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6C3391;
	Thu, 15 Feb 2024 00:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707955776; cv=none; b=K6xb0Wx1iJb7sjKTBn5J9Dqd6G2QKH6RYLfUm0LjEnYr2ddHD5HFOdLg5A9rtd3FpPBlSWfV8iJvwnTP3ToumTs5xYPeE5Y5JB9DPnsj64Q8RNffx7LRrzCtzM1/29+tbCpm5AzPJLzLEFBQq7U8cyGi3C+Druav4CdsnlMERuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707955776; c=relaxed/simple;
	bh=n9ieSy5V93KC4SdSun7MFEwqZwuRzVifQJhkvWQFCgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvlZZp3YmvA8cwaX0jrsyAcT7gIuLv+JNrOekYBZ6yenBUAaclv82kaX/g648h0g7RngDt5fsxG3m901U+6Ex+spmsIaFBJTpPjsfwdxTfPn8okxC8LWQx2kZNgAYwVHx1odoGiaoWKZPSu6M8zXHIL3knksccvGoIjOe/yqF4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+/A/kuC; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d1094b5568so3973111fa.1;
        Wed, 14 Feb 2024 16:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707955772; x=1708560572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1duIMvJ1ZNzVXpih2n6U+191FqGP0IxFLpaQFFYigPE=;
        b=j+/A/kuCNVCQLYcSy5bV4MKy4uLlbA76XPYxFFc86c2/f9iWEmL9m9bWxWVnCGIOM2
         9aRd6Je6TxuFdr32Hs/msvcgb9dUVlkJVRuwcFadTEpcrJp7CK7jO+x96z0PV4HE/ezy
         zkwDuoJnCkwTDEwhjzQlUOoGrQVgg3vwXkaHL4YnfssEaJ2s7XklwSY0GALIXuoNxhof
         W/UB/kUgeB18U4wauvQx5s2bSvLfZUqodTWLIPxSLYazkdzYPMKGaHsz6oXMfdmwInhN
         9RYLOsFbZmmnDyeakUUgp1+69mcCATjQaYrlXlnvfAJzqMdt2hMzaJMoxABVkbgmduEj
         J4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707955772; x=1708560572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1duIMvJ1ZNzVXpih2n6U+191FqGP0IxFLpaQFFYigPE=;
        b=GJ8E7CrfcFlzdt0qrMQ4vt8ayevHbnTsgoQhZ5QQeQJcUDtcKB36u98pLloeR6Al/3
         5DrzG4I58lhtdRWHoQ3nlXYT/1tleAfGWmMr3a7r8q1GS6AinmTP77LJSElTVng6qJvW
         xF+vOif7weDgpDMgZ1l2ZhhyFFBZD5kbEokSxQiuJB2m1YJIcDfftSVHPlpOTpDHS5yt
         0lSouyVEXsuwm9oAL62rAoNhDoYv+va5zYNJ32Ihnx6FtCrfSAoPkXX5ANH+D5ndkrQG
         GibqsHeESNGTzvKshI+oSRtG6JL2nUnIoca44swa2C6PS0BB24rnLdpuKm8KxMxmWMeb
         un6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVkGlw7cmFu6pUKMZj+g2GTDGu1H7EsLT346EejNYfulTPO3/Bok34SYzOpdCSyYiB3LlTmVa5yKrDCEB0e3d7IWLHwGIFpoEljledu
X-Gm-Message-State: AOJu0Ywva98DCX8JCBiH3kIuJxsx8rUnHLeFDXqOT1rB3fSvRr1q4KDW
	dTfhByExU0hMuqCm59Pp7Ayc/KqjEtpOLSIs09MzYd0FR7Tr3SzL
X-Google-Smtp-Source: AGHT+IHzf+RbETNgxLBBfJPEuN+Mi7QNhZVp5i2DIIEI9/7q1Mu2J0jcaaHQBx1uQgg7sVY+YEA/Ow==
X-Received: by 2002:a2e:9e10:0:b0:2d0:f629:82b9 with SMTP id e16-20020a2e9e10000000b002d0f62982b9mr212408ljk.34.1707955772197;
        Wed, 14 Feb 2024 16:09:32 -0800 (PST)
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id n17-20020a056402061100b00562d908daf4sm36417edv.84.2024.02.14.16.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 16:09:31 -0800 (PST)
Date: Thu, 15 Feb 2024 02:09:29 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 04/15] net: dsa: vsc73xx: Add define for max
 num of ports
Message-ID: <20240215000929.atbax2vqdbsatpcl@skbuf>
References: <20240213220331.239031-1-paweldembicki@gmail.com>
 <20240213220331.239031-5-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213220331.239031-5-paweldembicki@gmail.com>

On Tue, Feb 13, 2024 at 11:03:17PM +0100, Pawel Dembicki wrote:
> This patch introduces a new define: VSC73XX_MAX_NUM_PORTS, which can be
> used in the future instead of a hardcoded value.
> 
> Currently, the only hardcoded value is vsc->ds->num_ports. It is being
> replaced with the new define.
> 
> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

