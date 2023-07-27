Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209CE765D71
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 22:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbjG0UdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 16:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbjG0UdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 16:33:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8663FA3;
        Thu, 27 Jul 2023 13:33:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 027FE61F42;
        Thu, 27 Jul 2023 20:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EDF2C433C7;
        Thu, 27 Jul 2023 20:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690489983;
        bh=JEIdymq+g+5UHf99oQEYRN4H+4AZpmCrc9bz8NXf+zE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kAgv9n2B9Zh+vqvt181oI7bwCN+TbrbCI8rseXe+/m37HmP4pkl2J7HAHG0LSSO5B
         3cY05dGyDRk9vWYcw9GQk7MN+mvh+7ryXGdtPimBRz+iAsAs7YG1x7BuxUqVSqAryu
         Z1OoUcAvVvyYI3AQm5vXXFaMwOWXk0J2mTWW535e8tz3WyStE+bXzZsceJT8UDL8ml
         nWBtdscF726c8AeVZNpY0dlHHFbxEkpDVl6r52MlKILgDjNFKWCAVqomvMPIeaKBTC
         F+ixzu+auvjSW13veelOD+UMiZsscaWbKrM0pf1b30Ah3PK7SWJSYH95IfRn7MH0zE
         LQWIMG8+PPWEg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D495DCE0B04; Thu, 27 Jul 2023 13:33:02 -0700 (PDT)
Date:   Thu, 27 Jul 2023 13:33:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH 6.4 000/227] 6.4.7-rc1 review
Message-ID: <2cfc68cc-3a2f-4350-a711-ef0c0d8385fd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ZMJWet00+9yIl/9c@duo.ucw.cz>
 <78722041-D1F7-45FA-BA1C-41B92209BA6C@joelfernandes.org>
 <0751f5a8-2727-4a08-8bb8-50bbd4244c9c@paulmck-laptop>
 <67eba84a-ae24-2983-a756-463f39f3ca71@roeck-us.net>
 <ebe4a969-8a24-4bb8-8dbe-f77db89f65c9@paulmck-laptop>
 <2f4b012e-1f95-30aa-3f43-c31e84cb2c42@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f4b012e-1f95-30aa-3f43-c31e84cb2c42@roeck-us.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 10:39:17AM -0700, Guenter Roeck wrote:
