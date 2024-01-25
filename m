Return-Path: <linux-kernel+bounces-38829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D7E83C69C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C081F21878
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912FC73166;
	Thu, 25 Jan 2024 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uwIalc8o"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5137E4F5EC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706196677; cv=none; b=ZRj1KkwCJ5f30DtmrSBxZtWAbCGjuzXhsIQdMmHPsVKY7bwArgY01eYv91hu+8RExHFty/mS9jzMeRI1lURQKP9iOVuJpyksIhV20tsdnwrPeEkKyGpHncNVMnI/B3/4W76tuF2WKmOyEYe92FNAaVkE6Rb2ID/fd9EhmxL6j9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706196677; c=relaxed/simple;
	bh=JhPsd+XYVzYVuRnn7sBxx/KvgxV7WjX72z6mVmTkqhk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tMOGTPyDjesBP3mwldhZ0HpOWt0FxH13P1G4C3Cu4ordlx/TIcsHTbUuPkKFmCaShebkTkWfyVVM2+ohKjj5W4ey2xcYO5ARZcKTXvOJUkC8JVDHfSp/IQ4bR3A4YNTwLJNWPWYfBsbniS68mXtxWkXsBls9Zq5hqrTa2z0cm4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uwIalc8o; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ddf05b1922so5138733a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 07:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706196675; x=1706801475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NYK0H+CKAoklRasOR981W3Bz82GZLK+0/kJxDe4J3gw=;
        b=uwIalc8otI2cBDJW8UFBJV1fEtqsLbgcBB535e2mMRgSL7x54dUgaoghr32lTh6Xa0
         SQfDVMKIi+G6F+MkWFo2oZCXhr+MpzMgZVCNLdznBk53c5kLWb65kPcTIXf/ERHCN+dS
         ErvXNEbr0MOBg+XuI571nXTQVbHMVOwLLlshZMYr5lpBsW4N34CGb0OvxGEe2waVcOP5
         l+kXl5D9vm2+YJwvkwKhVgll2HTpcZZnTZfz7qH920Fwe1qYyvlZoEoRpr3pW8p6R4LJ
         MR9p7Zfq9KdpDwP3ii8f+IB1P1CSCEEd0U/jaja/POEAqLFi8SZ2Ci9l7Z/GGUf+70G3
         8ycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706196675; x=1706801475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYK0H+CKAoklRasOR981W3Bz82GZLK+0/kJxDe4J3gw=;
        b=nuzobKQ4MBbRECSNOqWeXvLIjqNzoVrtJHDoNKNBe5uRpSmcK9KXDmDqVF0zJiNL5X
         iPYciAunpYYecA6Av5YqOkIZl0QA9F6j6uJDxypMN4/oCI1itPSdc+avuQHq8APKXnsY
         22Yt/B4Xjii5BAfosdc59e1xlU9qEdwsQTOp6ZLaWaLrC//2pIaACfA7d8EZrUgo5Aai
         Lb7mRgq40YZoqQh1Kad4POLMvNAZro/GgUJ7nCXDhbweEeVZpbBZrZzNciJSKLMhZTTz
         9sBMGCOdSMqOODi9qXQJ2gZEyT70y7DLjiidp1ylAvdvyiynnlw42lVne19EYRZuptSU
         8fEw==
X-Gm-Message-State: AOJu0YxwyVBoxED+l/rCJ/tODvIYeNSqp4fw5gfClI3d3sRPyVsd4jyS
	kPfooNJxocA29ltkOM36mggOQQthA2j4cQ9ik7PEItXI/7zAVfkKDTvIXhOsQbM=
X-Google-Smtp-Source: AGHT+IEQzLbhD+YKInHXk9DGDwmHvSeNxQb2A7kdlkwqPHQz4iFJ9kjd/DWCpqFl/DPRheEcMOOZBQ==
X-Received: by 2002:a4a:da05:0:b0:599:c127:a5b with SMTP id e5-20020a4ada05000000b00599c1270a5bmr1010116oou.2.1706196675383;
        Thu, 25 Jan 2024 07:31:15 -0800 (PST)
Received: from krzk-bin.. ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id d14-20020a4ad34e000000b00599f1741917sm63973oos.43.2024.01.25.07.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 07:31:15 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 0/2] ASoC: codecs: tx-macro: correct TX SMIC MUXn widgets on SM8350+
Date: Thu, 25 Jan 2024 16:31:08 +0100
Message-Id: <20240125153110.410295-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Changelog in individual patches.

v1:
https://lore.kernel.org/all/20230717140138.201745-1-krzysztof.kozlowski@linaro.org/

Best regards,
Krzysztof

Krzysztof Kozlowski (2):
  ASoC: codecs: tx-macro: split widgets per different LPASS versions
  ASoC: codecs: tx-macro: correct TX SMIC MUXn widgets on SM8350+

 sound/soc/codecs/lpass-macro-common.h |   7 +
 sound/soc/codecs/lpass-tx-macro.c     | 666 +++++++++++++++++++-------
 2 files changed, 501 insertions(+), 172 deletions(-)

-- 
2.34.1


