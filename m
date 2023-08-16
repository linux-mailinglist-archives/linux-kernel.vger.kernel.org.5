Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5959977E0AD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244729AbjHPLpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244712AbjHPLow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:44:52 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225B11FC1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 04:44:50 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230816114445euoutp016f9d1d8204bdffd4d47f90469321eb50~72nYl9vIZ1440414404euoutp018
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:44:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230816114445euoutp016f9d1d8204bdffd4d47f90469321eb50~72nYl9vIZ1440414404euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1692186286;
        bh=ybP/u9jD3e17xx+5UrgeaaroBvLgdMV/sJVwSUP79EE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LRe0ntnlR7AW5LTvIRLVgOZm4Pq0+Rj2fDkKg6YBww3E4az/qucnvgkdns3tv0iih
         T2C/t9d+bXnFwFU0bRH6Q247j9yCdNFqG56TbQDSVZ5DNVb9/nE8zL8qqF9D3DzENx
         l7or3nts7lsGOZgEquJMysoiO11PWFTzn17M4ayQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230816114445eucas1p1080f6e8f332f6d04388749a0023474af~72nYOt-vb3120331203eucas1p1Z;
        Wed, 16 Aug 2023 11:44:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 86.6D.42423.DA6BCD46; Wed, 16
        Aug 2023 12:44:45 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230816114444eucas1p10af08143378ae52fcc3694158265d7ab~72nXm7Nn10491904919eucas1p1e;
        Wed, 16 Aug 2023 11:44:44 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230816114444eusmtrp2de454619f9385fbe7fe1f9e936ac4dcb~72nXmQ9uF1142111421eusmtrp2q;
        Wed, 16 Aug 2023 11:44:44 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-f1-64dcb6adaf00
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C1.73.10549.CA6BCD46; Wed, 16
        Aug 2023 12:44:44 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230816114444eusmtip27edfb6c0aaadef540a9af7b73bfe0924~72nXZvqjZ2443724437eusmtip2e;
        Wed, 16 Aug 2023 11:44:44 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Wed, 16 Aug 2023 12:44:43 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Wed, 16 Aug
        2023 12:44:43 +0100
