Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C828676AB32
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjHAIjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjHAIjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:39:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8450510E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 01:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690879158; x=1691483958; i=efault@gmx.de;
 bh=fQuDAejvv17CrafbhEWPjX3t0C0jSeS2qCYxa9Xs2BM=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=pYUUDdM3SgJKXkQCFUQ02tNGeh7MqcGZU1FL66i5bIdAkA48cEudZqiAElAEcha1B0jzn/R
 kwoXDd50hcV/uJ7d0IeMNKkTofKV+iPJbytF31M4zQFEoCYl90JPDO00C0RQn/0WgwhGA74DY
 8chVsONp9giXtkHFSPm+VzrHlgg/HRL8y18qx4YJ3Lpd5xw6DRFmfshHQujII+YAk8H4W5R8j
 4ocPP5AWcZ12XT8YQnIugYKSf/LA4tGhA4QWvpGG2hWI4lNJtFljEOqQj5IlmiZ37yr4u1lIH
 7ZeJ+zycBui/FQ4bdkHNDy7R/+FROpY2/NQmtOfWsf/kbO55TDyw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.191.216.56]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIdeX-1qfNUB1KvV-00Eemy; Tue, 01
 Aug 2023 10:39:18 +0200
Message-ID: <abd93ae835b2220277131081a448e038cce7e451.camel@gmx.de>
Subject: Re: arm64: perf test 26 rpi4 oops
From:   Mike Galbraith <efault@gmx.de>
To:     Will Deacon <will@kernel.org>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        wangkefeng.wang@huawei.com, catalin.marinas@arm.com,
        ardb@kernel.org
Date:   Tue, 01 Aug 2023 10:39:14 +0200
In-Reply-To: <20230801072732.GA25854@willie-the-truck>
References: <b39c62d29a431b023e98959578ba87e96af0e030.camel@gmx.de>
         <20230728141852.GA21718@willie-the-truck>
         <8c56256399e2e6c41bc574749d6170d5529f24fc.camel@gmx.de>
         <20230731104340.GA24767@willie-the-truck>
         <20230731115207.GB24767@willie-the-truck>
         <CAA5enKaUYehLZGL3abv4rsS7caoUG-pN9wF3R+qek-DGNZufbA@mail.gmail.com>
         <CAA5enKYaZ-daLeL3amr2QrQjtUdK=P8B+VbJdea7cB77QWY-eQ@mail.gmail.com>
         <42ad26cb6c98e028a331f5d73abf85bd965ff89d.camel@gmx.de>
         <21777dec0233b1bc65f51764ead9a03efa9baa64.camel@gmx.de>
         <7b94619ad89c9e308c7aedef2cacfa10b8666e69.camel@gmx.de>
         <20230801072732.GA25854@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1rBqZGJ5Caom51jUTScJD6nK7kAVGAjcjXpdZ3HzbpJcwC1WKVr
 yei/HdCCvgRK0qJFdQaiKofrW/IB2aULe1h4ektvZ5hQD7PFSAxNk03nPmhUx8qEifO06qT
 4HFGaLvVPiRt/2N0ubxizpBaLW2TdnpLUKqVOSj4aBTJV73zLfEbMduDWjVOxx0PUXftAbk
 +IFCOPB8e29euqpYGuuUw==
