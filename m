Return-Path: <linux-kernel+bounces-143343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEEA8A376B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7081F23A7C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215E5152197;
	Fri, 12 Apr 2024 20:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0ydVIav"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9E814F124;
	Fri, 12 Apr 2024 20:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712955465; cv=none; b=JKf+VpQjtmO8yqjTfxSnM3alzItQmLpJLObYV/hH6H67sHHCLVBKxIAVbVq442i9qBcooNOXKrL089L8SfzjqOIouaJxP+fJ223DzsAyS+h2UbSZwI+7sTFKPB7e97ZySdWDb7QZR/D201xkc8xv+Jl4FDkF8ABhxCIWb0+WsyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712955465; c=relaxed/simple;
	bh=7hpHYy70ghhIyp3iV8DeFnaTe5tvDh2MTiU/M7Ph7aY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FYU32jmZHhz8TdE2y8AAVao0XJ27wsWzK0qD+BFXd7k7pewYTzjzyfgqNlw0yvKpWB0tUKcko57N7dLn+4EUuYfvR5z9CsM33ryHY0zB0RzRvHTmxkVuHNfWTaorHzpvXfU7/pFqxBomC6yndFkTLq2bvW7pZ5LkAhh8HPRTYiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0ydVIav; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4181e10b3b4so926155e9.2;
        Fri, 12 Apr 2024 13:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712955462; x=1713560262; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QUNcSQI0xOoqnByekA7ZjQthM0HLAdbAOP6aM15AG6Q=;
        b=E0ydVIavGAt8BrSNCunG4BtA6f8i5NZ+RHkb7OpmV58v2HnzPRA6QUJJ8nVzfdBPg2
         l7I6ihBX0pLSMM6deKwWIL5QTBNsJBKJ/cdsoqfewY5/VgjvWMqgzlq2op0OKV+UwCtz
         /F8aKkY8dR8bVrm/8OXp6/vbQNKHEVEoTs/HCuWY2y6re6bSvECp+lawgjXyKs4xqeNf
         SFrnHr6ZVbR5zAdRuaU4kg9fD6WJCp83jZHNVjLiVOW3BFiKKWinirGeuSWimNz7V6lJ
         NJeYM/yOSurjvdSfkP///ZNaG6ORPuPBugdKLory9bwA0XOxgs0SVSr3+qHKvABLVw6/
         qFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712955462; x=1713560262;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUNcSQI0xOoqnByekA7ZjQthM0HLAdbAOP6aM15AG6Q=;
        b=shgkSxD2PnUKo2EqP4aReZK7nZj6FiQBv4QwFH/dQG/I8KR1/mt8dmTPGkQbFNTzkn
         xVmzoUHs8SBzFb09SzPKDawF8HBIRzRHGGZmh+id/YLCRm+XleStxqZDlN5M9w3KKGGj
         58+gi99w5wpshjVDV0Vf6SagbeNfFPmyAtl0zSiuwHW0+B1bFyW5FJ2zo5V8lYniRmcM
         j0gw6usITtLA+vr8DsE5cG0ZL6+0vBY0HKkhxuGW4RewspgcTsb44XODt91bz2HgSJs7
         qj+U76iiKwrUPHKw8jQq1AFeywRN1NOK9YFfv2x+qfFnpC3gtOBpFxNKR+Wagu1gxzKO
         SeRA==
X-Forwarded-Encrypted: i=1; AJvYcCXL9VgbWB2T7mm+oxW4PXJ0onKZUSW5KF3Fi2v+Y+2HHmhGx+K94AUd8zHFTyRQyOonkBAImgTZI7VJolOUv1LLE9738P06IwCWxGfM
X-Gm-Message-State: AOJu0YxuEzrYU2PTbILpAa1MjzGCeHatYJactxnRSJIhQggRmuVLSq/4
	Q5JEqtz5IOTJhb8oj82nkalGiCWpNqqpa1ONPOj5kVi1cd3yM7ei+plmpg+d
X-Google-Smtp-Source: AGHT+IEMUEAHNBJn4jyAcQ2c1UA3x2d1j7AyxgK9Ok5sT9YubwnGW7+CXDcC7dMjB1rgQE3flGWEbQ==
X-Received: by 2002:a5d:5482:0:b0:347:2077:53f2 with SMTP id h2-20020a5d5482000000b00347207753f2mr1422613wrv.2.1712955462014;
        Fri, 12 Apr 2024 13:57:42 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-64.cable.dynamic.surfer.at. [84.115.213.64])
        by smtp.gmail.com with ESMTPSA id l8-20020a5d4808000000b0034599eca6c9sm4989203wrq.41.2024.04.12.13.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 13:57:41 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 12 Apr 2024 22:57:33 +0200
Subject: [PATCH 4/6] input: gpio_keys_polled: use
 device_for_each_child_node_scoped()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-input_device_for_each_child_node_scoped-v1-4-dbad1bc7ea84@gmail.com>
References: <20240412-input_device_for_each_child_node_scoped-v1-0-dbad1bc7ea84@gmail.com>
In-Reply-To: <20240412-input_device_for_each_child_node_scoped-v1-0-dbad1bc7ea84@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712955454; l=1376;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=7hpHYy70ghhIyp3iV8DeFnaTe5tvDh2MTiU/M7Ph7aY=;
 b=iOhvYd8Tx/MX5bG8Bom4qyweZyNh5iP8JMZWhfDNufVK6fI1lrEM92B7AmfEtskEaLj8+M8SO
 j8WRHH0shWKDra1yP2SWX7dfAaBilNXZ83TJCJ5dBDNX0FslIjCdG43
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Switch to the _scoped() version introduced in commit 365130fd47af
("device property: Introduce device_for_each_child_node_scoped()")
to remove the need for manual calling of fwnode_handle_put() in the
paths where the code exits the loop early.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/input/keyboard/gpio_keys_polled.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index b41fd1240f43..41ca0d3c9098 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -144,7 +144,6 @@ gpio_keys_polled_get_devtree_pdata(struct device *dev)
 {
 	struct gpio_keys_platform_data *pdata;
 	struct gpio_keys_button *button;
-	struct fwnode_handle *child;
 	int nbuttons;
 
 	nbuttons = device_get_child_node_count(dev);
@@ -166,11 +165,10 @@ gpio_keys_polled_get_devtree_pdata(struct device *dev)
 
 	device_property_read_string(dev, "label", &pdata->name);
 
-	device_for_each_child_node(dev, child) {
+	device_for_each_child_node_scoped(dev, child) {
 		if (fwnode_property_read_u32(child, "linux,code",
 					     &button->code)) {
 			dev_err(dev, "button without keycode\n");
-			fwnode_handle_put(child);
 			return ERR_PTR(-EINVAL);
 		}
 

-- 
2.40.1


