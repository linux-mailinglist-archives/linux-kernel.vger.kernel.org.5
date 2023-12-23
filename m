Return-Path: <linux-kernel+bounces-10192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4FE81D11E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0438285B01
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4A1D52B;
	Sat, 23 Dec 2023 01:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="RGUnH7J9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9157CA5F
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-35fb0dcec7aso9787485ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1703296794; x=1703901594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjGy0qcS0bsjIhVMCVvxHQecehCic/YbYj9/FdJmdRY=;
        b=RGUnH7J9L+aD0vpdHeuASbMhtWRpzWeCqNbJmrdF9DIIDYa4eO+/onn5+7QZ3tJqow
         waugNgvra7H3FnzvZ6sHe/YdOuQ6cKvvS1yoU8UYuWkwx+fvpy3z1MpPT43CB8pIbJM/
         7cJMr64A2gZNGbcP7B0hJ17L6oLVlHS7aQMDk+OdcS6qamwJ4pDjUWWynlXkqamdvNxk
         4d1CG5ohPMVlI5K+TVM3+jcMcUcb+ejfV5m9UYnFMPD6dPlwfH5q0oIuk7muXC5PRohP
         oclR0pMSAQDIelFlnyKycXAGPm0pWfzPDn3hIK4wPAYToygpx569N9guFKLswdvF9j2M
         r8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296794; x=1703901594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjGy0qcS0bsjIhVMCVvxHQecehCic/YbYj9/FdJmdRY=;
        b=CH144mtj2T+lgfx//Vdi/JAl+Ea/jAzxRoH0tp9TF09DS8LsQ+vCY4RuzjF8wncuCR
         p3S7f/d6ca4hvxnos0/yRxCjI9r9Z82ifZYE6XdUB+djNOqFuIcppTWE06PhgkdNKWsZ
         ft+kLq7ERhzRL1ekTzQAvsj3hncCkLxdXP6e4306Zz2uoe3gyRl+VZRGHKN1z3h+8EJA
         hIilaromCOawyjVVCLj2T8ifBx/iS6YhknIuGq4GfEjAKXLQKhmKEmPl6BpEgcceCBwK
         C3ma3o2iEmCmt09pq2OrtWsbEtdVNi3VwZZ7UrLeP6ta1sNpNzmuZ3mSV6fhiw5i2Z40
         GmLg==
X-Gm-Message-State: AOJu0YwLezL9TgiYGQSrEoxARz8raMWLG9lwdaLoskcvp9+DCoXki+Te
	kP/t7N4OoL6nJ7EZ3By7MfoJMlPQVvIfVA==
X-Google-Smtp-Source: AGHT+IFb+EqECbvZXq6Y+Z2dVfuuaR8f5NH3+choZ3UkB0RM2XWddK8HAlyjltbFCIBQv4uJ1LDXOQ==
X-Received: by 2002:a05:6e02:1888:b0:35e:6b97:b8a4 with SMTP id o8-20020a056e02188800b0035e6b97b8a4mr3249746ilu.4.1703296793927;
        Fri, 22 Dec 2023 17:59:53 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kg15-20020a170903060f00b001d3edef115dsm4106546plb.20.2023.12.22.17.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:59:53 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 09/20] Staging: rtl8192e: Fix function definition broken across multiple lines
Date: Fri, 22 Dec 2023 17:59:31 -0800
Message-Id: <20231223015942.418263-10-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231223015942.418263-1-tdavies@darkphysics.net>
References: <20231223015942.418263-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Join 4 lines, so that function definition resides on a single line, to fix
Warning: Lines should not end with a '('

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 3788e9fb0ac0..49ac73320fdb 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2267,11 +2267,7 @@ static void rtllib_MlmeDisassociateRequest(struct rtllib_device *rtllib,
 	}
 }
 
-static void
-rtllib_MgntDisconnectAP(
-	struct rtllib_device *rtllib,
-	u8 asRsn
-)
+static void rtllib_MgntDisconnectAP(struct rtllib_device *rtllib, u8 asRsn)
 {
 	bool bFilterOutNonAssociatedBSSID = false;
 
-- 
2.39.2


