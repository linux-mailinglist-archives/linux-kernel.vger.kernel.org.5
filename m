Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFC67F4655
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344088AbjKVMes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343795AbjKVMeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:34:46 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8DA91;
        Wed, 22 Nov 2023 04:34:43 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMBVnbg031299;
        Wed, 22 Nov 2023 12:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=JfDEp2rYNNMJNDqWlkXnSrW+7ZX3LJDn+wjWCugogRE=;
 b=cSOF+PIxGHmfVH8gXZeM4IQXDsjrzeQ+LIpOQ2dkN6NZTLTa01xYKdhKV2gM5prBNuWE
 bgt7jzmGPk15zoKoD6L+owY+SpeQfCx41gIRRh7SzeIIAqld5tvlzY6pZZ/LczKySpjN
 mPMSikfHCOglkK4qaKjHkRKfyttx9xWohGKjQRpNkQcNubuQ5/NoeTmOdJCgrtnjix3h
 iIExx5v0NxdG6m5NeD3xFxkA+G8qm5pfsvVuynl10OFfbC6GQZmzBtpHOhhxQhvyEE/n
 +b9h6oBoKCApe1eQyIJIWYSdQOJNPNSOjqlqXVl/AmLXcByet9dR6bYavKTjGW5jyBt+ Gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uhgq2hx2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 12:34:38 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AMBv4th023999;
        Wed, 22 Nov 2023 12:34:37 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uhgq2hx1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 12:34:37 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMAJr1B001763;
        Wed, 22 Nov 2023 12:34:36 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf93kymyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 12:34:36 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AMCYZXP14942944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Nov 2023 12:34:35 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A49B15803F;
        Wed, 22 Nov 2023 12:34:35 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB5165805A;
        Wed, 22 Nov 2023 12:34:34 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 22 Nov 2023 12:34:34 +0000 (GMT)
Message-ID: <85154bfe-6bd5-440a-acc1-f01497d59af5@linux.ibm.com>
Date:   Wed, 22 Nov 2023 07:34:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: Start the tpm2 before running a self test.
Content-Language: en-US
To:     Hermin Anggawijaya <hermin.anggawijaya@alliedtelesis.co.nz>,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231122065528.1049819-1-hermin.anggawijaya@alliedtelesis.co.nz>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231122065528.1049819-1-hermin.anggawijaya@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LbJzGeycirY9ZjRWDHlyNiY9chUMTGIY
X-Proofpoint-GUID: pWk4bk2Bxre_FEY90RMSySOWmCNkLYQ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_08,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 spamscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220088
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/22/23 01:55, Hermin Anggawijaya wrote:
> Before sending a command to attempt the self test, the TPM
> may need to be started, otherwise the self test returns
> TPM2_RC_INITIALIZE value causing a log as follows:
> "tpm tpm0: A TPM error (256) occurred attempting the self test".
> 
> Signed-off-by: Hermin Anggawijaya <hermin.anggawijaya@alliedtelesis.co.nz>
> ---
>   drivers/char/tpm/tpm2-cmd.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 93545be190a5..0530f3b5f86a 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -737,15 +737,15 @@ int tpm2_auto_startup(struct tpm_chip *chip)
>   	if (rc)
>   		goto out;
>   
> +	rc = tpm2_startup(chip);
> +	if (rc && rc != TPM2_RC_INITIALIZE)
> +		goto out;
> +

Most platforms should have firmware initialize the TPM 2 these days. 
Therefore, a selftest should work and in case it doesn't work you fall 
back to the tpm2_startup below and if you get an error message in the 
log you at least know that you firmware is not up-to-date.

>   	rc = tpm2_do_selftest(chip);
>   	if (rc && rc != TPM2_RC_INITIALIZE)
>   		goto out;
>   
>   	if (rc == TPM2_RC_INITIALIZE) {
> -		rc = tpm2_startup(chip);
> -		if (rc)
> -			goto out;
> -
>   		rc = tpm2_do_selftest(chip);
>   		if (rc)
>   			goto out;
