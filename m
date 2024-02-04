Return-Path: <linux-kernel+bounces-51873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0535384904E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0BD1C20CB7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552842555F;
	Sun,  4 Feb 2024 20:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="MEnh0IXc"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC7D25558;
	Sun,  4 Feb 2024 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707077769; cv=none; b=AKix2SQxIutm3LLso2VvNClFP8ry5bEqWgq6ZVxgSGANMOjCN8bRT0n4sJLaSOoqxWoNKCm3mQ6QzT6fzm/CZhHlzeI7uVgsarN9I300MYLakntIo7DYsQ3mwFSUhDyzJIWDfHP2l+8rYAkY+wQL2sa2mlFhbv9FbZfTB+hLyzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707077769; c=relaxed/simple;
	bh=7Rq8PxlzGAPzQXGlTqWX+/40pObpLsbM3cDE1X+m16Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=n+qKya2GbVXNSZEjtapUxDCUtA0Kx1W6pOl7Lt5KpjrHznXBvrBTsaaJo9ofq8NZbfUCDMT1ODblhBHHsU5pXXke5Vpn3wCEcIq3+ZpNmVtMyzq3XgCeHXAFnlJj0tqBKjSq00TJhtAroPSPdoC5oMf5KTl3ihn7nKVypMR/y90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=MEnh0IXc reason="key not found in DNS"; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2954b34ddd0so3162053a91.0;
        Sun, 04 Feb 2024 12:16:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707077766; x=1707682566;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ETesji2JsWKRveI8/fr08IQFkOxwNEgDGOoV8NmjSk=;
        b=JD5WHXYJaPKCN1xch7gCsb9he8GZpnZtlujXcPDbY7TMHrBL4iLOlRLVF90hC+Z3Ot
         PG9Yh/CpyTIG7pkQaMyL6o6Iq5elF7tE3NbbT0k7UiIOj/M+Guc2Mooytb9IedlyEGM6
         F69zcWrYhWUrqI7+e42o5TT82SCG5Yb3OMOdIcR3wtP3j4Xkxg5NNbpNwPVtgSbYl+VU
         /xIRrurIFJZKO77kK7lldVvZxF8YqXO3mGUIwCa7jBDdHYxgQaFtuyw3P6A+eSU3og8F
         rBG5qtKl0e0PiAl0TXKjwhaG0ROBicSxGuQnbTAqepdHtdj1XODA1U/ryLeEx8k2KiOo
         HVKw==
X-Gm-Message-State: AOJu0YywPSZai8R4uCgwAjCj4kpkOmov06b/8qCZIsvDkIVS2D3DiRxI
	8urttrmXKJElqTDukfSh7a7rS8uRbQ3nvM3EaAvmBsBtNENjKpzr
X-Google-Smtp-Source: AGHT+IG9h4nDNgh7TgtlxhSXQDPd3EXevAv0lyqjY590/62a9JLemRZtShyUVdF7KMbipIhdAazgKQ==
X-Received: by 2002:a17:90b:105:b0:296:8ac:ab65 with SMTP id p5-20020a17090b010500b0029608acab65mr10967798pjz.12.1707077766348;
        Sun, 04 Feb 2024 12:16:06 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX6rxBo6JzWsMMYRAqSW3OE2t9Z8gVxiFpJMPvY1DCIS/Cd1YDmDqCJNjB+djkUPIH8fWpzaWjEjkhHGwOecUreWvX2aE+orPA44HBFH8S1FdapTmZvGNsZwrPUsYDOpPdXV0DFyLCLqjKV+0/iZbbcgApzSY2/uCTG6G9VS0Hh+kHdMdRRgDiegYhvM/Lh5qPI8JRlL9uRYMRoIYw7iBrZoao3tZM=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id db8-20020a17090ad64800b0029051dad730sm3736088pjb.26.2024.02.04.12.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 12:16:05 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707077764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1ETesji2JsWKRveI8/fr08IQFkOxwNEgDGOoV8NmjSk=;
	b=MEnh0IXcd5Q2FcEL5hcbMo6Xjz0/7+tJ3DivDdH2ddVptqU/hA+k0Hpcu8ks0HrAwcHZ1S
	d+gl+z6hUmhFdf0yHO08g1gjX8OVxdo3zusGKBZH47J1aLdYUeKvroFHCeqnjwUjzZcMlA
	7vAJoC3Ifhaf1kmrXtIXdMNhip5vI4/89SKmH0MetJzGZES3Wbdb+m4Wbm7v7UNaXZk5Ls
	BH55/JA27vDzEQa4M7rlmajjdrtwmdGd/sjVS8jx23Sk0BvtT9XjHw2wBeO5dwqP8EaupK
	8KmqMD0EApkzNV+3fFnYnbs0RLi/cXakhDLUfQruFIAIKkx9BlrGGF+EXtqttw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 17:16:34 -0300
