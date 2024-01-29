Return-Path: <linux-kernel+bounces-42640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BADC840437
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50F961F2227A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94024604B8;
	Mon, 29 Jan 2024 11:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q8b5OvvT"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394AD5FEEF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706529147; cv=none; b=Gx3ZRP21QBhjoKV+eMix+miGmQM/2ysjaXv0Ga1W99zr2oIQEFstY5CDCuLPoPoPZQbtNvrQsejCs5VyLpoQ13VXcEcy73hqxV3DHjru/x8Ckrl4gBXPqar4YSBglHQgdh8VS7cFuuedmGbs1dmkz03QLH1DJ0eEnzgl1sg+618=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706529147; c=relaxed/simple;
	bh=OEn344ksEcO/KPuz03HGzt0LbiDtkFUUnDPggKZSm1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WzcZK2QOkY88XjB2omEQyvhP1UcRmVvZP4KZsrh2iPM2QsYWO6kyrPn3JFRVHcOIrXCCSqdm/gpSnp4pRmbz1nPIEJWb/3F+LVTFrEM8Ppe+cpR5SKvumFFQmkq7wFR+Mzh/06d8h9e/tdTtGmj3IrVGrYUTL2Sx7ElxukigRCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q8b5OvvT; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55a9008c185so4469245a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 03:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706529144; x=1707133944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDGYECsDtIdBMjd3oPDwhe2eE52MgTh9xNyzExOhMAs=;
        b=q8b5OvvTa9f/RWb3NGXpsnBIN2ZgiYeIVf9OiHYDkvGk3hdMutIWF1EEh0rhj88h/p
         2qFgExwNkb4oulqKFs6czWzjC3cXWChiC4JqaY9jVxKw357DBmGHT1P0g1AAxWqBJz++
         OXxva5J+BnhHXYQ4Q93HfBXgCxWOSyp2I9XkdWG4rKz0F2PB35O9EtOcqN/AVGXGQiRx
         luSDgjkBSCfSE61fay6OFiwbQnqLIPzqXGwqtqpoIKW64LIIAfs0umYxmAKR5V15tB3w
         GRtsA6znNpxcFUjHdBoGIwkNq3Gck162ZvRj6/ykFJkIZ4K39HwMbOdA+7DLdfDjkd5c
         sEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706529144; x=1707133944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDGYECsDtIdBMjd3oPDwhe2eE52MgTh9xNyzExOhMAs=;
        b=rYUlodLlgk2v/NP+xZ/r4C/gH0tumvFgBihbTkIY0DZUfb9Q1P3nAI0hLhfKfhQTHo
         7kZRptIpPkQfaNvKUwUPdjoM5OZnHF+/8jkT7Y6g0i3Z4z7c0eIdVJfw4HvQBTu66D3W
         knLubegX0CIqIHjGaFesCt5gMrWpBBEm1DnG44MzN3xcuEP+ceSP/a93Vt03U2U+P8V7
         8ypxapPfQX9mzzvL/iYQ9zxbVtL0iCPZXmj0V7lU0yDeEvLZgxd2xFofrR9r/GWej/7g
         Wt1DW4UM/bx/ZlnErjYe2Ru6hySnHaEXy8Ybz46ZWgbDUm1dEO9WcBo+NAHBJtdKjSEe
         m7cQ==
X-Gm-Message-State: AOJu0YwKXL+Np4ka7IPblZ+4muSJD5tHZKv/PSxvhYm7YEZ3vuNKe9KU
	q4jCyg1PJSf/D4PSvyKBMqQOYKkYNg3dKqvGGFJ/qPX+p2LT3xlQDbX+W9veED4=
X-Google-Smtp-Source: AGHT+IEQNLjhCr6Kx84OvaKLsougPYvC2/GgEyXcjNLbL1aCexWmd5xdUnkglSvejmamCtxIHbvojw==
X-Received: by 2002:a05:6402:2711:b0:55e:b30d:d845 with SMTP id y17-20020a056402271100b0055eb30dd845mr6121423edd.17.1706529144550;
        Mon, 29 Jan 2024 03:52:24 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id ec19-20020a0564020d5300b0055f29ececeasm19907edb.57.2024.01.29.03.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 03:52:23 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 2/6] cpufreq: do not open-code of_phandle_args_equal()
Date: Mon, 29 Jan 2024 12:52:12 +0100
Message-Id: <20240129115216.96479-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129115216.96479-1-krzysztof.kozlowski@linaro.org>
References: <20240129115216.96479-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use newly added of_phandle_args_equal() helper to compare two
of_phandle_args.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Depends on previous OF change.
---
 include/linux/cpufreq.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index afda5f24d3dd..3cd06dafb04b 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1149,8 +1149,7 @@ static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_
 		if (ret < 0)
 			continue;
 
-		if (pargs->np == args.np && pargs->args_count == args.args_count &&
-		    !memcmp(pargs->args, args.args, sizeof(args.args[0]) * args.args_count))
+		if (of_phandle_args_equal(pargs, &args))
 			cpumask_set_cpu(cpu, cpumask);
 
 		of_node_put(args.np);
-- 
2.34.1


