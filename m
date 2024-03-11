Return-Path: <linux-kernel+bounces-99433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEA087883C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9846528374A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58FE57300;
	Mon, 11 Mar 2024 18:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPAf3HK6"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09E0200A6;
	Mon, 11 Mar 2024 18:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182730; cv=none; b=ThCYMqCrMaZgdiLap06Y8TRGA1w919AwlRZJcEisIt0IHGuwhExlh9vDU1mLH0VZJbORp2Q0my6SXTgW8QGrXeuiffDiHdjkLu3vU01DUaylDEfuxRYrlx2JURcwy3LjgPEsT6o8/qCY6dYQb4dYJqhDQ40jFYh1xHn5QBIcTFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182730; c=relaxed/simple;
	bh=9xm1lqYozJ2Q4DQNtfZO4FjYrrfBluZ5j0bq80UQI/A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CMEU451z3VNFx+za/ikhwPeooLr/A4dU+14nYyITcbXWqro4xfqtX2g+qmaGaq2BlPAN5M0uVeaM0gJFILAe7Sb/de3ctwJtDXHtZf8R6tntOwQq8sqLvHgpTfUObUqngCQZ1uUq0nsm/Re73eOhO4tBL3D9Ig6S8uan3NTCmBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPAf3HK6; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33e94c12f33so1574339f8f.3;
        Mon, 11 Mar 2024 11:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710182727; x=1710787527; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l74WDjBu+9I6yPlAa9MNJUwmc07TrFP9z9L7VLUK9nU=;
        b=YPAf3HK6DnERas0BMVs0gM/TYzJAr15eR5RLsCWw4UolRXL/rPikZv0h18kEm/6/Gb
         JKwGEe4t1eX6BuKOMIVzOXTgTiMhSbJKg2UQCUYKVnWnzJzVZM0PttWRxrTRxTioqzte
         suhToWmgwhjl6Jt63+K+7Cx+K59voE+7arHZzjy5RQiv56BL2l3O2dBVepMqjjVs5kKl
         TOOolasv9KuXIzFaoEiFkR01sgJXtsDhImJbgFukWq+/CoyUZIomLMo4w1P99sTHaWcR
         AvaBZZCJU487IeRND4TeCBXPswi7ECEXuIfiD5vvVaBunXZ167OgA73knt1JCJ3T80co
         eNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710182727; x=1710787527;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l74WDjBu+9I6yPlAa9MNJUwmc07TrFP9z9L7VLUK9nU=;
        b=XcxLnQl3PmWIB8R8dd53IUNsxJ+WXCrHyuFM98xiVqoY2VPkrka0TFw2P2UqNVEXIv
         /0zJ9t9SKqjf+VUn1dfnFSB8i0J1No5wV0kr3LQg/Sxn7VqHxfgMs0tjpICrL8pxTqcX
         oPY7Pq/5WY1cqzcerFZ5hDsFKRBF5EFpYkVYw/wTZWN77Tb4qvHk/feNOqaioI8n6yj9
         tR9TzqP5HxpHC2uvIYdGU/hlbt1g02+6OKAFhc1wI0t2MO/F3vAHNT320aUbM8vdhgQg
         N/+iut+d25zmGoW5VhL1H58SHmEgFxmw1GKKzFvQyadXwa2+P+ydyNULBDzMlK/mJMDU
         ueiA==
X-Forwarded-Encrypted: i=1; AJvYcCVJOsuuWXSJlVwz84NN7sd3W3BGfTTpy3Mpzk7YOz0kq+bKY+WnbmQse0yq/Q3CJ8HTVg5gsFJw2SsC5SjAic6Lq/zkl7V9r/XXyAJrx6IQDvAKRyr4FTmaWUSl4qwFFHWV4tsWW1PC
X-Gm-Message-State: AOJu0YykMKKcvrn1jk3Ce8Z4psIFMXLKcbmD1XWoIJ2weFBeinLXuzlm
	vHrsP1H/AumBjxKo1KzgMdRXiAqdYoGXlZz+f/woGQ80c1SYUWVV
X-Google-Smtp-Source: AGHT+IH+numVysLS2NubI1tk/3R4g5ig7yCmWUjxwfZ17CiPmqsqLqsoPGyLe/EW7iG/HtwyLvZh6Q==
X-Received: by 2002:a05:6000:230:b0:33e:96ba:2d48 with SMTP id l16-20020a056000023000b0033e96ba2d48mr2008411wrz.57.1710182726844;
        Mon, 11 Mar 2024 11:45:26 -0700 (PDT)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id a11-20020adff7cb000000b0033b48190e5esm7012080wrq.67.2024.03.11.11.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 11:45:26 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Subject: [PATCH 0/2] clk: qcom: clk-alpha-pll: Stromer register cleanup
Date: Mon, 11 Mar 2024 19:45:18 +0100
Message-Id: <20240311-alpha-pll-stromer-cleanup-v1-0-f7c0c5607cca@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD5R72UC/x3MQQqDMBBA0avIrDuQRGOgVyldpDptBmIME5VC8
 O4Gl2/xf4VCwlTg2VUQOrjwmhr0o4Mp+PQj5LkZjDKD6rVGH3PwmGPEssm6kOAUyac9o9If6xw
 5a8YBWp+Fvvy/36/3eV57fkT6awAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan R <quic_srichara@quicinc.com>, 
 Kathiravan T <quic_kathirav@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.12.3

This small set contains two patches which are intended to clean
up the Stromer specific register offsets in 'clk_alpha_pll_regs'
a bit.

Based on v6.8.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Gabor Juhos (2):
      clk: qcom: clk-alpha-pll: remove invalid Stromer register offset
      clk: qcom: clk-alpha-pll: reorder Stromer register offsets

 drivers/clk/qcom/clk-alpha-pll.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
---
base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
change-id: 20240311-alpha-pll-stromer-cleanup-01b577e75264

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


