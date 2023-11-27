Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5537FAC31
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 22:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjK0VD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 16:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjK0VDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 16:03:54 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839EC19D;
        Mon, 27 Nov 2023 13:04:00 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARIqhBF003778;
        Mon, 27 Nov 2023 21:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=zOZbd6Tjx5IqpV15IyxKo0encBbYOCBSBIdNBMzfpec=;
 b=Dba7yW9u+4XRwMfD4OalQmn1/50PeP+xt51OT/M087lSeEIDJJCWI0Ns8fDRzFZH7+ls
 OUSos0Y3z56xYgtH5ZL8bowozXvgSpbSMtN+sMdiyEzITZPtbaUnqN2tBSYxDjJBSNUS
 Ant3r/JunxJqxIx3aZV/YkjZS6fdyD/ktSpl8o5CJ5xPbckA6IXiwg+XJoTXEdq7xnAC
 Rgma1Lb/BsN7GcgeCLlTAMYHqpp1ApwiOrDunKTqrelfztneOjvJkllHTzEJy4xkTiw4
 a9sVxn2Qjc/adqnumt++9akOHCgoVMv7f64lHw+i5WW+9v6hN9uvYWAGzPasq1mreKfJ 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3un0s1u6te-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 21:03:56 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ARKicf7009940;
        Mon, 27 Nov 2023 21:03:55 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3un0s1u6sk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 21:03:55 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARJP6hO009565;
        Mon, 27 Nov 2023 21:03:54 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukv8nbbex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 21:03:54 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ARL3rwY37814664
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Nov 2023 21:03:53 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55AFE58056;
        Mon, 27 Nov 2023 21:03:53 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66C995806B;
        Mon, 27 Nov 2023 21:03:52 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 27 Nov 2023 21:03:52 +0000 (GMT)
Message-ID: <eb15a5a2-f783-43f1-a91d-1de52d755861@linux.ibm.com>
Date:   Mon, 27 Nov 2023 16:03:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/8] tpm: Store the length of the tpm_buf data
 separately.
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
 <20231124020237.27116-6-jarkko@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231124020237.27116-6-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: w58gYfXAFxHCJsCCMQXdoTm90YJP30g2
