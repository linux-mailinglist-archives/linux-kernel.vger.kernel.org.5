Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBF078B147
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjH1NBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbjH1NBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:01:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A85185
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 06:01:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693227671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=WNBk6mBKT0EzyMaKmzdJRFwiucQku0cSDbODc/+aTzc=;
        b=E51t3P/jCDMJG9/UXmAoeqeuOtnPWhVE8D8u4T6kT+tNawEkKwFPUG/tY9oNTQFdLDlaay
        0fcoSrYVCENknwvQXcGkdBQkeXUcDxJqkky80JSDdHYbzDUlgm1d1YEye1o/mguolxLwwz
        xug1EN9GS8KBMCaZOwjdgeskB6q9v58T8aHkAkPpZ7Ocx73pB5LibQeuIFsyMCqvGLCWT6
        pzHMIIIqnOcXzDmFY9KNeZQewrWq0v/z6bUiKbn4zjHSb6jJ/Nri3VpfxXk/4lc7S5KK28
        +rubGOyMCnQQdFl8Apbjl7BuNTdgiYTI3efqROwuXMj077eYiJo3oSkGmBF0mQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693227671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=WNBk6mBKT0EzyMaKmzdJRFwiucQku0cSDbODc/+aTzc=;
        b=H/GjyCHmjp4o6Qv5KlYLeiZ7QV73BmzslxRnFQ9bTikeYXrW8tha2cbN9mKnrHKx8YHlXM
        l121mxpXa3DD4CDA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/core for v6.6-rc1
References: <169322654636.420889.373907562030292433.tglx@xen13.tec.linutronix.de>
Message-ID: <169322654758.420889.12581588922728486948.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 28 Aug 2023 15:01:11 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2023-08=
-28

up to:  02362c9a99b6: Merge tag 'irqchip-6.6' of git://git.kernel.org/pub/scm=
/linux/kernel/git/maz/arm-platforms into irq/core


Boring updates for the interrupt subsystem:

  Core:

    - Prevent a deadlock of nested interrupt threads vs.
      synchronize_hard()

    - Removal of a stale extern declaration

  Drivers:

    - The first new driver since v6.2 for Amlogic-C3 SoCs

    - The usual small fixes, cleanups and improvements all over
      the place

Thanks,

	tglx

------------------>
Arnd Bergmann (3):
      irqchip/xtensa-pic: Include header for xtensa_pic_init_legacy()
      irqchip/mips-gic: Mark gic_irq_domain_free() static
      irqchipr/i8259: Mark i8259_of_init() static

Bibo Mao (1):
      irqchip/loongson-eiointc: Fix return value checking of eiointc_index

Huqiang Qin (2):
      dt-bindings: interrupt-controller: Add support for Amlogic-C3 SoCs
      irqchip: Add support for Amlogic-C3 SoCs

Rob Herring (1):
      irqchip: Explicitly include correct DT includes

Ruan Jinjie (2):
      irqchip/imx-mu-msi: Do not check for 0 return after calling platform_ge=
t_irq()
      irqchip/irq-pruss-intc: Do not check for 0 return after calling platfor=
m_get_irq()

Vincent Whitchurch (1):
      genirq: Prevent nested thread vs synchronize_hardirq() deadlock

Yang Yingliang (1):
      irqchip/orion: Use of_address_count() helper

Yangtao Li (2):
      irqchip/ls-scfg-msi: Use devm_platform_get_and_ioremap_resource()
      irqchip/irq-mvebu-sei: Use devm_platform_get_and_ioremap_resource()

