Return-Path: <linux-kernel+bounces-41209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B7D83ED6F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6BF9B2287F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 14:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8436025769;
	Sat, 27 Jan 2024 14:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="YpY6eFSj"
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23FA1E51D
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706364487; cv=none; b=e5VpUIXsQuxv1sbLS3fb4VIzyC7pTgLeRPVB7w7n6QvtbDqh4D329WyZAPnIgD7+j6/8UrJEA4xH3PXZxVXyuLRADPYYKi4RF0zWr3O7cyO7aSUMCWEzXxtbJC/23vQW94hfXcABo8pLPGmTPnEadeEY+l7f0UydZAwbZ0/qFI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706364487; c=relaxed/simple;
	bh=cw1eeOM4RkSe0XSNPxAa/P/Ot8H/KXwR4u6/EczyARw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=qR2vTND6kDbdTfq0/sF4jZ6MDW8kvvapncZ2HVS3xDhsktzq1FYYpc6VmaPIdaxyrmlEy4qTgVipgYShk4NzA0le+zSKB9n5RDYm62yE1dwAuHiLUAduFHDLTnJIT5cxa/aN/CbK8i5vCY/anlK2IccE7N58p0xqwCOSEbwUa/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nctdev.nl; spf=pass smtp.mailfrom=nctdev.nl; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=YpY6eFSj; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nctdev.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nctdev.nl
X-KPN-MessageId: 514459e5-bd1d-11ee-abd4-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 514459e5-bd1d-11ee-abd4-005056999439;
	Sat, 27 Jan 2024 15:06:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:subject:from:to:mime-version:date:message-id;
	bh=bBpLD8rwKBISkYLaBimopWAIUafM5MHOvmogIK8NVCc=;
	b=YpY6eFSjjmBCmJ6/oSckRvnNyNKdIZ1YUAv42Z8p/HzXPjN32oOcXclKlTxARzZOy4b8Hi5Fz4224
	 QgF/zcqTGFoRI7ypSGJHKVwwpXANFD/rEausj140fge7lSgo4OCa47dj1IwsiPqYGIW0bsyeKjlAu6
	 9RKmwdJITA7Mgubo=
Received: from [192.168.2.19] (84-86-195-241.fixed.kpn.net [84.86.195.241])
	by smtp.kpnmail.nl (Halon) with ESMTP
	id 51b0c109-bd1d-11ee-ad35-005056998788;
	Sat, 27 Jan 2024 15:06:51 +0100 (CET)
Message-ID: <9a001fc8-d748-7d45-9a0f-6a2a5dd3438d@nctdev.nl>
Date: Sat, 27 Jan 2024 15:06:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: linux-kernel@vger.kernel.org
From: Nico Coesel <nico@nctdev.nl>
Subject: Patch to allow hot-plugging Atmel AT24 eeproms
Organization: NCT Developments
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,
I'm working on an embedded project which uses SFPs (hot-pluggable 
optical network interface modules) which have two Atmel 'AT24' 
compatible eeproms inside. I wanted to be able to read the contents of 
the eeproms through the nvme subsystem as a file so the higher level 
software doesn't need to mess with I2C and all.

I tried to use the at24 driver but it tests if the device is present or 
not. Since the device may not be present, this behaviour is not suitable 
for the project I'm working on. The patch below (against kernel version 
5.4.142) adds a hotplug flag so the 'device present' test is skipped and 
the device is added nevertheless. The behaviour is controlled by an 
extra device property called 'hotplug'.


diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 2cccd82..c4e9cf3 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -24,6 +24,9 @@
  #include <linux/pm_runtime.h>
  #include <linux/gpio/consumer.h>

+//NC: Added flag to support devices not being preseny
+#define AT24_FLAG_HOTPLUG    BIT(8)
+
  /* Address pointer is 16 bit. */
  #define AT24_FLAG_ADDR16    BIT(7)
  /* sysfs-entry will be read-only. */
@@ -592,6 +595,10 @@
      if (device_property_present(dev, "no-read-rollover"))
          flags |= AT24_FLAG_NO_RDROL;

+    //NC: Add hotplug flag. This skips device detection
+    if (device_property_present(dev, "hotplug"))
+        flags |= AT24_FLAG_HOTPLUG;
+
      err = device_property_read_u32(dev, "address-width", &addrw);
      if (!err) {
          switch (addrw) {
@@ -709,11 +716,14 @@
       * Perform a one-byte test read to verify that the
       * chip is functional.
       */
-    err = at24_read(at24, 0, &test_byte, 1);
-    pm_runtime_idle(dev);
-    if (err) {
-        pm_runtime_disable(dev);
-        return -ENODEV;
+    if ((flags & AT24_FLAG_HOTPLUG) ==0)
+        {
+        err = at24_read(at24, 0, &test_byte, 1);
+        pm_runtime_idle(dev);
+        if (err) {
+            pm_runtime_disable(dev);
+            return -ENODEV;
+        }
      }

      dev_info(dev, "%u byte %s EEPROM, %s, %u bytes/write\n",

I used the device tree snippet from below:

     sfp1_info: eeprom@50 {
         compatible = "atmel,24c02";
         reg = <0x50>;
         read-only;
         pagesize = <1>;
         hotplug;
     };

I hope this can be of use to somebody.

Regards,
Nico Coesel

-- 
o---------------------------------------------------------------o
|                       N C T  Developments                     |
|Innovative embedded solutions                                  |
o---------------------------------------------------------------o


