Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8716C7FABC3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjK0Ulw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjK0Ult (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:41:49 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEDCD60;
        Mon, 27 Nov 2023 12:41:55 -0800 (PST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARJl5x0011147;
        Mon, 27 Nov 2023 20:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=33k6fG7CN8caIQqp5re35EClf3g84aCx79/bsayWk6Y=;
 b=m4OwfOd0wlHGrvPq9yqK8s+YZQvbOCvSfMDn0N/8g4xpZxWQnwhHRoUVum1q+42B2QiU
 0j9NsyY9eneILDBYEKakLHz/T868hngsVDQRIiIPr4TPG82qAOBwHZA75FZ31OBCKZqB
 N5mInXNWjDWwAGQcBcr71hHQvE2J2MQPN3LjIu1bk/Um1GAKC+HyOPG5GvM9GjVzySmD
 Yo+sdxRnwplYdMDqFeu/2co1bs1RNCyJgsLH+4/meX2w5OAfDOVj8ME7IutcIw+UHumw
 z6VUSPQ+THQxrSdf80UU+whrWSs2HAHG8UyU1R+ZURcXAd9rApivUdGQ7n365Q9oepSD Og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3un0xetax9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 20:41:48 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ARJofA7021579;
        Mon, 27 Nov 2023 20:41:48 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3un0xetawx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 20:41:48 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARJcpLI001736;
        Mon, 27 Nov 2023 20:41:47 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwy1jqr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 20:41:47 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ARKfkle16450228
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Nov 2023 20:41:47 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C2EE58054;
        Mon, 27 Nov 2023 20:41:46 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AC4958045;
        Mon, 27 Nov 2023 20:41:45 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 27 Nov 2023 20:41:45 +0000 (GMT)
Message-ID: <ba84a7c1-f397-45f3-b76c-7faed89a005d@linux.ibm.com>
Date:   Mon, 27 Nov 2023 15:41:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/8] tpm: Update struct tpm_buf documentation comments
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
 <20231124020237.27116-5-jarkko@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231124020237.27116-5-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aiuvupNQQzQ38zcO7U2FAyRSc5dYlS83
X-Proofpoint-GUID: 0JPz4-f2rM993IWewFRLLRQXDmE1qw0C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_19,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
> Remove deprecated portions and document enum values.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v1 [2023-11-21]: A new patch.
> v2 [2023-11-24]: Refined the commit message a bit.
> ---
>   include/linux/tpm.h | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index bb0e8718a432..0a8c1351adc2 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -297,15 +297,14 @@ struct tpm_header {
>   	};
>   } __packed;
>   
> -/* A string buffer type for constructing TPM commands. This is based on the
> - * ideas of string buffer code in security/keys/trusted.h but is heap based
> - * in order to keep the stack usage minimal.
> - */
> -
>   enum tpm_buf_flags {
> +	/* the capacity exceeded: */

was exceeded

>   	TPM_BUF_OVERFLOW	= BIT(0),
>   };
>   
> +/*
> + * A string buffer type for constructing TPM commands.
> + */
>   struct tpm_buf {
>   	unsigned int flags;
>   	u8 *data;

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
