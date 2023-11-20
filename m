Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201107F2014
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjKTWTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjKTWS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:18:58 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AA5D8;
        Mon, 20 Nov 2023 14:18:53 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5bdb0be3591so3733003a12.2;
        Mon, 20 Nov 2023 14:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700518733; x=1701123533; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=I/3mtydLD/Lb2rDtzTZXuvLacuyy1JWz82TjxT8tqK0=;
        b=d5VqPkfUjYK9em0vA97Y4EwWg2p5WfmkAmKtSLYUbDdXJ9/fJbH/qxFW4YEinPHxQf
         eyPcSFbNfmoKTQly4X0PSP5N3aNDUgfdL1mgN3YiCmh5G4ic8/p1QrxsZQ6elNzRfCxh
         HrWxfrpGI4WYPHDNxV4QMgHbmZk7Xdm1S/WP3hEyi7plNUKf8AzbsZDwVnIEmOjEXeNF
         cJndfeewteshuyJyg5PKtFR09850lZdrsveg3O/k8/UUZsj8Edbf0S89korSixmqCVQ8
         9Y5Wj97b8BMeFsEyEdnjc5oAzMW0ao2rgMIZ2+tlAnUIKe6Dee4uR8IZAE+ox18kWnY5
         YK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700518733; x=1701123533;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I/3mtydLD/Lb2rDtzTZXuvLacuyy1JWz82TjxT8tqK0=;
        b=Si6EoKk4/9+g1GS2Fpd3qZSm4bsR+YI8mNG+/fABDXFdDiv5rnNbLPAVvqxa3MHysC
         xASvhurU3KUXhKRFhmpkPmAZqWMas7eIRWCBmgfMR6sQkzEZOef4ylr3uH7VEy1+JhQ4
         PJI3og5s/V+yfOBoyZ7m/WU7CamaVask3rK+swxWF+QoLFrZAy1BzY3YvO5N8vIl32lI
         syvh/UBIftJ1udGXLYwjH4m9hFjaJmt83fZaw1f0rpkgSREzaRjAfriT4GU2vdemhIEl
         ifiJPPxx8bKxmSeSlO2EBlvaNvGGm/T47QluoK4EFqtONo+hJasI4F9utZyqEEVHBO+5
         brVA==
X-Gm-Message-State: AOJu0YyksA1FrEZglL5rSBXiHd3T0zi5UadEcMPuzIC8u3//+riioMeV
        UtVbPuWP2yLKdc2M2dkdrPAvFbGp6if5Bc3p9BY=
X-Google-Smtp-Source: AGHT+IGVw69NsSUpyYBEzCPib8cMAl/KYivH3ier87LxfJpORJbfFRfDdGV5P2XU7s3z4pN/cQdhwuwK3ORI9BRNRLE=
X-Received: by 2002:a05:6a20:729e:b0:174:c134:81fa with SMTP id
 o30-20020a056a20729e00b00174c13481famr11887527pzk.17.1700518732652; Mon, 20
 Nov 2023 14:18:52 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Nov 2023 14:18:51 -0800
From:   Amit Dhingra <mechanicalamit@gmail.com>
References: <20231105143932.3722920-2-u.kleine-koenig@pengutronix.de> <233689d7-9409-406b-9383-49f10cd29336@web.de>
MIME-Version: 1.0
In-Reply-To: <233689d7-9409-406b-9383-49f10cd29336@web.de>
Date:   Mon, 20 Nov 2023 14:18:51 -0800
Message-ID: <CAO=gReGA17gHSr4ftN1Jwrjt5t76oAgaL6+n6X4wD0osJnuq4g@mail.gmail.com>
Subject: Re: spi: cadence-xspi: Drop useless assignment to NULL
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, kernel@pengutronix.de,
        kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org,
        cocci@inria.fr, Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2023 at 05:42:17PM +0100, Markus Elfring wrote:
> > Static structs are initialized with zeros for unspecified fields.
> > So there is no advantage to explicitly initialize .remove with NULL
> > and the assignment can be dropped without side effects.
>
> Would you become interested to delete redundant initialisation repetitions
> at any more source code places?
>
> A corresponding script for the semantic patch language (Coccinelle software)
> can point more remaining update candidates out for various components.


