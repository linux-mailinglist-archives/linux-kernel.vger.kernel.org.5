Return-Path: <linux-kernel+bounces-51238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2759384882E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3062F1C225B2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 18:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F7F5FDBC;
	Sat,  3 Feb 2024 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="qv2Yqelc"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C1C5FBAE
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706984685; cv=none; b=jzXWxvvcfq+2jkLEFSagIkGOyHsN2+PSml9dxiGLGSBLxzCWn+qnQ7CWgIDkTlgT3kw9GR6xguQb+sR8Dr+Sgg+cj8HRyx2oCH9FxtHzdAIIgkQ31jWgRVx5KaAMxzUumFdjIJ0eezTDKwnTmkpkMC3l8+hYIQwPBVRFXtD0094=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706984685; c=relaxed/simple;
	bh=PWGIF0SB6BlBgK8TT4wQwOjd9acucA+/T3Wm8oL7Q9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eNEyfEYLi/bV5Yhxcc3ydtigjw3iV7+XZV4XihR0UKPd71F0qwuZQSnC7LA1qFYLh84W7bHcJhLCBmRR36ti6nilFXb3Uq/3jvLkrJC4QJC+lFB7P/duBgwpVO9i6T2OU/NhV/78WN2KYaYWpaL2PGPkjHstSWt8zvLjDUk2AMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=qv2Yqelc reason="key not found in DNS"; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e037a698cdso64399b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 10:24:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706984683; x=1707589483;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KzZQL8rSLrwKDPYyaVTOC54buQP+RGECHRJE70wSEUM=;
        b=ol0hiyQhumQIgqXt1VRRrYgSrtqWMSFMHS56U0DqCWCNadT8jXqqlKMBI+Rd9salRs
         bTEkgeVIJmuz0CVZUzV/f5qTq6tmMckS/3cSix6WOnt5In27gqlcotxWfHj06XhMwkAW
         7TYcTBqM1tA26PiK+hYJs9uaUm6VSyck4z6awW7WaFLTQzWyL0SOk/E6TUYvLMRyfM8Q
         b+rWfkmvPSbg2sW2wDpNq2btdqbyMvrY09gi+S7YVg/mtb2/voA0LfP+0UW5V+SRWpZK
         IN3imUqn7MXtwGCU1ryyeisQ9OgJH+4QhdNBfzlwzKoCOBHgTJqegp3UATAMVzAr240p
         n+zg==
X-Gm-Message-State: AOJu0YwmwaQgBaA8dlnVV0XT0aVRVYm1pAZjDcbU0O5/8t88d/V0DjUJ
	Fvm/tE+re6bmVz1yiTGYsuK1z1kYQ3cvsqtL4r9DizMqaB7/Mx81
X-Google-Smtp-Source: AGHT+IEILJLjfVVzQJ3+jtnCq+/VzJxVyccXhsxT6jLgQyU2VxtZYf3msDjaLnpW1BWqssRhdHFDlw==
X-Received: by 2002:a05:6a00:99e:b0:6e0:2eae:c6a4 with SMTP id u30-20020a056a00099e00b006e02eaec6a4mr1218611pfg.26.1706984683151;
        Sat, 03 Feb 2024 10:24:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUAnhW7+7ZZR/+M3OqkVol31iBtpyxjnwRhUfxk94DLZtUWCsNi+JRv/8wJtWqleLKh6/huZxMNandBP6p4b/e5MgHuQ+QQaEeFEZFFFVbjz90N2npVCnZg4JIac8geK0XSaaR/e6u44AE/uG4cIjBoVmWlRehk4yPRhAaW0gNJuSQe8F4oDr+VIwQC/cc8JRRbKOT7TZIaQ3V/xgMcRADrgl4thCBLLmzM6bXqWvn3DRfK/B7e
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id ld9-20020a056a004f8900b006d99056c4edsm3653164pfb.187.2024.02.03.10.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 10:24:42 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706984681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KzZQL8rSLrwKDPYyaVTOC54buQP+RGECHRJE70wSEUM=;
	b=qv2Yqelci7CqWkXp2npcOdmxqHAEdbh/mnvcOkN+vXhYboPX8TiUHRiOfxneevQAzEPpub
	RZSECHJTdXj6mQgf6vh14WUlOgljvEbM3ywYnZ0K/Fto+mF04dqPlEQFcYywF/7z8dU4l4
	wdlQ3SrqWVLM7zXCSyyjT8EGJTFg88LxbbTvAQvHIzjyAWEst43VXY2hOrFD5pTX+lNSde
	jk93IkcYw6e8oDAYOe1zDNA4utzygw2YaG8BXQ/qZwq9H2SL63aFVnXwNJa3wBO84CEhoh
	hx3U2gRiZS6DDuE5Lqvz8dRKKNcfLP2nQ5sXr6lM0ZGQRdGFQOuSBFcVYEBIEw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 03 Feb 2024 15:25:03 -0300
