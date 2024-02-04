Return-Path: <linux-kernel+bounces-51891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A982849074
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EEE8282833
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA242C69D;
	Sun,  4 Feb 2024 20:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="BIh6SZQ5"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050402C689;
	Sun,  4 Feb 2024 20:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707079680; cv=none; b=Gy9WCQ6KSc7QUJgmP30XVPxAQbWVVYFKaAR0x3j7dhnsX+uUkRmGkmLjLwStCexdaRU/bE3P6xL2cC31V3wgUUoEqMoB+Zk3wp6dEZwqYsvBrr4PoqrqLMEwoG/AqRX5ue7VHtMrxQU/SRJKTihI99FHY801cKTJM0UYSargSU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707079680; c=relaxed/simple;
	bh=BvgTYMXZSIoxQCB+6JoHcivSv9aP3kClw8rXmKKzv0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=n/keUEnLtP+XTce8+1WrLPx/ie3GzLshvsohan8z9ebCfSU9bzRwW0lVXClLpdW+iAPxyp/sHC28wJ4Kz/N8onjJGoih8YjQmkAK7mdCRunrJtiVfxLYfnCmXSOsdGm3Rb0XouzaphlxZu+1TTti2cizLMDH/7CqaGrpuGvYPbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=BIh6SZQ5 reason="key not found in DNS"; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5dbf7b74402so1699000a12.0;
        Sun, 04 Feb 2024 12:47:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707079678; x=1707684478;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1lHSLWchQmcMmj5RG0k11AC5ovrjd0r3IwIbUyaorw=;
        b=MSEUrpQ8aozXfGrlb1t43QImQ2y38CrmWxbFMz9oZgkdOlUfMBFadQc76K0BU7okaT
         sZ8+vlPnNKyODvZQ0ISoT/zPWoxq37emltGWDdnkmRnbk4FDoj8if8SZYZsaVHc26WJJ
         ftqjMLU9M3nG0Lz49Id3c//nhpnELA1jWySbnM7KmgEjtfQfwolZWUJz8+Cjhw4ORP5u
         amViX7Zw6nJKoy3pNTvzTuj22qb9is1tnxtcAxvI9yZuWfVWt4mr8E6NKczk6b80P20p
         oQHRVl7bYmvTtKNHE2Zcc4z/uAdmUXJANe4RUDlo2PmkcLp0rVRMFCEKWyrcTncfO2+n
         DFXw==
X-Gm-Message-State: AOJu0YxDaDOdcuEPq9RS0sWR0NAx2wMt3BJMrijuERrHrMAWVALTT/1R
	P+6cicEG6pcN7WJQ2FhgR8dzIKhDMkgwYFkwNToICYCzygK9pnele1YOCGr8w3fJjA==
X-Google-Smtp-Source: AGHT+IGk2Y7ThNwAjEDJ10ZnJJxT/iIrxt1aLHyKnZ2j/nnQ6gSFdYqpxa9X/FNuGJB5L7kIx7LRGA==
X-Received: by 2002:a05:6a20:4393:b0:19e:4cd8:cc4b with SMTP id i19-20020a056a20439300b0019e4cd8cc4bmr9964872pzl.2.1707079678178;
        Sun, 04 Feb 2024 12:47:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUv7tLqaVvqXgwszjVRH1m4YlisMO9XAqq+uveBIDkZFCd9no27+Q0HgtYzoTPPnu8LgUPVPZeBp4jxZTjiJcb0YUuanWIo19zqZZjRbmgFNbIyygm0Ukupab/EWLW3wzY27gaKW8WLi69bgTDSMtcby5Fdg3u6HgIqzNvzX+CfWzKt+LPDPA==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id lw10-20020a056a00750a00b006d9aa6592d0sm5183492pfb.82.2024.02.04.12.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 12:47:57 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707079676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B1lHSLWchQmcMmj5RG0k11AC5ovrjd0r3IwIbUyaorw=;
	b=BIh6SZQ5MBAU7PI7HZLle/XX7cFC39Ah6+oicF5i3txyQw72F75SRwqK3/fDGwKD0IrcZm
	PvTBRPT1O4HZUo8Ut3zHd8D+9Z62NgIW1B+PPQQ5WOPxZ32WcYJNCE1BIwkEAcl+2wDw1I
	/FYJRqmoha0KBtuBsbBne7zrehfYHp/JD4UL0uY5TN2jMhV1j3OIzIDzGz9xxE9O2ko84v
	cpzx1iP7Lavcz6sHyi+ezfXR2Z1aiPUX4bG9NINNVdHveMtoIaNjOVn80GPuDj5/HadT0H
	GLt/+GiaWZ6hhXbq2iP7GjuUpsKeJn0w9JcfZFNMk7uFWNu4w2TETKbeuqB89g==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 17:48:26 -0300
