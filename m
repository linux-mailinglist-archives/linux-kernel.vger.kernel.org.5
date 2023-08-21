Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E73782EEE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236938AbjHUQ61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236836AbjHUQ6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:58:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F33FF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:58:09 -0700 (PDT)
Date:   Mon, 21 Aug 2023 16:58:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692637088;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NjdwKpbZH/EjNNYHf4RutOnbh8kVQgCtQssR4iAVDpY=;
        b=1Or8YflHvBEkCFparpDZqvV6CsE/uD6pR6lghaGm8ig35FH3V8KmfanJu5fLC2vYoU3VpW
        8rBPTCjwDVCz4sovxsrib3lK8tAC3F52RkMuACt9vMWn71Pg42lhOZOo6XnvVh7HNxXmj7
        1MvHvSez8R1kohOp/PvIbdPxWf8nUXXrC0NS8BbX6tsXZKvuNdAoCn0s42a9JiO0lPJUa8
        9NXVGjNiaCY5fT6P/s8gOsoDw9rsx8103jwt9vJtSolj1fz5nRURQd1RFwM4qc7axiYvJP
        doWPY4ihJm8KTLRV1girs04QFkI5NFMqF9/C4o9v6Pk/JNXqhu9kLNKHapRKyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692637088;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NjdwKpbZH/EjNNYHf4RutOnbh8kVQgCtQssR4iAVDpY=;
        b=/3h4TuFzlAs7PjKVw2aRr3cMO1ycyvYrNWwIBYX9iVxOc+hpiDgqpC4suNSJsNyV2T05kR
        ojfzMY41gAF2G/Aw==
From:   "irqchip-bot for Bibo Mao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/loongson-eiointc: Fix return
 value checking of eiointc_index
Cc:     Bibo Mao <maobibo@loongson.cn>, philmd@linaro.org,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230811095805.2974722-2-maobibo@loongson.cn>
References: <20230811095805.2974722-2-maobibo@loongson.cn>
MIME-Version: 1.0
Message-ID: <169263708750.27769.986837756344799978.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqc=
hip:

Commit-ID:     2e99b73afde18853754c5fae8e8d1a66fe5e3f64
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platfo=
rms/2e99b73afde18853754c5fae8e8d1a66fe5e3f64
Author:        Bibo Mao <maobibo@loongson.cn>
AuthorDate:    Fri, 11 Aug 2023 17:58:04 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 21 Aug 2023 17:39:21 +01:00

irqchip/loongson-eiointc: Fix return value checking of eiointc_index

Return value of function eiointc_index is int, however it is converted
into uint32_t and then compared smaller than zero, this will cause logic
problem.

Fixes: dd281e1a1a93 ("irqchip: Add Loongson Extended I/O interrupt controller=
 support")
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230811095805.2974722-2-maobibo@loongson.cn
---
 drivers/irqchip/irq-loongson-eiointc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loo=
ngson-eiointc.c
index 92d8aa2..1623cd7 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -144,7 +144,7 @@ static int eiointc_router_init(unsigned int cpu)
 	int i, bit;
 	uint32_t data;
 	uint32_t node =3D cpu_to_eio_node(cpu);
-	uint32_t index =3D eiointc_index(node);
+	int index =3D eiointc_index(node);
=20
 	if (index < 0) {
 		pr_err("Error: invalid nodemap!\n");
