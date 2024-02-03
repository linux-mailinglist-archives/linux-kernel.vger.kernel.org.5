Return-Path: <linux-kernel+bounces-51151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF8B848723
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1962B1C21863
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F115F86F;
	Sat,  3 Feb 2024 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="oiGo5E3W"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3E25F84C;
	Sat,  3 Feb 2024 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706974322; cv=none; b=aPZ4pRFKVIPGCEsT0U2sQ9GMs8i43NXt0ZGMoWXLMR9PDNXXumhdFff4E74avnj1SXJA/aEGVXb31CuKZrRWJQJw9kNs7JdksPuyMbkgu9dg/QrXqATTdzV07BLNgl3DaJLbzo5FnxJociYDWmatmrY1glq3ANUGjNvo3ncfr0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706974322; c=relaxed/simple;
	bh=OcdO4+Lmv5jeFYKjb4B+mP70CtkJZ7ufqOpuShyPo2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qHpjbj+2S+i0VhRXBKXV2IE7qQut8w5Xx63yTsGT4OcZwFDzMmjNep6Ip8GblgQLPZlMYHieQufgCXP2d8rCVLyBL42QlVSc6oMWllSt/0onYUe6E1fUzanztlXQUnKwqwmPvSRkZWVO8b+8o7Qo0zIFr8Yq9yXt7DOYDF3FBCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=oiGo5E3W reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d958e0d73dso14290325ad.1;
        Sat, 03 Feb 2024 07:32:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706974320; x=1707579120;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HkzC/4J1CJguP9SwF3o5ml0BgeYLSNx8kmjhXVsnB9E=;
        b=iGej0mvq/LvJabqsedujqI7VWVRIJsqY3ky6hznxE7AYiFAIzxb1IbqNXj7mtfsgi8
         ML/f3o2jdFwtl83BfM5VIVPAB9JJTJYDEQBN4XaDo9Nx0WQ+59FUXB+vPReR6aa/EYEr
         7UB3yC/6nuw3WHWXLuDsihftXLqw80NNXMwb3xo22gAOWaEixYxiXyex5fNK4wqxG9im
         +0+262nAniyjqv3CYKafjtpCGGpfYU5ILseWCVfik+ULj8HjQPpLOdS5WT2YH4dsAULE
         bKSmE4rXPgKIKoE8bo8k4T76LavU7oEaCGbQAe5m3j/gfuKS5t2hxpAp27lDgAcMspvt
         HOSA==
X-Gm-Message-State: AOJu0YyAPCb3S9+s3EpB3W6WeTNwZQMeIvs73q8xYVm4YD+C6I6nK+HK
	fKEr2UkHek9kGoC0d7ODY3sPETow2P0p4WQDYdqpCdG+YVR0yRt2
X-Google-Smtp-Source: AGHT+IGHWPOihH4W0+TDMHhxLH7sIs4raapMS0uWhDuNiv3zVdIIIJ0Hn5wELcdx60T82x25ljfwPQ==
X-Received: by 2002:a17:903:1d1:b0:1d8:d3e8:c322 with SMTP id e17-20020a17090301d100b001d8d3e8c322mr2696494plh.0.1706974320364;
        Sat, 03 Feb 2024 07:32:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWsbCWCbpMTZF0qmV7cjOaqJWm8aUEaOs3YMNfK0AWbNifZead2DBYemig4EyDFFNu3KuHJhn4iCg45AFB3H34sh4Tw8SAexk9kX28WsrSAPAn9DOBfynsQTpBOns1TrpJ1Q3cnI3hmwVSKaHxgEUD3ho4ky014N+wVIs4DqqeWAwWl8jF2PqlTKRvNmJLdc+feIXJGhmGawVuNE/O7OAL9VK4zB2JnCk9Wf+vVLaoSANTWzNcc/nBkaU/3vtiy
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902c15300b001d8fe502661sm3424915plj.19.2024.02.03.07.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 07:31:59 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706974319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HkzC/4J1CJguP9SwF3o5ml0BgeYLSNx8kmjhXVsnB9E=;
	b=oiGo5E3W4AAd0y4bbfmIKXG0KFVurh6RBcQoxKr1OF/trrTzx8Ru9syGGXjDCmlEgcALEd
	z+z01msOLrEoUq74b4b7bDVl62Yz+XIOVw1oB50edA3wp3yoIg3CIJnVOebPftiYYM4LC2
	MFvAx0lrVeKLAp9+o0smYFI4mTM16+tKaga1vSaOHWOnvmyZ8plgFthE2CIfL1isW6JGHb
	tjxUyFHKWzZtUKF5Fg4HPlvXUMYrS+aiUrxVMDCW3bjxuN1rURQzzQsjwcv6zqSmVWGEAT
	1OqdAo9vu7LM5J8f0vVhL2lG+is0T0L1V8so+1qfyloX0VHkHiISZ+Gn/APEGw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 03 Feb 2024 12:31:27 -0300
