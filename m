Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E98793B33
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239720AbjIFL2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239702AbjIFL2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:28:33 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76DE19AA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 04:28:12 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230906112743epoutp0262581da7b8759ffbfaa01b27371f772d~CS7gRFDr11145011450epoutp02e
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 11:27:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230906112743epoutp0262581da7b8759ffbfaa01b27371f772d~CS7gRFDr11145011450epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693999663;
        bh=9PogCc+RcjmGrjk07I2lYqkyZuUfXKH1ZOSe+tK0EEM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bZT3oQNhxsduMXT4vCozMS9prvx/DS1CH9GQBqPzq/gAFz/nzKyWUa0qGwITX5KmF
         kukeETMsf4bViFkeFXtfik8rd3LoPkBHhdUmu4zETj5a5OMRHk5jzLnWWUN2ulFoLm
         nQ9n8Vp/UriTg04jBu1Cxtos07pkAHS0jht2vO/k=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230906112742epcas2p48ea97fb3fb44111b2e0ca69cb8dbb284~CS7fH_NrY0425204252epcas2p4E;
        Wed,  6 Sep 2023 11:27:42 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.88]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Rgg8Z08j3z4x9Pr; Wed,  6 Sep
        2023 11:27:42 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C3.20.19471.D2268F46; Wed,  6 Sep 2023 20:27:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230906112741epcas2p289f3c861707efa2eb48514aef4f75327~CS7eYswid0296902969epcas2p2y;
        Wed,  6 Sep 2023 11:27:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230906112741epsmtrp2c31bb1089c66a79252be2ef27b0fcc62~CS7eYDOom2556225562epsmtrp2I;
        Wed,  6 Sep 2023 11:27:41 +0000 (GMT)
X-AuditID: b6c32a4d-b07ff70000004c0f-db-64f8622d12af
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        97.C4.08742.D2268F46; Wed,  6 Sep 2023 20:27:41 +0900 (KST)
Received: from KORCO045595.samsungds.net (unknown [10.229.38.76]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230906112741epsmtip2447ef2e534d58b744f7bbe42db4c9179~CS7eLn2SL0915409154epsmtip2H;
        Wed,  6 Sep 2023 11:27:41 +0000 (GMT)
Date:   Wed, 6 Sep 2023 20:27:41 +0900
From:   Bongkyu Kim <bongkyu7.kim@samsung.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        will@kernel.org, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 1/2] Revert
 "locking/rwsem: Remove reader optimistic spinning"
