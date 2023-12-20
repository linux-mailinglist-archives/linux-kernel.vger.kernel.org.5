Return-Path: <linux-kernel+bounces-7491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F80581A8D4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61E8C1C22BC0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFED4A995;
	Wed, 20 Dec 2023 22:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hr4Onva/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB064A98E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a2343c31c4bso15112766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 14:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703110377; x=1703715177; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WbE+p+rcyyFP+eEtMwxqlwbKKm3YVPbvUnctIfiDxV4=;
        b=Hr4Onva/aMYa64TV02v8sEKnKOa9dU62ufHv3yjaq1jplcVcisLWqPTnod6NLBmyFf
         Oj2XWDERSnbqEhbSHqPfRL+xOo0q4I8ZxNh4PksJmQ7akJXXsFjZJ6H269HHJKBhRZ3/
         rSqRYkF0PHYQLSfwsHb8O5J1vcFEyhzJHTAjthYue2WHfZQE93GV21d9G19rMnsWnre/
         +8kIGjaiGETubllpaBv2Z1E2IVgOfhaTDJO3L/47jiNzxlF1z1ODi/WuTDshXNx8EsX8
         1R36bcOCsw9trvSTscRUDP9VnL0o9rKC9fZyQmmm62IPKdmS/2bdlUba3ugcWnuf7D0R
         LDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703110377; x=1703715177;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WbE+p+rcyyFP+eEtMwxqlwbKKm3YVPbvUnctIfiDxV4=;
        b=fVOhAf8Ju/P0s2EQPeFzBnJJgbLlhQjlkii9ErPtzeif3E8Acot+SzUXgY2FqAAFeY
         glbtKUap45FmqUeDnnDQJCfWWl+EhEFodDjSKe6yx4FvHZ6J1ds0vpl5tIzl75xu1ael
         w5oYeSjFcZ2TPFXuPYjWpCqtNWQu+nzdDGKrtb8sZQmWwy8nrPg+5soOlTwMDEtOkaTd
         /p2f4Gcr0OQfJ682a9/c2fknzGg1LG/8udXsz+qfbXcTsxuYMtpc8PINmBuEYfAMXoRD
         CKQCa4Ay4tEOpjRnT4HSGlFq7bySaSJT9pe0XYaOw38Vf77XYjnN7Ym6qE5QQubB5+rt
         69qA==
X-Gm-Message-State: AOJu0Yy/nbJf1YwTMpDa9HN8y3+JoPuZbdFL5BZi7ADvuKvBcuZnDNsZ
	ZT8TkfrRzOa00CoBIXLsdI1EGA==
X-Google-Smtp-Source: AGHT+IHJw/FE2ewpobj61P+2P9GS8ZpVhAHis9tAoOMOkVKIcEuDOaRMsr1NH5TfHUZOtlI0W92iCQ==
X-Received: by 2002:a17:906:65d8:b0:a19:a19b:4251 with SMTP id z24-20020a17090665d800b00a19a19b4251mr5876749ejn.188.1703110376744;
        Wed, 20 Dec 2023 14:12:56 -0800 (PST)
Received: from [10.167.154.1] (178235179206.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.206])
        by smtp.gmail.com with ESMTPSA id x22-20020a170906135600b00a235f3b8259sm254654ejb.186.2023.12.20.14.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 14:12:56 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH RFT v2 0/3] Fix up SC8280XP idle states
Date: Wed, 20 Dec 2023 23:12:53 +0100
Message-Id: <20230619-topic-sc8280xp-idle-v2-0-cde50bf02f3c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOVmg2UC/32NQQ6CMBBFr0Jmbc20gBZXrjyAcWdYlFJgkqZtW
 iQYwt1tOIDL919+3gbJRDIJbsUG0SyUyLsM4lSAnpQbDaM+MwgUJV54w2YfSLOkpZC4hmytYYi
 DRryKstIS8rNTybAuKqen/HUfa/MYohloPVJveD5e0OZxojT7+D3yCz/U39LCGbKyVrJrZFXzH
 u+WnIr+7OMI7b7vP1oDiMfRAAAA
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan+linaro@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@somainline.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703110375; l=1554;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ARUY1xHpXtNbYJC73kXlyu2iubFsquAhjet7Dqjyorw=;
 b=jEr+FiShAw83HyJ/2AgXX7eCo9PSxs+fd6VLsvmwSxLTtAFYHteCzA7izJM+8hpXXahv2STz/
 KP9ClVfkcC1BKCyOMLzdt6YpWdfFOmse7l+aVQMz3Ri4ySQHP+ZzN9u
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Comparing the data available in the downstream sources with what's there
upstream, it was easy to spot some differences. This series aligns what
we have upstream with what is there on the vendor kernel.

The big asterisk there is that the downstream sources for SC8280XP can't
always be trusted. A simple test shows that the lower idle states that
were previously missing are implemented in the firmware (Linux reports no
errors and enters them).

HOWEVER

The only cluster idle state that's been present until now (the deepest
one) is now barely used if at all, as the scheduler seems to deem it
inefficient or so.

Hence, a request for testing and comments, especially from those who
use the X13s daily or have reliable setup to measure the power usage.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:
- Rename the idle states
- Drop RFC, confirmed with Qualcomm
- Rebase
- Link to v1: https://lore.kernel.org/r/20230619-topic-sc8280xp-idle-v1-0-35a8b98451d0@linaro.org

---
Konrad Dybcio (3):
      arm64: dts: qcom: sc8280xp: Add lower cluster idle states
      arm64: dts: qcom: sc8280xp: Add missing CPU idle states
      arm64: dts: qcom: sc8280xp: Fix up idle state periods

 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 72 +++++++++++++++++++++++++---------
 1 file changed, 54 insertions(+), 18 deletions(-)
---
base-commit: 20d857259d7d10cd0d5e8b60608455986167cfad
change-id: 20230619-topic-sc8280xp-idle-00fc007234c8

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


