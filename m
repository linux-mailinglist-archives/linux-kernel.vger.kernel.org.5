Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3E38040A1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 22:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjLDU7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjLDU7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:59:51 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5152CB2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:59:57 -0800 (PST)
Received: from mail.denx.de (unknown [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 20F2F876DA;
        Mon,  4 Dec 2023 21:59:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1701723595;
        bh=SmAvWJjBSFrmv67o9Uu6ysguaUrpN+50gXjQo05+N7g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ks5JPrOJvCgScLceDnfY8bT+W8LmLLvZZ/IXiA5upfpFlWiRLdTpOkC/7Sta7Gwxf
         eOb50Hw873ylHu1boHUpji3k88yc55fORWAIBItop9Ly3sh2O0JqUXKiQUtR1yTe0E
         Mu1Q1NbeVfcsBa2DbYJwoJD5T3YMBKxMCxiH+esfnve0E3qJ5HeNx8djNGzl7FPVR3
         mB1/8e8x63415AJgcN3oHw2h2iBGw6rdIVrhV1yOwm4FJxLaQiRSiqorjgznZ8vuHx
         t0nXhBDLkGhZ1JG9Pr8T7Z0CXOKzV+ZGdQ0E6PkD6ChfUtCZhorMeHAlVv0hMS1iXU
         XVfUJuSXIyyjw==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 04 Dec 2023 17:59:55 -0300
From:   Fabio Estevam <festevam@denx.de>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     pratyush@kernel.org, michael@walle.cc,
        linux-mtd@lists.infradead.org, takahiro.kuwano@infineon.com,
        bacem.daassi@infineon.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] mtd: spi-nor: introduce die erase
In-Reply-To: <f9dc82f3-070a-42cd-a92d-83d031647867@linaro.org>
References: <20231125123529.55686-1-tudor.ambarus@linaro.org>
 <d7ce98eb-c920-413f-bbe9-059077a9dda7@linaro.org>
 <6156a51f7eadc9594404bb0eacabe1a6@denx.de>
 <f9dc82f3-070a-42cd-a92d-83d031647867@linaro.org>
Message-ID: <8de7595d8f4839187fdbbe7e139016bc@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2023 07:42, Tudor Ambarus wrote:

> Thanks, will do. Would you please replicate the tests that I did in
> patch 3/5 for mt25qu01q? You'll have to modify a bit the offsets for 
> the
> die and cross die tests.


Here it goes.

Can this series be applied now?

:~# cat /sys/bus/spi/devices/spi0.0/spi-nor/partname
mt25qu01g

:~# cat /sys/bus/spi/devices/spi0.0/spi-nor/jedec_id
20bb21104400

:~# cat /sys/bus/spi/devices/spi0.0/spi-nor/manufacturer
st

:~# xxd -p  
/sys/devices/platform/soc@0/30800000.bus/30bb0000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp
53464450060101ff00060110300000ff84000102800000ffffffffffffff
ffffffffffffffffffffffffffffffffffffe520fbffffffff3f29eb276b
273b27bbffffffffffff27bbffff29eb0c2010d80f520000244a99008b8e
03e1ac0127387a757a75fbbdd55c4a0f82ff81bd3d36ffffffffffffffff
ffffffffffffffffffe7ffff21dcffff

:~# sha256sum /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
e49dfee6eeb73c55e94c07a8c7d352dd7d8774b830a64ed1059ef6e7bc833668  
/sys/bus/spi/devices/spi0.0/spi-nor/sfdp

:~# cat /sys/kernel/debug/spi-nor/spi0.0/capabilities
Supported read modes by the flash
  1S-1S-1S
   opcode	0x13
   mode cycles	0
   dummy cycles	0
  1S-1S-2S
   opcode	0x3c
   mode cycles	1
   dummy cycles	7
  1S-2S-2S
   opcode	0xbc
   mode cycles	1
   dummy cycles	7
  2S-2S-2S
   opcode	0xbc
   mode cycles	1
   dummy cycles	7
  1S-1S-4S
   opcode	0x6c
   mode cycles	1
   dummy cycles	7
  1S-4S-4S
   opcode	0xec
   mode cycles	1
   dummy cycles	9
  4S-4S-4S
   opcode	0xec
   mode cycles	1
   dummy cycles	9

Supported page program modes by the flash
  1S-1S-1S
   opcode	0x12
  1S-1S-4S
   opcode	0x34
  1S-4S-4S
   opcode	0x3e

:~# cat /sys/kernel/debug/spi-nor/spi0.0/params
name		mt25qu01g
id		20 bb 21 10 44 00
size		128 MiB
write size	1
page size	256
address nbytes	4
flags		4B_OPCODES | HAS_4BAIT | HAS_16BIT_SR | SOFT_RESET

opcodes
  read		0x6c
   dummy cycles	8
  erase		0x21
  program	0x12
  8D extension	none

protocols
  read		1S-1S-4S
  write		1S-1S-1S
  register	1S-1S-1S

erase commands
  21 (4.00 KiB) [1]
  dc (64.0 KiB) [3]
  c4 (128 MiB)

sector map
  region (in hex)   | erase mask | flags
  ------------------+------------+----------
  00000000-07ffffff |     [ 123] |
root@mcde3000a:~#

:~# dd if=/dev/urandom of=./spi_test bs=1M count=2
2+0 records in
2+0 records out
2097152 bytes (2.1 MB, 2.0 MiB) copied, 0.0303915 s, 69.0 MB/s

:~# mtd_debug erase /dev/mtd0 0 2097152
Erased 2097152 bytes from address 0x00000000 in flash
:~# mtd_debug read /dev/mtd0 0 2097152 spi_read
Copied 2097152 bytes from address 0x00000000 in flash to spi_read
:~# hexdump spi_read
0000000 ffff ffff ffff ffff ffff ffff ffff ffff
*
0200000
:~# sha256sum spi_read
4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  
spi_read
:~# mtd_debug write /dev/mtd0 0 2097152 spi_test
Copied 2097152 bytes from spi_test to address 0x00000000 in flash

:~# mtd_debug read /dev/mtd0 0 2097152 spi_read
Copied 2097152 bytes from address 0x00000000 in flash to spi_read
:~# sha256sum spi*
d5c15629e1fa019941cb820eff6ffd2a9008b5796bb23a67c351f42af48ce180  
spi_read
d5c15629e1fa019941cb820eff6ffd2a9008b5796bb23a67c351f42af48ce180  
spi_test
:~# mtd_debug erase /dev/mtd0 0 2097152
Erased 2097152 bytes from address 0x00000000 in flash

:~# mtd_debug read /dev/mtd0 0 2097152 spi_read
Copied 2097152 bytes from address 0x00000000 in flash to spi_read
:~# sha256sum spi*
4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  
spi_read
d5c15629e1fa019941cb820eff6ffd2a9008b5796bb23a67c351f42af48ce180  
spi_test
:~# mtd_debug info /dev/mtd0
mtd.type = MTD_NORFLASH
mtd.flags = MTD_CAP_NORFLASH
mtd.size = 134217728 (128M)
mtd.erasesize = 4096 (4K)
mtd.writesize = 1
mtd.oobsize = 0
regions = 0


real	0m0.005s
user	0m0.001s
sys	0m0.005s
:~# time mtd_debug erase /dev/mtd0 0 134217728
Erased 134217728 bytes from address 0x00000000 in flash

real	0m1.768s
user	0m0.001s
sys	0m1.609s
:~# echo "ta writes something into the first die" > firstdie
:~# echo "ta writes something into the second die" > seconddie
:~# ls -al
total 4112
drwx------ 2 root root    4096 Dec  4 20:36 .
drwxr-xr-x 4 root root    4096 Mar  9  2018 ..
-rw-r--r-- 1 root root      39 Dec  4 20:36 firstdie
-rw-r--r-- 1 root root      40 Dec  4 20:36 seconddie
-rw-r--r-- 1 root root 2097152 Dec  4 20:35 spi_read
-rw-r--r-- 1 root root 2097152 Dec  4 20:32 spi_test
:~# mtd_debug write /dev/mtd0 0 39 firstdie
Copied 39 bytes from firstdie to address 0x00000000 in flash
:~# mtd_debug write /dev/mtd0 67108864 40 seconddie
Copied 40 bytes from seconddie to address 0x04000000 in flash
:~# mtd_debug read /dev/mtd0 0 134217728 read
Copied 134217728 bytes from address 0x00000000 in flash to read
:~# hexdump -C read
00000000  74 61 20 77 72 69 74 65  73 20 73 6f 6d 65 74 68  |ta writes 
someth|
00000010  69 6e 67 20 69 6e 74 6f  20 74 68 65 20 66 69 72  |ing into 
the fir|
00000020  73 74 20 64 69 65 0a ff  ff ff ff ff ff ff ff ff  |st 
die..........|
00000030  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
04000000  74 61 20 77 72 69 74 65  73 20 73 6f 6d 65 74 68  |ta writes 
someth|
04000010  69 6e 67 20 69 6e 74 6f  20 74 68 65 20 73 65 63  |ing into 
the sec|
04000020  6f 6e 64 20 64 69 65 0a  ff ff ff ff ff ff ff ff  |ond 
die.........|
04000030  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
08000000
:~# time mtd_debug erase /dev/mtd0 0 134217728
Erased 134217728 bytes from address 0x00000000 in flash

real	0m2.029s
user	0m0.001s
sys	0m1.853s

:~# echo "ta writes a something crossing the dice" > cross-dice
:~# mtd_debug write /dev/mtd0 67108857 40 cross-dice
Copied 40 bytes from cross-dice to address 0x03fffff9 in flash

:~# mtd_debug read /dev/mtd0 0 134217728 read
Copied 134217728 bytes from address 0x00000000 in flash to read
:~# hexdump -C read
00000000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
03fffff0  ff ff ff ff ff ff ff ff  ff 74 61 20 77 72 69 74  |.........ta 
writ|
04000000  65 73 20 61 20 73 6f 6d  65 74 68 69 6e 67 20 63  |es a 
something c|
04000010  72 6f 73 73 69 6e 67 20  74 68 65 20 64 69 63 65  |rossing the 
dice|
04000020  0a ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
04000030  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
08000000
:~# mtd_debug read /dev/mtd0 67108857 40 read
Copied 40 bytes from address 0x03fffff9 in flash to read
:~# hexdump -C read
00000000  74 61 20 77 72 69 74 65  73 20 61 20 73 6f 6d 65  |ta writes a 
some|
00000010  74 68 69 6e 67 20 63 72  6f 73 73 69 6e 67 20 74  |thing 
crossing t|
00000020  68 65 20 64 69 63 65 0a                           |he dice.|
00000028
:~#
