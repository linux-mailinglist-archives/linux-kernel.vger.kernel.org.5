Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3735E79F85F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 04:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbjINCrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 22:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjINCrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 22:47:01 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1122110C3;
        Wed, 13 Sep 2023 19:46:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVgAbuuYbw0R9yh1TuWKlREZ5wCLaLr8hIT4kKXPaGLYS8NHHsgopfYxpqtVNYDwPWrvVZyy9AHu7kJmlxqxsmmT6bLErHxqClcxm5QzPIC8pbHKpThmpRSP4+MwAM9xpZdNQbeGFzPPwrUdArpLw/YLbHoCVzxXOy+VtA0xOQE2c5FjkJ0HT3brndXkWyrgepNO/ytPyxBcsFRlwBb8IpCQhsRinGJ4X3Ex8dTcG1LtfftDHLQQoeXqSPhZmP9d26X6G3iHT2QJDSq8u5nKlgPxVsxseQ+YQMV5viU92HUspYOBYnuJFcusDBjze9PFlmav/n6HiSoraPeXuLAIDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiuXeFuTR+vS0ipB3ihW9ecZ8MD+nVXVhK9+eaMCIeA=;
 b=b70Lh2p1dARY7mnvhZw2vUuwvySvsPujt4STUgG7wqVcqyakWLC3JulHjQwRIisYUZv0savuLW3i/qZdifCLsoCLIphJXFZW2xsP07/MMeE5YpcDpQoQrsVbrtro6MjQlaAYkAeNEI0QsRslSMIf96CtOn6iw2uUqOjPSOrxjnPxoEfu69OyvQHvRey7eLkyrKEthh90zp8OXD6KbVy/qYvCvPBReaEbYRrszS6bpevsEX8wxCgsblUlNOfelG7hB26gMu+cY4dwVCKRvpnYaZFhmOkhWiADIKWFZGiLrw4AVF2Hr0rSoWmK8VScmvbyubA+6uuYS0msdtmbO4YAXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiuXeFuTR+vS0ipB3ihW9ecZ8MD+nVXVhK9+eaMCIeA=;
 b=Yq4oh3tAoOtl8Ujl5U4iodT+fJoDw6F2GeRIC2/jdAAlNNm/L7WGesLVMlbPu2+vDtr1awnfZDomfKrw3uGDEQBF1uirrr0Wgsy8eompM7AaRAxMrqKxSQ9ysd0iwMVVe7EV5+p6R2PGZKna+xltwof35Mg8DBQNKxAQGBT8nUkGHZOvK0He14kbDg9VAM+pOEClc6jZIPKrVhds0FVLTtWhJfOVhc0yXOymczOIOqU5066ZsMTGlsp9H9A3a2fa2d9hK3zPe4G31z8aF7oPwJ3nXT0QLq+bUPNtUbNcGztvhyd3Dw0qVcvJj3Be5UcPSj92QLWdMRuhjavFrnCfGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ2PR12MB8718.namprd12.prod.outlook.com (2603:10b6:a03:540::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.30; Thu, 14 Sep 2023 02:46:54 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6745.020; Thu, 14 Sep 2023
 02:46:54 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Cc:     Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        "\"Mike Rapoport (IBM)\"" <rppt@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3 5/5] mips: use nth_page() in place of direct struct
 page manipulation.
Date:   Wed, 13 Sep 2023 22:46:50 -0400
X-Mailer: MailMate (1.14r5984)
Message-ID: <F0E56181-587E-4F72-92AA-22031921EC46@nvidia.com>
In-Reply-To: <20230913201248.452081-6-zi.yan@sent.com>
References: <20230913201248.452081-1-zi.yan@sent.com>
 <20230913201248.452081-6-zi.yan@sent.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_F8976C30-D161-45AE-AC3B-7E25CF53FD9F_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: YQZPR01CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::16) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ2PR12MB8718:EE_
