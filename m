Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C35B798AE0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 18:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242069AbjIHQuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 12:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbjIHQue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 12:50:34 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10656199F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 09:50:30 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-26d49cf1811so1668384a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 09:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1694191829; x=1694796629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3eeFI5506k3uG/Tnaim0ZTpM400tQ9NIQWLiCpa+7gk=;
        b=C+o9q3BPKVJbnVeFlFBXBPtTbPLOr43rZdk5HI/mErDBS3PHpobEo+RLl3lKCx6e7t
         OQZ/ffyhusYrSg4ucch9QoWtNVK5DMUDsKpNUPRAM35/eyozRKpsoXvAOW6m90WI+KTA
         Xt69kHoMcboi6gwwKjcHLEM4ps3VmH0/oJ4zuqeB0dKePPXBMgtAXp41ZrLRudE3MKDv
         A8/+V1qogW7gd1++FDDhF2/a1vTbQHaKyRjDv8lb27Gc8yh/nlpm6beRIa+QDSQMITAE
         W8U5uZz0wL6n0OWYUF5Doq6XIafu9zG/0ATX9tFNjCgmDVxAA/gkgKdYIdtiaqJ75Civ
         2TQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694191829; x=1694796629;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eeFI5506k3uG/Tnaim0ZTpM400tQ9NIQWLiCpa+7gk=;
        b=LnDj4A3m9q9Hcevq21CxS4wSByrm1z341OVbsKBxp2RBfCvm6UlkjOBFSY9ViQe3o9
         kyy0ZxCuYaHa47frUbKeakpS8d+y6T7PryWVsIz67AduVhsX8wepdnguA83eKezXUEFt
         Q+i4E6ZswMvDYlLZ0sbefZyCMagmuB1v4sqeaAoj67vj+nf0+irm8UVrnsRcV5EDMlIs
         B6VK2/+XHRYfCKDaZnCMH9+6+jXAeZSNxNzMR9AKIUzvbXQqxcnc0G6SUsPjSCsTelxB
         98KbYP5BkX599DwpnP+vU6qQJQCgMQITSim8NQOfG3VbZ1UPoK2s+S8bnYVGmX0PxhaF
         bMEA==
X-Gm-Message-State: AOJu0YzvF7INrZhhxPvmyAHO9hpIzSaRRiUmlPw7q536ZmRGTZlS7TsH
        y51mcGz9mcUNNXeydi5tNnUlqA==
X-Google-Smtp-Source: AGHT+IEVeX4yUQTpMLJ+SKNmoAnN0hnwpqOf8t9o3c23h+s6qxoAKlV6bSiBnjiV62r5SyH1rdDXrw==
X-Received: by 2002:a17:90a:f290:b0:25d:eca9:1621 with SMTP id fs16-20020a17090af29000b0025deca91621mr2956024pjb.6.1694191829361;
        Fri, 08 Sep 2023 09:50:29 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id t13-20020a17090a024d00b0026b6b17ca5dsm1641181pje.54.2023.09.08.09.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 09:50:28 -0700 (PDT)