UI-OutboundReport: notjunk:1;M01:P0:QIzy8noaYPM=;kZatil0QBf+lhYE5GHUJ72EYn/P
 djJQvfDetgi6gWGCfFXJR2gc6An3X2w7FTG+ffAQaEx/SHnzq6TqqXGihWdfn4YwXIqX6TSDh
 ZloFm5H36+edsWsjHMpX6bqbcOoEKxstbazI+7II8L0lXFNYbelHk9l6dpRoqsrp5eC+PYZev
 lZ0xJ7dr0hzjdWVLT/QnrtNmbhmqrfc1Wxz9mnf5Z1JePhvP+3HvmVIx5SIiwfIjWm/SvS56O
 tWAaiIsa/x0XJ7EWUqYw+CHeNbZQlPugtlw8q6mqWiz/ROfDH4zex2CfPSQlcaZzpLfUaQP3g
 iHaRQX54Pj3cFwNYyG4EPj+0mY04WrQC8G9WVmt/dBNFlMRIN47etCCA7n9w+/qLjyAkYi0/W
 AAbODLkej2b2ZhRtbuz0c2psmrUFX4EfAew3IvQz+E50Ji6Y8vQxk0kY7UmyROi+Y3WEDHS8Z
 W4xPXODjL0Kocs8gPPNqRQMjoIdmq4kyqapmMDGRwB+C5snRypK2Zh6Hza4hm+KziLIvk6n/1
 OIvYclm2ONTFf6l+NPY1L55iqdz3pvpRmSAqEB/03yRRssoMPAlzpN0dYIAsF4YiH+DcuKvBJ
 uCm9AXtT99IFSX7tm++w3rtlDcbdvQx07E59H3OYeZc8I2U+4N9ZzJOO++Lbm2o0dF84YCC/w
 VK825YDRZOF06exNRdBbQ2V6EiEc4aa0CwiZxLaMdk8tK9t5rkmso5oRKWPdFtHGo/CNT/OIB
 tBXH/myjMET5kAB+JLA31QemJkWENYRcpjO2x7tOyq3c0o+ogSN57Cgmt/Z9XOVQjfqwZkNq5
 Ulq8yLgDCNU6Nk+D+7noyRYeRhfSRRBl0cv+plPW0q91fo5udzH0Uig1HCzWmp+sylq1ASbl7
 QaRvxsRKhk/7J7lydzoEkw9wcIP3KjTI5uOklSXyA26Rm5nsDOSuUq7hglSuqCVgTHp6Llfea
 CxnREgPPj4KLb1VNhhV3jR3Xz4w=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-08-01 at 08:27 +0100, Will Deacon wrote:
> On Tue, Aug 01, 2023 at 06:34:15AM +0200, Mike Galbraith wrote:
> > On Tue, 2023-08-01 at 01:48 +0200, Mike Galbraith wrote:
> > >
> > > root@rpi4:~# dmesg|tail -2
> > > [=C2=A0 979.003019] __vm_enough_memory: pid: 12439, comm: objdump, n=
ot enough memory for the allocation
> > > [=C2=A0 979.003080] __vm_enough_memory: pid: 12439, comm: objdump, n=
ot enough memory for the allocation
> >
> > Ancient bug droppings are due to VMALLOC_END-VMALLOC_START=3D265885319=
168.
>
> FWIW, I see the same thing on my x86 laptop. I'm guessing objdump tries
> to read all of the vmalloc space into memory, which is going to end
> pretty badly!

Weird, I don't see that even booting my 16G desktop box with mem=3D4G,
with a crashdump kernel setup and the GUI up and running...

homer:/root # echo 0 > /proc/sys/vm/overcommit_memory
homer:/root # free -h
              total        used        free      shared  buff/cache   avai=
lable
Mem:          3.2Gi       1.6Gi       667Mi        18Mi       1.1Gi       =
1.6Gi
Swap:         4.0Gi          0B       4.0Gi
homer:/root # swapoff -a
homer:/root # perf test 26
 26: Object code reading                        : Ok
homer:/root # dmesg | tail
[    9.379431] br0: port 1(eth0) entered blocking state
[    9.379434] br0: port 1(eth0) entered forwarding state
[    9.379527] IPv6: ADDRCONF(NETDEV_CHANGE): br0: link becomes ready
[    9.388643] NET: Registered PF_PACKET protocol family
[   17.225053] usblp0: removed
[   17.226278] usblp 2-10:1.1: usblp0: USB Bidirectional printer dev 5 if =
1 alt 0 proto 2 vid 0x04E8 pid 0x342E
[   17.911334] r8169 0000:03:00.0: invalid VPD tag 0x00 (size 0) at offset=
 0; assume missing optional EEPROM
[   18.430787] NFSD: Using UMH upcall client tracking operations.
[   18.430802] NFSD: starting 90-second grace period (net f0000000)
[   20.578718] logitech-hidpp-device 0003:046D:401B.0006: HID++ 2.0 device=
 connected.
homer:/root # uname -r
6.4.7-stable
homer:/root #

Same for a limited objdump -d, though unrestricted will oom instantly.

	-Mike
