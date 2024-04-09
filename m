Return-Path: <linux-kernel+bounces-136612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F29B89D629
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 785A6283DB5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C946980BF0;
	Tue,  9 Apr 2024 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAG70yXI"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEB85339A;
	Tue,  9 Apr 2024 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712656935; cv=none; b=AkOCN2T93PZtTpahEom1ecsWdquYgRx/7RkMClgDgKsXOxR1f03yzjAxHRUSZqbsHBf+/iYbfNn84NEKsknq1t+pBpWCPtOVJq5hYIIt3Ev7m2msczV6XbLOnOTvZKFSmK6E3uYxWN+Wj7LqJGfAwYF3GKF3GqqYPRsVrJNgZ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712656935; c=relaxed/simple;
	bh=fMMPR+Yh9gYVL2djxLycCTl77gxWuXN3esxhzd6/Pb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=seuQzkNIbspZJIoGav7DxarJNIE21BLq1oQOXu4e6X6iL6RmEpsavMP2VZqv3ieqBmoqtlJJJ5bUILRiHVglxg0oEyVeATm8gakk71MWrrx3jrEo/QLh8WaTN1SvpjKDILYVOHDwxJ1oZtkpGRuygOq/6ohI3uvPUaLQpngyONo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAG70yXI; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2a2f2cd61cdso1398814a91.1;
        Tue, 09 Apr 2024 03:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712656933; x=1713261733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMMPR+Yh9gYVL2djxLycCTl77gxWuXN3esxhzd6/Pb0=;
        b=QAG70yXIdRaabEOkaV7rt3xO2LRwIqTORXZUBQ6qhdYfKFgBig8KNk1H2mzAyitV5D
         Xsq+6KFowF3wR41pEdX95l52Bbf/wvf0uYcixNegDHH7f6KUBKF+9fGWt9t1Z0YDvaiU
         ZVpg70uAkLWBSDUvMiM8xcA0V6plIubNuofvdYPWuqfkGK3xgzcuonPmxub9CF2MPmS1
         dOYid5x3W6vFneJXYNJFEn2sBb0XUHEWgtYIXjj4QV+MnEbno22Ebi0UdyiaTkIxXhj3
         ojVSCstSGSpzkQBGcnzVPFpyi16IRaNDxPqq6q4C1VHukGzgsi2XduL3FwxXrcUnX6Fp
         EjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712656933; x=1713261733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMMPR+Yh9gYVL2djxLycCTl77gxWuXN3esxhzd6/Pb0=;
        b=xNCUhRkLn9PIgrTJFuMTpU6LyiKR4wXZvLtPQ5KTS4ra3KkAS5BdVW+IfNNQIevqyv
         SYNCU3uE0bl8H6pKTENI/Ld/6WJMsKNEaz6uMtaUVYgDs6O8iH4FY9eckAhsJubHsyUH
         1FS5+do60QAGhtFHESiABDfroHDpRvZseHl6apPCluSN5o1ViPBQ13siB+kGyf/ixqY4
         O1S5HiMgQZeydSg9lcwF4mQKVhkDipAuT2pdb1wSS/ameKjkvDM9CpjTWy2itydDm1iw
         qixaMGxF0u9gldLvczUzll59sddG3urZHsbEAXz/su6P95jhyT2dbYbuuWxtY9eBlgz0
         z3fw==
X-Forwarded-Encrypted: i=1; AJvYcCXcEXxvhN8F7lKnhE2OTyIdhUcy5CeVM1cse222212VoHDoNH3IoAviyIgWNlSPx0j67BTtWjImfdcHXOVmFnSxr9/jlXUu0ic6wyZRYU6t8L4gye7/u900dH4wffxqcSRu75nk5Xw2ZcflSktUcdyq6D4Wm2eJJdiz6xxQyCNmVzBnMgu/
X-Gm-Message-State: AOJu0YwmVIXwnRd8QvZFsNpcZG+OzE6jMiS/1a2oq66jXMiigV1IYjue
	J9jPNOJcGJFCpLa16AZ1TWrzDHTOUcd1C5UX0f0j04IfvJ26S6k6hXB6JSaMTeiTm799dLwWHF/
	nij0rbZ6G+gq/PX4QDisgY+9LfBU=
X-Google-Smtp-Source: AGHT+IELrW9fVmzx05lKtSDUmKkTXNduR8F/EVQ4MLLoyqDY44OGDV7EXL3DQXLowx47WFC00/A9tFArob5eyFuseLA=
X-Received: by 2002:a17:90b:211:b0:2a5:2b1c:90f4 with SMTP id
 fy17-20020a17090b021100b002a52b1c90f4mr4238430pjb.3.1712656933108; Tue, 09
 Apr 2024 03:02:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1712652644-28887-1-git-send-email-shengjiu.wang@nxp.com> <1712652644-28887-3-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1712652644-28887-3-git-send-email-shengjiu.wang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 9 Apr 2024 07:02:00 -0300
Message-ID: <CAOMZO5Cku1kifsnWJOr0Zd-5+49j-KB67iHZDcvUsKwrhVPtLA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ARM: dts: imx6: exchange fallback and specific
 compatible string
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	shengjiu.wang@gmail.com, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 6:08=E2=80=AFAM Shengjiu Wang <shengjiu.wang@nxp.com=
> wrote:
>
> exchange fallback and specific compatible string for spdif sound card.

Ok, but please explain the reason.

