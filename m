Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689287D3C9A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjJWQby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjJWQbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:31:39 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2A210E;
        Mon, 23 Oct 2023 09:31:37 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NGRV07015709;
        Mon, 23 Oct 2023 16:31:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=5zC/P5EPty0Y0r8h3zLsFuH5hC2+OJE4zNLyy2vAfiY=;
 b=pa4NZa4FBmpq+74FigJDuO4sct0Nk44m9gaaYycg1UCsIAJaR2tVSBeq64pI8txz2upN
 fBrzFAfD8bMHXwf0y034F8kk8OwgRzt6nx9M/x99DL2jMA6RYoVPl3rk0B0cSiQhvhH1
 ayIJXxqWB2E9s1APpGcbwdniTHYpublxzijhbGX5lmMKNNuM15ORJepTq4ubs4Fe0FDi
 OKepPmC8ZBLI5Jx6vH0BYRwPlcgdl5QH/C8TaEfZVPbwTH3s2vltkFcuzb/Ucb97rLzh
 H79hPpRWlxh7Ic7Bsp8unp+mdyH7C6z/Xy/bG6yOnoH/Wc+Ffn1cNn6vRmO+O52jcX8q Qw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3twvc4r42p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 16:31:35 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39NGU9q5026870;
        Mon, 23 Oct 2023 16:31:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tvsynhqjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 16:31:34 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39NGVVZB16253628
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Oct 2023 16:31:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E32D2007A;
        Mon, 23 Oct 2023 16:31:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3FA820071;
        Mon, 23 Oct 2023 16:31:30 +0000 (GMT)
Received: from [9.179.15.215] (unknown [9.179.15.215])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 23 Oct 2023 16:31:30 +0000 (GMT)
Message-ID: <711135296d62cfa0d5dee744a0de86141d57cd6d.camel@linux.ibm.com>
Subject: Re: [PATCH] s390/pci: remove custom and misleading bitmap_vzalloc
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Vasily Gorbik <gor@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Date:   Mon, 23 Oct 2023 18:31:30 +0200
In-Reply-To: <your-ad-here.call-01698077514-ext-9164@work.hours>
References: <your-ad-here.call-01697881440-ext-2458@work.hours>
         <CAHk-=wgTUz1bdY6zvsN4ED0arCLE8Sb==1GH8d0sjm5bu7zesQ@mail.gmail.com>
         <your-ad-here.call-01698077344-ext-9104@work.hours>
         <your-ad-here.call-01698077514-ext-9164@work.hours>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tFwXFMBfP2rXid9Rq4h2kAeYjfTKkggv
X-Proofpoint-ORIG-GUID: tFwXFMBfP2rXid9Rq4h2kAeYjfTKkggv
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_15,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230144
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-23 at 18:11 +0200, Vasily Gorbik wrote:
> This commit effectively reverts commit c1ae1c59c8c6 ("s390/pci: fix
> iommu bitmap allocation") and applies a simpler fix instead. Commit
> c1ae1c59c8c6 introduced a custom bitmap_vzalloc() function that included
> unnecessary and misleading overflow handling.
>=20
> This fix is only relevant for the current v6.6 and stable backports. It
> will be superseded by the upcoming conversion to use the common
> code DMA API on s390 (pending in linux-next [2]), which eliminates
> arch/s390/pci/pci_dma.c entirely and, therefore, addresses the original
> problem in another way.
>=20
> Instead of relying on a custom bitmap_vzalloc() function, this change goes
> back to straightforward allocation using vzalloc() with the appropriate
> size calculated using the BITS_TO_LONGS() macro.
>=20
> Link: https://lore.kernel.org/all/CAHk-=3DwgTUz1bdY6zvsN4ED0arCLE8Sb=3D=
=3D1GH8d0sjm5bu7zesQ@mail.gmail.com/
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git=
/commit/?h=3Dnext-20231020&id=3Dc76c067e488c
> Cc: stable@vger.kernel.org
> Fixes: c1ae1c59c8c6 ("s390/pci: fix iommu bitmap allocation")
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> ---
>  arch/s390/pci/pci_dma.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
>=20
> diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
> index 99209085c75b..1b4b123d79aa 100644
> --- a/arch/s390/pci/pci_dma.c
> +++ b/arch/s390/pci/pci_dma.c
> @@ -565,17 +565,6 @@ static void s390_dma_unmap_sg(struct device *dev, st=
ruct scatterlist *sg,
>  	}
>  }
>=20=20
> -static unsigned long *bitmap_vzalloc(size_t bits, gfp_t flags)
> -{
> -	size_t n =3D BITS_TO_LONGS(bits);
> -	size_t bytes;
> -
> -	if (unlikely(check_mul_overflow(n, sizeof(unsigned long), &bytes)))
> -		return NULL;
> -
> -	return vzalloc(bytes);
> -}
> -=09
>  int zpci_dma_init_device(struct zpci_dev *zdev)
>  {
>  	u8 status;
> @@ -615,13 +604,15 @@ int zpci_dma_init_device(struct zpci_dev *zdev)
>  				zdev->end_dma - zdev->start_dma + 1);
>  	zdev->end_dma =3D zdev->start_dma + zdev->iommu_size - 1;
>  	zdev->iommu_pages =3D zdev->iommu_size >> PAGE_SHIFT;
> -	zdev->iommu_bitmap =3D bitmap_vzalloc(zdev->iommu_pages, GFP_KERNEL);
> +	zdev->iommu_bitmap =3D vzalloc(BITS_TO_LONGS(zdev->iommu_pages) *
> +				     sizeof(unsigned long));
>  	if (!zdev->iommu_bitmap) {
>  		rc =3D -ENOMEM;
>  		goto free_dma_table;
>  	}
>  	if (!s390_iommu_strict) {
> -		zdev->lazy_bitmap =3D bitmap_vzalloc(zdev->iommu_pages, GFP_KERNEL);
> +		zdev->lazy_bitmap =3D vzalloc(BITS_TO_LONGS(zdev->iommu_pages) *
> +					    sizeof(unsigned long));
>  		if (!zdev->lazy_bitmap) {
>  			rc =3D -ENOMEM;
>  			goto free_bitmap;

Mea culpa for the useless and misleading overflow check. I'm sorry, I
should not have copied this over from kvmalloc_array() without actually
thinking through whether it makes sense in the new place and you're
right Linus it doesn't.

Thank you Vasily for cleaning this up! Also as an additional point,
note that the size of the bitmap is limited by the above min3() which
in the largest possible case ensures a maximum of 128 MiB bitmaps which
only happens for very large memory systems or if a user sets an
unreasonably large s390_iommu_aperture kernel parameter.

Also:
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>

Best regards,
Niklas
