Return-Path: <linux-kernel+bounces-71281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D154385A2DE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7CD2839C6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355202D60A;
	Mon, 19 Feb 2024 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="FH2S+qF9"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1351D2CCDF;
	Mon, 19 Feb 2024 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344561; cv=none; b=pBli+Gu78vgykX/tlywtVhZHiHFXvsAJPepAE9Zk/y0xq6wvwevIYhTXCZlKpOamxUo86UxTHLlt5uYBjazMzU4oaXj54zRVzbtJkaeXNsD/yDl7gZQnkaJDy+27M6UGDs8c6e8B3TqkeTxYo/zra7hKWttAsxFJmoJMX++UYpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344561; c=relaxed/simple;
	bh=n/Xlz/SBgwXVhZoy5rPJEekvOcaPleC+nTuQXoDe8g8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sJn8XGKNU1d0R+LdsPf2v8wA+FZQ4uKokppHWNBjOY9puuahZLrWw3UD622GwIhtFxhWfmxyaDrzwFiUzvNydows9bWMPiRh9dRLSRj0IkDJqUGMbrpw7msrfAlRwKsk7xqDj/lrlxaK/tLPX7tk7iA2/KmuJisVyObjYRgn9kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=FH2S+qF9; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59fe5b77c0cso269423eaf.0;
        Mon, 19 Feb 2024 04:09:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708344559; x=1708949359;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ka430INN0JYKTvKVdlUJ+8Xn+1ilhUkQuNdcEzZ/V8w=;
        b=IDSRKI4XcKE4wMySxBYZH3p1gJzOVFAOzWhsJ5Iz3bF1UrwQp4UXBRxgXW0sCyjAOS
         xkyIXHfUKq7ra+9WRsymEe5ZqEAaFleISEjGU2nirZLjsFMvWwDmEuFliAO0PM90y7hm
         EdghZdM02A+j/b9ZiI0kdV81QIzgqqmqF36pGzDI+dXP+3trpjHmT4X2NfcbM5aIHnT7
         38CJYYAGQVkGdyFA6v5/wmJn9zj3C21LpYMz3vt3C+X2I4yA8nI+XtD8ugiEQ/kxAQIH
         rvy3iSpwyDY0HPe2xlRDCPDQ913q1V4kAp7lkWXcJSIm9VmtXMkF1eepViUpC2JXdy3p
         ruUw==
X-Forwarded-Encrypted: i=1; AJvYcCVzhH1lqo5+lkJ9Iyn3nwLfMu1H+nE+ibQ4+2+f+tBKM/Z4MgGd77C3ylpFHpU8tdbXqwUFlUoNb0NvNZRxBoCBj/D+4UIdEu1B8dcc
X-Gm-Message-State: AOJu0YynNNKt4tw5qaZB7IhT34IzuiYRGW2eqtw0jWVH954lLmChkoDc
	mMffulMCJjpkBn1Ebq3FWAHqJA/OWJOa1oMOx2UuLiez1ciB+9ej3Lpx0Kq5WCgp1Q==
X-Google-Smtp-Source: AGHT+IGliMT1wn1dRuG3vdcdQbh7tRuMkEIHQWxtyTIEruwZMoRQAjJnAIbOiLWkH1bokh2F36pZTQ==
X-Received: by 2002:a05:6358:94a4:b0:176:6141:48e5 with SMTP id i36-20020a05635894a400b00176614148e5mr15153978rwb.10.1708344558802;
        Mon, 19 Feb 2024 04:09:18 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id e15-20020a056a0000cf00b006e3be1a64f7sm3256347pfj.160.2024.02.19.04.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 04:09:18 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708344556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ka430INN0JYKTvKVdlUJ+8Xn+1ilhUkQuNdcEzZ/V8w=;
	b=FH2S+qF9ze5bzSdwBrzty32k/ptTECr1Qz+Y6AOWdmVcU28oc2QRjwqXouT8kO+vOKYOdu
	1mTaxsexmmXefxWpRJXoRUrHksDjdZbitxr79DqMBAfLg7JaYl0cUUvfAZ1foS2yGCAnvw
	sMGfp7TcfIWYJ1GLRZy68qpuaIvumZzDJZsm9rm2EdJtNschH6bnCMLCAPXn0+GBALRWCA
	85b8R5q07ppVD0Bi/Y4gAyrL9Sr+pehucx9jJqn4voxswjHUZ7+t/W4Gyc74kDlr0geawy
	uWRh/5BXKl4oCAwTHAX9MYZnqcwGufSsqw6SYvdCNcUQCZcUD8RWsR3DjGhPJA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Mon, 19 Feb 2024 09:10:00 -0300
