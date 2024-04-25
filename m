Return-Path: <linux-kernel+bounces-158640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 802D88B2357
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5C9B1C20F1B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3F914A4E2;
	Thu, 25 Apr 2024 13:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="UxJThwJg"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71460149E1B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053571; cv=none; b=hOKomM/2r/kFQyQ1x7Z1p6t/nZt/JmIewBmbBur4kElnZbmAQLzwtZksRg49FLOf2Y3IFdkADsrviibhx9qg5liBgVcjSA1XwFdXzdFQBEqDm5U/pIWugjhk6F2BUG8xZhQCzamYRhDNAXYeN7nbn5QgtLV6aPw5wSeHVUnJJ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053571; c=relaxed/simple;
	bh=bxaYAw3KFAukICHyA8ZADUCzO0ruG6dtxRHo2LheGEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GbsISD1t+N2/d+/0lYhnMVnXrzDMPkj+XAEE5YO1pHMwZafijqRImJzbnDWQiL3Tmqo0/3Myzd2bbPMvW7R7wCDMGEsCcfiprdBsU9EAc7uMCIp0b+2M1q9sM6CJQXsF8bn8fAJTgzzmX9U4+zJq2q0JrJouItPmdhGTjX4PDDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=UxJThwJg; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41b21ed19f5so6541575e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 06:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1714053566; x=1714658366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c/c8R+r2wKwqushYa97j544g6TTlix/kEzEOUalKigY=;
        b=UxJThwJgBtkepgF1e2axhmQymFrdcSCPr3zvjzvCuk7gyndAT79kCcUYiyYx5dN+qP
         4O0sGl/qmW0exa9XtppR3DKQxj0tJgWb+Lpyn4WoVn+CQEVzk6owEyU9JzC0zAslRTp0
         mF0bzrqCVgFvk6c3LX/7VrvPb+g4F852pSTMobrCPfQZzpbX9eJIIhxAVd2hZYi/SNkL
         5nbQ+aYkwYbaK/+jVGgXeNOyrpm/IWdAOY51gqOEU+37RJhneIqE642QjZyUIp92J7/T
         AvIpwpzUn61WykowEgeWlEnrSYEUJTmzAdo3KOImCl2SftlPa7UZjFHJi9TA7nfJRsPP
         4Aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714053566; x=1714658366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/c8R+r2wKwqushYa97j544g6TTlix/kEzEOUalKigY=;
        b=ekXKAQbtvJv6k9A+YJnNRoyBsf4zESNt/bB8kdyLDcgcJpfpYYh/aMscB6HtZW43cM
         oD3FV/mZjMgkT5J19PdZc/j6Am5DcZHJ/eMr1trzFf/9HMD+aFoKA2gr5AHlIUVnrlvJ
         QgFH/Y35rTBVvVlnB5YvSzsUl9q5PRKlMp0DOjRJIU/JVVR4YymQGzTR6c+EdH94c2n9
         09WaGp6ZS7GFCbExeOP8jR1OgUnqm6QOVO4poR9XbbH8mphTEnq+r9YqJOD4DGsIA4ky
         S/N2jIE1ff+MceusIlw1CLVNEqgXW+Gvuac2zntSWTxm6V4iOYgW5HnusGA8xfb6SQQ/
         qQ/g==
X-Forwarded-Encrypted: i=1; AJvYcCVQwED3UriihLbVCcs4Ld9MgwaT13vBt8P72yFq75PtWUh8dpS7SO4dDxFf6tePxMFWscgLBTvoRjkOqDPly/5DUFK2CD3E5nGN1xPv
X-Gm-Message-State: AOJu0YwX1DkmYQRcFb4e+jbZ52/Qc/H5cRrplEmiQGepruFIgzCgynZu
	jHWYqaE1BlXHAz72YB/w4gBijzjwpKAY1xW/xo1Oh4PRSBftAFDpwk0g/ZdZNNQ=
X-Google-Smtp-Source: AGHT+IHcVSLzRPPOv8+VkqJn3b1N+UKHe0ajTrqk97KpyD5BrgPSvbqWpwe4PKtfGo8kjhQZEZa7bQ==
X-Received: by 2002:a05:600c:4f8f:b0:419:f9ae:e50 with SMTP id n15-20020a05600c4f8f00b00419f9ae0e50mr4641377wmq.37.1714053565674;
        Thu, 25 Apr 2024 06:59:25 -0700 (PDT)
Received: from fbxleo.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b00418a6d62ad0sm31479464wmq.34.2024.04.25.06.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 06:59:25 -0700 (PDT)
From: =?UTF-8?q?L=C3=A9o=20DUBOIN?= <lduboin@freebox.fr>
To: linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?L=C3=A9o=20DUBOIN?= <lduboin@freebox.fr>
Subject: [PATCH 0/2] pinctrl: core: fix untreated named gpio ranges in pinctrl_pins_show()
Date: Thu, 25 Apr 2024 15:58:00 +0200
Message-ID: <cover.1714049455.git.lduboin@freebox.fr>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series covers errors I encountered with the pinctrl_pins_show()
function when dealing with named gpio ranges generated through the
device tree using 'gpio-ranges-group-names'.

These errors were introduced with the original implementation in 
f1b206cf7c57561ea156798f323b0541a783bd2f.

Léo DUBOIN (2):
  pinctrl: core: take into account the pins array in pinctrl_pins_show()
  pinctrl: core: reset gpio_device in loop in pinctrl_pins_show()

 drivers/pinctrl/core.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

-- 
2.42.0


