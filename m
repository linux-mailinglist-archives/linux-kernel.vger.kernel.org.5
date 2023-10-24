Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406427D51CB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbjJXNaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjJXNaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:30:08 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A92B6EA1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:30:02 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 38FD0120037;
        Tue, 24 Oct 2023 16:30:00 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 38FD0120037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1698154200;
        bh=uDFL+UiRh0fC+fhP1qbXLp0LfogzXYMs/LCjL9ObsmQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=ivDRJpEw2rF4222v+BO69JmmNfMvB7xycsx/ORGROPlPRZTsqoqnsuAxkSHzjBW+z
         yqZ2KzG4OQUt2pTg4R6scREJrMc9JsGuvN1g+6AJrU9GgfjHFN246AvJr9c2Ol6yWH
         NUOz8tisI+z98dS3X7eq/PgTT8SfPWI3U2taQEauakdD77pVajFGlWZeIzhHKS4L65
         HZgThlEAN1eZFNgcfqXHdiM0svb4m20YisB0RZbEGg29b7nsRTjOOzPm9vCsFg32IG
         AkdgsRKjWd1GyAglsZsJ6+SrFSYnAZ+9Bof9zAZno9vXTIwY1VA4yzTAUOcdXMUhxF
         xek566jBdQO5A==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Tue, 24 Oct 2023 16:29:58 +0300 (MSK)
Received: from [192.168.1.146] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 24 Oct 2023 16:29:58 +0300
Message-ID: <b6b5b413-0fbe-4ce2-9d44-451b16555eb3@salutedevices.com>
Date:   Tue, 24 Oct 2023 16:29:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] jffs2: make cleanmarker support option
To:     Richard Weinberger <richard@nod.at>
CC:     David Woodhouse <dwmw2@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Yu Zhe <yuzhe@nfschina.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        kernel <kernel@sberdevices.ru>
References: <20231019073838.17586-1-mmkurbanov@salutedevices.com>
 <20231019073838.17586-3-mmkurbanov@salutedevices.com>
 <1258129392.18842.1697703134703.JavaMail.zimbra@nod.at>
 <3951ac21-a0a4-47b5-be94-edb0140c69a5@salutedevices.com>
 <406915015.32119.1698083084288.JavaMail.zimbra@nod.at>
Content-Language: en-US
From:   Martin Kurbanov <mmkurbanov@salutedevices.com>
In-Reply-To: <406915015.32119.1698083084288.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180842 [Oct 24 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: mmkurbanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/24 11:32:00 #22275184
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.10.2023 20:44, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Von: "Martin Kurbanov" <mmkurbanov@salutedevices.com>
>> If you disable the cleanmarker, the found clean block (filled with 0xff)
>> will be erased again (see fs/jffs2/scan.c#L162).
>> In my opinion, it is better to perform the block erasure again than to
>> not work with such a nand flash at all.
> 
> Doesn't this case many re-erases at each mount time?

You are right. David proposed the good solution.

> BTW: I tried your patch in nandsim, jffs2 was unhappy.
> [   56.147361] jffs2: notice: (440) jffs2_build_xattr_subsystem: complete building xattr subsystem, 0 of xdatum (0 unchecked, 0 orphan) and 0 of xref (0 dead, 0 orphan) found.
> [   56.200438] nand: nand_do_write_ops: attempt to write non page aligned data
> [   56.201090] jffs2: Write clean marker to block at 0x001f8000 failed: -22
> 
> Do you have an idea?

According to this code from the function jffs2_mark_erased_block():

```
if (jffs2_cleanmarker_oob(c) || c->cleanmarker_size == 0) {

    if (jffs2_cleanmarker_oob(c)) {
        if (jffs2_write_nand_cleanmarker(c, jeb))
            goto filebad;
    }
} else {

    struct kvec vecs[1];
    struct jffs2_unknown_node marker = {
        .magic = cpu_to_je16(JFFS2_MAGIC_BITMASK),
        .nodetype = cpu_to_je16(JFFS2_NODETYPE_CLEANMARKER),
        .totlen = cpu_to_je32(c->cleanmarker_size)
    };
```

the "if" branch should be executed because "cleanmarker_size" is set to
0 for NAND flash:

```
int jffs2_nand_flash_setup(struct jffs2_sb_info *c)
{
    if (!c->mtd->oobsize)
        return 0;

    /* Cleanmarker is out-of-band, so inline size zero */
    c->cleanmarker_size = 0;
```

In your case, the "else" branch was executed. I assume that "oobsize" is
equal to 0. In this scenario, JFFS2 will not mount without
applying my patch.

-- 
Best Regards,
Martin Kurbanov