YueHaibing (1):
      genirq: Remove unused extern declaration


 .../amlogic,meson-gpio-intc.yaml                   |  1 +
 drivers/irqchip/irq-bcm6345-l1.c                   |  1 -
 drivers/irqchip/irq-bcm7038-l1.c                   |  1 -
 drivers/irqchip/irq-brcmstb-l2.c                   |  1 -
 drivers/irqchip/irq-gic-pm.c                       |  2 +-
 drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c        |  2 --
 drivers/irqchip/irq-i8259.c                        |  2 +-
 drivers/irqchip/irq-imx-intmux.c                   |  3 ++-
 drivers/irqchip/irq-imx-irqsteer.c                 |  3 ++-
 drivers/irqchip/irq-imx-mu-msi.c                   |  4 ++--
 drivers/irqchip/irq-keystone.c                     |  2 +-
 drivers/irqchip/irq-loongson-eiointc.c             |  2 +-
 drivers/irqchip/irq-loongson-htvec.c               |  1 -
 drivers/irqchip/irq-loongson-pch-pic.c             |  2 +-
 drivers/irqchip/irq-ls-scfg-msi.c                  |  3 +--
 drivers/irqchip/irq-madera.c                       |  4 +---
 drivers/irqchip/irq-meson-gpio.c                   |  5 +++++
 drivers/irqchip/irq-mips-gic.c                     |  2 +-
 drivers/irqchip/irq-mvebu-sei.c                    |  3 +--
 drivers/irqchip/irq-orion.c                        |  3 +--
 drivers/irqchip/irq-pruss-intc.c                   |  6 ++---
 drivers/irqchip/irq-qcom-mpm.c                     |  2 +-
 drivers/irqchip/irq-renesas-intc-irqpin.c          |  1 -
 drivers/irqchip/irq-st.c                           |  2 +-
 drivers/irqchip/irq-stm32-exti.c                   |  3 ++-
 drivers/irqchip/irq-sunxi-nmi.c                    |  1 -
 drivers/irqchip/irq-tb10x.c                        |  1 -
 drivers/irqchip/irq-ti-sci-inta.c                  |  4 ++--
 drivers/irqchip/irq-ti-sci-intr.c                  |  4 ++--
 drivers/irqchip/irq-uniphier-aidet.c               |  1 -
 drivers/irqchip/irq-xtensa-pic.c                   |  1 +
 drivers/irqchip/irqchip.c                          |  2 +-
 drivers/irqchip/qcom-pdc.c                         |  1 -
 kernel/irq/chip.c                                  | 11 ++++-----
 kernel/irq/internals.h                             |  4 ++--
 kernel/irq/manage.c                                | 26 ++++++++++++--------=
--
 36 files changed, 55 insertions(+), 62 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,m=
eson-gpio-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/=
amlogic,meson-gpio-intc.yaml
index e84e4f33b358..3d06db98e978 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gp=
io-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gp=
io-intc.yaml
@@ -35,6 +35,7 @@ properties:
               - amlogic,meson-sm1-gpio-intc
               - amlogic,meson-a1-gpio-intc
               - amlogic,meson-s4-gpio-intc
+              - amlogic,c3-gpio-intc
           - const: amlogic,meson-gpio-intc
=20
   reg:
diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l=
1.c
index 6341c0167c4a..9745a119d0e6 100644
--- a/drivers/irqchip/irq-bcm6345-l1.c
+++ b/drivers/irqchip/irq-bcm6345-l1.c
@@ -60,7 +60,6 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l=
1.c
index a62b96237b82..24ca1d656adc 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -20,7 +20,6 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l=
2.c
index 091b0fe7e324..5559c943f03f 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -15,7 +15,6 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
-#include <linux/of_platform.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/io.h>
diff --git a/drivers/irqchip/irq-gic-pm.c b/drivers/irqchip/irq-gic-pm.c
index 3989d16f997b..a275a8071a25 100644
--- a/drivers/irqchip/irq-gic-pm.c
+++ b/drivers/irqchip/irq-gic-pm.c
@@ -4,7 +4,7 @@
  */
 #include <linux/module.h>
 #include <linux/clk.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/irqchip/arm-gic.h>
 #include <linux/platform_device.h>
diff --git a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c b/drivers/irqchip/ir=
q-gic-v3-its-fsl-mc-msi.c
index 634263dfd7b5..8e87fc35f8aa 100644
--- a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
@@ -9,8 +9,6 @@
=20
 #include <linux/acpi.h>
 #include <linux/acpi_iort.h>
-#include <linux/of_device.h>
-#include <linux/of_address.h>
 #include <linux/irq.h>
 #include <linux/msi.h>
 #include <linux/of.h>