Subject: [PATCH 2/2] media: media-devnode: make media_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-bus_cleanup-media-v1-2-33e8feeab912@marliere.net>
References: <20240203-bus_cleanup-media-v1-0-33e8feeab912@marliere.net>
In-Reply-To: <20240203-bus_cleanup-media-v1-0-33e8feeab912@marliere.net>
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=953; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=OcdO4+Lmv5jeFYKjb4B+mP70CtkJZ7ufqOpuShyPo2M=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlvlyDdcnqcg+yRKKpg+tMvuurs4R3Bz0/X8TXt
 mdhFHwD/BqJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb5cgwAKCRDJC4p8Y4ZY
 piruEACGbgMP1negXyitmpiMwUI7wB9FY1Sb+qOZmuY4L3abJBCjoEpK3hYjeWfViC6/6Y/hVjT
 5BK9H5M//XER6BZ34tOS8MpkQ6VPMu01xdX7jY9Rt3dHJrdyvbUMyPVR72r58JXpXt5+JdFDbhW
 W678/WJJ90AXK1hRxRxmBpHahfOoomuXyNAnuMVnf0U2ExOkdde2/Rd7m65geMUfYPiUtE+Amha
 dFiIQMULu2OzDM2vlfXtgxunnXdWgjP7dE/yOI3z37s65T8ThTgsxubUziMbItbrJpXUFkrt2k+
 8uLP8uJ4RGwPML0uOlpeEREGgfTL02KhT7rUExtoWK7i2dqzVkGQ8Wm6mV009UbZqfqWnvLdm/i
 2M9M4lyVvT7VREGv7Ysq7IXu//P0JXWttdYpUwKV9eMHljFT77RwAzxiAtmd8O0zX6gjuUebIp5
 MmNQDcO4WNjAaPUo/J08MtkbY0/aVJkT15dlY0ZPYM4EkjxG6i3ArFEPUvUOOzf9JFHVQLYqc1n
 3A4ksuXlUW/aFjNo9Hu/mrq5yzGaD1ddtu/EgdKc3k0hcQQMrW7SYKCRBfQ7FyfJZaTWEzQTViV
 1kjI49vZy75+MsQ7UXNYbdu0xvpE1AHaXX1Do1HfVAmom7QQe45xSUB0N/1lN1fjV9uymq7Ublu
 tITzCWpTCq1XoYA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the media_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/media/mc/mc-devnode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/mc/mc-devnode.c b/drivers/media/mc/mc-devnode.c
index 680fbb3a9340..90646805bd81 100644
--- a/drivers/media/mc/mc-devnode.c
+++ b/drivers/media/mc/mc-devnode.c
@@ -63,7 +63,7 @@ static void media_devnode_release(struct device *cd)
 	pr_debug("%s: Media Devnode Deallocated\n", __func__);
 }
 
-static struct bus_type media_bus_type = {
+static const struct bus_type media_bus_type = {
 	.name = MEDIA_NAME,
 };
 

-- 
2.43.0