From:   Daniel Gomez <da.gomez@samsung.com>
To:     Yin Fengwei <fengwei.yin@intel.com>,
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
Thread-Index: AQHZz3vpurV86lSwc0Wr64w4rsIXva/r8T+AgADNGgA=
Date:   Wed, 16 Aug 2023 11:44:43 +0000
Message-ID: <svdxtqiihsjwcbxjp67s6cteprhoxgypf7rjrk2v73ppyn2ogp@ee4ru6vgspl4>
In-Reply-To: <2bfa1931-1fc6-5d6f-cba1-c7a9eb8a279a@intel.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [106.110.32.67]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <654ECA4FAD1BA543B8F2043D1DBB903F@scsc.local>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsWy7djP87prt91JMdj4VM5izvo1bBZf1/9i
        trhy+g2TxeVdc9gs7q35z2qx7Ot7doue3VMZLRacWAwkNj5itFi/7warRePn+4wWv38A1b2b
        8IXVgddjzbw1jB47Z91l91iwqdSj5chbVo/NK7Q8Fu95yeSxaVUnm8emT5PYPU7M+M3i8X7f
        VTaPz5vkArijuGxSUnMyy1KL9O0SuDJ+r1jIWvBesWLGn3tsDYw3pboYOTgkBEwkGo4JdDFy
        cQgJrGCUWL3/ExuE84VRomPtOijnM6NE690/TF2MnGAdk869YIVILGeUaP68mAWu6uKxNkYI
        5wyjxNPzMMNWMkq8XTiTBaSfTUBTYt/JTewgCRGBZlaJA9M/gCWEBaokVmw7yAhylohAtcTV
        bdUgYREBK4kXk+azgYRZBFQlds2QAwnzCvhKPPg5C6yTU8BWYv206WA2o4CsxKOVv9hBbGYB
        cYlbT+ZDnS0osWj2HmYIW0zi366HbBC2jsTZ608YIWwDia1L97FA2IoSHcduskHM0ZFYsPsT
        lG0psfjBOVYIW1ti2cLXzBD3CEqcnPkEHBISAgu5JA79bGKGhLCLxIVroRAzhSVeHd/CDmHL
        SPzfOZ9pAqP2LCSnzkKybhaSdbOQrJuFZN0CRtZVjOKppcW56anFhnmp5XrFibnFpXnpesn5
        uZsYgUnx9L/jn3Ywzn31Ue8QIxMH4yFGCQ5mJRHeHt5bKUK8KYmVValF+fFFpTmpxYcYpTlY
        lMR5tW1PJgsJpCeWpGanphakFsFkmTg4pRqYXJhZLNK5X35e/iptde1vQXM7i5P3fi+f8kF0
        M0/YtG3F6z50evgw5jfx8tXw5B2MaD1ZqyruMfnV3EM38gU+en9dpBjvsT9R9ckf5k3TeS9N
        N6ud/qlNPM1ETm6v6gbjYLNV2pnvKuP3iStk/mLO7+7d9vfL3BPzlaoknP01X5iUv5xgPW/V
        J/vpSRoz2uW9v4g0N374zWpr/l/phq/gWdODl8z7LEobd/6cyiL2oN1aRvTPwjeHKh/ZHrvy
        goFndWG9u/Vq+cfrds97XF60Y0mogOerFd81dy4Q+HF5/rqqN57CUUt3V3J1mc3g9/8xs2ar
        eeN1M5cGhznt3R0sDR8zPCTuMNb1RH2UVnRVYinOSDTUYi4qTgQA5TVPt/kDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsVy+t/xe7prtt1JMbjaaWQxZ/0aNouv638x
        W1w5/YbJ4vKuOWwW99b8Z7VY9vU9u0XP7qmMFgtOLAYSGx8xWqzfd4PVovHzfUaL3z+A6t5N
        +MLqwOuxZt4aRo+ds+6yeyzYVOrRcuQtq8fmFVoei/e8ZPLYtKqTzWPTp0nsHidm/GbxeL/v
        KpvH501yAdxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF
        +nYJehm/VyxkLXivWDHjzz22BsabUl2MnBwSAiYSk869YO1i5OIQEljKKHH78A0miISMxMYv
        V1khbGGJP9e62CCKPjJK3NtwjwnCOcMosfb6FnYIZyWjxIZ/n8Ha2QQ0Jfad3ASWEBFoZpU4
        MP0DC0hCWKBKYsW2g4wgtohAtcT94ydYIGwriReT5gPt4OBgEVCV2DVDDiTMK+Ar8eDnLBaI
        BbuYJKZ//ckMkuAUsJVYP206WC+jgKzEo5W/2EFsZgFxiVtP5kP9ICCxZM95ZghbVOLl439Q
        /+hInL3+hBHCNpDYunQfC4StKNFx7CYbxBwdiQW7P0HZlhKLH5xjhbC1JZYtfM0McZygxMmZ
        T1gmMErPQrJ6FpL2WUjaZyFpn4WkfQEj6ypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzA9Lbt
        2M/NOxjnvfqod4iRiYPxEKMEB7OSCG8P760UId6UxMqq1KL8+KLSnNTiQ4ymwLCbyCwlmpwP
        TLB5JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1Ms/0M119k/TJ9
        zdIfJqtjdH/5pR6aKrRiw5MNvmvkHffs74/1dLcydjJaUtp79wfLr2/+AY3Jol3HKyND9e/M
        yhNVajz+Yd+U7jPO+yIEp80rVrROXHrlpcibgJJgtjgVs0KFqpNbp8iwbj12qjTn2/OTSzVm
        RMpcOhz+qMlU/4zsi9ITy48+f5Rb+MpYML3rYVqWgUXM5Es6Sy8nzVi+9NHK7Dzj9gU1y26e
        XXmp/txNwazpFb5B1xbuUmL+9uhPrPmlh1eS3MtVdQMOf2BcdstoGnta6pQ0pn971l/Ksq7n
        bN37deFL1v/Ks5ZM77A7mH3u14oZkw9c5Pxy/K5u9pu4WuOmahtL7cAS5/nCakosxRmJhlrM
        RcWJAAbJdML4AwAA
