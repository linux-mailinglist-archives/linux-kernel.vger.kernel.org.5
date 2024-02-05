Return-Path: <linux-kernel+bounces-52395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BEB849785
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E1028C085
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CCD1803E;
	Mon,  5 Feb 2024 10:14:21 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E289A17748;
	Mon,  5 Feb 2024 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707128060; cv=none; b=kxIeNJbUhbOU2IJnWq9PADddfK8H4F47uf91AjVS6lJbsVe7FtmGqsrnoZpWonHIeupUBNtMsDr3txSbSDltqkP22D8iVv5aPoZlJtjwQLN/vx4nRfKck85++SKSU7kCeb1ewd80mLRDPiYHTKSrGCsC1LmDAnGfXddgYcDOs9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707128060; c=relaxed/simple;
	bh=h09XmzjAYrmpBl0iTXX+I7W1xNVXxPK2RnBfV9Jz0b8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=THb+ZIIP1Y+m8+ssuVm6S+YaHlAhF0derLLGUw0A0537ZL0lXM92VjnXhhRRHbEAsYhDw8fcc99pgKQ23kwhMf2blBo+TBkKeVefIqzQ1BAWkpMnaeF2Zg/lYLiDbhLTP6ZqSdxZ0yG2wgUlUZP/FaD1zYilobczf525JyplgHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so4725906a12.2;
        Mon, 05 Feb 2024 02:14:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707128057; x=1707732857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSPKPWb2+X/fBYPYBCyjcjI4u65FLsU0K06sqValewc=;
        b=piasBwFovWv7rTVqaTy7JzVGE14kd7fwBIstBzDLVl1TIrEHkWkN1+QHYNqoQVb2TH
         mzC5cDECHXVswuH2QOGMeWhiw7PTOOkKsLkSet0xxuZrZjP+W8z+jGN2C3iLPXauYqhZ
         /tmkqgcB1PFwsjzwM5yjli9R2XJzUrGZCtYKTUHNa60TPTXBXHcZwB+uH4v9zJUf/qUQ
         6xqsuAeeR5LMxc9BMdwAb+foziBsWsyK0qAo3u0DH9jQuS92D43WMbxsY5TuzKeSwycO
         7n+WZX2sgtT9v/t7+NVcWn07XpDz1Ag5f4sWz0mLNCy5YE7W3JzzTZN2TNBUuydZZJpt
         XRAQ==
X-Gm-Message-State: AOJu0YwFN72YtOeknixxm+DczeCwHcpKHTeEpKs3aQzIs5QFRIsLbf9a
	u4K7/WR04kQDivWvYVBBfRHjJ4m68exuMRv+9I2xfN+XuxGOv+5abKf6DVQThC0=
X-Google-Smtp-Source: AGHT+IHpSdEdJG+y6/RQl2v5HHUAg2S21JQgGwWx6JYCDZCHfsdugZu+Jyu7mIbS5ZeEu4Xvo53N+w==
X-Received: by 2002:a17:906:f8cd:b0:a35:a71d:81fe with SMTP id lh13-20020a170906f8cd00b00a35a71d81femr8389492ejb.43.1707128057126;
        Mon, 05 Feb 2024 02:14:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXok/aJvnbl/8tGiGBS4afqslCcV0MduWxPL/Dil2nqyGXS4zoIeMwBP8NzrOqtEVNNn3/KPVQPgBDd089QS728HIBBJ+cjHYx+EShhWKu1QFKMNbqEO+ORcHo6O3HOLv96S3Ay+RHMUYcVkFbm16n84CXZt+6S/hr8BKF89fiV8ar6QytA/UxkXFLhpd9kY3A4MqVyEZBKftApslBYMXfDzaqWjVXIN2497IBuaNffIKFvm1cHqOiHyA0joX9SonRQkf249G/Nquf9EEpZyhCbWYVKCMPzKNR822R+VTiacYaZq9QZEUCdJ69QLFcuqzm/QyTHtib2V/Ub91BlBw==
Received: from localhost (fwdproxy-lla-118.fbsv.net. [2a03:2880:30ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id x20-20020a170906135400b00a376804704asm2416875ejb.177.2024.02.05.02.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 02:14:16 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Alexander Aring <alex.aring@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	andrew@lunn.ch,
	linux-bluetooth@vger.kernel.org (open list:6LOWPAN GENERIC (BTLE/IEEE 802.15.4)),
	linux-wpan@vger.kernel.org (open list:6LOWPAN GENERIC (BTLE/IEEE 802.15.4))
Subject: [PATCH net 04/10] net: fill in MODULE_DESCRIPTION()s for 6LoWPAN
Date: Mon,  5 Feb 2024 02:13:53 -0800
Message-Id: <20240205101400.1480521-5-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240205101400.1480521-1-leitao@debian.org>
References: <20240205101400.1480521-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to IPv6 over Low power Wireless Personal Area Network.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/6lowpan/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
index 7b3341cef926..850d4a185f55 100644
--- a/net/6lowpan/core.c
+++ b/net/6lowpan/core.c
@@ -179,4 +179,5 @@ static void __exit lowpan_module_exit(void)
 module_init(lowpan_module_init);
 module_exit(lowpan_module_exit);
 
+MODULE_DESCRIPTION("IPv6 over Low-Power Wireless Personal Area Network core module");
 MODULE_LICENSE("GPL");
-- 
2.39.3