Subject: [PATCH] netdevsim: make nsim_bus const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-net-v1-1-704b36d75901@marliere.net>
X-B4-Tracking: v=1; b=H4sIAKHwv2UC/x3MQQqAIBBA0avIrBPUTKirRETaVANhohVBePek5
 Vv8/0LCSJigYy9EvCnR4QtkxcBtk1+R01wMSigtlNDcXml0O07+CtzjydvaSN2Y2aJsoVQh4kL
 Pf+yHnD/TFnnqYQAAAA==
To: Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1105; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=7Rq8PxlzGAPzQXGlTqWX+/40pObpLsbM3cDE1X+m16Q=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv/Cjxkgbf03s9WRTpgsdp+2LV6z+KktfTH465
 SppD8pxRaOJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb/wowAKCRDJC4p8Y4ZY
 pvlwD/wIXdwJu0Y88ga1UXVVMm7UXgadezW9LIru2jrsGW5EK/dhULYLMuE3thNtJnqeer//4Ef
 dd6eZnaHcFW6wQVdhyl5TG3I0QULespngtMHINyz/MxrmbM7Jgr5/WLJUE8UUgvrfdK0jILlBSD
 rOvXlPd04vziQJuVrJcBl5H25eyTRr4BYyARspZqihLScp/pOdqkuZA4SaiMOwdBoJa0PvlWTYE
 IGHzAu1Xnq7YW8rBjnJj6nVHDXei0GTRJPVrYndj/AX/9rsFHkoCezNKdLIKfZb587EopPHiWHw
 Nldp+LYw0Ad0vyuQcE8AxHjgkg76EjtRv5PBZb840t6ZjephugRaym+2M6ZW7awVKTzhITNA9kY
 fsidbEpSwraxe72DpCvDoM4JmEWp6eSYXWr0wflycQAv2pidm8++wIgC6CbIHd2Ne14zfbr0co4
 JC18p3V6pbbBfQlwngmFnh8AObITEFrtaVtLVfy6Spwz2rvkWoD0t/L8iL/9ysI1L3NgUQaTq1m
 ZwugtSn017AXDs2nrj9vDCkMZ9W+jxK1CfcyK4FSA+j3WjMJVp89umNB+jDBdN6ox9ANawp35WH
 rzYScVm7+5oRR65w3S1P2s0PFOcIz91P4lwW0vBv3Ic/AqU3prfEfu9LeOZYD3DyNGnVm/9T7Sx
 C9MXfq09sooruUA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the nsim_bus variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/net/netdevsim/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
index bcbc1e19edde..aedab1d9623a 100644
--- a/drivers/net/netdevsim/bus.c
+++ b/drivers/net/netdevsim/bus.c
@@ -260,7 +260,7 @@ static int nsim_num_vf(struct device *dev)
 	return nsim_bus_dev->num_vfs;
 }
 
-static struct bus_type nsim_bus = {
+static const struct bus_type nsim_bus = {
 	.name		= DRV_NAME,
 	.dev_name	= DRV_NAME,
 	.bus_groups	= nsim_bus_groups,

---
base-commit: ffabe98cb576097b77d404d39e8b3df03caa986a
change-id: 20240204-bus_cleanup-net-9361456dbe19

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


