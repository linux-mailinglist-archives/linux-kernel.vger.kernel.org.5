Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3A577E358
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343513AbjHPOOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbjHPONq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:13:46 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D252706
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:13:40 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230816141338euoutp01d9cbca771038ff37ae5748a4f4af9e14~74pXrNVBq1973419734euoutp01S
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:13:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230816141338euoutp01d9cbca771038ff37ae5748a4f4af9e14~74pXrNVBq1973419734euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1692195218;
        bh=wLwr6gnPMrVuRdoUCnV9+Ys56Mqg2tWmonUHpJvmY+E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PWvkTuMBcIT7tWdgoSv9UZfRC50Tnrm2egy6ESN2ZYZmYlJ2g+htv7p5qrgq/sCEJ
         g3wxxoLA5gaZi2ZkJfdeUKKVMmJPOI8ygtZXoSBPQVX5cmtShN+mIRVmIzIj6NSBm/
         BC11kxWcqfqNoZIlHk68/Txls+1wOW9aMilnbwQE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230816141338eucas1p2129e9e75855997125475391eb00750d9~74pXS0xgx2836328363eucas1p23;
        Wed, 16 Aug 2023 14:13:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B8.AF.42423.199DCD46; Wed, 16
        Aug 2023 15:13:37 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230816141337eucas1p1dabe7fb9f6bd69d6ce50586ca5df54d4~74pW4U2eK1452514525eucas1p1n;
        Wed, 16 Aug 2023 14:13:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230816141337eusmtrp2eb046b9b69d4d4e5b86fb69f834f96fa~74pW3ms5M3018630186eusmtrp2U;
        Wed, 16 Aug 2023 14:13:37 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-24-64dcd9915078
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 67.8B.14344.199DCD46; Wed, 16
        Aug 2023 15:13:37 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230816141337eusmtip107774bcc266c90b6eda9ff60aeabb727~74pWngub92176321763eusmtip1X;
        Wed, 16 Aug 2023 14:13:37 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Wed, 16 Aug 2023 15:13:36 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Wed, 16 Aug
        2023 15:13:36 +0100
From:   Daniel Gomez <da.gomez@samsung.com>
To:     "Yin, Fengwei" <fengwei.yin@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "vishal.moola@gmail.com" <vishal.moola@gmail.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "david@redhat.com" <david@redhat.com>,
        "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
        "shy828301@gmail.com" <shy828301@gmail.com>
Subject: Re: [PATCH v2 3/3] madvise:madvise_free_pte_range(): don't use
 mapcount() against large folio for sharing check
Thread-Topic: [PATCH v2 3/3] madvise:madvise_free_pte_range(): don't use
        mapcount() against large folio for sharing check
