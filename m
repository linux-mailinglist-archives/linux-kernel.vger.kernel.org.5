Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE40E78C73E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbjH2OTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbjH2OS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:18:57 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD514110
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:18:53 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TEFKWc032735;
        Tue, 29 Aug 2023 14:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=NTFNqU89pPbUUEpiNDjKB1jRT0a8KGm3TKx2+MSzp1g=;
 b=FcsAVPETodblDcAIEX2nAP/q1td8k0rD+9N7EFi4eTZ74oK79a6iR0Rq35kvWC/afPoH
 OFE7wtDGWG7f1Hqg+As/m6uFd+wYWlrM21ymZLGX74mBlOv+b85I0YkI5ke+IFf6DSSK
 a9jNpmrtt4HMnXdQieFU/DjNV+zGQEoEFN26aKVWCi5Uga9pIXgaB0eUB41nPf7Q4cmL
 iVFHvVep0ocjREzqGQMq6yopNR2lIkwGqweH/pZGDIk1097qXI0N5KZ2VlncTnAvPvKv
 UX78CIzPr6ng9lYa+4i+ZOJH3IDrucdgUZ8/uyyp3u9kmfJvRYviCOtfpGIn7b3cBc9D eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ssht2168c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 14:18:43 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37TDgups004033;
        Tue, 29 Aug 2023 14:18:43 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ssht21683-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 14:18:43 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37TD60qZ009907;
        Tue, 29 Aug 2023 14:18:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqw7kbtyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 14:18:42 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37TEIexV262734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 14:18:40 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9009D20043;
        Tue, 29 Aug 2023 14:18:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2254720040;
        Tue, 29 Aug 2023 14:18:40 +0000 (GMT)
Received: from [9.179.1.138] (unknown [9.179.1.138])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 29 Aug 2023 14:18:40 +0000 (GMT)
Message-ID: <4394654c47c4fcc2dc389cd916590bd643d18def.camel@linux.ibm.com>
Subject: Re: [PATCH v2 5/5] mm: Deprecate pasid field
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Tina Zhang <tina.zhang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Tue, 29 Aug 2023 16:18:39 +0200
In-Reply-To: <20230827084401.819852-6-tina.zhang@intel.com>
References: <20230827084401.819852-1-tina.zhang@intel.com>
         <20230827084401.819852-6-tina.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YadWYYEyo8TvladLOPCf3kCtHVszjp9H
X-Proofpoint-GUID: 7s7n6GdozBcB78Fo3PWni1Rj5UsE6bDx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_11,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 mlxlogscore=469 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290121
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-08-27 at 16:44 +0800, Tina Zhang wrote:
> Drop the pasid field, as all the information needed for sva domain
> management has been moved to the newly added iommu_mm field.

I think it should say "Drop" instead of "Deprecate" in the subject line
as well since this is field is completely removed.

>=20
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>  include/linux/mm_types.h | 1 -
>  mm/init-mm.c             | 3 ---
>  2 files changed, 4 deletions(-)
>=20
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 3fd65b7537f0e..6cb5cc53c4803 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -808,7 +808,6 @@ struct mm_struct {
>  		struct work_struct async_put_work;
> =20
>  #ifdef CONFIG_IOMMU_SVA
> -		u32 pasid;
>  		struct iommu_mm_data *iommu_mm;
>  #endif
>  #ifdef CONFIG_KSM
> diff --git a/mm/init-mm.c b/mm/init-mm.c
> index efa97b57acfd8..69719291463ed 100644
> --- a/mm/init-mm.c
> +++ b/mm/init-mm.c
> @@ -42,9 +42,6 @@ struct mm_struct init_mm =3D {
>  #endif
>  	.user_ns	=3D &init_user_ns,
>  	.cpu_bitmap	=3D CPU_BITS_NONE,
> -#ifdef CONFIG_IOMMU_SVA
> -	.pasid		=3D IOMMU_PASID_INVALID,
> -#endif
>  	INIT_MM_CONTEXT(init_mm)
>  };
> =20

