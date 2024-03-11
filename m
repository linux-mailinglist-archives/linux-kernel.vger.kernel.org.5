Return-Path: <linux-kernel+bounces-98432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152D9877A24
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 04:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDE9EB21019
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 03:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854E51FA1;
	Mon, 11 Mar 2024 03:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJATvD0n"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F5117D2;
	Mon, 11 Mar 2024 03:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710128016; cv=none; b=C72LSDRbQlt1AXPmeZUaGW+FHj68/ZtQrEvqQSvZO/edp6k6M9BOUXR2i9ltvtndIEnS7xPHkusMscNTLGUEAQsqVKTmDv+GAU+Be1sOS/b03FP7Cg0JnO5jFpOMa8lSCYO3nAu94KYySQ4yxMAu0tgBNBGwRNqoXzN0gkJlBzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710128016; c=relaxed/simple;
	bh=nmSBkh8trk2SfKKLbHXlV3zdZYUozq2GuuvHmPmREjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1KMoDBVVYMB4iYOFIelX2hYHPS+N1E05jj74rXNpX208cODo4JSqNRe660jg2+iabKdXo+x6b66eJSqWXdRTMEXwlN1BL4Ny7O/sX3+GLBsjbhFsGglVqPG8Jm9IA4VkAAnrWcI5nEy0S+NLwHNw/XIbBuKUi6tETbF+ts2Xuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJATvD0n; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-221a2d0c5dcso1606766fac.0;
        Sun, 10 Mar 2024 20:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710128014; x=1710732814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmSBkh8trk2SfKKLbHXlV3zdZYUozq2GuuvHmPmREjs=;
        b=iJATvD0nAhGiYWfH4MiuM9wR99UUyBDX79dJXs0VKLxm2Szzy3S5iGtP8P5oImxhh+
         ATZrWuwtLfyChJ/vgti9TIs4LNaWWa1aLPJEkgm3/UqAklHBnSpizY05Psk+yUszU9+P
         5X+HL0DRDYZPcKN3E95A5MSWS7RG7oCVBFI7XVWlLepMgPWqugG4Fiyb5uvIu7ceFuEz
         wrFrjh6347FCBNJPoswoHmi2WELLANc2twqZoMx2AGyJJUOPd02n7QKlg3goDlHXXJyC
         m6w49uSWhVKx8i0bcFwOPUEEGhI3z6/J/TF5UJHelTy6Vu85Y+sMcRFDgC3XrtpPPFA6
         W+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710128014; x=1710732814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmSBkh8trk2SfKKLbHXlV3zdZYUozq2GuuvHmPmREjs=;
        b=rpiPZfAyfinn6AgsTvt2EPpTx+TOfFXltWtUEGULmivnnxxcr455ashNriYbzfDDxS
         2H3m9+54RZmMzbuBuFTvJ0TMcL7Wv7Rkm629KOY/wFgRVX2haZgVS1KTVphdjVvZ6dX0
         75XoVssgm/6F92wyZ+i+RYq9WkweekVH/oIptKHNvcYchjgvvVifb9/aDU+28TvlygiI
         7rzCgCas168BSTA75CIKYrhV1OkNZ1CAfTgenPDZ/fSfR/pOZU9IdaR81Atl1yWwtmCn
         0c3nPcjyIm7BmHxefnxZ4IHxjpkWC4EYlho/rgfmWqyGivNFSK8HlrbTHPj58kYp4PyI
         SVZA==
X-Forwarded-Encrypted: i=1; AJvYcCViLhZ9qeRMhwT7V/IMyQRxs3XbpF4kQPduKKPHrZ9R1lIMZykJmk/AeJa3CMTJ24WeuUVdRsQZsSm2yGxhyrA7zwK6s1Q+ABHw9cU8DY8LDYFFix8iqNY/DQkSckiGeLaKMGxQDIRHwJ4E+R4ANI1PZR4eTs8PxWyDdlqRaXmVmbVQ6w==
X-Gm-Message-State: AOJu0YzJ1mYM/zToydFYmHwONPVDhBcEwysloLJ0hyboD/BKCLNXs0qt
	+8mfN5IoDdanAi3OMFjFPNkPNFJGmj28D3V6oq56XwbD7/NBwfBBSdMyRI3lFwPDeqIUBkdsNXM
	DXl9F/xnqq4uDkzmjI66T/YkGBEs=
X-Google-Smtp-Source: AGHT+IEEWYvYyub+cAb9jQ+3+gc2/UQx8g+vDrEH5ot2+j1TFAjUp7k7R4rzukWnnlly1T+w270UV6c31D8k1Vx3OnM=
X-Received: by 2002:a05:6871:580d:b0:221:1cb2:f569 with SMTP id
 oj13-20020a056871580d00b002211cb2f569mr6506082oac.23.1710128014600; Sun, 10
 Mar 2024 20:33:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310175217.20981-1-animeshagarwal28@gmail.com>
 <448f9d20-8b45-4794-9440-89d6a6888aee@linaro.org> <011b7c4c-ae44-41eb-b7eb-1a71da669f26@linaro.org>
In-Reply-To: <011b7c4c-ae44-41eb-b7eb-1a71da669f26@linaro.org>
From: Animesh Agarwal <animeshagarwal28@gmail.com>
Date: Mon, 11 Mar 2024 09:03:30 +0530
Message-ID: <CAE3Oz82ZC5Vz125iLzjsdvZd1YLd4YgQsrGPgTRJ=ugEc=e=Ow@mail.gmail.com>
Subject: Re: [PATCH v6] dt-bindings: imx-pata: Convert to dtschema
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 2:03=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> BTW, If this was not clear, I am quite fed up with these patches, so
> keep the rule of one version per day. You made quite a lot of changes
> which were not necessary and I have impression that you should just
> double check your code *before* sending next version.
This was my first attempt at a contribution to the linux kernel. I
have learned a lot, I feel like I have wasted a ton of your time.
I always try to not make any mistakes before posting but it was
clearly not a good try.
Moving forward I'll be a lot more cautious and write better code and
add proper explanation for the changes I made.

Thanks & Regards
Animesh

