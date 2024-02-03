Return-Path: <linux-kernel+bounces-51237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 923E984882D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F85285567
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 18:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AED5FBA8;
	Sat,  3 Feb 2024 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="Q8nZDUpm"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0423D5F46B
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 18:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706984682; cv=none; b=Jo6Pw7SXABCkvXAra/DI4FgQkGUNBaoFoanGDFrf0lAxhR76/dTjG31j3NhTMwugUmBAzIOyQZ7cYdoIEG76lC19W4/FoThl6ktmLRCBNGSsKa+xxfFJBFMzNPCfvwSUZgyZVO4WgQTopyH7zF8pt7aBXvtLh8aJyz05f8woPI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706984682; c=relaxed/simple;
	bh=EHsop8OSD89DvFIwCtnmWiC8KY/ajnvUqLfFEGNYwCc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Koowj8dw7DKz/WSQs2VE3dOicirBX4+yorQrc+uJoxsgKGgbUefph9qGkniw+SHz5qFLhS4BdyxFwnKSagmlS+AaUOTo9qI1impH5BBISF5HU5hhuaaB8fbV2M3K8BJnr9yzZynx62HxOg70wBs1abiVYv+Ylz3w5sWQwkGiowY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=Q8nZDUpm reason="key not found in DNS"; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so2068947a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 10:24:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706984680; x=1707589480;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1tBtDof9oDKavazJV1vIQGt3aWtLYVYOxE0CKitiEaw=;
        b=TvWp6PvnOcvbZc3C6x0YfZvJypMCHJDAPndLlGTM3WQZzJBV7Q7gpepsAuLPhAoKL2
         EdXNWJYF+9mjoKW45/U4fv88oNaeEnVDHIBHjbA4Z8YRG7E70qzLj2IXsR9v6CLbkhYg
         qGPo/bHimQRXHdHeuwMf2/ILLsHJ4sMywSA/vXrXAVZzGUsFqQ3sPI4uVjhDDUkSSdqp
         ou+wM4fmPSyNsNVpM/Qfanoe/iBBnYnt0+8PacBjsc3FDJZ1EYAm32ihNNG0x04/aF9z
         q0QAFvH42C5zFT46yyTPWVVpP2J0QMK2kcBmONNP0yhad7lCTJv0a8Qomt/jeYuE4brb
         KjYg==
X-Gm-Message-State: AOJu0Yx7NKrYTbcUNV+z3AkUkKCy8sWXnQn/yGeeJ7p8efMVo7Yo8gv6
	2TvYpagKAhAfMu/1JdnGwJ3IwNng6Mu4WWhgfF2R4h8aTLrEBAW4
X-Google-Smtp-Source: AGHT+IHWeVKFFPJ1I98e4sWPQC/ibyQF1vb9MVgoVL+efXw8lKv1v55lJY+x7za+d7oAmJy4712A1g==
X-Received: by 2002:a17:903:2092:b0:1d9:8ac8:d77b with SMTP id d18-20020a170903209200b001d98ac8d77bmr1626033plc.17.1706984680016;
        Sat, 03 Feb 2024 10:24:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVyA3rlykhNGs2+EmYfC2jAcPFRroT7xvdg349JtkDnXfqtFosnLhFQuOrSOo7p9j9lpS1IMFaoh2H6TQEyANPtyTqMXVS6wYXUhEhOehzMnVoWeD8xULi5/4XGHO3Ge9/ygDhSW06RZ9EBowj1i711Na8epXyFMzMUW34zj8jwW0XwH7+83P1lsUEN29CzPh+kAe9IxQv3+m3tCRnY+AeLvETRY3hSH5WXzZiulm3Hn88jaffy
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id o11-20020a170903008b00b001d94c01ae96sm3549186pld.66.2024.02.03.10.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 10:24:39 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706984677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1tBtDof9oDKavazJV1vIQGt3aWtLYVYOxE0CKitiEaw=;
	b=Q8nZDUpmruOMasFb7BTyiRVYl6dDR/x30idja+v7A5WS+cdShSWMANwOn7hsvlmsdxcvMq
	yUsbnIBSoweQTCD2Utkg6v4uhLSJtucrW1/uLhrgWPsQBJdYmzqOqXAngRnx2bfVOVDSSb
	/GIpjLF/vh7c0jc0U/aqJ2KR4SRvTHUoJ02m3UNnq9zXxgIuZKcKEJPHji0ppwEwKN2LaS
	dMfUD1ezTqRzy+fH99y4JS5w10f06Nr1Ab4kyMN/W9U8YDrmBdNSZRVu5oeCNT8OOk2bUi
	q8l+AiEWJGjFKaXh/XlJv4yDqSwYozYovbOG8rJcPESbEYm1XZXlYhrgTS1vSw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Subject: [PATCH 0/2] drivers: drm: struct bus_type cleanup
