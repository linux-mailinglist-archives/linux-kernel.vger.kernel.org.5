Return-Path: <linux-kernel+bounces-94489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C45E5874093
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70D4CB23804
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C0B14036B;
	Wed,  6 Mar 2024 19:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yyipT7by"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A096A13DBB7
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 19:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709753847; cv=none; b=OKLL3+OI+LU69dLNWUJjbzFn53+TiGutFVW2rXl4lMUTLIVBFBOTLhQ/od/Jwoflu4vf6HkB98VfVd8P1rxmPDT5ah/V7Abnczji2M1KsF9JyYJkPTEteh2W1EqJ7H1YZeSXcEitbPIyCOgyPCW9v4piAmnlf9bHH7dLlh7+sOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709753847; c=relaxed/simple;
	bh=6cnpZDUdkD29IWFwR/q5G6jtdmxkXbldKBzmXR0qa0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rpseq9sP4SYVgPi1YBOeYKzmm3Rlv1w1JB7JTplPgfuGVcan9S9gl6dXVjvDMSsADK9g4q2hspD7xy47CVxnY+GNyR2tXYq5JgWSPliGvvus113lRuQdAnJsaCfeLL5hwJGb/TEFSWEkqari6mauThDttCrKCcy5qpbjlAiTW2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yyipT7by; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60978479651so1019787b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 11:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709753844; x=1710358644; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GNGb5BZ7AINJbJgQXn/Q7jDuTAr3ISUOPfFvM1cAIAU=;
        b=yyipT7byMgTy1xWWkm9c8BWhf+0Tah4k419plUmM/Ny+1Xa5ArZq1+uhJRYGpGqD1F
         mHc7/HDPoNbSiEIYUJlT5igXpJ7C3JqLduWmnBXpaLE13DU938CqozHdj7fSm2rc098P
         aZZlRBFwG6iATUBXfi+yGBJEnhbbT+rqxgzQCI+QPQmtlPLFmg2YfircU649bLaZ79x2
         g0H3QAalXZAblrkc6MMGjIcCwtexh8LQ+uzxG6rrHSeBMKNWuOFhJueACsjvYQRds5wi
         HGEq0BvoGsqqeugtrxsx6hKx8HKEZ/DJQO2/lwkpbWANCGhOH0cW9KbXJSLYaijK49k9
         N/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709753844; x=1710358644;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GNGb5BZ7AINJbJgQXn/Q7jDuTAr3ISUOPfFvM1cAIAU=;
        b=p0w8t258syb7SR3WY1JWmoD1omr2lsGADD8o2oW/dpSUKk8rO/J8WvMuw9eArbOpUO
         TaFrJyt48B5L1Gga8Yt6dr64M1M4h+cs9IAWN/DnMsb/otpYDibLESVRVFdRj1MpuLxO
         lVcBfClbr9MqiQ/nikQzulsBvcFn+09hNSksTDhUD5HLXfxypPgOTf8KzJDGUlB+CemL
         EFmW5MD/NgBa3V1+Bj1LZZTfFtuS+Wzaa42voigZm1UCx7mIhBwJJ1tl+Fh/ZJUp4uFe
         MjsaFmh3SbYNRmHL17+IXpfXn1cDwm1GtMaFdQDCHTP1onUsjOELkYYmHWWQ9DYkZfRc
         Bg2w==
X-Forwarded-Encrypted: i=1; AJvYcCWvzuBiwEEPaBwvMNuKIyc+FcRmQBhMvjpBnRWPfZRdOGtJh7VYSEXlR+l0hywNPyZPT+Y85wwh86x6ggqJusWsBlp2pjdmtOwCa3t5
X-Gm-Message-State: AOJu0YxhfSXyekhzac09epKhy+DKG2ANIbWQlOE4yEU3dci+MNal37it
	qxk5AIyRT1qR+8KLCj/sotqNS19E2HH17d46xtsprSVaPnUw36Vr/Ug5WoirrLnTx9dkDH/DH73
	p+vXfvQDciPfxH9dRPRzJ8j3Li66TnHc5FJrVAw==
X-Google-Smtp-Source: AGHT+IHuei9cSteH/A4mQ8tGokXyI8WejeGtf2o3u3B0yT5hvLrRj3UV5f5zbG98ZxwHbe98Gp2+giMbUEY+VqeSeS0=
X-Received: by 2002:a0d:e8c4:0:b0:609:845a:4a89 with SMTP id
 r187-20020a0de8c4000000b00609845a4a89mr16100721ywe.39.1709753844667; Wed, 06
 Mar 2024 11:37:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306193515.455388-1-quic_abhinavk@quicinc.com>
In-Reply-To: <20240306193515.455388-1-quic_abhinavk@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 6 Mar 2024 21:37:13 +0200
Message-ID: <CAA8EJpqATJdV6f7Yi4gDeSpmgd45TUxqFmtk-nniPe6EhtFtXg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: fix typo in dp_display_handle_port_status_changed()
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, dri-devel@lists.freedesktop.org, 
	swboyd@chromium.org, quic_jesszhan@quicinc.com, quic_parellan@quicinc.com, 
	Rob Clark <robdclark@chromium.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 21:35, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> Fix the typo in the name of dp_display_handle_port_status_changed().
>
> Fixes: c58eb1b54fee ("drm/msm/dp: fix connect/disconnect handled at irq_hpd")
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

