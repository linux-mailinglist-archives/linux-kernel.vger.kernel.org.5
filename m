Return-Path: <linux-kernel+bounces-158643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A09B8B235E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA971F2215A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E8D14AD03;
	Thu, 25 Apr 2024 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="X63ezSel"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA7514A091
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053593; cv=none; b=pHvSrdOoFmO12Lwzw8RQAsLWYylMBuYJul2/Qob8VuuGZ3MeDLy8wIqSw1lK5ol++qi6IHuhYblwonw3bhJhO7I+7hmBM5zhj75EiYFjCQiBOzeLxxY3nk7LUztPE1imB/grbkfcfEdH4NbH7+OLjelAsucaLqGgQnSn7yORhQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053593; c=relaxed/simple;
	bh=mUZACTmIvN9VpSJnu+37t6kjVWpWjqK6pTbjUJgvM2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l0wr8aD1TTJMpe84MpBQKryFsdmPtbXvP/pcP94+e/NCuSFoUlfB+2GekTr5g1LQYo1fnluJuon7+MynLtF8q+NiOsiWOHSIloEHUlxfVxXbP1skkD6j1kzb2xKbX8cDi7pWipi/fg2bkUD7SFZCorjlLIzpHSXXn2DojhECiJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=X63ezSel; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41adf155cffso7626735e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 06:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1714053589; x=1714658389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QyGh/Qwq5NmQyuXE/qEzsm92r8+stUz1K4JXovBXMG0=;
        b=X63ezSeloXRmXYmLesLrM27SmZ1LKGqrzeFCZo0ENlPq1UUApAfPejgVmKqmaE2l5y
         sQb4jryIocbCAf08vh0xAAP6ntn3DcV+bvlQBKAy8dDSBArXRLHd65VijYJ9w9SAPhny
         q6o/rfa7cL7iW8GCKemp5cJIIwabxIeEZxn822ogbTHz2vPiiIGyFPvkYsuhgYJWPAaE
         DJ02yoZE/vuSdceJC89ug4+5BpV5bK7jB3jwqAdeD5pxrnqUM2EjRaUshQnhGePVP+OO
         GGPalkrxii7qpZ4Fs57lhVEysaHWXaCvCHXU6qGLei7EeuE9vV/FDAYyEo/3sUrtUXbA
         EEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714053589; x=1714658389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QyGh/Qwq5NmQyuXE/qEzsm92r8+stUz1K4JXovBXMG0=;
        b=QnynpAd65k+QEgkHhrtd4poVJiraL7y3L/7jmsfs3A4T5dYwTTx0GXmwswYQ72mEQ3
         7f5prtkod+y2RomXKnuKD7fVONuiknAACuc/fkFQ/4ZCISgW05UJLEaT/JuNW2yBwo9x
         XzpHCEdiphUSNU53jMsFMgzgrZfHpxvmSiu4PUJHr8tBPTtaX0m4BM1HTuz/kro41ELB
         qtP+d6HM0d9gPLj2FO8NzPRFApT+O7NXR2DSqT9V40RbP24pByVv4R6Uec5QZVi6jGZ+
         U/4boTd3haiq7G5DLciJFygTd0aT1MEEMbI9o4MZUaCzfo3DWRtfrWviegT972dWFft9
         gr8w==
X-Forwarded-Encrypted: i=1; AJvYcCVY3mLux69mdM0bVj7/3JWh1tReKHKl7F7h25ZyePPmHzGaEDGi7+Y5dRgR/keaCWQ+W+Rgk/dvScOXccI/lcOun4areR8HI3ZHRpVG
X-Gm-Message-State: AOJu0Yw5TVkiysQyBn0ZKjCUgI4HNiZULIZjTTHM5AFVUqRK+Y5GbZjC
	JRVrEZA6d9/GObfjYQn++fve5YYCchU8BPe7MasTLznWLh9S57wJEwsSX3O9bTw=
X-Google-Smtp-Source: AGHT+IFYPfy7I3CXLjJMhD1uN28B2VhtrX5AMAV4Szqw3ZykCF+dF8pQtGiVV57q6XpkZbeoQLiaqA==
X-Received: by 2002:a05:600c:1988:b0:41a:c92:d323 with SMTP id t8-20020a05600c198800b0041a0c92d323mr4457143wmq.10.1714053589161;
        Thu, 25 Apr 2024 06:59:49 -0700 (PDT)
Received: from fbxleo.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b00418a6d62ad0sm31479464wmq.34.2024.04.25.06.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 06:59:48 -0700 (PDT)
From: =?UTF-8?q?L=C3=A9o=20DUBOIN?= <lduboin@freebox.fr>
To: linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?L=C3=A9o=20DUBOIN?= <lduboin@freebox.fr>
Subject: [PATCH 2/2] pinctrl: core: reset gpio_device in loop in pinctrl_pins_show()
Date: Thu, 25 Apr 2024 15:58:02 +0200
Message-ID: <c40d0634abefa19e689ffd450e0f48a8d63c4fc4.1714049455.git.lduboin@freebox.fr>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1714049455.git.lduboin@freebox.fr>
References: <cover.1714049455.git.lduboin@freebox.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We were not resetting the pointer to the associated gpio_device once
we are done displaying a pin's information.

This meant that once we reached the end of a gpio-range, if there
were pins right after it that did not belong to any known range,
they would be associated with the previous range's gpio device.

This resulted in those pins appearing as <4294966783:old_gdev> instead
of the expected <0:?> (due to gpio_num being -1).

Signed-off-by: Léo DUBOIN <lduboin@freebox.fr>
---
 drivers/pinctrl/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 901f2f9bf850..ad878196ada9 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1670,6 +1670,7 @@ static int pinctrl_pins_show(struct seq_file *s, void *what)
 		seq_printf(s, "pin %d (%s) ", pin, desc->name);
 
 #ifdef CONFIG_GPIOLIB
+		gdev = NULL;
 		gpio_num = -1;
 		list_for_each_entry(range, &pctldev->gpio_ranges, node) {
 			if (range->pins != NULL) {
-- 
2.42.0