X-MS-Office365-Filtering-Correlation-Id: 31c48ad0-1ff7-4c2e-a684-08dbb4ccdb2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +NsWpmMSsqN7qFya5zKpSJ/Lrcm5tCM7KNq/PoqHmIxvWnJiKPun3NdfnvECgvXXms5TdsbuemtUvWeo1zcNspgNck+qmnPrm0+AXdO7dzISb2K7I4enX3VRdxIhSFh5YrQqs8/pZdu/6kyt+Lb88gjLkLySz2gmbFZucun3lIZLL7rQpUC5PML42DY9S/2XRPEnGHiCv20spDmUI+e62+lGNdYuffOY1HNBNTy89OmuvP5hBZFK2qkhtUfbn4kydMbM+jSzaoQjHpA7xKOf5lUtSYOxP7Mm5BvlhTeewt8i9eT5HDtFz65t3apYek8o0wso3B/fqtE/lv4sM+p46KhELBZG+5O9zzaXxwgsQhQiQ/ljKXQGMVtGXnbxHqW6jOfd6Oftuq0ttp6wM9roRSOGF2Mb2Lt889lSKHShOYvPUSPLiiWXo6hsxrylQD/PhItDYz0uqaEly89iBi8EQ9qL8FZVvplRe+K0ISd1RboQ0p8H+cgu1jdp+VZR4j67iC7nQJiXe55eqpODfqvRDQjeoEW59D9FxsSZOVDIWY4/1gbjM7HvmpQ9CptIjdaIBZ9oAHdu+9dB562Y0OdjyrFTp04qIrEKkpaQr6B3SSkHhvVP+bYmg3zh1tgZ6P5B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199024)(186009)(1800799009)(6666004)(6506007)(53546011)(8676002)(6486002)(36756003)(26005)(33656002)(38100700002)(86362001)(83380400001)(235185007)(2906002)(66556008)(6512007)(478600001)(66946007)(5660300002)(8936002)(4326008)(66476007)(316002)(2616005)(41300700001)(54906003)(7416002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XOW8u2aAwhfNjyKf38zMFiBTr5cRVs0bZJ0zSzEC66UtPDndvB3K+sqyEUZa?=
 =?us-ascii?Q?nOC9tsqyTncdQ9ofXNv/xd25Zcy4cDgFgc8bIw3SC7QGS5K41pzgYmoop4XM?=
 =?us-ascii?Q?IZ5RbVbOQARn4atPowmfXhQ14D+/TTdNGOjmtkYe41HHCQbZjX+nrcYTDHkD?=
 =?us-ascii?Q?BQKJr6rLFLKefb6uRbrAyJU6KdRv/DdMk3fdT64X4YCcj51LPMmV8TOE5bjU?=
 =?us-ascii?Q?jidFPav/rDvJVjZ+0JTkKccDUPwR6SoZkucLMi4uQ8QCznjDQYo5/uqtV9Ll?=
 =?us-ascii?Q?fz5wGWWC3D7DoO59Ojtt1kxyw89m00JFvz7e8YN5i/ypoFcSWN+NQCS4a155?=
 =?us-ascii?Q?RswMRxNaKrldPRlOgyKVcGheFl9wP0+OLjIEWadT5i8kfCExIVhVp4vYmbkN?=
 =?us-ascii?Q?l4yGi5GfRPEzymn/IB/bqbGcEOIQpardGuV3W3PCIzzTozD/clcFHmluemE2?=
 =?us-ascii?Q?SVR2EMPyep8ekH1d0H4UAuY+zfX6bRBMvMIcdijn8d56NGutxOT8urlxTIKK?=
 =?us-ascii?Q?pQgn1m2yWtASFeaT9MEuW6v8P3j8rQCyckPkDQBlciPkAnQga5kCs12ZIuRv?=
 =?us-ascii?Q?W3pwBR1qt8252ZcXZQ03QV1nlWYEDwJbAz7oiP6+t7ka21VVSf/bs3YqAcx/?=
 =?us-ascii?Q?wJGqmNdTYf1hrQUPzz6fxUOpuWkYuw5b3F2DMGCeppBEoBiLgk7XMVG8HNZI?=
 =?us-ascii?Q?ocx1i7Mjge3CWWVPQiF0M/yEJOmhcau3KROXWyDcHjhKmk876OTY36GAOkKz?=
 =?us-ascii?Q?jxfmnsZVTVSvpg4RnfnzAEq8AKUEQbtbOJMWsbJQnU9ZmKmO1yVRhEMRGfOe?=
 =?us-ascii?Q?04W7T/Bkj9BkwLPWZ2IT617kZNpSgYqt4Ht5k9/734Vr5aET9xhi0pFgVBAL?=
 =?us-ascii?Q?mQjYZOcYb0BtE4tr+JPmlhrQ/XlfFoTvIB3H+YyuRL4nIENW5a/GLOblYX9s?=
 =?us-ascii?Q?uazJ/XBuoG7ldCGKAsXks5EnWvbPJ/rw0NqFs4zVMMWlM4vsTHj0xj7qRQkb?=
 =?us-ascii?Q?RcgQ6XenCa1F1ML3I3C8z6xcOy32F3+MinGEhWRkTq3VjLewX1PzcM9amF/O?=
 =?us-ascii?Q?Udr+DiuZeJBz3onFP9i2f/SU3zy8kC2u3m7vC0Yy79t/+d/Jjc5MJ/0Vukkx?=
 =?us-ascii?Q?BwjBJiDtvFemWthizUnXL174dq81P+tu68MqVKVKCYnqx1Ph+5l99UAFaFv0?=
 =?us-ascii?Q?rNsoMzKCprIt5OYAPd5fEuY6/2OS++H8LJ4Do8QsJUv6hMzt/dTkg7c2E44e?=
 =?us-ascii?Q?It8vyaOesyRskB4vtoofLC84Za3UvWt970mQyt8LnZVktuqt4GtBl+VGWD8y?=
 =?us-ascii?Q?cbl3/BYZ8eRLjIuV15GzOiK3KIyYHDIs0iqADhH80RAcUO27XXtMI0qG3V1i?=
 =?us-ascii?Q?lXvVhVbIm+pVaZSzhxwji/oU06a5GbCduYcv0vqvDrBvq2OFPk7H+L44Ovxl?=
 =?us-ascii?Q?gz2CV7BAM3wcUxY8sBOyz17rfK3fSop9tmIR1rjMGhbpacI/RzcQRJodt8tb?=
 =?us-ascii?Q?JZ5fDKRH5NH/R/vpH1YboNPgld6LYkvkzIufQ2u0VptILmrSUL0av2fCzz0I?=
 =?us-ascii?Q?rOZBphV1dmrvYy0i5ydElzDzj1ITcODLKWGOEuhz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c48ad0-1ff7-4c2e-a684-08dbb4ccdb2d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:46:54.7543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2TvaYBEPwr6Lm+x2ycO9MIE0bUSo4BmLBls+9+zHHHjTDRQxv3HgdkQ0XOUL0gh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8718
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_F8976C30-D161-45AE-AC3B-7E25CF53FD9F_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 13 Sep 2023, at 16:12, Zi Yan wrote:

> From: Zi Yan <ziy@nvidia.com>
>
> __flush_dcache_pages() is called during hugetlb migration via
> migrate_pages() -> migrate_hugetlbs() -> unmap_and_move_huge_page()
> -> move_to_new_folio() -> flush_dcache_folio(). And with hugetlb and
> without sparsemem vmemmap, struct page is not guaranteed to be contiguo=
us
> beyond a section. Use nth_page() instead.
>
> Fixes: 15fa3e8e3269 ("mips: implement the new page table range API")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  arch/mips/mm/cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
> index 02042100e267..7f830634dbe7 100644
> --- a/arch/mips/mm/cache.c
> +++ b/arch/mips/mm/cache.c
> @@ -117,7 +117,7 @@ void __flush_dcache_pages(struct page *page, unsign=
ed int nr)
>  	 * get faulted into the tlb (and thus flushed) anyways.
>  	 */
>  	for (i =3D 0; i < nr; i++) {
> -		addr =3D (unsigned long)kmap_local_page(page + i);
> +		addr =3D (unsigned long)kmap_local_page(nth_page(page, i));
>  		flush_data_cache_page(addr);
>  		kunmap_local((void *)addr);
>  	}
> -- =

> 2.40.1

Without the fix, a wrong address might be used for data cache page flush.=

No bug is reported. The fix comes from code inspection.


--
Best Regards,
Yan, Zi

--=_MailMate_F8976C30-D161-45AE-AC3B-7E25CF53FD9F_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUCdBsPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUzGMQAJd1Q3KNwBMqvmm3vGIN/FxECqe3HXjJkv+q
RAQ9DAphpGKBvzx320t1NHRK87iiLw4gXliSAOiBXyo1oK2rBp/EQaWexd3uJkRs
tNHZyk9qJetZ/Wo+NjRhVuZKPst6AwjZkD0JsMKbr6IsPTSnJs/7gyG+QFNEb+Aj
87zsVgNPDvAPQ5UtP0Dngm/QmiACMQqbySh3Simo/px9AuC8nMVae0aAoaf5HnK1
mN6TJ1ADjmt1m6WxCIck/x7b+OWAihIJKnuYd30mdKdpCX1l5QvTfQIx0S6eUCLp
gXEWsSJmBhPruiP9vTxE75yOFaOyESbhcAoUJlPj9/V/bAYDgMkz6VG3Vh3ZASuW
hR4ynLcP/CgYR7+hz5gxvoURHeuFoa0d3s9Ztvq7ky2n0MO0xTfTMgFf9azSFjdM
r6PskMlS7ZHJfEgr+mDeZcrRUWGwD0ZMIloujYuSZWsfHjRrsrOMpTBdu5bbcBD6
MdAWUaCh1GFDzYooGDzIErhtg+M69aCjgYPo7v1eNJtEqvPBQ8DjEi+Ws1LeRR9t
WRh6waktdMQ079oCShpI9BrWX25O5RNqCMgMr4RbNg3cJfDAKvBa+qxufccZl5Wd
YlIZpNiXz0pF9f42qntVAvK/aWy9YzqTCE+e+07NDImO6AKTkqARrjE2XoN42q09
4gKRw9x/
=rg58
-----END PGP SIGNATURE-----

--=_MailMate_F8976C30-D161-45AE-AC3B-7E25CF53FD9F_=--
