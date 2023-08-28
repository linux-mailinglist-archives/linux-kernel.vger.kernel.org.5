Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D51678A4FC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 06:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjH1El3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 00:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjH1ElM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 00:41:12 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B17124;
        Sun, 27 Aug 2023 21:41:07 -0700 (PDT)
X-QQ-mid: bizesmtp78t1693197620tdj5elbh
Received: from wangjiexun-virtual-machine.loca ( [120.225.34.249])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 28 Aug 2023 12:40:17 +0800 (CST)
X-QQ-SSF: 01200000000000001000000A0000000
X-QQ-FEAT: znfcQSa1hKYDxmkXgnl9lrc8jm7ncjAYCvItBCS+bXKY++nEN9itQfpOM0KLH
        Oqr4Gg/mQj1qE4+umRvFwq6/LH8K3ysz5/vuSYTxFWjafMILTFvoP1vMsKqTSUJwY++Z9fI
        V+nQTh5qrHw2E2qIqik81duYSAF6Y46S4o/S4lb+ubZ34C56RBuIW6f9yY3paBw37SBvM2d
        MPas2/XycMRbK0qKwVULKjTSl0Xvl0x4qM6jvU04Vye23X9pBkqpy4LHTTSQwcA3ibY4b8d
        JgcuIAbF1pwh80gFwTPzkwDwK3VH07fUtjFz4u0NQ/FiKx+tc6Di2ylR1K8u+GIaqh53atJ
        LybILy8fHzRNHZgcbvCjB0yg9r2fxClx3ebmEh+
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1038203160215464499
From:   Jiexun Wang <wangjiexun@tinylab.org>
To:     dfustini@baylibre.com
Cc:     adrian.hunter@intel.com, aou@eecs.berkeley.edu,
        conor+dt@kernel.org, conor@kernel.org, devicetree@vger.kernel.org,
        guoren@kernel.org, jkridner@beagleboard.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        robertcnelson@beagleboard.org, robh+dt@kernel.org,
        ulf.hansson@linaro.org, wefu@redhat.com
Subject: Re: [PATCH RFC v2 0/4] RISC-V: Add basic eMMC support for BeagleV Ahead
Date:   Mon, 28 Aug 2023 12:40:16 +0800
Message-Id: <20230828044016.109515-1-wangjiexun@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724-th1520-emmc-v2-0-132ed2e2171e@baylibre.com>
References: <20230724-th1520-emmc-v2-0-132ed2e2171e@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,=0D
I tested the patch on my LicheePi 4A board.=0D
It can successfully boot with eMMC, but when I use the eMMC more frequently=
 - for instance:=0D
=0D
$ while true; do /bin/dd if=3D/dev/zero of=3Dbigfile bs=3D1024000 count=3D1=
024; done &=0D
=0D
I encounter the following error:=0D
=0D
sbi_trap_error: hart1: illegal instruction handler failed (error -2)=0D
sbi_trap_error: hart1: mcause=3D0x0000000000000002 mtval=3D0x0000000060e2de=
4f=0D
sbi_trap_error: hart1: mepc=3D0x000000000001897c mstatus=3D0x0000000a000018=
20=0D
sbi_trap_error: hart1: ra=3D0x00000000000170f8 sp=3D0x000000000004adc8=0D
sbi_trap_error: hart1: gp=3D0xffffffff8136ea90 tp=3D0xffffffd900228000=0D
sbi_trap_error: hart1: s0=3D0x0000000000000000 s1=3D0x000000000004ae08=0D
sbi_trap_error: hart1: a0=3D0x000000003f9aa9bc a1=3D0x0000000000000004=0D
sbi_trap_error: hart1: a2=3D0x0000000000000000 a3=3D0x0000000000000000=0D
sbi_trap_error: hart1: a4=3D0x0000000000042248 a5=3D0x00000000000170e5=0D
sbi_trap_error: hart1: a6=3D0x0000000000000000 a7=3D0x0000000054494d45=0D
sbi_trap_error: hart1: s2=3D0x000000000004aee8 s3=3D0x0000000000000000=0D
sbi_trap_error: hart1: s4=3D0x000000000004ae08 s5=3D0x0000000000000000=0D
sbi_trap_error: hart1: s6=3D0xffffffff813aa240 s7=3D0x0000000000000080=0D
sbi_trap_error: hart1: s8=3D0xffffffff80a1b5f0 s9=3D0x0000000000000000=0D
sbi_trap_error: hart1: s10=3D0xffffffd9fef5d380 s11=3D0xffffffff81290a80=0D
sbi_trap_error: hart1: t0=3D0x0000000a00000820 t1=3D0x0000000000000000=0D
sbi_trap_error: hart1: t2=3D0xffffffff80c00318 t3=3D0x0000000000000001=0D
sbi_trap_error: hart1: t4=3D0x0000000000000330 t5=3D0x0000000000000001=0D
sbi_trap_error: hart1: t6=3D0x0000000000040000=0D
=0D
My kernel version is v6.5-rc3.=0D
My OpenSBI version is 1.3.=0D
I tried to use other versions of OpenSBI, yet the problem persists. =0D
Is there a possibility of any underlying bug? Your insights into this would=
 be greatly appreciated.=0D
=0D
Thanks,=0D
Jiexun Wang=0D
=0D
