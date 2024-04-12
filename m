Return-Path: <linux-kernel+bounces-143344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9FC8A376D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 602721C20F73
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3DD152521;
	Fri, 12 Apr 2024 20:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1CjdNeb"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF79152183;
	Fri, 12 Apr 2024 20:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712955466; cv=none; b=TkzwhMSP+q8wAPa22EZbh4CM1c8DRMgkSIrWd6I6aTSq6bv+iijwSfB5PNNiQIj1sLo2e77AB5KMpd7ES7ny3kkCm8TMhX6XQ4HCVEck0pKJNMipeax+jS7z4WDnfnVAMNsbD00+dldkwnHMUfgRVKB3BCO7RD8Hpdl2nQw9trM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712955466; c=relaxed/simple;
	bh=My3kxrpMXWIXShvJZrEj9tARXzpifiSRwitXLmhirj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BiZemhJgpi1g6j/ctPL8lBFIplt9Rdqst2rT99D2DT6d+q2bvUQUA8n8eRFudnqm8B7Bm1vSauyfh/QSQNKPgNOjVuAdkJa2HvEbD3/XFA0BgVSoQ6U64RSRHoX2pCxLcliE5Ks83n75jCv689li8ozjQu8ALrMDpNAejznQCxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1CjdNeb; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4155819f710so9348305e9.2;
        Fri, 12 Apr 2024 13:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712955463; x=1713560263; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+/w4DYQqdffdEqyUdCKkI4m/zBdQ+Y6o/WPdaWy4CcY=;
        b=F1CjdNebMqTOCPS0tYOiEERSnFvPf1I5J4P/zlJ9DSO6WtZVqeI+VCDzu1fTiQe2KQ
         DoWtgP9VrwZrPcvE+WxNJoBTcmiFQCcW5i3m07FEibkyGXNPogwoQpIgCVGbAXbHN4P/
         vDr7CNdLSExuuTlvstxPF+RYqqV0xpITSDlwYJJtJF05p9ThgvHNf+NVt/28C7rgA7j9
         2Z4Wlg+EKqrETph6lYaDK94YQBWfEOt/Ka40TPHWlMxHiQFwM+XSiuXMK/r1BK2LWKNY
         muOz5GzbciqCebwZoeux0Dae01hUjQnBO7SQgyyXFTwZe9Ou6j/p1Dz5iEKLip03rR3o
         0Q/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712955463; x=1713560263;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/w4DYQqdffdEqyUdCKkI4m/zBdQ+Y6o/WPdaWy4CcY=;
        b=oTQoOU5rppE7UYpQ4w38R+nFg7dKNtz1Sl7lQwdderFbUHBR9VakBWm6KZ9mx6/7Lu
         53v55M6lfzDAbRa7Kbfmda0pagjyRn4GFucHc7IFs8Ct5klMJXEsWRgAKhWWEiaPLAJW
         w3ZUkrbhTA8ME0/DXw/UAVEWxY+UKhDfKn7YPdhLdtq1V2jPhr647I6iEZtMzyAvJFu8
         Wi//u3XfsUX7IfgJEwLp011goFjHotQ8VUARXsqZtR5R8JPXjWhRdUDl+UX5F5QBggqz
         Twl1Po885uJguzU46h9Z2p6S8M3CMkUR657dwlnkd5joqbD9KikPO1jha9bbuaoOcRE8
         iKiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsir5+IkgbkjrRn3ARXFL6UYb3f9wfcCVrJvbQejDZEfIVVQKfN2pi+PRzoZtjI7HEe+vyAzHeXPvtfA4BEiatB2K53OKLeg0iRhiF
X-Gm-Message-State: AOJu0Yy6tCVqe+m+jVr9yTifY+yrj7Zfn2VUxSvQEleenK/9l2nRSyGe
	IfZ22DiPkEeFpS6B6pe40x0rdL4ugam1j0QSRTbcNwGiTcpdUcWI1rnFRs27
X-Google-Smtp-Source: AGHT+IFkIN/k0BMfai+sd93S2GLt3RxVOGKdgpADjsWAq2n54kZwNqV+27tQxVYUaIwddryC7yAZuA==
X-Received: by 2002:a05:600c:1e8c:b0:417:fe3d:8ada with SMTP id be12-20020a05600c1e8c00b00417fe3d8adamr2575890wmb.29.1712955463332;
        Fri, 12 Apr 2024 13:57:43 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-64.cable.dynamic.surfer.at. [84.115.213.64])
        by smtp.gmail.com with ESMTPSA id l8-20020a5d4808000000b0034599eca6c9sm4989203wrq.41.2024.04.12.13.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 13:57:42 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 12 Apr 2024 22:57:34 +0200
Subject: [PATCH 5/6] input: adc-keys: use
 device_for_each_child_node_scoped()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-input_device_for_each_child_node_scoped-v1-5-dbad1bc7ea84@gmail.com>
References: <20240412-input_device_for_each_child_node_scoped-v1-0-dbad1bc7ea84@gmail.com>
In-Reply-To: <20240412-input_device_for_each_child_node_scoped-v1-0-dbad1bc7ea84@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712955454; l=1706;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=My3kxrpMXWIXShvJZrEj9tARXzpifiSRwitXLmhirj8=;
 b=IzjblgJnSVu11PE3U8HypEVhIu3/viMAHE0danzlk+ERonN2/D/K9Bdsj9AXbNXdv+W3jeGq9
 80P1mKKnzT6Dc7rzjp7FOyqQ5ygraawqMIDA+4qGG6ocqT45unBKHFG
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Switch to the _scoped() version introduced in commit 365130fd47af
("device property: Introduce device_for_each_child_node_scoped()")
to remove the need for manual calling of fwnode_handle_put() in the
paths where the code exits the loop early.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/input/keyboard/adc-keys.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/adc-keys.c b/drivers/input/keyboard/adc-keys.c
index bf72ab8df817..f1753207429d 100644
--- a/drivers/input/keyboard/adc-keys.c
+++ b/drivers/input/keyboard/adc-keys.c
@@ -66,7 +66,6 @@ static void adc_keys_poll(struct input_dev *input)
 static int adc_keys_load_keymap(struct device *dev, struct adc_keys_state *st)
 {
 	struct adc_keys_button *map;
-	struct fwnode_handle *child;
 	int i;
 
 	st->num_keys = device_get_child_node_count(dev);
@@ -80,11 +79,10 @@ static int adc_keys_load_keymap(struct device *dev, struct adc_keys_state *st)
 		return -ENOMEM;
 
 	i = 0;
-	device_for_each_child_node(dev, child) {
+	device_for_each_child_node_scoped(dev, child) {
 		if (fwnode_property_read_u32(child, "press-threshold-microvolt",
 					     &map[i].voltage)) {
 			dev_err(dev, "Key with invalid or missing voltage\n");
-			fwnode_handle_put(child);
 			return -EINVAL;
 		}
 		map[i].voltage /= 1000;
@@ -92,7 +90,6 @@ static int adc_keys_load_keymap(struct device *dev, struct adc_keys_state *st)
 		if (fwnode_property_read_u32(child, "linux,code",
 					     &map[i].keycode)) {
 			dev_err(dev, "Key with invalid or missing linux,code\n");
-			fwnode_handle_put(child);
 			return -EINVAL;
 		}
 

-- 
2.40.1


