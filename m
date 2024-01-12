Return-Path: <linux-kernel+bounces-24481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDEB82BD2F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80AE41C251C3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1267E56B70;
	Fri, 12 Jan 2024 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cuznrLq9"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99CE56B66
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 09:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3366e78d872so6516400f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 01:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705051680; x=1705656480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NCYVeywthYmIsrxQeF1XaxxekG4gcaUob9s27+cb08=;
        b=cuznrLq9AONq8PbkRzf/s2KTZnbK8OqnFIMmP0KNl9AAycKB5JHftVZzY8UoEgTRLy
         UWKvqx4DQbPYnPQRzDjLVcuZsQwCpYyXkBgnXO/FSroaB4Ou2Kkn3L81ZiOgZk5DNJs9
         zhvjqU3Cc/oAvtHZ91490tOfg19yMu5pagpXQF1ZeevVWJr3hHSLPE7V2/F49n/cZVvb
         m6s2W6GdPEiltpfZMy72+4Gxy37m4k2sAYfoH3Cb1ah0sbQOnPBJQ6HskRacgFzW2K3Z
         yOmndjGSaGMZ6weMvVIl8IEpfdq6jSAaYHPAG+D264spQMQqerK2okFzcOwl01BJg0FU
         SGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705051680; x=1705656480;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NCYVeywthYmIsrxQeF1XaxxekG4gcaUob9s27+cb08=;
        b=QfMetMui7A/ZKAHZacmErE/OMLxN1PoyLjpSDf/teENVR+Apwuxczrb84PQFqPUMnk
         pZyXt781yTx/nzU5xrM/paA26ojbjOqMGC04HTikBdnRU8/EkAxg/MY+OWFqDI6Q0KpJ
         wvLAzSdLIlitF0K6WgrSMu5hrEW6ana8ukOZDgPGik1SALLSBysSu9FOLorFP3p8QUFI
         dWSIEls/CpzOplmF8n+tfGUAzqRfjhPDm7pBERBEhp1x8hDMJf8lhZhsqiWRAnCDNB3A
         5L10aITqm7qGKA2JObwZAL8HRhzFOWW6+YlW+cS+DF33cLQQxf1Y534Qja9F0Ra0imPa
         RL7g==
X-Gm-Message-State: AOJu0YxEa9IF8Yhf+yCiA7u8o4e3eGWHNiTYH16omPmxlT8bczpQQkD0
	La5Hf0oUDXIa2hSu/9/KgxUXr6TUODoV6w==
X-Google-Smtp-Source: AGHT+IHmpnLNrMCfXBpSsxK1XN7TMi6MDCBV+eQHrgduX2+GjPUmROUVUbbgIHe2mBIZvBmditAB5A==
X-Received: by 2002:a5d:5543:0:b0:337:70cb:3eb3 with SMTP id g3-20020a5d5543000000b0033770cb3eb3mr255195wrw.89.1705051680110;
        Fri, 12 Jan 2024 01:28:00 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id d11-20020adfa34b000000b00336e15fbc85sm3324822wrb.82.2024.01.12.01.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 01:27:59 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Artur Weber <aweber.kernel@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org
In-Reply-To: <20240105-tab3-display-fixes-v2-0-904d1207bf6f@gmail.com>
References: <20240105-tab3-display-fixes-v2-0-904d1207bf6f@gmail.com>
Subject: Re: (subset) [PATCH v2 0/2] Fix panel polarity mixup in S6D7AA0
 panel driver and Galaxy Tab 3 8.0 DTSI
Message-Id: <170505167913.950726.6420816428690062433.b4-ty@linaro.org>
Date: Fri, 12 Jan 2024 10:27:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4

Hi,

On Fri, 05 Jan 2024 07:53:00 +0100, Artur Weber wrote:
> Two small one-line patches to address a mixup in the Samsung S6D7AA0
> panel driver and the Samsung Galaxy Tab 3 8.0 board it was initially
> added for.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-fixes)

[2/2] drm/panel: samsung-s6d7aa0: drop DRM_BUS_FLAG_DE_HIGH for lsl080al02
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=62b143b5ec4a14e1ae0dede5aabaf1832e3b0073

-- 
Neil


