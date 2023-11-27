Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FA67FABBE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbjK0Ukw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjK0Ukt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:40:49 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A2D91;
        Mon, 27 Nov 2023 12:40:55 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARKB2Gk026433;
        Mon, 27 Nov 2023 20:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4Q2jkPGtatYEjKI9PBL30yWtK7X+NIEHn95uM8k59QE=;
 b=nuSSbuEi++cG+qzyPKn7vWIK6XWexb/MMX3tEWrCOFNuvcSEnPgVVeVT34IJr7Br8pBq
 YUVG1wNJYVJl3P+Ein1uiZm5i5Rv9z4o2eAS6qM8FAwUqjfcsrxpWgzaYuIBDwDRL/oF
 ujlXr+8P236iI4BREcDEPpAQPYzFFMUmHMFM7Fz0q5eQca6KLCBu448XfNhVF9VxKUTY
 1rTHDLm+C1OcEtDpgJ4FqDRrhqqyIDb8H83PedbwO2YXcdVTfK8G/KKvFZp06jS+H+2A
 D0Ld64XQO2VNZ3rFwu5lcfGl5hfFfWUc4c8LDrpeiFfHLSvSPpFbt68Vd8I/G1CzQ3xg Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3un1wv8wsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 20:40:49 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ARKRekW019177;
        Mon, 27 Nov 2023 20:40:49 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3un1wv8wrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 20:40:49 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARJcpL7001736;
        Mon, 27 Nov 2023 20:40:48 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwy1jqmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 20:40:48 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ARKelwx16712262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Nov 2023 20:40:47 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76A115805E;
        Mon, 27 Nov 2023 20:40:47 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 758EE58045;
        Mon, 27 Nov 2023 20:40:46 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 27 Nov 2023 20:40:46 +0000 (GMT)
Message-ID: <00191640-5103-4370-bb6f-ba2f7657a678@linux.ibm.com>
Date:   Mon, 27 Nov 2023 15:40:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/8] tpm: Move buffer handling from static inlines to
 real functions
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
 <20231124020237.27116-4-jarkko@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231124020237.27116-4-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zWqJlT0aUL2fhPaEnIsATFH4i75hO-3K
