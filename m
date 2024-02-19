Return-Path: <linux-kernel+bounces-71198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6BB85A1E2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AC8128492B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE9B2D047;
	Mon, 19 Feb 2024 11:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1tWZsvP"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CA12C19C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341796; cv=none; b=OO1uMi/DAWunLjKY1igPKnW4jlG2ABFJ+vyoaN2igKcZmdUCkKaOIWr5ml0/YVHmqpPbbDtnj9CBOUzPKBMPM/0UltTgo5QUEmU5Y8vd9pFkY7fWCjMghTyjTe98M51bH2VnLMuCwpj5YAs1MpQ5ZBQwB6x59zt8e9u0+5F5Gyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341796; c=relaxed/simple;
	bh=iK0e+c0J9gt3ZVOym87zEAk44jIgYaxHSgdf2FUECRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jqNauk8ARJSJPuRGNRkAEydI+0khiU3jvDBCYTeQCNxIz5Et2snq0pPzZh7pEimaYpeAXe736UAxco47hpc45JJ9S21OvXV+vtewYznRYy3sCqs2S2XeeKSZbblX8Qp4+KBctxEFBQQfUHaaYnY39o4BDttwq3u3NRoBstM9OtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1tWZsvP; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3ea7616097so79126966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708341792; x=1708946592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmDgTWHbaX2qtPcYpGBlJHczQDop2U5oSFjT56bWXAk=;
        b=k1tWZsvP6+EhZF3EYQU9PdNKRjCW2fruMb/4VodJhuCKbaWaL4b7pFnfOxqfaD1+xj
         jpv/o0+IsGKugAvh559voarcZomM4jP25snDpYZq+XM1S7W3tPK+kC9hKIxKyhY9b1MG
         DsfjYXA0JslChqFwH5odIRbDkqf/LGkOZzlgLXdZb+EfoeZ79K7XlGYTAnxJT9izEf6e
         dakJ+ykZcDzoCnMhrI6yKclySSsRYkvAjxQXQ+Y2D2WReubj9DDy13xTuYh09Y0j0R94
         h1itVKS6ljipAp7RlVohh6GKeGiywHWYpXVa8BjpYdbKSnPyq+bNXX3wp99eoabK3XhN
         u4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708341792; x=1708946592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmDgTWHbaX2qtPcYpGBlJHczQDop2U5oSFjT56bWXAk=;
        b=M3H8sNV1aIUPXa/KWOatDJFOOC/rT6Bf+tPvgCWhSazc8VG550e27EhiaUrHWx28KV
         0IbTLc9nzJrwrYNFF0AxstdChuub+ONKr02vTDqo/+NTv5xc75jGyp9j15Q0W8jtOf/r
         DiEND3h18jdq14q16W97AGqK49sZXVvZi0CH7iCELApbEU3mUlfJHeXmOQsWG9q9VRRJ
         CEzur8FkvUR+8IN8olt1TxmlVltvKkU3iSagSWdkn2iJpbM5YjrgCciW7Pvo09oanZUD
         1F/mxypMC2mNkH3HLNqCeXIdgodgt7S4/haby7wIUiCsdSJpj/YnxIDWm7K8hGA2vdAm
         z8ww==
X-Forwarded-Encrypted: i=1; AJvYcCUqGLuoVrRFDYbRAwPEN2Gtk8x23+V2sC5orM0Zm/apDYTDuSdr9sbPCvdpmlXkOPNkhGg10QEWhQzL6lLSvSK5dUmXrUi4GX4KZZEV
X-Gm-Message-State: AOJu0Yw5Em/XRWEu9l6rLgQ1SIbXGxJ0cL9NsA6VHrxT1gDgNOBrkgUN
	WIAcGdZZCWMGL2TUxqKoVGH9ZrGPx0sYYb2G5jkvCMZJfk38tAG4
X-Google-Smtp-Source: AGHT+IF0+e8nNULuQdit5i/onzkhM2XG35UGS6l/IhtByN/m7Oo7XmQAuUWffmZBjcClq8nu1hedEA==
X-Received: by 2002:a17:906:2ad4:b0:a3e:19cc:16a with SMTP id m20-20020a1709062ad400b00a3e19cc016amr3606631eje.52.1708341792503;
        Mon, 19 Feb 2024 03:23:12 -0800 (PST)
Received: from pinguine.lan (ip-176-198-146-182.um43.pools.vodafone-ip.de. [176.198.146.182])
        by smtp.gmail.com with ESMTPSA id ti12-20020a170907c20c00b00a3d581658bfsm2826495ejc.24.2024.02.19.03.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 03:23:12 -0800 (PST)
From: "Moritz C. Weber" <mo.c.weber@gmail.com>
To: florian.fainelli@broadcom.com
Cc: linux-staging@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Moritz C. Weber" <mo.c.weber@gmail.com>
Subject: [PATCH v3 1/2] Staging: vc04_services: bcm2835-camera: fix blank line style check
Date: Mon, 19 Feb 2024 12:22:33 +0100
Message-Id: <20240219112234.8673-2-mo.c.weber@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240219112234.8673-1-mo.c.weber@gmail.com>
References: <236d985c-1835-410f-b0b5-cacbd5fbf930@moroto.mountain>
 <20240219112234.8673-1-mo.c.weber@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove blank line to fix checkpatch check:
Increase readability and consistency

Signed-off-by: Moritz C. Weber <mo.c.weber@gmail.com>
---
 drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index e6e89784d..e6ff5ea04 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -1006,7 +1006,6 @@ static int vidioc_try_fmt_vid_cap(struct file *file, void *priv,
 	return 0;
 }
 
-
 static int mmal_setup_video_component(struct bcm2835_mmal_dev *dev,
 				      struct v4l2_format *f)
 {
-- 
2.30.2


