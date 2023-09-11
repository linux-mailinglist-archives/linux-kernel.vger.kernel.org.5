Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E22179BD19
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344809AbjIKVOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237987AbjIKN3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:29:30 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A76012A;
        Mon, 11 Sep 2023 06:29:25 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BD4wkg031453;
        Mon, 11 Sep 2023 13:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=OHZCttcORDHOzgF/QX+R50Q6BNXzK/GZ2AIbEecuhtk=;
 b=qfs1ElmOtJBt4rgKxde9Ak8dx3N3nk5SCaMs23SbhTcCU/nw+bCRiwgJqCoNnu8pJ+Wx
 a635Y8ZLx4jb3uj2KY/2wY1UoQgSu3TH6CcegsoJo3IHPhFv+wnsFpfpvL5SoRtsUWlF
 0qleH8QHCez7sd9DOR/MSFHqIprE2YAZ3vTOhqZIPMr351eiv/JgrZxUPIEmcs8G1jRR
 4ZiEZJoRrl1VQj5f43mML4Ddpb3ksOgLGQBeyc9o2mW5LIc2klj2vC/U1SbPi4T4f2gy
 vVP6P0jX0XZ4ZRkdGD3eOCpjYDvJMWHt7//Kj/Qj4IANR+RESvFbIdBeWSlv28Ny+CpF Dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t23fb10r5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 13:29:11 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38BDCtEB016977;
        Mon, 11 Sep 2023 13:29:10 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t23fb10qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 13:29:10 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38BDHHjO002755;
        Mon, 11 Sep 2023 13:29:09 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t14hkjkgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 13:29:09 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38BDT9sp57409910
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 13:29:09 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 683DA58055;
        Mon, 11 Sep 2023 13:29:09 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 726F35804B;
        Mon, 11 Sep 2023 13:29:08 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.190.181])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 11 Sep 2023 13:29:08 +0000 (GMT)
Message-ID: <097a0413b27ed9792dc598ff184730bcf6ae8fcf.camel@linux.ibm.com>
Subject: Re: [PATCH] certs: Restrict blacklist updates to the secondary
 trusted keyring
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, jarkko@kernel.org,
        dhowells@redhat.com, dwmw2@infradead.org
Cc:     mic@linux.microsoft.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 11 Sep 2023 09:29:07 -0400
In-Reply-To: <20230908213428.731513-1-eric.snowberg@oracle.com>
References: <20230908213428.731513-1-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6yi0Q1cR-ekjGl6kAeMMU9adjH6TLfdr
X-Proofpoint-GUID: q6rxkGZ4mzIlJGDiIwNC4aA9lpDDv0ng
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_07,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110119
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Fri, 2023-09-08 at 17:34 -0400, Eric Snowberg wrote:
> Currently root can dynamically update the blacklist keyring if the hash
> being added is signed and vouched for by the builtin trusted keyring.
> Currently keys in the secondary trusted keyring can not be used.
> 
> Keys within the secondary trusted keyring carry the same capabilities as
> the builtin trusted keyring.  Relax the current restriction for updating
> the .blacklist keyring and allow the secondary to also be referenced as
> a trust source.  Since the machine keyring is linked to the secondary
> trusted keyring, any key within it may also be used.
> 
> An example use case for this is IMA appraisal.  Now that IMA both
> references the blacklist keyring and allows the machine owner to add
> custom IMA CA certs via the machine keyring, this adds the additional
> capability for the machine owner to also do revocations on a running
> system.
> 
> IMA appraisal usage example to add a revocation for /usr/foo:
> 
> sha256sum /bin/foo | awk '{printf "bin:" $1}' > hash.txt
> 
> openssl smime -sign -in hash.txt -inkey machine-private-key.pem \
>        -signer machine-certificate.pem -noattr -binary -outform DER \
>        -out hash.p7s
> 
> keyctl padd blacklist "$(< hash.txt)" %:.blacklist < hash.p7s
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

The secondary keyring may include both CA and code signing keys.  With
this change any key loaded onto the secondary keyring may blacklist a
hash.  Wouldn't it make more sense to limit blacklisting
certificates/hashes to at least CA keys? 

> ---
>  certs/Kconfig     | 2 +-
>  certs/blacklist.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/certs/Kconfig b/certs/Kconfig
> index 1f109b070877..23dc87c52aff 100644
> --- a/certs/Kconfig
> +++ b/certs/Kconfig
> @@ -134,7 +134,7 @@ config SYSTEM_BLACKLIST_AUTH_UPDATE
>  	depends on SYSTEM_DATA_VERIFICATION
>  	help
>  	  If set, provide the ability to load new blacklist keys at run time if
> -	  they are signed and vouched by a certificate from the builtin trusted
> +	  they are signed and vouched by a certificate from the secondary trusted

If CONFIG_SECONDARY_TRUSTED_KEYRING is not enabled, it falls back to
the builtin keyring.  Please update the comment accordingly.

>  	  keyring.  The PKCS#7 signature of the description is set in the key
>  	  payload.  Blacklist keys cannot be removed.
>  
> diff --git a/certs/blacklist.c b/certs/blacklist.c
> index 675dd7a8f07a..0b346048ae2d 100644
> --- a/certs/blacklist.c
> +++ b/certs/blacklist.c
> @@ -102,12 +102,12 @@ static int blacklist_key_instantiate(struct key *key,
>  
>  #ifdef CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE
>  	/*
> -	 * Verifies the description's PKCS#7 signature against the builtin
> +	 * Verifies the description's PKCS#7 signature against the secondary
>  	 * trusted keyring.
>  	 */

And similarly here ...

>  	err = verify_pkcs7_signature(key->description,
>  			strlen(key->description), prep->data, prep->datalen,
> -			NULL, VERIFYING_UNSPECIFIED_SIGNATURE, NULL, NULL);
> +			VERIFY_USE_SECONDARY_KEYRING, VERIFYING_UNSPECIFIED_SIGNATURE, NULL, NULL);
>  	if (err)
>  		return err;
>  #else

-- 
thanks,

Mimi

