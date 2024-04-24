Return-Path: <linux-kernel+bounces-156591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E958B0542
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A79B288D3F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB061158A29;
	Wed, 24 Apr 2024 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fOLfqlIy"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051C2158A2C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713949448; cv=none; b=aIh1mV8rHIDI3khAr9XGd9y1/1K8RydINFKTsZpU2TzWy82Tz6eR5I5rSsOPjm9vJz9/cc8TETifFbig/057tgra3zKeoekTPFCTTu8UnFLRPXFwf8VaWGMcdL4/54W3tF2FWl5Ko2IJOUIN8deocsCiSUUxv3kQyc6LIbgs1c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713949448; c=relaxed/simple;
	bh=Y2wzOvQe5awl2YyrzbxpkVss7E7jaSjDhA6vqXjHISs=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Csmoo/XTkb0/hc7gfLelAvmE7FWfRJNkZ81uCesOB8ft8AiiK4bbeFTXG52ulD9baSWLgVUq1yNM2ucyB9SWZaJFZvbzzZTw6tTw9AiFwh2zggMSQvIgiIdSrg0+//V2NeRJ+ybBBs035pcpCdX+2Jb7JJGr5UmEJYqgdXhN/fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=fOLfqlIy; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d858501412so89359721fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 02:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1713949443; x=1714554243; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pG9za8GIt2C4BOKtDqST70eWWIAaa++7qoZuka22atU=;
        b=fOLfqlIyZjW5NIDsjunXrf5zQeecKGfECk1Ut0zAaoXNQaqoYT1Od8bBgbAdUY4J+b
         oAMyqqAiDH+z2wPtikd1QoVvSzGiMRwzX9ulXWrh3iGFknUibZ7fUT9rOGFBpbjuCAdS
         PoNu6hm2/LXgd4mk7oaSCDm6k96HsOqTQCEsp51qnyihrHJu5DcFeeim621432QuiQd5
         JYmxm+TEa0GjbbQf5vWKb0fKYyLWPMY2R/6561e1rHlQFxe1He5MZElaDxyvZaUtm5Qk
         WFpWeoAHVVgeojypTFH6UpBUlZFpihTSUiJ/cVXHmmr5FsVzagTNOyVfi274v0N2Zbsr
         8PFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713949443; x=1714554243;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pG9za8GIt2C4BOKtDqST70eWWIAaa++7qoZuka22atU=;
        b=A85gbhiXPr+izfsfFOKV16cC4/wNSMhXfKCWkHttmPLm6r3pX9fcSp91/2CaK+Iy2j
         UzEpIow0W+VR6G//g312cDbqNuFGCaUwyV/IvG43uIVrkgBjsDYeOuSKO3f+7ORQ5P42
         x4Beg24XpLA9+0BkulzEot9Ex7vy8yX4JztvRkbddj0FqrQ8U+Bet6lqJ0WgHBgwEirc
         PiGHvuERnxd8MiUtnyJN9BcS37nIhV1GZikCN7swciVqFRFiaA2ApaONn7Iu6Yaelf9s
         gjcUJuKLtj4uMkinMIIZj+2xNwM79x0jkLsReVQOczAuXVwf6hCIiemHHLS/Qkgoordf
         sqAg==
X-Forwarded-Encrypted: i=1; AJvYcCWOQOA9SOnrpKWQThPToHsLTW4wFGlPz6N7hL3ILlWQ/89dRHs6UCpxcTaEOIkJeuzfrmJp9L9B5t5hq56/41pp2yjhqO47+kSpkmAl
X-Gm-Message-State: AOJu0YxmCpeb0PcOWCp8kNytgCjGPwPtk2zvXWgP7ewRSoljd6z5Er+P
	RKTfpBy0WNSGUWwb1rHqJxeaABhRxnSdRhbeJvbMPc0Fz6B+N4JciZ4vSHn2QsEajZdW8tOe6xj
	rU3T2vRIYSJpDtORh74O9Zoe9Ere6cJdyrw/pgQ==
X-Google-Smtp-Source: AGHT+IHihMiLWi4mS+U9MLzHnIRW71T0GNRhjdzDm651UOR7kxLQWwQJbUNXRKm+ie/OljuDvauLwUYFyWyyLZUYUGA=
X-Received: by 2002:a05:6512:925:b0:51a:ca97:66d6 with SMTP id
 f5-20020a056512092500b0051aca9766d6mr1164489lft.67.1713949442827; Wed, 24 Apr
 2024 02:04:02 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Apr 2024 05:04:02 -0400
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <99242a7c-53bf-4227-9623-7bc092f564b3@penguintechs.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422130036.31856-1-brgl@bgdev.pl> <99242a7c-53bf-4227-9623-7bc092f564b3@penguintechs.org>
Date: Wed, 24 Apr 2024 05:04:02 -0400
Message-ID: <CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: set power_ctrl_enabled on NULL returned
 by gpiod_get_optional()
To: Wren Turkal <wt@penguintechs.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Zijun Hu <quic_zijuhu@quicinc.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Apr 2024 07:07:05 +0200, Wren Turkal <wt@penguintechs.org> said:
> On 4/22/24 6:00 AM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
>> Any return value from gpiod_get_optional() other than a pointer to a
>> GPIO descriptor or a NULL-pointer is an error and the driver should
>> abort probing. That being said: commit 56d074d26c58 ("Bluetooth: hci_qca:
>> don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer sets
>> power_ctrl_enabled on NULL-pointer returned by
>> devm_gpiod_get_optional(). Restore this behavior but bail-out on errors.
>
> Nack. This patch does fixes neither the disable/re-enable problem nor
> the warm boot problem.
>
> Zijun replied to this patch also with what I think is the proper
> reasoning for why it doesn't fix my setup.
>

Indeed, I only addressed a single issue here and not the code under the
default: label of the switch case. Sorry.

Could you give the following diff a try?

Bart

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 92fa20f5ac7d..0e98ad2c0c9d 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2327,16 +2327,21 @@ static int qca_serdev_probe(struct
serdev_device *serdev)
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
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855 ||
-		     data->soc_type == QCA_WCN7850))
-			dev_warn(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
+		     data->soc_type == QCA_WCN7850)) {
+			dev_err(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
+			return PTR_ERR(qcadev->sw_ctrl);
+		}

 		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
 		if (IS_ERR(qcadev->susclk)) {
@@ -2355,10 +2360,13 @@ static int qca_serdev_probe(struct
serdev_device *serdev)
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
 		if (IS_ERR(qcadev->bt_en)) {
-			dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
-			power_ctrl_enabled = false;
+			dev_err(&serdev->dev, "failed to acquire enable gpio\n");
+			return PTR_ERR(qcadev->bt_en);
 		}

+		if (!qcadev->bt_en)
+			power_ctrl_enabled = false;
+
 		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
 		if (IS_ERR(qcadev->susclk)) {
 			dev_warn(&serdev->dev, "failed to acquire clk\n");

