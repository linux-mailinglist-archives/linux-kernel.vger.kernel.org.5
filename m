Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC097B4548
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 07:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjJAFPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 01:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjJAFPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 01:15:44 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD3DC4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 22:15:42 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id D34E532011DE;
        Sun,  1 Oct 2023 01:15:38 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute5.internal (MEProxy); Sun, 01 Oct 2023 01:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696137338; x=1696223738; bh=LL
        qhziztpsU4hplQSJL0KgoZ/2Tbl/WDiZLhU4ejS4g=; b=1EnF5YgIgrIDkMB8yC
        UzP6IW/D3O0hLKEoQVudsBSA/nJxg5ITKfYNXO6mPw0YjdnRgDMseEHs9uDzhjJN
        p1BSDCeZf93w72Hc7zhw0yonVty6AGnc5PPG8DVLfS4V+7u1ZyG8A5w2LcXEN47t
        fjD8m5Aw45oQ9IlK+i0SvNQtAoBrsvUgrlYM7WtOl/tKJnSOxi5JygL2VefqK5GX
        AR1ok8jS5lds7AunfFkvmEcN1Zxn50L0eM5KM/Nphv/PE/t/dRYcjCo/Q+B3bAbh
        c0qW311pbfbRCdEhQaUH6nS3/79fOleqiiaRCOKecB0rAYhWS08Y/200SbKzuRIt
        2wLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696137338; x=1696223738; bh=LLqhziztpsU4h
        plQSJL0KgoZ/2Tbl/WDiZLhU4ejS4g=; b=H36QVYNPJnWKdaHpMS13XFT+bdlwc
        TokPLqXz8DVv7aYdlJWC4qb2DJJLlTsn9XxDK+B7HJHT/u3NcucvNr6jt9EqqXz/
        DFqA4k6cQqd863rtxz6XL26efHFiIWtFInjdUHvqOWxSFPVa23tecjO7TAAcY0ZK
        5na85QLN1zPOXEleuBNxOakA9Nk/IiQELoSlgjs3eIWKkGXkQ1ikxtYoIEHaqPH2
        Qq2KaAJC2414U7H34AIbCQNL6RryX609IpZ6w69ZLqDlc20s8M4JqjEpYuQG8W6T
        /aMa8F2G/7wIfVdqCIlzO/OgRBjzLa5qBZP2lXf6+bu7w8fl0R0YfJ18w==
X-ME-Sender: <xms:egAZZQj03zD-4baycRwDDoHaqyR-S2aHCynqzR5T_WhpDjMHSVTFbA>
    <xme:egAZZZAz8DNh1cdx0UuthvlbgKA-4WwWcAlIaFBVDoNVlcjM5trI9k3b-F0js-vsJ
    _5fKxlza722N7uU_-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfvfgrkhgr
    shhhihcuufgrkhgrmhhothhofdcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhih
    drjhhpqeenucggtffrrghtthgvrhhnpeetheegtdevhfeufeejtdevheehudeiieejvedt
    tdekiedtheeuvefgudfgjeekueenucffohhmrghinhepohhpvghnshhushgvrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgr
    khgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:egAZZYGsuUvTLF1GyGXSyCkpwtVDVQmy9fchfnTaOomZlW6Mx6cfgw>
    <xmx:egAZZRTF2Tjw-e_ZWPr70iDtFsd8HhJP_p7L0NDN6NGKZYGgfe3VSQ>
    <xmx:egAZZdylfB5lc2cGq2BhhlErjhYf9QAkZs7whHBSzHWFGk6v7mVnRg>
    <xmx:egAZZWtIkTVLL2mgpdLM6raC-TdAEwP4o5iAwO58WVt4bNhKyvATiw>
Feedback-ID: ie8e14432:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1F2C236A0075; Sun,  1 Oct 2023 01:15:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <0ed4012a-83a7-4849-92c4-87a86e1bbb84@app.fastmail.com>
In-Reply-To: <a12593c9-9ced-4bb8-b7a5-8247b08d0e0f@kernel.org>
References: <20230704121847.GA26576@workstation.local>
 <f3d8c72b-cd30-490c-833f-5807bd74511f@kernel.org>
 <20230926140922.GA6538@workstation.local>
 <a12593c9-9ced-4bb8-b7a5-8247b08d0e0f@kernel.org>
Date:   Sun, 01 Oct 2023 14:15:16 +0900
From:   "Takashi Sakamoto" <o-takashi@sakamocchi.jp>
To:     "Jiri Slaby" <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] firewire updates for 6.5-rc1
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

Just now I installed openSUSE Tumbleweed, however I found no issue on my 1394 OHCI
hardware. I would like to ask your current opinion for the issue?

~> uname -r
6.5.4-1-default

