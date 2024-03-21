Return-Path: <linux-kernel+bounces-109863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2FA8856CE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1896C1C21476
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A8A4597E;
	Thu, 21 Mar 2024 09:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="miYXrVXS"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746BB53E1E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711014522; cv=none; b=BKmN3wbwq8nB14qaCyuI7RaFfBEJKzCvidupISL6nVenQEZDuwZw/Zpi38wn7mdjLX2pmMOzeUA8ufa+aBZq7s0PY+jtWiFKPotZ9IZMSsiXck710x1x/uObNSGOGl57BL/So53Og+RhwhwJ3BPTG6wJ0hgPPBN/+UhjicCX7Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711014522; c=relaxed/simple;
	bh=9931IsrYWQDSu/eFeWuyYjb66xLzNhuPeYdZAtOIOoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpRDQekjFXpMP2YnmLIPMUDlp+wOMN0/J8BLNnQljjs0YO0UTSpqQJ5k0SFsZ5BsrDOIS59ViQNU/kJSMpODP6az3z5D3EeQbyi1BU/ieWzFJMtNzoAPd4EJw2OrvaDskTWvxiEimeo2llA/oZwR/gHIyvRKen42ljDNhpE8WgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=miYXrVXS; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-414701303f7so7336075e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 02:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1711014485; x=1711619285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9931IsrYWQDSu/eFeWuyYjb66xLzNhuPeYdZAtOIOoM=;
        b=miYXrVXSlEfx5qibJ7Sc2sNWoY6AlFS0/eu4vqafFoZu/rI9Xq5wBsELMsrFhTFhbd
         j0A5oWF9BJ0SALTXZEhadHvL2oJuuGC2oouvKy2/IKSO9cVqdnne6Ti0E6jh6n+gVHCK
         W8QSLpoAh7bituULcgafsvCcoJjDOHiB9F86ivs0g89L6mFOv9mdbdTaFgkmpUQacxBE
         Fch7MTg2sjck2sKCawohRDqODxnumgW0B9A761VOnmGWj3voIQSOFsrdHZ+alV6Ivl6m
         AI/yugHz0DyEZuI/aOMrVTzvFrPfBE5j3pUt01mk6+y+SltmLTLaK485eWmVWp4cVf8D
         TEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711014485; x=1711619285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9931IsrYWQDSu/eFeWuyYjb66xLzNhuPeYdZAtOIOoM=;
        b=ee2tnIFXTsnmFi/l6izt68Ry6VeE1CTSIWZ7bv2goGZxufHOa7I/y4RtuObjABW1uw
         31ZglBanbMzH2lmTBbVa33aaBtB/EpNRnLORO+QaQk3R9EBegU4KLUeItJ3sIgoKaHPx
         KsbZtUuvHjgMsuK7yb/7z42oaf8n6cUadkog/2FypV2kcub4DLEztHANC1kxJTk/xv8K
         /NgcEM1XIcjXdigIBRCsTotejAoiLAcS1YGXNQT51DYflGS/BkQ3Odk5HWvE/HY8XQtc
         MvvjP8Jw+JsAc3O7GsUmIzNbjVWaYgAqkvtf38qLdQCCwFN9QIUrfY5VZ28Df1IOYlLo
         oUHA==
X-Forwarded-Encrypted: i=1; AJvYcCVVjRBYxcOHPzM8gban88+n02oIDyGsKX+niFeBcRjsEiAddwBZlTlbdmwmnBWxJ7O33xO4CTINj+0fdhYojh110agXV4CuRPOcPFN8
X-Gm-Message-State: AOJu0Yw1wa3LLjBJqeeYNH/r858ra1ev2ISzoQG2/QMFVGHHsoO9Fe4s
	0ipmfk18Xl5EDH89PS9wliaV2GLVN3QHpDyS07shM5e0XYdJ5x29THS9kKcRc+M=
X-Google-Smtp-Source: AGHT+IEn5hYdjsCtQC65m/BjBIh/ND0BhYzUdLoyJ6ghkDCvpjzUTuQBbg+fUfWtBghy6AQsDI/IEA==
X-Received: by 2002:a05:600c:63d0:b0:412:d149:254c with SMTP id dx16-20020a05600c63d000b00412d149254cmr1189143wmb.17.1711014484620;
        Thu, 21 Mar 2024 02:48:04 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c451100b004146dd6bfe2sm4276212wmo.47.2024.03.21.02.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 02:48:03 -0700 (PDT)
Date: Thu, 21 Mar 2024 10:48:01 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Alex Vesker <valex@nvidia.com>, Erez Shitrit <erezsh@nvidia.com>,
	Hamdan Igbaria <hamdani@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v3] net/mlx5: fix possible stack overflows
Message-ID: <ZfwCURACC48Injgk@nanopsycho>
References: <20240320180831.185128-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320180831.185128-1-arnd@kernel.org>

Wed, Mar 20, 2024 at 07:08:09PM CET, arnd@kernel.org wrote:
>From: Arnd Bergmann <arnd@arndb.de>
>
>A couple of debug functions use a 512 byte temporary buffer and call another
>function that has another buffer of the same size, which in turn exceeds the
>usual warning limit for excessive stack usage:
>
>drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c:1073:1: error: stack frame size (1448) exceeds limit (1024) in 'dr_dump_start' [-Werror,-Wframe-larger-than]
>dr_dump_start(struct seq_file *file, loff_t *pos)
>drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c:1009:1: error: stack frame size (1120) exceeds limit (1024) in 'dr_dump_domain' [-Werror,-Wframe-larger-than]
>dr_dump_domain(struct seq_file *file, struct mlx5dr_domain *dmn)
>drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c:705:1: error: stack frame size (1104) exceeds limit (1024) in 'dr_dump_matcher_rx_tx' [-Werror,-Wframe-larger-than]
>dr_dump_matcher_rx_tx(struct seq_file *file, bool is_rx,
>
>Rework these so that each of the various code paths only ever has one of
>these buffers in it, and exactly the functions that declare one have
>the 'noinline_for_stack' annotation that prevents them from all being
>inlined into the same caller.
>
>Fixes: 917d1e799ddf ("net/mlx5: DR, Change SWS usage to debug fs seq_file interface")
>Reviewed-by: Simon Horman <horms@kernel.org>
>Link: https://lore.kernel.org/all/20240219100506.648089-1-arnd@kernel.org/
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

