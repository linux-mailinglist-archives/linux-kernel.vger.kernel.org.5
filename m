Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B53E7F84EE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 20:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346084AbjKXTxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 14:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345941AbjKXTxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 14:53:52 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1609A10F6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:53:58 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54b0e553979so515044a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700855636; x=1701460436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=akxw437hH7pv9R9a7Z4VdJ7EFr4IKHM7FwBvILtqxGE=;
        b=QYjsUSXN3h9WEUqdCyF0hGOYCr2TItVX83MF5+CrRJl9jeuhBUDEUFxX0LNkdVw+KX
         5kZzQ/CgiG3ecW8kT/4/NDgcsYxEysv16ZrnEYO6KUdX+FkaFWuWlYnYKSQAUUkPkOmo
         byXJ57iiFMkUWGrujc78a+unYm071i3GTI2NBtzw/8GUS5O3cpHpGw2IkligtLzw6JDK
         wg3T1c2F2Sn2VpX7upPq45x6543N2X/vTa3ksnSZe5HTo+JB5r1ylary0mSnvO46Kwyq
         241Sq7f17NvvpzktyNJtY36OxwuGKu2McSJb3r/MMk/CCnyZ75gwPc605MunmlwNoiZt
         +c+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700855636; x=1701460436;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=akxw437hH7pv9R9a7Z4VdJ7EFr4IKHM7FwBvILtqxGE=;
        b=xQUsBLsJSZRpDbdmHMvfk6UZsn+0OwAl3lUEWjkdganlDW/Ibw03ahUKG2DWW7dIZb
         9NwDD3pMwW88CUxGNd6PZ95fZjCVlYGM2U3iGIyIk4Algukh2x42PCdPY2KK1RhRl7J8
         CDLXZSH2LxPW/kOocBiFIG9SzZ3A4YP4BVlPByY0t6Chf3c8aMY16awug44L7J+tV+eH
         /Smo5svy2CMKBxU132G0NkS0T4becsW9t10dmEIvN7l8v54j14dBfNflkQ11X5rSIQym
         hdkTycP1tYp3nq/FLcJxjS6xEDKOj8N9FpsUI/ATQZ0ll6raEKeW5yQlh7F9JkvG4hZ9
         IyLQ==
X-Gm-Message-State: AOJu0Ywn7IyLXHwmqTermMjPcHeTP6KukFnOIEbSe6uydEBhf5QpIAah
        ss2an3PCm/Q8ZiAFLQmQE5I3mA==
X-Google-Smtp-Source: AGHT+IF9A1fX43xCXs6oYY++234A06E7jGHzgfWUKypH/RSJLy3jbfomkr/OxJCgLD9RNycCET/UUg==
X-Received: by 2002:a05:6402:22e8:b0:54b:1a4c:8719 with SMTP id dn8-20020a05640222e800b0054b1a4c8719mr83838edb.9.1700855636302;
        Fri, 24 Nov 2023 11:53:56 -0800 (PST)
Received: from [192.168.0.174] ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id z15-20020aa7d40f000000b005488bf98309sm2131071edq.56.2023.11.24.11.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 11:53:55 -0800 (PST)
Message-ID: <0abce5f8-2688-451d-8c70-8fc32c73f8be@linaro.org>
Date:   Fri, 24 Nov 2023 21:53:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] docs: mtd: spi-nor: add sections about flash
 additions and testing
Content-Language: en-US
To:     pratyush@kernel.org, michael@walle.cc, bagasdotme@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, linux-kernel@vger.kernel.org
References: <20231124184902.1194235-1-tudor.ambarus@linaro.org>
 <20231124184902.1194235-2-tudor.ambarus@linaro.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20231124184902.1194235-2-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.11.2023 20:49, Tudor Ambarus wrote:
