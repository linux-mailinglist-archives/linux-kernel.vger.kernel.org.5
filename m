Return-Path: <linux-kernel+bounces-153477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE698ACE8F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6241C20EB1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863C514F9FA;
	Mon, 22 Apr 2024 13:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dpHL2Hk2"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EB014F9D9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713793442; cv=none; b=K+Af5QdTVFK8r6e11Zs6qEKsZoJOv8cMfSXAusgjFMg1fhUQKlDCxI81F9RZDvEb4KaRMF+zRyvI9+dEBFVcxf8eynn4ersk9OTBITLK5kwV4StDvNGSDFbQZ2RkcA9G0UserwtM0eyu9bi0bOtpI8EWliLi4SVYPl6tdt7AP58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713793442; c=relaxed/simple;
	bh=eLwGpBWNSzsKehoMyzaBaeqO5Km6GsohfpkHMeO3sMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JR3+cVcQusYppjEfH1B+Aplrb+s310hkYpNyKkzeY5GaUlyOjFiG6ip3baOmoNneIzr5YAO9DhTMUVQYHs4Ff5ONS/NSxGLGfqOO/xjkjI8vlwSecciAcaqx5OrGoaup3CY5LzogLYCYR3xcYrrPh3RtdXCmIWgK8oPkn6a7+Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dpHL2Hk2; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-343d7ff2350so3290122f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713793439; x=1714398239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IyhHpXfSBoKLASPLnhxuYO1fMBmMIpkOZFN42OM7jY4=;
        b=dpHL2Hk2vy25O4ofUjsgNOe5UUbuAu85JLHeohN7YTIMNGPjL3yrS1bhR1QASLLFzl
         fbDLeVp12ikjlreBT0KGHd3jQ08zLwEHZY81zqekONw97q4dugfvDXS99xHZwdj64Cj4
         fIDr8Cbi+hsgYdcDwgDraLN94xsmEixd2xdRDw1ayMStnUXwLWJ25wfhAQPSmNivjH0k
         tB6TIZbOlrAVuMvcBk2W7fuGg/hXbB0bl3Oav+LDzvpotKHRXVxxQBBrFNd0nf6myirt
         xbQO23PI+f1bmtWOBE885B4LHwrKCHa//SEbdt3/pZdse9U43csQpfMtFIKt6aRDcJTY
         WSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713793439; x=1714398239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IyhHpXfSBoKLASPLnhxuYO1fMBmMIpkOZFN42OM7jY4=;
        b=PTfDOiNl6n6YTPhGLX7ednfNOret1G4aXNUuy2l2xKSzVcYK/d7asPKBuXvjTYeRyq
         cmlLBjIsn1Bx7esZaaRATdoA4WdVhAHL+2Fo88BWgAHHZYAzrI8aQLksfXZ949e661Pf
         zESlJmkLi8hErybGz12Wg1jjgKjdGkh7HjV/DLxnh+FE++DzaxezfhjilXIX4rLVFQv6
         RwOUxS00yfI6mnxMLqxDsbmFGIxh/YlGzczsYpHwDFJb7YVFLillGbp1sAP8yIkGLEew
         isDSy2jlfoe6gslDzYdfEtbRACGR1lwga2365HgNZdt6MSMs9XXCIjsxEmYKLX+Puzoh
         vboA==
X-Forwarded-Encrypted: i=1; AJvYcCXl+wqiwelrT/tLcG6n1onJFygJtoxvgqprWn5VgF+m6ND1sDtqAlnDH9xIGJPiWg5iz4W7xBgierbVrH2bGGYQW+cXDHYYpfAqWpyc
X-Gm-Message-State: AOJu0Yy/OyCr2WPRaKhcRs2GO4eS8h1uDU7MunKdb5to4kVayQm3bpDG
	rE82lpAC6D7IkLzE40Dr8bQhakvcGY010ZuWSjgTk7NA9XSc7qix8o6H6Je3TLk=
X-Google-Smtp-Source: AGHT+IGVKGiL+8Ldo4qtKC5/WdzouQLf24IRdTEX/wcJBZuyxLhla2b8gT7u4AqyanBsHU3HdncymA==
X-Received: by 2002:a5d:69c1:0:b0:343:ef1b:9f69 with SMTP id s1-20020a5d69c1000000b00343ef1b9f69mr8121800wrw.43.1713793439531;
        Mon, 22 Apr 2024 06:43:59 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c4ed200b00417d624cffbsm20731069wmq.6.2024.04.22.06.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 06:43:59 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: broonie@kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	lgirdwood@gmail.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/4] ASoC: qcom: display port changes
Date: Mon, 22 Apr 2024 14:43:50 +0100
Message-Id: <20240422134354.89291-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patchset adds support for.
	1. parse Display Port module tokens from ASoC topology
	2. add support to DP/HDMI Jack events.
	3. fixes a typo in function name in sm8250

Verified these patches on X13s along with changes to tplg in 
https://git.codelinaro.org/linaro/qcomlt/audioreach-topology/-/tree/topic/x13s-dp?ref_type=heads
and ucm changes from https://github.com/Srinivas-Kandagatla/alsa-ucm-conf/tree/topic/x13s-dp

Thanks,
Srini

Changes since v1:
	- Fixed unused variable warning.
	- fixed warning 'break;' to avoid fall-through

Srinivas Kandagatla (4):
  ASoC: qcom: q6dsp: parse Display port tokens
  ASoC: qcom: common: add Display port Jack function
  ASoC: qcom: sc8280xp: add Display port Jack
  ASoC: qcom: sm8250: fix a typo in function name

 sound/soc/qcom/common.c         | 29 +++++++++++++++++++++++++++++
 sound/soc/qcom/common.h         |  3 +++
 sound/soc/qcom/qdsp6/topology.c | 26 ++++++++++++++++++++++++++
 sound/soc/qcom/sc8280xp.c       | 14 ++++++++++++++
 sound/soc/qcom/sm8250.c         |  4 ++--
 5 files changed, 74 insertions(+), 2 deletions(-)

-- 
2.25.1