Date:   Fri, 08 Sep 2023 09:50:28 -0700 (PDT)
X-Google-Original-Date: Fri, 08 Sep 2023 09:50:26 PDT (-0700)
Subject:     Re: linux-next: Tree for Sep 7
In-Reply-To: <20230908082625.487d39c4@canb.auug.org.au>
CC:     akiyks@gmail.com, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, Paul Walmsley <paul@pwsan.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <mhng-7ea71b18-44f0-4867-995b-fe061936685d@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Sep 2023 15:26:25 PDT (-0700), Stephen Rothwell wrote:
> Hi Akira,
>
> On Thu, 7 Sep 2023 12:00:39 +0900 Akira Yokosawa <akiyks@gmail.com> wrote:
>>
>> Stephen, I have noticed quite a few redundant documentation files
>> reappeared in today's linux-next.  I didn't check linux-next earlier
>> this week.
>> 
>> Redundant dirs:
>> 
>>     Documentation/loongarch/
>>     Documentation/mips/
>>     Documentation/s390/
>>     Documentation/translations/zh_CN/loongarch/
>>     Documentation/translations/zh_CN/mips/
>> 
>> Bisection blames merge commit be2bf9967daa ("Merge branch 'for-next'
>> of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git").
>> 
>> I suspect the conflict in Documentation/bpf/linux-notes.rst caused
>> those files once moved to arch/ in upstream to be picked up again
>> during "git merge" ...
>
> Actually, it looks like the merge
>
>   2bf3c0292f35 ("Merge patch series "RISC-V: Probe for misaligned access speed"")
>
> in the risc-v tree was resolved very badly and dragged a lot of stuff
> back in.

Sorry I missed this one too, I'm going to try and figure out what's up 
with my email lately.

>
> $ git diff --stat 2bf3c0292f35^..2bf3c0292f35
>  Documentation/bpf/instruction-set.rst              |  478 +++++++++
>  Documentation/bpf/linux-notes.rst                  |   83 ++
>  Documentation/devicetree/bindings/arm/msm/ssbi.txt |   18 +
>  .../devicetree/bindings/arm/tegra/nvidia,nvec.txt  |   21 +
>  .../bindings/arm/tegra/nvidia,tegra20-ahb.txt      |   17 +
>  .../bindings/arm/tegra/nvidia,tegra20-flowctrl.txt |   18 +
>  .../bindings/clock/amlogic,gxbb-aoclkc.txt         |   64 ++
>  .../bindings/clock/amlogic,gxbb-clkc.txt           |   53 +
>  .../devicetree/bindings/clock/hix5hd2-clock.txt    |   30 +
>  .../devicetree/bindings/clock/oxnas,stdclk.txt     |   28 +
>  .../devicetree/bindings/clock/xlnx,zynqmp-clk.txt  |   63 ++
>  .../devicetree/bindings/cpufreq/ti-cpufreq.txt     |  132 +++
>  .../devicetree/bindings/gpio/brcm,kona-gpio.txt    |   52 +
>  .../devicetree/bindings/gpio/gpio_oxnas.txt        |   47 +
>  .../bindings/input/rmi4/rmi_2d_sensor.txt          |   56 +
>  .../devicetree/bindings/input/rmi4/rmi_f01.txt     |   39 +
>  .../devicetree/bindings/input/rmi4/rmi_i2c.txt     |   61 ++
>  .../devicetree/bindings/input/rmi4/rmi_spi.txt     |   56 +
>  .../devicetree/bindings/net/davicom-dm9000.txt     |   27 +
>  .../devicetree/bindings/net/ftgmac100.txt          |   67 ++
>  .../devicetree/bindings/net/oxnas-dwmac.txt        |   41 +
>  .../devicetree/bindings/net/xilinx_gmii2rgmii.txt  |   35 +
>  .../bindings/opp/ti-omap5-opp-supply.txt           |   63 ++
>  .../bindings/pinctrl/brcm,bcm11351-pinctrl.txt     |  461 +++++++++
>  .../devicetree/bindings/pinctrl/oxnas,pinctrl.txt  |   56 +
>  .../devicetree/bindings/pinctrl/pinctrl-single.txt |  262 +++++
>  .../bindings/pinctrl/ti,omap-pinctrl.txt           |   13 +
>  .../bindings/power/xlnx,zynqmp-genpd.txt           |   34 +
>  Documentation/devicetree/bindings/pps/pps-gpio.txt |   30 +
>  .../devicetree/bindings/regulator/slg51000.txt     |   88 ++
>  .../devicetree/bindings/serial/cavium-uart.txt     |   19 +
>  .../bindings/serial/nvidia,tegra20-hsuart.txt      |   73 ++
>  .../bindings/serial/nxp,lpc1850-uart.txt           |   28 +
>  Documentation/devicetree/bindings/sound/gtm601.txt |   19 +
>  .../devicetree/bindings/sound/max9892x.txt         |   44 +
>  .../devicetree/bindings/sound/nau8821.txt          |   55 +
>  .../bindings/sound/qcom,msm8916-wcd-analog.txt     |  101 ++
>  Documentation/devicetree/bindings/sound/wm8904.txt |   33 +
>  .../bindings/spi/nvidia,tegra114-spi.txt           |   61 ++
>  .../bindings/spi/nvidia,tegra20-sflash.txt         |   37 +
>  .../bindings/spi/nvidia,tegra20-slink.txt          |   37 +
>  .../devicetree/bindings/spi/spi-bcm63xx.txt        |   33 +
>  .../bindings/thermal/nvidia,tegra124-soctherm.txt  |  238 +++++
>  .../devicetree/bindings/usb/samsung-hsotg.txt      |   38 +
>  Documentation/hwmon/smm665.rst                     |  187 ++++
>  Documentation/loongarch/booting.rst                |   42 +
>  Documentation/loongarch/features.rst               |    3 +
>  Documentation/loongarch/index.rst                  |   22 +
>  Documentation/loongarch/introduction.rst           |  390 +++++++
>  Documentation/loongarch/irq-chip-model.rst         |  160 +++
>  Documentation/mips/booting.rst                     |   28 +
>  Documentation/mips/features.rst                    |    3 +
>  Documentation/mips/index.rst                       |   21 +
>  Documentation/mips/ingenic-tcu.rst                 |   71 ++
>  Documentation/mm/frontswap.rst                     |  264 +++++
>  .../ethernet/mellanox/mlx5/devlink.rst             |  313 ++++++
>  Documentation/riscv/hwprobe.rst                    |   11 +-
>  Documentation/s390/3270.ChangeLog                  |   44 +
>  Documentation/s390/3270.rst                        |  298 ++++++
>  Documentation/s390/cds.rst                         |  530 ++++++++++
>  Documentation/s390/common_io.rst                   |  140 +++
>  Documentation/s390/config3270.sh                   |   76 ++
>  Documentation/s390/driver-model.rst                |  328 ++++++
>  Documentation/s390/features.rst                    |    3 +
>  Documentation/s390/index.rst                       |   30 +
>  Documentation/s390/monreader.rst                   |  212 ++++
>  Documentation/s390/pci.rst                         |  133 +++
>  Documentation/s390/qeth.rst                        |   64 ++
>  Documentation/s390/s390dbf.rst                     |  478 +++++++++
>  Documentation/s390/text_files.rst                  |   11 +
>  Documentation/s390/vfio-ap-locking.rst             |  115 +++
>  Documentation/s390/vfio-ap.rst                     | 1069 ++++++++++++++++++++
>  Documentation/s390/vfio-ccw.rst                    |  445 ++++++++
>  Documentation/s390/zfcpdump.rst                    |   50 +
>  .../translations/zh_CN/loongarch/booting.rst       |   48 +
>  .../translations/zh_CN/loongarch/features.rst      |    8 +
>  .../translations/zh_CN/loongarch/index.rst         |   27 +
>  .../translations/zh_CN/loongarch/introduction.rst  |  353 +++++++
>  .../zh_CN/loongarch/irq-chip-model.rst             |  157 +++
>  Documentation/translations/zh_CN/mips/booting.rst  |   34 +
>  Documentation/translations/zh_CN/mips/features.rst |   13 +
>  Documentation/translations/zh_CN/mips/index.rst    |   29 +
>  .../translations/zh_CN/mips/ingenic-tcu.rst        |   72 ++
>  Documentation/translations/zh_CN/mm/frontswap.rst  |  196 ++++
>  arch/arm/mach-keystone/keystone.h                  |   16 +
>  arch/arm/mach-keystone/memory.h                    |   18 +
>  arch/arm/mach-keystone/pm_domain.c                 |   50 +
>  arch/arm/mach-nspire/mmio.h                        |   16 +
>  arch/arm/mach-ux500/pm_domains.c                   |   79 ++
>  arch/arm/mach-ux500/pm_domains.h                   |   17 +
>  arch/arm/vfp/entry.S                               |   31 +
>  arch/arm64/boot/dts/arm/vexpress-v2m-rs1.dtsi      |    1 +
>  arch/hexagon/mm/ioremap.c                          |   44 +
>  arch/parisc/include/asm/machdep.h                  |   17 +
>  arch/parisc/kernel/pa7300lc.c                      |   51 +
>  arch/powerpc/include/asm/mpc8260.h                 |   22 +
>  arch/powerpc/kernel/trace/ftrace_64_pg.S           |   67 ++
>  arch/powerpc/kernel/trace/ftrace_low.S             |   78 ++
>  arch/powerpc/kernel/trace/ftrace_mprofile.S        |  251 +++++
>  arch/powerpc/lib/alloc.c                           |   23 +
>  arch/powerpc/platforms/82xx/m82xx_pci.h            |   14 +
>  arch/powerpc/platforms/83xx/usb.c                  |  251 +++++
>  arch/riscv/errata/thead/errata.c                   |    8 -
>  arch/riscv/include/asm/alternative.h               |    5 -
>  arch/riscv/include/asm/cpufeature.h                |    2 +
>  arch/riscv/kernel/Makefile                         |    1 +
>  arch/riscv/kernel/alternative.c                    |   19 -
>  arch/riscv/kernel/copy-unaligned.S                 |   71 ++
>  arch/riscv/kernel/copy-unaligned.h                 |   13 +
>  arch/riscv/kernel/cpufeature.c                     |  104 ++
>  arch/riscv/kernel/smpboot.c                        |    3 +-
>  arch/x86/include/asm/microcode_amd.h               |   58 ++
>  arch/x86/include/asm/microcode_intel.h             |   88 ++
>  drivers/accel/ivpu/ivpu_hw_mtl.c                   | 1053 +++++++++++++++++++
>  drivers/accel/ivpu/ivpu_hw_mtl_reg.h               |  281 +++++
>  drivers/acpi/acpi_amba.c                           |  130 +++
>  drivers/clk/clk-oxnas.c                            |  251 +++++
>  drivers/clk/meson/axg-aoclk.h                      |   18 +
>  drivers/clk/meson/g12a-aoclk.h                     |   32 +
>  drivers/clk/meson/gxbb-aoclk.h                     |   15 +
>  drivers/clk/mmp/clk-mmp2.c                         |  454 +++++++++
>  drivers/clk/mmp/clk-pxa168.c                       |  354 +++++++
>  drivers/clk/mmp/clk-pxa910.c                       |  325 ++++++
>  drivers/clk/qcom/lcc-mdm9615.c                     |  572 +++++++++++
>  drivers/firmware/imx/scu-pd.c                      |  428 ++++++++
>  .../gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c    |  658 ++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_iommu.c             |  356 +++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_iommu.h             |   84 ++
>  .../drm/amd/display/dmub/inc/dmub_subvp_state.h    |  183 ++++
>  drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramga102.c  |   40 +
>  130 files changed, 16400 insertions(+), 39 deletions(-)
>
> When I redid that merge:
>
> $ git diff HEAD^..HEAD
>  Documentation/riscv/hwprobe.rst      |  11 ++--
>  arch/riscv/errata/thead/errata.c     |   8 ---
>  arch/riscv/include/asm/alternative.h |   5 --
>  arch/riscv/include/asm/cpufeature.h  |   2 +
>  arch/riscv/kernel/Makefile           |   1 +
>  arch/riscv/kernel/alternative.c      |  19 -------
>  arch/riscv/kernel/copy-unaligned.S   |  71 ++++++++++++++++++++++++
>  arch/riscv/kernel/copy-unaligned.h   |  13 +++++
>  arch/riscv/kernel/cpufeature.c       | 104 +++++++++++++++++++++++++++++++++++
>  arch/riscv/kernel/smpboot.c          |   3 +-
>  10 files changed, 198 insertions(+), 39 deletions(-)
>
> So, the risc-v tree needs to be cleaned up.
> -- 
> Cheers,
> Stephen Rothwell
