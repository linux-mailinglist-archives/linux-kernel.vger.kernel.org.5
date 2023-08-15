Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E89677CD53
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 15:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbjHONZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 09:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237000AbjHONZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 09:25:18 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F3F113
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 06:25:15 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230815132510euoutp015d407a0bdc07f1fffcaa193e81f02057~7kVxJKwwS0797107971euoutp01V
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:25:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230815132510euoutp015d407a0bdc07f1fffcaa193e81f02057~7kVxJKwwS0797107971euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1692105910;
        bh=d8l753efnHFTV7EKKVv8trTsaJ91PH/bbkhwhsNjBM4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gGRRDQrssLdyNWMDZBAbrfHIQcx+E+UvFA02JEzHoZRzb6CeVxYDjg4M/yeTGTTdw
         qR4xBLHDof/ZNFOrr9NwzRJyaVio9PYH2QdXBIxSODe5Hcl2UUNx5NytFvow6ILW87
         SREvgN9w3QbMJ3yhn5po0vg9MOi3Kt5Yfc2sCE0Y=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230815132510eucas1p11bbc3c0b3689581e1ffcdb420b8bb6c8~7kVwwljZ40871008710eucas1p1R;
        Tue, 15 Aug 2023 13:25:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 21.99.37758.6BC7BD46; Tue, 15
        Aug 2023 14:25:10 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230815132509eucas1p1b34b2852a9c4efe743c8da82867c4cc3~7kVwbusDK1407214072eucas1p1K;
        Tue, 15 Aug 2023 13:25:09 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230815132509eusmtrp234bf6a8e37c103d489f2f9ac1f412e4a~7kVwa4PDS0071200712eusmtrp2a;
        Tue, 15 Aug 2023 13:25:09 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-0a-64db7cb6cd80
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D7.11.10549.5BC7BD46; Tue, 15
        Aug 2023 14:25:09 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230815132509eusmtip24868c4ae441fdf3ea34516c19dc2fe50~7kVwOtUgX3081330813eusmtip2y;
        Tue, 15 Aug 2023 13:25:09 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Tue, 15 Aug 2023 14:25:09 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Tue, 15 Aug
        2023 14:25:09 +0100
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
Thread-Index: AQHZz3vpurV86lSwc0Wr64w4rsIXvQ==
Date:   Tue, 15 Aug 2023 13:25:08 +0000
Message-ID: <4jvrmdpyteny5vaqmcrctzrovap2oy2zuukybbhfqyqbbb5xmy@ufgxufss2ngw>
In-Reply-To: <20230808020917.2230692-4-fengwei.yin@intel.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [106.210.248.44]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8D6195D8B82818448CD9589042C93871@scsc.local>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7djPc7rbam6nGLR/ZbGYs34Nm8XX9b+Y
        La6cfsNkcXnXHDaLe2v+s1os+/qe3aJn91RGiwUnFgOJjY8YLdbvu8Fq0fj5PqPF7x9Ade8m
        fGF14PVYM28No8fOWXfZPRZsKvVoOfKW1WPzCi2PxXteMnlsWtXJ5rHp0yR2jxMzfrN4vN93
        lc3j8ya5AO4oLpuU1JzMstQifbsErowT1zazFdyRqFj88zRrA+Nn4S5GTg4JAROJ1n0tjF2M
        XBxCAisYJe6c2M4M4XxhlNi5tYEJpEpI4DOjxJedpjAdq/Y/ZYMoWs4o8WDLK6h2oKITa2Ay
        Zxgl9p9YwQbRvpJR4vgSQRCbTUBTYt/JTewgRSICzawSB6Z/YAFJCAtUSazYdhBoFAdQolri
        6rZqkLCIgJ7Ep49XWEFsFgFViVkdp9hBbF4BX4ltq/sZQWxOAVuJX5t6mUFsRgFZiUcrf4HV
        MAuIS9x6Mp8J4mxBiUWz9zBD2GIS/3Y9ZIOwdSTOXn/CCGEbSGxduo8FwlaSuPlmO9QcHYkF
        uz+xQdiWEvua37JA2NoSyxa+Zoa4R1Di5MwnLCB/SQjM5ZJYt/8t1GIXiTUnjrBD2MISr45v
        gbJlJP7vnM80gVF7FpJbZyHZNwvJvllI9s1Csm8BI+sqRvHU0uLc9NRi47zUcr3ixNzi0rx0
        veT83E2MwLR4+t/xrzsYV7z6qHeIkYmD8RCjBAezkghvD++tFCHelMTKqtSi/Pii0pzU4kOM
        0hwsSuK82rYnk4UE0hNLUrNTUwtSi2CyTBycUg1MnDeXvf8Toj1RpVaRT/CtYl1+6+GWBsvg
        KWkGGjqzfihP7F56e2HvTnZ2eUX74yeE6r+xf8zXay7s23/6dcaVlspZgg96g5+ZnTdfeCqt
        bt/kvU9//uGIYpWKub45PNPjV1hk6cUoxsR9aXIbxHkTcu69bZO90ru4Wirv3ov8H2Y77z9N
        mh6+8lNR3gxpR6d/8aYv3jZ1Zzl/+D619OFK+8mpqpomJXULHkwLqLLqq/0st3dNq3pVjP5E
        rivXZyza3ai6+Ohd7w9//iivd1/5Sv7WnUyVAuGd9xKXrfVt729/kGz1KOX4Wxa1y9YirHNk
        /hR/mVT24LeHd5vcKa3KZ93GO4/5T46+8ihXcgazEktxRqKhFnNRcSIAVywsdfoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsVy+t/xe7pba26nGHyfqWUxZ/0aNouv638x
        W1w5/YbJ4vKuOWwW99b8Z7VY9vU9u0XP7qmMFgtOLAYSGx8xWqzfd4PVovHzfUaL3z+A6t5N
        +MLqwOuxZt4aRo+ds+6yeyzYVOrRcuQtq8fmFVoei/e8ZPLYtKqTzWPTp0nsHidm/GbxeL/v
        KpvH501yAdxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF
        +nYJehknrm1mK7gjUbH452nWBsbPwl2MnBwSAiYSq/Y/Zeti5OIQEljKKHHl7UtGiISMxMYv
        V1khbGGJP9e6oIo+MkqcfLiIHcI5wyhx4ckdVghnJaNEy6aPTCAtbAKaEvtObgKrEhFoZpU4
        MP0DC0hCWKBKYsW2g2A7RASqJe4fP8ECYetJfPp4BWwfi4CqxKyOU+wgNq+Ar8S21f1g9UIC
        +RL9l9rB6jkFbCV+beplBrEZBWQlHq38BVbPLCAucevJfCaIuwUkluw5zwxhi0q8fPwP6h8d
        ibPXn0D9aSCxdek+FghbSeLmm+1Qc3QkFuz+xAZhW0rsa37LAmFrSyxb+JoZ4jZBiZMzn7BM
        YJSehWT1LCTts5C0z0LSPgtJ+wJG1lWMIqmlxbnpucWGesWJucWleel6yfm5mxiB6W3bsZ+b
        dzDOe/VR7xAjEwfjIUYJDmYlEd4e3lspQrwpiZVVqUX58UWlOanFhxhNgWE3kVlKNDkfmGDz
        SuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNLUrNTUwtSi2D6mDg4pRqY9iblxMxadq1BM8yC
        Na7cWcVwgk/U+cfG7nF1H45n3XrLl7Gj2Ji7NeQJu2xWrf3KsjVcvZdMZY2aJyY2//t7Umz6
        oX1n1iv7h0fJ1e2989Fq51oRgYvWyoePzFPzPON7Pkh8W7hHUrrg4TVdecFGV8X8Ct2+rvTs
        K8zeus3+WOHvZwwLH4pZHpqx9W2aEa/BHvsNnw7/ZugNYEx+5fHu/wXDt1Gp0tcmcU2vPvft
        nwXbxeqe8xstZx1JmvGAO/IJ14SZLVFiyvdXH914L0M54dTdnvf2K5Ze5xK4n7NxS5RJtE+k
        1kKZVSrxK9sPbdb1TYut5m5Jdjupf+nqlVUmb5vPfb4b++pb0C+b+1n8SizFGYmGWsxFxYkA
        Fe5IVfgDAAA=
