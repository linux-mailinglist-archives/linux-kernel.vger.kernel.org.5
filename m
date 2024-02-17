Return-Path: <linux-kernel+bounces-70051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6689859258
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D90FA1C217CE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 20:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B6F7E779;
	Sat, 17 Feb 2024 20:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="PpgtROzV"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6101C2AD;
	Sat, 17 Feb 2024 20:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708200779; cv=none; b=XUEFsSkdf6cI2AVXhVTmpQPvUgMhx56VLIwQeKJiVHHKl+fbLKxL19s29x/yOKQs2CFJsU5u3f8C9FmfzYebBKBA4LuxSomZkb1WsuXcaBuWkpC12bS/RHsHPsJ7ovN/ddLV0wTJ3ivUInzfo/G7PJK0ZKVx898sJC00gvIkz4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708200779; c=relaxed/simple;
	bh=8IktCrsRC+hlS8Myl1fdnPGp6EP8hC9J1haMpC61SOg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EJ+LqCsJx3KvHsmvKequ1sCmeBzhrxZH8MTPy7O5Oj05Il79TRBa/6WXOpsuq4hyjKar+Q1i5ugjm7M2evcWh4udsV9GdneS8dLHoMsA/myTQbSCbafKZeOPBGG0nZ5zwhxa0KLxhFi4AsgRQ9t1ZuHPc/gdpXyMgnewUfO+DYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=PpgtROzV; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5ce2aada130so2720515a12.1;
        Sat, 17 Feb 2024 12:12:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708200776; x=1708805576;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g/RyA0owvp8Vb/My3RmXXVsAxzzWZv+QMQ3rufBIEHU=;
        b=wVFIYjYjXy8jcCfU1qmxLy0OF7PL8oWsQOT6Ba2DtDGsZWUzJwvJ6meq178cVxdb+6
         sbdxIWsV2hc3Qw0A/RjNTr9zw470f0W9di4X0RZqAXfAW2Egffmo7TqlJMtlGJ5k1umV
         fhX4nUprpvIibOtYv3pJoWuxDbjSdrgxhNkgcNMtOpcudjLF9CkkA1z7O3okeo27mjOB
         inX2V8aPN6t7CCSv33eVofbWeZd6u+JFSV2ht7yK3Q78UN8IDITzH3gS+Xddj4xC0S++
         A4YdnjIQn/a6cYAMVj8rAcrSRC0F36ZAh9Fc3o9PNS91pfHEkhCGE4OIV0TGObLIHVie
         UTgg==
X-Forwarded-Encrypted: i=1; AJvYcCX47UD7CdwHhVtIeOGrVAEbmeJEY14Cnn4IplSbYdnkEtfRT2FLKkgSrXQXtLP0lKq9ibBB8V8aUf98FFwRnbsfnxuyjPehPgAFxoMQWcAED6n8Nq7t8RFhDclHznMjqjpSPxoNuOz1pRNTFF5Njx3Ug3kWV9hZfw6iAV1lnB0SEIdE
X-Gm-Message-State: AOJu0Ywp66kfAX6daFExA52VxrWdfecTWMJCF5FiJM89pnB8zZZ9u5cU
	2YQuZrl0B1ORS5cK2mdm2Ds0ta0/K++reXdF0Xl6TdINi35oRkr9
X-Google-Smtp-Source: AGHT+IFFR+WvQ7e0onQtY4dZ6AcQhZ1Rlt02QSaKR9uAScQLp0C1KkbgTsK80QpcwvYKNme/Donw/A==
X-Received: by 2002:a05:6a00:1822:b0:6e0:3939:60dc with SMTP id y34-20020a056a00182200b006e0393960dcmr10299722pfa.23.1708200775782;
        Sat, 17 Feb 2024 12:12:55 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id p4-20020aa78604000000b006e363ca24dcsm1281725pfn.67.2024.02.17.12.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 12:12:55 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708200773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g/RyA0owvp8Vb/My3RmXXVsAxzzWZv+QMQ3rufBIEHU=;
	b=PpgtROzVu4fxgbA384MRbpgF+FeUxvP8j69pOojHuzqDCqIqQWZAAotSr6WCDaghpufBWq
	CtcU/JmiMs83KsjNV+6Pc/65LIZYHZXMmu3coO35DMVT/Xfhn8/qAJ18pq1f7OS6J14WIy
	RJj41euKpj9DjqAjPwn/iGhlI4c2ITpRFw3obJnCCAI5C1hxFMYVGFhZx2Lll2HsFiiffd
	PIOYWf08hcY7hCciMc4vKtBzJPdq9TyrBZjCo54PbUwAKxiTLLURggX58EPJPO6eeByLzT
	+WlALkmmx9l1mDlB/SxmRZto8d1GKF57eNnkfcU0QASkZ6I7u81GBsT8nNZheA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Subject: [PATCH 00/12] net: constify struct device_type usage
