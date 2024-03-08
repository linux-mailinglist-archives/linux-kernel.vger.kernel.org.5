Return-Path: <linux-kernel+bounces-97063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FE9876500
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8E4A1C210AC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF79364B4;
	Fri,  8 Mar 2024 13:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMxUGehw"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ADC10A34;
	Fri,  8 Mar 2024 13:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709903933; cv=none; b=CCg59B2BxqL855OrByP0NHmjFNTd6bclE3MAJrQnmAEg0HLG+DqZkLzlAZYm0Of+UJOsSQx5vkPeiu+6HMMX5rfDkFA0YUh9dJNKmKZpFM3/NF7lwqu2XRuo/n0ylgQA7TG8bzdrx9eLO+8KHuAGHTWuG/Ue6Qhuefx1vWQ4dJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709903933; c=relaxed/simple;
	bh=oPEWudfma1ZgyCTM00cIONaayXz1JGWtyvpKY2ge/lI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dBOzOe65yVJ8vKbxR3K5ObGt8X/R4wj1GTdJLP/8L7Pnv7YzFwYZpGJ9TMwmdQclhvbFQuTGTDkwtjb1iUz/YZ8eyTbX9M15kPNz+IkOXYHSh9y1pmYWQZgutN3c8KpcItEdijUnL3Og1ts7HNEJqtEuwMvvR6A3P1kVqG7hFD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMxUGehw; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4131804e695so3816625e9.0;
        Fri, 08 Mar 2024 05:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709903930; x=1710508730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=43felEw2qApt1wR5OexBfyucmoH5eT2hn7DMVQ2pgzw=;
        b=RMxUGehwsjjfc8NHdebt0EmpS58t0P/aLXWjwiQcmwX1Ay3eO7scJTTF9H3zs3WJl/
         QNM+Zd48hgGs2XH3YYhlR/+bsJ7qH/HvJGfCRVsQ4UI6CWD6GNBoGSyf+rkolZ9wEk7C
         SSjsmoo4bu+CRvePuDlvdAeKXbmA1BkhyWmq3ghwClntBZh/sKIbr19OgEqr1gzz2/kV
         RIhDI92GYdt+w5kk37MhCG0d5U05Vj+WDKPdY3qFrTF4hWd+w2NCAw4OwcY6sqijqYmh
         yNLb4PVlYcjtNPjRx0u5xkisB2+/XVoGnDGTNB5TfDZcKUfD0+5fz7PAOEHQ7Sc7+bea
         OLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709903930; x=1710508730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=43felEw2qApt1wR5OexBfyucmoH5eT2hn7DMVQ2pgzw=;
        b=UaLHRKuMINxnfLVhXjB7iYMgysaA2gHcfd5ok7dwzr+BSv1IeMs5diTM1ytEuW9qgj
         YXLe6M2eChaoxtkmCNjtjDixO52AOsIxpl0JznRJcxmW5wMfXnHFg/h25bv/rrUUZ+J0
         st7DZ8WxyS1o4UBEfNuFL3406X1Vztzwz74ekMwhCMvdGMm3Y1HL3JroNvqSi90NI+Fs
         pcrxeBEOyqfxXIyvK/lVfFk9ntPiyQMyeYnVaqoS7MNylgJGDfKVIRY0CNbv27PeHCBz
         XPPAIp0ZFXUWEae8vbqAs7Qn5YPJgWJGVTJtBz9FRhsxz+TSpcVqpTGRgTRiFJ85gGd0
         ur0A==
X-Forwarded-Encrypted: i=1; AJvYcCUUOY0HsMHWXK8hdwLmX/KKLO6f7NB52+fPRApQ0xINhYTMH/hFl71RMMXjFDWQquw3zGUCNTPm7Z1kwxeO1viorKJBlr9vlsg5wxUL
X-Gm-Message-State: AOJu0YznYzSzdeMoXRMyvtqn8OBefrduK/i3WuW1YosurI0SchiZiLmo
	pz6IfKqJ0Xnt+Bxs0s/MH34Z/dDemb6kIG03SYeIxyourH7eRIlp
X-Google-Smtp-Source: AGHT+IEcuoG4fcGSupG1DbYvisBXr0Tx9ypW68pn12SmHxssWNkQCyBpexd4VsSzxr2lqy7I3TimNw==
X-Received: by 2002:a05:600c:5012:b0:412:e4aa:f11e with SMTP id n18-20020a05600c501200b00412e4aaf11emr238159wmr.4.1709903929563;
        Fri, 08 Mar 2024 05:18:49 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id z11-20020a05600c0a0b00b00412f428aedasm5963761wmp.46.2024.03.08.05.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 05:18:49 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: H Hartley Sweeten <hsweeten@visionengravers.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] comedi: remove unused helper function dma_chain_flag_bits
Date: Fri,  8 Mar 2024 13:18:48 +0000
Message-Id: <20240308131848.2057693-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The helper function dma_chain_flag_bits is not being called from
anywhere, it is redundant and can be removed.

Cleans up clang scan build warning:
drivers/comedi/drivers/cb_pcidas64.c:377:28: warning: unused
function 'dma_chain_flag_bits' [-Wunused-function]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/comedi/drivers/cb_pcidas64.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/comedi/drivers/cb_pcidas64.c b/drivers/comedi/drivers/cb_pcidas64.c
index ff19fc3859e4..d398c6df9482 100644
--- a/drivers/comedi/drivers/cb_pcidas64.c
+++ b/drivers/comedi/drivers/cb_pcidas64.c
@@ -374,11 +374,6 @@ static inline u16 pipe_full_bits(u16 hw_status_bits)
 	return (hw_status_bits >> 10) & 0x3;
 };
 
-static inline unsigned int dma_chain_flag_bits(u16 prepost_bits)
-{
-	return (prepost_bits >> 6) & 0x3;
-}
-
 static inline unsigned int adc_upper_read_ptr_code(u16 prepost_bits)
 {
 	return (prepost_bits >> 12) & 0x3;
-- 
2.39.2


