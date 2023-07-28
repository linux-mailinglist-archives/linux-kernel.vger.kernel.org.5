Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA02D7678C2
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 00:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbjG1W7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 18:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjG1W7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 18:59:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C170BF;
        Fri, 28 Jul 2023 15:58:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A65CD621FF;
        Fri, 28 Jul 2023 22:58:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24D7C433C7;
        Fri, 28 Jul 2023 22:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690585137;
        bh=RKOFHEukRXed9nKfvhFMXNLlxZWTGs+xAWMhRdXyYhQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Xn+rtLDZpbr4tjW7tkJx/dG919958uc93w84cX2kQP5bWEV7NFt6KO3nBuN9iITi+
         35RqLujqbbnecrbjHq1RXlKZjRb7LjTWDO2nJVqNgOgbh0wFu3GEDWjYvXKAiMSkVG
         24h7DNFpsMY3SHZdcgZMG5YSwfAYji5QTFHEQzcDcLwN0CjZU3Ex3oAa5t0xBJcrdP
         DT7IGoCReQtYntfx344+0S9gfcK/0mjOYa7vZS3BDPIFi8jcJ2/5CkWl27LZg1sKmu
         yEwV4Nnj3Fh+P0xDpXNwroWzQXA+P6WarS2HsqUchV0sS9AiwEYbJCw/MC2JBxz8pA
         +ji13fRA+iqpQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 800C0CE093C; Fri, 28 Jul 2023 15:58:56 -0700 (PDT)
Date:   Fri, 28 Jul 2023 15:58:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH 6.4 000/227] 6.4.7-rc1 review
Message-ID: <a174c501-48df-404e-ae61-10ddaeb8e557@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <D56D0318-A2EA-4448-8F4D-BE84706E26A5@joelfernandes.org>
 <99B56FC7-9474-4968-B1DD-5862572FD0BA@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99B56FC7-9474-4968-B1DD-5862572FD0BA@joelfernandes.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,WEIRD_PORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Jul 28, 2023 at 05:17:59PM -0400, Joel Fernandes wrote:
