Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665CC7CBBDC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbjJQHBv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Oct 2023 03:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJQHBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:01:50 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7015783;
        Tue, 17 Oct 2023 00:01:45 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4S8l1p3p5Hz9ylWC;
        Tue, 17 Oct 2023 14:48:46 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAXcJE+MS5lg+dfAg--.50713S2;
        Tue, 17 Oct 2023 08:01:26 +0100 (CET)
Message-ID: <468436cf766732a3cfc55d07ad119a6ccdc815c1.camel@huaweicloud.com>
Subject: Re: [PATCH v15 00/11] LSM: Three basic syscalls
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Date:   Tue, 17 Oct 2023 09:01:15 +0200
In-Reply-To: <CAHC9VhRQ7xpeSX7b3VZfzQ15noJ8mgauNMuHWo_n3hMgsYMAfQ@mail.gmail.com>
References: <20230912205658.3432-1-casey.ref@schaufler-ca.com>
         <20230912205658.3432-1-casey@schaufler-ca.com>
         <CAHC9VhRcbp3iWQwL7FTUrcU1C3OsZ413Nbq+17oTwW7hZ7XvBw@mail.gmail.com>
         <CAHC9VhSqY5+DR-jXprrftb1=CzDvhTh0Ep66A16RMd4L7W7TYw@mail.gmail.com>
         <ae39864947debbc7c460db478b8abe1c147b7d5c.camel@huaweicloud.com>
         <CAHC9VhRQ7xpeSX7b3VZfzQ15noJ8mgauNMuHWo_n3hMgsYMAfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-CM-TRANSID: LxC2BwAXcJE+MS5lg+dfAg--.50713S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZryfurWftr4Duw15tF4xZwb_yoW8ur4rpF
        WDKay0kF4kAF1jkrn7Za1rAa48Kryru3yjgF98Cry7ArW5CFy0grW2kFW2vryUWrn3ta4r
        Xr4UKFyDC3Wqy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgANBF1jj5EcEgABsk
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-16 at 11:06 -0400, Paul Moore wrote:
> On Mon, Oct 16, 2023 at 8:05 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > 
> > Sorry, I just noticed LSM_ID_IMA. Since we have the 'integrity' LSM, I
> > think it should be LSM_ID_INTEGRITY.
> > 
> > Mimi, all, do you agree? If yes, I send a patch shortly.
> 
> I believe LSM_ID_IMA is the better option, despite "integrity" already
> being present in Kconfig and possibly other areas.  "IMA" is a
> specific thing/LSM whereas "integrity" is a property, principle, or
> quality.  Especially as we move forward with promoting IMA as a full
> and proper LSM, we should work towards referring to it as "IMA" and
> not "integrity".
> 
> If anything we should be working to support "IMA" in places where we
> currently have "integrity" so that we can eventually deprecate
> "integrity".

Hi Paul

I fully understand your argument. However, 'integrity' has been the
word to identify the integrity subsystem since long time ago.

Reducing the scope to 'ima' would create some confusion since, while
'ima' is associated to integrity, it would not encompass EVM.

The term 'integrity', although it is a property, it precisely
identifies in the kernel context the scope and goals of the subsystem,
and is general enough to encompass new projects going in a similar
direction (such as my integrity digest cache).

From a technical perspective, at the moment it is not possible to split
'integrity' in two standalone LSMs 'ima' and 'evm', as IMA and EVM work
on shared integrity metadata. Also my integrity digest cache is using
the same metadata.

In addition, making IMA and EVM as standalone LSMs would require a much
longer development cycle to make them use disjoint metadata and to
define proper communication interfaces. It would be not anymore a
technical move of function calls from a place to another, like for the
current patch set, but would require substantial time to validate the
new design.

To submit my patch set in the current state, the only thing I need is
to have LSM_ID_INTEGRITY defined.

Roberto

