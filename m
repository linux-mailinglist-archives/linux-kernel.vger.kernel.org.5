Return-Path: <linux-kernel+bounces-96538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 171A1875DBD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 06:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ACC41C21604
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 05:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85142339A1;
	Fri,  8 Mar 2024 05:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Br1bEehd"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4E92564;
	Fri,  8 Mar 2024 05:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709876436; cv=none; b=XWOwqu/ao1v71+3267OLAzt3XbMEiXrG905gfzCHtzJKAKDLk794S0sh7oApxCoDpWXmETqzsqKSlMzj3/wLFeIOXPtXHgbrAX79VrZeZRR+sXPyfSNrxl4AhOjNEbqYFUtWPWm4Uk+BxsmHShSat3MNNHpnklDJMrJGGbvx3ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709876436; c=relaxed/simple;
	bh=VXzTDDwrVzsBd5OwF3NbrcZGSZl081y1VSk5gTaR33M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oYt9ljqKFHNdMs9LxB/BGjGJLi3VEG7XUaoeJ3cmEvIwUU5GAzZbiuUB+xj3ARMUmTwjJ0QeZkNXaNZ5+1EzxpfJKQcrRXyIQUFTShs7t7g9/HK/qk4OBlA0oN6ewaFN8pEpit8MC5NkAqVKxsTha5GfstJXFP4wqjiCDNoF8YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Br1bEehd; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e4f8f140c1so740667a34.2;
        Thu, 07 Mar 2024 21:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709876434; x=1710481234; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmIdbXAIShCcx4VSxfFCIq6Nn+BVqj1An3BXPDxEMT8=;
        b=Br1bEehd3eynC8MInWxktqrrpdwCp1NI1xa9UVTuedejHoGDNM8X8nBaKngPp+VP2l
         BC7dDldTwTPmjc8xIhoT4oA5r4b4hS7gIlhoAWhdwLO0UvYZt4rypb6L4F20FfxDvQSu
         Rf8VMEjoKWwkgsUX7814x0Gm8ZkBzhBBPkzRpLDgLpOu58gSMDVHgWytjSrfSQ3WXwqb
         j6Z/LohasUNpL93GPABo8lEfOnb0976Fgqjif6wtJyEnfXsu5gj0S/VXySRqfsn6j82e
         es0pzgw//YlUUvSAhqesmaKC4LD5d4jZG/GZUYEwTl7eEEhLVXdwFajt3TRk24AhAidp
         cNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709876434; x=1710481234;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FmIdbXAIShCcx4VSxfFCIq6Nn+BVqj1An3BXPDxEMT8=;
        b=wBz/CGc3KMusO9dCNQ2v5EMjNdDFcmOidVIqfySO48dE0OlDYcRThcFLKvBsOzYurg
         Rbs/EgmZggE6DXcZxV/4oQN/VMyBUbOa5mlhzJ2cOo8ZRRAN6O/jhCCUUfW4FzQKUP4e
         gen4Q/ceheRGYc0h5XLLDopJQCU5iHsJzUFTxyCPvtaHKWi/e0umNI2RTzrhw+EAJ2U2
         cvG046B2mNg9YrxNCnl81zHi8+wdr2aHw31t5rY4G+DVYnmudizdvhnB0yZ6GpDYIvM2
         GljY+qioFy+vDHWWsrzsx9b8pSjRSGXY2qQqGBqaet6gbKX2V5rEBVSRh6B4vvF1R5Fb
         tf/w==
X-Forwarded-Encrypted: i=1; AJvYcCXw8cuMRMITv1KxNoTJenZ+OOeIZskRnLFmwusdF3FPiiYmQwolUXwdzG0oKR6rNzXCUfLU6tFqXfRvgp8DStcQUuadf7xk8oBAMPg=
X-Gm-Message-State: AOJu0YzxilDxSGRzzYqOsRqkApTAZfB6Ybhs+Tyjl/WquWFvsa/AXLot
	GZdxyeXFNNeGSfWkOGM+6C3o4ffpMpzSoU+HGY6S4suHMkh3G7DBdvqs+eMO
X-Google-Smtp-Source: AGHT+IGYu8d37+M+Hyt6EPIoBZhXbKT9k6mfbVygFCJcEx7bVGhnKAsjEq7wGIDWsDQqLgqQPmh1wg==
X-Received: by 2002:a05:6808:f15:b0:3c2:30b2:c6c2 with SMTP id m21-20020a0568080f1500b003c230b2c6c2mr1468161oiw.26.1709876434258;
        Thu, 07 Mar 2024 21:40:34 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:13a:f30c:e020:9a13])
        by smtp.gmail.com with ESMTPSA id n21-20020a056a000d5500b006e669289fa7sm661870pfv.220.2024.03.07.21.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 21:40:33 -0800 (PST)
Date: Thu, 7 Mar 2024 21:40:31 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v6.8-rc7
Message-ID: <Zeqhkk0HJwEIUZ0D@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.8-rc7

to receive updates for the input subsystem. You will get:

- a revert of endpoint checks in bcm5974 - the driver is being naughty
  and pokes at unclaimed USB interface, so the check fails. We need to
  fix the driver to claim both interfaces, and then re-implement the
  endpoints check

- a fix to Synaptics RMI driver to avoid UAF on driver unload or device
  unbinding

- a few new VID/PIDs added to xpad game controller driver

- a change to gpio_keys_polled driver to quiet it when GPIO causes probe
  deferral.

Changelog:
---------

Javier Carrasco (1):
      Revert "Input: bcm5974 - check endpoint type before starting traffic"

Mathias Krause (1):
      Input: synaptics-rmi4 - fix UAF of IRQ domain on driver removal

Max Nguyen (1):
      Input: xpad - add additional HyperX Controller Identifiers

Uwe Kleine-König (1):
      Input: gpio_keys_polled - suppress deferred probe error for gpio

Diffstat:
--------

 drivers/input/joystick/xpad.c             |  6 ++++++
 drivers/input/keyboard/gpio_keys_polled.c | 10 ++++------
 drivers/input/mouse/bcm5974.c             | 20 --------------------
 drivers/input/rmi4/rmi_driver.c           |  6 +++---
 4 files changed, 13 insertions(+), 29 deletions(-)

Thanks.


-- 
Dmitry

