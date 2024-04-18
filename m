Return-Path: <linux-kernel+bounces-150090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 081B58A9A4A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CBE01F20FA5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A496D16D328;
	Thu, 18 Apr 2024 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYm11ENj"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582E416C877;
	Thu, 18 Apr 2024 12:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444257; cv=none; b=SvmCweDRM9JJs/G5ZZJNzeAIzxr3c+S/iwlqSpeF8V21EIz0cL5UqdMpp+/6mPdCycbIUpiZUHOLaykCqQI0ggj1y5dhDBmoYxWA2N5DnPw53seF0edJyjwmvzvTjSOrUx1zlyauF1hI1S8JTCX3uQu8t8wa5k2qKAMgTdgVG5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444257; c=relaxed/simple;
	bh=VDDRpJrtn+FBJiYXnzWdYY1eE6FUMnWwjRC3v8JhoyY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iv8UaboC4O0O/Miay1nsPeVW0BTRJEFm1afInz2b1W8thHriBGt4HkZTQnJMt91K1x94znH3u4EbCzmNdmNhL0CUV8YoxSRN7H41gd+vM8Dk7NUSN+zO3UU4TPUzjSJdmvsXJdjAFlfHagXGIMe9QjlP+E64t/Jn2DiNuXyv/dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYm11ENj; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-518931f8d23so781867e87.3;
        Thu, 18 Apr 2024 05:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713444253; x=1714049053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bxeVD0eMUOeKTnsK96fJNP8CxKZSsom4Dx6Yys6UqKQ=;
        b=nYm11ENj4HMDdzsgFijB58KqYEx+GHuZ1gmDwS2lFI54cAsuMz93gZNMv9GiLxFNNA
         nOfXElcPnOIuLSmlZ0upfZqZB8a+mG0TPa5vrmx8C7O1D03JZhEbh8b4UksYQav7ob5M
         qT5lyrRvddwjuiQi+i6W3OBB3cmsQ7cMe70yyHbCisH3+DlFeqeraQbsm/IKAxxAhaHT
         JLoBGpfdsuh+2cNscTKd7fGqN6zm/rL220Ca9RSC6NB7/+R3TZ9kGFDr2MKgh9PFWjgs
         tmD0xn6q/+IQcrhQM9qDjEX03PsnUM+zL+bCiWHplhtyA2jQYVFZNe4SsGyzU5vv/IbR
         4Jvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713444253; x=1714049053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bxeVD0eMUOeKTnsK96fJNP8CxKZSsom4Dx6Yys6UqKQ=;
        b=VELikzkRQ0dFnQ69YlReGzvIfS0vxBGApn75aNhre8Ws6AJOkDij78qT1CbWQnI6k/
         gZg/sTo8QXro/G90yoFBx0S50ZFxZg4q3Iwafaad0Y2TxMM+txIAsAuuquWJcrK42qNp
         wVSA4LOw+11/Qr39bPGapcxpWVCauWzvij4dE2ptVwptmnsgpq1HDbsh51gpt9PBKsxV
         mEnyZsnkJtAaAs/MScV9cm0josNpBfj3uErYrnKD6p7Tlm5kAOy81JlphUOMUGDsNEia
         9b+23CfffmsJ5hTFsaXgEtmVyfN+XmcdDLvv8wKo196GmvPd8SDPUXR0hncK6koWVkJW
         8dgA==
X-Forwarded-Encrypted: i=1; AJvYcCU/R3jq3daql4qj/7QcWJds5m3v6onDMBIbGoMgJ6+Zu2SOyYiVUEVFmjvMWDYtfJlJRkBu/EzolXCJGsFBNPaalNVaG4fm7yZdXX+UJ8uoSa73M7mpUtOqnnYYJKggmW1MA92zsJy1Lkh/
X-Gm-Message-State: AOJu0YwnbZdndABbSleR9FuBQSQqqpyHB/zxN0dZTRD539Avs/Deao1g
	ME0301H+IdOgQDLaWZAI/Y223SXDArdrPEsLW0CRM/ymB8/ujnNAjr7XMdG+
X-Google-Smtp-Source: AGHT+IEZjH1dSZOJ3DKH4OuKiAPlaPcushV+W1X9DOb6sZmVnMV8UPHw5I7Qt/JxpxFYE158LRBxKg==
X-Received: by 2002:ac2:4ac1:0:b0:519:5ed4:c901 with SMTP id m1-20020ac24ac1000000b005195ed4c901mr1492290lfp.48.1713444253235;
        Thu, 18 Apr 2024 05:44:13 -0700 (PDT)
Received: from esko-ThinkStation-P620.nordic.imtech.com ([185.154.228.48])
        by smtp.gmail.com with ESMTPSA id t28-20020ac243bc000000b00516c9a8120asm225799lfl.226.2024.04.18.05.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 05:44:12 -0700 (PDT)
From: Esa Laakso <fidelix.laakso@gmail.com>
X-Google-Original-From: Esa Laakso <esa.laakso@fidelix.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org
Cc: kari.argillander@gmail.com,
	linux-kernel@vger.kernel.org,
	Esa Laakso <esa.laakso@fidelix.com>,
	Esa Laakso <fidelix.laakso@gmail.com>
Subject: [PATCH RFC] pty: Add parity enabling routine
Date: Thu, 18 Apr 2024 15:43:49 +0300
Message-Id: <20240418124349.26289-1-esa.laakso@fidelix.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some cases where parity selection is required for passing
it forward to a virtualized terminal. In this sepcific use-case, we
want to use pty to send and receive serial data to a serial
multiplexer. By using a pty, we avoid writing a custom tty driver.

There is very little evidence on the reasoning on why this option is
hard-coded to be disabled. AFAIK it has been as such since 1996. With
the lack of information about why this is, and based on the fact there
are other similar fields that are not hard-coded, it is considered safe
to enable this option.

Still, in order not to be too intrusive about the change, add it only on
the condition that the termios flag `EXTPROC` is turned on. This way
there is very little chance it will cause any unintended problems in any
other implementation.

Signed-off-by: Esa Laakso <esa.laakso@fidelix.com>
Signed-off-by: Esa Laakso <fidelix.laakso@gmail.com>
---

We are looking for some assistance on this patch, or just a green light
to submit it, if it is good to go.

We would need to know if the change is valid in context of pty, as
there seems to be fairly little information about the reasoning behind
the hard-coded values.

Our guess is that they have been as such forever and nobody has had a
reason to change them. We have a reason to change them, and we would
like to know if it is safe to do so and possibly contribute in the
process. Either by just using the patch for ourselves or submitting
it here.

For the record, this is my first patch submitted upstream. Please let
me know if something is incorrect or missing.
---

 drivers/tty/pty.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 07394fdaf522..e2d9718dcea0 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -267,7 +267,9 @@ static void pty_set_termios(struct tty_struct *tty,
 		}
 	}
 
-	tty->termios.c_cflag &= ~(CSIZE | PARENB);
+	tty->termios.c_cflag &= ~(CSIZE);
+	if (!L_EXTPROC(tty))
+		tty->termios.c_cflag &= ~(PARENB);
 	tty->termios.c_cflag |= (CS8 | CREAD);
 }
 
-- 
2.35.3


