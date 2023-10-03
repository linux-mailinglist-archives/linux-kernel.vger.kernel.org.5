Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15977B67FA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240507AbjJCLeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240481AbjJCLeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:34:05 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0827AC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 04:33:59 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8Cx2eol_BtlDM0uAA--.18989S3;
        Tue, 03 Oct 2023 19:33:57 +0800 (CST)
Received: from openarena.loongson.cn (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx7y8k_Btl7JAXAA--.48472S2;
        Tue, 03 Oct 2023 19:33:56 +0800 (CST)
From:   Sui Jingfeng <suijingfeng@loongson.cn>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 0/5] drm/etnaviv: Add pci device driver wrapper
Date:   Tue,  3 Oct 2023 19:33:51 +0800
Message-Id: <20231003113356.645394-1-suijingfeng@loongson.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx7y8k_Btl7JAXAA--.48472S2
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Aw47ZF4kKF4rXw4rtFW3XFc_yoW8KryDpF
        4fGFyYyrykurW2gw13JFs5JFy3Gw1xWFyF93srt3s09w45Ar1Utr1qkan8Ar98Jr4fGr1I
        qr1akry7WF1UArXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
        02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
        wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
        AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
        r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
        IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU25EfUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is add PCI device driver wrapper, to support the Vivante GC1000
GPU in LS2K1000 and LS7A1000.

The whole serie have been tested on LS3A5000+LS7A1000 board, with another
trivial patchset [1] applied beforehand.

[1] https://patchwork.freedesktop.org/series/119825/

v6:
	* Fix build issue on system without CONFIG_PCI enabled
v7:
	* Add a separate patch for the platform driver rearrangement (Bjorn)
	* Switch to runtime check if the GPU is dma coherent or not (Lucas)
	* Add ETNAVIV_PARAM_GPU_COHERENT to allow userspace to query (Lucas)
	* Remove etnaviv_gpu.no_clk member (Lucas)
	* Various Typos and coding style fixed (Bjorn)
v8:
	* Fix typos and remove unnecessary header included (Bjorn).
	* Add a dedicated function to create the virtual master platform
	  device.
v9:
	* Use PCI_VDEVICE() macro (Bjorn)
	* Add trivial stubs for the PCI driver (Bjorn)
	* Remove a redundant dev_err() usage (Bjorn)
	* Clean up etnaviv_pdev_probe() with etnaviv_of_first_available_node()
v10:
	* Add one more cleanup patch
	* Resolve the conflict with a patch from Rob
	* Make the dummy PCI stub inlined
	* Print only if the platform is dma-coherrent
V11:
	* Drop unnecessary changes (Lucas)
	* Tweak according to other reviews of v10.

Sui Jingfeng (5):
  drm/etnaviv: Add a dedicated function to get various clocks
  drm/etnaviv: Add constructor and destructor function for
    etnaviv_drm_private
  drm/etnaviv: Allow bypass component framework
  drm/etnaviv: Add driver support for the PCI devices
  drm/etnaviv: Add support for cached coherent caching mode

 drivers/gpu/drm/etnaviv/Kconfig           |   8 ++
 drivers/gpu/drm/etnaviv/Makefile          |   2 +
 drivers/gpu/drm/etnaviv/etnaviv_drv.c     | 131 ++++++++++++++-------
 drivers/gpu/drm/etnaviv/etnaviv_drv.h     |  12 ++
 drivers/gpu/drm/etnaviv/etnaviv_gem.c     |  16 ++-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c     | 134 ++++++++++++++--------
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h     |   7 ++
 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c |  74 ++++++++++++
 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.h |  18 +++
 include/uapi/drm/etnaviv_drm.h            |   1 +
 10 files changed, 314 insertions(+), 89 deletions(-)
 create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c
 create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.h

-- 
2.34.1

