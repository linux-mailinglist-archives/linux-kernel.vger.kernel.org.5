Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910817C5699
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346714AbjJKOSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbjJKOSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:18:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA89D94
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 07:18:42 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BEHNHj009903;
        Wed, 11 Oct 2023 14:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=v7Aq4LPAg2ISwEDezJSaooRSCiCQEygdjIfCI1MLCLY=;
 b=qcC5KosSisjohb81Z5fXGZI3cMJkmnjV+51M65wtrli3lnQhixgXGoB1Jndro7xWpMK/
 9yen5UKarwcOm09lRCoSXpeAL0u6UEQNs8nGJPOUyQ593Vl27f5FhpIXOLeeLos0aqmm
 rcsZwnivBlX7WfoGqw1nn4S9ONHIxyxtwNLiHmYZKvjYLyHjN4imSJguOY308gxAC8iY
 J7XOjQre8x5Dw7HV6aBRusAFe467eJ2eSoF8JCFqukKeHNnl7h0qy6CbAtZQCzD1xi9S
 UG3VTSXpw9rUWErh9EH3WFb84uXSzvzdbmhaudJuYCg7SdFencET9e/1r35OyFHSE617 Ww== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tnwb982j1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 14:18:34 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39BD3SHB023032;
        Wed, 11 Oct 2023 13:36:21 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkmc1qrq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 13:36:21 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39BDaKf623659124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Oct 2023 13:36:20 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 999AD58043;
        Wed, 11 Oct 2023 13:36:20 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7150D58055;
        Wed, 11 Oct 2023 13:36:20 +0000 (GMT)
Received: from [9.61.37.205] (unknown [9.61.37.205])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 11 Oct 2023 13:36:20 +0000 (GMT)
Message-ID: <dc63d7ca-aa62-1f51-1e1f-8569fdf841fc@linux.ibm.com>
Date:   Wed, 11 Oct 2023 08:36:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/2] fsi: sbefifo: Bump up user write cmd length
To:     Ninad Palsule <ninad@linux.ibm.com>, jk@ozlabs.org, joel@jms.id.au,
        alistair@popple.id.au, linux-fsi@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20231010204348.2600242-1-ninad@linux.ibm.com>
 <20231010204348.2600242-2-ninad@linux.ibm.com>
Content-Language: en-US
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20231010204348.2600242-2-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uOLUJ5ggglagcsyIlFYYrQbwhZ6HILYA
X-Proofpoint-ORIG-GUID: uOLUJ5ggglagcsyIlFYYrQbwhZ6HILYA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_09,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110126
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/10/23 15:43, Ninad Palsule wrote:
> This commit increases user write limit for command length from 1MB to
> 4MB. This is required to support images larger than 1MB.
>
> As per 'commit 15e2a7218c27 ("fsi: sbefifo: Bump max command length")'
> the alternate solution is to break image into 1MB pieces by cronous
> server that means kernel driver needs to provide way to send end of
> message command once all pieces are transferred. This requires
> restructuring of both kernel driver and cronus server (application).
> Hence this commit chose to bump up cmd length to reduce code impact.
>
> Testing:
>    Loaded 3 MB image through cronus server.


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
> v2:
>    - Add the cmd length check back and changed it to 4MB
> ---
>   drivers/fsi/fsi-sbefifo.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
> index 9912b7a6a4b9a..a95b32461f8f3 100644
> --- a/drivers/fsi/fsi-sbefifo.c
> +++ b/drivers/fsi/fsi-sbefifo.c
> @@ -113,7 +113,7 @@ enum sbe_state
>   #define SBEFIFO_TIMEOUT_IN_RSP		1000
>   
>   /* Other constants */
> -#define SBEFIFO_MAX_USER_CMD_LEN	(0x100000 + PAGE_SIZE)
> +#define SBEFIFO_MAX_USER_CMD_LEN       (0x400000 + PAGE_SIZE)
>   #define SBEFIFO_RESET_MAGIC		0x52534554 /* "RSET" */
>   
>   struct sbefifo {
