Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4C17C9CB8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 02:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjJPAm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 20:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjJPAm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 20:42:26 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34434A3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 17:42:23 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231016004219epoutp01c4ed45c5d52744660d31fbe97830d50c~Ob7amRv8r0099800998epoutp01e
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:42:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231016004219epoutp01c4ed45c5d52744660d31fbe97830d50c~Ob7amRv8r0099800998epoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697416939;
        bh=4thdf5vOiLjNrlhR2orFClc4haODcBFO8AN2JFM2cnA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PeDRdZNLcuLh7z5g9kFSW/wk51LkiJZyDZQ+6SUroc/HLojJ4caiDrbV3i3TaArFt
         fy/JhrNOF5Q2QF/oRySNRxBPYUGH+ZRy7xf/pzmENqE2ftxHgIhxN3gOp6kcgpoUWN
         xG0VMBYgrbNRAKo5KkZ6OBPDb5lgci4Tr9fM/z0w=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20231016004219epcas2p4cf1710a7794b601974475673c85d50e4~Ob7aTVSqS2621026210epcas2p4K;
        Mon, 16 Oct 2023 00:42:19 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.70]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4S7yxQ6vHCz4x9QC; Mon, 16 Oct
        2023 00:42:18 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.1D.18994.AE68C256; Mon, 16 Oct 2023 09:42:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20231016004218epcas2p19472bf83c7e69f73326a07141a021d98~Ob7ZZXoos1597115971epcas2p1-;
        Mon, 16 Oct 2023 00:42:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231016004218epsmtrp2b0992bb1f664dfed8e0b16647463804c~Ob7ZYyDpF1181411814epsmtrp2n;
        Mon, 16 Oct 2023 00:42:18 +0000 (GMT)