> On 7/27/23 09:07, Paul E. McKenney wrote:
> 
> ...]
> 
> > > No. However, (unrelated) in linux-next, rcu tests sometimes result in apparent hangs
> > > or long runtime.
> > > 
> > > [    0.778841] Mount-cache hash table entries: 512 (order: 0, 4096 bytes, linear)
> > > [    0.779011] Mountpoint-cache hash table entries: 512 (order: 0, 4096 bytes, linear)
> > > [    0.797998] Running RCU synchronous self tests
> > > [    0.798209] Running RCU synchronous self tests
> > > [    0.912368] smpboot: CPU0: AMD Opteron 63xx class CPU (family: 0x15, model: 0x2, stepping: 0x0)
> > > [    0.923398] RCU Tasks: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1.
> > > [    0.925419] Running RCU-tasks wait API self tests
> > > 
> > > (hangs until aborted). This is primarily with Opteron CPUs, but also with others such as Haswell,
> > > Icelake-Server, and pentium3. It is all but impossible to bisect because it doesn't happen
> > > all the time. All I was able to figure out was that it has to do with rcu changes in linux-next.
> > > I'd be much more concerned about that.
> > 
> > First I have heard of this, so thank you for letting me know.
> > 
> > About what fraction of the time does this happen?
> > 
> 
> Here is a sample test log from yesterday's -next. This is with x86_64.
> Today's -next always crashes, so no data.
> 
> Building x86_64:q35:Broadwell-noTSX:defconfig:smp:net,e1000:mem256:ata:hd ... running ....... passed
> Building x86_64:q35:Cascadelake-Server:defconfig:smp:net,e1000e:mem256:ata:cd ... running .................R....... passed
> Building x86_64:q35:IvyBridge:defconfig:smp2:net,i82801:efi:mem512:nvme:hd ... running ...... passed
> Building x86_64:q35:SandyBridge:defconfig:smp4:net,ne2k_pci:efi32:mem1G:usb:hd ... running ......... passed
> Building x86_64:q35:SandyBridge:defconfig:smp8:net,ne2k_pci:mem1G:usb-hub:hd ... running ....... passed
> Building x86_64:q35:Haswell:defconfig:smp:tpm-tis:net,pcnet:mem2G:usb-uas:hd ... running .................R.... passed
> Building x86_64:q35:Skylake-Client:defconfig:smp2:tpm-tis:net,rtl8139:efi:mem4G:sdhci:mmc:hd ... running ....... passed
> Building x86_64:q35:Conroe:defconfig:smp4:net,tulip:efi32:mem256:scsi[DC395]:hd ... running ....... passed
> Building x86_64:q35:Denverton:defconfig:smp2:net,tulip:efi:mem256:scsi[DC395]:hd ... running ....... passed
> Building x86_64:q35:EPYC-Milan:defconfig:smp:tpm-crb:net,tulip:mem256:scsi[DC395]:hd ... running ....... passed
> Building x86_64:q35:Nehalem:defconfig:smp:net,virtio-net:mem512:scsi[AM53C974]:hd ... running ....... passed
> Building x86_64:q35:Nehalem:defconfig:smp:net,virtio-net-old:mem512:scsi[AM53C974]:hd ... running ....... passed
> Building x86_64:q35:Westmere-IBRS:defconfig:smp2:tpm-crb:net,usb-ohci:efi:mem1G:scsi[53C810]:cd ... running .................R........... passed
> Building x86_64:q35:Skylake-Server:defconfig:smp4:tpm-tis:net,e1000-82544gc:efi32:mem2G:scsi[53C895A]:hd ... running ............. passed
> Building x86_64:pc:EPYC:defconfig:smp:pci-bridge:net,usb-uhci:mem4G:scsi[FUSION]:hd ... running ..................R.......... passed
> Building x86_64:q35:EPYC-IBPB:defconfig:smp2:net,e1000-82545em:efi:mem8G:scsi[MEGASAS]:hd ... running ....... passed
> Building x86_64:q35:Opteron_G5:defconfig:smp4:net,i82559c:efi32:mem256:scsi[MEGASAS2]:hd ... running ...... passed
> Building x86_64:q35:Opteron_G5:defconfig:smp4:net,i82559c:mem256:scsi[MEGASAS2]:hd ... running .................R.............. failed (silent)
> Building x86_64:pc:Opteron_G5:defconfig:smp4:net,i82559c:mem256:scsi[MEGASAS2]:hd ... running .......... passed
> Building x86_64:pc:phenom:defconfig:smp:net,i82559er:mem512:initrd ... running ........ passed
> Building x86_64:q35:Opteron_G1:defconfig:smp2:net,i82562:efi:mem1G:initrd ... running ...... passed
> Building x86_64:pc:Opteron_G2:defconfig:smp:net,usb:efi32:mem2G:scsi[virtio-pci]:hd ... running .................R................. passed
> Building x86_64:pc:Opteron_G2:defconfig:smp:net,usb:efi32:mem2G:scsi[virtio-pci-old]:hd ... running ................... passed
> Building x86_64:q35:core2duo:defconfig:smp2:net,i82559a:mem4G:virtio-pci:hd ... running ......... passed
> Building x86_64:q35:Broadwell:defconfig:smp4:net,i82558b:efi:mem8G:virtio:hd ... running ....... passed
> Building x86_64:q35:Nehalem:defconfig:smp2:net,i82558a:efi32:mem1G:virtio:hd ... running .................R... passed
> Building x86_64:q35:Icelake-Server:defconfig:preempt:smp4:net,ne2k_pci:efi:mem2G:virtio:cd ... running ......... passed
> Building x86_64:q35:Icelake-Server:defconfig:preempt:smp8:net,i82557a:mem4G:nvme:hd ... running ...... passed
> Building x86_64:q35:Skylake-Client-IBRS:defconfig:preempt:smp2:net,i82558b:efi32:mem1G:sdhci:mmc:hd ... running ...... passed
> Building x86_64:q35:KnightsMill:defconfig:preempt:smp6:net,i82550:mem512:initrd ... running ...... passed
> Building x86_64:q35:Cooperlake:defconfig:smp2:net,usb-ohci:efi:mem1G:scsi[53C810]:hd ... running ....... passed
> Building x86_64:q35:EPYC-Rome:defconfig:smp4:net,igb:mem2G:scsi[53C895A]:hd ... running ......... passed
> Building x86_64:pc:Opteron_G3:defconfig:nosmp:net,e1000:mem1G:usb:hd ... running ....................R................. failed (silent)
> Building x86_64:q35:Opteron_G4:defconfig:nosmp:net,ne2k_pci:efi:mem512:ata:hd ... running .....................R....... passed
> Building x86_64:q35:Haswell-noTSX-IBRS:defconfig:nosmp:net,pcnet:efi32:mem2G:ata:hd ... running .................R.............. failed (silent)
> 
> An earlier test run:
> 
> Building x86_64:q35:Broadwell-noTSX:defconfig:smp:net,e1000:mem256:ata:hd ... running ....... passed
> Building x86_64:q35:Cascadelake-Server:defconfig:smp:net,e1000e:mem256:ata:cd ... running .................R....... passed
> Building x86_64:q35:IvyBridge:defconfig:smp2:net,i82801:efi:mem512:nvme:hd ... running ........ passed
> Building x86_64:q35:SandyBridge:defconfig:smp4:net,ne2k_pci:efi32:mem1G:usb:hd ... running .......... passed
> Building x86_64:q35:SandyBridge:defconfig:smp8:net,ne2k_pci:mem1G:usb-hub:hd ... running ....... passed
> Building x86_64:q35:Haswell:defconfig:smp:tpm-tis:net,pcnet:mem2G:usb-uas:hd ... running .................R.... passed
> Building x86_64:q35:Skylake-Client:defconfig:smp2:tpm-tis:net,rtl8139:efi:mem4G:sdhci:mmc:hd ... running ....... passed
> Building x86_64:q35:Conroe:defconfig:smp4:net,tulip:efi32:mem256:scsi[DC395]:hd ... running ......... passed
> Building x86_64:q35:Denverton:defconfig:smp2:net,tulip:efi:mem256:scsi[DC395]:hd ... running ....... passed
> Building x86_64:q35:EPYC-Milan:defconfig:smp:tpm-crb:net,tulip:mem256:scsi[DC395]:hd ... running ....... passed
> Building x86_64:q35:Nehalem:defconfig:smp:net,virtio-net:mem512:scsi[AM53C974]:hd ... running ....... passed
> Building x86_64:q35:Nehalem:defconfig:smp:net,virtio-net-old:mem512:scsi[AM53C974]:hd ... running ........ passed
> Building x86_64:q35:Westmere-IBRS:defconfig:smp2:tpm-crb:net,usb-ohci:efi:mem1G:scsi[53C810]:cd ... running .......... passed
> Building x86_64:q35:Skylake-Server:defconfig:smp4:tpm-tis:net,e1000-82544gc:efi32:mem2G:scsi[53C895A]:hd ... running .................R..... passed
> Building x86_64:pc:EPYC:defconfig:smp:pci-bridge:net,usb-uhci:mem4G:scsi[FUSION]:hd ... running .................R.............. failed (silent)
> Building x86_64:q35:EPYC-IBPB:defconfig:smp2:net,e1000-82545em:efi:mem8G:scsi[MEGASAS]:hd ... running ....... passed
> Building x86_64:q35:Opteron_G5:defconfig:smp4:net,i82559c:efi32:mem256:scsi[MEGASAS2]:hd ... running ....... passed
> Building x86_64:q35:Opteron_G5:defconfig:smp4:net,i82559c:mem256:scsi[MEGASAS2]:hd ... running ....... passed
> Building x86_64:pc:Opteron_G5:defconfig:smp4:net,i82559c:mem256:scsi[MEGASAS2]:hd ... running .......... passed
> Building x86_64:pc:phenom:defconfig:smp:net,i82559er:mem512:initrd ... running ........ passed
> Building x86_64:q35:Opteron_G1:defconfig:smp2:net,i82562:efi:mem1G:initrd ... running ...... passed
> Building x86_64:pc:Opteron_G2:defconfig:smp:net,usb:efi32:mem2G:scsi[virtio-pci]:hd ... running .......... passed
> Building x86_64:pc:Opteron_G2:defconfig:smp:net,usb:efi32:mem2G:scsi[virtio-pci-old]:hd ... running .......... passed
> Building x86_64:q35:core2duo:defconfig:smp2:net,i82559a:mem4G:virtio-pci:hd ... running ...... passed
> Building x86_64:q35:Broadwell:defconfig:smp4:net,i82558b:efi:mem8G:virtio:hd ... running ....... passed
> Building x86_64:q35:Nehalem:defconfig:smp2:net,i82558a:efi32:mem1G:virtio:hd ... running ...... passed
> Building x86_64:q35:Icelake-Server:defconfig:preempt:smp4:net,ne2k_pci:efi:mem2G:virtio:cd ... running ......... passed
> Building x86_64:q35:Icelake-Server:defconfig:preempt:smp8:net,i82557a:mem4G:nvme:hd ... running ....... passed
> Building x86_64:q35:Skylake-Client-IBRS:defconfig:preempt:smp2:net,i82558b:efi32:mem1G:sdhci:mmc:hd ... running ....... passed
> Building x86_64:q35:KnightsMill:defconfig:preempt:smp6:net,i82550:mem512:initrd ... running ....... passed
> Building x86_64:q35:Cooperlake:defconfig:smp2:net,usb-ohci:efi:mem1G:scsi[53C810]:hd ... running ........ passed
> Building x86_64:q35:EPYC-Rome:defconfig:smp4:net,igb:mem2G:scsi[53C895A]:hd ... running ......... passed
> Building x86_64:pc:Opteron_G3:defconfig:nosmp:net,e1000:mem1G:usb:hd ... running ....................R................. failed (silent)
> Building x86_64:q35:Opteron_G4:defconfig:nosmp:net,ne2k_pci:efi:mem512:ata:hd ... running ....... passed
> Building x86_64:q35:Haswell-noTSX-IBRS:defconfig:nosmp:net,pcnet:efi32:mem2G:ata:hd ... running ....... passed
> 
> "R" means retry, and the dots reflect time expired. It looks like it happens most of the time,
> but not always, on affected CPUs. I don't have specific data for non-Intel CPUs. I don't think
> I see the problem there, but there is too much interference from other problems to be sure.
> 
> For comparison, here is the result from the latest mainline:
> 
> Building x86_64:q35:Broadwell-noTSX:defconfig:smp:net,e1000:mem256:ata:hd ... running ....... passed
> Building x86_64:q35:Cascadelake-Server:defconfig:smp:net,e1000e:mem256:ata:cd ... running .......... passed
> Building x86_64:q35:IvyBridge:defconfig:smp2:net,i82801:efi:mem512:nvme:hd ... running ...... passed
> Building x86_64:q35:SandyBridge:defconfig:smp4:net,ne2k_pci:efi32:mem1G:usb:hd ... running ......... passed
> Building x86_64:q35:SandyBridge:defconfig:smp8:net,ne2k_pci:mem1G:usb-hub:hd ... running ........... passed
> Building x86_64:q35:Haswell:defconfig:smp:tpm-tis:net,pcnet:mem2G:usb-uas:hd ... running ........ passed
> Building x86_64:q35:Skylake-Client:defconfig:smp2:tpm-tis:net,rtl8139:efi:mem4G:sdhci:mmc:hd ... running ....... passed
> Building x86_64:q35:Conroe:defconfig:smp4:net,tulip:efi32:mem256:scsi[DC395]:hd ... running ....... passed
> Building x86_64:q35:Denverton:defconfig:smp2:net,tulip:efi:mem256:scsi[DC395]:hd ... running ....... passed
> Building x86_64:q35:EPYC-Milan:defconfig:smp:tpm-crb:net,tulip:mem256:scsi[DC395]:hd ... running ....... passed
> Building x86_64:q35:Nehalem:defconfig:smp:net,virtio-net:mem512:scsi[AM53C974]:hd ... running ....... passed
> Building x86_64:q35:Nehalem:defconfig:smp:net,virtio-net-old:mem512:scsi[AM53C974]:hd ... running ....... passed
> Building x86_64:q35:Westmere-IBRS:defconfig:smp2:tpm-crb:net,usb-ohci:efi:mem1G:scsi[53C810]:cd ... running .......... passed
> Building x86_64:q35:Skylake-Server:defconfig:smp4:tpm-tis:net,e1000-82544gc:efi32:mem2G:scsi[53C895A]:hd ... running ....... passed
> Building x86_64:pc:EPYC:defconfig:smp:pci-bridge:net,usb-uhci:mem4G:scsi[FUSION]:hd ... running ............. passed
> Building x86_64:q35:EPYC-IBPB:defconfig:smp2:net,e1000-82545em:efi:mem8G:scsi[MEGASAS]:hd ... running ....... passed
> Building x86_64:q35:Opteron_G5:defconfig:smp4:net,i82559c:efi32:mem256:scsi[MEGASAS2]:hd ... running ....... passed
> Building x86_64:q35:Opteron_G5:defconfig:smp4:net,i82559c:mem256:scsi[MEGASAS2]:hd ... running ...... passed
> Building x86_64:pc:Opteron_G5:defconfig:smp4:net,i82559c:mem256:scsi[MEGASAS2]:hd ... running ......... passed
> Building x86_64:pc:phenom:defconfig:smp:net,i82559er:mem512:initrd ... running ......... passed
> Building x86_64:q35:Opteron_G1:defconfig:smp2:net,i82562:efi:mem1G:initrd ... running ......... passed
> Building x86_64:pc:Opteron_G2:defconfig:smp:net,usb:efi32:mem2G:scsi[virtio-pci]:hd ... running ......... passed
> Building x86_64:pc:Opteron_G2:defconfig:smp:net,usb:efi32:mem2G:scsi[virtio-pci-old]:hd ... running ......... passed
> Building x86_64:q35:core2duo:defconfig:smp2:net,i82559a:mem4G:virtio-pci:hd ... running ...... passed
> Building x86_64:q35:Broadwell:defconfig:smp4:net,i82558b:efi:mem8G:virtio:hd ... running ....... passed
> Building x86_64:q35:Nehalem:defconfig:smp2:net,i82558a:efi32:mem1G:virtio:hd ... running ...... passed
> Building x86_64:q35:Icelake-Server:defconfig:preempt:smp4:net,ne2k_pci:efi:mem2G:virtio:cd ... running ............ passed
> Building x86_64:q35:Icelake-Server:defconfig:preempt:smp8:net,i82557a:mem4G:nvme:hd ... running ....... passed
> Building x86_64:q35:Skylake-Client-IBRS:defconfig:preempt:smp2:net,i82558b:efi32:mem1G:sdhci:mmc:hd ... running ...... passed
> Building x86_64:q35:KnightsMill:defconfig:preempt:smp6:net,i82550:mem512:initrd ... running ...... passed
> Building x86_64:q35:Cooperlake:defconfig:smp2:net,usb-ohci:efi:mem1G:scsi[53C810]:hd ... running ....... passed
> Building x86_64:q35:EPYC-Rome:defconfig:smp4:net,igb:mem2G:scsi[53C895A]:hd ... running .......... passed
> Building x86_64:pc:Opteron_G3:defconfig:nosmp:net,e1000:mem1G:usb:hd ... running .......... passed
> Building x86_64:q35:Opteron_G4:defconfig:nosmp:net,ne2k_pci:efi:mem512:ata:hd ... running ...... passed
> Building x86_64:q35:Haswell-noTSX-IBRS:defconfig:nosmp:net,pcnet:efi32:mem2G:ata:hd ... running ...... passed

