Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF0F7DF6BC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347565AbjKBPn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376828AbjKBPny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:43:54 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE88C185
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:43:47 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6bd32d1a040so1133397b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 08:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698939827; x=1699544627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z5PUKlCraUJcD3yUC3L9imoLl1MsjERMoCBNNlZ4X64=;
        b=WvtOiyD32o16n3735vUVpJVrasR+Z5fqaEfgRApadlBNRN54iJ2qJHs938h6HOlSrt
         Im4NhYQKFCfIYTr6GIyHpajCNYZixd+EiLy5g8lQHErhYXW5S6d2ceSNKbrIXPKcqZ04
         SKRZw0W+UUTUa0/aZVMDfqSZm8K6Xv8Z70qt+MTb4S4gBnwQPI1VOECQzZ1F647lF3ZZ
         NfLdJt0rCRHAFPNU+5g484uOXmol4EiWWtvNHEpARtb7idMp/f9rxSTpZhwnqCj4cOxT
         I5DXK+Mtc+GvlHt5nEOM5jnxVoWBTx/yEb2X4PGbJ9bkmbTA4zl+ozvgpGHV4CLpWTqL
         zcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698939827; x=1699544627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5PUKlCraUJcD3yUC3L9imoLl1MsjERMoCBNNlZ4X64=;
        b=e4BDApgACwrK0wMcVBFbsIBblVPeUJacdkpYaepUQt8CcFW2Ic5Dea0i9oZeMytMAj
         EP0tsTqsEqH16/pE72x6+8OahCgiQFiYKY+/LAq6JycXjKIwJHlx2sbj9Nz6qlVZESy1
         1nuR2Rutw+FAzwN670WdGaQHFYnsUEXftu610sa5mPTfjKPFiXT0l4CsrerNHRWXSJrx
         B5KH8/sEsTdhShJc7ckPzbTowhhht86MX7MdjUXcilf3Ks9LcULJFS2aeMhhcOg8hhdE
         ZUuN+gaF/DUZS+l4l5HHXwpnkDgTy9Y4Rp049c4n5ojRHu4O8ASziw9aDVSGkg+oGcg+
         Y5Ng==
X-Gm-Message-State: AOJu0YxjN2K5hq1WIyN303p5wC9YWgbU/ORT6hTb+sio0dSo508clqFv
        PIHlwGoWmJw6rBUBpaJdRXxefA==
X-Google-Smtp-Source: AGHT+IFzt5NMH3PQeoRUfnSP2UesGRRYzh0jjWbcQa7WtH+uAmcsv/nWKunf6upLLXLOIMIrHbwuJQ==
X-Received: by 2002:a05:6a20:1613:b0:136:e26b:6401 with SMTP id l19-20020a056a20161300b00136e26b6401mr24204264pzj.16.1698939827132;
        Thu, 02 Nov 2023 08:43:47 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:fb88:de98:3a2b:8ed1])
        by smtp.gmail.com with ESMTPSA id z14-20020aa785ce000000b0068c10187dc3sm16866pfn.168.2023.11.02.08.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 08:43:45 -0700 (PDT)
Date:   Thu, 2 Nov 2023 09:43:42 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Suman Anna <s-anna@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hari Nagalla <hnagalla@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nishanth Menon <nm@ti.com>,
        "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
Subject: Re: [PATCH v3 3/5] remoteproc: k3-r5: Add support for IPC-only mode
 for all R5Fs
Message-ID: <ZUPDrlVLkDDgJpWm@p14s>
References: <20220213201246.25952-1-s-anna@ti.com>
 <20220213201246.25952-4-s-anna@ti.com>
 <e0bc7eb5-f1b9-4e99-a39f-ca6f31daa9d8@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0bc7eb5-f1b9-4e99-a39f-ca6f31daa9d8@siemens.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On Thu, Nov 02, 2023 at 11:07:45AM +0100, Jan Kiszka wrote:
> On 13.02.22 21:12, Suman Anna wrote:
> > Add support to the K3 R5F remoteproc driver to configure all the R5F
> > cores to be either in IPC-only mode or the traditional remoteproc mode.
> > The IPC-only mode expects that the remote processors are already booted
> > by the bootloader, and only performs the minimum steps required to
> > initialize and deinitialize the virtio IPC transports. The remoteproc
> > mode allows the kernel remoteproc driver to do the regular load and
> > boot and other device management operations for a R5F core.
> > 
> > The IPC-only mode for a R5F core is detected and configured at driver
> > probe time by querying the System Firmware for the R5F power and reset
> > state and/or status and making sure that the R5F core is indeed started
> > by the bootloaders, otherwise the device is configured for remoteproc
> > mode.
> > 
> > Support for IPC-only mode is achieved through .attach(), .detach() and
> > .get_loaded_rsc_table() callback ops and zeroing out the regular rproc
> > ops .prepare(), .unprepare(), .start() and .stop(). The resource table
> > follows a design-by-contract approach and is expected to be at the base
> > of the DDR firmware region reserved for each remoteproc, it is mostly
> > expected to contain only the virtio device and trace resource entries.
> > 
> > NOTE:
> > The driver cannot configure a R5F core for remoteproc mode by any
> > means without rebooting the kernel if that R5F core has been started
> > by a bootloader. This is the current desired behavior and can be
> > enhanced in the future if the feature is needed.
> > 
> 
> This change surfaced some complex issue in the K3 core: Turning on the
> RTI1 watchdog also powers up R5F core 1. And this could happen either in

When writing "... also powers up...", other than R5F core 1, what else is being
powered?

> U-Boot or in the kernel. If the kernel finds the core running, it also
> expects a resource table in the reserved RAM. But as the core is
> supposed to start via remoteproc, there is none, rather often garbage.
> Sometimes, a consistency check catches that, but not always:
>

If I understand correct and strictly addressing the Linux case, the R5F is
configured to operate in split mode and both cores are off.  An RTI1 watchdog
happens, which has the side effect of turning on core 1.  At some later time core
1 is turned on from the sysfs interface, the remoteproc driver recognizes that
it is already powered and as such enacts the "attach" scenario.  That leads to a
crash because the resource table hasn't been loaded into memory.

Is this a proper description?

