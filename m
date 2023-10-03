Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70AE7B5DEE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 02:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjJCABg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 20:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjJCABf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 20:01:35 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D5B9D;
        Mon,  2 Oct 2023 17:01:32 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c3bd829b86so2854495ad.0;
        Mon, 02 Oct 2023 17:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696291292; x=1696896092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=giEViECLPwO3fjVio1lGB0IuquaLWAMa99YP4JVkHs0=;
        b=lWBnigzEi0868fNrMPuAqfJ2/7isfP0nFkADvzfsZ0c5ZIM0Pf+umcUwmEkRspUnxA
         lcBgd2tvo+4uf8PIVEs8OjydlrQQ9WmwqOhH5j/Cqm++mwMxWqRes4EPR2hYG1DRDe3c
         1wYkAeYzta20rhVekRMPFtaMrWFVZ5NxRViYlFI5fumkRFWd6Fz3+5stdvmlQmwgKc7D
         bBs0WEbj8Q/pLfARq3Tof3hwLqmMBk7Lu+stzOO6pPhKakTyWxdWA0fQPSF9yDsbtBId
         CIFDo/MASxh2omSNLG7/973zxVJ2V1wjIjkaRNsVXZ2toPwKbIYPq1q4n2CQndHMrSAy
         DF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696291292; x=1696896092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=giEViECLPwO3fjVio1lGB0IuquaLWAMa99YP4JVkHs0=;
        b=tUAmrRfAghYiQRwRbzO9XBxV9Z42owYmR2YMQfKRfMibzBGV9TKhjaxHdGvsCGbyUD
         kdVZDh+gdtrvwAsjeWUIHelt4aM5BUTPayrnhaAhFdn3En9wPhlEW1PBtpy0sl86yJ0E
         8CBcjNdb6jip5XoiZd8CXXE8c5iSKBJcUU8nlOv0xcMbdimXXVbpvDYiVOQ8MyVGn7rt
         9VWP6ftibB58hBa131WCAMJa2ewutEYiwfRbf7fYHTDMJhplfYg6n6beywuR8zqrL56H
         ca40caRi2wxvKPq+vzu3sOwN2EVXPOIQ2bcGzNeaWt6r916FwnSsbXvWqbTb0kq0pFWG
         aVXQ==
X-Gm-Message-State: AOJu0Ywj+BvAIJA9mC7sBHuXnx+Sm+q3duboUt2n7aEueelIJ8F9HIkF
        x26pBWbMorkPeP68dcZFjqo=
X-Google-Smtp-Source: AGHT+IGep+h5CidOt2lcVjKUFb4zmJXRx2tKw56kYtoQ+HJ/ZjrNIMHluFLqPHgBUHTuzM0fYarC5A==
X-Received: by 2002:a17:903:4284:b0:1c3:2423:8e24 with SMTP id ju4-20020a170903428400b001c324238e24mr10866641plb.8.1696291292342;
        Mon, 02 Oct 2023 17:01:32 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id jb9-20020a170903258900b001b89a6164desm36792plb.118.2023.10.02.17.01.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 17:01:31 -0700 (PDT)
Message-ID: <c68ff294-0060-4621-82d9-61b6bbc12078@gmail.com>
Date:   Tue, 3 Oct 2023 07:01:25 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rt8000usb driver issue (maybe interaction with other drivers)
To:     Stanislaw Gruszka <stf_xl@wp.pl>
Cc:     enc0der <enc0der@gmail.com>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>
References: <CAEXpi5Rd6Y4umKOWRsCjX0kit=W5ZrVhn=MuRkyvJPwmjjDVnA@mail.gmail.com>
 <ZRj_ovMi-Xbb8i-D@debian.me> <20231002185053.GB402943@wp.pl>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20231002185053.GB402943@wp.pl>
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

On 03/10/2023 01:50, Stanislaw Gruszka wrote:
> 
> (cc list is too big, I shrink it)
> 
> On Sun, Oct 01, 2023 at 12:12:02PM +0700, Bagas Sanjaya wrote:
>> On Sat, Sep 30, 2023 at 06:04:22PM -0400, enc0der wrote:
>>> [   28.071586] lr : arm_smmu_dma_sync+0x40/0x70
>>> [   28.075965] sp : ffff8000100231a0
>>> [   28.079365] x29: 0000000000001000 x28: ffff4655c01d0ec0
>>> [   28.084817] x27: ffffaced1f227000 x26: ffff4655c6ee32c0
>>> [   28.090270] x25: 0000000000000000 x24: ffffaced1e405858
>>> [   28.095718] x23: ffff46572e84ae00 x22: ffff4655c6ee2c40
>>> [   28.101165] x21: ffff4655c82c3480 x20: ffffaced1db49e08
>>> [   28.106618] x19: ffff8000100231c0 x18: 0000000000010101
>>> [   28.112073] x17: 0000000000cccccc x16: ffffaced1d23382c
>>> [   28.117520] x15: 0000000000000000 x14: 0000000000000000
>>> [   28.122970] x13: 0000000000000001 x12: 0000000000000000
>>> [   28.128421] x11: 0000000000000008 x10: 0000000000000ab0
>>> [   28.133863] x9 : ffff800010023180 x8 : ffff4655c6ee3750
>>> [   28.139309] x7 : 000000067eb29c20 x6 : 0000000000000238
>>> [   28.144763] x5 : 00000000410fd420 x4 : 0000000000f0000f
>>> [   28.150214] x3 : 0000000000001000 x2 : ffff4655c82c3480
>>> [   28.155658] x1 : ffffaced1db49e08 x0 : ffff465704c37558
>>> [   28.161107] Call trace:
>>> [   28.163620]  0x1000
>>> [   28.165777] Code: bad PC value
>>> [   28.168911] ---[ end trace 62dc42c98ec427ca ]---
>>> [   28.183964] Kernel panic - not syncing: Oops: Fatal exception
>>> [   28.189864] SMP: stopping secondary CPUs
>>> [   29.275883] SMP: failed to stop secondary CPUs 0-5
>>> [   29.280811] Kernel Offset: 0x2ced0d200000 from 0xffff800010000000
> 
> This actually suggest that the issue is somewhere in the core.
> But again, without full logs we can not be sure.
> 

The reason why I added RCU subsystem maintainers to the Cc: list
was because the log the reporter provided points warning to
kernel/rcu/tree_plugin.h.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

