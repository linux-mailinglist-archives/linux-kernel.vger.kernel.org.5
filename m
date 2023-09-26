Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8827AEEB4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 16:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjIZOJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 10:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjIZOJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 10:09:35 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A29A136
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 07:09:28 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 2744B320097C;
        Tue, 26 Sep 2023 10:09:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 26 Sep 2023 10:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1695737366; x=
        1695823766; bh=fyAJkV2bNHKJP5A9p5EcAPgwpBqbmV65KABmZXDb9fQ=; b=0
        D7VNRwoZ3Tq0crvZ/JCldeOAeTxhU12tnprR6Ykv2IARE88h70JjVN1/WhxqhDBc
        PWdjahsC+YGdQsPLQjhrnqB/XwSbfLvDAyw3B44IS+rEPQ/JyTuO+Yqi8UPLV57m
        ZnZHkn+N4pP+KDkGWWoyk0ndMuUOONQcN0cgDDXHKW2AuZPIB/Sp2mACBUgpUlCv
        CvC+lZZiMPdgHZ6XCNXc29cGtsnxHkoo62NpbQVM6Kl/lcT2+2b1kLopFL/6qgig
        eHVZB0hP83QZCeDunXKpLn29VMNgdIxiIVdS/BWO7ZbylWFmWMBfvkdjCkwLU/aF
        dDqx5i7NYzrn056UV5CRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695737366; x=1695823766; bh=fyAJkV2bNHKJP
        5A9p5EcAPgwpBqbmV65KABmZXDb9fQ=; b=eblphmrxZQeBflKhUrga61QnBXp3b
        U1AK+KLMw+ffvorA5MfpQN8H+Aa1TwQYbRhgoOFvv/569mHVgClZfQFbe4LH7UZQ
        xjJdJWSMtaPGGY5sCXELsReg2rVMLPtv7CMzH8yffGUn67MOnRtHxqfWXxd65f7W
        4inksZQwUcDvRV6ZxUFRrne6J/cgNrm61ZOCDpeju8JAcLiZf08/5VxkYrowcl0/
        +Jm3HZzedZPpCJ2AkwLcJdqBTwPJjbGa0evxLZ1UR2js/jXyPPTwgE1th7QPxjGv
        9ImUX+T7eEudA5CgEeBFX3MblyqnsFoHSwCT4ulzI7MioM8u09RguNwsw==
X-ME-Sender: <xms:FuYSZaTxLdivbY1HNvhza59CbcAUtQEApxKOB0Ju6WlHg5bQpti9kw>
    <xme:FuYSZfxWz5Vx-ktL8juVYhc4L1sJajCFJKF4rTmBmnW4Q88LuqIF6owN13pe3u57T
    adI6Pt0BrzvXxMcXsM>
X-ME-Received: <xmr:FuYSZX3JHsGC1pDQSyqi_ZHvYy0NCvgdVwy2GXpv3GdyxqJ34OPcOhOR6y8PnZLpve4mh9B73cxYefzliTvvwVu1eGpU4ekjXZ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtddtgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucggtffrrghtthgvrhhnpedthfeiteevveettdeffeelffdvtddttdffvdduveeg
    lefhveetveevvdffleeiudenucffohhmrghinhepshhushgvrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihes
    shgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:FuYSZWCEQU1VLbD9Dhg6NcG-Q2nyzFVBySxeZ4jHE--cU8YRTLSldg>
    <xmx:FuYSZThhl0aowkESSvaES3US4Myi9bSgtTd64y8LkZZ9NUfAh2MVhQ>
    <xmx:FuYSZSpRU8CEGsWp7QFh9n-d2hdJYSKkfqccIl7_jA_E_yAipvNh5g>
    <xmx:FuYSZTK5eu6DPtDKDcGyxaQTdfNrZU39qf7LbmiXNgX15Q4DgWOAXw>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Sep 2023 10:09:25 -0400 (EDT)
Date:   Tue, 26 Sep 2023 23:09:22 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] firewire updates for 6.5-rc1
Message-ID: <20230926140922.GA6538@workstation.local>
Mail-Followup-To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
References: <20230704121847.GA26576@workstation.local>
 <f3d8c72b-cd30-490c-833f-5807bd74511f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3d8c72b-cd30-490c-833f-5807bd74511f@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for your report, and I apologize to trouble you and your
reporter.

