Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686F677DDFC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243607AbjHPJ5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236747AbjHPJ4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:56:49 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A019CC1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:56:48 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-53482b44007so3742946a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692179808; x=1692784608;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBbWFhxqqCcGSdxX6L9y8gpcH9P2VcnoWxvrGpmme/g=;
        b=L7NZ5l6xxSfCK6y8MCFY/pEyDTkmWjQSrQCriAsKuhTsoVHCwkaMNEIDDVP5YYvqWX
         bHxajzgVqykRTEfRlBynFp7azUVjqBaHiHD0WAkTWOtok7Jhj+hdq+ykMUzINmANvr0k
         wsilIupRWQhh1eVgUSJ2QT/0c9uxnWBp+UvftskPPxnHXUooyizN78lFjfwXFK9r0HSw
         SQfL7NWliXxvSACCEdcSYCVz5CKKIxORJb7RMU4XaafrgCDFdDqZbDsSv4O6yfhgdB8C
         1SpUKikNr/7eB0Ni9LVke+5aCY2j4nz4LLalS91BhGhPHhvm2xrTfrxJLKx8ItxnEv5i
         YV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692179808; x=1692784608;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WBbWFhxqqCcGSdxX6L9y8gpcH9P2VcnoWxvrGpmme/g=;
        b=CWriQUTJCj3rAFyH9GRGpVCt5XHt44QEaMxqJmxcys6BWC6OSQGzCd7G+CwEiaJanT
         z2rRDUk5NWve/3G/3sNt5ssiskc0AHrJAnY9e+WxmHlMeUT92X6UfWzgPHbbt1lfxHFa
         qIaAEfK9bawZpxvbkpTJBSsvJH+NMAJ8zlmhjphz9WYDYbGWPTnzRYO6g3sT14ddsEgP
         55a+PHfR+D+XfH3B2hJxxlPBIJE3ZRgqRX85T/r4dxYVq7MTs4Cdql0UIm6DJvpio5dm
         0uTpxGWdFZVLtSdLud+UfhbOITvN2jzsVUCNiLXxPvZzdwpJmprZkB0SLR8nl90yHSn2
         YO5Q==
X-Gm-Message-State: AOJu0YzNuw/X2NAHUz/m+64NF/M3kUKM41xDOzxLSADkHWVvBI6nsseN
        BtknpKx387tAhONHHS6/WzI=
X-Google-Smtp-Source: AGHT+IHMQqnNNpKK0OYvp3ioa9FinjRPGijehCrG6tg1HNg2sSFi2xL1LWlSANBX4nNGkBsuylbLbw==
X-Received: by 2002:a17:90a:e004:b0:269:21ad:bdec with SMTP id u4-20020a17090ae00400b0026921adbdecmr904692pjy.28.1692179808036;
        Wed, 16 Aug 2023 02:56:48 -0700 (PDT)
Received: from [192.168.0.105] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090a31c600b00267eead2f16sm11610829pjf.36.2023.08.16.02.56.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 02:56:47 -0700 (PDT)
Message-ID: <44f5a8f7-0bf4-c986-a0dc-dc12d0cb30ca@gmail.com>
Date:   Wed, 16 Aug 2023 16:56:44 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     Linux MTD <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: ubi: fastmap: Fix a series of wear leveling problems
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a bug report with proposed fixes on Bugzilla [1]. Quoting from it
(only the first problem that is quoted):

> Problem 1: large erase counter for single fastmap data PEB
> 
> Config:
> x86_64 qemu
> flash: nandsim
> CONFIG_MTD_UBI_WL_THRESHOLD=128
> CONFIG_MTD_UBI_FASTMAP=y
> ubi->beb_rsvd_pebs=0
> 
> Running fsstress on ubifs for 3h(fastmap data PEB has large erase counter than others):
> =========================================================
> from              to     count      min      avg      max
> ---------------------------------------------------------
> 0        ..        9:        0        0        0        0
> 10       ..       99:      532       84       92       99
> 100      ..      999:    15787      100      147      229
> 1000     ..     9999:       64     4699     4765     4826
> 10000    ..    99999:        0        0        0        0
> 100000   ..      inf:        1   272935   272935   272935
> ---------------------------------------------------------
> Total               :    16384       84      180   272935
> PEB 8031(ec=272935) is always taken for fastmap data.
> 
> After fix, running fsstress on ubifs for 12h(no pool reservation), no individual peb has big erase counter:
> =========================================================
> from              to     count      min      avg      max
> ---------------------------------------------------------
> 0        ..        9:        0        0        0        0
> 10       ..       99:        0        0        0        0
> 100      ..      999:    16320      609      642      705
> 1000     ..     9999:        0        0        0        0
> 10000    ..    99999:       64    18176    18234    18303
> 100000   ..      inf:        0        0        0        0
> ---------------------------------------------------------
> Total               :    16384      609      710    18303

See Bugzilla for the full thread (with other problems mentioned) and
attached patch series that fixes them.

Zhihao: I asked you on BZ to send your patches to linux-mtd list,
but you didn't respond there. Would you like to send them for
review?

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217787

-- 
An old man doll... just what I always wanted! - Clara
