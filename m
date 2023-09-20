Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C9A7A716B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 06:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjITEJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 00:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjITEJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 00:09:20 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E092AC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 21:09:12 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230920040910epoutp02de57fcdcb37c402ef89822dbe40c6f01~Gf_l8aOQn0469804698epoutp02a
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 04:09:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230920040910epoutp02de57fcdcb37c402ef89822dbe40c6f01~Gf_l8aOQn0469804698epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695182950;
        bh=tPB99B6ahNxvPYhnfuH5l8ERgsGC1nfJfoLgiz+PHck=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A72nqKURvWkB5LldJHuq7otQqQpNbucWDKUJhPz0on4UvC7k5+03fn+vvyZW36rxI
         ExSin9EThnIZWf4Kyvg54mV0vYwv1iDdwxmJxCpjJ5VzMtHm3A+Bk4VZZsSQdGlMJH
         DdU47SKm+UObLG2opDzC3AikWKMiUgLtG1fQC7EQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230920040910epcas2p3de9b5cbfc52490a65ccd46e9ec2110e4~Gf_lh-0ea1788117881epcas2p32;
        Wed, 20 Sep 2023 04:09:10 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.91]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Rr4m53lkDz4x9Px; Wed, 20 Sep
        2023 04:09:09 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        AB.01.09693.5607A056; Wed, 20 Sep 2023 13:09:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230920040909epcas2p1a547a2548af937f6a35da0ec27a46df9~Gf_knL9fI1808118081epcas2p1M;
        Wed, 20 Sep 2023 04:09:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230920040909epsmtrp2839f382821341d0dd51bafaad552fb28~Gf_kmen4E2458624586epsmtrp2d;
        Wed, 20 Sep 2023 04:09:09 +0000 (GMT)
