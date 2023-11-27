Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956DB7FAC50
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 22:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbjK0VKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 16:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbjK0VKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 16:10:11 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1651D6D;
        Mon, 27 Nov 2023 13:10:17 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARKdWH8023197;
        Mon, 27 Nov 2023 21:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=IH45mWrzzCdZ3sMW0VImP3i2zCTpmv82AlXf7OreOjw=;
 b=Zk+EzHs981PmcaRjB9044iK66efvB/uxTmZ5Or3Xu5ALtPZsw2KiBOXT59p1GIfSfJMw
 QMe59aK9GIiB3YvrvwCqedNdu3SbEsihMH8T4li7JKEsrXMU+g1Hjb2V5wOLLfs3HaDH
 kT7MHF7gyZuZeOKK4wppU/xydfe6Cp79rZPokbcULgPGGF1JbZCBjOdsOMSVFl+jMi7J
 x/NaegUuxBBBpV+6Tw++XN1Kg8k+d6L5nWqGNM8iXYIfpqb8mcVPfG/wxaqnGoM0Dvt4
 wOr6pUYhL6LezRABiCX7A2ohIx14CGpOaF7yHhzWVvxAJyg5IJFzY0RC22Vsxixl2lAe TA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umytg5aam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 21:10:13 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ARKJTSO021559;
        Mon, 27 Nov 2023 21:10:12 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umytg5aa1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 21:10:12 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARJOPX3001742;
        Mon, 27 Nov 2023 21:10:11 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwy1jvfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 21:10:11 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ARLAAge29425922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Nov 2023 21:10:11 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A34685805D;
        Mon, 27 Nov 2023 21:10:10 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD4F058056;
        Mon, 27 Nov 2023 21:10:09 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 27 Nov 2023 21:10:09 +0000 (GMT)
Message-ID: <22032156-bd61-4c72-ad47-fe5932cd832a@linux.ibm.com>
Date:   Mon, 27 Nov 2023 16:10:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/8] tpm: Add tpm_buf_read_{u8,u16,u32}
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
 <20231124020237.27116-8-jarkko@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231124020237.27116-8-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9weWJHXXl_oURyW7Z4KBN3jXqp0BTMT2
X-Proofpoint-ORIG-GUID: zeHZ-mPguzqroTmFqZ81zvvIcc3zZJzQ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_19,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=670 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311270147
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
> Declare reader functions for the instances of struct tpm_buf. If the read
> goes out of boundary, TPM_BUF_BOUNDARY_ERROR is set, and subsequent read
> will do nothing.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
> v5 [2023-11-24]: Fixed off-by-one error in the boundary check.
> v4 [2023-11-21]: Address James Bottomley's feedback for v2 of this
> patch, i.e. offset pointer was not correctly dereferenced.
> v3 [2023-11-21]: Add possibility to check for boundary error to the
> as response to the feedback from Mario Limenciello:
> https://lore.kernel.org/linux-integrity/3f9086f6-935f-48a7-889b-c71398422fa1@amd.com/
> ---
>   drivers/char/tpm/tpm-buf.c | 79 +++++++++++++++++++++++++++++++++++++-
>   include/linux/tpm.h        |  5 +++
>   2 files changed, 83 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> index 099b4a56c5d5..32619e9ab4fa 100644
> --- a/drivers/char/tpm/tpm-buf.c
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -107,7 +107,7 @@ void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length)
>   		return;
>   
>   	if ((buf->length + new_length) > PAGE_SIZE) {
> -		WARN(1, "tpm_buf: overflow\n");
> +		WARN(1, "tpm_buf: write overflow\n");
>   		buf->flags |= TPM_BUF_OVERFLOW;
>   		return;
>   	}
> @@ -143,3 +143,80 @@ void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
>   	tpm_buf_append(buf, (u8 *)&value2, 4);
>   }
>   EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
> +
> +/**
> + * tpm_buf_read() - Read from a TPM buffer
> + * @buf:	&tpm_buf instance
> + * @offset:	offset within the buffer
> + * @count:	the number of bytes to read
> + * @output:	the output buffer
> + */
> +static void tpm_buf_read(struct tpm_buf *buf, off_t *offset, size_t count, void *output)
> +{
> +	off_t next_offset;
> +
> +	/* Return silently if overflow has already happened. */
> +	if (buf->flags & TPM_BUF_BOUNDARY_ERROR)
> +		return;
> +
> +	next_offset = *offset + count;
> +	if (next_offset > buf->length) {
> +		WARN(1, "tpm_buf: read out of boundary\n");
> +		buf->flags |= TPM_BUF_BOUNDARY_ERROR;
> +		return;
> +	}
> +
> +	memcpy(output, &buf->data[*offset], count);
> +	*offset = next_offset;
> +}
> +
> +/**
> + * tpm_buf_read_u8() - Read 8-bit word from a TPM buffer
> + * @buf:	&tpm_buf instance
> + * @offset:	offset within the buffer
> + *
> + * Return: next 8-bit word
> + */
> +u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset)
> +{
> +	u8 value;
> +
> +	tpm_buf_read(buf, offset, sizeof(value), &value);
> +
> +	return value;
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_read_u8);
> +
> +/**
> + * tpm_buf_read_u16() - Read 16-bit word from a TPM buffer
> + * @buf:	&tpm_buf instance
> + * @offset:	offset within the buffer
> + *
> + * Return: next 16-bit word
> + */
> +u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset)
> +{
> +	u16 value;
> +
> +	tpm_buf_read(buf, offset, sizeof(value), &value);
> +
> +	return be16_to_cpu(value);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_read_u16);
> +
> +/**
> + * tpm_buf_read_u32() - Read 32-bit word from a TPM buffer
> + * @buf:	&tpm_buf instance
> + * @offset:	offset within the buffer
> + *
> + * Return: next 32-bit word
> + */
> +u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset)
> +{
> +	u32 value;
> +
> +	tpm_buf_read(buf, offset, sizeof(value), &value);
> +
> +	return be32_to_cpu(value);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_read_u32);
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 715db4a91c1f..e8172f81c562 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -302,6 +302,8 @@ enum tpm_buf_flags {
>   	TPM_BUF_OVERFLOW	= BIT(0),
>   	/* TPM2B format: */
>   	TPM_BUF_TPM2B		= BIT(1),
> +	/* read out of boundary: */
> +	TPM_BUF_BOUNDARY_ERROR	= BIT(2),
>   };
>   
>   /*
> @@ -338,6 +340,9 @@ void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length);
>   void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value);
>   void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value);
>   void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
> +u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset);
> +u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset);
> +u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset);
>   
>   /*
>    * Check if TPM device is in the firmware upgrade mode.