X-AuditID: b6c32a4d-9f7ff70000004a32-e2-652c86ea40fc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.57.08755.AE68C256; Mon, 16 Oct 2023 09:42:18 +0900 (KST)
Received: from tiffany (unknown [10.229.95.142]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231016004218epsmtip2ce75f3cb6e92d4aa50e617a76f01c8aa~Ob7ZPUyhD2150521505epsmtip2z;
        Mon, 16 Oct 2023 00:42:18 +0000 (GMT)
Date:   Mon, 16 Oct 2023 09:32:00 +0900
From:   Hyesoo Yu <hyesoo.yu@samsung.com>
To:     Vishal Moola <vishal.moola@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: page_alloc: check the order of compound page event
 when the order is 0
Message-ID: <20231016003200.GA445850@tiffany>
MIME-Version: 1.0
In-Reply-To: <ZSmucNWBMj/mNVeE@dhcp-10-159-238-251.vpn.oracle.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmhe6rNp1Ug952C4s569ewWVzeNYfN
        4t6a/6wW6/fdYHVg8dg56y67x6ZPk9g9Tsz4zeLxeZNcAEtUtk1GamJKapFCal5yfkpmXrqt
        kndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0EolhbLEnFKgUEBicbGSvp1NUX5pSapC
        Rn5xia1SakFKToF5gV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGqQfP2AoOCVQ0TZvJ3sC4k7eL
        kZNDQsBEYk33HZYuRi4OIYE9jBK33u1ihXA+MUqcON7LDOF8Y5RoaVvNDtPStH8LVGIvo8TW
        S6uYIJynjBL3t70Hcjg4WARUJa7+cAFpYBNQlzixZRkjSFhEQFNi5d8kkDCzQKLE36nrwWYK
        A9k7mzewgdi8AroSK96cZIGwBSVOznwCZnMKOEkcW/SZCeKGS+wS1/sDIGwXiY5vt5khbGGJ
        V8e3QN0pJfH53V42CDtb4u7HCVB2icS6Mw1QNcYSs561M0Lcky7xY98TNpAzJQSUJY7cYoEI
        80l0HP7LDhHmlehoE4LoVJbYv2weC4QtKfFobTsrRImHRNeeeEh4nGCU+D5rCvsERrlZSJ6Z
        hWQZhK0jsWD3JyCbA8iWllj+jwPC1JRYv0t/ASPrKkap1ILi3PTUZKMCQ9281HJ4DCfn525i
        BCdBLd8djK/X/9U7xMjEwXiIUYKDWUmENz1YJ1WINyWxsiq1KD++qDQntfgQoykwbiYyS4km
        5wPTcF5JvKGJpYGJmZmhuZGpgbmSOO+91rkpQgLpiSWp2ampBalFMH1MHJxSDUycXMqXGMJ1
        ZxrNe896RXO1+MRzF9+GZOwtP7i39ZHfbMXqQyvufF1/XuCX6JOvNXbmc05s9016F7PzlY6n
        ebeIqc3WDQoKU3OWpkrv+S8nJuVwvGaVv/0c35n7lq85N2PKsjWbXqh/1NGys1606uTarQUy
        x8Ms2rc/uxH5WcZojk1A+bwzedX50wwKmiuvzq73fSbyWsfIzfuRCePCqhmfOxutzh69t6vP
        6IjCxjXPNslNsn6/sMuW5SPT82UNVlP13/2JjGB3fSV8+kdhULKzw2FeNmPv/s3tpew7dN/W
        fHnfdtNgbXnAh2v9m6+cte79t8V0544NPJwM+6ftmHQugPfcFcZFwuybtk3KuXDmmBJLcUai
        oRZzUXEiAL5ewbELBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWy7bCSvO6rNp1Ug0/3ZCzmrF/DZnF51xw2
        i3tr/rNarN93g9WBxWPnrLvsHps+TWL3ODHjN4vH501yASxRXDYpqTmZZalF+nYJXBnPvhoU
        tPJVHH7Yw9TAOJW7i5GTQ0LARKJp/xbmLkYuDiGB3YwSC26fY4FISErM+nySCcIWlrjfcoQV
        ougxo8SOYxvZuhg5OFgEVCWu/nABqWETUJc4sWUZI0hYREBTYuXfJJAws0CixN+p69lBbGEg
        e2fzBjYQm1dAV2LFm5MsECNPMEr8+7aLGSIhKHFy5hMWiGYtiRv/XjKBzGQWkJZY/o8DJMwp
        4CRxbNFnpgmMArOQdMxC0jELoWMBI/MqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzg
        8NXS3MG4fdUHvUOMTByMhxglOJiVRHjTg3VShXhTEiurUovy44tKc1KLDzFKc7AoifOKv+hN
        ERJITyxJzU5NLUgtgskycXBKNTAll12TPOjc+nXa28MnyhI5tjzbbn187mS/oOZv17nuWnNt
        +KHEYqR5+aOdidwK0z1Sh9+zR3083NB9XuWLknKfYJG02SPDbfcuNnlU3LfYdtRwes7tjV+L
        vk3L4Pq14mSr6i9uNTbJBr0Lm4r4ruYZJV9ds/b15z1PD99Jl5BIE3ExPnHtsLVDgp73hd2X
        C8Qf7vztwaZbcH3NehOzkEqj+X6xuqqhMX6V/7JmOdq+lHFynvJbrcHypPlptu3RJt90FLP8
        7q2emHx2/eSjCk5T42MaWeweLPmUfGD/ISEuh1kpm5wbr05l2v268fuFyn+RH9n4BKS9ZBbK
        Rdwt+GzSkO0k+6risOfU8oNXFU8osRRnJBpqMRcVJwIA4uZzW84CAAA=
X-CMS-MailID: 20231016004218epcas2p19472bf83c7e69f73326a07141a021d98
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----.DGRwfvtDKQaTon4q7jBZTz_rY-uYfv-SaOoriR32EfX1D_r=_7c95_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231012012153epcas2p34b8e9e8a898ace8d50411cadf937ef5d
References: <CGME20231012012153epcas2p34b8e9e8a898ace8d50411cadf937ef5d@epcas2p3.samsung.com>
        <20231012011106.2425309-1-hyesoo.yu@samsung.com>
        <ZSmucNWBMj/mNVeE@dhcp-10-159-238-251.vpn.oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------.DGRwfvtDKQaTon4q7jBZTz_rY-uYfv-SaOoriR32EfX1D_r=_7c95_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Fri, Oct 13, 2023 at 01:54:08PM -0700, Vishal Moola wrote:
> On Thu, Oct 12, 2023 at 10:11:06AM +0900, Hyesoo Yu wrote:
> > For compound pages, the head sets the PG_head flag and
> > the tail sets the compound_head to indicate the head page.
> > If a user allocates a compound page and frees it with a different
> > order, the compound page information will not be properly
> > initialized. To detect this problem, compound_page(page) and
> > the order are compared, but it is not checked when the order is 0.
> > That error should be checked regardless of the order.
> 
> I believe all compound pages are order >= 1, so this error can't occur
> when the order is 0.
> 

Yes. All compound pages are order >= 1.
However if the user uses the API incorrectly, the order value could be zero.

For example,

addr = alloc_pages(GFP_COMP, 2);
free_pages(addr, 0);

(struct page[16])0xFFFFFFFE21715100 = (
(flags = 0x4000000000000200, lru = (next = 0x0, prev = 0xDEAD000000000122),//  Clear PG_head
(flags = 0x4000000000000000, lru = (next = 0xFFFFFFFE21715101, prev = 0xFFFFFFFF00000201),  // Remain compound head

It is memory leak, and it also makes system stability problem.
on isolation_single_pageblock, That case makes infinite loops.

for (pfn = start_pfn; pfn < boundary_pfn; ) {
	if (PageCompound(page)) { // page[1] is compound page
		struct page *head = compound_head(page); // page[0]
		unsigned long head_pfn = page_to_pfn(head);
		unsigned long nr_pages = compound_nr(head); // nr_pages is 1 since page[0] is not compound page.

 		if (head_pfn + nr_pages <= boundary_pfn) {
			pfn = head_pfn + nr_pages; // pfn is set as page[1].
			continue;
		}
}

So, I guess, we have to check the incorrect use in free_pages_prepare.

Thanks,
Hyesoo Yu.

------.DGRwfvtDKQaTon4q7jBZTz_rY-uYfv-SaOoriR32EfX1D_r=_7c95_
Content-Type: text/plain; charset="utf-8"


------.DGRwfvtDKQaTon4q7jBZTz_rY-uYfv-SaOoriR32EfX1D_r=_7c95_--
