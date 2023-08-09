Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68C0776904
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjHITqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjHITqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:46:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA15710DC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 12:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691610358; x=1692215158; i=toralf.foerster@gmx.de;
 bh=G1rzM8ZdsdInEsbGfVt+FX6seuaEZxLU9P6EhmmwOcE=;
 h=X-UI-Sender-Class:Date:To:From:Subject;
 b=kuyfM6lwH3y5nbJnry2iZPzjWBuByEEDY870kPh0al0wx1ZiAinGfmRqGFqX0Bjb2biJlJw
 o/+cxTg+hHmCIhnVWAhbcCS8vSmz/AuxRE5Bj0DnjGntzNrGhLzJ+PYf+qvqucEwSfqEdo90P
 aDkVy17Ttlb8qgwVUlsb2uIEVbYjQtIC/RTvIkOsWmtFONUAAbGG87UeEpPkIL+wJMXB8/lVc
 F8jjZ++C01H0xsYlyIXlo2Cx9e17BYV7KxU/EaCoklZVqIm/Xifa6FDaXO3pCqymGKJvl2RWx
 nYAlzUGv3ZrHDdZTF8AVuYry2bYuex+EZQ+cRDZF6IqCQ9D7pUqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.31] ([95.112.75.254]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N17YY-1pnEDv3gDq-012Zh6 for
 <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 21:45:57 +0200
Message-ID: <5890bdee-ead3-a5c9-46e0-7abb7de1fb15@gmx.de>
Date:   Wed, 9 Aug 2023 21:45:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To:     Linux Kernel <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Subject: few dozen pollfress.t segfaults messages in system log
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ec//1jxTr4scAg+T/gW/miYBpK5Wrg8D4joMSYcapXm5tV4EAh0
 Qqc0+3KZh5CbyFs6tKKAUtwoNxpWQOacQaHllX43AzLfQT0Rmjj07uLkQeoYFSfsitAVcF0
 JBSPd6aLFRiF+HiMXYrw8FHWKyR2yo3yYsNkELEIpJKl6wEtTiqn5ICWAeEmrMhOrdnmJvN
 kmFeG1sGYLcvKek9yz95g==
UI-OutboundReport: notjunk:1;M01:P0:pATl0uyXoAs=;+9CdWiJtjUaOtl1xcqM1XSlI6sD
 RgIw4662SIHeIZ0MSxm9EI50FeuGNFgFQ73rzYKMlVMk910SSbkteuHcEG7qdLMS33dl+UkcJ
 +PoKWiP8sFzmUHUWfiEujeQWdJUC1hXop+Aho9Vk+b0ifSty4Syo2mfNP7yqz7TyG1rmTuomK
 IGWVUCElWSHUVTuVsIRfnghhPbiRGIzkbg/NaXz2yjlLTvQ28wwfT5WS6iLxbFdRoVTToX/31
 3p5JxYTGclVr0UXYVcjFvwLcmAnpdQhf1XOS1tvAYH3iEKjNUdCDEwWiR5SDj268iH80NwwiU
 IFFWjkKsYA+CFJVkUl7ltnQeii1+zPsCC5ZP0NCo/H58M048vmyPzc+9Ezr0xqWzp/wMx8AXP
 jS/3yaIEpgCA9wLFkQcLY9xslzoi0cU+mXgLs+Wh19wJwgm94aB1hl0l56ZSdjOR3SRTelBQu
 00UvmtgXCdx3OFsUsIqcK4ZqhGITB0YitTM0lpYNNP0jlUkRijYanxltUuoQJs2ZVNah9/uuX
 ZZTiKo9unq1CLDgXnykAHY2tl98M5u5yEqTrLr7w4Tto7N7FSiRN1oAdmTgKzRl7Rx56PPDcx
 7sRAbajkQYOqcp6uXBTNKOBqoYybx+kd1TMZk1fSLt/DIQzcvKxR+3oC7JuinPna6BnhAR4y2
 mH2YATXzcrxPDXbPqnC5ZxvYs35hxU3RgPj8wvA1W0rB/DY3vHCERAmvXHK256RxuIkIwHqAh
 UTp4ivMkGVUK7GyY1TXKy7BP3at3qBPVwJnuy1L2oAm4rieaImaAe0LJmpbyv8D1pgsf941cW
 bwIdrNhb9xwMI4Lgv68iqUEnDqWidld0L+10Fvgf9gdori8NejwDywtednIpFZnq6YQ3Jr6AR
 fUTdhLLjjN/jwL1a1AVhfJ1wnag/+xUZCJnz/hsPBs6Bn6XPqOnMHA2DekUk1wvVvcbpkhr/K
 jGByYw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got a bunch of

$ grep pollfree messages
Aug  9 02:10:14 mr-fox kernel: pollfree.t[18582]: segfault at 10b ip
0000563c9619b373 sp 00007f69511a2eb0 error 4 in
pollfree.t[563c9619a000+3000] likely on CPU 14 (core 14, socket 0)
Aug  9 02:10:14 mr-fox kernel: pollfree.t[18594]: segfault at 10b ip
0000563c9619b373 sp 00007f69511a2eb0 error 4 in
pollfree.t[563c9619a000+3000] likely on CPU 4 (core 4, socket 0)
Aug  9 02:10:14 mr-fox kernel: pollfree.t[18597]: segfault at 10b ip
0000563c9619b373 sp 00007f69511a2eb0 error 4 in
pollfree.t[563c9619a000+3000] likely on CPU 11 (core 11, socket 0)
Aug  9 02:10:14 mr-fox kernel: pollfree.t[18601]: segfault at 10b ip
0000563c9619b373 sp 00007f69511a2eb0 error 4 in
pollfree.t[563c9619a000+3000] likely on CPU 26 (core 10, socket 0)

last night with kernel 6.4.9 at a stable hardened Gentoo Linux:

Linux p14s 6.1.44 #34 SMP Tue Aug  8 21:43:00 CEST 2023 x86_64 AMD Ryzen
7 PRO 6850U with Radeon Graphics AuthenticAMD GNU/Linux

I do wonder if those messages are related to the host kernel or if they
are coming from a buggy app within one of the images of the build bot I
do run at that machine ?

=2D-
Toralf