Date: Sat, 17 Feb 2024 17:13:22 -0300
Message-Id: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGMT0WUC/x2MWwqAIBAAryL7naDSQ7tKRIhttRAWWhGId0/6H
 JiZBBEDYYSeJQj4UKTDF5AVA7dZvyKnuTAooWqhZMfnIjmc3I7W3yf3eHHdadMK00jTaijhGXC
 h958OY84fnVJAZGQAAAA=
To: Oliver Neukum <oneukum@suse.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Loic Poulain <loic.poulain@linaro.org>, 
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev, 
 linux-ppp@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2050; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=8IktCrsRC+hlS8Myl1fdnPGp6EP8hC9J1haMpC61SOg=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl0RNrpk7BX+VmqEEeJxcyIwSF9ZeHvTQLW5p1V
 ealPQCKRLOJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdETawAKCRDJC4p8Y4ZY
 plYsD/wLcDBrNqH7PMKSjPkDtyu9739Mvkq+1uT348a8e82LOWBnOdKK6q+DkjgyUHodP2kqFyB
 q+OBZevG9xCq7m5Nbu5mjwu6pALcRTrny9S5Zk0cLWMSZAIXYTvexzFW5CLi4XUHeqR3Qwq8c+U
 GetCdNHd/HNgOyqW/L9kd5s1ivpxGffSeBzNg3WhrWajErwBAHboUc1HJ17FD8tPSTcPAvUwl97
 Wl0auf0nme1Niz+WyayZv9iRtZut21l+tVeMH+HqWYjh36SKvkrU/p2hPzR8syuDHLvk+j0T2q2
 IVg4PE18HskT1IoRQ5s+9D85b5zqVuU7e2k/eRrxkMJVG08tcmnxOYZ0eKzYEBQMrXECyqlS4ty
 It1ohBySWA58CT7b0XC4jduQ1APoExAel6JvYgMVP0U/IQ+1dRGVX7o6mRjpj9vdGlXisYNIya6
 RnkAPo4SFGuLWYUSta0O1rRUbVzh9ZkOs1A3usrujPywEvrT7ylTOwEpnlr2FL8RAZn9udVV08m
 MA99oSDSBPqtqIWk7/Z5cdlaOBZwEmytINyYUaX4CV5SHFWtO7K3wjojXMityKLq3iabpjm10z9
 ZdzdzWwgoD1HhvD8cAUC1WCU/j/owgoaFbXHZaDAaKrEhWTlTpKlw0t3s4AdKkMWmyU+iYreHuV
 MtNhqyvaf91HA/g==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

This is a simple and straight forward cleanup series that makes all device
types in the net subsystem constants. This has been possible since 2011 [1]
but not all occurrences were cleaned. I have been sweeping the tree to fix
them all.

I was not sure if I should send these squashed, but there are quite a few
changes so I decided to send them separately. Please let me know if that is
not desirable.

---
[1] https://lore.kernel.org/all/1305850262-9575-5-git-send-email-gregkh@suse.de/

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

---
Ricardo B. Marliere (12):
      net: usbnet: constify the struct device_type usage
      net: dsa: constify the struct device_type usage
      net: bridge: constify the struct device_type usage
      net: vxlan: constify the struct device_type usage
      net: ppp: constify the struct device_type usage
      net: geneve: constify the struct device_type usage
      net: hsr: constify the struct device_type usage
      net: l2tp: constify the struct device_type usage
      net: vlan: constify the struct device_type usage
      net: netdevsim: constify the struct device_type usage
      net: wwan: core: constify the struct device_type usage
      net: hso: constify the struct device_type usage

 drivers/net/geneve.c           | 2 +-
 drivers/net/netdevsim/bus.c    | 2 +-
 drivers/net/ppp/ppp_generic.c  | 2 +-
 drivers/net/usb/hso.c          | 2 +-
 drivers/net/usb/usbnet.c       | 4 ++--
 drivers/net/vxlan/vxlan_core.c | 2 +-
 drivers/net/wwan/wwan_core.c   | 2 +-
 net/8021q/vlan_dev.c           | 2 +-
 net/bridge/br_device.c         | 2 +-
 net/dsa/user.c                 | 2 +-
 net/hsr/hsr_device.c           | 2 +-
 net/l2tp/l2tp_eth.c            | 2 +-
 12 files changed, 13 insertions(+), 13 deletions(-)
---
base-commit: a6e0cb150c514efba4aaba4069927de43d80bb59
change-id: 20240217-device_cleanup-net-878960951968

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


