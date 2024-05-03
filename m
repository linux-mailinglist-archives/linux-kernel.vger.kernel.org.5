Return-Path: <linux-kernel+bounces-167407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF658BA91C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C391F21DA5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5172714A0AC;
	Fri,  3 May 2024 08:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tKf8GmJ2"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C9B14E2F2
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 08:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714725811; cv=none; b=dnL7U6eiByIag4R3tmZZdzppdv6+hgN1az27hO+0gF2jsnBDZhuZVhdCaA1/gAyMbIG38BpnXrxAXcJlA9caSaEqU24Bt3qhmwTMiKZkJWmrCXVr+ZS2rfWws/CUwjdXwm13pGvOny1JmoZVss+tSOCLg3dfOfnFNFsJqT6P+zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714725811; c=relaxed/simple;
	bh=IthYABbl+XYP2no1zBH/8OfSj2VfccQFxJIGWTIgypI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rOYOorLBso8mgFcsXTi9KWe7zmbQbihdFlIqEHwzBR92+KBlE2WMsE8raCPIBJZA0bB9pgH8NKX0N1ZzYsIMhdau50L7Y3KCrDIA1NOQSAKWMgt7+HzUia71CrfVuAS0JAiSzZtqxeLqXN0dGKnV+cGLn5rHHCujCNIF47hDuYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tKf8GmJ2; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-de5ea7edb90so6190058276.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 01:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714725809; x=1715330609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IthYABbl+XYP2no1zBH/8OfSj2VfccQFxJIGWTIgypI=;
        b=tKf8GmJ2Pq+CfNEKOxeQit9eskq2/hSFNAqhVWrcy+IJPonBpK+6u7/wbgGHOgSCWK
         x5+3G2exV6oNS0+I2ingBOV0Sod2G1t0JYckJxrpqR0Wwa/2aH/8gR+L9I5ytCa3m3vT
         ALg6JeH1HP9UsaNTaQKMBSD/gUzpdcLLBTDjGE4kGO0R7Kdywcv4tCyNtZHnw/Wpi0vi
         hF1/FVsnrJVpQSdm6o7kOTUq+WbhbqjMEY9tYqmyQFmbLSO4lrhzqBVkKWHT3s6WKbHB
         RNa10Z/VouF7eCmsMC/F9EvfqqcOQUNDvNj6dLrC7MM1A/TcmfW86gd81MeSGR4VBTXK
         /SBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714725809; x=1715330609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IthYABbl+XYP2no1zBH/8OfSj2VfccQFxJIGWTIgypI=;
        b=P1zowEfh4g2+6+8va0FBTmyp1xuZuZCrAA0wn30S2Pw8NXLCFOzJIqOkMIHQUrUaZB
         fGGI1BF/osQai3JPcK1nLrPpReWZarbUdrH7HTHRC3liEEj5K6SnMBq9Z8wVa97qEslK
         ZohLzgeGUDlNAjWvBP01f21lYG6i+DSszZrU7ASIlrdlGB2z4vcIJ2/KN3WItJohAkT3
         M7RKxA4zmFknA03AdTfSZ0mPNAQW/pp3FId4fUMs09HVO9vU8TCghhBnTGMpdECOQ8AN
         Qjt76KE74Ox6gQbvQqe0I3shJB92QOGyYBYJnKXNBQvGPE6bPQ9T9PH9oSo8FpcP3pJs
         zo2w==
X-Forwarded-Encrypted: i=1; AJvYcCWlXLYlZGrhIyK5qh/HW2WlYGaQ6S81eh0HkJsoY+VvCXLL67KpIi4RCGlOeHbAtFPbdYiPBtiNJnWnCYax5rxC+dMpDKU1d8TEXuMD
X-Gm-Message-State: AOJu0YyuVkEl82kbFVvM++z1OVBu7g5b5xy5StG5FoJjkuZF5KKYioQu
	FFxR2zchSL8QbSciTQM/scUsji2tUiQ/NEBCi3kQHZTsT/WaUiDakj3dRThRLV4TEHd9rUXWEBD
	qEMxFxmvHoEskQS2KfIqzQILrSO7+A0v4OqS4XQ==
X-Google-Smtp-Source: AGHT+IFn18zk/0CGAnIGCKxPd+feiggCXRrifTra1ZKeVU6w+Ts5BaiPOesmJE+oMR13iArpuvmuLHtaeDFVjamaJ2c=
X-Received: by 2002:a25:8e03:0:b0:deb:3b7c:5268 with SMTP id
 p3-20020a258e03000000b00deb3b7c5268mr1774916ybl.29.1714725809150; Fri, 03 May
 2024 01:43:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com> <20240429104633.11060-7-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20240429104633.11060-7-ilpo.jarvinen@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 3 May 2024 10:43:18 +0200
Message-ID: <CACRpkda2Z9BsKuneG_vpjbmHRSGaVPo2UHABe78i0yv-w3+dhA@mail.gmail.com>
Subject: Re: [PATCH 06/10] PCI: ixp4xx: Replace 1 with PCI_CONF1_TRANSACTION
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 12:47=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:

> Add PCI_CONF1_TRANSACTION and replace literal 1 within PCI
> Configuration Space Type 1 address with it.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

