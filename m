Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACFC80AE8E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574773AbjLHVFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 16:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjLHVFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 16:05:12 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA00E1985;
        Fri,  8 Dec 2023 13:05:15 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-35d396ae91fso9016175ab.3;
        Fri, 08 Dec 2023 13:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702069515; x=1702674315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqvWOUimTI+IzTX35gstFYIO9U9PLoGOpX1jOFzw7Ys=;
        b=VB8vo0Xqp7swVF76pi+Avk7GpowXCingFV9/UxArKQEyRHEnu7a0vK583YvK8KIc4G
         6UcTaX4bpynXTE3LBca85RfMUeY1PhinVgGlOhr2wQQC1TeaXvXNHkOYvrtFIE/QWHt6
         ozZzWGV9HP9XTSn4uZY5HoQW5RMYZDs/omv6N4NpOGrzhDHYuyxexEkcmwibdnz8On88
         U2RGVqvWUJCu/EEk7MPx3RfmV2y6I2mwDmQHruu4Quu4hSwlR25zxt+b3c2YLe6grdrJ
         W0i32/Av3vgTpgEdUvNUMvrlGZwcGk2LFIrPAK/m5mUn6nm/if5HbAkXwzSz0ne/kGwG
         0iWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702069515; x=1702674315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqvWOUimTI+IzTX35gstFYIO9U9PLoGOpX1jOFzw7Ys=;
        b=jnjbuA4TVP8fwtXfor1XH65CXAj7buihoiIBJ5XGYz2TW/C2T1G3dIEbANQrryu/YT
         oFcdHNMr5cGGDz4E5JlMzlCt1MGnpveYE5PyFFbTUxGucI1oX+OyihADMcklpcugTAkJ
         L03sUwckaJFk8ge9XqbLkMn2nXhfmtoKuxoL3DEUws1geQ+FdFUiVJyOc6fPEA4FjZGD
         uo7bfYFzvWd6e+nh28OZ1B2kL+pKIsdoO6+mA22z+yC1XXp0WW9kZVERBwgo085Scpf0
         VaiTLbApKllRfN7sMv7CPDET3XYLQ14cKEgUt2YKRKaJSKj05Zq7cq8SLG5lhKXLu63E
         UczA==
X-Gm-Message-State: AOJu0Yzqxb8b+4HMHkwDyU3Bfef5hiqRT+sduRWUysMHW7zdpDJkBspQ
        76MGQP91/PI3d6ndphYAuRk=
X-Google-Smtp-Source: AGHT+IHJccm62cOKUWkw44apCwQUzTR5ks7nbDr2UPv/+vNBT8nqq4QoUUazVrDhRPx34NpezSVCGQ==
X-Received: by 2002:a05:6e02:1bc9:b0:35d:5f9d:d9be with SMTP id x9-20020a056e021bc900b0035d5f9dd9bemr915380ilv.10.1702069514926;
        Fri, 08 Dec 2023 13:05:14 -0800 (PST)
Received: from celestia.nettie.lan ([2001:470:42c4:101:971d:15c7:de39:3b4b])
        by smtp.gmail.com with ESMTPSA id g12-20020a056e020d0c00b0035d5a1760c1sm736458ilj.69.2023.12.08.13.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 13:05:14 -0800 (PST)
From:   Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 2/2] usb: dwc3: host: Disable USB3 ports if maximum-speed doesn't permit USB3
Date:   Fri,  8 Dec 2023 14:04:58 -0700
Message-ID: <20231208210458.912776-3-CFSworks@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231208210458.912776-1-CFSworks@gmail.com>
References: <20231208210458.912776-1-CFSworks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DWC3 core can be configured (during IP instantiation, and/or via
configuration signals) not to have any USB3 ports. Some SoCs, however,
may have USB3 interfaces enabled that do not have USB3 PHYs driving
them. This can be due to a few circumstances, including:
a) The hardware designer didn't include USB3 PHYs and neglected to
   disable the DWC3 core's USB ports (I know of no instance where this
   has actually happened, however, and it seems pretty unlikely).
b) The USB3 PHYs are present but powered off. Perhaps a driver to enable
   the PHYs has not yet been written or merged, or USB3 capability is
   unneeded in the system and the system designer would like to conserve
   power.
c) The USB3 PHYs are muxed to a different controller. This can happen if
   the PHYs support non-USB protocols and one of these alternate
   functions is needed instead.

In these circumstances, if the DWC3 does not receive clear link status
indication on an enabled USB3 port, the DWC3 may not allow even USB2
to function: in host mode, the DWC3 generates an endless barrage of
PORT_CSC status on the accompanying USB2 port, and the xHCI driver is
unable to bring the USB2 port to a functioning state.

Fix this by first checking if the maximum-speed property in the DT
permits USB3. If not, pass the new `disable-usb3;` property to the
virtual xHCI device, causing the xHCI driver not to enable the USB3
ports. This allows USB2 to function even with USB3 PHYs
missing/misbehaving, and may be useful even when the USB3 PHYs are
well-behaved: a DT author may know that USB3 support is intact, but
disconnected (not exposed off-board) and choose to lower the
maximum-speed property to avoid an unusable USB3 rhub showing up in
sysfs/lsusb where it may mislead end-users.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 drivers/usb/dwc3/host.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index 61f57fe5bb78..29f170927e70 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -61,7 +61,7 @@ static int dwc3_host_get_irq(struct dwc3 *dwc)
 
 int dwc3_host_init(struct dwc3 *dwc)
 {
-	struct property_entry	props[4];
+	struct property_entry	props[5];
 	struct platform_device	*xhci;
 	int			ret, irq;
 	int			prop_idx = 0;
@@ -95,6 +95,9 @@ int dwc3_host_init(struct dwc3 *dwc)
 	if (dwc->usb2_lpm_disable)
 		props[prop_idx++] = PROPERTY_ENTRY_BOOL("usb2-lpm-disable");
 
+	if (dwc->maximum_speed == USB_SPEED_FULL || dwc->maximum_speed == USB_SPEED_HIGH)
+		props[prop_idx++] = PROPERTY_ENTRY_BOOL("disable-usb3");
+
 	/**
 	 * WORKAROUND: dwc3 revisions <=3.00a have a limitation
 	 * where Port Disable command doesn't work.
-- 
2.41.0