Message-ID: <20230906112741.GA18415@KORCO045595.samsungds.net>
MIME-Version: 1.0
In-Reply-To: <94764456-c4d4-03eb-81ef-df402f4916f6@redhat.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIJsWRmVeSWpSXmKPExsWy7bCmua5u0o8UgzPfrCzWbGlksmhevJ7N
        4vKuOWwWp4+dYLG4dGABk8Xx3gNMFi13TB3YPXbOusvusXmFlsemVZ1sHvvnrmH3eL/vKpvH
        501yAWxRDYw2iUXJGZllqQqpecn5KZl56bZKoSFuuhZKChn5xSW2StGGhkZ6hgbmekZGRnqm
        RrFWRqZKCnmJuam2ShW6UL1KCkXJBUC1uZXFQANyUvWg4nrFqXkpDln5pSDn6xUn5haX5qXr
        JefnKimUJeaUAo1Q0k/4xpjRvGU1e8ES/opbe5MbGA/xdDFyckgImEicmH+KDcQWEtjDKDF1
        f2UXIxeQ/YlR4tTvZ6wQzjdGiUkPdzN1MXKAdaxpEoaI72WUON5wgw2uaNPfR+wgo1gEVCTm
        zDzGDGKzCehI/F89gwnEFgGKd7z9AdbALLCAUeLnwomMIAlhgXCJhU9ugtm8AnYSu6c+Z4aw
        BSVOznzCAmJzAsV7V+9lBGmWEPjJLrF63nQWiCdcJPY9ecgKYQtLvDq+hR3ClpL4/G4vG4Sd
        LXHmznlGCLtC4uXfP1A1xhKznrWDxZkFMiX+PbnEDPGmssSRWywQYT6JjsN/ocoFJU5f64Yq
        4ZXoaBOCCKtJ7H7eCnWBjMTBs2uhgeUhceGPJSR8tjBJ9B5qZp3AKD8LyWezkCyGsHUkFuz+
        xDYLqJ1ZQFpi+T8OCFNTYv0u/QWMrKsYpVILinPTU5ONCgx181LLkWN8EyM49Wr57mB8vf6v
        3iFGJg7GQ4wSHMxKIrzv5L+lCPGmJFZWpRblxxeV5qQWH2JMBsbVRGYp0eR8YPLPK4k3NDOz
        tLA0MrWwNDW1ICxsYmlgYmZmaG5kamCuJM57r3VuipBAemJJanZqakFqEcwWJg5OqQam8F8e
        b7zPbE1/wlazta7voKnw9CfWWsw1vUsuvSr4Nf1mYG9LyP1ZuTkqt8/2fdivf2NRV3rG1z2W
        ehXfryxjbVh145LNZ4n+OHeFNT5ztoU/Ck3z8UvL2H8i72Gay7Hw0NqLNepdIhM+N4hN8VEN
        +qT/eIfXZnNh2anejkfYWv/vX3hx3S/p05XuFZXZ2p/XvVZsFJ9esNr5n+bqb6enH9j5NCyr
        Q3HSFPMJTv89XapuJrq7/Nd0F7T90Z//XF8/gMHA9+Q3r+lCxXe+dp47dis+fsIihqZ5l899
        KtC6seCkk7zp55XLZ2msT1/O8J3lxUQtsfA9Gz9v111+QtXordgGm5WxpaY3+myDBBtuKbEU
        ZyQaajEXFScCACbwQs90BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsWy7bCSvK5u0o8Ugx/z1S3WbGlksmhevJ7N
        4vKuOWwWp4+dYLG4dGABk8Xx3gNMFi13TB3YPXbOusvusXmFlsemVZ1sHvvnrmH3eL/vKpvH
        501yAWxRXDYpqTmZZalF+nYJXBk9uy+wFTzkqfi/5j17A+MMri5GDg4JAROJNU3CXYxcHEIC
        uxklbs6eztbFyAkUl5E49G8tE4QtLHG/5QgrRNEXRokvjc9ZQRIsAioSc2YeYwax2QR0JP6v
        ngHWIAIU73j7gw2kgVlgAaPEz4UTGUESwgLhEr+edYFt4BWwk9g99TkzxNQtTBKXPh5hh0gI
        Spyc+YQFxGYW0JK48e8lE8ipzALSEsv/cYCEOYF6e1fvZZzAKDALSccsJB2zEDoWMDKvYpRM
        LSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIDnktzR2M21d90DvEyMTBeIhRgoNZSYT3nfy3
        FCHelMTKqtSi/Pii0pzU4kOM0hwsSuK84i96U4QE0hNLUrNTUwtSi2CyTBycUg1Mu9kjtUzC
        7A8Vpc8MLjryfu31H3Vc2Uw/Lm1JTX917MyxlYGeKg5ZF/nO/aues6R0i/3xD/YJFntX7df5
        dU9OIWtB1V/L55EWIj879xwvSYzb3fVlmvUVAyNlxX3z4m+/fXh6+j1du/yHa/u2rLr9W6tu
        34OtB+c9rK5jmWMRPldD503BTt+CdU2BS2/Y/WXb63TiROeHgnyRyVIxZfZ9Am2zEvQDJzW6
        /fiydZntPZPSFXb3jXfVPvK766vJqPT99jM+xSOHXBYyXqgsUJKzfjiF07z0+8yeDYavV0/4
        rNPXfr31s13tkp3rGrxL7s/P6tbPlTqU6iO2+aD1BLWfp+YZCAk/vHc7+Blf+N+ZukosxRmJ
        hlrMRcWJAEPplProAgAA
X-CMS-MailID: 20230906112741epcas2p289f3c861707efa2eb48514aef4f75327
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="-----BtiRfIwJ_n6lLjqSnW_hkHVJs.G1Q1_quieK.Ms.6zkUSMJ=_1a0a7b_"
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-------BtiRfIwJ_n6lLjqSnW_hkHVJs.G1Q1_quieK.Ms.6zkUSMJ=_1a0a7b_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Sep 04, 2023 at 03:56:56PM -0400, Waiman Long wrote:
> On 9/4/23 11:10, Peter Zijlstra wrote:
> > On Fri, Sep 01, 2023 at 10:07:03AM +0900, Bongkyu Kim wrote:
> > > This reverts commit 617f3ef95177840c77f59c2aec1029d27d5547d6.
> > > 
> > > In mobile environment, reader optimistic spinning is still useful
> > > because there're not many readers. In my test result at android device,
> > > it improves application startup time about 3.8%
> > > App startup time is most important factor for android user expriences.
> > > So, re-enable reader optimistic spinning by this commit. And,
> > > the later patch will make it optional feature by cmdline.
> > I'm not seeing any mention on how this interacts with all the rwsem work
> > that has been done since that commit, like the handoff rework.
> > 
> > Why is a straight revert a sane thing at this point?
> 
> I also agree that a revert is not the best way to reintroduce the feature.
> It should document the reason why reader optimistic spinning is not the
> default as discussed in commit 617f3ef9517 ("locking/rwsem: Remove reader
> optimistic spinning") and under what condition should reader optimistic
> spinning can be turned back on.
> 
> Besides, I now think we may not really need 2 separate nonspinnable bits. We
> can go with one that is set by writer timing out when spinning on reader.
> 
> Cheers,
> Longman

Should I modify like the below?
- Title to "locking/rwsem: Reintroduce reader optimistic spinning"
- Add more document like Longman's comment
- Reconsidering about 2 separate nonspinnable bits to one

Thanks,
Bongkyu

-------BtiRfIwJ_n6lLjqSnW_hkHVJs.G1Q1_quieK.Ms.6zkUSMJ=_1a0a7b_
Content-Type: text/plain; charset="utf-8"


-------BtiRfIwJ_n6lLjqSnW_hkHVJs.G1Q1_quieK.Ms.6zkUSMJ=_1a0a7b_--