Subject: [PATCH 1/2] drm: display: make dp_aux_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-bus_cleanup-gpu-v1-1-1b6ecdb5f941@marliere.net>
References: <20240203-bus_cleanup-gpu-v1-0-1b6ecdb5f941@marliere.net>
In-Reply-To: <20240203-bus_cleanup-gpu-v1-0-1b6ecdb5f941@marliere.net>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1053; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=PWGIF0SB6BlBgK8TT4wQwOjd9acucA+/T3Wm8oL7Q9c=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlvoUBQ8Ijrp8ZsUoVm9cfxF+uKmjw5CLni5fKV
 6KxFLWPyFyJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb6FAQAKCRDJC4p8Y4ZY
 pghbD/4uskt44jqKw1/ZXMHt348KW7amF7zcEnyCfk4/ychYObeyJgPQTUcTn0TD0fPB5mxbrDl
 qKoHCi3kJL8H2EiokwzIMDit4F75ARVBDU01eTXqkKynASAsr7HVOgi9c+hkzfFogDKcI4Sg8k3
 zPrK5VvdMUcG9XW9czn7FRTlGOu09fqa0D7+6jbZ5eUaGRWGAI6leNxJKOL3cf/VTzFk4AjQt+m
 aXMI+UbKBbcR4c08yXKm+YQb7cwQaLRiZtxrG0p4dcxs+JDrYpSV3EAfZ/FBEVAnKcaf5r9p5Xl
 FZZY+vYtAvgMzKu65xSvD+XBS7TeCqWZXN3D7Hn1n61my/6lbUUxP6Jhto1If09ySKHlOQULuw+
 bGIViaW/8INa6qRKWyYte9jN70yCoMpc4BfIpyaAhvtc49/RoNFlJtTGxhpUR4r4jeC/Zom6Tf2
 vMUi4wVDjYDCbBfc9Caz66oxu2GB2yEpUD3tAwAjxWDP8dCJXOLtUG0bH+SI1mW+uqbDSV40QuE
 w+JxoohW7zNNF3NQ2zDblodV56UQUUW2XqJLhG2TyZBNkKMQ8m1dt1OyJQ4gTyJGsWyeRLKzAc3
 1H/xKgxOPlfSfeiwCjlsZ+BTDZdh8uk0Uh99at4taLUlFbsjf9yBECtf/MpR4lOg39zr/g9SqRR
 EOSabTz+a/qCNzg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the dp_aux_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/gpu/drm/display/drm_dp_aux_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_dp_aux_bus.c b/drivers/gpu/drm/display/drm_dp_aux_bus.c
index 8a165be1a821..5afc26be9d2a 100644
--- a/drivers/gpu/drm/display/drm_dp_aux_bus.c
+++ b/drivers/gpu/drm/display/drm_dp_aux_bus.c
@@ -127,7 +127,7 @@ static void dp_aux_ep_shutdown(struct device *dev)
 		aux_ep_drv->shutdown(to_dp_aux_ep_dev(dev));
 }
 
-static struct bus_type dp_aux_bus_type = {
+static const struct bus_type dp_aux_bus_type = {
 	.name		= "dp-aux",
 	.match		= dp_aux_ep_match,
 	.probe		= dp_aux_ep_probe,

-- 
2.43.0


