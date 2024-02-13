Return-Path: <linux-kernel+bounces-64073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE988539D5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F59B1F222B9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F66605DF;
	Tue, 13 Feb 2024 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDGvgEnm"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2D4605C8;
	Tue, 13 Feb 2024 18:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707848682; cv=none; b=CN16EdBFG3crWUhNXesW23Xgm56uYMgT3+W9SDvA3So2cNRtUMI+Cv3OzKhg4u/v0Fy4S8MfDiY0sSJ0uD22OfgzndC71L5iwgKQYNVig7vONI9phbWwUYpf+g5Q7xbNTZ2yXQpfDqCUM+DS9uqMPIeha06uZ3cmnYZN27DBRSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707848682; c=relaxed/simple;
	bh=Aw4TgiV4L/Ax6GgNOY3EQ3AedNdMnqShmp1jU+WV4qo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hoT5yL2Zn08z09f5oWlZY/LoYzTEl70c2X0YD219b4ZWYAnawkwhYKWcg8GKTAT6vYflWD9t0cYuYicKqxrex2YmjVtOMN1buoRDRDyA0iWLVYDrUt2FHNcIJazaqrklbsDe+qBT2C0c5nH6GcYJ3oCa1NNa+rtELvMiy1EXmv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDGvgEnm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-410c1ebf5e4so21500645e9.2;
        Tue, 13 Feb 2024 10:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707848679; x=1708453479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OQ5S/P9o6shLLmwJu/RxB7GB7IC8YbWNZ5o+W4xta3I=;
        b=EDGvgEnmCYcYPCfp5Zlmumn6W2FnMchTSnFb7cFcTC/rdQdQe7btG0Urlkuw01Ikxt
         g1dV2H4ibwEX5Pg2DTgv45UsSj4tyAbJxiK0RY2Ngg/RHr9jRH3MDyrNZh5DbW3L/D3l
         OqTEwr9rbsoTzCbE3NB8KQAbuRKvInk2U8TbCM2DR2AHrK58Qjp7l8CN+/9+iJpba4vk
         y2mi2WhidqtCKYAVB6aCdz1BHJ7ULHQNzJAYJ3/IRvOmLHpzJnBkya8+MiOG5Z9G0+wj
         igRA5pr0/XTZRiyCwWD+qPLH8waeOfvteWSWY3PCFp83V2y0V/Ucnc6ePJcU8MfqYdy9
         O6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707848679; x=1708453479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQ5S/P9o6shLLmwJu/RxB7GB7IC8YbWNZ5o+W4xta3I=;
        b=Vr+UEE/w69Il/ShW8jG4YWnjPTb8lJY/itcRyAmReKG84VXH74f3oraqOLC5e844Jq
         dEN3wHiRrXBWNku7AjuQ6y8a+/5LCS5bzsGLxh2IYJAs2c/xBxzsf49/Nwf/LJtWFoCI
         78iqRt9ymTs2euIYia36KWDeFfVkLyeBrpgEIJzr0mfsNcTGJoCcEu5Ymvxuxpt3YQCS
         TDr27QIvQd1xysjhhvtezue3oCYplCIyFEwzecgz45+/Dcqy696ZLzdLwG2KSZnND6PF
         ZJ1pNlbtA9wqI+K6HKJSzN/wV0PtajfTx5CLH7a6mc4uMy2g+UE0Bck5zDWh7I5mQ8Du
         Ddkw==
X-Forwarded-Encrypted: i=1; AJvYcCXrM8lOnCDWWYLUTJof91Pq3yxm23rn7WOV966E1Pl2JpoL4c9Mh9cF+cYHimfThzjdTKDaD8v++TTVuFLUmjtBCGuE3ONLJ5udY1FJX9DC2lQQyhOsvAGr1NbvD5aGReGCpRUm
X-Gm-Message-State: AOJu0YzQTXifGcVRSPsISV+ryLa9WIxuSq3VdLiWbI42KSyKY4nK1QN0
	6gbUbZSD0/BuZyrzlLl1hc+fQA2DaHj32Rq3KVqzz35DjWYb2LjlUgZADtxTrJc=
