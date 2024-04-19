Return-Path: <linux-kernel+bounces-151617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 467048AB130
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A09281BBF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B285E12F584;
	Fri, 19 Apr 2024 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sGcFdBa3"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D169D1E893
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713538911; cv=none; b=XI5Q1Us5YbxaxIvZ7oZZ/AfcGdcCxbLAlKyMXOP5vwMUBddqIYSUCjckpAStgCt57vCLUN5EXKVahOvcYmGHk9q5uxGtnbP7f1L02mpb0XgLtNPN80d9qJAVrxqC2GsNg/1Qswh3RjDFz8gEpByHar1O30+HyBqq9sOoxvexGwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713538911; c=relaxed/simple;
	bh=38u+Wt5Zc3dld0ZUNzGY4xaUgcWnqdvL6LMkBUX2jYs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uR/VNECjmX6Ps5/zOZkWWOpREfr1U4L0eCcBdjlhLVojDI+emTLtR4pPPrPoQOqjqXW8hnLKTELusXT52WoOnOgAsUDgnXDxszugHmRjyPHJz44Jpo26irznDkND2JL6uVPm7qYfvq305MgbnRBOjdC9zOA8czFXayLt6TcEUSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sGcFdBa3; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-419ca3f3ee3so2723975e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713538906; x=1714143706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xKyNdflCXl1k1Bk34C22tLwiygb4fVA2Yaqs6+5ffr0=;
        b=sGcFdBa32zCodzpL8gxpdE6zR7cA+9y+6g1+xoZv/yqX7GyOL26VbyIaRsy+oOsUk3
         1Bbut2wPVPHyfLbct1j7PArq4orbBZGc9KcWIR222iSUTkL7wLnkxdZNsfuaN4AIbhdS
         jA1dSWnqTdhVMMkmIZQS1nzg83eNC2gQ3LNs/5Db0oDdUkPIl3+8JVXNrVt6CAl+sFAr
         Ap09js8YAFEaRtDHi/2+qmkpO/+zJ9I2Fl7t9UNAmGzN/z35tSzUst8y6um+yvnNZ9rl
         b1EYUG1/+7G630RJ/Z69/j8/WWbEvVwovBXB90kkjCycfIoRJ8WuuoI0oR9iHKioTwAz
         Tg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713538906; x=1714143706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xKyNdflCXl1k1Bk34C22tLwiygb4fVA2Yaqs6+5ffr0=;
        b=LFDnja06zcLRpinhI26BVpyVYpSADwOUHbwyp9l/XLEq/nb+h8B15eTWLJ0XOBob93
         vsA+zF4MDlTHAry68jdlPFx0FnTn1/wkGm3nue8C9usx/XbnL53BWX4g4hW7XlnrN2zi
         4rErDisQLXoKzl7UWRYQ3wI8TmSbzq8E/oLBsN7SSywx+Tak3mn81/gs3206VUSPgu5/
         GxQHbZCa7whKhMMHKUK0ssm1lOaxDy9emvHrBPLJ/nQrGmlMQl7tMlkDTzMvbpUAxemS
         kkMc3DaPDRbFhoEZhG9YRDHRyViv1m26BIgc5j20SDqQYnn1IxVMo7jMmAYpd/kgaZ3L
         Z+qg==
X-Forwarded-Encrypted: i=1; AJvYcCURmdHOSF0i6UbDnS/wejob/Og116AwwMdPLIYuPI7f1fDxSuxGhCxCZFxEud8rL1d9CteGpWLVGZrMe0Ve6GIu6W16x6z2/04fv3Xo
X-Gm-Message-State: AOJu0YyzUgpIE8kYULnsv6U1QzFt/+twmThjjDJVZAAXgF0wr0SQ9dCN
	R6oOoqIWVLlAR6YJtCCVRR32dkID1lEKWSHnOmgq02Q84d2oIfk/r6ETgtgVzJ4=
X-Google-Smtp-Source: AGHT+IEmv8ZU3P4FOUWe8jOOnJJzNXxiQc6qjZPMNqbl1hoINJs4ktVsOKqF99wOmcKo+yLUw+QqKA==
X-Received: by 2002:a05:600c:4ed1:b0:418:ed13:302d with SMTP id g17-20020a05600c4ed100b00418ed13302dmr1759763wmq.26.1713538906051;
        Fri, 19 Apr 2024 08:01:46 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c4e8b00b00417ee886977sm10660462wmq.4.2024.04.19.08.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 08:01:45 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: broonie@kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	lgirdwood@gmail.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	steev@kali.org,
	jenneron@postmarketos.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/4] ASoC: qcom: display port changes
Date: Fri, 19 Apr 2024 16:01:36 +0100
Message-Id: <20240419150140.92527-1-srinivas.kandagatla@linaro.org>
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
and ucm chagnes from https://github.com/Srinivas-Kandagatla/alsa-ucm-conf/tree/topic/x13s-dp

Thanks,
Srini

Srinivas Kandagatla (4):
  ASoC: qcom: q6dsp: parse Display port tokens
  ASoC: qcom: common: add Display port Jack function
  ASoC: qcom: sc8280xp: add Display port Jack
  ASoC: qcom: sm8250: fix a typo in function name

 sound/soc/qcom/common.c         | 30 ++++++++++++++++++++++++++++++
 sound/soc/qcom/common.h         |  3 +++
 sound/soc/qcom/qdsp6/topology.c | 26 ++++++++++++++++++++++++++
 sound/soc/qcom/sc8280xp.c       | 13 +++++++++++++
 sound/soc/qcom/sm8250.c         |  4 ++--
 5 files changed, 74 insertions(+), 2 deletions(-)

-- 
2.43.0


