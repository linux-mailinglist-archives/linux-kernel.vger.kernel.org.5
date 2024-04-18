Return-Path: <linux-kernel+bounces-149862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E528A96F1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47E73B2150C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9139915B578;
	Thu, 18 Apr 2024 10:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="32zD3y44"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB5615B141
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713434596; cv=none; b=iZDykfIntnmxi+nngBTUechDYaAQPYUFk6m1Xm/W/gcHzNhi8VrBEkV9mkgm3YsgobpTMfH+DQX74h15JwVkDYdNx58Oue/W1T7CS0t8fdNZldNKthh3U8gO3JkKDD31xJ8Kq/MGgnKDgo5yVPUG2p2xByYB4K+TvG5TpRhQZrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713434596; c=relaxed/simple;
	bh=zwzkYWr6U9C4zC2JlX3QMDroH3epi3ZSlaJuC9jmIvY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TnbRtWALH/oXtdKt+qFEGjVmNX5GSdbwW3LlubNAZYXtH+IXoEuJlE/w2yC2UV3TSGBErSn8oTeH+MzEub/DJGyY6W3zIPFDdIsnGGlWYS/RSdz7qNN6lxmW8HcDC3Kn4qUoht4SwVZFE6vmZsBbdkEwHSEmpUkNCuLxS6ILNvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=32zD3y44; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a555b203587so65892466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 03:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1713434592; x=1714039392; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwzkYWr6U9C4zC2JlX3QMDroH3epi3ZSlaJuC9jmIvY=;
        b=32zD3y44hHaLIYej5hYS32GufwYGYRibPGW7H1540N4sCnx1Ra2aQ48QyYnbP/Rtkn
         5LYrRWqRx4iqonM4En5tqQcLAdoaf+DywCMtNDgT07hPKKMY88DG0/1JovWPbJtLMwN3
         6Q7it91+9KwtCPvpbDJKJ6UVUEdt211xAL2lxBBRVdI5AVxZD3Elx+2JNJiUOmhX/Flv
         rmCCk8IttwWC70m9fJqMg5+f9p7fap040O8SJzDidRqbsvOFSl6s6/VKUhbkduwFJZjo
         UFiagZ5L6S+F8R3QiitcE8gYdRxNB/VeRTPrKE28a53pAUXiRHDnWTMCsx+6RHPjBlQu
         AIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713434592; x=1714039392;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zwzkYWr6U9C4zC2JlX3QMDroH3epi3ZSlaJuC9jmIvY=;
        b=siCDipkxoylsyIKXReFMKtUFpyvxU7giar+5av5JSCb/+1aBB1FrTe1SB04WnV7/CJ
         2mqpJWTjw+TtPMM/Xb2Nh6ba6I0tzXeCtVhg5O+nsHJIXxWvT+cHZCSaMM/9Pq1GuPHI
         8OqGvCA11KpifaIVv1wdMwlaBLi22sbWWk2ryqIdC3aVmHypHd8gt9px4FtBF1mnfSKa
         vTaEmqdLfRogwB3FmB7keCi5cGYTDOm+BZ6FVui783fYQrjRTWuYV/A0C4soCK/vayYH
         2D5ZQtXl5WrJcXBQFQFHaWUPf7Hb9Bj5gW4+XegGpkjEeAnUAF5/U4VSw4BEIKq0vK00
         Rb+A==
X-Forwarded-Encrypted: i=1; AJvYcCVDhFN4a9mu8gmpMDfjh3A50WihESvvwPUbMr2ElPbbj2tif/bEOdQ15XxMzNQ0E2xeMA8OM95drqSNG1Gt6MpX0Eghp4MJri5R/WB8
X-Gm-Message-State: AOJu0YxoaI02SAFJ6sTqckSSbWXZNs+l/lVO4nnYFYEWFVh9z8eTtKAj
	W9v2CLB3GMX6HevYb3UqBmJKgbKQZs/JagI1+n67MuccmeYbaotAq3yQxNMbNWU=
X-Google-Smtp-Source: AGHT+IFwCe4772YEoD9aT9S4d9KsRvOdenXKwAQfIEqOG8jB0+onHAzI0XgYqm54xb5CuulaaJho7w==
X-Received: by 2002:a17:906:6857:b0:a51:dd18:bd20 with SMTP id a23-20020a170906685700b00a51dd18bd20mr1763260ejs.14.1713434592068;
        Thu, 18 Apr 2024 03:03:12 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id gh16-20020a170906e09000b00a5180d5b31asm672634ejb.32.2024.04.18.03.03.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 03:03:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Apr 2024 12:03:10 +0200
Message-Id: <D0N5VCESMRIX.3MY64A0MXKJGW@fairphone.com>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: pmi632: Add vibrator
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Konrad Dybcio" <konrad.dybcio@linaro.org>, "Bjorn Andersson"
 <andersson@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Fenglin Wu" <quic_fenglinw@quicinc.com>
X-Mailer: aerc 0.17.0
References: <20240418-fp3-vibra-v1-0-b636b8b3ff32@fairphone.com>
 <20240418-fp3-vibra-v1-1-b636b8b3ff32@fairphone.com>
 <c1763d69-f0a4-4415-be7a-31b04153fbfb@linaro.org>
In-Reply-To: <c1763d69-f0a4-4415-be7a-31b04153fbfb@linaro.org>

On Thu Apr 18, 2024 at 12:01 PM CEST, Konrad Dybcio wrote:
> On 18.04.2024 8:36 AM, Luca Weiss wrote:
> > Add a node for the vibrator module found inside the PMI632.
> >=20
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>
> On a side note, this is a totally configuration-free peripheral that does=
n't do
> anything crazy until manually configured.
>
> In the slow quest to be (hopefully) more sane about the defaults, should =
we keep
> them enabled by default? Bjorn?

But many (most?) devices don't have a vibration motor connected to
PMI632, some (like devboards) don't have anything, and other phones have
a separate chip that controls the vibration motor.

Enabling this by default would mean all devices with PMI632 would get an
input device for the vibrator that probably doesn't work?

Regards
Luca

>
> Konrad


