Return-Path: <linux-kernel+bounces-65420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F6F854CBA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5FD1F22CDE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9B25FBB4;
	Wed, 14 Feb 2024 15:29:04 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073F25D90E;
	Wed, 14 Feb 2024 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924543; cv=none; b=scp5zFgBQz9LaQZw0RjYFF1+gePKG/wgTNC/dEM8Q1+uMXz8q60B78j3GhC4g8FcH5AFhTEKJcoeKqbnCaUhZv64LS1oh4kYenWvlX8OVa+uuoLkjU7+ymD6OyjSY0RHKRG9McNskbdAVbRvBpC+PnvcLHzUNSfoH7uN4aHU4Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924543; c=relaxed/simple;
	bh=ATeujqNTxGZ7Buahdh3oQZdOez0THha3F4P6l0NgA4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XM0txPOvuxMrJWYvkOqP2JVI20qAGJcUq0ztjmnlpVRemNn/v5Q3fmDU0Qukobvm37RwfdgRXTaPp++8tzltaC8G4lF6kVJTizJnED5kcjh6QCKr2YBMKWk79FAoBWbKVaTkDhID/z5xa2Gip8eBG3qe2KN4LEAYUcbt3M7hFyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-562131bb958so1654089a12.2;
        Wed, 14 Feb 2024 07:29:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707924540; x=1708529340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+NDfFH0YYmBs1BkIUepda9MZ/fKCEXrnoPMYFzSoWw=;
        b=d9XJc3Wlw8T4WHV8tdcIDAEH7x3/TIkCa3dNYgxgn60NuvqclnacxoBENCtc/gmIBP
         x+bdjb8YGlDwArCs2T9Xs+WqqH4Wy2SalXyWvAVkYx+PRfcT947Q1DkmEJd6OYreZFpQ
         HSVwZWrovhy2h8Sps8bGbcByx7644hVYpYqI4fb+tceXRtYNruO16MVjzVfPdjBQs+xm
         WmZCznltiZ/oNNHKZ6/PivzQYpYnW40FZ8K2iGCR7lwxFVpDxXNP5lqIgBKOJBKeoMT8
         uUQR11xlitOhKSiYtIkK63ZKgKe/UpY1G9PECXxYPOQOLRXq9mJ3TA0YTvQ/BzZhXtZy
         ya/w==
X-Forwarded-Encrypted: i=1; AJvYcCUkhUxunn84+sX/hTDDmefFgOP/0L92hU0r8bjPO6GvZGiias5qYIj6SuHjDVABUIY7Rp1p1EHVdQrQ1lrpfet0RhbVFKZITbBZuXxNv1g/iVEEVEcMZ9UzfjnO4A7kFY1phScgv7fCwA==
X-Gm-Message-State: AOJu0Yyl6YVijHXEddHfmQIAg2dM+L73RDo2rwMgjH7vv5ZXfW7Zfu07
	OqmQbGCGxUEk6KERk0QMySW+mtwegbWBarqUkMd1xEb0bmXW3ZbJ
X-Google-Smtp-Source: AGHT+IHn2hRhp+3Wv/pQxVUA9681xKLxCQCY322uIg1fNQ5XPNfEjdKLkxQkxnCrzUIxFee3zz1sbw==
X-Received: by 2002:a05:6402:8d8:b0:55f:e936:b495 with SMTP id d24-20020a05640208d800b0055fe936b495mr2073704edz.0.1707924540058;
        Wed, 14 Feb 2024 07:29:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUU4q3o7WrB5Df6c8gfCO2uZlaY6pvaHqqcY4u4wfQl2ocpHTb99wjlpJFortRfpkTSPB8WSnO81NK2blmR+gDFCsSaUG4UppQUMVeXwDL9z4z5gmbxMmjjrL+4J1IFxTKidgZ91bumSN5zjCtFapL5RZlI2jqTUg+iL+6YOlF1hhi9znl037r/a3Atu8t0KAHCiQvlH93GHnVm0xMPQZ3VF+uIouGApQgPHqFDEw1qaBxkrsAlHrz21m6rX8236csG0Bw+uL6Ca6fDykMUUmIdwmc2L/A/Er20nBdIJS3AWuBknJGxjIhofI5+ESzw37KzOjLNdjN1pSiaC41+zMmUB2kp
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id a22-20020aa7d756000000b0056140d51b7asm4768826eds.83.2024.02.14.07.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 07:28:59 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	linux-wpan@vger.kernel.org (open list:IEEE 802.15.4 SUBSYSTEM)
Subject: [PATCH net v2 2/7] net: fill in MODULE_DESCRIPTION()s for ieee802154/fakelb
Date: Wed, 14 Feb 2024 07:27:36 -0800
Message-Id: <20240214152741.670178-3-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240214152741.670178-1-leitao@debian.org>
References: <20240214152741.670178-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the IEEE 802.15.4 loopback driver.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ieee802154/fakelb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index 35e55f198e05..2930141d7dd2 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -259,4 +259,5 @@ static __exit void fake_remove_module(void)
 
 module_init(fakelb_init_module);
 module_exit(fake_remove_module);
+MODULE_DESCRIPTION("IEEE 802.15.4 loopback driver");
 MODULE_LICENSE("GPL");
-- 
2.39.3