Subject: [PATCH] bus: ti-sysc: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-device_cleanup-ti-sysc-v1-1-13b53177d0a5@marliere.net>
X-B4-Tracking: v=1; b=H4sIABdF02UC/x2M0QrCMAwAf6XkeYG2DkR/ZchI21QD0pVGRSn79
 xUfD+6ug3ITVriaDo0/orKVAW4yEB9U7oySBoO3frbeXTANKfIan0zlXfElqD+NSJQy2UDncLI
 w4to4y/c/Xm77fgAnVJQwaAAAAA==
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1089; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=n/Xlz/SBgwXVhZoy5rPJEekvOcaPleC+nTuQXoDe8g8=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl00UaI+RduexGL6Qjo5qoqVK2JPy1OIqabFk37
 hrafRNyTQGJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdNFGgAKCRDJC4p8Y4ZY
 pl4ND/9yBbuwfQ0FG3FFfT2+FKYcaEA3W2Ne7SYz/gZmKjios4P/m4JPoPT0s5NiFR1+ttPAlxW
 cl0AUCQhiVEpAY/hu8tqF3SMS8rErEKqkUFPRKPF3Fa566jQB4/ahV1K2c+dWwj7dvg2MJVXni2
 GIrrGMgTSt4+3rtn7+dzdvEds5sKJNnJzCXXQxr3T8hRPXnSbI0+1mLDSZdgyYDYQy1SJTQK4Uy
 axnUpFT3Zb4aGeEJkSxWGBanjxly119JK3E8VZ3SGGggTSPkCqFGTCR3o7jRuGCr7srf28pRdCH
 LGDzxBuqwtYR3L+4TiisdF5+TzOkSqEde+1XF+M2FO8ENVo4GnM6ps0+hjX837rhcsPHZozutNi
 hyxuRbKDQOfsu6PBFVD54Cv0nmOqnukkG0m3blex0COXAKo8Icafh5JhDjy/i8kL7oxCpjEslul
 3euvESGScbxbbdHYo4yHplu7RHIxboftP5ArWlSx7jU1IJh8woWgDEEDcQdM0hXZF4RN+IeW5Rc
 VHGNDYdeE+JHsBA66NKfrZ8ISBDznObC+p22we/QpwJzjHn40pASV7/dGVQXXrJKGFZVecyiOj4
 ZXLmVMDs1vKZw+19cEVSpldc7oGPjH39S0NxTnlRPM0/M8OvlKLylnsyNSyQn4/Ge+zbQ+O/24V
 dlqkY76MeKKUS0w==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the
sysc_device_type variable to be a constant structure as well, placing it
into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/bus/ti-sysc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 245e5e827d0d..41d33f39efe5 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -2400,7 +2400,7 @@ static int sysc_child_add_clocks(struct sysc *ddata,
 	return 0;
 }
 
-static struct device_type sysc_device_type = {
+static const struct device_type sysc_device_type = {
 };
 
 static struct sysc *sysc_child_to_parent(struct device *dev)

---
base-commit: 0012c1958460386adc5770baf2f53206aed77ff3
change-id: 20240219-device_cleanup-ti-sysc-aadfa0ba7b30

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