Date: Sat, 03 Feb 2024 15:25:02 -0300
Message-Id: <20240203-bus_cleanup-gpu-v1-0-1b6ecdb5f941@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP6EvmUC/x3MQQqAIBBA0avErBMmM6KuEhFpow2EiWIE0d2Tl
 m/x/wOJIlOCsXog0sWJT1/Q1BWYffWOBG/FIFEqlNgKndNiDlp9DsKFLNAO2PVKG5IKShUiWb7
 /4zS/7wfajb/cYQAAAA==
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1369; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=EHsop8OSD89DvFIwCtnmWiC8KY/ajnvUqLfFEGNYwCc=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlvoUBZvjjLTROlWBYxpUUj+9QjyBFkHbTHXRD3
 svTQTQ0a7eJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb6FAQAKCRDJC4p8Y4ZY
 pqjWD/9IpjVqk5r3J+ZuT/if1aJo8N1Sji6/DMWy30pHg6VDHN9LQ/OyyRczPUo6ku/krvQeyE0
 JO2EUme1v5R3otlfkOxXpOu4ZuPEbgOw3dj/y788396vfOOvrDY4KkGBMmC8XrknilgQ//wyz3Z
 5Hbvi+Gd+MsoO4Uqy8NddimzIawaxcy9JcrW82bv4SVNwJFBDdANRjuWGVr12GrVDCRAqTj/aDR
 3p8BWaGw9vIMgwoIOJqIm29XX99fvJjto4ElJ36+Dhn8hNxLUgsgM1AcRkksE0n+ns95v6LznEN
 3c8DbkZzEQrLAoeVZFbdPVZs4ZnaHhIv3B3X0lU88vCmjgNxq5gLV3WXq4XE17b1ZMavXpyYcUd
 vPZ00nO/YzfyMwzmeuOP6SzbEgKGtwMuq5HKWmmrYuMTdtEolRaJdkMs1QK6LxtvDVlwAwXB0h8
 ulKp3u8qKg6D5KQrGpKN5h68Mxj9NJ6gQxDbRit2bdJ2tMcQO5QwAmOhg87M/Y1+UPnqF72gluU
 K8VuT2W5jxcM90YRE4evo1+7RG9HW3WYGc80prBwIwTsueDSI5TxFdl8eNI+baZNHFlNZJxlVre
 w2fasHxlB4sS/O5ay9gN0B5V+hl9hh3OkMiHTne0pxDX9AbGa3jkfLqejyORv04DZjJEemaR3rn
 H+jmCIPradmfTyA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

This series is part of an effort to cleanup the users of the driver
core, as can be seen in many recent patches authored by Greg across the
tree (e.g. [1]). Specifically, this series is part of the task of
splitting one of his TODOs [2].

---
[1]: https://lore.kernel.org/lkml/?q=f%3Agregkh%40linuxfoundation.org+s%3A%22make%22+and+s%3A%22const%22
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=bus_cleanup&id=26105f537f0c60eacfeb430abd2e05d7ddcdd8aa

To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:  <dri-devel@lists.freedesktop.org>
Cc:  <linux-kernel@vger.kernel.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

---
Ricardo B. Marliere (2):
      drm: display: make dp_aux_bus_type const
      drm: mipi-dsi: make mipi_dsi_bus_type const

 drivers/gpu/drm/display/drm_dp_aux_bus.c | 2 +-
 drivers/gpu/drm/drm_mipi_dsi.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 3d94e7584486f7ac4a44fe215330ae6a1094e492
change-id: 20240203-bus_cleanup-gpu-0f90574bce24

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