> Add sections about how to propose a new flash addition and about the
> minimum testing requirements.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Reviewed-by: Michael Walle <michael@walle.cc>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> ---
>  Documentation/driver-api/mtd/spi-nor.rst | 187 +++++++++++++++++++++++
>  1 file changed, 187 insertions(+)
> 
> diff --git a/Documentation/driver-api/mtd/spi-nor.rst b/Documentation/driver-api/mtd/spi-nor.rst
> index c22f8c0f7950..3b2e1a6a88bf 100644
> --- a/Documentation/driver-api/mtd/spi-nor.rst
> +++ b/Documentation/driver-api/mtd/spi-nor.rst
> @@ -63,3 +63,190 @@ The main API is spi_nor_scan(). Before you call the hook, a driver should
>  initialize the necessary fields for spi_nor{}. Please see
>  drivers/mtd/spi-nor/spi-nor.c for detail. Please also refer to spi-fsl-qspi.c
>  when you want to write a new driver for a SPI NOR controller.
> +
> +How to propose a new flash addition
> +-----------------------------------
> +
> +Most SPI NOR flashes comply with the JEDEC JESD216
> +Serial Flash Discoverable Parameter (SFDP) standard. SFDP describes
> +the functional and feature capabilities of serial flash devices in a
> +standard set of internal read-only parameter tables.
> +
> +The SPI NOR driver queries the SFDP tables in order to determine the
> +flash's parameters and settings. If the flash defines the SFDP tables
> +it's likely that you won't need a flash entry at all, and instead
> +rely on the generic flash driver which probes the flash solely based
> +on its SFDP data. All one has to do is to specify the "jedec,spi-nor"
> +compatible in the device tree.
> +
> +There are cases however where you need to define an explicit flash
> +entry. This typically happens when the flash has settings or support
> +that is not covered by the SFDP tables (e.g. Block Protection), or
> +when the flash contains mangled SFDP data. If the later, one needs
> +to implement the ``spi_nor_fixups`` hooks in order to amend the SFDP
> +parameters with the correct values.
> +
> +Minimum testing requirements
> +-----------------------------
> +
> +Do all the tests from below and paste them in the commit's comments
> +section, after the ``---`` marker.
> +
> +1) Specify the controller that you used to test the flash and specify
> +   the frequency at which the flash was operated, e.g.::
> +
> +    This flash is populated on the X board and was tested at Y
> +    frequency using the Z (put compatible) SPI controller.
> +
> +2) Dump the sysfs entries and print the md5/sha1/sha256 SFDP checksum::
> +
> +    root@1:~#  cat /sys/bus/spi/devices/spi0.0/spi-nor/partname
> +    sst26vf064b
> +    root@1:~#  cat /sys/bus/spi/devices/spi0.0/spi-nor/jedec_id
> +    bf2643
> +    root@1:~#  cat /sys/bus/spi/devices/spi0.0/spi-nor/manufacturer
> +    sst
> +    root@1:~# xxd -p /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
> +    53464450060102ff00060110300000ff81000106000100ffbf0001180002
> +    0001fffffffffffffffffffffffffffffffffd20f1ffffffff0344eb086b
> +    083b80bbfeffffffffff00ffffff440b0c200dd80fd810d820914824806f
> +    1d81ed0f773830b030b0f7ffffff29c25cfff030c080ffffffffffffffff
> +    ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> +    ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> +    ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> +    ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> +    ffffffffffffffffffffffffffffffffff0004fff37f0000f57f0000f9ff
> +    7d00f57f0000f37f0000ffffffffffffffffffffffffffffffffffffffff
> +    ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> +    ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> +    ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> +    ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> +    ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> +    ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> +    ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> +    ffffbf2643ffb95ffdff30f260f332ff0a122346ff0f19320f1919ffffff
> +    ffffffff00669938ff05013506040232b03072428de89888a585c09faf5a
> +    ffff06ec060c0003080bffffffffff07ffff0202ff060300fdfd040700fc
> +    0300fefe0202070e
> +    root@1:~# sha256sum /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
> +    428f34d0461876f189ac97f93e68a05fa6428c6650b3b7baf736a921e5898ed1  /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
> +
> +   Please dump the SFDP tables using ``xxd -p``. It enables us to do
> +   the reverse operation and convert the hexdump to binary with
> +   ``xxd -rp``. Dumping the SFDP data with ``hexdump -Cv`` is accepted,
> +   but less desirable.
> +
> +3) Dump debugfs data::
> +
> +    root@1:~# cat /sys/kernel/debug/spi-nor/spi0.0/capabilities
> +    Supported read modes by the flash
> +     1S-1S-1S
> +      opcode		0x03
> +      mode cycles	0
> +      dummy cycles	0
> +     1S-1S-1S (fast read)
> +      opcode		0x0b
> +      mode cycles	0
> +      dummy cycles	8
> +     1S-1S-2S
> +      opcode		0x3b
> +      mode cycles	0
> +      dummy cycles	8
> +     1S-2S-2S
> +      opcode		0xbb
> +      mode cycles	4
> +      dummy cycles	0
> +     1S-1S-4S
> +      opcode		0x6b
> +      mode cycles	0
> +      dummy cycles	8
> +     1S-4S-4S
> +      opcode		0xeb
> +      mode cycles	2
> +      dummy cycles	4
> +     4S-4S-4S
> +      opcode		0x0b
> +      mode cycles	2
> +      dummy cycles	4
> +
> +    Supported page program modes by the flash
> +     1S-1S-1S
> +      opcode	0x02
> +
> +    root@1:~# cat /sys/kernel/debug/spi-nor/spi0.0/params
> +    name		sst26vf064b
> +    id			bf 26 43 bf 26 43
> +    size		8.00 MiB
> +    write size		1
> +    page size		256
> +    address nbytes	3
> +    flags		HAS_LOCK | HAS_16BIT_SR | SOFT_RESET | SWP_IS_VOLATILE
> +
> +    opcodes
> +     read		0xeb
> +      dummy cycles	6
> +     erase		0x20
> +     program		0x02
> +     8D extension	none
> +
> +    protocols
> +     read		1S-4S-4S
> +     write		1S-1S-1S
> +     register		1S-1S-1S
> +
> +    erase commands
> +     20 (4.00 KiB) [0]
> +     d8 (8.00 KiB) [1]
> +     d8 (32.0 KiB) [2]
> +     d8 (64.0 KiB) [3]
> +     c7 (8.00 MiB)
> +
> +    sector map
> +     region (in hex)   | erase mask | flags
> +     ------------------+------------+----------
> +     00000000-00007fff |     [01  ] |
> +     00008000-0000ffff |     [0 2 ] |
> +     00010000-007effff |     [0  3] |
> +     007f0000-007f7fff |     [0 2 ] |
> +     007f8000-007fffff |     [01  ] |
> +
> +4) Use `mtd-utils <https://git.infradead.org/mtd-utils.git>`__
> +   and verify that erase, read and page program operations work fine::
> +
> +    root@1:~# dd if=/dev/urandom of=./spi_test bs=1M count=2
> +    2+0 records in
> +    2+0 records out
> +    2097152 bytes (2.1 MB, 2.0 MiB) copied, 0.848566 s, 2.5 MB/s
> +
> +    root@1:~# mtd_debug erase /dev/mtd0 0 2097152
> +    Erased 2097152 bytes from address 0x00000000 in flash
> +
> +    root@1:~# mtd_debug read /dev/mtd0 0 2097152 spi_read
> +    Copied 2097152 bytes from address 0x00000000 in flash to spi_read
> +
> +    root@1:~# hexdump spi_read
> +    0000000 ffff ffff ffff ffff ffff ffff ffff ffff
> +    *
> +    0200000

