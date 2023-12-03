Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459B98023F8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 14:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbjLCM3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 07:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCM3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 07:29:39 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AB0AB;
        Sun,  3 Dec 2023 04:29:44 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id E196C3200A51;
        Sun,  3 Dec 2023 07:29:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 03 Dec 2023 07:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1701606580; x=
        1701692980; bh=GOwoFAR8GHE2hmMC7toWGpEGxnv7HNMn1zEazKgNcs8=; b=O
        r7RGwxKxaHzN7uXr99A2ovW4Wllkp/CwDBsVjGjl7SZQfTOQc7Z1KyAHbzlreEC1
        fitroL1mWk50lo6/Q+zluJ/bOVluO9vSuncs4YVSZP8bSKZWlaud2LVOD7u+mRNG
        opYpcLDXeMxBLZbfqsLgraUsKR/SK5KDCLDz70pMUetYK/TNH1KdzWYJbc34dTQH
        6IZ350EDssi02JJCzr8SHqVdHjhu5Awqv7KAIjLupai4tQ6NPpFHIRtK7QBAhCBK
        jLA73sVEce2D9ibOPdJ3666D7OesTjUqtshtkdE7pi3BaMq3qsnFGK7JhVSc14OF
        2z3+l61sEIvHywqnHseJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701606580; x=1701692980; bh=GOwoFAR8GHE2h
        mMC7toWGpEGxnv7HNMn1zEazKgNcs8=; b=gXlehs3Z9GqnGY4QD4mNHAWgPqRii
        d0meS63kWnLjZa74xPElKdQkocfy7am7XRT+kFODJaoqWMXZ8Z5CMccGSNJMRxwE
        nuOv0Ual5t6YsN8pcsZuBc12QuZZkMD4awKy3MEGL6GEXBTXSXv8JpfBmqARVFwg
        3aoPRdfKSANj4N13pA8WCH+UGalNEBgtKcKBPVcdar45dNNxy65e0RqY5VUsk6kI
        hMljrWyHx4VYksU/v7V9Zng3Pm0fKiRV19kIpPOnLgrf+kgdy1WjboKRSTftOOBJ
        BevDj+JC9RNoGIAzECh4ovVVMOjbZxx97x77+dgetG28RQOEqkDo86JWw==
X-ME-Sender: <xms:s3RsZbPd9qm9jBpE5TY2BiLByymbKlMfoFvEzY3-95y8BnzhmxlHRg>
    <xme:s3RsZV9TRQyPhnGTgpaNqYD4TooIywoXibHAAg036w0-57kStu3NCrWjbs-n1jwhI
    ig3LsXGgbjeKdOjkFA>
X-ME-Received: <xmr:s3RsZaQxYLfiffi_kwxgagaJ1TSBEwuS-BIJ70S4o3zYN7kqJItZWc6yIlWGVnjEfvodAhpfRAODGqEn0EewwnRXOnBKhwR_FI4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejgedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnheptdetleekheeihfejueefkeejheehleduvddtkeel
    hfelteekfeegkedufeejfeffnecuffhomhgrihhnpedtqdefjedqghgvnhgvrhhitgdrih
    htpdgrmhgurdgtohhmpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttg
    hhihdrjhhp
X-ME-Proxy: <xmx:s3RsZfvmocDHNg_LoY9TOFmrRqK_5vA2XPsgwVQiKMDxvwwkgz-QTA>
    <xmx:s3RsZTefHFBZmqIDLIgcK01_jrTiJg5RNocy4cj9dh_L2lQ8nTprnw>
    <xmx:s3RsZb3Q1cwk3RzFCOsNm8eGr3Qolj7ZxVU6vNmCBVRytBJ3txsgmg>
    <xmx:tHRsZVtztgEuY05Svgdt3hfWAmWScTThAsAnAdxb19DAnw-ZZai71g>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Dec 2023 07:29:37 -0500 (EST)
Date:   Sun, 3 Dec 2023 21:29:35 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     a.mark.broadworth@gmail.com, matthias.schrumpf@freenet.de,
        LKML <linux-kernel@vger.kernel.org>, aros@gmx.com,
        bagasdotme@gmail.com,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: Regression from dcadfd7f7c74ef9ee415e072a19bdf6c085159eb
Message-ID: <20231203122935.GA5986@workstation.local>
Mail-Followup-To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Mario Limonciello <mario.limonciello@amd.com>,
        a.mark.broadworth@gmail.com, matthias.schrumpf@freenet.de,
        LKML <linux-kernel@vger.kernel.org>, aros@gmx.com,
        bagasdotme@gmail.com,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Borislav Petkov <bp@alien8.de>
