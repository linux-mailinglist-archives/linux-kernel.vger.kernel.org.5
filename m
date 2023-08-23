Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B06785649
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbjHWKyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjHWKyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:54:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162D719A;
        Wed, 23 Aug 2023 03:54:17 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NAnB9r030951;
        Wed, 23 Aug 2023 10:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=3eNJ1F1ZIh5qb5ABj3u6R40fpkitePvKxhd0FlU+G8s=;
 b=VKt8IydGFnohWH59XRysxy6TXiX7WNJup4ggmXgZsJgtwJ0A17CkWAmXdihvozm7b8b7
 RpfJB/mi8aDIlezw6SNvhk9occtvjPu8efnV7vSE/pWXbGTLRKpVvrsHx6qd7CneFaoy
 i7RUQlIHzHGCSFEhkbo99IHpGeRRV4LHo7w0KNQyKD8D6uvtr5WBHoitFTotQ69fhAdn
 wUu2uKRyEo30lmgj58dFk9lTzaGFc1sPjA+XFMEhviWb6/bloLfVQUKmIC2d+t2OLwQ3
 SkuttcS/e3Or3U9TfQrcjQfiqMZW2oy37iHOUaLQULIq0b1UMVu2gN3yFnI+GqrIEqER hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sngpfr1qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 10:53:11 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37NAnGSX031081;
        Wed, 23 Aug 2023 10:53:10 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sngpfr1pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 10:53:10 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37N9Ujs5020144;
        Wed, 23 Aug 2023 10:53:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sn22adnqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 10:53:08 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37NAr6TJ45089220
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Aug 2023 10:53:06 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1494B2004D;
        Wed, 23 Aug 2023 10:53:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B274420040;
        Wed, 23 Aug 2023 10:53:03 +0000 (GMT)
Received: from [9.171.92.225] (unknown [9.171.92.225])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 23 Aug 2023 10:53:03 +0000 (GMT)
Message-ID: <67ec0e36908b7e6d7a6eba642ec76ef87d0d4945.camel@linux.ibm.com>
Subject: Re: [PATCH v11 4/6] iommu/s390: Force ISM devices to use
 IOMMU_DOMAIN_DMA
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Gerd Bayer <gbayer@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-doc@vger.kernel.org
Date:   Wed, 23 Aug 2023 12:53:03 +0200
In-Reply-To: <ba1e0b29-52e0-2fc0-2eb9-475735febacf@arm.com>
References: <20230717-dma_iommu-v11-0-a7a0b83c355c@linux.ibm.com>
         <20230717-dma_iommu-v11-4-a7a0b83c355c@linux.ibm.com>
         <ba1e0b29-52e0-2fc0-2eb9-475735febacf@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Dn5I7UigftX5RBKQwAj9CDPxUIpK94FJ
X-Proofpoint-GUID: X6PgzynOD1cJFA8yBLSkFvc2jrgZNG5R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_06,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308230096
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-08-18 at 20:10 +0100, Robin Murphy wrote:
> On 2023-07-17 12:00, Niklas Schnelle wrote:
> > ISM devices are virtual PCI devices used for cross-LPAR communication.
> > Unlike real PCI devices ISM devices do not use the hardware IOMMU but
> > inspects IOMMU translation tables directly on IOTLB flush (s390 RPCIT
> > instruction).
> >=20
> > While ISM devices keep their DMA allocations static and only very rarel=
y
> > DMA unmap at all, For each IOTLB flush that occurs after unmap the ISM
> > devices will inspect the area of the IOVA space indicated by the flush.
> > This means that for the global IOTLB flushes used by the flush queue
> > mechanism the entire IOVA space would be inspected. In principle this
> > would be fine, albeit potentially unnecessarily slow, it turns out
> > however that ISM devices are sensitive to seeing IOVA addresses that ar=
e
> > currently in use in the IOVA range being flushed. Seeing such in-use
> > IOVA addresses will cause the ISM device to enter an error state and
> > become unusable.
> >=20
> > Fix this by forcing IOMMU_DOMAIN_DMA to be used for ISM devices. This
> > makes sure IOTLB flushes only cover IOVAs that have been unmapped and
> > also restricts the range of the IOTLB flush potentially reducing latenc=
y
> > spikes.
>=20
> Would it not be simpler to return false for IOMMU_CAP_DEFERRED_FLUSH for=
=20
> these devices?
>=20
> Cheers,
> Robin.

Nice idea thank you. This is indeed less code, basically just return
zdev->pft !=3D PCI_FUNC_TYPE_ISM for the IOMMU_CAP_DEFERRED_FLUSH check.
I think it's also semantically more clear in that we don't really care
about the domain type but about not getting deferred flushes.

Thanks,
Niklas

>=20
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> >   drivers/iommu/s390-iommu.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> >=20
> > diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> > index f6d6c60e5634..020cc538e4c4 100644
> > --- a/drivers/iommu/s390-iommu.c
> > +++ b/drivers/iommu/s390-iommu.c
> > @@ -710,6 +710,15 @@ struct zpci_iommu_ctrs *zpci_get_iommu_ctrs(struct=
 zpci_dev *zdev)
> >   	return &zdev->s390_domain->ctrs;
> >   }
> >  =20
> > +static int s390_iommu_def_domain_type(struct device *dev)
> > +{
> > +	struct zpci_dev *zdev =3D to_zpci_dev(dev);
> > +
> > +	if (zdev->pft =3D=3D PCI_FUNC_TYPE_ISM)
> > +		return IOMMU_DOMAIN_DMA;
> > +	return 0;
> > +}
> > +
> >   int zpci_init_iommu(struct zpci_dev *zdev)
> >   {
> >   	u64 aperture_size;
> > @@ -789,6 +798,7 @@ static const struct iommu_ops s390_iommu_ops =3D {
> >   	.probe_device =3D s390_iommu_probe_device,
> >   	.probe_finalize =3D s390_iommu_probe_finalize,
> >   	.release_device =3D s390_iommu_release_device,
> > +	.def_domain_type =3D s390_iommu_def_domain_type,
> >   	.device_group =3D generic_device_group,
> >   	.pgsize_bitmap =3D SZ_4K,
> >   	.get_resv_regions =3D s390_iommu_get_resv_regions,
> >=20
>=20

