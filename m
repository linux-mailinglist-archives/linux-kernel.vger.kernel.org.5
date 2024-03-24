Return-Path: <linux-kernel+bounces-112864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1503887F2C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 836FA1F215EB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BB61CF96;
	Sun, 24 Mar 2024 21:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H3wO1wvc"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ED91C292
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 21:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711315579; cv=none; b=Sm3ETPJ4OcGxMv6Dkm9Z2xYarSPAm5G+1x1E+ivCQu+1G/7UKUz8phW0aAx/aSYZDBcqcTCxOuATvZwBzvUnUvi51WOnodY1/KlqmvaVAO6lPQEGy3jIej0Tgxx5uyfiRyMY13LfNyMHBVPM6gDl67pKHpF6rk13BD1n0DQa5a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711315579; c=relaxed/simple;
	bh=KKl6wWS260X61pqvbsfcKnOIji56BqFVJYwHX5ROGcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UM5oC4NfLYsaNOSi0GxOdE6xOSt6vcjcv0MvM7dpxxUEcDebo7umNZF/Gro05lsPwVSDPdG6gIdBAxOX92DhjZKrl8WUbzAsUsemDyFt+0oDa8ufwJoY1zXOulawKkegyjJGUCadZkjM+fvgyRK5fseQnWCXuAEGljChiEEcNTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H3wO1wvc; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-609f4d8551eso37896957b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 14:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711315577; x=1711920377; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8UBUPxS321/AJf/zeuMrnHeAqSxFl6swaOw2l9wbH8s=;
        b=H3wO1wvcz1O3AS8Bi5sr1Yp1RCF5KI7ntF7/eyMiEuPXDPVgJWXGWbTrsXrxewnoPq
         IpHd/KrwPcswTODF143HGyVCxB841jX09yrMugS27TcpWYS2OVj/ZaFVVUv7OyM1xA+n
         F6REpmleVSbiZ/K+WHpNS/U+f4YHN+2RZeavFCKuUV0HDeY7ZzbOoB3UoNf14gjSwpzu
         xeswF6yliMAQXaSA4Fmo2qz39c4hdZ2zremsBofAoVQHaoyU3rleJkBfjGEPs2SrFf7U
         LgjwMuBc93Kp3r+ldY/sZD4hibIEjxPMAVW/TtHGhBfD4k0J3gjQi9sjFDMQ/V4xBhWy
         DoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711315577; x=1711920377;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8UBUPxS321/AJf/zeuMrnHeAqSxFl6swaOw2l9wbH8s=;
        b=ke/p5MRNmttYz9PxYMMgElxcLGEdV1NGCpjzrN59gUD2Ao9vTy1Wd+11XyoOQpXfjj
         3alARu7A3miCW3UAfDG1omRSHvagEpRBawxXCF2c3cjLx83WLlOR3G9tPdgyFyIh5Ukc
         c6SAbCj8+bBbinmwqY+r26RT4mg82nljPbNwFLJz7eK6SDcvBlrB9jTrzAbHgQflctRF
         QfLdVPRr9LtxM4E7FYliXArBRZGvTU2j77xXSIr+Xb/H9wgXOXVp07XGfe7P/tE0mqaf
         rNKN7ljDvNfdKX1iYTGOWM9qMK0keDXYm4AtPN7zPfVuFS08uIQJTYSup/F6sQencp5w
         RMfw==
X-Forwarded-Encrypted: i=1; AJvYcCWR9XGKNpj/nX1ugbUeMBBKwph+oIXQBFP4YBiEAqlnVUsqX7ohcDEaGxLF1s9vej9oYEQ3l8t6Sd6ebNWaDlV188txS20XhwWyEZkM
X-Gm-Message-State: AOJu0YzeUuSRFNi0B9s6qKmosJhkkogNQ6IBnoXoFYIMmDgt354UtsmE
	hz6OaHQss0IjwLIG0/SaMg3VRBWgEv0AKEEcIAngNBtcbvpX311LCoHgFhoVU/WNZza4UhvJHqw
	PKWKAwkpddm7/zvc7v6x1sMSvWU4pytkAGHSSKA==
X-Google-Smtp-Source: AGHT+IG/BGMQhZLtiVAhPS3yZQIGBjfnOqHRCzrw1QQAMhgO2W6ZqAaMDp//3sX/c/QhGU7sxClNAVK8ToaSEIU60Zg=
X-Received: by 2002:a25:d804:0:b0:dcf:a42b:7e2b with SMTP id
 p4-20020a25d804000000b00dcfa42b7e2bmr2460474ybg.3.1711315577391; Sun, 24 Mar
 2024 14:26:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324-x1e80100-phy-edp-compatible-refactor-v5-0-a0db5f3150bc@linaro.org>
 <20240324-x1e80100-phy-edp-compatible-refactor-v5-1-a0db5f3150bc@linaro.org>
In-Reply-To: <20240324-x1e80100-phy-edp-compatible-refactor-v5-1-a0db5f3150bc@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 24 Mar 2024 23:26:06 +0200
Message-ID: <CAA8EJprPgZJ7hZooJEs1ysn2Py=M_rJguuVdXFuBK757q86ZAQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v5 1/2] phy: Add Embedded DisplayPort and
 DisplayPort submodes
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johan Hovold <johan@kernel.org>, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Mar 2024 at 20:50, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> In some cases, a DP PHY needs to be configured to work in eDP mode.
> So add submodes for both DP and eDP so they can be used by the
> controllers for specifying the mode the PHY should be configured in.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  include/linux/phy/phy-dp.h | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Vinod, we'd need an immutable branch or a tag for this patch, so that
we can merge DP changes during this cycle

-- 
With best wishes
Dmitry