Coccinelle shows 471 files.

@@
identifier var, id;
identifier ty;
@@
static struct ty id = {
	...,
-	.var = NULL,
	...,
};

A lot of them have comments that seem to add clarity.


arch/arm/mach-imx/pm-imx6.c
arch/arm/mach-omap1/board-nokia770.c
arch/arm/mach-omap1/board-osk.c
arch/arm/mach-omap1/board-palmte.c
arch/arm/mach-omap1/board-sx1.c
arch/arm/mach-omap2/pdata-quirks.c
arch/arm/mach-omap2/prm3xxx.c
arch/arm/mach-sa1100/jornada720.c
arch/arm64/kernel/armv8_deprecated.c
arch/microblaze/kernel/timer.c
arch/mips/pci/pci-rc32434.c
arch/mips/sibyte/common/sb_tbprof.c
arch/parisc/kernel/irq.c
arch/powerpc/kernel/dt_cpu_ftrs.c
arch/powerpc/platforms/powernv/eeh-powernv.c
arch/powerpc/platforms/powernv/opal-async.c
arch/powerpc/platforms/powernv/opal-hmi.c
arch/powerpc/platforms/powernv/opal-memory-errors.c
arch/powerpc/platforms/powernv/opal-power.c
arch/powerpc/platforms/powernv/opal-prd.c
arch/powerpc/platforms/powernv/smp.c
arch/powerpc/platforms/pseries/eeh_pseries.c
arch/powerpc/platforms/pseries/smp.c
arch/powerpc/sysdev/xics/ics-native.c
arch/powerpc/sysdev/xics/ics-opal.c
arch/powerpc/sysdev/xics/ics-rtas.c
arch/powerpc/sysdev/xics/xics-common.c
arch/riscv/kvm/vcpu_sbi.c
arch/s390/crypto/prng.c
arch/s390/kernel/perf_pai_crypto.c
arch/s390/kernel/perf_pai_ext.c
arch/sh/boards/mach-sh7763rdp/setup.c
arch/um/drivers/hostaudio_kern.c
arch/um/drivers/net_kern.c
arch/um/drivers/vector_kern.c
arch/x86/events/core.c
arch/x86/kernel/apic/bigsmp_32.c
arch/x86/kernel/apic/x2apic_cluster.c
arch/x86/kernel/cpu/resctrl/pseudo_lock.c
arch/x86/kvm/svm/svm.c
arch/x86/kvm/vmx/vmx.c
arch/x86/platform/uv/uv_time.c
drivers/accel/habanalabs/gaudi/gaudi.c
drivers/accel/habanalabs/gaudi2/gaudi2.c
drivers/accel/habanalabs/goya/goya.c
drivers/accessibility/speakup/speakup_acntpc.c
drivers/accessibility/speakup/speakup_acntsa.c
drivers/accessibility/speakup/speakup_apollo.c
drivers/accessibility/speakup/speakup_audptr.c
drivers/accessibility/speakup/speakup_bns.c
drivers/accessibility/speakup/speakup_decext.c
drivers/accessibility/speakup/speakup_decpc.c
drivers/accessibility/speakup/speakup_dectlk.c
drivers/accessibility/speakup/speakup_dtlk.c
drivers/accessibility/speakup/speakup_dummy.c
drivers/accessibility/speakup/speakup_keypc.c
drivers/accessibility/speakup/speakup_ltlk.c
drivers/accessibility/speakup/speakup_soft.c
drivers/accessibility/speakup/speakup_spkout.c
drivers/accessibility/speakup/speakup_txprt.c
drivers/acpi/sleep.c
drivers/ata/pata_parport/pata_parport.c
drivers/atm/adummy.c
drivers/atm/lanai.c
drivers/atm/solos-pci.c
drivers/bluetooth/btmrvl_sdio.c
drivers/bluetooth/btnxpuart.c
drivers/char/agp/ali-agp.c
drivers/char/agp/amd64-agp.c
drivers/char/agp/sis-agp.c
drivers/char/agp/via-agp.c
drivers/char/hw_random/s390-trng.c
drivers/char/ipmi/ipmi_msghandler.c
drivers/char/ipmi/ipmi_watchdog.c
drivers/char/tlclk.c
drivers/char/virtio_console.c
drivers/clk/ralink/clk-mtmips.c
drivers/comedi/drivers/tests/ni_routes_test.c
drivers/cpufreq/powernv-cpufreq.c
drivers/crypto/ccp/ccp-debugfs.c
drivers/crypto/ccp/ccp-dev-v3.c
drivers/crypto/nx/nx-common-pseries.c
drivers/firmware/arm_scmi/base.c
drivers/firmware/arm_scmi/system.c
drivers/gpu/drm/amd/amdgpu/aldebaran.c
drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
drivers/gpu/drm/amd/amdgpu/cik.c
drivers/gpu/drm/amd/amdgpu/cik_ih.c
drivers/gpu/drm/amd/amdgpu/cik_sdma.c
drivers/gpu/drm/amd/amdgpu/cz_ih.c
drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
drivers/gpu/drm/amd/amdgpu/iceland_ih.c
drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
drivers/gpu/drm/amd/amdgpu/navi10_ih.c
drivers/gpu/drm/amd/amdgpu/nv.c
drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
drivers/gpu/drm/amd/amdgpu/si.c
drivers/gpu/drm/amd/amdgpu/si_dma.c
drivers/gpu/drm/amd/amdgpu/si_ih.c
drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
drivers/gpu/drm/amd/amdgpu/soc15.c
drivers/gpu/drm/amd/amdgpu/tonga_ih.c
drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
drivers/gpu/drm/amd/amdgpu/vi.c
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
drivers/gpu/drm/amd/display/dc/bios/dce110/command_table_helper_dce110.c
drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper2_dce112.c
drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper_dce112.c
drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator_v.c
drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
drivers/gpu/drm/amd/display/dc/dce80/dce80_timing_generator.c
drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c
drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c
drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c
drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubbub.c
drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.c
drivers/gpu/drm/amd/display/dc/dcn201/dcn201_mpc.c
drivers/gpu/drm/amd/display/dc/dcn201/dcn201_optc.c
drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c
drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
drivers/gpu/drm/amd/display/dc/dcn301/dcn301_optc.c
drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dpp.c
drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c
drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c
drivers/gpu/drm/amd/display/dc/gpio/dce110/hw_factory_dce110.c
drivers/gpu/drm/amd/display/dc/gpio/dce120/hw_factory_dce120.c
drivers/gpu/drm/amd/display/dc/gpio/dce60/hw_factory_dce60.c
drivers/gpu/drm/amd/display/dc/gpio/dce80/hw_factory_dce80.c
drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c
drivers/gpu/drm/amd/display/dc/irq/dce120/irq_service_dce120.c
drivers/gpu/drm/amd/display/dc/irq/dce60/irq_service_dce60.c
drivers/gpu/drm/amd/display/dc/irq/dce80/irq_service_dce80.c
drivers/gpu/drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c
drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
drivers/gpu/drm/amd/display/dc/irq/dcn302/irq_service_dcn302.c
drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.c
drivers/gpu/drm/amd/display/dc/irq/dcn31/irq_service_dcn31.c
drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c
drivers/gpu/drm/amd/display/dc/irq/dcn315/irq_service_dcn315.c
drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
drivers/gpu/drm/amd/display/dc/irq/dcn35/irq_service_dcn35.c
drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
drivers/gpu/drm/i915/gvt/firmware.c
drivers/gpu/drm/i915/i915_switcheroo.c
drivers/gpu/drm/i915/i915_sysfs.c
drivers/gpu/drm/mcde/mcde_drv.c
drivers/gpu/drm/msm/dsi/dsi_cfg.c
drivers/gpu/drm/nouveau/dispnv04/dfp.c
drivers/gpu/drm/omapdrm/dss/dss.c
drivers/gpu/drm/panfrost/panfrost_drv.c
drivers/gpu/drm/pl111/pl111_drv.c
drivers/gpu/drm/radeon/radeon_asic.c
drivers/gpu/drm/radeon/radeon_device.c
drivers/gpu/drm/tve200/tve200_drv.c
drivers/gpu/drm/vc4/vc4_crtc.c
drivers/gpu/drm/vmwgfx/vmwgfx_context.c
drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
drivers/gpu/drm/vmwgfx/vmwgfx_streamoutput.c
drivers/gpu/host1x/dev.c
drivers/hid/hid-wiimote-modules.c
drivers/hid/i2c-hid/i2c-hid-of-elan.c
drivers/hte/hte-tegra194.c
drivers/hv/vmbus_drv.c
drivers/hwmon/asus_wmi_sensors.c
drivers/hwmon/hp-wmi-sensors.c
drivers/hwmon/pmbus/acbel-fsg032.c
drivers/hwmon/pmbus/max20730.c
drivers/hwmon/pmbus/pmbus_core.c
drivers/hwmon/scmi-hwmon.c
drivers/i2c/busses/i2c-qcom-geni.c
drivers/iio/adc/ingenic-adc.c
drivers/iio/adc/ltc2496.c
drivers/iio/proximity/srf08.c
drivers/infiniband/hw/qib/qib_init.c
drivers/infiniband/ulp/srpt/ib_srpt.c
drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
drivers/ipack/devices/ipoctal.c
drivers/isdn/mISDN/dsp_hwec.c
drivers/leds/simple/simatic-ipc-leds-gpio-apollolake.c
drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c
drivers/mailbox/qcom-apcs-ipc-mailbox.c
drivers/md/dm-integrity.c
drivers/md/md.c
drivers/md/persistent-data/dm-bitset.c
drivers/md/persistent-data/dm-space-map-disk.c
drivers/md/persistent-data/dm-space-map-metadata.c
drivers/md/raid5.c
drivers/media/dvb-core/dmxdev.c
drivers/media/dvb-core/dvb_ca_en50221.c
drivers/media/dvb-core/dvb_net.c
drivers/media/dvb-frontends/atbm8830.c
drivers/media/dvb-frontends/dib0090.c
drivers/media/dvb-frontends/gp8psk-fe.c
drivers/media/i2c/lm3560.c
drivers/media/i2c/lm3646.c
drivers/media/pci/bt8xx/dst_ca.c
drivers/media/pci/cobalt/cobalt-i2c.c
drivers/media/pci/cx18/cx18-i2c.c
drivers/media/pci/cx23885/cx23885-dvb.c
drivers/media/pci/ddbridge/ddbridge-core.c
drivers/media/pci/ivtv/ivtv-i2c.c
drivers/media/pci/ivtv/ivtvfb.c
drivers/media/pci/mantis/mantis_vp1041.c
drivers/media/pci/ngene/ngene-dvb.c
drivers/media/pci/saa7146/hexium_gemini.c
drivers/media/pci/saa7146/hexium_orion.c
drivers/media/pci/saa7146/mxb.c
drivers/media/pci/ttpci/budget-av.c
drivers/media/pci/ttpci/budget-ci.c
drivers/media/pci/ttpci/budget.c
drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-dvb.c
drivers/media/radio/radio-cadet.c
drivers/media/radio/radio-si476x.c
drivers/media/test-drivers/vivid/vivid-osd.c
drivers/media/tuners/max2165.c
drivers/media/usb/dvb-usb-v2/az6007.c
drivers/media/usb/dvb-usb/az6027.c
drivers/media/usb/dvb-usb/dib0700_devices.c
drivers/media/usb/dvb-usb/m920x.c
drivers/media/usb/dvb-usb/pctv452e.c
drivers/memory/brcmstb_dpfe.c
drivers/mfd/ab8500-core.c
drivers/mfd/pcf50633-core.c
drivers/mfd/stmpe.c
drivers/misc/cardreader/rtl8411.c
drivers/misc/cardreader/rts5209.c
drivers/misc/cardreader/rts5227.c
drivers/misc/cardreader/rts5229.c
drivers/mmc/host/sunxi-mmc.c
drivers/mtd/chips/cfi_cmdset_0001.c
drivers/mtd/chips/cfi_cmdset_0002.c
drivers/mtd/chips/cfi_cmdset_0020.c
drivers/net/arcnet/arc-rawmode.c
drivers/net/arcnet/arcnet.c
drivers/net/arcnet/com20020-pci.c
drivers/net/arcnet/rfc1051.c
drivers/net/arcnet/rfc1201.c
drivers/net/can/softing/softing_main.c
drivers/net/ethernet/altera/altera_tse_main.c
drivers/net/ethernet/amazon/ena/ena_netdev.c
drivers/net/ethernet/amd/sun3lance.c
drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
drivers/net/ethernet/brocade/bna/bfa_ioc_ct.c
drivers/net/ethernet/brocade/bna/bnad.c
drivers/net/ethernet/freescale/enetc/enetc_qos.c
drivers/net/ethernet/ibm/ibmveth.c
drivers/net/ethernet/intel/e1000e/80003es2lan.c
drivers/net/ethernet/intel/e1000e/82571.c
drivers/net/ethernet/intel/e1000e/ich8lan.c
drivers/net/ethernet/intel/ice/ice_sriov.c
drivers/net/ethernet/intel/igb/igb_main.c
drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c
drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
drivers/net/ethernet/myricom/myri10ge/myri10ge.c
drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c
drivers/net/ieee802154/ca8210.c
drivers/net/rionet.c
drivers/net/usb/cdc_ether.c
drivers/net/usb/cdc_ncm.c
drivers/net/wireless/ath/ath10k/ce.c
drivers/net/wireless/ath/ath11k/ahb.c
drivers/net/wireless/ath/ath11k/pci.c
drivers/net/wireless/ath/ath12k/pci.c
drivers/net/wireless/intel/ipw2x00/ipw2200.c
drivers/net/wireless/intel/iwlegacy/3945-mac.c
drivers/net/wireless/intel/iwlegacy/4965-mac.c
drivers/net/wireless/marvell/mwifiex/pcie.c
drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
drivers/net/wireless/realtek/rtw88/rtw8723d.c
drivers/net/wireless/realtek/rtw88/rtw8821c.c
drivers/net/wireless/realtek/rtw88/rtw8822c.c
drivers/net/wireless/realtek/rtw89/rtw8851b.c
drivers/net/wireless/realtek/rtw89/rtw8851be.c
drivers/net/wireless/realtek/rtw89/rtw8852a.c
drivers/net/wireless/realtek/rtw89/rtw8852ae.c
drivers/net/wireless/realtek/rtw89/rtw8852b.c
drivers/net/wireless/realtek/rtw89/rtw8852be.c
drivers/net/wireless/realtek/rtw89/rtw8852c.c
drivers/net/wireless/realtek/rtw89/rtw8922ae.c
drivers/net/wireless/ti/wl12xx/main.c
drivers/net/wireless/ti/wl18xx/main.c
drivers/nfc/microread/microread.c
drivers/parisc/hppb.c
drivers/parport/procfs.c
drivers/parport/share.c
drivers/pci/controller/dwc/pcie-uniphier-ep.c
drivers/pci/hotplug/acpiphp_ibm.c
drivers/pci/pci-stub.c
drivers/perf/arm-cci.c
drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
drivers/platform/surface/aggregator/ssh_packet_layer.c
drivers/platform/surface/surface_acpi_notify.c
drivers/platform/x86/dell/dcdbas.c
drivers/platform/x86/panasonic-laptop.c
drivers/power/supply/collie_battery.c
drivers/power/supply/ltc4162-l-charger.c
drivers/powercap/intel_rapl_common.c
drivers/pps/generators/pps_gen_parport.c
drivers/rapidio/switches/idtcps.c
drivers/s390/char/sclp_ftp.c
drivers/s390/crypto/zcrypt_msgtype6.c
drivers/scsi/3w-9xxx.c
drivers/scsi/3w-sas.c
drivers/scsi/3w-xxxx.c
drivers/scsi/elx/efct/efct_lio.c
drivers/scsi/qedf/qedf_main.c
drivers/scsi/qedi/qedi_main.c
drivers/scsi/qla2xxx/qla_nvme.c
drivers/scsi/qla2xxx/qla_os.c
drivers/scsi/qla2xxx/tcm_qla2xxx.c
drivers/soc/mediatek/mtk-pmic-wrap.c
drivers/soc/tegra/pmc.c
drivers/staging/media/av7110/av7110.c
drivers/staging/media/av7110/av7110_av.c
drivers/staging/media/av7110/av7110_ca.c
drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
drivers/staging/rtl8192e/rtllib_crypt_wep.c
drivers/target/iscsi/iscsi_target.c
drivers/target/sbp/sbp_target.c
drivers/target/target_core_configfs.c
drivers/target/tcm_fc/tfc_conf.c
drivers/tty/serial/ar933x_uart.c
drivers/tty/serial/serial-tegra.c
drivers/tty/vcc.c
drivers/uio/uio_hv_generic.c
drivers/uio/uio_pci_generic.c
drivers/usb/core/sysfs.c
drivers/usb/gadget/function/f_tcm.c
drivers/usb/gadget/udc/pch_udc.c
drivers/usb/host/ehci-xilinx-of.c
drivers/usb/host/uhci-grlib.c
drivers/usb/host/uhci-platform.c
drivers/usb/host/xhci.c
drivers/vdpa/virtio_pci/vp_vdpa.c
drivers/vhost/scsi.c
drivers/video/backlight/lms283gf05.c
drivers/video/fbdev/acornfb.c
drivers/video/fbdev/arkfb.c
drivers/video/fbdev/au1200fb.c
drivers/video/fbdev/geode/gxfb_core.c
drivers/video/fbdev/geode/lxfb_core.c
drivers/video/fbdev/i740fb.c
drivers/video/fbdev/omap2/omapfb/dss/dss.c
drivers/video/fbdev/s3fb.c
drivers/video/fbdev/uvesafb.c
drivers/video/fbdev/via/via-core.c
drivers/video/fbdev/vt8623fb.c
drivers/virtio/virtio_pci_modern.c
drivers/watchdog/diag288_wdt.c
drivers/xen/xen-scsiback.c
fs/configfs/mount.c
fs/jffs2/compr_rubin.c
fs/nfsd/nfs4recover.c
fs/nilfs2/btree.c
fs/nilfs2/direct.c
fs/nilfs2/segment.c
fs/notify/fanotify/fanotify_user.c
fs/ocfs2/super.c
fs/xfs/libxfs/xfs_alloc_btree.c
include/linux/qed/qed_ll2_if.h
kernel/bpf/link_iter.c
kernel/bpf/map_iter.c
kernel/bpf/prog_iter.c
kernel/debug/debug_core.c
kernel/kallsyms.c
kernel/locking/locktorture.c
kernel/rcu/rcutorture.c
kernel/trace/trace_eprobe.c
kernel/trace/trace_hwlat.c
kernel/trace/trace_osnoise.c
mm/mmap.c
net/atm/lec.c
net/ipv4/udp.c
net/ipv6/netfilter/ip6t_ipv6header.c
net/ipv6/udp.c
net/netfilter/ipvs/ip_vs_ftp.c
net/netfilter/ipvs/ip_vs_rr.c
net/sched/sch_multiq.c
net/sched/sch_prio.c
net/sched/sch_sfq.c
net/sched/sch_tbf.c
net/sunrpc/xdr.c
net/wireless/lib80211_crypt_ccmp.c
net/wireless/lib80211_crypt_wep.c
sound/firewire/bebob/bebob.c
sound/pci/ctxfi/ctdaio.c
sound/pci/ctxfi/ctsrc.c
sound/soc/codecs/ak4641.c
sound/soc/codecs/wcd938x.c
sound/soc/intel/atom/sst/sst_drv_interface.c
sound/soc/soc-ac97.c
sound/soc/ux500/mop500.c
sound/usb/mixer.c
tools/perf/builtin-kwork.c
tools/testing/selftests/net/ioam6_parser.c
virt/kvm/kvm_main.c

    - Amit
