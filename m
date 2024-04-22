Return-Path: <linux-kernel+bounces-153399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE728ACDA6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C534284E20
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3CB14E2FD;
	Mon, 22 Apr 2024 13:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="j3+JlENr"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E4314A4C1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713790851; cv=none; b=k0n9wRLc2FZ1VklZubwzLCcjrz+TCBRkJ1Zi9ZEXryf3p6r8CIPmmzmZ0HwnxqHB4PZuzd9/Ntp4tqf7OrrtIlbcB1IqOYlIhApjfjCCXIHz1PFSNNTVlFsaCPr5Caev8Ch+l3N8KTIw4OuZ/M8obg56xyvirwMxQ1eiIsHcR6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713790851; c=relaxed/simple;
	bh=Yq/JhB+Lrc/miD6DiFv71QXBz/idDrjXRkpufPo8K/0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ufz5ZfUHr+vgwmecxQwjuMINGkUlFIDmAfqrADz0jz8y3lUUxx7U8TC9K80OeJGQZSQslYSP8yGRgjJwIYrKxofmNBo5FYX0t39djxgA1/6xluX+2tT+4G1t5vTb4ErqrsINT7nRx+i7VnFRH5zPxyUVkBvf6RZYzyBwe68LB3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=j3+JlENr; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-346b96f1483so2281732f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1713790846; x=1714395646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I/gyfw9gI/bmdg08KWcL093IxCvqzBUYKqsRkm5VLSU=;
        b=j3+JlENrWQ9AxArq5CDU3nd1hhHgrjJxbST4FXGDSSRF/dU4hrG0UCWqJE5IYDZq/E
         p3I4U+1LvG6k9x8rZMgRIfRQR97TIdsxOJ/eycM6sM6rgiIhcQ3op27v4Q5xaznYYQAQ
         vWX6pVCE3Ut96QVJjUxlSzKxalJCID9dcW308kDbPCWyNmy4ryeQA3PM/NTXmr13w09p
         93zaxWrkdTLdtG4QNNOkP5JH3BM9VxaxzstkeWN25XL2ThBySI7Mg4U7AVack4w6qzIs
         LcQgD10LnboAduLMiBzYNA/3bMKJvLDAllEPZNS8U3SF3HKtQMJ9azEZqNtQjH+fSfSX
         cOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713790846; x=1714395646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/gyfw9gI/bmdg08KWcL093IxCvqzBUYKqsRkm5VLSU=;
        b=UrZ/EScClxxCBI6+lDdbYtlbYmqibmQdQJXpIzUrkXN2Aja+xeMRbrkVNn51fAdjch
         osPStrH2sBpaX/4eKMtbDIcB5gfHLkBKcfRoIwK5M0pdqQvLAVsyMKi2ROtL7cc1Hfp3
         vPcizeQXXN/RDuwvRJX7Y6wchFg7vYMs+7y9C+PJoGvLo+5bloxjBiUiTcKkLnyKsI3N
         hMgGatYTPsczvxpr4PQJwCORLDnwp+5hlYByAD9LLTS7aVbVKtF1ZokWXBjCgNb0WzTK
         Xt4WCw0aUh3wX0wN5ELI8pp/0DAEV0DHkQfNmATZeszPmkNmwQWRMOwxY0PioHyDhKvj
         brow==
X-Forwarded-Encrypted: i=1; AJvYcCXTo9Nvfgr7YT9eafJZBhUUEblNgWXj3cAWRk+JO7LNYW60pEEV9Fmf9HnaLzWrhZ88MlE0o9DlsbK12fPGX9T019ICBliAhlri7ZZo
X-Gm-Message-State: AOJu0YxAL+1NqPzETApkttRBAYYFSlaE9qa2ERkpHv9nz6o40Pjd+ypy
	gGL9pyR/7u9nJiXnBQBbaQ1+FekzUvpHamxNx08TQQD1Ks+NjjEzh1iv0LP9HwU=
X-Google-Smtp-Source: AGHT+IGr4KfXdTc9P+tUqOlPT1oTTntEG1xJ+qUnk/c9fCN4nizt5pKj5b0MOuQknSB8WsQfCV29lA==
X-Received: by 2002:adf:ef07:0:b0:33e:c91b:9083 with SMTP id e7-20020adfef07000000b0033ec91b9083mr8231244wro.16.1713790846220;
        Mon, 22 Apr 2024 06:00:46 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:6981:a121:4529:6e42])
        by smtp.gmail.com with ESMTPSA id a16-20020a5d4d50000000b0034a9b75e272sm6761942wru.45.2024.04.22.06.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 06:00:45 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Wren Turkal <wt@penguintechs.org>,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH] Bluetooth: qca: set power_ctrl_enabled on NULL returned by gpiod_get_optional()
Date: Mon, 22 Apr 2024 15:00:36 +0200
Message-Id: <20240422130036.31856-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Any return value from gpiod_get_optional() other than a pointer to a
GPIO descriptor or a NULL-pointer is an error and the driver should
abort probing. That being said: commit 56d074d26c58 ("Bluetooth: hci_qca:
don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer sets
power_ctrl_enabled on NULL-pointer returned by
devm_gpiod_get_optional(). Restore this behavior but bail-out on errors.

Reported-by: Wren Turkal <wt@penguintechs.org>
Reported-by: Zijun Hu <quic_zijuhu@quicinc.com>
Closes: https://lore.kernel.org/linux-bluetooth/1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com/
Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 92fa20f5ac7d..739248c6d6b9 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2327,9 +2327,12 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855)) {
 			dev_err(&serdev->dev, "failed to acquire BT_EN gpio\n");
-			power_ctrl_enabled = false;
+			return PTR_ERR(qcadev->bt_en);
 		}
 
+		if (!qcadev->bt_en)
+			power_ctrl_enabled = false;
+
 		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
 					       GPIOD_IN);
 		if (IS_ERR(qcadev->sw_ctrl) &&
-- 
2.40.1


