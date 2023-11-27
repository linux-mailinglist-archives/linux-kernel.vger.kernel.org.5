Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD18B7FAB9F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbjK0Ud1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjK0Ud0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:33:26 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA47593;
        Mon, 27 Nov 2023 12:33:32 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARJgXKV030196;
        Mon, 27 Nov 2023 20:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Lkh3ZB0fmtu8u/GH3a6JEmF9T4HRnls2lJwdbACwm3Y=;
 b=bXs4CsZ0zaxLPQdnLC/UmozDkO67bfZDxQt+9gwGdxiXOPvN7GyUbDRWvmgKaTgr2aQ3
 zQ9rR45lGVR+pienIPQ++UwKkOIUn1DfHkaP3RskZt9O+nWLLtie+A2feFmS7F+ldwVv
 4fVrSad32GenFdXf+GiLKpC0c0D4BbjQo44zNSRgSa1MQl+5MjeXlB0zxMjeg2++tZl4
 3GaCj7kNjRezC/iged+3sMcOp2Fkwi3Xlhv4+KNJ87+0w9mAqkpS1uzIq83PxZ9ytpO3
 9hUP6oSaaZQp+RE7Ns72y6zXaTvMnMVry8G8eS0GuIGGYjj5IRIhYVBmwoE8K5lBMSnT VA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3un1gesdc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 20:33:28 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ARJgtXA031165;
        Mon, 27 Nov 2023 20:33:28 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3un1gesdat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 20:33:28 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARJchNe018544;
        Mon, 27 Nov 2023 20:33:26 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwfjtttd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 20:33:26 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ARKXP1w24707596
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Nov 2023 20:33:25 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C94B958050;
        Mon, 27 Nov 2023 20:33:25 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2CFF58045;
        Mon, 27 Nov 2023 20:33:24 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 27 Nov 2023 20:33:24 +0000 (GMT)
Message-ID: <94a6c269-7086-4a20-8396-07521cf1c220@linux.ibm.com>
Date:   Mon, 27 Nov 2023 15:33:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/8] tpm: Remove unused tpm_buf_tag()
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        William Roberts <bill.c.roberts@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
References: <20231124020237.27116-1-jarkko@kernel.org>
 <20231124020237.27116-2-jarkko@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231124020237.27116-2-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _B7MXcilXN4EqENafQe1mmccsN1fD6ej
X-Proofpoint-GUID: G__qMkKK_WvxFx9nFrabSns5lrHjioxA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_19,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=714 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270143
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/23/23 21:02, Jarkko Sakkinen wrote:
> The helper function has no call sites. Thus, remove it.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
> v1 [2023-11-21]: A new patch.
> ---
>   include/linux/tpm.h | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 4ee9d13749ad..6588ca87cf93 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -358,13 +358,6 @@ static inline u32 tpm_buf_length(struct tpm_buf *buf)
>   	return be32_to_cpu(head->length);
>   }
>   
> -static inline u16 tpm_buf_tag(struct tpm_buf *buf)
> -{
> -	struct tpm_header *head = (struct tpm_header *)buf->data;
> -
> -	return be16_to_cpu(head->tag);
> -}
> -
>   static inline void tpm_buf_append(struct tpm_buf *buf,
>   				  const unsigned char *new_data,
>   				  unsigned int new_len)
