Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07407AE394
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 04:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjIZCHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 22:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjIZCHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 22:07:02 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FD8D8;
        Mon, 25 Sep 2023 19:06:55 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-59f7cc71e2eso39832367b3.0;
        Mon, 25 Sep 2023 19:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695694015; x=1696298815; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KW9OTVtKUcJ1r6ahtEjJyCkdCwhSV0YXVMo8xFwAxVM=;
        b=K2bRV28+dRZCt/LOuaOeytoWqkNVeAwwnenQa3QIQrVsxr29SBBH1F0jygk7GvorgD
         TR0HrLnmRyWZdpMtofma4ZKKT5Y9OBZ7I6hlHIJJ8jTmyd9ZDOztZ2Vc7shpt8Y4aMyo
         AEp15+bqMUtmVdPRJsxX+rfa3noDmYkAi7oIAUJPqVkZwSM8OmEdMD/uQIVnu42dMQdb
         F7sUAHXISpdxcj/xi7GjttaZbC3bnkI34A5JohOwEfq25yflzQOo7E5dZ4ixyAqWmBCV
         qXm/DHxFMgSDAy962GOzgWEe/XZsrUf+rihplIN9IfUZBebfK9Mo2H1+HxDHKBVh754d
         n2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695694015; x=1696298815;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KW9OTVtKUcJ1r6ahtEjJyCkdCwhSV0YXVMo8xFwAxVM=;
        b=uliBfo4moISODAL579S+zYtfzJgbYQeS4I3LQvV7Bgv4AuPeI9z1bmf4xkkjInnEdU
         JCT190RLa4OX1Jg+sBt43PQzOBOsV7DiuWmvYRr8rvTaxDL+tS7QjiANP1GChuw7L/Ev
         sswVnanuJLA3dmn6i9pqe1fjyYJ1cy9KFyRf+EFy+23SDFHpzUabSWYmf+PfiGEWT/Wf
         AqD78QVQZtTM0D5KSndeSGKGs9tbHkWrUynu5plTvsuXItw9DQX8P9u0lIbfLAag0+kc
         sBpNhcWk5NOSXfydGYUZyp4I7Ii8Cpenb5PYqkAMhnL6SSqyFhu+UqE94ZhbCD2Wl6VW
         mhxg==
X-Gm-Message-State: AOJu0YwSnVjuAwpJ2/v5+QGtJLiUBZh34yAFiakKJSkTBhbEEUTlA6rp
        qj8/8UMMvoqdPnJBwT+wGzTEw/dI+WDNWojaclwfMDQJTSk=
X-Google-Smtp-Source: AGHT+IFtc/Rq3MDTSkg96FLLZ9Z1rrv8f1cL+mPnrxg7pqkqeQrwPWBEmiJdPnsXUh2xPSC6bRJgh7suU0EBm9JDKEw=
X-Received: by 2002:a0d:ce81:0:b0:589:b3c6:95ff with SMTP id
 q123-20020a0dce81000000b00589b3c695ffmr9314078ywd.36.1695694014949; Mon, 25
 Sep 2023 19:06:54 -0700 (PDT)
MIME-Version: 1.0
From:   John Salamon <salamonj9@gmail.com>
Date:   Tue, 26 Sep 2023 11:36:43 +0930
Message-ID: <CA+fyA4SqT4jgpWeq_ipp7i3ZM7s=gQkSdtsPw6x+zeJdGcXvqw@mail.gmail.com>
Subject: PROBLEM: RTL8821CS SDIO card is unusable on boot (Anbernic RG353V)
To:     pkshih@realtek.com
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On an Anbernic RG353V using the latest mainline kernel, the wifi
(RTL8821CS) is in an unusable state on boot (no wireless adapter
available) and I get the following kernel messages:

[    5.878711] rtw_8821cs mmc3:0001:1: Firmware version 24.11.0, H2C version 12
[    6.218709] rtw_8821cs mmc3:0001:1: sdio read32 failed (0x11080): -110
[    6.218844] rtw_8821cs mmc3:0001:1: sdio write32 failed (0x11080): -110
[    6.219136] rtw_8821cs mmc3:0001:1: sdio read32 failed (0x10080): -110
[    6.219230] rtw_8821cs mmc3:0001:1: sdio write32 failed (0x10080): -110
[    6.219409] rtw_8821cs mmc3:0001:1: sdio read32 failed (0x10040): -110
[    6.219503] rtw_8821cs mmc3:0001:1: sdio write32 failed (0x10040): -110
[    6.219706] rtw_8821cs mmc3:0001:1: sdio read32 failed (0x11700): -110
[    6.219800] rtw_8821cs mmc3:0001:1: sdio write32 failed (0x11700): -110
[    6.219967] rtw_8821cs mmc3:0001:1: sdio read32 failed (0x11708): -110
[    6.220474] rtw_8821cs mmc3:0001:1: sdio write32 failed (0x11330): -110
[    6.220673] rtw_8821cs mmc3:0001:1: sdio read32 failed (0x1022c): -110
[    6.220863] rtw_8821cs mmc3:0001:1: sdio write32 failed (0x1022c): -110
[    6.220993] rtw_8821cs mmc3:0001:1: sdio read32 failed (0x20): -110
[    6.221570] rtw_8821cs mmc3:0001:1: sdio read32 failed (0x11208): -110
[    6.221695] rtw_8821cs mmc3:0001:1: sdio write32 failed (0x11208): -110
[    6.222076] rtw_8821cs mmc3:0001:1: sdio read32 failed (0x20): -110
[    6.222195] rtw_8821cs mmc3:0001:1: sdio read32 failed (0x24): -110
[    6.222322] rtw_8821cs mmc3:0001:1: sdio read32 failed (0x28): -110
[    6.222471] rtw_8821cs mmc3:0001:1: Failed to write 4608 byte(s) to
SDIO port 0x0000840c
[    6.222510] rtw_8821cs mmc3:0001:1: failed to write data to rsvd page
[    6.222680] rtw_8821cs mmc3:0001:1: failed to download rsvd page
[    6.222851] rtw_8821cs mmc3:0001:1: failed to download firmware
[    6.223011] rtw_8821cs mmc3:0001:1: failed to setup chip efuse info
[    6.223033] rtw_8821cs mmc3:0001:1: failed to setup chip information
[    6.224013] rtw_8821cs: probe of mmc3:0001:1 failed with error -110

If I rmmod rtw_8821cs and modprobe rtw_8821cs, it actually becomes
usable, at least for a while.
After some time, many repeated messages like this appear:

[ 1562.774009] rtw_8821cs mmc3:0001:1: timed out to flush queue 2
[ 1563.234018] rtw_8821cs mmc3:0001:1: timed out to flush queue 1

And I have to do the rmmod/modprobe trick again for it to start working again.

I can always reproduce this on boot.
I am using the latest mainline kernel, uboot and linux-firmware (I've
also tried 6.5 kernel with the same result).
kernel .config:
https://github.com/human9/rg353v_linux/blob/main/linux_new.config
dmesg: https://github.com/human9/rg353v_linux/blob/main/dmesg.txt
