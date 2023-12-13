Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74BF811E2E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbjLMTIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbjLMTIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:08:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACDD1B8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:06:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98668C433D9;
        Wed, 13 Dec 2023 19:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702494401;
        bh=MDcng/RdCUyRtmt1vpQXaN/v6a4RINm9QkoMMDL6/DQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aG1JLjgOyvU5U3Vx4Yyee5eiOsFsqZoU9DzngO67ZISUf0s9qBqfFzsKATMPDuzBM
         MWzZom/Woql70Oy/vtgsXmIyXfifazlochWo+7Yofx/+pOEQ34P4GDKSGI8qU5wHNY
         vKhAChOsX3jZIztgyM5irY+++eeQGNsg148PbIiI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.4.264
Date:   Wed, 13 Dec 2023 20:05:51 +0100
Message-ID: <2023121350-overblown-ceremony-dd24@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2023121350-occultist-moonshine-65ca@gregkh>
References: <2023121350-occultist-moonshine-65ca@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 3936ad84e1ba..eeb06cdcf64f 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 4
-SUBLEVEL = 263
+SUBLEVEL = 264
 EXTRAVERSION =
 NAME = Kleptomaniac Octopus
 
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 861392ff7086..0150b2d5c534 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -578,7 +578,7 @@
 				status = "disabled";
 			};
 
