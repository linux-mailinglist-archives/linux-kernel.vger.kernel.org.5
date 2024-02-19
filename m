Return-Path: <linux-kernel+bounces-71268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B90B185A2B7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD8D1C23B1A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9893610A;
	Mon, 19 Feb 2024 12:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="SbFqWZ8m"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D3F36103
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344014; cv=none; b=pgV+aIkpyByiMV2XrLsJ1cYjj+dmxXsfFf+exMwVibNcHmI2ODnNGge+vf0du+svZAqBqbGWGYPbpRx+ngnY4xWj+ooQtZmkf5mFhlhEsr/T26F8Z9bMViq+9+T1uVfgFRn8ACdB5aqHSdvf/ZUv4xSO4qHIE0+B13QuwrxZcTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344014; c=relaxed/simple;
	bh=Km+H2S6VUJOVhwCV0HxwAGP/gwbHc7XavDH63KBqNTE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jb2BUyzTVnYkKZfuMU0gL3ITxWtA7D/avJCeBuhnIREqfceDfvNSj90oBj0+knz6sHbcjmirsuMYcN/pzOczZPKQo55Y1Ijt6GNYrXOCS34d84f+ldOXbHnO+sDENGCv+Sxap3g+gtBqoDgqiUwmYPKH5beErjeUz/YxO6b7fyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=SbFqWZ8m; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dc0d11d1b7so478615ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:00:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708344012; x=1708948812;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y/y+wzHPYfd3SiHwSQB2gKjSO42jAZTbkJRHXD4vpAA=;
        b=kkmSQsMua1Bh5nO3MVGmJK5wKaBKHa0G0h+1VLS7D62hs1atjHfK8YHskXfSiKou8r
         39fnFt9m6AN1hgYDudC8I8BMsAPBn7rPZ2lsv2mwlpDXR3663OlS2Z5ttIhX1Rcyfpom
         P6pStKEZ331tXSWL0U3Yfiy00WeWXI1MaYvF3ayJ3B93GbD4+W9Z2LBjeFB5IuzwN/y2
         4oPbAJGR9YZHEsGDSpDjYBMw+1C6qemhFJNl9WhXqAWj04noabpz/TPmw3XGprjWOu5W
         vg4sfEDai0G3+KbRFEpWjcO2PuiJJRfTxfni2xptl/1UflfI1eZ9b1BAkFQ+iYuxWfVM
         Fp0w==
X-Forwarded-Encrypted: i=1; AJvYcCUciEG0ET8RHe6YYNDIqF0ExZfu3ykcB28iMczqoptpCpClwpZAZb2gIj6LMbRoQTi2b9yl7zUhqmy1L3OOqR4b515rRvJ6pPvyykCV
X-Gm-Message-State: AOJu0YyYrF9pHlgCW4K0yquNYmyZzBH5TBeaHH7Bd6KVoFSKWy/oOopI
	cZLetUN0VkhOmdysCrcj3e+N9ydDvhrGNgQISoJsAg8wM1UtuW8J
X-Google-Smtp-Source: AGHT+IFqlQY5V3p4tah87iC3Iam00vn1SMjTwNz28T3natSCKrRYMa//YfctcP/zWPa49vZ0F42pSQ==
X-Received: by 2002:a17:903:11c9:b0:1db:509a:5a31 with SMTP id q9-20020a17090311c900b001db509a5a31mr12250224plh.26.1708344010045;
        Mon, 19 Feb 2024 04:00:10 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902ed1100b001dba356b96esm4223022pld.306.2024.02.19.04.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 04:00:09 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708344007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y/y+wzHPYfd3SiHwSQB2gKjSO42jAZTbkJRHXD4vpAA=;
	b=SbFqWZ8miv9wQlNXq84nvC4QIffme1yj078sP+A9c+zX3ra44UwXA8zi9JAn0LjP5Cwqay
	eAnJGc1G45kkZX0dTq50UTr3hrFd01aR2wuphJ1Cfhs13/WcqYwlP8On4quNjO6L/h6nu/
	BZTxDQ9EtIHLMQ/tFaRj5m4yWffDmmSei2Ui4LWSfUVlQJ16zPLAoJz297CP3p+Ew5WQD9
	jJcyfGe3hMt14Knp21qNZlVUFa7ZzO8YOxiPjlb0MG7OoQClY9czp61i1VNtW1wtq2VISa
	/Bk2lJKv8zyZlOrmiXnAob216JTNZSusEUKJT2dCH0VX439uimzyJfOs0mtIAw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Subject: [PATCH drm-misc 0/3] drm: constify the struct device_type usage
