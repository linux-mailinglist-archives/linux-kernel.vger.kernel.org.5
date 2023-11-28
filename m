Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6943C7FC433
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 20:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376312AbjK1TW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 14:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346389AbjK1TW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 14:22:28 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071F1172E;
        Tue, 28 Nov 2023 11:22:27 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3330bd1e9ecso245005f8f.0;
        Tue, 28 Nov 2023 11:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701199345; x=1701804145; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:newsgroups:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GGEd1LKPk1taRXyHn/u5FYCm8ct3CDj6xi+RPFwfC8M=;
        b=njcWyGBZfSdqZafeIDRc5S04r3inNgqf9a3je7qEaSdmM8ypWVBkQ69RJIdZ129Y+D
         2yN0JNL7bxw2/1DTqL8qSi7dmjSicwDiQ/7ntvF1h2z0MSdpxTZTHlpYz9fnNkq+Z75H
         G2zA/vyUgAfLWcWzyQLi9WcyoPexwhirLrSnm0/zSyZrd2HFn440rbVmhF8drMPhDpjN
         iy8OIvzalQ50ta6Tai69iPNwPIgYy1UeQ2/q89j5cG/Ci8A5NOtnY9Ju0G87uTxDVXPb
         Lz7uEDPtvY5zeY/OxYzGIF0d9Bbl9HCMyn9ibJ/Cu9nggmQnHKpjb7Z/9If2158yJUvF
         4lMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701199345; x=1701804145;
        h=in-reply-to:from:content-language:references:newsgroups:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GGEd1LKPk1taRXyHn/u5FYCm8ct3CDj6xi+RPFwfC8M=;
        b=s1WGOknVv+0SwEDWQ8jVo0omAwezLBJVGOT68p8T+P1CeORafkRn917lwrOdeMHpfY
         PEB9Bfj9LqVIKjNVicOsErmVEJ5NtU/XQNqfE3Be7AkAYQZDn6ERuExzHxTtlSLJhU4v
         VB62/PHCQ91xnxeIlqbCHV5gDhXgLIOcQP/iRx2NT5BJEjxfWAmqiVnu+kviqBnfsyAK
         bU+7UM22wBQU+p0jsVeI2LBt+GBO3MCx/uD3jaXr18EsDLtw0cfL0hOssloK/bIhZSyN
         RRnY4AwzjkTdluiujIX5D710bcpJ4M00NxCvqVwIbLiK6zEtV50j3TT7UOSd/pJaZdeD
         G3kw==
X-Gm-Message-State: AOJu0YyXSeNPindbATkStaRMAEEQFm5UyisiQX2mlRVUD+5ViQsqK7ac
        HO26CHuA4gnWot2CanX+mCw=
X-Google-Smtp-Source: AGHT+IEdIrZ145mJfGyp77hmbM7CGlW7bJsfd+7e9NRJLuUbHv9/zD7o78wE21k16o9i0l6fpZq+uQ==
X-Received: by 2002:adf:a10f:0:b0:333:db:dc20 with SMTP id o15-20020adfa10f000000b0033300dbdc20mr5277166wro.4.1701199344736;
        Tue, 28 Nov 2023 11:22:24 -0800 (PST)
Received: from ?IPV6:2a02:2788:416:318:a650:c5d8:5f59:d6? ([2a02:2788:416:318:a650:c5d8:5f59:d6])
        by smtp.gmail.com with ESMTPSA id t5-20020a5d49c5000000b00327b5ca093dsm15718571wrs.117.2023.11.28.11.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 11:22:24 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------qYcSrBBHm10BmvZ01XJ97mIE"
Message-ID: <7f07bb2d-bb00-4774-8cc0-d66b7210380c@gmail.com>
Date:   Tue, 28 Nov 2023 20:22:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.1.64
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz
Newsgroups: gmane.linux.kernel.stable,gmane.linux.kernel
References: <2023112826-glitter-onion-8533@gregkh>
Content-Language: fr-FR
From:   =?UTF-8?Q?Fran=C3=A7ois_Valenduc?= <francoisvalenduc@gmail.com>
In-Reply-To: <2023112826-glitter-onion-8533@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------qYcSrBBHm10BmvZ01XJ97mIE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Build fails on my baremetal server on scaleway:

In file included from arch/x86/kvm/vmx/vmx.c:54:
arch/x86/kvm/vmx/evmcs.h:215:20: note: previous definition of 
‘evmptr_is_valid’ with type ‘bool(u64)’ {aka ‘_Bool(long long unsigned 
int)’}
   215 | static inline bool evmptr_is_valid(u64 evmptr)
       |                    ^~~~~~~~~~~~~~~
In file included from arch/x86/kvm/vmx/vmx.c:55:
arch/x86/kvm/vmx/hyperv.h:184:6: error: redeclaration of ‘enum 
nested_evmptrld_status’
   184 | enum nested_evmptrld_status {
       |      ^~~~~~~~~~~~~~~~~~~~~~
In file included from arch/x86/kvm/vmx/vmx.c:54:
arch/x86/kvm/vmx/evmcs.h:220:6: note: originally defined here
   220 | enum nested_evmptrld_status {
       |      ^~~~~~~~~~~~~~~~~~~~~~
In file included from arch/x86/kvm/vmx/vmx.c:55:
arch/x86/kvm/vmx/hyperv.h:185:9: error: redeclaration of enumerator 
‘EVMPTRLD_DISABLED’
   185 |         EVMPTRLD_DISABLED,
       |         ^~~~~~~~~~~~~~~~~
In file included from arch/x86/kvm/vmx/vmx.c:54:
arch/x86/kvm/vmx/evmcs.h:221:9: note: previous definition of 
‘EVMPTRLD_DISABLED’ with type ‘enum nested_evmptrld_status’
   221 |         EVMPTRLD_DISABLED,
       |         ^~~~~~~~~~~~~~~~~
In file included from arch/x86/kvm/vmx/vmx.c:55:
arch/x86/kvm/vmx/hyperv.h:186:9: error: redeclaration of enumerator 
‘EVMPTRLD_SUCCEEDED’
   186 |         EVMPTRLD_SUCCEEDED,
       |         ^~~~~~~~~~~~~~~~~~
In file included from arch/x86/kvm/vmx/vmx.c:54:
arch/x86/kvm/vmx/evmcs.h:222:9: note: previous definition of 
‘EVMPTRLD_SUCCEEDED’ with type ‘enum nested_evmptrld_status’
   222 |         EVMPTRLD_SUCCEEDED,
       |         ^~~~~~~~~~~~~~~~~~
In file included from arch/x86/kvm/vmx/vmx.c:55:
arch/x86/kvm/vmx/hyperv.h:187:9: error: redeclaration of enumerator 
‘EVMPTRLD_VMFAIL’
   187 |         EVMPTRLD_VMFAIL,
       |         ^~~~~~~~~~~~~~~
In file included from arch/x86/kvm/vmx/vmx.c:54:
arch/x86/kvm/vmx/evmcs.h:223:9: note: previous definition of 
‘EVMPTRLD_VMFAIL’ with type ‘enum nested_evmptrld_status’
   223 |         EVMPTRLD_VMFAIL,
       |         ^~~~~~~~~~~~~~~
In file included from arch/x86/kvm/vmx/vmx.c:55:
arch/x86/kvm/vmx/hyperv.h:188:9: error: redeclaration of enumerator 
‘EVMPTRLD_ERROR’
   188 |         EVMPTRLD_ERROR,
       |         ^~~~~~~~~~~~~~
In file included from arch/x86/kvm/vmx/vmx.c:54:
arch/x86/kvm/vmx/evmcs.h:224:9: note: previous definition of 
‘EVMPTRLD_ERROR’ with type ‘enum nested_evmptrld_status’
   224 |         EVMPTRLD_ERROR,
       |         ^~~~~~~~~~~~~~
make[3]: *** [scripts/Makefile.build:250: arch/x86/kvm/vmx/vmx.o] Error 1
make[2]: *** [scripts/Makefile.build:500: arch/x86/kvm] Error 2
make[1]: *** [scripts/Makefile.build:500: arch/x86] Error 2

The configuration file is attached. Kernel 6.1.62 compiled fine.
Does somebody have an idea about this ?

Thanks in advance for your help.

François Valenduc


Le 28/11/23 à 19:25, Greg Kroah-Hartman a écrit :
> I'm announcing the release of the 6.1.64 kernel.
> 
> All users of the 6.1 kernel series must upgrade.
> 
> The updated 6.1.y git tree can be found at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
> and can be browsed at the normal kernel.org git web browser:
> 	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> 
> thanks,
> 
> greg k-h
> 
> ------------
> 
>   Documentation/admin-guide/kernel-parameters.txt            |    7
>   Makefile                                                   |    2
>   arch/arm/include/asm/exception.h                           |    4
>   arch/arm64/Kconfig                                         |    2
>   arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi             |   46 ++-
>   arch/arm64/boot/dts/qcom/ipq6018.dtsi                      |    4
>   arch/arm64/boot/dts/qcom/ipq8074.dtsi                      |    2
>   arch/loongarch/include/asm/percpu.h                        |   10
>   arch/parisc/include/uapi/asm/pdc.h                         |    1
>   arch/parisc/kernel/entry.S                                 |    7
>   arch/parisc/kernel/head.S                                  |    5
>   arch/powerpc/perf/core-book3s.c                            |    5
>   arch/powerpc/platforms/powernv/opal-prd.c                  |   17 -
>   arch/riscv/include/asm/page.h                              |    4
>   arch/riscv/kernel/probes/simulate-insn.c                   |    2
>   arch/riscv/kernel/smp.c                                    |    1
>   arch/riscv/mm/ptdump.c                                     |    3
>   arch/s390/mm/page-states.c                                 |    6
>   arch/x86/crypto/sha1_ssse3_glue.c                          |   12
>   arch/x86/crypto/sha256_ssse3_glue.c                        |   12
>   arch/x86/include/asm/msr-index.h                           |    1
>   arch/x86/include/asm/numa.h                                |    7
>   arch/x86/kernel/cpu/hygon.c                                |    8
>   arch/x86/kvm/hyperv.c                                      |   10
>   arch/x86/kvm/lapic.c                                       |   26 +-
>   arch/x86/kvm/x86.c                                         |    2
>   arch/x86/mm/numa.c                                         |    7
>   crypto/pcrypt.c                                            |    4
>   drivers/acpi/acpi_fpdt.c                                   |   45 +++
>   drivers/acpi/ec.c                                          |   10
>   drivers/acpi/resource.c                                    |   12
>   drivers/atm/iphase.c                                       |   20 -
>   drivers/base/dd.c                                          |    2
>   drivers/base/regmap/regcache.c                             |   30 ++
>   drivers/block/virtio_blk.c                                 |    4
>   drivers/bluetooth/btusb.c                                  |   15 +
>   drivers/clk/qcom/gcc-ipq6018.c                             |    6
>   drivers/clk/qcom/gcc-ipq8074.c                             |    6
>   drivers/clk/socfpga/stratix10-clk.h                        |    4
>   drivers/clk/visconti/pll.h                                 |    5
>   drivers/clocksource/timer-atmel-tcb.c                      |    1
>   drivers/clocksource/timer-imx-gpt.c                        |   18 +
>   drivers/cpufreq/cpufreq_stats.c                            |   14 -
>   drivers/crypto/hisilicon/qm.c                              |    2
>   drivers/cxl/acpi.c                                         |    2
>   drivers/cxl/core/core.h                                    |   11
>   drivers/cxl/core/hdm.c                                     |    3
>   drivers/cxl/core/port.c                                    |   91 +++----
>   drivers/cxl/core/region.c                                  |  134 +++++++---
>   drivers/cxl/cxl.h                                          |    4
>   drivers/cxl/cxlmem.h                                       |   12
>   drivers/cxl/mem.c                                          |   38 +++
>   drivers/dma/stm32-mdma.c                                   |    4
>   drivers/firmware/qcom_scm.c                                |    7
>   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c                   |    5
>   drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c                |    1
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                     |    2
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                |    6
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                 |   11
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c                    |    9
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c                    |    7
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c                   |    2
>   drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c                     |    5
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c                       |   13 -
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c          |   24 +
>   drivers/gpu/drm/amd/display/dc/core/dc.c                   |   20 +
>   drivers/gpu/drm/amd/display/dc/core/dc_stream.c            |    4
>   drivers/gpu/drm/amd/display/dc/dc.h                        |    5
>   drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c         |    3
>   drivers/gpu/drm/amd/display/dmub/dmub_srv.h                |   22 +
>   drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c            |   32 +-
>   drivers/gpu/drm/amd/include/pptable.h                      |    4
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c                         |    8
>   drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h      |   16 -
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                  |    2
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h              |    2
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h               |    4
>   drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c            |    4
>   drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |    8
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c             |    4
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c       |   40 ---
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c       |    9
>   drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c |    9
>   drivers/gpu/drm/drm_lease.c                                |    4
>   drivers/gpu/drm/gma500/psb_drv.h                           |    1
>   drivers/gpu/drm/gma500/psb_irq.c                           |    5
>   drivers/gpu/drm/i915/display/intel_cdclk.c                 |   12
>   drivers/gpu/drm/i915/gem/i915_gem_context.c                |    1
>   drivers/gpu/drm/i915/i915_perf.c                           |   15 -
>   drivers/gpu/drm/mediatek/mtk_dp.c                          |    6
>   drivers/gpu/drm/msm/dp/dp_panel.c                          |   21 -
>   drivers/gpu/drm/panel/panel-arm-versatile.c                |    2
>   drivers/gpu/drm/panel/panel-sitronix-st7703.c              |   25 +-
>   drivers/gpu/drm/panel/panel-tpo-tpg110.c                   |    2
>   drivers/gpu/drm/qxl/qxl_display.c                          |    3
>   drivers/gpu/drm/radeon/radeon_connectors.c                 |    2
>   drivers/gpu/drm/vmwgfx/vmwgfx_surface.c                    |    4
>   drivers/hid/hid-ids.h                                      |    1
>   drivers/hid/hid-lenovo.c                                   |  118 ++++++---
>   drivers/hid/hid-quirks.c                                   |    1
>   drivers/i2c/busses/i2c-designware-master.c                 |   19 +
>   drivers/i2c/busses/i2c-i801.c                              |   19 -
>   drivers/i2c/busses/i2c-pxa.c                               |   76 +++++-
>   drivers/i2c/busses/i2c-sun6i-p2wi.c                        |    5
>   drivers/i2c/i2c-core-base.c                                |   13 -
>   drivers/i2c/i2c-core.h                                     |    2
>   drivers/i2c/i2c-dev.c                                      |    4
>   drivers/i3c/master/i3c-master-cdns.c                       |    6
>   drivers/i3c/master/mipi-i3c-hci/dat_v1.c                   |   29 +-
>   drivers/i3c/master/mipi-i3c-hci/dma.c                      |    2
>   drivers/i3c/master/svc-i3c-master.c                        |   60 ++++
>   drivers/iio/adc/stm32-adc-core.c                           |    9
>   drivers/infiniband/hw/hfi1/pcie.c                          |    9
>   drivers/input/joystick/xpad.c                              |    1
>   drivers/mcb/mcb-core.c                                     |    1
>   drivers/mcb/mcb-parse.c                                    |    2
>   drivers/md/dm-verity-fec.c                                 |    4
>   drivers/md/dm-verity-target.c                              |   23 -
>   drivers/md/dm-verity.h                                     |    2
>   drivers/media/i2c/ccs/ccs-core.c                           |    2
>   drivers/media/i2c/ccs/ccs-quirk.h                          |    4
>   drivers/media/pci/cobalt/cobalt-driver.c                   |   11
>   drivers/media/platform/qcom/camss/camss-csid-gen2.c        |    9
>   drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c   |    2
>   drivers/media/platform/qcom/camss/camss-vfe-170.c          |   22 -
>   drivers/media/platform/qcom/camss/camss-vfe-480.c          |   22 -
>   drivers/media/platform/qcom/camss/camss-vfe.c              |    5
>   drivers/media/platform/qcom/camss/camss.c                  |   12
>   drivers/media/platform/qcom/venus/hfi_msgs.c               |    2
>   drivers/media/platform/qcom/venus/hfi_parser.c             |   15 +
>   drivers/media/platform/qcom/venus/hfi_venus.c              |   10
>   drivers/media/rc/imon.c                                    |    6
>   drivers/media/rc/ir-sharp-decoder.c                        |    8
>   drivers/media/rc/lirc_dev.c                                |    6
>   drivers/media/test-drivers/vivid/vivid-rds-gen.c           |    2
>   drivers/media/usb/gspca/cpia1.c                            |    3
>   drivers/mfd/intel-lpss-pci.c                               |   13 +
>   drivers/mfd/qcom-spmi-pmic.c                               |  101 +++++---
>   drivers/misc/pci_endpoint_test.c                           |    4
>   drivers/mmc/core/block.c                                   |    4
>   drivers/mmc/core/card.h                                    |    4
>   drivers/mmc/core/mmc.c                                     |    8
>   drivers/mmc/core/quirks.h                                  |    7
>   drivers/mmc/host/meson-gx-mmc.c                            |    1
>   drivers/mmc/host/sdhci-pci-gli.c                           |   30 ++
>   drivers/mmc/host/sdhci_am654.c                             |    2
>   drivers/mmc/host/vub300.c                                  |    1
>   drivers/mtd/chips/cfi_cmdset_0001.c                        |   20 +
>   drivers/mtd/nand/raw/intel-nand-controller.c               |   10
>   drivers/mtd/nand/raw/meson_nand.c                          |    3
>   drivers/mtd/nand/raw/tegra_nand.c                          |    4
>   drivers/net/bonding/bond_main.c                            |    6
>   drivers/net/dsa/lan9303_mdio.c                             |    4
>   drivers/net/ethernet/atheros/atl1c/atl1c.h                 |    3
>   drivers/net/ethernet/atheros/atl1c/atl1c_main.c            |   67 +----
>   drivers/net/ethernet/cortina/gemini.c                      |   45 ++-
>   drivers/net/ethernet/cortina/gemini.h                      |    4
>   drivers/net/ethernet/engleder/tsnep.h                      |    2
>   drivers/net/ethernet/engleder/tsnep_main.c                 |   12
>   drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c         |    9
>   drivers/net/ethernet/hisilicon/hns3/hns3_enet.c            |    2
>   drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   33 ++
>   drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |   25 +-
>   drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |    1
>   drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   |    7
>   drivers/net/ethernet/marvell/mvneta.c                      |   28 +-
>   drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c   |    4
>   drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c        |   30 +-
>   drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c       |   13 -
>   drivers/net/ethernet/mellanox/mlx5/core/en_rep.c           |   12
>   drivers/net/ethernet/mellanox/mlx5/core/en_tc.c            |   60 ++--
>   drivers/net/ethernet/realtek/r8169_main.c                  |   46 ++-
>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c          |    3
>   drivers/net/ipvlan/ipvlan_core.c                           |   41 ++-
>   drivers/net/macvlan.c                                      |    2
>   drivers/net/phy/phylink.c                                  |    1
>   drivers/net/ppp/ppp_synctty.c                              |    6
>   drivers/net/wireless/ath/ath10k/debug.c                    |    2
>   drivers/net/wireless/ath/ath10k/snoc.c                     |   18 +
>   drivers/net/wireless/ath/ath11k/dp_rx.c                    |    8
>   drivers/net/wireless/ath/ath11k/wmi.c                      |   19 +
>   drivers/net/wireless/ath/ath9k/debug.c                     |    2
>   drivers/net/wireless/ath/ath9k/htc_drv_debug.c             |    2
>   drivers/net/wireless/intel/iwlwifi/mvm/tx.c                |   14 -
>   drivers/net/wireless/mac80211_hwsim.c                      |    2
>   drivers/net/wireless/microchip/wilc1000/wlan.c             |    2
>   drivers/net/wireless/purelifi/plfxlc/mac.c                 |    2
>   drivers/parisc/power.c                                     |   16 +
>   drivers/pci/controller/dwc/pci-exynos.c                    |    4
>   drivers/pci/controller/dwc/pci-keystone.c                  |    8
>   drivers/pci/controller/dwc/pcie-kirin.c                    |    4
>   drivers/pci/controller/dwc/pcie-tegra194.c                 |    9
>   drivers/pci/controller/pci-mvebu.c                         |    2
>   drivers/pci/pci-acpi.c                                     |    2
>   drivers/pci/pci-sysfs.c                                    |   10
>   drivers/pci/pci.c                                          |   22 -
>   drivers/pci/pcie/aspm.c                                    |    2
>   drivers/pci/probe.c                                        |    6
>   drivers/pci/quirks.c                                       |   41 ++-
>   drivers/platform/chrome/cros_ec_proto_test.c               |    1
>   drivers/platform/x86/thinkpad_acpi.c                       |    1
>   drivers/ptp/ptp_chardev.c                                  |    3
>   drivers/ptp/ptp_clock.c                                    |    5
>   drivers/ptp/ptp_private.h                                  |    8
>   drivers/ptp/ptp_sysfs.c                                    |    3
>   drivers/s390/crypto/ap_bus.c                               |    4
>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                     |   13 -
>   drivers/scsi/ibmvscsi/ibmvfc.c                             |  124 +++++++++-
>   drivers/scsi/libfc/fc_lport.c                              |    6
>   drivers/scsi/megaraid/megaraid_sas_base.c                  |    4
>   drivers/scsi/mpt3sas/mpt3sas_base.c                        |    4
>   drivers/scsi/qla2xxx/qla_os.c                              |   12
>   drivers/soc/bcm/bcm2835-power.c                            |    2
>   drivers/soc/imx/gpc.c                                      |    1
>   drivers/soundwire/dmi-quirks.c                             |    2
>   drivers/thunderbolt/quirks.c                               |    3
>   drivers/tty/hvc/hvc_xen.c                                  |   39 ++-
>   drivers/tty/serial/meson_uart.c                            |   14 -
>   drivers/tty/sysrq.c                                        |    3
>   drivers/tty/vcc.c                                          |   16 +
>   drivers/usb/dwc3/core.c                                    |  160 ++++++++++---
>   drivers/usb/dwc3/core.h                                    |   13 +
>   drivers/usb/gadget/function/f_ncm.c                        |   27 --
>   drivers/usb/host/xhci-pci.c                                |    4
>   drivers/vhost/vdpa.c                                       |    1
>   drivers/watchdog/sbsa_gwdt.c                               |    4
>   drivers/xen/events/events_base.c                           |    4
>   fs/9p/xattr.c                                              |    5
>   fs/btrfs/delalloc-space.c                                  |    3
>   fs/btrfs/inode.c                                           |    7
>   fs/exfat/namei.c                                           |   29 +-
>   fs/ext4/acl.h                                              |    5
>   fs/ext4/extents_status.c                                   |    4
>   fs/ext4/file.c                                             |  153 +++++-------
>   fs/ext4/inode.c                                            |   14 +
>   fs/ext4/resize.c                                           |   23 -
>   fs/f2fs/compress.c                                         |    2
>   fs/f2fs/node.c                                             |    7
>   fs/f2fs/xattr.c                                            |   20 +
>   fs/gfs2/inode.c                                            |   14 -
>   fs/gfs2/quota.c                                            |   11
>   fs/gfs2/super.c                                            |    2
>   fs/inode.c                                                 |   16 +
>   fs/jbd2/recovery.c                                         |    8
>   fs/jfs/jfs_dmap.c                                          |   23 +
>   fs/jfs/jfs_imap.c                                          |    5
>   fs/nfs/nfs4proc.c                                          |   12
>   fs/nfsd/nfs4state.c                                        |    2
>   fs/overlayfs/super.c                                       |    2
>   fs/proc/proc_sysctl.c                                      |    8
>   fs/quota/dquot.c                                           |   14 +
>   fs/smb/client/cifs_debug.c                                 |    6
>   fs/smb/client/cifs_spnego.c                                |    4
>   fs/smb/client/cifsfs.c                                     |    1
>   fs/smb/client/cifspdu.h                                    |    2
>   fs/smb/client/cifsproto.h                                  |    7
>   fs/smb/client/connect.c                                    |   15 -
>   fs/smb/client/inode.c                                      |    4
>   fs/smb/client/sess.c                                       |    1
>   fs/smb/client/smb2misc.c                                   |    2
>   fs/smb/client/smb2ops.c                                    |    8
>   fs/smb/client/smb2transport.c                              |    5
>   fs/smb/client/transport.c                                  |   11
>   fs/smb/client/xattr.c                                      |    5
>   fs/smb/server/smb_common.c                                 |   11
>   fs/smb/server/smbacl.c                                     |   29 ++
>   fs/xfs/xfs_inode_item_recover.c                            |   32 +-
>   include/linux/damon.h                                      |    7
>   include/linux/ethtool.h                                    |    4
>   include/linux/fs.h                                         |   45 +++
>   include/linux/generic-radix-tree.h                         |    7
>   include/linux/lsm_hook_defs.h                              |    4
>   include/linux/mmc/card.h                                   |    2
>   include/linux/preempt.h                                    |   15 +
>   include/linux/pwm.h                                        |    4
>   include/linux/socket.h                                     |    1
>   include/linux/string.h                                     |   40 +++
>   include/linux/sunrpc/clnt.h                                |    1
>   include/linux/sysctl.h                                     |    6
>   include/linux/trace_events.h                               |    4
>   include/linux/workqueue.h                                  |   46 +++
>   include/net/netfilter/nf_tables.h                          |    4
>   include/net/sock.h                                         |   26 +-
>   include/sound/soc-acpi.h                                   |    7
>   include/sound/soc-card.h                                   |   37 +++
>   include/sound/soc.h                                        |   11
>   include/sound/sof.h                                        |    8
>   include/uapi/linux/vm_sockets.h                            |   17 +
>   init/main.c                                                |    4
>   kernel/audit_watch.c                                       |    9
>   kernel/bpf/core.c                                          |    6
>   kernel/bpf/verifier.c                                      |   16 +
>   kernel/cpu.c                                               |   11
>   kernel/debug/debug_core.c                                  |    3
>   kernel/events/ring_buffer.c                                |    6
>   kernel/irq/generic-chip.c                                  |   25 +-
>   kernel/kexec.c                                             |    2
>   kernel/locking/test-ww_mutex.c                             |   20 -
>   kernel/padata.c                                            |    2
>   kernel/power/snapshot.c                                    |   16 -
>   kernel/rcu/srcutree.c                                      |    4
>   kernel/rcu/tree.c                                          |   21 +
>   kernel/rcu/tree.h                                          |    4
>   kernel/rcu/tree_stall.h                                    |   20 +
>   kernel/reboot.c                                            |    1
>   kernel/smp.c                                               |   13 -
>   kernel/trace/trace.c                                       |   15 +
>   kernel/trace/trace.h                                       |    3
>   kernel/trace/trace_events.c                                |   43 ++-
>   kernel/trace/trace_events_filter.c                         |    3
>   kernel/trace/trace_events_synth.c                          |    2
>   kernel/watch_queue.c                                       |    2
>   kernel/watchdog.c                                          |    7
>   kernel/workqueue.c                                         |   20 -
>   lib/generic-radix-tree.c                                   |   17 +
>   mm/cma.c                                                   |    2
>   mm/damon/lru_sort.c                                        |    4
>   mm/damon/ops-common.c                                      |    5
>   mm/damon/sysfs.c                                           |   87 ++++---
>   mm/huge_memory.c                                           |   16 -
>   mm/memcontrol.c                                            |    3
>   mm/memory_hotplug.c                                        |    2
>   net/9p/client.c                                            |    2
>   net/9p/trans_fd.c                                          |   13 -
>   net/bluetooth/hci_conn.c                                   |    6
>   net/bluetooth/hci_sysfs.c                                  |   23 -
>   net/bridge/netfilter/nf_conntrack_bridge.c                 |    2
>   net/core/sock.c                                            |    2
>   net/ipv4/inet_hashtables.c                                 |    2
>   net/ipv4/tcp_output.c                                      |    2
>   net/mac80211/cfg.c                                         |    4
>   net/mptcp/pm_netlink.c                                     |    5
>   net/mptcp/protocol.c                                       |    4
>   net/mptcp/sockopt.c                                        |    3
>   net/ncsi/ncsi-aen.c                                        |    5
>   net/netfilter/nf_tables_api.c                              |   53 ++--
>   net/netfilter/nft_byteorder.c                              |    5
>   net/netfilter/nft_meta.c                                   |    2
>   net/sunrpc/clnt.c                                          |    7
>   net/sunrpc/rpcb_clnt.c                                     |    4
>   net/sunrpc/xprtrdma/svc_rdma_recvfrom.c                    |    3
>   net/tipc/netlink_compat.c                                  |    1
>   net/unix/af_unix.c                                         |    9
>   net/vmw_vsock/af_vsock.c                                   |    6
>   scripts/gcc-plugins/randomize_layout_plugin.c              |   11
>   security/integrity/iint.c                                  |   48 +++
>   security/integrity/ima/ima_api.c                           |    5
>   security/integrity/ima/ima_main.c                          |   16 +
>   security/integrity/integrity.h                             |    2
>   security/keys/trusted-keys/trusted_core.c                  |   20 -
>   security/keys/trusted-keys/trusted_tee.c                   |   64 +----
>   sound/core/info.c                                          |   21 +
>   sound/hda/hdac_stream.c                                    |    6
>   sound/pci/hda/patch_realtek.c                              |   26 --
>   sound/soc/codecs/lpass-wsa-macro.c                         |    3
>   sound/soc/intel/common/soc-acpi-intel-cht-match.c          |   43 +++
>   sound/soc/sof/ipc4.c                                       |    3
>   sound/soc/sof/sof-audio.c                                  |    7
>   sound/soc/sof/sof-pci-dev.c                                |    8
>   sound/soc/ti/omap-mcbsp.c                                  |    6
>   tools/perf/util/intel-pt.c                                 |    2
>   tools/power/x86/turbostat/turbostat.c                      |    3
>   tools/testing/cxl/test/cxl.c                               |  147 +++++++++++
>   tools/testing/selftests/efivarfs/create-read.c             |    2
>   tools/testing/selftests/lkdtm/config                       |    1
>   tools/testing/selftests/lkdtm/tests.txt                    |    2
>   tools/testing/selftests/resctrl/Makefile                   |    2
>   tools/testing/selftests/resctrl/cmt_test.c                 |    3
>   tools/testing/selftests/resctrl/mba_test.c                 |    2
>   tools/testing/selftests/resctrl/mbm_test.c                 |    2
>   tools/testing/selftests/resctrl/resctrl.h                  |    1
>   371 files changed, 3389 insertions(+), 1476 deletions(-)
> 
> Adrian Hunter (1):
>        perf intel-pt: Fix async branch flags
> 
> Ajay Singh (1):
>        wifi: wilc1000: use vmm_table as array in wilc struct
> 
> Al Viro (1):
>        gfs2: fix an oops in gfs2_permission
> 
> Alain Volmat (1):
>        dmaengine: stm32-mdma: correct desc prep when channel running
> 
> Alex Deucher (3):
>        drm/amdgpu/smu13: drop compute workload workaround
>        drm/amdgpu: don't use pci_is_thunderbolt_attached()
>        drm/amdgpu: don't use ATRM for external devices
> 
> Alex Spataru (1):
>        ALSA: hda/realtek: Add quirk for ASUS UX7602ZM
> 
> Alexander Sverdlin (1):
>        net: dsa: lan9303: consequently nested-lock physical MDIO
> 
> Amir Goldstein (1):
>        ima: annotate iint mutex to avoid lockdep false positive warnings
> 
> Anastasia Belova (1):
>        cifs: spnego: add ';' in HOST_KEY_LEN
> 
> Andreas Gruenbacher (1):
>        gfs2: Silence "suspicious RCU usage in gfs2_permission" warning
> 
> Andrew Lunn (1):
>        net: ethtool: Fix documentation of ethtool_sprintf()
> 
> Andrey Konovalov (1):
>        media: qcom: camss: Fix csid-gen2 for test pattern generator
> 
> Andrii Nakryiko (1):
>        bpf: Ensure proper register state printing for cond jumps
> 
> Arseniy Krasnov (1):
>        vsock: read from socket's error queue
> 
> Artem Lukyanov (1):
>        Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x0cb8:0xc559
> 
> Axel Lin (1):
>        i2c: sun6i-p2wi: Prevent potential division by zero
> 
> Bartosz Pawlowski (2):
>        PCI: Extract ATS disabling to a helper function
>        PCI: Disable ATS for specific Intel IPU E2000 devices
> 
> Baruch Siach (2):
>        net: stmmac: fix rx budget limit check
>        net: stmmac: avoid rx queue overrun
> 
> Bas Nieuwenhuizen (1):
>        drm/amd/pm: Handle non-terminated overdrive commands.
> 
> Basavaraj Natikar (1):
>        xhci: Enable RPM on controllers that support low-power states
> 
> Bean Huo (1):
>        mmc: Add quirk MMC_QUIRK_BROKEN_CACHE_FLUSH for Micron eMMC Q2J54A
> 
> Benjamin Bara (2):
>        kernel/reboot: emergency_restart: Set correct system_state
>        i2c: core: Run atomic i2c xfer when !preemptible
> 
> Billy Tsai (1):
>        i3c: master: mipi-i3c-hci: Fix a kernel panic for accessing DAT_data.
> 
> Bjorn Helgaas (1):
>        PCI: Use FIELD_GET() in Sapphire RX 5600 XT Pulse quirk
> 
> Bob Peterson (1):
>        gfs2: ignore negated quota changes
> 
> Brian Geffon (2):
>        PM: hibernate: Use __get_safe_page() rather than touching the list
>        PM: hibernate: Clean up sync_read handling in snapshot_write_next()
> 
> Bryan O'Donoghue (6):
>        media: qcom: camss: Fix pm_domain_on sequence in probe
>        media: qcom: camss: Fix vfe_get() error jump
>        media: qcom: camss: Fix VFE-17x vfe_disable_output()
>        media: qcom: camss: Fix VFE-480 vfe_disable_output()
>        media: qcom: camss: Fix missing vfe_lite clocks check
>        media: qcom: camss: Fix invalid clock enable bit disjunction
> 
> Catalin Marinas (1):
>        rcu: kmemleak: Ignore kmemleak false positives when RCU-freeing objects
> 
> Cezary Rojewski (1):
>        ALSA: hda: Fix possible null-ptr-deref when assigning a stream
> 
> Chandradeep Dey (1):
>        ALSA: hda/realtek - Enable internal speaker of ASUS K6500ZC
> 
> Chandrakanth patil (1):
>        scsi: megaraid_sas: Increase register read retry rount from 3 to 30 for selected registers
> 
> Chen Yu (1):
>        tools/power/turbostat: Enable the C-state Pre-wake printing
> 
> Christian König (2):
>        drm/amdgpu: fix error handling in amdgpu_bo_list_get()
>        drm/amdgpu: lower CS errors to debug severity
> 
> Christian Marangi (1):
>        cpufreq: stats: Fix buffer overflow detection in trans_stats()
> 
> Chuck Lever (1):
>        svcrdma: Drop connection after an RDMA Read error
> 
> ChunHao Lin (2):
>        r8169: fix network lost after resume on DASH systems
>        r8169: add handling DASH when DASH is disabled
> 
> Clark Wang (1):
>        i3c: master: svc: add NACK check after start byte sent
> 
> Conor Dooley (1):
>        RISC-V: drop error print from riscv_hartid_to_cpuid()
> 
> Dan Carpenter (5):
>        pwm: Fix double shift bug
>        SUNRPC: Add an IS_ERR() check back to where it was
>        vhost-vdpa: fix use after free in vhost_vdpa_probe()
>        netfilter: nf_tables: fix pointer math issue in nft_byteorder_eval()
>        mmc: vub300: fix an error code
> 
> Dan Williams (5):
>        cxl/region: Validate region mode vs decoder mode
>        cxl/region: Cleanup target list on attach error
>        cxl/region: Move region-position validation to a helper
>        cxl/mem: Move devm_cxl_add_endpoint() from cxl_core to cxl_mem
>        tools/testing/cxl: Define a fixed volatile configuration to parse
> 
> Dario Binacchi (1):
>        clk: visconti: remove unused visconti_pll_provider::regmap
> 
> Darren Hart (1):
>        sbsa_gwdt: Calculate timeout with 64-bit math
> 
> Dave Chinner (1):
>        xfs: recovery should not clear di_flushiter unconditionally
> 
> David (Ming Qiang) Wu (1):
>        drm/amdgpu: not to save bo in the case of RAS err_event_athub
> 
> David Woodhouse (3):
>        hvc/xen: fix console unplug
>        hvc/xen: fix error path in xen_hvc_init() to always register frontend driver
>        hvc/xen: fix event channel handling for secondary consoles
> 
> Denis Arefev (1):
>        srcu: Fix srcu_struct node grpmask overflow on 64-bit systems
> 
> Dmitry Antipov (4):
>        wifi: plfxlc: fix clang-specific fortify warning
>        wifi: mac80211_hwsim: fix clang-specific fortify warning
>        wifi: ath9k: fix clang-specific fortify warnings
>        wifi: ath10k: fix clang-specific fortify warning
> 
> Dominique Martinet (1):
>        9p: v9fs_listxattr: fix %s null argument warning
> 
> Douglas Anderson (2):
>        wifi: ath10k: Don't touch the CE interrupt registers after power up
>        kgdb: Flush console before entering kgdb on panic
> 
> Dust Li (1):
>        net/mlx5e: fix double free of encap_header
> 
> Ekaterina Esina (1):
>        cifs: fix check of rc in function generate_smb3signingkey
> 
> Eric Biggers (1):
>        quota: explicitly forbid quota files from being encrypted
> 
> Eric Dumazet (6):
>        net: annotate data-races around sk->sk_tx_queue_mapping
>        net: annotate data-races around sk->sk_dst_pending_confirm
>        ipvlan: add ipvlan_route_v6_outbound() helper
>        ptp: annotate data-race around q->head and q->tail
>        bonding: stop the device in bond_setup_by_slave()
>        af_unix: fix use-after-free in unix_stream_read_actor()
> 
> Eymen Yigit (1):
>        ALSA: hda/realtek: Enable Mute LED on HP 255 G8
> 
> Finn Thain (1):
>        sched/core: Optimize in_task() and in_interrupt() a bit
> 
> Frank Li (6):
>        i3c: master: svc: fix race condition in ibi work thread
>        i3c: master: svc: fix wrong data return when IBI happen during start frame
>        i3c: master: svc: fix ibi may not return mandatory data byte
>        i3c: master: svc: fix check wrong status register in irq handler
>        i3c: master: svc: fix SDA keep low when polling IBIWON timeout happen
>        i3c: master: svc: fix random hot join failure since timeout error
> 
> Frederic Weisbecker (1):
>        workqueue: Provide one lock class key per work_on_cpu() callsite
> 
> Gavin Li (1):
>        net/mlx5e: fix double free of encap_header in update funcs
> 
> Geliang Tang (1):
>        mptcp: add validity check for sending RM_ADDR
> 
> Gerhard Engleder (1):
>        tsnep: Fix tsnep_request_irq() format-overflow warning
> 
> Greg Kroah-Hartman (1):
>        Linux 6.1.64
> 
> Guan Wentao (1):
>        Bluetooth: btusb: Add 0bda:b85b for Fn-Link RTL8852BE
> 
> Gustavo A. R. Silva (2):
>        clk: socfpga: Fix undefined behavior bug in struct stratix10_clock_data
>        clk: visconti: Fix undefined behavior bug in struct visconti_pll_provider
> 
> Hans Verkuil (1):
>        media: vivid: avoid integer overflow
> 
> Hans de Goede (1):
>        ASoC: Intel: soc-acpi-cht: Add Lenovo Yoga Tab 3 Pro YT3-X90 quirk
> 
> Hao Sun (1):
>        bpf: Fix check_stack_write_fixed_off() to correctly spill imm
> 
> Harald Freudenberger (1):
>        s390/ap: fix AP bus crash on early config change callback invocation
> 
> Hardik Gajjar (1):
>        usb: gadget: f_ncm: Always set current gadget in ncm_bind()
> 
> Harshit Mogalapalli (1):
>        i915/perf: Fix NULL deref bugs with drm_dbg() calls
> 
> Heiko Carstens (1):
>        s390/cmma: fix detection of DAT pages
> 
> Heiner Kallweit (3):
>        PCI/ASPM: Fix L1 substate handling in aspm_attr_store_common()
>        i2c: i801: fix potential race in i801_block_transaction_byte_by_byte
>        Revert "net: r8169: Disable multicast filter for RTL8168H and RTL8107E"
> 
> Helge Deller (5):
>        parisc/pdc: Add width field to struct pdc_model
>        parisc/power: Add power soft-off when running on qemu
>        parisc: Prevent booting 64-bit kernels on PA1.x machines
>        parisc/pgtable: Do not drop upper 5 address bits of physical address
>        parisc/power: Fix power soft-off when running on qemu
> 
> Herve Codina (1):
>        genirq/generic_chip: Make irq_remove_generic_chip() irqdomain aware
> 
> Ilpo Järvinen (10):
>        RDMA/hfi1: Use FIELD_GET() to extract Link Width
>        PCI: tegra194: Use FIELD_GET()/FIELD_PREP() with Link Width fields
>        PCI: mvebu: Use FIELD_PREP() with Link Width
>        atm: iphase: Do PCI error checks on own line
>        PCI: Do error check on own line to split long "if" conditions
>        PCI: Use FIELD_GET() to extract Link Width
>        media: cobalt: Use FIELD_GET() to extract Link Width
>        selftests/resctrl: Remove duplicate feature check from CMT test
>        selftests/resctrl: Move _GNU_SOURCE define into Makefile
>        selftests/resctrl: Reduce failures due to outliers in MBA/MBM tests
> 
> Jacky Bai (1):
>        clocksource/drivers/timer-imx-gpt: Fix potential memory leak
> 
> Jaegeuk Kim (1):
>        f2fs: do not return EFSCORRUPTED, but try to run online repair
> 
> Jamie Lentin (1):
>        hid: lenovo: Resend all settings on reset_resume for compact keyboards
> 
> Jan Kara (1):
>        ext4: properly sync file size update after O_SYNC direct IO
> 
> Jani Nikula (3):
>        drm/msm/dp: skip validity check for DP CTS EDID checksum
>        drm/mediatek/dp: fix memory leak on ->get_edid callback audio detection
>        drm/mediatek/dp: fix memory leak on ->get_edid callback error path
> 
> Jarkko Nikula (2):
>        mfd: intel-lpss: Add Intel Lunar Lake-M PCI IDs
>        i3c: mipi-i3c-hci: Fix out of bounds access in hci_dma_irq_handler
> 
> Jarkko Sakkinen (1):
>        KEYS: trusted: Rollback init_trusted() consistently
> 
> Jeff Layton (1):
>        fs: add ctime accessors infrastructure
> 
> Jesse Zhang (1):
>        drm/amdkfd: Fix shift out-of-bounds issue
> 
> Jian Shen (2):
>        net: hns3: fix add VLAN fail issue
>        net: hns3: fix incorrect capability bit display for copper port
> 
> Jijie Shao (2):
>        net: hns3: fix VF reset fail issue
>        net: hns3: fix VF wrong speed and duplex issue
> 
> Jim Harris (2):
>        cxl/region: Do not try to cleanup after cxl_region_setup_targets() fails
>        cxl/region: Fix x1 root-decoder granularity calculations
> 
> Jiri Kosina (1):
>        HID: Add quirk for Dell Pro Wireless Keyboard and Mouse KM5221W
> 
> Joel Fernandes (Google) (1):
>        rcu/tree: Defer setting of jiffies during stall reset
> 
> Johan Hovold (6):
>        wifi: ath11k: fix temperature event locking
>        wifi: ath11k: fix dfs radar event locking
>        wifi: ath11k: fix htt pktlog locking
>        wifi: ath11k: fix gtk offload status event locking
>        mfd: qcom-spmi-pmic: Fix reference leaks in revid helper
>        mfd: qcom-spmi-pmic: Fix revid implementation
> 
> John Stultz (1):
>        locking/ww_mutex/test: Fix potential workqueue corruption
> 
> Johnathan Mantey (1):
>        Revert ncsi: Propagate carrier gain/loss events to the NCSI controller
> 
> Jonathan Denose (1):
>        ACPI: EC: Add quirk for HP 250 G7 Notebook PC
> 
> Josef Bacik (1):
>        btrfs: don't arbitrarily slow down delalloc if we're committing
> 
> Joshua Yeong (1):
>        i3c: master: cdns: Fix reading status register
> 
> Juergen Gross (1):
>        xen/events: fix delayed eoi list handling
> 
> Juntong Deng (2):
>        fs/jfs: Add check for negative db_l2nbperpage
>        fs/jfs: Add validity check for db_maxag and db_agpref
> 
> Kailang Yang (1):
>        ALSA: hda/realtek - Add Dell ALC295 to pin fall back table
> 
> Kathiravan Thirumoorthy (3):
>        clk: qcom: ipq8074: drop the CLK_SET_RATE_PARENT flag from PLL clocks
>        clk: qcom: ipq6018: drop the CLK_SET_RATE_PARENT flag from PLL clocks
>        firmware: qcom_scm: use 64-bit calling convention only when client is 64-bit
> 
> Kees Cook (1):
>        randstruct: Fix gcc-plugin performance mode to stay in group
> 
> Kemeng Shi (4):
>        ext4: correct offset of gdb backup in non meta_bg group to update_backups
>        ext4: correct return value of ext4_convert_meta_bg
>        ext4: remove gdb backup copy for meta bg in setup_new_flex_group_blocks
>        ext4: add missed brelse in update_backups
> 
> Kent Overstreet (1):
>        lib/generic-radix-tree.c: Don't overflow in peek()
> 
> Klaus Kudielka (1):
>        net: phylink: initialize carrier state at creation
> 
> Krister Johansen (2):
>        proc: sysctl: prevent aliased sysctls from getting passed to init
>        watchdog: move softlockup_panic back to early_param
> 
> Krzysztof Kozlowski (1):
>        ASoC: codecs: wsa-macro: fix uninitialized stack variables with name prefix
> 
> Kumar Kartikeya Dwivedi (1):
>        bpf: Detect IP == ksym.end as part of BPF program
> 
> Kunwu Chan (1):
>        drm/i915: Fix potential spectre vulnerability
> 
> Larry Finger (2):
>        bluetooth: Add device 0bda:887b to device tables
>        bluetooth: Add device 13d3:3571 to device tables
> 
> Laurentiu Tudor (1):
>        arm64: dts: ls208xa: use a pseudo-bus to constrain usb dma size
> 
> Lewis Huang (1):
>        drm/amd/display: Change the DMCUB mailbox memory location from FB to inbox
> 
> Linkui Xiao (1):
>        netfilter: nf_conntrack_bridge: initialize err to 0
> 
> Linus Walleij (4):
>        net: ethernet: cortina: Fix max RX frame define
>        net: ethernet: cortina: Handle large frames
>        net: ethernet: cortina: Fix MTU max setting
>        mtd: cfi_cmdset_0001: Byte swap OTP info
> 
> Longfang Liu (1):
>        crypto: hisilicon/qm - prevent soft lockup in receive loop
> 
> Lu Jialin (1):
>        crypto: pcrypt - Fix hungtask for PADATA_RESET
> 
> Lukas Wunner (1):
>        PCI/sysfs: Protect driver's D3cold preference from user space
> 
> Ma Jun (1):
>        drm/amd/pm: Fix error of MACO flag setting code
> 
> Ma Ke (4):
>        drm/panel: fix a possible null pointer dereference
>        drm/panel/panel-tpo-tpg110: fix a possible null pointer dereference
>        drm/radeon: fix a possible null pointer dereference
>        drm/amdgpu/vkms: fix a possible null pointer dereference
> 
> Maciej S. Szmigiero (1):
>        KVM: x86: Ignore MSR_AMD64_TW_CFG access
> 
> Mahmoud Adam (1):
>        nfsd: fix file memleak on client_opens_release
> 
> Manas Ghandat (2):
>        jfs: fix array-index-out-of-bounds in dbFindLeaf
>        jfs: fix array-index-out-of-bounds in diAlloc
> 
> Marco Elver (1):
>        9p/trans_fd: Annotate data-racy writes to file::f_flags
> 
> Mario Limonciello (4):
>        drm/amd: Update `update_pcie_parameters` functions to use uint8_t arguments
>        drm/amd: Fix UBSAN array-index-out-of-bounds for SMU7
>        drm/amd: Fix UBSAN array-index-out-of-bounds for Polaris and Tonga
>        drm/amd/display: fix a NULL pointer dereference in amdgpu_dm_i2c_xfer()
> 
> Mark Brown (1):
>        regmap: Ensure range selector registers are updated after cache sync
> 
> Masum Reza (1):
>        Bluetooth: btusb: Add RTW8852BE device 13d3:3570 to device tables
> 
> Matus Malych (1):
>        ALSA: hda/realtek: Enable Mute LED on HP 255 G10
> 
> Max Kellermann (1):
>        ext4: apply umask if ACL support is disabled
> 
> Maíra Canal (1):
>        pmdomain: bcm: bcm2835-power: check if the ASB register is equal to enable
> 
> Michael Ellerman (1):
>        powerpc/powernv: Fix fortify source warnings in opal-prd.c
> 
> Mika Westerberg (1):
>        thunderbolt: Apply USB 3.x bandwidth quirk only in software connection manager
> 
> Mike Rapoport (IBM) (1):
>        x86/mm: Drop the 4 MB restriction on minimal NUMA node memory size
> 
> Mikhail Khvainitski (1):
>        HID: lenovo: Detect quirk-free fw on cptkbd and stop applying workaround
> 
> Mikulas Patocka (1):
>        dm-verity: don't use blocking calls from tasklets
> 
> Mimi Zohar (1):
>        ima: detect changes to the backing overlay file
> 
> Miri Korenblit (1):
>        wifi: iwlwifi: Use FW rate for non-data frames
> 
> Muhammad Ahmed (1):
>        drm/amd/display: enable dsc_clk even if dsc_pg disabled
> 
> Muhammad Usama Anjum (1):
>        tty/sysrq: replace smp_processor_id() with get_cpu()
> 
> Nam Cao (1):
>        riscv: kprobes: allow writing to x0
> 
> Namjae Jeon (2):
>        ksmbd: handle malformed smb1 message
>        ksmbd: fix slab out of bounds write in smb_inherit_dacl()
> 
> Naohiro Aota (1):
>        btrfs: zoned: wait for data BG to be finished on direct IO allocation
> 
> Nathan Chancellor (2):
>        arm64: Restrict CPU_BIG_ENDIAN to GNU as or LLVM IAS 15.x or newer
>        LoongArch: Mark __percpu functions as always inline
> 
> Nicholas Piggin (1):
>        powerpc/perf: Fix disabling BHRB and instruction sampling
> 
> Nicolas Saenz Julienne (1):
>        KVM: x86: hyper-v: Don't auto-enable stimer on write from user-space
> 
> Nitin Yadav (1):
>        mmc: sdhci_am654: fix start loop index for TAP value parsing
> 
> Ojaswin Mujoo (1):
>        ext4: mark buffer new if it is unwritten to avoid stale data exposure
> 
> Olga Kornievskaia (2):
>        NFSv4.1: fix handling NFS4ERR_DELAY when testing for session trunking
>        NFSv4.1: fix SP4_MACH_CRED protection for pnfs IO
> 
> Olli Asikainen (1):
>        platform/x86: thinkpad_acpi: Add battery quirk for Thinkpad X120e
> 
> Ondrej Jirman (1):
>        drm/panel: st7703: Pick different reset sequence
> 
> Ondrej Mosnacek (2):
>        lsm: fix default return value for vm_enough_memory
>        lsm: fix default return value for inode_getsecctx
> 
> Pablo Neira Ayuso (2):
>        netfilter: nf_tables: remove catchall element in GC sync path
>        netfilter: nf_tables: split async and sync catchall in two functions
> 
> Paolo Abeni (2):
>        mptcp: deal with large GSO size
>        mptcp: fix setsockopt(IP_TOS) subflow locking
> 
> Paul Moore (2):
>        audit: don't take task_lock() in audit_exe_compare() code path
>        audit: don't WARN_ON_ONCE(!current->mm) in audit_exe_compare()
> 
> Paulo Alcantara (2):
>        smb: client: fix use-after-free bug in cifs_debug_data_proc_show()
>        smb: client: fix potential deadlock when releasing mids
> 
> Pavel Krasavin (1):
>        tty: serial: meson: fix hard LOCKUP on crtscts mode
> 
> Pengfei Li (1):
>        pmdomain: imx: Make imx pgc power domain also set the fwnode
> 
> Philipp Stanner (6):
>        string.h: add array-wrappers for (v)memdup_user()
>        kernel: kexec: copy user-array safely
>        kernel: watch_queue: copy user-array safely
>        drm_lease.c: copy user-array safely
>        drm: vmwgfx_surface.c: copy user-array safely
>        i2c: dev: copy userspace array safely
> 
> Pierre-Louis Bossart (1):
>        soundwire: dmi-quirks: update HP Omen match
> 
> Ping-Ke Shih (1):
>        wifi: mac80211: don't return unset power in ieee80211_get_tx_power()
> 
> Pu Wen (1):
>        x86/cpu/hygon: Fix the CPU topology evaluation for real
> 
> Qu Huang (1):
>        drm/amdgpu: Fix a null pointer access when the smc_rreg pointer is NULL
> 
> Quinn Tran (1):
>        scsi: qla2xxx: Fix system crash due to bad pointer access
> 
> Rahul Rameshbabu (2):
>        net/mlx5e: Check return value of snprintf writing to fw_version buffer
>        net/mlx5e: Check return value of snprintf writing to fw_version buffer for representors
> 
> Rajeshwar R Shinde (1):
>        media: gspca: cpia1: shift-out-of-bounds in set_flicker
> 
> Ran Xiaokai (1):
>        cpu/hotplug: Don't offline the last non-isolated CPU
> 
> Rander Wang (1):
>        ASoC: SOF: ipc4: handle EXCEPTION_CAUGHT notification from firmware
> 
> Ranjan Kumar (1):
>        scsi: mpt3sas: Fix loop logic
> 
> Ricardo Cañuelo (1):
>        selftests/lkdtm: Disable CONFIG_UBSAN_TRAP in test config
> 
> Richard Fitzgerald (2):
>        ASoC: soc-card: Add storage for PCI SSID
>        ASoC: SOF: Pass PCI SSID to machine driver
> 
> Rik van Riel (1):
>        smp,csd: Throw an error if a CSD lock is stuck for too long
> 
> Robert Marko (1):
>        Revert "i2c: pxa: move to generic GPIO recovery"
> 
> Robert Richter (2):
>        cxl: Unify debug messages when calling devm_cxl_add_port()
>        cxl/port: Fix NULL pointer access in devm_cxl_add_port()
> 
> Roman Gushchin (1):
>        mm: kmem: drop __GFP_NOFAIL when allocating objcg vectors
> 
> Ronald Wahl (1):
>        clocksource/drivers/timer-atmel-tcb: Fix initialization on SAM9 hardware
> 
> Rong Chen (1):
>        mmc: meson-gx: Remove setting of CMD_CFG_ERROR
> 
> Roxana Nicolescu (1):
>        crypto: x86/sha - load modules based on CPU features
> 
> Saeed Mahameed (1):
>        net/mlx5e: Reduce the size of icosq_str
> 
> Sakari Ailus (2):
>        media: ccs: Fix driver quirk struct documentation
>        media: ccs: Correctly initialise try compose rectangle
> 
> Sanjuán García, Jorge (1):
>        mcb: fix error handling for different scenarios when parsing
> 
> Saravana Kannan (1):
>        driver core: Release all resources during unbind before updating device links
> 
> Sean Young (2):
>        media: lirc: drop trailing space from scancode transmit
>        media: sharp: fix sharp encoding
> 
> SeongJae Park (6):
>        mm/damon/sysfs: remove requested targets when online-commit inputs
>        mm/damon/sysfs: update monitoring target regions for online input commit
>        mm/damon/lru_sort: avoid divide-by-zero in hot threshold calculation
>        mm/damon/ops-common: avoid divide-by-zero during region hotness calculation
>        mm/damon: implement a function for max nr_accesses safe calculation
>        mm/damon/sysfs: check error from damon_sysfs_update_target()
> 
> Shigeru Yoshida (2):
>        tty: Fix uninit-value access in ppp_sync_receive()
>        tipc: Fix kernel-infoleak due to uninitialized TLV value
> 
> Shuai Xue (1):
>        perf/core: Bail out early if the request AUX area is out of bound
> 
> Shung-Hsi Yu (1):
>        bpf: Fix precision tracking for BPF_ALU | BPF_TO_BE | BPF_END
> 
> Shyam Prasad N (3):
>        cifs: reconnect helper should set reconnect for the right channel
>        cifs: force interface update before a fresh session setup
>        cifs: do not reset chan_max if multichannel is not supported at mount
> 
> Sieng-Piaw Liew (1):
>        atl1c: Work around the DMA RX overflow issue
> 
> Song Shuai (2):
>        riscv: mm: Update the comment of CONFIG_PAGE_OFFSET
>        riscv: correct pt_level name via pgtable_l5/4_enabled
> 
> Stanislav Fomichev (1):
>        net: set SOCK_RCU_FREE before inserting socket into hashtable
> 
> Stanley Chang (1):
>        usb: dwc3: core: configure TX/RX threshold for DWC3_IP
> 
> Stanley.Yang (1):
>        drm/amdgpu: Fix potential null pointer derefernce
> 
> Stefan Binding (1):
>        ALSA: hda/realtek: Add quirks for HP Laptops
> 
> Stefan Roesch (1):
>        mm: fix for negative counter: nr_file_hugepages
> 
> Steve French (3):
>        smb3: fix creating FIFOs when mounting with "sfu" mount option
>        smb3: fix touch -h of symlink
>        smb3: fix caching of ctime on setxattr
> 
> Steven Rostedt (Google) (2):
>        tracing: Have the user copy of synthetic event address use correct context
>        tracing: Have trace_event_file have ref counters
> 
> Su Hui (1):
>        f2fs: avoid format-overflow warning
> 
> Sui Jingfeng (1):
>        drm/gma500: Fix call trace when psb_gem_mm_init() fails
> 
> Sumit Garg (1):
>        KEYS: trusted: tee: Refactor register SHM usage
> 
> Sven Auhagen (1):
>        net: mvneta: fix calls to page_pool_get_stats
> 
> Takashi Iwai (2):
>        media: imon: fix access to invalid resource for the second interface
>        ALSA: info: Fix potential deadlock at disconnection
> 
> Tam Nguyen (1):
>        i2c: designware: Disable TX_EMPTY irq while waiting for block length byte
> 
> Tao Su (1):
>        KVM: x86: Clear bit12 of ICR after APIC-write VM-exit
> 
> Tianci Yin (1):
>        drm/amd/display: Enable fast plane updates on DCN3.2 and above
> 
> Tony Lindgren (1):
>        ASoC: ti: omap-mcbsp: Fix runtime PM underflow warnings
> 
> Trond Myklebust (1):
>        SUNRPC: ECONNRESET might require a rebind
> 
> Tyrel Datwyler (1):
>        scsi: ibmvfc: Remove BUG_ON in the case of an empty event pool
> 
> Tzung-Bi Shih (1):
>        platform/chrome: kunit: initialize lock for fake ec_dev
> 
> Uwe Kleine-König (4):
>        PCI: keystone: Don't discard .remove() callback
>        PCI: keystone: Don't discard .probe() callback
>        PCI: kirin: Don't discard .remove() callback
>        PCI: exynos: Don't discard .remove() callback
> 
> Vasily Khoruzhick (1):
>        ACPI: FPDT: properly handle invalid FPDT subtables
> 
> Vicki Pfau (1):
>        Input: xpad - add VID for Turtle Beach controllers
> 
> Victor Shih (3):
>        mmc: sdhci-pci-gli: A workaround to allow GL9750 to enter ASPM L1.2
>        mmc: sdhci-pci-gli: GL9750: Mask the replay timer timeout of AER
>        mmc: sdhci-pci-gli: GL9755: Mask the replay timer timeout of AER
> 
> Vignesh Viswanathan (3):
>        arm64: dts: qcom: ipq6018: Fix hwlock index for SMEM
>        arm64: dts: qcom: ipq8074: Fix hwlock index for SMEM
>        arm64: dts: qcom: ipq6018: Fix tcsr_mutex register size
> 
> Vikash Garodia (4):
>        media: venus: hfi: add checks to perform sanity on queue pointers
>        media: venus: hfi_parser: Add check to keep the number of codecs within range
>        media: venus: hfi: fix the check to handle session buffer requirement
>        media: venus: hfi: add checks to handle capabilities from firmware
> 
> Ville Syrjälä (1):
>        drm/i915: Bump GLK CDCLK frequency when driving multiple pipes
> 
> Vincent Whitchurch (1):
>        ARM: 9320/1: fix stack depot IRQ stack filter
> 
> Vitaly Prosyak (1):
>        drm/amdgpu: fix software pci_unplug on some chips
> 
> Vlad Buslov (2):
>        net/mlx5e: Fix pedit endianness
>        macvlan: Don't propagate promisc change to lower dev in passthru
> 
> Wayne Lin (1):
>        drm/amd/display: Avoid NULL dereference of timing generator
> 
> Wenchao Hao (1):
>        scsi: libfc: Fix potential NULL pointer dereference in fc_lport_ptp_setup()
> 
> Wenjing Liu (1):
>        drm/amd/display: use full update for clip size increase of large plane source
> 
> Werner Sembach (1):
>        ACPI: resource: Do IRQ override on TongFang GMxXGxx
> 
> Willem de Bruijn (1):
>        ppp: limit MRU to 64K
> 
> Wolfram Sang (1):
>        i2c: fix memleak in i2c_new_client_device()
> 
> Xiaogang Chen (1):
>        drm/amdkfd: Fix a race condition of vram buffer unref in svm code
> 
> Yi Yang (4):
>        tty: vcc: Add check for kstrdup() in vcc_probe()
>        mtd: rawnand: tegra: add missing check for platform_get_irq()
>        mtd: rawnand: intel: check return value of devm_kasprintf()
>        mtd: rawnand: meson: check return value of devm_kasprintf()
> 
> Yihang Li (1):
>        scsi: hisi_sas: Set debugfs_dir pointer to NULL after removing debugfs
> 
> Yonglong Liu (3):
>        net: hns3: add barrier in vf mailbox reply process
>        net: hns3: fix out-of-bounds access may occur when coalesce info is read via debugfs
>        net: hns3: fix variable may not initialized problem in hns3_init_mac_addr()
> 
> Yoshihiro Shimoda (1):
>        misc: pci_endpoint_test: Add Device ID for R-Car S4-8 PCIe controller
> 
> Yuezhang Mo (1):
>        exfat: support handle zero-size directory
> 
> Zhang Rui (1):
>        tools/power/turbostat: Fix a knl bug
> 
> Zhang Shurong (1):
>        iio: adc: stm32-adc: harden against NULL pointer deref in stm32_adc_probe()
> 
> Zhang Yi (1):
>        ext4: correct the start block of counting reserved clusters
> 
> ZhengHan Wang (1):
>        Bluetooth: Fix double free in hci_conn_cleanup
> 
> Zhiguo Niu (1):
>        f2fs: fix error handling of __get_node_page
> 
> Zhihao Cheng (1):
>        jbd2: fix potential data lost in recovering journal raced with synchronizing fs bdev
> 
> Zi Yan (2):
>        mm/cma: use nth_page() in place of direct struct page manipulation
>        mm/memory_hotplug: use pfn math in place of direct struct page manipulation
> 
> Zongmin Zhou (1):
>        drm/qxl: prevent memory leak
> 
> baozhu.liu (1):
>        drm/komeda: drop all currently held locks if deadlock happens
> 
> felix (1):
>        SUNRPC: Fix RPC client cleaned up the freed pipefs dentries
> 
> youwan Wang (1):
>        Bluetooth: btusb: Add date->evt_skb is NULL check
> 
> zhenwei pi (1):
>        virtio-blk: fix implicit overflow on virtio_max_dma_size
> 
> zhujun2 (1):
>        selftests/efivarfs: create-read: fix a resource leak
> 
> 
> 

--------------qYcSrBBHm10BmvZ01XJ97mIE
Content-Type: text/plain; charset=UTF-8; name="config-6.1.63"
Content-Disposition: attachment; filename="config-6.1.63"
Content-Transfer-Encoding: base64

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIGZpbGU7IERPIE5PVCBFRElULgojIExpbnV4
L3g4NiA2LjEuNjMgS2VybmVsIENvbmZpZ3VyYXRpb24KIwpDT05GSUdfQ0NfVkVSU0lPTl9U
RVhUPSJnY2MgKFVidW50dSAxMS40LjAtMXVidW50dTF+MjIuMDQpIDExLjQuMCIKQ09ORklH
X0NDX0lTX0dDQz15CkNPTkZJR19HQ0NfVkVSU0lPTj0xMTA0MDAKQ09ORklHX0NMQU5HX1ZF
UlNJT049MApDT05GSUdfQVNfSVNfR05VPXkKQ09ORklHX0FTX1ZFUlNJT049MjM4MDAKQ09O
RklHX0xEX0lTX0JGRD15CkNPTkZJR19MRF9WRVJTSU9OPTIzODAwCkNPTkZJR19MTERfVkVS
U0lPTj0wCkNPTkZJR19DQ19DQU5fTElOSz15CkNPTkZJR19DQ19DQU5fTElOS19TVEFUSUM9
eQpDT05GSUdfQ0NfSEFTX0FTTV9HT1RPX09VVFBVVD15CkNPTkZJR19DQ19IQVNfQVNNX0dP
VE9fVElFRF9PVVRQVVQ9eQpDT05GSUdfQ0NfSEFTX0FTTV9JTkxJTkU9eQpDT05GSUdfQ0Nf
SEFTX05PX1BST0ZJTEVfRk5fQVRUUj15CkNPTkZJR19QQUhPTEVfVkVSU0lPTj0wCkNPTkZJ
R19JUlFfV09SSz15CkNPTkZJR19CVUlMRFRJTUVfVEFCTEVfU09SVD15CkNPTkZJR19USFJF
QURfSU5GT19JTl9UQVNLPXkKCiMKIyBHZW5lcmFsIHNldHVwCiMKQ09ORklHX0lOSVRfRU5W
X0FSR19MSU1JVD0zMgojIENPTkZJR19DT01QSUxFX1RFU1QgaXMgbm90IHNldAojIENPTkZJ
R19XRVJST1IgaXMgbm90IHNldApDT05GSUdfTE9DQUxWRVJTSU9OPSIiCiMgQ09ORklHX0xP
Q0FMVkVSU0lPTl9BVVRPIGlzIG5vdCBzZXQKQ09ORklHX0JVSUxEX1NBTFQ9IiIKQ09ORklH
X0hBVkVfS0VSTkVMX0daSVA9eQpDT05GSUdfSEFWRV9LRVJORUxfQlpJUDI9eQpDT05GSUdf
SEFWRV9LRVJORUxfTFpNQT15CkNPTkZJR19IQVZFX0tFUk5FTF9YWj15CkNPTkZJR19IQVZF
X0tFUk5FTF9MWk89eQpDT05GSUdfSEFWRV9LRVJORUxfTFo0PXkKQ09ORklHX0hBVkVfS0VS
TkVMX1pTVEQ9eQojIENPTkZJR19LRVJORUxfR1pJUCBpcyBub3Qgc2V0CiMgQ09ORklHX0tF
Uk5FTF9CWklQMiBpcyBub3Qgc2V0CiMgQ09ORklHX0tFUk5FTF9MWk1BIGlzIG5vdCBzZXQK
IyBDT05GSUdfS0VSTkVMX1haIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VSTkVMX0xaTyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0tFUk5FTF9MWjQgaXMgbm90IHNldApDT05GSUdfS0VSTkVMX1pT
VEQ9eQpDT05GSUdfREVGQVVMVF9JTklUPSIiCkNPTkZJR19ERUZBVUxUX0hPU1ROQU1FPSIo
bm9uZSkiCkNPTkZJR19TWVNWSVBDPXkKQ09ORklHX1NZU1ZJUENfU1lTQ1RMPXkKQ09ORklH
X1NZU1ZJUENfQ09NUEFUPXkKQ09ORklHX1BPU0lYX01RVUVVRT15CkNPTkZJR19QT1NJWF9N
UVVFVUVfU1lTQ1RMPXkKQ09ORklHX1dBVENIX1FVRVVFPXkKQ09ORklHX0NST1NTX01FTU9S
WV9BVFRBQ0g9eQpDT05GSUdfVVNFTElCPXkKQ09ORklHX0FVRElUPXkKQ09ORklHX0hBVkVf
QVJDSF9BVURJVFNZU0NBTEw9eQpDT05GSUdfQVVESVRTWVNDQUxMPXkKCiMKIyBJUlEgc3Vi
c3lzdGVtCiMKQ09ORklHX0dFTkVSSUNfSVJRX1BST0JFPXkKQ09ORklHX0dFTkVSSUNfSVJR
X1NIT1c9eQpDT05GSUdfR0VORVJJQ19JUlFfRUZGRUNUSVZFX0FGRl9NQVNLPXkKQ09ORklH
X0dFTkVSSUNfUEVORElOR19JUlE9eQpDT05GSUdfR0VORVJJQ19JUlFfTUlHUkFUSU9OPXkK
Q09ORklHX0hBUkRJUlFTX1NXX1JFU0VORD15CkNPTkZJR19JUlFfRE9NQUlOPXkKQ09ORklH
X0lSUV9ET01BSU5fSElFUkFSQ0hZPXkKQ09ORklHX0dFTkVSSUNfTVNJX0lSUT15CkNPTkZJ
R19HRU5FUklDX01TSV9JUlFfRE9NQUlOPXkKQ09ORklHX0lSUV9NU0lfSU9NTVU9eQpDT05G
SUdfR0VORVJJQ19JUlFfTUFUUklYX0FMTE9DQVRPUj15CkNPTkZJR19HRU5FUklDX0lSUV9S
RVNFUlZBVElPTl9NT0RFPXkKQ09ORklHX0lSUV9GT1JDRURfVEhSRUFESU5HPXkKQ09ORklH
X1NQQVJTRV9JUlE9eQojIENPTkZJR19HRU5FUklDX0lSUV9ERUJVR0ZTIGlzIG5vdCBzZXQK
IyBlbmQgb2YgSVJRIHN1YnN5c3RlbQoKQ09ORklHX0NMT0NLU09VUkNFX1dBVENIRE9HPXkK
Q09ORklHX0FSQ0hfQ0xPQ0tTT1VSQ0VfSU5JVD15CkNPTkZJR19DTE9DS1NPVVJDRV9WQUxJ
REFURV9MQVNUX0NZQ0xFPXkKQ09ORklHX0dFTkVSSUNfVElNRV9WU1lTQ0FMTD15CkNPTkZJ
R19HRU5FUklDX0NMT0NLRVZFTlRTPXkKQ09ORklHX0dFTkVSSUNfQ0xPQ0tFVkVOVFNfQlJP
QURDQVNUPXkKQ09ORklHX0dFTkVSSUNfQ0xPQ0tFVkVOVFNfTUlOX0FESlVTVD15CkNPTkZJ
R19HRU5FUklDX0NNT1NfVVBEQVRFPXkKQ09ORklHX0hBVkVfUE9TSVhfQ1BVX1RJTUVSU19U
QVNLX1dPUks9eQpDT05GSUdfUE9TSVhfQ1BVX1RJTUVSU19UQVNLX1dPUks9eQpDT05GSUdf
Q09OVEVYVF9UUkFDS0lORz15CkNPTkZJR19DT05URVhUX1RSQUNLSU5HX0lETEU9eQoKIwoj
IFRpbWVycyBzdWJzeXN0ZW0KIwpDT05GSUdfVElDS19PTkVTSE9UPXkKQ09ORklHX05PX0ha
X0NPTU1PTj15CiMgQ09ORklHX0haX1BFUklPRElDIGlzIG5vdCBzZXQKQ09ORklHX05PX0ha
X0lETEU9eQojIENPTkZJR19OT19IWl9GVUxMIGlzIG5vdCBzZXQKQ09ORklHX05PX0haPXkK
Q09ORklHX0hJR0hfUkVTX1RJTUVSUz15CkNPTkZJR19DTE9DS1NPVVJDRV9XQVRDSERPR19N
QVhfU0tFV19VUz0xMDAKIyBlbmQgb2YgVGltZXJzIHN1YnN5c3RlbQoKQ09ORklHX0JQRj15
CkNPTkZJR19IQVZFX0VCUEZfSklUPXkKQ09ORklHX0FSQ0hfV0FOVF9ERUZBVUxUX0JQRl9K
SVQ9eQoKIwojIEJQRiBzdWJzeXN0ZW0KIwpDT05GSUdfQlBGX1NZU0NBTEw9eQpDT05GSUdf
QlBGX0pJVD15CkNPTkZJR19CUEZfSklUX0FMV0FZU19PTj15CkNPTkZJR19CUEZfSklUX0RF
RkFVTFRfT049eQpDT05GSUdfQlBGX1VOUFJJVl9ERUZBVUxUX09GRj15CiMgQ09ORklHX0JQ
Rl9QUkVMT0FEIGlzIG5vdCBzZXQKIyBlbmQgb2YgQlBGIHN1YnN5c3RlbQoKQ09ORklHX1BS
RUVNUFRfQlVJTEQ9eQpDT05GSUdfUFJFRU1QVF9OT05FPXkKIyBDT05GSUdfUFJFRU1QVF9W
T0xVTlRBUlkgaXMgbm90IHNldAojIENPTkZJR19QUkVFTVBUIGlzIG5vdCBzZXQKQ09ORklH
X1BSRUVNUFRfQ09VTlQ9eQpDT05GSUdfUFJFRU1QVElPTj15CkNPTkZJR19QUkVFTVBUX0RZ
TkFNSUM9eQpDT05GSUdfU0NIRURfQ09SRT15CgojCiMgQ1BVL1Rhc2sgdGltZSBhbmQgc3Rh
dHMgYWNjb3VudGluZwojCkNPTkZJR19USUNLX0NQVV9BQ0NPVU5USU5HPXkKIyBDT05GSUdf
VklSVF9DUFVfQUNDT1VOVElOR19HRU4gaXMgbm90IHNldAojIENPTkZJR19JUlFfVElNRV9B
Q0NPVU5USU5HIGlzIG5vdCBzZXQKQ09ORklHX0JTRF9QUk9DRVNTX0FDQ1Q9eQpDT05GSUdf
QlNEX1BST0NFU1NfQUNDVF9WMz15CkNPTkZJR19UQVNLU1RBVFM9eQpDT05GSUdfVEFTS19E
RUxBWV9BQ0NUPXkKQ09ORklHX1RBU0tfWEFDQ1Q9eQpDT05GSUdfVEFTS19JT19BQ0NPVU5U
SU5HPXkKQ09ORklHX1BTST15CiMgQ09ORklHX1BTSV9ERUZBVUxUX0RJU0FCTEVEIGlzIG5v
dCBzZXQKIyBlbmQgb2YgQ1BVL1Rhc2sgdGltZSBhbmQgc3RhdHMgYWNjb3VudGluZwoKQ09O
RklHX0NQVV9JU09MQVRJT049eQoKIwojIFJDVSBTdWJzeXN0ZW0KIwpDT05GSUdfVFJFRV9S
Q1U9eQpDT05GSUdfUFJFRU1QVF9SQ1U9eQojIENPTkZJR19SQ1VfRVhQRVJUIGlzIG5vdCBz
ZXQKQ09ORklHX1NSQ1U9eQpDT05GSUdfVFJFRV9TUkNVPXkKQ09ORklHX1RBU0tTX1JDVV9H
RU5FUklDPXkKQ09ORklHX1RBU0tTX1JDVT15CkNPTkZJR19UQVNLU19UUkFDRV9SQ1U9eQpD
T05GSUdfUkNVX1NUQUxMX0NPTU1PTj15CkNPTkZJR19SQ1VfTkVFRF9TRUdDQkxJU1Q9eQoj
IGVuZCBvZiBSQ1UgU3Vic3lzdGVtCgojIENPTkZJR19JS0NPTkZJRyBpcyBub3Qgc2V0CkNP
TkZJR19JS0hFQURFUlM9bQpDT05GSUdfTE9HX0JVRl9TSElGVD0xOApDT05GSUdfTE9HX0NQ
VV9NQVhfQlVGX1NISUZUPTEyCkNPTkZJR19QUklOVEtfU0FGRV9MT0dfQlVGX1NISUZUPTEz
CiMgQ09ORklHX1BSSU5US19JTkRFWCBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX1VOU1RBQkxF
X1NDSEVEX0NMT0NLPXkKCiMKIyBTY2hlZHVsZXIgZmVhdHVyZXMKIwpDT05GSUdfVUNMQU1Q
X1RBU0s9eQpDT05GSUdfVUNMQU1QX0JVQ0tFVFNfQ09VTlQ9NQojIGVuZCBvZiBTY2hlZHVs
ZXIgZmVhdHVyZXMKCkNPTkZJR19BUkNIX1NVUFBPUlRTX05VTUFfQkFMQU5DSU5HPXkKQ09O
RklHX0FSQ0hfV0FOVF9CQVRDSEVEX1VOTUFQX1RMQl9GTFVTSD15CkNPTkZJR19DQ19IQVNf
SU5UMTI4PXkKQ09ORklHX0NDX0lNUExJQ0lUX0ZBTExUSFJPVUdIPSItV2ltcGxpY2l0LWZh
bGx0aHJvdWdoPTUiCkNPTkZJR19HQ0MxMV9OT19BUlJBWV9CT1VORFM9eQpDT05GSUdfQ0Nf
Tk9fQVJSQVlfQk9VTkRTPXkKQ09ORklHX0FSQ0hfU1VQUE9SVFNfSU5UMTI4PXkKQ09ORklH
X05VTUFfQkFMQU5DSU5HPXkKQ09ORklHX05VTUFfQkFMQU5DSU5HX0RFRkFVTFRfRU5BQkxF
RD15CkNPTkZJR19DR1JPVVBTPXkKQ09ORklHX1BBR0VfQ09VTlRFUj15CiMgQ09ORklHX0NH
Uk9VUF9GQVZPUl9EWU5NT0RTIGlzIG5vdCBzZXQKQ09ORklHX01FTUNHPXkKQ09ORklHX01F
TUNHX0tNRU09eQpDT05GSUdfQkxLX0NHUk9VUD15CkNPTkZJR19DR1JPVVBfV1JJVEVCQUNL
PXkKQ09ORklHX0NHUk9VUF9TQ0hFRD15CkNPTkZJR19GQUlSX0dST1VQX1NDSEVEPXkKQ09O
RklHX0NGU19CQU5EV0lEVEg9eQojIENPTkZJR19SVF9HUk9VUF9TQ0hFRCBpcyBub3Qgc2V0
CkNPTkZJR19VQ0xBTVBfVEFTS19HUk9VUD15CkNPTkZJR19DR1JPVVBfUElEUz15CkNPTkZJ
R19DR1JPVVBfUkRNQT15CkNPTkZJR19DR1JPVVBfRlJFRVpFUj15CkNPTkZJR19DR1JPVVBf
SFVHRVRMQj15CkNPTkZJR19DUFVTRVRTPXkKQ09ORklHX1BST0NfUElEX0NQVVNFVD15CkNP
TkZJR19DR1JPVVBfREVWSUNFPXkKQ09ORklHX0NHUk9VUF9DUFVBQ0NUPXkKQ09ORklHX0NH
Uk9VUF9QRVJGPXkKQ09ORklHX0NHUk9VUF9CUEY9eQpDT05GSUdfQ0dST1VQX01JU0M9eQpD
T05GSUdfU09DS19DR1JPVVBfREFUQT15CkNPTkZJR19OQU1FU1BBQ0VTPXkKQ09ORklHX1VU
U19OUz15CkNPTkZJR19USU1FX05TPXkKQ09ORklHX0lQQ19OUz15CkNPTkZJR19VU0VSX05T
PXkKQ09ORklHX1BJRF9OUz15CkNPTkZJR19ORVRfTlM9eQpDT05GSUdfQ0hFQ0tQT0lOVF9S
RVNUT1JFPXkKQ09ORklHX1NDSEVEX0FVVE9HUk9VUD15CiMgQ09ORklHX1NZU0ZTX0RFUFJF
Q0FURUQgaXMgbm90IHNldApDT05GSUdfUkVMQVk9eQpDT05GSUdfQkxLX0RFVl9JTklUUkQ9
eQpDT05GSUdfSU5JVFJBTUZTX1NPVVJDRT0iIgojIENPTkZJR19SRF9HWklQIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUkRfQlpJUDIgaXMgbm90IHNldAojIENPTkZJR19SRF9MWk1BIGlzIG5v
dCBzZXQKIyBDT05GSUdfUkRfWFogaXMgbm90IHNldAojIENPTkZJR19SRF9MWk8gaXMgbm90
IHNldApDT05GSUdfUkRfTFo0PXkKQ09ORklHX1JEX1pTVEQ9eQpDT05GSUdfQk9PVF9DT05G
SUc9eQojIENPTkZJR19CT09UX0NPTkZJR19FTUJFRCBpcyBub3Qgc2V0CkNPTkZJR19JTklU
UkFNRlNfUFJFU0VSVkVfTVRJTUU9eQpDT05GSUdfQ0NfT1BUSU1JWkVfRk9SX1BFUkZPUk1B
TkNFPXkKIyBDT05GSUdfQ0NfT1BUSU1JWkVfRk9SX1NJWkUgaXMgbm90IHNldApDT05GSUdf
TERfT1JQSEFOX1dBUk49eQpDT05GSUdfU1lTQ1RMPXkKQ09ORklHX0hBVkVfVUlEMTY9eQpD
T05GSUdfU1lTQ1RMX0VYQ0VQVElPTl9UUkFDRT15CkNPTkZJR19IQVZFX1BDU1BLUl9QTEFU
Rk9STT15CiMgQ09ORklHX0VYUEVSVCBpcyBub3Qgc2V0CkNPTkZJR19VSUQxNj15CkNPTkZJ
R19NVUxUSVVTRVI9eQpDT05GSUdfU0dFVE1BU0tfU1lTQ0FMTD15CkNPTkZJR19TWVNGU19T
WVNDQUxMPXkKQ09ORklHX0ZIQU5ETEU9eQpDT05GSUdfUE9TSVhfVElNRVJTPXkKQ09ORklH
X1BSSU5USz15CkNPTkZJR19CVUc9eQpDT05GSUdfRUxGX0NPUkU9eQpDT05GSUdfUENTUEtS
X1BMQVRGT1JNPXkKQ09ORklHX0JBU0VfRlVMTD15CkNPTkZJR19GVVRFWD15CkNPTkZJR19G
VVRFWF9QST15CkNPTkZJR19FUE9MTD15CkNPTkZJR19TSUdOQUxGRD15CkNPTkZJR19USU1F
UkZEPXkKQ09ORklHX0VWRU5URkQ9eQpDT05GSUdfU0hNRU09eQpDT05GSUdfQUlPPXkKQ09O
RklHX0lPX1VSSU5HPXkKQ09ORklHX0FEVklTRV9TWVNDQUxMUz15CkNPTkZJR19NRU1CQVJS
SUVSPXkKQ09ORklHX0tBTExTWU1TPXkKQ09ORklHX0tBTExTWU1TX0FCU09MVVRFX1BFUkNQ
VT15CkNPTkZJR19LQUxMU1lNU19CQVNFX1JFTEFUSVZFPXkKQ09ORklHX0FSQ0hfSEFTX01F
TUJBUlJJRVJfU1lOQ19DT1JFPXkKQ09ORklHX0tDTVA9eQpDT05GSUdfUlNFUT15CiMgQ09O
RklHX0VNQkVEREVEIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfUEVSRl9FVkVOVFM9eQpDT05G
SUdfR1VFU1RfUEVSRl9FVkVOVFM9eQoKIwojIEtlcm5lbCBQZXJmb3JtYW5jZSBFdmVudHMg
QW5kIENvdW50ZXJzCiMKQ09ORklHX1BFUkZfRVZFTlRTPXkKIyBlbmQgb2YgS2VybmVsIFBl
cmZvcm1hbmNlIEV2ZW50cyBBbmQgQ291bnRlcnMKCkNPTkZJR19TWVNURU1fREFUQV9WRVJJ
RklDQVRJT049eQojIENPTkZJR19QUk9GSUxJTkcgaXMgbm90IHNldAojIGVuZCBvZiBHZW5l
cmFsIHNldHVwCgpDT05GSUdfNjRCSVQ9eQpDT05GSUdfWDg2XzY0PXkKQ09ORklHX1g4Nj15
CkNPTkZJR19JTlNUUlVDVElPTl9ERUNPREVSPXkKQ09ORklHX09VVFBVVF9GT1JNQVQ9ImVs
ZjY0LXg4Ni02NCIKQ09ORklHX0xPQ0tERVBfU1VQUE9SVD15CkNPTkZJR19TVEFDS1RSQUNF
X1NVUFBPUlQ9eQpDT05GSUdfTU1VPXkKQ09ORklHX0FSQ0hfTU1BUF9STkRfQklUU19NSU49
MjgKQ09ORklHX0FSQ0hfTU1BUF9STkRfQklUU19NQVg9MzIKQ09ORklHX0FSQ0hfTU1BUF9S
TkRfQ09NUEFUX0JJVFNfTUlOPTgKQ09ORklHX0FSQ0hfTU1BUF9STkRfQ09NUEFUX0JJVFNf
TUFYPTE2CkNPTkZJR19HRU5FUklDX0lTQV9ETUE9eQpDT05GSUdfR0VORVJJQ19CVUc9eQpD
T05GSUdfR0VORVJJQ19CVUdfUkVMQVRJVkVfUE9JTlRFUlM9eQpDT05GSUdfQVJDSF9NQVlf
SEFWRV9QQ19GREM9eQpDT05GSUdfR0VORVJJQ19DQUxJQlJBVEVfREVMQVk9eQpDT05GSUdf
QVJDSF9IQVNfQ1BVX1JFTEFYPXkKQ09ORklHX0FSQ0hfSElCRVJOQVRJT05fUE9TU0lCTEU9
eQpDT05GSUdfQVJDSF9OUl9HUElPPTEwMjQKQ09ORklHX0FSQ0hfU1VTUEVORF9QT1NTSUJM
RT15CkNPTkZJR19BVURJVF9BUkNIPXkKQ09ORklHX0hBVkVfSU5URUxfVFhUPXkKQ09ORklH
X1g4Nl82NF9TTVA9eQpDT05GSUdfQVJDSF9TVVBQT1JUU19VUFJPQkVTPXkKQ09ORklHX0ZJ
WF9FQVJMWUNPTl9NRU09eQpDT05GSUdfUEdUQUJMRV9MRVZFTFM9NQpDT05GSUdfQ0NfSEFT
X1NBTkVfU1RBQ0tQUk9URUNUT1I9eQoKIwojIFByb2Nlc3NvciB0eXBlIGFuZCBmZWF0dXJl
cwojCkNPTkZJR19TTVA9eQpDT05GSUdfWDg2X0ZFQVRVUkVfTkFNRVM9eQpDT05GSUdfWDg2
X1gyQVBJQz15CkNPTkZJR19YODZfTVBQQVJTRT15CiMgQ09ORklHX0dPTERGSVNIIGlzIG5v
dCBzZXQKQ09ORklHX1g4Nl9DUFVfUkVTQ1RSTD15CkNPTkZJR19YODZfRVhURU5ERURfUExB
VEZPUk09eQpDT05GSUdfWDg2X05VTUFDSElQPXkKIyBDT05GSUdfWDg2X1ZTTVAgaXMgbm90
IHNldAojIENPTkZJR19YODZfVVYgaXMgbm90IHNldAojIENPTkZJR19YODZfR09MREZJU0gg
aXMgbm90IHNldAojIENPTkZJR19YODZfSU5URUxfTUlEIGlzIG5vdCBzZXQKQ09ORklHX1g4
Nl9JTlRFTF9MUFNTPXkKIyBDT05GSUdfWDg2X0FNRF9QTEFURk9STV9ERVZJQ0UgaXMgbm90
IHNldApDT05GSUdfSU9TRl9NQkk9eQpDT05GSUdfSU9TRl9NQklfREVCVUc9eQpDT05GSUdf
WDg2X1NVUFBPUlRTX01FTU9SWV9GQUlMVVJFPXkKQ09ORklHX1NDSEVEX09NSVRfRlJBTUVf
UE9JTlRFUj15CiMgQ09ORklHX0hZUEVSVklTT1JfR1VFU1QgaXMgbm90IHNldAojIENPTkZJ
R19NSzggaXMgbm90IHNldAojIENPTkZJR19NUFNDIGlzIG5vdCBzZXQKQ09ORklHX01DT1JF
Mj15CiMgQ09ORklHX01BVE9NIGlzIG5vdCBzZXQKIyBDT05GSUdfR0VORVJJQ19DUFUgaXMg
bm90IHNldApDT05GSUdfWDg2X0lOVEVSTk9ERV9DQUNIRV9TSElGVD02CkNPTkZJR19YODZf
TDFfQ0FDSEVfU0hJRlQ9NgpDT05GSUdfWDg2X0lOVEVMX1VTRVJDT1BZPXkKQ09ORklHX1g4
Nl9VU0VfUFBST19DSEVDS1NVTT15CkNPTkZJR19YODZfUDZfTk9QPXkKQ09ORklHX1g4Nl9U
U0M9eQpDT05GSUdfWDg2X0NNUFhDSEc2ND15CkNPTkZJR19YODZfQ01PVj15CkNPTkZJR19Y
ODZfTUlOSU1VTV9DUFVfRkFNSUxZPTY0CkNPTkZJR19YODZfREVCVUdDVExNU1I9eQpDT05G
SUdfSUEzMl9GRUFUX0NUTD15CkNPTkZJR19YODZfVk1YX0ZFQVRVUkVfTkFNRVM9eQpDT05G
SUdfQ1BVX1NVUF9JTlRFTD15CkNPTkZJR19DUFVfU1VQX0FNRD15CkNPTkZJR19DUFVfU1VQ
X0hZR09OPXkKQ09ORklHX0NQVV9TVVBfQ0VOVEFVUj15CkNPTkZJR19DUFVfU1VQX1pIQU9Y
SU49eQpDT05GSUdfSFBFVF9USU1FUj15CkNPTkZJR19IUEVUX0VNVUxBVEVfUlRDPXkKQ09O
RklHX0RNST15CiMgQ09ORklHX0dBUlRfSU9NTVUgaXMgbm90IHNldApDT05GSUdfQk9PVF9W
RVNBX1NVUFBPUlQ9eQpDT05GSUdfTlJfQ1BVU19SQU5HRV9CRUdJTj0yCkNPTkZJR19OUl9D
UFVTX1JBTkdFX0VORD01MTIKQ09ORklHX05SX0NQVVNfREVGQVVMVD02NApDT05GSUdfTlJf
Q1BVUz02NApDT05GSUdfU0NIRURfQ0xVU1RFUj15CkNPTkZJR19TQ0hFRF9TTVQ9eQpDT05G
SUdfU0NIRURfTUM9eQpDT05GSUdfU0NIRURfTUNfUFJJTz15CkNPTkZJR19YODZfTE9DQUxf
QVBJQz15CkNPTkZJR19YODZfSU9fQVBJQz15CkNPTkZJR19YODZfUkVST1VURV9GT1JfQlJP
S0VOX0JPT1RfSVJRUz15CkNPTkZJR19YODZfTUNFPXkKQ09ORklHX1g4Nl9NQ0VMT0dfTEVH
QUNZPXkKQ09ORklHX1g4Nl9NQ0VfSU5URUw9eQpDT05GSUdfWDg2X01DRV9BTUQ9eQpDT05G
SUdfWDg2X01DRV9USFJFU0hPTEQ9eQpDT05GSUdfWDg2X01DRV9JTkpFQ1Q9bQoKIwojIFBl
cmZvcm1hbmNlIG1vbml0b3JpbmcKIwpDT05GSUdfUEVSRl9FVkVOVFNfSU5URUxfVU5DT1JF
PXkKQ09ORklHX1BFUkZfRVZFTlRTX0lOVEVMX1JBUEw9bQpDT05GSUdfUEVSRl9FVkVOVFNf
SU5URUxfQ1NUQVRFPW0KIyBDT05GSUdfUEVSRl9FVkVOVFNfQU1EX1BPV0VSIGlzIG5vdCBz
ZXQKQ09ORklHX1BFUkZfRVZFTlRTX0FNRF9VTkNPUkU9eQojIENPTkZJR19QRVJGX0VWRU5U
U19BTURfQlJTIGlzIG5vdCBzZXQKIyBlbmQgb2YgUGVyZm9ybWFuY2UgbW9uaXRvcmluZwoK
Q09ORklHX1g4Nl8xNkJJVD15CkNPTkZJR19YODZfRVNQRklYNjQ9eQpDT05GSUdfWDg2X1ZT
WVNDQUxMX0VNVUxBVElPTj15CkNPTkZJR19YODZfSU9QTF9JT1BFUk09eQpDT05GSUdfTUlD
Uk9DT0RFPXkKQ09ORklHX01JQ1JPQ09ERV9JTlRFTD15CiMgQ09ORklHX01JQ1JPQ09ERV9B
TUQgaXMgbm90IHNldAojIENPTkZJR19NSUNST0NPREVfTEFURV9MT0FESU5HIGlzIG5vdCBz
ZXQKQ09ORklHX1g4Nl9NU1I9bQpDT05GSUdfWDg2X0NQVUlEPW0KQ09ORklHX1g4Nl81TEVW
RUw9eQpDT05GSUdfWDg2X0RJUkVDVF9HQlBBR0VTPXkKIyBDT05GSUdfWDg2X0NQQV9TVEFU
SVNUSUNTIGlzIG5vdCBzZXQKIyBDT05GSUdfQU1EX01FTV9FTkNSWVBUIGlzIG5vdCBzZXQK
Q09ORklHX05VTUE9eQpDT05GSUdfQU1EX05VTUE9eQpDT05GSUdfWDg2XzY0X0FDUElfTlVN
QT15CiMgQ09ORklHX05VTUFfRU1VIGlzIG5vdCBzZXQKQ09ORklHX05PREVTX1NISUZUPTYK
Q09ORklHX0FSQ0hfU1BBUlNFTUVNX0VOQUJMRT15CkNPTkZJR19BUkNIX1NQQVJTRU1FTV9E
RUZBVUxUPXkKQ09ORklHX0FSQ0hfTUVNT1JZX1BST0JFPXkKQ09ORklHX0FSQ0hfUFJPQ19L
Q09SRV9URVhUPXkKQ09ORklHX0lMTEVHQUxfUE9JTlRFUl9WQUxVRT0weGRlYWQwMDAwMDAw
MDAwMDAKQ09ORklHX1g4Nl9QTUVNX0xFR0FDWV9ERVZJQ0U9eQpDT05GSUdfWDg2X1BNRU1f
TEVHQUNZPXkKQ09ORklHX1g4Nl9DSEVDS19CSU9TX0NPUlJVUFRJT049eQpDT05GSUdfWDg2
X0JPT1RQQVJBTV9NRU1PUllfQ09SUlVQVElPTl9DSEVDSz15CkNPTkZJR19NVFJSPXkKQ09O
RklHX01UUlJfU0FOSVRJWkVSPXkKQ09ORklHX01UUlJfU0FOSVRJWkVSX0VOQUJMRV9ERUZB
VUxUPTEKQ09ORklHX01UUlJfU0FOSVRJWkVSX1NQQVJFX1JFR19OUl9ERUZBVUxUPTEKQ09O
RklHX1g4Nl9QQVQ9eQpDT05GSUdfQVJDSF9VU0VTX1BHX1VOQ0FDSEVEPXkKQ09ORklHX1g4
Nl9VTUlQPXkKQ09ORklHX0NDX0hBU19JQlQ9eQojIENPTkZJR19YODZfS0VSTkVMX0lCVCBp
cyBub3Qgc2V0CkNPTkZJR19YODZfSU5URUxfTUVNT1JZX1BST1RFQ1RJT05fS0VZUz15CkNP
TkZJR19YODZfSU5URUxfVFNYX01PREVfT0ZGPXkKIyBDT05GSUdfWDg2X0lOVEVMX1RTWF9N
T0RFX09OIGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2X0lOVEVMX1RTWF9NT0RFX0FVVE8gaXMg
bm90IHNldApDT05GSUdfWDg2X1NHWD15CkNPTkZJR19FRkk9eQpDT05GSUdfRUZJX1NUVUI9
eQpDT05GSUdfRUZJX01JWEVEPXkKIyBDT05GSUdfSFpfMTAwIGlzIG5vdCBzZXQKQ09ORklH
X0haXzI1MD15CiMgQ09ORklHX0haXzMwMCBpcyBub3Qgc2V0CiMgQ09ORklHX0haXzEwMDAg
aXMgbm90IHNldApDT05GSUdfSFo9MjUwCkNPTkZJR19TQ0hFRF9IUlRJQ0s9eQpDT05GSUdf
S0VYRUM9eQpDT05GSUdfS0VYRUNfRklMRT15CkNPTkZJR19BUkNIX0hBU19LRVhFQ19QVVJH
QVRPUlk9eQpDT05GSUdfS0VYRUNfU0lHPXkKIyBDT05GSUdfS0VYRUNfU0lHX0ZPUkNFIGlz
IG5vdCBzZXQKQ09ORklHX0tFWEVDX0JaSU1BR0VfVkVSSUZZX1NJRz15CkNPTkZJR19DUkFT
SF9EVU1QPXkKQ09ORklHX1BIWVNJQ0FMX1NUQVJUPTB4MTAwMDAwMApDT05GSUdfUkVMT0NB
VEFCTEU9eQpDT05GSUdfUkFORE9NSVpFX0JBU0U9eQpDT05GSUdfWDg2X05FRURfUkVMT0NT
PXkKQ09ORklHX1BIWVNJQ0FMX0FMSUdOPTB4MjAwMDAwCkNPTkZJR19EWU5BTUlDX01FTU9S
WV9MQVlPVVQ9eQpDT05GSUdfUkFORE9NSVpFX01FTU9SWT15CkNPTkZJR19SQU5ET01JWkVf
TUVNT1JZX1BIWVNJQ0FMX1BBRERJTkc9MHhhCkNPTkZJR19IT1RQTFVHX0NQVT15CiMgQ09O
RklHX0JPT1RQQVJBTV9IT1RQTFVHX0NQVTAgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19I
T1RQTFVHX0NQVTAgaXMgbm90IHNldAojIENPTkZJR19DT01QQVRfVkRTTyBpcyBub3Qgc2V0
CkNPTkZJR19MRUdBQ1lfVlNZU0NBTExfWE9OTFk9eQojIENPTkZJR19MRUdBQ1lfVlNZU0NB
TExfTk9ORSBpcyBub3Qgc2V0CiMgQ09ORklHX0NNRExJTkVfQk9PTCBpcyBub3Qgc2V0CkNP
TkZJR19NT0RJRllfTERUX1NZU0NBTEw9eQojIENPTkZJR19TVFJJQ1RfU0lHQUxUU1RBQ0tf
U0laRSBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX0xJVkVQQVRDSD15CiMgZW5kIG9mIFByb2Nl
c3NvciB0eXBlIGFuZCBmZWF0dXJlcwoKQ09ORklHX0NDX0hBU19TTFM9eQpDT05GSUdfQ0Nf
SEFTX1JFVFVSTl9USFVOSz15CkNPTkZJR19TUEVDVUxBVElPTl9NSVRJR0FUSU9OUz15CkNP
TkZJR19QQUdFX1RBQkxFX0lTT0xBVElPTj15CkNPTkZJR19SRVRQT0xJTkU9eQpDT05GSUdf
UkVUSFVOSz15CkNPTkZJR19DUFVfVU5SRVRfRU5UUlk9eQpDT05GSUdfQ1BVX0lCUEJfRU5U
Ulk9eQpDT05GSUdfQ1BVX0lCUlNfRU5UUlk9eQpDT05GSUdfQ1BVX1NSU089eQpDT05GSUdf
U0xTPXkKIyBDT05GSUdfR0RTX0ZPUkNFX01JVElHQVRJT04gaXMgbm90IHNldApDT05GSUdf
QVJDSF9IQVNfQUREX1BBR0VTPXkKQ09ORklHX0FSQ0hfTUhQX01FTU1BUF9PTl9NRU1PUllf
RU5BQkxFPXkKCiMKIyBQb3dlciBtYW5hZ2VtZW50IGFuZCBBQ1BJIG9wdGlvbnMKIwojIENP
TkZJR19TVVNQRU5EIGlzIG5vdCBzZXQKIyBDT05GSUdfSElCRVJOQVRJT04gaXMgbm90IHNl
dApDT05GSUdfUE09eQpDT05GSUdfUE1fREVCVUc9eQpDT05GSUdfUE1fQURWQU5DRURfREVC
VUc9eQpDT05GSUdfUE1fQ0xLPXkKQ09ORklHX1dRX1BPV0VSX0VGRklDSUVOVF9ERUZBVUxU
PXkKQ09ORklHX0VORVJHWV9NT0RFTD15CkNPTkZJR19BUkNIX1NVUFBPUlRTX0FDUEk9eQpD
T05GSUdfQUNQST15CkNPTkZJR19BQ1BJX0xFR0FDWV9UQUJMRVNfTE9PS1VQPXkKQ09ORklH
X0FSQ0hfTUlHSFRfSEFWRV9BQ1BJX1BEQz15CkNPTkZJR19BQ1BJX1NZU1RFTV9QT1dFUl9T
VEFURVNfU1VQUE9SVD15CkNPTkZJR19BQ1BJX0RFQlVHR0VSPXkKQ09ORklHX0FDUElfREVC
VUdHRVJfVVNFUj15CkNPTkZJR19BQ1BJX1NQQ1JfVEFCTEU9eQpDT05GSUdfQUNQSV9GUERU
PXkKQ09ORklHX0FDUElfTFBJVD15CkNPTkZJR19BQ1BJX1JFVl9PVkVSUklERV9QT1NTSUJM
RT15CkNPTkZJR19BQ1BJX0VDX0RFQlVHRlM9bQpDT05GSUdfQUNQSV9BQz15CkNPTkZJR19B
Q1BJX0JBVFRFUlk9eQpDT05GSUdfQUNQSV9CVVRUT049eQpDT05GSUdfQUNQSV9WSURFTz1t
CkNPTkZJR19BQ1BJX0ZBTj15CkNPTkZJR19BQ1BJX0RPQ0s9eQpDT05GSUdfQUNQSV9DUFVf
RlJFUV9QU1M9eQpDT05GSUdfQUNQSV9QUk9DRVNTT1JfQ1NUQVRFPXkKQ09ORklHX0FDUElf
UFJPQ0VTU09SX0lETEU9eQpDT05GSUdfQUNQSV9DUFBDX0xJQj15CkNPTkZJR19BQ1BJX1BS
T0NFU1NPUj15CkNPTkZJR19BQ1BJX0lQTUk9bQpDT05GSUdfQUNQSV9IT1RQTFVHX0NQVT15
CkNPTkZJR19BQ1BJX1BST0NFU1NPUl9BR0dSRUdBVE9SPW0KQ09ORklHX0FDUElfVEhFUk1B
TD15CkNPTkZJR19BQ1BJX0NVU1RPTV9EU0RUX0ZJTEU9IiIKQ09ORklHX0FSQ0hfSEFTX0FD
UElfVEFCTEVfVVBHUkFERT15CkNPTkZJR19BQ1BJX1RBQkxFX1VQR1JBREU9eQpDT05GSUdf
QUNQSV9ERUJVRz15CkNPTkZJR19BQ1BJX1BDSV9TTE9UPXkKQ09ORklHX0FDUElfQ09OVEFJ
TkVSPXkKQ09ORklHX0FDUElfSE9UUExVR19NRU1PUlk9eQpDT05GSUdfQUNQSV9IT1RQTFVH
X0lPQVBJQz15CkNPTkZJR19BQ1BJX1NCUz1tCkNPTkZJR19BQ1BJX0hFRD15CiMgQ09ORklH
X0FDUElfQ1VTVE9NX01FVEhPRCBpcyBub3Qgc2V0CkNPTkZJR19BQ1BJX0JHUlQ9eQpDT05G
SUdfQUNQSV9ORklUPW0KIyBDT05GSUdfTkZJVF9TRUNVUklUWV9ERUJVRyBpcyBub3Qgc2V0
CkNPTkZJR19BQ1BJX05VTUE9eQpDT05GSUdfQUNQSV9ITUFUPXkKQ09ORklHX0hBVkVfQUNQ
SV9BUEVJPXkKQ09ORklHX0hBVkVfQUNQSV9BUEVJX05NST15CkNPTkZJR19BQ1BJX0FQRUk9
eQpDT05GSUdfQUNQSV9BUEVJX0dIRVM9eQpDT05GSUdfQUNQSV9BUEVJX1BDSUVBRVI9eQpD
T05GSUdfQUNQSV9BUEVJX01FTU9SWV9GQUlMVVJFPXkKQ09ORklHX0FDUElfQVBFSV9FSU5K
PW0KIyBDT05GSUdfQUNQSV9BUEVJX0VSU1RfREVCVUcgaXMgbm90IHNldApDT05GSUdfQUNQ
SV9EUFRGPXkKQ09ORklHX0RQVEZfUE9XRVI9bQpDT05GSUdfRFBURl9QQ0hfRklWUj1tCkNP
TkZJR19BQ1BJX0NPTkZJR0ZTPW0KIyBDT05GSUdfQUNQSV9QRlJVVCBpcyBub3Qgc2V0CkNP
TkZJR19BQ1BJX1BDQz15CkNPTkZJR19QTUlDX09QUkVHSU9OPXkKQ09ORklHX0FDUElfUFJN
VD15CkNPTkZJR19YODZfUE1fVElNRVI9eQoKIwojIENQVSBGcmVxdWVuY3kgc2NhbGluZwoj
CkNPTkZJR19DUFVfRlJFUT15CkNPTkZJR19DUFVfRlJFUV9HT1ZfQVRUUl9TRVQ9eQpDT05G
SUdfQ1BVX0ZSRVFfR09WX0NPTU1PTj15CkNPTkZJR19DUFVfRlJFUV9TVEFUPXkKIyBDT05G
SUdfQ1BVX0ZSRVFfREVGQVVMVF9HT1ZfUEVSRk9STUFOQ0UgaXMgbm90IHNldAojIENPTkZJ
R19DUFVfRlJFUV9ERUZBVUxUX0dPVl9QT1dFUlNBVkUgaXMgbm90IHNldAojIENPTkZJR19D
UFVfRlJFUV9ERUZBVUxUX0dPVl9VU0VSU1BBQ0UgaXMgbm90IHNldApDT05GSUdfQ1BVX0ZS
RVFfREVGQVVMVF9HT1ZfU0NIRURVVElMPXkKQ09ORklHX0NQVV9GUkVRX0dPVl9QRVJGT1JN
QU5DRT15CkNPTkZJR19DUFVfRlJFUV9HT1ZfUE9XRVJTQVZFPXkKQ09ORklHX0NQVV9GUkVR
X0dPVl9VU0VSU1BBQ0U9eQpDT05GSUdfQ1BVX0ZSRVFfR09WX09OREVNQU5EPXkKQ09ORklH
X0NQVV9GUkVRX0dPVl9DT05TRVJWQVRJVkU9eQpDT05GSUdfQ1BVX0ZSRVFfR09WX1NDSEVE
VVRJTD15CgojCiMgQ1BVIGZyZXF1ZW5jeSBzY2FsaW5nIGRyaXZlcnMKIwpDT05GSUdfWDg2
X0lOVEVMX1BTVEFURT15CkNPTkZJR19YODZfUENDX0NQVUZSRVE9eQpDT05GSUdfWDg2X0FN
RF9QU1RBVEU9eQojIENPTkZJR19YODZfQU1EX1BTVEFURV9VVCBpcyBub3Qgc2V0CkNPTkZJ
R19YODZfQUNQSV9DUFVGUkVRPXkKQ09ORklHX1g4Nl9BQ1BJX0NQVUZSRVFfQ1BCPXkKQ09O
RklHX1g4Nl9QT1dFUk5PV19LOD15CiMgQ09ORklHX1g4Nl9BTURfRlJFUV9TRU5TSVRJVklU
WSBpcyBub3Qgc2V0CkNPTkZJR19YODZfU1BFRURTVEVQX0NFTlRSSU5PPXkKQ09ORklHX1g4
Nl9QNF9DTE9DS01PRD1tCgojCiMgc2hhcmVkIG9wdGlvbnMKIwpDT05GSUdfWDg2X1NQRUVE
U1RFUF9MSUI9bQojIGVuZCBvZiBDUFUgRnJlcXVlbmN5IHNjYWxpbmcKCiMKIyBDUFUgSWRs
ZQojCkNPTkZJR19DUFVfSURMRT15CkNPTkZJR19DUFVfSURMRV9HT1ZfTEFEREVSPXkKQ09O
RklHX0NQVV9JRExFX0dPVl9NRU5VPXkKQ09ORklHX0NQVV9JRExFX0dPVl9URU89eQojIGVu
ZCBvZiBDUFUgSWRsZQoKQ09ORklHX0lOVEVMX0lETEU9eQojIGVuZCBvZiBQb3dlciBtYW5h
Z2VtZW50IGFuZCBBQ1BJIG9wdGlvbnMKCiMKIyBCdXMgb3B0aW9ucyAoUENJIGV0Yy4pCiMK
Q09ORklHX1BDSV9ESVJFQ1Q9eQpDT05GSUdfUENJX01NQ09ORklHPXkKQ09ORklHX01NQ09O
Rl9GQU0xMEg9eQpDT05GSUdfSVNBX0RNQV9BUEk9eQpDT05GSUdfQU1EX05CPXkKIyBlbmQg
b2YgQnVzIG9wdGlvbnMgKFBDSSBldGMuKQoKIwojIEJpbmFyeSBFbXVsYXRpb25zCiMKQ09O
RklHX0lBMzJfRU1VTEFUSU9OPXkKIyBDT05GSUdfWDg2X1gzMl9BQkkgaXMgbm90IHNldApD
T05GSUdfQ09NUEFUXzMyPXkKQ09ORklHX0NPTVBBVD15CkNPTkZJR19DT01QQVRfRk9SX1U2
NF9BTElHTk1FTlQ9eQojIGVuZCBvZiBCaW5hcnkgRW11bGF0aW9ucwoKQ09ORklHX0hBVkVf
S1ZNPXkKQ09ORklHX0hBVkVfS1ZNX1BGTkNBQ0hFPXkKQ09ORklHX0hBVkVfS1ZNX0lSUUNI
SVA9eQpDT05GSUdfSEFWRV9LVk1fSVJRRkQ9eQpDT05GSUdfSEFWRV9LVk1fSVJRX1JPVVRJ
Tkc9eQpDT05GSUdfSEFWRV9LVk1fRElSVFlfUklORz15CkNPTkZJR19IQVZFX0tWTV9ESVJU
WV9SSU5HX1RTTz15CkNPTkZJR19IQVZFX0tWTV9ESVJUWV9SSU5HX0FDUV9SRUw9eQpDT05G
SUdfSEFWRV9LVk1fRVZFTlRGRD15CkNPTkZJR19LVk1fTU1JTz15CkNPTkZJR19LVk1fQVNZ
TkNfUEY9eQpDT05GSUdfSEFWRV9LVk1fTVNJPXkKQ09ORklHX0hBVkVfS1ZNX0NQVV9SRUxB
WF9JTlRFUkNFUFQ9eQpDT05GSUdfS1ZNX1ZGSU89eQpDT05GSUdfS1ZNX0dFTkVSSUNfRElS
VFlMT0dfUkVBRF9QUk9URUNUPXkKQ09ORklHX0tWTV9DT01QQVQ9eQpDT05GSUdfSEFWRV9L
Vk1fSVJRX0JZUEFTUz15CkNPTkZJR19IQVZFX0tWTV9OT19QT0xMPXkKQ09ORklHX0tWTV9Y
RkVSX1RPX0dVRVNUX1dPUks9eQpDT05GSUdfSEFWRV9LVk1fUE1fTk9USUZJRVI9eQpDT05G
SUdfVklSVFVBTElaQVRJT049eQpDT05GSUdfS1ZNPW0KQ09ORklHX0tWTV9JTlRFTD1tCkNP
TkZJR19YODZfU0dYX0tWTT15CiMgQ09ORklHX0tWTV9BTUQgaXMgbm90IHNldAojIENPTkZJ
R19LVk1fWEVOIGlzIG5vdCBzZXQKQ09ORklHX0FTX0FWWDUxMj15CkNPTkZJR19BU19TSEEx
X05JPXkKQ09ORklHX0FTX1NIQTI1Nl9OST15CkNPTkZJR19BU19UUEFVU0U9eQoKIwojIEdl
bmVyYWwgYXJjaGl0ZWN0dXJlLWRlcGVuZGVudCBvcHRpb25zCiMKQ09ORklHX0NSQVNIX0NP
UkU9eQpDT05GSUdfS0VYRUNfQ09SRT15CkNPTkZJR19IT1RQTFVHX1NNVD15CkNPTkZJR19H
RU5FUklDX0VOVFJZPXkKQ09ORklHX0tQUk9CRVM9eQpDT05GSUdfSlVNUF9MQUJFTD15CiMg
Q09ORklHX1NUQVRJQ19LRVlTX1NFTEZURVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfU1RBVElD
X0NBTExfU0VMRlRFU1QgaXMgbm90IHNldApDT05GSUdfT1BUUFJPQkVTPXkKQ09ORklHX0hB
VkVfRUZGSUNJRU5UX1VOQUxJR05FRF9BQ0NFU1M9eQpDT05GSUdfQVJDSF9VU0VfQlVJTFRJ
Tl9CU1dBUD15CkNPTkZJR19LUkVUUFJPQkVTPXkKQ09ORklHX0tSRVRQUk9CRV9PTl9SRVRI
T09LPXkKQ09ORklHX1VTRVJfUkVUVVJOX05PVElGSUVSPXkKQ09ORklHX0hBVkVfSU9SRU1B
UF9QUk9UPXkKQ09ORklHX0hBVkVfS1BST0JFUz15CkNPTkZJR19IQVZFX0tSRVRQUk9CRVM9
eQpDT05GSUdfSEFWRV9PUFRQUk9CRVM9eQpDT05GSUdfSEFWRV9LUFJPQkVTX09OX0ZUUkFD
RT15CkNPTkZJR19BUkNIX0NPUlJFQ1RfU1RBQ0tUUkFDRV9PTl9LUkVUUFJPQkU9eQpDT05G
SUdfSEFWRV9GVU5DVElPTl9FUlJPUl9JTkpFQ1RJT049eQpDT05GSUdfSEFWRV9OTUk9eQpD
T05GSUdfVFJBQ0VfSVJRRkxBR1NfU1VQUE9SVD15CkNPTkZJR19UUkFDRV9JUlFGTEFHU19O
TUlfU1VQUE9SVD15CkNPTkZJR19IQVZFX0FSQ0hfVFJBQ0VIT09LPXkKQ09ORklHX0hBVkVf
RE1BX0NPTlRJR1VPVVM9eQpDT05GSUdfR0VORVJJQ19TTVBfSURMRV9USFJFQUQ9eQpDT05G
SUdfQVJDSF9IQVNfRk9SVElGWV9TT1VSQ0U9eQpDT05GSUdfQVJDSF9IQVNfU0VUX01FTU9S
WT15CkNPTkZJR19BUkNIX0hBU19TRVRfRElSRUNUX01BUD15CkNPTkZJR19BUkNIX0hBU19D
UFVfRklOQUxJWkVfSU5JVD15CkNPTkZJR19IQVZFX0FSQ0hfVEhSRUFEX1NUUlVDVF9XSElU
RUxJU1Q9eQpDT05GSUdfQVJDSF9XQU5UU19EWU5BTUlDX1RBU0tfU1RSVUNUPXkKQ09ORklH
X0FSQ0hfV0FOVFNfTk9fSU5TVFI9eQpDT05GSUdfSEFWRV9BU01fTU9EVkVSU0lPTlM9eQpD
T05GSUdfSEFWRV9SRUdTX0FORF9TVEFDS19BQ0NFU1NfQVBJPXkKQ09ORklHX0hBVkVfUlNF
UT15CkNPTkZJR19IQVZFX1JVU1Q9eQpDT05GSUdfSEFWRV9GVU5DVElPTl9BUkdfQUNDRVNT
X0FQST15CkNPTkZJR19IQVZFX0hXX0JSRUFLUE9JTlQ9eQpDT05GSUdfSEFWRV9NSVhFRF9C
UkVBS1BPSU5UU19SRUdTPXkKQ09ORklHX0hBVkVfVVNFUl9SRVRVUk5fTk9USUZJRVI9eQpD
T05GSUdfSEFWRV9QRVJGX0VWRU5UU19OTUk9eQpDT05GSUdfSEFWRV9IQVJETE9DS1VQX0RF
VEVDVE9SX1BFUkY9eQpDT05GSUdfSEFWRV9QRVJGX1JFR1M9eQpDT05GSUdfSEFWRV9QRVJG
X1VTRVJfU1RBQ0tfRFVNUD15CkNPTkZJR19IQVZFX0FSQ0hfSlVNUF9MQUJFTD15CkNPTkZJ
R19IQVZFX0FSQ0hfSlVNUF9MQUJFTF9SRUxBVElWRT15CkNPTkZJR19NTVVfR0FUSEVSX01F
UkdFX1ZNQVM9eQpDT05GSUdfQVJDSF9IQVZFX05NSV9TQUZFX0NNUFhDSEc9eQpDT05GSUdf
SEFWRV9BTElHTkVEX1NUUlVDVF9QQUdFPXkKQ09ORklHX0hBVkVfQ01QWENIR19MT0NBTD15
CkNPTkZJR19IQVZFX0NNUFhDSEdfRE9VQkxFPXkKQ09ORklHX0FSQ0hfV0FOVF9DT01QQVRf
SVBDX1BBUlNFX1ZFUlNJT049eQpDT05GSUdfQVJDSF9XQU5UX09MRF9DT01QQVRfSVBDPXkK
Q09ORklHX0hBVkVfQVJDSF9TRUNDT01QPXkKQ09ORklHX0hBVkVfQVJDSF9TRUNDT01QX0ZJ
TFRFUj15CkNPTkZJR19TRUNDT01QPXkKQ09ORklHX1NFQ0NPTVBfRklMVEVSPXkKIyBDT05G
SUdfU0VDQ09NUF9DQUNIRV9ERUJVRyBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX0FSQ0hfU1RB
Q0tMRUFLPXkKQ09ORklHX0hBVkVfU1RBQ0tQUk9URUNUT1I9eQpDT05GSUdfU1RBQ0tQUk9U
RUNUT1I9eQpDT05GSUdfU1RBQ0tQUk9URUNUT1JfU1RST05HPXkKQ09ORklHX0FSQ0hfU1VQ
UE9SVFNfTFRPX0NMQU5HPXkKQ09ORklHX0FSQ0hfU1VQUE9SVFNfTFRPX0NMQU5HX1RISU49
eQpDT05GSUdfTFRPX05PTkU9eQpDT05GSUdfQVJDSF9TVVBQT1JUU19DRklfQ0xBTkc9eQpD
T05GSUdfSEFWRV9BUkNIX1dJVEhJTl9TVEFDS19GUkFNRVM9eQpDT05GSUdfSEFWRV9DT05U
RVhUX1RSQUNLSU5HX1VTRVI9eQpDT05GSUdfSEFWRV9DT05URVhUX1RSQUNLSU5HX1VTRVJf
T0ZGU1RBQ0s9eQpDT05GSUdfSEFWRV9WSVJUX0NQVV9BQ0NPVU5USU5HX0dFTj15CkNPTkZJ
R19IQVZFX0lSUV9USU1FX0FDQ09VTlRJTkc9eQpDT05GSUdfSEFWRV9NT1ZFX1BVRD15CkNP
TkZJR19IQVZFX01PVkVfUE1EPXkKQ09ORklHX0hBVkVfQVJDSF9UUkFOU1BBUkVOVF9IVUdF
UEFHRT15CkNPTkZJR19IQVZFX0FSQ0hfVFJBTlNQQVJFTlRfSFVHRVBBR0VfUFVEPXkKQ09O
RklHX0hBVkVfQVJDSF9IVUdFX1ZNQVA9eQpDT05GSUdfSEFWRV9BUkNIX0hVR0VfVk1BTExP
Qz15CkNPTkZJR19BUkNIX1dBTlRfSFVHRV9QTURfU0hBUkU9eQpDT05GSUdfSEFWRV9BUkNI
X1NPRlRfRElSVFk9eQpDT05GSUdfSEFWRV9NT0RfQVJDSF9TUEVDSUZJQz15CkNPTkZJR19N
T0RVTEVTX1VTRV9FTEZfUkVMQT15CkNPTkZJR19IQVZFX0lSUV9FWElUX09OX0lSUV9TVEFD
Sz15CkNPTkZJR19IQVZFX1NPRlRJUlFfT05fT1dOX1NUQUNLPXkKQ09ORklHX1NPRlRJUlFf
T05fT1dOX1NUQUNLPXkKQ09ORklHX0FSQ0hfSEFTX0VMRl9SQU5ET01JWkU9eQpDT05GSUdf
SEFWRV9BUkNIX01NQVBfUk5EX0JJVFM9eQpDT05GSUdfSEFWRV9FWElUX1RIUkVBRD15CkNP
TkZJR19BUkNIX01NQVBfUk5EX0JJVFM9MjgKQ09ORklHX0hBVkVfQVJDSF9NTUFQX1JORF9D
T01QQVRfQklUUz15CkNPTkZJR19BUkNIX01NQVBfUk5EX0NPTVBBVF9CSVRTPTgKQ09ORklH
X0hBVkVfQVJDSF9DT01QQVRfTU1BUF9CQVNFUz15CkNPTkZJR19QQUdFX1NJWkVfTEVTU19U
SEFOXzY0S0I9eQpDT05GSUdfUEFHRV9TSVpFX0xFU1NfVEhBTl8yNTZLQj15CkNPTkZJR19I
QVZFX09CSlRPT0w9eQpDT05GSUdfSEFWRV9KVU1QX0xBQkVMX0hBQ0s9eQpDT05GSUdfSEFW
RV9OT0lOU1RSX0hBQ0s9eQpDT05GSUdfSEFWRV9OT0lOU1RSX1ZBTElEQVRJT049eQpDT05G
SUdfSEFWRV9VQUNDRVNTX1ZBTElEQVRJT049eQpDT05GSUdfSEFWRV9TVEFDS19WQUxJREFU
SU9OPXkKQ09ORklHX0hBVkVfUkVMSUFCTEVfU1RBQ0tUUkFDRT15CkNPTkZJR19PTERfU0lH
U1VTUEVORDM9eQpDT05GSUdfQ09NUEFUX09MRF9TSUdBQ1RJT049eQpDT05GSUdfQ09NUEFU
XzMyQklUX1RJTUU9eQpDT05GSUdfSEFWRV9BUkNIX1ZNQVBfU1RBQ0s9eQpDT05GSUdfVk1B
UF9TVEFDSz15CkNPTkZJR19IQVZFX0FSQ0hfUkFORE9NSVpFX0tTVEFDS19PRkZTRVQ9eQpD
T05GSUdfUkFORE9NSVpFX0tTVEFDS19PRkZTRVQ9eQpDT05GSUdfUkFORE9NSVpFX0tTVEFD
S19PRkZTRVRfREVGQVVMVD15CkNPTkZJR19BUkNIX0hBU19TVFJJQ1RfS0VSTkVMX1JXWD15
CkNPTkZJR19TVFJJQ1RfS0VSTkVMX1JXWD15CkNPTkZJR19BUkNIX0hBU19TVFJJQ1RfTU9E
VUxFX1JXWD15CkNPTkZJR19TVFJJQ1RfTU9EVUxFX1JXWD15CkNPTkZJR19IQVZFX0FSQ0hf
UFJFTDMyX1JFTE9DQVRJT05TPXkKQ09ORklHX0FSQ0hfVVNFX01FTVJFTUFQX1BST1Q9eQoj
IENPTkZJR19MT0NLX0VWRU5UX0NPVU5UUyBpcyBub3Qgc2V0CkNPTkZJR19BUkNIX0hBU19N
RU1fRU5DUllQVD15CkNPTkZJR19IQVZFX1NUQVRJQ19DQUxMPXkKQ09ORklHX0hBVkVfU1RB
VElDX0NBTExfSU5MSU5FPXkKQ09ORklHX0hBVkVfUFJFRU1QVF9EWU5BTUlDPXkKQ09ORklH
X0hBVkVfUFJFRU1QVF9EWU5BTUlDX0NBTEw9eQpDT05GSUdfQVJDSF9XQU5UX0xEX09SUEhB
Tl9XQVJOPXkKQ09ORklHX0FSQ0hfU1VQUE9SVFNfREVCVUdfUEFHRUFMTE9DPXkKQ09ORklH
X0FSQ0hfU1VQUE9SVFNfUEFHRV9UQUJMRV9DSEVDSz15CkNPTkZJR19BUkNIX0hBU19FTEZD
T1JFX0NPTVBBVD15CkNPTkZJR19BUkNIX0hBU19QQVJBTk9JRF9MMURfRkxVU0g9eQpDT05G
SUdfRFlOQU1JQ19TSUdGUkFNRT15CkNPTkZJR19IQVZFX0FSQ0hfTk9ERV9ERVZfR1JPVVA9
eQpDT05GSUdfQVJDSF9IQVNfTk9OTEVBRl9QTURfWU9VTkc9eQoKIwojIEdDT1YtYmFzZWQg
a2VybmVsIHByb2ZpbGluZwojCiMgQ09ORklHX0dDT1ZfS0VSTkVMIGlzIG5vdCBzZXQKQ09O
RklHX0FSQ0hfSEFTX0dDT1ZfUFJPRklMRV9BTEw9eQojIGVuZCBvZiBHQ09WLWJhc2VkIGtl
cm5lbCBwcm9maWxpbmcKCkNPTkZJR19IQVZFX0dDQ19QTFVHSU5TPXkKIyBlbmQgb2YgR2Vu
ZXJhbCBhcmNoaXRlY3R1cmUtZGVwZW5kZW50IG9wdGlvbnMKCkNPTkZJR19SVF9NVVRFWEVT
PXkKQ09ORklHX0JBU0VfU01BTEw9MApDT05GSUdfTU9EVUxFX1NJR19GT1JNQVQ9eQpDT05G
SUdfTU9EVUxFUz15CiMgQ09ORklHX01PRFVMRV9GT1JDRV9MT0FEIGlzIG5vdCBzZXQKQ09O
RklHX01PRFVMRV9VTkxPQUQ9eQojIENPTkZJR19NT0RVTEVfRk9SQ0VfVU5MT0FEIGlzIG5v
dCBzZXQKIyBDT05GSUdfTU9EVUxFX1VOTE9BRF9UQUlOVF9UUkFDS0lORyBpcyBub3Qgc2V0
CkNPTkZJR19NT0RWRVJTSU9OUz15CkNPTkZJR19BU01fTU9EVkVSU0lPTlM9eQpDT05GSUdf
TU9EVUxFX1NSQ1ZFUlNJT05fQUxMPXkKQ09ORklHX01PRFVMRV9TSUc9eQpDT05GSUdfTU9E
VUxFX1NJR19GT1JDRT15CkNPTkZJR19NT0RVTEVfU0lHX0FMTD15CiMgQ09ORklHX01PRFVM
RV9TSUdfU0hBMSBpcyBub3Qgc2V0CiMgQ09ORklHX01PRFVMRV9TSUdfU0hBMjI0IGlzIG5v
dCBzZXQKIyBDT05GSUdfTU9EVUxFX1NJR19TSEEyNTYgaXMgbm90IHNldAojIENPTkZJR19N
T0RVTEVfU0lHX1NIQTM4NCBpcyBub3Qgc2V0CkNPTkZJR19NT0RVTEVfU0lHX1NIQTUxMj15
CkNPTkZJR19NT0RVTEVfU0lHX0hBU0g9InNoYTUxMiIKQ09ORklHX01PRFVMRV9DT01QUkVT
U19OT05FPXkKIyBDT05GSUdfTU9EVUxFX0NPTVBSRVNTX0daSVAgaXMgbm90IHNldAojIENP
TkZJR19NT0RVTEVfQ09NUFJFU1NfWFogaXMgbm90IHNldAojIENPTkZJR19NT0RVTEVfQ09N
UFJFU1NfWlNURCBpcyBub3Qgc2V0CiMgQ09ORklHX01PRFVMRV9BTExPV19NSVNTSU5HX05B
TUVTUEFDRV9JTVBPUlRTIGlzIG5vdCBzZXQKQ09ORklHX01PRFBST0JFX1BBVEg9Ii9zYmlu
L21vZHByb2JlIgpDT05GSUdfTU9EVUxFU19UUkVFX0xPT0tVUD15CkNPTkZJR19CTE9DSz15
CkNPTkZJR19CTE9DS19MRUdBQ1lfQVVUT0xPQUQ9eQpDT05GSUdfQkxLX1JRX0FMTE9DX1RJ
TUU9eQpDT05GSUdfQkxLX0NHUk9VUF9SV1NUQVQ9eQpDT05GSUdfQkxLX0RFVl9CU0dfQ09N
TU9OPXkKQ09ORklHX0JMS19JQ1E9eQpDT05GSUdfQkxLX0RFVl9CU0dMSUI9eQpDT05GSUdf
QkxLX0RFVl9JTlRFR1JJVFk9eQpDT05GSUdfQkxLX0RFVl9JTlRFR1JJVFlfVDEwPW0KQ09O
RklHX0JMS19ERVZfWk9ORUQ9eQpDT05GSUdfQkxLX0RFVl9USFJPVFRMSU5HPXkKIyBDT05G
SUdfQkxLX0RFVl9USFJPVFRMSU5HX0xPVyBpcyBub3Qgc2V0CkNPTkZJR19CTEtfV0JUPXkK
Q09ORklHX0JMS19XQlRfTVE9eQojIENPTkZJR19CTEtfQ0dST1VQX0lPTEFURU5DWSBpcyBu
b3Qgc2V0CkNPTkZJR19CTEtfQ0dST1VQX0lPQ09TVD15CkNPTkZJR19CTEtfQ0dST1VQX0lP
UFJJTz15CkNPTkZJR19CTEtfREVCVUdfRlM9eQpDT05GSUdfQkxLX0RFQlVHX0ZTX1pPTkVE
PXkKQ09ORklHX0JMS19TRURfT1BBTD15CkNPTkZJR19CTEtfSU5MSU5FX0VOQ1JZUFRJT049
eQpDT05GSUdfQkxLX0lOTElORV9FTkNSWVBUSU9OX0ZBTExCQUNLPXkKCiMKIyBQYXJ0aXRp
b24gVHlwZXMKIwpDT05GSUdfUEFSVElUSU9OX0FEVkFOQ0VEPXkKIyBDT05GSUdfQUNPUk5f
UEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfQUlYX1BBUlRJVElPTiBpcyBub3Qgc2V0
CiMgQ09ORklHX09TRl9QQVJUSVRJT04gaXMgbm90IHNldAojIENPTkZJR19BTUlHQV9QQVJU
SVRJT04gaXMgbm90IHNldAojIENPTkZJR19BVEFSSV9QQVJUSVRJT04gaXMgbm90IHNldAoj
IENPTkZJR19NQUNfUEFSVElUSU9OIGlzIG5vdCBzZXQKQ09ORklHX01TRE9TX1BBUlRJVElP
Tj15CiMgQ09ORklHX0JTRF9ESVNLTEFCRUwgaXMgbm90IHNldAojIENPTkZJR19NSU5JWF9T
VUJQQVJUSVRJT04gaXMgbm90IHNldAojIENPTkZJR19TT0xBUklTX1g4Nl9QQVJUSVRJT04g
aXMgbm90IHNldAojIENPTkZJR19VTklYV0FSRV9ESVNLTEFCRUwgaXMgbm90IHNldAojIENP
TkZJR19MRE1fUEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfU0dJX1BBUlRJVElPTiBp
cyBub3Qgc2V0CiMgQ09ORklHX1VMVFJJWF9QQVJUSVRJT04gaXMgbm90IHNldAojIENPTkZJ
R19TVU5fUEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfS0FSTUFfUEFSVElUSU9OIGlz
IG5vdCBzZXQKQ09ORklHX0VGSV9QQVJUSVRJT049eQojIENPTkZJR19TWVNWNjhfUEFSVElU
SU9OIGlzIG5vdCBzZXQKQ09ORklHX0NNRExJTkVfUEFSVElUSU9OPXkKIyBlbmQgb2YgUGFy
dGl0aW9uIFR5cGVzCgpDT05GSUdfQkxPQ0tfQ09NUEFUPXkKQ09ORklHX0JMS19NUV9QQ0k9
eQpDT05GSUdfQkxLX1BNPXkKQ09ORklHX0JMT0NLX0hPTERFUl9ERVBSRUNBVEVEPXkKQ09O
RklHX0JMS19NUV9TVEFDS0lORz15CgojCiMgSU8gU2NoZWR1bGVycwojCkNPTkZJR19NUV9J
T1NDSEVEX0RFQURMSU5FPXkKQ09ORklHX01RX0lPU0NIRURfS1lCRVI9bQpDT05GSUdfSU9T
Q0hFRF9CRlE9bQpDT05GSUdfQkZRX0dST1VQX0lPU0NIRUQ9eQojIENPTkZJR19CRlFfQ0dS
T1VQX0RFQlVHIGlzIG5vdCBzZXQKIyBlbmQgb2YgSU8gU2NoZWR1bGVycwoKQ09ORklHX1BS
RUVNUFRfTk9USUZJRVJTPXkKQ09ORklHX0FTTjE9eQpDT05GSUdfVU5JTkxJTkVfU1BJTl9V
TkxPQ0s9eQpDT05GSUdfQVJDSF9TVVBQT1JUU19BVE9NSUNfUk1XPXkKQ09ORklHX01VVEVY
X1NQSU5fT05fT1dORVI9eQpDT05GSUdfUldTRU1fU1BJTl9PTl9PV05FUj15CkNPTkZJR19M
T0NLX1NQSU5fT05fT1dORVI9eQpDT05GSUdfQVJDSF9VU0VfUVVFVUVEX1NQSU5MT0NLUz15
CkNPTkZJR19RVUVVRURfU1BJTkxPQ0tTPXkKQ09ORklHX0FSQ0hfVVNFX1FVRVVFRF9SV0xP
Q0tTPXkKQ09ORklHX1FVRVVFRF9SV0xPQ0tTPXkKQ09ORklHX0FSQ0hfSEFTX05PTl9PVkVS
TEFQUElOR19BRERSRVNTX1NQQUNFPXkKQ09ORklHX0FSQ0hfSEFTX1NZTkNfQ09SRV9CRUZP
UkVfVVNFUk1PREU9eQpDT05GSUdfQVJDSF9IQVNfU1lTQ0FMTF9XUkFQUEVSPXkKQ09ORklH
X0ZSRUVaRVI9eQoKIwojIEV4ZWN1dGFibGUgZmlsZSBmb3JtYXRzCiMKQ09ORklHX0JJTkZN
VF9FTEY9eQpDT05GSUdfQ09NUEFUX0JJTkZNVF9FTEY9eQpDT05GSUdfRUxGQ09SRT15CkNP
TkZJR19DT1JFX0RVTVBfREVGQVVMVF9FTEZfSEVBREVSUz15CkNPTkZJR19CSU5GTVRfU0NS
SVBUPXkKQ09ORklHX0JJTkZNVF9NSVNDPW0KQ09ORklHX0NPUkVEVU1QPXkKIyBlbmQgb2Yg
RXhlY3V0YWJsZSBmaWxlIGZvcm1hdHMKCiMKIyBNZW1vcnkgTWFuYWdlbWVudCBvcHRpb25z
CiMKQ09ORklHX1pQT09MPXkKQ09ORklHX1NXQVA9eQpDT05GSUdfWlNXQVA9eQojIENPTkZJ
R19aU1dBUF9ERUZBVUxUX09OIGlzIG5vdCBzZXQKIyBDT05GSUdfWlNXQVBfQ09NUFJFU1NP
Ul9ERUZBVUxUX0RFRkxBVEUgaXMgbm90IHNldApDT05GSUdfWlNXQVBfQ09NUFJFU1NPUl9E
RUZBVUxUX0xaTz15CiMgQ09ORklHX1pTV0FQX0NPTVBSRVNTT1JfREVGQVVMVF84NDIgaXMg
bm90IHNldAojIENPTkZJR19aU1dBUF9DT01QUkVTU09SX0RFRkFVTFRfTFo0IGlzIG5vdCBz
ZXQKIyBDT05GSUdfWlNXQVBfQ09NUFJFU1NPUl9ERUZBVUxUX0xaNEhDIGlzIG5vdCBzZXQK
IyBDT05GSUdfWlNXQVBfQ09NUFJFU1NPUl9ERUZBVUxUX1pTVEQgaXMgbm90IHNldApDT05G
SUdfWlNXQVBfQ09NUFJFU1NPUl9ERUZBVUxUPSJsem8iCkNPTkZJR19aU1dBUF9aUE9PTF9E
RUZBVUxUX1pCVUQ9eQojIENPTkZJR19aU1dBUF9aUE9PTF9ERUZBVUxUX1ozRk9MRCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1pTV0FQX1pQT09MX0RFRkFVTFRfWlNNQUxMT0MgaXMgbm90IHNl
dApDT05GSUdfWlNXQVBfWlBPT0xfREVGQVVMVD0iemJ1ZCIKQ09ORklHX1pCVUQ9eQpDT05G
SUdfWjNGT0xEPW0KQ09ORklHX1pTTUFMTE9DPXkKIyBDT05GSUdfWlNNQUxMT0NfU1RBVCBp
cyBub3Qgc2V0CgojCiMgU0xBQiBhbGxvY2F0b3Igb3B0aW9ucwojCiMgQ09ORklHX1NMQUIg
aXMgbm90IHNldApDT05GSUdfU0xVQj15CkNPTkZJR19TTEFCX01FUkdFX0RFRkFVTFQ9eQpD
T05GSUdfU0xBQl9GUkVFTElTVF9SQU5ET009eQpDT05GSUdfU0xBQl9GUkVFTElTVF9IQVJE
RU5FRD15CiMgQ09ORklHX1NMVUJfU1RBVFMgaXMgbm90IHNldApDT05GSUdfU0xVQl9DUFVf
UEFSVElBTD15CiMgZW5kIG9mIFNMQUIgYWxsb2NhdG9yIG9wdGlvbnMKCkNPTkZJR19TSFVG
RkxFX1BBR0VfQUxMT0NBVE9SPXkKIyBDT05GSUdfQ09NUEFUX0JSSyBpcyBub3Qgc2V0CkNP
TkZJR19TUEFSU0VNRU09eQpDT05GSUdfU1BBUlNFTUVNX0VYVFJFTUU9eQpDT05GSUdfU1BB
UlNFTUVNX1ZNRU1NQVBfRU5BQkxFPXkKQ09ORklHX1NQQVJTRU1FTV9WTUVNTUFQPXkKQ09O
RklHX0hBVkVfRkFTVF9HVVA9eQpDT05GSUdfTlVNQV9LRUVQX01FTUlORk89eQpDT05GSUdf
TUVNT1JZX0lTT0xBVElPTj15CkNPTkZJR19FWENMVVNJVkVfU1lTVEVNX1JBTT15CkNPTkZJ
R19IQVZFX0JPT1RNRU1fSU5GT19OT0RFPXkKQ09ORklHX0FSQ0hfRU5BQkxFX01FTU9SWV9I
T1RQTFVHPXkKQ09ORklHX0FSQ0hfRU5BQkxFX01FTU9SWV9IT1RSRU1PVkU9eQpDT05GSUdf
TUVNT1JZX0hPVFBMVUc9eQpDT05GSUdfTUVNT1JZX0hPVFBMVUdfREVGQVVMVF9PTkxJTkU9
eQpDT05GSUdfTUVNT1JZX0hPVFJFTU9WRT15CkNPTkZJR19NSFBfTUVNTUFQX09OX01FTU9S
WT15CkNPTkZJR19TUExJVF9QVExPQ0tfQ1BVUz00CkNPTkZJR19BUkNIX0VOQUJMRV9TUExJ
VF9QTURfUFRMT0NLPXkKQ09ORklHX0NPTVBBQ1RJT049eQpDT05GSUdfQ09NUEFDVF9VTkVW
SUNUQUJMRV9ERUZBVUxUPTEKQ09ORklHX1BBR0VfUkVQT1JUSU5HPXkKQ09ORklHX01JR1JB
VElPTj15CkNPTkZJR19ERVZJQ0VfTUlHUkFUSU9OPXkKQ09ORklHX0FSQ0hfRU5BQkxFX0hV
R0VQQUdFX01JR1JBVElPTj15CkNPTkZJR19BUkNIX0VOQUJMRV9USFBfTUlHUkFUSU9OPXkK
Q09ORklHX0NPTlRJR19BTExPQz15CkNPTkZJR19QSFlTX0FERFJfVF82NEJJVD15CkNPTkZJ
R19NTVVfTk9USUZJRVI9eQpDT05GSUdfS1NNPXkKQ09ORklHX0RFRkFVTFRfTU1BUF9NSU5f
QUREUj02NTUzNgpDT05GSUdfQVJDSF9TVVBQT1JUU19NRU1PUllfRkFJTFVSRT15CkNPTkZJ
R19NRU1PUllfRkFJTFVSRT15CkNPTkZJR19BUkNIX1dBTlRfR0VORVJBTF9IVUdFVExCPXkK
Q09ORklHX0FSQ0hfV0FOVFNfVEhQX1NXQVA9eQpDT05GSUdfVFJBTlNQQVJFTlRfSFVHRVBB
R0U9eQojIENPTkZJR19UUkFOU1BBUkVOVF9IVUdFUEFHRV9BTFdBWVMgaXMgbm90IHNldApD
T05GSUdfVFJBTlNQQVJFTlRfSFVHRVBBR0VfTUFEVklTRT15CkNPTkZJR19USFBfU1dBUD15
CiMgQ09ORklHX1JFQURfT05MWV9USFBfRk9SX0ZTIGlzIG5vdCBzZXQKQ09ORklHX05FRURf
UEVSX0NQVV9FTUJFRF9GSVJTVF9DSFVOSz15CkNPTkZJR19ORUVEX1BFUl9DUFVfUEFHRV9G
SVJTVF9DSFVOSz15CkNPTkZJR19VU0VfUEVSQ1BVX05VTUFfTk9ERV9JRD15CkNPTkZJR19I
QVZFX1NFVFVQX1BFUl9DUFVfQVJFQT15CkNPTkZJR19GUk9OVFNXQVA9eQojIENPTkZJR19D
TUEgaXMgbm90IHNldApDT05GSUdfTUVNX1NPRlRfRElSVFk9eQpDT05GSUdfR0VORVJJQ19F
QVJMWV9JT1JFTUFQPXkKIyBDT05GSUdfREVGRVJSRURfU1RSVUNUX1BBR0VfSU5JVCBpcyBu
b3Qgc2V0CkNPTkZJR19QQUdFX0lETEVfRkxBRz15CkNPTkZJR19JRExFX1BBR0VfVFJBQ0tJ
Tkc9eQpDT05GSUdfQVJDSF9IQVNfQ0FDSEVfTElORV9TSVpFPXkKQ09ORklHX0FSQ0hfSEFT
X0NVUlJFTlRfU1RBQ0tfUE9JTlRFUj15CkNPTkZJR19BUkNIX0hBU19QVEVfREVWTUFQPXkK
Q09ORklHX1pPTkVfRE1BPXkKQ09ORklHX1pPTkVfRE1BMzI9eQpDT05GSUdfWk9ORV9ERVZJ
Q0U9eQpDT05GSUdfR0VUX0ZSRUVfUkVHSU9OPXkKQ09ORklHX0RFVklDRV9QUklWQVRFPXkK
Q09ORklHX0FSQ0hfVVNFU19ISUdIX1ZNQV9GTEFHUz15CkNPTkZJR19BUkNIX0hBU19QS0VZ
Uz15CkNPTkZJR19WTV9FVkVOVF9DT1VOVEVSUz15CiMgQ09ORklHX1BFUkNQVV9TVEFUUyBp
cyBub3Qgc2V0CiMgQ09ORklHX0dVUF9URVNUIGlzIG5vdCBzZXQKQ09ORklHX0FSQ0hfSEFT
X1BURV9TUEVDSUFMPXkKQ09ORklHX1NFQ1JFVE1FTT15CiMgQ09ORklHX0FOT05fVk1BX05B
TUUgaXMgbm90IHNldApDT05GSUdfVVNFUkZBVUxURkQ9eQpDT05GSUdfSEFWRV9BUkNIX1VT
RVJGQVVMVEZEX1dQPXkKQ09ORklHX0hBVkVfQVJDSF9VU0VSRkFVTFRGRF9NSU5PUj15CkNP
TkZJR19QVEVfTUFSS0VSPXkKQ09ORklHX1BURV9NQVJLRVJfVUZGRF9XUD15CiMgQ09ORklH
X0xSVV9HRU4gaXMgbm90IHNldApDT05GSUdfTE9DS19NTV9BTkRfRklORF9WTUE9eQoKIwoj
IERhdGEgQWNjZXNzIE1vbml0b3JpbmcKIwojIENPTkZJR19EQU1PTiBpcyBub3Qgc2V0CiMg
ZW5kIG9mIERhdGEgQWNjZXNzIE1vbml0b3JpbmcKIyBlbmQgb2YgTWVtb3J5IE1hbmFnZW1l
bnQgb3B0aW9ucwoKQ09ORklHX05FVD15CkNPTkZJR19XQU5UX0NPTVBBVF9ORVRMSU5LX01F
U1NBR0VTPXkKQ09ORklHX0NPTVBBVF9ORVRMSU5LX01FU1NBR0VTPXkKQ09ORklHX05FVF9J
TkdSRVNTPXkKQ09ORklHX05FVF9FR1JFU1M9eQpDT05GSUdfU0tCX0VYVEVOU0lPTlM9eQoK
IwojIE5ldHdvcmtpbmcgb3B0aW9ucwojCkNPTkZJR19QQUNLRVQ9eQpDT05GSUdfUEFDS0VU
X0RJQUc9bQpDT05GSUdfVU5JWD15CkNPTkZJR19VTklYX1NDTT15CkNPTkZJR19BRl9VTklY
X09PQj15CkNPTkZJR19VTklYX0RJQUc9bQpDT05GSUdfVExTPW0KQ09ORklHX1RMU19ERVZJ
Q0U9eQojIENPTkZJR19UTFNfVE9FIGlzIG5vdCBzZXQKQ09ORklHX1hGUk09eQpDT05GSUdf
WEZSTV9PRkZMT0FEPXkKQ09ORklHX1hGUk1fQUxHTz1tCkNPTkZJR19YRlJNX1VTRVI9bQpD
T05GSUdfWEZSTV9VU0VSX0NPTVBBVD1tCkNPTkZJR19YRlJNX0lOVEVSRkFDRT1tCiMgQ09O
RklHX1hGUk1fU1VCX1BPTElDWSBpcyBub3Qgc2V0CiMgQ09ORklHX1hGUk1fTUlHUkFURSBp
cyBub3Qgc2V0CkNPTkZJR19YRlJNX1NUQVRJU1RJQ1M9eQpDT05GSUdfWEZSTV9BSD1tCkNP
TkZJR19YRlJNX0VTUD1tCkNPTkZJR19YRlJNX0lQQ09NUD1tCkNPTkZJR19ORVRfS0VZPW0K
IyBDT05GSUdfTkVUX0tFWV9NSUdSQVRFIGlzIG5vdCBzZXQKQ09ORklHX1hGUk1fRVNQSU5U
Q1A9eQpDT05GSUdfWERQX1NPQ0tFVFM9eQpDT05GSUdfWERQX1NPQ0tFVFNfRElBRz1tCkNP
TkZJR19JTkVUPXkKQ09ORklHX0lQX01VTFRJQ0FTVD15CkNPTkZJR19JUF9BRFZBTkNFRF9S
T1VURVI9eQpDT05GSUdfSVBfRklCX1RSSUVfU1RBVFM9eQpDT05GSUdfSVBfTVVMVElQTEVf
VEFCTEVTPXkKQ09ORklHX0lQX1JPVVRFX01VTFRJUEFUSD15CkNPTkZJR19JUF9ST1VURV9W
RVJCT1NFPXkKIyBDT05GSUdfSVBfUE5QIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0lQSVAg
aXMgbm90IHNldAojIENPTkZJR19ORVRfSVBHUkVfREVNVVggaXMgbm90IHNldApDT05GSUdf
TkVUX0lQX1RVTk5FTD1tCkNPTkZJR19JUF9NUk9VVEVfQ09NTU9OPXkKQ09ORklHX0lQX01S
T1VURT15CkNPTkZJR19JUF9NUk9VVEVfTVVMVElQTEVfVEFCTEVTPXkKQ09ORklHX0lQX1BJ
TVNNX1YxPXkKQ09ORklHX0lQX1BJTVNNX1YyPXkKQ09ORklHX1NZTl9DT09LSUVTPXkKIyBD
T05GSUdfTkVUX0lQVlRJIGlzIG5vdCBzZXQKQ09ORklHX05FVF9VRFBfVFVOTkVMPW0KIyBD
T05GSUdfTkVUX0ZPVSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9GT1VfSVBfVFVOTkVMUyBp
cyBub3Qgc2V0CiMgQ09ORklHX0lORVRfQUggaXMgbm90IHNldAojIENPTkZJR19JTkVUX0VT
UCBpcyBub3Qgc2V0CiMgQ09ORklHX0lORVRfSVBDT01QIGlzIG5vdCBzZXQKQ09ORklHX0lO
RVRfVEFCTEVfUEVSVFVSQl9PUkRFUj0xNgpDT05GSUdfSU5FVF9UVU5ORUw9bQpDT05GSUdf
SU5FVF9ESUFHPW0KQ09ORklHX0lORVRfVENQX0RJQUc9bQpDT05GSUdfSU5FVF9VRFBfRElB
Rz1tCkNPTkZJR19JTkVUX1JBV19ESUFHPW0KQ09ORklHX0lORVRfRElBR19ERVNUUk9ZPXkK
Q09ORklHX1RDUF9DT05HX0FEVkFOQ0VEPXkKQ09ORklHX1RDUF9DT05HX0JJQz1tCkNPTkZJ
R19UQ1BfQ09OR19DVUJJQz15CkNPTkZJR19UQ1BfQ09OR19XRVNUV09PRD1tCkNPTkZJR19U
Q1BfQ09OR19IVENQPW0KQ09ORklHX1RDUF9DT05HX0hTVENQPW0KQ09ORklHX1RDUF9DT05H
X0hZQkxBPW0KQ09ORklHX1RDUF9DT05HX1ZFR0FTPW0KQ09ORklHX1RDUF9DT05HX05WPW0K
Q09ORklHX1RDUF9DT05HX1NDQUxBQkxFPW0KQ09ORklHX1RDUF9DT05HX0xQPW0KQ09ORklH
X1RDUF9DT05HX1ZFTk89bQpDT05GSUdfVENQX0NPTkdfWUVBSD1tCkNPTkZJR19UQ1BfQ09O
R19JTExJTk9JUz1tCkNPTkZJR19UQ1BfQ09OR19EQ1RDUD1tCkNPTkZJR19UQ1BfQ09OR19D
REc9bQpDT05GSUdfVENQX0NPTkdfQkJSPW0KQ09ORklHX0RFRkFVTFRfQ1VCSUM9eQojIENP
TkZJR19ERUZBVUxUX1JFTk8gaXMgbm90IHNldApDT05GSUdfREVGQVVMVF9UQ1BfQ09ORz0i
Y3ViaWMiCiMgQ09ORklHX1RDUF9NRDVTSUcgaXMgbm90IHNldApDT05GSUdfSVBWNj15CiMg
Q09ORklHX0lQVjZfUk9VVEVSX1BSRUYgaXMgbm90IHNldAojIENPTkZJR19JUFY2X09QVElN
SVNUSUNfREFEIGlzIG5vdCBzZXQKQ09ORklHX0lORVQ2X0FIPW0KQ09ORklHX0lORVQ2X0VT
UD1tCkNPTkZJR19JTkVUNl9FU1BfT0ZGTE9BRD1tCkNPTkZJR19JTkVUNl9FU1BJTlRDUD15
CkNPTkZJR19JTkVUNl9JUENPTVA9bQojIENPTkZJR19JUFY2X01JUDYgaXMgbm90IHNldAoj
IENPTkZJR19JUFY2X0lMQSBpcyBub3Qgc2V0CkNPTkZJR19JTkVUNl9YRlJNX1RVTk5FTD1t
CkNPTkZJR19JTkVUNl9UVU5ORUw9bQojIENPTkZJR19JUFY2X1ZUSSBpcyBub3Qgc2V0CkNP
TkZJR19JUFY2X1NJVD1tCiMgQ09ORklHX0lQVjZfU0lUXzZSRCBpcyBub3Qgc2V0CkNPTkZJ
R19JUFY2X05ESVNDX05PREVUWVBFPXkKQ09ORklHX0lQVjZfVFVOTkVMPW0KQ09ORklHX0lQ
VjZfTVVMVElQTEVfVEFCTEVTPXkKQ09ORklHX0lQVjZfU1VCVFJFRVM9eQpDT05GSUdfSVBW
Nl9NUk9VVEU9eQpDT05GSUdfSVBWNl9NUk9VVEVfTVVMVElQTEVfVEFCTEVTPXkKQ09ORklH
X0lQVjZfUElNU01fVjI9eQojIENPTkZJR19JUFY2X1NFRzZfTFdUVU5ORUwgaXMgbm90IHNl
dAojIENPTkZJR19JUFY2X1NFRzZfSE1BQyBpcyBub3Qgc2V0CiMgQ09ORklHX0lQVjZfUlBM
X0xXVFVOTkVMIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBWNl9JT0FNNl9MV1RVTk5FTCBpcyBu
b3Qgc2V0CiMgQ09ORklHX05FVExBQkVMIGlzIG5vdCBzZXQKIyBDT05GSUdfTVBUQ1AgaXMg
bm90IHNldAojIENPTkZJR19ORVRXT1JLX1NFQ01BUksgaXMgbm90IHNldAojIENPTkZJR19O
RVRXT1JLX1BIWV9USU1FU1RBTVBJTkcgaXMgbm90IHNldApDT05GSUdfTkVURklMVEVSPXkK
Q09ORklHX05FVEZJTFRFUl9BRFZBTkNFRD15CiMgQ09ORklHX0JSSURHRV9ORVRGSUxURVIg
aXMgbm90IHNldAoKIwojIENvcmUgTmV0ZmlsdGVyIENvbmZpZ3VyYXRpb24KIwpDT05GSUdf
TkVURklMVEVSX0lOR1JFU1M9eQpDT05GSUdfTkVURklMVEVSX0VHUkVTUz15CkNPTkZJR19O
RVRGSUxURVJfTkVUTElOSz1tCkNPTkZJR19ORVRGSUxURVJfTkVUTElOS19IT09LPW0KQ09O
RklHX05FVEZJTFRFUl9ORVRMSU5LX0FDQ1Q9bQpDT05GSUdfTkVURklMVEVSX05FVExJTktf
UVVFVUU9bQpDT05GSUdfTkVURklMVEVSX05FVExJTktfTE9HPW0KQ09ORklHX05FVEZJTFRF
Ul9ORVRMSU5LX09TRj1tCkNPTkZJR19ORl9DT05OVFJBQ0s9bQpDT05GSUdfTkZfTE9HX1NZ
U0xPRz15CkNPTkZJR19ORVRGSUxURVJfQ09OTkNPVU5UPW0KQ09ORklHX05GX0NPTk5UUkFD
S19NQVJLPXkKQ09ORklHX05GX0NPTk5UUkFDS19aT05FUz15CiMgQ09ORklHX05GX0NPTk5U
UkFDS19QUk9DRlMgaXMgbm90IHNldApDT05GSUdfTkZfQ09OTlRSQUNLX0VWRU5UUz15CkNP
TkZJR19ORl9DT05OVFJBQ0tfVElNRU9VVD15CkNPTkZJR19ORl9DT05OVFJBQ0tfVElNRVNU
QU1QPXkKQ09ORklHX05GX0NPTk5UUkFDS19MQUJFTFM9eQpDT05GSUdfTkZfQ1RfUFJPVE9f
RENDUD15CkNPTkZJR19ORl9DVF9QUk9UT19TQ1RQPXkKQ09ORklHX05GX0NUX1BST1RPX1VE
UExJVEU9eQojIENPTkZJR19ORl9DT05OVFJBQ0tfQU1BTkRBIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkZfQ09OTlRSQUNLX0ZUUCBpcyBub3Qgc2V0CiMgQ09ORklHX05GX0NPTk5UUkFDS19I
MzIzIGlzIG5vdCBzZXQKIyBDT05GSUdfTkZfQ09OTlRSQUNLX0lSQyBpcyBub3Qgc2V0CiMg
Q09ORklHX05GX0NPTk5UUkFDS19ORVRCSU9TX05TIGlzIG5vdCBzZXQKIyBDT05GSUdfTkZf
Q09OTlRSQUNLX1NOTVAgaXMgbm90IHNldAojIENPTkZJR19ORl9DT05OVFJBQ0tfUFBUUCBp
cyBub3Qgc2V0CiMgQ09ORklHX05GX0NPTk5UUkFDS19TQU5FIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkZfQ09OTlRSQUNLX1NJUCBpcyBub3Qgc2V0CiMgQ09ORklHX05GX0NPTk5UUkFDS19U
RlRQIGlzIG5vdCBzZXQKQ09ORklHX05GX0NUX05FVExJTks9bQpDT05GSUdfTkZfQ1RfTkVU
TElOS19USU1FT1VUPW0KQ09ORklHX05GX0NUX05FVExJTktfSEVMUEVSPW0KQ09ORklHX05F
VEZJTFRFUl9ORVRMSU5LX0dMVUVfQ1Q9eQpDT05GSUdfTkZfTkFUPW0KQ09ORklHX05GX05B
VF9SRURJUkVDVD15CkNPTkZJR19ORl9OQVRfTUFTUVVFUkFERT15CkNPTkZJR19ORVRGSUxU
RVJfU1lOUFJPWFk9bQpDT05GSUdfTkZfVEFCTEVTPW0KQ09ORklHX05GX1RBQkxFU19JTkVU
PXkKQ09ORklHX05GX1RBQkxFU19ORVRERVY9eQpDT05GSUdfTkZUX05VTUdFTj1tCkNPTkZJ
R19ORlRfQ1Q9bQpDT05GSUdfTkZUX0ZMT1dfT0ZGTE9BRD1tCkNPTkZJR19ORlRfQ09OTkxJ
TUlUPW0KQ09ORklHX05GVF9MT0c9bQpDT05GSUdfTkZUX0xJTUlUPW0KQ09ORklHX05GVF9N
QVNRPW0KQ09ORklHX05GVF9SRURJUj1tCkNPTkZJR19ORlRfTkFUPW0KQ09ORklHX05GVF9U
VU5ORUw9bQpDT05GSUdfTkZUX09CSlJFRj1tCkNPTkZJR19ORlRfUVVFVUU9bQpDT05GSUdf
TkZUX1FVT1RBPW0KQ09ORklHX05GVF9SRUpFQ1Q9bQpDT05GSUdfTkZUX1JFSkVDVF9JTkVU
PW0KQ09ORklHX05GVF9DT01QQVQ9bQpDT05GSUdfTkZUX0hBU0g9bQpDT05GSUdfTkZUX0ZJ
Qj1tCkNPTkZJR19ORlRfRklCX0lORVQ9bQpDT05GSUdfTkZUX1hGUk09bQpDT05GSUdfTkZU
X1NPQ0tFVD1tCkNPTkZJR19ORlRfT1NGPW0KQ09ORklHX05GVF9UUFJPWFk9bQpDT05GSUdf
TkZUX1NZTlBST1hZPW0KQ09ORklHX05GX0RVUF9ORVRERVY9bQpDT05GSUdfTkZUX0RVUF9O
RVRERVY9bQpDT05GSUdfTkZUX0ZXRF9ORVRERVY9bQpDT05GSUdfTkZUX0ZJQl9ORVRERVY9
bQpDT05GSUdfTkZUX1JFSkVDVF9ORVRERVY9bQpDT05GSUdfTkZfRkxPV19UQUJMRV9JTkVU
PW0KQ09ORklHX05GX0ZMT1dfVEFCTEU9bQojIENPTkZJR19ORl9GTE9XX1RBQkxFX1BST0NG
UyBpcyBub3Qgc2V0CkNPTkZJR19ORVRGSUxURVJfWFRBQkxFUz1tCkNPTkZJR19ORVRGSUxU
RVJfWFRBQkxFU19DT01QQVQ9eQoKIwojIFh0YWJsZXMgY29tYmluZWQgbW9kdWxlcwojCkNP
TkZJR19ORVRGSUxURVJfWFRfTUFSSz1tCkNPTkZJR19ORVRGSUxURVJfWFRfQ09OTk1BUks9
bQpDT05GSUdfTkVURklMVEVSX1hUX1NFVD1tCgojCiMgWHRhYmxlcyB0YXJnZXRzCiMKIyBD
T05GSUdfTkVURklMVEVSX1hUX1RBUkdFVF9BVURJVCBpcyBub3Qgc2V0CkNPTkZJR19ORVRG
SUxURVJfWFRfVEFSR0VUX0NIRUNLU1VNPW0KIyBDT05GSUdfTkVURklMVEVSX1hUX1RBUkdF
VF9DTEFTU0lGWSBpcyBub3Qgc2V0CkNPTkZJR19ORVRGSUxURVJfWFRfVEFSR0VUX0NPTk5N
QVJLPW0KQ09ORklHX05FVEZJTFRFUl9YVF9UQVJHRVRfQ1Q9bQpDT05GSUdfTkVURklMVEVS
X1hUX1RBUkdFVF9EU0NQPW0KQ09ORklHX05FVEZJTFRFUl9YVF9UQVJHRVRfSEw9bQojIENP
TkZJR19ORVRGSUxURVJfWFRfVEFSR0VUX0hNQVJLIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVU
RklMVEVSX1hUX1RBUkdFVF9JRExFVElNRVIgaXMgbm90IHNldApDT05GSUdfTkVURklMVEVS
X1hUX1RBUkdFVF9MT0c9bQojIENPTkZJR19ORVRGSUxURVJfWFRfVEFSR0VUX01BUksgaXMg
bm90IHNldApDT05GSUdfTkVURklMVEVSX1hUX05BVD1tCiMgQ09ORklHX05FVEZJTFRFUl9Y
VF9UQVJHRVRfTkVUTUFQIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVURklMVEVSX1hUX1RBUkdF
VF9ORkxPRyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVEZJTFRFUl9YVF9UQVJHRVRfTkZRVUVV
RSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVEZJTFRFUl9YVF9UQVJHRVRfTk9UUkFDSyBpcyBu
b3Qgc2V0CkNPTkZJR19ORVRGSUxURVJfWFRfVEFSR0VUX1JBVEVFU1Q9bQpDT05GSUdfTkVU
RklMVEVSX1hUX1RBUkdFVF9SRURJUkVDVD1tCkNPTkZJR19ORVRGSUxURVJfWFRfVEFSR0VU
X01BU1FVRVJBREU9bQojIENPTkZJR19ORVRGSUxURVJfWFRfVEFSR0VUX1RFRSBpcyBub3Qg
c2V0CiMgQ09ORklHX05FVEZJTFRFUl9YVF9UQVJHRVRfVFBST1hZIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkVURklMVEVSX1hUX1RBUkdFVF9UUkFDRSBpcyBub3Qgc2V0CiMgQ09ORklHX05F
VEZJTFRFUl9YVF9UQVJHRVRfVENQTVNTIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVURklMVEVS
X1hUX1RBUkdFVF9UQ1BPUFRTVFJJUCBpcyBub3Qgc2V0CgojCiMgWHRhYmxlcyBtYXRjaGVz
CiMKQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9BRERSVFlQRT1tCiMgQ09ORklHX05FVEZJ
TFRFUl9YVF9NQVRDSF9CUEYgaXMgbm90IHNldApDT05GSUdfTkVURklMVEVSX1hUX01BVENI
X0NHUk9VUD1tCiMgQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9DTFVTVEVSIGlzIG5vdCBz
ZXQKQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9DT01NRU5UPW0KQ09ORklHX05FVEZJTFRF
Ul9YVF9NQVRDSF9DT05OQllURVM9bQpDT05GSUdfTkVURklMVEVSX1hUX01BVENIX0NPTk5M
QUJFTD1tCkNPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfQ09OTkxJTUlUPW0KQ09ORklHX05F
VEZJTFRFUl9YVF9NQVRDSF9DT05OTUFSSz1tCkNPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hf
Q09OTlRSQUNLPW0KIyBDT05GSUdfTkVURklMVEVSX1hUX01BVENIX0NQVSBpcyBub3Qgc2V0
CiMgQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9EQ0NQIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkVURklMVEVSX1hUX01BVENIX0RFVkdST1VQIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVURklM
VEVSX1hUX01BVENIX0RTQ1AgaXMgbm90IHNldApDT05GSUdfTkVURklMVEVSX1hUX01BVENI
X0VDTj1tCiMgQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9FU1AgaXMgbm90IHNldAojIENP
TkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfSEFTSExJTUlUIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkVURklMVEVSX1hUX01BVENIX0hFTFBFUiBpcyBub3Qgc2V0CkNPTkZJR19ORVRGSUxURVJf
WFRfTUFUQ0hfSEw9bQojIENPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfSVBDT01QIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkVURklMVEVSX1hUX01BVENIX0lQUkFOR0UgaXMgbm90IHNldApD
T05GSUdfTkVURklMVEVSX1hUX01BVENIX0lQVlM9bQojIENPTkZJR19ORVRGSUxURVJfWFRf
TUFUQ0hfTDJUUCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9MRU5H
VEggaXMgbm90IHNldApDT05GSUdfTkVURklMVEVSX1hUX01BVENIX0xJTUlUPW0KQ09ORklH
X05FVEZJTFRFUl9YVF9NQVRDSF9NQUM9bQpDT05GSUdfTkVURklMVEVSX1hUX01BVENIX01B
Uks9bQpDT05GSUdfTkVURklMVEVSX1hUX01BVENIX01VTFRJUE9SVD1tCiMgQ09ORklHX05F
VEZJTFRFUl9YVF9NQVRDSF9ORkFDQ1QgaXMgbm90IHNldAojIENPTkZJR19ORVRGSUxURVJf
WFRfTUFUQ0hfT1NGIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVURklMVEVSX1hUX01BVENIX09X
TkVSIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVURklMVEVSX1hUX01BVENIX1BPTElDWSBpcyBu
b3Qgc2V0CiMgQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9QS1RUWVBFIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkVURklMVEVSX1hUX01BVENIX1FVT1RBIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkVURklMVEVSX1hUX01BVENIX1JBVEVFU1QgaXMgbm90IHNldAojIENPTkZJR19ORVRGSUxU
RVJfWFRfTUFUQ0hfUkVBTE0gaXMgbm90IHNldApDT05GSUdfTkVURklMVEVSX1hUX01BVENI
X1JFQ0VOVD1tCiMgQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9TQ1RQIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkVURklMVEVSX1hUX01BVENIX1NPQ0tFVCBpcyBub3Qgc2V0CkNPTkZJR19O
RVRGSUxURVJfWFRfTUFUQ0hfU1RBVEU9bQojIENPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hf
U1RBVElTVElDIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVURklMVEVSX1hUX01BVENIX1NUUklO
RyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9UQ1BNU1MgaXMgbm90
IHNldAojIENPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfVElNRSBpcyBub3Qgc2V0CiMgQ09O
RklHX05FVEZJTFRFUl9YVF9NQVRDSF9VMzIgaXMgbm90IHNldAojIGVuZCBvZiBDb3JlIE5l
dGZpbHRlciBDb25maWd1cmF0aW9uCgpDT05GSUdfSVBfU0VUPW0KQ09ORklHX0lQX1NFVF9N
QVg9MjU2CkNPTkZJR19JUF9TRVRfQklUTUFQX0lQPW0KQ09ORklHX0lQX1NFVF9CSVRNQVBf
SVBNQUM9bQpDT05GSUdfSVBfU0VUX0JJVE1BUF9QT1JUPW0KQ09ORklHX0lQX1NFVF9IQVNI
X0lQPW0KQ09ORklHX0lQX1NFVF9IQVNIX0lQTUFSSz1tCkNPTkZJR19JUF9TRVRfSEFTSF9J
UFBPUlQ9bQpDT05GSUdfSVBfU0VUX0hBU0hfSVBQT1JUSVA9bQpDT05GSUdfSVBfU0VUX0hB
U0hfSVBQT1JUTkVUPW0KQ09ORklHX0lQX1NFVF9IQVNIX0lQTUFDPW0KQ09ORklHX0lQX1NF
VF9IQVNIX01BQz1tCkNPTkZJR19JUF9TRVRfSEFTSF9ORVRQT1JUTkVUPW0KQ09ORklHX0lQ
X1NFVF9IQVNIX05FVD1tCkNPTkZJR19JUF9TRVRfSEFTSF9ORVRORVQ9bQpDT05GSUdfSVBf
U0VUX0hBU0hfTkVUUE9SVD1tCkNPTkZJR19JUF9TRVRfSEFTSF9ORVRJRkFDRT1tCkNPTkZJ
R19JUF9TRVRfTElTVF9TRVQ9bQpDT05GSUdfSVBfVlM9bQpDT05GSUdfSVBfVlNfSVBWNj15
CiMgQ09ORklHX0lQX1ZTX0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX0lQX1ZTX1RBQl9CSVRT
PTEyCgojCiMgSVBWUyB0cmFuc3BvcnQgcHJvdG9jb2wgbG9hZCBiYWxhbmNpbmcgc3VwcG9y
dAojCkNPTkZJR19JUF9WU19QUk9UT19UQ1A9eQpDT05GSUdfSVBfVlNfUFJPVE9fVURQPXkK
Q09ORklHX0lQX1ZTX1BST1RPX0FIX0VTUD15CkNPTkZJR19JUF9WU19QUk9UT19FU1A9eQpD
T05GSUdfSVBfVlNfUFJPVE9fQUg9eQpDT05GSUdfSVBfVlNfUFJPVE9fU0NUUD15CgojCiMg
SVBWUyBzY2hlZHVsZXIKIwpDT05GSUdfSVBfVlNfUlI9bQpDT05GSUdfSVBfVlNfV1JSPW0K
Q09ORklHX0lQX1ZTX0xDPW0KQ09ORklHX0lQX1ZTX1dMQz1tCkNPTkZJR19JUF9WU19GTz1t
CkNPTkZJR19JUF9WU19PVkY9bQpDT05GSUdfSVBfVlNfTEJMQz1tCkNPTkZJR19JUF9WU19M
QkxDUj1tCkNPTkZJR19JUF9WU19ESD1tCkNPTkZJR19JUF9WU19TSD1tCkNPTkZJR19JUF9W
U19NSD1tCkNPTkZJR19JUF9WU19TRUQ9bQpDT05GSUdfSVBfVlNfTlE9bQpDT05GSUdfSVBf
VlNfVFdPUz1tCgojCiMgSVBWUyBTSCBzY2hlZHVsZXIKIwpDT05GSUdfSVBfVlNfU0hfVEFC
X0JJVFM9OAoKIwojIElQVlMgTUggc2NoZWR1bGVyCiMKQ09ORklHX0lQX1ZTX01IX1RBQl9J
TkRFWD0xMgoKIwojIElQVlMgYXBwbGljYXRpb24gaGVscGVyCiMKQ09ORklHX0lQX1ZTX05G
Q1Q9eQoKIwojIElQOiBOZXRmaWx0ZXIgQ29uZmlndXJhdGlvbgojCkNPTkZJR19ORl9ERUZS
QUdfSVBWND1tCkNPTkZJR19ORl9TT0NLRVRfSVBWND1tCkNPTkZJR19ORl9UUFJPWFlfSVBW
ND1tCkNPTkZJR19ORl9UQUJMRVNfSVBWND15CkNPTkZJR19ORlRfUkVKRUNUX0lQVjQ9bQpD
T05GSUdfTkZUX0RVUF9JUFY0PW0KQ09ORklHX05GVF9GSUJfSVBWND1tCiMgQ09ORklHX05G
X1RBQkxFU19BUlAgaXMgbm90IHNldApDT05GSUdfTkZfRFVQX0lQVjQ9bQpDT05GSUdfTkZf
TE9HX0FSUD15CkNPTkZJR19ORl9MT0dfSVBWND1tCkNPTkZJR19ORl9SRUpFQ1RfSVBWND1t
CkNPTkZJR19JUF9ORl9JUFRBQkxFUz1tCkNPTkZJR19JUF9ORl9NQVRDSF9BSD1tCkNPTkZJ
R19JUF9ORl9NQVRDSF9FQ049bQojIENPTkZJR19JUF9ORl9NQVRDSF9SUEZJTFRFUiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0lQX05GX01BVENIX1RUTCBpcyBub3Qgc2V0CkNPTkZJR19JUF9O
Rl9GSUxURVI9bQpDT05GSUdfSVBfTkZfVEFSR0VUX1JFSkVDVD1tCiMgQ09ORklHX0lQX05G
X1RBUkdFVF9TWU5QUk9YWSBpcyBub3Qgc2V0CkNPTkZJR19JUF9ORl9OQVQ9bQpDT05GSUdf
SVBfTkZfVEFSR0VUX01BU1FVRVJBREU9bQojIENPTkZJR19JUF9ORl9UQVJHRVRfTkVUTUFQ
IGlzIG5vdCBzZXQKQ09ORklHX0lQX05GX1RBUkdFVF9SRURJUkVDVD1tCkNPTkZJR19JUF9O
Rl9NQU5HTEU9bQojIENPTkZJR19JUF9ORl9UQVJHRVRfQ0xVU1RFUklQIGlzIG5vdCBzZXQK
IyBDT05GSUdfSVBfTkZfVEFSR0VUX0VDTiBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX05GX1RB
UkdFVF9UVEwgaXMgbm90IHNldApDT05GSUdfSVBfTkZfUkFXPW0KIyBDT05GSUdfSVBfTkZf
U0VDVVJJVFkgaXMgbm90IHNldAojIENPTkZJR19JUF9ORl9BUlBUQUJMRVMgaXMgbm90IHNl
dAojIGVuZCBvZiBJUDogTmV0ZmlsdGVyIENvbmZpZ3VyYXRpb24KCiMKIyBJUHY2OiBOZXRm
aWx0ZXIgQ29uZmlndXJhdGlvbgojCkNPTkZJR19ORl9TT0NLRVRfSVBWNj1tCkNPTkZJR19O
Rl9UUFJPWFlfSVBWNj1tCkNPTkZJR19ORl9UQUJMRVNfSVBWNj15CkNPTkZJR19ORlRfUkVK
RUNUX0lQVjY9bQpDT05GSUdfTkZUX0RVUF9JUFY2PW0KQ09ORklHX05GVF9GSUJfSVBWNj1t
CkNPTkZJR19ORl9EVVBfSVBWNj1tCkNPTkZJR19ORl9SRUpFQ1RfSVBWNj1tCkNPTkZJR19O
Rl9MT0dfSVBWNj1tCkNPTkZJR19JUDZfTkZfSVBUQUJMRVM9bQpDT05GSUdfSVA2X05GX01B
VENIX0FIPW0KQ09ORklHX0lQNl9ORl9NQVRDSF9FVUk2ND1tCkNPTkZJR19JUDZfTkZfTUFU
Q0hfRlJBRz1tCkNPTkZJR19JUDZfTkZfTUFUQ0hfT1BUUz1tCkNPTkZJR19JUDZfTkZfTUFU
Q0hfSEw9bQpDT05GSUdfSVA2X05GX01BVENIX0lQVjZIRUFERVI9bQpDT05GSUdfSVA2X05G
X01BVENIX01IPW0KQ09ORklHX0lQNl9ORl9NQVRDSF9SUEZJTFRFUj1tCkNPTkZJR19JUDZf
TkZfTUFUQ0hfUlQ9bQpDT05GSUdfSVA2X05GX01BVENIX1NSSD1tCkNPTkZJR19JUDZfTkZf
VEFSR0VUX0hMPW0KQ09ORklHX0lQNl9ORl9GSUxURVI9bQpDT05GSUdfSVA2X05GX1RBUkdF
VF9SRUpFQ1Q9bQpDT05GSUdfSVA2X05GX1RBUkdFVF9TWU5QUk9YWT1tCkNPTkZJR19JUDZf
TkZfTUFOR0xFPW0KQ09ORklHX0lQNl9ORl9SQVc9bQpDT05GSUdfSVA2X05GX1NFQ1VSSVRZ
PW0KQ09ORklHX0lQNl9ORl9OQVQ9bQpDT05GSUdfSVA2X05GX1RBUkdFVF9NQVNRVUVSQURF
PW0KQ09ORklHX0lQNl9ORl9UQVJHRVRfTlBUPW0KIyBlbmQgb2YgSVB2NjogTmV0ZmlsdGVy
IENvbmZpZ3VyYXRpb24KCkNPTkZJR19ORl9ERUZSQUdfSVBWNj1tCiMgQ09ORklHX05GX1RB
QkxFU19CUklER0UgaXMgbm90IHNldApDT05GSUdfTkZfQ09OTlRSQUNLX0JSSURHRT1tCiMg
Q09ORklHX0JSSURHRV9ORl9FQlRBQkxFUyBpcyBub3Qgc2V0CiMgQ09ORklHX0JQRklMVEVS
IGlzIG5vdCBzZXQKIyBDT05GSUdfSVBfRENDUCBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX1ND
VFAgaXMgbm90IHNldAojIENPTkZJR19SRFMgaXMgbm90IHNldAojIENPTkZJR19USVBDIGlz
IG5vdCBzZXQKIyBDT05GSUdfQVRNIGlzIG5vdCBzZXQKIyBDT05GSUdfTDJUUCBpcyBub3Qg
c2V0CkNPTkZJR19TVFA9bQpDT05GSUdfR0FSUD1tCkNPTkZJR19CUklER0U9bQpDT05GSUdf
QlJJREdFX0lHTVBfU05PT1BJTkc9eQpDT05GSUdfQlJJREdFX1ZMQU5fRklMVEVSSU5HPXkK
IyBDT05GSUdfQlJJREdFX01SUCBpcyBub3Qgc2V0CiMgQ09ORklHX0JSSURHRV9DRk0gaXMg
bm90IHNldAojIENPTkZJR19ORVRfRFNBIGlzIG5vdCBzZXQKQ09ORklHX1ZMQU5fODAyMVE9
bQpDT05GSUdfVkxBTl84MDIxUV9HVlJQPXkKIyBDT05GSUdfVkxBTl84MDIxUV9NVlJQIGlz
IG5vdCBzZXQKQ09ORklHX0xMQz1tCiMgQ09ORklHX0xMQzIgaXMgbm90IHNldAojIENPTkZJ
R19BVEFMSyBpcyBub3Qgc2V0CiMgQ09ORklHX1gyNSBpcyBub3Qgc2V0CiMgQ09ORklHX0xB
UEIgaXMgbm90IHNldAojIENPTkZJR19QSE9ORVQgaXMgbm90IHNldAojIENPTkZJR182TE9X
UEFOIGlzIG5vdCBzZXQKIyBDT05GSUdfSUVFRTgwMjE1NCBpcyBub3Qgc2V0CiMgQ09ORklH
X05FVF9TQ0hFRCBpcyBub3Qgc2V0CiMgQ09ORklHX0RDQiBpcyBub3Qgc2V0CkNPTkZJR19E
TlNfUkVTT0xWRVI9eQojIENPTkZJR19CQVRNQU5fQURWIGlzIG5vdCBzZXQKIyBDT05GSUdf
T1BFTlZTV0lUQ0ggaXMgbm90IHNldAojIENPTkZJR19WU09DS0VUUyBpcyBub3Qgc2V0CkNP
TkZJR19ORVRMSU5LX0RJQUc9eQojIENPTkZJR19NUExTIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkVUX05TSCBpcyBub3Qgc2V0CiMgQ09ORklHX0hTUiBpcyBub3Qgc2V0CiMgQ09ORklHX05F
VF9TV0lUQ0hERVYgaXMgbm90IHNldApDT05GSUdfTkVUX0wzX01BU1RFUl9ERVY9eQojIENP
TkZJR19RUlRSIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX05DU0kgaXMgbm90IHNldApDT05G
SUdfUENQVV9ERVZfUkVGQ05UPXkKQ09ORklHX1JQUz15CkNPTkZJR19SRlNfQUNDRUw9eQpD
T05GSUdfU09DS19SWF9RVUVVRV9NQVBQSU5HPXkKQ09ORklHX1hQUz15CkNPTkZJR19DR1JP
VVBfTkVUX1BSSU89eQpDT05GSUdfQ0dST1VQX05FVF9DTEFTU0lEPXkKQ09ORklHX05FVF9S
WF9CVVNZX1BPTEw9eQpDT05GSUdfQlFMPXkKQ09ORklHX0JQRl9TVFJFQU1fUEFSU0VSPXkK
Q09ORklHX05FVF9GTE9XX0xJTUlUPXkKCiMKIyBOZXR3b3JrIHRlc3RpbmcKIwojIENPTkZJ
R19ORVRfUEtUR0VOIGlzIG5vdCBzZXQKIyBlbmQgb2YgTmV0d29yayB0ZXN0aW5nCiMgZW5k
IG9mIE5ldHdvcmtpbmcgb3B0aW9ucwoKIyBDT05GSUdfSEFNUkFESU8gaXMgbm90IHNldAoj
IENPTkZJR19DQU4gaXMgbm90IHNldAojIENPTkZJR19CVCBpcyBub3Qgc2V0CiMgQ09ORklH
X0FGX1JYUlBDIGlzIG5vdCBzZXQKIyBDT05GSUdfQUZfS0NNIGlzIG5vdCBzZXQKQ09ORklH
X1NUUkVBTV9QQVJTRVI9eQojIENPTkZJR19NQ1RQIGlzIG5vdCBzZXQKQ09ORklHX0ZJQl9S
VUxFUz15CiMgQ09ORklHX1dJUkVMRVNTIGlzIG5vdCBzZXQKIyBDT05GSUdfUkZLSUxMIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkVUXzlQIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0FJRiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0NFUEhfTElCIGlzIG5vdCBzZXQKIyBDT05GSUdfTkZDIGlzIG5v
dCBzZXQKIyBDT05GSUdfUFNBTVBMRSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9JRkUgaXMg
bm90IHNldAojIENPTkZJR19MV1RVTk5FTCBpcyBub3Qgc2V0CkNPTkZJR19EU1RfQ0FDSEU9
eQpDT05GSUdfR1JPX0NFTExTPXkKQ09ORklHX1NPQ0tfVkFMSURBVEVfWE1JVD15CkNPTkZJ
R19ORVRfU0VMRlRFU1RTPW0KQ09ORklHX05FVF9TT0NLX01TRz15CkNPTkZJR19QQUdFX1BP
T0w9eQojIENPTkZJR19QQUdFX1BPT0xfU1RBVFMgaXMgbm90IHNldApDT05GSUdfRkFJTE9W
RVI9bQpDT05GSUdfRVRIVE9PTF9ORVRMSU5LPXkKCiMKIyBEZXZpY2UgRHJpdmVycwojCkNP
TkZJR19IQVZFX0VJU0E9eQojIENPTkZJR19FSVNBIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVf
UENJPXkKQ09ORklHX1BDST15CkNPTkZJR19QQ0lfRE9NQUlOUz15CkNPTkZJR19QQ0lFUE9S
VEJVUz15CkNPTkZJR19IT1RQTFVHX1BDSV9QQ0lFPXkKQ09ORklHX1BDSUVBRVI9eQojIENP
TkZJR19QQ0lFQUVSX0lOSkVDVCBpcyBub3Qgc2V0CiMgQ09ORklHX1BDSUVfRUNSQyBpcyBu
b3Qgc2V0CkNPTkZJR19QQ0lFQVNQTT15CkNPTkZJR19QQ0lFQVNQTV9ERUZBVUxUPXkKIyBD
T05GSUdfUENJRUFTUE1fUE9XRVJTQVZFIGlzIG5vdCBzZXQKIyBDT05GSUdfUENJRUFTUE1f
UE9XRVJfU1VQRVJTQVZFIGlzIG5vdCBzZXQKIyBDT05GSUdfUENJRUFTUE1fUEVSRk9STUFO
Q0UgaXMgbm90IHNldApDT05GSUdfUENJRV9QTUU9eQpDT05GSUdfUENJRV9EUEM9eQpDT05G
SUdfUENJRV9QVE09eQpDT05GSUdfUENJRV9FRFI9eQpDT05GSUdfUENJX01TST15CkNPTkZJ
R19QQ0lfTVNJX0lSUV9ET01BSU49eQpDT05GSUdfUENJX1FVSVJLUz15CkNPTkZJR19QQ0lf
UkVBTExPQ19FTkFCTEVfQVVUTz15CkNPTkZJR19QQ0lfU1RVQj1tCkNPTkZJR19QQ0lfUEZf
U1RVQj1tCkNPTkZJR19QQ0lfQVRTPXkKQ09ORklHX1BDSV9MT0NLTEVTU19DT05GSUc9eQpD
T05GSUdfUENJX0lPVj15CkNPTkZJR19QQ0lfUFJJPXkKQ09ORklHX1BDSV9QQVNJRD15CiMg
Q09ORklHX1BDSV9QMlBETUEgaXMgbm90IHNldApDT05GSUdfUENJX0xBQkVMPXkKQ09ORklH
X1ZHQV9BUkI9eQpDT05GSUdfVkdBX0FSQl9NQVhfR1BVUz0xNgpDT05GSUdfSE9UUExVR19Q
Q0k9eQpDT05GSUdfSE9UUExVR19QQ0lfQUNQST15CkNPTkZJR19IT1RQTFVHX1BDSV9BQ1BJ
X0lCTT1tCkNPTkZJR19IT1RQTFVHX1BDSV9DUENJPXkKQ09ORklHX0hPVFBMVUdfUENJX0NQ
Q0lfWlQ1NTUwPW0KQ09ORklHX0hPVFBMVUdfUENJX0NQQ0lfR0VORVJJQz1tCkNPTkZJR19I
T1RQTFVHX1BDSV9TSFBDPXkKCiMKIyBQQ0kgY29udHJvbGxlciBkcml2ZXJzCiMKQ09ORklH
X1ZNRD1tCgojCiMgRGVzaWduV2FyZSBQQ0kgQ29yZSBTdXBwb3J0CiMKQ09ORklHX1BDSUVf
RFc9eQpDT05GSUdfUENJRV9EV19IT1NUPXkKQ09ORklHX1BDSUVfRFdfRVA9eQpDT05GSUdf
UENJRV9EV19QTEFUPXkKQ09ORklHX1BDSUVfRFdfUExBVF9IT1NUPXkKQ09ORklHX1BDSUVf
RFdfUExBVF9FUD15CiMgQ09ORklHX1BDSV9NRVNPTiBpcyBub3Qgc2V0CiMgZW5kIG9mIERl
c2lnbldhcmUgUENJIENvcmUgU3VwcG9ydAoKIwojIE1vYml2ZWlsIFBDSWUgQ29yZSBTdXBw
b3J0CiMKIyBlbmQgb2YgTW9iaXZlaWwgUENJZSBDb3JlIFN1cHBvcnQKCiMKIyBDYWRlbmNl
IFBDSWUgY29udHJvbGxlcnMgc3VwcG9ydAojCiMgZW5kIG9mIENhZGVuY2UgUENJZSBjb250
cm9sbGVycyBzdXBwb3J0CiMgZW5kIG9mIFBDSSBjb250cm9sbGVyIGRyaXZlcnMKCiMKIyBQ
Q0kgRW5kcG9pbnQKIwpDT05GSUdfUENJX0VORFBPSU5UPXkKQ09ORklHX1BDSV9FTkRQT0lO
VF9DT05GSUdGUz15CiMgQ09ORklHX1BDSV9FUEZfVEVTVCBpcyBub3Qgc2V0CkNPTkZJR19Q
Q0lfRVBGX05UQj1tCiMgZW5kIG9mIFBDSSBFbmRwb2ludAoKIwojIFBDSSBzd2l0Y2ggY29u
dHJvbGxlciBkcml2ZXJzCiMKIyBDT05GSUdfUENJX1NXX1NXSVRDSFRFQyBpcyBub3Qgc2V0
CiMgZW5kIG9mIFBDSSBzd2l0Y2ggY29udHJvbGxlciBkcml2ZXJzCgojIENPTkZJR19DWExf
QlVTIGlzIG5vdCBzZXQKIyBDT05GSUdfUENDQVJEIGlzIG5vdCBzZXQKIyBDT05GSUdfUkFQ
SURJTyBpcyBub3Qgc2V0CgojCiMgR2VuZXJpYyBEcml2ZXIgT3B0aW9ucwojCkNPTkZJR19V
RVZFTlRfSEVMUEVSPXkKQ09ORklHX1VFVkVOVF9IRUxQRVJfUEFUSD0iIgpDT05GSUdfREVW
VE1QRlM9eQpDT05GSUdfREVWVE1QRlNfTU9VTlQ9eQojIENPTkZJR19ERVZUTVBGU19TQUZF
IGlzIG5vdCBzZXQKIyBDT05GSUdfU1RBTkRBTE9ORSBpcyBub3Qgc2V0CkNPTkZJR19QUkVW
RU5UX0ZJUk1XQVJFX0JVSUxEPXkKCiMKIyBGaXJtd2FyZSBsb2FkZXIKIwpDT05GSUdfRldf
TE9BREVSPXkKQ09ORklHX0ZXX0xPQURFUl9QQUdFRF9CVUY9eQpDT05GSUdfRldfTE9BREVS
X1NZU0ZTPXkKQ09ORklHX0VYVFJBX0ZJUk1XQVJFPSIiCkNPTkZJR19GV19MT0FERVJfVVNF
Ul9IRUxQRVI9eQojIENPTkZJR19GV19MT0FERVJfVVNFUl9IRUxQRVJfRkFMTEJBQ0sgaXMg
bm90IHNldApDT05GSUdfRldfTE9BREVSX0NPTVBSRVNTPXkKQ09ORklHX0ZXX0xPQURFUl9D
T01QUkVTU19YWj15CiMgQ09ORklHX0ZXX0xPQURFUl9DT01QUkVTU19aU1REIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRldfVVBMT0FEIGlzIG5vdCBzZXQKIyBlbmQgb2YgRmlybXdhcmUgbG9h
ZGVyCgpDT05GSUdfQUxMT1dfREVWX0NPUkVEVU1QPXkKQ09ORklHX0hNRU1fUkVQT1JUSU5H
PXkKIyBDT05GSUdfVEVTVF9BU1lOQ19EUklWRVJfUFJPQkUgaXMgbm90IHNldApDT05GSUdf
R0VORVJJQ19DUFVfQVVUT1BST0JFPXkKQ09ORklHX0dFTkVSSUNfQ1BVX1ZVTE5FUkFCSUxJ
VElFUz15CkNPTkZJR19SRUdNQVA9eQpDT05GSUdfUkVHTUFQX01NSU89eQpDT05GSUdfRE1B
X1NIQVJFRF9CVUZGRVI9eQojIENPTkZJR19ETUFfRkVOQ0VfVFJBQ0UgaXMgbm90IHNldAoj
IGVuZCBvZiBHZW5lcmljIERyaXZlciBPcHRpb25zCgojCiMgQnVzIGRldmljZXMKIwojIENP
TkZJR19NSElfQlVTIGlzIG5vdCBzZXQKIyBDT05GSUdfTUhJX0JVU19FUCBpcyBub3Qgc2V0
CiMgZW5kIG9mIEJ1cyBkZXZpY2VzCgpDT05GSUdfQ09OTkVDVE9SPW0KCiMKIyBGaXJtd2Fy
ZSBEcml2ZXJzCiMKCiMKIyBBUk0gU3lzdGVtIENvbnRyb2wgYW5kIE1hbmFnZW1lbnQgSW50
ZXJmYWNlIFByb3RvY29sCiMKIyBlbmQgb2YgQVJNIFN5c3RlbSBDb250cm9sIGFuZCBNYW5h
Z2VtZW50IEludGVyZmFjZSBQcm90b2NvbAoKQ09ORklHX0VERD15CkNPTkZJR19FRERfT0ZG
PXkKQ09ORklHX0ZJUk1XQVJFX01FTU1BUD15CkNPTkZJR19ETUlJRD15CkNPTkZJR19ETUlf
U1lTRlM9bQpDT05GSUdfRE1JX1NDQU5fTUFDSElORV9OT05fRUZJX0ZBTExCQUNLPXkKIyBD
T05GSUdfSVNDU0lfSUJGVCBpcyBub3Qgc2V0CkNPTkZJR19GV19DRkdfU1lTRlM9bQojIENP
TkZJR19GV19DRkdfU1lTRlNfQ01ETElORSBpcyBub3Qgc2V0CkNPTkZJR19TWVNGQj15CiMg
Q09ORklHX1NZU0ZCX1NJTVBMRUZCIGlzIG5vdCBzZXQKIyBDT05GSUdfR09PR0xFX0ZJUk1X
QVJFIGlzIG5vdCBzZXQKCiMKIyBFRkkgKEV4dGVuc2libGUgRmlybXdhcmUgSW50ZXJmYWNl
KSBTdXBwb3J0CiMKQ09ORklHX0VGSV9FU1JUPXkKQ09ORklHX0VGSV9WQVJTX1BTVE9SRT1t
CiMgQ09ORklHX0VGSV9WQVJTX1BTVE9SRV9ERUZBVUxUX0RJU0FCTEUgaXMgbm90IHNldApD
T05GSUdfRUZJX1JVTlRJTUVfTUFQPXkKIyBDT05GSUdfRUZJX0ZBS0VfTUVNTUFQIGlzIG5v
dCBzZXQKQ09ORklHX0VGSV9TT0ZUX1JFU0VSVkU9eQpDT05GSUdfRUZJX0RYRV9NRU1fQVRU
UklCVVRFUz15CkNPTkZJR19FRklfUlVOVElNRV9XUkFQUEVSUz15CkNPTkZJR19FRklfR0VO
RVJJQ19TVFVCX0lOSVRSRF9DTURMSU5FX0xPQURFUj15CkNPTkZJR19FRklfQk9PVExPQURF
Ul9DT05UUk9MPW0KQ09ORklHX0VGSV9DQVBTVUxFX0xPQURFUj1tCkNPTkZJR19FRklfVEVT
VD1tCkNPTkZJR19FRklfREVWX1BBVEhfUEFSU0VSPXkKQ09ORklHX0FQUExFX1BST1BFUlRJ
RVM9eQpDT05GSUdfUkVTRVRfQVRUQUNLX01JVElHQVRJT049eQpDT05GSUdfRUZJX1JDSTJf
VEFCTEU9eQojIENPTkZJR19FRklfRElTQUJMRV9QQ0lfRE1BIGlzIG5vdCBzZXQKQ09ORklH
X0VGSV9DVVNUT01fU1NEVF9PVkVSTEFZUz15CiMgQ09ORklHX0VGSV9ESVNBQkxFX1JVTlRJ
TUUgaXMgbm90IHNldAojIENPTkZJR19FRklfQ09DT19TRUNSRVQgaXMgbm90IHNldAojIGVu
ZCBvZiBFRkkgKEV4dGVuc2libGUgRmlybXdhcmUgSW50ZXJmYWNlKSBTdXBwb3J0CgpDT05G
SUdfVUVGSV9DUEVSPXkKQ09ORklHX1VFRklfQ1BFUl9YODY9eQoKIwojIFRlZ3JhIGZpcm13
YXJlIGRyaXZlcgojCiMgZW5kIG9mIFRlZ3JhIGZpcm13YXJlIGRyaXZlcgojIGVuZCBvZiBG
aXJtd2FyZSBEcml2ZXJzCgojIENPTkZJR19HTlNTIGlzIG5vdCBzZXQKIyBDT05GSUdfTVRE
IGlzIG5vdCBzZXQKIyBDT05GSUdfT0YgaXMgbm90IHNldApDT05GSUdfQVJDSF9NSUdIVF9I
QVZFX1BDX1BBUlBPUlQ9eQojIENPTkZJR19QQVJQT1JUIGlzIG5vdCBzZXQKQ09ORklHX1BO
UD15CiMgQ09ORklHX1BOUF9ERUJVR19NRVNTQUdFUyBpcyBub3Qgc2V0CgojCiMgUHJvdG9j
b2xzCiMKQ09ORklHX1BOUEFDUEk9eQpDT05GSUdfQkxLX0RFVj15CiMgQ09ORklHX0JMS19E
RVZfTlVMTF9CTEsgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0ZEIGlzIG5vdCBzZXQK
Q09ORklHX0NEUk9NPW0KIyBDT05GSUdfQkxLX0RFVl9QQ0lFU1NEX01USVAzMlhYIGlzIG5v
dCBzZXQKIyBDT05GSUdfWlJBTSBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX0xPT1A9bQpD
T05GSUdfQkxLX0RFVl9MT09QX01JTl9DT1VOVD04CiMgQ09ORklHX0JMS19ERVZfRFJCRCBp
cyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX05CRD1tCkNPTkZJR19CTEtfREVWX1JBTT1tCkNP
TkZJR19CTEtfREVWX1JBTV9DT1VOVD0xNgpDT05GSUdfQkxLX0RFVl9SQU1fU0laRT02NTUz
NgojIENPTkZJR19DRFJPTV9QS1RDRFZEIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRBX09WRVJf
RVRIIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9SQkQgaXMgbm90IHNldAojIENPTkZJ
R19CTEtfREVWX1VCTEsgaXMgbm90IHNldAoKIwojIE5WTUUgU3VwcG9ydAojCiMgQ09ORklH
X0JMS19ERVZfTlZNRSBpcyBub3Qgc2V0CiMgQ09ORklHX05WTUVfRkMgaXMgbm90IHNldAoj
IENPTkZJR19OVk1FX1RDUCBpcyBub3Qgc2V0CiMgQ09ORklHX05WTUVfVEFSR0VUIGlzIG5v
dCBzZXQKIyBlbmQgb2YgTlZNRSBTdXBwb3J0CgojCiMgTWlzYyBkZXZpY2VzCiMKIyBDT05G
SUdfQUQ1MjVYX0RQT1QgaXMgbm90IHNldAojIENPTkZJR19EVU1NWV9JUlEgaXMgbm90IHNl
dAojIENPTkZJR19JQk1fQVNNIGlzIG5vdCBzZXQKIyBDT05GSUdfUEhBTlRPTSBpcyBub3Qg
c2V0CiMgQ09ORklHX1RJRk1fQ09SRSBpcyBub3Qgc2V0CiMgQ09ORklHX0lDUzkzMlM0MDEg
aXMgbm90IHNldAojIENPTkZJR19FTkNMT1NVUkVfU0VSVklDRVMgaXMgbm90IHNldAojIENP
TkZJR19IUF9JTE8gaXMgbm90IHNldAojIENPTkZJR19BUERTOTgwMkFMUyBpcyBub3Qgc2V0
CiMgQ09ORklHX0lTTDI5MDAzIGlzIG5vdCBzZXQKIyBDT05GSUdfSVNMMjkwMjAgaXMgbm90
IHNldAojIENPTkZJR19TRU5TT1JTX1RTTDI1NTAgaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX0JIMTc3MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQVBEUzk5MFggaXMgbm90
IHNldAojIENPTkZJR19ITUM2MzUyIGlzIG5vdCBzZXQKIyBDT05GSUdfRFMxNjgyIGlzIG5v
dCBzZXQKIyBDT05GSUdfU1JBTSBpcyBub3Qgc2V0CiMgQ09ORklHX0RXX1hEQVRBX1BDSUUg
aXMgbm90IHNldAojIENPTkZJR19QQ0lfRU5EUE9JTlRfVEVTVCBpcyBub3Qgc2V0CiMgQ09O
RklHX1hJTElOWF9TREZFQyBpcyBub3Qgc2V0CiMgQ09ORklHX0MyUE9SVCBpcyBub3Qgc2V0
CgojCiMgRUVQUk9NIHN1cHBvcnQKIwojIENPTkZJR19FRVBST01fQVQyNCBpcyBub3Qgc2V0
CiMgQ09ORklHX0VFUFJPTV9MRUdBQ1kgaXMgbm90IHNldAojIENPTkZJR19FRVBST01fTUFY
Njg3NSBpcyBub3Qgc2V0CiMgQ09ORklHX0VFUFJPTV85M0NYNiBpcyBub3Qgc2V0CiMgQ09O
RklHX0VFUFJPTV9JRFRfODlIUEVTWCBpcyBub3Qgc2V0CiMgQ09ORklHX0VFUFJPTV9FRTEw
MDQgaXMgbm90IHNldAojIGVuZCBvZiBFRVBST00gc3VwcG9ydAoKIyBDT05GSUdfQ0I3MTBf
Q09SRSBpcyBub3Qgc2V0CgojCiMgVGV4YXMgSW5zdHJ1bWVudHMgc2hhcmVkIHRyYW5zcG9y
dCBsaW5lIGRpc2NpcGxpbmUKIwojIGVuZCBvZiBUZXhhcyBJbnN0cnVtZW50cyBzaGFyZWQg
dHJhbnNwb3J0IGxpbmUgZGlzY2lwbGluZQoKIyBDT05GSUdfU0VOU09SU19MSVMzX0kyQyBp
cyBub3Qgc2V0CgojCiMgQWx0ZXJhIEZQR0EgZmlybXdhcmUgZG93bmxvYWQgbW9kdWxlIChy
ZXF1aXJlcyBJMkMpCiMKIyBDT05GSUdfQUxURVJBX1NUQVBMIGlzIG5vdCBzZXQKQ09ORklH
X0lOVEVMX01FST1tCkNPTkZJR19JTlRFTF9NRUlfTUU9bQpDT05GSUdfSU5URUxfTUVJX1RY
RT1tCiMgQ09ORklHX1ZNV0FSRV9WTUNJIGlzIG5vdCBzZXQKIyBDT05GSUdfR0VOV1FFIGlz
IG5vdCBzZXQKIyBDT05GSUdfRUNITyBpcyBub3Qgc2V0CiMgQ09ORklHX0JDTV9WSyBpcyBu
b3Qgc2V0CiMgQ09ORklHX01JU0NfQUxDT1JfUENJIGlzIG5vdCBzZXQKIyBDT05GSUdfTUlT
Q19SVFNYX1BDSSBpcyBub3Qgc2V0CiMgQ09ORklHX0hBQkFOQV9BSSBpcyBub3Qgc2V0CiMg
Q09ORklHX1VBQ0NFIGlzIG5vdCBzZXQKIyBDT05GSUdfUFZQQU5JQyBpcyBub3Qgc2V0CiMg
ZW5kIG9mIE1pc2MgZGV2aWNlcwoKIwojIFNDU0kgZGV2aWNlIHN1cHBvcnQKIwpDT05GSUdf
U0NTSV9NT0Q9eQpDT05GSUdfUkFJRF9BVFRSUz1tCkNPTkZJR19TQ1NJX0NPTU1PTj15CkNP
TkZJR19TQ1NJPXkKQ09ORklHX1NDU0lfRE1BPXkKIyBDT05GSUdfU0NTSV9QUk9DX0ZTIGlz
IG5vdCBzZXQKCiMKIyBTQ1NJIHN1cHBvcnQgdHlwZSAoZGlzaywgdGFwZSwgQ0QtUk9NKQoj
CkNPTkZJR19CTEtfREVWX1NEPW0KIyBDT05GSUdfQ0hSX0RFVl9TVCBpcyBub3Qgc2V0CkNP
TkZJR19CTEtfREVWX1NSPW0KIyBDT05GSUdfQ0hSX0RFVl9TRyBpcyBub3Qgc2V0CiMgQ09O
RklHX0JMS19ERVZfQlNHIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hSX0RFVl9TQ0ggaXMgbm90
IHNldApDT05GSUdfU0NTSV9DT05TVEFOVFM9eQpDT05GSUdfU0NTSV9MT0dHSU5HPXkKQ09O
RklHX1NDU0lfU0NBTl9BU1lOQz15CgojCiMgU0NTSSBUcmFuc3BvcnRzCiMKIyBDT05GSUdf
U0NTSV9TUElfQVRUUlMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0ZDX0FUVFJTIGlzIG5v
dCBzZXQKQ09ORklHX1NDU0lfSVNDU0lfQVRUUlM9bQpDT05GSUdfU0NTSV9TQVNfQVRUUlM9
bQpDT05GSUdfU0NTSV9TQVNfTElCU0FTPW0KQ09ORklHX1NDU0lfU0FTX0FUQT15CkNPTkZJ
R19TQ1NJX1NBU19IT1NUX1NNUD15CkNPTkZJR19TQ1NJX1NSUF9BVFRSUz1tCiMgZW5kIG9m
IFNDU0kgVHJhbnNwb3J0cwoKQ09ORklHX1NDU0lfTE9XTEVWRUw9eQpDT05GSUdfSVNDU0lf
VENQPW0KIyBDT05GSUdfSVNDU0lfQk9PVF9TWVNGUyBpcyBub3Qgc2V0CiMgQ09ORklHX1ND
U0lfQ1hHQjNfSVNDU0kgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0NYR0I0X0lTQ1NJIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0NTSV9CTlgyX0lTQ1NJIGlzIG5vdCBzZXQKIyBDT05GSUdf
QkUySVNDU0kgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWXzNXX1hYWFhfUkFJRCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NDU0lfSFBTQSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfM1df
OVhYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfM1dfU0FTIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0NTSV9BQ0FSRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQUFDUkFJRCBpcyBub3Qg
c2V0CiMgQ09ORklHX1NDU0lfQUlDN1hYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQUlD
NzlYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQUlDOTRYWCBpcyBub3Qgc2V0CiMgQ09O
RklHX1NDU0lfTVZTQVMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX01WVU1JIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0NTSV9BRFZBTlNZUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQVJD
TVNSIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9FU0FTMlIgaXMgbm90IHNldAojIENPTkZJ
R19NRUdBUkFJRF9ORVdHRU4gaXMgbm90IHNldAojIENPTkZJR19NRUdBUkFJRF9MRUdBQ1kg
aXMgbm90IHNldAojIENPTkZJR19NRUdBUkFJRF9TQVMgaXMgbm90IHNldAojIENPTkZJR19T
Q1NJX01QVDNTQVMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX01QVDJTQVMgaXMgbm90IHNl
dAojIENPTkZJR19TQ1NJX01QSTNNUiBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfU01BUlRQ
UUkgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0hQVElPUCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NDU0lfQlVTTE9HSUMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX01ZUkIgaXMgbm90IHNl
dAojIENPTkZJR19TQ1NJX01ZUlMgaXMgbm90IHNldAojIENPTkZJR19WTVdBUkVfUFZTQ1NJ
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9TTklDIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NT
SV9ETVgzMTkxRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfRkRPTUFJTl9QQ0kgaXMgbm90
IHNldAojIENPTkZJR19TQ1NJX0lTQ0kgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0lQUyBp
cyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfSU5JVElPIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NT
SV9JTklBMTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9TVEVYIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0NTSV9TWU01M0M4WFhfMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfSVBSIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0NTSV9RTE9HSUNfMTI4MCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NDU0lfUUxBX0lTQ1NJIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9EQzM5NXggaXMgbm90
IHNldAojIENPTkZJR19TQ1NJX0FNNTNDOTc0IGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9X
RDcxOVggaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0NTSV9QTUNSQUlEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9QTTgwMDEgaXMgbm90
IHNldAojIENPTkZJR19TQ1NJX0RIIGlzIG5vdCBzZXQKIyBlbmQgb2YgU0NTSSBkZXZpY2Ug
c3VwcG9ydAoKQ09ORklHX0FUQT1tCkNPTkZJR19TQVRBX0hPU1Q9eQojIENPTkZJR19BVEFf
VkVSQk9TRV9FUlJPUiBpcyBub3Qgc2V0CkNPTkZJR19BVEFfRk9SQ0U9eQojIENPTkZJR19B
VEFfQUNQSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFfUE1QIGlzIG5vdCBzZXQKCiMKIyBD
b250cm9sbGVycyB3aXRoIG5vbi1TRkYgbmF0aXZlIGludGVyZmFjZQojCkNPTkZJR19TQVRB
X0FIQ0k9bQpDT05GSUdfU0FUQV9NT0JJTEVfTFBNX1BPTElDWT0zCkNPTkZJR19TQVRBX0FI
Q0lfUExBVEZPUk09bQojIENPTkZJR19BSENJX0RXQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NB
VEFfSU5JQzE2MlggaXMgbm90IHNldAojIENPTkZJR19TQVRBX0FDQVJEX0FIQ0kgaXMgbm90
IHNldAojIENPTkZJR19TQVRBX1NJTDI0IGlzIG5vdCBzZXQKIyBDT05GSUdfQVRBX1NGRiBp
cyBub3Qgc2V0CkNPTkZJR19NRD15CkNPTkZJR19CTEtfREVWX01EPW0KIyBDT05GSUdfTURf
TElORUFSIGlzIG5vdCBzZXQKIyBDT05GSUdfTURfUkFJRDAgaXMgbm90IHNldApDT05GSUdf
TURfUkFJRDE9bQojIENPTkZJR19NRF9SQUlEMTAgaXMgbm90IHNldApDT05GSUdfTURfUkFJ
RDQ1Nj1tCiMgQ09ORklHX01EX01VTFRJUEFUSCBpcyBub3Qgc2V0CiMgQ09ORklHX01EX0ZB
VUxUWSBpcyBub3Qgc2V0CiMgQ09ORklHX0JDQUNIRSBpcyBub3Qgc2V0CkNPTkZJR19CTEtf
REVWX0RNX0JVSUxUSU49eQpDT05GSUdfQkxLX0RFVl9ETT1tCiMgQ09ORklHX0RNX0RFQlVH
IGlzIG5vdCBzZXQKIyBDT05GSUdfRE1fVU5TVFJJUEVEIGlzIG5vdCBzZXQKQ09ORklHX0RN
X0NSWVBUPW0KIyBDT05GSUdfRE1fU05BUFNIT1QgaXMgbm90IHNldAojIENPTkZJR19ETV9U
SElOX1BST1ZJU0lPTklORyBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX0NBQ0hFIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRE1fV1JJVEVDQUNIRSBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX0VCUyBp
cyBub3Qgc2V0CiMgQ09ORklHX0RNX0VSQSBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX0NMT05F
IGlzIG5vdCBzZXQKIyBDT05GSUdfRE1fTUlSUk9SIGlzIG5vdCBzZXQKIyBDT05GSUdfRE1f
UkFJRCBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX1pFUk8gaXMgbm90IHNldApDT05GSUdfRE1f
TVVMVElQQVRIPW0KIyBDT05GSUdfRE1fTVVMVElQQVRIX1FMIGlzIG5vdCBzZXQKIyBDT05G
SUdfRE1fTVVMVElQQVRIX1NUIGlzIG5vdCBzZXQKIyBDT05GSUdfRE1fTVVMVElQQVRIX0hT
VCBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX01VTFRJUEFUSF9JT0EgaXMgbm90IHNldAojIENP
TkZJR19ETV9ERUxBWSBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX0RVU1QgaXMgbm90IHNldAoj
IENPTkZJR19ETV9VRVZFTlQgaXMgbm90IHNldAojIENPTkZJR19ETV9GTEFLRVkgaXMgbm90
IHNldAojIENPTkZJR19ETV9WRVJJVFkgaXMgbm90IHNldAojIENPTkZJR19ETV9TV0lUQ0gg
aXMgbm90IHNldAojIENPTkZJR19ETV9MT0dfV1JJVEVTIGlzIG5vdCBzZXQKIyBDT05GSUdf
RE1fSU5URUdSSVRZIGlzIG5vdCBzZXQKIyBDT05GSUdfRE1fWk9ORUQgaXMgbm90IHNldAoj
IENPTkZJR19ETV9BVURJVCBpcyBub3Qgc2V0CkNPTkZJR19UQVJHRVRfQ09SRT1tCkNPTkZJ
R19UQ01fSUJMT0NLPW0KQ09ORklHX1RDTV9GSUxFSU89bQpDT05GSUdfVENNX1BTQ1NJPW0K
IyBDT05GSUdfVENNX1VTRVIyIGlzIG5vdCBzZXQKIyBDT05GSUdfTE9PUEJBQ0tfVEFSR0VU
IGlzIG5vdCBzZXQKQ09ORklHX0lTQ1NJX1RBUkdFVD1tCiMgQ09ORklHX0lTQ1NJX1RBUkdF
VF9DWEdCNCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZVU0lPTiBpcyBub3Qgc2V0CgojCiMgSUVF
RSAxMzk0IChGaXJlV2lyZSkgc3VwcG9ydAojCiMgQ09ORklHX0ZJUkVXSVJFIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRklSRVdJUkVfTk9TWSBpcyBub3Qgc2V0CiMgZW5kIG9mIElFRUUgMTM5
NCAoRmlyZVdpcmUpIHN1cHBvcnQKCiMgQ09ORklHX01BQ0lOVE9TSF9EUklWRVJTIGlzIG5v
dCBzZXQKQ09ORklHX05FVERFVklDRVM9eQpDT05GSUdfTkVUX0NPUkU9eQojIENPTkZJR19C
T05ESU5HIGlzIG5vdCBzZXQKIyBDT05GSUdfRFVNTVkgaXMgbm90IHNldAojIENPTkZJR19X
SVJFR1VBUkQgaXMgbm90IHNldAojIENPTkZJR19FUVVBTElaRVIgaXMgbm90IHNldAojIENP
TkZJR19ORVRfRkMgaXMgbm90IHNldAojIENPTkZJR19JRkIgaXMgbm90IHNldAojIENPTkZJ
R19ORVRfVEVBTSBpcyBub3Qgc2V0CkNPTkZJR19NQUNWTEFOPW0KQ09ORklHX01BQ1ZUQVA9
bQpDT05GSUdfSVBWTEFOX0wzUz15CkNPTkZJR19JUFZMQU49bQpDT05GSUdfSVBWVEFQPW0K
Q09ORklHX1ZYTEFOPW0KQ09ORklHX0dFTkVWRT1tCiMgQ09ORklHX0JBUkVVRFAgaXMgbm90
IHNldAojIENPTkZJR19HVFAgaXMgbm90IHNldAojIENPTkZJR19BTVQgaXMgbm90IHNldAoj
IENPTkZJR19NQUNTRUMgaXMgbm90IHNldAojIENPTkZJR19ORVRDT05TT0xFIGlzIG5vdCBz
ZXQKQ09ORklHX1RVTj15CkNPTkZJR19UQVA9bQojIENPTkZJR19UVU5fVk5FVF9DUk9TU19M
RSBpcyBub3Qgc2V0CkNPTkZJR19WRVRIPW0KQ09ORklHX05MTU9OPW0KIyBDT05GSUdfTkVU
X1ZSRiBpcyBub3Qgc2V0CiMgQ09ORklHX0FSQ05FVCBpcyBub3Qgc2V0CkNPTkZJR19FVEhF
Uk5FVD15CkNPTkZJR19NRElPPW0KIyBDT05GSUdfTkVUX1ZFTkRPUl8zQ09NIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9BREFQVEVDIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVU
X1ZFTkRPUl9BR0VSRSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfQUxBQ1JJVEVD
SCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfQUxURU9OIGlzIG5vdCBzZXQKIyBD
T05GSUdfQUxURVJBX1RTRSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfQU1BWk9O
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9BTUQgaXMgbm90IHNldAojIENPTkZJ
R19ORVRfVkVORE9SX0FRVUFOVElBIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9B
UkMgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX0FTSVggaXMgbm90IHNldAojIENP
TkZJR19ORVRfVkVORE9SX0FUSEVST1MgaXMgbm90IHNldAojIENPTkZJR19DWF9FQ0FUIGlz
IG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfQlJPQURDT009eQojIENPTkZJR19CNDQgaXMg
bm90IHNldAojIENPTkZJR19CQ01HRU5FVCBpcyBub3Qgc2V0CkNPTkZJR19CTlgyPW0KQ09O
RklHX0NOSUM9bQpDT05GSUdfVElHT04zPW0KQ09ORklHX1RJR09OM19IV01PTj15CiMgQ09O
RklHX0JOWDJYIGlzIG5vdCBzZXQKIyBDT05GSUdfU1lTVEVNUE9SVCBpcyBub3Qgc2V0CiMg
Q09ORklHX0JOWFQgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX0NBREVOQ0UgaXMg
bm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX0NBVklVTSBpcyBub3Qgc2V0CkNPTkZJR19O
RVRfVkVORE9SX0NIRUxTSU89eQojIENPTkZJR19DSEVMU0lPX1QxIGlzIG5vdCBzZXQKQ09O
RklHX0NIRUxTSU9fVDM9bQpDT05GSUdfQ0hFTFNJT19UND1tCiMgQ09ORklHX0NIRUxTSU9f
VDRWRiBpcyBub3Qgc2V0CiMgQ09ORklHX0NIRUxTSU9fSU5MSU5FX0NSWVBUTyBpcyBub3Qg
c2V0CkNPTkZJR19ORVRfVkVORE9SX0NJU0NPPXkKQ09ORklHX0VOSUM9bQojIENPTkZJR19O
RVRfVkVORE9SX0NPUlRJTkEgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX0RBVklD
T00gaXMgbm90IHNldAojIENPTkZJR19ETkVUIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZF
TkRPUl9ERUMgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX0RMSU5LIGlzIG5vdCBz
ZXQKQ09ORklHX05FVF9WRU5ET1JfRU1VTEVYPXkKQ09ORklHX0JFMk5FVD1tCiMgQ09ORklH
X0JFMk5FVF9IV01PTiBpcyBub3Qgc2V0CiMgQ09ORklHX0JFMk5FVF9CRTIgaXMgbm90IHNl
dAojIENPTkZJR19CRTJORVRfQkUzIGlzIG5vdCBzZXQKIyBDT05GSUdfQkUyTkVUX0xBTkNF
UiBpcyBub3Qgc2V0CiMgQ09ORklHX0JFMk5FVF9TS1lIQVdLIGlzIG5vdCBzZXQKCiMKIyBX
QVJOSU5HOiBiZTJuZXQgaXMgdXNlbGVzcyB3aXRob3V0IGFueSBlbmFibGVkIGNoaXAKIwoj
IENPTkZJR19ORVRfVkVORE9SX0VOR0xFREVSIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZF
TkRPUl9FWkNISVAgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX0ZVTkdJQkxFIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9HT09HTEUgaXMgbm90IHNldAojIENPTkZJ
R19ORVRfVkVORE9SX0hVQVdFSSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfSU5U
RUwgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX1dBTkdYVU4gaXMgbm90IHNldAoj
IENPTkZJR19KTUUgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX0xJVEVYIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9NQVJWRUxMIGlzIG5vdCBzZXQKQ09ORklHX05F
VF9WRU5ET1JfTUVMTEFOT1g9eQojIENPTkZJR19NTFg0X0VOIGlzIG5vdCBzZXQKIyBDT05G
SUdfTUxYNV9DT1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfTUxYU1dfQ09SRSBpcyBub3Qgc2V0
CiMgQ09ORklHX01MWEZXIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9NSUNSRUwg
aXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX01JQ1JPQ0hJUCBpcyBub3Qgc2V0CiMg
Q09ORklHX05FVF9WRU5ET1JfTUlDUk9TRU1JIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZF
TkRPUl9NSUNST1NPRlQgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX01ZUkkgaXMg
bm90IHNldAojIENPTkZJR19GRUFMTlggaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9S
X05JIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9OQVRTRU1JIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkVUX1ZFTkRPUl9ORVRFUklPTiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9W
RU5ET1JfTkVUUk9OT01FIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9OVklESUEg
aXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX09LSSBpcyBub3Qgc2V0CiMgQ09ORklH
X0VUSE9DIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9QQUNLRVRfRU5HSU5FUyBp
cyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfUEVOU0FORE8gaXMgbm90IHNldAojIENP
TkZJR19ORVRfVkVORE9SX1FMT0dJQyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1Jf
QlJPQ0FERSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfUVVBTENPTU0gaXMgbm90
IHNldAojIENPTkZJR19ORVRfVkVORE9SX1JEQyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9W
RU5ET1JfUkVBTFRFSyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfUkVORVNBUyBp
cyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfUk9DS0VSIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkVUX1ZFTkRPUl9TQU1TVU5HIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9T
RUVRIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9TSUxBTiBpcyBub3Qgc2V0CiMg
Q09ORklHX05FVF9WRU5ET1JfU0lTIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9T
T0xBUkZMQVJFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9TTVNDIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9TT0NJT05FWFQgaXMgbm90IHNldAojIENPTkZJR19O
RVRfVkVORE9SX1NUTUlDUk8gaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX1NVTiBp
cyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfU1lOT1BTWVMgaXMgbm90IHNldAojIENP
TkZJR19ORVRfVkVORE9SX1RFSFVUSSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1Jf
VEkgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX1ZFUlRFWENPTSBpcyBub3Qgc2V0
CiMgQ09ORklHX05FVF9WRU5ET1JfVklBIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRP
Ul9XSVpORVQgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX1hJTElOWCBpcyBub3Qg
c2V0CiMgQ09ORklHX0ZEREkgaXMgbm90IHNldAojIENPTkZJR19ISVBQSSBpcyBub3Qgc2V0
CiMgQ09ORklHX05FVF9TQjEwMDAgaXMgbm90IHNldApDT05GSUdfUEhZTElCPW0KQ09ORklH
X1NXUEhZPXkKQ09ORklHX0ZJWEVEX1BIWT1tCgojCiMgTUlJIFBIWSBkZXZpY2UgZHJpdmVy
cwojCiMgQ09ORklHX0FNRF9QSFkgaXMgbm90IHNldAojIENPTkZJR19BRElOX1BIWSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0FESU4xMTAwX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0FRVUFO
VElBX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0FYODg3OTZCX1BIWSBpcyBub3Qgc2V0CiMg
Q09ORklHX0JST0FEQ09NX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0JDTTU0MTQwX1BIWSBp
cyBub3Qgc2V0CiMgQ09ORklHX0JDTTdYWFhfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfQkNN
ODQ4ODFfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfQkNNODdYWF9QSFkgaXMgbm90IHNldAoj
IENPTkZJR19DSUNBREFfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfQ09SVElOQV9QSFkgaXMg
bm90IHNldAojIENPTkZJR19EQVZJQ09NX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0lDUExV
U19QSFkgaXMgbm90IHNldAojIENPTkZJR19MWFRfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdf
SU5URUxfWFdBWV9QSFkgaXMgbm90IHNldAojIENPTkZJR19MU0lfRVQxMDExQ19QSFkgaXMg
bm90IHNldAojIENPTkZJR19NQVJWRUxMX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX01BUlZF
TExfMTBHX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX01BUlZFTExfODhYMjIyMl9QSFkgaXMg
bm90IHNldAojIENPTkZJR19NQVhMSU5FQVJfR1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX01F
RElBVEVLX0dFX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX01JQ1JFTF9QSFkgaXMgbm90IHNl
dAojIENPTkZJR19NSUNST0NISVBfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfTUlDUk9DSElQ
X1QxX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX01JQ1JPU0VNSV9QSFkgaXMgbm90IHNldAoj
IENPTkZJR19NT1RPUkNPTU1fUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfTkFUSU9OQUxfUEhZ
IGlzIG5vdCBzZXQKIyBDT05GSUdfTlhQX0M0NV9USkExMVhYX1BIWSBpcyBub3Qgc2V0CiMg
Q09ORklHX05YUF9USkExMVhYX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX1FTRU1JX1BIWSBp
cyBub3Qgc2V0CiMgQ09ORklHX1JFQUxURUtfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVO
RVNBU19QSFkgaXMgbm90IHNldAojIENPTkZJR19ST0NLQ0hJUF9QSFkgaXMgbm90IHNldAoj
IENPTkZJR19TTVNDX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX1NURTEwWFAgaXMgbm90IHNl
dAojIENPTkZJR19URVJBTkVUSUNTX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0RQODM4MjJf
UEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfRFA4M1RDODExX1BIWSBpcyBub3Qgc2V0CiMgQ09O
RklHX0RQODM4NDhfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfRFA4Mzg2N19QSFkgaXMgbm90
IHNldAojIENPTkZJR19EUDgzODY5X1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0RQODNURDUx
MF9QSFkgaXMgbm90IHNldAojIENPTkZJR19WSVRFU1NFX1BIWSBpcyBub3Qgc2V0CiMgQ09O
RklHX1hJTElOWF9HTUlJMlJHTUlJIGlzIG5vdCBzZXQKIyBDT05GSUdfUFNFX0NPTlRST0xM
RVIgaXMgbm90IHNldApDT05GSUdfTURJT19ERVZJQ0U9bQpDT05GSUdfTURJT19CVVM9bQpD
T05GSUdfRldOT0RFX01ESU89bQpDT05GSUdfQUNQSV9NRElPPW0KQ09ORklHX01ESU9fREVW
UkVTPW0KIyBDT05GSUdfTURJT19CSVRCQU5HIGlzIG5vdCBzZXQKIyBDT05GSUdfTURJT19C
Q01fVU5JTUFDIGlzIG5vdCBzZXQKIyBDT05GSUdfTURJT19NU0NDX01JSU0gaXMgbm90IHNl
dAojIENPTkZJR19NRElPX1RIVU5ERVIgaXMgbm90IHNldAoKIwojIE1ESU8gTXVsdGlwbGV4
ZXJzCiMKCiMKIyBQQ1MgZGV2aWNlIGRyaXZlcnMKIwojIGVuZCBvZiBQQ1MgZGV2aWNlIGRy
aXZlcnMKCiMgQ09ORklHX1BQUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NMSVAgaXMgbm90IHNl
dAoKIwojIEhvc3Qtc2lkZSBVU0Igc3VwcG9ydCBpcyBuZWVkZWQgZm9yIFVTQiBOZXR3b3Jr
IEFkYXB0ZXIgc3VwcG9ydAojCiMgQ09ORklHX1dMQU4gaXMgbm90IHNldAojIENPTkZJR19X
QU4gaXMgbm90IHNldAoKIwojIFdpcmVsZXNzIFdBTgojCiMgQ09ORklHX1dXQU4gaXMgbm90
IHNldAojIGVuZCBvZiBXaXJlbGVzcyBXQU4KCiMgQ09ORklHX1ZNWE5FVDMgaXMgbm90IHNl
dAojIENPTkZJR19GVUpJVFNVX0VTIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUREVWU0lNIGlz
IG5vdCBzZXQKQ09ORklHX05FVF9GQUlMT1ZFUj1tCiMgQ09ORklHX0lTRE4gaXMgbm90IHNl
dAoKIwojIElucHV0IGRldmljZSBzdXBwb3J0CiMKQ09ORklHX0lOUFVUPXkKIyBDT05GSUdf
SU5QVVRfTEVEUyBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0ZGX01FTUxFU1MgaXMgbm90
IHNldApDT05GSUdfSU5QVVRfU1BBUlNFS01BUD1tCiMgQ09ORklHX0lOUFVUX01BVFJJWEtN
QVAgaXMgbm90IHNldApDT05GSUdfSU5QVVRfVklWQUxESUZNQVA9eQoKIwojIFVzZXJsYW5k
IGludGVyZmFjZXMKIwpDT05GSUdfSU5QVVRfTU9VU0VERVY9eQojIENPTkZJR19JTlBVVF9N
T1VTRURFVl9QU0FVWCBpcyBub3Qgc2V0CkNPTkZJR19JTlBVVF9NT1VTRURFVl9TQ1JFRU5f
WD0xMDI0CkNPTkZJR19JTlBVVF9NT1VTRURFVl9TQ1JFRU5fWT03NjgKIyBDT05GSUdfSU5Q
VVRfSk9ZREVWIGlzIG5vdCBzZXQKQ09ORklHX0lOUFVUX0VWREVWPXkKQ09ORklHX0lOUFVU
X0VWQlVHPW0KCiMKIyBJbnB1dCBEZXZpY2UgRHJpdmVycwojCkNPTkZJR19JTlBVVF9LRVlC
T0FSRD15CiMgQ09ORklHX0tFWUJPQVJEX0FEUDU1ODggaXMgbm90IHNldAojIENPTkZJR19L
RVlCT0FSRF9BRFA1NTg5IGlzIG5vdCBzZXQKQ09ORklHX0tFWUJPQVJEX0FUS0JEPXkKIyBD
T05GSUdfS0VZQk9BUkRfUVQxMDUwIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfUVQx
MDcwIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfUVQyMTYwIGlzIG5vdCBzZXQKIyBD
T05GSUdfS0VZQk9BUkRfRExJTktfRElSNjg1IGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9B
UkRfTEtLQkQgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9UQ0E2NDE2IGlzIG5vdCBz
ZXQKIyBDT05GSUdfS0VZQk9BUkRfVENBODQxOCBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJP
QVJEX0xNODMyMyBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX0xNODMzMyBpcyBub3Qg
c2V0CiMgQ09ORklHX0tFWUJPQVJEX01BWDczNTkgaXMgbm90IHNldAojIENPTkZJR19LRVlC
T0FSRF9NQ1MgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9NUFIxMjEgaXMgbm90IHNl
dAojIENPTkZJR19LRVlCT0FSRF9ORVdUT04gaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FS
RF9PUEVOQ09SRVMgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9TQU1TVU5HIGlzIG5v
dCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfU1RPV0FXQVkgaXMgbm90IHNldAojIENPTkZJR19L
RVlCT0FSRF9TVU5LQkQgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9UTTJfVE9VQ0hL
RVkgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9YVEtCRCBpcyBub3Qgc2V0CiMgQ09O
RklHX0tFWUJPQVJEX0NZUFJFU1NfU0YgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9NT1VT
RSBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0pPWVNUSUNLIGlzIG5vdCBzZXQKIyBDT05G
SUdfSU5QVVRfVEFCTEVUIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfVE9VQ0hTQ1JFRU4g
aXMgbm90IHNldAojIENPTkZJR19JTlBVVF9NSVNDIGlzIG5vdCBzZXQKIyBDT05GSUdfUk1J
NF9DT1JFIGlzIG5vdCBzZXQKCiMKIyBIYXJkd2FyZSBJL08gcG9ydHMKIwpDT05GSUdfU0VS
SU89eQpDT05GSUdfQVJDSF9NSUdIVF9IQVZFX1BDX1NFUklPPXkKQ09ORklHX1NFUklPX0k4
MDQyPXkKQ09ORklHX1NFUklPX1NFUlBPUlQ9bQojIENPTkZJR19TRVJJT19DVDgyQzcxMCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFUklPX1BDSVBTMiBpcyBub3Qgc2V0CkNPTkZJR19TRVJJ
T19MSUJQUzI9eQojIENPTkZJR19TRVJJT19SQVcgaXMgbm90IHNldAojIENPTkZJR19TRVJJ
T19BTFRFUkFfUFMyIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSU9fUFMyTVVMVCBpcyBub3Qg
c2V0CiMgQ09ORklHX1NFUklPX0FSQ19QUzIgaXMgbm90IHNldAojIENPTkZJR19VU0VSSU8g
aXMgbm90IHNldAojIENPTkZJR19HQU1FUE9SVCBpcyBub3Qgc2V0CiMgZW5kIG9mIEhhcmR3
YXJlIEkvTyBwb3J0cwojIGVuZCBvZiBJbnB1dCBkZXZpY2Ugc3VwcG9ydAoKIwojIENoYXJh
Y3RlciBkZXZpY2VzCiMKQ09ORklHX1RUWT15CkNPTkZJR19WVD15CkNPTkZJR19DT05TT0xF
X1RSQU5TTEFUSU9OUz15CkNPTkZJR19WVF9DT05TT0xFPXkKQ09ORklHX0hXX0NPTlNPTEU9
eQpDT05GSUdfVlRfSFdfQ09OU09MRV9CSU5ESU5HPXkKQ09ORklHX1VOSVg5OF9QVFlTPXkK
IyBDT05GSUdfTEVHQUNZX1BUWVMgaXMgbm90IHNldApDT05GSUdfTERJU0NfQVVUT0xPQUQ9
eQoKIwojIFNlcmlhbCBkcml2ZXJzCiMKQ09ORklHX1NFUklBTF84MjUwPW0KIyBDT05GSUdf
U0VSSUFMXzgyNTBfREVQUkVDQVRFRF9PUFRJT05TIGlzIG5vdCBzZXQKQ09ORklHX1NFUklB
TF84MjUwX1BOUD15CiMgQ09ORklHX1NFUklBTF84MjUwXzE2NTUwQV9WQVJJQU5UUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFUklBTF84MjUwX0ZJTlRFSyBpcyBub3Qgc2V0CkNPTkZJR19T
RVJJQUxfODI1MF9ETUE9eQpDT05GSUdfU0VSSUFMXzgyNTBfUENJPW0KIyBDT05GSUdfU0VS
SUFMXzgyNTBfRVhBUiBpcyBub3Qgc2V0CkNPTkZJR19TRVJJQUxfODI1MF9OUl9VQVJUUz00
OApDT05GSUdfU0VSSUFMXzgyNTBfUlVOVElNRV9VQVJUUz0zMgpDT05GSUdfU0VSSUFMXzgy
NTBfRVhURU5ERUQ9eQpDT05GSUdfU0VSSUFMXzgyNTBfTUFOWV9QT1JUUz15CkNPTkZJR19T
RVJJQUxfODI1MF9TSEFSRV9JUlE9eQojIENPTkZJR19TRVJJQUxfODI1MF9ERVRFQ1RfSVJR
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMXzgyNTBfUlNBIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VSSUFMXzgyNTBfRFcgaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfODI1MF9SVDI4
OFggaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfODI1MF9MUFNTIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VSSUFMXzgyNTBfTUlEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMXzgyNTBf
UEVSSUNPTSBpcyBub3Qgc2V0CgojCiMgTm9uLTgyNTAgc2VyaWFsIHBvcnQgc3VwcG9ydAoj
CiMgQ09ORklHX1NFUklBTF9VQVJUTElURSBpcyBub3Qgc2V0CkNPTkZJR19TRVJJQUxfQ09S
RT1tCiMgQ09ORklHX1NFUklBTF9KU00gaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfTEFO
VElRIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMX1NDQ05YUCBpcyBub3Qgc2V0CiMgQ09O
RklHX1NFUklBTF9TQzE2SVM3WFggaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfQUxURVJB
X0pUQUdVQVJUIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMX0FMVEVSQV9VQVJUIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VSSUFMX0FSQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF9S
UDIgaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfRlNMX0xQVUFSVCBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFUklBTF9GU0xfTElORkxFWFVBUlQgaXMgbm90IHNldAojIENPTkZJR19TRVJJ
QUxfU1BSRCBpcyBub3Qgc2V0CiMgZW5kIG9mIFNlcmlhbCBkcml2ZXJzCgojIENPTkZJR19T
RVJJQUxfTk9OU1RBTkRBUkQgaXMgbm90IHNldAojIENPTkZJR19OX0dTTSBpcyBub3Qgc2V0
CiMgQ09ORklHX05PWk9NSSBpcyBub3Qgc2V0CiMgQ09ORklHX05VTExfVFRZIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VSSUFMX0RFVl9CVVMgaXMgbm90IHNldAojIENPTkZJR19WSVJUSU9f
Q09OU09MRSBpcyBub3Qgc2V0CkNPTkZJR19JUE1JX0hBTkRMRVI9bQpDT05GSUdfSVBNSV9E
TUlfREVDT0RFPXkKQ09ORklHX0lQTUlfUExBVF9EQVRBPXkKIyBDT05GSUdfSVBNSV9QQU5J
Q19FVkVOVCBpcyBub3Qgc2V0CkNPTkZJR19JUE1JX0RFVklDRV9JTlRFUkZBQ0U9bQpDT05G
SUdfSVBNSV9TST1tCkNPTkZJR19JUE1JX1NTSUY9bQpDT05GSUdfSVBNSV9XQVRDSERPRz1t
CkNPTkZJR19JUE1JX1BPV0VST0ZGPW0KQ09ORklHX0hXX1JBTkRPTT15CkNPTkZJR19IV19S
QU5ET01fVElNRVJJT01FTT1tCkNPTkZJR19IV19SQU5ET01fSU5URUw9bQojIENPTkZJR19I
V19SQU5ET01fQU1EIGlzIG5vdCBzZXQKIyBDT05GSUdfSFdfUkFORE9NX0JBNDMxIGlzIG5v
dCBzZXQKIyBDT05GSUdfSFdfUkFORE9NX1ZJQSBpcyBub3Qgc2V0CiMgQ09ORklHX0hXX1JB
TkRPTV9YSVBIRVJBIGlzIG5vdCBzZXQKIyBDT05GSUdfQVBQTElDT00gaXMgbm90IHNldAoj
IENPTkZJR19NV0FWRSBpcyBub3Qgc2V0CkNPTkZJR19ERVZNRU09eQpDT05GSUdfTlZSQU09
bQpDT05GSUdfREVWUE9SVD15CkNPTkZJR19IUEVUPXkKQ09ORklHX0hQRVRfTU1BUD15CkNP
TkZJR19IUEVUX01NQVBfREVGQVVMVD15CkNPTkZJR19IQU5HQ0hFQ0tfVElNRVI9bQpDT05G
SUdfVENHX1RQTT1tCkNPTkZJR19IV19SQU5ET01fVFBNPXkKQ09ORklHX1RDR19USVNfQ09S
RT1tCiMgQ09ORklHX1RDR19USVMgaXMgbm90IHNldApDT05GSUdfVENHX1RJU19JMkM9bQoj
IENPTkZJR19UQ0dfVElTX0kyQ19DUjUwIGlzIG5vdCBzZXQKIyBDT05GSUdfVENHX1RJU19J
MkNfQVRNRUwgaXMgbm90IHNldAojIENPTkZJR19UQ0dfVElTX0kyQ19JTkZJTkVPTiBpcyBu
b3Qgc2V0CiMgQ09ORklHX1RDR19USVNfSTJDX05VVk9UT04gaXMgbm90IHNldAojIENPTkZJ
R19UQ0dfTlNDIGlzIG5vdCBzZXQKIyBDT05GSUdfVENHX0FUTUVMIGlzIG5vdCBzZXQKIyBD
T05GSUdfVENHX0lORklORU9OIGlzIG5vdCBzZXQKQ09ORklHX1RDR19DUkI9bQojIENPTkZJ
R19UQ0dfVlRQTV9QUk9YWSBpcyBub3Qgc2V0CiMgQ09ORklHX1RDR19USVNfU1QzM1pQMjRf
STJDIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVMQ0xPQ0sgaXMgbm90IHNldAojIENPTkZJR19Y
SUxMWUJVUyBpcyBub3Qgc2V0CkNPTkZJR19SQU5ET01fVFJVU1RfQ1BVPXkKQ09ORklHX1JB
TkRPTV9UUlVTVF9CT09UTE9BREVSPXkKIyBlbmQgb2YgQ2hhcmFjdGVyIGRldmljZXMKCiMK
IyBJMkMgc3VwcG9ydAojCkNPTkZJR19JMkM9bQpDT05GSUdfSTJDX0JPQVJESU5GTz15CiMg
Q09ORklHX0kyQ19DT01QQVQgaXMgbm90IHNldAojIENPTkZJR19JMkNfQ0hBUkRFViBpcyBu
b3Qgc2V0CiMgQ09ORklHX0kyQ19NVVggaXMgbm90IHNldAojIENPTkZJR19JMkNfSEVMUEVS
X0FVVE8gaXMgbm90IHNldAojIENPTkZJR19JMkNfU01CVVMgaXMgbm90IHNldAoKIwojIEky
QyBBbGdvcml0aG1zCiMKQ09ORklHX0kyQ19BTEdPQklUPW0KIyBDT05GSUdfSTJDX0FMR09Q
Q0YgaXMgbm90IHNldAojIENPTkZJR19JMkNfQUxHT1BDQSBpcyBub3Qgc2V0CiMgZW5kIG9m
IEkyQyBBbGdvcml0aG1zCgojCiMgSTJDIEhhcmR3YXJlIEJ1cyBzdXBwb3J0CiMKCiMKIyBQ
QyBTTUJ1cyBob3N0IGNvbnRyb2xsZXIgZHJpdmVycwojCiMgQ09ORklHX0kyQ19BTEkxNTM1
IGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0FMSTE1NjMgaXMgbm90IHNldAojIENPTkZJR19J
MkNfQUxJMTVYMyBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19BTUQ3NTYgaXMgbm90IHNldAoj
IENPTkZJR19JMkNfQU1EODExMSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19BTURfTVAyIGlz
IG5vdCBzZXQKIyBDT05GSUdfSTJDX0k4MDEgaXMgbm90IHNldAojIENPTkZJR19JMkNfSVND
SCBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19JU01UIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJD
X1BJSVg0IGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX05GT1JDRTIgaXMgbm90IHNldAojIENP
TkZJR19JMkNfTlZJRElBX0dQVSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19TSVM1NTk1IGlz
IG5vdCBzZXQKIyBDT05GSUdfSTJDX1NJUzYzMCBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19T
SVM5NlggaXMgbm90IHNldAojIENPTkZJR19JMkNfVklBIGlzIG5vdCBzZXQKIyBDT05GSUdf
STJDX1ZJQVBSTyBpcyBub3Qgc2V0CgojCiMgQUNQSSBkcml2ZXJzCiMKIyBDT05GSUdfSTJD
X1NDTUkgaXMgbm90IHNldAoKIwojIEkyQyBzeXN0ZW0gYnVzIGRyaXZlcnMgKG1vc3RseSBl
bWJlZGRlZCAvIHN5c3RlbS1vbi1jaGlwKQojCiMgQ09ORklHX0kyQ19ERVNJR05XQVJFX1BM
QVRGT1JNIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0RFU0lHTldBUkVfUENJIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSTJDX0VNRVYyIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX09DT1JFUyBp
cyBub3Qgc2V0CiMgQ09ORklHX0kyQ19QQ0FfUExBVEZPUk0gaXMgbm90IHNldAojIENPTkZJ
R19JMkNfU0lNVEVDIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1hJTElOWCBpcyBub3Qgc2V0
CgojCiMgRXh0ZXJuYWwgSTJDL1NNQnVzIGFkYXB0ZXIgZHJpdmVycwojCiMgQ09ORklHX0ky
Q19QQ0kxWFhYWCBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19UQU9TX0VWTSBpcyBub3Qgc2V0
CgojCiMgT3RoZXIgSTJDL1NNQnVzIGJ1cyBkcml2ZXJzCiMKIyBDT05GSUdfSTJDX01MWENQ
TEQgaXMgbm90IHNldAojIENPTkZJR19JMkNfVklSVElPIGlzIG5vdCBzZXQKIyBlbmQgb2Yg
STJDIEhhcmR3YXJlIEJ1cyBzdXBwb3J0CgojIENPTkZJR19JMkNfU1RVQiBpcyBub3Qgc2V0
CiMgQ09ORklHX0kyQ19TTEFWRSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19ERUJVR19DT1JF
IGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0RFQlVHX0FMR08gaXMgbm90IHNldAojIENPTkZJ
R19JMkNfREVCVUdfQlVTIGlzIG5vdCBzZXQKIyBlbmQgb2YgSTJDIHN1cHBvcnQKCiMgQ09O
RklHX0kzQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NQSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NQ
TUkgaXMgbm90IHNldAojIENPTkZJR19IU0kgaXMgbm90IHNldAojIENPTkZJR19QUFMgaXMg
bm90IHNldAoKIwojIFBUUCBjbG9jayBzdXBwb3J0CiMKIyBDT05GSUdfUFRQXzE1ODhfQ0xP
Q0sgaXMgbm90IHNldApDT05GSUdfUFRQXzE1ODhfQ0xPQ0tfT1BUSU9OQUw9eQoKIwojIEVu
YWJsZSBQSFlMSUIgYW5kIE5FVFdPUktfUEhZX1RJTUVTVEFNUElORyB0byBzZWUgdGhlIGFk
ZGl0aW9uYWwgY2xvY2tzLgojCiMgZW5kIG9mIFBUUCBjbG9jayBzdXBwb3J0CgpDT05GSUdf
UElOQ1RSTD15CiMgQ09ORklHX1BJTkNUUkxfQU1EIGlzIG5vdCBzZXQKIyBDT05GSUdfUElO
Q1RSTF9DWThDOTVYMCBpcyBub3Qgc2V0CiMgQ09ORklHX1BJTkNUUkxfTUNQMjNTMDggaXMg
bm90IHNldAoKIwojIEludGVsIHBpbmN0cmwgZHJpdmVycwojCiMgQ09ORklHX1BJTkNUUkxf
QkFZVFJBSUwgaXMgbm90IHNldAojIENPTkZJR19QSU5DVFJMX0NIRVJSWVZJRVcgaXMgbm90
IHNldAojIENPTkZJR19QSU5DVFJMX0xZTlhQT0lOVCBpcyBub3Qgc2V0CiMgQ09ORklHX1BJ
TkNUUkxfQUxERVJMQUtFIGlzIG5vdCBzZXQKIyBDT05GSUdfUElOQ1RSTF9CUk9YVE9OIGlz
IG5vdCBzZXQKIyBDT05GSUdfUElOQ1RSTF9DQU5OT05MQUtFIGlzIG5vdCBzZXQKIyBDT05G
SUdfUElOQ1RSTF9DRURBUkZPUksgaXMgbm90IHNldAojIENPTkZJR19QSU5DVFJMX0RFTlZF
UlRPTiBpcyBub3Qgc2V0CiMgQ09ORklHX1BJTkNUUkxfRUxLSEFSVExBS0UgaXMgbm90IHNl
dAojIENPTkZJR19QSU5DVFJMX0VNTUlUU0JVUkcgaXMgbm90IHNldAojIENPTkZJR19QSU5D
VFJMX0dFTUlOSUxBS0UgaXMgbm90IHNldAojIENPTkZJR19QSU5DVFJMX0lDRUxBS0UgaXMg
bm90IHNldAojIENPTkZJR19QSU5DVFJMX0pBU1BFUkxBS0UgaXMgbm90IHNldAojIENPTkZJ
R19QSU5DVFJMX0xBS0VGSUVMRCBpcyBub3Qgc2V0CiMgQ09ORklHX1BJTkNUUkxfTEVXSVNC
VVJHIGlzIG5vdCBzZXQKIyBDT05GSUdfUElOQ1RSTF9NRVRFT1JMQUtFIGlzIG5vdCBzZXQK
IyBDT05GSUdfUElOQ1RSTF9TVU5SSVNFUE9JTlQgaXMgbm90IHNldAojIENPTkZJR19QSU5D
VFJMX1RJR0VSTEFLRSBpcyBub3Qgc2V0CiMgZW5kIG9mIEludGVsIHBpbmN0cmwgZHJpdmVy
cwoKIwojIFJlbmVzYXMgcGluY3RybCBkcml2ZXJzCiMKIyBlbmQgb2YgUmVuZXNhcyBwaW5j
dHJsIGRyaXZlcnMKCiMgQ09ORklHX0dQSU9MSUIgaXMgbm90IHNldAojIENPTkZJR19XMSBp
cyBub3Qgc2V0CiMgQ09ORklHX1BPV0VSX1JFU0VUIGlzIG5vdCBzZXQKQ09ORklHX1BPV0VS
X1NVUFBMWT15CiMgQ09ORklHX1BPV0VSX1NVUFBMWV9ERUJVRyBpcyBub3Qgc2V0CkNPTkZJ
R19QT1dFUl9TVVBQTFlfSFdNT049eQojIENPTkZJR19QREFfUE9XRVIgaXMgbm90IHNldAoj
IENPTkZJR19JUDVYWFhfUE9XRVIgaXMgbm90IHNldAojIENPTkZJR19URVNUX1BPV0VSIGlz
IG5vdCBzZXQKIyBDT05GSUdfQ0hBUkdFUl9BRFA1MDYxIGlzIG5vdCBzZXQKIyBDT05GSUdf
QkFUVEVSWV9DVzIwMTUgaXMgbm90IHNldAojIENPTkZJR19CQVRURVJZX0RTMjc4MCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0JBVFRFUllfRFMyNzgxIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFU
VEVSWV9EUzI3ODIgaXMgbm90IHNldAojIENPTkZJR19CQVRURVJZX1NBTVNVTkdfU0RJIGlz
IG5vdCBzZXQKIyBDT05GSUdfQkFUVEVSWV9TQlMgaXMgbm90IHNldAojIENPTkZJR19DSEFS
R0VSX1NCUyBpcyBub3Qgc2V0CiMgQ09ORklHX0JBVFRFUllfQlEyN1hYWCBpcyBub3Qgc2V0
CiMgQ09ORklHX0JBVFRFUllfTUFYMTcwNDAgaXMgbm90IHNldAojIENPTkZJR19CQVRURVJZ
X01BWDE3MDQyIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hBUkdFUl9NQVg4OTAzIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQ0hBUkdFUl9MUDg3MjcgaXMgbm90IHNldAojIENPTkZJR19DSEFSR0VS
X0xUQzQxNjJMIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hBUkdFUl9NQVg3Nzk3NiBpcyBub3Qg
c2V0CiMgQ09ORklHX0NIQVJHRVJfQlEyNDE1WCBpcyBub3Qgc2V0CiMgQ09ORklHX0JBVFRF
UllfR0FVR0VfTFRDMjk0MSBpcyBub3Qgc2V0CiMgQ09ORklHX0JBVFRFUllfR09MREZJU0gg
aXMgbm90IHNldAojIENPTkZJR19CQVRURVJZX1JUNTAzMyBpcyBub3Qgc2V0CiMgQ09ORklH
X0NIQVJHRVJfQkQ5OTk1NCBpcyBub3Qgc2V0CiMgQ09ORklHX0JBVFRFUllfVUczMTA1IGlz
IG5vdCBzZXQKQ09ORklHX0hXTU9OPXkKIyBDT05GSUdfSFdNT05fREVCVUdfQ0hJUCBpcyBu
b3Qgc2V0CgojCiMgTmF0aXZlIGRyaXZlcnMKIwojIENPTkZJR19TRU5TT1JTX0FCSVRVR1VS
VSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQUJJVFVHVVJVMyBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfQUQ3NDE0IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BRDc0
MTggaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FETTEwMjEgaXMgbm90IHNldAojIENP
TkZJR19TRU5TT1JTX0FETTEwMjUgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FETTEw
MjYgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FETTEwMjkgaXMgbm90IHNldAojIENP
TkZJR19TRU5TT1JTX0FETTEwMzEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FETTEx
NzcgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FETTkyNDAgaXMgbm90IHNldAojIENP
TkZJR19TRU5TT1JTX0FEVDc0MTAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FEVDc0
MTEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FEVDc0NjIgaXMgbm90IHNldAojIENP
TkZJR19TRU5TT1JTX0FEVDc0NzAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FEVDc0
NzUgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FIVDEwIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VOU09SU19BUzM3MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQVNDNzYyMSBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQVhJX0ZBTl9DT05UUk9MIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0VOU09SU19LOFRFTVAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0sx
MFRFTVAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0ZBTTE1SF9QT1dFUiBpcyBub3Qg
c2V0CiMgQ09ORklHX1NFTlNPUlNfQVBQTEVTTUMgaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX0FTQjEwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQVRYUDEgaXMgbm90IHNl
dAojIENPTkZJR19TRU5TT1JTX0NPUlNBSVJfQ1BSTyBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfQ09SU0FJUl9QU1UgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0RSSVZFVEVN
UCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRFM2MjAgaXMgbm90IHNldAojIENPTkZJ
R19TRU5TT1JTX0RTMTYyMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfREVMTF9TTU0g
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0k1S19BTUIgaXMgbm90IHNldAojIENPTkZJ
R19TRU5TT1JTX0Y3MTgwNUYgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0Y3MTg4MkZH
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19GNzUzNzVTIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VOU09SU19GU0NITUQgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0ZUU1RFVVRB
VEVTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19HTDUxOFNNIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VOU09SU19HTDUyMFNNIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19HNzYw
QSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRzc2MiBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFTlNPUlNfSElINjEzMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfSUJNQUVNIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19JQk1QRVggaXMgbm90IHNldAojIENPTkZJR19T
RU5TT1JTX0k1NTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19DT1JFVEVNUCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfSVQ4NyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNP
UlNfSkM0MiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfUE9XUjEyMjAgaXMgbm90IHNl
dAojIENPTkZJR19TRU5TT1JTX0xJTkVBR0UgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JT
X0xUQzI5NDUgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xUQzI5NDdfSTJDIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19MVEMyOTkwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19MVEM0MTUxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MVEM0MjE1IGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19MVEM0MjIyIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19MVEM0MjQ1IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MVEM0MjYwIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19MVEM0MjYxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19NQVgxMjcgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX01BWDE2MDY1IGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19NQVgxNjE5IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19NQVgxNjY4IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19NQVgxOTcgaXMgbm90
IHNldAojIENPTkZJR19TRU5TT1JTX01BWDMxNzMwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19NQVgzMTc2MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTUFYNjYyMCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTUFYNjYyMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfTUFYNjYzOSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTUFYNjY0MiBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTUFYNjY1MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfTUFYNjY5NyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTUFYMzE3OTAgaXMg
bm90IHNldAojIENPTkZJR19TRU5TT1JTX01DUDMwMjEgaXMgbm90IHNldAojIENPTkZJR19T
RU5TT1JTX1RDNjU0IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19UUFMyMzg2MSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTVI3NTIwMyBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfTE02MyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE03MyBpcyBub3Qgc2V0
CiMgQ09ORklHX1NFTlNPUlNfTE03NSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE03
NyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE03OCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFTlNPUlNfTE04MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE04MyBpcyBub3Qg
c2V0CiMgQ09ORklHX1NFTlNPUlNfTE04NSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNf
TE04NyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE05MCBpcyBub3Qgc2V0CiMgQ09O
RklHX1NFTlNPUlNfTE05MiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE05MyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE05NTIzNCBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfTE05NTI0MSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE05NTI0NSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfUEM4NzM2MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfUEM4NzQyNyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTkNUNjY4MyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTkNUNjc3NSBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfTkNUNjc3NV9JMkMgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX05DVDc4MDIg
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX05DVDc5MDQgaXMgbm90IHNldAojIENPTkZJ
R19TRU5TT1JTX05QQ003WFggaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1BDRjg1OTEg
aXMgbm90IHNldAojIENPTkZJR19QTUJVUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNf
U0JUU0kgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1NCUk1JIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VOU09SU19TSFQyMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfU0hUM3gg
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1NIVDR4IGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VOU09SU19TSFRDMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfU0lTNTU5NSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRE1FMTczNyBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfRU1DMTQwMyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRU1DMjEwMyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRU1DMjMwNSBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfRU1DNlcyMDEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1NNU0M0N00xIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19TTVNDNDdNMTkyIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VOU09SU19TTVNDNDdCMzk3IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19TQ0g1
NjI3IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19TQ0g1NjM2IGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VOU09SU19TVFRTNzUxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19TTU02
NjUgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FEQzEyOEQ4MTggaXMgbm90IHNldAoj
IENPTkZJR19TRU5TT1JTX0FEUzc4MjggaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FN
QzY4MjEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0lOQTIwOSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfSU5BMlhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19JTkEy
MzggaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0lOQTMyMjEgaXMgbm90IHNldAojIENP
TkZJR19TRU5TT1JTX1RDNzQgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1RITUM1MCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVE1QMTAyIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VOU09SU19UTVAxMDMgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1RNUDEwOCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVE1QNDAxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19UTVA0MjEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1RNUDQ2NCBpcyBub3Qg
c2V0CiMgQ09ORklHX1NFTlNPUlNfVE1QNTEzIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19WSUFfQ1BVVEVNUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVklBNjg2QSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVlQxMjExIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19WVDgyMzEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1c4Mzc3M0cgaXMgbm90
IHNldAojIENPTkZJR19TRU5TT1JTX1c4Mzc4MUQgaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX1c4Mzc5MUQgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1c4Mzc5MkQgaXMgbm90
IHNldAojIENPTkZJR19TRU5TT1JTX1c4Mzc5MyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNP
UlNfVzgzNzk1IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19XODNMNzg1VFMgaXMgbm90
IHNldAojIENPTkZJR19TRU5TT1JTX1c4M0w3ODZORyBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfVzgzNjI3SEYgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1c4MzYyN0VIRiBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfWEdFTkUgaXMgbm90IHNldAoKIwojIEFDUEkg
ZHJpdmVycwojCiMgQ09ORklHX1NFTlNPUlNfQUNQSV9QT1dFUiBpcyBub3Qgc2V0CiMgQ09O
RklHX1NFTlNPUlNfQVRLMDExMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQVNVU19X
TUkgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FTVVNfRUMgaXMgbm90IHNldApDT05G
SUdfVEhFUk1BTD15CkNPTkZJR19USEVSTUFMX05FVExJTks9eQpDT05GSUdfVEhFUk1BTF9T
VEFUSVNUSUNTPXkKQ09ORklHX1RIRVJNQUxfRU1FUkdFTkNZX1BPV0VST0ZGX0RFTEFZX01T
PTAKQ09ORklHX1RIRVJNQUxfSFdNT049eQpDT05GSUdfVEhFUk1BTF9XUklUQUJMRV9UUklQ
Uz15CkNPTkZJR19USEVSTUFMX0RFRkFVTFRfR09WX1NURVBfV0lTRT15CiMgQ09ORklHX1RI
RVJNQUxfREVGQVVMVF9HT1ZfRkFJUl9TSEFSRSBpcyBub3Qgc2V0CiMgQ09ORklHX1RIRVJN
QUxfREVGQVVMVF9HT1ZfVVNFUl9TUEFDRSBpcyBub3Qgc2V0CiMgQ09ORklHX1RIRVJNQUxf
REVGQVVMVF9HT1ZfUE9XRVJfQUxMT0NBVE9SIGlzIG5vdCBzZXQKQ09ORklHX1RIRVJNQUxf
R09WX0ZBSVJfU0hBUkU9eQpDT05GSUdfVEhFUk1BTF9HT1ZfU1RFUF9XSVNFPXkKQ09ORklH
X1RIRVJNQUxfR09WX0JBTkdfQkFORz15CkNPTkZJR19USEVSTUFMX0dPVl9VU0VSX1NQQUNF
PXkKQ09ORklHX1RIRVJNQUxfR09WX1BPV0VSX0FMTE9DQVRPUj15CkNPTkZJR19USEVSTUFM
X0VNVUxBVElPTj15CgojCiMgSW50ZWwgdGhlcm1hbCBkcml2ZXJzCiMKQ09ORklHX0lOVEVM
X1BPV0VSQ0xBTVA9bQpDT05GSUdfWDg2X1RIRVJNQUxfVkVDVE9SPXkKQ09ORklHX1g4Nl9Q
S0dfVEVNUF9USEVSTUFMPW0KQ09ORklHX0lOVEVMX1NPQ19EVFNfSU9TRl9DT1JFPW0KQ09O
RklHX0lOVEVMX1NPQ19EVFNfVEhFUk1BTD1tCgojCiMgQUNQSSBJTlQzNDBYIHRoZXJtYWwg
ZHJpdmVycwojCkNPTkZJR19JTlQzNDBYX1RIRVJNQUw9bQpDT05GSUdfQUNQSV9USEVSTUFM
X1JFTD1tCkNPTkZJR19JTlQzNDA2X1RIRVJNQUw9bQpDT05GSUdfUFJPQ19USEVSTUFMX01N
SU9fUkFQTD1tCiMgZW5kIG9mIEFDUEkgSU5UMzQwWCB0aGVybWFsIGRyaXZlcnMKCkNPTkZJ
R19JTlRFTF9QQ0hfVEhFUk1BTD1tCkNPTkZJR19JTlRFTF9UQ0NfQ09PTElORz1tCkNPTkZJ
R19JTlRFTF9NRU5MT1c9bQojIENPTkZJR19JTlRFTF9IRklfVEhFUk1BTCBpcyBub3Qgc2V0
CiMgZW5kIG9mIEludGVsIHRoZXJtYWwgZHJpdmVycwoKQ09ORklHX1dBVENIRE9HPXkKQ09O
RklHX1dBVENIRE9HX0NPUkU9eQojIENPTkZJR19XQVRDSERPR19OT1dBWU9VVCBpcyBub3Qg
c2V0CkNPTkZJR19XQVRDSERPR19IQU5ETEVfQk9PVF9FTkFCTEVEPXkKQ09ORklHX1dBVENI
RE9HX09QRU5fVElNRU9VVD0wCkNPTkZJR19XQVRDSERPR19TWVNGUz15CiMgQ09ORklHX1dB
VENIRE9HX0hSVElNRVJfUFJFVElNRU9VVCBpcyBub3Qgc2V0CgojCiMgV2F0Y2hkb2cgUHJl
dGltZW91dCBHb3Zlcm5vcnMKIwpDT05GSUdfV0FUQ0hET0dfUFJFVElNRU9VVF9HT1Y9eQpD
T05GSUdfV0FUQ0hET0dfUFJFVElNRU9VVF9HT1ZfU0VMPW0KQ09ORklHX1dBVENIRE9HX1BS
RVRJTUVPVVRfR09WX05PT1A9eQpDT05GSUdfV0FUQ0hET0dfUFJFVElNRU9VVF9HT1ZfUEFO
SUM9bQpDT05GSUdfV0FUQ0hET0dfUFJFVElNRU9VVF9ERUZBVUxUX0dPVl9OT09QPXkKIyBD
T05GSUdfV0FUQ0hET0dfUFJFVElNRU9VVF9ERUZBVUxUX0dPVl9QQU5JQyBpcyBub3Qgc2V0
CgojCiMgV2F0Y2hkb2cgRGV2aWNlIERyaXZlcnMKIwpDT05GSUdfU09GVF9XQVRDSERPRz1t
CkNPTkZJR19TT0ZUX1dBVENIRE9HX1BSRVRJTUVPVVQ9eQojIENPTkZJR19XREFUX1dEVCBp
cyBub3Qgc2V0CiMgQ09ORklHX1hJTElOWF9XQVRDSERPRyBpcyBub3Qgc2V0CiMgQ09ORklH
X1pJSVJBVkVfV0FUQ0hET0cgaXMgbm90IHNldAojIENPTkZJR19DQURFTkNFX1dBVENIRE9H
IGlzIG5vdCBzZXQKIyBDT05GSUdfRFdfV0FUQ0hET0cgaXMgbm90IHNldAojIENPTkZJR19N
QVg2M1hYX1dBVENIRE9HIGlzIG5vdCBzZXQKIyBDT05GSUdfQUNRVUlSRV9XRFQgaXMgbm90
IHNldAojIENPTkZJR19BRFZBTlRFQ0hfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfQUxJTTE1
MzVfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfQUxJTTcxMDFfV0RUIGlzIG5vdCBzZXQKIyBD
T05GSUdfRUJDX0MzODRfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfRVhBUl9XRFQgaXMgbm90
IHNldAojIENPTkZJR19GNzE4MDhFX1dEVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NQNTEwMF9U
Q08gaXMgbm90IHNldAojIENPTkZJR19TQkNfRklUUEMyX1dBVENIRE9HIGlzIG5vdCBzZXQK
IyBDT05GSUdfRVVST1RFQ0hfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfSUI3MDBfV0RUIGlz
IG5vdCBzZXQKIyBDT05GSUdfSUJNQVNSIGlzIG5vdCBzZXQKIyBDT05GSUdfV0FGRVJfV0RU
IGlzIG5vdCBzZXQKIyBDT05GSUdfSTYzMDBFU0JfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdf
SUU2WFhfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfSVRDT19XRFQgaXMgbm90IHNldAojIENP
TkZJR19JVDg3MTJGX1dEVCBpcyBub3Qgc2V0CiMgQ09ORklHX0lUODdfV0RUIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSFBfV0FUQ0hET0cgaXMgbm90IHNldAojIENPTkZJR19TQzEyMDBfV0RU
IGlzIG5vdCBzZXQKIyBDT05GSUdfUEM4NzQxM19XRFQgaXMgbm90IHNldAojIENPTkZJR19O
Vl9UQ08gaXMgbm90IHNldAojIENPTkZJR182MFhYX1dEVCBpcyBub3Qgc2V0CiMgQ09ORklH
X0NQVTVfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfU01TQ19TQ0gzMTFYX1dEVCBpcyBub3Qg
c2V0CiMgQ09ORklHX1NNU0MzN0I3ODdfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfVFFNWDg2
X1dEVCBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJQV9XRFQgaXMgbm90IHNldAojIENPTkZJR19X
ODM2MjdIRl9XRFQgaXMgbm90IHNldAojIENPTkZJR19XODM4NzdGX1dEVCBpcyBub3Qgc2V0
CiMgQ09ORklHX1c4Mzk3N0ZfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFDSFpfV0RUIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0JDX0VQWF9DM19XQVRDSERPRyBpcyBub3Qgc2V0CiMgQ09O
RklHX0lOVEVMX01FSV9XRFQgaXMgbm90IHNldAojIENPTkZJR19OSTkwM1hfV0RUIGlzIG5v
dCBzZXQKIyBDT05GSUdfTklDNzAxOF9XRFQgaXMgbm90IHNldAoKIwojIFBDSS1iYXNlZCBX
YXRjaGRvZyBDYXJkcwojCkNPTkZJR19QQ0lQQ1dBVENIRE9HPW0KQ09ORklHX1dEVFBDST1t
CkNPTkZJR19TU0JfUE9TU0lCTEU9eQojIENPTkZJR19TU0IgaXMgbm90IHNldApDT05GSUdf
QkNNQV9QT1NTSUJMRT15CiMgQ09ORklHX0JDTUEgaXMgbm90IHNldAoKIwojIE11bHRpZnVu
Y3Rpb24gZGV2aWNlIGRyaXZlcnMKIwojIENPTkZJR19NRkRfQkNNNTkwWFggaXMgbm90IHNl
dAojIENPTkZJR19NRkRfQkQ5NTcxTVdWIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0FYUDIw
WF9JMkMgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUFERVJBIGlzIG5vdCBzZXQKIyBDT05G
SUdfTUZEX0RBOTA2MiBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9EQTkwNjMgaXMgbm90IHNl
dAojIENPTkZJR19NRkRfREE5MTUwIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX01DMTNYWFhf
STJDIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX01QMjYyOSBpcyBub3Qgc2V0CiMgQ09ORklH
X0hUQ19QQVNJQzMgaXMgbm90IHNldAojIENPTkZJR19NRkRfSU5URUxfUVVBUktfSTJDX0dQ
SU8gaXMgbm90IHNldAojIENPTkZJR19MUENfSUNIIGlzIG5vdCBzZXQKIyBDT05GSUdfTFBD
X1NDSCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9JTlRFTF9MUFNTX0FDUEkgaXMgbm90IHNl
dAojIENPTkZJR19NRkRfSU5URUxfTFBTU19QQ0kgaXMgbm90IHNldAojIENPTkZJR19NRkRf
SU5URUxfUE1DX0JYVCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9JUVM2MlggaXMgbm90IHNl
dAojIENPTkZJR19NRkRfSkFOWl9DTU9ESU8gaXMgbm90IHNldAojIENPTkZJR19NRkRfS0VN
UExEIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEXzg4UE04MDAgaXMgbm90IHNldAojIENPTkZJ
R19NRkRfODhQTTgwNSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9NQVgxNDU3NyBpcyBub3Qg
c2V0CiMgQ09ORklHX01GRF9NQVg3NzY5MyBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9NQVg4
OTA3IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX01UNjM2MCBpcyBub3Qgc2V0CiMgQ09ORklH
X01GRF9NVDYzNzAgaXMgbm90IHNldAojIENPTkZJR19NRkRfTVQ2Mzk3IGlzIG5vdCBzZXQK
IyBDT05GSUdfTUZEX01FTkYyMUJNQyBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9SRVRVIGlz
IG5vdCBzZXQKIyBDT05GSUdfTUZEX1BDRjUwNjMzIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZE
X1NZNzYzNkEgaXMgbm90IHNldAojIENPTkZJR19NRkRfUkRDMzIxWCBpcyBub3Qgc2V0CiMg
Q09ORklHX01GRF9SVDQ4MzEgaXMgbm90IHNldAojIENPTkZJR19NRkRfUlQ1MDMzIGlzIG5v
dCBzZXQKIyBDT05GSUdfTUZEX1JUNTEyMCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9TSTQ3
NlhfQ09SRSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9TTTUwMSBpcyBub3Qgc2V0CiMgQ09O
RklHX01GRF9TS1k4MTQ1MiBpcyBub3Qgc2V0CkNPTkZJR19NRkRfU1lTQ09OPXkKIyBDT05G
SUdfTUZEX1RJX0FNMzM1WF9UU0NBREMgaXMgbm90IHNldAojIENPTkZJR19NRkRfTFAzOTQz
IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1RJX0xNVSBpcyBub3Qgc2V0CiMgQ09ORklHX1RQ
UzYxMDVYIGlzIG5vdCBzZXQKIyBDT05GSUdfVFBTNjUwN1ggaXMgbm90IHNldAojIENPTkZJ
R19NRkRfVFBTNjUwODYgaXMgbm90IHNldAojIENPTkZJR19NRkRfVElfTFA4NzNYIGlzIG5v
dCBzZXQKIyBDT05GSUdfTUZEX1RQUzY1OTEyX0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX01G
RF9XTDEyNzNfQ09SRSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9MTTM1MzMgaXMgbm90IHNl
dAojIENPTkZJR19NRkRfVFFNWDg2IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1ZYODU1IGlz
IG5vdCBzZXQKIyBDT05GSUdfTUZEX0FSSVpPTkFfSTJDIGlzIG5vdCBzZXQKIyBDT05GSUdf
TUZEX1dNODk5NCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9BVEMyNjBYX0kyQyBpcyBub3Qg
c2V0CiMgZW5kIG9mIE11bHRpZnVuY3Rpb24gZGV2aWNlIGRyaXZlcnMKCiMgQ09ORklHX1JF
R1VMQVRPUiBpcyBub3Qgc2V0CiMgQ09ORklHX1JDX0NPUkUgaXMgbm90IHNldApDT05GSUdf
Q0VDX0NPUkU9bQpDT05GSUdfQ0VDX05PVElGSUVSPXkKCiMKIyBDRUMgc3VwcG9ydAojCiMg
Q09ORklHX01FRElBX0NFQ19TVVBQT1JUIGlzIG5vdCBzZXQKIyBlbmQgb2YgQ0VDIHN1cHBv
cnQKCiMgQ09ORklHX01FRElBX1NVUFBPUlQgaXMgbm90IHNldAoKIwojIEdyYXBoaWNzIHN1
cHBvcnQKIwpDT05GSUdfQVBFUlRVUkVfSEVMUEVSUz15CiMgQ09ORklHX0FHUCBpcyBub3Qg
c2V0CiMgQ09ORklHX1ZHQV9TV0lUQ0hFUk9PIGlzIG5vdCBzZXQKQ09ORklHX0RSTT1tCkNP
TkZJR19EUk1fS01TX0hFTFBFUj1tCkNPTkZJR19EUk1fRkJERVZfRU1VTEFUSU9OPXkKQ09O
RklHX0RSTV9GQkRFVl9PVkVSQUxMT0M9MTAwCkNPTkZJR19EUk1fTE9BRF9FRElEX0ZJUk1X
QVJFPXkKQ09ORklHX0RSTV9HRU1fU0hNRU1fSEVMUEVSPW0KCiMKIyBJMkMgZW5jb2RlciBv
ciBoZWxwZXIgY2hpcHMKIwpDT05GSUdfRFJNX0kyQ19DSDcwMDY9bQpDT05GSUdfRFJNX0ky
Q19TSUwxNjQ9bQpDT05GSUdfRFJNX0kyQ19OWFBfVERBOTk4WD1tCkNPTkZJR19EUk1fSTJD
X05YUF9UREE5OTUwPW0KIyBlbmQgb2YgSTJDIGVuY29kZXIgb3IgaGVscGVyIGNoaXBzCgoj
CiMgQVJNIGRldmljZXMKIwojIGVuZCBvZiBBUk0gZGV2aWNlcwoKIyBDT05GSUdfRFJNX1JB
REVPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9BTURHUFUgaXMgbm90IHNldAojIENPTkZJ
R19EUk1fTk9VVkVBVSBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9JOTE1IGlzIG5vdCBzZXQK
IyBDT05GSUdfRFJNX1ZHRU0gaXMgbm90IHNldAojIENPTkZJR19EUk1fVktNUyBpcyBub3Qg
c2V0CiMgQ09ORklHX0RSTV9WTVdHRlggaXMgbm90IHNldAojIENPTkZJR19EUk1fR01BNTAw
IGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX0FTVCBpcyBub3Qgc2V0CkNPTkZJR19EUk1fTUdB
RzIwMD1tCiMgQ09ORklHX0RSTV9RWEwgaXMgbm90IHNldApDT05GSUdfRFJNX1BBTkVMPXkK
CiMKIyBEaXNwbGF5IFBhbmVscwojCiMgZW5kIG9mIERpc3BsYXkgUGFuZWxzCgpDT05GSUdf
RFJNX0JSSURHRT15CkNPTkZJR19EUk1fUEFORUxfQlJJREdFPXkKCiMKIyBEaXNwbGF5IElu
dGVyZmFjZSBCcmlkZ2VzCiMKIyBDT05GSUdfRFJNX0FOQUxPR0lYX0FOWDc4WFggaXMgbm90
IHNldAojIGVuZCBvZiBEaXNwbGF5IEludGVyZmFjZSBCcmlkZ2VzCgojIENPTkZJR19EUk1f
RVROQVZJViBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9CT0NIUyBpcyBub3Qgc2V0CiMgQ09O
RklHX0RSTV9DSVJSVVNfUUVNVSBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9TSU1QTEVEUk0g
aXMgbm90IHNldAojIENPTkZJR19EUk1fVkJPWFZJREVPIGlzIG5vdCBzZXQKIyBDT05GSUdf
RFJNX1NTRDEzMFggaXMgbm90IHNldAojIENPTkZJR19EUk1fTEVHQUNZIGlzIG5vdCBzZXQK
Q09ORklHX0RSTV9QQU5FTF9PUklFTlRBVElPTl9RVUlSS1M9eQpDT05GSUdfRFJNX05PTU9E
RVNFVD15CgojCiMgRnJhbWUgYnVmZmVyIERldmljZXMKIwpDT05GSUdfRkJfQ01ETElORT15
CkNPTkZJR19GQl9OT1RJRlk9eQpDT05GSUdfRkI9eQpDT05GSUdfRklSTVdBUkVfRURJRD15
CkNPTkZJR19GQl9DRkJfRklMTFJFQ1Q9eQpDT05GSUdfRkJfQ0ZCX0NPUFlBUkVBPXkKQ09O
RklHX0ZCX0NGQl9JTUFHRUJMSVQ9eQpDT05GSUdfRkJfU1lTX0ZJTExSRUNUPW0KQ09ORklH
X0ZCX1NZU19DT1BZQVJFQT1tCkNPTkZJR19GQl9TWVNfSU1BR0VCTElUPW0KIyBDT05GSUdf
RkJfRk9SRUlHTl9FTkRJQU4gaXMgbm90IHNldApDT05GSUdfRkJfU1lTX0ZPUFM9bQpDT05G
SUdfRkJfREVGRVJSRURfSU89eQpDT05GSUdfRkJfTU9ERV9IRUxQRVJTPXkKQ09ORklHX0ZC
X1RJTEVCTElUVElORz15CgojCiMgRnJhbWUgYnVmZmVyIGhhcmR3YXJlIGRyaXZlcnMKIwoj
IENPTkZJR19GQl9DSVJSVVMgaXMgbm90IHNldAojIENPTkZJR19GQl9QTTIgaXMgbm90IHNl
dAojIENPTkZJR19GQl9DWUJFUjIwMDAgaXMgbm90IHNldAojIENPTkZJR19GQl9BUkMgaXMg
bm90IHNldAojIENPTkZJR19GQl9BU0lMSUFOVCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0lN
U1RUIGlzIG5vdCBzZXQKQ09ORklHX0ZCX1ZHQTE2PW0KIyBDT05GSUdfRkJfVVZFU0EgaXMg
bm90IHNldApDT05GSUdfRkJfVkVTQT15CkNPTkZJR19GQl9FRkk9eQojIENPTkZJR19GQl9O
NDExIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfSEdBIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJf
T1BFTkNPUkVTIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfUzFEMTNYWFggaXMgbm90IHNldAoj
IENPTkZJR19GQl9OVklESUEgaXMgbm90IHNldAojIENPTkZJR19GQl9SSVZBIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRkJfSTc0MCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0xFODA1NzggaXMg
bm90IHNldAojIENPTkZJR19GQl9NQVRST1ggaXMgbm90IHNldAojIENPTkZJR19GQl9SQURF
T04gaXMgbm90IHNldAojIENPTkZJR19GQl9BVFkxMjggaXMgbm90IHNldAojIENPTkZJR19G
Ql9BVFkgaXMgbm90IHNldAojIENPTkZJR19GQl9TMyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZC
X1NBVkFHRSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1NJUyBpcyBub3Qgc2V0CiMgQ09ORklH
X0ZCX05FT01BR0lDIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfS1lSTyBpcyBub3Qgc2V0CiMg
Q09ORklHX0ZCXzNERlggaXMgbm90IHNldAojIENPTkZJR19GQl9WT09ET08xIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRkJfVlQ4NjIzIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfVFJJREVOVCBp
cyBub3Qgc2V0CiMgQ09ORklHX0ZCX0FSSyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1BNMyBp
cyBub3Qgc2V0CiMgQ09ORklHX0ZCX0NBUk1JTkUgaXMgbm90IHNldAojIENPTkZJR19GQl9J
Qk1fR1hUNDUwMCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1ZJUlRVQUwgaXMgbm90IHNldAoj
IENPTkZJR19GQl9NRVRST05PTUUgaXMgbm90IHNldAojIENPTkZJR19GQl9NQjg2MlhYIGlz
IG5vdCBzZXQKQ09ORklHX0ZCX1NJTVBMRT1tCiMgQ09ORklHX0ZCX1NNNzEyIGlzIG5vdCBz
ZXQKIyBlbmQgb2YgRnJhbWUgYnVmZmVyIERldmljZXMKCiMKIyBCYWNrbGlnaHQgJiBMQ0Qg
ZGV2aWNlIHN1cHBvcnQKIwojIENPTkZJR19MQ0RfQ0xBU1NfREVWSUNFIGlzIG5vdCBzZXQK
Q09ORklHX0JBQ0tMSUdIVF9DTEFTU19ERVZJQ0U9eQojIENPTkZJR19CQUNLTElHSFRfQVBQ
TEUgaXMgbm90IHNldAojIENPTkZJR19CQUNLTElHSFRfUUNPTV9XTEVEIGlzIG5vdCBzZXQK
IyBDT05GSUdfQkFDS0xJR0hUX1NBSEFSQSBpcyBub3Qgc2V0CiMgQ09ORklHX0JBQ0tMSUdI
VF9BRFA4ODYwIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFDS0xJR0hUX0FEUDg4NzAgaXMgbm90
IHNldAojIENPTkZJR19CQUNLTElHSFRfTE0zNjM5IGlzIG5vdCBzZXQKIyBDT05GSUdfQkFD
S0xJR0hUX0xWNTIwN0xQIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFDS0xJR0hUX0JENjEwNyBp
cyBub3Qgc2V0CiMgQ09ORklHX0JBQ0tMSUdIVF9BUkNYQ05OIGlzIG5vdCBzZXQKIyBlbmQg
b2YgQmFja2xpZ2h0ICYgTENEIGRldmljZSBzdXBwb3J0CgpDT05GSUdfVkdBU1RBVEU9bQpD
T05GSUdfSERNST15CgojCiMgQ29uc29sZSBkaXNwbGF5IGRyaXZlciBzdXBwb3J0CiMKQ09O
RklHX1ZHQV9DT05TT0xFPXkKQ09ORklHX0RVTU1ZX0NPTlNPTEU9eQpDT05GSUdfRFVNTVlf
Q09OU09MRV9DT0xVTU5TPTgwCkNPTkZJR19EVU1NWV9DT05TT0xFX1JPV1M9MjUKQ09ORklH
X0ZSQU1FQlVGRkVSX0NPTlNPTEU9eQojIENPTkZJR19GUkFNRUJVRkZFUl9DT05TT0xFX0xF
R0FDWV9BQ0NFTEVSQVRJT04gaXMgbm90IHNldApDT05GSUdfRlJBTUVCVUZGRVJfQ09OU09M
RV9ERVRFQ1RfUFJJTUFSWT15CkNPTkZJR19GUkFNRUJVRkZFUl9DT05TT0xFX1JPVEFUSU9O
PXkKQ09ORklHX0ZSQU1FQlVGRkVSX0NPTlNPTEVfREVGRVJSRURfVEFLRU9WRVI9eQojIGVu
ZCBvZiBDb25zb2xlIGRpc3BsYXkgZHJpdmVyIHN1cHBvcnQKCiMgQ09ORklHX0xPR08gaXMg
bm90IHNldAojIGVuZCBvZiBHcmFwaGljcyBzdXBwb3J0CgojIENPTkZJR19TT1VORCBpcyBu
b3Qgc2V0CgojCiMgSElEIHN1cHBvcnQKIwpDT05GSUdfSElEPW0KQ09ORklHX0hJRF9CQVRU
RVJZX1NUUkVOR1RIPXkKQ09ORklHX0hJRFJBVz15CkNPTkZJR19VSElEPW0KIyBDT05GSUdf
SElEX0dFTkVSSUMgaXMgbm90IHNldAoKIwojIFNwZWNpYWwgSElEIGRyaXZlcnMKIwojIENP
TkZJR19ISURfQTRURUNIIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0FDUlVYIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSElEX0FQUExFIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0FVUkVBTCBp
cyBub3Qgc2V0CiMgQ09ORklHX0hJRF9CRUxLSU4gaXMgbm90IHNldAojIENPTkZJR19ISURf
Q0hFUlJZIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0NPVUdBUiBpcyBub3Qgc2V0CiMgQ09O
RklHX0hJRF9NQUNBTExZIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0NNRURJQSBpcyBub3Qg
c2V0CiMgQ09ORklHX0hJRF9DWVBSRVNTIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0RSQUdP
TlJJU0UgaXMgbm90IHNldAojIENPTkZJR19ISURfRU1TX0ZGIGlzIG5vdCBzZXQKIyBDT05G
SUdfSElEX0VMRUNPTSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9FWktFWSBpcyBub3Qgc2V0
CiMgQ09ORklHX0hJRF9HRU1CSVJEIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0dGUk0gaXMg
bm90IHNldAojIENPTkZJR19ISURfR0xPUklPVVMgaXMgbm90IHNldAojIENPTkZJR19ISURf
VklWQUxESSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9LRVlUT1VDSCBpcyBub3Qgc2V0CiMg
Q09ORklHX0hJRF9LWUUgaXMgbm90IHNldAojIENPTkZJR19ISURfV0FMVE9QIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSElEX1ZJRVdTT05JQyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9WUkMy
IGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1hJQU9NSSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJ
RF9HWVJBVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9JQ0FERSBpcyBub3Qgc2V0CiMg
Q09ORklHX0hJRF9JVEUgaXMgbm90IHNldAojIENPTkZJR19ISURfSkFCUkEgaXMgbm90IHNl
dAojIENPTkZJR19ISURfVFdJTkhBTiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9LRU5TSU5H
VE9OIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0xDUE9XRVIgaXMgbm90IHNldAojIENPTkZJ
R19ISURfTEVEIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0xFTk9WTyBpcyBub3Qgc2V0CiMg
Q09ORklHX0hJRF9NQUdJQ01PVVNFIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX01BTFRST04g
aXMgbm90IHNldAojIENPTkZJR19ISURfTUFZRkxBU0ggaXMgbm90IHNldAojIENPTkZJR19I
SURfUkVEUkFHT04gaXMgbm90IHNldAojIENPTkZJR19ISURfTUlDUk9TT0ZUIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSElEX01PTlRFUkVZIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX01VTFRJ
VE9VQ0ggaXMgbm90IHNldAojIENPTkZJR19ISURfTklOVEVORE8gaXMgbm90IHNldAojIENP
TkZJR19ISURfTlRJIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX09SVEVLIGlzIG5vdCBzZXQK
IyBDT05GSUdfSElEX1BBTlRIRVJMT1JEIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1BFVEFM
WU5YIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1BJQ09MQ0QgaXMgbm90IHNldAojIENPTkZJ
R19ISURfUExBTlRST05JQ1MgaXMgbm90IHNldAojIENPTkZJR19ISURfUFhSQyBpcyBub3Qg
c2V0CiMgQ09ORklHX0hJRF9SQVpFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9QUklNQVgg
aXMgbm90IHNldAojIENPTkZJR19ISURfU0FJVEVLIGlzIG5vdCBzZXQKIyBDT05GSUdfSElE
X1NFTUlURUsgaXMgbm90IHNldAojIENPTkZJR19ISURfU1BFRURMSU5LIGlzIG5vdCBzZXQK
IyBDT05GSUdfSElEX1NURUFNIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1NURUVMU0VSSUVT
IGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1NVTlBMVVMgaXMgbm90IHNldAojIENPTkZJR19I
SURfUk1JIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0dSRUVOQVNJQSBpcyBub3Qgc2V0CiMg
Q09ORklHX0hJRF9TTUFSVEpPWVBMVVMgaXMgbm90IHNldAojIENPTkZJR19ISURfVElWTyBp
cyBub3Qgc2V0CiMgQ09ORklHX0hJRF9UT1BTRUVEIGlzIG5vdCBzZXQKIyBDT05GSUdfSElE
X1RPUFJFIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1RISU5HTSBpcyBub3Qgc2V0CiMgQ09O
RklHX0hJRF9VRFJBV19QUzMgaXMgbm90IHNldAojIENPTkZJR19ISURfV0lJTU9URSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0hJRF9YSU5NTyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9aRVJP
UExVUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9aWURBQ1JPTiBpcyBub3Qgc2V0CiMgQ09O
RklHX0hJRF9TRU5TT1JfSFVCIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0FMUFMgaXMgbm90
IHNldAojIGVuZCBvZiBTcGVjaWFsIEhJRCBkcml2ZXJzCgojCiMgSTJDIEhJRCBzdXBwb3J0
CiMKQ09ORklHX0kyQ19ISURfQUNQST1tCiMgZW5kIG9mIEkyQyBISUQgc3VwcG9ydAoKQ09O
RklHX0kyQ19ISURfQ09SRT1tCgojCiMgSW50ZWwgSVNIIEhJRCBzdXBwb3J0CiMKIyBDT05G
SUdfSU5URUxfSVNIX0hJRCBpcyBub3Qgc2V0CiMgZW5kIG9mIEludGVsIElTSCBISUQgc3Vw
cG9ydAoKIwojIEFNRCBTRkggSElEIFN1cHBvcnQKIwojIENPTkZJR19BTURfU0ZIX0hJRCBp
cyBub3Qgc2V0CiMgZW5kIG9mIEFNRCBTRkggSElEIFN1cHBvcnQKIyBlbmQgb2YgSElEIHN1
cHBvcnQKCkNPTkZJR19VU0JfT0hDSV9MSVRUTEVfRU5ESUFOPXkKIyBDT05GSUdfVVNCX1NV
UFBPUlQgaXMgbm90IHNldAojIENPTkZJR19NTUMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJ
X1VGU0hDRCBpcyBub3Qgc2V0CiMgQ09ORklHX01FTVNUSUNLIGlzIG5vdCBzZXQKQ09ORklH
X05FV19MRURTPXkKQ09ORklHX0xFRFNfQ0xBU1M9bQojIENPTkZJR19MRURTX0NMQVNTX0ZM
QVNIIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19DTEFTU19NVUxUSUNPTE9SIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTEVEU19CUklHSFRORVNTX0hXX0NIQU5HRUQgaXMgbm90IHNldAoKIwoj
IExFRCBkcml2ZXJzCiMKIyBDT05GSUdfTEVEU19BUFUgaXMgbm90IHNldAojIENPTkZJR19M
RURTX0xNMzUzMCBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfTE0zNTMyIGlzIG5vdCBzZXQK
IyBDT05GSUdfTEVEU19MTTM2NDIgaXMgbm90IHNldAojIENPTkZJR19MRURTX1BDQTk1MzIg
aXMgbm90IHNldAojIENPTkZJR19MRURTX0xQMzk0NCBpcyBub3Qgc2V0CiMgQ09ORklHX0xF
RFNfUENBOTU1WCBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfUENBOTYzWCBpcyBub3Qgc2V0
CiMgQ09ORklHX0xFRFNfQkQyODAyIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19JTlRFTF9T
UzQyMDAgaXMgbm90IHNldAojIENPTkZJR19MRURTX1RDQTY1MDcgaXMgbm90IHNldAojIENP
TkZJR19MRURTX1RMQzU5MVhYIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19MTTM1NXggaXMg
bm90IHNldAojIENPTkZJR19MRURTX0lTMzFGTDMxOVggaXMgbm90IHNldAoKIwojIExFRCBk
cml2ZXIgZm9yIGJsaW5rKDEpIFVTQiBSR0IgTEVEIGlzIHVuZGVyIFNwZWNpYWwgSElEIGRy
aXZlcnMgKEhJRF9USElOR00pCiMKIyBDT05GSUdfTEVEU19CTElOS00gaXMgbm90IHNldAoj
IENPTkZJR19MRURTX01MWENQTEQgaXMgbm90IHNldAojIENPTkZJR19MRURTX01MWFJFRyBp
cyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfVVNFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNf
TklDNzhCWCBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfVElfTE1VX0NPTU1PTiBpcyBub3Qg
c2V0CgojCiMgRmxhc2ggYW5kIFRvcmNoIExFRCBkcml2ZXJzCiMKCiMKIyBSR0IgTEVEIGRy
aXZlcnMKIwoKIwojIExFRCBUcmlnZ2VycwojCiMgQ09ORklHX0xFRFNfVFJJR0dFUlMgaXMg
bm90IHNldAoKIwojIFNpbXBsZSBMRUQgZHJpdmVycwojCiMgQ09ORklHX0FDQ0VTU0lCSUxJ
VFkgaXMgbm90IHNldAojIENPTkZJR19JTkZJTklCQU5EIGlzIG5vdCBzZXQKQ09ORklHX0VE
QUNfQVRPTUlDX1NDUlVCPXkKQ09ORklHX0VEQUNfU1VQUE9SVD15CiMgQ09ORklHX0VEQUMg
aXMgbm90IHNldApDT05GSUdfUlRDX0xJQj15CkNPTkZJR19SVENfTUMxNDY4MThfTElCPXkK
Q09ORklHX1JUQ19DTEFTUz15CkNPTkZJR19SVENfSENUT1NZUz15CkNPTkZJR19SVENfSENU
T1NZU19ERVZJQ0U9InJ0YzAiCkNPTkZJR19SVENfU1lTVE9IQz15CkNPTkZJR19SVENfU1lT
VE9IQ19ERVZJQ0U9InJ0YzAiCiMgQ09ORklHX1JUQ19ERUJVRyBpcyBub3Qgc2V0CkNPTkZJ
R19SVENfTlZNRU09eQoKIwojIFJUQyBpbnRlcmZhY2VzCiMKQ09ORklHX1JUQ19JTlRGX1NZ
U0ZTPXkKQ09ORklHX1JUQ19JTlRGX1BST0M9eQpDT05GSUdfUlRDX0lOVEZfREVWPXkKIyBD
T05GSUdfUlRDX0lOVEZfREVWX1VJRV9FTVVMIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RS
Vl9URVNUIGlzIG5vdCBzZXQKCiMKIyBJMkMgUlRDIGRyaXZlcnMKIwojIENPTkZJR19SVENf
RFJWX0FCQjVaRVMzIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9BQkVPWjkgaXMgbm90
IHNldAojIENPTkZJR19SVENfRFJWX0FCWDgwWCBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19E
UlZfRFMxMzA3IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9EUzEzNzQgaXMgbm90IHNl
dAojIENPTkZJR19SVENfRFJWX0RTMTY3MiBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZf
TUFYNjkwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUlM1QzM3MiBpcyBub3Qgc2V0
CiMgQ09ORklHX1JUQ19EUlZfSVNMMTIwOCBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZf
SVNMMTIwMjIgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1gxMjA1IGlzIG5vdCBzZXQK
IyBDT05GSUdfUlRDX0RSVl9QQ0Y4NTIzIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9Q
Q0Y4NTA2MyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUENGODUzNjMgaXMgbm90IHNl
dAojIENPTkZJR19SVENfRFJWX1BDRjg1NjMgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJW
X1BDRjg1ODMgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX000MVQ4MCBpcyBub3Qgc2V0
CiMgQ09ORklHX1JUQ19EUlZfQlEzMksgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1Mz
NTM5MEEgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX0ZNMzEzMCBpcyBub3Qgc2V0CiMg
Q09ORklHX1JUQ19EUlZfUlg4MDEwIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9SWDg1
ODEgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1JYODAyNSBpcyBub3Qgc2V0CiMgQ09O
RklHX1JUQ19EUlZfRU0zMDI3IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9SVjMwMjgg
aXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1JWMzAzMiBpcyBub3Qgc2V0CiMgQ09ORklH
X1JUQ19EUlZfUlY4ODAzIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9TRDMwNzggaXMg
bm90IHNldAoKIwojIFNQSSBSVEMgZHJpdmVycwojCkNPTkZJR19SVENfSTJDX0FORF9TUEk9
bQoKIwojIFNQSSBhbmQgSTJDIFJUQyBkcml2ZXJzCiMKIyBDT05GSUdfUlRDX0RSVl9EUzMy
MzIgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1BDRjIxMjcgaXMgbm90IHNldAojIENP
TkZJR19SVENfRFJWX1JWMzAyOUMyIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9SWDYx
MTAgaXMgbm90IHNldAoKIwojIFBsYXRmb3JtIFJUQyBkcml2ZXJzCiMKQ09ORklHX1JUQ19E
UlZfQ01PUz15CiMgQ09ORklHX1JUQ19EUlZfRFMxMjg2IGlzIG5vdCBzZXQKIyBDT05GSUdf
UlRDX0RSVl9EUzE1MTEgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX0RTMTU1MyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRFMxNjg1X0ZBTUlMWSBpcyBub3Qgc2V0CiMgQ09O
RklHX1JUQ19EUlZfRFMxNzQyIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9EUzI0MDQg
aXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1NUSzE3VEE4IGlzIG5vdCBzZXQKIyBDT05G
SUdfUlRDX0RSVl9NNDhUODYgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX000OFQzNSBp
cyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfTTQ4VDU5IGlzIG5vdCBzZXQKIyBDT05GSUdf
UlRDX0RSVl9NU002MjQyIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9CUTQ4MDIgaXMg
bm90IHNldAojIENPTkZJR19SVENfRFJWX1JQNUMwMSBpcyBub3Qgc2V0CiMgQ09ORklHX1JU
Q19EUlZfVjMwMjAgaXMgbm90IHNldAoKIwojIG9uLUNQVSBSVEMgZHJpdmVycwojCkNPTkZJ
R19SVENfRFJWX0ZUUlRDMDEwPW0KCiMKIyBISUQgU2Vuc29yIFJUQyBkcml2ZXJzCiMKQ09O
RklHX1JUQ19EUlZfR09MREZJU0g9bQpDT05GSUdfRE1BREVWSUNFUz15CiMgQ09ORklHX0RN
QURFVklDRVNfREVCVUcgaXMgbm90IHNldAoKIwojIERNQSBEZXZpY2VzCiMKQ09ORklHX0RN
QV9FTkdJTkU9eQpDT05GSUdfRE1BX1ZJUlRVQUxfQ0hBTk5FTFM9eQpDT05GSUdfRE1BX0FD
UEk9eQpDT05GSUdfQUxURVJBX01TR0RNQT15CkNPTkZJR19JTlRFTF9JRE1BNjQ9bQpDT05G
SUdfSU5URUxfSURYRF9CVVM9bQpDT05GSUdfSU5URUxfSURYRD1tCiMgQ09ORklHX0lOVEVM
X0lEWERfQ09NUEFUIGlzIG5vdCBzZXQKQ09ORklHX0lOVEVMX0lEWERfU1ZNPXkKQ09ORklH
X0lOVEVMX0lEWERfUEVSRk1PTj15CkNPTkZJR19JTlRFTF9JT0FURE1BPW0KQ09ORklHX1BM
WF9ETUE9eQojIENPTkZJR19BTURfUFRETUEgaXMgbm90IHNldAojIENPTkZJR19RQ09NX0hJ
RE1BX01HTVQgaXMgbm90IHNldAojIENPTkZJR19RQ09NX0hJRE1BIGlzIG5vdCBzZXQKIyBD
T05GSUdfRFdfRE1BQyBpcyBub3Qgc2V0CiMgQ09ORklHX0RXX0RNQUNfUENJIGlzIG5vdCBz
ZXQKQ09ORklHX0RXX0VETUE9eQojIENPTkZJR19EV19FRE1BX1BDSUUgaXMgbm90IHNldAoj
IENPTkZJR19TRl9QRE1BIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5URUxfTERNQSBpcyBub3Qg
c2V0CgojCiMgRE1BIENsaWVudHMKIwpDT05GSUdfQVNZTkNfVFhfRE1BPXkKIyBDT05GSUdf
RE1BVEVTVCBpcyBub3Qgc2V0CkNPTkZJR19ETUFfRU5HSU5FX1JBSUQ9eQoKIwojIERNQUJV
RiBvcHRpb25zCiMKQ09ORklHX1NZTkNfRklMRT15CkNPTkZJR19TV19TWU5DPXkKQ09ORklH
X1VETUFCVUY9eQojIENPTkZJR19ETUFCVUZfTU9WRV9OT1RJRlkgaXMgbm90IHNldAojIENP
TkZJR19ETUFCVUZfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19ETUFCVUZfU0VMRlRFU1RT
IGlzIG5vdCBzZXQKQ09ORklHX0RNQUJVRl9IRUFQUz15CiMgQ09ORklHX0RNQUJVRl9TWVNG
U19TVEFUUyBpcyBub3Qgc2V0CkNPTkZJR19ETUFCVUZfSEVBUFNfU1lTVEVNPXkKIyBlbmQg
b2YgRE1BQlVGIG9wdGlvbnMKCkNPTkZJR19EQ0E9bQojIENPTkZJR19BVVhESVNQTEFZIGlz
IG5vdCBzZXQKQ09ORklHX1VJTz1tCiMgQ09ORklHX1VJT19DSUYgaXMgbm90IHNldApDT05G
SUdfVUlPX1BEUlZfR0VOSVJRPW0KQ09ORklHX1VJT19ETUVNX0dFTklSUT1tCiMgQ09ORklH
X1VJT19BRUMgaXMgbm90IHNldAojIENPTkZJR19VSU9fU0VSQ09TMyBpcyBub3Qgc2V0CkNP
TkZJR19VSU9fUENJX0dFTkVSSUM9bQojIENPTkZJR19VSU9fTkVUWCBpcyBub3Qgc2V0CiMg
Q09ORklHX1VJT19QUlVTUyBpcyBub3Qgc2V0CiMgQ09ORklHX1VJT19NRjYyNCBpcyBub3Qg
c2V0CiMgQ09ORklHX1ZGSU8gaXMgbm90IHNldApDT05GSUdfSVJRX0JZUEFTU19NQU5BR0VS
PW0KIyBDT05GSUdfVklSVF9EUklWRVJTIGlzIG5vdCBzZXQKIyBDT05GSUdfVklSVElPX01F
TlUgaXMgbm90IHNldAojIENPTkZJR19WRFBBIGlzIG5vdCBzZXQKIyBDT05GSUdfVkhPU1Rf
TUVOVSBpcyBub3Qgc2V0CgojCiMgTWljcm9zb2Z0IEh5cGVyLVYgZ3Vlc3Qgc3VwcG9ydAoj
CiMgZW5kIG9mIE1pY3Jvc29mdCBIeXBlci1WIGd1ZXN0IHN1cHBvcnQKCiMgQ09ORklHX0dS
RVlCVVMgaXMgbm90IHNldAojIENPTkZJR19DT01FREkgaXMgbm90IHNldAojIENPTkZJR19T
VEFHSU5HIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hST01FX1BMQVRGT1JNUyBpcyBub3Qgc2V0
CiMgQ09ORklHX01FTExBTk9YX1BMQVRGT1JNIGlzIG5vdCBzZXQKIyBDT05GSUdfU1VSRkFD
RV9QTEFURk9STVMgaXMgbm90IHNldApDT05GSUdfWDg2X1BMQVRGT1JNX0RFVklDRVM9eQpD
T05GSUdfQUNQSV9XTUk9bQpDT05GSUdfV01JX0JNT0Y9bQojIENPTkZJR19IVUFXRUlfV01J
IGlzIG5vdCBzZXQKQ09ORklHX01YTV9XTUk9bQpDT05GSUdfUEVBUV9XTUk9bQojIENPTkZJ
R19OVklESUFfV01JX0VDX0JBQ0tMSUdIVCBpcyBub3Qgc2V0CiMgQ09ORklHX1hJQU9NSV9X
TUkgaXMgbm90IHNldAojIENPTkZJR19HSUdBQllURV9XTUkgaXMgbm90IHNldAojIENPTkZJ
R19ZT0dBQk9PS19XTUkgaXMgbm90IHNldAojIENPTkZJR19BQ0VSSERGIGlzIG5vdCBzZXQK
IyBDT05GSUdfQUNFUl9XSVJFTEVTUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FDRVJfV01JIGlz
IG5vdCBzZXQKIyBDT05GSUdfQU1EX1BNRiBpcyBub3Qgc2V0CiMgQ09ORklHX0FNRF9QTUMg
aXMgbm90IHNldAojIENPTkZJR19BTURfSFNNUCBpcyBub3Qgc2V0CiMgQ09ORklHX0FEVl9T
V0JVVFRPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0FQUExFX0dNVVggaXMgbm90IHNldAojIENP
TkZJR19BU1VTX0xBUFRPUCBpcyBub3Qgc2V0CkNPTkZJR19BU1VTX1dJUkVMRVNTPW0KIyBD
T05GSUdfQVNVU19XTUkgaXMgbm90IHNldAojIENPTkZJR19FRUVQQ19MQVBUT1AgaXMgbm90
IHNldAojIENPTkZJR19YODZfUExBVEZPUk1fRFJJVkVSU19ERUxMIGlzIG5vdCBzZXQKIyBD
T05GSUdfRlVKSVRTVV9MQVBUT1AgaXMgbm90IHNldAojIENPTkZJR19GVUpJVFNVX1RBQkxF
VCBpcyBub3Qgc2V0CiMgQ09ORklHX0dQRF9QT0NLRVRfRkFOIGlzIG5vdCBzZXQKIyBDT05G
SUdfWDg2X1BMQVRGT1JNX0RSSVZFUlNfSFAgaXMgbm90IHNldAojIENPTkZJR19XSVJFTEVT
U19IT1RLRVkgaXMgbm90IHNldAojIENPTkZJR19JQk1fUlRMIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VOU09SU19IREFQUyBpcyBub3Qgc2V0CiMgQ09ORklHX1RISU5LUEFEX0FDUEkgaXMg
bm90IHNldAojIENPTkZJR19USElOS1BBRF9MTUkgaXMgbm90IHNldAojIENPTkZJR19JTlRF
TF9BVE9NSVNQMl9QTSBpcyBub3Qgc2V0CkNPTkZJR19JTlRFTF9TQVJfSU5UMTA5Mj1tCkNP
TkZJR19JTlRFTF9QTUNfQ09SRT1tCgojCiMgSW50ZWwgU3BlZWQgU2VsZWN0IFRlY2hub2xv
Z3kgaW50ZXJmYWNlIHN1cHBvcnQKIwpDT05GSUdfSU5URUxfU1BFRURfU0VMRUNUX0lOVEVS
RkFDRT1tCiMgZW5kIG9mIEludGVsIFNwZWVkIFNlbGVjdCBUZWNobm9sb2d5IGludGVyZmFj
ZSBzdXBwb3J0CgpDT05GSUdfSU5URUxfV01JPXkKQ09ORklHX0lOVEVMX1dNSV9TQkxfRldf
VVBEQVRFPW0KQ09ORklHX0lOVEVMX1dNSV9USFVOREVSQk9MVD1tCgojCiMgSW50ZWwgVW5j
b3JlIEZyZXF1ZW5jeSBDb250cm9sCiMKQ09ORklHX0lOVEVMX1VOQ09SRV9GUkVRX0NPTlRS
T0w9bQojIGVuZCBvZiBJbnRlbCBVbmNvcmUgRnJlcXVlbmN5IENvbnRyb2wKCkNPTkZJR19J
TlRFTF9ISURfRVZFTlQ9bQpDT05GSUdfSU5URUxfVkJUTj1tCkNPTkZJR19JTlRFTF9QVU5J
VF9JUEM9bQpDT05GSUdfSU5URUxfUlNUPW0KQ09ORklHX0lOVEVMX1NNQVJUQ09OTkVDVD1t
CkNPTkZJR19JTlRFTF9UVVJCT19NQVhfMz15CiMgQ09ORklHX0lOVEVMX1ZTRUMgaXMgbm90
IHNldAojIENPTkZJR19NU0lfV01JIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FNU1VOR19MQVBU
T1AgaXMgbm90IHNldAojIENPTkZJR19TQU1TVU5HX1ExMCBpcyBub3Qgc2V0CiMgQ09ORklH
X1RPU0hJQkFfQlRfUkZLSUxMIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9TSElCQV9IQVBTIGlz
IG5vdCBzZXQKIyBDT05GSUdfVE9TSElCQV9XTUkgaXMgbm90IHNldAojIENPTkZJR19BQ1BJ
X0NNUEMgaXMgbm90IHNldAojIENPTkZJR19MR19MQVBUT1AgaXMgbm90IHNldAojIENPTkZJ
R19QQU5BU09OSUNfTEFQVE9QIGlzIG5vdCBzZXQKIyBDT05GSUdfU1lTVEVNNzZfQUNQSSBp
cyBub3Qgc2V0CiMgQ09ORklHX1RPUFNUQVJfTEFQVE9QIGlzIG5vdCBzZXQKIyBDT05GSUdf
TUxYX1BMQVRGT1JNIGlzIG5vdCBzZXQKQ09ORklHX0lOVEVMX0lQUz1tCkNPTkZJR19JTlRF
TF9TQ1VfSVBDPXkKQ09ORklHX0lOVEVMX1NDVT15CkNPTkZJR19JTlRFTF9TQ1VfUENJPXkK
Q09ORklHX0lOVEVMX1NDVV9QTEFURk9STT1tCkNPTkZJR19JTlRFTF9TQ1VfSVBDX1VUSUw9
bQojIENPTkZJR19TSUVNRU5TX1NJTUFUSUNfSVBDIGlzIG5vdCBzZXQKIyBDT05GSUdfV0lO
TUFURV9GTTA3X0tFWVMgaXMgbm90IHNldAojIENPTkZJR19QMlNCIGlzIG5vdCBzZXQKQ09O
RklHX0hBVkVfQ0xLPXkKQ09ORklHX0hBVkVfQ0xLX1BSRVBBUkU9eQpDT05GSUdfQ09NTU9O
X0NMSz15CiMgQ09ORklHX0NPTU1PTl9DTEtfTUFYOTQ4NSBpcyBub3Qgc2V0CiMgQ09ORklH
X0NPTU1PTl9DTEtfU0k1MzQxIGlzIG5vdCBzZXQKIyBDT05GSUdfQ09NTU9OX0NMS19TSTUz
NTEgaXMgbm90IHNldAojIENPTkZJR19DT01NT05fQ0xLX1NJNTQ0IGlzIG5vdCBzZXQKIyBD
T05GSUdfQ09NTU9OX0NMS19DRENFNzA2IGlzIG5vdCBzZXQKIyBDT05GSUdfQ09NTU9OX0NM
S19DUzIwMDBfQ1AgaXMgbm90IHNldAojIENPTkZJR19YSUxJTlhfVkNVIGlzIG5vdCBzZXQK
Q09ORklHX0hXU1BJTkxPQ0s9eQoKIwojIENsb2NrIFNvdXJjZSBkcml2ZXJzCiMKQ09ORklH
X0NMS0VWVF9JODI1Mz15CkNPTkZJR19JODI1M19MT0NLPXkKQ09ORklHX0NMS0JMRF9JODI1
Mz15CiMgZW5kIG9mIENsb2NrIFNvdXJjZSBkcml2ZXJzCgpDT05GSUdfTUFJTEJPWD15CkNP
TkZJR19QQ0M9eQojIENPTkZJR19BTFRFUkFfTUJPWCBpcyBub3Qgc2V0CkNPTkZJR19JT01N
VV9JT1ZBPXkKQ09ORklHX0lPQVNJRD15CkNPTkZJR19JT01NVV9BUEk9eQpDT05GSUdfSU9N
TVVfU1VQUE9SVD15CgojCiMgR2VuZXJpYyBJT01NVSBQYWdldGFibGUgU3VwcG9ydAojCiMg
ZW5kIG9mIEdlbmVyaWMgSU9NTVUgUGFnZXRhYmxlIFN1cHBvcnQKCiMgQ09ORklHX0lPTU1V
X0RFQlVHRlMgaXMgbm90IHNldAojIENPTkZJR19JT01NVV9ERUZBVUxUX0RNQV9TVFJJQ1Qg
aXMgbm90IHNldApDT05GSUdfSU9NTVVfREVGQVVMVF9ETUFfTEFaWT15CiMgQ09ORklHX0lP
TU1VX0RFRkFVTFRfUEFTU1RIUk9VR0ggaXMgbm90IHNldApDT05GSUdfSU9NTVVfRE1BPXkK
Q09ORklHX0lPTU1VX1NWQT15CiMgQ09ORklHX0FNRF9JT01NVSBpcyBub3Qgc2V0CkNPTkZJ
R19ETUFSX1RBQkxFPXkKQ09ORklHX0lOVEVMX0lPTU1VPXkKQ09ORklHX0lOVEVMX0lPTU1V
X1NWTT15CiMgQ09ORklHX0lOVEVMX0lPTU1VX0RFRkFVTFRfT04gaXMgbm90IHNldApDT05G
SUdfSU5URUxfSU9NTVVfRkxPUFBZX1dBPXkKIyBDT05GSUdfSU5URUxfSU9NTVVfU0NBTEFC
TEVfTU9ERV9ERUZBVUxUX09OIGlzIG5vdCBzZXQKQ09ORklHX0lSUV9SRU1BUD15CgojCiMg
UmVtb3RlcHJvYyBkcml2ZXJzCiMKIyBDT05GSUdfUkVNT1RFUFJPQyBpcyBub3Qgc2V0CiMg
ZW5kIG9mIFJlbW90ZXByb2MgZHJpdmVycwoKIwojIFJwbXNnIGRyaXZlcnMKIwojIENPTkZJ
R19SUE1TR19RQ09NX0dMSU5LX1JQTSBpcyBub3Qgc2V0CiMgQ09ORklHX1JQTVNHX1ZJUlRJ
TyBpcyBub3Qgc2V0CiMgZW5kIG9mIFJwbXNnIGRyaXZlcnMKCiMgQ09ORklHX1NPVU5EV0lS
RSBpcyBub3Qgc2V0CgojCiMgU09DIChTeXN0ZW0gT24gQ2hpcCkgc3BlY2lmaWMgRHJpdmVy
cwojCgojCiMgQW1sb2dpYyBTb0MgZHJpdmVycwojCiMgZW5kIG9mIEFtbG9naWMgU29DIGRy
aXZlcnMKCiMKIyBCcm9hZGNvbSBTb0MgZHJpdmVycwojCiMgZW5kIG9mIEJyb2FkY29tIFNv
QyBkcml2ZXJzCgojCiMgTlhQL0ZyZWVzY2FsZSBRb3JJUSBTb0MgZHJpdmVycwojCiMgZW5k
IG9mIE5YUC9GcmVlc2NhbGUgUW9ySVEgU29DIGRyaXZlcnMKCiMKIyBmdWppdHN1IFNvQyBk
cml2ZXJzCiMKIyBlbmQgb2YgZnVqaXRzdSBTb0MgZHJpdmVycwoKIwojIGkuTVggU29DIGRy
aXZlcnMKIwojIGVuZCBvZiBpLk1YIFNvQyBkcml2ZXJzCgojCiMgRW5hYmxlIExpdGVYIFNv
QyBCdWlsZGVyIHNwZWNpZmljIGRyaXZlcnMKIwojIGVuZCBvZiBFbmFibGUgTGl0ZVggU29D
IEJ1aWxkZXIgc3BlY2lmaWMgZHJpdmVycwoKIwojIFF1YWxjb21tIFNvQyBkcml2ZXJzCiMK
IyBlbmQgb2YgUXVhbGNvbW0gU29DIGRyaXZlcnMKCiMgQ09ORklHX1NPQ19USSBpcyBub3Qg
c2V0CgojCiMgWGlsaW54IFNvQyBkcml2ZXJzCiMKIyBlbmQgb2YgWGlsaW54IFNvQyBkcml2
ZXJzCiMgZW5kIG9mIFNPQyAoU3lzdGVtIE9uIENoaXApIHNwZWNpZmljIERyaXZlcnMKCiMg
Q09ORklHX1BNX0RFVkZSRVEgaXMgbm90IHNldAojIENPTkZJR19FWFRDT04gaXMgbm90IHNl
dApDT05GSUdfTUVNT1JZPXkKIyBDT05GSUdfSUlPIGlzIG5vdCBzZXQKIyBDT05GSUdfTlRC
IGlzIG5vdCBzZXQKIyBDT05GSUdfUFdNIGlzIG5vdCBzZXQKCiMKIyBJUlEgY2hpcCBzdXBw
b3J0CiMKIyBlbmQgb2YgSVJRIGNoaXAgc3VwcG9ydAoKIyBDT05GSUdfSVBBQ0tfQlVTIGlz
IG5vdCBzZXQKIyBDT05GSUdfUkVTRVRfQ09OVFJPTExFUiBpcyBub3Qgc2V0CgojCiMgUEhZ
IFN1YnN5c3RlbQojCkNPTkZJR19HRU5FUklDX1BIWT15CiMgQ09ORklHX1BIWV9DQU5fVFJB
TlNDRUlWRVIgaXMgbm90IHNldAoKIwojIFBIWSBkcml2ZXJzIGZvciBCcm9hZGNvbSBwbGF0
Zm9ybXMKIwpDT05GSUdfQkNNX0tPTkFfVVNCMl9QSFk9bQojIGVuZCBvZiBQSFkgZHJpdmVy
cyBmb3IgQnJvYWRjb20gcGxhdGZvcm1zCgojIENPTkZJR19QSFlfUFhBXzI4Tk1fSFNJQyBp
cyBub3Qgc2V0CiMgQ09ORklHX1BIWV9QWEFfMjhOTV9VU0IyIGlzIG5vdCBzZXQKQ09ORklH
X1BIWV9JTlRFTF9MR01fRU1NQz1tCiMgZW5kIG9mIFBIWSBTdWJzeXN0ZW0KCkNPTkZJR19Q
T1dFUkNBUD15CkNPTkZJR19JTlRFTF9SQVBMX0NPUkU9bQpDT05GSUdfSU5URUxfUkFQTD1t
CkNPTkZJR19JRExFX0lOSkVDVD15CiMgQ09ORklHX01DQiBpcyBub3Qgc2V0CgojCiMgUGVy
Zm9ybWFuY2UgbW9uaXRvciBzdXBwb3J0CiMKIyBlbmQgb2YgUGVyZm9ybWFuY2UgbW9uaXRv
ciBzdXBwb3J0CgpDT05GSUdfUkFTPXkKQ09ORklHX1JBU19DRUM9eQojIENPTkZJR19SQVNf
Q0VDX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCNCBpcyBub3Qgc2V0CgojCiMgQW5k
cm9pZAojCiMgQ09ORklHX0FORFJPSURfQklOREVSX0lQQyBpcyBub3Qgc2V0CiMgZW5kIG9m
IEFuZHJvaWQKCkNPTkZJR19MSUJOVkRJTU09eQpDT05GSUdfQkxLX0RFVl9QTUVNPW0KQ09O
RklHX05EX0NMQUlNPXkKQ09ORklHX05EX0JUVD1tCkNPTkZJR19CVFQ9eQpDT05GSUdfTkRf
UEZOPW0KQ09ORklHX05WRElNTV9QRk49eQpDT05GSUdfTlZESU1NX0RBWD15CkNPTkZJR19O
VkRJTU1fS0VZUz15CkNPTkZJR19EQVg9eQpDT05GSUdfREVWX0RBWD1tCkNPTkZJR19ERVZf
REFYX1BNRU09bQpDT05GSUdfREVWX0RBWF9ITUVNPW0KQ09ORklHX0RFVl9EQVhfSE1FTV9E
RVZJQ0VTPXkKQ09ORklHX0RFVl9EQVhfS01FTT1tCkNPTkZJR19OVk1FTT15CkNPTkZJR19O
Vk1FTV9TWVNGUz15CkNPTkZJR19OVk1FTV9STUVNPW0KCiMKIyBIVyB0cmFjaW5nIHN1cHBv
cnQKIwpDT05GSUdfU1RNPW0KQ09ORklHX1NUTV9QUk9UT19CQVNJQz1tCkNPTkZJR19TVE1f
UFJPVE9fU1lTX1Q9bQpDT05GSUdfU1RNX0RVTU1ZPW0KQ09ORklHX1NUTV9TT1VSQ0VfQ09O
U09MRT1tCkNPTkZJR19TVE1fU09VUkNFX0hFQVJUQkVBVD1tCkNPTkZJR19JTlRFTF9USD1t
CkNPTkZJR19JTlRFTF9USF9QQ0k9bQpDT05GSUdfSU5URUxfVEhfQUNQST1tCkNPTkZJR19J
TlRFTF9USF9HVEg9bQpDT05GSUdfSU5URUxfVEhfU1RIPW0KQ09ORklHX0lOVEVMX1RIX01T
VT1tCkNPTkZJR19JTlRFTF9USF9QVEk9bQojIENPTkZJR19JTlRFTF9USF9ERUJVRyBpcyBu
b3Qgc2V0CiMgZW5kIG9mIEhXIHRyYWNpbmcgc3VwcG9ydAoKIyBDT05GSUdfRlBHQSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1RFRSBpcyBub3Qgc2V0CiMgQ09ORklHX1NJT1ggaXMgbm90IHNl
dAojIENPTkZJR19TTElNQlVTIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5URVJDT05ORUNUIGlz
IG5vdCBzZXQKIyBDT05GSUdfQ09VTlRFUiBpcyBub3Qgc2V0CiMgQ09ORklHX01PU1QgaXMg
bm90IHNldAojIENPTkZJR19QRUNJIGlzIG5vdCBzZXQKIyBDT05GSUdfSFRFIGlzIG5vdCBz
ZXQKIyBlbmQgb2YgRGV2aWNlIERyaXZlcnMKCiMKIyBGaWxlIHN5c3RlbXMKIwpDT05GSUdf
RENBQ0hFX1dPUkRfQUNDRVNTPXkKQ09ORklHX1ZBTElEQVRFX0ZTX1BBUlNFUj15CkNPTkZJ
R19GU19JT01BUD15CiMgQ09ORklHX0VYVDJfRlMgaXMgbm90IHNldAojIENPTkZJR19FWFQz
X0ZTIGlzIG5vdCBzZXQKQ09ORklHX0VYVDRfRlM9bQojIENPTkZJR19FWFQ0X1VTRV9GT1Jf
RVhUMiBpcyBub3Qgc2V0CkNPTkZJR19FWFQ0X0ZTX1BPU0lYX0FDTD15CkNPTkZJR19FWFQ0
X0ZTX1NFQ1VSSVRZPXkKIyBDT05GSUdfRVhUNF9ERUJVRyBpcyBub3Qgc2V0CkNPTkZJR19K
QkQyPW0KIyBDT05GSUdfSkJEMl9ERUJVRyBpcyBub3Qgc2V0CkNPTkZJR19GU19NQkNBQ0hF
PW0KIyBDT05GSUdfUkVJU0VSRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19KRlNfRlMgaXMg
bm90IHNldAojIENPTkZJR19YRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19HRlMyX0ZTIGlz
IG5vdCBzZXQKIyBDT05GSUdfT0NGUzJfRlMgaXMgbm90IHNldApDT05GSUdfQlRSRlNfRlM9
bQpDT05GSUdfQlRSRlNfRlNfUE9TSVhfQUNMPXkKIyBDT05GSUdfQlRSRlNfRlNfQ0hFQ0tf
SU5URUdSSVRZIGlzIG5vdCBzZXQKIyBDT05GSUdfQlRSRlNfRlNfUlVOX1NBTklUWV9URVNU
UyBpcyBub3Qgc2V0CiMgQ09ORklHX0JUUkZTX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdf
QlRSRlNfQVNTRVJUIGlzIG5vdCBzZXQKIyBDT05GSUdfQlRSRlNfRlNfUkVGX1ZFUklGWSBp
cyBub3Qgc2V0CiMgQ09ORklHX05JTEZTMl9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0YyRlNf
RlMgaXMgbm90IHNldAojIENPTkZJR19aT05FRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19G
U19EQVggaXMgbm90IHNldApDT05GSUdfRlNfUE9TSVhfQUNMPXkKQ09ORklHX0VYUE9SVEZT
PXkKQ09ORklHX0VYUE9SVEZTX0JMT0NLX09QUz15CkNPTkZJR19GSUxFX0xPQ0tJTkc9eQpD
T05GSUdfRlNfRU5DUllQVElPTj15CkNPTkZJR19GU19FTkNSWVBUSU9OX0FMR1M9bQpDT05G
SUdfRlNfRU5DUllQVElPTl9JTkxJTkVfQ1JZUFQ9eQpDT05GSUdfRlNfVkVSSVRZPXkKIyBD
T05GSUdfRlNfVkVSSVRZX0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX0ZTX1ZFUklUWV9CVUlM
VElOX1NJR05BVFVSRVM9eQpDT05GSUdfRlNOT1RJRlk9eQpDT05GSUdfRE5PVElGWT15CkNP
TkZJR19JTk9USUZZX1VTRVI9eQpDT05GSUdfRkFOT1RJRlk9eQpDT05GSUdfRkFOT1RJRllf
QUNDRVNTX1BFUk1JU1NJT05TPXkKQ09ORklHX1FVT1RBPXkKQ09ORklHX1FVT1RBX05FVExJ
TktfSU5URVJGQUNFPXkKIyBDT05GSUdfUFJJTlRfUVVPVEFfV0FSTklORyBpcyBub3Qgc2V0
CiMgQ09ORklHX1FVT1RBX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfUUZNVF9WMSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1FGTVRfVjIgaXMgbm90IHNldApDT05GSUdfUVVPVEFDVEw9eQoj
IENPTkZJR19BVVRPRlM0X0ZTIGlzIG5vdCBzZXQKQ09ORklHX0FVVE9GU19GUz1tCkNPTkZJ
R19GVVNFX0ZTPW0KQ09ORklHX0NVU0U9bQojIENPTkZJR19WSVJUSU9fRlMgaXMgbm90IHNl
dApDT05GSUdfT1ZFUkxBWV9GUz1tCiMgQ09ORklHX09WRVJMQVlfRlNfUkVESVJFQ1RfRElS
IGlzIG5vdCBzZXQKQ09ORklHX09WRVJMQVlfRlNfUkVESVJFQ1RfQUxXQVlTX0ZPTExPVz15
CiMgQ09ORklHX09WRVJMQVlfRlNfSU5ERVggaXMgbm90IHNldApDT05GSUdfT1ZFUkxBWV9G
U19YSU5PX0FVVE89eQojIENPTkZJR19PVkVSTEFZX0ZTX01FVEFDT1BZIGlzIG5vdCBzZXQK
CiMKIyBDYWNoZXMKIwpDT05GSUdfTkVURlNfU1VQUE9SVD1tCkNPTkZJR19ORVRGU19TVEFU
Uz15CkNPTkZJR19GU0NBQ0hFPW0KQ09ORklHX0ZTQ0FDSEVfU1RBVFM9eQojIENPTkZJR19G
U0NBQ0hFX0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX0NBQ0hFRklMRVM9bQojIENPTkZJR19D
QUNIRUZJTEVTX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0FDSEVGSUxFU19FUlJPUl9J
TkpFQ1RJT04gaXMgbm90IHNldAojIENPTkZJR19DQUNIRUZJTEVTX09OREVNQU5EIGlzIG5v
dCBzZXQKIyBlbmQgb2YgQ2FjaGVzCgojCiMgQ0QtUk9NL0RWRCBGaWxlc3lzdGVtcwojCkNP
TkZJR19JU085NjYwX0ZTPW0KQ09ORklHX0pPTElFVD15CkNPTkZJR19aSVNPRlM9eQojIENP
TkZJR19VREZfRlMgaXMgbm90IHNldAojIGVuZCBvZiBDRC1ST00vRFZEIEZpbGVzeXN0ZW1z
CgojCiMgRE9TL0ZBVC9FWEZBVC9OVCBGaWxlc3lzdGVtcwojCkNPTkZJR19GQVRfRlM9eQpD
T05GSUdfTVNET1NfRlM9bQpDT05GSUdfVkZBVF9GUz15CkNPTkZJR19GQVRfREVGQVVMVF9D
T0RFUEFHRT00MzcKQ09ORklHX0ZBVF9ERUZBVUxUX0lPQ0hBUlNFVD0iaXNvODg1OS0xIgoj
IENPTkZJR19GQVRfREVGQVVMVF9VVEY4IGlzIG5vdCBzZXQKIyBDT05GSUdfRVhGQVRfRlMg
aXMgbm90IHNldAojIENPTkZJR19OVEZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfTlRGUzNf
RlMgaXMgbm90IHNldAojIGVuZCBvZiBET1MvRkFUL0VYRkFUL05UIEZpbGVzeXN0ZW1zCgoj
CiMgUHNldWRvIGZpbGVzeXN0ZW1zCiMKQ09ORklHX1BST0NfRlM9eQpDT05GSUdfUFJPQ19L
Q09SRT15CkNPTkZJR19QUk9DX1ZNQ09SRT15CkNPTkZJR19QUk9DX1ZNQ09SRV9ERVZJQ0Vf
RFVNUD15CkNPTkZJR19QUk9DX1NZU0NUTD15CkNPTkZJR19QUk9DX1BBR0VfTU9OSVRPUj15
CkNPTkZJR19QUk9DX0NISUxEUkVOPXkKQ09ORklHX1BST0NfUElEX0FSQ0hfU1RBVFVTPXkK
Q09ORklHX1BST0NfQ1BVX1JFU0NUUkw9eQpDT05GSUdfS0VSTkZTPXkKQ09ORklHX1NZU0ZT
PXkKQ09ORklHX1RNUEZTPXkKQ09ORklHX1RNUEZTX1BPU0lYX0FDTD15CkNPTkZJR19UTVBG
U19YQVRUUj15CkNPTkZJR19UTVBGU19JTk9ERTY0PXkKQ09ORklHX0hVR0VUTEJGUz15CkNP
TkZJR19IVUdFVExCX1BBR0U9eQpDT05GSUdfQVJDSF9XQU5UX0hVR0VUTEJfUEFHRV9PUFRJ
TUlaRV9WTUVNTUFQPXkKQ09ORklHX0hVR0VUTEJfUEFHRV9PUFRJTUlaRV9WTUVNTUFQPXkK
IyBDT05GSUdfSFVHRVRMQl9QQUdFX09QVElNSVpFX1ZNRU1NQVBfREVGQVVMVF9PTiBpcyBu
b3Qgc2V0CkNPTkZJR19NRU1GRF9DUkVBVEU9eQpDT05GSUdfQVJDSF9IQVNfR0lHQU5USUNf
UEFHRT15CkNPTkZJR19DT05GSUdGU19GUz15CkNPTkZJR19FRklWQVJfRlM9eQojIGVuZCBv
ZiBQc2V1ZG8gZmlsZXN5c3RlbXMKCkNPTkZJR19NSVNDX0ZJTEVTWVNURU1TPXkKIyBDT05G
SUdfT1JBTkdFRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19BREZTX0ZTIGlzIG5vdCBzZXQK
IyBDT05GSUdfQUZGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0VDUllQVF9GUyBpcyBub3Qg
c2V0CiMgQ09ORklHX0hGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hGU1BMVVNfRlMgaXMg
bm90IHNldAojIENPTkZJR19CRUZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQkZTX0ZTIGlz
IG5vdCBzZXQKIyBDT05GSUdfRUZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JBTUZTIGlz
IG5vdCBzZXQKQ09ORklHX1NRVUFTSEZTPW0KIyBDT05GSUdfU1FVQVNIRlNfRklMRV9DQUNI
RSBpcyBub3Qgc2V0CkNPTkZJR19TUVVBU0hGU19GSUxFX0RJUkVDVD15CkNPTkZJR19TUVVB
U0hGU19ERUNPTVBfU0lOR0xFPXkKIyBDT05GSUdfU1FVQVNIRlNfREVDT01QX01VTFRJIGlz
IG5vdCBzZXQKIyBDT05GSUdfU1FVQVNIRlNfREVDT01QX01VTFRJX1BFUkNQVSBpcyBub3Qg
c2V0CkNPTkZJR19TUVVBU0hGU19YQVRUUj15CkNPTkZJR19TUVVBU0hGU19aTElCPXkKQ09O
RklHX1NRVUFTSEZTX0xaND15CkNPTkZJR19TUVVBU0hGU19MWk89eQpDT05GSUdfU1FVQVNI
RlNfWFo9eQpDT05GSUdfU1FVQVNIRlNfWlNURD15CiMgQ09ORklHX1NRVUFTSEZTXzRLX0RF
VkJMS19TSVpFIGlzIG5vdCBzZXQKIyBDT05GSUdfU1FVQVNIRlNfRU1CRURERUQgaXMgbm90
IHNldApDT05GSUdfU1FVQVNIRlNfRlJBR01FTlRfQ0FDSEVfU0laRT0zCiMgQ09ORklHX1ZY
RlNfRlMgaXMgbm90IHNldAojIENPTkZJR19NSU5JWF9GUyBpcyBub3Qgc2V0CiMgQ09ORklH
X09NRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19IUEZTX0ZTIGlzIG5vdCBzZXQKIyBDT05G
SUdfUU5YNEZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfUU5YNkZTX0ZTIGlzIG5vdCBzZXQK
IyBDT05GSUdfUk9NRlNfRlMgaXMgbm90IHNldApDT05GSUdfUFNUT1JFPXkKQ09ORklHX1BT
VE9SRV9ERUZBVUxUX0tNU0dfQllURVM9MTAyNDAKQ09ORklHX1BTVE9SRV9ERUZMQVRFX0NP
TVBSRVNTPXkKIyBDT05GSUdfUFNUT1JFX0xaT19DT01QUkVTUyBpcyBub3Qgc2V0CiMgQ09O
RklHX1BTVE9SRV9MWjRfQ09NUFJFU1MgaXMgbm90IHNldAojIENPTkZJR19QU1RPUkVfTFo0
SENfQ09NUFJFU1MgaXMgbm90IHNldAojIENPTkZJR19QU1RPUkVfODQyX0NPTVBSRVNTIGlz
IG5vdCBzZXQKIyBDT05GSUdfUFNUT1JFX1pTVERfQ09NUFJFU1MgaXMgbm90IHNldApDT05G
SUdfUFNUT1JFX0NPTVBSRVNTPXkKQ09ORklHX1BTVE9SRV9ERUZMQVRFX0NPTVBSRVNTX0RF
RkFVTFQ9eQpDT05GSUdfUFNUT1JFX0NPTVBSRVNTX0RFRkFVTFQ9ImRlZmxhdGUiCiMgQ09O
RklHX1BTVE9SRV9DT05TT0xFIGlzIG5vdCBzZXQKIyBDT05GSUdfUFNUT1JFX1BNU0cgaXMg
bm90IHNldApDT05GSUdfUFNUT1JFX1JBTT1tCkNPTkZJR19QU1RPUkVfWk9ORT1tCkNPTkZJ
R19QU1RPUkVfQkxLPW0KQ09ORklHX1BTVE9SRV9CTEtfQkxLREVWPSIiCkNPTkZJR19QU1RP
UkVfQkxLX0tNU0dfU0laRT02NApDT05GSUdfUFNUT1JFX0JMS19NQVhfUkVBU09OPTIKIyBD
T05GSUdfU1lTVl9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1VGU19GUyBpcyBub3Qgc2V0CiMg
Q09ORklHX0VST0ZTX0ZTIGlzIG5vdCBzZXQKQ09ORklHX05FVFdPUktfRklMRVNZU1RFTVM9
eQpDT05GSUdfTkZTX0ZTPW0KIyBDT05GSUdfTkZTX1YyIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkZTX1YzIGlzIG5vdCBzZXQKQ09ORklHX05GU19WND1tCkNPTkZJR19ORlNfU1dBUD15CkNP
TkZJR19ORlNfVjRfMT15CiMgQ09ORklHX05GU19WNF8yIGlzIG5vdCBzZXQKQ09ORklHX1BO
RlNfRklMRV9MQVlPVVQ9bQpDT05GSUdfUE5GU19CTE9DSz1tCkNPTkZJR19ORlNfVjRfMV9J
TVBMRU1FTlRBVElPTl9JRF9ET01BSU49Imtlcm5lbC5vcmciCkNPTkZJR19ORlNfVjRfMV9N
SUdSQVRJT049eQpDT05GSUdfTkZTX0ZTQ0FDSEU9eQojIENPTkZJR19ORlNfVVNFX0xFR0FD
WV9ETlMgaXMgbm90IHNldApDT05GSUdfTkZTX1VTRV9LRVJORUxfRE5TPXkKQ09ORklHX05G
U19ESVNBQkxFX1VEUF9TVVBQT1JUPXkKQ09ORklHX05GU0Q9bQojIENPTkZJR19ORlNEX1Yz
X0FDTCBpcyBub3Qgc2V0CkNPTkZJR19ORlNEX1Y0PXkKQ09ORklHX05GU0RfUE5GUz15CkNP
TkZJR19ORlNEX0JMT0NLTEFZT1VUPXkKQ09ORklHX05GU0RfU0NTSUxBWU9VVD15CkNPTkZJ
R19ORlNEX0ZMRVhGSUxFTEFZT1VUPXkKQ09ORklHX05GU0RfVjRfU0VDVVJJVFlfTEFCRUw9
eQpDT05GSUdfR1JBQ0VfUEVSSU9EPW0KQ09ORklHX0xPQ0tEPW0KQ09ORklHX0xPQ0tEX1Y0
PXkKQ09ORklHX05GU19DT01NT049eQpDT05GSUdfU1VOUlBDPW0KQ09ORklHX1NVTlJQQ19H
U1M9bQpDT05GSUdfU1VOUlBDX0JBQ0tDSEFOTkVMPXkKQ09ORklHX1NVTlJQQ19TV0FQPXkK
IyBDT05GSUdfU1VOUlBDX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0VQSF9GUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0NJRlMgaXMgbm90IHNldAojIENPTkZJR19TTUJfU0VSVkVSIGlz
IG5vdCBzZXQKIyBDT05GSUdfQ09EQV9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FGU19GUyBp
cyBub3Qgc2V0CkNPTkZJR19OTFM9eQpDT05GSUdfTkxTX0RFRkFVTFQ9InV0ZjgiCkNPTkZJ
R19OTFNfQ09ERVBBR0VfNDM3PXkKIyBDT05GSUdfTkxTX0NPREVQQUdFXzczNyBpcyBub3Qg
c2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV83NzUgaXMgbm90IHNldApDT05GSUdfTkxTX0NP
REVQQUdFXzg1MD1tCiMgQ09ORklHX05MU19DT0RFUEFHRV84NTIgaXMgbm90IHNldAojIENP
TkZJR19OTFNfQ09ERVBBR0VfODU1IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdF
Xzg1NyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjAgaXMgbm90IHNldAoj
IENPTkZJR19OTFNfQ09ERVBBR0VfODYxIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQ
QUdFXzg2MiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjMgaXMgbm90IHNl
dAojIENPTkZJR19OTFNfQ09ERVBBR0VfODY0IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NP
REVQQUdFXzg2NSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjYgaXMgbm90
IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODY5IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxT
X0NPREVQQUdFXzkzNiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV85NTAgaXMg
bm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfOTMyIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkxTX0NPREVQQUdFXzk0OSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NzQg
aXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV84IGlzIG5vdCBzZXQKIyBDT05GSUdf
TkxTX0NPREVQQUdFXzEyNTAgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfMTI1
MSBpcyBub3Qgc2V0CkNPTkZJR19OTFNfQVNDSUk9bQpDT05GSUdfTkxTX0lTTzg4NTlfMT1t
CiMgQ09ORklHX05MU19JU084ODU5XzIgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1
OV8zIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfNCBpcyBub3Qgc2V0CiMgQ09O
RklHX05MU19JU084ODU5XzUgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV82IGlz
IG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfNyBpcyBub3Qgc2V0CiMgQ09ORklHX05M
U19JU084ODU5XzkgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV8xMyBpcyBub3Qg
c2V0CiMgQ09ORklHX05MU19JU084ODU5XzE0IGlzIG5vdCBzZXQKQ09ORklHX05MU19JU084
ODU5XzE1PW0KIyBDT05GSUdfTkxTX0tPSThfUiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19L
T0k4X1UgaXMgbm90IHNldAojIENPTkZJR19OTFNfTUFDX1JPTUFOIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkxTX01BQ19DRUxUSUMgaXMgbm90IHNldAojIENPTkZJR19OTFNfTUFDX0NFTlRF
VVJPIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX01BQ19DUk9BVElBTiBpcyBub3Qgc2V0CiMg
Q09ORklHX05MU19NQUNfQ1lSSUxMSUMgaXMgbm90IHNldAojIENPTkZJR19OTFNfTUFDX0dB
RUxJQyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19NQUNfR1JFRUsgaXMgbm90IHNldAojIENP
TkZJR19OTFNfTUFDX0lDRUxBTkQgaXMgbm90IHNldAojIENPTkZJR19OTFNfTUFDX0lOVUlU
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX01BQ19ST01BTklBTiBpcyBub3Qgc2V0CiMgQ09O
RklHX05MU19NQUNfVFVSS0lTSCBpcyBub3Qgc2V0CkNPTkZJR19OTFNfVVRGOD1tCiMgQ09O
RklHX0RMTSBpcyBub3Qgc2V0CiMgQ09ORklHX1VOSUNPREUgaXMgbm90IHNldApDT05GSUdf
SU9fV1E9eQojIGVuZCBvZiBGaWxlIHN5c3RlbXMKCiMKIyBTZWN1cml0eSBvcHRpb25zCiMK
Q09ORklHX0tFWVM9eQpDT05GSUdfS0VZU19SRVFVRVNUX0NBQ0hFPXkKQ09ORklHX1BFUlNJ
U1RFTlRfS0VZUklOR1M9eQpDT05GSUdfVFJVU1RFRF9LRVlTPXkKCiMKIyBObyB0cnVzdCBz
b3VyY2Ugc2VsZWN0ZWQhCiMKQ09ORklHX0VOQ1JZUFRFRF9LRVlTPXkKIyBDT05GSUdfVVNF
Ul9ERUNSWVBURURfREFUQSBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWV9ESF9PUEVSQVRJT05T
IGlzIG5vdCBzZXQKQ09ORklHX0tFWV9OT1RJRklDQVRJT05TPXkKIyBDT05GSUdfU0VDVVJJ
VFlfRE1FU0dfUkVTVFJJQ1QgaXMgbm90IHNldApDT05GSUdfU0VDVVJJVFk9eQpDT05GSUdf
U0VDVVJJVFlGUz15CkNPTkZJR19TRUNVUklUWV9ORVRXT1JLPXkKIyBDT05GSUdfU0VDVVJJ
VFlfTkVUV09SS19YRlJNIGlzIG5vdCBzZXQKQ09ORklHX1NFQ1VSSVRZX1BBVEg9eQpDT05G
SUdfSU5URUxfVFhUPXkKQ09ORklHX0hBVkVfSEFSREVORURfVVNFUkNPUFlfQUxMT0NBVE9S
PXkKQ09ORklHX0hBUkRFTkVEX1VTRVJDT1BZPXkKQ09ORklHX0ZPUlRJRllfU09VUkNFPXkK
IyBDT05GSUdfU1RBVElDX1VTRVJNT0RFSEVMUEVSIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VD
VVJJVFlfU0VMSU5VWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFQ1VSSVRZX1NNQUNLIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VDVVJJVFlfVE9NT1lPIGlzIG5vdCBzZXQKQ09ORklHX1NFQ1VS
SVRZX0FQUEFSTU9SPXkKIyBDT05GSUdfU0VDVVJJVFlfQVBQQVJNT1JfREVCVUcgaXMgbm90
IHNldApDT05GSUdfU0VDVVJJVFlfQVBQQVJNT1JfSU5UUk9TUEVDVF9QT0xJQ1k9eQpDT05G
SUdfU0VDVVJJVFlfQVBQQVJNT1JfSEFTSD15CkNPTkZJR19TRUNVUklUWV9BUFBBUk1PUl9I
QVNIX0RFRkFVTFQ9eQpDT05GSUdfU0VDVVJJVFlfQVBQQVJNT1JfRVhQT1JUX0JJTkFSWT15
CkNPTkZJR19TRUNVUklUWV9BUFBBUk1PUl9QQVJBTk9JRF9MT0FEPXkKIyBDT05GSUdfU0VD
VVJJVFlfTE9BRFBJTiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFQ1VSSVRZX1lBTUEgaXMgbm90
IHNldAojIENPTkZJR19TRUNVUklUWV9TQUZFU0VUSUQgaXMgbm90IHNldAojIENPTkZJR19T
RUNVUklUWV9MT0NLRE9XTl9MU00gaXMgbm90IHNldAojIENPTkZJR19TRUNVUklUWV9MQU5E
TE9DSyBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVHUklUWSBpcyBub3Qgc2V0CiMgQ09ORklH
X0lNQV9TRUNVUkVfQU5EX09SX1RSVVNURURfQk9PVCBpcyBub3Qgc2V0CkNPTkZJR19ERUZB
VUxUX1NFQ1VSSVRZX0FQUEFSTU9SPXkKIyBDT05GSUdfREVGQVVMVF9TRUNVUklUWV9EQUMg
aXMgbm90IHNldApDT05GSUdfTFNNPSJsYW5kbG9jayxsb2NrZG93bix5YW1hLGludGVncml0
eSxhcHBhcm1vciIKCiMKIyBLZXJuZWwgaGFyZGVuaW5nIG9wdGlvbnMKIwoKIwojIE1lbW9y
eSBpbml0aWFsaXphdGlvbgojCkNPTkZJR19JTklUX1NUQUNLX05PTkU9eQpDT05GSUdfSU5J
VF9PTl9BTExPQ19ERUZBVUxUX09OPXkKIyBDT05GSUdfSU5JVF9PTl9GUkVFX0RFRkFVTFRf
T04gaXMgbm90IHNldApDT05GSUdfQ0NfSEFTX1pFUk9fQ0FMTF9VU0VEX1JFR1M9eQojIENP
TkZJR19aRVJPX0NBTExfVVNFRF9SRUdTIGlzIG5vdCBzZXQKIyBlbmQgb2YgTWVtb3J5IGlu
aXRpYWxpemF0aW9uCgpDT05GSUdfUkFORFNUUlVDVF9OT05FPXkKIyBlbmQgb2YgS2VybmVs
IGhhcmRlbmluZyBvcHRpb25zCiMgZW5kIG9mIFNlY3VyaXR5IG9wdGlvbnMKCkNPTkZJR19Y
T1JfQkxPQ0tTPW0KQ09ORklHX0FTWU5DX0NPUkU9bQpDT05GSUdfQVNZTkNfTUVNQ1BZPW0K
Q09ORklHX0FTWU5DX1hPUj1tCkNPTkZJR19BU1lOQ19QUT1tCkNPTkZJR19BU1lOQ19SQUlE
Nl9SRUNPVj1tCkNPTkZJR19DUllQVE89eQoKIwojIENyeXB0byBjb3JlIG9yIGhlbHBlcgoj
CkNPTkZJR19DUllQVE9fQUxHQVBJPXkKQ09ORklHX0NSWVBUT19BTEdBUEkyPXkKQ09ORklH
X0NSWVBUT19BRUFEPXkKQ09ORklHX0NSWVBUT19BRUFEMj15CkNPTkZJR19DUllQVE9fU0tD
SVBIRVI9eQpDT05GSUdfQ1JZUFRPX1NLQ0lQSEVSMj15CkNPTkZJR19DUllQVE9fSEFTSD15
CkNPTkZJR19DUllQVE9fSEFTSDI9eQpDT05GSUdfQ1JZUFRPX1JORz15CkNPTkZJR19DUllQ
VE9fUk5HMj15CkNPTkZJR19DUllQVE9fUk5HX0RFRkFVTFQ9eQpDT05GSUdfQ1JZUFRPX0FL
Q0lQSEVSMj15CkNPTkZJR19DUllQVE9fQUtDSVBIRVI9eQpDT05GSUdfQ1JZUFRPX0tQUDI9
eQpDT05GSUdfQ1JZUFRPX0tQUD15CkNPTkZJR19DUllQVE9fQUNPTVAyPXkKQ09ORklHX0NS
WVBUT19NQU5BR0VSPXkKQ09ORklHX0NSWVBUT19NQU5BR0VSMj15CkNPTkZJR19DUllQVE9f
VVNFUj1tCkNPTkZJR19DUllQVE9fTUFOQUdFUl9ESVNBQkxFX1RFU1RTPXkKQ09ORklHX0NS
WVBUT19HRjEyOE1VTD15CkNPTkZJR19DUllQVE9fTlVMTD15CkNPTkZJR19DUllQVE9fTlVM
TDI9eQojIENPTkZJR19DUllQVE9fUENSWVBUIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19D
UllQVEQ9eQpDT05GSUdfQ1JZUFRPX0FVVEhFTkM9bQojIENPTkZJR19DUllQVE9fVEVTVCBp
cyBub3Qgc2V0CkNPTkZJR19DUllQVE9fU0lNRD15CkNPTkZJR19DUllQVE9fRU5HSU5FPW0K
IyBlbmQgb2YgQ3J5cHRvIGNvcmUgb3IgaGVscGVyCgojCiMgUHVibGljLWtleSBjcnlwdG9n
cmFwaHkKIwpDT05GSUdfQ1JZUFRPX1JTQT15CkNPTkZJR19DUllQVE9fREg9eQojIENPTkZJ
R19DUllQVE9fREhfUkZDNzkxOV9HUk9VUFMgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0VD
Qz1tCkNPTkZJR19DUllQVE9fRUNESD1tCiMgQ09ORklHX0NSWVBUT19FQ0RTQSBpcyBub3Qg
c2V0CiMgQ09ORklHX0NSWVBUT19FQ1JEU0EgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9f
U00yIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0NVUlZFMjU1MTkgaXMgbm90IHNldAoj
IGVuZCBvZiBQdWJsaWMta2V5IGNyeXB0b2dyYXBoeQoKIwojIEJsb2NrIGNpcGhlcnMKIwpD
T05GSUdfQ1JZUFRPX0FFUz15CkNPTkZJR19DUllQVE9fQUVTX1RJPW0KIyBDT05GSUdfQ1JZ
UFRPX0FSSUEgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQkxPV0ZJU0ggaXMgbm90IHNl
dAojIENPTkZJR19DUllQVE9fQ0FNRUxMSUEgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0NB
U1RfQ09NTU9OPW0KQ09ORklHX0NSWVBUT19DQVNUNT1tCkNPTkZJR19DUllQVE9fQ0FTVDY9
bQojIENPTkZJR19DUllQVE9fREVTIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19GQ1JZUFQ9
bQpDT05GSUdfQ1JZUFRPX1NFUlBFTlQ9eQpDT05GSUdfQ1JZUFRPX1NNND1tCiMgQ09ORklH
X0NSWVBUT19TTTRfR0VORVJJQyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19UV09GSVNI
IGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19UV09GSVNIX0NPTU1PTj1tCiMgZW5kIG9mIEJs
b2NrIGNpcGhlcnMKCiMKIyBMZW5ndGgtcHJlc2VydmluZyBjaXBoZXJzIGFuZCBtb2Rlcwoj
CiMgQ09ORklHX0NSWVBUT19BRElBTlRVTSBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fQ0hB
Q0hBMjA9bQpDT05GSUdfQ1JZUFRPX0NCQz15CkNPTkZJR19DUllQVE9fQ0ZCPW0KQ09ORklH
X0NSWVBUT19DVFI9eQojIENPTkZJR19DUllQVE9fQ1RTIGlzIG5vdCBzZXQKQ09ORklHX0NS
WVBUT19FQ0I9bQojIENPTkZJR19DUllQVE9fSENUUjIgaXMgbm90IHNldAojIENPTkZJR19D
UllQVE9fS0VZV1JBUCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19MUlcgaXMgbm90IHNl
dAojIENPTkZJR19DUllQVE9fT0ZCIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19QQ0JDPW0K
Q09ORklHX0NSWVBUT19YVFM9bQojIGVuZCBvZiBMZW5ndGgtcHJlc2VydmluZyBjaXBoZXJz
IGFuZCBtb2RlcwoKIwojIEFFQUQgKGF1dGhlbnRpY2F0ZWQgZW5jcnlwdGlvbiB3aXRoIGFz
c29jaWF0ZWQgZGF0YSkgY2lwaGVycwojCiMgQ09ORklHX0NSWVBUT19BRUdJUzEyOCBpcyBu
b3Qgc2V0CkNPTkZJR19DUllQVE9fQ0hBQ0hBMjBQT0xZMTMwNT1tCkNPTkZJR19DUllQVE9f
Q0NNPW0KQ09ORklHX0NSWVBUT19HQ009eQpDT05GSUdfQ1JZUFRPX1NFUUlWPXkKQ09ORklH
X0NSWVBUT19FQ0hBSU5JVj1tCkNPTkZJR19DUllQVE9fRVNTSVY9bQojIGVuZCBvZiBBRUFE
IChhdXRoZW50aWNhdGVkIGVuY3J5cHRpb24gd2l0aCBhc3NvY2lhdGVkIGRhdGEpIGNpcGhl
cnMKCiMKIyBIYXNoZXMsIGRpZ2VzdHMsIGFuZCBNQUNzCiMKQ09ORklHX0NSWVBUT19CTEFL
RTJCPW0KQ09ORklHX0NSWVBUT19DTUFDPW0KQ09ORklHX0NSWVBUT19HSEFTSD15CkNPTkZJ
R19DUllQVE9fSE1BQz15CiMgQ09ORklHX0NSWVBUT19NRDQgaXMgbm90IHNldApDT05GSUdf
Q1JZUFRPX01ENT15CiMgQ09ORklHX0NSWVBUT19NSUNIQUVMX01JQyBpcyBub3Qgc2V0CkNP
TkZJR19DUllQVE9fUE9MWTEzMDU9bQojIENPTkZJR19DUllQVE9fUk1EMTYwIGlzIG5vdCBz
ZXQKQ09ORklHX0NSWVBUT19TSEExPXkKQ09ORklHX0NSWVBUT19TSEEyNTY9eQpDT05GSUdf
Q1JZUFRPX1NIQTUxMj15CkNPTkZJR19DUllQVE9fU0hBMz1tCiMgQ09ORklHX0NSWVBUT19T
TTNfR0VORVJJQyBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fU1RSRUVCT0c9bQojIENPTkZJ
R19DUllQVE9fVk1BQyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19XUDUxMiBpcyBub3Qg
c2V0CiMgQ09ORklHX0NSWVBUT19YQ0JDIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19YWEhB
U0g9bQojIGVuZCBvZiBIYXNoZXMsIGRpZ2VzdHMsIGFuZCBNQUNzCgojCiMgQ1JDcyAoY3lj
bGljIHJlZHVuZGFuY3kgY2hlY2tzKQojCkNPTkZJR19DUllQVE9fQ1JDMzJDPXkKQ09ORklH
X0NSWVBUT19DUkMzMj1tCkNPTkZJR19DUllQVE9fQ1JDVDEwRElGPXkKQ09ORklHX0NSWVBU
T19DUkM2NF9ST0NLU09GVD15CiMgZW5kIG9mIENSQ3MgKGN5Y2xpYyByZWR1bmRhbmN5IGNo
ZWNrcykKCiMKIyBDb21wcmVzc2lvbgojCkNPTkZJR19DUllQVE9fREVGTEFURT15CkNPTkZJ
R19DUllQVE9fTFpPPXkKQ09ORklHX0NSWVBUT184NDI9bQpDT05GSUdfQ1JZUFRPX0xaND1t
CkNPTkZJR19DUllQVE9fTFo0SEM9bQpDT05GSUdfQ1JZUFRPX1pTVEQ9bQojIGVuZCBvZiBD
b21wcmVzc2lvbgoKIwojIFJhbmRvbSBudW1iZXIgZ2VuZXJhdGlvbgojCkNPTkZJR19DUllQ
VE9fQU5TSV9DUFJORz1tCkNPTkZJR19DUllQVE9fRFJCR19NRU5VPXkKQ09ORklHX0NSWVBU
T19EUkJHX0hNQUM9eQpDT05GSUdfQ1JZUFRPX0RSQkdfSEFTSD15CkNPTkZJR19DUllQVE9f
RFJCR19DVFI9eQpDT05GSUdfQ1JZUFRPX0RSQkc9eQpDT05GSUdfQ1JZUFRPX0pJVFRFUkVO
VFJPUFk9eQojIGVuZCBvZiBSYW5kb20gbnVtYmVyIGdlbmVyYXRpb24KCiMKIyBVc2Vyc3Bh
Y2UgaW50ZXJmYWNlCiMKQ09ORklHX0NSWVBUT19VU0VSX0FQST1tCkNPTkZJR19DUllQVE9f
VVNFUl9BUElfSEFTSD1tCkNPTkZJR19DUllQVE9fVVNFUl9BUElfU0tDSVBIRVI9bQpDT05G
SUdfQ1JZUFRPX1VTRVJfQVBJX1JORz1tCiMgQ09ORklHX0NSWVBUT19VU0VSX0FQSV9STkdf
Q0FWUCBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fVVNFUl9BUElfQUVBRD1tCiMgQ09ORklH
X0NSWVBUT19VU0VSX0FQSV9FTkFCTEVfT0JTT0xFVEUgaXMgbm90IHNldApDT05GSUdfQ1JZ
UFRPX1NUQVRTPXkKIyBlbmQgb2YgVXNlcnNwYWNlIGludGVyZmFjZQoKQ09ORklHX0NSWVBU
T19IQVNIX0lORk89eQoKIwojIEFjY2VsZXJhdGVkIENyeXB0b2dyYXBoaWMgQWxnb3JpdGht
cyBmb3IgQ1BVICh4ODYpCiMKIyBDT05GSUdfQ1JZUFRPX0NVUlZFMjU1MTlfWDg2IGlzIG5v
dCBzZXQKQ09ORklHX0NSWVBUT19BRVNfTklfSU5URUw9bQojIENPTkZJR19DUllQVE9fQkxP
V0ZJU0hfWDg2XzY0IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0NBTUVMTElBX1g4Nl82
NCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19DQU1FTExJQV9BRVNOSV9BVlhfWDg2XzY0
IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0NBTUVMTElBX0FFU05JX0FWWDJfWDg2XzY0
IGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19DQVNUNV9BVlhfWDg2XzY0PW0KIyBDT05GSUdf
Q1JZUFRPX0NBU1Q2X0FWWF9YODZfNjQgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fREVT
M19FREVfWDg2XzY0IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1NFUlBFTlRfU1NFMl9Y
ODZfNjQgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX1NFUlBFTlRfQVZYX1g4Nl82ND15CkNP
TkZJR19DUllQVE9fU0VSUEVOVF9BVlgyX1g4Nl82ND15CkNPTkZJR19DUllQVE9fU000X0FF
U05JX0FWWF9YODZfNjQ9bQojIENPTkZJR19DUllQVE9fU000X0FFU05JX0FWWDJfWDg2XzY0
IGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19UV09GSVNIX1g4Nl82ND1tCkNPTkZJR19DUllQ
VE9fVFdPRklTSF9YODZfNjRfM1dBWT1tCkNPTkZJR19DUllQVE9fVFdPRklTSF9BVlhfWDg2
XzY0PW0KIyBDT05GSUdfQ1JZUFRPX0FSSUFfQUVTTklfQVZYX1g4Nl82NCBpcyBub3Qgc2V0
CiMgQ09ORklHX0NSWVBUT19DSEFDSEEyMF9YODZfNjQgaXMgbm90IHNldAojIENPTkZJR19D
UllQVE9fQUVHSVMxMjhfQUVTTklfU1NFMiBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19O
SFBPTFkxMzA1X1NTRTIgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fTkhQT0xZMTMwNV9B
VlgyIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19CTEFLRTJTX1g4Nj15CiMgQ09ORklHX0NS
WVBUT19QT0xZVkFMX0NMTVVMX05JIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1BPTFkx
MzA1X1g4Nl82NCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19TSEExX1NTU0UzIGlzIG5v
dCBzZXQKIyBDT05GSUdfQ1JZUFRPX1NIQTI1Nl9TU1NFMyBpcyBub3Qgc2V0CiMgQ09ORklH
X0NSWVBUT19TSEE1MTJfU1NTRTMgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fU00zX0FW
WF9YODZfNjQgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fR0hBU0hfQ0xNVUxfTklfSU5U
RUwgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0NSQzMyQ19JTlRFTD1tCiMgQ09ORklHX0NS
WVBUT19DUkMzMl9QQ0xNVUwgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQ1JDVDEwRElG
X1BDTE1VTCBpcyBub3Qgc2V0CiMgZW5kIG9mIEFjY2VsZXJhdGVkIENyeXB0b2dyYXBoaWMg
QWxnb3JpdGhtcyBmb3IgQ1BVICh4ODYpCgpDT05GSUdfQ1JZUFRPX0hXPXkKQ09ORklHX0NS
WVBUT19ERVZfUEFETE9DSz15CkNPTkZJR19DUllQVE9fREVWX1BBRExPQ0tfQUVTPW0KQ09O
RklHX0NSWVBUT19ERVZfUEFETE9DS19TSEE9bQpDT05GSUdfQ1JZUFRPX0RFVl9BVE1FTF9J
MkM9bQpDT05GSUdfQ1JZUFRPX0RFVl9BVE1FTF9FQ0M9bQpDT05GSUdfQ1JZUFRPX0RFVl9B
VE1FTF9TSEEyMDRBPW0KQ09ORklHX0NSWVBUT19ERVZfQ0NQPXkKQ09ORklHX0NSWVBUT19E
RVZfQ0NQX0REPW0KQ09ORklHX0NSWVBUT19ERVZfU1BfQ0NQPXkKQ09ORklHX0NSWVBUT19E
RVZfQ0NQX0NSWVBUTz1tCkNPTkZJR19DUllQVE9fREVWX1NQX1BTUD15CiMgQ09ORklHX0NS
WVBUT19ERVZfQ0NQX0RFQlVHRlMgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0RFVl9RQVQ9
bQpDT05GSUdfQ1JZUFRPX0RFVl9RQVRfREg4OTV4Q0M9bQpDT05GSUdfQ1JZUFRPX0RFVl9R
QVRfQzNYWFg9bQpDT05GSUdfQ1JZUFRPX0RFVl9RQVRfQzYyWD1tCkNPTkZJR19DUllQVE9f
REVWX1FBVF80WFhYPW0KQ09ORklHX0NSWVBUT19ERVZfUUFUX0RIODk1eENDVkY9bQpDT05G
SUdfQ1JZUFRPX0RFVl9RQVRfQzNYWFhWRj1tCkNPTkZJR19DUllQVE9fREVWX1FBVF9DNjJY
VkY9bQpDT05GSUdfQ1JZUFRPX0RFVl9OSVRST1g9bQpDT05GSUdfQ1JZUFRPX0RFVl9OSVRS
T1hfQ05ONTVYWD1tCkNPTkZJR19DUllQVE9fREVWX0NIRUxTSU89bQpDT05GSUdfQ1JZUFRP
X0RFVl9TQUZFWENFTD1tCkNPTkZJR19DUllQVE9fREVWX0FNTE9HSUNfR1hMPW0KIyBDT05G
SUdfQ1JZUFRPX0RFVl9BTUxPR0lDX0dYTF9ERUJVRyBpcyBub3Qgc2V0CkNPTkZJR19BU1lN
TUVUUklDX0tFWV9UWVBFPXkKQ09ORklHX0FTWU1NRVRSSUNfUFVCTElDX0tFWV9TVUJUWVBF
PXkKQ09ORklHX1g1MDlfQ0VSVElGSUNBVEVfUEFSU0VSPXkKQ09ORklHX1BLQ1M4X1BSSVZB
VEVfS0VZX1BBUlNFUj1tCkNPTkZJR19QS0NTN19NRVNTQUdFX1BBUlNFUj15CkNPTkZJR19Q
S0NTN19URVNUX0tFWT1tCkNPTkZJR19TSUdORURfUEVfRklMRV9WRVJJRklDQVRJT049eQoj
IENPTkZJR19GSVBTX1NJR05BVFVSRV9TRUxGVEVTVCBpcyBub3Qgc2V0CgojCiMgQ2VydGlm
aWNhdGVzIGZvciBzaWduYXR1cmUgY2hlY2tpbmcKIwpDT05GSUdfTU9EVUxFX1NJR19LRVk9
ImNlcnRzL3NpZ25pbmdfa2V5LnBlbSIKQ09ORklHX01PRFVMRV9TSUdfS0VZX1RZUEVfUlNB
PXkKIyBDT05GSUdfTU9EVUxFX1NJR19LRVlfVFlQRV9FQ0RTQSBpcyBub3Qgc2V0CkNPTkZJ
R19TWVNURU1fVFJVU1RFRF9LRVlSSU5HPXkKQ09ORklHX1NZU1RFTV9UUlVTVEVEX0tFWVM9
IiIKQ09ORklHX1NZU1RFTV9FWFRSQV9DRVJUSUZJQ0FURT15CkNPTkZJR19TWVNURU1fRVhU
UkFfQ0VSVElGSUNBVEVfU0laRT00MDk2CkNPTkZJR19TRUNPTkRBUllfVFJVU1RFRF9LRVlS
SU5HPXkKQ09ORklHX1NZU1RFTV9CTEFDS0xJU1RfS0VZUklORz15CkNPTkZJR19TWVNURU1f
QkxBQ0tMSVNUX0hBU0hfTElTVD0iIgpDT05GSUdfU1lTVEVNX1JFVk9DQVRJT05fTElTVD15
CkNPTkZJR19TWVNURU1fUkVWT0NBVElPTl9LRVlTPSIiCiMgQ09ORklHX1NZU1RFTV9CTEFD
S0xJU1RfQVVUSF9VUERBVEUgaXMgbm90IHNldAojIGVuZCBvZiBDZXJ0aWZpY2F0ZXMgZm9y
IHNpZ25hdHVyZSBjaGVja2luZwoKQ09ORklHX0JJTkFSWV9QUklOVEY9eQoKIwojIExpYnJh
cnkgcm91dGluZXMKIwpDT05GSUdfUkFJRDZfUFE9bQpDT05GSUdfUkFJRDZfUFFfQkVOQ0hN
QVJLPXkKIyBDT05GSUdfUEFDS0lORyBpcyBub3Qgc2V0CkNPTkZJR19CSVRSRVZFUlNFPXkK
Q09ORklHX0dFTkVSSUNfU1RSTkNQWV9GUk9NX1VTRVI9eQpDT05GSUdfR0VORVJJQ19TVFJO
TEVOX1VTRVI9eQpDT05GSUdfR0VORVJJQ19ORVRfVVRJTFM9eQojIENPTkZJR19DT1JESUMg
aXMgbm90IHNldAojIENPTkZJR19QUklNRV9OVU1CRVJTIGlzIG5vdCBzZXQKQ09ORklHX1JB
VElPTkFMPXkKQ09ORklHX0dFTkVSSUNfUENJX0lPTUFQPXkKQ09ORklHX0dFTkVSSUNfSU9N
QVA9eQpDT05GSUdfQVJDSF9VU0VfQ01QWENIR19MT0NLUkVGPXkKQ09ORklHX0FSQ0hfSEFT
X0ZBU1RfTVVMVElQTElFUj15CkNPTkZJR19BUkNIX1VTRV9TWU1fQU5OT1RBVElPTlM9eQoK
IwojIENyeXB0byBsaWJyYXJ5IHJvdXRpbmVzCiMKQ09ORklHX0NSWVBUT19MSUJfVVRJTFM9
eQpDT05GSUdfQ1JZUFRPX0xJQl9BRVM9eQpDT05GSUdfQ1JZUFRPX0FSQ0hfSEFWRV9MSUJf
QkxBS0UyUz15CkNPTkZJR19DUllQVE9fTElCX0JMQUtFMlNfR0VORVJJQz15CkNPTkZJR19D
UllQVE9fTElCX0NIQUNIQV9HRU5FUklDPW0KQ09ORklHX0NSWVBUT19MSUJfQ0hBQ0hBPW0K
Q09ORklHX0NSWVBUT19MSUJfQ1VSVkUyNTUxOV9HRU5FUklDPW0KQ09ORklHX0NSWVBUT19M
SUJfQ1VSVkUyNTUxOT1tCkNPTkZJR19DUllQVE9fTElCX0RFUz1tCkNPTkZJR19DUllQVE9f
TElCX1BPTFkxMzA1X1JTSVpFPTExCkNPTkZJR19DUllQVE9fTElCX1BPTFkxMzA1X0dFTkVS
SUM9bQpDT05GSUdfQ1JZUFRPX0xJQl9QT0xZMTMwNT1tCkNPTkZJR19DUllQVE9fTElCX0NI
QUNIQTIwUE9MWTEzMDU9bQpDT05GSUdfQ1JZUFRPX0xJQl9TSEExPXkKQ09ORklHX0NSWVBU
T19MSUJfU0hBMjU2PXkKIyBlbmQgb2YgQ3J5cHRvIGxpYnJhcnkgcm91dGluZXMKCkNPTkZJ
R19DUkNfQ0NJVFQ9eQpDT05GSUdfQ1JDMTY9eQpDT05GSUdfQ1JDX1QxMERJRj15CkNPTkZJ
R19DUkM2NF9ST0NLU09GVD15CkNPTkZJR19DUkNfSVRVX1Q9bQpDT05GSUdfQ1JDMzI9eQoj
IENPTkZJR19DUkMzMl9TRUxGVEVTVCBpcyBub3Qgc2V0CkNPTkZJR19DUkMzMl9TTElDRUJZ
OD15CiMgQ09ORklHX0NSQzMyX1NMSUNFQlk0IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JDMzJf
U0FSV0FURSBpcyBub3Qgc2V0CiMgQ09ORklHX0NSQzMyX0JJVCBpcyBub3Qgc2V0CkNPTkZJ
R19DUkM2ND15CiMgQ09ORklHX0NSQzQgaXMgbm90IHNldAojIENPTkZJR19DUkM3IGlzIG5v
dCBzZXQKQ09ORklHX0xJQkNSQzMyQz1tCkNPTkZJR19DUkM4PW0KQ09ORklHX1hYSEFTSD15
CiMgQ09ORklHX1JBTkRPTTMyX1NFTEZURVNUIGlzIG5vdCBzZXQKQ09ORklHXzg0Ml9DT01Q
UkVTUz1tCkNPTkZJR184NDJfREVDT01QUkVTUz1tCkNPTkZJR19aTElCX0lORkxBVEU9eQpD
T05GSUdfWkxJQl9ERUZMQVRFPXkKQ09ORklHX0xaT19DT01QUkVTUz15CkNPTkZJR19MWk9f
REVDT01QUkVTUz15CkNPTkZJR19MWjRfQ09NUFJFU1M9bQpDT05GSUdfTFo0SENfQ09NUFJF
U1M9bQpDT05GSUdfTFo0X0RFQ09NUFJFU1M9eQpDT05GSUdfWlNURF9DT01NT049eQpDT05G
SUdfWlNURF9DT01QUkVTUz1tCkNPTkZJR19aU1REX0RFQ09NUFJFU1M9eQpDT05GSUdfWFpf
REVDPXkKQ09ORklHX1haX0RFQ19YODY9eQpDT05GSUdfWFpfREVDX1BPV0VSUEM9eQpDT05G
SUdfWFpfREVDX0lBNjQ9eQpDT05GSUdfWFpfREVDX0FSTT15CkNPTkZJR19YWl9ERUNfQVJN
VEhVTUI9eQpDT05GSUdfWFpfREVDX1NQQVJDPXkKQ09ORklHX1haX0RFQ19NSUNST0xaTUE9
eQpDT05GSUdfWFpfREVDX0JDSj15CkNPTkZJR19YWl9ERUNfVEVTVD1tCkNPTkZJR19ERUNP
TVBSRVNTX0xaND15CkNPTkZJR19ERUNPTVBSRVNTX1pTVEQ9eQpDT05GSUdfR0VORVJJQ19B
TExPQ0FUT1I9eQpDT05GSUdfUkVFRF9TT0xPTU9OPW0KQ09ORklHX1JFRURfU09MT01PTl9F
TkM4PXkKQ09ORklHX1JFRURfU09MT01PTl9ERUM4PXkKQ09ORklHX0lOVEVSVkFMX1RSRUU9
eQpDT05GSUdfWEFSUkFZX01VTFRJPXkKQ09ORklHX0FTU09DSUFUSVZFX0FSUkFZPXkKQ09O
RklHX0hBU19JT01FTT15CkNPTkZJR19IQVNfSU9QT1JUX01BUD15CkNPTkZJR19IQVNfRE1B
PXkKQ09ORklHX0RNQV9PUFM9eQpDT05GSUdfTkVFRF9TR19ETUFfTEVOR1RIPXkKQ09ORklH
X05FRURfRE1BX01BUF9TVEFURT15CkNPTkZJR19BUkNIX0RNQV9BRERSX1RfNjRCSVQ9eQpD
T05GSUdfU1dJT1RMQj15CiMgQ09ORklHX0RNQV9BUElfREVCVUcgaXMgbm90IHNldAojIENP
TkZJR19ETUFfTUFQX0JFTkNITUFSSyBpcyBub3Qgc2V0CkNPTkZJR19TR0xfQUxMT0M9eQoj
IENPTkZJR19GT1JDRV9OUl9DUFVTIGlzIG5vdCBzZXQKQ09ORklHX0NQVV9STUFQPXkKQ09O
RklHX0RRTD15CkNPTkZJR19HTE9CPXkKIyBDT05GSUdfR0xPQl9TRUxGVEVTVCBpcyBub3Qg
c2V0CkNPTkZJR19OTEFUVFI9eQpDT05GSUdfQ0xaX1RBQj15CkNPTkZJR19JUlFfUE9MTD15
CkNPTkZJR19NUElMSUI9eQpDT05GSUdfT0lEX1JFR0lTVFJZPXkKQ09ORklHX1VDUzJfU1RS
SU5HPXkKQ09ORklHX0hBVkVfR0VORVJJQ19WRFNPPXkKQ09ORklHX0dFTkVSSUNfR0VUVElN
RU9GREFZPXkKQ09ORklHX0dFTkVSSUNfVkRTT19USU1FX05TPXkKQ09ORklHX0ZPTlRfU1VQ
UE9SVD15CkNPTkZJR19GT05UUz15CkNPTkZJR19GT05UXzh4OD15CkNPTkZJR19GT05UXzh4
MTY9eQojIENPTkZJR19GT05UXzZ4MTEgaXMgbm90IHNldAojIENPTkZJR19GT05UXzd4MTQg
aXMgbm90IHNldAojIENPTkZJR19GT05UX1BFQVJMXzh4OCBpcyBub3Qgc2V0CkNPTkZJR19G
T05UX0FDT1JOXzh4OD15CiMgQ09ORklHX0ZPTlRfTUlOSV80eDYgaXMgbm90IHNldApDT05G
SUdfRk9OVF82eDEwPXkKIyBDT05GSUdfRk9OVF8xMHgxOCBpcyBub3Qgc2V0CiMgQ09ORklH
X0ZPTlRfU1VOOHgxNiBpcyBub3Qgc2V0CiMgQ09ORklHX0ZPTlRfU1VOMTJ4MjIgaXMgbm90
IHNldApDT05GSUdfRk9OVF9URVIxNngzMj15CiMgQ09ORklHX0ZPTlRfNng4IGlzIG5vdCBz
ZXQKQ09ORklHX1NHX1BPT0w9eQpDT05GSUdfQVJDSF9IQVNfUE1FTV9BUEk9eQpDT05GSUdf
TUVNUkVHSU9OPXkKQ09ORklHX0FSQ0hfSEFTX1VBQ0NFU1NfRkxVU0hDQUNIRT15CkNPTkZJ
R19BUkNIX0hBU19DT1BZX01DPXkKQ09ORklHX0FSQ0hfU1RBQ0tXQUxLPXkKQ09ORklHX1NU
QUNLREVQT1Q9eQpDT05GSUdfU0JJVE1BUD15CiMgZW5kIG9mIExpYnJhcnkgcm91dGluZXMK
CiMKIyBLZXJuZWwgaGFja2luZwojCgojCiMgcHJpbnRrIGFuZCBkbWVzZyBvcHRpb25zCiMK
Q09ORklHX1BSSU5US19USU1FPXkKIyBDT05GSUdfUFJJTlRLX0NBTExFUiBpcyBub3Qgc2V0
CiMgQ09ORklHX1NUQUNLVFJBQ0VfQlVJTERfSUQgaXMgbm90IHNldApDT05GSUdfQ09OU09M
RV9MT0dMRVZFTF9ERUZBVUxUPTcKQ09ORklHX0NPTlNPTEVfTE9HTEVWRUxfUVVJRVQ9NApD
T05GSUdfTUVTU0FHRV9MT0dMRVZFTF9ERUZBVUxUPTQKQ09ORklHX0RZTkFNSUNfREVCVUc9
eQpDT05GSUdfRFlOQU1JQ19ERUJVR19DT1JFPXkKQ09ORklHX1NZTUJPTElDX0VSUk5BTUU9
eQpDT05GSUdfREVCVUdfQlVHVkVSQk9TRT15CiMgZW5kIG9mIHByaW50ayBhbmQgZG1lc2cg
b3B0aW9ucwoKIyBDT05GSUdfREVCVUdfS0VSTkVMIGlzIG5vdCBzZXQKCiMKIyBDb21waWxl
LXRpbWUgY2hlY2tzIGFuZCBjb21waWxlciBvcHRpb25zCiMKQ09ORklHX0FTX0hBU19OT05f
Q09OU1RfTEVCMTI4PXkKQ09ORklHX0ZSQU1FX1dBUk49MTAyNAojIENPTkZJR19TVFJJUF9B
U01fU1lNUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hFQURFUlNfSU5TVEFMTCBpcyBub3Qgc2V0
CiMgQ09ORklHX0RFQlVHX1NFQ1RJT05fTUlTTUFUQ0ggaXMgbm90IHNldApDT05GSUdfU0VD
VElPTl9NSVNNQVRDSF9XQVJOX09OTFk9eQpDT05GSUdfT0JKVE9PTD15CiMgZW5kIG9mIENv
bXBpbGUtdGltZSBjaGVja3MgYW5kIGNvbXBpbGVyIG9wdGlvbnMKCiMKIyBHZW5lcmljIEtl
cm5lbCBEZWJ1Z2dpbmcgSW5zdHJ1bWVudHMKIwpDT05GSUdfTUFHSUNfU1lTUlE9eQpDT05G
SUdfTUFHSUNfU1lTUlFfREVGQVVMVF9FTkFCTEU9MHgwMWI2CkNPTkZJR19NQUdJQ19TWVNS
UV9TRVJJQUw9eQpDT05GSUdfTUFHSUNfU1lTUlFfU0VSSUFMX1NFUVVFTkNFPSIiCkNPTkZJ
R19ERUJVR19GUz15CkNPTkZJR19ERUJVR19GU19BTExPV19BTEw9eQojIENPTkZJR19ERUJV
R19GU19ESVNBTExPV19NT1VOVCBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0ZTX0FMTE9X
X05PTkUgaXMgbm90IHNldApDT05GSUdfSEFWRV9BUkNIX0tHREI9eQpDT05GSUdfQVJDSF9I
QVNfVUJTQU5fU0FOSVRJWkVfQUxMPXkKQ09ORklHX1VCU0FOPXkKIyBDT05GSUdfVUJTQU5f
VFJBUCBpcyBub3Qgc2V0CkNPTkZJR19DQ19IQVNfVUJTQU5fQk9VTkRTPXkKQ09ORklHX1VC
U0FOX0JPVU5EUz15CkNPTkZJR19VQlNBTl9PTkxZX0JPVU5EUz15CkNPTkZJR19VQlNBTl9T
SElGVD15CiMgQ09ORklHX1VCU0FOX0RJVl9aRVJPIGlzIG5vdCBzZXQKQ09ORklHX1VCU0FO
X0JPT0w9eQpDT05GSUdfVUJTQU5fRU5VTT15CiMgQ09ORklHX1VCU0FOX0FMSUdOTUVOVCBp
cyBub3Qgc2V0CkNPTkZJR19VQlNBTl9TQU5JVElaRV9BTEw9eQojIENPTkZJR19URVNUX1VC
U0FOIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfQVJDSF9LQ1NBTj15CkNPTkZJR19IQVZFX0tD
U0FOX0NPTVBJTEVSPXkKIyBlbmQgb2YgR2VuZXJpYyBLZXJuZWwgRGVidWdnaW5nIEluc3Ry
dW1lbnRzCgojCiMgTmV0d29ya2luZyBEZWJ1Z2dpbmcKIwojIGVuZCBvZiBOZXR3b3JraW5n
IERlYnVnZ2luZwoKIwojIE1lbW9yeSBEZWJ1Z2dpbmcKIwojIENPTkZJR19QQUdFX0VYVEVO
U0lPTiBpcyBub3Qgc2V0CkNPTkZJR19TTFVCX0RFQlVHPXkKIyBDT05GSUdfU0xVQl9ERUJV
R19PTiBpcyBub3Qgc2V0CiMgQ09ORklHX1BBR0VfVEFCTEVfQ0hFQ0sgaXMgbm90IHNldApD
T05GSUdfUEFHRV9QT0lTT05JTkc9eQojIENPTkZJR19ERUJVR19ST0RBVEFfVEVTVCBpcyBu
b3Qgc2V0CkNPTkZJR19BUkNIX0hBU19ERUJVR19XWD15CkNPTkZJR19ERUJVR19XWD15CkNP
TkZJR19HRU5FUklDX1BURFVNUD15CkNPTkZJR19QVERVTVBfQ09SRT15CiMgQ09ORklHX1NI
UklOS0VSX0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfREVCVUdfS01FTUxFQUs9eQpD
T05GSUdfQVJDSF9IQVNfREVCVUdfVk1fUEdUQUJMRT15CiMgQ09ORklHX0RFQlVHX1ZNX1BH
VEFCTEUgaXMgbm90IHNldApDT05GSUdfQVJDSF9IQVNfREVCVUdfVklSVFVBTD15CkNPTkZJ
R19ERUJVR19NRU1PUllfSU5JVD15CkNPTkZJR19BUkNIX1NVUFBPUlRTX0tNQVBfTE9DQUxf
Rk9SQ0VfTUFQPXkKQ09ORklHX0hBVkVfQVJDSF9LQVNBTj15CkNPTkZJR19IQVZFX0FSQ0hf
S0FTQU5fVk1BTExPQz15CkNPTkZJR19DQ19IQVNfS0FTQU5fR0VORVJJQz15CkNPTkZJR19D
Q19IQVNfV09SS0lOR19OT1NBTklUSVpFX0FERFJFU1M9eQojIENPTkZJR19LQVNBTiBpcyBu
b3Qgc2V0CkNPTkZJR19IQVZFX0FSQ0hfS0ZFTkNFPXkKQ09ORklHX0tGRU5DRT15CkNPTkZJ
R19LRkVOQ0VfU0FNUExFX0lOVEVSVkFMPTAKQ09ORklHX0tGRU5DRV9OVU1fT0JKRUNUUz0y
NTUKIyBDT05GSUdfS0ZFTkNFX0RFRkVSUkFCTEUgaXMgbm90IHNldApDT05GSUdfS0ZFTkNF
X1NUUkVTU19URVNUX0ZBVUxUUz0wCkNPTkZJR19IQVZFX0FSQ0hfS01TQU49eQojIGVuZCBv
ZiBNZW1vcnkgRGVidWdnaW5nCgojCiMgRGVidWcgT29wcywgTG9ja3VwcyBhbmQgSGFuZ3MK
IwojIENPTkZJR19QQU5JQ19PTl9PT1BTIGlzIG5vdCBzZXQKQ09ORklHX1BBTklDX09OX09P
UFNfVkFMVUU9MApDT05GSUdfUEFOSUNfVElNRU9VVD0wCkNPTkZJR19IQVJETE9DS1VQX0NI
RUNLX1RJTUVTVEFNUD15CiMgQ09ORklHX1RFU1RfTE9DS1VQIGlzIG5vdCBzZXQKIyBlbmQg
b2YgRGVidWcgT29wcywgTG9ja3VwcyBhbmQgSGFuZ3MKCiMKIyBTY2hlZHVsZXIgRGVidWdn
aW5nCiMKQ09ORklHX1NDSEVEX0lORk89eQojIGVuZCBvZiBTY2hlZHVsZXIgRGVidWdnaW5n
CgojIENPTkZJR19ERUJVR19USU1FS0VFUElORyBpcyBub3Qgc2V0CgojCiMgTG9jayBEZWJ1
Z2dpbmcgKHNwaW5sb2NrcywgbXV0ZXhlcywgZXRjLi4uKQojCkNPTkZJR19MT0NLX0RFQlVH
R0lOR19TVVBQT1JUPXkKIyBDT05GSUdfV1dfTVVURVhfU0VMRlRFU1QgaXMgbm90IHNldAoj
IGVuZCBvZiBMb2NrIERlYnVnZ2luZyAoc3BpbmxvY2tzLCBtdXRleGVzLCBldGMuLi4pCgoj
IENPTkZJR19ERUJVR19JUlFGTEFHUyBpcyBub3Qgc2V0CkNPTkZJR19TVEFDS1RSQUNFPXkK
IyBDT05GSUdfV0FSTl9BTExfVU5TRUVERURfUkFORE9NIGlzIG5vdCBzZXQKCiMKIyBEZWJ1
ZyBrZXJuZWwgZGF0YSBzdHJ1Y3R1cmVzCiMKIyBDT05GSUdfQlVHX09OX0RBVEFfQ09SUlVQ
VElPTiBpcyBub3Qgc2V0CiMgZW5kIG9mIERlYnVnIGtlcm5lbCBkYXRhIHN0cnVjdHVyZXMK
CiMKIyBSQ1UgRGVidWdnaW5nCiMKQ09ORklHX1JDVV9DUFVfU1RBTExfVElNRU9VVD02MApD
T05GSUdfUkNVX0VYUF9DUFVfU1RBTExfVElNRU9VVD0wCiMgZW5kIG9mIFJDVSBEZWJ1Z2dp
bmcKCkNPTkZJR19VU0VSX1NUQUNLVFJBQ0VfU1VQUE9SVD15CkNPTkZJR19IQVZFX1JFVEhP
T0s9eQpDT05GSUdfUkVUSE9PSz15CkNPTkZJR19IQVZFX0ZVTkNUSU9OX1RSQUNFUj15CkNP
TkZJR19IQVZFX0RZTkFNSUNfRlRSQUNFPXkKQ09ORklHX0hBVkVfRFlOQU1JQ19GVFJBQ0Vf
V0lUSF9SRUdTPXkKQ09ORklHX0hBVkVfRFlOQU1JQ19GVFJBQ0VfV0lUSF9ESVJFQ1RfQ0FM
TFM9eQpDT05GSUdfSEFWRV9EWU5BTUlDX0ZUUkFDRV9XSVRIX0FSR1M9eQpDT05GSUdfSEFW
RV9EWU5BTUlDX0ZUUkFDRV9OT19QQVRDSEFCTEU9eQpDT05GSUdfSEFWRV9GVFJBQ0VfTUNP
VU5UX1JFQ09SRD15CkNPTkZJR19IQVZFX1NZU0NBTExfVFJBQ0VQT0lOVFM9eQpDT05GSUdf
SEFWRV9GRU5UUlk9eQpDT05GSUdfSEFWRV9PQkpUT09MX01DT1VOVD15CkNPTkZJR19IQVZF
X0NfUkVDT1JETUNPVU5UPXkKQ09ORklHX0hBVkVfQlVJTERUSU1FX01DT1VOVF9TT1JUPXkK
Q09ORklHX1RSQUNJTkdfU1VQUE9SVD15CiMgQ09ORklHX0ZUUkFDRSBpcyBub3Qgc2V0CiMg
Q09ORklHX1BST1ZJREVfT0hDSTEzOTRfRE1BX0lOSVQgaXMgbm90IHNldAojIENPTkZJR19T
QU1QTEVTIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfU0FNUExFX0ZUUkFDRV9ESVJFQ1Q9eQpD
T05GSUdfSEFWRV9TQU1QTEVfRlRSQUNFX0RJUkVDVF9NVUxUST15CkNPTkZJR19BUkNIX0hB
U19ERVZNRU1fSVNfQUxMT1dFRD15CkNPTkZJR19TVFJJQ1RfREVWTUVNPXkKIyBDT05GSUdf
SU9fU1RSSUNUX0RFVk1FTSBpcyBub3Qgc2V0CgojCiMgeDg2IERlYnVnZ2luZwojCiMgQ09O
RklHX1g4Nl9WRVJCT1NFX0JPT1RVUCBpcyBub3Qgc2V0CkNPTkZJR19FQVJMWV9QUklOVEs9
eQojIENPTkZJR19FQVJMWV9QUklOVEtfREJHUCBpcyBub3Qgc2V0CiMgQ09ORklHX0VBUkxZ
X1BSSU5US19VU0JfWERCQyBpcyBub3Qgc2V0CiMgQ09ORklHX0VGSV9QR1RfRFVNUCBpcyBu
b3Qgc2V0CkNPTkZJR19IQVZFX01NSU9UUkFDRV9TVVBQT1JUPXkKIyBDT05GSUdfSU9fREVM
QVlfMFg4MCBpcyBub3Qgc2V0CkNPTkZJR19JT19ERUxBWV8wWEVEPXkKIyBDT05GSUdfSU9f
REVMQVlfVURFTEFZIGlzIG5vdCBzZXQKIyBDT05GSUdfSU9fREVMQVlfTk9ORSBpcyBub3Qg
c2V0CiMgQ09ORklHX1BVTklUX0FUT01fREVCVUcgaXMgbm90IHNldApDT05GSUdfVU5XSU5E
RVJfT1JDPXkKIyBDT05GSUdfVU5XSU5ERVJfRlJBTUVfUE9JTlRFUiBpcyBub3Qgc2V0CiMg
ZW5kIG9mIHg4NiBEZWJ1Z2dpbmcKCiMKIyBLZXJuZWwgVGVzdGluZyBhbmQgQ292ZXJhZ2UK
IwojIENPTkZJR19LVU5JVCBpcyBub3Qgc2V0CkNPTkZJR19GVU5DVElPTl9FUlJPUl9JTkpF
Q1RJT049eQpDT05GSUdfQVJDSF9IQVNfS0NPVj15CkNPTkZJR19DQ19IQVNfU0FOQ09WX1RS
QUNFX1BDPXkKIyBDT05GSUdfS0NPViBpcyBub3Qgc2V0CiMgQ09ORklHX1JVTlRJTUVfVEVT
VElOR19NRU5VIGlzIG5vdCBzZXQKQ09ORklHX0FSQ0hfVVNFX01FTVRFU1Q9eQojIENPTkZJ
R19NRU1URVNUIGlzIG5vdCBzZXQKIyBlbmQgb2YgS2VybmVsIFRlc3RpbmcgYW5kIENvdmVy
YWdlCgojCiMgUnVzdCBoYWNraW5nCiMKIyBlbmQgb2YgUnVzdCBoYWNraW5nCiMgZW5kIG9m
IEtlcm5lbCBoYWNraW5nCg==

--------------qYcSrBBHm10BmvZ01XJ97mIE--