> [   38.372844] remoteproc remoteproc18: 41000000.r5f is available
> [   38.380324] platform 41400000.r5f: R5F core may have been powered on by a different host, programmed state (0) != actual state (1)
> [   38.394910] platform 41400000.r5f: configured R5F for IPC-only mode
> [   38.401941] platform 41400000.r5f: assigned reserved memory node r5f-dma-memory@a1000000
> [   38.476997] remoteproc remoteproc19: 41400000.r5f is available
> [   38.484661] remoteproc remoteproc19: attaching to 41400000.r5f
> [   38.491092] Unable to handle kernel paging request at virtual address ffff80000dffffff
> [   38.503704] Mem abort info:
> [   38.509760]   ESR = 0x0000000096000007
> [   38.514071]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   38.519578]   SET = 0, FnV = 0
> [   38.523095]   EA = 0, S1PTW = 0
> [   38.526355]   FSC = 0x07: level 3 translation fault
> [   38.528974] cal 6f03000.cal: Neither port is configured, no point in staying up
> [   38.531775] Data abort info:
> [   38.541866]   ISV = 0, ISS = 0x00000007
> [   38.545765]   CM = 0, WnR = 0
> [   38.548814] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000082fdc000
> [   38.555831] [ffff80000dffffff] pgd=10000008fffff003, p4d=10000008fffff003, pud=10000008ffffe003, pmd=1000000886609003, pte=0000000000000000
> [   38.568623] remoteproc remoteproc18: powering up 41000000.r5f
> [   38.569338] Internal error: Oops: 0000000096000007 [#1] PREEMPT SMP
> [   38.574440] remoteproc remoteproc18: Booting fw image am65x-mcu-r5f0_0-fw, size 932
> [   38.580644] Modules linked in: usbserial ti_cal videobuf2_dma_contig ti_k3_r5_remoteproc(+) videobuf2_memops pci_endpoint_test videobuf2_v4l2 rti_wdt watchdog videobuf2_common at24 st_lsm6dsx_i2c(+) optee_rng st_lsm6dsx kfifo_buf pm16d17 rng_core tee_stmm_efi tpm_ftpm_tee fuse dm_mod ip_tables x_tables ipv6
> [   38.589862] remoteproc remoteproc18: remote processor 41000000.r5f is now up
> [   38.615533] CPU: 1 PID: 283 Comm: (udev-worker) Not tainted 6.1.54-cip6 #1
> [   38.615546] Hardware name: SIMATIC IOT2050 Advanced PG2 (DT)
> [   38.615553] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   38.641945] pc : rproc_handle_resources.constprop.0+0x8c/0x164
> [   38.647788] lr : rproc_boot+0x2fc/0x57c
> [   38.651628] sp : ffff800009d53740
> [   38.654934] x29: ffff800009d53740 x28: ffff00087f7d77f8 x27: ffff0008048f4c10
> [   38.662068] x26: 0000000000000001 x25: ffffffffffffffff x24: ffff80000e000000
> [   38.669199] x23: ffff00080227e038 x22: 0000000000000000 x21: ffff8000092bb1b0
> [   38.676333] x20: ffff00080227e000 x19: 0000000000000000 x18: 000000000000028e
> [   38.683464] x17: 0000000000000000 x16: 000000006d958cac x15: ffffffffffffffff
> [   38.690597] x14: ffffffffffffffff x13: ffffffffffffffff x12: ffffffffffffffff
> [   38.697728] x11: ffffffffffffffff x10: ffffffffffffffff x9 : ffffffffbfffffff
> [   38.704862] x8 : ffffffffffffffff x7 : fffffdffffffffff x6 : ffffffffffdfffff
> [   38.711994] x5 : ffff000802be1f00 x4 : ffff80000e000100 x3 : 00000000000000fd
> [   38.719127] x2 : 00000000ffffffff x1 : ffff80000e000003 x0 : ffff80000e000000
> [   38.726260] Call trace:
> [   38.728703]  rproc_handle_resources.constprop.0+0x8c/0x164
> [   38.734196]  rproc_boot+0x2fc/0x57c
> [   38.737689]  rproc_add+0xcc/0x16c
> [   38.741004]  k3_r5_probe+0x44c/0xe14 [ti_k3_r5_remoteproc]
> [   38.746501]  platform_probe+0x68/0xc0
> [   38.750168]  really_probe+0xbc/0x2dc
> [   38.753742]  __driver_probe_device+0x78/0x114
> [   38.758099]  driver_probe_device+0xd8/0x15c
> [   38.762282]  __driver_attach+0x94/0x19c
> [   38.766119]  bus_for_each_dev+0x74/0xd0
> [   38.769954]  driver_attach+0x24/0x30
> [   38.773529]  bus_add_driver+0x154/0x20c
> [   38.777363]  driver_register+0x78/0x130
> [   38.781198]  __platform_driver_register+0x28/0x34
> [   38.785901]  k3_r5_rproc_driver_init+0x20/0x1000 [ti_k3_r5_remoteproc]
> [   38.792437]  do_one_initcall+0x64/0x1dc
> [   38.796272]  do_init_module+0x48/0x1d0
> [   38.800023]  load_module+0x185c/0x1cc4
> [   38.803770]  __do_sys_finit_module+0xa8/0xfc
> [   38.808040]  __arm64_sys_finit_module+0x20/0x30
> [   38.812571]  invoke_syscall+0x48/0x114
> [   38.816320]  el0_svc_common.constprop.0+0xcc/0xec
> [   38.821053]  do_el0_svc+0x2c/0xd0
> [   38.821077]  el0_svc+0x2c/0x84
> [   38.821095]  el0t_64_sync_handler+0xf4/0x120
> [   38.831698]  el0t_64_sync+0x18c/0x190
> 
> (this crash was with a stable kernel, but same issue with head of tree)
>

Right, stable or head the result would be the same.

> This raises several questions:
>  - Is it a hardware property that RTI1 powers up core 1 as well?

I will leave that question to the TI guys.

>  - If so, how can we use both watchdog and remoteproc so that the latter
>    loads the firmware for the former? We are currently doing that from 
>    U-Boot, but what if that is not desired? Should the watchdog driver 
>    take care to not leave core 1 in a different power state behind?

Making sure core1 is turned off by the watchdog driver is a solution but based
on how the HW is behaving and when the interrupt service routine runs, there
may be a race condition when core1 is genuinely enabled.

>  - Can and should we do more while parsing the resource table to prevent
>    such crashes?
> 

That's a tricky question.  The kernel's firmware subsystem ensures the validity
of the ELF image by looking at the image's magic number.  But for the attach()
case only the address of the resource table is provided, and that resource table
doesn't have a magic number.  As such I am not sure that is it possible to parse
the resource table that is provided while keeping things generic.  That said,
I'm open to ideas.

Since this is a platform problem I think the checks need to happen in
k3_r5_get_loaded_rsc_table().  I can't advise on what those should be since I do
not have the HW.

Thanks,
Mathieu

> Jan
> 
> -- 
> Siemens AG, Technology
> Linux Expert Center
> 
