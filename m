Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA75811E1B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442057AbjLMTGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442219AbjLMTGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:06:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F972110
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:06:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69F4C433CB;
        Wed, 13 Dec 2023 19:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702494373;
        bh=wGBL34BlGyB8o1A3MZFQHYVZoCdVbOx02dTNtlWKhfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JToxpVe1tYbldTOF4JevYIMCeLIHmbxvdjtt3pyLgoiyQiGsd/7Vy7kwrjL9NKouI
         OzK/jxXrP8z7HEqeWeeH4kMqnHARYpzzI6PmufI722ezhHbWwLXrQeXpb/w8iNdPF0
         nlwe3H3xcb6FX3LgJGKeZzxFusr4s4Sjw9ypzDII=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.19.302
Date:   Wed, 13 Dec 2023 20:05:45 +0100
Message-ID: <2023121345-corny-rockiness-3f12@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2023121345-humorless-acre-4805@gregkh>
References: <2023121345-humorless-acre-4805@gregkh>
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
index 1db751784cf2..acd4be908046 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 301
+SUBLEVEL = 302
 EXTRAVERSION =
 NAME = "People's Front"
 
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index fcd7e4dc949a..b6aac90d1233 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -565,7 +565,7 @@
 				status = "disabled";
 			};
 
-			gpt: gpt@2098000 {
+			gpt: timer@2098000 {
 				compatible = "fsl,imx6q-gpt", "fsl,imx31-gpt";
 				reg = <0x02098000 0x4000>;
 				interrupts = <0 55 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index b00f791471c6..e9f6cffc7eee 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -374,7 +374,7 @@
 				clock-names = "ipg", "per";
 			};
 
-			gpt: gpt@2098000 {
+			gpt: timer@2098000 {
 				compatible = "fsl,imx6sl-gpt";
 				reg = <0x02098000 0x4000>;
 				interrupts = <0 55 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index a0c0e631ebbe..4cabcf32af06 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -468,7 +468,7 @@
 				status = "disabled";
 			};
 
-			gpt: gpt@2098000 {
+			gpt: timer@2098000 {
 				compatible = "fsl,imx6sx-gpt", "fsl,imx6dl-gpt";
 				reg = <0x02098000 0x4000>;
 				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index dcb187995f76..7c3d8acf87be 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -423,7 +423,7 @@
 				status = "disabled";
 			};
 
-			gpt1: gpt@2098000 {
+			gpt1: timer@2098000 {
 				compatible = "fsl,imx6ul-gpt", "fsl,imx6sx-gpt";
 				reg = <0x02098000 0x4000>;
 				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
@@ -696,7 +696,7 @@
 				reg = <0x020e4000 0x4000>;
 			};
 
-			gpt2: gpt@20e8000 {
+			gpt2: timer@20e8000 {
 				compatible = "fsl,imx6ul-gpt", "fsl,imx6sx-gpt";
 				reg = <0x020e8000 0x4000>;
 				interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 8a6d698e253d..36c00fe29f4f 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -439,8 +439,8 @@
 				fsl,input-sel = <&iomuxc>;
 			};
 
-			gpt1: gpt@302d0000 {
-				compatible = "fsl,imx7d-gpt", "fsl,imx6sx-gpt";
+			gpt1: timer@302d0000 {
+				compatible = "fsl,imx7d-gpt", "fsl,imx6dl-gpt";
 				reg = <0x302d0000 0x10000>;
 				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_GPT1_ROOT_CLK>,
@@ -448,8 +448,8 @@
 				clock-names = "ipg", "per";
 			};
 
-			gpt2: gpt@302e0000 {
-				compatible = "fsl,imx7d-gpt", "fsl,imx6sx-gpt";
+			gpt2: timer@302e0000 {
+				compatible = "fsl,imx7d-gpt", "fsl,imx6dl-gpt";
 				reg = <0x302e0000 0x10000>;
 				interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_GPT2_ROOT_CLK>,
@@ -458,8 +458,8 @@
 				status = "disabled";
 			};
 
-			gpt3: gpt@302f0000 {
-				compatible = "fsl,imx7d-gpt", "fsl,imx6sx-gpt";
+			gpt3: timer@302f0000 {
+				compatible = "fsl,imx7d-gpt", "fsl,imx6dl-gpt";
 				reg = <0x302f0000 0x10000>;
 				interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_GPT3_ROOT_CLK>,
@@ -468,8 +468,8 @@
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
index 965a41572283..67cf02c2f2ec 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -513,6 +513,10 @@ static int imx_mmdc_perf_init(struct platform_device *pdev, void __iomem *mmdc_b
 
 	name = devm_kasprintf(&pdev->dev,
 				GFP_KERNEL, "mmdc%d", ret);
+	if (!name) {
+		ret = -ENOMEM;
+		goto pmu_release_id;
+	}
 
 	pmu_mmdc->mmdc_ipg_clk = mmdc_ipg_clk;
 	pmu_mmdc->devtype_data = (struct fsl_mmdc_devtype_data *)of_id->data;
@@ -535,9 +539,10 @@ static int imx_mmdc_perf_init(struct platform_device *pdev, void __iomem *mmdc_b
 
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
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 9f3903089869..758e8e9eee4f 100644
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
index dc41d4d7836e..84667781c41d 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1253,5 +1253,8 @@ static void zenbleed_check_cpu(void *unused)
 
 void amd_check_microcode(void)
 {
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+		return;
+
 	on_each_cpu(zenbleed_check_cpu, NULL, 1);
 }
diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index f1a3353f3494..b13574cdef69 100644
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
@@ -291,13 +366,17 @@ void dev_coredumpm(struct device *dev, struct module *owner,
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
 
@@ -309,12 +388,15 @@ void dev_coredumpm(struct device *dev, struct module *owner,
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
index e0ccc79b239a..7a8dfc36a6c1 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -495,14 +495,17 @@ static ssize_t export_store(struct class *class,
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
index 70e446c2acf8..94b06c918e80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -147,7 +147,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 	}
 
 	for (i = 0; i < p->nchunks; i++) {
-		struct drm_amdgpu_cs_chunk __user **chunk_ptr = NULL;
+		struct drm_amdgpu_cs_chunk __user *chunk_ptr = NULL;
 		struct drm_amdgpu_cs_chunk user_chunk;
 		uint32_t __user *cdata;
 
diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 2f40da04a944..b1e5ad59ec71 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -45,6 +45,7 @@ ACPI_MODULE_NAME(ACPI_POWER_METER_NAME);
 #define POWER_METER_CAN_NOTIFY	(1 << 3)
 #define POWER_METER_IS_BATTERY	(1 << 8)
 #define UNKNOWN_HYSTERESIS	0xFFFFFFFF
+#define UNKNOWN_POWER		0xFFFFFFFF
 
 #define METER_NOTIFY_CONFIG	0x80
 #define METER_NOTIFY_TRIP	0x81
@@ -356,6 +357,9 @@ static ssize_t show_power(struct device *dev,
 	update_meter(resource);
 	mutex_unlock(&resource->lock);
 
+	if (resource->power == UNKNOWN_POWER)
+		return -ENODATA;
+
 	return sprintf(buf, "%llu\n", resource->power * 1000);
 }
 
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index f1b666c80f36..b34e221507f5 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -70,7 +70,7 @@ static char version[] =
 		BNXT_RE_DESC " v" ROCE_DRV_MODULE_VERSION "\n";
 
 MODULE_AUTHOR("Eddie Wai <eddie.wai@broadcom.com>");
-MODULE_DESCRIPTION(BNXT_RE_DESC " Driver");
+MODULE_DESCRIPTION(BNXT_RE_DESC);
 MODULE_LICENSE("Dual BSD/GPL");
 
 /* globals */
diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 60594dad5545..d7b7b77e4d65 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -190,15 +190,15 @@ isert_alloc_rx_descriptors(struct isert_conn *isert_conn)
 	rx_desc = isert_conn->rx_descs;
 
 	for (i = 0; i < ISERT_QP_MAX_RECV_DTOS; i++, rx_desc++)  {
-		dma_addr = ib_dma_map_single(ib_dev, (void *)rx_desc,
-					ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
+		dma_addr = ib_dma_map_single(ib_dev, rx_desc->buf,
+					ISER_RX_SIZE, DMA_FROM_DEVICE);
 		if (ib_dma_mapping_error(ib_dev, dma_addr))
 			goto dma_map_fail;
 
 		rx_desc->dma_addr = dma_addr;
 
 		rx_sg = &rx_desc->rx_sg;
-		rx_sg->addr = rx_desc->dma_addr;
+		rx_sg->addr = rx_desc->dma_addr + isert_get_hdr_offset(rx_desc);
 		rx_sg->length = ISER_RX_PAYLOAD_SIZE;
 		rx_sg->lkey = device->pd->local_dma_lkey;
 		rx_desc->rx_cqe.done = isert_recv_done;
@@ -210,7 +210,7 @@ isert_alloc_rx_descriptors(struct isert_conn *isert_conn)
 	rx_desc = isert_conn->rx_descs;
 	for (j = 0; j < i; j++, rx_desc++) {
 		ib_dma_unmap_single(ib_dev, rx_desc->dma_addr,
-				    ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
+				    ISER_RX_SIZE, DMA_FROM_DEVICE);
 	}
 	kfree(isert_conn->rx_descs);
 	isert_conn->rx_descs = NULL;
@@ -231,7 +231,7 @@ isert_free_rx_descriptors(struct isert_conn *isert_conn)
 	rx_desc = isert_conn->rx_descs;
 	for (i = 0; i < ISERT_QP_MAX_RECV_DTOS; i++, rx_desc++)  {
 		ib_dma_unmap_single(ib_dev, rx_desc->dma_addr,
-				    ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
+				    ISER_RX_SIZE, DMA_FROM_DEVICE);
 	}
 
 	kfree(isert_conn->rx_descs);
@@ -416,10 +416,9 @@ isert_free_login_buf(struct isert_conn *isert_conn)
 			    ISER_RX_PAYLOAD_SIZE, DMA_TO_DEVICE);
 	kfree(isert_conn->login_rsp_buf);
 
-	ib_dma_unmap_single(ib_dev, isert_conn->login_req_dma,
-			    ISER_RX_PAYLOAD_SIZE,
-			    DMA_FROM_DEVICE);
-	kfree(isert_conn->login_req_buf);
+	ib_dma_unmap_single(ib_dev, isert_conn->login_desc->dma_addr,
+			    ISER_RX_SIZE, DMA_FROM_DEVICE);
+	kfree(isert_conn->login_desc);
 }
 
 static int
@@ -428,25 +427,25 @@ isert_alloc_login_buf(struct isert_conn *isert_conn,
 {
 	int ret;
 
-	isert_conn->login_req_buf = kzalloc(sizeof(*isert_conn->login_req_buf),
+	isert_conn->login_desc = kzalloc(sizeof(*isert_conn->login_desc),
 			GFP_KERNEL);
-	if (!isert_conn->login_req_buf)
+	if (!isert_conn->login_desc)
 		return -ENOMEM;
 
-	isert_conn->login_req_dma = ib_dma_map_single(ib_dev,
-				isert_conn->login_req_buf,
-				ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
-	ret = ib_dma_mapping_error(ib_dev, isert_conn->login_req_dma);
+	isert_conn->login_desc->dma_addr = ib_dma_map_single(ib_dev,
+				isert_conn->login_desc->buf,
+				ISER_RX_SIZE, DMA_FROM_DEVICE);
+	ret = ib_dma_mapping_error(ib_dev, isert_conn->login_desc->dma_addr);
 	if (ret) {
-		isert_err("login_req_dma mapping error: %d\n", ret);
-		isert_conn->login_req_dma = 0;
-		goto out_free_login_req_buf;
+		isert_err("login_desc dma mapping error: %d\n", ret);
+		isert_conn->login_desc->dma_addr = 0;
+		goto out_free_login_desc;
 	}
 
 	isert_conn->login_rsp_buf = kzalloc(ISER_RX_PAYLOAD_SIZE, GFP_KERNEL);
 	if (!isert_conn->login_rsp_buf) {
 		ret = -ENOMEM;
-		goto out_unmap_login_req_buf;
+		goto out_unmap_login_desc;
 	}
 
 	isert_conn->login_rsp_dma = ib_dma_map_single(ib_dev,
@@ -463,11 +462,11 @@ isert_alloc_login_buf(struct isert_conn *isert_conn,
 
 out_free_login_rsp_buf:
 	kfree(isert_conn->login_rsp_buf);
-out_unmap_login_req_buf:
-	ib_dma_unmap_single(ib_dev, isert_conn->login_req_dma,
-			    ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
-out_free_login_req_buf:
-	kfree(isert_conn->login_req_buf);
+out_unmap_login_desc:
+	ib_dma_unmap_single(ib_dev, isert_conn->login_desc->dma_addr,
+			    ISER_RX_SIZE, DMA_FROM_DEVICE);
+out_free_login_desc:
+	kfree(isert_conn->login_desc);
 	return ret;
 }
 
@@ -586,7 +585,7 @@ isert_connect_release(struct isert_conn *isert_conn)
 		ib_destroy_qp(isert_conn->qp);
 	}
 
-	if (isert_conn->login_req_buf)
+	if (isert_conn->login_desc)
 		isert_free_login_buf(isert_conn);
 
 	isert_device_put(device);
@@ -976,17 +975,18 @@ isert_login_post_recv(struct isert_conn *isert_conn)
 	int ret;
 
 	memset(&sge, 0, sizeof(struct ib_sge));
-	sge.addr = isert_conn->login_req_dma;
+	sge.addr = isert_conn->login_desc->dma_addr +
+		isert_get_hdr_offset(isert_conn->login_desc);
 	sge.length = ISER_RX_PAYLOAD_SIZE;
 	sge.lkey = isert_conn->device->pd->local_dma_lkey;
 
 	isert_dbg("Setup sge: addr: %llx length: %d 0x%08x\n",
 		sge.addr, sge.length, sge.lkey);
 
-	isert_conn->login_req_buf->rx_cqe.done = isert_login_recv_done;
+	isert_conn->login_desc->rx_cqe.done = isert_login_recv_done;
 
 	memset(&rx_wr, 0, sizeof(struct ib_recv_wr));
-	rx_wr.wr_cqe = &isert_conn->login_req_buf->rx_cqe;
+	rx_wr.wr_cqe = &isert_conn->login_desc->rx_cqe;
 	rx_wr.sg_list = &sge;
 	rx_wr.num_sge = 1;
 
@@ -1063,7 +1063,7 @@ isert_put_login_tx(struct iscsi_conn *conn, struct iscsi_login *login,
 static void
 isert_rx_login_req(struct isert_conn *isert_conn)
 {
-	struct iser_rx_desc *rx_desc = isert_conn->login_req_buf;
+	struct iser_rx_desc *rx_desc = isert_conn->login_desc;
 	int rx_buflen = isert_conn->login_req_len;
 	struct iscsi_conn *conn = isert_conn->conn;
 	struct iscsi_login *login = conn->conn_login;
@@ -1075,7 +1075,7 @@ isert_rx_login_req(struct isert_conn *isert_conn)
 
 	if (login->first_request) {
 		struct iscsi_login_req *login_req =
-			(struct iscsi_login_req *)&rx_desc->iscsi_header;
+			(struct iscsi_login_req *)isert_get_iscsi_hdr(rx_desc);
 		/*
 		 * Setup the initial iscsi_login values from the leading
 		 * login request PDU.
@@ -1094,13 +1094,13 @@ isert_rx_login_req(struct isert_conn *isert_conn)
 		login->tsih		= be16_to_cpu(login_req->tsih);
 	}
 
-	memcpy(&login->req[0], (void *)&rx_desc->iscsi_header, ISCSI_HDR_LEN);
+	memcpy(&login->req[0], isert_get_iscsi_hdr(rx_desc), ISCSI_HDR_LEN);
 
 	size = min(rx_buflen, MAX_KEY_VALUE_PAIRS);
 	isert_dbg("Using login payload size: %d, rx_buflen: %d "
 		  "MAX_KEY_VALUE_PAIRS: %d\n", size, rx_buflen,
 		  MAX_KEY_VALUE_PAIRS);
-	memcpy(login->req_buf, &rx_desc->data[0], size);
+	memcpy(login->req_buf, isert_get_data(rx_desc), size);
 
 	if (login->first_request) {
 		complete(&isert_conn->login_comp);
@@ -1165,14 +1165,15 @@ isert_handle_scsi_cmd(struct isert_conn *isert_conn,
 	if (imm_data_len != data_len) {
 		sg_nents = max(1UL, DIV_ROUND_UP(imm_data_len, PAGE_SIZE));
 		sg_copy_from_buffer(cmd->se_cmd.t_data_sg, sg_nents,
-				    &rx_desc->data[0], imm_data_len);
+				    isert_get_data(rx_desc), imm_data_len);
 		isert_dbg("Copy Immediate sg_nents: %u imm_data_len: %d\n",
 			  sg_nents, imm_data_len);
 	} else {
 		sg_init_table(&isert_cmd->sg, 1);
 		cmd->se_cmd.t_data_sg = &isert_cmd->sg;
 		cmd->se_cmd.t_data_nents = 1;
-		sg_set_buf(&isert_cmd->sg, &rx_desc->data[0], imm_data_len);
+		sg_set_buf(&isert_cmd->sg, isert_get_data(rx_desc),
+				imm_data_len);
 		isert_dbg("Transfer Immediate imm_data_len: %d\n",
 			  imm_data_len);
 	}
@@ -1241,9 +1242,9 @@ isert_handle_iscsi_dataout(struct isert_conn *isert_conn,
 	}
 	isert_dbg("Copying DataOut: sg_start: %p, sg_off: %u "
 		  "sg_nents: %u from %p %u\n", sg_start, sg_off,
-		  sg_nents, &rx_desc->data[0], unsol_data_len);
+		  sg_nents, isert_get_data(rx_desc), unsol_data_len);
 
-	sg_copy_from_buffer(sg_start, sg_nents, &rx_desc->data[0],
+	sg_copy_from_buffer(sg_start, sg_nents, isert_get_data(rx_desc),
 			    unsol_data_len);
 
 	rc = iscsit_check_dataout_payload(cmd, hdr, false);
@@ -1302,7 +1303,7 @@ isert_handle_text_cmd(struct isert_conn *isert_conn, struct isert_cmd *isert_cmd
 	}
 	cmd->text_in_ptr = text_in;
 
-	memcpy(cmd->text_in_ptr, &rx_desc->data[0], payload_length);
+	memcpy(cmd->text_in_ptr, isert_get_data(rx_desc), payload_length);
 
 	return iscsit_process_text_cmd(conn, cmd, hdr);
 }
@@ -1312,7 +1313,7 @@ isert_rx_opcode(struct isert_conn *isert_conn, struct iser_rx_desc *rx_desc,
 		uint32_t read_stag, uint64_t read_va,
 		uint32_t write_stag, uint64_t write_va)
 {
-	struct iscsi_hdr *hdr = &rx_desc->iscsi_header;
+	struct iscsi_hdr *hdr = isert_get_iscsi_hdr(rx_desc);
 	struct iscsi_conn *conn = isert_conn->conn;
 	struct iscsi_cmd *cmd;
 	struct isert_cmd *isert_cmd;
@@ -1410,8 +1411,8 @@ isert_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct isert_conn *isert_conn = wc->qp->qp_context;
 	struct ib_device *ib_dev = isert_conn->cm_id->device;
 	struct iser_rx_desc *rx_desc = cqe_to_rx_desc(wc->wr_cqe);
-	struct iscsi_hdr *hdr = &rx_desc->iscsi_header;
-	struct iser_ctrl *iser_ctrl = &rx_desc->iser_header;
+	struct iscsi_hdr *hdr = isert_get_iscsi_hdr(rx_desc);
+	struct iser_ctrl *iser_ctrl = isert_get_iser_hdr(rx_desc);
 	uint64_t read_va = 0, write_va = 0;
 	uint32_t read_stag = 0, write_stag = 0;
 
@@ -1425,7 +1426,7 @@ isert_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	rx_desc->in_use = true;
 
 	ib_dma_sync_single_for_cpu(ib_dev, rx_desc->dma_addr,
-			ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
+			ISER_RX_SIZE, DMA_FROM_DEVICE);
 
 	isert_dbg("DMA: 0x%llx, iSCSI opcode: 0x%02x, ITT: 0x%08x, flags: 0x%02x dlen: %d\n",
 		 rx_desc->dma_addr, hdr->opcode, hdr->itt, hdr->flags,
@@ -1460,7 +1461,7 @@ isert_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 			read_stag, read_va, write_stag, write_va);
 
 	ib_dma_sync_single_for_device(ib_dev, rx_desc->dma_addr,
-			ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
+			ISER_RX_SIZE, DMA_FROM_DEVICE);
 }
 
 static void
@@ -1474,8 +1475,8 @@ isert_login_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		return;
 	}
 
-	ib_dma_sync_single_for_cpu(ib_dev, isert_conn->login_req_dma,
-			ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
+	ib_dma_sync_single_for_cpu(ib_dev, isert_conn->login_desc->dma_addr,
+			ISER_RX_SIZE, DMA_FROM_DEVICE);
 
 	isert_conn->login_req_len = wc->byte_len - ISER_HEADERS_LEN;
 
@@ -1490,8 +1491,8 @@ isert_login_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	complete(&isert_conn->login_req_comp);
 	mutex_unlock(&isert_conn->mutex);
 
-	ib_dma_sync_single_for_device(ib_dev, isert_conn->login_req_dma,
-				ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
+	ib_dma_sync_single_for_device(ib_dev, isert_conn->login_desc->dma_addr,
+				ISER_RX_SIZE, DMA_FROM_DEVICE);
 }
 
 static void
diff --git a/drivers/infiniband/ulp/isert/ib_isert.h b/drivers/infiniband/ulp/isert/ib_isert.h
index 3b296bac4f60..d267a6d60d87 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.h
+++ b/drivers/infiniband/ulp/isert/ib_isert.h
@@ -59,9 +59,11 @@
 				ISERT_MAX_TX_MISC_PDUS	+ \
 				ISERT_MAX_RX_MISC_PDUS)
 
-#define ISER_RX_PAD_SIZE	(ISCSI_DEF_MAX_RECV_SEG_LEN + 4096 - \
-		(ISER_RX_PAYLOAD_SIZE + sizeof(u64) + sizeof(struct ib_sge) + \
-		 sizeof(struct ib_cqe) + sizeof(bool)))
+/*
+ * RX size is default of 8k plus headers, but data needs to align to
+ * 512 boundary, so use 1024 to have the extra space for alignment.
+ */
+#define ISER_RX_SIZE		(ISCSI_DEF_MAX_RECV_SEG_LEN + 1024)
 
 #define ISCSI_ISER_SG_TABLESIZE		256
 
@@ -80,21 +82,41 @@ enum iser_conn_state {
 };
 
 struct iser_rx_desc {
-	struct iser_ctrl iser_header;
-	struct iscsi_hdr iscsi_header;
-	char		data[ISCSI_DEF_MAX_RECV_SEG_LEN];
+	char		buf[ISER_RX_SIZE];
 	u64		dma_addr;
 	struct ib_sge	rx_sg;
 	struct ib_cqe	rx_cqe;
 	bool		in_use;
-	char		pad[ISER_RX_PAD_SIZE];
-} __packed;
+};
 
 static inline struct iser_rx_desc *cqe_to_rx_desc(struct ib_cqe *cqe)
 {
 	return container_of(cqe, struct iser_rx_desc, rx_cqe);
 }
 
+static void *isert_get_iser_hdr(struct iser_rx_desc *desc)
+{
+	return PTR_ALIGN(desc->buf + ISER_HEADERS_LEN, 512) - ISER_HEADERS_LEN;
+}
+
+static size_t isert_get_hdr_offset(struct iser_rx_desc *desc)
+{
+	return isert_get_iser_hdr(desc) - (void *)desc->buf;
+}
+
+static void *isert_get_iscsi_hdr(struct iser_rx_desc *desc)
+{
+	return isert_get_iser_hdr(desc) + sizeof(struct iser_ctrl);
+}
+
+static void *isert_get_data(struct iser_rx_desc *desc)
+{
+	void *data = isert_get_iser_hdr(desc) + ISER_HEADERS_LEN;
+
+	WARN_ON((uintptr_t)data & 511);
+	return data;
+}
+
 struct iser_tx_desc {
 	struct iser_ctrl iser_header;
 	struct iscsi_hdr iscsi_header;
@@ -141,9 +163,8 @@ struct isert_conn {
 	u32			responder_resources;
 	u32			initiator_depth;
 	bool			pi_support;
-	struct iser_rx_desc	*login_req_buf;
+	struct iser_rx_desc	*login_desc;
 	char			*login_rsp_buf;
-	u64			login_req_dma;
 	int			login_req_len;
 	u64			login_rsp_dma;
 	struct iser_rx_desc	*rx_descs;
diff --git a/drivers/media/platform/davinci/vpif_capture.c b/drivers/media/platform/davinci/vpif_capture.c
index a96f53ce8088..cf1d11e6dd8c 100644
--- a/drivers/media/platform/davinci/vpif_capture.c
+++ b/drivers/media/platform/davinci/vpif_capture.c
@@ -1489,8 +1489,6 @@ static int vpif_probe_complete(void)
 		/* Unregister video device */
 		video_unregister_device(&ch->video_dev);
 	}
-	kfree(vpif_obj.sd);
-	v4l2_device_unregister(&vpif_obj.v4l2_dev);
 
 	return err;
 }
diff --git a/drivers/net/arcnet/arc-rimi.c b/drivers/net/arcnet/arc-rimi.c
index a07e24970be4..3d0ce6d46a24 100644
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
index d09b2b46ab63..c72ad5e2ac5f 100644
--- a/drivers/net/arcnet/arcdevice.h
+++ b/drivers/net/arcnet/arcdevice.h
@@ -191,6 +191,8 @@ do {									\
 #define ARC_IS_5MBIT    1   /* card default speed is 5MBit */
 #define ARC_CAN_10MBIT  2   /* card uses COM20022, supporting 10MBit,
 				 but default is 2.5MBit. */
+#define ARC_HAS_LED     4   /* card has software controlled LEDs */
+#define ARC_HAS_ROTARY  8   /* card has rotary encoder */
 
 /* information needed to define an encapsulation driver */
 struct ArcProto {
@@ -303,6 +305,10 @@ struct arcnet_local {
 
 	int excnak_pending;    /* We just got an excesive nak interrupt */
 
+	/* RESET flag handling */
+	int reset_in_progress;
+	struct work_struct reset_work;
+
 	struct {
 		uint16_t sequence;	/* sequence number (incs with each packet) */
 		__be16 aborted_seq;
@@ -355,7 +361,9 @@ void arcnet_dump_skb(struct net_device *dev, struct sk_buff *skb, char *desc)
 
 void arcnet_unregister_proto(struct ArcProto *proto);
 irqreturn_t arcnet_interrupt(int irq, void *dev_id);
+
 struct net_device *alloc_arcdev(const char *name);
+void free_arcdev(struct net_device *dev);
 
 int arcnet_open(struct net_device *dev);
 int arcnet_close(struct net_device *dev);
diff --git a/drivers/net/arcnet/arcnet.c b/drivers/net/arcnet/arcnet.c
index 2b112d3d8540..c5ff13887a1d 100644
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
+	dev_open(dev);
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
index 38fa60ddaf2e..fada3f23970e 100644
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
index 4e56aaf2b984..e9fc0577ddc0 100644
--- a/drivers/net/arcnet/com90io.c
+++ b/drivers/net/arcnet/com90io.c
@@ -394,7 +394,7 @@ static int __init com90io_init(void)
 	err = com90io_probe(dev);
 
 	if (err) {
-		free_netdev(dev);
+		free_arcdev(dev);
 		return err;
 	}
 
@@ -417,7 +417,7 @@ static void __exit com90io_exit(void)
 
 	free_irq(dev->irq, dev);
 	release_region(dev->base_addr, ARCNET_TOTAL_SIZE);
-	free_netdev(dev);
+	free_arcdev(dev);
 }
 
 module_init(com90io_init)
diff --git a/drivers/net/arcnet/com90xx.c b/drivers/net/arcnet/com90xx.c
index ca4a57c30bf8..5e38a2d6623c 100644
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
index f0b5c8a4d29f..68bb4a2ff7ce 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -6859,7 +6859,7 @@ static int tg3_rx(struct tg3_napi *tnapi, int budget)
 				       desc_idx, *post_ptr);
 		drop_it_no_recycle:
 			/* Other statistics kept track of by card. */
-			tp->rx_dropped++;
+			tnapi->rx_dropped++;
 			goto next_pkt;
 		}
 
@@ -7889,8 +7889,10 @@ static int tg3_tso_bug(struct tg3 *tp, struct tg3_napi *tnapi,
 
 	segs = skb_gso_segment(skb, tp->dev->features &
 				    ~(NETIF_F_TSO | NETIF_F_TSO6));
-	if (IS_ERR(segs) || !segs)
+	if (IS_ERR(segs) || !segs) {
+		tnapi->tx_dropped++;
 		goto tg3_tso_bug_end;
+	}
 
 	do {
 		nskb = segs;
@@ -8163,7 +8165,7 @@ static netdev_tx_t tg3_start_xmit(struct sk_buff *skb, struct net_device *dev)
 drop:
 	dev_kfree_skb_any(skb);
 drop_nofree:
-	tp->tx_dropped++;
+	tnapi->tx_dropped++;
 	return NETDEV_TX_OK;
 }
 
@@ -9342,7 +9344,7 @@ static void __tg3_set_rx_mode(struct net_device *);
 /* tp->lock is held. */
 static int tg3_halt(struct tg3 *tp, int kind, bool silent)
 {
-	int err;
+	int err, i;
 
 	tg3_stop_fw(tp);
 
@@ -9363,6 +9365,13 @@ static int tg3_halt(struct tg3 *tp, int kind, bool silent)
 
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
@@ -11919,6 +11928,9 @@ static void tg3_get_nstats(struct tg3 *tp, struct rtnl_link_stats64 *stats)
 {
 	struct rtnl_link_stats64 *old_stats = &tp->net_stats_prev;
 	struct tg3_hw_stats *hw_stats = tp->hw_stats;
+	unsigned long rx_dropped;
+	unsigned long tx_dropped;
+	int i;
 
 	stats->rx_packets = old_stats->rx_packets +
 		get_stat64(&hw_stats->rx_ucast_packets) +
@@ -11965,8 +11977,26 @@ static void tg3_get_nstats(struct tg3 *tp, struct rtnl_link_stats64 *stats)
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
index a772a33b685c..b8cc8ff4e878 100644
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
index cfdc92de9dc0..d2791bcff5d4 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
@@ -70,6 +70,27 @@ static enum mac_mode hns_get_enet_interface(const struct hns_mac_cb *mac_cb)
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
@@ -87,6 +108,14 @@ void hns_mac_get_link_status(struct hns_mac_cb *mac_cb, u32 *link_status)
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
index 0765d5f61714..386658ce1297 100644
--- a/drivers/net/hyperv/Kconfig
+++ b/drivers/net/hyperv/Kconfig
@@ -2,5 +2,6 @@ config HYPERV_NET
 	tristate "Microsoft Hyper-V virtual network driver"
 	depends on HYPERV
 	select UCS2_STRING
+	select NLS
 	help
 	  Select this option to enable the Hyper-V virtual network driver.
diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index d99ac73a1d89..c34ad5dd62e3 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -2647,6 +2647,8 @@ enum parport_pc_pci_cards {
 	netmos_9865,
 	quatech_sppxp100,
 	wch_ch382l,
+	brainboxes_uc146,
+	brainboxes_px203,
 };
 
 
@@ -2710,6 +2712,8 @@ static struct parport_pc_pci {
 	/* netmos_9865 */               { 1, { { 0, -1 }, } },
 	/* quatech_sppxp100 */		{ 1, { { 0, 1 }, } },
 	/* wch_ch382l */		{ 1, { { 2, -1 }, } },
+	/* brainboxes_uc146 */	{ 1, { { 3, -1 }, } },
+	/* brainboxes_px203 */	{ 1, { { 0, -1 }, } },
 };
 
 static const struct pci_device_id parport_pc_pci_tbl[] = {
@@ -2801,6 +2805,23 @@ static const struct pci_device_id parport_pc_pci_tbl[] = {
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
diff --git a/drivers/scsi/be2iscsi/be_main.c b/drivers/scsi/be2iscsi/be_main.c
index 50e9b4b68357..295eef40e275 100644
--- a/drivers/scsi/be2iscsi/be_main.c
+++ b/drivers/scsi/be2iscsi/be_main.c
@@ -2713,6 +2713,7 @@ static int beiscsi_init_wrb_handle(struct beiscsi_hba *phba)
 		kfree(pwrb_context->pwrb_handle_base);
 		kfree(pwrb_context->pwrb_handle_basestd);
 	}
+	kfree(phwi_ctxt->be_wrbq);
 	return -ENOMEM;
 }
 
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 1ad4b69292ad..0078cb365d8c 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -59,10 +59,12 @@ struct spi_imx_data;
 
 struct spi_imx_devtype_data {
 	void (*intctrl)(struct spi_imx_data *, int);
+	int (*prepare_message)(struct spi_imx_data *, struct spi_message *);
 	int (*config)(struct spi_device *);
 	void (*trigger)(struct spi_imx_data *);
 	int (*rx_available)(struct spi_imx_data *);
 	void (*reset)(struct spi_imx_data *);
+	void (*setup_wml)(struct spi_imx_data *);
 	void (*disable)(struct spi_imx_data *);
 	bool has_dmamode;
 	bool has_slavemode;
@@ -216,7 +218,6 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 			 struct spi_transfer *transfer)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
-	unsigned int bytes_per_word, i;
 
 	if (!master->dma_rx)
 		return false;
@@ -224,14 +225,6 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 	if (spi_imx->slave_mode)
 		return false;
 
-	bytes_per_word = spi_imx_bytes_per_word(transfer->bits_per_word);
-
-	for (i = spi_imx->devtype_data->fifo_size / 2; i > 0; i--) {
-		if (!(transfer->len % (i * bytes_per_word)))
-			break;
-	}
-
-	spi_imx->wml = i;
 	spi_imx->dynamic_burst = 0;
 
 	return true;
@@ -502,11 +495,12 @@ static void mx51_ecspi_disable(struct spi_imx_data *spi_imx)
 	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
 }
 
-static int mx51_ecspi_config(struct spi_device *spi)
+static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
+				      struct spi_message *msg)
 {
-	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
+	struct spi_device *spi = msg->spi;
 	u32 ctrl = MX51_ECSPI_CTRL_ENABLE;
-	u32 clk = spi_imx->speed_hz, delay, reg;
+	u32 testreg;
 	u32 cfg = readl(spi_imx->base + MX51_ECSPI_CONFIG);
 
 	/* set Master or Slave mode */
@@ -521,19 +515,21 @@ static int mx51_ecspi_config(struct spi_device *spi)
 	if (spi->mode & SPI_READY)
 		ctrl |= MX51_ECSPI_CTRL_DRCTL(spi_imx->spi_drctl);
 
-	/* set clock speed */
-	ctrl |= mx51_ecspi_clkdiv(spi_imx, spi_imx->speed_hz, &clk);
-	spi_imx->spi_bus_clk = clk;
-
 	/* set chip select to use */
 	ctrl |= MX51_ECSPI_CTRL_CS(spi->chip_select);
 
-	if (spi_imx->slave_mode && is_imx53_ecspi(spi_imx))
-		ctrl |= (spi_imx->slave_burst * 8 - 1)
-			<< MX51_ECSPI_CTRL_BL_OFFSET;
+	/*
+	 * The ctrl register must be written first, with the EN bit set other
+	 * registers must not be written to.
+	 */
+	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
+
+	testreg = readl(spi_imx->base + MX51_ECSPI_TESTREG);
+	if (spi->mode & SPI_LOOP)
+		testreg |= MX51_ECSPI_TESTREG_LBC;
 	else
-		ctrl |= (spi_imx->bits_per_word - 1)
-			<< MX51_ECSPI_CTRL_BL_OFFSET;
+		testreg &= ~MX51_ECSPI_TESTREG_LBC;
+	writel(testreg, spi_imx->base + MX51_ECSPI_TESTREG);
 
 	/*
 	 * eCSPI burst completion by Chip Select signal in Slave mode
@@ -557,25 +553,42 @@ static int mx51_ecspi_config(struct spi_device *spi)
 		cfg &= ~MX51_ECSPI_CONFIG_SCLKPOL(spi->chip_select);
 		cfg &= ~MX51_ECSPI_CONFIG_SCLKCTL(spi->chip_select);
 	}
+
 	if (spi->mode & SPI_CS_HIGH)
 		cfg |= MX51_ECSPI_CONFIG_SSBPOL(spi->chip_select);
 	else
 		cfg &= ~MX51_ECSPI_CONFIG_SSBPOL(spi->chip_select);
 
-	if (spi_imx->usedma)
-		ctrl |= MX51_ECSPI_CTRL_SMC;
+	writel(cfg, spi_imx->base + MX51_ECSPI_CONFIG);
 
-	/* CTRL register always go first to bring out controller from reset */
-	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
+	return 0;
+}
 
-	reg = readl(spi_imx->base + MX51_ECSPI_TESTREG);
-	if (spi->mode & SPI_LOOP)
-		reg |= MX51_ECSPI_TESTREG_LBC;
+static int mx51_ecspi_config(struct spi_device *spi)
+{
+	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
+	u32 ctrl = readl(spi_imx->base + MX51_ECSPI_CTRL);
+	u32 clk = spi_imx->speed_hz, delay;
+
+	/* Clear BL field and set the right value */
+	ctrl &= ~MX51_ECSPI_CTRL_BL_MASK;
+	if (spi_imx->slave_mode && is_imx53_ecspi(spi_imx))
+		ctrl |= (spi_imx->slave_burst * 8 - 1)
+			<< MX51_ECSPI_CTRL_BL_OFFSET;
 	else
-		reg &= ~MX51_ECSPI_TESTREG_LBC;
-	writel(reg, spi_imx->base + MX51_ECSPI_TESTREG);
+		ctrl |= (spi_imx->bits_per_word - 1)
+			<< MX51_ECSPI_CTRL_BL_OFFSET;
 
-	writel(cfg, spi_imx->base + MX51_ECSPI_CONFIG);
+	/* set clock speed */
+	ctrl &= ~(0xf << MX51_ECSPI_CTRL_POSTDIV_OFFSET |
+		  0xf << MX51_ECSPI_CTRL_PREDIV_OFFSET);
+	ctrl |= mx51_ecspi_clkdiv(spi_imx, spi_imx->speed_hz, &clk);
+	spi_imx->spi_bus_clk = clk;
+
+	if (spi_imx->usedma)
+		ctrl |= MX51_ECSPI_CTRL_SMC;
+
+	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
 
 	/*
 	 * Wait until the changes in the configuration register CONFIGREG
@@ -594,18 +607,20 @@ static int mx51_ecspi_config(struct spi_device *spi)
 	else			/* SCLK is _very_ slow */
 		usleep_range(delay, delay + 10);
 
+	return 0;
+}
+
+static void mx51_setup_wml(struct spi_imx_data *spi_imx)
+{
 	/*
 	 * Configure the DMA register: setup the watermark
 	 * and enable DMA request.
 	 */
-
-	writel(MX51_ECSPI_DMA_RX_WML(spi_imx->wml) |
+	writel(MX51_ECSPI_DMA_RX_WML(spi_imx->wml - 1) |
 		MX51_ECSPI_DMA_TX_WML(spi_imx->wml) |
 		MX51_ECSPI_DMA_RXT_WML(spi_imx->wml) |
 		MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN |
 		MX51_ECSPI_DMA_RXTDEN, spi_imx->base + MX51_ECSPI_DMA);
-
-	return 0;
 }
 
 static int mx51_ecspi_rx_available(struct spi_imx_data *spi_imx)
@@ -672,6 +687,12 @@ static void mx31_trigger(struct spi_imx_data *spi_imx)
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 }
 
+static int mx31_prepare_message(struct spi_imx_data *spi_imx,
+				struct spi_message *msg)
+{
+	return 0;
+}
+
 static int mx31_config(struct spi_device *spi)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
@@ -768,6 +789,12 @@ static void mx21_trigger(struct spi_imx_data *spi_imx)
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 }
 
+static int mx21_prepare_message(struct spi_imx_data *spi_imx,
+				struct spi_message *msg)
+{
+	return 0;
+}
+
 static int mx21_config(struct spi_device *spi)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
@@ -837,6 +864,12 @@ static void mx1_trigger(struct spi_imx_data *spi_imx)
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 }
 
+static int mx1_prepare_message(struct spi_imx_data *spi_imx,
+			       struct spi_message *msg)
+{
+	return 0;
+}
+
 static int mx1_config(struct spi_device *spi)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
@@ -871,6 +904,7 @@ static void mx1_reset(struct spi_imx_data *spi_imx)
 
 static struct spi_imx_devtype_data imx1_cspi_devtype_data = {
 	.intctrl = mx1_intctrl,
+	.prepare_message = mx1_prepare_message,
 	.config = mx1_config,
 	.trigger = mx1_trigger,
 	.rx_available = mx1_rx_available,
@@ -884,6 +918,7 @@ static struct spi_imx_devtype_data imx1_cspi_devtype_data = {
 
 static struct spi_imx_devtype_data imx21_cspi_devtype_data = {
 	.intctrl = mx21_intctrl,
+	.prepare_message = mx21_prepare_message,
 	.config = mx21_config,
 	.trigger = mx21_trigger,
 	.rx_available = mx21_rx_available,
@@ -898,6 +933,7 @@ static struct spi_imx_devtype_data imx21_cspi_devtype_data = {
 static struct spi_imx_devtype_data imx27_cspi_devtype_data = {
 	/* i.mx27 cspi shares the functions with i.mx21 one */
 	.intctrl = mx21_intctrl,
+	.prepare_message = mx21_prepare_message,
 	.config = mx21_config,
 	.trigger = mx21_trigger,
 	.rx_available = mx21_rx_available,
@@ -911,6 +947,7 @@ static struct spi_imx_devtype_data imx27_cspi_devtype_data = {
 
 static struct spi_imx_devtype_data imx31_cspi_devtype_data = {
 	.intctrl = mx31_intctrl,
+	.prepare_message = mx31_prepare_message,
 	.config = mx31_config,
 	.trigger = mx31_trigger,
 	.rx_available = mx31_rx_available,
@@ -925,6 +962,7 @@ static struct spi_imx_devtype_data imx31_cspi_devtype_data = {
 static struct spi_imx_devtype_data imx35_cspi_devtype_data = {
 	/* i.mx35 and later cspi shares the functions with i.mx31 one */
 	.intctrl = mx31_intctrl,
+	.prepare_message = mx31_prepare_message,
 	.config = mx31_config,
 	.trigger = mx31_trigger,
 	.rx_available = mx31_rx_available,
@@ -938,10 +976,12 @@ static struct spi_imx_devtype_data imx35_cspi_devtype_data = {
 
 static struct spi_imx_devtype_data imx51_ecspi_devtype_data = {
 	.intctrl = mx51_ecspi_intctrl,
+	.prepare_message = mx51_ecspi_prepare_message,
 	.config = mx51_ecspi_config,
 	.trigger = mx51_ecspi_trigger,
 	.rx_available = mx51_ecspi_rx_available,
 	.reset = mx51_ecspi_reset,
+	.setup_wml = mx51_setup_wml,
 	.fifo_size = 64,
 	.has_dmamode = true,
 	.dynamic_burst = true,
@@ -952,6 +992,7 @@ static struct spi_imx_devtype_data imx51_ecspi_devtype_data = {
 
 static struct spi_imx_devtype_data imx53_ecspi_devtype_data = {
 	.intctrl = mx51_ecspi_intctrl,
+	.prepare_message = mx51_ecspi_prepare_message,
 	.config = mx51_ecspi_config,
 	.trigger = mx51_ecspi_trigger,
 	.rx_available = mx51_ecspi_rx_available,
@@ -1149,7 +1190,6 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 				 struct spi_transfer *t)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
-	int ret;
 
 	if (!t)
 		return 0;
@@ -1190,12 +1230,6 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	else
 		spi_imx->usedma = 0;
 
-	if (spi_imx->usedma) {
-		ret = spi_imx_dma_configure(spi->master);
-		if (ret)
-			return ret;
-	}
-
 	if (is_imx53_ecspi(spi_imx) && spi_imx->slave_mode) {
 		spi_imx->rx = mx53_ecspi_rx_slave;
 		spi_imx->tx = mx53_ecspi_tx_slave;
@@ -1300,6 +1334,31 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	unsigned long timeout;
 	struct spi_master *master = spi_imx->bitbang.master;
 	struct sg_table *tx = &transfer->tx_sg, *rx = &transfer->rx_sg;
+	struct scatterlist *last_sg = sg_last(rx->sgl, rx->nents);
+	unsigned int bytes_per_word, i;
+	int ret;
+
+	/* Get the right burst length from the last sg to ensure no tail data */
+	bytes_per_word = spi_imx_bytes_per_word(transfer->bits_per_word);
+	for (i = spi_imx->devtype_data->fifo_size / 2; i > 0; i--) {
+		if (!(sg_dma_len(last_sg) % (i * bytes_per_word)))
+			break;
+	}
+	/* Use 1 as wml in case no available burst length got */
+	if (i == 0)
+		i = 1;
+
+	spi_imx->wml =  i;
+
+	ret = spi_imx_dma_configure(master);
+	if (ret)
+		return ret;
+
+	if (!spi_imx->devtype_data->setup_wml) {
+		dev_err(spi_imx->dev, "No setup_wml()?\n");
+		return -EINVAL;
+	}
+	spi_imx->devtype_data->setup_wml(spi_imx);
 
 	/*
 	 * The TX DMA setup starts the transfer, so make sure RX is configured
@@ -1486,7 +1545,13 @@ spi_imx_prepare_message(struct spi_master *master, struct spi_message *msg)
 		return ret;
 	}
 
-	return 0;
+	ret = spi_imx->devtype_data->prepare_message(spi_imx, msg);
+	if (ret) {
+		clk_disable(spi_imx->clk_ipg);
+		clk_disable(spi_imx->clk_per);
+	}
+
+	return ret;
 }
 
 static int
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
 
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index d4496a44abdf..c65f9194abb0 100644
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
index ea877cba0763..b18d44f04e37 100644
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
index 2ede329ce594..e789f4a7553a 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -192,7 +192,7 @@ static void typec_altmode_put_partner(struct altmode *altmode)
 	if (!partner)
 		return;
 
-	adev = &partner->adev;
+	adev = &altmode->adev;
 
 	if (is_typec_plug(adev->dev.parent)) {
 		struct typec_plug *plug = to_typec_plug(adev->dev.parent);
@@ -459,7 +459,8 @@ static void typec_altmode_release(struct device *dev)
 {
 	struct altmode *alt = to_altmode(to_typec_altmode(dev));
 
-	typec_altmode_put_partner(alt);
+	if (!is_typec_port(dev->parent))
+		typec_altmode_put_partner(alt);
 
 	altmode_id_remove(alt->adev.dev.parent, alt->id);
 	kfree(alt);
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
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 71a0a5ffdbb1..dd9f035be63f 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -139,6 +139,7 @@ enum cpuhp_state {
 	CPUHP_AP_ARM_CORESIGHT_STARTING,
 	CPUHP_AP_ARM64_ISNDEP_STARTING,
 	CPUHP_AP_SMPCFD_DYING,
+	CPUHP_AP_HRTIMERS_DYING,
 	CPUHP_AP_X86_TBOOT_DYING,
 	CPUHP_AP_ARM_CACHE_B15_RAC_DYING,
 	CPUHP_AP_ONLINE,
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 542b4fa2cda9..3bdaa92a2cab 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -508,9 +508,9 @@ extern void sysrq_timer_list_show(void);
 
 int hrtimers_prepare_cpu(unsigned int cpu);
 #ifdef CONFIG_HOTPLUG_CPU
-int hrtimers_dead_cpu(unsigned int cpu);
+int hrtimers_cpu_dying(unsigned int cpu);
 #else
-#define hrtimers_dead_cpu	NULL
+#define hrtimers_cpu_dying	NULL
 #endif
 
 #endif
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d46eeddeb859..123e4d715c98 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -685,6 +685,8 @@ struct perf_event {
 	struct pid_namespace		*ns;
 	u64				id;
 
+	atomic64_t			lost_samples;
+
 	u64				(*clock)(void);
 	perf_overflow_handler_t		overflow_handler;
 	void				*overflow_handler_context;
diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index 3e3a1a38884a..b8b7edcfc893 100644
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
diff --git a/include/uapi/linux/netfilter/xt_owner.h b/include/uapi/linux/netfilter/xt_owner.h
index fa3ad84957d5..9e98c09eda32 100644
--- a/include/uapi/linux/netfilter/xt_owner.h
+++ b/include/uapi/linux/netfilter/xt_owner.h
@@ -5,9 +5,10 @@
 #include <linux/types.h>
 
 enum {
-	XT_OWNER_UID    = 1 << 0,
-	XT_OWNER_GID    = 1 << 1,
-	XT_OWNER_SOCKET = 1 << 2,
+	XT_OWNER_UID          = 1 << 0,
+	XT_OWNER_GID          = 1 << 1,
+	XT_OWNER_SOCKET       = 1 << 2,
+	XT_OWNER_SUPPL_GROUPS = 1 << 3,
 };
 
 struct xt_owner_match_info {
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 5fb4cdf37100..140024b2db38 100644
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
index c9ca190ec034..34c09c3d37bc 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1418,7 +1418,7 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 	[CPUHP_HRTIMERS_PREPARE] = {
 		.name			= "hrtimers:prepare",
 		.startup.single		= hrtimers_prepare_cpu,
-		.teardown.single	= hrtimers_dead_cpu,
+		.teardown.single	= NULL,
 	},
 	[CPUHP_SMPCFD_PREPARE] = {
 		.name			= "smpcfd:prepare",
@@ -1485,6 +1485,12 @@ static struct cpuhp_step cpuhp_hp_states[] = {
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
index 3c8eb5d84214..4182e265176d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1710,28 +1710,34 @@ static inline void perf_event__state_init(struct perf_event *event)
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
@@ -1772,8 +1778,9 @@ static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
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
 
@@ -1804,24 +1811,35 @@ static void perf_event__id_header_size(struct perf_event *event)
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
 
@@ -4816,11 +4834,15 @@ static int __perf_read_group_add(struct perf_event *leader,
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
@@ -4874,7 +4896,7 @@ static int perf_read_one(struct perf_event *event,
 				 u64 read_format, char __user *buf)
 {
 	u64 enabled, running;
-	u64 values[4];
+	u64 values[5];
 	int n = 0;
 
 	values[n++] = __perf_event_read_value(event, &enabled, &running);
@@ -4884,6 +4906,8 @@ static int perf_read_one(struct perf_event *event,
 		values[n++] = running;
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(event);
+	if (read_format & PERF_FORMAT_LOST)
+		values[n++] = atomic64_read(&event->lost_samples);
 
 	if (copy_to_user(buf, values, n * sizeof(u64)))
 		return -EFAULT;
@@ -6193,7 +6217,7 @@ static void perf_output_read_one(struct perf_output_handle *handle,
 				 u64 enabled, u64 running)
 {
 	u64 read_format = event->attr.read_format;
-	u64 values[4];
+	u64 values[5];
 	int n = 0;
 
 	values[n++] = perf_event_count(event);
@@ -6207,6 +6231,8 @@ static void perf_output_read_one(struct perf_output_handle *handle,
 	}
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(event);
+	if (read_format & PERF_FORMAT_LOST)
+		values[n++] = atomic64_read(&event->lost_samples);
 
 	__output_copy(handle, values, n * sizeof(u64));
 }
@@ -6217,7 +6243,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 {
 	struct perf_event *leader = event->group_leader, *sub;
 	u64 read_format = event->attr.read_format;
-	u64 values[5];
+	u64 values[6];
 	int n = 0;
 
 	values[n++] = 1 + leader->nr_siblings;
@@ -6235,6 +6261,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 	values[n++] = perf_event_count(leader);
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(leader);
+	if (read_format & PERF_FORMAT_LOST)
+		values[n++] = atomic64_read(&leader->lost_samples);
 
 	__output_copy(handle, values, n * sizeof(u64));
 
@@ -6248,6 +6276,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 		values[n++] = perf_event_count(sub);
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
+		if (read_format & PERF_FORMAT_LOST)
+			values[n++] = atomic64_read(&sub->lost_samples);
 
 		__output_copy(handle, values, n * sizeof(u64));
 	}
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 2f6f77658eba..ddcbd03eccbb 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -165,8 +165,10 @@ __perf_output_begin(struct perf_output_handle *handle,
 		goto out;
 
 	if (unlikely(rb->paused)) {
-		if (rb->nr_pages)
+		if (rb->nr_pages) {
 			local_inc(&rb->lost);
+			atomic64_inc(&event->lost_samples);
+		}
 		goto out;
 	}
 
@@ -249,6 +251,7 @@ __perf_output_begin(struct perf_output_handle *handle,
 
 fail:
 	local_inc(&rb->lost);
+	atomic64_inc(&event->lost_samples);
 	perf_output_put_handle(handle);
 out:
 	rcu_read_unlock();
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 8512f06f0ebe..bf74f43e42af 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1922,29 +1922,22 @@ static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
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
@@ -1955,15 +1948,13 @@ int hrtimers_dead_cpu(unsigned int scpu)
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
index f44c8f1fd3ec..b43d681b072f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2209,8 +2209,11 @@ void trace_buffered_event_enable(void)
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
@@ -2224,10 +2227,6 @@ void trace_buffered_event_enable(void)
 			WARN_ON_ONCE(1);
 		preempt_enable();
 	}
-
-	return;
- failed:
-	trace_buffered_event_disable();
 }
 
 static void enable_trace_buffered_event(void *data)
@@ -2262,11 +2261,9 @@ void trace_buffered_event_disable(void)
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
 	synchronize_sched();
@@ -2275,17 +2272,19 @@ void trace_buffered_event_disable(void)
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
@@ -5259,8 +5258,7 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 		return ret;
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-	if (!(tr->flags & TRACE_ARRAY_FL_GLOBAL) ||
-	    !tr->current_trace->use_max_tr)
+	if (!tr->current_trace->use_max_tr)
 		goto out;
 
 	ret = ring_buffer_resize(tr->max_buffer.buffer, size, cpu);
diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index 2ed600012640..52e559252a9e 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -122,7 +122,7 @@ static struct sk_buff *reset_per_cpu_data(struct per_cpu_dm_data *data)
 }
 
 static const struct genl_multicast_group dropmon_mcgrps[] = {
-	{ .name = "events", },
+	{ .name = "events", .cap_sys_admin = 1 },
 };
 
 static void send_dm_alert(struct work_struct *work)
@@ -370,10 +370,12 @@ static const struct genl_ops dropmon_ops[] = {
 	{
 		.cmd = NET_DM_CMD_START,
 		.doit = net_dm_cmd_trace,
+		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = NET_DM_CMD_STOP,
 		.doit = net_dm_cmd_trace,
+		.flags = GENL_ADMIN_PERM,
 	},
 };
 
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index e16373640f4c..38c8db78cda1 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -683,15 +683,18 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
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
index 0052a6194cc1..407ad07dc598 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3640,8 +3640,12 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
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
index 5ff67cb8b6ac..92bc56028b8b 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1351,13 +1351,9 @@ int fib6_add(struct fib6_node *root, struct fib6_info *rt,
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
index 31756d1bf83e..031bb83aed70 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -64,6 +64,8 @@ MODULE_ALIAS_NFNL_SUBSYS(NFNL_SUBSYS_IPSET);
 	ip_set_dereference((inst)->ip_set_list)[id]
 #define ip_set_ref_netlink(inst,id)	\
 	rcu_dereference_raw((inst)->ip_set_list)[id]
+#define ip_set_dereference_nfnl(p)	\
+	rcu_dereference_check(p, lockdep_nfnl_is_held(NFNL_SUBSYS_IPSET))
 
 /* The set types are implemented in modules and registered set types
  * can be found in ip_set_type_list. Adding/deleting types is
@@ -552,15 +554,10 @@ __ip_set_put_netlink(struct ip_set *set)
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
 
 int
@@ -1227,6 +1224,9 @@ static int ip_set_swap(struct net *net, struct sock *ctnl, struct sk_buff *skb,
 	ip_set(inst, to_id) = from;
 	write_unlock_bh(&ip_set_ref_lock);
 
+	/* Make sure all readers of the old set pointers are completed. */
+	synchronize_rcu();
+
 	return 0;
 }
 
diff --git a/net/netfilter/xt_owner.c b/net/netfilter/xt_owner.c
index 46686fb73784..0c101b25cacf 100644
--- a/net/netfilter/xt_owner.c
+++ b/net/netfilter/xt_owner.c
@@ -76,29 +76,54 @@ owner_mt(const struct sk_buff *skb, struct xt_action_param *par)
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
+		unsigned int i, match = false;
 		kgid_t gid_min = make_kgid(net->user_ns, info->gid_min);
 		kgid_t gid_max = make_kgid(net->user_ns, info->gid_max);
-		if ((gid_gte(filp->f_cred->fsgid, gid_min) &&
-		     gid_lte(filp->f_cred->fsgid, gid_max)) ^
-		    !(info->invert & XT_OWNER_GID))
+		struct group_info *gi = filp->f_cred->group_info;
+
+		if (gid_gte(filp->f_cred->fsgid, gid_min) &&
+		    gid_lte(filp->f_cred->fsgid, gid_max))
+			match = true;
+
+		if (!match && (info->match & XT_OWNER_SUPPL_GROUPS) && gi) {
+			for (i = 0; i < gi->ngroups; ++i) {
+				kgid_t group = gi->gid[i];
+
+				if (gid_gte(group, gid_min) &&
+				    gid_lte(group, gid_max)) {
+					match = true;
+					break;
+				}
+			}
+		}
+
+		if (match ^ !(info->invert & XT_OWNER_GID)) {
+			read_unlock_bh(&sk->sk_callback_lock);
 			return false;
+		}
 	}
 
+	read_unlock_bh(&sk->sk_callback_lock);
 	return true;
 }
 
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 35ecaa93f213..e91489b3274c 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1030,7 +1030,6 @@ static int netlink_bind(struct socket *sock, struct sockaddr *addr,
 			return -EINVAL;
 	}
 
-	netlink_lock_table();
 	if (nlk->netlink_bind && groups) {
 		int group;
 
@@ -1042,13 +1041,14 @@ static int netlink_bind(struct socket *sock, struct sockaddr *addr,
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
index ede73ecfb1f5..f449be93b375 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -961,11 +961,46 @@ static struct genl_family genl_ctrl __ro_after_init = {
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
index 39ddfbda804e..377832981178 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -4214,7 +4214,7 @@ static void packet_mm_open(struct vm_area_struct *vma)
 	struct sock *sk = sock->sk;
 
 	if (sk)
-		atomic_inc(&pkt_sk(sk)->mapped);
+		atomic_long_inc(&pkt_sk(sk)->mapped);
 }
 
 static void packet_mm_close(struct vm_area_struct *vma)
@@ -4224,7 +4224,7 @@ static void packet_mm_close(struct vm_area_struct *vma)
 	struct sock *sk = sock->sk;
 
 	if (sk)
-		atomic_dec(&pkt_sk(sk)->mapped);
+		atomic_long_dec(&pkt_sk(sk)->mapped);
 }
 
 static const struct vm_operations_struct packet_mmap_ops = {
@@ -4319,7 +4319,7 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 
 	err = -EBUSY;
 	if (!closing) {
-		if (atomic_read(&po->mapped))
+		if (atomic_long_read(&po->mapped))
 			goto out;
 		if (packet_read_pending(rb))
 			goto out;
@@ -4422,7 +4422,7 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 
 	err = -EBUSY;
 	mutex_lock(&po->pg_vec_lock);
-	if (closing || atomic_read(&po->mapped) == 0) {
+	if (closing || atomic_long_read(&po->mapped) == 0) {
 		err = 0;
 		spin_lock_bh(&rb_queue->lock);
 		swap(rb->pg_vec, pg_vec);
@@ -4440,9 +4440,9 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
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
 
@@ -4520,7 +4520,7 @@ static int packet_mmap(struct file *file, struct socket *sock,
 		}
 	}
 
-	atomic_inc(&po->mapped);
+	atomic_long_inc(&po->mapped);
 	vma->vm_ops = &packet_mmap_ops;
 	err = 0;
 
diff --git a/net/packet/internal.h b/net/packet/internal.h
index 3d871cae85b8..7f2d5eed5e00 100644
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
index 30e8239bd774..196fbf674dc1 100644
--- a/net/psample/psample.c
+++ b/net/psample/psample.c
@@ -31,7 +31,8 @@ enum psample_nl_multicast_groups {
 
 static const struct genl_multicast_group psample_nl_mcgrps[] = {
 	[PSAMPLE_NL_MCGRP_CONFIG] = { .name = PSAMPLE_NL_MCGRP_CONFIG_NAME },
-	[PSAMPLE_NL_MCGRP_SAMPLE] = { .name = PSAMPLE_NL_MCGRP_SAMPLE_NAME },
+	[PSAMPLE_NL_MCGRP_SAMPLE] = { .name = PSAMPLE_NL_MCGRP_SAMPLE_NAME,
+				      .flags = GENL_UNS_ADMIN_PERM },
 };
 
 static struct genl_family psample_nl_family __ro_after_init;
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 703b9b899ee9..5adb60b7e12f 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -119,9 +119,9 @@ static long long sym_get_range_val(struct symbol *sym, int base)
 static void sym_validate_range(struct symbol *sym)
 {
 	struct property *prop;
+	struct symbol *range_sym;
 	int base;
 	long long val, val2;
-	char str[64];
 
 	switch (sym->type) {
 	case S_INT:
@@ -137,17 +137,15 @@ static void sym_validate_range(struct symbol *sym)
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
index 8eed6244b832..601f60bb2e8a 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -266,6 +266,7 @@ static char *snd_pcm_state_names[] = {
 	STATE(DRAINING),
 	STATE(PAUSED),
 	STATE(SUSPENDED),
+	STATE(DISCONNECTED),
 };
 
 static char *snd_pcm_access_names[] = {
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index a45e7b4f0316..3e3c303bdda5 100644
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
