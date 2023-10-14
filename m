Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91ED07C9623
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 21:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjJNT5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 15:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjJNT5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 15:57:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6ADB7
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 12:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1697313453; x=1697918253; i=aros@gmx.com;
 bh=OJ10MhnuLe89O+Cxce6qshxsCEIpOlpY3U8dRVBV3JY=;
 h=X-UI-Sender-Class:Date:From:Subject:To;
 b=Qm966Y5sZsNpPehwfYFEW/qCMACkEgOiBA7j6kK4W3dgHekp9sJm2kuUhEGC10rGJmDGJtXWtbw
 MMJvmKvJowUGifjGaeHypzOwcHOMtyi3w0GfByG7WmbqAZoToxqYzfUvcVpCOW0WfowAtPxUhNuwh
 S+b9LqipOlNcMnjZLqg3tS4MvN/PRNp5NH9Zlh14dWy/Eip7l4G5Qu/DOJfKOhBARhR64COhndl8O
 32MRVGJLCbcD9O20xmq3LhHVn5rQzkNfwuOxThvEelumAIkjFICFwftCX11ejHROmSkPJWaCHqfqY
 zFf+qhjVOL42UYm2FfgRpnh2TbtNcwdTByrg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.32.110.19] ([98.159.234.33]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1ML9uU-1r8jPz1LSk-00I9bR; Sat, 14
 Oct 2023 21:57:33 +0200
Message-ID: <1d521170-85c9-41bb-ad79-5d2bf3aae7f2@gmx.com>
Date:   Sat, 14 Oct 2023 19:57:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   "Artem S. Tashkinov" <aros@gmx.com>
Subject: Printing HW configuration on boot
To:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+8Preq0RKuZir/w7n27r8p/O9XL0+cvz4mTeG9NPLZY2+sbWhB4
 p/njRp9V6BrUZHBwjxQ6G9crjiomwl3VRC/sEFJII2MzbatD3QfcR3OV0oMulxGrJwrZ23r
 WH5LtNeh8F6rr58FqdAHvleHbOqBgnY5/O7mhX6B7Vt/H6KF6n8SZpRrnel2revg15MOqPU
 zsmqnVPR+uXIkESKf9mzQ==
UI-OutboundReport: notjunk:1;M01:P0:4qs/YGuchwk=;Ea1sPh7JwRg4abv321MQE1PHNrj
 xZfegvT6B4penRoy8nbfFNKVeOgUbnCBXkiAEEHocbDTms2af2LiB6IPLEP+ad8klQ/sZH/e8
 3cZwmkTXaRkqpfXRwYZiUOtjgEjeH5NAj6+GbFYEg7MTK1LqNBqEFSkgsvX6VAu2WkhaAB5Mu
 QG0KROI6sru49V4dMPJwvphm9WcwAybEkU9cw+Ag8+M55LLXLbqhzcZAFU2n+Ss08SmsP8naJ
 3PwZBbIOQh2dt29RAHHM2DeK26gxr7nwnuuI+jmlSwiayEdgPF3lb0v4YXz3hoy/j0bwxGQgy
 i/izONjIpsGoA4ThpgrwQOqKN+13wMuVbM7Iadvz3rsfpOuR+WKIf4n4RyoGUc0bcwhnLW1+5
 ByMQRehs226Y4ZmeIS25vvWwyLXr2iPQ1LTzuTMFZJa9D0GWg1UfCpw9WFmrt597xbjsM7jbj
 2m8t8pUoR5CMi4LYmfJG33y+gWoQEPHV+zXoeOCfkns6M1we4VDqUE48qRSwPCvaS8UFQvggk
 kwUd9IkvExhAG8+OxROnmzDPmkMvMJ6QHlDq9s7GT1aQtqD6+W3N4gJ1uN4d7uco2N1M/piKb
 I3Ln7VW/eMJmLFob/wr5r+inucDEsID0YH47VeejDiXuK3tHcuTantYmpY/6qrnZqb5OES+yv
 CXVMbJtPR+/WjYCOVBB6h+1QQCKbwdRBYIdlKrrjxMRlPB0x2KCECR6CBimoly2b3k1nOp9Wr
 P8pjFcvfn4qYYOaKVKQRkDaOMletW8g4uKpo5NQsMo9F/85qkdbSyb5oahrxK3/VLNHD9+Xr9
 X5IyNZQWrgClzTgU1qsbAHlee0UE2QOkIGMQTVxjtUTG0qSAywUUClzl8jpohXSqw8SiFASmw
 mWIXmkenJ+2j2tumQMYOPuOBGaHtv5efSDKdkBkS8/PgxXzTzRedFc1g7Sp89gb00hfhTyo0m
 KGNswYHGRokppl/FiDMRChzMVjA=
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

dmesg is an invaluable source of information about the system however
oftentimes it's the only source of information and it gets really hard
to extract information from it.

It would be great if someone coded the following feature: a printout of
system configuration before the kernel runs /sbin/init, e.g. something
like this:

=3D=3D=3D=3D=3D=3D=3D Detected hardware configuration =3D=3D=3D=3D=3D=3D=
=3D
Arch: x86-64, EFI, Secure boot enabled
CPU: Intel/AMD Something; X cores/Y threads
GPU: AMD/Intel/NVIDIA VEN_ID/DEV_ID, VRAM MB
RAM: 32614128K/33414620K available, ECC enabled
Motherboard: Vendor, Model, BIOS revision
Console: i915drmfb, 1024x768@24bit
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Some (all?) of this information is already there but it's hard to find
and read.

Thanks a ton,
Artem
