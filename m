Return-Path: <linux-kernel+bounces-65421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6E7854CBC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39B621F24604
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7221A60241;
	Wed, 14 Feb 2024 15:29:07 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2F65FF10;
	Wed, 14 Feb 2024 15:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924547; cv=none; b=OmD+Au63PNuLrb9hTfMltUf2oZ6Wv/6gAcPFJoFWjbknjRIB4JWEQukk0WGkAoKB49j4gN8TdqkNsgjlPgh5xP/sSx2sJRyt3JWrnGIEbxUbPrC1tZmWiD8WgAMI/3NLgwWmbiA1ej2NMUQtLBWUUjzX1M2Y6WnNtVWHGnRiIr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924547; c=relaxed/simple;
	bh=Sw9aECovxuzHfbGjq+NuK5xwXC1F2IayjoSQFizg6p0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ggZFJygAzAViKtayZUq8MBoY6vwyh9Qq/FXUazVToDk1V1m0zCxcBOPPw5BjDJ5BANevSTUorFzD9r6/+3VoHXOodSHj3HnLWnowj6zwknkPSWRGOCrv4aflpOCUHVEToQl8MCOoGx4kbuWf9FieIfB8e2ti0RA/sOBIMBRTx1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so7687785a12.0;
        Wed, 14 Feb 2024 07:29:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707924543; x=1708529343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BaPmfqU67eGkA9+Zdc/Y5R+aKMFy5zwM/Q9/t40NLg=;
        b=QyCJnCGVhUbMsVuWgpjqcQITWQOIGfk3A4ElLjvDXqqhTwoHZzimTfWcrvgkcUtBcB
         yMP0KlR2TUhpxEZCCo2gxFXof4rqTDlzlYvgv/NJAG8z0GYgBOzLEG6CEgL7rj/UjF6w
         Upi4wTR9ierNTK8b9ayPHfbyZSZYqbGocXvKWVWCvaOnSdWPA8wWBAYOnGJgpHm0E+zX
         8NwvjkQp48kFy7NNQ0gN0VEZdEmc26vB1nxSZ2+nCEeA+uihOcrDlAWV9z1FoSn5t6t0
         N1Y8lxiBp92ODhNy9yEhPLLdUq4G5ocRZX9+//HaRM96IQ816foKyA1+5cjpzrTOFBB/
         7p1g==
X-Forwarded-Encrypted: i=1; AJvYcCU1mI4r1MuMvhICLllRnybI0lAiPGQ7IUlYeoiv3QJVVcqwrHZHVgHdsRUMlGUrk4SCktP1m/uS4exPcEiEKlPR3GxSfSyKYfPAtHIn
X-Gm-Message-State: AOJu0YxitDrAtZ+INpotC35Mrv4Z0ufQr4rqJCh1TTKFVhxGPlGs2XPx
	QX/+WdWvb7+KuxZh4w/wkfdMcJ4eEy+svfjwS1ow/+6Z69pbDsG/
X-Google-Smtp-Source: AGHT+IFaXEr2teuGVFIY3e63PQZLZjlkMOh/79YLO+6HG7h6xj+tM2tgWqCC+6G+N7QK4Gl64dTghQ==
X-Received: by 2002:aa7:d394:0:b0:55f:1728:3b33 with SMTP id x20-20020aa7d394000000b0055f17283b33mr1868908edq.40.1707924543704;
        Wed, 14 Feb 2024 07:29:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW6EmMhJ1hroARzMA2uZEjjfz8yL7pS6AhcawagbVnuPRMKZLDfjPpJfHFWfr+3ew5g3XBIPGhFBJCYAX9vfs3PplLvfNfDWZiW12+kvsH+ZCpLd52aYnKZ3g3xr+Bl9r6+HI7sBZiXoWtym1Xc93Aj8RVaKWYBHPq+45HrthvO1DOmEq3HTRuVXL9XnwPIDGl+/30BQhbrL/zrcA==
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id x63-20020a50bac5000000b0056368be8a58sm636609ede.27.2024.02.14.07.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 07:29:03 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org
Subject: [PATCH net v2 3/7] net: fill in MODULE_DESCRIPTION()s for plip
Date: Wed, 14 Feb 2024 07:27:37 -0800
Message-Id: <20240214152741.670178-4-leitao@debian.org>
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
Add descriptions to the PLIP (parallel port) network module

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/plip/plip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/plip/plip.c b/drivers/net/plip/plip.c
index 40ce8abe6999..cc7d1113ece0 100644
--- a/drivers/net/plip/plip.c
+++ b/drivers/net/plip/plip.c
@@ -1437,4 +1437,5 @@ static int __init plip_init (void)
 
 module_init(plip_init);
 module_exit(plip_cleanup_module);
+MODULE_DESCRIPTION("PLIP (parallel port) network module");
 MODULE_LICENSE("GPL");
-- 
2.39.3


