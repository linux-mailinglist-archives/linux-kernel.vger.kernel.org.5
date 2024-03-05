Return-Path: <linux-kernel+bounces-92851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F00F98726E0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7AAF287A09
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EE61B957;
	Tue,  5 Mar 2024 18:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvXgi+D3"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0ED1426F;
	Tue,  5 Mar 2024 18:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664442; cv=none; b=p4IsNI7NqqDF//ic0TPAFJw32P2LI0bpOICHWClgR5CBVB5UfL+WML3DolRBrrJcUbOXFz6zSWx0cf7jaIxe256BhQx2r8t9IkR03BWP7gvQexxfMV4uGxl4FwSno0SJHQyXiHJKQvAMyV6S095i455aN/Lvpc2FY4deOJRXCCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664442; c=relaxed/simple;
	bh=iAaSLHsYs9roiiEX5r9RnEO+PBQ1/2zpvlq3PkG99m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8NVGrkCRdUH3D0zzfLT0t4lVKuvGPw9IJBvNJBwcxF+HKIqYxokHbdwzAn1KvZi1M4pf2oAf5udoSkJw/K6q1weqlbENpIY5tQFIPWEgLuBo/JyZwyMDkWFBO8X0PdIZsy2EKOjPayuPsSjl6Dd+fAuLC9zLMVnZx2yQKF8L0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvXgi+D3; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dc49b00bdbso54459925ad.3;
        Tue, 05 Mar 2024 10:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709664440; x=1710269240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p4Ja5phbKUQl6LGtsUwc/A0bRu4rsYTBRUxvAe+9/4Y=;
        b=KvXgi+D36nqS7SdTTPKH8w3TaychHtwyDDSPEPctQi7/xRF3RiT9XFAfTTQ0OoPaBJ
         1ZGpHQVBn2BVLwZKsNzV1JoyFYyqWqz/PriMX/tJB//GkJHW0bcLy26MZTeeRxnRpxCj
         53IFRdKaJ+HxcXsD8Nhq07CwnSTx4RcKmJuWI0U47fen0cQtrMKk4Z78FFcskU5Symhk
         4kLBU4GoZUxqAY4e9zSdNwqjpBIZ+BVoXQ1C+uTqBzUfuMrdvxdxDCzFyuc84Up06Hxh
         PXnnpy+fGdSDH+l22K9N/gb0SaZHITiO/AxTFHm4QY0WVYxUM0l5/FtKsMzvAgGkehkO
         ZXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709664440; x=1710269240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4Ja5phbKUQl6LGtsUwc/A0bRu4rsYTBRUxvAe+9/4Y=;
        b=vywg1heKDJziGkYjJ7GBI7FqO+mfPPfwqhzZek2a5Igiz8JSTVhNDMuhvYCS95YdGY
         jtVDtqYAnEeu4/oeZsEacVHLaL7mze4RY8z1sSCCA8fqcjkhxATTzVbBq/7fI1ZZ8WQw
         WjlXq7VBYFVaojp4Vlci5T2oTWkJAa3TSnEklyb+3xjGBHHZM3VRL3JnIJL1MHfy3sWT
         FFmeAc05qKebcfgAIFCHj1qkKAV/QJINwHTiljhE12pBd70UeajNgX1RsXj+i49KMHzq
         N9ECpaUjYe1ILhpFQFYhAkKUkGFDAZsPMLWpAz/ksiiPovA2j2ZAeDdLjt+KJQpkMXid
         ADBA==
X-Forwarded-Encrypted: i=1; AJvYcCUaG5KP7DkAzZ7J81Vo+gljqvjd79MttWypDDRfQfYus3YKHAj46GAGM97gGaslsKckXr9tm6zHk/lMJ6Twym/WqgQ2um2b3SwfGrc=
X-Gm-Message-State: AOJu0YxE3Ju/jZPNlAwlb+dKqaCNSnS8N5h+sbxn1L6H1vC/owO1P/FD
	yCutzjnAgqPzbLPfE9CDmtZ+UlUIAC1baEE03BdOBc1pSvSvwTP8
X-Google-Smtp-Source: AGHT+IH1qbh8T+uOB1J+/dWQ+S1Mi36WGIRdloSgQg0mgDX4K7CA0qNXIF7gstpIcIvf0HXxwh7b4w==
X-Received: by 2002:a17:902:7c92:b0:1dc:cc09:ebad with SMTP id y18-20020a1709027c9200b001dccc09ebadmr2188437pll.28.1709664440320;
        Tue, 05 Mar 2024 10:47:20 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:a5d5:fe74:fba8:86b5])
        by smtp.gmail.com with ESMTPSA id d15-20020a170903230f00b001dc3c4e7a12sm10915798plh.14.2024.03.05.10.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 10:47:19 -0800 (PST)
Date: Tue, 5 Mar 2024 10:47:17 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jonathan Denose <jdenose@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, jefferymiller@google.com,
	Jonathan Denose <jdenose@google.com>,
	Raul Rangel <rrangel@chromium.org>, linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: psmouse - add resync_on_resume dmi check