-			gpt: gpt@2098000 {
+			gpt: timer@2098000 {
 				compatible = "fsl,imx6q-gpt", "fsl,imx31-gpt";
 				reg = <0x02098000 0x4000>;
 				interrupts = <0 55 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 3cf1da06e7f0..fbbae0004e62 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -386,7 +386,7 @@
 				clock-names = "ipg", "per";
 			};
 
-			gpt: gpt@2098000 {
+			gpt: timer@2098000 {
 				compatible = "fsl,imx6sl-gpt";
 				reg = <0x02098000 0x4000>;
 				interrupts = <0 55 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 3dc1e97e145c..1afeae14560a 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -475,7 +475,7 @@
 				status = "disabled";
 			};
 
-			gpt: gpt@2098000 {
+			gpt: timer@2098000 {
 				compatible = "fsl,imx6sx-gpt", "fsl,imx6dl-gpt";
 				reg = <0x02098000 0x4000>;
 				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 5b677b66162a..7037d2a45e60 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -433,7 +433,7 @@
 				status = "disabled";
 			};
 
-			gpt1: gpt@2098000 {
+			gpt1: timer@2098000 {
 				compatible = "fsl,imx6ul-gpt", "fsl,imx6sx-gpt";
 				reg = <0x02098000 0x4000>;
 				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
@@ -707,7 +707,7 @@
 				reg = <0x020e4000 0x4000>;
 			};
 
-			gpt2: gpt@20e8000 {
+			gpt2: timer@20e8000 {
 				compatible = "fsl,imx6ul-gpt", "fsl,imx6sx-gpt";
 				reg = <0x020e8000 0x4000>;
 				interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 791530124fb0..7ce541fcac76 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -446,8 +446,8 @@
 				fsl,input-sel = <&iomuxc>;
 			};
 
-			gpt1: gpt@302d0000 {
-				compatible = "fsl,imx7d-gpt", "fsl,imx6sx-gpt";
+			gpt1: timer@302d0000 {
+				compatible = "fsl,imx7d-gpt", "fsl,imx6dl-gpt";
 				reg = <0x302d0000 0x10000>;
 				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_GPT1_ROOT_CLK>,
@@ -455,8 +455,8 @@
 				clock-names = "ipg", "per";
 			};
 
-			gpt2: gpt@302e0000 {
-				compatible = "fsl,imx7d-gpt", "fsl,imx6sx-gpt";
+			gpt2: timer@302e0000 {
+				compatible = "fsl,imx7d-gpt", "fsl,imx6dl-gpt";
 				reg = <0x302e0000 0x10000>;
 				interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_GPT2_ROOT_CLK>,
@@ -465,8 +465,8 @@
 				status = "disabled";
 			};
 
-			gpt3: gpt@302f0000 {
-				compatible = "fsl,imx7d-gpt", "fsl,imx6sx-gpt";
+			gpt3: timer@302f0000 {
+				compatible = "fsl,imx7d-gpt", "fsl,imx6dl-gpt";
 				reg = <0x302f0000 0x10000>;
 				interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_GPT3_ROOT_CLK>,
@@ -475,8 +475,8 @@
 				status = "disabled";
 			};
 
-			gpt4: gpt@30300000 {
-				compatible = "fsl,imx7d-gpt", "fsl,imx6sx-gpt";
+			gpt4: timer@30300000 {
+				compatible = "fsl,imx7d-gpt", "fsl,imx6dl-gpt";
 				reg = <0x30300000 0x10000>;
 				interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_GPT4_ROOT_CLK>,
diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index b9efe9da06e0..3d76e8c28c51 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -502,6 +502,10 @@ static int imx_mmdc_perf_init(struct platform_device *pdev, void __iomem *mmdc_b
 
 	name = devm_kasprintf(&pdev->dev,
 				GFP_KERNEL, "mmdc%d", ret);
+	if (!name) {
+		ret = -ENOMEM;
+		goto pmu_release_id;
+	}
 
 	pmu_mmdc->mmdc_ipg_clk = mmdc_ipg_clk;
 	pmu_mmdc->devtype_data = (struct fsl_mmdc_devtype_data *)of_id->data;
@@ -524,9 +528,10 @@ static int imx_mmdc_perf_init(struct platform_device *pdev, void __iomem *mmdc_b
 
 pmu_register_err:
 	pr_warn("MMDC Perf PMU failed (%d), disabled\n", ret);
-	ida_simple_remove(&mmdc_ida, pmu_mmdc->id);
 	cpuhp_state_remove_instance_nocalls(cpuhp_mmdc_state, &pmu_mmdc->node);
 	hrtimer_cancel(&pmu_mmdc->hrtimer);
+pmu_release_id:
+	ida_simple_remove(&mmdc_ida, pmu_mmdc->id);
 pmu_free:
 	kfree(pmu_mmdc);
 	return ret;
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
index 81215cc3759a..7b095378c96c 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
@@ -69,7 +69,7 @@
 		};
 	};
 
-	memory {
+	memory@40000000 {
 		reg = <0 0x40000000 0 0x40000000>;
 	};
 
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index 3f783348c66a..f586c1ee4a59 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -55,7 +55,7 @@
 		};
 	};
 
-	memory {
+	memory@40000000 {
 		reg = <0 0x40000000 0 0x20000000>;
 	};
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 6dffada2e66b..2b66afcf026e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -43,7 +43,7 @@
 		id-gpio = <&pio 16 GPIO_ACTIVE_HIGH>;
 	};
 
-	usb_p1_vbus: regulator@0 {
+	usb_p1_vbus: regulator-usb-p1 {
 		compatible = "regulator-fixed";
 		regulator-name = "usb_vbus";
 		regulator-min-microvolt = <5000000>;
@@ -52,7 +52,7 @@
 		enable-active-high;
 	};
 
-	usb_p0_vbus: regulator@1 {
+	usb_p0_vbus: regulator-usb-p0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vbus";
 		regulator-min-microvolt = <5000000>;
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 28ca07360e97..c2ed9b859860 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -699,7 +699,7 @@ void ptep_zap_unused(struct mm_struct *mm, unsigned long addr,
 		pte_clear(mm, addr, ptep);
 	}
 	if (reset)
-		pgste_val(pgste) &= ~_PGSTE_GPS_USAGE_MASK;
+		pgste_val(pgste) &= ~(_PGSTE_GPS_USAGE_MASK | _PGSTE_GPS_NODAT);
 	pgste_set_unlock(ptep, pgste);
 	preempt_enable();
 }
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index eb3cd4ad45ae..b2cdf1c07e56 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1248,5 +1248,8 @@ static void zenbleed_check_cpu(void *unused)
 
 void amd_check_microcode(void)
 {
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+		return;
+
 	on_each_cpu(zenbleed_check_cpu, NULL, 1);
 }
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 09eb170f26d2..13ae2ce9f50d 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -503,7 +503,6 @@ static struct acpi_iort_node *iort_find_dev_node(struct device *dev)
 		node = iort_get_iort_node(dev->fwnode);
 		if (node)
 			return node;
-
 		/*
 		 * if not, then it should be a platform device defined in
 		 * DSDT/SSDT (with Named Component node in IORT)
@@ -522,22 +521,22 @@ static struct acpi_iort_node *iort_find_dev_node(struct device *dev)
 }
 
 /**
- * iort_msi_map_rid() - Map a MSI requester ID for a device
+ * iort_msi_map_id() - Map a MSI input ID for a device
  * @dev: The device for which the mapping is to be done.
- * @req_id: The device requester ID.
+ * @input_id: The device input ID.
  *
- * Returns: mapped MSI RID on success, input requester ID otherwise
+ * Returns: mapped MSI ID on success, input ID otherwise
  */
-u32 iort_msi_map_rid(struct device *dev, u32 req_id)
+u32 iort_msi_map_id(struct device *dev, u32 input_id)
 {
 	struct acpi_iort_node *node;
 	u32 dev_id;
 
 	node = iort_find_dev_node(dev);
 	if (!node)
-		return req_id;
+		return input_id;
 
-	iort_node_map_id(node, req_id, &dev_id, IORT_MSI_TYPE);
+	iort_node_map_id(node, input_id, &dev_id, IORT_MSI_TYPE);
 	return dev_id;
 }
 
@@ -594,13 +593,13 @@ static int __maybe_unused iort_find_its_base(u32 its_id, phys_addr_t *base)
 /**
  * iort_dev_find_its_id() - Find the ITS identifier for a device
  * @dev: The device.
- * @req_id: Device's requester ID
+ * @id: Device's ID
  * @idx: Index of the ITS identifier list.
  * @its_id: ITS identifier.
  *
  * Returns: 0 on success, appropriate error value otherwise
  */
-static int iort_dev_find_its_id(struct device *dev, u32 req_id,
+static int iort_dev_find_its_id(struct device *dev, u32 id,
 				unsigned int idx, int *its_id)
 {
 	struct acpi_iort_its_group *its;
@@ -610,7 +609,7 @@ static int iort_dev_find_its_id(struct device *dev, u32 req_id,
 	if (!node)
 		return -ENXIO;
 
-	node = iort_node_map_id(node, req_id, NULL, IORT_MSI_TYPE);
+	node = iort_node_map_id(node, id, NULL, IORT_MSI_TYPE);
 	if (!node)
 		return -ENXIO;
 
@@ -633,19 +632,20 @@ static int iort_dev_find_its_id(struct device *dev, u32 req_id,
  *
  * Returns: the MSI domain for this device, NULL otherwise
  */
-struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id)
+struct irq_domain *iort_get_device_domain(struct device *dev, u32 id,
+					  enum irq_domain_bus_token bus_token)
 {
 	struct fwnode_handle *handle;
 	int its_id;
 
-	if (iort_dev_find_its_id(dev, req_id, 0, &its_id))
+	if (iort_dev_find_its_id(dev, id, 0, &its_id))
 		return NULL;
 
 	handle = iort_find_domain_token(its_id);
 	if (!handle)
 		return NULL;
 
-	return irq_find_matching_fwnode(handle, DOMAIN_BUS_PCI_MSI);
+	return irq_find_matching_fwnode(handle, bus_token);
 }
 
 static void iort_set_device_domain(struct device *dev,
diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index e42d0b514384..e9398bcffab6 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -29,6 +29,47 @@ struct devcd_entry {
 	struct device devcd_dev;
 	void *data;
 	size_t datalen;
+	/*
+	 * Here, mutex is required to serialize the calls to del_wk work between
+	 * user/kernel space which happens when devcd is added with device_add()
+	 * and that sends uevent to user space. User space reads the uevents,
+	 * and calls to devcd_data_write() which try to modify the work which is
+	 * not even initialized/queued from devcoredump.
+	 *
+	 *
+	 *
+	 *        cpu0(X)                                 cpu1(Y)
+	 *
+	 *        dev_coredump() uevent sent to user space
+	 *        device_add()  ======================> user space process Y reads the
+	 *                                              uevents writes to devcd fd
+	 *                                              which results into writes to
+	 *
+	 *                                             devcd_data_write()
+	 *                                               mod_delayed_work()
+	 *                                                 try_to_grab_pending()
+	 *                                                   del_timer()
+	 *                                                     debug_assert_init()
+	 *       INIT_DELAYED_WORK()
+	 *       schedule_delayed_work()
+	 *
+	 *
+	 * Also, mutex alone would not be enough to avoid scheduling of
+	 * del_wk work after it get flush from a call to devcd_free()
+	 * mentioned as below.
+	 *
+	 *	disabled_store()
+	 *        devcd_free()
+	 *          mutex_lock()             devcd_data_write()
+	 *          flush_delayed_work()
+	 *          mutex_unlock()
+	 *                                   mutex_lock()
+	 *                                   mod_delayed_work()
+	 *                                   mutex_unlock()
+	 * So, delete_work flag is required.
+	 */
+	struct mutex mutex;
+	bool delete_work;
 	struct module *owner;
 	ssize_t (*read)(char *buffer, loff_t offset, size_t count,
 			void *data, size_t datalen);
@@ -88,7 +129,12 @@ static ssize_t devcd_data_write(struct file *filp, struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct devcd_entry *devcd = dev_to_devcd(dev);
 
-	mod_delayed_work(system_wq, &devcd->del_wk, 0);
+	mutex_lock(&devcd->mutex);
+	if (!devcd->delete_work) {
+		devcd->delete_work = true;
+		mod_delayed_work(system_wq, &devcd->del_wk, 0);
+	}
+	mutex_unlock(&devcd->mutex);
 
 	return count;
 }
@@ -116,7 +162,12 @@ static int devcd_free(struct device *dev, void *data)
 {
 	struct devcd_entry *devcd = dev_to_devcd(dev);
 
+	mutex_lock(&devcd->mutex);
+	if (!devcd->delete_work)
+		devcd->delete_work = true;
+
 	flush_delayed_work(&devcd->del_wk);
+	mutex_unlock(&devcd->mutex);
 	return 0;
 }
 
@@ -126,6 +177,30 @@ static ssize_t disabled_show(struct class *class, struct class_attribute *attr,
 	return sprintf(buf, "%d\n", devcd_disabled);
 }
 
+/*
+ *
+ *	disabled_store()                                	worker()
+ *	 class_for_each_device(&devcd_class,
+ *		NULL, NULL, devcd_free)
+ *         ...
+ *         ...
+ *	   while ((dev = class_dev_iter_next(&iter))
+ *                                                             devcd_del()
+ *                                                               device_del()
+ *                                                                 put_device() <- last reference
+ *             error = fn(dev, data)                           devcd_dev_release()
+ *             devcd_free(dev, data)                           kfree(devcd)
+ *             mutex_lock(&devcd->mutex);
+ *
+ *
+ * In the above diagram, It looks like disabled_store() would be racing with parallely
+ * running devcd_del() and result in memory abort while acquiring devcd->mutex which
+ * is called after kfree of devcd memory  after dropping its last reference with
+ * put_device(). However, this will not happens as fn(dev, data) runs
+ * with its own reference to device via klist_node so it is not its last reference.
+ * so, above situation would not occur.
+ */
+
 static ssize_t disabled_store(struct class *class, struct class_attribute *attr,
 			      const char *buf, size_t count)
 {
@@ -282,13 +357,17 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 	devcd->read = read;
 	devcd->free = free;
 	devcd->failing_dev = get_device(dev);
+	devcd->delete_work = false;
 
+	mutex_init(&devcd->mutex);
 	device_initialize(&devcd->devcd_dev);
 
 	dev_set_name(&devcd->devcd_dev, "devcd%d",
 		     atomic_inc_return(&devcd_count));
 	devcd->devcd_dev.class = &devcd_class;
 
+	mutex_lock(&devcd->mutex);
+	dev_set_uevent_suppress(&devcd->devcd_dev, true);
 	if (device_add(&devcd->devcd_dev))
 		goto put_device;
 
@@ -300,12 +379,15 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 			      "devcoredump"))
 		/* nothing - symlink will be missing */;
 
+	dev_set_uevent_suppress(&devcd->devcd_dev, false);
+	kobject_uevent(&devcd->devcd_dev.kobj, KOBJ_ADD);
 	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
 	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
-
+	mutex_unlock(&devcd->mutex);
 	return;
  put_device:
 	put_device(&devcd->devcd_dev);
+	mutex_unlock(&devcd->mutex);
  put_module:
 	module_put(owner);
  free:
diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 558cd900d399..b993416961a7 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -490,14 +490,17 @@ static ssize_t export_store(struct class *class,
 	}
 
 	status = gpiod_set_transitory(desc, false);
-	if (!status) {
-		status = gpiod_export(desc, true);
-		if (status < 0)
-			gpiod_free(desc);
-		else
-			set_bit(FLAG_SYSFS, &desc->flags);
+	if (status) {
+		gpiod_free(desc);
+		goto done;
 	}
 
+	status = gpiod_export(desc, true);
+	if (status < 0)
+		gpiod_free(desc);
+	else
+		set_bit(FLAG_SYSFS, &desc->flags);
+
 done:
 	if (status)
 		pr_debug("%s: status %d\n", __func__, status);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 1a8305521176..f9c725a8991b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -141,7 +141,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 	}
 
 	for (i = 0; i < p->nchunks; i++) {
-		struct drm_amdgpu_cs_chunk __user **chunk_ptr = NULL;
+		struct drm_amdgpu_cs_chunk __user *chunk_ptr = NULL;
 		struct drm_amdgpu_cs_chunk user_chunk;
 		uint32_t __user *cdata;
 
diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 740ac0a1b726..549c8f30acce 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -32,6 +32,7 @@ ACPI_MODULE_NAME(ACPI_POWER_METER_NAME);
 #define POWER_METER_CAN_NOTIFY	(1 << 3)
 #define POWER_METER_IS_BATTERY	(1 << 8)
 #define UNKNOWN_HYSTERESIS	0xFFFFFFFF
+#define UNKNOWN_POWER		0xFFFFFFFF
 
 #define METER_NOTIFY_CONFIG	0x80
 #define METER_NOTIFY_TRIP	0x81
@@ -343,6 +344,9 @@ static ssize_t show_power(struct device *dev,
 	update_meter(resource);
 	mutex_unlock(&resource->lock);
 
+	if (resource->power == UNKNOWN_POWER)
+		return -ENODATA;
+
 	return sprintf(buf, "%llu\n", resource->power * 1000);
 }
 
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index a40bc23196bf..34d1c4264602 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -70,7 +70,7 @@ static char version[] =
 		BNXT_RE_DESC "\n";
 
 MODULE_AUTHOR("Eddie Wai <eddie.wai@broadcom.com>");
-MODULE_DESCRIPTION(BNXT_RE_DESC " Driver");
+MODULE_DESCRIPTION(BNXT_RE_DESC);
 MODULE_LICENSE("Dual BSD/GPL");
 
 /* globals */
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 614a93aa5305..656939ed842e 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -121,7 +121,7 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 	struct of_phandle_args iommu_spec = { .args_count = 1 };
 	int err;
 
-	err = of_map_rid(info->np, alias, "iommu-map", "iommu-map-mask",
+	err = of_map_id(info->np, alias, "iommu-map", "iommu-map-mask",
 			 &iommu_spec.np, iommu_spec.args);
 	if (err)
 		return err == -ENODEV ? NO_IOMMU : err;
@@ -137,7 +137,7 @@ static int of_fsl_mc_iommu_init(struct fsl_mc_device *mc_dev,
 	struct of_phandle_args iommu_spec = { .args_count = 1 };
 	int err;
 
-	err = of_map_rid(master_np, mc_dev->icid, "iommu-map",
+	err = of_map_id(master_np, mc_dev->icid, "iommu-map",
 			 "iommu-map-mask", &iommu_spec.np,
 			 iommu_spec.args);
 	if (err)
diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.c
index b6febbcf8978..327032cbbb1f 100644
--- a/drivers/mmc/core/regulator.c
+++ b/drivers/mmc/core/regulator.c
@@ -258,3 +258,44 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mmc_regulator_get_supply);
+
+/**
+ * mmc_regulator_enable_vqmmc - enable VQMMC regulator for a host
+ * @mmc: the host to regulate
+ *
+ * Returns 0 or errno. Enables the regulator for vqmmc.
+ * Keeps track of the enable status for ensuring that calls to
+ * regulator_enable/disable are balanced.
+ */
+int mmc_regulator_enable_vqmmc(struct mmc_host *mmc)
+{
+	int ret = 0;
+
+	if (!IS_ERR(mmc->supply.vqmmc) && !mmc->vqmmc_enabled) {
+		ret = regulator_enable(mmc->supply.vqmmc);
+		if (ret < 0)
+			dev_err(mmc_dev(mmc), "enabling vqmmc regulator failed\n");
+		else
+			mmc->vqmmc_enabled = true;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mmc_regulator_enable_vqmmc);
+
+/**
+ * mmc_regulator_disable_vqmmc - disable VQMMC regulator for a host
+ * @mmc: the host to regulate
+ *
+ * Returns 0 or errno. Disables the regulator for vqmmc.
+ * Keeps track of the enable status for ensuring that calls to
+ * regulator_enable/disable are balanced.
+ */
+void mmc_regulator_disable_vqmmc(struct mmc_host *mmc)
+{
+	if (!IS_ERR(mmc->supply.vqmmc) && mmc->vqmmc_enabled) {
+		regulator_disable(mmc->supply.vqmmc);
+		mmc->vqmmc_enabled = false;
+	}
+}
+EXPORT_SYMBOL_GPL(mmc_regulator_disable_vqmmc);
diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 1b1dad9d9a60..b624589e62a0 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -381,12 +381,33 @@ static unsigned int sdhci_sprd_get_ro(struct sdhci_host *host)
 	return 0;
 }
 
+static void sdhci_sprd_set_power(struct sdhci_host *host, unsigned char mode,
+				 unsigned short vdd)
+{
+	struct mmc_host *mmc = host->mmc;
+
+	switch (mode) {
+	case MMC_POWER_OFF:
+		mmc_regulator_set_ocr(host->mmc, mmc->supply.vmmc, 0);
+
+		mmc_regulator_disable_vqmmc(mmc);
+		break;
+	case MMC_POWER_ON:
+		mmc_regulator_enable_vqmmc(mmc);
+		break;
+	case MMC_POWER_UP:
+		mmc_regulator_set_ocr(host->mmc, mmc->supply.vmmc, vdd);
+		break;
+	}
+}
+
 static struct sdhci_ops sdhci_sprd_ops = {
 	.read_l = sdhci_sprd_readl,
 	.write_l = sdhci_sprd_writel,
 	.write_w = sdhci_sprd_writew,
 	.write_b = sdhci_sprd_writeb,
 	.set_clock = sdhci_sprd_set_clock,
+	.set_power = sdhci_sprd_set_power,
 	.get_max_clock = sdhci_sprd_get_max_clock,
 	.get_min_clock = sdhci_sprd_get_min_clock,
 	.set_bus_width = sdhci_set_bus_width,
@@ -630,6 +651,10 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 |
 			 SDHCI_SUPPORT_DDR50);
 
+	ret = mmc_regulator_get_supply(host->mmc);
+	if (ret)
+		goto pm_runtime_disable;
+
 	ret = sdhci_setup_host(host);
 	if (ret)
 		goto pm_runtime_disable;
diff --git a/drivers/net/arcnet/arc-rimi.c b/drivers/net/arcnet/arc-rimi.c
index 14a5fb378145..313b636edf23 100644
--- a/drivers/net/arcnet/arc-rimi.c
+++ b/drivers/net/arcnet/arc-rimi.c
@@ -332,7 +332,7 @@ static int __init arc_rimi_init(void)
 		dev->irq = 9;
 
 	if (arcrimi_probe(dev)) {
-		free_netdev(dev);
+		free_arcdev(dev);
 		return -EIO;
 	}
 
@@ -349,7 +349,7 @@ static void __exit arc_rimi_exit(void)
 	iounmap(lp->mem_start);
 	release_mem_region(dev->mem_start, dev->mem_end - dev->mem_start + 1);
 	free_irq(dev->irq, dev);
-	free_netdev(dev);
+	free_arcdev(dev);
 }
 
 #ifndef MODULE
diff --git a/drivers/net/arcnet/arcdevice.h b/drivers/net/arcnet/arcdevice.h
index b0f5bc07aef5..7b783ee91834 100644
--- a/drivers/net/arcnet/arcdevice.h
+++ b/drivers/net/arcnet/arcdevice.h
@@ -186,6 +186,8 @@ do {									\
 #define ARC_IS_5MBIT    1   /* card default speed is 5MBit */
 #define ARC_CAN_10MBIT  2   /* card uses COM20022, supporting 10MBit,
 				 but default is 2.5MBit. */
+#define ARC_HAS_LED     4   /* card has software controlled LEDs */
+#define ARC_HAS_ROTARY  8   /* card has rotary encoder */
 
 /* information needed to define an encapsulation driver */
 struct ArcProto {
@@ -298,6 +300,10 @@ struct arcnet_local {
 
 	int excnak_pending;    /* We just got an excesive nak interrupt */
 
+	/* RESET flag handling */
+	int reset_in_progress;
+	struct work_struct reset_work;
+
 	struct {
 		uint16_t sequence;	/* sequence number (incs with each packet) */
 		__be16 aborted_seq;
@@ -350,7 +356,9 @@ void arcnet_dump_skb(struct net_device *dev, struct sk_buff *skb, char *desc)
 
 void arcnet_unregister_proto(struct ArcProto *proto);
 irqreturn_t arcnet_interrupt(int irq, void *dev_id);
+
 struct net_device *alloc_arcdev(const char *name);
+void free_arcdev(struct net_device *dev);
 
 int arcnet_open(struct net_device *dev);
 int arcnet_close(struct net_device *dev);
diff --git a/drivers/net/arcnet/arcnet.c b/drivers/net/arcnet/arcnet.c
index 2b112d3d8540..cf652c76af85 100644
--- a/drivers/net/arcnet/arcnet.c
+++ b/drivers/net/arcnet/arcnet.c
@@ -387,10 +387,44 @@ static void arcnet_timer(struct timer_list *t)
 	struct arcnet_local *lp = from_timer(lp, t, timer);
 	struct net_device *dev = lp->dev;
 
-	if (!netif_carrier_ok(dev)) {
+	spin_lock_irq(&lp->lock);
+
+	if (!lp->reset_in_progress && !netif_carrier_ok(dev)) {
 		netif_carrier_on(dev);
 		netdev_info(dev, "link up\n");
 	}
+
+	spin_unlock_irq(&lp->lock);
+}
+
+static void reset_device_work(struct work_struct *work)
+{
+	struct arcnet_local *lp;
+	struct net_device *dev;
+
+	lp = container_of(work, struct arcnet_local, reset_work);
+	dev = lp->dev;
+
+	/* Do not bring the network interface back up if an ifdown
+	 * was already done.
+	 */
+	if (!netif_running(dev) || !lp->reset_in_progress)
+		return;
+
+	rtnl_lock();
+
+	/* Do another check, in case of an ifdown that was triggered in
+	 * the small race window between the exit condition above and
+	 * acquiring RTNL.
+	 */
+	if (!netif_running(dev) || !lp->reset_in_progress)
+		goto out;
+
+	dev_close(dev);
+	dev_open(dev, NULL);
+
+out:
+	rtnl_unlock();
 }
 
 static void arcnet_reply_tasklet(unsigned long data)
@@ -452,12 +486,25 @@ struct net_device *alloc_arcdev(const char *name)
 		lp->dev = dev;
 		spin_lock_init(&lp->lock);
 		timer_setup(&lp->timer, arcnet_timer, 0);
+		INIT_WORK(&lp->reset_work, reset_device_work);
 	}
 
 	return dev;
 }
 EXPORT_SYMBOL(alloc_arcdev);
 
+void free_arcdev(struct net_device *dev)
+{
+	struct arcnet_local *lp = netdev_priv(dev);
+
+	/* Do not cancel this at ->ndo_close(), as the workqueue itself
+	 * indirectly calls the ifdown path through dev_close().
+	 */
+	cancel_work_sync(&lp->reset_work);
+	free_netdev(dev);
+}
+EXPORT_SYMBOL(free_arcdev);
+
 /* Open/initialize the board.  This is called sometime after booting when
  * the 'ifconfig' program is run.
  *
@@ -587,6 +634,10 @@ int arcnet_close(struct net_device *dev)
 
 	/* shut down the card */
 	lp->hw.close(dev);
+
+	/* reset counters */
+	lp->reset_in_progress = 0;
+
 	module_put(lp->hw.owner);
 	return 0;
 }
@@ -820,6 +871,9 @@ irqreturn_t arcnet_interrupt(int irq, void *dev_id)
 
 	spin_lock_irqsave(&lp->lock, flags);
 
+	if (lp->reset_in_progress)
+		goto out;
+
 	/* RESET flag was enabled - if device is not running, we must
 	 * clear it right away (but nothing else).
 	 */
@@ -852,11 +906,14 @@ irqreturn_t arcnet_interrupt(int irq, void *dev_id)
 		if (status & RESETflag) {
 			arc_printk(D_NORMAL, dev, "spurious reset (status=%Xh)\n",
 				   status);
-			arcnet_close(dev);
-			arcnet_open(dev);
+
+			lp->reset_in_progress = 1;
+			netif_stop_queue(dev);
+			netif_carrier_off(dev);
+			schedule_work(&lp->reset_work);
 
 			/* get out of the interrupt handler! */
-			break;
+			goto out;
 		}
 		/* RX is inhibited - we must have received something.
 		 * Prepare to receive into the next buffer.
@@ -1052,6 +1109,7 @@ irqreturn_t arcnet_interrupt(int irq, void *dev_id)
 	udelay(1);
 	lp->hw.intmask(dev, lp->intmask);
 
+out:
 	spin_unlock_irqrestore(&lp->lock, flags);
 	return retval;
 }
diff --git a/drivers/net/arcnet/com20020-isa.c b/drivers/net/arcnet/com20020-isa.c
index cd27fdc1059b..141b05451252 100644
--- a/drivers/net/arcnet/com20020-isa.c
+++ b/drivers/net/arcnet/com20020-isa.c
@@ -169,7 +169,7 @@ static int __init com20020_init(void)
 		dev->irq = 9;
 
 	if (com20020isa_probe(dev)) {
-		free_netdev(dev);
+		free_arcdev(dev);
 		return -EIO;
 	}
 
@@ -182,7 +182,7 @@ static void __exit com20020_exit(void)
 	unregister_netdev(my_dev);
 	free_irq(my_dev->irq, my_dev);
 	release_region(my_dev->base_addr, ARCNET_TOTAL_SIZE);
-	free_netdev(my_dev);
+	free_arcdev(my_dev);
 }
 
 #ifndef MODULE
diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
index 9f44e2e458df..9d9e4200064f 100644
--- a/drivers/net/arcnet/com20020-pci.c
+++ b/drivers/net/arcnet/com20020-pci.c
@@ -127,6 +127,8 @@ static int com20020pci_probe(struct pci_dev *pdev,
 	int i, ioaddr, ret;
 	struct resource *r;
 
+	ret = 0;
+
 	if (pci_enable_device(pdev))
 		return -EIO;
 
@@ -142,6 +144,8 @@ static int com20020pci_probe(struct pci_dev *pdev,
 	priv->ci = ci;
 	mm = &ci->misc_map;
 
+	pci_set_drvdata(pdev, priv);
+
 	INIT_LIST_HEAD(&priv->list_dev);
 
 	if (mm->size) {
@@ -164,7 +168,7 @@ static int com20020pci_probe(struct pci_dev *pdev,
 		dev = alloc_arcdev(device);
 		if (!dev) {
 			ret = -ENOMEM;
-			goto out_port;
+			break;
 		}
 		dev->dev_port = i;
 
@@ -181,7 +185,7 @@ static int com20020pci_probe(struct pci_dev *pdev,
 			pr_err("IO region %xh-%xh already allocated\n",
 			       ioaddr, ioaddr + cm->size - 1);
 			ret = -EBUSY;
-			goto out_port;
+			goto err_free_arcdev;
 		}
 
 		/* Dummy access after Reset
@@ -209,76 +213,79 @@ static int com20020pci_probe(struct pci_dev *pdev,
 		if (!strncmp(ci->name, "EAE PLX-PCI FB2", 15))
 			lp->backplane = 1;
 
-		/* Get the dev_id from the PLX rotary coder */
-		if (!strncmp(ci->name, "EAE PLX-PCI MA1", 15))
-			dev_id_mask = 0x3;
-		dev->dev_id = (inb(priv->misc + ci->rotary) >> 4) & dev_id_mask;
-
-		snprintf(dev->name, sizeof(dev->name), "arc%d-%d", dev->dev_id, i);
+		if (ci->flags & ARC_HAS_ROTARY) {
+			/* Get the dev_id from the PLX rotary coder */
+			if (!strncmp(ci->name, "EAE PLX-PCI MA1", 15))
+				dev_id_mask = 0x3;
+			dev->dev_id = (inb(priv->misc + ci->rotary) >> 4) & dev_id_mask;
+			snprintf(dev->name, sizeof(dev->name), "arc%d-%d", dev->dev_id, i);
+		}
 
 		if (arcnet_inb(ioaddr, COM20020_REG_R_STATUS) == 0xFF) {
 			pr_err("IO address %Xh is empty!\n", ioaddr);
 			ret = -EIO;
-			goto out_port;
+			goto err_free_arcdev;
 		}
 		if (com20020_check(dev)) {
 			ret = -EIO;
-			goto out_port;
+			goto err_free_arcdev;
 		}
 
+		ret = com20020_found(dev, IRQF_SHARED);
+		if (ret)
+			goto err_free_arcdev;
+
 		card = devm_kzalloc(&pdev->dev, sizeof(struct com20020_dev),
 				    GFP_KERNEL);
 		if (!card) {
 			ret = -ENOMEM;
-			goto out_port;
+			goto err_free_arcdev;
 		}
 
 		card->index = i;
 		card->pci_priv = priv;
-		card->tx_led.brightness_set = led_tx_set;
-		card->tx_led.default_trigger = devm_kasprintf(&pdev->dev,
-						GFP_KERNEL, "arc%d-%d-tx",
-						dev->dev_id, i);
-		card->tx_led.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
-						"pci:green:tx:%d-%d",
-						dev->dev_id, i);
-
-		card->tx_led.dev = &dev->dev;
-		card->recon_led.brightness_set = led_recon_set;
-		card->recon_led.default_trigger = devm_kasprintf(&pdev->dev,
-						GFP_KERNEL, "arc%d-%d-recon",
-						dev->dev_id, i);
-		card->recon_led.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
-						"pci:red:recon:%d-%d",
-						dev->dev_id, i);
-		card->recon_led.dev = &dev->dev;
-		card->dev = dev;
-
-		ret = devm_led_classdev_register(&pdev->dev, &card->tx_led);
-		if (ret)
-			goto out_port;
-
-		ret = devm_led_classdev_register(&pdev->dev, &card->recon_led);
-		if (ret)
-			goto out_port;
-
-		dev_set_drvdata(&dev->dev, card);
 
-		ret = com20020_found(dev, IRQF_SHARED);
-		if (ret)
-			goto out_port;
-
-		devm_arcnet_led_init(dev, dev->dev_id, i);
+		if (ci->flags & ARC_HAS_LED) {
+			card->tx_led.brightness_set = led_tx_set;
+			card->tx_led.default_trigger = devm_kasprintf(&pdev->dev,
+							GFP_KERNEL, "arc%d-%d-tx",
+							dev->dev_id, i);
+			card->tx_led.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+							"pci:green:tx:%d-%d",
+							dev->dev_id, i);
+
+			card->tx_led.dev = &dev->dev;
+			card->recon_led.brightness_set = led_recon_set;
+			card->recon_led.default_trigger = devm_kasprintf(&pdev->dev,
+							GFP_KERNEL, "arc%d-%d-recon",
+							dev->dev_id, i);
+			card->recon_led.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+							"pci:red:recon:%d-%d",
+							dev->dev_id, i);
+			card->recon_led.dev = &dev->dev;
+
+			ret = devm_led_classdev_register(&pdev->dev, &card->tx_led);
+			if (ret)
+				goto err_free_arcdev;
+
+			ret = devm_led_classdev_register(&pdev->dev, &card->recon_led);
+			if (ret)
+				goto err_free_arcdev;
+
+			dev_set_drvdata(&dev->dev, card);
+			devm_arcnet_led_init(dev, dev->dev_id, i);
+		}
 
+		card->dev = dev;
 		list_add(&card->list, &priv->list_dev);
-	}
+		continue;
 
-	pci_set_drvdata(pdev, priv);
-
-	return 0;
-
-out_port:
-	com20020pci_remove(pdev);
+err_free_arcdev:
+		free_arcdev(dev);
+		break;
+	}
+	if (ret)
+		com20020pci_remove(pdev);
 	return ret;
 }
 
@@ -294,7 +301,7 @@ static void com20020pci_remove(struct pci_dev *pdev)
 
 		unregister_netdev(dev);
 		free_irq(dev->irq, dev);
-		free_netdev(dev);
+		free_arcdev(dev);
 	}
 }
 
@@ -325,7 +332,7 @@ static struct com20020_pci_card_info card_info_5mbit = {
 };
 
 static struct com20020_pci_card_info card_info_sohard = {
-	.name = "PLX-PCI",
+	.name = "SOHARD SH ARC-PCI",
 	.devcount = 1,
 	/* SOHARD needs PCI base addr 4 */
 	.chan_map_tbl = {
@@ -360,7 +367,7 @@ static struct com20020_pci_card_info card_info_eae_arc1 = {
 		},
 	},
 	.rotary = 0x0,
-	.flags = ARC_CAN_10MBIT,
+	.flags = ARC_HAS_ROTARY | ARC_HAS_LED | ARC_CAN_10MBIT,
 };
 
 static struct com20020_pci_card_info card_info_eae_ma1 = {
@@ -392,7 +399,7 @@ static struct com20020_pci_card_info card_info_eae_ma1 = {
 		},
 	},
 	.rotary = 0x0,
-	.flags = ARC_CAN_10MBIT,
+	.flags = ARC_HAS_ROTARY | ARC_HAS_LED | ARC_CAN_10MBIT,
 };
 
 static struct com20020_pci_card_info card_info_eae_fb2 = {
@@ -417,7 +424,7 @@ static struct com20020_pci_card_info card_info_eae_fb2 = {
 		},
 	},
 	.rotary = 0x0,
-	.flags = ARC_CAN_10MBIT,
+	.flags = ARC_HAS_ROTARY | ARC_HAS_LED | ARC_CAN_10MBIT,
 };
 
 static const struct pci_device_id com20020pci_id_table[] = {
diff --git a/drivers/net/arcnet/com20020_cs.c b/drivers/net/arcnet/com20020_cs.c
index cf607ffcf358..9cc5eb6a8e90 100644
--- a/drivers/net/arcnet/com20020_cs.c
+++ b/drivers/net/arcnet/com20020_cs.c
@@ -177,7 +177,7 @@ static void com20020_detach(struct pcmcia_device *link)
 		dev = info->dev;
 		if (dev) {
 			dev_dbg(&link->dev, "kfree...\n");
-			free_netdev(dev);
+			free_arcdev(dev);
 		}
 		dev_dbg(&link->dev, "kfree2...\n");
 		kfree(info);
diff --git a/drivers/net/arcnet/com90io.c b/drivers/net/arcnet/com90io.c
index 186bbf87bc84..5843b8976fd1 100644
--- a/drivers/net/arcnet/com90io.c
+++ b/drivers/net/arcnet/com90io.c
@@ -396,7 +396,7 @@ static int __init com90io_init(void)
 	err = com90io_probe(dev);
 
 	if (err) {
-		free_netdev(dev);
+		free_arcdev(dev);
 		return err;
 	}
 
@@ -419,7 +419,7 @@ static void __exit com90io_exit(void)
 
 	free_irq(dev->irq, dev);
 	release_region(dev->base_addr, ARCNET_TOTAL_SIZE);
-	free_netdev(dev);
+	free_arcdev(dev);
 }
 
 module_init(com90io_init)
diff --git a/drivers/net/arcnet/com90xx.c b/drivers/net/arcnet/com90xx.c
index bd75d06ad7df..5e40ecf189b1 100644
--- a/drivers/net/arcnet/com90xx.c
+++ b/drivers/net/arcnet/com90xx.c
@@ -554,7 +554,7 @@ static int __init com90xx_found(int ioaddr, int airq, u_long shmem,
 err_release_mem:
 	release_mem_region(dev->mem_start, dev->mem_end - dev->mem_start + 1);
 err_free_dev:
-	free_netdev(dev);
+	free_arcdev(dev);
 	return -EIO;
 }
 
@@ -672,7 +672,7 @@ static void __exit com90xx_exit(void)
 		release_region(dev->base_addr, ARCNET_TOTAL_SIZE);
 		release_mem_region(dev->mem_start,
 				   dev->mem_end - dev->mem_start + 1);
-		free_netdev(dev);
+		free_arcdev(dev);
 	}
 }
 
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 90bfaea6d629..4cfb0d0ee80c 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -6870,7 +6870,7 @@ static int tg3_rx(struct tg3_napi *tnapi, int budget)
 				       desc_idx, *post_ptr);
 		drop_it_no_recycle:
 			/* Other statistics kept track of by card. */
-			tp->rx_dropped++;
+			tnapi->rx_dropped++;
 			goto next_pkt;
 		}
 
@@ -7896,8 +7896,10 @@ static int tg3_tso_bug(struct tg3 *tp, struct tg3_napi *tnapi,
 
 	segs = skb_gso_segment(skb, tp->dev->features &
 				    ~(NETIF_F_TSO | NETIF_F_TSO6));
-	if (IS_ERR(segs) || !segs)
+	if (IS_ERR(segs) || !segs) {
+		tnapi->tx_dropped++;
 		goto tg3_tso_bug_end;
+	}
 
 	do {
 		nskb = segs;
@@ -8169,7 +8171,7 @@ static netdev_tx_t tg3_start_xmit(struct sk_buff *skb, struct net_device *dev)
 drop:
 	dev_kfree_skb_any(skb);
 drop_nofree:
-	tp->tx_dropped++;
+	tnapi->tx_dropped++;
 	return NETDEV_TX_OK;
 }
 
@@ -9348,7 +9350,7 @@ static void __tg3_set_rx_mode(struct net_device *);
 /* tp->lock is held. */
 static int tg3_halt(struct tg3 *tp, int kind, bool silent)
 {
-	int err;
+	int err, i;
 
 	tg3_stop_fw(tp);
 
@@ -9369,6 +9371,13 @@ static int tg3_halt(struct tg3 *tp, int kind, bool silent)
 
 		/* And make sure the next sample is new data */
 		memset(tp->hw_stats, 0, sizeof(struct tg3_hw_stats));
+
+		for (i = 0; i < TG3_IRQ_MAX_VECS; ++i) {
+			struct tg3_napi *tnapi = &tp->napi[i];
+
+			tnapi->rx_dropped = 0;
+			tnapi->tx_dropped = 0;
+		}
 	}
 
 	return err;
@@ -11925,6 +11934,9 @@ static void tg3_get_nstats(struct tg3 *tp, struct rtnl_link_stats64 *stats)
 {
 	struct rtnl_link_stats64 *old_stats = &tp->net_stats_prev;
 	struct tg3_hw_stats *hw_stats = tp->hw_stats;
+	unsigned long rx_dropped;
+	unsigned long tx_dropped;
+	int i;
 
 	stats->rx_packets = old_stats->rx_packets +
 		get_stat64(&hw_stats->rx_ucast_packets) +
@@ -11971,8 +11983,26 @@ static void tg3_get_nstats(struct tg3 *tp, struct rtnl_link_stats64 *stats)
 	stats->rx_missed_errors = old_stats->rx_missed_errors +
 		get_stat64(&hw_stats->rx_discards);
 
-	stats->rx_dropped = tp->rx_dropped;
-	stats->tx_dropped = tp->tx_dropped;
+	/* Aggregate per-queue counters. The per-queue counters are updated
+	 * by a single writer, race-free. The result computed by this loop
+	 * might not be 100% accurate (counters can be updated in the middle of
+	 * the loop) but the next tg3_get_nstats() will recompute the current
+	 * value so it is acceptable.
+	 *
+	 * Note that these counters wrap around at 4G on 32bit machines.
+	 */
+	rx_dropped = (unsigned long)(old_stats->rx_dropped);
+	tx_dropped = (unsigned long)(old_stats->tx_dropped);
+
+	for (i = 0; i < tp->irq_cnt; i++) {
+		struct tg3_napi *tnapi = &tp->napi[i];
+
+		rx_dropped += tnapi->rx_dropped;
+		tx_dropped += tnapi->tx_dropped;
+	}
+
+	stats->rx_dropped = rx_dropped;
+	stats->tx_dropped = tx_dropped;
 }
 
 static int tg3_get_regs_len(struct net_device *dev)
diff --git a/drivers/net/ethernet/broadcom/tg3.h b/drivers/net/ethernet/broadcom/tg3.h
index 6953d0546acb..811627abde5c 100644
--- a/drivers/net/ethernet/broadcom/tg3.h
+++ b/drivers/net/ethernet/broadcom/tg3.h
@@ -3018,6 +3018,7 @@ struct tg3_napi {
 	u16				*rx_rcb_prod_idx;
 	struct tg3_rx_prodring_set	prodring;
 	struct tg3_rx_buffer_desc	*rx_rcb;
+	unsigned long			rx_dropped;
 
 	u32				tx_prod	____cacheline_aligned;
 	u32				tx_cons;
@@ -3026,6 +3027,7 @@ struct tg3_napi {
 	u32				prodmbox;
 	struct tg3_tx_buffer_desc	*tx_ring;
 	struct tg3_tx_ring_info		*tx_buffers;
+	unsigned long			tx_dropped;
 
 	dma_addr_t			status_mapping;
 	dma_addr_t			rx_rcb_mapping;
@@ -3219,8 +3221,6 @@ struct tg3 {
 
 
 	/* begin "everything else" cacheline(s) section */
-	unsigned long			rx_dropped;
-	unsigned long			tx_dropped;
 	struct rtnl_link_stats64	net_stats_prev;
 	struct tg3_ethtool_stats	estats_prev;
 
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
index 8aace2de0cc9..e34245649057 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
@@ -66,6 +66,27 @@ static enum mac_mode hns_get_enet_interface(const struct hns_mac_cb *mac_cb)
 	}
 }
 
+static u32 hns_mac_link_anti_shake(struct mac_driver *mac_ctrl_drv)
+{
+#define HNS_MAC_LINK_WAIT_TIME 5
+#define HNS_MAC_LINK_WAIT_CNT 40
+
+	u32 link_status = 0;
+	int i;
+
+	if (!mac_ctrl_drv->get_link_status)
+		return link_status;
+
+	for (i = 0; i < HNS_MAC_LINK_WAIT_CNT; i++) {
+		msleep(HNS_MAC_LINK_WAIT_TIME);
+		mac_ctrl_drv->get_link_status(mac_ctrl_drv, &link_status);
+		if (!link_status)
+			break;
+	}
+
+	return link_status;
+}
+
 void hns_mac_get_link_status(struct hns_mac_cb *mac_cb, u32 *link_status)
 {
 	struct mac_driver *mac_ctrl_drv;
@@ -83,6 +104,14 @@ void hns_mac_get_link_status(struct hns_mac_cb *mac_cb, u32 *link_status)
 							       &sfp_prsnt);
 		if (!ret)
 			*link_status = *link_status && sfp_prsnt;
+
+		/* for FIBER port, it may have a fake link up.
+		 * when the link status changes from down to up, we need to do
+		 * anti-shake. the anti-shake time is base on tests.
+		 * only FIBER port need to do this.
+		 */
+		if (*link_status && !mac_cb->link)
+			*link_status = hns_mac_link_anti_shake(mac_ctrl_drv);
 	}
 
 	mac_cb->link = *link_status;
diff --git a/drivers/net/hyperv/Kconfig b/drivers/net/hyperv/Kconfig
index ca7bf7f897d3..c8cbd85adcf9 100644
--- a/drivers/net/hyperv/Kconfig
+++ b/drivers/net/hyperv/Kconfig
@@ -3,5 +3,6 @@ config HYPERV_NET
 	tristate "Microsoft Hyper-V virtual network driver"
 	depends on HYPERV
 	select UCS2_STRING
+	select NLS
 	help
 	  Select this option to enable the Hyper-V virtual network driver.
diff --git a/drivers/of/base.c b/drivers/of/base.c
index b5c84607a74b..c8af9a65f98b 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -306,7 +306,7 @@ struct device_node *__of_find_all_nodes(struct device_node *prev)
  * @prev:	Previous node or NULL to start iteration
  *		of_node_put() will be called on it
  *
- * Returns a node pointer with refcount incremented, use
+ * Return: A node pointer with refcount incremented, use
  * of_node_put() on it when done.
  */
 struct device_node *of_find_all_nodes(struct device_node *prev)
@@ -367,7 +367,7 @@ bool __weak arch_match_cpu_phys_id(int cpu, u64 phys_id)
 	return (u32)phys_id == cpu;
 }
 
-/**
+/*
  * Checks if the given "prop_name" property holds the physical id of the
  * core/thread corresponding to the logical cpu 'cpu'. If 'thread' is not
  * NULL, local thread number within the core is returned in it.
@@ -436,7 +436,7 @@ bool __weak arch_find_n_match_cpu_physical_id(struct device_node *cpun,
  * before booting secondary cores. This function uses arch_match_cpu_phys_id
  * which can be overridden by architecture specific implementation.
  *
- * Returns a node pointer for the logical cpu with refcount incremented, use
+ * Return: A node pointer for the logical cpu with refcount incremented, use
  * of_node_put() on it when done. Returns NULL if not found.
  */
 struct device_node *of_get_cpu_node(int cpu, unsigned int *thread)
@@ -456,8 +456,8 @@ EXPORT_SYMBOL(of_get_cpu_node);
  *
  * @cpu_node: Pointer to the device_node for CPU.
  *
- * Returns the logical CPU number of the given CPU device_node.
- * Returns -ENODEV if the CPU is not found.
+ * Return: The logical CPU number of the given CPU device_node or -ENODEV if the
+ * CPU is not found.
  */
 int of_cpu_node_to_id(struct device_node *cpu_node)
 {
@@ -477,6 +477,42 @@ int of_cpu_node_to_id(struct device_node *cpu_node)
 }
 EXPORT_SYMBOL(of_cpu_node_to_id);
 
+/**
+ * of_get_cpu_state_node - Get CPU's idle state node at the given index
+ *
+ * @cpu_node: The device node for the CPU
+ * @index: The index in the list of the idle states
+ *
+ * Two generic methods can be used to describe a CPU's idle states, either via
+ * a flattened description through the "cpu-idle-states" binding or via the
+ * hierarchical layout, using the "power-domains" and the "domain-idle-states"
+ * bindings. This function check for both and returns the idle state node for
+ * the requested index.
+ *
+ * Return: An idle state node if found at @index. The refcount is incremented
+ * for it, so call of_node_put() on it when done. Returns NULL if not found.
+ */
+struct device_node *of_get_cpu_state_node(struct device_node *cpu_node,
+					  int index)
+{
+	struct of_phandle_args args;
+	int err;
+
+	err = of_parse_phandle_with_args(cpu_node, "power-domains",
+					"#power-domain-cells", 0, &args);
+	if (!err) {
+		struct device_node *state_node =
+			of_parse_phandle(args.np, "domain-idle-states", index);
+
+		of_node_put(args.np);
+		if (state_node)
+			return state_node;
+	}
+
+	return of_parse_phandle(cpu_node, "cpu-idle-states", index);
+}
+EXPORT_SYMBOL(of_get_cpu_state_node);
+
 /**
  * __of_device_is_compatible() - Check if the node matches given constraints
  * @device: pointer to node
@@ -587,7 +623,7 @@ int of_device_compatible_match(struct device_node *device,
  * of_machine_is_compatible - Test root of device tree for a given compatible value
  * @compat: compatible string to look for in root node's compatible property.
  *
- * Returns a positive integer if the root node has the given value in its
+ * Return: A positive integer if the root node has the given value in its
  * compatible property.
  */
 int of_machine_is_compatible(const char *compat)
@@ -609,7 +645,7 @@ EXPORT_SYMBOL(of_machine_is_compatible);
  *
  *  @device: Node to check for availability, with locks already held
  *
- *  Returns true if the status property is absent or set to "okay" or "ok",
+ *  Return: True if the status property is absent or set to "okay" or "ok",
  *  false otherwise
  */
 static bool __of_device_is_available(const struct device_node *device)
@@ -637,7 +673,7 @@ static bool __of_device_is_available(const struct device_node *device)
  *
  *  @device: Node to check for availability
  *
- *  Returns true if the status property is absent or set to "okay" or "ok",
+ *  Return: True if the status property is absent or set to "okay" or "ok",
  *  false otherwise
  */
 bool of_device_is_available(const struct device_node *device)
@@ -658,7 +694,7 @@ EXPORT_SYMBOL(of_device_is_available);
  *
  *  @device: Node to check for endianness
  *
- *  Returns true if the device has a "big-endian" property, or if the kernel
+ *  Return: True if the device has a "big-endian" property, or if the kernel
  *  was compiled for BE *and* the device has a "native-endian" property.
  *  Returns false otherwise.
  *
@@ -677,11 +713,11 @@ bool of_device_is_big_endian(const struct device_node *device)
 EXPORT_SYMBOL(of_device_is_big_endian);
 
 /**
- *	of_get_parent - Get a node's parent if any
- *	@node:	Node to get parent
+ * of_get_parent - Get a node's parent if any
+ * @node:	Node to get parent
  *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.
  */
 struct device_node *of_get_parent(const struct device_node *node)
 {
@@ -699,15 +735,15 @@ struct device_node *of_get_parent(const struct device_node *node)
 EXPORT_SYMBOL(of_get_parent);
 
 /**
- *	of_get_next_parent - Iterate to a node's parent
- *	@node:	Node to get parent of
+ * of_get_next_parent - Iterate to a node's parent
+ * @node:	Node to get parent of
  *
- *	This is like of_get_parent() except that it drops the
- *	refcount on the passed node, making it suitable for iterating
- *	through a node's parents.
+ * This is like of_get_parent() except that it drops the
+ * refcount on the passed node, making it suitable for iterating
+ * through a node's parents.
  *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.
  */
 struct device_node *of_get_next_parent(struct device_node *node)
 {
@@ -745,13 +781,13 @@ static struct device_node *__of_get_next_child(const struct device_node *node,
 	     child = __of_get_next_child(parent, child))
 
 /**
- *	of_get_next_child - Iterate a node childs
- *	@node:	parent node
- *	@prev:	previous child of the parent node, or NULL to get first
+ * of_get_next_child - Iterate a node childs
+ * @node:	parent node
+ * @prev:	previous child of the parent node, or NULL to get first
  *
- *	Returns a node pointer with refcount incremented, use of_node_put() on
- *	it when done. Returns NULL when prev is the last child. Decrements the
- *	refcount of prev.
+ * Return: A node pointer with refcount incremented, use of_node_put() on
+ * it when done. Returns NULL when prev is the last child. Decrements the
+ * refcount of prev.
  */
 struct device_node *of_get_next_child(const struct device_node *node,
 	struct device_node *prev)
@@ -767,12 +803,12 @@ struct device_node *of_get_next_child(const struct device_node *node,
 EXPORT_SYMBOL(of_get_next_child);
 
 /**
- *	of_get_next_available_child - Find the next available child node
- *	@node:	parent node
- *	@prev:	previous child of the parent node, or NULL to get first
+ * of_get_next_available_child - Find the next available child node
+ * @node:	parent node
+ * @prev:	previous child of the parent node, or NULL to get first
  *
- *      This function is like of_get_next_child(), except that it
- *      automatically skips any disabled nodes (i.e. status = "disabled").
+ * This function is like of_get_next_child(), except that it
+ * automatically skips any disabled nodes (i.e. status = "disabled").
  */
 struct device_node *of_get_next_available_child(const struct device_node *node,
 	struct device_node *prev)
@@ -798,12 +834,12 @@ struct device_node *of_get_next_available_child(const struct device_node *node,
 EXPORT_SYMBOL(of_get_next_available_child);
 
 /**
- *	of_get_next_cpu_node - Iterate on cpu nodes
- *	@prev:	previous child of the /cpus node, or NULL to get first
+ * of_get_next_cpu_node - Iterate on cpu nodes
+ * @prev:	previous child of the /cpus node, or NULL to get first
  *
- *	Returns a cpu node pointer with refcount incremented, use of_node_put()
- *	on it when done. Returns NULL when prev is the last child. Decrements
- *	the refcount of prev.
+ * Return: A cpu node pointer with refcount incremented, use of_node_put()
+ * on it when done. Returns NULL when prev is the last child. Decrements
+ * the refcount of prev.
  */
 struct device_node *of_get_next_cpu_node(struct device_node *prev)
 {
@@ -842,7 +878,7 @@ EXPORT_SYMBOL(of_get_next_cpu_node);
  * Lookup child node whose compatible property contains the given compatible
  * string.
  *
- * Returns a node pointer with refcount incremented, use of_node_put() on it
+ * Return: a node pointer with refcount incremented, use of_node_put() on it
  * when done; or NULL if not found.
  */
 struct device_node *of_get_compatible_child(const struct device_node *parent,
@@ -860,15 +896,15 @@ struct device_node *of_get_compatible_child(const struct device_node *parent,
 EXPORT_SYMBOL(of_get_compatible_child);
 
 /**
- *	of_get_child_by_name - Find the child node by name for a given parent
- *	@node:	parent node
- *	@name:	child name to look for.
+ * of_get_child_by_name - Find the child node by name for a given parent
+ * @node:	parent node
+ * @name:	child name to look for.
  *
- *      This function looks for child node for given matching name
+ * This function looks for child node for given matching name
  *
- *	Returns a node pointer if found, with refcount incremented, use
- *	of_node_put() on it when done.
- *	Returns NULL if node is not found.
+ * Return: A node pointer if found, with refcount incremented, use
+ * of_node_put() on it when done.
+ * Returns NULL if node is not found.
  */
 struct device_node *of_get_child_by_name(const struct device_node *node,
 				const char *name)
@@ -919,22 +955,22 @@ struct device_node *__of_find_node_by_full_path(struct device_node *node,
 }
 
 /**
- *	of_find_node_opts_by_path - Find a node matching a full OF path
- *	@path: Either the full path to match, or if the path does not
- *	       start with '/', the name of a property of the /aliases
- *	       node (an alias).  In the case of an alias, the node
- *	       matching the alias' value will be returned.
- *	@opts: Address of a pointer into which to store the start of
- *	       an options string appended to the end of the path with
- *	       a ':' separator.
- *
- *	Valid paths:
- *		/foo/bar	Full path
- *		foo		Valid alias
- *		foo/bar		Valid alias + relative path
- *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
+ * of_find_node_opts_by_path - Find a node matching a full OF path
+ * @path: Either the full path to match, or if the path does not
+ *       start with '/', the name of a property of the /aliases
+ *       node (an alias).  In the case of an alias, the node
+ *       matching the alias' value will be returned.
+ * @opts: Address of a pointer into which to store the start of
+ *       an options string appended to the end of the path with
+ *       a ':' separator.
+ *
+ * Valid paths:
+ *  * /foo/bar	Full path
+ *  * foo	Valid alias
+ *  * foo/bar	Valid alias + relative path
+ *
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.
  */
 struct device_node *of_find_node_opts_by_path(const char *path, const char **opts)
 {
@@ -984,15 +1020,15 @@ struct device_node *of_find_node_opts_by_path(const char *path, const char **opt
 EXPORT_SYMBOL(of_find_node_opts_by_path);
 
 /**
- *	of_find_node_by_name - Find a node by its "name" property
- *	@from:	The node to start searching from or NULL; the node
+ * of_find_node_by_name - Find a node by its "name" property
+ * @from:	The node to start searching from or NULL; the node
  *		you pass will not be searched, only the next one
  *		will. Typically, you pass what the previous call
  *		returned. of_node_put() will be called on @from.
- *	@name:	The name string to match against
+ * @name:	The name string to match against
  *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.
  */
 struct device_node *of_find_node_by_name(struct device_node *from,
 	const char *name)
@@ -1011,16 +1047,16 @@ struct device_node *of_find_node_by_name(struct device_node *from,
 EXPORT_SYMBOL(of_find_node_by_name);
 
 /**
- *	of_find_node_by_type - Find a node by its "device_type" property
- *	@from:	The node to start searching from, or NULL to start searching
+ * of_find_node_by_type - Find a node by its "device_type" property
+ * @from:	The node to start searching from, or NULL to start searching
  *		the entire device tree. The node you pass will not be
  *		searched, only the next one will; typically, you pass
  *		what the previous call returned. of_node_put() will be
  *		called on from for you.
- *	@type:	The type string to match against
+ * @type:	The type string to match against
  *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.
  */
 struct device_node *of_find_node_by_type(struct device_node *from,
 	const char *type)
@@ -1039,18 +1075,18 @@ struct device_node *of_find_node_by_type(struct device_node *from,
 EXPORT_SYMBOL(of_find_node_by_type);
 
 /**
- *	of_find_compatible_node - Find a node based on type and one of the
+ * of_find_compatible_node - Find a node based on type and one of the
  *                                tokens in its "compatible" property
- *	@from:		The node to start searching from or NULL, the node
- *			you pass will not be searched, only the next one
- *			will; typically, you pass what the previous call
- *			returned. of_node_put() will be called on it
- *	@type:		The type string to match "device_type" or NULL to ignore
- *	@compatible:	The string to match to one of the tokens in the device
- *			"compatible" list.
- *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
+ * @from:	The node to start searching from or NULL, the node
+ *		you pass will not be searched, only the next one
+ *		will; typically, you pass what the previous call
+ *		returned. of_node_put() will be called on it
+ * @type:	The type string to match "device_type" or NULL to ignore
+ * @compatible:	The string to match to one of the tokens in the device
+ *		"compatible" list.
+ *
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.
  */
 struct device_node *of_find_compatible_node(struct device_node *from,
 	const char *type, const char *compatible)
@@ -1070,16 +1106,16 @@ struct device_node *of_find_compatible_node(struct device_node *from,
 EXPORT_SYMBOL(of_find_compatible_node);
 
 /**
- *	of_find_node_with_property - Find a node which has a property with
- *                                   the given name.
- *	@from:		The node to start searching from or NULL, the node
- *			you pass will not be searched, only the next one
- *			will; typically, you pass what the previous call
- *			returned. of_node_put() will be called on it
- *	@prop_name:	The name of the property to look for.
- *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
+ * of_find_node_with_property - Find a node which has a property with
+ *                              the given name.
+ * @from:	The node to start searching from or NULL, the node
+ *		you pass will not be searched, only the next one
+ *		will; typically, you pass what the previous call
+ *		returned. of_node_put() will be called on it
+ * @prop_name:	The name of the property to look for.
+ *
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.
  */
 struct device_node *of_find_node_with_property(struct device_node *from,
 	const char *prop_name)
@@ -1128,10 +1164,10 @@ const struct of_device_id *__of_match_node(const struct of_device_id *matches,
 
 /**
  * of_match_node - Tell if a device_node has a matching of_match structure
- *	@matches:	array of of device match structures to search in
- *	@node:		the of device structure to match against
+ * @matches:	array of of device match structures to search in
+ * @node:	the of device structure to match against
  *
- *	Low level utility function used by device matching.
+ * Low level utility function used by device matching.
  */
 const struct of_device_id *of_match_node(const struct of_device_id *matches,
 					 const struct device_node *node)
@@ -1147,17 +1183,17 @@ const struct of_device_id *of_match_node(const struct of_device_id *matches,
 EXPORT_SYMBOL(of_match_node);
 
 /**
- *	of_find_matching_node_and_match - Find a node based on an of_device_id
- *					  match table.
- *	@from:		The node to start searching from or NULL, the node
- *			you pass will not be searched, only the next one
- *			will; typically, you pass what the previous call
- *			returned. of_node_put() will be called on it
- *	@matches:	array of of device match structures to search in
- *	@match		Updated to point at the matches entry which matched
- *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
+ * of_find_matching_node_and_match - Find a node based on an of_device_id
+ *				     match table.
+ * @from:	The node to start searching from or NULL, the node
+ *		you pass will not be searched, only the next one
+ *		will; typically, you pass what the previous call
+ *		returned. of_node_put() will be called on it
+ * @matches:	array of of device match structures to search in
+ * @match:	Updated to point at the matches entry which matched
+ *
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.
  */
 struct device_node *of_find_matching_node_and_match(struct device_node *from,
 					const struct of_device_id *matches,
@@ -1196,7 +1232,7 @@ EXPORT_SYMBOL(of_find_matching_node_and_match);
  * It does this by stripping the manufacturer prefix (as delimited by a ',')
  * from the first entry in the compatible list property.
  *
- * This routine returns 0 on success, <0 on failure.
+ * Return: This routine returns 0 on success, <0 on failure.
  */
 int of_modalias_node(struct device_node *node, char *modalias, int len)
 {
@@ -1216,7 +1252,7 @@ EXPORT_SYMBOL_GPL(of_modalias_node);
  * of_find_node_by_phandle - Find a node given a phandle
  * @handle:	phandle of the node to find
  *
- * Returns a node pointer with refcount incremented, use
+ * Return: A node pointer with refcount incremented, use
  * of_node_put() on it when done.
  */
 struct device_node *of_find_node_by_phandle(phandle handle)
@@ -1469,7 +1505,7 @@ static int __of_parse_phandle_with_args(const struct device_node *np,
  * @index: For properties holding a table of phandles, this is the index into
  *         the table
  *
- * Returns the device_node pointer with refcount incremented.  Use
+ * Return: The device_node pointer with refcount incremented.  Use
  * of_node_put() on it when done.
  */
 struct device_node *of_parse_phandle(const struct device_node *np,
@@ -1503,21 +1539,21 @@ EXPORT_SYMBOL(of_parse_phandle);
  * Caller is responsible to call of_node_put() on the returned out_args->np
  * pointer.
  *
- * Example:
+ * Example::
  *
- * phandle1: node1 {
+ *  phandle1: node1 {
  *	#list-cells = <2>;
- * }
+ *  };
  *
- * phandle2: node2 {
+ *  phandle2: node2 {
  *	#list-cells = <1>;
- * }
+ *  };
  *
- * node3 {
+ *  node3 {
  *	list = <&phandle1 1 2 &phandle2 3>;
- * }
+ *  };
  *
- * To get a device_node of the `node2' node you may call this:
+ * To get a device_node of the ``node2`` node you may call this:
  * of_parse_phandle_with_args(node3, "list", "#list-cells", 1, &args);
  */
 int of_parse_phandle_with_args(const struct device_node *np, const char *list_name,
@@ -1555,29 +1591,29 @@ EXPORT_SYMBOL(of_parse_phandle_with_args);
  * Caller is responsible to call of_node_put() on the returned out_args->np
  * pointer.
  *
- * Example:
+ * Example::
  *
- * phandle1: node1 {
- *	#list-cells = <2>;
- * }
+ *  phandle1: node1 {
+ *  	#list-cells = <2>;
+ *  };
  *
- * phandle2: node2 {
- *	#list-cells = <1>;
- * }
+ *  phandle2: node2 {
+ *  	#list-cells = <1>;
+ *  };
  *
- * phandle3: node3 {
- * 	#list-cells = <1>;
- * 	list-map = <0 &phandle2 3>,
- * 		   <1 &phandle2 2>,
- * 		   <2 &phandle1 5 1>;
- *	list-map-mask = <0x3>;
- * };
+ *  phandle3: node3 {
+ *  	#list-cells = <1>;
+ *  	list-map = <0 &phandle2 3>,
+ *  		   <1 &phandle2 2>,
+ *  		   <2 &phandle1 5 1>;
+ *  	list-map-mask = <0x3>;
+ *  };
  *
- * node4 {
- *	list = <&phandle1 1 2 &phandle3 0>;
- * }
+ *  node4 {
+ *  	list = <&phandle1 1 2 &phandle3 0>;
+ *  };
  *
- * To get a device_node of the `node2' node you may call this:
+ * To get a device_node of the ``node2`` node you may call this:
  * of_parse_phandle_with_args(node4, "list", "list", 1, &args);
  */
 int of_parse_phandle_with_args_map(const struct device_node *np,
@@ -1737,19 +1773,19 @@ EXPORT_SYMBOL(of_parse_phandle_with_args_map);
  * Caller is responsible to call of_node_put() on the returned out_args->np
  * pointer.
  *
- * Example:
+ * Example::
  *
- * phandle1: node1 {
- * }
+ *  phandle1: node1 {
+ *  };
  *
- * phandle2: node2 {
- * }
+ *  phandle2: node2 {
+ *  };
  *
- * node3 {
- *	list = <&phandle1 0 2 &phandle2 2 3>;
- * }
+ *  node3 {
+ *  	list = <&phandle1 0 2 &phandle2 2 3>;
+ *  };
  *
- * To get a device_node of the `node2' node you may call this:
+ * To get a device_node of the ``node2`` node you may call this:
  * of_parse_phandle_with_fixed_args(node3, "list", 2, 1, &args);
  */
 int of_parse_phandle_with_fixed_args(const struct device_node *np,
@@ -1769,7 +1805,7 @@ EXPORT_SYMBOL(of_parse_phandle_with_fixed_args);
  * @list_name:	property name that contains a list
  * @cells_name:	property name that specifies phandles' arguments count
  *
- * Returns the number of phandle + argument tuples within a property. It
+ * Return: The number of phandle + argument tuples within a property. It
  * is a typical pattern to encode a list of phandle and variable
  * arguments into a single property. The number of arguments is encoded
  * by a property in the phandle-target node. For example, a gpios
@@ -1817,6 +1853,8 @@ EXPORT_SYMBOL(of_count_phandle_with_args);
 
 /**
  * __of_add_property - Add a property to a node without lock operations
+ * @np:		Caller's Device Node
+ * @prob:	Property to add
  */
 int __of_add_property(struct device_node *np, struct property *prop)
 {
@@ -1838,6 +1876,8 @@ int __of_add_property(struct device_node *np, struct property *prop)
 
 /**
  * of_add_property - Add a property to a node
+ * @np:		Caller's Device Node
+ * @prob:	Property to add
  */
 int of_add_property(struct device_node *np, struct property *prop)
 {
@@ -1882,6 +1922,8 @@ int __of_remove_property(struct device_node *np, struct property *prop)
 
 /**
  * of_remove_property - Remove a property from a node.
+ * @np:		Caller's Device Node
+ * @prob:	Property to remove
  *
  * Note that we don't actually remove it, since we have given out
  * who-knows-how-many pointers to the data using get-property.
@@ -1988,13 +2030,12 @@ static void of_alias_add(struct alias_prop *ap, struct device_node *np,
 
 /**
  * of_alias_scan - Scan all properties of the 'aliases' node
+ * @dt_alloc:	An allocator that provides a virtual address to memory
+ *		for storing the resulting tree
  *
  * The function scans all the properties of the 'aliases' node and populates
  * the global lookup table with the properties.  It returns the
  * number of alias properties found, or an error code in case of failure.
- *
- * @dt_alloc:	An allocator that provides a virtual address to memory
- *		for storing the resulting tree
  */
 void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
 {
@@ -2063,7 +2104,9 @@ void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
  * @stem:	Alias stem of the given device_node
  *
  * The function travels the lookup table to get the alias id for the given
- * device_node and alias stem.  It returns the alias id if found.
+ * device_node and alias stem.
+ *
+ * Return: The alias id if found.
  */
 int of_alias_get_id(struct device_node *np, const char *stem)
 {
@@ -2167,13 +2210,14 @@ EXPORT_SYMBOL_GPL(of_alias_get_highest_id);
 
 /**
  * of_console_check() - Test and setup console for DT setup
- * @dn - Pointer to device node
- * @name - Name to use for preferred console without index. ex. "ttyS"
- * @index - Index to use for preferred console.
+ * @dn: Pointer to device node
+ * @name: Name to use for preferred console without index. ex. "ttyS"
+ * @index: Index to use for preferred console.
  *
  * Check if the given device node matches the stdout-path property in the
- * /chosen node. If it does then register it as the preferred console and return
- * TRUE. Otherwise return FALSE.
+ * /chosen node. If it does then register it as the preferred console.
+ *
+ * Return: TRUE if console successfully setup. Otherwise return FALSE.
  */
 bool of_console_check(struct device_node *dn, char *name, int index)
 {
@@ -2189,12 +2233,12 @@ bool of_console_check(struct device_node *dn, char *name, int index)
 EXPORT_SYMBOL_GPL(of_console_check);
 
 /**
- *	of_find_next_cache_node - Find a node's subsidiary cache
- *	@np:	node of type "cpu" or "cache"
+ * of_find_next_cache_node - Find a node's subsidiary cache
+ * @np:	node of type "cpu" or "cache"
  *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.  Caller should hold a reference
- *	to np.
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.  Caller should hold a reference
+ * to np.
  */
 struct device_node *of_find_next_cache_node(const struct device_node *np)
 {
@@ -2224,7 +2268,7 @@ struct device_node *of_find_next_cache_node(const struct device_node *np)
  *
  * @cpu: cpu number(logical index) for which the last cache level is needed
  *
- * Returns the the level at which the last cache is present. It is exactly
+ * Return: The the level at which the last cache is present. It is exactly
  * same as  the total number of cache levels for the given logical cpu.
  */
 int of_find_last_cache_level(unsigned int cpu)
@@ -2244,15 +2288,15 @@ int of_find_last_cache_level(unsigned int cpu)
 }
 
 /**
- * of_map_rid - Translate a requester ID through a downstream mapping.
+ * of_map_id - Translate an ID through a downstream mapping.
  * @np: root complex device node.
- * @rid: device requester ID to map.
+ * @id: device ID to map.
  * @map_name: property name of the map to use.
  * @map_mask_name: optional property name of the mask to use.
  * @target: optional pointer to a target device node.
  * @id_out: optional pointer to receive the translated ID.
  *
- * Given a device requester ID, look up the appropriate implementation-defined
+ * Given a device ID, look up the appropriate implementation-defined
  * platform ID and/or the target device which receives transactions on that
  * ID, as per the "iommu-map" and "msi-map" bindings. Either of @target or
  * @id_out may be NULL if only the other is required. If @target points to
@@ -2262,11 +2306,11 @@ int of_find_last_cache_level(unsigned int cpu)
  *
  * Return: 0 on success or a standard error code on failure.
  */
-int of_map_rid(struct device_node *np, u32 rid,
+int of_map_id(struct device_node *np, u32 id,
 	       const char *map_name, const char *map_mask_name,
 	       struct device_node **target, u32 *id_out)
 {
-	u32 map_mask, masked_rid;
+	u32 map_mask, masked_id;
 	int map_len;
 	const __be32 *map = NULL;
 
@@ -2278,7 +2322,7 @@ int of_map_rid(struct device_node *np, u32 rid,
 		if (target)
 			return -ENODEV;
 		/* Otherwise, no map implies no translation */
-		*id_out = rid;
+		*id_out = id;
 		return 0;
 	}
 
@@ -2298,22 +2342,22 @@ int of_map_rid(struct device_node *np, u32 rid,
 	if (map_mask_name)
 		of_property_read_u32(np, map_mask_name, &map_mask);
 
-	masked_rid = map_mask & rid;
+	masked_id = map_mask & id;
 	for ( ; map_len > 0; map_len -= 4 * sizeof(*map), map += 4) {
 		struct device_node *phandle_node;
-		u32 rid_base = be32_to_cpup(map + 0);
+		u32 id_base = be32_to_cpup(map + 0);
 		u32 phandle = be32_to_cpup(map + 1);
 		u32 out_base = be32_to_cpup(map + 2);
-		u32 rid_len = be32_to_cpup(map + 3);
+		u32 id_len = be32_to_cpup(map + 3);
 
-		if (rid_base & ~map_mask) {
-			pr_err("%pOF: Invalid %s translation - %s-mask (0x%x) ignores rid-base (0x%x)\n",
+		if (id_base & ~map_mask) {
+			pr_err("%pOF: Invalid %s translation - %s-mask (0x%x) ignores id-base (0x%x)\n",
 				np, map_name, map_name,
-				map_mask, rid_base);
+				map_mask, id_base);
 			return -EFAULT;
 		}
 
-		if (masked_rid < rid_base || masked_rid >= rid_base + rid_len)
+		if (masked_id < id_base || masked_id >= id_base + id_len)
 			continue;
 
 		phandle_node = of_find_node_by_phandle(phandle);
@@ -2331,20 +2375,20 @@ int of_map_rid(struct device_node *np, u32 rid,
 		}
 
 		if (id_out)
-			*id_out = masked_rid - rid_base + out_base;
+			*id_out = masked_id - id_base + out_base;
 
-		pr_debug("%pOF: %s, using mask %08x, rid-base: %08x, out-base: %08x, length: %08x, rid: %08x -> %08x\n",
-			np, map_name, map_mask, rid_base, out_base,
-			rid_len, rid, masked_rid - rid_base + out_base);
+		pr_debug("%pOF: %s, using mask %08x, id-base: %08x, out-base: %08x, length: %08x, id: %08x -> %08x\n",
+			np, map_name, map_mask, id_base, out_base,
+			id_len, id, masked_id - id_base + out_base);
 		return 0;
 	}
 
-	pr_info("%pOF: no %s translation for rid 0x%x on %pOF\n", np, map_name,
-		rid, target && *target ? *target : NULL);
+	pr_info("%pOF: no %s translation for id 0x%x on %pOF\n", np, map_name,
+		id, target && *target ? *target : NULL);
 
 	/* Bypasses translation */
 	if (id_out)
-		*id_out = rid;
+		*id_out = id;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(of_map_rid);
+EXPORT_SYMBOL_GPL(of_map_id);
diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 49b16f76d78e..ae969630958c 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -27,7 +27,7 @@ static struct device_node *kobj_to_device_node(struct kobject *kobj)
  * @node:	Node to inc refcount, NULL is supported to simplify writing of
  *		callers
  *
- * Returns node.
+ * Return: The node with refcount incremented.
  */
 struct device_node *of_node_get(struct device_node *node)
 {
@@ -104,8 +104,10 @@ int of_reconfig_notify(unsigned long action, struct of_reconfig_data *p)
  * @arg		- argument of the of notifier
  *
  * Returns the new state of a device based on the notifier used.
- * Returns 0 on device going from enabled to disabled, 1 on device
- * going from disabled to enabled and -1 on no change.
+ *
+ * Return: OF_RECONFIG_CHANGE_REMOVE on device going from enabled to
+ * disabled, OF_RECONFIG_CHANGE_ADD on device going from disabled to
+ * enabled and OF_RECONFIG_NO_CHANGE on no change.
  */
 int of_reconfig_get_state_change(unsigned long action, struct of_reconfig_data *pr)
 {
@@ -372,7 +374,8 @@ void of_node_release(struct kobject *kobj)
  * property structure and the property name & contents. The property's
  * flags have the OF_DYNAMIC bit set so that we can differentiate between
  * dynamically allocated properties and not.
- * Returns the newly allocated property or NULL on out of memory error.
+ *
+ * Return: The newly allocated property or NULL on out of memory error.
  */
 struct property *__of_prop_dup(const struct property *prop, gfp_t allocflags)
 {
@@ -415,7 +418,7 @@ struct property *__of_prop_dup(const struct property *prop, gfp_t allocflags)
  * another node.  The node data are dynamically allocated and all the node
  * flags have the OF_DYNAMIC & OF_DETACHED bits set.
  *
- * Returns the newly allocated node or NULL on out of memory error.
+ * Return: The newly allocated node or NULL on out of memory error.
  */
 struct device_node *__of_node_dup(const struct device_node *np,
 				  const char *full_name)
@@ -781,7 +784,8 @@ static int __of_changeset_apply(struct of_changeset *ocs)
  * Any side-effects of live tree state changes are applied here on
  * success, like creation/destruction of devices and side-effects
  * like creation of sysfs properties and directories.
- * Returns 0 on success, a negative error value in case of an error.
+ *
+ * Return: 0 on success, a negative error value in case of an error.
  * On error the partially applied effects are reverted.
  */
 int of_changeset_apply(struct of_changeset *ocs)
@@ -875,7 +879,8 @@ static int __of_changeset_revert(struct of_changeset *ocs)
  * was before the application.
  * Any side-effects like creation/destruction of devices and
  * removal of sysfs properties and directories are applied.
- * Returns 0 on success, a negative error value in case of an error.
+ *
+ * Return: 0 on success, a negative error value in case of an error.
  */
 int of_changeset_revert(struct of_changeset *ocs)
 {
@@ -903,7 +908,8 @@ EXPORT_SYMBOL_GPL(of_changeset_revert);
  * + OF_RECONFIG_ADD_PROPERTY
  * + OF_RECONFIG_REMOVE_PROPERTY,
  * + OF_RECONFIG_UPDATE_PROPERTY
- * Returns 0 on success, a negative error value in case of an error.
+ *
+ * Return: 0 on success, a negative error value in case of an error.
  */
 int of_changeset_action(struct of_changeset *ocs, unsigned long action,
 		struct device_node *np, struct property *prop)
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 6d519ef3c5da..1db951f43353 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -282,7 +282,7 @@ static void reverse_nodes(struct device_node *parent)
  * @dad: Parent struct device_node
  * @nodepp: The device_node tree created by the call
  *
- * It returns the size of unflattened device tree or error code
+ * Return: The size of unflattened device tree or error code
  */
 static int unflatten_dt_nodes(const void *blob,
 			      void *mem,
@@ -349,11 +349,6 @@ static int unflatten_dt_nodes(const void *blob,
 
 /**
  * __unflatten_device_tree - create tree of device_nodes from flat blob
- *
- * unflattens a device-tree, creating the
- * tree of struct device_node. It also fills the "name" and "type"
- * pointers of the nodes so the normal device-tree walking functions
- * can be used.
  * @blob: The blob to expand
  * @dad: Parent device node
  * @mynodes: The device_node tree created by the call
@@ -361,7 +356,11 @@ static int unflatten_dt_nodes(const void *blob,
  * for the resulting tree
  * @detached: if true set OF_DETACHED on @mynodes
  *
- * Returns NULL on failure or the memory chunk containing the unflattened
+ * unflattens a device-tree, creating the tree of struct device_node. It also
+ * fills the "name" and "type" pointers of the nodes so the normal device-tree
+ * walking functions can be used.
+ *
+ * Return: NULL on failure or the memory chunk containing the unflattened
  * device tree on success.
  */
 void *__unflatten_device_tree(const void *blob,
@@ -442,7 +441,7 @@ static DEFINE_MUTEX(of_fdt_unflatten_mutex);
  * pointers of the nodes so the normal device-tree walking functions
  * can be used.
  *
- * Returns NULL on failure or the memory chunk containing the unflattened
+ * Return: NULL on failure or the memory chunk containing the unflattened
  * device tree on success.
  */
 void *of_fdt_unflatten_tree(const unsigned long *blob,
@@ -720,7 +719,7 @@ const void *__init of_get_flat_dt_prop(unsigned long node, const char *name,
  * @node: node to test
  * @compat: compatible string to compare with compatible list.
  *
- * On match, returns a non-zero value with smaller values returned for more
+ * Return: a non-zero value on match with smaller values returned for more
  * specific compatible values.
  */
 static int of_fdt_is_compatible(const void *blob,
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index a296eaf52a5b..352e14b007e7 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -48,7 +48,7 @@ EXPORT_SYMBOL_GPL(irq_of_parse_and_map);
  * of_irq_find_parent - Given a device node, find its interrupt parent node
  * @child: pointer to device node
  *
- * Returns a pointer to the interrupt parent node, or NULL if the interrupt
+ * Return: A pointer to the interrupt parent node, or NULL if the interrupt
  * parent could not be determined.
  */
 struct device_node *of_irq_find_parent(struct device_node *child)
@@ -81,14 +81,14 @@ EXPORT_SYMBOL_GPL(of_irq_find_parent);
  * @addr:	address specifier (start of "reg" property of the device) in be32 format
  * @out_irq:	structure of_phandle_args updated by this function
  *
- * Returns 0 on success and a negative number on error
- *
  * This function is a low-level interrupt tree walking function. It
  * can be used to do a partial walk with synthetized reg and interrupts
  * properties, for example when resolving PCI interrupts when no device
  * node exist for the parent. It takes an interrupt specifier structure as
  * input, walks the tree looking for any interrupt-map properties, translates
  * the specifier for each map, and then returns the translated map.
+ *
+ * Return: 0 on success and a negative number on error
  */
 int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 {
@@ -380,7 +380,7 @@ EXPORT_SYMBOL_GPL(of_irq_to_resource);
  * @dev: pointer to device tree node
  * @index: zero-based index of the IRQ
  *
- * Returns Linux IRQ number on success, or 0 on the IRQ mapping failure, or
+ * Return: Linux IRQ number on success, or 0 on the IRQ mapping failure, or
  * -EPROBE_DEFER if the IRQ domain is not yet created, or error code in case
  * of any other failure.
  */
@@ -407,7 +407,7 @@ EXPORT_SYMBOL_GPL(of_irq_get);
  * @dev: pointer to device tree node
  * @name: IRQ name
  *
- * Returns Linux IRQ number on success, or 0 on the IRQ mapping failure, or
+ * Return: Linux IRQ number on success, or 0 on the IRQ mapping failure, or
  * -EPROBE_DEFER if the IRQ domain is not yet created, or error code in case
  * of any other failure.
  */
@@ -447,7 +447,7 @@ int of_irq_count(struct device_node *dev)
  * @res: array of resources to fill in
  * @nr_irqs: the number of IRQs (and upper bound for num of @res elements)
  *
- * Returns the size of the filled in table (up to @nr_irqs).
+ * Return: The size of the filled in table (up to @nr_irqs).
  */
 int of_irq_to_resource_table(struct device_node *dev, struct resource *res,
 		int nr_irqs)
@@ -576,55 +576,57 @@ void __init of_irq_init(const struct of_device_id *matches)
 	}
 }
 
-static u32 __of_msi_map_rid(struct device *dev, struct device_node **np,
-			    u32 rid_in)
+static u32 __of_msi_map_id(struct device *dev, struct device_node **np,
+			    u32 id_in)
 {
 	struct device *parent_dev;
-	u32 rid_out = rid_in;
+	u32 id_out = id_in;
 
 	/*
 	 * Walk up the device parent links looking for one with a
 	 * "msi-map" property.
 	 */
 	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent)
-		if (!of_map_rid(parent_dev->of_node, rid_in, "msi-map",
-				"msi-map-mask", np, &rid_out))
+		if (!of_map_id(parent_dev->of_node, id_in, "msi-map",
+				"msi-map-mask", np, &id_out))
 			break;
-	return rid_out;
+	return id_out;
 }
 
 /**
- * of_msi_map_rid - Map a MSI requester ID for a device.
+ * of_msi_map_id - Map a MSI ID for a device.
  * @dev: device for which the mapping is to be done.
  * @msi_np: device node of the expected msi controller.
- * @rid_in: unmapped MSI requester ID for the device.
+ * @id_in: unmapped MSI ID for the device.
  *
  * Walk up the device hierarchy looking for devices with a "msi-map"
- * property.  If found, apply the mapping to @rid_in.
+ * property.  If found, apply the mapping to @id_in.
  *
- * Returns the mapped MSI requester ID.
+ * Return: The mapped MSI ID.
  */
-u32 of_msi_map_rid(struct device *dev, struct device_node *msi_np, u32 rid_in)
+u32 of_msi_map_id(struct device *dev, struct device_node *msi_np, u32 id_in)
 {
-	return __of_msi_map_rid(dev, &msi_np, rid_in);
+	return __of_msi_map_id(dev, &msi_np, id_in);
 }
 
 /**
  * of_msi_map_get_device_domain - Use msi-map to find the relevant MSI domain
  * @dev: device for which the mapping is to be done.
- * @rid: Requester ID for the device.
+ * @id: Device ID.
+ * @bus_token: Bus token
  *
  * Walk up the device hierarchy looking for devices with a "msi-map"
  * property.
  *
  * Returns: the MSI domain for this device (or NULL on failure)
  */
-struct irq_domain *of_msi_map_get_device_domain(struct device *dev, u32 rid)
+struct irq_domain *of_msi_map_get_device_domain(struct device *dev, u32 id,
+						u32 bus_token)
 {
 	struct device_node *np = NULL;
 
-	__of_msi_map_rid(dev, &np, rid);
-	return irq_find_matching_host(np, DOMAIN_BUS_PCI_MSI);
+	__of_msi_map_id(dev, &np, id);
+	return irq_find_matching_host(np, bus_token);
 }
 
 /**
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index dc298775f762..b551fe44f2f9 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -296,7 +296,7 @@ static struct property *dup_and_fixup_symbol_prop(
  *
  * Update of property in symbols node is not allowed.
  *
- * Returns 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
+ * Return: 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
  * invalid @overlay.
  */
 static int add_changeset_property(struct overlay_changeset *ovcs,
@@ -401,7 +401,7 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
  *
  * NOTE_2: Multiple mods of created nodes not supported.
  *
- * Returns 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
+ * Return: 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
  * invalid @overlay.
  */
 static int add_changeset_node(struct overlay_changeset *ovcs,
@@ -473,7 +473,7 @@ static int add_changeset_node(struct overlay_changeset *ovcs,
  *
  * Do not allow symbols node to have any children.
  *
- * Returns 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
+ * Return: 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
  * invalid @overlay_node.
  */
 static int build_changeset_next_level(struct overlay_changeset *ovcs,
@@ -604,7 +604,7 @@ static int find_dup_cset_prop(struct overlay_changeset *ovcs,
  * the same node or duplicate {add, delete, or update} properties entries
  * for the same property.
  *
- * Returns 0 on success, or -EINVAL if duplicate changeset entry found.
+ * Return: 0 on success, or -EINVAL if duplicate changeset entry found.
  */
 static int changeset_dup_entry_check(struct overlay_changeset *ovcs)
 {
@@ -628,7 +628,7 @@ static int changeset_dup_entry_check(struct overlay_changeset *ovcs)
  * any portions of the changeset that were successfully created will remain
  * in @ovcs->cset.
  *
- * Returns 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
+ * Return: 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
  * invalid overlay in @ovcs->fragments[].
  */
 static int build_changeset(struct overlay_changeset *ovcs)
@@ -724,7 +724,7 @@ static struct device_node *find_target(struct device_node *info_node)
  * the top level of @tree.  The relevant top level nodes are the fragment
  * nodes and the __symbols__ node.  Any other top level node will be ignored.
  *
- * Returns 0 on success, -ENOMEM if memory allocation failure, -EINVAL if error
+ * Return: 0 on success, -ENOMEM if memory allocation failure, -EINVAL if error
  * detected in @tree, or -ENOSPC if idr_alloc() error.
  */
 static int init_overlay_changeset(struct overlay_changeset *ovcs,
@@ -1180,7 +1180,7 @@ static int overlay_removal_is_ok(struct overlay_changeset *remove_ovcs)
  * If an error is returned by an overlay changeset post-remove notifier
  * then no further overlay changeset post-remove notifier will be called.
  *
- * Returns 0 on success, or a negative error number.  *ovcs_id is set to
+ * Return: 0 on success, or a negative error number.  *ovcs_id is set to
  * zero after reverting the changeset, even if a subsequent error occurs.
  */
 int of_overlay_remove(int *ovcs_id)
@@ -1267,7 +1267,7 @@ EXPORT_SYMBOL_GPL(of_overlay_remove);
  *
  * Removes all overlays from the system in the correct order.
  *
- * Returns 0 on success, or a negative error number
+ * Return: 0 on success, or a negative error number
  */
 int of_overlay_remove_all(void)
 {
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index b47a2292fe8e..cf5dbc9536f2 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -44,7 +44,7 @@ static const struct of_device_id of_skipped_node_table[] = {
  * Takes a reference to the embedded struct device which needs to be dropped
  * after use.
  *
- * Returns platform_device pointer, or NULL if not found
+ * Return: platform_device pointer, or NULL if not found
  */
 struct platform_device *of_find_device_by_node(struct device_node *np)
 {
@@ -160,7 +160,7 @@ EXPORT_SYMBOL(of_device_alloc);
  * @platform_data: pointer to populate platform_data pointer with
  * @parent: Linux device model parent device.
  *
- * Returns pointer to created platform device, or NULL if a device was not
+ * Return: Pointer to created platform device, or NULL if a device was not
  * registered.  Unavailable devices will not get registered.
  */
 static struct platform_device *of_platform_device_create_pdata(
@@ -204,7 +204,7 @@ static struct platform_device *of_platform_device_create_pdata(
  * @bus_id: name to assign device
  * @parent: Linux device model parent device.
  *
- * Returns pointer to created platform device, or NULL if a device was not
+ * Return: Pointer to created platform device, or NULL if a device was not
  * registered.  Unavailable devices will not get registered.
  */
 struct platform_device *of_platform_device_create(struct device_node *np,
@@ -463,7 +463,7 @@ EXPORT_SYMBOL(of_platform_bus_probe);
  * New board support should be using this function instead of
  * of_platform_bus_probe().
  *
- * Returns 0 on success, < 0 on failure.
+ * Return: 0 on success, < 0 on failure.
  */
 int of_platform_populate(struct device_node *root,
 			const struct of_device_id *matches,
@@ -594,7 +594,7 @@ static void devm_of_platform_populate_release(struct device *dev, void *res)
  * Similar to of_platform_populate(), but will automatically call
  * of_platform_depopulate() when the device is unbound from the bus.
  *
- * Returns 0 on success, < 0 on failure.
+ * Return: 0 on success, < 0 on failure.
  */
 int devm_of_platform_populate(struct device *dev)
 {
diff --git a/drivers/of/property.c b/drivers/of/property.c
index f6010ec0f67b..28ea326d102f 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -36,9 +36,11 @@
  * @elem_size:	size of the individual element
  *
  * Search for a property in a device node and count the number of elements of
- * size elem_size in it. Returns number of elements on sucess, -EINVAL if the
- * property does not exist or its length does not match a multiple of elem_size
- * and -ENODATA if the property does not have a value.
+ * size elem_size in it.
+ *
+ * Return: The number of elements on sucess, -EINVAL if the property does not
+ * exist or its length does not match a multiple of elem_size and -ENODATA if
+ * the property does not have a value.
  */
 int of_property_count_elems_of_size(const struct device_node *np,
 				const char *propname, int elem_size)
@@ -70,8 +72,9 @@ EXPORT_SYMBOL_GPL(of_property_count_elems_of_size);
  * @len:	if !=NULL, actual length is written to here
  *
  * Search for a property in a device node and valid the requested size.
- * Returns the property value on success, -EINVAL if the property does not
- *  exist, -ENODATA if property does not have a value, and -EOVERFLOW if the
+ *
+ * Return: The property value on success, -EINVAL if the property does not
+ * exist, -ENODATA if property does not have a value, and -EOVERFLOW if the
  * property data is too small or too large.
  *
  */
@@ -104,7 +107,9 @@ static void *of_find_property_value_of_size(const struct device_node *np,
  * @out_value:	pointer to return value, modified only if no error.
  *
  * Search for a property in a device node and read nth 32-bit value from
- * it. Returns 0 on success, -EINVAL if the property does not exist,
+ * it.
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist,
  * -ENODATA if property does not have a value, and -EOVERFLOW if the
  * property data isn't large enough.
  *
@@ -136,7 +141,9 @@ EXPORT_SYMBOL_GPL(of_property_read_u32_index);
  * @out_value:	pointer to return value, modified only if no error.
  *
  * Search for a property in a device node and read nth 64-bit value from
- * it. Returns 0 on success, -EINVAL if the property does not exist,
+ * it.
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist,
  * -ENODATA if property does not have a value, and -EOVERFLOW if the
  * property data isn't large enough.
  *
@@ -171,12 +178,14 @@ EXPORT_SYMBOL_GPL(of_property_read_u64_index);
  *		sz_min will be read.
  *
  * Search for a property in a device node and read 8-bit value(s) from
- * it. Returns number of elements read on success, -EINVAL if the property
- * does not exist, -ENODATA if property does not have a value, and -EOVERFLOW
- * if the property data is smaller than sz_min or longer than sz_max.
+ * it.
  *
  * dts entry of array should be like:
- *	property = /bits/ 8 <0x50 0x60 0x70>;
+ *  ``property = /bits/ 8 <0x50 0x60 0x70>;``
+ *
+ * Return: The number of elements read on success, -EINVAL if the property
+ * does not exist, -ENODATA if property does not have a value, and -EOVERFLOW
+ * if the property data is smaller than sz_min or longer than sz_max.
  *
  * The out_values is modified only if a valid u8 value can be decoded.
  */
@@ -219,12 +228,14 @@ EXPORT_SYMBOL_GPL(of_property_read_variable_u8_array);
  *		sz_min will be read.
  *
  * Search for a property in a device node and read 16-bit value(s) from
- * it. Returns number of elements read on success, -EINVAL if the property
- * does not exist, -ENODATA if property does not have a value, and -EOVERFLOW
- * if the property data is smaller than sz_min or longer than sz_max.
+ * it.
  *
  * dts entry of array should be like:
- *	property = /bits/ 16 <0x5000 0x6000 0x7000>;
+ *  ``property = /bits/ 16 <0x5000 0x6000 0x7000>;``
+ *
+ * Return: The number of elements read on success, -EINVAL if the property
+ * does not exist, -ENODATA if property does not have a value, and -EOVERFLOW
+ * if the property data is smaller than sz_min or longer than sz_max.
  *
  * The out_values is modified only if a valid u16 value can be decoded.
  */
@@ -267,7 +278,9 @@ EXPORT_SYMBOL_GPL(of_property_read_variable_u16_array);
  *		sz_min will be read.
  *
  * Search for a property in a device node and read 32-bit value(s) from
- * it. Returns number of elements read on success, -EINVAL if the property
+ * it.
+ *
+ * Return: The number of elements read on success, -EINVAL if the property
  * does not exist, -ENODATA if property does not have a value, and -EOVERFLOW
  * if the property data is smaller than sz_min or longer than sz_max.
  *
@@ -306,7 +319,9 @@ EXPORT_SYMBOL_GPL(of_property_read_variable_u32_array);
  * @out_value:	pointer to return value, modified only if return value is 0.
  *
  * Search for a property in a device node and read a 64-bit value from
- * it. Returns 0 on success, -EINVAL if the property does not exist,
+ * it.
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist,
  * -ENODATA if property does not have a value, and -EOVERFLOW if the
  * property data isn't large enough.
  *
@@ -341,7 +356,9 @@ EXPORT_SYMBOL_GPL(of_property_read_u64);
  *		sz_min will be read.
  *
  * Search for a property in a device node and read 64-bit value(s) from
- * it. Returns number of elements read on success, -EINVAL if the property
+ * it.
+ *
+ * Return: The number of elements read on success, -EINVAL if the property
  * does not exist, -ENODATA if property does not have a value, and -EOVERFLOW
  * if the property data is smaller than sz_min or longer than sz_max.
  *
@@ -383,10 +400,11 @@ EXPORT_SYMBOL_GPL(of_property_read_variable_u64_array);
  *		return value is 0.
  *
  * Search for a property in a device tree node and retrieve a null
- * terminated string value (pointer to data, not a copy). Returns 0 on
- * success, -EINVAL if the property does not exist, -ENODATA if property
- * does not have a value, and -EILSEQ if the string is not null-terminated
- * within the length of the property data.
+ * terminated string value (pointer to data, not a copy).
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist, -ENODATA if
+ * property does not have a value, and -EILSEQ if the string is not
+ * null-terminated within the length of the property data.
  *
  * The out_string pointer is modified only if a valid string can be decoded.
  */
@@ -750,7 +768,7 @@ EXPORT_SYMBOL(of_graph_get_remote_port_parent);
  * @node: pointer to a local endpoint device_node
  *
  * Return: Remote port node associated with remote endpoint node linked
- *	   to @node. Use of_node_put() on it when done.
+ * to @node. Use of_node_put() on it when done.
  */
 struct device_node *of_graph_get_remote_port(const struct device_node *node)
 {
@@ -783,7 +801,7 @@ EXPORT_SYMBOL(of_graph_get_endpoint_count);
  * @endpoint: identifier (value of reg property) of the endpoint node
  *
  * Return: Remote device node associated with remote endpoint node linked
- *	   to @node. Use of_node_put() on it when done.
+ * to @node. Use of_node_put() on it when done.
  */
 struct device_node *of_graph_get_remote_node(const struct device_node *node,
 					     u32 port, u32 endpoint)
diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index 3bc0027b7844..23aced808242 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -2648,6 +2648,8 @@ enum parport_pc_pci_cards {
 	netmos_9865,
 	quatech_sppxp100,
 	wch_ch382l,
+	brainboxes_uc146,
+	brainboxes_px203,
 };
 
 
@@ -2711,6 +2713,8 @@ static struct parport_pc_pci {
 	/* netmos_9865 */               { 1, { { 0, -1 }, } },
 	/* quatech_sppxp100 */		{ 1, { { 0, 1 }, } },
 	/* wch_ch382l */		{ 1, { { 2, -1 }, } },
+	/* brainboxes_uc146 */	{ 1, { { 3, -1 }, } },
+	/* brainboxes_px203 */	{ 1, { { 0, -1 }, } },
 };
 
 static const struct pci_device_id parport_pc_pci_tbl[] = {
@@ -2802,6 +2806,23 @@ static const struct pci_device_id parport_pc_pci_tbl[] = {
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, quatech_sppxp100 },
 	/* WCH CH382L PCI-E single parallel port card */
 	{ 0x1c00, 0x3050, 0x1c00, 0x3050, 0, 0, wch_ch382l },
+	/* Brainboxes IX-500/550 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x402a,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, oxsemi_pcie_pport },
+	/* Brainboxes UC-146/UC-157 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0be1,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc146 },
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0be2,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc146 },
+	/* Brainboxes PX-146/PX-257 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x401c,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, oxsemi_pcie_pport },
+	/* Brainboxes PX-203 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x4007,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_px203 },
+	/* Brainboxes PX-475 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x401f,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, oxsemi_pcie_pport },
 	{ 0, } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, parport_pc_pci_tbl);
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 715c85d4e688..c4f4a8a3bf8f 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1603,8 +1603,8 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
 	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
 
 	of_node = irq_domain_get_of_node(domain);
-	rid = of_node ? of_msi_map_rid(&pdev->dev, of_node, rid) :
-			iort_msi_map_rid(&pdev->dev, rid);
+	rid = of_node ? of_msi_map_id(&pdev->dev, of_node, rid) :
+			iort_msi_map_id(&pdev->dev, rid);
 
 	return rid;
 }
@@ -1624,9 +1624,10 @@ struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
 	u32 rid = pci_dev_id(pdev);
 
 	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
-	dom = of_msi_map_get_device_domain(&pdev->dev, rid);
+	dom = of_msi_map_get_device_domain(&pdev->dev, rid, DOMAIN_BUS_PCI_MSI);
 	if (!dom)
-		dom = iort_get_device_domain(&pdev->dev, rid);
+		dom = iort_get_device_domain(&pdev->dev, rid,
+					     DOMAIN_BUS_PCI_MSI);
 	return dom;
 }
 #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
diff --git a/drivers/scsi/be2iscsi/be_main.c b/drivers/scsi/be2iscsi/be_main.c
index 53b33f146f82..d34c881c3f8a 100644
--- a/drivers/scsi/be2iscsi/be_main.c
+++ b/drivers/scsi/be2iscsi/be_main.c
@@ -2694,6 +2694,7 @@ static int beiscsi_init_wrb_handle(struct beiscsi_hba *phba)
 		kfree(pwrb_context->pwrb_handle_base);
 		kfree(pwrb_context->pwrb_handle_basestd);
 	}
+	kfree(phwi_ctxt->be_wrbq);
 	return -ENOMEM;
 }
 
diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 5cd8c36c8fcc..2acaea5f3232 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -176,6 +176,7 @@ static int __init early_omap8250_setup(struct earlycon_device *device,
 OF_EARLYCON_DECLARE(omap8250, "ti,omap2-uart", early_omap8250_setup);
 OF_EARLYCON_DECLARE(omap8250, "ti,omap3-uart", early_omap8250_setup);
 OF_EARLYCON_DECLARE(omap8250, "ti,omap4-uart", early_omap8250_setup);
+OF_EARLYCON_DECLARE(omap8250, "ti,am654-uart", early_omap8250_setup);
 
 #endif
 
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 86084090232d..5f9d0ae8129d 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -227,17 +227,18 @@ static struct vendor_data vendor_zte = {
 
 /* Deals with DMA transactions */
 
-struct pl011_sgbuf {
-	struct scatterlist sg;
-	char *buf;
+struct pl011_dmabuf {
+	dma_addr_t		dma;
+	size_t			len;
+	char			*buf;
 };
 
 struct pl011_dmarx_data {
 	struct dma_chan		*chan;
 	struct completion	complete;
 	bool			use_buf_b;
-	struct pl011_sgbuf	sgbuf_a;
-	struct pl011_sgbuf	sgbuf_b;
+	struct pl011_dmabuf	dbuf_a;
+	struct pl011_dmabuf	dbuf_b;
 	dma_cookie_t		cookie;
 	bool			running;
 	struct timer_list	timer;
@@ -250,7 +251,8 @@ struct pl011_dmarx_data {
 
 struct pl011_dmatx_data {
 	struct dma_chan		*chan;
-	struct scatterlist	sg;
+	dma_addr_t		dma;
+	size_t			len;
 	char			*buf;
 	bool			queued;
 };
@@ -371,32 +373,24 @@ static int pl011_fifo_to_tty(struct uart_amba_port *uap)
 
 #define PL011_DMA_BUFFER_SIZE PAGE_SIZE
 
-static int pl011_sgbuf_init(struct dma_chan *chan, struct pl011_sgbuf *sg,
+static int pl011_dmabuf_init(struct dma_chan *chan, struct pl011_dmabuf *db,
 	enum dma_data_direction dir)
 {
-	dma_addr_t dma_addr;
-
-	sg->buf = dma_alloc_coherent(chan->device->dev,
-		PL011_DMA_BUFFER_SIZE, &dma_addr, GFP_KERNEL);
-	if (!sg->buf)
+	db->buf = dma_alloc_coherent(chan->device->dev, PL011_DMA_BUFFER_SIZE,
+				     &db->dma, GFP_KERNEL);
+	if (!db->buf)
 		return -ENOMEM;
-
-	sg_init_table(&sg->sg, 1);
-	sg_set_page(&sg->sg, phys_to_page(dma_addr),
-		PL011_DMA_BUFFER_SIZE, offset_in_page(dma_addr));
-	sg_dma_address(&sg->sg) = dma_addr;
-	sg_dma_len(&sg->sg) = PL011_DMA_BUFFER_SIZE;
+	db->len = PL011_DMA_BUFFER_SIZE;
 
 	return 0;
 }
 
-static void pl011_sgbuf_free(struct dma_chan *chan, struct pl011_sgbuf *sg,
+static void pl011_dmabuf_free(struct dma_chan *chan, struct pl011_dmabuf *db,
 	enum dma_data_direction dir)
 {
-	if (sg->buf) {
+	if (db->buf) {
 		dma_free_coherent(chan->device->dev,
-			PL011_DMA_BUFFER_SIZE, sg->buf,
-			sg_dma_address(&sg->sg));
+				  PL011_DMA_BUFFER_SIZE, db->buf, db->dma);
 	}
 }
 
@@ -557,8 +551,8 @@ static void pl011_dma_tx_callback(void *data)
 
 	spin_lock_irqsave(&uap->port.lock, flags);
 	if (uap->dmatx.queued)
-		dma_unmap_sg(dmatx->chan->device->dev, &dmatx->sg, 1,
-			     DMA_TO_DEVICE);
+		dma_unmap_single(dmatx->chan->device->dev, dmatx->dma,
+				dmatx->len, DMA_TO_DEVICE);
 
 	dmacr = uap->dmacr;
 	uap->dmacr = dmacr & ~UART011_TXDMAE;
@@ -644,18 +638,19 @@ static int pl011_dma_tx_refill(struct uart_amba_port *uap)
 			memcpy(&dmatx->buf[first], &xmit->buf[0], second);
 	}
 
-	dmatx->sg.length = count;
-
-	if (dma_map_sg(dma_dev->dev, &dmatx->sg, 1, DMA_TO_DEVICE) != 1) {
+	dmatx->len = count;
+	dmatx->dma = dma_map_single(dma_dev->dev, dmatx->buf, count,
+				    DMA_TO_DEVICE);
+	if (dmatx->dma == DMA_MAPPING_ERROR) {
 		uap->dmatx.queued = false;
 		dev_dbg(uap->port.dev, "unable to map TX DMA\n");
 		return -EBUSY;
 	}
 
-	desc = dmaengine_prep_slave_sg(chan, &dmatx->sg, 1, DMA_MEM_TO_DEV,
+	desc = dmaengine_prep_slave_single(chan, dmatx->dma, dmatx->len, DMA_MEM_TO_DEV,
 					     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc) {
-		dma_unmap_sg(dma_dev->dev, &dmatx->sg, 1, DMA_TO_DEVICE);
+		dma_unmap_single(dma_dev->dev, dmatx->dma, dmatx->len, DMA_TO_DEVICE);
 		uap->dmatx.queued = false;
 		/*
 		 * If DMA cannot be used right now, we complete this
@@ -819,8 +814,8 @@ __acquires(&uap->port.lock)
 	dmaengine_terminate_async(uap->dmatx.chan);
 
 	if (uap->dmatx.queued) {
-		dma_unmap_sg(uap->dmatx.chan->device->dev, &uap->dmatx.sg, 1,
-			     DMA_TO_DEVICE);
+		dma_unmap_single(uap->dmatx.chan->device->dev, uap->dmatx.dma,
+				 uap->dmatx.len, DMA_TO_DEVICE);
 		uap->dmatx.queued = false;
 		uap->dmacr &= ~UART011_TXDMAE;
 		pl011_write(uap->dmacr, uap, REG_DMACR);
@@ -834,15 +829,15 @@ static int pl011_dma_rx_trigger_dma(struct uart_amba_port *uap)
 	struct dma_chan *rxchan = uap->dmarx.chan;
 	struct pl011_dmarx_data *dmarx = &uap->dmarx;
 	struct dma_async_tx_descriptor *desc;
-	struct pl011_sgbuf *sgbuf;
+	struct pl011_dmabuf *dbuf;
 
 	if (!rxchan)
 		return -EIO;
 
 	/* Start the RX DMA job */
-	sgbuf = uap->dmarx.use_buf_b ?
-		&uap->dmarx.sgbuf_b : &uap->dmarx.sgbuf_a;
-	desc = dmaengine_prep_slave_sg(rxchan, &sgbuf->sg, 1,
+	dbuf = uap->dmarx.use_buf_b ?
+		&uap->dmarx.dbuf_b : &uap->dmarx.dbuf_a;
+	desc = dmaengine_prep_slave_single(rxchan, dbuf->dma, dbuf->len,
 					DMA_DEV_TO_MEM,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	/*
@@ -882,8 +877,8 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
 			       bool readfifo)
 {
 	struct tty_port *port = &uap->port.state->port;
-	struct pl011_sgbuf *sgbuf = use_buf_b ?
-		&uap->dmarx.sgbuf_b : &uap->dmarx.sgbuf_a;
+	struct pl011_dmabuf *dbuf = use_buf_b ?
+		&uap->dmarx.dbuf_b : &uap->dmarx.dbuf_a;
 	int dma_count = 0;
 	u32 fifotaken = 0; /* only used for vdbg() */
 
@@ -892,7 +887,7 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
 
 	if (uap->dmarx.poll_rate) {
 		/* The data can be taken by polling */
-		dmataken = sgbuf->sg.length - dmarx->last_residue;
+		dmataken = dbuf->len - dmarx->last_residue;
 		/* Recalculate the pending size */
 		if (pending >= dmataken)
 			pending -= dmataken;
@@ -906,7 +901,7 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
 		 * Note that tty_insert_flip_buf() tries to take as many chars
 		 * as it can.
 		 */
-		dma_count = tty_insert_flip_string(port, sgbuf->buf + dmataken,
+		dma_count = tty_insert_flip_string(port, dbuf->buf + dmataken,
 				pending);
 
 		uap->port.icount.rx += dma_count;
@@ -917,7 +912,7 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
 
 	/* Reset the last_residue for Rx DMA poll */
 	if (uap->dmarx.poll_rate)
-		dmarx->last_residue = sgbuf->sg.length;
+		dmarx->last_residue = dbuf->len;
 
 	/*
 	 * Only continue with trying to read the FIFO if all DMA chars have
@@ -954,8 +949,8 @@ static void pl011_dma_rx_irq(struct uart_amba_port *uap)
 {
 	struct pl011_dmarx_data *dmarx = &uap->dmarx;
 	struct dma_chan *rxchan = dmarx->chan;
-	struct pl011_sgbuf *sgbuf = dmarx->use_buf_b ?
-		&dmarx->sgbuf_b : &dmarx->sgbuf_a;
+	struct pl011_dmabuf *dbuf = dmarx->use_buf_b ?
+		&dmarx->dbuf_b : &dmarx->dbuf_a;
 	size_t pending;
 	struct dma_tx_state state;
 	enum dma_status dmastat;
@@ -977,7 +972,7 @@ static void pl011_dma_rx_irq(struct uart_amba_port *uap)
 	pl011_write(uap->dmacr, uap, REG_DMACR);
 	uap->dmarx.running = false;
 
-	pending = sgbuf->sg.length - state.residue;
+	pending = dbuf->len - state.residue;
 	BUG_ON(pending > PL011_DMA_BUFFER_SIZE);
 	/* Then we terminate the transfer - we now know our residue */
 	dmaengine_terminate_all(rxchan);
@@ -1004,8 +999,8 @@ static void pl011_dma_rx_callback(void *data)
 	struct pl011_dmarx_data *dmarx = &uap->dmarx;
 	struct dma_chan *rxchan = dmarx->chan;
 	bool lastbuf = dmarx->use_buf_b;
-	struct pl011_sgbuf *sgbuf = dmarx->use_buf_b ?
-		&dmarx->sgbuf_b : &dmarx->sgbuf_a;
+	struct pl011_dmabuf *dbuf = dmarx->use_buf_b ?
+		&dmarx->dbuf_b : &dmarx->dbuf_a;
 	size_t pending;
 	struct dma_tx_state state;
 	int ret;
@@ -1023,7 +1018,7 @@ static void pl011_dma_rx_callback(void *data)
 	 * the DMA irq handler. So we check the residue here.
 	 */
 	rxchan->device->device_tx_status(rxchan, dmarx->cookie, &state);
-	pending = sgbuf->sg.length - state.residue;
+	pending = dbuf->len - state.residue;
 	BUG_ON(pending > PL011_DMA_BUFFER_SIZE);
 	/* Then we terminate the transfer - we now know our residue */
 	dmaengine_terminate_all(rxchan);
@@ -1075,16 +1070,16 @@ static void pl011_dma_rx_poll(struct timer_list *t)
 	unsigned long flags = 0;
 	unsigned int dmataken = 0;
 	unsigned int size = 0;
-	struct pl011_sgbuf *sgbuf;
+	struct pl011_dmabuf *dbuf;
 	int dma_count;
 	struct dma_tx_state state;
 
-	sgbuf = dmarx->use_buf_b ? &uap->dmarx.sgbuf_b : &uap->dmarx.sgbuf_a;
+	dbuf = dmarx->use_buf_b ? &uap->dmarx.dbuf_b : &uap->dmarx.dbuf_a;
 	rxchan->device->device_tx_status(rxchan, dmarx->cookie, &state);
 	if (likely(state.residue < dmarx->last_residue)) {
-		dmataken = sgbuf->sg.length - dmarx->last_residue;
+		dmataken = dbuf->len - dmarx->last_residue;
 		size = dmarx->last_residue - state.residue;
-		dma_count = tty_insert_flip_string(port, sgbuf->buf + dmataken,
+		dma_count = tty_insert_flip_string(port, dbuf->buf + dmataken,
 				size);
 		if (dma_count == size)
 			dmarx->last_residue =  state.residue;
@@ -1131,7 +1126,7 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
 		return;
 	}
 
-	sg_init_one(&uap->dmatx.sg, uap->dmatx.buf, PL011_DMA_BUFFER_SIZE);
+	uap->dmatx.len = PL011_DMA_BUFFER_SIZE;
 
 	/* The DMA buffer is now the FIFO the TTY subsystem can use */
 	uap->port.fifosize = PL011_DMA_BUFFER_SIZE;
@@ -1141,7 +1136,7 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
 		goto skip_rx;
 
 	/* Allocate and map DMA RX buffers */
-	ret = pl011_sgbuf_init(uap->dmarx.chan, &uap->dmarx.sgbuf_a,
+	ret = pl011_dmabuf_init(uap->dmarx.chan, &uap->dmarx.dbuf_a,
 			       DMA_FROM_DEVICE);
 	if (ret) {
 		dev_err(uap->port.dev, "failed to init DMA %s: %d\n",
@@ -1149,12 +1144,12 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
 		goto skip_rx;
 	}
 
-	ret = pl011_sgbuf_init(uap->dmarx.chan, &uap->dmarx.sgbuf_b,
+	ret = pl011_dmabuf_init(uap->dmarx.chan, &uap->dmarx.dbuf_b,
 			       DMA_FROM_DEVICE);
 	if (ret) {
 		dev_err(uap->port.dev, "failed to init DMA %s: %d\n",
 			"RX buffer B", ret);
-		pl011_sgbuf_free(uap->dmarx.chan, &uap->dmarx.sgbuf_a,
+		pl011_dmabuf_free(uap->dmarx.chan, &uap->dmarx.dbuf_a,
 				 DMA_FROM_DEVICE);
 		goto skip_rx;
 	}
@@ -1208,8 +1203,9 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
 		/* In theory, this should already be done by pl011_dma_flush_buffer */
 		dmaengine_terminate_all(uap->dmatx.chan);
 		if (uap->dmatx.queued) {
-			dma_unmap_sg(uap->dmatx.chan->device->dev, &uap->dmatx.sg, 1,
-				     DMA_TO_DEVICE);
+			dma_unmap_single(uap->dmatx.chan->device->dev,
+					 uap->dmatx.dma, uap->dmatx.len,
+					 DMA_TO_DEVICE);
 			uap->dmatx.queued = false;
 		}
 
@@ -1220,8 +1216,8 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
 	if (uap->using_rx_dma) {
 		dmaengine_terminate_all(uap->dmarx.chan);
 		/* Clean up the RX DMA */
-		pl011_sgbuf_free(uap->dmarx.chan, &uap->dmarx.sgbuf_a, DMA_FROM_DEVICE);
-		pl011_sgbuf_free(uap->dmarx.chan, &uap->dmarx.sgbuf_b, DMA_FROM_DEVICE);
+		pl011_dmabuf_free(uap->dmarx.chan, &uap->dmarx.dbuf_a, DMA_FROM_DEVICE);
+		pl011_dmabuf_free(uap->dmarx.chan, &uap->dmarx.dbuf_b, DMA_FROM_DEVICE);
 		if (uap->dmarx.poll_rate)
 			del_timer_sync(&uap->dmarx.timer);
 		uap->using_rx_dma = false;
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 091cf5fe9030..42e1e6101485 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -694,6 +694,18 @@ static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 		case SC16IS7XX_IIR_RTOI_SRC:
 		case SC16IS7XX_IIR_XOFFI_SRC:
 			rxlen = sc16is7xx_port_read(port, SC16IS7XX_RXLVL_REG);
+
+			/*
+			 * There is a silicon bug that makes the chip report a
+			 * time-out interrupt but no data in the FIFO. This is
+			 * described in errata section 18.1.4.
+			 *
+			 * When this happens, read one byte from the FIFO to
+			 * clear the interrupt.
+			 */
+			if (iir == SC16IS7XX_IIR_RTOI_SRC && !rxlen)
+				rxlen = 1;
+
 			if (rxlen)
 				sc16is7xx_handle_rx(port, rxlen, iir);
 			break;
diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index c9d61d4dc9f5..571560d689c8 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -88,6 +88,7 @@ static void hidg_release(struct device *dev)
 {
 	struct f_hidg *hidg = container_of(dev, struct f_hidg, dev);
 
+	kfree(hidg->report_desc);
 	kfree(hidg->set_report_buf);
 	kfree(hidg);
 }
@@ -1293,9 +1294,9 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 	hidg->report_length = opts->report_length;
 	hidg->report_desc_length = opts->report_desc_length;
 	if (opts->report_desc) {
-		hidg->report_desc = devm_kmemdup(&hidg->dev, opts->report_desc,
-						 opts->report_desc_length,
-						 GFP_KERNEL);
+		hidg->report_desc = kmemdup(opts->report_desc,
+					    opts->report_desc_length,
+					    GFP_KERNEL);
 		if (!hidg->report_desc) {
 			put_device(&hidg->dev);
 			--opts->refcnt;
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index db926641b79d..79bebda96c55 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -193,7 +193,7 @@ static void typec_altmode_put_partner(struct altmode *altmode)
 	if (!partner)
 		return;
 
-	adev = &partner->adev;
+	adev = &altmode->adev;
 
 	if (is_typec_plug(adev->dev.parent)) {
 		struct typec_plug *plug = to_typec_plug(adev->dev.parent);
@@ -465,7 +465,8 @@ static void typec_altmode_release(struct device *dev)
 {
 	struct altmode *alt = to_altmode(to_typec_altmode(dev));
 
-	typec_altmode_put_partner(alt);
+	if (!is_typec_port(dev->parent))
+		typec_altmode_put_partner(alt);
 
 	altmode_id_remove(alt->adev.dev.parent, alt->id);
 	kfree(alt);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index dda86994e0a4..b4ed11b5f148 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2829,7 +2829,6 @@ int open_ctree(struct super_block *sb,
 		goto fail_alloc;
 	}
 
-	btrfs_info(fs_info, "first mount of filesystem %pU", disk_super->fsid);
 	/*
 	 * Verify the type first, if that or the checksum value are
 	 * corrupted, we'll find out
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 2804b055b4ed..ea8b5b2d859d 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -291,10 +291,7 @@ void __btrfs_panic(struct btrfs_fs_info *fs_info, const char *function,
 
 static void btrfs_put_super(struct super_block *sb)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
-
-	btrfs_info(fs_info, "last unmount of filesystem %pU", fs_info->fs_devices->fsid);
-	close_ctree(fs_info);
+	close_ctree(btrfs_sb(sb));
 }
 
 enum {
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 917441e3018a..12f632287d16 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1079,7 +1079,9 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
 	unsigned int xid;
 	int rc;
 
-	if (remap_flags & ~(REMAP_FILE_DEDUP | REMAP_FILE_ADVISORY))
+	if (remap_flags & REMAP_FILE_DEDUP)
+		return -EOPNOTSUPP;
+	if (remap_flags & ~REMAP_FILE_ADVISORY)
 		return -EINVAL;
 
 	cifs_dbg(FYI, "clone range\n");
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index ad9b207432e1..5fea15a5f341 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -2498,6 +2498,8 @@ smb2_get_dfs_refer(const unsigned int xid, struct cifs_ses *ses,
 				(char **)&dfs_rsp, &dfs_rsp_size);
 	} while (rc == -EAGAIN);
 
+	if (!rc && !dfs_rsp)
+		rc = -EIO;
 	if (rc) {
 		if ((rc != -ENOENT) && (rc != -EOPNOTSUPP))
 			cifs_tcon_dbg(VFS, "ioctl error in %s rc=%d\n", __func__, rc);
diff --git a/fs/io_uring.c b/fs/io_uring.c
index adc263400471..9de8961763b0 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3137,101 +3137,6 @@ static void io_finish_async(struct io_ring_ctx *ctx)
 	}
 }
 
-#if defined(CONFIG_UNIX)
-static void io_destruct_skb(struct sk_buff *skb)
-{
-	struct io_ring_ctx *ctx = skb->sk->sk_user_data;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(ctx->sqo_wq); i++)
-		if (ctx->sqo_wq[i])
-			flush_workqueue(ctx->sqo_wq[i]);
-
-	unix_destruct_scm(skb);
-}
-
-/*
- * Ensure the UNIX gc is aware of our file set, so we are certain that
- * the io_uring can be safely unregistered on process exit, even if we have
- * loops in the file referencing.
- */
-static int __io_sqe_files_scm(struct io_ring_ctx *ctx, int nr, int offset)
-{
-	struct sock *sk = ctx->ring_sock->sk;
-	struct scm_fp_list *fpl;
-	struct sk_buff *skb;
-	int i;
-
-	fpl = kzalloc(sizeof(*fpl), GFP_KERNEL);
-	if (!fpl)
-		return -ENOMEM;
-
-	skb = alloc_skb(0, GFP_KERNEL);
-	if (!skb) {
-		kfree(fpl);
-		return -ENOMEM;
-	}
-
-	skb->sk = sk;
-	skb->scm_io_uring = 1;
-	skb->destructor = io_destruct_skb;
-
-	fpl->user = get_uid(ctx->user);
-	for (i = 0; i < nr; i++) {
-		fpl->fp[i] = get_file(ctx->user_files[i + offset]);
-		unix_inflight(fpl->user, fpl->fp[i]);
-	}
-
-	fpl->max = fpl->count = nr;
-	UNIXCB(skb).fp = fpl;
-	refcount_add(skb->truesize, &sk->sk_wmem_alloc);
-	skb_queue_head(&sk->sk_receive_queue, skb);
-
-	for (i = 0; i < nr; i++)
-		fput(fpl->fp[i]);
-
-	return 0;
-}
-
-/*
- * If UNIX sockets are enabled, fd passing can cause a reference cycle which
- * causes regular reference counting to break down. We rely on the UNIX
- * garbage collection to take care of this problem for us.
- */
-static int io_sqe_files_scm(struct io_ring_ctx *ctx)
-{
-	unsigned left, total;
-	int ret = 0;
-
-	total = 0;
-	left = ctx->nr_user_files;
-	while (left) {
-		unsigned this_files = min_t(unsigned, left, SCM_MAX_FD);
-
-		ret = __io_sqe_files_scm(ctx, this_files, total);
-		if (ret)
-			break;
-		left -= this_files;
-		total += this_files;
-	}
-
-	if (!ret)
-		return 0;
-
-	while (total < ctx->nr_user_files) {
-		fput(ctx->user_files[total]);
-		total++;
-	}
-
-	return ret;
-}
-#else
-static int io_sqe_files_scm(struct io_ring_ctx *ctx)
-{
-	return 0;
-}
-#endif
-
 static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 				 unsigned nr_args)
 {
@@ -3285,11 +3190,7 @@ static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 		return ret;
 	}
 
-	ret = io_sqe_files_scm(ctx);
-	if (ret)
-		io_sqe_files_unregister(ctx);
-
-	return ret;
+	return 0;
 }
 
 static int io_sq_offload_start(struct io_ring_ctx *ctx,
diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
index d85d3c758d7b..4626540008c1 100644
--- a/fs/nilfs2/sufile.c
+++ b/fs/nilfs2/sufile.c
@@ -504,15 +504,38 @@ int nilfs_sufile_mark_dirty(struct inode *sufile, __u64 segnum)
 
 	down_write(&NILFS_MDT(sufile)->mi_sem);
 	ret = nilfs_sufile_get_segment_usage_block(sufile, segnum, 0, &bh);
-	if (!ret) {
-		mark_buffer_dirty(bh);
-		nilfs_mdt_mark_dirty(sufile);
-		kaddr = kmap_atomic(bh->b_page);
-		su = nilfs_sufile_block_get_segment_usage(sufile, segnum, bh, kaddr);
+	if (ret)
+		goto out_sem;
+
+	kaddr = kmap_atomic(bh->b_page);
+	su = nilfs_sufile_block_get_segment_usage(sufile, segnum, bh, kaddr);
+	if (unlikely(nilfs_segment_usage_error(su))) {
+		struct the_nilfs *nilfs = sufile->i_sb->s_fs_info;
+
+		kunmap_atomic(kaddr);
+		brelse(bh);
+		if (nilfs_segment_is_active(nilfs, segnum)) {
+			nilfs_error(sufile->i_sb,
+				    "active segment %llu is erroneous",
+				    (unsigned long long)segnum);
+		} else {
+			/*
+			 * Segments marked erroneous are never allocated by
+			 * nilfs_sufile_alloc(); only active segments, ie,
+			 * the segments indexed by ns_segnum or ns_nextnum,
+			 * can be erroneous here.
+			 */
+			WARN_ON_ONCE(1);
+		}
+		ret = -EIO;
+	} else {
 		nilfs_segment_usage_set_dirty(su);
 		kunmap_atomic(kaddr);
+		mark_buffer_dirty(bh);
+		nilfs_mdt_mark_dirty(sufile);
 		brelse(bh);
 	}
+out_sem:
 	up_write(&NILFS_MDT(sufile)->mi_sem);
 	return ret;
 }
@@ -539,9 +562,14 @@ int nilfs_sufile_set_segment_usage(struct inode *sufile, __u64 segnum,
 
 	kaddr = kmap_atomic(bh->b_page);
 	su = nilfs_sufile_block_get_segment_usage(sufile, segnum, bh, kaddr);
-	WARN_ON(nilfs_segment_usage_error(su));
-	if (modtime)
+	if (modtime) {
+		/*
+		 * Check segusage error and set su_lastmod only when updating
+		 * this entry with a valid timestamp, not for cancellation.
+		 */
+		WARN_ON_ONCE(nilfs_segment_usage_error(su));
 		su->su_lastmod = cpu_to_le64(modtime);
+	}
 	su->su_nblocks = cpu_to_le32(nblocks);
 	kunmap_atomic(kaddr);
 
diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
index d550a564645e..c8d869bc25b0 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -688,7 +688,11 @@ int init_nilfs(struct the_nilfs *nilfs, struct super_block *sb, char *data)
 			goto failed_sbh;
 		}
 		nilfs_release_super_block(nilfs);
-		sb_set_blocksize(sb, blocksize);
+		if (!sb_set_blocksize(sb, blocksize)) {
+			nilfs_msg(sb, KERN_ERR, "bad blocksize %d", blocksize);
+			err = -EINVAL;
+			goto out;
+		}
 
 		err = nilfs_load_super_block(nilfs, sb, blocksize, &sbp);
 		if (err)
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 64f700254ca0..cce2cbd4f301 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -29,8 +29,9 @@ void iort_deregister_domain_token(int trans_id);
 struct fwnode_handle *iort_find_domain_token(int trans_id);
 #ifdef CONFIG_ACPI_IORT
 void acpi_iort_init(void);
-u32 iort_msi_map_rid(struct device *dev, u32 req_id);
-struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id);
+u32 iort_msi_map_id(struct device *dev, u32 id);
+struct irq_domain *iort_get_device_domain(struct device *dev, u32 id,
+					  enum irq_domain_bus_token bus_token);
 void acpi_configure_pmsi_domain(struct device *dev);
 int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
 /* IOMMU interface */
@@ -39,10 +40,10 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev);
 int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
 #else
 static inline void acpi_iort_init(void) { }
-static inline u32 iort_msi_map_rid(struct device *dev, u32 req_id)
-{ return req_id; }
-static inline struct irq_domain *iort_get_device_domain(struct device *dev,
-							u32 req_id)
+static inline u32 iort_msi_map_id(struct device *dev, u32 id)
+{ return id; }
+static inline struct irq_domain *iort_get_device_domain(
+	struct device *dev, u32 id, enum irq_domain_bus_token bus_token)
 { return NULL; }
 static inline void acpi_configure_pmsi_domain(struct device *dev) { }
 /* IOMMU interface */
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 8134cc3b99cd..206d7ac411b8 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -141,6 +141,7 @@ enum cpuhp_state {
 	CPUHP_AP_ARM_CORESIGHT_STARTING,
 	CPUHP_AP_ARM64_ISNDEP_STARTING,
 	CPUHP_AP_SMPCFD_DYING,
+	CPUHP_AP_HRTIMERS_DYING,
 	CPUHP_AP_X86_TBOOT_DYING,
 	CPUHP_AP_ARM_CACHE_B15_RAC_DYING,
 	CPUHP_AP_ONLINE,
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 48be92aded5e..16c68a7287bc 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -526,9 +526,9 @@ extern void sysrq_timer_list_show(void);
 
 int hrtimers_prepare_cpu(unsigned int cpu);
 #ifdef CONFIG_HOTPLUG_CPU
-int hrtimers_dead_cpu(unsigned int cpu);
+int hrtimers_cpu_dying(unsigned int cpu);
 #else
-#define hrtimers_dead_cpu	NULL
+#define hrtimers_cpu_dying	NULL
 #endif
 
 #endif
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index a0e1cf1bef4e..68880c2b4fe0 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -397,6 +397,7 @@ struct mmc_host {
 	unsigned int		use_blk_mq:1;	/* use blk-mq */
 	unsigned int		retune_crc_disable:1; /* don't trigger retune upon crc */
 	unsigned int		can_dma_map_merge:1; /* merging can be used */
+	unsigned int		vqmmc_enabled:1; /* vqmmc regulator is enabled */
 
 	int			rescan_disable;	/* disable card detection */
 	int			rescan_entered;	/* used with nonremovable devices */
@@ -534,6 +535,8 @@ static inline int mmc_regulator_set_vqmmc(struct mmc_host *mmc,
 #endif
 
 int mmc_regulator_get_supply(struct mmc_host *mmc);
+int mmc_regulator_enable_vqmmc(struct mmc_host *mmc);
+void mmc_regulator_disable_vqmmc(struct mmc_host *mmc);
 
 static inline int mmc_card_is_removable(struct mmc_host *host)
 {
diff --git a/include/linux/of.h b/include/linux/of.h
index a7621e2b440a..8681277af9c6 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -351,6 +351,8 @@ extern const void *of_get_property(const struct device_node *node,
 				int *lenp);
 extern struct device_node *of_get_cpu_node(int cpu, unsigned int *thread);
 extern struct device_node *of_get_next_cpu_node(struct device_node *prev);
+extern struct device_node *of_get_cpu_state_node(struct device_node *cpu_node,
+						 int index);
 
 #define for_each_property_of_node(dn, pp) \
 	for (pp = dn->properties; pp != NULL; pp = pp->next)
@@ -422,12 +424,14 @@ extern int of_detach_node(struct device_node *);
  * @sz:		number of array elements to read
  *
  * Search for a property in a device node and read 8-bit value(s) from
- * it. Returns 0 on success, -EINVAL if the property does not exist,
- * -ENODATA if property does not have a value, and -EOVERFLOW if the
- * property data isn't large enough.
+ * it.
  *
  * dts entry of array should be like:
- *	property = /bits/ 8 <0x50 0x60 0x70>;
+ *  ``property = /bits/ 8 <0x50 0x60 0x70>;``
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist,
+ * -ENODATA if property does not have a value, and -EOVERFLOW if the
+ * property data isn't large enough.
  *
  * The out_values is modified only if a valid u8 value can be decoded.
  */
@@ -452,12 +456,14 @@ static inline int of_property_read_u8_array(const struct device_node *np,
  * @sz:		number of array elements to read
  *
  * Search for a property in a device node and read 16-bit value(s) from
- * it. Returns 0 on success, -EINVAL if the property does not exist,
- * -ENODATA if property does not have a value, and -EOVERFLOW if the
- * property data isn't large enough.
+ * it.
  *
  * dts entry of array should be like:
- *	property = /bits/ 16 <0x5000 0x6000 0x7000>;
+ *  ``property = /bits/ 16 <0x5000 0x6000 0x7000>;``
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist,
+ * -ENODATA if property does not have a value, and -EOVERFLOW if the
+ * property data isn't large enough.
  *
  * The out_values is modified only if a valid u16 value can be decoded.
  */
@@ -483,7 +489,9 @@ static inline int of_property_read_u16_array(const struct device_node *np,
  * @sz:		number of array elements to read
  *
  * Search for a property in a device node and read 32-bit value(s) from
- * it. Returns 0 on success, -EINVAL if the property does not exist,
+ * it.
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist,
  * -ENODATA if property does not have a value, and -EOVERFLOW if the
  * property data isn't large enough.
  *
@@ -511,7 +519,9 @@ static inline int of_property_read_u32_array(const struct device_node *np,
  * @sz:		number of array elements to read
  *
  * Search for a property in a device node and read 64-bit value(s) from
- * it. Returns 0 on success, -EINVAL if the property does not exist,
+ * it.
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist,
  * -ENODATA if property does not have a value, and -EOVERFLOW if the
  * property data isn't large enough.
  *
@@ -552,7 +562,7 @@ bool of_console_check(struct device_node *dn, char *name, int index);
 
 extern int of_cpu_node_to_id(struct device_node *np);
 
-int of_map_rid(struct device_node *np, u32 rid,
+int of_map_id(struct device_node *np, u32 id,
 	       const char *map_name, const char *map_mask_name,
 	       struct device_node **target, u32 *id_out);
 
@@ -765,6 +775,12 @@ static inline struct device_node *of_get_next_cpu_node(struct device_node *prev)
 	return NULL;
 }
 
+static inline struct device_node *of_get_cpu_state_node(struct device_node *cpu_node,
+					int index)
+{
+	return NULL;
+}
+
 static inline int of_n_addr_cells(struct device_node *np)
 {
 	return 0;
@@ -970,7 +986,7 @@ static inline int of_cpu_node_to_id(struct device_node *np)
 	return -ENODEV;
 }
 
-static inline int of_map_rid(struct device_node *np, u32 rid,
+static inline int of_map_id(struct device_node *np, u32 id,
 			     const char *map_name, const char *map_mask_name,
 			     struct device_node **target, u32 *id_out)
 {
@@ -1038,7 +1054,9 @@ static inline bool of_node_is_type(const struct device_node *np, const char *typ
  * @propname:	name of the property to be searched.
  *
  * Search for a property in a device node and count the number of u8 elements
- * in it. Returns number of elements on sucess, -EINVAL if the property does
+ * in it.
+ *
+ * Return: The number of elements on sucess, -EINVAL if the property does
  * not exist or its length does not match a multiple of u8 and -ENODATA if the
  * property does not have a value.
  */
@@ -1055,7 +1073,9 @@ static inline int of_property_count_u8_elems(const struct device_node *np,
  * @propname:	name of the property to be searched.
  *
  * Search for a property in a device node and count the number of u16 elements
- * in it. Returns number of elements on sucess, -EINVAL if the property does
+ * in it.
+ *
+ * Return: The number of elements on sucess, -EINVAL if the property does
  * not exist or its length does not match a multiple of u16 and -ENODATA if the
  * property does not have a value.
  */
@@ -1072,7 +1092,9 @@ static inline int of_property_count_u16_elems(const struct device_node *np,
  * @propname:	name of the property to be searched.
  *
  * Search for a property in a device node and count the number of u32 elements
- * in it. Returns number of elements on sucess, -EINVAL if the property does
+ * in it.
+ *
+ * Return: The number of elements on sucess, -EINVAL if the property does
  * not exist or its length does not match a multiple of u32 and -ENODATA if the
  * property does not have a value.
  */
@@ -1089,7 +1111,9 @@ static inline int of_property_count_u32_elems(const struct device_node *np,
  * @propname:	name of the property to be searched.
  *
  * Search for a property in a device node and count the number of u64 elements
- * in it. Returns number of elements on sucess, -EINVAL if the property does
+ * in it.
+ *
+ * Return: The number of elements on sucess, -EINVAL if the property does
  * not exist or its length does not match a multiple of u64 and -ENODATA if the
  * property does not have a value.
  */
@@ -1110,7 +1134,7 @@ static inline int of_property_count_u64_elems(const struct device_node *np,
  * Search for a property in a device tree node and retrieve a list of
  * terminated string values (pointer to data, not a copy) in that property.
  *
- * If @out_strs is NULL, the number of strings in the property is returned.
+ * Return: If @out_strs is NULL, the number of strings in the property is returned.
  */
 static inline int of_property_read_string_array(const struct device_node *np,
 						const char *propname, const char **out_strs,
@@ -1126,10 +1150,11 @@ static inline int of_property_read_string_array(const struct device_node *np,
  * @propname:	name of the property to be searched.
  *
  * Search for a property in a device tree node and retrieve the number of null
- * terminated string contain in it. Returns the number of strings on
- * success, -EINVAL if the property does not exist, -ENODATA if property
- * does not have a value, and -EILSEQ if the string is not null-terminated
- * within the length of the property data.
+ * terminated string contain in it.
+ *
+ * Return: The number of strings on success, -EINVAL if the property does not
+ * exist, -ENODATA if property does not have a value, and -EILSEQ if the string
+ * is not null-terminated within the length of the property data.
  */
 static inline int of_property_count_strings(const struct device_node *np,
 					    const char *propname)
@@ -1149,7 +1174,8 @@ static inline int of_property_count_strings(const struct device_node *np,
  * Search for a property in a device tree node and retrieve a null
  * terminated string value (pointer to data, not a copy) in the list of strings
  * contained in that property.
- * Returns 0 on success, -EINVAL if the property does not exist, -ENODATA if
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist, -ENODATA if
  * property does not have a value, and -EILSEQ if the string is not
  * null-terminated within the length of the property data.
  *
@@ -1169,7 +1195,8 @@ static inline int of_property_read_string_index(const struct device_node *np,
  * @propname:	name of the property to be searched.
  *
  * Search for a property in a device node.
- * Returns true if the property exists false otherwise.
+ *
+ * Return: true if the property exists false otherwise.
  */
 static inline bool of_property_read_bool(const struct device_node *np,
 					 const char *propname)
@@ -1415,7 +1442,7 @@ static inline int of_reconfig_get_state_change(unsigned long action,
  * of_device_is_system_power_controller - Tells if system-power-controller is found for device_node
  * @np: Pointer to the given device_node
  *
- * return true if present false otherwise
+ * Return: true if present false otherwise
  */
 static inline bool of_device_is_system_power_controller(const struct device_node *np)
 {
diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
index 1214cabb2247..e8b78139f78c 100644
--- a/include/linux/of_irq.h
+++ b/include/linux/of_irq.h
@@ -52,9 +52,10 @@ extern struct irq_domain *of_msi_get_domain(struct device *dev,
 					    struct device_node *np,
 					    enum irq_domain_bus_token token);
 extern struct irq_domain *of_msi_map_get_device_domain(struct device *dev,
-						       u32 rid);
+							u32 id,
+							u32 bus_token);
 extern void of_msi_configure(struct device *dev, struct device_node *np);
-u32 of_msi_map_rid(struct device *dev, struct device_node *msi_np, u32 rid_in);
+u32 of_msi_map_id(struct device *dev, struct device_node *msi_np, u32 id_in);
 #else
 static inline int of_irq_count(struct device_node *dev)
 {
@@ -85,17 +86,17 @@ static inline struct irq_domain *of_msi_get_domain(struct device *dev,
 	return NULL;
 }
 static inline struct irq_domain *of_msi_map_get_device_domain(struct device *dev,
-							      u32 rid)
+						u32 id, u32 bus_token)
 {
 	return NULL;
 }
 static inline void of_msi_configure(struct device *dev, struct device_node *np)
 {
 }
-static inline u32 of_msi_map_rid(struct device *dev,
-				 struct device_node *msi_np, u32 rid_in)
+static inline u32 of_msi_map_id(struct device *dev,
+				 struct device_node *msi_np, u32 id_in)
 {
-	return rid_in;
+	return id_in;
 }
 #endif
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 4c7409e23318..9e0e20c11aa3 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -702,6 +702,8 @@ struct perf_event {
 	struct pid_namespace		*ns;
 	u64				id;
 
+	atomic64_t			lost_samples;
+
 	u64				(*clock)(void);
 	perf_overflow_handler_t		overflow_handler;
 	void				*overflow_handler_context;
diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index 2d9e67a69cbe..2d52776def52 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -11,9 +11,12 @@
 /**
  * struct genl_multicast_group - generic netlink multicast group
  * @name: name of the multicast group, names are per-family
+ * @cap_sys_admin: whether %CAP_SYS_ADMIN is required for binding
  */
 struct genl_multicast_group {
 	char			name[GENL_NAMSIZ];
+	u8			flags;
+	u8			cap_sys_admin:1;
 };
 
 struct genl_ops;
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index ceccd980ffcf..19c143a293be 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -273,6 +273,7 @@ enum {
  *	  { u64		time_enabled; } && PERF_FORMAT_TOTAL_TIME_ENABLED
  *	  { u64		time_running; } && PERF_FORMAT_TOTAL_TIME_RUNNING
  *	  { u64		id;           } && PERF_FORMAT_ID
+ *	  { u64		lost;         } && PERF_FORMAT_LOST
  *	} && !PERF_FORMAT_GROUP
  *
  *	{ u64		nr;
@@ -280,6 +281,7 @@ enum {
  *	  { u64		time_running; } && PERF_FORMAT_TOTAL_TIME_RUNNING
  *	  { u64		value;
  *	    { u64	id;           } && PERF_FORMAT_ID
+ *	    { u64	lost;         } && PERF_FORMAT_LOST
  *	  }		cntr[nr];
  *	} && PERF_FORMAT_GROUP
  * };
@@ -289,8 +291,9 @@ enum perf_event_read_format {
 	PERF_FORMAT_TOTAL_TIME_RUNNING		= 1U << 1,
 	PERF_FORMAT_ID				= 1U << 2,
 	PERF_FORMAT_GROUP			= 1U << 3,
+	PERF_FORMAT_LOST			= 1U << 4,
 
-	PERF_FORMAT_MAX = 1U << 4,		/* non-ABI */
+	PERF_FORMAT_MAX = 1U << 5,		/* non-ABI */
 };
 
 #define PERF_ATTR_SIZE_VER0	64	/* sizeof first published struct */
diff --git a/kernel/cpu.c b/kernel/cpu.c
index c08456af0c7f..ba579bb6b897 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1473,7 +1473,7 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 	[CPUHP_HRTIMERS_PREPARE] = {
 		.name			= "hrtimers:prepare",
 		.startup.single		= hrtimers_prepare_cpu,
-		.teardown.single	= hrtimers_dead_cpu,
+		.teardown.single	= NULL,
 	},
 	[CPUHP_SMPCFD_PREPARE] = {
 		.name			= "smpcfd:prepare",
@@ -1540,6 +1540,12 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 		.startup.single		= NULL,
 		.teardown.single	= smpcfd_dying_cpu,
 	},
+	[CPUHP_AP_HRTIMERS_DYING] = {
+		.name			= "hrtimers:dying",
+		.startup.single		= NULL,
+		.teardown.single	= hrtimers_cpu_dying,
+	},
+
 	/* Entry state on starting. Interrupts enabled from here on. Transient
 	 * state for synchronsization */
 	[CPUHP_AP_ONLINE] = {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index cd32c7e55568..fcc8e3823198 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1711,28 +1711,34 @@ static inline void perf_event__state_init(struct perf_event *event)
 					      PERF_EVENT_STATE_INACTIVE;
 }
 
-static void __perf_event_read_size(struct perf_event *event, int nr_siblings)
+static int __perf_event_read_size(u64 read_format, int nr_siblings)
 {
 	int entry = sizeof(u64); /* value */
 	int size = 0;
 	int nr = 1;
 
-	if (event->attr.read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
+	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
 		size += sizeof(u64);
 
-	if (event->attr.read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
+	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
 		size += sizeof(u64);
 
-	if (event->attr.read_format & PERF_FORMAT_ID)
+	if (read_format & PERF_FORMAT_ID)
+		entry += sizeof(u64);
+
+	if (read_format & PERF_FORMAT_LOST)
 		entry += sizeof(u64);
 
-	if (event->attr.read_format & PERF_FORMAT_GROUP) {
+	if (read_format & PERF_FORMAT_GROUP) {
 		nr += nr_siblings;
 		size += sizeof(u64);
 	}
 
-	size += entry * nr;
-	event->read_size = size;
+	/*
+	 * Since perf_event_validate_size() limits this to 16k and inhibits
+	 * adding more siblings, this will never overflow.
+	 */
+	return size + nr * entry;
 }
 
 static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
@@ -1773,8 +1779,9 @@ static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
  */
 static void perf_event__header_size(struct perf_event *event)
 {
-	__perf_event_read_size(event,
-			       event->group_leader->nr_siblings);
+	event->read_size =
+		__perf_event_read_size(event->attr.read_format,
+				       event->group_leader->nr_siblings);
 	__perf_event_header_size(event, event->attr.sample_type);
 }
 
@@ -1805,24 +1812,35 @@ static void perf_event__id_header_size(struct perf_event *event)
 	event->id_header_size = size;
 }
 
+/*
+ * Check that adding an event to the group does not result in anybody
+ * overflowing the 64k event limit imposed by the output buffer.
+ *
+ * Specifically, check that the read_size for the event does not exceed 16k,
+ * read_size being the one term that grows with groups size. Since read_size
+ * depends on per-event read_format, also (re)check the existing events.
+ *
+ * This leaves 48k for the constant size fields and things like callchains,
+ * branch stacks and register sets.
+ */
 static bool perf_event_validate_size(struct perf_event *event)
 {
-	/*
-	 * The values computed here will be over-written when we actually
-	 * attach the event.
-	 */
-	__perf_event_read_size(event, event->group_leader->nr_siblings + 1);
-	__perf_event_header_size(event, event->attr.sample_type & ~PERF_SAMPLE_READ);
-	perf_event__id_header_size(event);
+	struct perf_event *sibling, *group_leader = event->group_leader;
 
-	/*
-	 * Sum the lot; should not exceed the 64k limit we have on records.
-	 * Conservative limit to allow for callchains and other variable fields.
-	 */
-	if (event->read_size + event->header_size +
-	    event->id_header_size + sizeof(struct perf_event_header) >= 16*1024)
+	if (__perf_event_read_size(event->attr.read_format,
+				   group_leader->nr_siblings + 1) > 16*1024)
+		return false;
+
+	if (__perf_event_read_size(group_leader->attr.read_format,
+				   group_leader->nr_siblings + 1) > 16*1024)
 		return false;
 
+	for_each_sibling_event(sibling, group_leader) {
+		if (__perf_event_read_size(sibling->attr.read_format,
+					   group_leader->nr_siblings + 1) > 16*1024)
+			return false;
+	}
+
 	return true;
 }
 
@@ -4915,11 +4933,15 @@ static int __perf_read_group_add(struct perf_event *leader,
 	values[n++] += perf_event_count(leader);
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(leader);
+	if (read_format & PERF_FORMAT_LOST)
+		values[n++] = atomic64_read(&leader->lost_samples);
 
 	for_each_sibling_event(sub, leader) {
 		values[n++] += perf_event_count(sub);
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
+		if (read_format & PERF_FORMAT_LOST)
+			values[n++] = atomic64_read(&sub->lost_samples);
 	}
 
 unlock:
@@ -4973,7 +4995,7 @@ static int perf_read_one(struct perf_event *event,
 				 u64 read_format, char __user *buf)
 {
 	u64 enabled, running;
-	u64 values[4];
+	u64 values[5];
 	int n = 0;
 
 	values[n++] = __perf_event_read_value(event, &enabled, &running);
@@ -4983,6 +5005,8 @@ static int perf_read_one(struct perf_event *event,
 		values[n++] = running;
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(event);
+	if (read_format & PERF_FORMAT_LOST)
+		values[n++] = atomic64_read(&event->lost_samples);
 
 	if (copy_to_user(buf, values, n * sizeof(u64)))
 		return -EFAULT;
@@ -6312,7 +6336,7 @@ static void perf_output_read_one(struct perf_output_handle *handle,
 				 u64 enabled, u64 running)
 {
 	u64 read_format = event->attr.read_format;
-	u64 values[4];
+	u64 values[5];
 	int n = 0;
 
 	values[n++] = perf_event_count(event);
@@ -6326,6 +6350,8 @@ static void perf_output_read_one(struct perf_output_handle *handle,
 	}
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(event);
+	if (read_format & PERF_FORMAT_LOST)
+		values[n++] = atomic64_read(&event->lost_samples);
 
 	__output_copy(handle, values, n * sizeof(u64));
 }
@@ -6336,7 +6362,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 {
 	struct perf_event *leader = event->group_leader, *sub;
 	u64 read_format = event->attr.read_format;
-	u64 values[5];
+	u64 values[6];
 	int n = 0;
 
 	values[n++] = 1 + leader->nr_siblings;
@@ -6354,6 +6380,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 	values[n++] = perf_event_count(leader);
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(leader);
+	if (read_format & PERF_FORMAT_LOST)
+		values[n++] = atomic64_read(&leader->lost_samples);
 
 	__output_copy(handle, values, n * sizeof(u64));
 
@@ -6367,6 +6395,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 		values[n++] = perf_event_count(sub);
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
+		if (read_format & PERF_FORMAT_LOST)
+			values[n++] = atomic64_read(&sub->lost_samples);
 
 		__output_copy(handle, values, n * sizeof(u64));
 	}
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index fb3edb2f8ac9..679cc87b40f4 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -171,8 +171,10 @@ __perf_output_begin(struct perf_output_handle *handle,
 		goto out;
 
 	if (unlikely(rb->paused)) {
-		if (rb->nr_pages)
+		if (rb->nr_pages) {
 			local_inc(&rb->lost);
+			atomic64_inc(&event->lost_samples);
+		}
 		goto out;
 	}
 
@@ -255,6 +257,7 @@ __perf_output_begin(struct perf_output_handle *handle,
 
 fail:
 	local_inc(&rb->lost);
+	atomic64_inc(&event->lost_samples);
 	perf_output_put_handle(handle);
 out:
 	rcu_read_unlock();
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 8e3c9228aec9..e2a055e46255 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2105,29 +2105,22 @@ static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
 	}
 }
 
-int hrtimers_dead_cpu(unsigned int scpu)
+int hrtimers_cpu_dying(unsigned int dying_cpu)
 {
 	struct hrtimer_cpu_base *old_base, *new_base;
-	int i;
+	int i, ncpu = cpumask_first(cpu_active_mask);
 
-	BUG_ON(cpu_online(scpu));
-	tick_cancel_sched_timer(scpu);
+	tick_cancel_sched_timer(dying_cpu);
+
+	old_base = this_cpu_ptr(&hrtimer_bases);
+	new_base = &per_cpu(hrtimer_bases, ncpu);
 
-	/*
-	 * this BH disable ensures that raise_softirq_irqoff() does
-	 * not wakeup ksoftirqd (and acquire the pi-lock) while
-	 * holding the cpu_base lock
-	 */
-	local_bh_disable();
-	local_irq_disable();
-	old_base = &per_cpu(hrtimer_bases, scpu);
-	new_base = this_cpu_ptr(&hrtimer_bases);
 	/*
 	 * The caller is globally serialized and nobody else
 	 * takes two locks at once, deadlock is not possible.
 	 */
-	raw_spin_lock(&new_base->lock);
-	raw_spin_lock_nested(&old_base->lock, SINGLE_DEPTH_NESTING);
+	raw_spin_lock(&old_base->lock);
+	raw_spin_lock_nested(&new_base->lock, SINGLE_DEPTH_NESTING);
 
 	for (i = 0; i < HRTIMER_MAX_CLOCK_BASES; i++) {
 		migrate_hrtimer_list(&old_base->clock_base[i],
@@ -2138,15 +2131,13 @@ int hrtimers_dead_cpu(unsigned int scpu)
 	 * The migration might have changed the first expiring softirq
 	 * timer on this CPU. Update it.
 	 */
-	hrtimer_update_softirq_timer(new_base, false);
+	__hrtimer_get_next_event(new_base, HRTIMER_ACTIVE_SOFT);
+	/* Tell the other CPU to retrigger the next event */
+	smp_call_function_single(ncpu, retrigger_next_event, NULL, 0);
 
-	raw_spin_unlock(&old_base->lock);
 	raw_spin_unlock(&new_base->lock);
+	raw_spin_unlock(&old_base->lock);
 
-	/* Check, if we got expired work to do */
-	__hrtimer_peek_ahead_timers();
-	local_irq_enable();
-	local_bh_enable();
 	return 0;
 }
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a15dffe60722..d7ca8f97b315 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2438,8 +2438,11 @@ void trace_buffered_event_enable(void)
 	for_each_tracing_cpu(cpu) {
 		page = alloc_pages_node(cpu_to_node(cpu),
 					GFP_KERNEL | __GFP_NORETRY, 0);
-		if (!page)
-			goto failed;
+		/* This is just an optimization and can handle failures */
+		if (!page) {
+			pr_err("Failed to allocate event buffer\n");
+			break;
+		}
 
 		event = page_address(page);
 		memset(event, 0, sizeof(*event));
@@ -2453,10 +2456,6 @@ void trace_buffered_event_enable(void)
 			WARN_ON_ONCE(1);
 		preempt_enable();
 	}
-
-	return;
- failed:
-	trace_buffered_event_disable();
 }
 
 static void enable_trace_buffered_event(void *data)
@@ -2491,11 +2490,9 @@ void trace_buffered_event_disable(void)
 	if (--trace_buffered_event_ref)
 		return;
 
-	preempt_disable();
 	/* For each CPU, set the buffer as used. */
-	smp_call_function_many(tracing_buffer_mask,
-			       disable_trace_buffered_event, NULL, 1);
-	preempt_enable();
+	on_each_cpu_mask(tracing_buffer_mask, disable_trace_buffered_event,
+			 NULL, true);
 
 	/* Wait for all current users to finish */
 	synchronize_rcu();
@@ -2504,17 +2501,19 @@ void trace_buffered_event_disable(void)
 		free_page((unsigned long)per_cpu(trace_buffered_event, cpu));
 		per_cpu(trace_buffered_event, cpu) = NULL;
 	}
+
 	/*
-	 * Make sure trace_buffered_event is NULL before clearing
-	 * trace_buffered_event_cnt.
+	 * Wait for all CPUs that potentially started checking if they can use
+	 * their event buffer only after the previous synchronize_rcu() call and
+	 * they still read a valid pointer from trace_buffered_event. It must be
+	 * ensured they don't see cleared trace_buffered_event_cnt else they
+	 * could wrongly decide to use the pointed-to buffer which is now freed.
 	 */
-	smp_wmb();
+	synchronize_rcu();
 
-	preempt_disable();
-	/* Do the work on each cpu */
-	smp_call_function_many(tracing_buffer_mask,
-			       enable_trace_buffered_event, NULL, 1);
-	preempt_enable();
+	/* For each CPU, relinquish the buffer */
+	on_each_cpu_mask(tracing_buffer_mask, enable_trace_buffered_event, NULL,
+			 true);
 }
 
 static struct ring_buffer *temp_buffer;
@@ -5598,8 +5597,7 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 		return ret;
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-	if (!(tr->flags & TRACE_ARRAY_FL_GLOBAL) ||
-	    !tr->current_trace->use_max_tr)
+	if (!tr->current_trace->use_max_tr)
 		goto out;
 
 	ret = ring_buffer_resize(tr->max_buffer.buffer, size, cpu);
diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index e8e8389ddc96..feb946c954b6 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -180,7 +180,7 @@ static struct sk_buff *reset_per_cpu_data(struct per_cpu_dm_data *data)
 }
 
 static const struct genl_multicast_group dropmon_mcgrps[] = {
-	{ .name = "events", },
+	{ .name = "events", .cap_sys_admin = 1 },
 };
 
 static void send_dm_alert(struct work_struct *work)
@@ -1539,11 +1539,13 @@ static const struct genl_ops dropmon_ops[] = {
 		.cmd = NET_DM_CMD_START,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = net_dm_cmd_trace,
+		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = NET_DM_CMD_STOP,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = net_dm_cmd_trace,
+		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = NET_DM_CMD_CONFIG_GET,
diff --git a/net/core/filter.c b/net/core/filter.c
index d866e1c5970c..3c4dcdc7217e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2219,6 +2219,22 @@ BPF_CALL_2(bpf_msg_cork_bytes, struct sk_msg *, msg, u32, bytes)
 	return 0;
 }
 
+static void sk_msg_reset_curr(struct sk_msg *msg)
+{
+	u32 i = msg->sg.start;
+	u32 len = 0;
+
+	do {
+		len += sk_msg_elem(msg, i)->length;
+		sk_msg_iter_var_next(i);
+		if (len >= msg->sg.size)
+			break;
+	} while (i != msg->sg.end);
+
+	msg->sg.curr = i;
+	msg->sg.copybreak = 0;
+}
+
 static const struct bpf_func_proto bpf_msg_cork_bytes_proto = {
 	.func           = bpf_msg_cork_bytes,
 	.gpl_only       = false,
@@ -2338,6 +2354,7 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
 		      msg->sg.end - shift + NR_MSG_FRAG_IDS :
 		      msg->sg.end - shift;
 out:
+	sk_msg_reset_curr(msg);
 	msg->data = sg_virt(&msg->sg.data[first_sge]) + start - offset;
 	msg->data_end = msg->data + bytes;
 	return 0;
@@ -2471,6 +2488,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 		msg->sg.data[new] = rsge;
 	}
 
+	sk_msg_reset_curr(msg);
 	sk_msg_compute_data_pointers(msg);
 	return 0;
 }
@@ -2642,6 +2660,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 
 	sk_mem_uncharge(msg->sk, len - pop);
 	msg->sg.size -= (len - pop);
+	sk_msg_reset_curr(msg);
 	sk_msg_compute_data_pointers(msg);
 	return 0;
 }
diff --git a/net/core/scm.c b/net/core/scm.c
index 31a38239c92f..5525c14f33f1 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -26,6 +26,7 @@
 #include <linux/nsproxy.h>
 #include <linux/slab.h>
 #include <linux/errqueue.h>
+#include <linux/io_uring.h>
 
 #include <linux/uaccess.h>
 
@@ -103,6 +104,11 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
 
 		if (fd < 0 || !(file = fget_raw(fd)))
 			return -EBADF;
+		/* don't allow io_uring files */
+		if (io_uring_get_socket(file)) {
+			fput(file);
+			return -EINVAL;
+		}
 		*fpp++ = file;
 		fpl->count++;
 	}
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index f8f008344273..db48dec61f30 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -607,15 +607,18 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
 	}
 
 	if (dev->header_ops) {
+		int pull_len = tunnel->hlen + sizeof(struct iphdr);
+
 		if (skb_cow_head(skb, 0))
 			goto free_skb;
 
 		tnl_params = (const struct iphdr *)skb->data;
 
-		/* Pull skb since ip_tunnel_xmit() needs skb->data pointing
-		 * to gre header.
-		 */
-		skb_pull(skb, tunnel->hlen + sizeof(struct iphdr));
+		if (!pskb_network_may_pull(skb, pull_len))
+			goto free_skb;
+
+		/* ip_tunnel_xmit() needs skb->data pointing to gre header. */
+		skb_pull(skb, pull_len);
 		skb_reset_mac_header(skb);
 
 		if (skb->ip_summed == CHECKSUM_PARTIAL &&
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index fe5ef114beba..982fe464156a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3657,8 +3657,12 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	 * then we can probably ignore it.
 	 */
 	if (before(ack, prior_snd_una)) {
+		u32 max_window;
+
+		/* do not accept ACK for bytes we never sent. */
+		max_window = min_t(u64, tp->max_window, tp->bytes_acked);
 		/* RFC 5961 5.2 [Blind Data Injection Attack].[Mitigation] */
-		if (before(ack, prior_snd_una - tp->max_window)) {
+		if (before(ack, prior_snd_una - max_window)) {
 			if (!(flag & FLAG_NO_CHALLENGE_ACK))
 				tcp_send_challenge_ack(sk, skb);
 			return -1;
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index ef55489651f8..d74a825c50f0 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1433,13 +1433,9 @@ int fib6_add(struct fib6_node *root, struct fib6_info *rt,
 			if (!pn_leaf && !(pn->fn_flags & RTN_RTINFO)) {
 				pn_leaf = fib6_find_prefix(info->nl_net, table,
 							   pn);
-#if RT6_DEBUG >= 2
-				if (!pn_leaf) {
-					WARN_ON(!pn_leaf);
+				if (!pn_leaf)
 					pn_leaf =
 					    info->nl_net->ipv6.fib6_null_entry;
-				}
-#endif
 				fib6_info_hold(pn_leaf);
 				rcu_assign_pointer(pn->leaf, pn_leaf);
 			}
diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index d3be0d0b0bda..d4feda487e5e 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -61,6 +61,8 @@ MODULE_ALIAS_NFNL_SUBSYS(NFNL_SUBSYS_IPSET);
 	ip_set_dereference((inst)->ip_set_list)[id]
 #define ip_set_ref_netlink(inst,id)	\
 	rcu_dereference_raw((inst)->ip_set_list)[id]
+#define ip_set_dereference_nfnl(p)	\
+	rcu_dereference_check(p, lockdep_nfnl_is_held(NFNL_SUBSYS_IPSET))
 
 /* The set types are implemented in modules and registered set types
  * can be found in ip_set_type_list. Adding/deleting types is
@@ -556,15 +558,10 @@ __ip_set_put_netlink(struct ip_set *set)
 static inline struct ip_set *
 ip_set_rcu_get(struct net *net, ip_set_id_t index)
 {
-	struct ip_set *set;
 	struct ip_set_net *inst = ip_set_pernet(net);
 
-	rcu_read_lock();
-	/* ip_set_list itself needs to be protected */
-	set = rcu_dereference(inst->ip_set_list)[index];
-	rcu_read_unlock();
-
-	return set;
+	/* ip_set_list and the set pointer need to be protected */
+	return ip_set_dereference_nfnl(inst->ip_set_list)[index];
 }
 
 static inline void
@@ -1255,6 +1252,9 @@ static int ip_set_swap(struct net *net, struct sock *ctnl, struct sk_buff *skb,
 	ip_set(inst, to_id) = from;
 	write_unlock_bh(&ip_set_ref_lock);
 
+	/* Make sure all readers of the old set pointers are completed. */
+	synchronize_rcu();
+
 	return 0;
 }
 
diff --git a/net/netfilter/xt_owner.c b/net/netfilter/xt_owner.c
index e85ce69924ae..50332888c8d2 100644
--- a/net/netfilter/xt_owner.c
+++ b/net/netfilter/xt_owner.c
@@ -76,18 +76,23 @@ owner_mt(const struct sk_buff *skb, struct xt_action_param *par)
 		 */
 		return false;
 
-	filp = sk->sk_socket->file;
-	if (filp == NULL)
+	read_lock_bh(&sk->sk_callback_lock);
+	filp = sk->sk_socket ? sk->sk_socket->file : NULL;
+	if (filp == NULL) {
+		read_unlock_bh(&sk->sk_callback_lock);
 		return ((info->match ^ info->invert) &
 		       (XT_OWNER_UID | XT_OWNER_GID)) == 0;
+	}
 
 	if (info->match & XT_OWNER_UID) {
 		kuid_t uid_min = make_kuid(net->user_ns, info->uid_min);
 		kuid_t uid_max = make_kuid(net->user_ns, info->uid_max);
 		if ((uid_gte(filp->f_cred->fsuid, uid_min) &&
 		     uid_lte(filp->f_cred->fsuid, uid_max)) ^
-		    !(info->invert & XT_OWNER_UID))
+		    !(info->invert & XT_OWNER_UID)) {
+			read_unlock_bh(&sk->sk_callback_lock);
 			return false;
+		}
 	}
 
 	if (info->match & XT_OWNER_GID) {
@@ -112,10 +117,13 @@ owner_mt(const struct sk_buff *skb, struct xt_action_param *par)
 			}
 		}
 
-		if (match ^ !(info->invert & XT_OWNER_GID))
+		if (match ^ !(info->invert & XT_OWNER_GID)) {
+			read_unlock_bh(&sk->sk_callback_lock);
 			return false;
+		}
 	}
 
+	read_unlock_bh(&sk->sk_callback_lock);
 	return true;
 }
 
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 29eabd45b832..3cb27a27b420 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1020,7 +1020,6 @@ static int netlink_bind(struct socket *sock, struct sockaddr *addr,
 			return -EINVAL;
 	}
 
-	netlink_lock_table();
 	if (nlk->netlink_bind && groups) {
 		int group;
 
@@ -1032,13 +1031,14 @@ static int netlink_bind(struct socket *sock, struct sockaddr *addr,
 			if (!err)
 				continue;
 			netlink_undo_bind(group, groups, sk);
-			goto unlock;
+			return err;
 		}
 	}
 
 	/* No need for barriers here as we return to user-space without
 	 * using any of the bound attributes.
 	 */
+	netlink_lock_table();
 	if (!bound) {
 		err = nladdr->nl_pid ?
 			netlink_insert(sk, nladdr->nl_pid) :
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 102b8d6b5612..a03e16e06e29 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -989,11 +989,46 @@ static struct genl_family genl_ctrl __ro_after_init = {
 	.netnsok = true,
 };
 
+static int genl_bind(struct net *net, int group)
+{
+	const struct genl_family *family;
+	unsigned int id;
+	int ret = 0;
+
+	genl_lock_all();
+
+	idr_for_each_entry(&genl_fam_idr, family, id) {
+		const struct genl_multicast_group *grp;
+		int i;
+
+		if (family->n_mcgrps == 0)
+			continue;
+
+		i = group - family->mcgrp_offset;
+		if (i < 0 || i >= family->n_mcgrps)
+			continue;
+
+		grp = &family->mcgrps[i];
+		if ((grp->flags & GENL_UNS_ADMIN_PERM) &&
+		    !ns_capable(net->user_ns, CAP_NET_ADMIN))
+			ret = -EPERM;
+		if (grp->cap_sys_admin &&
+		    !ns_capable(net->user_ns, CAP_SYS_ADMIN))
+			ret = -EPERM;
+
+		break;
+	}
+
+	genl_unlock_all();
+	return ret;
+}
+
 static int __net_init genl_pernet_init(struct net *net)
 {
 	struct netlink_kernel_cfg cfg = {
 		.input		= genl_rcv,
 		.flags		= NL_CFG_F_NONROOT_RECV,
+		.bind		= genl_bind,
 	};
 
 	/* we'll bump the group number right afterwards */
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 0582abf5ab71..600a84a5c582 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -4240,7 +4240,7 @@ static void packet_mm_open(struct vm_area_struct *vma)
 	struct sock *sk = sock->sk;
 
 	if (sk)
-		atomic_inc(&pkt_sk(sk)->mapped);
+		atomic_long_inc(&pkt_sk(sk)->mapped);
 }
 
 static void packet_mm_close(struct vm_area_struct *vma)
@@ -4250,7 +4250,7 @@ static void packet_mm_close(struct vm_area_struct *vma)
 	struct sock *sk = sock->sk;
 
 	if (sk)
-		atomic_dec(&pkt_sk(sk)->mapped);
+		atomic_long_dec(&pkt_sk(sk)->mapped);
 }
 
 static const struct vm_operations_struct packet_mmap_ops = {
@@ -4345,7 +4345,7 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 
 	err = -EBUSY;
 	if (!closing) {
-		if (atomic_read(&po->mapped))
+		if (atomic_long_read(&po->mapped))
 			goto out;
 		if (packet_read_pending(rb))
 			goto out;
@@ -4448,7 +4448,7 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 
 	err = -EBUSY;
 	mutex_lock(&po->pg_vec_lock);
-	if (closing || atomic_read(&po->mapped) == 0) {
+	if (closing || atomic_long_read(&po->mapped) == 0) {
 		err = 0;
 		spin_lock_bh(&rb_queue->lock);
 		swap(rb->pg_vec, pg_vec);
@@ -4466,9 +4466,9 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 		po->prot_hook.func = (po->rx_ring.pg_vec) ?
 						tpacket_rcv : packet_rcv;
 		skb_queue_purge(rb_queue);
-		if (atomic_read(&po->mapped))
-			pr_err("packet_mmap: vma is busy: %d\n",
-			       atomic_read(&po->mapped));
+		if (atomic_long_read(&po->mapped))
+			pr_err("packet_mmap: vma is busy: %ld\n",
+			       atomic_long_read(&po->mapped));
 	}
 	mutex_unlock(&po->pg_vec_lock);
 
@@ -4546,7 +4546,7 @@ static int packet_mmap(struct file *file, struct socket *sock,
 		}
 	}
 
-	atomic_inc(&po->mapped);
+	atomic_long_inc(&po->mapped);
 	vma->vm_ops = &packet_mmap_ops;
 	err = 0;
 
diff --git a/net/packet/internal.h b/net/packet/internal.h
index 2b2b85dadf8e..878fcdca8c25 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -125,7 +125,7 @@ struct packet_sock {
 	__be16			num;
 	struct packet_rollover	*rollover;
 	struct packet_mclist	*mclist;
-	atomic_t		mapped;
+	atomic_long_t		mapped;
 	enum tpacket_versions	tp_version;
 	unsigned int		tp_hdrlen;
 	unsigned int		tp_reserve;
diff --git a/net/psample/psample.c b/net/psample/psample.c
index 6f2fbc6b9eb2..6d29983cbd07 100644
--- a/net/psample/psample.c
+++ b/net/psample/psample.c
@@ -28,7 +28,8 @@ enum psample_nl_multicast_groups {
 
 static const struct genl_multicast_group psample_nl_mcgrps[] = {
 	[PSAMPLE_NL_MCGRP_CONFIG] = { .name = PSAMPLE_NL_MCGRP_CONFIG_NAME },
-	[PSAMPLE_NL_MCGRP_SAMPLE] = { .name = PSAMPLE_NL_MCGRP_SAMPLE_NAME },
+	[PSAMPLE_NL_MCGRP_SAMPLE] = { .name = PSAMPLE_NL_MCGRP_SAMPLE_NAME,
+				      .flags = GENL_UNS_ADMIN_PERM },
 };
 
 static struct genl_family psample_nl_family __ro_after_init;
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index f56eec5ea4c7..342fefe5dba4 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -117,9 +117,9 @@ static long long sym_get_range_val(struct symbol *sym, int base)
 static void sym_validate_range(struct symbol *sym)
 {
 	struct property *prop;
+	struct symbol *range_sym;
 	int base;
 	long long val, val2;
-	char str[64];
 
 	switch (sym->type) {
 	case S_INT:
@@ -135,17 +135,15 @@ static void sym_validate_range(struct symbol *sym)
 	if (!prop)
 		return;
 	val = strtoll(sym->curr.val, NULL, base);
-	val2 = sym_get_range_val(prop->expr->left.sym, base);
+	range_sym = prop->expr->left.sym;
+	val2 = sym_get_range_val(range_sym, base);
 	if (val >= val2) {
-		val2 = sym_get_range_val(prop->expr->right.sym, base);
+		range_sym = prop->expr->right.sym;
+		val2 = sym_get_range_val(range_sym, base);
 		if (val <= val2)
 			return;
 	}
-	if (sym->type == S_INT)
-		sprintf(str, "%lld", val2);
-	else
-		sprintf(str, "0x%llx", val2);
-	sym->curr.val = xstrdup(str);
+	sym->curr.val = range_sym->curr.val;
 }
 
 static void sym_set_changed(struct symbol *sym)
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 3561cdceaadc..9722cf378d31 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -251,6 +251,7 @@ static char *snd_pcm_state_names[] = {
 	STATE(DRAINING),
 	STATE(PAUSED),
 	STATE(SUSPENDED),
+	STATE(DISCONNECTED),
 };
 
 static char *snd_pcm_access_names[] = {
diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index aedfa6b2895b..8df5f3bc6e97 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -3649,12 +3649,12 @@ static int wm_adsp_buffer_populate(struct wm_adsp_compr_buf *buf)
 		ret = wm_adsp_buffer_read(buf, caps->region_defs[i].base_offset,
 					  &region->base_addr);
 		if (ret < 0)
-			return ret;
+			goto err;
 
 		ret = wm_adsp_buffer_read(buf, caps->region_defs[i].size_offset,
 					  &offset);
 		if (ret < 0)
-			return ret;
+			goto err;
 
 		region->cumulative_size = offset;
 
@@ -3665,6 +3665,10 @@ static int wm_adsp_buffer_populate(struct wm_adsp_compr_buf *buf)
 	}
 
 	return 0;
+
+err:
+	kfree(buf->regions);
+	return ret;
 }
 
 static void wm_adsp_buffer_clear(struct wm_adsp_compr_buf *buf)
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index fabe5aeaa351..6f1bbf2ada4c 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -273,6 +273,7 @@ enum {
  *	  { u64		time_enabled; } && PERF_FORMAT_TOTAL_TIME_ENABLED
  *	  { u64		time_running; } && PERF_FORMAT_TOTAL_TIME_RUNNING
  *	  { u64		id;           } && PERF_FORMAT_ID
+ *	  { u64		lost;         } && PERF_FORMAT_LOST
  *	} && !PERF_FORMAT_GROUP
  *
  *	{ u64		nr;
@@ -280,6 +281,7 @@ enum {
  *	  { u64		time_running; } && PERF_FORMAT_TOTAL_TIME_RUNNING
  *	  { u64		value;
  *	    { u64	id;           } && PERF_FORMAT_ID
+ *	    { u64	lost;         } && PERF_FORMAT_LOST
  *	  }		cntr[nr];
  *	} && PERF_FORMAT_GROUP
  * };
@@ -289,8 +291,9 @@ enum perf_event_read_format {
 	PERF_FORMAT_TOTAL_TIME_RUNNING		= 1U << 1,
 	PERF_FORMAT_ID				= 1U << 2,
 	PERF_FORMAT_GROUP			= 1U << 3,
+	PERF_FORMAT_LOST			= 1U << 4,
 
-	PERF_FORMAT_MAX = 1U << 4,		/* non-ABI */
+	PERF_FORMAT_MAX = 1U << 5,		/* non-ABI */
 };
 
 #define PERF_ATTR_SIZE_VER0	64	/* sizeof first published struct */
