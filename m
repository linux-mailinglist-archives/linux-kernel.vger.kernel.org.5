Return-Path: <linux-kernel+bounces-60529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEB2850622
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 20:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD076284293
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 19:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977AD5F57A;
	Sat, 10 Feb 2024 19:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjMNnWuq"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600A9339AD;
	Sat, 10 Feb 2024 19:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707593837; cv=none; b=PfIgxUJLvBCfqVMMV4xYH2Ms2IRxCw5nzD/1IMiANSWizkI1GVx+AklPixqv4B37EHkDa8KKy/27D+Hwsm/yOnPqUbhCeZwzgoPyr/J7tQicWuDdr8cJ5MPw8DXBf0gq00JoEOYrH/dGAJqUzkr5fQc+TODSePZkqbK3cdtj4ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707593837; c=relaxed/simple;
	bh=Jn//OSKGthFe6OAP058JSis/CXn03TlnUxflYAOTjTE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Cx13b1UyCxQV/F1Z9RJBxAY4z9mBZgAmCov1QovWq8lSQbEmfw0NwIigU8JJu2eawA8lNLx0V8I/QIiW3GovOHQhwbzhfe5Wofp3k8mA0dQdkjXr5dH5y3pbJdAMw0GnGIFmIuEPme3ESapp7NnCVkLHUzIRN36TA0jWEfTytb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjMNnWuq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41090edfeb3so4418935e9.2;
        Sat, 10 Feb 2024 11:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707593834; x=1708198634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X5Ch8/R/ytcGd/WSniu0Y6nEnaIWMCRnox19MKHusmU=;
        b=LjMNnWuq2FyADt4aJCLbGQwcxP6GHZAOhecWd/Bc7qyXxh0tbxNX4UohgpL35PNjGV
         1ijPcOMc0bqqdihqbtpMJOWqhMuZbEAS+YXD8CfHJM8Q+0CuvjFnlbddnrAdigkzqWtd
         nxhygwK1oKslyGUNdbqyKbI4KVD1MhFrVQpDOWd1dfkQHOuHArk3tsoxEF4xyOJNb77m
         2teFLpl/0gdRj+6SyNBqVvP/efW4Q3INh8dDmMxfPmsmLrCDhnv4SFe2H+Wc8kdUVS6B
         lMZ0v26tC4mPtmaf0R2QzUhtHpcW1Ju9ZsuqKZn/kX73UAMG+5AEkQFkYO99lmEuwO8O
         NBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707593834; x=1708198634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X5Ch8/R/ytcGd/WSniu0Y6nEnaIWMCRnox19MKHusmU=;
        b=RgZTX8JhNkHicsYHHYt0vHWuSMnG23X1O7yHr8fGu+sqE/kBBBayxp812LraaopaHg
         TvAE5PTV98HdjTn7Ym0IQtfFkU4dhrfIyg52iAKdpnbfB2FosnBrytjsupQnEws+akwx
         Bi2UZduC3v4H5AnBmpTlqsstGBlParZrK2Vv6+keWnp4N3D4b1lFM9BgB/6zfFAAtgiw
         AL1yIR9cXpM6jOaBsq7vtp1DyANF9FwfPgvxkWxuK7aYtGaWXdGcm2MHecibCOaFsMlR
         KANDj4i0x4MbsGDV+/CEdSSvRlHVgf4VDLjcN9j6OeeEK2tMg8Y9smIIoc5WY4mF97VW
         /QIg==
X-Forwarded-Encrypted: i=1; AJvYcCXoHgzf+qYuuG3kteFfiQ2TpI9u3VXp6nptFialv+sf2JedztkFqB0Q/ypHyns0g0V3y6lzBIl9h1mrS61pyga4X8RUu7u7pf7VfApbaKkhnnI1vJSMSpL7gALOlYu6ZMk/xrmkWTTddefFbPD1p1PzzzmRWUhF800rUE7Z7wRfkRw=
X-Gm-Message-State: AOJu0YwrtZkjUopunQsohA5fGlByI1e5n+6oCZT9ObYYsUvorXlyb+JO
	loEMEJ8VVm7T3jE2TZDzBOvhyCTbd/wvPpW2D1BU6UKcKBS50nJkCn7bGDMSzyE=
X-Google-Smtp-Source: AGHT+IEAWbVZRqKIqx8VVon5/TdWZcx3X05PXfOs8rrphlHw6EuNLFAnwpwtoJphUp8NmJ+rHd8fuw==
X-Received: by 2002:a05:600c:4588:b0:40f:cf69:3e1a with SMTP id r8-20020a05600c458800b0040fcf693e1amr2231427wmo.39.1707593834295;
        Sat, 10 Feb 2024 11:37:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWGcE+ZpdumaAMlVGsSifSbReIenuTLF4/RaZStUKXx+01NZuKFK23K82L+BOjfRgjKgX7wSMTj1QlvU1Plhc/LeEXUyw+NR5dUJcZi+JBcEANLy1l9r8Xfoegv+PjNyJ6KT4LHR1mq9s0V87YzB42eNwt2OAsI6x7scmOTultVla+trhErYT4P44aGHME02IiFg/2b3VXJXLKLSCTv6asxsmqkMMS1AIbgQbFH0wVL5PPieDZG
Received: from Attila-PC.. ([188.24.48.22])
        by smtp.gmail.com with ESMTPSA id f26-20020a7bc8da000000b0041076151a8csm4018344wml.14.2024.02.10.11.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 11:37:14 -0800 (PST)
From: =?UTF-8?q?Attila=20T=C5=91k=C3=A9s?= <attitokes@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Attila=20T=C5=91k=C3=A9s?= <attitokes@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: amd: yc: Fix non-functional mic on Lenovo 82UU
Date: Sat, 10 Feb 2024 21:36:38 +0200
Message-Id: <20240210193638.144028-1-attitokes@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Like many other models, the Lenovo 82UU (Yoga Slim 7 Pro 14ARH7)
needs a quirk entry for the internal microphone to function.

Cc: stable@vger.kernel.org
Signed-off-by: Attila Tőkés <attitokes@gmail.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 23d44a50d815..864976a81393 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -234,6 +234,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "82UG"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82UU"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.34.1


