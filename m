Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4A07A516B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjIRR6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjIRR6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:58:15 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE67116
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 10:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
        s=protonmail2; t=1695059888; x=1695319088;
        bh=ptC3c+rBLEFTuyfQUK2LpgarFJRpP17fWUb7YzH2OCU=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=EMcZEsPnJUce0c0lWk2Wy1trojsA85RROlQbVl35DU9YbGX3R4YpzXIAhCCgxxO+L
         v5QTEw0CMQRbStH8pu42NrTxx/0VVeHa+8aZqfvpW/HKkR/2gNMKRiNxSitogLKbEU
         5dNqVdnqzpb5qeKGWHbiZnIYyLEssofn3aXLaccS1Z1kgebT4t7QPKyC2GbwSlvFYV
         9crlhMvz4L/wrhl6rOewJ2vCb3sUK8EvRnyv5lkl83ouZiK9m4nAEfNIAkJAL6Ab0o
         tR2yGRBtRlvRPpYglYNl/5UMACjY299t/YPaRczHHkjyKFww93fJjZ/beaWXlJ1QuP
         Iv1cqLrACOJaw==
Date:   Mon, 18 Sep 2023 17:57:52 +0000
To:     linux-alpha@vger.kernel.org
From:   Peter Lafreniere <peter@n8pjl.ca>
Cc:     Peter Lafreniere <peter@n8pjl.ca>, jack@suse.cz,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        richard.henderson@linaro.org, ink@jurassic.park.msu.ru
Subject: [PATCH 7/7] arch: alpha: remove ReiserFS from defconfig
Message-ID: <20230918175529.19011-8-peter@n8pjl.ca>
In-Reply-To: <20230918175529.19011-1-peter@n8pjl.ca>
References: <20230918175529.19011-1-peter@n8pjl.ca>
Feedback-ID: 53133685:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ReiserFS has been deprecated for a year and a half, yet is still built
as part of a defconfig kernel.

According to commit eb103a51640e ("reiserfs: Deprecate reiserfs"), the
filesystem is slated to be removed in 2025. Remove it from the defconfig
profile now, as part of its deprecation process.

Signed-off-by: Peter Lafreniere <peter@n8pjl.ca>
---
 arch/alpha/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/alpha/configs/defconfig b/arch/alpha/configs/defconfig
index 1816c1dc22b1..3280bd9e6578 100644
--- a/arch/alpha/configs/defconfig
+++ b/arch/alpha/configs/defconfig
@@ -51,7 +51,6 @@ CONFIG_SERIAL_8250_CONSOLE=3Dy
 CONFIG_RTC_CLASS=3Dy
 CONFIG_RTC_DRV_CMOS=3Dy
 CONFIG_EXT2_FS=3Dy
-CONFIG_REISERFS_FS=3Dm
 CONFIG_ISO9660_FS=3Dy
 CONFIG_MSDOS_FS=3Dy
 CONFIG_VFAT_FS=3Dy
--=20
2.42.0


