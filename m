Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92B1772736
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjHGOLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjHGOLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:11:34 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134E79E;
        Mon,  7 Aug 2023 07:11:33 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RKJB611VTz1KCNf;
        Mon,  7 Aug 2023 22:10:22 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 22:11:29 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: [PATCH -next] USB: misc: Remove unused include file usb_u132.h
Date:   Mon, 7 Aug 2023 22:11:28 +0800
Message-ID: <20230807141128.39092-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8be174835f07 ("usb: ftdi-elan: Delete driver") this include file
is not used anymore, so can remove it.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/usb/misc/usb_u132.h | 97 -------------------------------------
 1 file changed, 97 deletions(-)
 delete mode 100644 drivers/usb/misc/usb_u132.h

diff --git a/drivers/usb/misc/usb_u132.h b/drivers/usb/misc/usb_u132.h
deleted file mode 100644
index 1584efbbd704..000000000000
--- a/drivers/usb/misc/usb_u132.h
+++ /dev/null
@@ -1,97 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
-* Common Header File for the Elan Digital Systems U132 adapter
-* this file should be included by both the "ftdi-u132" and
-* the "u132-hcd" modules.
-*
-* Copyright(C) 2006 Elan Digital Systems Limited
-*(http://www.elandigitalsystems.com)
-*
-* Author and Maintainer - Tony Olech - Elan Digital Systems
-*(tony.olech@elandigitalsystems.com)
-*
-* The driver was written by Tony Olech(tony.olech@elandigitalsystems.com)
-* based on various USB client drivers in the 2.6.15 linux kernel
-* with constant reference to the 3rd Edition of Linux Device Drivers
-* published by O'Reilly
-*
-* The U132 adapter is a USB to CardBus adapter specifically designed
-* for PC cards that contain an OHCI host controller. Typical PC cards
-* are the Orange Mobile 3G Option GlobeTrotter Fusion card.
-*
-* The U132 adapter will *NOT *work with PC cards that do not contain
-* an OHCI controller. A simple way to test whether a PC card has an
-* OHCI controller as an interface is to insert the PC card directly
-* into a laptop(or desktop) with a CardBus slot and if "lspci" shows
-* a new USB controller and "lsusb -v" shows a new OHCI Host Controller
-* then there is a good chance that the U132 adapter will support the
-* PC card.(you also need the specific client driver for the PC card)
-*
-* Please inform the Author and Maintainer about any PC cards that
-* contain OHCI Host Controller and work when directly connected to
-* an embedded CardBus slot but do not work when they are connected
-* via an ELAN U132 adapter.
-*
-* The driver consists of two modules, the "ftdi-u132" module is
-* a USB client driver that interfaces to the FTDI chip within
-* the U132 adapter manufactured by Elan Digital Systems, and the
-* "u132-hcd" module is a USB host controller driver that talks
-* to the OHCI controller within CardBus card that are inserted
-* in the U132 adapter.
-*
-* The "ftdi-u132" module should be loaded automatically by the
-* hot plug system when the U132 adapter is plugged in. The module
-* initialises the adapter which mostly consists of synchronising
-* the FTDI chip, before continuously polling the adapter to detect
-* PC card insertions. As soon as a PC card containing a recognised
-* OHCI controller is seen the "ftdi-u132" module explicitly requests
-* the kernel to load the "u132-hcd" module.
-*
-* The "ftdi-u132" module provides the interface to the inserted
-* PC card and the "u132-hcd" module uses the API to send and receive
-* data. The API features call-backs, so that part of the "u132-hcd"
-* module code will run in the context of one of the kernel threads
-* of the "ftdi-u132" module.
-*
-*/
-int ftdi_elan_switch_on_diagnostics(int number);
-void ftdi_elan_gone_away(struct platform_device *pdev);
-void start_usb_lock_device_tracing(void);
-struct u132_platform_data {
-        u16 vendor;
-        u16 device;
-        u8 potpg;
-        void (*port_power) (struct device *dev, int is_on);
-        void (*reset) (struct device *dev);
-};
-int usb_ftdi_elan_edset_single(struct platform_device *pdev, u8 ed_number,
-        void *endp, struct urb *urb, u8 address, u8 ep_number, u8 toggle_bits,
-        void (*callback) (void *endp, struct urb *urb, u8 *buf, int len,
-        int toggle_bits, int error_count, int condition_code, int repeat_number,
-         int halted, int skipped, int actual, int non_null));
-int usb_ftdi_elan_edset_output(struct platform_device *pdev, u8 ed_number,
-        void *endp, struct urb *urb, u8 address, u8 ep_number, u8 toggle_bits,
-        void (*callback) (void *endp, struct urb *urb, u8 *buf, int len,
-        int toggle_bits, int error_count, int condition_code, int repeat_number,
-         int halted, int skipped, int actual, int non_null));
-int usb_ftdi_elan_edset_empty(struct platform_device *pdev, u8 ed_number,
-        void *endp, struct urb *urb, u8 address, u8 ep_number, u8 toggle_bits,
-        void (*callback) (void *endp, struct urb *urb, u8 *buf, int len,
-        int toggle_bits, int error_count, int condition_code, int repeat_number,
-         int halted, int skipped, int actual, int non_null));
-int usb_ftdi_elan_edset_input(struct platform_device *pdev, u8 ed_number,
-        void *endp, struct urb *urb, u8 address, u8 ep_number, u8 toggle_bits,
-        void (*callback) (void *endp, struct urb *urb, u8 *buf, int len,
-        int toggle_bits, int error_count, int condition_code, int repeat_number,
-         int halted, int skipped, int actual, int non_null));
-int usb_ftdi_elan_edset_setup(struct platform_device *pdev, u8 ed_number,
-        void *endp, struct urb *urb, u8 address, u8 ep_number, u8 toggle_bits,
-        void (*callback) (void *endp, struct urb *urb, u8 *buf, int len,
-        int toggle_bits, int error_count, int condition_code, int repeat_number,
-         int halted, int skipped, int actual, int non_null));
-int usb_ftdi_elan_edset_flush(struct platform_device *pdev, u8 ed_number,
-        void *endp);
-int usb_ftdi_elan_read_pcimem(struct platform_device *pdev, int mem_offset,
-			      u8 width, u32 *data);
-int usb_ftdi_elan_write_pcimem(struct platform_device *pdev, int mem_offset,
-			       u8 width, u32 data);
-- 
2.34.1

