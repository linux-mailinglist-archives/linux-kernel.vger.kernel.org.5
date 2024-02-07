Return-Path: <linux-kernel+bounces-56300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D8C84C874
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 924E5B24A93
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FE528DA7;
	Wed,  7 Feb 2024 10:19:47 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7A1286AC;
	Wed,  7 Feb 2024 10:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707301186; cv=none; b=neGJPzbvT8EdZ+6h989/eQOj0SFQdLBLLI/X77kTuk1HcCyUJMjbNwWmJVFkFRI1vQhyQwfm+r3kBnSLQvyWGQ0d2eyy+NhyM2sLM27v/0mIncEm5pgOOobFf2kgjk8ZCaFdGGS+XFxm58JT/eM59xzvtg2yMSjMLqbX0veMHCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707301186; c=relaxed/simple;
	bh=cLlSglYo5zPsuAw9zjY3og+Hq2BehO4c6tsRI1MltBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s25VE8y3kNyTFHhulp/NVSkYKH83XX0MgCIWfRYokq44qkw2juvHdLgn8qxXjvDjumVn1GriPeLmUVkEkWOjgpXE4Ml5sbXx/D784aAslRgyxPSKiLzKOV/wymiFxt2iViW/iWq4G9Sx8UGFzXIhQSnRt3a3O2PqOAXf4symQl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55790581457so580274a12.3;
        Wed, 07 Feb 2024 02:19:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707301183; x=1707905983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aeD6034q8KvdXPJcZmxXEmuuy9qPKKAyxbAnHHYFoBw=;
        b=jcyQSwDyOxelu6nXRMZwW0ZqDE1hd+Dj9IPKFWtPzTtjfbxVePM3oaGAZ7uE81ilFh
         6M3VrFwbbe1MfQaCKEKoDEkH7zbUFZ3ZoRKeZ7qtH/dsep2tjr48punkYYtmmgxWmEPE
         PI+WpEEZzP/L/2dFWLnzzTOh1M8bE1CKpfLP/MW2C3lc3Ivfk/cJK6LICUSy6RGcB5jA
         uGmsP6Nx5vVULQZbINOs2UKn61dP/yaW6ehkEUOgu1UKWhQtm7TjtePkERUdR1OZ/E5B
         TtJz7VSXNNuxxLpP9NsMqZ2+KLowb3SZXkXeRTPdwnx/Y9occ9+Pcz4OXyM+eEWt0jaJ
         zWQg==
X-Gm-Message-State: AOJu0YwZFV1Vr0D/4yw15Ab/crkUCSqgniN42QtjVAXWDpxY5kgyvHsJ
	AR1pYrZeuYQBkvvTVfNfRA6I1qltqYTWjyudTmGLe3AJ2D/i5KuQ
X-Google-Smtp-Source: AGHT+IFaRgITS9KbagU/W6G07GebP3AniBfTbZW/CjChlH204cHBL1fMfL+yz4y9nLWBzUsTMlPOAw==
X-Received: by 2002:aa7:de04:0:b0:560:1652:e7cb with SMTP id h4-20020aa7de04000000b005601652e7cbmr3841706edv.16.1707301182902;
        Wed, 07 Feb 2024 02:19:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUaJCr40+XRSXJuvfAWi9ZXqHI11FUrXvasmyxQLoHnVH7PPK0pm+2771Sw6V4BwPyALaYT/ZwP2++atngi4Vl+Un1iR4/m7EjlxEWsivW2IqVImTjtzLoVEHuU2KDPF0zagogA4WQ+9USiga7cpKg+DX6VodJjiqgOSTV437+0KGJDad6R8h/SeEOaqs5ouxzyx8L7mC6Nu3+MAEOMNVFsmlpXPZlykosRTAI=
Received: from localhost (fwdproxy-lla-117.fbsv.net. [2a03:2880:30ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id l20-20020aa7c3d4000000b005601e5ca418sm514607edr.33.2024.02.07.02.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 02:19:42 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	andrew@lunn.ch
Subject: [PATCH net v2 2/9] net: fill in MODULE_DESCRIPTION()s for mpoa
Date: Wed,  7 Feb 2024 02:19:21 -0800
Message-Id: <20240207101929.484681-3-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240207101929.484681-1-leitao@debian.org>
References: <20240207101929.484681-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the Multi-Protocol Over ATM (MPOA) driver.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/atm/mpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/atm/mpc.c b/net/atm/mpc.c
index 033871e718a3..324e3ab96bb3 100644
--- a/net/atm/mpc.c
+++ b/net/atm/mpc.c
@@ -1532,4 +1532,5 @@ static void __exit atm_mpoa_cleanup(void)
 module_init(atm_mpoa_init);
 module_exit(atm_mpoa_cleanup);
 
+MODULE_DESCRIPTION("Multi-Protocol Over ATM (MPOA) driver");
 MODULE_LICENSE("GPL");
-- 
2.39.3


