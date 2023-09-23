Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67ED37AC20E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 14:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjIWM3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 08:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjIWM3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 08:29:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E677A3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 05:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
 t=1695472121; x=1696076921; i=j.neuschaefer@gmx.net;
 bh=5PbtnxHt4pzwD8Q2b/5utg2+U5eL23wgfkdvavzRTeM=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=o5A1d7wGiMAYUAcAekHw+yVsJDV1l7XbJ7hoBYr577AlA2DrQrq8Qc2qmEFwncVRx0BHr2EbYtm
 e7+7W9mJTFkScaMhUkjJOBQ5aMG4RMyg4dIJgEFIQMgAZOwm2n4Oi4kbj74o9b5EtlhgcHbVMv/0f
 KQIcPR4vD5R8lxsOWX3VXmC6RvsAO95a2EzKJ55HZKYG2cxW/sxCYcaDX+9Le5QMWh6/wmb0omQGq
 q0PJjJ3Jr1l4r2VDv8NbBQLJr5WZ4fKowUhzZfh7GDBwUAsLOqCm7acDnyzjwyneFM6NzL35vJYO5
 vL8aiVv6Z6LwGgHwrodr1oiXu0iAPBLzvwgA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([89.0.47.152]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8ob6-1rmBoN1xP4-015qKl; Sat, 23
 Sep 2023 14:28:41 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Russell King <linux@armlinux.org.uk>, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: wpcm450_defconfig: Fix formatting of 32-bit number
Date:   Sat, 23 Sep 2023 14:28:32 +0200
Message-Id: <20230923122833.1734268-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pn8f3Er7D00eg+JBPEfT1LBHFNbmo1D6zRqUPQqSN8TNw37DOtM
 6yuFL8Fw7QNZad/4aSq/+sUfFT1vGyJYmCJJeY1/YUvgiytcF5yd2mzGupkYDgiIySZO8Hl
 Vplq2nkjwP9iEL/NR2ARTZhcp5+KZVdU23M8gAEzxuEdK4PVaC6N71yc7PtaJt9IOt4BXFV
 tcihTtr/8qyQBgRXwQCxg==
UI-OutboundReport: notjunk:1;M01:P0:PCHRbzln+TM=;pObnbTvGRUjCreVVnsegac+vUiF
 +kT0jLsW6Gavv1xvlxZW+6FQKxzzfazO0iS3Ot6KsysYaaa0AZYDU8xxDe9ZRP/dpUpKxSnHg
 tNGpUCRYnL9ofp1qxFinoAhDPRorVm8qfU0r/+AqgcEb2OZEHdqXmjffieSaGfwvbm3yEdDn9
 rwvUWOl5ZkxdvKRHcDT8BBMHlp/SoGAuGU+W+iHRCjYOWrxNVhZMNtqYJ5zKl7w0E14IWqW2W
 /f/Kruq9j/1PZm4VSa+WbVnDEz/sxO0flYLjmnrDsv/boNXkFnFAMYue/IXu8vV7QKK0ZbZjg
 X38EEmJd5jo07q8kVs5bsw9l2S3t2+vNHkKzbszedAj+TMZtBjt9K63NYv0kyjQSmx9sHLKhX
 Z8LFxTj243DzwZuqXdllbkZoqDfKvdSiwfpo/HoszsndLbafLCLHwRiuDrReNt/kLSLAUwxe6
 DDtzAcgMwJi2dLjdsG2JUQ1YXMFJQ9xSBxVH1HqP704ZkLYtMvk347wx79dAKBS4e7he/bUEK
 OU74kOCiH3DJXPas1Nq55RplrsLjZwgSpCQm5aomwyq2u7p5rWbjkvP6+H0beaAGjlUpb/G5t
 /RE1TL/RZzkdvptJ+0sP+yHwHH1AwFFd0FZljg3u+zoAf6zs9yOYhoNQukcsUxxt3HTPIhlHr
 5y5dKtuDBNcVhVb602bPqWKCeIObqaQljJP8fub8qmVWrtrYLsZnBqmAFJITGgXus/kEYUfOj
 UoUbLdt6+iHxMIWNYIpKPiBUbatnA9N9fMOS325nSfRCmZ35OzGd4SoxsClZADGlvvfiaIsK1
 0gyJvkG0UzjwyEJDbYN4Hs+DVa5DtOsofEPDeMij33SAxzKHQq+daqX63mgAF4g1nBMJWwbIl
 dKt4LnFpWce7h5/ZNnQ/+QYJlTDen4/3TySwXo/Fp7zmq3AT6ka26eaSI5XFcFvdIy9pGaOJm
 cekimA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nine digits are one too many.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 arch/arm/configs/wpcm450_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/wpcm450_defconfig b/arch/arm/configs/wpcm450=
_defconfig
index 45483deab034f..78b6c671eade5 100644
=2D-- a/arch/arm/configs/wpcm450_defconfig
+++ b/arch/arm/configs/wpcm450_defconfig
@@ -206,6 +206,6 @@ CONFIG_DEBUG_USER=3Dy
 CONFIG_DEBUG_LL=3Dy
 CONFIG_DEBUG_LL_UART_8250=3Dy
 CONFIG_DEBUG_UART_PHYS=3D0xb8000000
-CONFIG_DEBUG_UART_VIRT=3D0x0ff000000
+CONFIG_DEBUG_UART_VIRT=3D0xff000000
 CONFIG_DEBUG_UART_8250_WORD=3Dy
 CONFIG_EARLY_PRINTK=3Dy
=2D-
2.40.1

