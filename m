Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3737FABAA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjK0UhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjK0UhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:37:16 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358D093;
        Mon, 27 Nov 2023 12:37:23 -0800 (PST)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARK7glu015570;
        Mon, 27 Nov 2023 20:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=6dZtFtVOkj3v2LtTIxhqkO3S6miBpByv3GzVmhf3YVU=;
 b=EMzB+O+xdsCcRuauPeT9AyRkRBnKlC2X82T+yzMymmXZsR22zWHopFIxqUsty64ex5QH
 jTrGgb1mDT/3NouBnfIDRqi5DtXbJ2Qe7vVQZcpKrddke9U5JAxC1k4gRqHGX2xpeMTL
 Cc89fvZMYw8NEOXC58rLOtLnOeqAi5uMulKP2MZoc/SX/eAcropvYeoP6aw7SfNJ1mWz
 NqoKrUr4GGa53PIXxy+22sWAHsk2/H6YgLkbYJ9FkFRO8YBU5OvT6Fz0WZHeqG3tck56
 h2zPGLSNCZpt/cXd847+tX153lRHb+tiyy/hbIUca5PJg60msGjWR7Vn0KsPVFT6UJFt 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3un1v80u17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 20:37:19 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ARK9f8k023274;
        Mon, 27 Nov 2023 20:37:19 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3un1v80u0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 20:37:18 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARJP6YP009565;
        Mon, 27 Nov 2023 20:37:17 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukv8nb792-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 20:37:17 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ARKbHv354395314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Nov 2023 20:37:17 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2122658056;
        Mon, 27 Nov 2023 20:37:17 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C7E758045;
        Mon, 27 Nov 2023 20:37:16 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 27 Nov 2023 20:37:16 +0000 (GMT)
Message-ID: <3d900dea-5636-4773-9344-61315c5b7fad@linux.ibm.com>
Date:   Mon, 27 Nov 2023 15:37:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/8] tpm: Remove tpm_send()
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
 <20231124020237.27116-3-jarkko@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231124020237.27116-3-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _7OXSbSCHb5aBMPFkG3U_4ExYfix84jP
X-Proofpoint-GUID: xQe8XJ6xrRmmOZeStl5d_tBviX9DRtlf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_19,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311270143
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
> Open code the last remaining call site for tpm_send().
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
> v1 [2023-11-21]: A new patch.
> ---
>   drivers/char/tpm/tpm-interface.c          | 25 -----------------------
>   include/linux/tpm.h                       |  5 -----
>   security/keys/trusted-keys/trusted_tpm1.c | 14 +++++++++++--
>   3 files changed, 12 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 66b16d26eecc..163ae247bff2 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -342,31 +342,6 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>   }
>   EXPORT_SYMBOL_GPL(tpm_pcr_extend);
>   
> -/**
> - * tpm_send - send a TPM command
> - * @chip:	a &struct tpm_chip instance, %NULL for the default chip
> - * @cmd:	a TPM command buffer
> - * @buflen:	the length of the TPM command buffer
> - *
> - * Return: same as with tpm_transmit_cmd()
> - */
> -int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen)
> -{
> -	struct tpm_buf buf;
> -	int rc;
> -
> -	chip = tpm_find_get_ops(chip);
> -	if (!chip)
> -		return -ENODEV;
> -
> -	buf.data = cmd;
> -	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to a send a command");
> -
> -	tpm_put_ops(chip);
> -	return rc;
> -}
> -EXPORT_SYMBOL_GPL(tpm_send);
> -
>   int tpm_auto_startup(struct tpm_chip *chip)
>   {
>   	int rc;
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 6588ca87cf93..d9d645e9c52c 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -422,7 +422,6 @@ extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
>   			struct tpm_digest *digest);
>   extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>   			  struct tpm_digest *digests);
> -extern int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen);
>   extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
>   extern struct tpm_chip *tpm_default_chip(void);
>   void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
> @@ -443,10 +442,6 @@ static inline int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>   	return -ENODEV;
>   }
>   
> -static inline int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen)
> -{
> -	return -ENODEV;
> -}
>   static inline int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max)
>   {
>   	return -ENODEV;
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> index aa108bea6739..37bce84eef99 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -356,17 +356,27 @@ static int TSS_checkhmac2(unsigned char *buffer,
>    */
>   int trusted_tpm_send(unsigned char *cmd, size_t buflen)
>   {
> +	struct tpm_buf buf;
>   	int rc;
>   
>   	if (!chip)
>   		return -ENODEV;
>   
> +	rc = tpm_try_get_ops(chip);
> +	if (rc)
> +		return rc;
> +
> +	buf.flags = 0;
> +	buf.data = cmd;
>   	dump_tpm_buf(cmd);
> -	rc = tpm_send(chip, cmd, buflen);
> +	rc = tpm_transmit_cmd(chip, &buf, 4, "sending data");
>   	dump_tpm_buf(cmd);
> +
>   	if (rc > 0)
> -		/* Can't return positive return codes values to keyctl */
> +		/* TPM error */
>   		rc = -EPERM;
> +
> +	tpm_put_ops(chip);
>   	return rc;
>   }
>   EXPORT_SYMBOL_GPL(trusted_tpm_send);