Message-ID: <ZedotW8Yu6tJ2yYL@google.com>
References: <20231102075243.1.Idb37ff8043a29f607beab6440c32b9ae52525825@changeid>
 <ZcKs589qYxviC1J4@google.com>
 <CALNJtpV0KsOusPQeGv8bQ3jKy2sUj+k=mPHc172f+vMaTDYPfg@mail.gmail.com>
 <ZcZ2oG1Rls-oR593@google.com>
 <CALNJtpWNbSZdpxky9hTiSRsaGgLDUnM66QGEy213d3Lhra0hsw@mail.gmail.com>
 <ZeDLq9gPs5InBmdK@google.com>
 <CALNJtpWwhen2H9OT1-rZ4bt+huwXPOPz6qVDJ5g+emE1wRSLsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALNJtpWwhen2H9OT1-rZ4bt+huwXPOPz6qVDJ5g+emE1wRSLsw@mail.gmail.com>

On Mon, Mar 04, 2024 at 11:17:31AM -0600, Jonathan Denose wrote:
> I disabled the ideapad driver by rebuilding the kernel without the
> ideapad_laptop module. That does fix the suspend/resume issue!
> 
> Attached are the logs. Is there a way to make this permanent?

Could you please try the patch below? Thanks!

---

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 9fbb8d31575a..2f0c143c3137 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -127,6 +127,7 @@ MODULE_PARM_DESC(unmask_kbd_data, "Unconditional enable (may reveal sensitive da
 #endif
 
 static bool i8042_present;
+static bool i8042_ready;
 static bool i8042_bypass_aux_irq_test;
 static char i8042_kbd_firmware_id[128];
 static char i8042_aux_firmware_id[128];
@@ -190,6 +191,26 @@ void i8042_unlock_chip(void)
 }
 EXPORT_SYMBOL(i8042_unlock_chip);
 
+int i8042_device_link_add(struct device *consumer)
+{
+	if (!i8042_present)
+		return -ENODEV;
+
+	if (!i8042_platform_device || !i8042_ready)
+		return -EPROBE_DEFER;
+
+	return device_link_add(consumer, &i8042_platform_device->dev,
+			       DL_FLAG_STATELESS) != NULL;
+}
+EXPORT_SYMBOL(i8042_device_link_add);
+
+void i8042_device_link_remove(struct device *consumer)
+{
+	if (i8042_platform_device)
+		device_link_remove(consumer, &i8042_platform_device->dev);
+}
+EXPORT_SYMBOL(i8042_device_link_remove);
+
 int i8042_install_filter(bool (*filter)(unsigned char data, unsigned char str,
 					struct serio *serio))
 {
@@ -1574,6 +1595,7 @@ static int i8042_probe(struct platform_device *dev)
  */
 	i8042_register_ports();
 
+	i8042_ready = true;
 	return 0;
 
  out_fail:
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index ac037540acfc..d4d1bccbe882 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1842,6 +1842,13 @@ static int ideapad_acpi_add(struct platform_device *pdev)
 			ideapad_register_rfkill(priv, i);
 
 	ideapad_sync_rfk_state(priv);
+
+	err = i8042_device_link_add(&pdev->dev);
+	if (err) {
+		dev_err(&pdev->dev, "failed to link with 8042 controller :%d", err);
+		goto i8042_link_failed;
+	}
+
 	ideapad_sync_touchpad_state(priv, false);
 
 	err = ideapad_dytc_profile_init(priv);
@@ -1882,7 +1889,9 @@ static int ideapad_acpi_add(struct platform_device *pdev)
 
 backlight_failed:
 	ideapad_dytc_profile_exit(priv);
+	i8042_device_link_remove(&pdev->dev);
 
+i8042_link_failed:
 	for (i = 0; i < IDEAPAD_RFKILL_DEV_NUM; i++)
 		ideapad_unregister_rfkill(priv, i);
 
@@ -1909,6 +1918,7 @@ static void ideapad_acpi_remove(struct platform_device *pdev)
 
 	ideapad_backlight_exit(priv);
 	ideapad_dytc_profile_exit(priv);
+	i8042_device_link_remove(&pdev->dev);
 
 	for (i = 0; i < IDEAPAD_RFKILL_DEV_NUM; i++)
 		ideapad_unregister_rfkill(priv, i);
diff --git a/include/linux/i8042.h b/include/linux/i8042.h
index 95b07f8b77fe..ce45569f5246 100644
--- a/include/linux/i8042.h
+++ b/include/linux/i8042.h
@@ -52,12 +52,15 @@
 #define I8042_CTR_AUXDIS	0x20
 #define I8042_CTR_XLATE		0x40
 
+struct device;
 struct serio;
 
 #if defined(CONFIG_SERIO_I8042) || defined(CONFIG_SERIO_I8042_MODULE)
 
 void i8042_lock_chip(void);
 void i8042_unlock_chip(void);
+int i8042_device_link_add(struct device *dev);
+void i8042_device_link_remove(struct device *dev);
 int i8042_command(unsigned char *param, int command);
 int i8042_install_filter(bool (*filter)(unsigned char data, unsigned char str,
 					struct serio *serio));
@@ -74,6 +77,15 @@ static inline void i8042_unlock_chip(void)
 {
 }
 
+int i8042_device_link_add(struct device *dev)
+{
+	return -ENODEV;
+}
+
+void i8042_device_link_remove(struct device *dev)
+{
+}
+
 static inline int i8042_command(unsigned char *param, int command)
 {
 	return -ENODEV;



Thanks.

-- 
Dmitry

