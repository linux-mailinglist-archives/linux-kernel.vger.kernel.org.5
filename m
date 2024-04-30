Return-Path: <linux-kernel+bounces-163633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9605B8B6E01
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C72FA1C21EF8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6FA127E3F;
	Tue, 30 Apr 2024 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zbhIC8EV"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5903B127B66
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468629; cv=none; b=INeTzndewkE/aPYsgzctZRncM8XOf/S5jtUB4Ter5mO5QGL2vYhOfcfCcZBOMGSUaEaeUl99oSyTI1FWXklx/ehfcKd/6xaOfsFvpEIVshNtMj8Gv6Q0+nghqbXdaxpNttloN3U2lWiAEzCxUT96KGvc5wC/00X/hGQ9HgYnq+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468629; c=relaxed/simple;
	bh=s0yx1qau/+zk4mee9o4EH1POhJvehPsTVJGZPyUGpw4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lz3tnlORgwx2dCV+dYn7VWr4TLVDq2ym+ZiGJ3ofsdPJLGxW56r1ZJwZnDNcFFAJPLgGil7/kW/dRnIyy7BGr2u13I7yJCXWaygLMwqpYBZYAC5SQOjXk0XaudCf4V8iY8bJEtES1xiEP+8SlrgJLyAXY782tAWkp3v9uwLchwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zbhIC8EV; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51bae805c56so6306150e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 02:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714468626; x=1715073426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PawZZp+34eJqjAmEpUy1c9FrLXAHXmDkiFpfpAXaMIo=;
        b=zbhIC8EVGRFlDV/uNlFBjtQlWEGP6z8VYwu16RZ1DncsiJiUh5NStz45n2YBD6l3Tk
         5NaGPAGk4eVKwkUSKDKS0BPV3PdisR4Ku8SoGnVENfQlzSuIaFv+P8wkwv1efULnVPQv
         3SYlwaPEvLC1EhW5B2bpOCym/LtMbupApaj2bF11k8DyVeh+elMt5V0Nqa8yM5LNCQ7p
         Jd+HD5SK07D31kjmAX/bohrPVKb+HT2UJN6Qk/JOVyAOTWI9en+GCspslbOWSVho4UCb
         NVPFmO+tMP59g7u8Sd04W4i+ugUJj5RtkoOxBmur506jC1wPicxcMoKmmaM+p3VGMH0+
         MVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714468626; x=1715073426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PawZZp+34eJqjAmEpUy1c9FrLXAHXmDkiFpfpAXaMIo=;
        b=jQOkT3quy8Oke2pT6u9Z7Hw2KuX89Umf3fp7wZsV2jmlAtGSl0jx9Ke6/3LRtRlxCN
         53wN/Ph14CWWKRnT7xBbUuUBopiy6/mODKhM1FqoFQPjuWTxL3p7d0UeE4jSoTKK+i3j
         Bqdk3fsPa/QkSOoqEW5c0JP4zFYTOVQIeX3V6cRICBdhP9Cwkrafjk3D5XJe1pEia9+0
         Aznl/e6LcuKbSb0c0697wJZKjhLqbFi9TOEvqZbvy1HDetVfDkof9iZXR9FXfVsNHvBX
         SCYhbjXY/BegLQnhq2VgxNWGHvmG72/FyfXcIRHq7wu5yVVSNAbwGTVYTrU8hjl8c0ip
         qqEw==
X-Gm-Message-State: AOJu0YyvRV1yNMlqNvLkS4/nf1UyakYyF8UE4o2JMu/ObHN5t+ssaBJD
	uOf0YhpoJzq8GYfCYS2aPO1PJ8akD4jZDAT6e/3/OrKgDPuAJCq/MZyZtgU2y7KHTQH5VsyXm2u
	Y
X-Google-Smtp-Source: AGHT+IGRLriwH+LxvVdfGjZ/nHvBOGCGsePdPc9XBzWYOKAD/QKTKJ/OWLKfCdj/aPfaWxVAteuLQQ==
X-Received: by 2002:ac2:4c2f:0:b0:519:63c1:6f2b with SMTP id u15-20020ac24c2f000000b0051963c16f2bmr6494956lfq.54.1714468626562;
        Tue, 30 Apr 2024 02:17:06 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4106000000b0034d8b0b5329sm935513wrp.87.2024.04.30.02.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 02:17:06 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 0/3] slimbus: patches for v6.10
Date: Tue, 30 Apr 2024 10:16:54 +0100
Message-Id: <20240430091657.35428-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=708; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=F70IAvLlsF0cycL+15KW5orMR4z2gLUiWLKstukUj7E=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmMLcFDvKZazWg4lJFDZP2N/mwMetj3BH4UottB Dl9auLoNliJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZjC3BQAKCRB6of1ZxzRV NxddB/4/7KIfYgg98hYDi8Atk4k8lNS65YbkR/xJnd5o1v513w72KnuYV93JusqzJ5lt7nUWAtf iGI+dZ821TC7iBDE7JjbR0aPKwlJ6it4w+az9GPHdpSQ3ZPSG6SlyHPqpUJGMHlUMQhf1nhgP2B bLPdCvyjUzy/4a4st4Bz/3mOfQFTDjK0OCdJDOIPOH2ytnZTFJq9s4zqmFTMwepp0R/K3y7wRJg /UgOHccngSC2SUVLw5vJik1ENX4CsPWzrwZJdAfwAPDZAZJW25i5lQSs/pl97cVWZZX9eDAlsj4 HhNYFfEaDAls6c9KVWu/+IR4Mj07lhu5BB450sCVeOlLpvpN
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Here are few patches in slimbus for 6.10 that includes
- fixing autoloading.
- coverting driver remove to return void
- reduce suspend delay

Can you please queue them up for 6.10

Thanks,
Srini

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Krzysztof Kozlowski (1):
  slimbus: qcom-ctrl: fix module autoloading

Uwe Kleine-König (1):
  slimbus: Convert to platform remove callback returning void

Viken Dadhaniya (1):
  slimbus: qcom-ngd-ctrl: Reduce auto suspend delay

 drivers/slimbus/qcom-ctrl.c     |  6 +++---
 drivers/slimbus/qcom-ngd-ctrl.c | 14 +++++---------
 2 files changed, 8 insertions(+), 12 deletions(-)

-- 
2.25.1