Thread-Index: AQHZz3vpurV86lSwc0Wr64w4rsIXva/r8T+AgADNGgCAAAV0gIAAJCQA
Date:   Wed, 16 Aug 2023 14:13:35 +0000
Message-ID: <a4k27pleianmjbt2d5lqlmwqv7k2pujzfv75y2q564vrcdye3w@xf3wcifffxkx>
In-Reply-To: <4412ad3c-ebed-40a4-8f4e-83bb1b53b686@intel.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [106.110.32.67]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <81886C2D09B51A449710C87C857467DA@scsc.local>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7djP87oTb95JMdiy0sZizvo1bBZf1/9i
        trhy+g2TxeVdc9gs7q35z2qx7Ot7doue3VMZLRacWAwkNj5itFi/7warRePn+4wWv38A1b2b
        8IXVgddjzbw1jB47Z91l91iwqdSj5chbVo/NK7Q8Fu95yeSxaVUnm8emT5PYPU7M+M3i8X7f
        VTaPz5vkArijuGxSUnMyy1KL9O0SuDIObdjNXnBAo2L3nJtsDYw9Cl2MnBwSAiYS876dYQSx
        hQRWMEp0NQp0MXIB2V8YJXav38EE4XxmlJi1dgEzTMfk/idQieWMEv/n3mWFaAequt4YCpE4
        wyjxfc0LqKqVjBK3VlwFa2cT0JTYd3ITO0hCRKCNVWLSxPlMIAlhgSqJFdsOAl3CAZSolri6
        rRokLCLgJvGguYkNxGYRUJXoXX4AbBuvgK9E6/9OFhCbU8BW4kDDcbAxjAKyEo9W/mIHsZkF
        xCVuPYEYLyEgKLFo9h6oF8Qk/u16yAZh60icvf6EEcI2kNi6dB8LhK0o0XHsJhvEHB2JBbs/
        QdmWEvtXdzJC2NoSyxa+Zoa4R1Di5MwnLCB/SQjM5ZJ49bGHFWKQi8SxCeuhFgtLvDq+hR3C
        lpH4v3M+0wRG7VlIbp2FZN8sJPtmIdk3C8m+BYysqxjFU0uLc9NTiw3zUsv1ihNzi0vz0vWS
        83M3MQLT4ul/xz/tYJz76qPeIUYmDsZDjBIczEoivD28t1KEeFMSK6tSi/Lji0pzUosPMUpz
        sCiJ82rbnkwWEkhPLEnNTk0tSC2CyTJxcEo1MCVIb1Wf+sjxT/fVL6yhBf93/zj1Ne+C0NSX
        87/sfcbLJum36Ffw5c0v58TG+s5MNj5SsUsh6dK6qQvr5xbOrj/Bv+ZzsIDobiPXhS+bqtqk
        WOd+kVJSWRjfu8l+MnudUPcVRk3tOypW/k6vjld3L36qbXqfN+L1tFt6S/edZEoOSqz62+l4
        Qf2fzh+VR59YPJ6aSO2JqxZ6uaR9zpfLSZadB1anaf3bsrXo06rpiRtXsU+wcTRf/P7CC2et
        uXO4nv74onlaQjnO7cDnD1McZWXFHVbc37aj+t/FC5Wqek7hcnLMM+LuXuw97nfzz9rjbU5d
        /5jWar7yadY5s/hiNf+EkD7zYxW7vM0r9qk9+LpDiaU4I9FQi7moOBEACx7otfoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsVy+t/xu7oTb95JMVg/Q95izvo1bBZf1/9i
        trhy+g2TxeVdc9gs7q35z2qx7Ot7doue3VMZLRacWAwkNj5itFi/7warRePn+4wWv38A1b2b
        8IXVgddjzbw1jB47Z91l91iwqdSj5chbVo/NK7Q8Fu95yeSxaVUnm8emT5PYPU7M+M3i8X7f
        VTaPz5vkArij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL
        9O0S9DIObdjNXnBAo2L3nJtsDYw9Cl2MnBwSAiYSk/ufMHUxcnEICSxllLh95DoLREJGYuOX
        q6wQtrDEn2tdbBBFHxklZi3YDNVxhlHiYudeVghnJaPE779NjCAtbAKaEvtObmIHSYgItLFK
        TJo4nwkkISxQJbFi20GwIhGBaon7x0+wQNhuEg+am9hAbBYBVYne5QfAdvMK+Eq0/u9kgdiw
        kVni+5HFYAlOAVuJAw3HwYYyCshKPFr5ix3EZhYQl7j1BGKZhICAxJI955khbFGJl4//QT2k
        I3H2+hNGCNtAYuvSfVBPK0p0HLvJBjFHR2LB7k9QtqXE/tWdjBC2tsSyha+ZIY4TlDg58wnL
        BEbpWUhWz0LSPgtJ+ywk7bOQtC9gZF3FKJJaWpybnltspFecmFtcmpeul5yfu4kRmOC2Hfu5
        ZQfjylcf9Q4xMnEwHmKU4GBWEuHt4b2VIsSbklhZlVqUH19UmpNafIjRFBh4E5mlRJPzgSk2
        ryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qBadcq6+aDewL/LHWJ
        Px1wK27Gn0V/e9c9Xhd9rXvbgTV5SbvctI/rStn7vsy+H9f4f/WvHdu2NWerHrl2edtT92wp
        aRv9Ewmn79t1+T4oKTA/HvS3OGf7O8td4rw6f9SLL5Vpl4seFZILfCafKTNz3sGiCLbV92xE
        sm8oeijN+6oYKSKxa6lRv3ZOx3vBPa/EDDxqjUIvlifMX//wKFu/onRJl8bd4EMLdDoVLy8+
        whrg6ub9Om/elAd98623yDNzXhSVyL+6tat86cp30oGvprr0Gv/83SZcXbW0ccm5PYnFypo1
        ueLhya3F8Q/OX/2j+aPJKGzWXFvO2HTDDe5814oqu4Me/bz557rqZuF0JZbijERDLeai4kQA
        tlZ+pPkDAAA=