X-Proofpoint-ORIG-GUID: DKVMytZuc_hIY3vvUD7jUdIZ-Gr9PD4M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_19,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 spamscore=0 mlxlogscore=955 lowpriorityscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270143
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/23/23 21:02, Jarkko Sakkinen wrote:
> From: James Bottomley <James.Bottomley@HansenPartnership.com>
> 
> separate out the tpm_buf_... handling functions from static inlines in
> tpm.h and move them to their own tpm-buf.c file.  This is a precursor
> to adding new functions for other TPM type handling because the amount
> of code will grow from the current 70 lines in tpm.h to about 200
> lines when the additions are done.  200 lines of inline functions is a
> bit too much to keep in a header file.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
> v3: make tpm_buf_tag static
> v4: remove space after spdx tag
> v5: fix checkpatch.pl --strict issues
> ---
>   drivers/char/tpm/Makefile  |  1 +
>   drivers/char/tpm/tpm-buf.c | 87 ++++++++++++++++++++++++++++++++++++++
>   include/linux/tpm.h        | 80 ++++-------------------------------
>   3 files changed, 97 insertions(+), 71 deletions(-)
>   create mode 100644 drivers/char/tpm/tpm-buf.c
> 
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index 0222b1ddb310..ad3594e383e1 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -15,6 +15,7 @@ tpm-y += tpm-sysfs.o
>   tpm-y += eventlog/common.o
>   tpm-y += eventlog/tpm1.o
>   tpm-y += eventlog/tpm2.o
> +tpm-y += tpm-buf.o
>   
>   tpm-$(CONFIG_ACPI) += tpm_ppi.o eventlog/acpi.o
>   tpm-$(CONFIG_EFI) += eventlog/efi.o
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> new file mode 100644
> index 000000000000..96cee41d5b9c
> --- /dev/null
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Handling of TPM command and other buffers.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/tpm.h>
> +
> +int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
> +{
> +	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
> +	if (!buf->data)
> +		return -ENOMEM;
> +
> +	buf->flags = 0;
> +	tpm_buf_reset(buf, tag, ordinal);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_init);
> +
> +void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
> +{
> +	struct tpm_header *head = (struct tpm_header *)buf->data;
> +
> +	head->tag = cpu_to_be16(tag);
> +	head->length = cpu_to_be32(sizeof(*head));
> +	head->ordinal = cpu_to_be32(ordinal);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_reset);
> +
> +void tpm_buf_destroy(struct tpm_buf *buf)
> +{
> +	free_page((unsigned long)buf->data);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_destroy);
> +
> +u32 tpm_buf_length(struct tpm_buf *buf)
> +{
> +	struct tpm_header *head = (struct tpm_header *)buf->data;
> +
> +	return be32_to_cpu(head->length);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_length);
> +
> +void tpm_buf_append(struct tpm_buf *buf,
> +		    const unsigned char *new_data,
> +		    unsigned int new_len)
> +{
> +	struct tpm_header *head = (struct tpm_header *)buf->data;
> +	u32 len = tpm_buf_length(buf);
> +
> +	/* Return silently if overflow has already happened. */
> +	if (buf->flags & TPM_BUF_OVERFLOW)
> +		return;
> +
> +	if ((len + new_len) > PAGE_SIZE) {
> +		WARN(1, "tpm_buf: overflow\n");
> +		buf->flags |= TPM_BUF_OVERFLOW;
> +		return;
> +	}
> +
> +	memcpy(&buf->data[len], new_data, new_len);
> +	head->length = cpu_to_be32(len + new_len);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_append);
> +
> +void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value)
> +{
> +	tpm_buf_append(buf, &value, 1);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_append_u8);
> +
> +void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value)
> +{
> +	__be16 value2 = cpu_to_be16(value);
> +
> +	tpm_buf_append(buf, (u8 *)&value2, 2);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_append_u16);
> +
> +void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
> +{
> +	__be32 value2 = cpu_to_be32(value);
> +
> +	tpm_buf_append(buf, (u8 *)&value2, 4);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index d9d645e9c52c..bb0e8718a432 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -326,77 +326,15 @@ struct tpm2_hash {
>   	unsigned int tpm_id;
>   };
>   
> -static inline void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
> -{
> -	struct tpm_header *head = (struct tpm_header *)buf->data;
> -
> -	head->tag = cpu_to_be16(tag);
> -	head->length = cpu_to_be32(sizeof(*head));
> -	head->ordinal = cpu_to_be32(ordinal);
> -}
> -
> -static inline int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
> -{
> -	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
> -	if (!buf->data)
> -		return -ENOMEM;
> -
> -	buf->flags = 0;
> -	tpm_buf_reset(buf, tag, ordinal);
> -	return 0;
> -}
> -
> -static inline void tpm_buf_destroy(struct tpm_buf *buf)
> -{
> -	free_page((unsigned long)buf->data);
> -}
> -
> -static inline u32 tpm_buf_length(struct tpm_buf *buf)
> -{
> -	struct tpm_header *head = (struct tpm_header *)buf->data;
> -
> -	return be32_to_cpu(head->length);
> -}
> -
> -static inline void tpm_buf_append(struct tpm_buf *buf,
> -				  const unsigned char *new_data,
> -				  unsigned int new_len)
> -{
> -	struct tpm_header *head = (struct tpm_header *)buf->data;
> -	u32 len = tpm_buf_length(buf);
> -
> -	/* Return silently if overflow has already happened. */
> -	if (buf->flags & TPM_BUF_OVERFLOW)
> -		return;
> -
> -	if ((len + new_len) > PAGE_SIZE) {
> -		WARN(1, "tpm_buf: overflow\n");
> -		buf->flags |= TPM_BUF_OVERFLOW;
> -		return;
> -	}
> -
> -	memcpy(&buf->data[len], new_data, new_len);
> -	head->length = cpu_to_be32(len + new_len);
> -}
> -
> -static inline void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value)
> -{
> -	tpm_buf_append(buf, &value, 1);
> -}
> -
> -static inline void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value)
> -{
> -	__be16 value2 = cpu_to_be16(value);
> -
> -	tpm_buf_append(buf, (u8 *) &value2, 2);
> -}
> -
> -static inline void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
> -{
> -	__be32 value2 = cpu_to_be32(value);
> -
> -	tpm_buf_append(buf, (u8 *) &value2, 4);
> -}
> +int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal);
> +void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal);
> +void tpm_buf_destroy(struct tpm_buf *buf);
> +u32 tpm_buf_length(struct tpm_buf *buf);
> +void tpm_buf_append(struct tpm_buf *buf, const unsigned char *new_data,
> +		    unsigned int new_len);
> +void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value);
> +void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value);
> +void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
>   
>   /*
>    * Check if TPM device is in the firmware upgrade mode.
