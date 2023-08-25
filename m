Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097F4788D40
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 18:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344029AbjHYQhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 12:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344068AbjHYQhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 12:37:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB005213D;
        Fri, 25 Aug 2023 09:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=M04seJ36piv1fkVK7SFUwKnyxRGLDPUVAdGMO8Zrucs=; b=xWivv6W+ShYQBu54Hepm5ciLDy
        0vyvxs9s/66N101Bj6RnCqzAAau0j2IZXLbVaNF/cS8rm7Qui1uhgL9RKIAjZlXfZUMBv66Oqlr+K
        eHczw4s99QCZsn7+ucQziC5uOseRIDC56QbeQIELNLr6MJJQwdX1t19ZMho8tzIxsge4rfixY3XpT
        ePVlEkLbnq5i6jCv5bNMH05dxirKH4pnKUVaoDD3bWwBdb0wK3Y3LEzpKM6PDljvnb+v9SxZAmHJZ
        nHdN8P1hFJZLjAnMocOrcNbu4AjZTtrF39o1iLfbRsXRW3+4Ox5ZtQBVHzis7HmFtsP4eab3qsoow
        vbLrgDnw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qZZoV-005k0E-2c;
        Fri, 25 Aug 2023 16:37:35 +0000
Message-ID: <5c633b8b-0d9f-9d80-da11-b6828c525ec1@infradead.org>
Date:   Fri, 25 Aug 2023 09:37:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: linux-next: Tree for Aug 25 (drivers/soc/loongson/loongson2_pm.c)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:LOONGARCH" <loongarch@lists.linux.dev>
References: <20230825155204.4fcc6dcf@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230825155204.4fcc6dcf@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/24/23 22:52, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20230824:
> 

on loongarch:
# CONFIG_INPUT is not set

/opt/crosstool/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-ld: drivers/soc/loongson/loongson2_pm.o: in function `loongson2_power_button_init':
/work/lnx/next/linux-next-20230825/LOONG64/../drivers/soc/loongson/loongson2_pm.c:101:(.text+0x350): undefined reference to `input_allocate_device'
/opt/crosstool/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-ld: /work/lnx/next/linux-next-20230825/LOONG64/../drivers/soc/loongson/loongson2_pm.c:109:(.text+0x3dc): undefined reference to `input_set_capability'
/opt/crosstool/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-ld: /work/lnx/next/linux-next-20230825/LOONG64/../drivers/soc/loongson/loongson2_pm.c:111:(.text+0x3e4): undefined reference to `input_register_device'
/opt/crosstool/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-ld: /work/lnx/next/linux-next-20230825/LOONG64/../drivers/soc/loongson/loongson2_pm.c:125:(.text+0x3fc): undefined reference to `input_free_device'
/opt/crosstool/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-ld: drivers/soc/loongson/loongson2_pm.o: in function `input_report_key':
/work/lnx/next/linux-next-20230825/LOONG64/../include/linux/input.h:425:(.text+0x58c): undefined reference to `input_event'
/opt/crosstool/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-ld: drivers/soc/loongson/loongson2_pm.o: in function `input_sync':
/work/lnx/next/linux-next-20230825/LOONG64/../include/linux/input.h:450:(.text+0x5a0): undefined reference to `input_event'
/opt/crosstool/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-ld: drivers/soc/loongson/loongson2_pm.o: in function `input_report_key':
/work/lnx/next/linux-next-20230825/LOONG64/../include/linux/input.h:425:(.text+0x5b4): undefined reference to `input_event'
/opt/crosstool/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-ld: drivers/soc/loongson/loongson2_pm.o: in function `input_sync':
/work/lnx/next/linux-next-20230825/LOONG64/../include/linux/input.h:450:(.text+0x5c8): undefined reference to `input_event'


-- 
~Randy
