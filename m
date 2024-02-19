Return-Path: <linux-kernel+bounces-71313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDFD85A367
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E288A1F232C2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E7D36137;
	Mon, 19 Feb 2024 12:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DD/0soRE"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A55435F0C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708345855; cv=none; b=tCpi2O9BneosblinW6pvqWqminvJF4f/F5dM6xc39BBILdVfbPFtzJUFM4bQXMFw6Xq9Kg5VG+92+/MKA3W/hS64bPLWnLVQcf+iHM13XdEQ4eJVqzaHpP9Pg216/ijl6XWvtZtTEG3K6gS15BaUvNvLDM38hYumJTekTQWf8Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708345855; c=relaxed/simple;
	bh=jeszU7cS6hiWuSbHa6Gl/NZ+4dTstY0j8dyZDzSMMHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AMaRI7/ITi9bjW18nRehRSN9wQIqOAHycuoWWidt1MErnCNaEU41KSH5O6CV9WS3PmTkSMltaw9H0qBQdnYcrCH7DVJw9PUnZG437Z7wg3HtUz+dCftJzFyLVdSFHQ5G9LjkL/vGRsfsyILpzF1WadKNCoBRo/xgG3ZCCjNtuJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DD/0soRE; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-511570b2f49so4361595e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708345851; x=1708950651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjMb4d1hbiL9rkEx3BrswRg3MQUneLIxmtF5Ztvz0jI=;
        b=DD/0soREgkRoEVHbH3uBDuiSZYSKJgYJwTrNnESgIEibNkh05r1Zjxo1rs0cGdBif3
         /DchscPfxdI8KzJ/ld5j7Jei2PS0wdIgUSgwLv5Y46akKVJW9/KxkajJW77h3GHxAdz5
         aJhXQaoVFzTazdQuOqp42bHh81C2oskR4ya5kwW8o9JmHdHbumxtuNmlrFKjtWSltGbO
         fNIXsdO7uOQC81nvV/s8STrBxmftNDgHuXN0eBb7vZboNSULkzXWO4TqY/YE3dGUk65I
         aGq6V6j2COHf6DW2fJzaOtV3N40tIDNDW4qTxSm2l/J9xLIIopGJHaKCAFfxlG7oIy8y
         EB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708345851; x=1708950651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjMb4d1hbiL9rkEx3BrswRg3MQUneLIxmtF5Ztvz0jI=;
        b=wUSZeqbzp1UXb677B6j/DPh2C7LE1+J4fEImG0W3UToNoS1o/H3yKmT9KzHYXMAdxK
         uWkCPTZGOMESVTtU+VTXPjqS+7aV1qDkna7Z4zVcJc3GIfPrVF/vXwtHa5Ra1Dsrgxo8
         FCFEHugViyLoPRgk88q4KvYg10OM1KC6+ohT5CSEQOdtNf2xtadhzzKDa0bNU2/kR/da
         1Lpk38VZAbPW8FLOBC1yni45iBicWGdkjFi6I4OY9dK5XI4LGnmMhoogMBfPGG6WEVfZ
         ehAwX3oHxrSNga2cD/EXzC3a+va/ZQoulJyifpK3eVPDqVrYOGQB3u1ScxYPL9d1IjhV
         LrsA==
X-Forwarded-Encrypted: i=1; AJvYcCVHpryLFHCl+99mt0rXHb66F/mMMXJ2caw56F6Im1UWcHRik9l2HBtIg25f+ywWGcRqR4FtqV0QOQHnO6aPZZzrGEV812yYk/S5503p
X-Gm-Message-State: AOJu0YxboPOu3PufD9E1Pdsfnytr8+9RnBDXgzC7YlwKpf6wfnhX8vpH
	Ut7C+JroNGUACgEXq+pyUb0F9icEbwbkmgehNUFkXhhGf1H9M3nPIAOBm6hl100=
X-Google-Smtp-Source: AGHT+IFsnM5T1SLVsoU88JG+DcwZETnLSFkjv32tNAhdISToncKjt/6wK4uHEKC7yxoH4WxJY1IvhQ==
X-Received: by 2002:a05:6512:b86:b0:512:b39b:9768 with SMTP id b6-20020a0565120b8600b00512b39b9768mr955071lfv.31.1708345851583;
        Mon, 19 Feb 2024 04:30:51 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id i6-20020ac25226000000b00512bde4cddfsm90466lfl.148.2024.02.19.04.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 04:30:51 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Marijn Suijten <marijn.suijten@somainline.org>
Cc: linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dsi: Replace dsi_get_bpp() with mipi_dsi header function
Date: Mon, 19 Feb 2024 14:30:39 +0200
Message-Id: <170834569503.2610898.3555817415070936483.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240204-drm-msm-dsi-remove-open-coded-get-bpp-v1-1-c16212de7e86@somainline.org>
References: <20240204-drm-msm-dsi-remove-open-coded-get-bpp-v1-1-c16212de7e86@somainline.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 04 Feb 2024 18:04:39 +0100, Marijn Suijten wrote:
> drm_mipi_dsi.h already provides a conversion function from MIPI_DSI_FMT_
> to bpp, named mipi_dsi_pixel_format_to_bpp().
> 
> 

Applied, thanks!

[1/1] drm/msm/dsi: Replace dsi_get_bpp() with mipi_dsi header function
      https://gitlab.freedesktop.org/lumag/msm/-/commit/99d519fed75b

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