X-CMS-MailID: 20230816141337eucas1p1dabe7fb9f6bd69d6ce50586ca5df54d4
X-Msg-Generator: CA
X-RootMTR: 20230815132509eucas1p1b34b2852a9c4efe743c8da82867c4cc3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230815132509eucas1p1b34b2852a9c4efe743c8da82867c4cc3
References: <20230808020917.2230692-1-fengwei.yin@intel.com>
        <20230808020917.2230692-4-fengwei.yin@intel.com>
        <CGME20230815132509eucas1p1b34b2852a9c4efe743c8da82867c4cc3@eucas1p1.samsung.com>
        <4jvrmdpyteny5vaqmcrctzrovap2oy2zuukybbhfqyqbbb5xmy@ufgxufss2ngw>
        <2bfa1931-1fc6-5d6f-cba1-c7a9eb8a279a@intel.com>
        <svdxtqiihsjwcbxjp67s6cteprhoxgypf7rjrk2v73ppyn2ogp@ee4ru6vgspl4>
        <4412ad3c-ebed-40a4-8f4e-83bb1b53b686@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 08:04:11PM +0800, Yin, Fengwei wrote:
>
>
> On 8/16/2023 7:44 PM, Daniel Gomez wrote:
> > On Wed, Aug 16, 2023 at 07:30:35AM +0800, Yin Fengwei wrote:
> >>
> >>
> >> On 8/15/23 21:25, Daniel Gomez wrote:
> >>> Hi Yin,
> >>> On Tue, Aug 08, 2023 at 10:09:17AM +0800, Yin Fengwei wrote:
> >>>> Commit 98b211d6415f ("madvise: convert madvise_free_pte_range() to u=
se a
> >>>> folio") replaced the page_mapcount() with folio_mapcount() to check
> >>>> whether the folio is shared by other mapping.
> >>>>
> >>>> It's not correct for large folios. folio_mapcount() returns the tota=
l
> >>>> mapcount of large folio which is not suitable to detect whether the =
folio
> >>>> is shared.
> >>>>
> >>>> Use folio_estimated_sharers() which returns a estimated number of sh=
ares.
> >>>> That means it's not 100% correct. It should be OK for madvise case h=
ere.
> >>>
> >>> I'm trying to understand why it should be ok for madvise this change,=
 so
> >>> I hope it's okay to ask you few questions.
> >>>
> >>> folio_mapcount() calculates the total maps for all the subpages of a
> >>> folio. However, the folio_estimated_sharers does it only for the firs=
t
> >>> subpage making it not true for large folios. Then, wouldn't this chan=
ge
> >>> drop support for large folios?
> >> I saw David explained this very well in another mail.
> >>
> >>>
> >>> Seems like folio_entire_mapcount() is not accurate either because of =
it
> >>> does not inclue PTE-mapped sub-pages which I think we need here. Henc=
e,
> >>> the folio_mapcount(). Could this be something missing in the test sid=
e?
> >>>
> >>> I tried to replicate the setup with CONFIG_TRANSPARENT_HUGEPAGE but
> >>> seems like I'm not able to do it:
> >>>
> >>> ./cow
> >>> # [INFO] detected THP size: 2048 KiB
> >>> # [INFO] detected hugetlb size: 2048 KiB
> >>> # [INFO] detected hugetlb size: 1048576 KiB
> >>> # [INFO] huge zeropage is enabled
> >>> TAP version 13
> >>> 1..166
> >>> # [INFO] Anonymous memory tests in private mappings
> >>> # [RUN] Basic COW after fork() ... with base page
> >>> not ok 1 MADV_NOHUGEPAGE failed
> >>> # [RUN] Basic COW after fork() ... with swapped out base page
> >>> not ok 2 MADV_NOHUGEPAGE failed
> >>> # [RUN] Basic COW after fork() ... with THP
> >>> not ok 3 MADV_HUGEPAGE failed
> >>> # [RUN] Basic COW after fork() ... with swapped-out THP
> >>> not ok 4 MADV_HUGEPAGE failed
> >>> # [RUN] Basic COW after fork() ... with PTE-mapped THP
> >>> not ok 5 MADV_HUGEPAGE failed
> >>> # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
> >>> not ok 6 MADV_HUGEPAGE failed
> >>> ...
> >> Can you post the MADV_PAGEOUT and PTE-mapped THP related testing resul=
t?
> >> And I suppose swap need be enabled also for the testing.
> >
> > You may find a dump of the logs in the link below with system informati=
on. Let me
> > know if you find something wrong in my setup or if you need something e=
lse.
> > Besides CONFIG_TRANSPARENT_HUGEPAGE, CONFIG_SWAP is also enabled in the=
 kernel.
> >
> > https://gitlab.com/-/snippets/2584135
> >
> > Also, strace reports ENOSYS for MADV_*:
> > madvise(0x7f2912465000, 4096, MADV_NOHUGEPAGE) =3D -1 ENOSYS (Function =
not implemented)
> > madvise(0x7f2912000000, 2097152, MADV_HUGEPAGE) =3D -1 ENOSYS (Function=
 not implemented)
> O. The problem here is MADV_HUGEPAGE/MADV_NOHUGEPAGE doesn't work.
> Do you have CONFIG_ADVISE_SYSCALLS enabled?
It worked after I enabled the conf. Some tests failed and some were
skipped. But I managed to reproduce the issue now, thanks Yin!

Bail out! 4 out of 166 tests failed
# Totals: pass:146 fail:4 xfail:0 xpass:0 skip:16 error:0

Here the full log:
https://gitlab.com/-/snippets/2584190/raw/main/cow.txt
>
> Regards
> Yin, Fengwei
>
> >
> >
> >>
> >>
> >> Regards
> >> Yin, Fengwei
> >>
> >>>
> >>>
> >>> Daniel
> >>>>
> >>>> User-visible effects is that the THP is skipped when user call madvi=
se.
> >>>> But the correct behavior is THP should be split and processed then.
> >>>>
> >>>> NOTE: this change is a temporary fix to reduce the user-visible effe=
cts
> >>>> before the long term fix from David is ready.
> >>>>
> >>>> Fixes: 98b211d6415f ("madvise: convert madvise_free_pte_range() to u=
se a folio")
> >>>> Cc: stable@vger.kernel.org
> >>>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
> >>>> Reviewed-by: Yu Zhao <yuzhao@google.com>
> >>>> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> >>>> ---
> >>>>  mm/madvise.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/mm/madvise.c b/mm/madvise.c
> >>>> index 49af35e2d99a..4dded5d27e7e 100644
> >>>> --- a/mm/madvise.c
> >>>> +++ b/mm/madvise.c
> >>>> @@ -683,7 +683,7 @@ static int madvise_free_pte_range(pmd_t *pmd, un=
signed long addr,
> >>>>  		if (folio_test_large(folio)) {
> >>>>  			int err;
> >>>>
> >>>> -			if (folio_mapcount(folio) !=3D 1)
> >>>> +			if (folio_estimated_sharers(folio) !=3D 1)
> >>>>  				break;
> >>>>  			if (!folio_trylock(folio))
> >>>>  				break;
> >>>> --
> >>>> 2.39.2
> >>> >=