X-AuditID: b6c32a45-84fff700000025dd-63-650a70656060
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        24.CF.08742.4607A056; Wed, 20 Sep 2023 13:09:08 +0900 (KST)
Received: from KORCO045595.samsungds.net (unknown [10.229.38.76]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230920040908epsmtip151860e5be2f34be04b88cdf962ce3587~Gf_kZMO0X1764417644epsmtip1X;
        Wed, 20 Sep 2023 04:09:08 +0000 (GMT)
Date:   Wed, 20 Sep 2023 13:09:08 +0900
From:   Bongkyu Kim <bongkyu7.kim@samsung.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        will@kernel.org, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        bongkyu7.kim@samsung.com
Subject: Re: [PATCH v2 1/2] Revert
 "locking/rwsem: Remove reader optimistic spinning"
Message-ID: <20230920040908.GA4197@KORCO045595.samsungds.net>
MIME-Version: 1.0
In-Reply-To: <9578a3a7-4151-6b60-3241-d883afe08bc1@redhat.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBJsWRmVeSWpSXmKPExsWy7bCmuW5qAVeqwawZMhavG18yWazZ0shk
        0bx4PZvF5V1z2CxOHzvBYnHpwAImi+O9B5gsWu6YOnB47Jx1l91j8wotj02rOtk89s9dw+7x
        ft9VNo++LasYPT5vkgtgj2pgtEksSs7ILEtVSM1Lzk/JzEu3VQoNcdO1UFLIyC8usVWKNjQ0
        0jM0MNczMjLSMzWKtTIyVVLIS8xNtVWq0IXqVVIoSi4Aqs2tLAYakJOqBxXXK07NS3HIyi8F
        eUSvODG3uDQvXS85P1dJoSwxpxRohJJ+wjfGjLbJvWwFt0Qr7rTOZG5gXCfYxcjJISFgIrFh
        0l6mLkYuDiGBHYwSl49NZQVJCAl8YpSYticUIvGNUWLmo2dsMB0zD7cyQiT2MkrMOnKECaID
        qGrRWksQm0VAVWLbxV9gk9gEdCT+r54BViMioCLR8fYHG0gzs8AuoPpfC1hAEsIC4RILn9xk
        BLF5BWwlds9sZYWwBSVOznwCVsMpYCfxc9JnsM0SAn/ZJVbdX8wMcZKLxKXLZ6FsYYlXx7ew
        Q9hSEp/f7YU6O1vizJ3zjBB2hcTLv3+gaowlZj1rB4szC6RLzF9yCuhSDqC4ssSRWywQYT6J
        jsN/ocoFJU5f62aGKOGV6GgTggirSex+DnGyhICMxMGza6GmeEhc+GMJCau5zBKfTp9lm8Ao
        PwvJZ7OQLIawdSQW7P7ENguonVlAWmL5Pw4IU1Ni/S79BYysqxjFUguKc9NTi40KDJGjexMj
        OBFrue5gnPz2g94hRiYOxkOMEhzMSiK8uWpcqUK8KYmVValF+fFFpTmpxYcYk4HxNJFZSjQ5
        H5gL8kriDc3MLC0sjUwtLE1NLQgLm1gamJiZGZobmRqYK4nz3mudmyIkkJ5YkpqdmlqQWgSz
        hYmDU6qBqV7c4MzMTec7DrHbzRBO64t/vW/FbcEpT+ee15+ey71WUEHZxNU4YNomQdln63r3
        F4V0PAycM/uiHdeOdXsFrRfyzrI7P+n01MWfTghocW9h/MZl35HTpvu6NanS7/Ke6jjfTzq1
        DUaKVpMef2Qx0mFoZj/4e03OBenAO59+mPjfCfRtPfR181d2mQt+DazBzTa6afteqmxievbt
        7dstztyfX71JnVVxMyzZNvTB16Aw52apiuqrSabz7iT3PSpMeTc75PbxOJmQA5N9n/p/0eC5
        J+anr/tE+cX3yuWZTAsfnvyV8qfedJXxv9c3PhqycDpFrf656sjl5UrO1e+v/yk03hpw4tbM
        bvPZeVPmzVFiKc5INNRiLipOBACy+wMWewQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsWy7bCSnG5qAVeqwWori9eNL5ks1mxpZLJo
        XryezeLyrjlsFqePnWCxuHRgAZPF8d4DTBYtd0wdODx2zrrL7rF5hZbHplWdbB77565h93i/
        7yqbR9+WVYwenzfJBbBHcdmkpOZklqUW6dslcGXc71zNVDBXuOLTfpsGxi7+LkZODgkBE4mZ
        h1sZuxi5OIQEdjNKzF3whQkiISNx6N9aKFtY4n7LEVaIoi+MEg1PX4IlWARUJbZd/MUKYrMJ
        6Ej8Xz0DLC4ioCLR8fYHG0gDs8AuRolFvxawgCSEBcIlfj3rYgOxeQVsJXbPbIWaOpdZYsLd
        ecwQCUGJkzOfgDUwC2hJ3PgHso0DyJaWWP6PAyTMKWAn8XPSZ8YJjAKzkHTMQtIxC6FjASPz
        KkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4CjQ0tzBuH3VB71DjEwcjIcYJTiYlUR4
        c9W4UoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzir/oTRESSE8sSc1OTS1ILYLJMnFwSjUwrVbt
        23xVUb/m9PFtV6un93u9F9r5eZWW4uybc2KedV6zmhXM7zlxUdzym1laVyb38S86G302N0Pi
        f1SAGee/cr9e7xYzj3sJdQtuJZYy+68Okep2y1zfnWKypfqB1085ma7voXvVOdY/X785401Z
        YNoRDtlTb2sbdlacV5qvcmx9e2DTOcuUyYeq/1/vF13pqlsQzRNlW9Qt0/pb6E/1MfPEhGlf
        P4ptmnzolKXHSZfrlgoGzTbXP0Q0vhfZ8yHKIjkmwtT5FOu/cl+XpXu+r08WPM+vlb3O01Hs
        Hqf9u8SKTbHzziuf/rXGjH/S8geJTLt1XhzMWCMc+vVOp+k5VfbbWemHbj9J/2jJ/OamEktx
        RqKhFnNRcSIAd5B+5vECAAA=
X-CMS-MailID: 20230920040909epcas2p1a547a2548af937f6a35da0ec27a46df9
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----fhEHFYu7RNsFUiSWfAq-IjQ-VzC.j9Pzsqf7lJgctIRm.Jgh=_8f6b_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230901010734epcas2p1a0d3698e76590637f9175fca40ad9eaf
References: <20230901010704.18493-1-bongkyu7.kim@samsung.com>
        <CGME20230901010734epcas2p1a0d3698e76590637f9175fca40ad9eaf@epcas2p1.samsung.com>
        <20230901010704.18493-2-bongkyu7.kim@samsung.com>
        <20230904151008.GA25717@noisy.programming.kicks-ass.net>
        <94764456-c4d4-03eb-81ef-df402f4916f6@redhat.com>
        <20230906112741.GA18415@KORCO045595.samsungds.net>
        <9578a3a7-4151-6b60-3241-d883afe08bc1@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------fhEHFYu7RNsFUiSWfAq-IjQ-VzC.j9Pzsqf7lJgctIRm.Jgh=_8f6b_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Sep 06, 2023 at 09:32:45AM -0400, Waiman Long wrote:
> 
> On 9/6/23 07:27, Bongkyu Kim wrote:
> > On Mon, Sep 04, 2023 at 03:56:56PM -0400, Waiman Long wrote:
> > > On 9/4/23 11:10, Peter Zijlstra wrote:
> > > > On Fri, Sep 01, 2023 at 10:07:03AM +0900, Bongkyu Kim wrote:
> > > > > This reverts commit 617f3ef95177840c77f59c2aec1029d27d5547d6.
> > > > > 
> > > > > In mobile environment, reader optimistic spinning is still useful
> > > > > because there're not many readers. In my test result at android device,
> > > > > it improves application startup time about 3.8%
> > > > > App startup time is most important factor for android user expriences.
> > > > > So, re-enable reader optimistic spinning by this commit. And,
> > > > > the later patch will make it optional feature by cmdline.
> > > > I'm not seeing any mention on how this interacts with all the rwsem work
> > > > that has been done since that commit, like the handoff rework.
> > > > 
> > > > Why is a straight revert a sane thing at this point?
> > > I also agree that a revert is not the best way to reintroduce the feature.
> > > It should document the reason why reader optimistic spinning is not the
> > > default as discussed in commit 617f3ef9517 ("locking/rwsem: Remove reader
> > > optimistic spinning") and under what condition should reader optimistic
> > > spinning can be turned back on.
> > > 
> > > Besides, I now think we may not really need 2 separate nonspinnable bits. We
> > > can go with one that is set by writer timing out when spinning on reader.
> > > 
> > > Cheers,
> > > Longman
> > Should I modify like the below?
> > - Title to "locking/rwsem: Reintroduce reader optimistic spinning"
> > - Add more document like Longman's comment
> > - Reconsidering about 2 separate nonspinnable bits to one
> 
> Besides the above, Peter also ask to verify that it won't affect handoff
> handling which requires that an unlocker see the lock will be free and wake
> up the head of the wait queue. Given the fact that the simple heuristic of
> skipping optimistic spinning if the lock is reader owned is kept, that
> shouldn't be a problem, but you still need to document that.
> 
> Cheers,
> Longman
 
I've been reviewing nonspinnable bits for several days, but I can't find the
way for one spinnable bit. In this patch, how about modify only already mentioned
document part? About one spinnable bit, we will discuss later.

------fhEHFYu7RNsFUiSWfAq-IjQ-VzC.j9Pzsqf7lJgctIRm.Jgh=_8f6b_
Content-Type: text/plain; charset="utf-8"


------fhEHFYu7RNsFUiSWfAq-IjQ-VzC.j9Pzsqf7lJgctIRm.Jgh=_8f6b_--
