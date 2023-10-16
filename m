Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613287CA7AD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjJPMFF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Oct 2023 08:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjJPMFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:05:03 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC29DC;
        Mon, 16 Oct 2023 05:05:00 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4S8FpB5mz7z9y0Ns;
        Mon, 16 Oct 2023 19:52:02 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwBnwJHRJi1lVkJTAg--.47770S2;
        Mon, 16 Oct 2023 13:04:42 +0100 (CET)
Message-ID: <ae39864947debbc7c460db478b8abe1c147b7d5c.camel@huaweicloud.com>
Subject: Re: [PATCH v15 00/11] LSM: Three basic syscalls
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Date:   Mon, 16 Oct 2023 14:04:30 +0200
In-Reply-To: <CAHC9VhSqY5+DR-jXprrftb1=CzDvhTh0Ep66A16RMd4L7W7TYw@mail.gmail.com>
References: <20230912205658.3432-1-casey.ref@schaufler-ca.com>
         <20230912205658.3432-1-casey@schaufler-ca.com>
         <CAHC9VhRcbp3iWQwL7FTUrcU1C3OsZ413Nbq+17oTwW7hZ7XvBw@mail.gmail.com>
         <CAHC9VhSqY5+DR-jXprrftb1=CzDvhTh0Ep66A16RMd4L7W7TYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-CM-TRANSID: LxC2BwBnwJHRJi1lVkJTAg--.47770S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw18CFyfWrWkCF45Kr4rKrg_yoW8uw1kpF
        W3K3ZFkF4kJrZ5CFn7A3WUZ3yrKa93JrZrCF98Aryrua45Gr1Iqr93KanY9F1UZrZ3Ca4I
        qr4jyrZ3Cw15A37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAMBF1jj5USuwABsF
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-10-13 at 17:55 -0400, Paul Moore wrote:
> On Thu, Oct 12, 2023 at 6:07 PM Paul Moore <paul@paul-moore.com> wrote:
> > 
> > On Tue, Sep 12, 2023 at 4:57 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > 
> > > Add three system calls for the Linux Security Module ABI ...
> > 
> > First off, a big thank you to Casey who took it upon himself to turn
> > my pseudo-code syscall suggestion into a proper patchset and saw it
> > through 15 revisions.  Thanks also go out to everyone that has helped
> > review and comment on this effort; I know everyone is busy, but these
> > reviews are important.
> > 
> > I'm happy to say that I think we're in a good place with this revision
> > of the LSM syscall patchset.  I only see two outstanding issues, and
> > neither of those are bugs/showstoppers that affect the API, they are
> > simply areas where the implementation could be improved.  With the
> > understanding that Casey is busy for the rest of the month, and my
> > desire to make sure this patchset gets a full dev cycle in linux-next,
> > I'm going to suggest merging this into the lsm/next-queue branch soon
> > (likely tomorrow) in preparation for merging it into lsm/next once the
> > upcoming merge window closes.  Those who want to help improve the
> > implementation, as suggested in the feedback on this revision or
> > otherwise, are welcome to submit patches against the lsm/next-queue
> > branch and I will merge them into that branch once they pass review.
> > 
> > If I don't hear any objections I'll plan on merging this patchset
> > tomorrow, I'll send a follow-up reply to this email when it's done.
> 
> Since it's been *almost* a full 24 hours and no objections I went
> ahead and merged this patchset into lsm/next-queue with the intention
> of bringing them into lsm/next after the upcoming merge window closes.
> For those of you who have suggested changes, please feel free to
> submit patches against the lsm/next-queue branch and we can get them
> queued up along with these patches.

Sorry, I just noticed LSM_ID_IMA. Since we have the 'integrity' LSM, I
think it should be LSM_ID_INTEGRITY.

Mimi, all, do you agree? If yes, I send a patch shortly.

Thanks

Roberto

