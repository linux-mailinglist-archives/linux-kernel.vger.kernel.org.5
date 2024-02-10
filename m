Return-Path: <linux-kernel+bounces-60558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D458506B0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 22:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588191F213C0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 21:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1276160888;
	Sat, 10 Feb 2024 21:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VV/ZGUwd"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C082660884;
	Sat, 10 Feb 2024 21:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707602015; cv=none; b=NFgNgDDbhfX8lzedNIzD5wU8KMXlrDqJSsJld54Du/YGeMSO0mVg72xlsVNxx0OhoFa1wfb8m6tGMsEZNfyx/HYAmB1BV9Pk6GnuegPxJSrw+LJ0YET4u5YeArGM7hPDxu3q1ATen+zfAT6Wxa56Zdlie2JAaCx9vuMj8pet3gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707602015; c=relaxed/simple;
	bh=uZ/iEzHzCIhr+xNOOG6BX4XQZBvb2bh0UdKtK6p9C9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A4KwR/HcZkHYZ7SluVbHpAvkkTazo5+CO0xlKEk8ZsEpzgN5Eh+g6n9tQxwEU7GxErbvrzrl8A/sHYh6jzoU2AabVkHXtJpsuPCUVHOFqZG3aj679WOoeawtceA2R5QpNnAczd13lQMDJKGqOJ/+tHjV0UbL4XouHJlk8R+TPHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VV/ZGUwd; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5116b2dbd16so1896389e87.1;
        Sat, 10 Feb 2024 13:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707602012; x=1708206812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CE/tMEMANhtdsJoNIgspcl6/nRhH557LKBYohiZkZ6M=;
        b=VV/ZGUwdRZiQbR1RvL2EH/k2hiPaNhyjQ7W1WHPSDdyRfWePkUuk0YbwlD5ybLMuLk
         kc8rQzlCCuB058rPTXkZKTV7lxyi+o/Ob8iEskWQCSFOWVhNCjVPf52MWpANK3oPoWvH
         cBXCR5LVIHiaym6fjw6E6F1ACrjjl9R9RyWH49vrySZ0fMCjh/okvKgzLx9cMSjf4uP3
         /qlSUD5tq8wL53uK5bF2S+inPr3xocs+vduOD8qN0kp8fVh/ft3dI8bvMWm9e8Iebshu
         gsBsEt3+/8W5vgFbSDDtC1vtwxV1I3aJBFk16IRPYppFNieMUsHL5i9pfDAcAuIcsTB3
         D82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707602012; x=1708206812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CE/tMEMANhtdsJoNIgspcl6/nRhH557LKBYohiZkZ6M=;
        b=fRmTY0KnwmY596qwKe7dlwDv7OSyNII6URI7BXFcVv8RBBENf53k2Exm97BmePRHRe
         UBJzWzZTppga70wPydUuSJe2gnMTpC3epDCpBxXeYkMdtHsLvN7uztR4myjMzVh1F39u
         4tpMR49QFW+9UZlU1/eF5+mFXtelkH8Sc2N6pCNbTIli9dc0sxZia5W42H/i5KuKA1ZR
         N0Ng0l5God3HqSHFTV/Q6Q65D1ALWkWMD9YiGwH1JHmdDQ0iktdzoznZjlhSj36Lbidk
         rrBQIz0l6LpSOLvFZ+INZAjFRQldIXru19VzKb5CuBfEeVCde4Lh9+1fF8yvN5JUsmtP
         qS9w==
X-Forwarded-Encrypted: i=1; AJvYcCWb+nwvmtV4LIOVUnMID+HKwKfidZkdV+zsMPoBlAj1mSe4iA+v0xMhvAg6W6W1i7gJbiWdz8+xWMBzECyfvxIBEepQxuWRxx+Qy49lqjyk+VPl2P2PdHGpa3QgOgSWGBaisdCF3uyFjDQ=
X-Gm-Message-State: AOJu0YziS/ri408HFcVJwB0ReUwO1ARv2MM1NFnlqkId1Ma63qGho+qJ
	CZZMxdoe06oIVIm+oYDPpqeoAcOB+ZzPYqBqYDxRCb9aHXHXE6IK
X-Google-Smtp-Source: AGHT+IGBj3+WUy+pImZngNF3w0si/MoMZcVC0tyTqNTsiFYm7kVn4yav0KugDUPggUYoc6bsO8gjxQ==
X-Received: by 2002:a05:6512:7c:b0:511:889a:e3ef with SMTP id i28-20020a056512007c00b00511889ae3efmr96626lfo.5.1707602011842;
        Sat, 10 Feb 2024 13:53:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUZEqxMzhH+wqfPpTsjZqyH5h6GGyqVmixr1O7B/iLBtsEF+YAvIw12ixjWIiuXmjuH0/QuqJrZ3FkJeyChcylDHbQLSFiUutnNx6+k5JW+6Uu7RbNzl6PPsHcdeSj+2DlzsUdKlXph3xjW7SzQgdV9yS6lMmVMOCr77/07I4vpLrg4bvjQ/IHlrLpJoEL79qG1mZvz0KbSMjVcuPEILsooRZPs8ExRWVAV31yesXWukGG86K48Tvh7MkVShz113Vk/CSns5XNqoq6mueqJbcIY3NhA26ZmhWk9D5GMobBfZokHg7IwVRVIUSgkSrVJKRRcRTB+2JGqr8aW88cf/wyRRYcdtrnXDlj2NZ8MbtEzuxUTCRFcQw==
Received: from m2.. (89-139-223-180.bb.netvision.net.il. [89.139.223.180])
        by smtp.googlemail.com with ESMTPSA id a7-20020a19ca07000000b0051189b53f93sm24005lfg.302.2024.02.10.13.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 13:53:31 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: chrysh@christina-quast.de,
	daniel.beer@igorinstitute.com,
	jikos@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	johan@kernel.org,
	gregkh@linuxfoundation.org,
	equinox@diac24.net,
	michael.zaidman@gmail.com
Subject: [PATCH v1 11/19] hid-ft260: uart: do not disable wakeup workaround twice
Date: Sat, 10 Feb 2024 23:51:39 +0200
Message-Id: <20240210215147.77629-12-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240210215147.77629-1-michael.zaidman@gmail.com>
References: <20240210215147.77629-1-michael.zaidman@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The wakeup workaround is terminated twice: first in the
ft260_uart_port_shutdown and then, in the ft260_uart_port_remove routine.

We do not need to do it in the ft260_uart_port_remove routine since
it's always called when the wakeup mechanism is inactive:
1. Upon the ft260_uart_probe failure.
2. Upon the device/driver removal.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 63839f02e9b5..f8d4bf7e6c4f 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1124,7 +1124,6 @@ static void ft260_uart_port_remove(struct ft260_device *port)
 	spin_unlock(&port->write_lock);
 
 	mutex_lock(&port->port.mutex);
-	ft260_uart_wakeup_workaraund_enable(port, false);
 	tty_port_tty_hangup(&port->port, false);
 	mutex_unlock(&port->port.mutex);
 
-- 
2.40.1