~> cat /etc/os-release 
NAME="openSUSE Tumbleweed"
# VERSION="20230929"
ID="opensuse-tumbleweed"
ID_LIKE="opensuse suse"
VERSION_ID="20230929"
PRETTY_NAME="openSUSE Tumbleweed"
ANSI_COLOR="0;32"
CPE_NAME="cpe:/o:opensuse:tumbleweed:20230929"
BUG_REPORT_URL="https://bugzilla.opensuse.org"
SUPPORT_URL="https://bugs.opensuse.org"
HOME_URL="https://www.opensuse.org"
DOCUMENTATION_URL="https://en.opensuse.org/Portal:Tumbleweed"
LOGO="distributor-logo-Tumbleweed"

->sudo lspci -v
...
01:00.0 PCI bridge: Texas Instruments XIO2213A/B/XIO2221 PCI Express to PCI Bridge [Cheetah Express] (rev 01) (prog-if 00 [Normal decode])
        Subsystem: Device 3412:7856
        Flags: bus master, fast devsel, latency 0, IOMMU group 8
        Memory at fce00000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=01, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: [disabled] [32-bit]
        Memory behind bridge: fcd00000-fcdfffff [size=1M] [32-bit]
        Prefetchable memory behind bridge: [disabled] [64-bit]
        Capabilities: [50] Power Management version 3
        Capabilities: [60] MSI: Enable- Count=1/16 Maskable- 64bit+
        Capabilities: [80] Subsystem: Device 3412:7856
        Capabilities: [90] Express PCI-Express to PCI/PCI-X Bridge, MSI 00
        Capabilities: [100] Advanced Error Reporting

02:00.0 FireWire (IEEE 1394): Texas Instruments XIO2213A/B/XIO2221 IEEE-1394b OHCI Controller [Cheetah Express] (rev 01) (prog-if 10 [OHCI])
        Subsystem: Device 3412:7856
        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 39, IOMMU group 8
        Memory at fcd04000 (32-bit, non-prefetchable) [size=2K]
        Memory at fcd00000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 3
        Kernel driver in use: firewire_ohci
        Kernel modules: firewire_ohci
...

$ udevadm info -e
...
P: /devices/pci0000:00/0000:00:01.1/0000:01:00.0
M: 0000:01:00.0
R: 0
U: pci
E: DEVPATH=/devices/pci0000:00/0000:00:01.1/0000:01:00.0
E: SUBSYSTEM=pci
E: PCI_CLASS=60400
E: PCI_ID=104C:823E
E: PCI_SUBSYS_ID=3412:7856
E: PCI_SLOT_NAME=0000:01:00.0
E: MODALIAS=pci:v0000104Cd0000823Esv00003412sd00007856bc06sc04i00
E: USEC_INITIALIZED=11023840
E: ID_PCI_CLASS_FROM_DATABASE=Bridge
E: ID_PCI_SUBCLASS_FROM_DATABASE=PCI bridge
E: ID_PCI_INTERFACE_FROM_DATABASE=Normal decode
E: ID_VENDOR_FROM_DATABASE=Texas Instruments
E: ID_MODEL_FROM_DATABASE=XIO2213A/B/XIO2221 PCI Express to PCI Bridge [Cheetah Express]
E: ID_PATH=pci-0000:01:00.0
E: ID_PATH_TAG=pci-0000_01_00_0

P: /devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0
M: 0000:02:00.0
R: 0
U: pci
V: firewire_ohci
E: DEVPATH=/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0
E: SUBSYSTEM=pci
E: DRIVER=firewire_ohci
E: PCI_CLASS=C0010
E: PCI_ID=104C:823F
E: PCI_SUBSYS_ID=3412:7856
E: PCI_SLOT_NAME=0000:02:00.0
E: MODALIAS=pci:v0000104Cd0000823Fsv00003412sd00007856bc0Csc00i10
E: USEC_INITIALIZED=11023930
E: ID_PCI_CLASS_FROM_DATABASE=Serial bus controller
E: ID_PCI_SUBCLASS_FROM_DATABASE=FireWire (IEEE 1394)
E: ID_PCI_INTERFACE_FROM_DATABASE=OHCI
E: ID_VENDOR_FROM_DATABASE=Texas Instruments
E: ID_MODEL_FROM_DATABASE=XIO2213A/B/XIO2221 IEEE-1394b OHCI Controller [Cheetah Express]
E: ID_PATH=pci-0000:02:00.0
E: ID_PATH_TAG=pci-0000_02_00_0

P: /devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/fw0
M: fw0
R: 0
U: firewire
D: c 244:0
N: fw0
L: 0
E: DEVPATH=/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/fw0
E: SUBSYSTEM=firewire
E: DEVNAME=/dev/fw0
E: MAJOR=244
E: MINOR=0
...

When I plugged in my sound device (Tascam Fireone) and load ALSA OXFW driver, it works as expected. It means that both 1394 Asynchronous/Isochronous communications are established as expected.


Regards

Takashi Sakamoto