Subject: [PATCH] scsi: tcm_loop: make tcm_loop_lld_bus const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-target-v1-1-96106936c4ab@marliere.net>
X-B4-Tracking: v=1; b=H4sIABn4v2UC/x3MTQqAIBBA4avErBNMK7KrRITZZANh4U8E0d2Tl
 t/ivQcCesIAffGAx4sCHS6jKgswm3YWGS3ZILioueA1m1OYzI7apZNF7S1G1kglzcqVaZsOcnh
 6XOn+p8P4vh+ClmzmZAAAAA==
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1291; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=BvgTYMXZSIoxQCB+6JoHcivSv9aP3kClw8rXmKKzv0E=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv/gbvhed3/Ty2DECc/ugIL2aG6nIk/Q0/+HeJ
 2ghFk9UgeSJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb/4GwAKCRDJC4p8Y4ZY
 piYVEACeKqHuYgAbozlEv9BOz1anb4RQdAazoMXwG5qo1B1M1m+FxyH3FghJgjzrMCpEKpmzVjT
 0e7/dVpf7zt61Ke5VyOTzc0ZmFUjgbm/6Q8/KFMFpiAzAoepqXQ+uvhwUmHHZ/44UjiFO8Na3W0
 XJsVDgZ2ud0NnLIsYr+6HfQ1Wv59kFRPrYdxZXK1CaWKhMQfrdnfTjVwTSXC0/MkQfP+Ek4TeOc
 8CZla3+tszyIkknFfm7ApaTKVNacTL77R5GCdqUFo+1tM+hf1hAPViu+AifD+hbI2oy2JzTj8E0
 A0O2GyFKUpovnzMHYQ7W+NNnUuk57FfzE1PGlGToSudafHqEsMzCgDXKfWo9nPaO1pZMhSG3mA9
 dNayyZhkn91Rxz4Pk1P1t14KLsVjDXW+wsMJEnOKxXZDxtkDcqkpTEDXiN/eQLGNnDHytaaDVY6
 vgIm7kh6Muolj0WwLX6XBLCHw/bj718IdorAsURadO9H3AhRut2PQJVbMcn0B4pHF7Y1Sgba9Fz
 BArGIia98kxiHTw9R/wuy6Yeu48HqfBNeWDnJSXdoUSzMKp5L5C/9uEC/5zjdTxOEtbaRNFWytz
 9790FXVtdIbBVmkB1coUv4pRsH5CGyXFa5gN8folHSE0WsomUcvHJ+ldVAxsnEjLppKSyHrUpKy
 dkfEjN2qLf3KjWA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the tcm_loop_lld_bus variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/target/loopback/tcm_loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/target/loopback/tcm_loop.c b/drivers/target/loopback/tcm_loop.c
index 8e4035ff3674..761c511aea07 100644
--- a/drivers/target/loopback/tcm_loop.c
+++ b/drivers/target/loopback/tcm_loop.c
@@ -83,7 +83,7 @@ static int tcm_loop_show_info(struct seq_file *m, struct Scsi_Host *host)
 static int tcm_loop_driver_probe(struct device *);
 static void tcm_loop_driver_remove(struct device *);
 
-static struct bus_type tcm_loop_lld_bus = {
+static const struct bus_type tcm_loop_lld_bus = {
 	.name			= "tcm_loop_bus",
 	.probe			= tcm_loop_driver_probe,
 	.remove			= tcm_loop_driver_remove,

---
base-commit: 3f90ac7138edb995b4312221647b58afcc15ec06
change-id: 20240204-bus_cleanup-target-5393cf09c658

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