it's not enough. If the flash comes erased by default, and erase opcode
is ignored, we won't catch it. Thus we'll need a second erase, after we
verify the write.

> +
> +    root@1:~# sha256sum spi_read
> +    4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  spi_read
> +
> +    root@1:~# mtd_debug write /dev/mtd0 0 2097152 spi_test
> +    Copied 2097152 bytes from spi_test to address 0x00000000 in flash
> +
> +    root@1:~# mtd_debug read /dev/mtd0 0 2097152 spi_read
> +    Copied 2097152 bytes from address 0x00000000 in flash to spi_read
> +
> +    root@1:~# sha256sum spi*
> +    c444216a6ba2a4a66cccd60a0dd062bce4b865dd52b200ef5e21838c4b899ac8  spi_read
> +    c444216a6ba2a4a66cccd60a0dd062bce4b865dd52b200ef5e21838c4b899ac8  spi_test

here again:
	root@1:~# mtd_debug erase /dev/mtd0 0 2097152
	root@1:~# mtd_debug read /dev/mtd0 0 2097152 spi_read
	root@1:~# sha256sum spi_read


> +
> +    root@1:~# mtd_debug info /dev/mtd0
> +    mtd.type = MTD_NORFLASH
> +    mtd.flags = MTD_CAP_NORFLASH
> +    mtd.size = 8388608 (8M)
> +    mtd.erasesize = 4096 (4K)
> +    mtd.writesize = 1
> +    mtd.oobsize = 0
> +    regions = 0
