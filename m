Return-Path: <linux-kernel+bounces-4181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D3E8178E7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E00CEB216C1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DEE5D724;
	Mon, 18 Dec 2023 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WVLhvxPC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C5C5A85A;
	Mon, 18 Dec 2023 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BIGvQLA012226;
	Mon, 18 Dec 2023 17:40:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=kGU3Y0ofIoXUefql5OFH7DdlnKdmPymElNGMnFFsIf4=;
 b=WVLhvxPCBl1D39stVR9VfQ9LN0BGZQtQjcOwSOxKNYfmdMtxU4r3imRiwN/ATckl3jIa
 f/xqj/19Z2BueGa1UeYbNLyMCSFWiCOlkmZlMkd2gIOWAbIfD/RX626Wdx5/R726Y443
 GhEUk0adE9Dcxc2LZez6eImTIKOwAFypFbf5PDu/dSYXgBxwP4NKpDK+CHhv9BUj9qQT
 9zN07muU0dUkqpY3DIkoJk0lHek3wSt5RzpjyJ3kuN/UHOoxHb68G1NXnQ9adIrr0e/Q
 q2vW+XIt9i3O0tTGcWIkhsr85cnIzXqMHQSA6qx40KtVXS/49HGzFQuXDLEKeY8LQpme LA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v2t25rywp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 17:40:18 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIHVR0f001741;
	Mon, 18 Dec 2023 17:40:18 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v2t25ryw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 17:40:17 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BIFEF29004797;
	Mon, 18 Dec 2023 17:40:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v1pkyjh38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 17:40:16 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BIHeCoC63898010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 17:40:13 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B950B20043;
	Mon, 18 Dec 2023 17:40:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBEB52004D;
	Mon, 18 Dec 2023 17:40:11 +0000 (GMT)
Received: from [9.171.88.206] (unknown [9.171.88.206])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 Dec 2023 17:40:11 +0000 (GMT)
Message-ID: <c9d908e3-5147-4c54-a2de-ef9254ac5c4f@linux.ibm.com>
Date: Mon, 18 Dec 2023 18:40:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 03/10] net/smc: unify the structs of accept or
 confirm message for v1 and v2
Content-Language: en-US
To: Wen Gu <guwen@linux.alibaba.com>, wenjia@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, raspl@linux.ibm.com, schnelle@linux.ibm.com,
        guangguan.wang@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1702371151-125258-1-git-send-email-guwen@linux.alibaba.com>
 <1702371151-125258-4-git-send-email-guwen@linux.alibaba.com>
 <63aa2995-7980-430d-84be-58ce204f5172@linux.ibm.com>
 <32c7fbda-297b-76a7-9da3-e136b49a63b5@linux.alibaba.com>
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <32c7fbda-297b-76a7-9da3-e136b49a63b5@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Qu_lQrGnQWpKIe0PAEEvEcwaORHJdTzu
X-Proofpoint-GUID: ULhosz6Bol4JSy8P-vLJRZ0yEEnA1v-Q
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_11,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 spamscore=0 impostorscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxlogscore=713 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312180130



On 18.12.23 13:21, Wen Gu wrote:
> The fields in smcr_clc_msg_accept_confirm and smcd_clc_msg_accept_confirm_common
> seem to have not changed since SMCDv1. So I guess there is no v2-only fields
> in this two struct. I tried to confirm this in some documents but didn't find
> the message format for v1.

V1 is documented in
https://datatracker.ietf.org/doc/html/draft-fox-tcpm-shared-memory-rdma-03

> 
> If the smcr_clc_msg_accept_confirm and smcd_clc_msg_accept_confirm_common
> is inherited from v1, should we still put the fields of v2 into these two structures?

You are right, they do not contain v2 fields, I guess I was confused. 

I still think, it would be better for readability and maintainability to avoid
+#define r0	r1._r0
+#define d0	d1._d0

