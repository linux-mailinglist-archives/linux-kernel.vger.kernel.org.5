Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31A476ADEE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbjHAJeg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Aug 2023 05:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbjHAJeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:34:15 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A89B64227
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 02:32:10 -0700 (PDT)
Received: from loongson.cn (unknown [209.85.128.46])
        by gateway (Coremail) with SMTP id _____8DxBfEY0chkmgEOAA--.33177S3;
        Tue, 01 Aug 2023 17:32:08 +0800 (CST)
Received: from mail-wm1-f46.google.com (unknown [209.85.128.46])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Ax98wV0chka8pDAA--.25082S3;
        Tue, 01 Aug 2023 17:32:07 +0800 (CST)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3fe1fc8768aso20741995e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 02:32:07 -0700 (PDT)
X-Gm-Message-State: ABy/qLYQePvlrahuCV7AzBHk0JBxPow6BT6uBiNdFNS2qGsTrkgi9uWg
        CyBePHB1tK+rsFIp5/iiF2uo6pXvUUzA6QFogp80OQ==
X-Google-Smtp-Source: APBJJlHqbDFsfSbkV7K1RkpgBmye51dh7D/GseqY2VYp7RQZPUaf6FUdgbXwn36j93aMBMNRlwW7GAFAFCMYWjSYye8=
X-Received: by 2002:adf:eec3:0:b0:317:6849:2d39 with SMTP id
 a3-20020adfeec3000000b0031768492d39mr2061081wrp.10.1690882325216; Tue, 01 Aug
 2023 02:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230801011554.3950435-1-guoren@kernel.org> <CAHirt9ht8AsE=FC8+222JDZXH3T58uLt+o=_pq+1zBhv1MKRjg@mail.gmail.com>
 <CAJF2gTRa5erHomJzLgUFO4SGqd5zSDwn6r3WN7kM8aWpv1vesg@mail.gmail.com> <CAJF2gTQ1hV1vipAo3H4X4WiPO84kVVFZcdGq7u4f0bVTry_akQ@mail.gmail.com>
In-Reply-To: <CAJF2gTQ1hV1vipAo3H4X4WiPO84kVVFZcdGq7u4f0bVTry_akQ@mail.gmail.com>
From:   WANG Rui <wangrui@loongson.cn>
Date:   Tue, 1 Aug 2023 17:31:54 +0800
X-Gmail-Original-Message-ID: <CAHirt9gVqE=9vviJEY=kY=booVRmFPHrnFsKCXPXnXiWTB8bZQ@mail.gmail.com>
Message-ID: <CAHirt9gVqE=9vviJEY=kY=booVRmFPHrnFsKCXPXnXiWTB8bZQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Fixup cmpxchg sematic for memory barrier
To:     Guo Ren <guoren@kernel.org>
Cc:     chenhuacai@kernel.or, kernel@xen0n.name, arnd@arndb.de,
        andi.shyti@linux.intel.com, andrzej.hajda@intel.com,
        peterz@infradead.org, will@kernel.org, boqun.feng@gmail.com,
        mark.rutland@arm.com, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-CM-TRANSID: AQAAf8Ax98wV0chka8pDAA--.25082S3
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Jr1xZFyUAr1rWry5GF18Xrc_yoWxCrb_C3
        Z7CrWrZr48Jw18JanxWry3ZF4j9FZruFyUJFy7t3Wvqa40q3ZxJFsFyr93Za4rArs2yFn7
        C3WDZa98Zw17AosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
        s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
        cSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
        vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
        14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVW8ZVWrXwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWHqcU
        UUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Aug 1, 2023 at 5:05 PM Guo Ren <guoren@kernel.org> wrote:
>
> > The CoRR problem would cause wider problems than this.For this case,
> > do you mean your LL -> LL would be reordered?
> >
> > CPU 0
> >           CPU1
> > LL(2) (set ex-monitor)
> >
> >                 store (break the ex-monitor)
> > LL(1) (reordered instruction set ex-monitor
> > SC(3) (successes ?)
> Sorry for the mail client reformat, I mean:
>
> CPU0  LL(2) (set ex-monitor)
> CPU1  STORE (break the ex-monitor)
> CPU0  LL(1) (reordered instruction set ex-monitor
> CPU0  SC(3) (success?)

No. LL and LL won't reorder because LL implies a memory barrier(though
not acquire semantics).

Regards,
-- 
WANG Rui