X-CMS-MailID: 20230816114444eucas1p10af08143378ae52fcc3694158265d7ab
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 07:30:35AM +0800, Yin Fengwei wrote:
>
>
> On 8/15/23 21:25, Daniel Gomez wrote:
> > Hi Yin,
> > On Tue, Aug 08, 2023 at 10:09:17AM +0800, Yin Fengwei wrote:
> >> Commit 98b211d6415f ("madvise: convert madvise_free_pte_range() to use=
 a
> >> folio") replaced the page_mapcount() with folio_mapcount() to check
> >> whether the folio is shared by other mapping.
> >>
> >> It's not correct for large folios. folio_mapcount() returns the total
> >> mapcount of large folio which is not suitable to detect whether the fo=
lio
> >> is shared.
> >>
> >> Use folio_estimated_sharers() which returns a estimated number of shar=
es.
> >> That means it's not 100% correct. It should be OK for madvise case her=
e.
> >
> > I'm trying to understand why it should be ok for madvise this change, s=
o
> > I hope it's okay to ask you few questions.
> >
> > folio_mapcount() calculates the total maps for all the subpages of a
> > folio. However, the folio_estimated_sharers does it only for the first
> > subpage making it not true for large folios. Then, wouldn't this change
> > drop support for large folios?
> I saw David explained this very well in another mail.
>
> >
> > Seems like folio_entire_mapcount() is not accurate either because of it
> > does not inclue PTE-mapped sub-pages which I think we need here. Hence,
> > the folio_mapcount(). Could this be something missing in the test side?
> >
> > I tried to replicate the setup with CONFIG_TRANSPARENT_HUGEPAGE but
> > seems like I'm not able to do it:
> >
> > ./cow
> > # [INFO] detected THP size: 2048 KiB
> > # [INFO] detected hugetlb size: 2048 KiB
> > # [INFO] detected hugetlb size: 1048576 KiB
> > # [INFO] huge zeropage is enabled
> > TAP version 13
> > 1..166
> > # [INFO] Anonymous memory tests in private mappings
> > # [RUN] Basic COW after fork() ... with base page
> > not ok 1 MADV_NOHUGEPAGE failed
> > # [RUN] Basic COW after fork() ... with swapped out base page
> > not ok 2 MADV_NOHUGEPAGE failed
> > # [RUN] Basic COW after fork() ... with THP
> > not ok 3 MADV_HUGEPAGE failed
> > # [RUN] Basic COW after fork() ... with swapped-out THP
> > not ok 4 MADV_HUGEPAGE failed
> > # [RUN] Basic COW after fork() ... with PTE-mapped THP
> > not ok 5 MADV_HUGEPAGE failed
> > # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
> > not ok 6 MADV_HUGEPAGE failed
> > ...
> Can you post the MADV_PAGEOUT and PTE-mapped THP related testing result?
> And I suppose swap need be enabled also for the testing.

You may find a dump of the logs in the link below with system information. =
Let me
know if you find something wrong in my setup or if you need something else.
Besides CONFIG_TRANSPARENT_HUGEPAGE, CONFIG_SWAP is also enabled in the ker=
nel.

https://gitlab.com/-/snippets/2584135

Also, strace reports ENOSYS for MADV_*:
madvise(0x7f2912465000, 4096, MADV_NOHUGEPAGE) =3D -1 ENOSYS (Function not =
implemented)
madvise(0x7f2912000000, 2097152, MADV_HUGEPAGE) =3D -1 ENOSYS (Function not=
 implemented)


>
>
> Regards
> Yin, Fengwei
>
> >
> >
> > Daniel
> >>
> >> User-visible effects is that the THP is skipped when user call madvise=
.
> >> But the correct behavior is THP should be split and processed then.
> >>
> >> NOTE: this change is a temporary fix to reduce the user-visible effect=
s
> >> before the long term fix from David is ready.
> >>
> >> Fixes: 98b211d6415f ("madvise: convert madvise_free_pte_range() to use=
 a folio")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
> >> Reviewed-by: Yu Zhao <yuzhao@google.com>
> >> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> >> ---
> >>  mm/madvise.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/mm/madvise.c b/mm/madvise.c
> >> index 49af35e2d99a..4dded5d27e7e 100644
> >> --- a/mm/madvise.c
> >> +++ b/mm/madvise.c
> >> @@ -683,7 +683,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsi=
gned long addr,
> >>  		if (folio_test_large(folio)) {
> >>  			int err;
> >>
> >> -			if (folio_mapcount(folio) !=3D 1)
> >> +			if (folio_estimated_sharers(folio) !=3D 1)
> >>  				break;
> >>  			if (!folio_trylock(folio))
> >>  				break;
> >> --
> >> 2.39.2
> >>=