Date: Mon, 19 Feb 2024 09:00:50 -0300
Message-Id: <20240219-device_cleanup-drm-v1-0-e2f2acb38bff@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPJC02UC/x2MUQqDMBAFrxL224AJttpeRYqkm1ddaNKQUBHEu
 5v2c2BmdirIgkJ3tVPGKkU+sYJpFPHi4gwtvjLZ1natNTftq8SY+A0Xv0n7HDSA54X77jp4RzV
 MGS/Z/tORfkKQwvQ4jhMiAvDnbgAAAA==
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1371; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=Km+H2S6VUJOVhwCV0HxwAGP/gwbHc7XavDH63KBqNTE=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl00L1CbIuZohfUxP4oQ+gIg5l/qdyFLnWxlC8b
 h+0jG70h3uJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdNC9QAKCRDJC4p8Y4ZY
 ptUuEACiK2YVZzL6OtOLLulMgYsNOJGnIij/8clART7o4OFIxLJiEsdVMkGj9Ob+CNt4XNP7gjM
 jphzkppLod/SSoIvWcDAvPx9tU0sSNtJwM6ypDARr7MsSXEAqJuafTSSaeHxsCfq+YZn3CjUUEi
 UxBbKLhdCoJC2GQqPQhPJaCXTyI5JhkRje4ugtREtHYd307d6QaALR1N7c+Ze7huKGOcRTnP+Ok
 9Ragvxxf2Y96SxLmc8qXonskO+QtZ0/Dnoeg0jiWp60T1QVmsMf38rMbVLOqfam1j64EBzWKAhs
 B914RBT1yJD06xtoQEpc/nHTFkdpoEnRiRu9rXwer649r1cVIZ79yfXAPbTgxusHykOzBxW4diO
 lZ3U2x+2/AzuuVM/S/uIBEQ8SsdFGlmcCNZKUU60jljRS7Zb/EunUy9vg5B+m0AEvpqhoLDuKtk
 7C5XeoVX4KmEFosCw5xZzhvoejUOPIv7HcCt39KmXx8+8sbGzv3HB4JC7GAIM9i9YclIYTlivEb
 axBHa1YMa3qzzi1t3tr8YRRUDDBOxsH2vw0L2yyIteGbGBVAcE99omZtwF9bmP2VxjzxJzp0y6Q
 hxX/mLArUzublWYkRljX5K3Pwl2OonxL2KvHncF4M1Yy2wKvkFPF+4uZw/PyHcrprCt/rcsDxiD
 +AJWYhcnCF47VzA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

This is a simple and straight forward cleanup series that makes all device
types in the net subsystem constants. This has been possible since 2011 [1]
but not all occurrences were cleaned. I have been sweeping the tree to fix
them all.

---
[1] https://lore.kernel.org/all/1305850262-9575-5-git-send-email-gregkh@suse.de/

To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Daniel Vetter <daniel@ffwll.ch>
To: Hans de Goede <hdegoede@redhat.com>
Cc:  <dri-devel@lists.freedesktop.org>
Cc:  <linux-kernel@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

---
Ricardo B. Marliere (3):
      drm/dp: constify the struct device_type usage
      drm/privacy_screen: constify the struct device_type usage
      drm/sysfs: constify the struct device_type usage

 drivers/gpu/drm/display/drm_dp_aux_bus.c | 2 +-
 drivers/gpu/drm/drm_privacy_screen.c     | 2 +-
 drivers/gpu/drm/drm_sysfs.c              | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)
---
base-commit: b59dcca97bf052341b9ac28b1ee1af46498b8833
change-id: 20240219-device_cleanup-drm-eeeb5c7468da

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