I freely confess that I am having a hard time imagining what would
be CPU dependent in that code.  Timing, maybe?  Whatever the reason,
I am not seeing these failures in my testing.

So which of the following Kconfig options is defined in your .config?
CONFIG_TASKS_RCU, CONFIG_TASKS_RUDE_RCU, and CONFIG_TASKS_TRACE_RCU.

If you have more than one of them, could you please apply this patch
and show me the corresponding console output from the resulting hang?

							Thanx, Paul

------------------------------------------------------------------------

commit 709a917710dc01798e01750ea628ece4bfc42b7b
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Jul 27 13:13:46 2023 -0700

    rcu-tasks: Add printk()s to localize boot-time self-test hang
    
    Currently, rcu_tasks_initiate_self_tests() prints a message and then
    initiates self tests on up to three different RCU Tasks flavors.  If one
    of the flavors has a grace-period hang, it is not easy to work out which
    of the three hung.  This commit therefore prints a message prior to each
    individual test.
    
    Reported-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 56c470a489c8..427433c90935 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1981,20 +1981,22 @@ static void test_rcu_tasks_callback(struct rcu_head *rhp)
 
 static void rcu_tasks_initiate_self_tests(void)
 {
-	pr_info("Running RCU-tasks wait API self tests\n");
 #ifdef CONFIG_TASKS_RCU
+	pr_info("Running RCU Tasks wait API self tests\n");
 	tests[0].runstart = jiffies;
 	synchronize_rcu_tasks();
 	call_rcu_tasks(&tests[0].rh, test_rcu_tasks_callback);
 #endif
 
 #ifdef CONFIG_TASKS_RUDE_RCU
+	pr_info("Running RCU Tasks Rude wait API self tests\n");
 	tests[1].runstart = jiffies;
 	synchronize_rcu_tasks_rude();
 	call_rcu_tasks_rude(&tests[1].rh, test_rcu_tasks_callback);
 #endif
 
 #ifdef CONFIG_TASKS_TRACE_RCU
+	pr_info("Running RCU Tasks Trace wait API self tests\n");
 	tests[2].runstart = jiffies;
 	synchronize_rcu_tasks_trace();
 	call_rcu_tasks_trace(&tests[2].rh, test_rcu_tasks_callback);