diff --git a/drivers/irqchip/irq-i8259.c b/drivers/irqchip/irq-i8259.c
index b70ce0d3c092..115bdcffab24 100644
--- a/drivers/irqchip/irq-i8259.c
+++ b/drivers/irqchip/irq-i8259.c
@@ -340,7 +340,7 @@ static void i8259_irq_dispatch(struct irq_desc *desc)
 	generic_handle_domain_irq(domain, hwirq);
 }
=20
-int __init i8259_of_init(struct device_node *node, struct device_node *paren=
t)
+static int __init i8259_of_init(struct device_node *node, struct device_node=
 *parent)
 {
 	struct irq_domain *domain;
 	unsigned int parent_irq;
diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmu=
x.c
index 80aaea82468a..6d9a08238c9d 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -50,8 +50,9 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/pm_runtime.h>
=20
diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irq=
steer.c
index 96230a04ec23..bd9543314539 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -10,8 +10,9 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
+#include <linux/of.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/spinlock.h>
=20
diff --git a/drivers/irqchip/irq-imx-mu-msi.c b/drivers/irqchip/irq-imx-mu-ms=
i.c
index 229039eda1b1..90d41c1407ac 100644
--- a/drivers/irqchip/irq-imx-mu-msi.c
+++ b/drivers/irqchip/irq-imx-mu-msi.c
@@ -339,8 +339,8 @@ static int __init imx_mu_of_init(struct device_node *dn,
 	msi_data->msiir_addr =3D res->start + msi_data->cfg->xTR;
=20
 	irq =3D platform_get_irq(pdev, 0);
-	if (irq <=3D 0)
-		return -ENODEV;
+	if (irq < 0)
+		return irq;
=20
 	platform_set_drvdata(pdev, msi_data);
=20
diff --git a/drivers/irqchip/irq-keystone.c b/drivers/irqchip/irq-keystone.c
index ba9792e60329..a36396db4b08 100644
--- a/drivers/irqchip/irq-keystone.c
+++ b/drivers/irqchip/irq-keystone.c
@@ -15,7 +15,7 @@
 #include <linux/irqdomain.h>
 #include <linux/irqchip.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
=20
diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loo=
ngson-eiointc.c
index 92d8aa28bdf5..1623cd779175 100644
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
diff --git a/drivers/irqchip/irq-loongson-htvec.c b/drivers/irqchip/irq-loong=
son-htvec.c
index fc8bf1f5d41b..0bff728b25e3 100644
--- a/drivers/irqchip/irq-loongson-htvec.c
+++ b/drivers/irqchip/irq-loongson-htvec.c
@@ -15,7 +15,6 @@
 #include <linux/platform_device.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <linux/syscore_ops.h>
=20
 /* Registers */
diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loo=
ngson-pch-pic.c
index 93a71f66efeb..63db8e2172e0 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -12,9 +12,9 @@
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <linux/syscore_ops.h>
=20
 /* Registers */
diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-=
msi.c
index f5ba3f9f8415..f31a262fe438 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -349,8 +349,7 @@ static int ls_scfg_msi_probe(struct platform_device *pdev)
=20
 	msi_data->cfg =3D (struct ls_scfg_msi_cfg *) match->data;
=20
-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	msi_data->regs =3D devm_ioremap_resource(&pdev->dev, res);
+	msi_data->regs =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(msi_data->regs)) {
 		dev_err(&pdev->dev, "failed to initialize 'regs'\n");
 		return PTR_ERR(msi_data->regs);
diff --git a/drivers/irqchip/irq-madera.c b/drivers/irqchip/irq-madera.c
index 8b81271c823c..3eb1f8cdf674 100644
--- a/drivers/irqchip/irq-madera.c
+++ b/drivers/irqchip/irq-madera.c
@@ -10,12 +10,10 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
 #include <linux/irqchip/irq-madera.h>
 #include <linux/mfd/madera/core.h>
 #include <linux/mfd/madera/pdata.h>
diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpi=
o.c
index 7da18ef95211..f88df39f4129 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -150,6 +150,10 @@ static const struct meson_gpio_irq_params s4_params =3D {
 	INIT_MESON_S4_COMMON_DATA(82)
 };
=20
+static const struct meson_gpio_irq_params c3_params =3D {
+	INIT_MESON_S4_COMMON_DATA(55)
+};
+
 static const struct of_device_id meson_irq_gpio_matches[] __maybe_unused =3D=
 {
 	{ .compatible =3D "amlogic,meson8-gpio-intc", .data =3D &meson8_params },
 	{ .compatible =3D "amlogic,meson8b-gpio-intc", .data =3D &meson8b_params },
@@ -160,6 +164,7 @@ static const struct of_device_id meson_irq_gpio_matches[]=
 __maybe_unused =3D {
 	{ .compatible =3D "amlogic,meson-sm1-gpio-intc", .data =3D &sm1_params },
 	{ .compatible =3D "amlogic,meson-a1-gpio-intc", .data =3D &a1_params },
 	{ .compatible =3D "amlogic,meson-s4-gpio-intc", .data =3D &s4_params },
+	{ .compatible =3D "amlogic,c3-gpio-intc", .data =3D &c3_params },
 	{ }
 };
=20
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 6d5ecc10a870..76253e864f23 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -557,7 +557,7 @@ static int gic_irq_domain_alloc(struct irq_domain *d, uns=
igned int virq,
 	return gic_irq_domain_map(d, virq, hwirq);
 }
=20
-void gic_irq_domain_free(struct irq_domain *d, unsigned int virq,
+static void gic_irq_domain_free(struct irq_domain *d, unsigned int virq,
 			 unsigned int nr_irqs)
 {
 }
diff --git a/drivers/irqchip/irq-mvebu-sei.c b/drivers/irqchip/irq-mvebu-sei.c
index 4ecef6d83777..a48dbe91b036 100644
--- a/drivers/irqchip/irq-mvebu-sei.c
+++ b/drivers/irqchip/irq-mvebu-sei.c
@@ -377,8 +377,7 @@ static int mvebu_sei_probe(struct platform_device *pdev)
 	mutex_init(&sei->cp_msi_lock);
 	raw_spin_lock_init(&sei->mask_lock);
=20
-	sei->res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	sei->base =3D devm_ioremap_resource(sei->dev, sei->res);
+	sei->base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &sei->res);
 	if (IS_ERR(sei->base))
 		return PTR_ERR(sei->base);
=20
diff --git a/drivers/irqchip/irq-orion.c b/drivers/irqchip/irq-orion.c
index 17c2c7a07f10..4e4e874e09a8 100644
--- a/drivers/irqchip/irq-orion.c
+++ b/drivers/irqchip/irq-orion.c
@@ -57,8 +57,7 @@ static int __init orion_irq_init(struct device_node *np,
 	struct resource r;
=20
 	/* count number of irq chips by valid reg addresses */
-	while (of_address_to_resource(np, num_chips, &r) =3D=3D 0)
-		num_chips++;
+	num_chips =3D of_address_count(np);
=20
 	orion_irq_domain =3D irq_domain_add_linear(np,
 				num_chips * ORION_IRQS_PER_CHIP,
diff --git a/drivers/irqchip/irq-pruss-intc.c b/drivers/irqchip/irq-pruss-int=
c.c
index fa8d89b02ec0..0f64ecb9b1f4 100644
--- a/drivers/irqchip/irq-pruss-intc.c
+++ b/drivers/irqchip/irq-pruss-intc.c
@@ -17,7 +17,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
=20
 /*
@@ -565,8 +565,8 @@ static int pruss_intc_probe(struct platform_device *pdev)
 			continue;
=20
 		irq =3D platform_get_irq_byname(pdev, irq_names[i]);
-		if (irq <=3D 0) {
-			ret =3D (irq =3D=3D 0) ? -EINVAL : irq;
+		if (irq < 0) {
+			ret =3D irq;
 			goto fail_irq;
 		}
=20
diff --git a/drivers/irqchip/irq-qcom-mpm.c b/drivers/irqchip/irq-qcom-mpm.c
index d30614661eea..7124565234a5 100644
--- a/drivers/irqchip/irq-qcom-mpm.c
+++ b/drivers/irqchip/irq-qcom-mpm.c
@@ -14,7 +14,7 @@
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/slab.h>
diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-=
renesas-intc-irqpin.c
index 26e4c17a7bf2..fa19585f3dee 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -17,7 +17,6 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/pm_runtime.h>
=20
 #define INTC_IRQPIN_MAX 8 /* maximum 8 interrupts per driver instance */
diff --git a/drivers/irqchip/irq-st.c b/drivers/irqchip/irq-st.c
index 819a12297b58..de71bb350d57 100644
--- a/drivers/irqchip/irq-st.c
+++ b/drivers/irqchip/irq-st.c
@@ -10,7 +10,7 @@
 #include <dt-bindings/interrupt-controller/irq-st.h>
 #include <linux/err.h>
 #include <linux/mfd/syscon.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-ext=
i.c
index b5fa76ce5046..d8ba5fba7450 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -14,10 +14,11 @@
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/syscore_ops.h>
=20
 #include <dt-bindings/interrupt-controller/arm-gic.h>
diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index 21d49791f855..e760b1278143 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -19,7 +19,6 @@
 #include <linux/irqdomain.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
-#include <linux/of_platform.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
=20
diff --git a/drivers/irqchip/irq-tb10x.c b/drivers/irqchip/irq-tb10x.c
index 8a0e69298e83..680586354d12 100644
--- a/drivers/irqchip/irq-tb10x.c
+++ b/drivers/irqchip/irq-tb10x.c
@@ -13,7 +13,6 @@
 #include <linux/irqchip.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
-#include <linux/of_platform.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/bitops.h>
diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-i=
nta.c
index 7133f9fa6fd9..b83f5cbab123 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -15,9 +15,9 @@
 #include <linux/msi.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/of_address.h>
+#include <linux/of.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/soc/ti/ti_sci_inta_msi.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-i=
ntr.c
index 1186f1e431a3..c027cd9e4a69 100644
--- a/drivers/irqchip/irq-ti-sci-intr.c
+++ b/drivers/irqchip/irq-ti-sci-intr.c
@@ -12,9 +12,9 @@
 #include <linux/io.h>
 #include <linux/irqchip.h>
 #include <linux/irqdomain.h>
-#include <linux/of_platform.h>
-#include <linux/of_address.h>
+#include <linux/of.h>
 #include <linux/of_irq.h>
+#include <linux/platform_device.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
=20
 /**
diff --git a/drivers/irqchip/irq-uniphier-aidet.c b/drivers/irqchip/irq-uniph=
ier-aidet.c
index 716b1bb88bf2..601f9343d5b3 100644
--- a/drivers/irqchip/irq-uniphier-aidet.c
+++ b/drivers/irqchip/irq-uniphier-aidet.c
@@ -12,7 +12,6 @@
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
diff --git a/drivers/irqchip/irq-xtensa-pic.c b/drivers/irqchip/irq-xtensa-pi=
c.c
index ab12328be5ee..0c18d1f1e264 100644
--- a/drivers/irqchip/irq-xtensa-pic.c
+++ b/drivers/irqchip/irq-xtensa-pic.c
@@ -16,6 +16,7 @@
 #include <linux/irqdomain.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
+#include <linux/irqchip/xtensa-pic.h>
 #include <linux/of.h>
=20
 unsigned int cached_irq_mask;
diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
index 7899607fbee8..1eeb0d0156ce 100644
--- a/drivers/irqchip/irqchip.c
+++ b/drivers/irqchip/irqchip.c
@@ -10,7 +10,7 @@
=20
 #include <linux/acpi.h>
 #include <linux/init.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/irqchip.h>
 #include <linux/platform_device.h>
diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index d96916cf6a41..a32c0d28d038 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/soc/qcom/irq.h>
 #include <linux/spinlock.h>
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index ee8c0acf39df..dc94e0bf2c94 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -473,11 +473,12 @@ void handle_nested_irq(unsigned int irq)
 	action =3D desc->action;
 	if (unlikely(!action || irqd_irq_disabled(&desc->irq_data))) {
 		desc->istate |=3D IRQS_PENDING;
-		goto out_unlock;
+		raw_spin_unlock_irq(&desc->lock);
+		return;
 	}
=20
 	kstat_incr_irqs_this_cpu(desc);
-	irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS);
+	atomic_inc(&desc->threads_active);
 	raw_spin_unlock_irq(&desc->lock);
=20
 	action_ret =3D IRQ_NONE;
@@ -487,11 +488,7 @@ void handle_nested_irq(unsigned int irq)
 	if (!irq_settings_no_debug(desc))
 		note_interrupt(desc, action_ret);
=20
-	raw_spin_lock_irq(&desc->lock);
-	irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);
-
-out_unlock:
-	raw_spin_unlock_irq(&desc->lock);
+	wake_threads_waitq(desc);
 }
 EXPORT_SYMBOL_GPL(handle_nested_irq);
=20
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index bdd35bb9c735..bcc7f21db9ee 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -108,8 +108,6 @@ extern int __irq_get_irqchip_state(struct irq_data *data,
 				   enum irqchip_irq_state which,
 				   bool *state);
=20
-extern void init_kstat_irqs(struct irq_desc *desc, int node, int nr);
-
 irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc);
 irqreturn_t handle_irq_event_percpu(struct irq_desc *desc);
 irqreturn_t handle_irq_event(struct irq_desc *desc);
@@ -121,6 +119,8 @@ void irq_resend_init(struct irq_desc *desc);
 bool irq_wait_for_poll(struct irq_desc *desc);
 void __irq_wake_thread(struct irq_desc *desc, struct irqaction *action);
=20
+void wake_threads_waitq(struct irq_desc *desc);
+
 #ifdef CONFIG_PROC_FS
 extern void register_irq_proc(unsigned int irq, struct irq_desc *desc);
 extern void unregister_irq_proc(unsigned int irq, struct irq_desc *desc);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index d2742af0f0fd..d309ba84e08a 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -108,6 +108,16 @@ bool synchronize_hardirq(unsigned int irq)
 }
 EXPORT_SYMBOL(synchronize_hardirq);
=20
+static void __synchronize_irq(struct irq_desc *desc)
+{
+	__synchronize_hardirq(desc, true);
+	/*
+	 * We made sure that no hardirq handler is running. Now verify that no
+	 * threaded handlers are active.
+	 */
+	wait_event(desc->wait_for_threads, !atomic_read(&desc->threads_active));
+}
+
 /**
  *	synchronize_irq - wait for pending IRQ handlers (on other CPUs)
  *	@irq: interrupt number to wait for
@@ -127,16 +137,8 @@ void synchronize_irq(unsigned int irq)
 {
 	struct irq_desc *desc =3D irq_to_desc(irq);
=20
-	if (desc) {
-		__synchronize_hardirq(desc, true);
-		/*
-		 * We made sure that no hardirq handler is
-		 * running. Now verify that no threaded handlers are
-		 * active.
-		 */
-		wait_event(desc->wait_for_threads,
-			   !atomic_read(&desc->threads_active));
-	}
+	if (desc)
+		__synchronize_irq(desc);
 }
 EXPORT_SYMBOL(synchronize_irq);
=20
@@ -1216,7 +1218,7 @@ static irqreturn_t irq_thread_fn(struct irq_desc *desc,
 	return ret;
 }
=20
-static void wake_threads_waitq(struct irq_desc *desc)
+void wake_threads_waitq(struct irq_desc *desc)
 {
 	if (atomic_dec_and_test(&desc->threads_active))
 		wake_up(&desc->wait_for_threads);
@@ -1944,7 +1946,7 @@ static struct irqaction *__free_irq(struct irq_desc *de=
sc, void *dev_id)
 	 * supports it also make sure that there is no (not yet serviced)
 	 * interrupt in flight at the hardware level.
 	 */
-	__synchronize_hardirq(desc, true);
+	__synchronize_irq(desc);
=20
 #ifdef CONFIG_DEBUG_SHIRQ
 	/*

