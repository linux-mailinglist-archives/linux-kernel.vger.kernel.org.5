Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C897793CC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbjHKQE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjHKQE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:04:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B34E58;
        Fri, 11 Aug 2023 09:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691769864; x=1692374664; i=deller@gmx.de;
 bh=l5mnkz2k1a6F+R0c1XAKS+SjI6mLnDCae5GSDV64zGI=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=uZYblYq+QAUR6iLGwSJbpku4LpL/qb4ecQnUit29FrHTi9u18sbxsCuMNLtys4pe4Isrgkt
 StdV21Bl+r0xetTjB0T9RNgN/GBeYKW1jCPynqaDRDOJh8mktS9TQ9/MK/HmJMCCHg+fmLFYH
 6gS2y/rvLKdSHWZib6D2pb0xITYeUGrviUnhp8Xr1hhFDWuVIns6Ip5+kO4+jIXg/gUHcdR6E
 pJo9yNJPqL7jtPLtAMT7SXBFrWP14HYNmg85LAbyrRZDlb1PtfUcNfVmY16dCiiCn6likcJmQ
 CSLtWR/fsMk5Sn5zSAd9ydfYu7VkV+IPyphiDlIuaeK2GTcYL6eQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.154.87]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiaY9-1ppdlQ44NL-00fi2W; Fri, 11
 Aug 2023 18:04:24 +0200
Date:   Fri, 11 Aug 2023 18:04:22 +0200
From:   Helge Deller <deller@gmx.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-parisc@vger.kernel.org
Subject: [PATCH] init: Add lockdep annotation to kthreadd_done completer
Message-ID: <ZNZcBkiVkm87+Tvr@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:sVs2lL9kx55kJx/JfBa6k0AR9UXRwIyujuUX/Dw7vmKICNRJJct
 JDV4T4yUVK43jOOunqRKV/sF59/BtsjOm0QC6oaovIrtvs4HPmCEU+WO/ntp0nyx7oFHBpa
 Dx8f5kl4moRkAChAnRhiL9CRXUA30Zt1HfeiAW0UaIzQ3mcvq7OVf+pnJrE2hRfgt4DhQmo
 8rHVXExW8RCQX4dXddnnw==
UI-OutboundReport: notjunk:1;M01:P0:/hEbsO8p8IQ=;ORWZ6GbnDwFW7Fr6WQt7MP+3x4A
 3DFQ9fXw1HC97TsYJPWYTtR/yv5qqm0oF5Sm3rujxF77Jr4ilGnEh3+0vbVBO0qqASH7RYeWi
 IbxDLlYSiggwT+e1NVcedLpXfzBRxRgAhVDvltRSFFkXI5hAzUYtowmZup/yA7GupOc58BR7M
 l0IaAr6E7IHrDAD8EIdYMc9hnnz+JytVwk/fJ7xA1JKBrCp9hpAaU58j2KfTBPZ0NO0qLnBRu
 Yz3MlxOsdfn+TLwDySDV4AbmbxIPZaK81NvfftidXTbRma/UC7fJmoxCI6TbTH8hVXVo1qvZl
 fOxWiMHxJjcKezzy9z26gC9JMuZfSfXJiDk0pA7MjzpFqmd8ll2A3WnWCkEmomv2oI+kwZcW/
 iHwftyUj9/YGRMj7vP2HQHLPpWz6IlkAJLHHFp4NAhJFx2Wj43vTIFy5Bph5xyTSyq0OxlQ+z
 HBtk2emZbYiSwxBj3iivRmGfu4A/fjQpropfzk2wPNihJ+DQhK0TOJ6Om33VeFvXv8Sjnl5S/
 hwXiDjfG40HBjqXT/8//aG+sDPO2vjUfpUUe0frjPzBt14/Pxyc3A9OgBdahEI+MsTuZl+ALL
 f80kqoPZgTtiNyjkGKK/a82PTc72FGOTDva6qsB4r1ou8iZnema/Qem2cwGZ8EreBFK5buGLV
 FukkFh2cL5FL+GdCRJU6+EgHB9IyHK4RPZoYa0AjHmPpjY+62vSWeohBQEuVAwON2YuRpLuQ5
 xCqIxjS3r3RtH01Igs1eSxqbqQb5dtEZFjehfT9IAisyOI8awAOlO6ReQnbEHRLSoocSHMg4C
 TR2JuEWBrSvn1ZE0VbLAZta2Mu0JzVZS+azHasERTBNFJSsjRsaNb7G+U+wtPDTIYhRyyOwSd
 TyYmxG+tZstidUmTcXJu3HBGU2ceQrC34Mp91mA0FKQ/KIRIZOMkv7CX61HY7IYLtSPAUad9V
 cQc6qg==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing lockdep annotation to avoid this warning:

 INFO: trying to register non-static key.
 The code is fine but needs lockdep annotation, or maybe
 you didn't initialize this object before use?
 turning off the locking correctness validator.
 CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc5+ #681
 Hardware name: 9000/785/C3700
 Backtrace:
  [<000000004030bcd0>] show_stack+0x74/0xb0
  [<0000000041469c7c>] dump_stack_lvl+0x104/0x180
  [<0000000041469d2c>] dump_stack+0x34/0x48
  [<000000004040e5b4>] register_lock_class+0xd24/0xd30
  [<000000004040c21c>] __lock_acquire.isra.0+0xb4/0xac8
  [<000000004040cd60>] lock_acquire+0x130/0x298
  [<000000004146df54>] _raw_spin_lock_irq+0x60/0xb8
  [<0000000041472044>] wait_for_completion+0xa0/0x2d0
  [<000000004146b544>] kernel_init+0x48/0x3a8
  [<0000000040302020>] ret_from_kernel_thread+0x20/0x28

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/init/main.c b/init/main.c
index ad920fac325c..11870ca752de 100644
=2D-- a/init/main.c
+++ b/init/main.c
@@ -682,6 +682,8 @@ noinline void __ref __noreturn rest_init(void)
 	struct task_struct *tsk;
 	int pid;

+	init_completion(&kthreadd_done);
+
 	rcu_scheduler_starting();
 	/*
 	 * We need to spawn init first so that it obtains pid 1, however