X-Google-Smtp-Source: AGHT+IFS2StKhLpfkWuEP2L72+74L8r1uhJ/sIkJoNSMcCf8E6f0h3uObO6AKvyl6mJNbWWHBxDNGQ==
X-Received: by 2002:a05:600c:4e86:b0:410:e201:bc55 with SMTP id f6-20020a05600c4e8600b00410e201bc55mr391992wmq.11.1707848678509;
        Tue, 13 Feb 2024 10:24:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWAhwf+gqbnRrwi7gbKHhk0NUmawgJ9Gx7wMZFKt77THPQn1fHSSKRHqxs+AcAbDJsGdgtJ/ZG+xjlgjDfp8z/Lw911Sl2LynlVIO/KBmYgMzT8/Vp9oTfC2OckRD5J6GHwSM9pQDEKmitEGSgoeq975i9CJNHAkS1rCL3ooccYecoT+rYmzxVpx5/RV3A+TXMWdm8zarzmpnfd3WqqvSQhflyv8cc4dTSwv18Ov+RAVtv1yql7SHkujtgue/mG0TPevPCYv3ipAXNx1xLbdMjQkLfN7xkofbAXRgOajWUa55ybS/PqqfqOtnFXYMJ+SY8IsAlzljizG+KRNbdYuYY5QHQmOcm8yT7xrCvZCNBHcb5S8I2+Y75KgCLlwhtT30asI50CVd8=
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id bs25-20020a056000071900b0033b45bdb2a1sm10347974wrb.4.2024.02.13.10.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 10:24:38 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robimarko@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH 0/2] net: phy: aquantia: fix system interface provision
Date: Tue, 13 Feb 2024 19:24:10 +0100
Message-ID: <20240213182415.17223-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Posting this as RFC as I think this require some discussion on the topic.

There is currently a problem. OEM multiple time provision Aquantia FW
with random and wrong data that may apply for one board but doesn't for
another. And at the same time OEM use the same broken FW for multiple
board and apply fixup at runtime.

This is the common case for AQR112 where downstream (uboot, OEM sdk,
openwrt to have the port correctly working) hack patch are used to fixup
broken system interface provision from the FW.

The downstream patch do one simple thing, they setup the SERDES startup
rate (that the FW may wrongly not init) and overwrite the
global system config for each rate to default values for the rwquested PHY
interface.

Now setting the SERDES startup value is SAFE, and this can be implemented
right away.

Overwriting the SERDES modes for each rate tho might pose some question
on how this is correct or wrong.

Reality is that probably every user an Aquantia PHY in one way or another
makes use of the SDK and have this patch in use making any kind of
provision on the FW ignored, (since the default values are always applied
at runtime) making the introduction of this change safe and restoring
correct functionality of AQR112 in the case of a broken FW loaded.

As said in the commit description, one thing this handle is the problem
where the FW is provision with 10BASE-R while the MAC supports and expect
UXSGMII.

The AQR PHY can correctly switch from one mode to another and I think it's
the most common case where one FW is broken.
This might be the safest change but again would not give us 100% idea that
the thing provision by the FW are correct.

Another idea might be adding a property like
"aquantia,broken-system-interface-provision" and with that enable we would
overwrite values with the default one.

Christian Marangi (2):
  net: phy: aquantia: setup interface protocols for AQR112
  net: phy: aquantia: add AQR112C and AQR112R PHY ID

 drivers/net/phy/aquantia/aquantia.h      |  17 +++
 drivers/net/phy/aquantia/aquantia_main.c | 152 +++++++++++++++++++++++
 2 files changed, 169 insertions(+)

-- 
2.43.0


