Return-Path: <linux-kernel+bounces-24470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A2182BD0A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64EA1B2395C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC33956B92;
	Fri, 12 Jan 2024 09:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EhH7HmOM"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8744E55C1A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 09:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e6275e9beso6002995e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 01:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705051523; x=1705656323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3bfVv8WtMnQ2fP3XkB2eOBLDf/LsCJjP8wfwX/T4wM=;
        b=EhH7HmOMlMI500FvCSNs1tYIqwNUcTYHKojQQCS60nhwLIfhEAPQEJuXKDQAcRDsoh
         4K195kuJL1Kax5yCN03yf896jMcQ1m7949PDudgYELHRmDpHF+rNL6vUVddC+x4qrGmf
         0nFuR4a+LUHFFy8nqxLJycw0eRm0krZbJvqxXNrkPx6Rx6l/ex37WbpfIIEGNoCiyXO8
         95KrfTsKi8KoClPIe+foCeMeHC77830g56nVSx8F5bH0213X3MwbCx9h2wEby2NrLJLu
         XwD+9DpULZq0U42xpKWELUd2JPd+Npg/ddOd33rJ6yYz7ZzjXxk54C+bjoz0G8qwJ2IL
         2xGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705051523; x=1705656323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3bfVv8WtMnQ2fP3XkB2eOBLDf/LsCJjP8wfwX/T4wM=;
        b=N8Q5tVMS/28FNr8/79eMFdsvAn9aCuWf+w/9H15KGzrEQcBv1m1TDsmk7Fl5b5wy15
         cBsNScN0tngJbem/2sCfbTkL9cSc3XO/nQpwsLUG9TD4Iwl1gQmyWjKU3+RtFJiJat7h
         GMB9HiJo3Y2UGQFRobXij+901qOTJoW9dkZb4B6xXz66jEZ8epuefwPRFsyeqcgv87Gv
         HkUGFl79XZuIItEYTyVcYOYKiN4SHfCdAQxckLvSVKDwxaQDKDuY5LufKpZ4n+EZ4kem
         bz40U9nXli9jpujBKLWXk8M4ny5bVWE48RYa71trkqOh3M08fXtmJE0K4wKJrqhR3zyQ
         ppSw==
X-Gm-Message-State: AOJu0Yw2ngp8ZzfGgyOTWtYr6H98BlaywQ0PlA7rNT0D54t5v1qPI5PN
	//TCSxO+TbqDA1lfr+hXUqbJ8K4c+CKerA==
X-Google-Smtp-Source: AGHT+IEMwKZ9XV3E5enGXhcHiQsIucq3Zsj1wJo8Uj7nGouthpJzDE5uay5WsPpo048DpY1o1KYFwg==
X-Received: by 2002:a05:600c:6a19:b0:40d:8881:4d1e with SMTP id jj25-20020a05600c6a1900b0040d88814d1emr550199wmb.66.1705051522693;
        Fri, 12 Jan 2024 01:25:22 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id l6-20020a7bc346000000b0040d81ca11casm4901880wmj.28.2024.01.12.01.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 01:25:22 -0800 (PST)
From: neil.armstrong@linaro.org
To: Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sandy Huang <hjc@rock-chips.com>,
	Mark Yao <markyao0591@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Segfault <awarnecke002@hotmail.com>,
	Arnaud Ferraris <aferraris@debian.org>,
	Danct12 <danct12@riseup.net>,
	Ondrej Jirman <megi@xff.cz>,
	Manuel Traut <manut@mecka.net>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v3 0/4] arm64: rockchip: Pine64 PineTab2 support
Date: Fri, 12 Jan 2024 10:25:18 +0100
Message-Id: <170505150474.933870.7165654280857450168.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102-pinetab2-v3-0-cb1aa69f8c30@mecka.net>
References: <20240102-pinetab2-v3-0-cb1aa69f8c30@mecka.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Neil Armstrong <neil.armstrong@linaro.org>

Hi,

On Tue, 02 Jan 2024 17:15:43 +0100, Manuel Traut wrote:
> This adds support for the BOE TH101MB31IG002 LCD Panel used in PineTab2 [1] and
> PineTab-V [2] as well as the devictrees for the PineTab2 v0.1 and v2.0.
> 
> The BOE LCD Panel patch was retrieved from [3]. The function-name prefix has
> been adapted and the LCD init section was simplified.
> 
> The PineTab2 devicetree patch was retrieved from [4]. Some renaming was needed
> to pass the dtb-checks, the brightness-levels are specified as range and steps
> instead of a list of values.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/4] dt-bindings: display: panel: Add BOE TH101MB31IG002-28A panel
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=baae3a0b10c499d4228514a701602f6fd2a8d6b4
[2/4] drm/panel: Add driver for BOE TH101MB31IG002-28A panel
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=420186db1483da4e16cd5d5a472f511a35dbc1b7

-- 
Neil