X-CMS-MailID: 20230815132509eucas1p1b34b2852a9c4efe743c8da82867c4cc3
X-Msg-Generator: CA
X-RootMTR: 20230815132509eucas1p1b34b2852a9c4efe743c8da82867c4cc3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230815132509eucas1p1b34b2852a9c4efe743c8da82867c4cc3
References: <20230808020917.2230692-1-fengwei.yin@intel.com>
        <20230808020917.2230692-4-fengwei.yin@intel.com>
        <CGME20230815132509eucas1p1b34b2852a9c4efe743c8da82867c4cc3@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yin,
On Tue, Aug 08, 2023 at 10:09:17AM +0800, Yin Fengwei wrote:
> Commit 98b211d6415f ("madvise: convert madvise_free_pte_range() to use a
> folio") replaced the page_mapcount() with folio_mapcount() to check
> whether the folio is shared by other mapping.
>
> It's not correct for large folios. folio_mapcount() returns the total
> mapcount of large folio which is not suitable to detect whether the folio
> is shared.
>
> Use folio_estimated_sharers() which returns a estimated number of shares.
> That means it's not 100% correct. It should be OK for madvise case here.

I'm trying to understand why it should be ok for madvise this change, so
I hope it's okay to ask you few questions.

folio_mapcount() calculates the total maps for all the subpages of a
folio. However, the folio_estimated_sharers does it only for the first
subpage making it not true for large folios. Then, wouldn't this change
drop support for large folios?

Seems like folio_entire_mapcount() is not accurate either because of it
does not inclue PTE-mapped sub-pages which I think we need here. Hence,
the folio_mapcount(). Could this be something missing in the test side?

I tried to replicate the setup with CONFIG_TRANSPARENT_HUGEPAGE but
seems like I'm not able to do it:

./cow
# [INFO] detected THP size: 2048 KiB
# [INFO] detected hugetlb size: 2048 KiB
# [INFO] detected hugetlb size: 1048576 KiB
# [INFO] huge zeropage is enabled
TAP version 13
1..166
# [INFO] Anonymous memory tests in private mappings
# [RUN] Basic COW after fork() ... with base page
not ok 1 MADV_NOHUGEPAGE failed
# [RUN] Basic COW after fork() ... with swapped out base page
not ok 2 MADV_NOHUGEPAGE failed
# [RUN] Basic COW after fork() ... with THP
not ok 3 MADV_HUGEPAGE failed
# [RUN] Basic COW after fork() ... with swapped-out THP
not ok 4 MADV_HUGEPAGE failed
# [RUN] Basic COW after fork() ... with PTE-mapped THP
not ok 5 MADV_HUGEPAGE failed
# [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
not ok 6 MADV_HUGEPAGE failed
...


Daniel
>
> User-visible effects is that the THP is skipped when user call madvise.
> But the correct behavior is THP should be split and processed then.
>
> NOTE: this change is a temporary fix to reduce the user-visible effects
> before the long term fix from David is ready.
>
> Fixes: 98b211d6415f ("madvise: convert madvise_free_pte_range() to use a =
folio")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
> Reviewed-by: Yu Zhao <yuzhao@google.com>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  mm/madvise.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 49af35e2d99a..4dded5d27e7e 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -683,7 +683,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigne=
d long addr,
>  		if (folio_test_large(folio)) {
>  			int err;
>
> -			if (folio_mapcount(folio) !=3D 1)
> +			if (folio_estimated_sharers(folio) !=3D 1)
>  				break;
>  			if (!folio_trylock(folio))
>  				break;
> --
> 2.39.2
>=