>
>   On Jul 27, 2023, at 7:18 PM, Joel Fernandes <joel@joelfernandes.org>
>   wrote:
>
> ﻿
>
>   On Jul 27, 2023, at 4:33 PM, Paul E. McKenney <paulmck@kernel.org>
>   wrote:
>
>   ﻿On Thu, Jul 27, 2023 at 10:39:17AM -0700, Guenter Roeck wrote:
>
>   On 7/27/23 09:07, Paul E. McKenney wrote:
>
>   ...]
>
>   No. However, (unrelated) in linux-next, rcu tests sometimes result
>   in apparent hangs
>
>   or long runtime.
>
>   [    0.778841] Mount-cache hash table entries: 512 (order: 0, 4096
>   bytes, linear)
>
>   [    0.779011] Mountpoint-cache hash table entries: 512 (order: 0,
>   4096 bytes, linear)
>
>   [    0.797998] Running RCU synchronous self tests
>
>   [    0.798209] Running RCU synchronous self tests
>
>   [    0.912368] smpboot: CPU0: AMD Opteron 63xx class CPU (family:
>   0x15, model: 0x2, stepping: 0x0)
>
>   [    0.923398] RCU Tasks: Setting shift to 2 and lim to 1
>   rcu_task_cb_adjust=1.
>
>   [    0.925419] Running RCU-tasks wait API self tests
>
>   (hangs until aborted). This is primarily with Opteron CPUs, but also
>   with others such as Haswell,
>
>   Icelake-Server, and pentium3. It is all but impossible to bisect
>   because it doesn't happen
>
>   all the time. All I was able to figure out was that it has to do
>   with rcu changes in linux-next.
>
>   I'd be much more concerned about that.
>
>   First I have heard of this, so thank you for letting me know.
>
>   About what fraction of the time does this happen?
>
>   Here is a sample test log from yesterday's -next. This is with
>   x86_64.
>
>   Today's -next always crashes, so no data.
>
>   Building
>   x86_64:q35:Broadwell-noTSX:defconfig:smp:net,e1000:mem256:ata:hd ...
>   running ....... passed
>
>   Building
>   x86_64:q35:Cascadelake-Server:defconfig:smp:net,e1000e:mem256:ata:cd
>   ... running .................R....... passed
>
>   Building
>   x86_64:q35:IvyBridge:defconfig:smp2:net,i82801:efi:mem512:nvme:hd
>   ... running ...... passed
>
>   Building
>   x86_64:q35:SandyBridge:defconfig:smp4:net,ne2k_pci:efi32:mem1G:usb:h
>   d ... running ......... passed
>
>   Building
>   x86_64:q35:SandyBridge:defconfig:smp8:net,ne2k_pci:mem1G:usb-hub:hd
>   ... running ....... passed
>
>   Building
>   x86_64:q35:Haswell:defconfig:smp:tpm-tis:net,pcnet:mem2G:usb-uas:hd
>   ... running .................R.... passed
>
>   Building
>   x86_64:q35:Skylake-Client:defconfig:smp2:tpm-tis:net,rtl8139:efi:mem
>   4G:sdhci:mmc:hd ... running ....... passed
>
>   Building
>   x86_64:q35:Conroe:defconfig:smp4:net,tulip:efi32:mem256:scsi[DC395]:
>   hd ... running ....... passed
>
>   Building
>   x86_64:q35:Denverton:defconfig:smp2:net,tulip:efi:mem256:scsi[DC395]
>   :hd ... running ....... passed
>
>   Building
>   x86_64:q35:EPYC-Milan:defconfig:smp:tpm-crb:net,tulip:mem256:scsi[DC
>   395]:hd ... running ....... passed
>
>   Building
>   x86_64:q35:Nehalem:defconfig:smp:net,virtio-net:mem512:scsi[AM53C974
>   ]:hd ... running ....... passed
>
>   Building
>   x86_64:q35:Nehalem:defconfig:smp:net,virtio-net-old:mem512:scsi[AM53
>   C974]:hd ... running ....... passed
>
>   Building
>   x86_64:q35:Westmere-IBRS:defconfig:smp2:tpm-crb:net,usb-ohci:efi:mem
>   1G:scsi[53C810]:cd ... running .................R........... passed
>
>   Building
>   x86_64:q35:Skylake-Server:defconfig:smp4:tpm-tis:net,e1000-82544gc:e
>   fi32:mem2G:scsi[53C895A]:hd ... running ............. passed
>
>   Building
>   x86_64:pc:EPYC:defconfig:smp:pci-bridge:net,usb-uhci:mem4G:scsi[FUSI
>   ON]:hd ... running ..................R.......... passed
>
>   Building
>   x86_64:q35:EPYC-IBPB:defconfig:smp2:net,e1000-82545em:efi:mem8G:scsi
>   [MEGASAS]:hd ... running ....... passed
>
>   Building
>   x86_64:q35:Opteron_G5:defconfig:smp4:net,i82559c:efi32:mem256:scsi[M
>   EGASAS2]:hd ... running ...... passed
>
>   Building
>   x86_64:q35:Opteron_G5:defconfig:smp4:net,i82559c:mem256:scsi[MEGASAS
>   2]:hd ... running .................R.............. failed (silent)
>
>   Building
>   x86_64:pc:Opteron_G5:defconfig:smp4:net,i82559c:mem256:scsi[MEGASAS2
>   ]:hd ... running .......... passed
>
>   Building x86_64:pc:phenom:defconfig:smp:net,i82559er:mem512:initrd
>   ... running ........ passed
>
>   Building
>   x86_64:q35:Opteron_G1:defconfig:smp2:net,i82562:efi:mem1G:initrd ...
>   running ...... passed
>
>   Building
>   x86_64:pc:Opteron_G2:defconfig:smp:net,usb:efi32:mem2G:scsi[virtio-p
>   ci]:hd ... running .................R................. passed
>
>   Building
>   x86_64:pc:Opteron_G2:defconfig:smp:net,usb:efi32:mem2G:scsi[virtio-p
>   ci-old]:hd ... running ................... passed
>
>   Building
>   x86_64:q35:core2duo:defconfig:smp2:net,i82559a:mem4G:virtio-pci:hd
>   ... running ......... passed
>
>   Building
>   x86_64:q35:Broadwell:defconfig:smp4:net,i82558b:efi:mem8G:virtio:hd
>   ... running ....... passed
>
>   Building
>   x86_64:q35:Nehalem:defconfig:smp2:net,i82558a:efi32:mem1G:virtio:hd
>   ... running .................R... passed
>
>   Building
>   x86_64:q35:Icelake-Server:defconfig:preempt:smp4:net,ne2k_pci:efi:me
>   m2G:virtio:cd ... running ......... passed
>
>   Building
>   x86_64:q35:Icelake-Server:defconfig:preempt:smp8:net,i82557a:mem4G:n
>   vme:hd ... running ...... passed
>
>   Building
>   x86_64:q35:Skylake-Client-IBRS:defconfig:preempt:smp2:net,i82558b:ef
>   i32:mem1G:sdhci:mmc:hd ... running ...... passed
>
>   Building
>   x86_64:q35:KnightsMill:defconfig:preempt:smp6:net,i82550:mem512:init
>   rd ... running ...... passed
>
>   Building
>   x86_64:q35:Cooperlake:defconfig:smp2:net,usb-ohci:efi:mem1G:scsi[53C
>   810]:hd ... running ....... passed
>
>   Building
>   x86_64:q35:EPYC-Rome:defconfig:smp4:net,igb:mem2G:scsi[53C895A]:hd
>   ... running ......... passed
>
>   Building x86_64:pc:Opteron_G3:defconfig:nosmp:net,e1000:mem1G:usb:hd
>   ... running ....................R................. failed (silent)
>
>   Building
>   x86_64:q35:Opteron_G4:defconfig:nosmp:net,ne2k_pci:efi:mem512:ata:hd
>   ... running .....................R....... passed
>
>   Building
>   x86_64:q35:Haswell-noTSX-IBRS:defconfig:nosmp:net,pcnet:efi32:mem2G:
>   ata:hd ... running .................R.............. failed (silent)
>
>   An earlier test run:
>
>   Building
>   x86_64:q35:Broadwell-noTSX:defconfig:smp:net,e1000:mem256:ata:hd ...
>   running ....... passed
>
>   Building
>   x86_64:q35:Cascadelake-Server:defconfig:smp:net,e1000e:mem256:ata:cd
>   ... running .................R....... passed
>
>   Building
>   x86_64:q35:IvyBridge:defconfig:smp2:net,i82801:efi:mem512:nvme:hd
>   ... running ........ passed
>
>   Building
>   x86_64:q35:SandyBridge:defconfig:smp4:net,ne2k_pci:efi32:mem1G:usb:h
>   d ... running .......... passed
>
>   Building
>   x86_64:q35:SandyBridge:defconfig:smp8:net,ne2k_pci:mem1G:usb-hub:hd
>   ... running ....... passed
>
>   Building
>   x86_64:q35:Haswell:defconfig:smp:tpm-tis:net,pcnet:mem2G:usb-uas:hd
>   ... running .................R.... passed
>
>   Building
>   x86_64:q35:Skylake-Client:defconfig:smp2:tpm-tis:net,rtl8139:efi:mem
>   4G:sdhci:mmc:hd ... running ....... passed
>
>   Building
>   x86_64:q35:Conroe:defconfig:smp4:net,tulip:efi32:mem256:scsi[DC395]:
>   hd ... running ......... passed
>
>   Building
>   x86_64:q35:Denverton:defconfig:smp2:net,tulip:efi:mem256:scsi[DC395]
>   :hd ... running ....... passed
>
>   Building
>   x86_64:q35:EPYC-Milan:defconfig:smp:tpm-crb:net,tulip:mem256:scsi[DC
>   395]:hd ... running ....... passed
>
>   Building
>   x86_64:q35:Nehalem:defconfig:smp:net,virtio-net:mem512:scsi[AM53C974
>   ]:hd ... running ....... passed
>
>   Building
>   x86_64:q35:Nehalem:defconfig:smp:net,virtio-net-old:mem512:scsi[AM53
>   C974]:hd ... running ........ passed
>
>   Building
>   x86_64:q35:Westmere-IBRS:defconfig:smp2:tpm-crb:net,usb-ohci:efi:mem
>   1G:scsi[53C810]:cd ... running .......... passed
>
>   Building
>   x86_64:q35:Skylake-Server:defconfig:smp4:tpm-tis:net,e1000-82544gc:e
>   fi32:mem2G:scsi[53C895A]:hd ... running .................R.....
>   passed
>
>   Building
>   x86_64:pc:EPYC:defconfig:smp:pci-bridge:net,usb-uhci:mem4G:scsi[FUSI
>   ON]:hd ... running .................R.............. failed (silent)
>
>   Building
>   x86_64:q35:EPYC-IBPB:defconfig:smp2:net,e1000-82545em:efi:mem8G:scsi
>   [MEGASAS]:hd ... running ....... passed
>
>   Building
>   x86_64:q35:Opteron_G5:defconfig:smp4:net,i82559c:efi32:mem256:scsi[M
>   EGASAS2]:hd ... running ....... passed
>
>   Building
>   x86_64:q35:Opteron_G5:defconfig:smp4:net,i82559c:mem256:scsi[MEGASAS
>   2]:hd ... running ....... passed
>
>   Building
>   x86_64:pc:Opteron_G5:defconfig:smp4:net,i82559c:mem256:scsi[MEGASAS2
>   ]:hd ... running .......... passed
>
>   Building x86_64:pc:phenom:defconfig:smp:net,i82559er:mem512:initrd
>   ... running ........ passed
>
>   Building
>   x86_64:q35:Opteron_G1:defconfig:smp2:net,i82562:efi:mem1G:initrd ...
>   running ...... passed
>
>   Building
>   x86_64:pc:Opteron_G2:defconfig:smp:net,usb:efi32:mem2G:scsi[virtio-p
>   ci]:hd ... running .......... passed
>
>   Building
>   x86_64:pc:Opteron_G2:defconfig:smp:net,usb:efi32:mem2G:scsi[virtio-p
>   ci-old]:hd ... running .......... passed
>
>   Building
>   x86_64:q35:core2duo:defconfig:smp2:net,i82559a:mem4G:virtio-pci:hd
>   ... running ...... passed
>
>   Building
>   x86_64:q35:Broadwell:defconfig:smp4:net,i82558b:efi:mem8G:virtio:hd
>   ... running ....... passed
>
>   Building
>   x86_64:q35:Nehalem:defconfig:smp2:net,i82558a:efi32:mem1G:virtio:hd
>   ... running ...... passed
>
>   Building
>   x86_64:q35:Icelake-Server:defconfig:preempt:smp4:net,ne2k_pci:efi:me
>   m2G:virtio:cd ... running ......... passed
>
>   Building
>   x86_64:q35:Icelake-Server:defconfig:preempt:smp8:net,i82557a:mem4G:n
>   vme:hd ... running ....... passed
>
>   Building
>   x86_64:q35:Skylake-Client-IBRS:defconfig:preempt:smp2:net,i82558b:ef
>   i32:mem1G:sdhci:mmc:hd ... running ....... passed
>
>   Building
>   x86_64:q35:KnightsMill:defconfig:preempt:smp6:net,i82550:mem512:init
>   rd ... running ....... passed
>
>   Building
>   x86_64:q35:Cooperlake:defconfig:smp2:net,usb-ohci:efi:mem1G:scsi[53C
>   810]:hd ... running ........ passed
>
>   Building
>   x86_64:q35:EPYC-Rome:defconfig:smp4:net,igb:mem2G:scsi[53C895A]:hd
>   ... running ......... passed
>
>   Building x86_64:pc:Opteron_G3:defconfig:nosmp:net,e1000:mem1G:usb:hd
>   ... running ....................R................. failed (silent)
>
>   Building
>   x86_64:q35:Opteron_G4:defconfig:nosmp:net,ne2k_pci:efi:mem512:ata:hd
>   ... running ....... passed
>
>   Building
>   x86_64:q35:Haswell-noTSX-IBRS:defconfig:nosmp:net,pcnet:efi32:mem2G:
>   ata:hd ... running ....... passed
>
>   "R" means retry, and the dots reflect time expired. It looks like it
>   happens most of the time,
>
>   but not always, on affected CPUs. I don't have specific data for
>   non-Intel CPUs. I don't think
>
>   I see the problem there, but there is too much interference from
>   other problems to be sure.
>
>   For comparison, here is the result from the latest mainline:
>
>   Building
>   x86_64:q35:Broadwell-noTSX:defconfig:smp:net,e1000:mem256:ata:hd ...
>   running ....... passed
>
>   Building
>   x86_64:q35:Cascadelake-Server:defconfig:smp:net,e1000e:mem256:ata:cd
>   ... running .......... passed
>
>   Building
>   x86_64:q35:IvyBridge:defconfig:smp2:net,i82801:efi:mem512:nvme:hd
>   ... running ...... passed
>
>   Building
>   x86_64:q35:SandyBridge:defconfig:smp4:net,ne2k_pci:efi32:mem1G:usb:h
>   d ... running ......... passed
>
>   Building
>   x86_64:q35:SandyBridge:defconfig:smp8:net,ne2k_pci:mem1G:usb-hub:hd
>   ... running ........... passed
>
>   Building
>   x86_64:q35:Haswell:defconfig:smp:tpm-tis:net,pcnet:mem2G:usb-uas:hd
>   ... running ........ passed
>
>   Building
>   x86_64:q35:Skylake-Client:defconfig:smp2:tpm-tis:net,rtl8139:efi:mem
>   4G:sdhci:mmc:hd ... running ....... passed
>
>   Building
>   x86_64:q35:Conroe:defconfig:smp4:net,tulip:efi32:mem256:scsi[DC395]:
>   hd ... running ....... passed
>
>   Building
>   x86_64:q35:Denverton:defconfig:smp2:net,tulip:efi:mem256:scsi[DC395]
>   :hd ... running ....... passed
>
>   Building
>   x86_64:q35:EPYC-Milan:defconfig:smp:tpm-crb:net,tulip:mem256:scsi[DC
>   395]:hd ... running ....... passed
>
>   Building
>   x86_64:q35:Nehalem:defconfig:smp:net,virtio-net:mem512:scsi[AM53C974
>   ]:hd ... running ....... passed
>
>   Building
>   x86_64:q35:Nehalem:defconfig:smp:net,virtio-net-old:mem512:scsi[AM53
>   C974]:hd ... running ....... passed
>
>   Building
>   x86_64:q35:Westmere-IBRS:defconfig:smp2:tpm-crb:net,usb-ohci:efi:mem
>   1G:scsi[53C810]:cd ... running .......... passed
>
>   Building
>   x86_64:q35:Skylake-Server:defconfig:smp4:tpm-tis:net,e1000-82544gc:e
>   fi32:mem2G:scsi[53C895A]:hd ... running ....... passed
>
>   Building
>   x86_64:pc:EPYC:defconfig:smp:pci-bridge:net,usb-uhci:mem4G:scsi[FUSI
>   ON]:hd ... running ............. passed
>
>   Building
>   x86_64:q35:EPYC-IBPB:defconfig:smp2:net,e1000-82545em:efi:mem8G:scsi
>   [MEGASAS]:hd ... running ....... passed
>
>   Building
>   x86_64:q35:Opteron_G5:defconfig:smp4:net,i82559c:efi32:mem256:scsi[M
>   EGASAS2]:hd ... running ....... passed
>
>   Building
>   x86_64:q35:Opteron_G5:defconfig:smp4:net,i82559c:mem256:scsi[MEGASAS
>   2]:hd ... running ...... passed
>
>   Building
>   x86_64:pc:Opteron_G5:defconfig:smp4:net,i82559c:mem256:scsi[MEGASAS2
>   ]:hd ... running ......... passed
>
>   Building x86_64:pc:phenom:defconfig:smp:net,i82559er:mem512:initrd
>   ... running ......... passed
>
>   Building
>   x86_64:q35:Opteron_G1:defconfig:smp2:net,i82562:efi:mem1G:initrd ...
>   running ......... passed
>
>   Building
>   x86_64:pc:Opteron_G2:defconfig:smp:net,usb:efi32:mem2G:scsi[virtio-p
>   ci]:hd ... running ......... passed
>
>   Building
>   x86_64:pc:Opteron_G2:defconfig:smp:net,usb:efi32:mem2G:scsi[virtio-p
>   ci-old]:hd ... running ......... passed
>
>   Building
>   x86_64:q35:core2duo:defconfig:smp2:net,i82559a:mem4G:virtio-pci:hd
>   ... running ...... passed
>
>   Building
>   x86_64:q35:Broadwell:defconfig:smp4:net,i82558b:efi:mem8G:virtio:hd
>   ... running ....... passed
>
>   Building
>   x86_64:q35:Nehalem:defconfig:smp2:net,i82558a:efi32:mem1G:virtio:hd
>   ... running ...... passed
>
>   Building
>   x86_64:q35:Icelake-Server:defconfig:preempt:smp4:net,ne2k_pci:efi:me
>   m2G:virtio:cd ... running ............ passed
>
>   Building
>   x86_64:q35:Icelake-Server:defconfig:preempt:smp8:net,i82557a:mem4G:n
>   vme:hd ... running ....... passed
>
>   Building
>   x86_64:q35:Skylake-Client-IBRS:defconfig:preempt:smp2:net,i82558b:ef
>   i32:mem1G:sdhci:mmc:hd ... running ...... passed
>
>   Building
>   x86_64:q35:KnightsMill:defconfig:preempt:smp6:net,i82550:mem512:init
>   rd ... running ...... passed
>
>   Building
>   x86_64:q35:Cooperlake:defconfig:smp2:net,usb-ohci:efi:mem1G:scsi[53C
>   810]:hd ... running ....... passed
>
>   Building
>   x86_64:q35:EPYC-Rome:defconfig:smp4:net,igb:mem2G:scsi[53C895A]:hd
>   ... running .......... passed
>
>   Building x86_64:pc:Opteron_G3:defconfig:nosmp:net,e1000:mem1G:usb:hd
>   ... running .......... passed
>
>   Building
>   x86_64:q35:Opteron_G4:defconfig:nosmp:net,ne2k_pci:efi:mem512:ata:hd
>   ... running ...... passed
>
>   Building
>   x86_64:q35:Haswell-noTSX-IBRS:defconfig:nosmp:net,pcnet:efi32:mem2G:
>   ata:hd ... running ...... passed
>
>   I freely confess that I am having a hard time imagining what would
>
>   be CPU dependent in that code.  Timing, maybe?  Whatever the reason,
>
>   I am not seeing these failures in my testing.
>
>   So which of the following Kconfig options is defined in your
>   .config?
>
>   CONFIG_TASKS_RCU, CONFIG_TASKS_RUDE_RCU, and CONFIG_TASKS_TRACE_RCU.
>
>   If you have more than one of them, could you please apply this patch
>
>   and show me the corresponding console output from the resulting
>   hang?
>
> FWIW, I am not able to repro this issue either. If a .config can be
> shared of the problem system, I can try it out to see if it can be
> reproduced on my side.
>
> I do see this now on 5.15 stable:
>
>TASKS03 ------- 3089 GPs (0.858056/s)
>QEMU killed
>TASKS03 no success message, 64 successful version messages
>!!! PID 3309783 hung at 3781 vs. 3600 seconds
>
> I have not looked too closely yet. The full test artifacts are here:
>
> [1]Artifacts of linux-5.15.y 5.15.123 :
> /tools/testing/selftests/rcutorture/res/2023.07.28-04.00.44 [Jenkins]
> [2]box.joelfernandes.org
> [3]apple-touch-icon.png
>
> Thanks,
>
> - Joel
>
> (Apologies if the email is html, I am sending from phone).