References: <f878b188-3fe4-420c-9bcb-b431ac6088dd@amd.com>
 <20231107121756.GA168964@workstation.local>
 <318cc8da-f8d2-4307-866e-8c302dacf094@amd.com>
 <20231108051638.GA194133@workstation.local>
 <20231128052429.GA25379@workstation.local>
 <80dbe1de-c71c-4556-817d-3f06e67f38ba@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80dbe1de-c71c-4556-817d-3f06e67f38ba@amd.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

Thanks for the advices.

I note that In my experiments I use Ubuntu 23.04 amd64 (v6.2 kernel) with
backported FireWire stack[1]. Except for the stack, the kernel and software
packages can be retrieved from repositories of Ubuntu project.

On Tue, Nov 28, 2023 at 12:09:41AM -0600, Mario Limonciello wrote:
> On 11/27/2023 23:24, Takashi Sakamoto wrote:
> > Hi Mario
> > 
> > Following up on our last conversation, I purchase some hardware to
> > attempt to retrieve outputs from serial port. Finally, I bought another
> > mother board in used market which provides serial port from Super I/O
> > chip (ASUS TUF Gaming X570-Plus). However, I have retrieved no helpful
> > outputs yet when encountering the system reboot.
> 
> Did you up the loglevel to 8 to make sure you'll get all kernel output on
> the serial port, not just errors?

Even if giving either 'debug' cmdline option or incrementing console
loglevel via syctl, I receive no useful output from console when loading
the module at or after booting up.

```
$ sysctl kernel.printk
kernel.printk = 7	7	1	7
```

I tried at several difference cases; enabling/disabling IOMMU,
enabling/disabling SVM in motherboard level. But nothing effective.

> > As you mentioned, I check whether PCIe AER is enabled or not in the
> > running kernel (Ubuntu 23.04 linux-image-6.2.0-37-generic). It is
> > certainly enabled, however I can see nothing in the output as I noted.
> > 
> > I experienced extra troubles relevant to AMD Ryzen machine and the issued
> > PCIe device:
> > 
> > * ASRock X570 Phantom Gaming 4 with AMD Ryzen 5 3600X does not detect
> >    the card. We can see no corresponding entry in lspci.
> > * After associating the card to vfio-pci, lspci command can reboot the
> >    system even if firewire-ohci driver is not loaded. I can regenerate it
> >    in both Gigabyte AX370-Gaming 5/ASUS TUF Gaming X570-plus with AMD
> >    Ryzen 2400G.
> 
> Rather than lspci, is it specifically config space access from sysfs? Does
> the output from the serial port change with IOMMU enabled vs disabled?

In lspci case, I can work with debugger and figure out that 'pread(2)' to
file descriptor for 'config' node in sysfs causes the unexpected system
reboot. Additionally I can regenerate it by hexdump(1) to the node:

```
$ lspci
...
04:00.0 PCI bridge: ASMedia Technology Inc. ASM1083/1085 PCIe to PCI Bridge [1b21:1080] (rev 03)
05:00.0 FireWire (IEEE 1394): VIA Technologies, Inc. VT6306/7/8 [Fire II(M)] IEEE 1394 OHCI Controller [1106:3044] (rev 80)
...
$ hexdump -C /sys/bus/pci/devices/0000\:05\:00.0/config 
00000000  06 11 44 30 80 00 10 02  80 10 00 0c 10 20 00 00  |..D0......... ..|
00000010  00 00 90 fc 01 d0 00 00  00 00 00 00 00 00 00 00  |................|
00000020  00 00 00 00 00 00 00 00  00 00 00 00 06 11 44 30  |..............D0|
00000030  00 00 00 00 50 00 00 00  00 00 00 00 ff 01 00 20  |....P.......... |
00000040

$ lsmod | grep firewire
(no output)

$ sudo -i
# modprobe vfio-pci
# echo 1106 3044 > /sys/bus/pci/drivers/vfio-pci/new_id 
# exit

$ hexdump -C /sys/bus/pci/devices/0000\:05\:00.0/config 
(reboot)
```

I can suppress it when disabling IOMMU in motherboard. In this point, the
issue of lspci is a bit different from the issue of driver issue.

> > I'm plreased to see if you have extra ideas to get helpful output from
> > the system. But I guess that I should start finding some workaround to
> > avoid the issued access to register instead of investigating the reboot
> > mechanism, sigh...
> > 
> > Anyway, thanks for your help. >
> 
> Can you check FCH::PM::S5_RESET_STATUS on next boot after failure has
> occurred?  It is available at MMIO FED80300 or through indirect IO access at
> 0xC0.
> 
> If MMIO doesn't work, double check FCH::PM_ISACONTROL bit 1 (described on
> page 296) to confirm if your system enables it.
> 
> The meanings of the different bits can be found in a recent PPR:
> https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/55901_B1_pub_053.zip
> 
> Indirect IO is described on PDF page 294.
> 
> This will at least give us a hint what's going on in this case.

I'll try the above in this week. Thanks.


[1] https://github.com/takaswie/linux-firewire-dkms/

Takashi Sakamoto
