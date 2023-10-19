Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA717CF191
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjJSHp6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Oct 2023 03:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbjJSHpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:45:54 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A0BF7;
        Thu, 19 Oct 2023 00:45:51 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4S9zvl69lbz9v7Qx;
        Thu, 19 Oct 2023 15:32:51 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDXLrqN3jBl0dl3Ag--.35623S2;
        Thu, 19 Oct 2023 08:45:27 +0100 (CET)
Message-ID: <e12f63037405f41a1be979b1424d1404d3139a4d.camel@huaweicloud.com>
Subject: Re: [PATCH v15 00/11] LSM: Three basic syscalls
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        linux-integrity@vger.kernel.org
Date:   Thu, 19 Oct 2023 09:45:14 +0200
In-Reply-To: <CAHC9VhSqgAD09QL2n0aoWLK7RGPkkjZHBrDCQmt1p3=ozpdt4A@mail.gmail.com>
References: <20230912205658.3432-1-casey.ref@schaufler-ca.com>
         <20230912205658.3432-1-casey@schaufler-ca.com>
         <CAHC9VhRcbp3iWQwL7FTUrcU1C3OsZ413Nbq+17oTwW7hZ7XvBw@mail.gmail.com>
         <CAHC9VhSqY5+DR-jXprrftb1=CzDvhTh0Ep66A16RMd4L7W7TYw@mail.gmail.com>
         <ae39864947debbc7c460db478b8abe1c147b7d5c.camel@huaweicloud.com>
         <CAHC9VhRQ7xpeSX7b3VZfzQ15noJ8mgauNMuHWo_n3hMgsYMAfQ@mail.gmail.com>
         <468436cf766732a3cfc55d07ad119a6ccdc815c1.camel@huaweicloud.com>
         <CAHC9VhTjHT-DGKu0=cZPVb=+kMwmbPdr8HiVWJq-yzaDiYk_SA@mail.gmail.com>
         <6f33144c850c40e9438a6de2cf3004e223508755.camel@huaweicloud.com>
         <2637d5294d4a7ae871f1b758f5a30234836e2463.camel@huaweicloud.com>
         <c896c8ed559d0075146070be232e449b6951eb99.camel@linux.ibm.com>
         <283bf52d-af6e-4d20-a5ba-d98511c2e530@huaweicloud.com>
         <CAHC9VhSiUgY1Dzy6LGOjPF6XQ3pVBiZ9LPdcQANNXZ9rj-WURw@mail.gmail.com>
         <80f05011bf9fe19bde1f923e98c2db69ffc91065.camel@linux.ibm.com>
         <CAHC9VhSqgAD09QL2n0aoWLK7RGPkkjZHBrDCQmt1p3=ozpdt4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-CM-TRANSID: GxC2BwDXLrqN3jBl0dl3Ag--.35623S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4fXFy7Xr17JF15Xw48Xrb_yoW8AFyDpF
        W5ta1jkr4qvr4jyws2yF4rtw4jyFZ3XF97X345Jr1rA3s8JF9YqrWfuFW29ryUGrsYya40
        yF42qa43ua4DZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAPBF1jj5E3+AAAsm
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-10-18 at 16:40 -0400, Paul Moore wrote:
> On Wed, Oct 18, 2023 at 4:23 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Wed, 2023-10-18 at 12:35 -0400, Paul Moore wrote:
> > > On Wed, Oct 18, 2023 at 10:15 AM Roberto Sassu
> > > <roberto.sassu@huaweicloud.com> wrote:
> > > > On 10/18/2023 3:09 PM, Mimi Zohar wrote:
> > > 
> > > ...
> > > 
> > > > > I agree with Roberto.  All three should be defined: LSM_ID_INTEGRITY,
> > > > > LSM_ID_IMA, LSM_ID_EVM.
> > > > 
> > > > I did not try yet, but the 'integrity' LSM does not need an LSM ID. With
> > > > the last version adding hooks to 'ima' or 'evm', it should be sufficient
> > > > to keep DEFINE_LSM(integrity) with the request to store a pointer in the
> > > > security blob (even the init function can be a dummy function).
> > > 
> > > First off, this *really* should have been brought up way, way, *way*
> > > before now.  This patchset has been discussed for months, and bringing
> > > up concerns in the eleventh hour is borderline rude.
> > 
> > As everyone knows IMA and EVM are not LSMs at this point.
> 
> Considering all the work Roberto has been doing to make that happen,
> not to mention the discussions we've had on this topic, that's an
> awfully small technicality to use as the basis of an argument.

Sorry Paul, but I've been working on this patch set for a long time and
you were also involved in the prerequisites (like making the
'integrity' LSM as the last).

I thought it was clear at this point that we were going to add the
hooks to the 'integrity' LSM.

I really have no problem to rebase my work on top of other work, but I
was very surprised to see LSM_ID_IMA instead of LSM_ID_INTEGRITY, and
at minimum this should have been agreed with Mimi. And also, I was not
convinced with the argument that LSM_ID_IMA should represent IMA+EVM.

Roberto

