Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB837F8B03
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 14:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjKYNEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 08:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjKYNEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 08:04:10 -0500
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521AA8F
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 05:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1700917452; x=1701176652;
        bh=43iqpWsQOIvUj4idO/6jD2I4/VKJLSuA11XDlQSzX2g=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=zlk0cw4OPc+Zc80S+sBy1obAJ+u+qBnyIwAVzuvZjQr9cuEtY2bHiznhesoAFJUt3
         lt4PGu5kvoJw8MBwykRHqqCLlBtaeuSEaRPPiIa8RdD9nFFK138U9vW+oXt8e71gg6
         B9pCefKxZOx1OzRGJEO/SVOMcO1h56K0A3LrxHn7rabmGTJdzLKtDq0n5D8EYm+Nfs
         /c3wZTes8y1Jh3p0T/vgMavPGvSSYs2hs13k2EX68OIPJCCMptSERsdzcPV7laPCUU
         XPBsCPgXfNpLkUVml9apYUwg/J+vWhPuKuOdBwWTy9SSgDKQ1M9KBNl1nmkWHwFlci
         VEO0OVoJBb1fA==
Date:   Sat, 25 Nov 2023 13:03:45 +0000
To:     "kuba@kernel.org" <kuba@kernel.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
From:   cristian_ci <cristian_ci@protonmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "cristian_ci@protonmail.com" <cristian_ci@protonmail.com>
Subject: [BUG] wireless: mt7601u: probe failed with error -110
Message-ID: <Bnwq2et4CBU1_MS8X3rFeejMDmKf2dr_BNq60IzBcGKbjTxHG1CjJ0zB_wZjn8_iLJsi7fCx6_Eh01ozYBqPA-cEZXMZE_X98E0b7yotXCg=@protonmail.com>
Feedback-ID: 27475468:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this mt7601u device attempts continuously to probe spamming the followi=
ng lines to dmesg output:

[   99.604249] usb 1-2: new high-speed USB device number 7 using xhci_hcd
[   99.758083] usb 1-2: New USB device found, idVendor=3D148f, idProduct=3D=
7601, bcdDevice=3D 0.00
[   99.758098] usb 1-2: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[   99.758104] usb 1-2: Product: 802.11 n WLAN
[   99.758109] usb 1-2: Manufacturer: MediaTek
[   99.758114] usb 1-2: SerialNumber: 1.0
[   99.880644] usb 1-2: reset high-speed USB device number 7 using xhci_hcd
[  100.025562] mt7601u 1-2:1.0: ASIC revision: 76010001 MAC revision: 76010=
500
[  100.029499] mt7601u 1-2:1.0: Firmware Version: 0.1.00 Build: 7640 Build =
time: 201302052146____
[  100.455461] mt7601u 1-2:1.0: EEPROM ver:0d fae:00
[  100.645586] mt7601u 1-2:1.0: Error: MCU resp urb failed:-71
[  100.645610] mt7601u 1-2:1.0: Error: MCU resp evt:0 seq:5-4!
[  100.645678] mt7601u 1-2:1.0: Error: MCU resp urb failed:-71
[  100.645697] mt7601u 1-2:1.0: Error: MCU resp evt:0 seq:5-4!
[  100.645774] mt7601u 1-2:1.0: Error: MCU resp urb failed:-71
[  100.645816] mt7601u 1-2:1.0: Error: MCU resp evt:0 seq:5-4!
[  100.645920] mt7601u 1-2:1.0: Error: MCU resp urb failed:-71
[  100.645926] mt7601u 1-2:1.0: Error: MCU resp evt:0 seq:5-4!
[  100.646026] mt7601u 1-2:1.0: Error: MCU resp urb failed:-71
[  100.646031] mt7601u 1-2:1.0: Error: MCU resp evt:0 seq:5-4!
[  100.646036] mt7601u 1-2:1.0: Error: mt7601u_mcu_wait_resp timed out
[  100.784270] mt7601u 1-2:1.0: Vendor request req:07 off:0080 failed:-71
[  100.917572] mt7601u 1-2:1.0: Vendor request req:02 off:0080 failed:-71
[  101.057650] mt7601u 1-2:1.0: Vendor request req:02 off:0080 failed:-71
[  101.057737] mt7601u: probe of 1-2:1.0 failed with error -110
[  101.058197] usb 1-2: USB disconnect, device number 7
[  101.313690] usb 1-2: new high-speed USB device number 8 using xhci_hcd

I'm not the only one to have experienced this bug. I've been suggested to r=
eport that to kernel mailing list by linux support channels.

I've tested this bug against upstream 6.6.2 kernel tarball from the latest =
stable branch [1].

To solve this issue. I've also tried to patch mt7601u driver disabling mcu =
calibration. Which doesn't seem a wise idea because apparently it fixes pro=
bing but also hangs completely the machine after some seconds (so, it needs=
 a hard/forced shutdown).

Thanks in advance,

Regards,

Cristian.

[1] https://www.kernel.org/