Heh.  I have a script that runs lynx.  Which isn't perfect, but usually
makes things at least somewhat legible.

This looks like the prototypical hard hang with interrupts disabled,
which could be anywhere in the kernel, including RCU.  I am not seeing
this.  but the usual cause when I have seen it in the past was deadlock
of irq-disabled locks.  In one spectacular case, it was a timekeeping
failure that messed up a CPU-hotplug operation.

If this is reproducible, one trick would be to have a script look at
the console.log file, and have it do something (NMI? sysrq?  something
else?) to qemu if output ceased for too long.

One way to do this without messing with the rcutorture scripting is to
grab the qemu-cmd file from this run, and then invoke that file from your
own script, possibly with suitable modifications to qemu's parameters.

Thoughts?

							Thanx, Paul

> Cheers,
> - Joel
>
>                             Thanx, Paul
>
>   --------------------------------------------------------------------
>   ----
>
>   commit 709a917710dc01798e01750ea628ece4bfc42b7b
>
>   Author: Paul E. McKenney <paulmck@kernel.org>
>
>   Date:   Thu Jul 27 13:13:46 2023 -0700
>
>     rcu-tasks: Add printk()s to localize boot-time self-test hang
>
>     Currently, rcu_tasks_initiate_self_tests() prints a message and
>   then
>
>     initiates self tests on up to three different RCU Tasks flavors.
>   If one
>
>     of the flavors has a grace-period hang, it is not easy to work out
>   which
>
>     of the three hung.  This commit therefore prints a message prior
>   to each
>
>     individual test.
>
>     Reported-by: Guenter Roeck <linux@roeck-us.net>
>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
>   diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
>
>   index 56c470a489c8..427433c90935 100644
>
>   --- a/kernel/rcu/tasks.h
>
>   +++ b/kernel/rcu/tasks.h
>
>   @@ -1981,20 +1981,22 @@ static void test_rcu_tasks_callback(struct
>   rcu_head *rhp)
>
>   static void rcu_tasks_initiate_self_tests(void)
>
>   {
>
>   -    pr_info("Running RCU-tasks wait API self tests\n");
>
>   #ifdef CONFIG_TASKS_RCU
>
>   +    pr_info("Running RCU Tasks wait API self tests\n");
>
>     tests[0].runstart = jiffies;
>
>     synchronize_rcu_tasks();
>
>     call_rcu_tasks(&tests[0].rh, test_rcu_tasks_callback);
>
>   #endif
>
>   #ifdef CONFIG_TASKS_RUDE_RCU
>
>   +    pr_info("Running RCU Tasks Rude wait API self tests\n");
>
>     tests[1].runstart = jiffies;
>
>     synchronize_rcu_tasks_rude();
>
>     call_rcu_tasks_rude(&tests[1].rh, test_rcu_tasks_callback);
>
>   #endif
>
>   #ifdef CONFIG_TASKS_TRACE_RCU
>
>   +    pr_info("Running RCU Tasks Trace wait API self tests\n");
>
>     tests[2].runstart = jiffies;
>
>     synchronize_rcu_tasks_trace();
>
>     call_rcu_tasks_trace(&tests[2].rh, test_rcu_tasks_callback);
>
>References
>
> Visible links:
> 1. http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-5.15.y/lastFailedBuild/artifact/tools/testing/selftests/rcutorture/res/2023.07.28-04.00.44/
> 2. http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-5.15.y/lastFailedBuild/artifact/tools/testing/selftests/rcutorture/res/2023.07.28-04.00.44/
> 3. http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-5.15.y/lastFailedBuild/artifact/tools/testing/selftests/rcutorture/res/2023.07.28-04.00.44/
>
> Hidden links:
> 5. http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-5.15.y/lastFailedBuild/artifact/tools/testing/selftests/rcutorture/res/2023.07.28-04.00.44/
