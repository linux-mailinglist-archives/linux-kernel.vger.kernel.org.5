Return-Path: <linux-kernel+bounces-104570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9BD87D013
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67AB91C20C30
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9EA3D572;
	Fri, 15 Mar 2024 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nr67b5Y0"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76EB3D396
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710516067; cv=none; b=Im72fRigczUZfzu54WY6Y2xDGHEb90Cu5hbdYchLe6BIxY4kC3BoiX6OmRrLhRN249o/pk5kiSiyrjU4R2sb6ZONODW7tBpFEuxhmhgvntdlP3Xvcr+lEHFcfFi+vgKOOJq15r6U+/TZounRu+iqIPTyXtAvcSvgufLEbmpuACM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710516067; c=relaxed/simple;
	bh=oQSU8jjDxqSIS8TDvT+ZEvcNLa1hjhhovpfiAu/AtGE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=n4scKcZC8xq1tkJsWu+fJmvE5d6mljPOHHIRctB0oFgiRFPj1t/DGssqiut9ofP2YFKUU07L/7E0x2dUazAK7+L/89oVKD5i76D8ZnJ1uXF8acOYPxQEi3/saEGOkbqyS+esvVOZ+3Iq+9Ee2J1bQMedGz0lpOdoeWn1aGg5Fbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nr67b5Y0; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33e99b639e0so1304963f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 08:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710516064; x=1711120864; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZYKXoXyTZp5ci3YSNMbewaGpFg016n+QUTmPiNKutP8=;
        b=nr67b5Y00FpstdzWyaItuqUA+vzNDjKC74oTSeoDviOHdgGgzmHLGvU9D844S3caz8
         kgvzMrmwmLkLgiR1x4MkqRAdxkTzdeD+7U5OhD1j0x1l/W+KjrMTZu3RrzB59bsLbQ6h
         r0M38PMSTxoq/Lmfv7psSYUb3mkJSYmixKEsUgbLrlUOVKI1y3vc/TIq+9I4a76lLKuP
         U+PkpEagJhWDWYDBj15zvN4cdADt7XtiZam7KS3TuBRBEmo76POOMtK4AnkzZ9FG3Dig
         9EBPo9xiQBRR+wEeEZm8C+PmBdPrvrgqXODDnBCbOmJXOyEOHudKOHBXbH8V0yjRsbry
         LiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710516064; x=1711120864;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYKXoXyTZp5ci3YSNMbewaGpFg016n+QUTmPiNKutP8=;
        b=TbUupjGFn/zk7jfnVIjM2qyyDcpmKuIuXuImg8QgkzewgsqT6KwTAIzrnaTRrj3TKK
         ezVJQA6Tg4dVTqoT3W75gZOjhO7eIi6AyDrwmFlrTGEB9VXu+cFiQjmhG74o1NJ3iFc4
         SZlpBMgCrxdY5fuzwHPCmKHwKpgz0TzpXfJvF3ts2vIz44zqdVnmbBOk+I3mSbYrfI27
         0BQJnOfvSmOY3UT7gtwoL5j+js6r4R0LQPrErIZNnewjLfuF8PDD6HoS2OivftpfLqCh
         Apa9DOTo0NeoDNj6WYPWTVfmC/OSsjjNvFvsvRe6kioNbAE4k/PiRtqgTYgSpcAo+W35
         L3aw==
X-Forwarded-Encrypted: i=1; AJvYcCUzPbHiClGUerkg29pdKrFEnouTn/PEjsJ84z6UfQYnSIVvtNSY/IE6T11MG7KRJKJDB4bibyxM+6dW1nsDo24y0904ybJXTIpizV/0
X-Gm-Message-State: AOJu0Ywg4LrE1Pr6c4Z0Oz14jHNJz4GiMppnh6QL6x/U7QUiLm455qEG
	z+YzV5xjEXo7QpxBHBKxdp14phjD8PlTPLtmN9N+X5rbAvnHqRg7VGSqY61J/2s=
X-Google-Smtp-Source: AGHT+IEcaJ72Qyr1XY7S8v6ZEeNlHEDW0NpxpQP3hzbLmJpU6iEGgDon3kkU7qm+Qmk7GrjsL7dbSg==
X-Received: by 2002:a5d:6b0d:0:b0:33e:c2ea:5e1f with SMTP id v13-20020a5d6b0d000000b0033ec2ea5e1fmr3133725wrw.0.1710516064137;
        Fri, 15 Mar 2024 08:21:04 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id dd12-20020a0560001e8c00b0033eab3520a9sm3402524wrb.43.2024.03.15.08.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 08:21:03 -0700 (PDT)
Date: Fri, 15 Mar 2024 18:21:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] usb: usb-acpi: fix uninitialized variable in
 usb_acpi_get_connect_type()
Message-ID: <fdd4f94d-fb8c-44a0-9472-3485a567caca@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "pld" pointer is uninitialized if acpi_get_physical_device_location()
fails.  Initialize it to NULL.

Fixes: f3ac348e6e04 ("usb: usb-acpi: Set port connect type of not connectable ports correctly")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/usb/core/usb-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index f250dfc3b14d..2aeeaa389380 100644
--- a/drivers/usb/core/usb-acpi.c
+++ b/drivers/usb/core/usb-acpi.c
@@ -153,8 +153,8 @@ usb_acpi_get_connect_type(struct usb_port *port_dev, acpi_handle *handle)
 {
 	enum usb_port_connect_type connect_type = USB_PORT_CONNECT_TYPE_UNKNOWN;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_pld_info *pld = NULL;
 	union acpi_object *upc = NULL;
-	struct acpi_pld_info *pld;
 	acpi_status status;
 
 	/*
-- 
2.43.0


