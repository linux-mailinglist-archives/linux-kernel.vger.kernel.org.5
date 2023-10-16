Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B835A7CA0A0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjJPHda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJPHd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:33:28 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B2CAD
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:33:26 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231016073324epoutp04d590c7bf75b81eb0a15b9efb4a470d5b~OhiVTgA0v0198901989epoutp04y
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 07:33:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231016073324epoutp04d590c7bf75b81eb0a15b9efb4a470d5b~OhiVTgA0v0198901989epoutp04y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697441604;
        bh=/fmWexiW3XjDpbpbWnZTKvgi14z+ifFVkfg9xnLHvnU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P81jSSjRqHddN8DwiTTUDm7TUtJ3ekLiLGMlbMDvM0gNHfd72akiTyGXeAeKGOSD9
         HUvK5xItffVCzWJaaGk81Sqt4b0aPWpxfkadGms2T8qC2Poj7XlWpBOtMn3RwF/Iu8
         2vrcQujYdZMHSPWEqEmBTt6ayj68TlVWfD0VjUDQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20231016073324epcas2p2470508d7c80bde0ead6e40ed26dac610~OhiVBD5Bf0987509875epcas2p2s;
        Mon, 16 Oct 2023 07:33:24 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.68]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4S883l3zCPz4x9Q2; Mon, 16 Oct
        2023 07:33:23 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        C7.FD.09607.347EC256; Mon, 16 Oct 2023 16:33:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20231016073323epcas2p215b7d7c872459cfc427b24fee8ff14a9~OhiUKkBeJ2756927569epcas2p2S;
        Mon, 16 Oct 2023 07:33:23 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231016073323epsmtrp11d601c6c642aa890c1bfad2f945c20cf~OhiUKEuQD0099400994epsmtrp1E;
        Mon, 16 Oct 2023 07:33:23 +0000 (GMT)