X-Proofpoint-GUID: 2zeToWxDBkkTdsaJIq6sjOwqzi21QK3f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_19,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=798 phishscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
> TPM2B buffers, or sized buffers, have a two byte header, which contains the
> length of the payload as a 16-bit big-endian number, without counting in
> the space taken by the header. This differs from encoding in the TPM header
> where the length includes also the bytes taken by the header.
> 
> Unbound the length of a tpm_buf from the value stored to the TPM command
> header. A separate encoding and decoding step so that different buffer
> types can be supported, with variant header format and length encoding.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
> v3 [2023-11-21]: Removed spurious memset() (albeit not harmful). Expand
> tag invariant in tpm_buf_reset() to be allowed to be zero.
> v2 [2023-11-21]: Squashed together with the following patch, as the API
> of tpm_buf_init() is no longer changed.
> ---
>   drivers/char/tpm/tpm-buf.c                | 48 +++++++++++++++++------
>   drivers/char/tpm/tpm-interface.c          |  1 +
>   include/keys/trusted_tpm.h                |  2 -
>   include/linux/tpm.h                       |  6 +--
>   security/keys/trusted-keys/trusted_tpm1.c |  9 +++--
>   5 files changed, 46 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> index 96cee41d5b9c..3f39893f3bb1 100644
> --- a/drivers/char/tpm/tpm-buf.c
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -3,25 +3,44 @@
>    * Handling of TPM command and other buffers.
>    */
>   
> +#include <linux/tpm_command.h>
>   #include <linux/module.h>
>   #include <linux/tpm.h>
>   
> +/**
> + * tpm_buf_init() - Allocate and initialize a TPM command
> + * @buf:	A &tpm_buf
> + * @tag:	TPM_TAG_RQU_COMMAND, TPM2_ST_NO_SESSIONS or TPM2_ST_SESSIONS
> + * @ordinal:	A command ordinal
> + *
> + * Return: 0 or -ENOMEM
> + */
>   int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
>   {
>   	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
>   	if (!buf->data)
>   		return -ENOMEM;
>   
> -	buf->flags = 0;
>   	tpm_buf_reset(buf, tag, ordinal);
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(tpm_buf_init);
>   
> +/**
> + * tpm_buf_reset() - Initialize a TPM command
> + * @buf:	A &tpm_buf
> + * @tag:	TPM_TAG_RQU_COMMAND, TPM2_ST_NO_SESSIONS or TPM2_ST_SESSIONS
> + * @ordinal:	A command ordinal
> + */
>   void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
>   {
>   	struct tpm_header *head = (struct tpm_header *)buf->data;
>   
> +	WARN_ON(tag != TPM_TAG_RQU_COMMAND && tag != TPM2_ST_NO_SESSIONS &&
> +		tag != TPM2_ST_SESSIONS && tag != 0);
> +
> +	buf->flags = 0;
> +	buf->length = sizeof(*head);
>   	head->tag = cpu_to_be16(tag);
>   	head->length = cpu_to_be32(sizeof(*head));
>   	head->ordinal = cpu_to_be32(ordinal);
> @@ -34,33 +53,40 @@ void tpm_buf_destroy(struct tpm_buf *buf)
>   }
>   EXPORT_SYMBOL_GPL(tpm_buf_destroy);
>   
> +/**
> + * tpm_buf_length() - Return the number of bytes consumed by the data
> + *
> + * Return: The number of bytes consumed by the buffer
> + */
>   u32 tpm_buf_length(struct tpm_buf *buf)
>   {
> -	struct tpm_header *head = (struct tpm_header *)buf->data;
> -
> -	return be32_to_cpu(head->length);
> +	return buf->length;
>   }
>   EXPORT_SYMBOL_GPL(tpm_buf_length);
>   
> -void tpm_buf_append(struct tpm_buf *buf,
> -		    const unsigned char *new_data,
> -		    unsigned int new_len)
> +/**
> + * tpm_buf_append() - Append data to an initialized buffer
> + * @buf:	A &tpm_buf
> + * @new_data:	A data blob
> + * @new_length:	Size of the appended data
> + */
> +void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length)
>   {
>   	struct tpm_header *head = (struct tpm_header *)buf->data;
> -	u32 len = tpm_buf_length(buf);
>   
>   	/* Return silently if overflow has already happened. */
>   	if (buf->flags & TPM_BUF_OVERFLOW)
>   		return;
>   
> -	if ((len + new_len) > PAGE_SIZE) {
> +	if ((buf->length + new_length) > PAGE_SIZE) {
>   		WARN(1, "tpm_buf: overflow\n");
>   		buf->flags |= TPM_BUF_OVERFLOW;
>   		return;
>   	}
>   
> -	memcpy(&buf->data[len], new_data, new_len);
> -	head->length = cpu_to_be32(len + new_len);
> +	memcpy(&buf->data[buf->length], new_data, new_length);
> +	buf->length += new_length;
> +	head->length = cpu_to_be32(buf->length);
>   }
>   EXPORT_SYMBOL_GPL(tpm_buf_append);
>   
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 163ae247bff2..ea75f2776c2f 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -232,6 +232,7 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
>   	if (len < min_rsp_body_length + TPM_HEADER_SIZE)
>   		return -EFAULT;
>   
> +	buf->length = len;
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(tpm_transmit_cmd);
> diff --git a/include/keys/trusted_tpm.h b/include/keys/trusted_tpm.h
> index 7769b726863a..a088b33fd0e3 100644
> --- a/include/keys/trusted_tpm.h
> +++ b/include/keys/trusted_tpm.h
> @@ -6,8 +6,6 @@
>   #include <linux/tpm_command.h>
>   
>   /* implementation specific TPM constants */
> -#define MAX_BUF_SIZE			1024
> -#define TPM_GETRANDOM_SIZE		14
>   #define TPM_SIZE_OFFSET			2
>   #define TPM_RETURN_OFFSET		6
>   #define TPM_DATA_OFFSET			10
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 0a8c1351adc2..1d7b39b5c383 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -306,7 +306,8 @@ enum tpm_buf_flags {
>    * A string buffer type for constructing TPM commands.
>    */
>   struct tpm_buf {
> -	unsigned int flags;
> +	u32 flags;
> +	u32 length;
>   	u8 *data;
>   };
>   
> @@ -329,8 +330,7 @@ int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal);
>   void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal);
>   void tpm_buf_destroy(struct tpm_buf *buf);
>   u32 tpm_buf_length(struct tpm_buf *buf);
> -void tpm_buf_append(struct tpm_buf *buf, const unsigned char *new_data,
> -		    unsigned int new_len);
> +void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length);
>   void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value);
>   void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value);
>   void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> index 37bce84eef99..89c9798d1800 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -367,6 +367,7 @@ int trusted_tpm_send(unsigned char *cmd, size_t buflen)
>   		return rc;
>   
>   	buf.flags = 0;
> +	buf.length = buflen;
>   	buf.data = cmd;
>   	dump_tpm_buf(cmd);
>   	rc = tpm_transmit_cmd(chip, &buf, 4, "sending data");
> @@ -417,7 +418,7 @@ static int osap(struct tpm_buf *tb, struct osapsess *s,
>   	tpm_buf_append_u32(tb, handle);
>   	tpm_buf_append(tb, ononce, TPM_NONCE_SIZE);
>   
> -	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
> +	ret = trusted_tpm_send(tb->data, tb->length);
>   	if (ret < 0)
>   		return ret;
>   
> @@ -441,7 +442,7 @@ int oiap(struct tpm_buf *tb, uint32_t *handle, unsigned char *nonce)
>   		return -ENODEV;
>   
>   	tpm_buf_reset(tb, TPM_TAG_RQU_COMMAND, TPM_ORD_OIAP);
> -	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
> +	ret = trusted_tpm_send(tb->data, tb->length);
>   	if (ret < 0)
>   		return ret;
>   
> @@ -553,7 +554,7 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
>   	tpm_buf_append_u8(tb, cont);
>   	tpm_buf_append(tb, td->pubauth, SHA1_DIGEST_SIZE);
>   
> -	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
> +	ret = trusted_tpm_send(tb->data, tb->length);
>   	if (ret < 0)
>   		goto out;
>   
> @@ -644,7 +645,7 @@ static int tpm_unseal(struct tpm_buf *tb,
>   	tpm_buf_append_u8(tb, cont);
>   	tpm_buf_append(tb, authdata2, SHA1_DIGEST_SIZE);
>   
> -	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
> +	ret = trusted_tpm_send(tb->data, tb->length);
>   	if (ret < 0) {
>   		pr_info("authhmac failed (%d)\n", ret);
>   		return ret;
