Return-Path: <linux-kernel+bounces-78729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8B28617E7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B18D1F23C52
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5121272A9;
	Fri, 23 Feb 2024 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOeTJRoP"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBF08287B;
	Fri, 23 Feb 2024 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705735; cv=none; b=i9wBncXmpPbAqtcTSISmpOMxWfGVJfI3gzBQ4u8gKoYZu7ZU9wRiTemmD5DKXuYgrmB0PzoLijGCczlglcaKgChO41tLEmbzls5khx/RPLiBxBSQoKROUkadWiQkp/QN7QmQjKyxOmjEO9s8e31tcanbCe2hr/JghULjZzpJtxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705735; c=relaxed/simple;
	bh=5YbTR7gyfaezo2opFjG6lXkXRaDF1IHJkCMt5G/1Gwo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SaxRsTFYKedsHqCUbU0VMO1eMf0wpnHaw2U02gZOo6lJYEnSreqYiE1dMR+dO6cEyT/UZvtZeXBPscniCenALxIhnKnnv2RICukPKf4QLJDbPo89AdCwMzwe0Z1VMRRo9/z8+oIX+D0nj22zWeanzSGhxEM9yOZqGJv4ZkaOgsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOeTJRoP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4128f5ec9b7so7459355e9.3;
        Fri, 23 Feb 2024 08:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708705732; x=1709310532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aoib1qDvqXB6tm8HGIYPQsiyL3x8ruk6j93ZM2+3jRs=;
        b=MOeTJRoPbtU08fNYwthHcggbNIrC0hEccshS/YsLUR1Ky5cpIhkVJtqwE3IPrW30mK
         flx7ddW6Eb1WHvt0Ny6fE3ay9HQkLM604IQO9OgAfqV7lH+2/U5OyGH4MbzUVI+oqWNa
         oW810eaM8nwf4AAKJkQ1x/EgOB4t0IxD6s9mXijPF5cxx+ioPBC2Xs0qnhH0Uutj+IcY
         qzR/k0EEYKkGPyuOARZkGRIdyEMaVryf+mFGVFcOyqW43jawDk8nEDxm/URk4OsA479x
         ftf79f85bGrnlIhO0nNaR2iX3g38EBrF0yXs0cehmv/6J2tEsHInN2cnc9qF9UeCg1Lm
         s7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708705732; x=1709310532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aoib1qDvqXB6tm8HGIYPQsiyL3x8ruk6j93ZM2+3jRs=;
        b=SEzM12h6dHmh+pKsSp/MeGtbtV3EnJuVMMVOuXGGMVGUZLnxvThII9AdYHjvuKrT+P
         9j6fiCAxYJqRZ+dE62olblwu8cr1LZjWBNgKCl7VwulkJYpgQ4Ahdiq+4YYsWKRt0sZI
         iaYQeCtkWUkLNwGlinFBFbWBxx0xhJqxFXvvl1mAdRXN+euYrLx1OQMc1qxstKISPzuT
         15CXcLoA1xYiPGRoGjcI1hS0i8C2aNGOWToIVz2hx+L9CAl86j3d52dNrgH1dZPGe8sB
         YpL6P0AeYrIV5JxEXx+w0u4RANfsr6ecrCZQm8qfLx9iOs3wHzyn12J84H+DzbLN4rNQ
         iPhw==
X-Forwarded-Encrypted: i=1; AJvYcCXFpAHxwDR4IwhO5+MMfyIKuBNvqmjDQAS/3rvt7VNo6a+g7mS7/cbfPgokIPyXl88CgfnsVnjCYHfaw70IriVwVDHlQVyu++BgmNEr+NL6DDLrRa8xipNxsDFaNLVlQdc64nH0h8/J6g==
X-Gm-Message-State: AOJu0YxcdO+oh2yg7oYAa+BZpowq6cNJxMIqsp3hE8FuvD9lmFu/RMH/
	SKLb70SXvV2yVJQkfvhuzKjySgxfrOQ32WavjS43sj1hGSG3NBj6j97jnQOx
X-Google-Smtp-Source: AGHT+IFOwIC6IuTODMV51tXOSHJACqr21Yq7b0hX5JR1OEkHYV0qY455zw5E0qSXOXAhqMqT6FCVAw==
X-Received: by 2002:a05:600c:4ec9:b0:412:8faa:65db with SMTP id g9-20020a05600c4ec900b004128faa65dbmr261477wmq.38.1708705731452;
        Fri, 23 Feb 2024 08:28:51 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id he8-20020a05600c540800b004129867fae8sm219812wmb.1.2024.02.23.08.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 08:28:51 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] pinctrl: ocelot: remove redundant assignment to variable ret
Date: Fri, 23 Feb 2024 16:28:50 +0000
Message-Id: <20240223162850.3914349-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable ret is being assigned a value that is never read, it
is being re-assigned a value in every case statement in the following
switch statement. The assignment is redundant and can be removed.

Cleans up clang scan build warning:
drivers/pinctrl/pinctrl-ocelot.c:1404:3: warning: Value stored to 'ret'
is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/pinctrl/pinctrl-ocelot.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index 52aadd6d72a8..be9b8c010167 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -1401,7 +1401,6 @@ static int ocelot_hw_set_value(struct ocelot_pinctrl *info,
 	if (info->pincfg) {
 		const struct ocelot_pincfg_data *opd = info->pincfg_data;
 
-		ret = 0;
 		switch (reg) {
 		case PINCONF_BIAS:
 			ret = ocelot_pincfg_clrsetbits(info, pin,
-- 
2.39.2