X-AuditID: b6c32a48-bcdfd70000002587-d6-652ce743281a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A9.E1.18939.347EC256; Mon, 16 Oct 2023 16:33:23 +0900 (KST)
Received: from tiffany (unknown [10.229.95.142]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231016073323epsmtip21e5a4b746388960075f13439e0fadc3e~OhiUCZDW00486504865epsmtip2b;
        Mon, 16 Oct 2023 07:33:23 +0000 (GMT)
Date:   Mon, 16 Oct 2023 16:23:05 +0900
From:   Hyesoo Yu <hyesoo.yu@samsung.com>
To:     Vishal Moola <vishal.moola@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: page_alloc: check the order of compound page event
 when the order is 0
Message-ID: <20231016072305.GA2440288@tiffany>
MIME-Version: 1.0
In-Reply-To: <CAOzc2pxGyZUGju07aid06FpSgFFA45tr0wU-yH4yUipKMPaP=Q@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42LZdljTXNf5uU6qwexPchZz1q9hs7i8aw6b
        xb01/1kt1u+7werA4rFz1l12j02fJrF7nJjxm8Xj8ya5AJaobJuM1MSU1CKF1Lzk/JTMvHRb
        Je/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoJVKCmWJOaVAoYDE4mIlfTubovzSklSF
        jPziElul1IKUnALzAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMtQcWMRd8kqjY376WtYHxl1AX
        IyeHhICJxI4Jt1m6GLk4hAR2MEo8uniKDcL5xCjR+H4NE5zz5c5pdpiWNb1bGCESOxklFrxa
        wA7hPGWU2HDtOBNIFYuAqsTstyvBOtgE1CVObFkG1MHBISKgKbHybxJImFkgUeLv1PVgJcJA
        9s7mDWwgNq+AnsTCWYfZIWxBiZMzn7CA2JwCgRJPZi5mhjjiFrvEulMeELaLxLXdNxkhbGGJ
        V8e3QB0qJfGyvw3Kzpa4+3ECG4RdIrHuTANU3Fhi1rN2Roh70iW2Tf3PDnKmhICyxJFbLBBh
        PomOw3+hwrwSHW3QkFOW2L9sHguELSnxaG07K0SJh0TXnnhIgGxmkjh6eBnzBEa5WUiemYVk
        2SygFmZgmKzfpQ8Rlpdo3jqbGSIsLbH8HweSigWMbKsYxVILinPTU4uNCkzgMZ2cn7uJEZwU
        tTx2MM5++0HvECMTB+MhRgkOZiUR3vRgnVQh3pTEyqrUovz4otKc1OJDjKbAOJrILCWanA9M
        y3kl8YYmlgYmZmaG5kamBuZK4rz3WuemCAmkJ5akZqemFqQWwfQxcXBKNTAtYD0a/PsWW9u+
        ac2RV75e+hdqp+HBZznpsUORa0Rl8Axffh5f/5pC44lrGa/W75325/G9qV+/vWi8M8F6MotB
        Qqqe7X03Zd2cP1GHVjWqHV8/38z1J5f29OaYM/YB8ivOzU8pcf6u+TdNUDBuwt6jId0H6zfF
        9JQKmG8/cPPnBY+oJnWWiLcmdpdKuya2l71wveBd/bN6jk1zVREPx0t9odlNy6U+yx/fXr1U
        Utt1w4/5/9fd0GZRlvC7r8tZN/nNxkcXvgk+aZ9w+tXK904vJqzmPd3w7G8880v57vVt0+w/
        OG4S2nuKZfL/J8zlOl8erztQPqXRb//fsBkR9S0r+84xKweUcsVdfrzgDc9GJZbijERDLeai
        4kQAcxUtFBMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSvK7zc51Ugy9vOC3mrF/DZnF51xw2
        i3tr/rNarN93g9WBxWPnrLvsHps+TWL3ODHjN4vH501yASxRXDYpqTmZZalF+nYJXBkXv95g
        KpguVnHn+kW2BsbdAl2MnBwSAiYSa3q3MHYxcnEICWxnlHh47AMzREJSYtbnk0wQtrDE/ZYj
        rCC2kMBjRokX/fEgNouAqsTstyvZQWw2AXWJE1uWAQ3i4BAR0JRY+TcJJMwskCjxd+p6sBJh
        IHtn8wY2EJtXQE9i4azD7BB7NzNJnHiwmB0iIShxcuYTFohmdYk/8y4xg8xkFpCWWP6PAyIs
        L9G8dTbYmZwCgRJPZi5mnsAoOAtJ9ywk3bMQumch6V7AyLKKUTS1oDg3PTe5wFCvODG3uDQv
        XS85P3cTIzjQtYJ2MC5b/1fvECMTB+MhRgkOZiUR3vRgnVQh3pTEyqrUovz4otKc1OJDjNIc
        LErivMo5nSlCAumJJanZqakFqUUwWSYOTqkGJslvNxnrzm40a3h4SurY9zc5S9tUdsROYp99
        hf/BlNdWccufXUpg4Ap22Byv0rHAaIqLQHHorJwrx7Sbly8ufR4UFSixLfSAw5wXaS0etxnb
        Yvf0v9x6PvlUVfDZXbOrFK63ylw7ENG2x+mi82Uj2dvTRV99e6r37hX7Ivu9x41//b0T/8jw
        wMRIucN/VrfbW0zNDJ/OyMFtrVpj9SA1V1m0vCim7voa80WhOYs7vGRentw2M6o+S03E5uT0
        W74PzXSa5pppOnmFCJzRn7x8Sur0SN/LRSvPb0g5qH59mYO0f5O1yjrPj4ZzG0Mzdk5KeHm+
        OCjWL7kz6b/Uhi2F8edUXzLPsz2tuqZk5xSHzUosxRmJhlrMRcWJAHSI2urjAgAA
X-CMS-MailID: 20231016073323epcas2p215b7d7c872459cfc427b24fee8ff14a9
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----kpWfbNyO0dZ94JZMx8UaZzOLaVw4Eds-FlcQ7ND7-zj3ifPP=_d102_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231012012153epcas2p34b8e9e8a898ace8d50411cadf937ef5d
References: <CGME20231012012153epcas2p34b8e9e8a898ace8d50411cadf937ef5d@epcas2p3.samsung.com>
        <20231012011106.2425309-1-hyesoo.yu@samsung.com>
        <ZSmucNWBMj/mNVeE@dhcp-10-159-238-251.vpn.oracle.com>
        <20231016003200.GA445850@tiffany>
        <CAOzc2pxGyZUGju07aid06FpSgFFA45tr0wU-yH4yUipKMPaP=Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------kpWfbNyO0dZ94JZMx8UaZzOLaVw4Eds-FlcQ7ND7-zj3ifPP=_d102_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Sun, Oct 15, 2023 at 08:28:18PM -0700, Vishal Moola wrote:
> On Sun, Oct 15, 2023 at 5:42 PM Hyesoo Yu <hyesoo.yu@samsung.com> wrote:
> >
> > On Fri, Oct 13, 2023 at 01:54:08PM -0700, Vishal Moola wrote:
> > > On Thu, Oct 12, 2023 at 10:11:06AM +0900, Hyesoo Yu wrote:
> > > > For compound pages, the head sets the PG_head flag and
> > > > the tail sets the compound_head to indicate the head page.
> > > > If a user allocates a compound page and frees it with a different
> > > > order, the compound page information will not be properly
> > > > initialized. To detect this problem, compound_page(page) and
> 
> s/compound_page/compound_order/
> 
> > > > the order are compared, but it is not checked when the order is 0.
> > > > That error should be checked regardless of the order.
> 
> With this many mentions of "the order", it is easy to misinterpret "the
> order"
> to be referencing the page order rather than the order of pages we are
> trying
> to free. I recommend replacing "the order" with "the order argument" or
> something similar for clarity.
> 

What a good idea! I'll replace that. Thanks for your comments.

> > > I believe all compound pages are order >= 1, so this error can't occur
> > > when the order is 0.
> > >
> >
> > Yes. All compound pages are order >= 1.
> > However if the user uses the API incorrectly, the order value could be
> zero.
> 
> I see, thanks for clarifying that.
> 
> With the commit message changes above:
> Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> 

Okay, Thanks for review.

Regards.
Hyesoo Yu.

> > For example,
> >
> > addr = alloc_pages(GFP_COMP, 2);
> > free_pages(addr, 0);
> >
> > (struct page[16])0xFFFFFFFE21715100 = (
> > (flags = 0x4000000000000200, lru = (next = 0x0, prev =
> 0xDEAD000000000122),//  Clear PG_head
> > (flags = 0x4000000000000000, lru = (next = 0xFFFFFFFE21715101, prev =
> 0xFFFFFFFF00000201),  // Remain compound head
> >
> > It is memory leak, and it also makes system stability problem.
> > on isolation_single_pageblock, That case makes infinite loops.
> >
> > for (pfn = start_pfn; pfn < boundary_pfn; ) {
> >         if (PageCompound(page)) { // page[1] is compound page
> >                 struct page *head = compound_head(page); // page[0]
> >                 unsigned long head_pfn = page_to_pfn(head);
> >                 unsigned long nr_pages = compound_nr(head); // nr_pages
> is 1 since page[0] is not compound page.
> >
> >                 if (head_pfn + nr_pages <= boundary_pfn) {
> >                         pfn = head_pfn + nr_pages; // pfn is set as
> page[1].
> >                         continue;
> >                 }
> > }
> >
> > So, I guess, we have to check the incorrect use in free_pages_prepare.
> >
> > Thanks,
> > Hyesoo Yu.

------kpWfbNyO0dZ94JZMx8UaZzOLaVw4Eds-FlcQ7ND7-zj3ifPP=_d102_
Content-Type: text/plain; charset="utf-8"


------kpWfbNyO0dZ94JZMx8UaZzOLaVw4Eds-FlcQ7ND7-zj3ifPP=_d102_--