On Tue, Sep 26, 2023 at 11:11:23AM +0200, Jiri Slaby wrote:
> Hi,
> 
> On 04. 07. 23, 14:18, Takashi Sakamoto wrote:
> > Please pull firewire updates for v6.5-rc1.
> > 
> > The following changes since commit 44c026a73be8038f03dbdeef028b642880cf1511:
> > 
> >    Linux 6.4-rc3 (2023-05-21 14:05:48 -0700)
> 
> Likely some of the below commits causes an instant reboot during boot as was
> reported in:
>   https://bugzilla.suse.com/show_bug.cgi?id=1215436
> 
> 6.4.* was fine, 6.5.4 or 6.6-rc1 fails.
> 
> module_blacklist=firewire_ohci fixes the issue on 6.5.4.
> 
> Any ideas what can cause this? I fail to see an issue in the commits...

In my opinion, the series of patches to optimize 1394 OHCI driver to
devicves managed resources would bring the issue in the environmennt,
therefore:

> FWIW I see "obsolete usage of GFP_ATOMIC" was reverted in 6.5.5 and 6.6-rc2,
> I asked the reporter to test those.
>
> > Takashi Sakamoto (24):
> >        firewire: add KUnit test to check layout of UAPI structures
> >        firewire: cdev: add new version of ABI to notify time stamp at request/response subaction of transaction
> >        firewire: cdev: add new event to notify request subaction with time stamp
> >        firewire: cdev: implement new event to notify request subaction with time stamp
> >        firewire: core: use union for callback of transaction completion
> >        firewire: core: implement variations to send request and wait for response with time stamp
> >        firewire: cdev: code refactoring to operate event of response
> >        firewire: cdev: add new event to notify response subaction with time stamp
> >        firewire: cdev: implement new event to notify response subaction with time stamp
> >        firewire: cdev: code refactoring to dispatch event for phy packet
> >        firewire: cdev: add new event to notify phy packet with time stamp
> >        firewire: cdev: implement new event relevant to phy packet with time stamp
> >        firewire: fix build failure due to missing module license
> >        firewire: fix warnings to generate UAPI documentation

here

> >        firewire: ohci: use devres for memory object of ohci structure
> >        firewire: ohci: use devres for PCI-related resources
> >        firewire: ohci: use devres for MMIO region mapping
> >        firewire: ohci: use devres for misc DMA buffer
> >        firewire: ohci: use devres for requested IRQ
> >        firewire: ohci: use devres for list of isochronous contexts
> >        firewire: ohci: use devres for IT, IR, AT/receive, and AT/request contexts
> >        firewire: ohci: use devres for content of configuration ROM
> >        firewire: ohci: release buffer for AR req/resp contexts when managed resource is released

to here.

> >        firewire: core: obsolete usage of GFP_ATOMIC at building node tree
> > 
> > Zhang Shurong (1):
> >        firewire: net: fix use after free in fwnet_finish_incoming_packet()
> 
> thanks,
> -- 
> js
> suse labs

Although, usage of device managed resource is itself preferable, thus I
would like you to help me to fix the issue. I test these patches in v6.2
kernel by module backporting and I have no issue in my environment. For
example, with 'acpi=noirq':

```
kernel: firewire_ohci 0000:0b:00.0: enabling device (0000 -> 0002)
kernel: firewire_ohci 0000:0b:00.0: using bridge 0000:03:00.2 INT D to get INT A
kernel: firewire_ohci 0000:0b:00.0: added OHCI v1.10 device as card 0, 8 IR + 8 IT contexts, quirks 0x2
kernel: firewire_core 0000:0b:00.0: created device fw0: GUID 080028510100014a, S800
```

But in the reporter's environment:

```
kernel: firewire_ohci 0000:22:00.0: enabling device (0080 -> 0083)
kernel: firewire_ohci 0000:22:00.0: can't find IRQ for PCI INT A; please try using pci=biosirq
kernel: genirq: Flags mismatch irq 0. 00000080 (firewire_ohci) vs. 00015a00 (timer)
kernel: firewire_ohci 0000:22:00.0: failed to allocate interrupt 0
kernel: firewire_ohci: probe of 0000:22:00.0 failed with error -16
kernel: firewire_ohci 0000:22:00.0: removed fw-ohci device
```

For my information, would you please ask your reporter to tell what kind
of 1394 OHCI hardware to use? Once the Linux system booted, you can
retrieve information about it by lspci(8). My hardware includes
PCIe-to-PCI bridge as well as PCI-to-1394-bus bridge (1394 OHCI) and I
would like to check the reporter uses the similar hardware or not.

For example, in the market, we have direct PCIe-to-1394-bus bridge. It
appears that the reporter would uses the kind of hardware. If so, I
install the similar hardware in my system and check the patchset. Else,
I'll investigate the other causes; e.g. installing openSUSE Tumbleweed
to regenerate the issue.


Thanks

Takashi Sakamoto
