Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C997D588C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344013AbjJXQgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343987AbjJXQf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:35:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BED93;
        Tue, 24 Oct 2023 09:35:50 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OGRZRT005791;
        Tue, 24 Oct 2023 16:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=gzAjjy82jfI/5Z+fp7XVCAqrdkII0tgN1G0UzbsZCZo=;
 b=Fnb9y0ZriqGJj5MvDcRRkh1VycEDeuyBKKqq6BatKHg9/SgcJ8G2C/45OFMoBlHYdYE6
 yTP2oay52RuQh5gl+5MtG0DpAYIm9EbnLMH7eukwj3POJTzvZUmbGqcmwCXOXpgoGJPp
 0Y8iXmGzmsbtx+aX/8+3ItQHJ5HPyVUlTDqZGOnWUesixqisyFczLKU0e2HhkeOwmGn2
 qn48lyjHbCRUU4PjrO/UKLh2TGbYYCBWj5Xzj/2DajWvBe+ga4pVeiqMY2lzcyszMVE7
 v57Duk43ML+p4Ykl+1V0yvtHneL0yiZUciRJkI4UichkMD/HQA2NIvri3MMXMUY8oulu Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txhf5r641-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 16:35:48 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39OGRY6k005735;
        Tue, 24 Oct 2023 16:35:43 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txhf5r4kk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 16:35:40 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39OFq1sP023782;
        Tue, 24 Oct 2023 16:31:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tvryt11vj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 16:31:09 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39OGV6Lj37290336
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 16:31:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B611120043;
        Tue, 24 Oct 2023 16:31:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 069E520040;
        Tue, 24 Oct 2023 16:31:06 +0000 (GMT)
Received: from [9.171.57.222] (unknown [9.171.57.222])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 24 Oct 2023 16:31:05 +0000 (GMT)
Message-ID: <c82af527-d72a-476f-8a76-893d68b6a87f@linux.ibm.com>
Date:   Tue, 24 Oct 2023 18:31:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/qeth: replace deprecated strncpy with strscpy
To:     Justin Stitt <justinstitt@google.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20231023-strncpy-drivers-s390-net-qeth_core_main-c-v1-1-e7ce65454446@google.com>
Content-Language: en-GB
From:   Thorsten Winkler <twinkler@linux.ibm.com>
In-Reply-To: <20231023-strncpy-drivers-s390-net-qeth_core_main-c-v1-1-e7ce65454446@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BwEG0FpVjPOs9G4YuxgdOSKf9jDJn1ZN
X-Proofpoint-ORIG-GUID: XAQV7EPJWV3xI0saw8O4bh3S0Kz7Cesg
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_16,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 phishscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310240143
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.10.23 21:39, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect new_entry->dbf_name to be NUL-terminated based on its use with
> strcmp():
> |       if (strcmp(entry->dbf_name, name) == 0) {
> 
> Moreover, NUL-padding is not required as new_entry is kzalloc'd just
> before this assignment:
> |       new_entry = kzalloc(sizeof(struct qeth_dbf_entry), GFP_KERNEL);
> 
> ... rendering any future NUL-byte assignments (like the ones strncpy()
> does) redundant.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

LGTM, thank you!

Reviewed-by: Thorsten Winkler <twinkler@linux.ibm.com>
Tested-by: Thorsten Winkler <twinkler@linux.ibm.com>

> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>   drivers/s390/net/qeth_core_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
> index cd783290bde5..6af2511e070c 100644
> --- a/drivers/s390/net/qeth_core_main.c
> +++ b/drivers/s390/net/qeth_core_main.c
> @@ -6226,7 +6226,7 @@ static int qeth_add_dbf_entry(struct qeth_card *card, char *name)
>   	new_entry = kzalloc(sizeof(struct qeth_dbf_entry), GFP_KERNEL);
>   	if (!new_entry)
>   		goto err_dbg;
> -	strncpy(new_entry->dbf_name, name, DBF_NAME_LEN);
> +	strscpy(new_entry->dbf_name, name, sizeof(new_entry->dbf_name));
>   	new_entry->dbf_info = card->debug;
>   	mutex_lock(&qeth_dbf_list_mutex);
>   	list_add(&new_entry->dbf_list, &qeth_dbf_list);
> 
> ---
> base-commit: 9c5d00cb7b6bbc5a7965d9ab7d223b5402d1f02c
> change-id: 20231023-strncpy-drivers-s390-net-qeth_core_main-c-0b0ee08672ec
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
> 
