Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0877FAC44
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 22:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbjK0VIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 16:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjK0VIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 16:08:09 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FDE191;
        Mon, 27 Nov 2023 13:08:16 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARKAmpx001569;
        Mon, 27 Nov 2023 21:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=4LopCIk+VbSRPrGHln6ohxeSl7MfENo2tZiIppXReWQ=;
 b=cbR2bmBgmZTnms5y3cdrfMs2wWuK2efgBrf3dZN/JSn08sEjrK9bzdoVmuQ1g6ksgkf6
 mxl/ifeSOPqfZe7LOO152c7A0wVHNiwKBG/YPZrozyxHwrTf9IAtCI0h2TvKnxoAcg0a
 i8zLvKMZ0DZGHEKIITmUHcPBXlr2UrvfGNDssx4FbSbYVlvz+8eq3lPPdYDt2nLv45wV
 OGLMmWmcZ8yZ9x6azZiC97YnjI7cRIWLsJdjM5Wpvs3ej37DYpnRaB5cUdWAnUwI/NAw
 QTWOnsUQNQzxNO98hetfK5b7tPqAd8HTjqwbgqseAuDt4qCVkc+G2t0tf43XQpR1g314 qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3un0mdkgm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 21:08:11 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ARKBNTe004677;
        Mon, 27 Nov 2023 21:08:11 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3un0mdkgke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 21:08:11 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARJWQiN009176;
        Mon, 27 Nov 2023 21:08:09 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukumybjd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 21:08:09 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ARL89qI17892090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Nov 2023 21:08:09 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7A1F5805D;
        Mon, 27 Nov 2023 21:08:08 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2413058052;
        Mon, 27 Nov 2023 21:08:08 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 27 Nov 2023 21:08:08 +0000 (GMT)
Message-ID: <a9d5b31d-2d89-4787-959e-2df2c059db9b@linux.ibm.com>
Date:   Mon, 27 Nov 2023 16:08:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/8] tpm: TPM2B formatted buffers
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
 <20231124020237.27116-7-jarkko@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231124020237.27116-7-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xOHUTHP6x6ahT23qLkSvmsjkl4sx1t1n
X-Proofpoint-GUID: XU5Okn9GBCsD6m9LPskvoqo-KqBsw7_M
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_19,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270147
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
> Declare tpm_buf_init_sized() and tpm_buf_reset_sized() for creating TPM2B
> formatted buffers. These buffers are also known as sized buffers in the
> specifications and literature.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
> v2: [2021-11-21] Refine the API according to the comments for
>      https://lore.kernel.org/linux-integrity/20231024011531.442587-5-jarkko@kernel.org/
> ---
>   drivers/char/tpm/tpm-buf.c | 38 +++++++++++++++++++++++++++++++++++---
>   include/linux/tpm.h        |  4 ++++
>   2 files changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> index 3f39893f3bb1..099b4a56c5d5 100644
> --- a/drivers/char/tpm/tpm-buf.c
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -47,6 +47,36 @@ void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
>   }
>   EXPORT_SYMBOL_GPL(tpm_buf_reset);
>   
> +/**
> + * tpm_buf_init_sized() - Allocate and initialize a sized (TPM2B) buffer
> + * @buf:	A @tpm_buf
> + *
> + * Return: 0 or -ENOMEM
> + */
> +int tpm_buf_init_sized(struct tpm_buf *buf)
> +{
> +	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
> +	if (!buf->data)
> +		return -ENOMEM;
> +
> +	tpm_buf_reset_sized(buf);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_init_sized);
> +
> +/**
> + * tpm_buf_reset_sized() - Initialize a sized buffer
> + * @buf:	A &tpm_buf
> + */
> +void tpm_buf_reset_sized(struct tpm_buf *buf)
> +{
> +	buf->flags = TPM_BUF_TPM2B;
> +	buf->length = 2;
> +	buf->data[0] = 0;
> +	buf->data[1] = 0;
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_reset_sized);
> +
>   void tpm_buf_destroy(struct tpm_buf *buf)
>   {
>   	free_page((unsigned long)buf->data);
> @@ -72,8 +102,6 @@ EXPORT_SYMBOL_GPL(tpm_buf_length);
>    */
>   void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length)
>   {
> -	struct tpm_header *head = (struct tpm_header *)buf->data;
> -
>   	/* Return silently if overflow has already happened. */
>   	if (buf->flags & TPM_BUF_OVERFLOW)
>   		return;
> @@ -86,7 +114,11 @@ void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length)
>   
>   	memcpy(&buf->data[buf->length], new_data, new_length);
>   	buf->length += new_length;
> -	head->length = cpu_to_be32(buf->length);
> +
> +	if (buf->flags & TPM_BUF_TPM2B)
> +		((__be16 *)buf->data)[0] = cpu_to_be16(buf->length - 2);
> +	else
> +		((struct tpm_header *)buf->data)->length = cpu_to_be32(buf->length);
>   }
>   EXPORT_SYMBOL_GPL(tpm_buf_append);
>   
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 1d7b39b5c383..715db4a91c1f 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -300,6 +300,8 @@ struct tpm_header {
>   enum tpm_buf_flags {
>   	/* the capacity exceeded: */
>   	TPM_BUF_OVERFLOW	= BIT(0),
> +	/* TPM2B format: */
> +	TPM_BUF_TPM2B		= BIT(1),
>   };
>   
>   /*
> @@ -328,6 +330,8 @@ struct tpm2_hash {
>   
>   int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal);
>   void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal);
> +int tpm_buf_init_sized(struct tpm_buf *buf);
> +void tpm_buf_reset_sized(struct tpm_buf *buf);
>   void tpm_buf_destroy(struct tpm_buf *buf);
>   u32 tpm_buf_length(struct tpm_buf *buf);
>   void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length);