I guess you and previous editors wanted to avoid changing all the instances that use r0 and d0.
But then.. it is a rather simple search/replace..

> 
> If still, I will change these structures as
> 
> diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
> index 614fa2f298f5..18157aeb14ec 100644
> --- a/net/smc/smc_clc.h
> +++ b/net/smc/smc_clc.h
> @@ -201,9 +201,12 @@ struct smcr_clc_msg_accept_confirm {       /* SMCR accept/confirm */
>         __be64 rmb_dma_addr;    /* RMB virtual address */
>         u8 reserved2;
>         u8 psn[3];              /* packet sequence number */
> +       /* v2 only, reserved and ignored in v1: */
> +       u8 eid[SMC_MAX_EID_LEN];
> +       u8 reserved6[8];
>  } __packed;
> 
> -struct smcd_clc_msg_accept_confirm_common {    /* SMCD accept/confirm */
> +struct smcd_clc_msg_accept_confirm {   /* SMCD accept/confirm */
>         __be64 gid;             /* Sender GID */
>         __be64 token;           /* DMB token */
>         u8 dmbe_idx;            /* DMBE index */
> @@ -216,6 +219,10 @@ struct smcd_clc_msg_accept_confirm_common {        /* SMCD accept/confirm */
>  #endif
>         u16 reserved4;
>         __be32 linkid;          /* Link identifier */
> +       /* v2 only, reserved and ignored in v1: */
> +       __be16 chid;
> +       u8 eid[SMC_MAX_EID_LEN];
> +       u8 reserved5[8];
>  } __packed;
> 
>  #define SMC_CLC_OS_ZOS         1
> @@ -259,22 +266,9 @@ struct smc_clc_fce_gid_ext {
>  struct smc_clc_msg_accept_confirm {    /* clc accept / confirm message */
>         struct smc_clc_msg_hdr hdr;
>         union {
> -               struct { /* SMC-R */
> -                       struct smcr_clc_msg_accept_confirm _r0;
> -                       /* v2 only, reserved and ignored in v1: */

^^ Actually these commetns are not fully correct. The fields are not reserved in V1. 
(my bad) The message length is shorter in V1.
So /* v2 only: */ would be more correct.

> -                       u8 eid[SMC_MAX_EID_LEN];
> -                       u8 reserved6[8];
> -               } r1;
> -               struct { /* SMC-D */
> -                       struct smcd_clc_msg_accept_confirm_common _d0;
> -                       /* v2 only, reserved and ignored in v1: */

same here: /* v2 only: */

> -                       __be16 chid;
> -                       u8 eid[SMC_MAX_EID_LEN];
> -                       u8 reserved5[8];
> -               } d1;
> +               struct smcr_clc_msg_accept_confirm r0; /* SMC-R */
> +               struct smcd_clc_msg_accept_confirm d0; /* SMC-D */
>         };
> -#define r0     r1._r0
> -#define d0     d1._d0
>  };
> 
>>
>>>   };

Yes, I like that solution better. 
But I have no strong feelings. At least the duplicate declarations are gone. 
So, if you prefer the #defines , it's ok with me.



>>
>> You have removed the __packed attribute.
>> patch 07/10 adds it back for the SMC-D case, but the SMC-R case needs it as well.
>>
> 
> r1 and d1 in smc_clc_msg_accept_confirm_v2 (smc_clc_msg_accept_confirm now in
> this patch) is aligned well. In patch 07/10 I replaced reserved5[8] with u64 gid_ext,
> thus making a hole before gid_ext, so I added __packed attribute to SMC-D.
> 
> If it is to avoid potential mistakes in future expansion, I can also add __packed to SMC-R.
> 

Yes, __packed is not only about preventing misalignement today.
IMU, without __packed, there is no guarantee that a future compile run will not insert unused bytes.
(highly unlikely, I admit). But __packed makes it visible that this needs to go to hardware in exactly
this layout.


> Thanks.

