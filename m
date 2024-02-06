Return-Path: <linux-kernel+bounces-54418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA27484AF01
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFE9DB232CC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D74128839;
	Tue,  6 Feb 2024 07:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZzwKrVA"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02572128810;
	Tue,  6 Feb 2024 07:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707204704; cv=none; b=UYmUNC4rRM1qbJYnCciNSEg55XRVlSH1w8o1lZ6LB/o8w3/9mz7HQ1e1pdwGbWOUYjP+dS2PpwQi+0N841XSO2JG6hWVa2pUP4qX0RQp+K+WVf+r25auBmJKe3hkuu3dsFS/6EUxVTTuvYosl2wzEsWOvqHDdNb2NdQ/yjWmbFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707204704; c=relaxed/simple;
	bh=aHeN/DwCZTyWaeZkbZFCrZMKkRuzmVdTS/3KetyGM1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGLaG563jCI4e1T59QfTxqMIWiikINbR7+0TfGCqIqx73ISmb9jCfPwo5T0bWfB4SSR6YmWLpw+mwGTDJBNDSTMnWLbrXUPA3/X5G+5B+0ZYv7ai3RRmjX6G+EqevPaAM8KDi09C6ratLseHEXIoLrAOjFEe3q4uqTinMP6RSVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZzwKrVA; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5d8b276979aso498899a12.2;
        Mon, 05 Feb 2024 23:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707204702; x=1707809502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Opj+msIKIr4Yxj2sekXGXxbXzMPQ6JIm/gk0Yx1cPE=;
        b=KZzwKrVAygCqyWN8xHs1d8jTOgK3VMsgYHB/+BogVPGtS5zXO5sD8J7/4bySCN1Gls
         I9EtUwHCAorFBGSiXwsT5MGSTl3eeNmNttmws4647t5VZO581nm0QWxDOr3IdNjvFu+U
         A2BbkZofG9rBLEgSa+SmxSfvB9jhmY0gu0jcVqaa7q/2+NqSbU88lAPNz3fOdPYgnZGi
         QbKczTa8urYObLoaTFpMo3WQegRgRmSS73h9BVRUaHn0+knNzWnzm2SH7PhzoYsAmbgZ
         YQsFX63rxx1PhFY8Wpa+/47YOy220fcJfVHLXg11KQZ3/3jA3bB07jaO8wFiBx89TiSG
         DMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707204702; x=1707809502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Opj+msIKIr4Yxj2sekXGXxbXzMPQ6JIm/gk0Yx1cPE=;
        b=v3im/F2KKvwXQnopbRlk35OIAhA6XDbk/XqZ1U3j65i8KStcE8GZpfXbEmL+jcZDe9
         6t5d/TZJZkL20+4ptBV9nozHvJhQt7tr9MxbtwQQl/p4CXp0n0x5lmlyYibhuduXUnPf
         jBtl25NnRKijLvR5m+8jXzfkbe9PkUjOeMzi50JZ/0SwXNiYy80ZhLaaZALFpcja+I80
         YsixFaF22WYnGTQBHKNQZ1U2NcL/7f0KheunwUmDD82G7wmFfMRtXErx3do6anzKzQzT
         z7EYpBealZO9Yb5lN9YbiBM6aplMmSKFtQU8jt+LJETChBQbapYsXWWGPSz0mRHypStG
         VQ0g==
X-Gm-Message-State: AOJu0YzFlNu/YNHF+Tkl4zE8uPlRHpPAmiWQn39ASe42/DQMVK+h75e+
	4MM9KF1Pj3XiAeiUEHHqTiDnTSMkpQ4RXBf+in9ZTB197i5nBok+
X-Google-Smtp-Source: AGHT+IGyrHZMnTucglCSl0HBBj6AIOfaTXmstzhAMRvYlX4LHgIhB8uVz6BfLLh0Xb2Z702wGKxpTg==
X-Received: by 2002:a05:6a20:8f25:b0:19e:34e4:818e with SMTP id b37-20020a056a208f2500b0019e34e4818emr908605pzk.8.1707204702287;
        Mon, 05 Feb 2024 23:31:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUxEtYTb3qTAZ4JM+Eg7KRh+oKOphwcu5V8MmWfGrlDHCa2Pf3KzK9shVY7b5SzxxCgMIilVmE0c9qSG5v6nLI7FPfthdBjB46zZZN5DfGXFsPDmPfFrjEFmi0hZtKDmgMTkcifOCOPrUn4or6W7jB9Ztpz8X3bITlf8yi6gSqQ/SA5kzXSyhTW/SHAZoPC4T6chUt3CokppqbiGVWfI6xplC1U6WM7Ac5u4mXn9FNIlEQLzsL8UaxRXNAWqpqtgofW/GdXSa6Tk4OTCuZawikPq9oEZJ06zUciIyBAnu0PmXPZJFlnFrPDtq7JVn+YlDKMOv1MBxmxeLc0n3zSIPqUjgpXnHGdnQ9va2Gu9/Hw8PGfmuHawyig/tLm04WRDALgNMi9HuTDja3LGYmm+dXx+FyZfCjmK0g0Yzdcw0pZtz80SKAbtwOj1eRF+RVX4PLpm85FmN0M9tGWX4haTaNS8flwLULhqRykecevqtjf+JmziVBMacb1EJ7Wd45zRQ0l52ToA5Fl2MrP3+sawfRPCwlgHo/qknyABtDVmNpjPxZ2PXM+cBbNLjrxAVd9gaf/kO1/Yw==
Received: from dragon (144.34.186.27.16clouds.com. [144.34.186.27])
        by smtp.gmail.com with ESMTPSA id mi14-20020a170902fcce00b001d8fe502661sm1143349plb.19.2024.02.05.23.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 23:31:41 -0800 (PST)
Date: Tue, 6 Feb 2024 15:31:25 +0800
From: Shawn Guo <shawn.gsc@gmail.com>
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, Li Yang <leoyang.li@nxp.com>,
	Primoz Fiser <primoz.fiser@norik.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Christoph Stoidner <c.stoidner@phytec.de>,
	Wadim Egorov <w.egorov@phytec.de>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: arm: fsl: Add phyBOARD-Segin-i.MX93
Message-ID: <ZcHdc73ys6TCaUom@dragon>
References: <20240124074930.26101-1-othacehe@gnu.org>
 <20240124074930.26101-2-othacehe@gnu.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124074930.26101-2-othacehe@gnu.org>

On Wed, Jan 24, 2024 at 08:49:28AM +0100, Mathieu Othacehe wrote:
> Add support for phyBOARD-Segin-i.MX93 board.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>

Applied, thanks!

