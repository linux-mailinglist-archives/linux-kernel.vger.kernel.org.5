Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4A67EB051
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjKNMx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbjKNMx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:53:26 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E39E1A1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 04:53:23 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AECRHrv020159;
        Tue, 14 Nov 2023 12:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=rWc6ZdZlGQ5XXMuzhvtwu4sqiqI0ciX047IsVjTo2Pg=;
 b=gpu+2o6EMqANy1si+sesKa/Og2ogiUtUtqTE5Kd/nehVbh/jbmid6FVUDt8OE6pLJAk+
 UjUXDj1nvnFtn+zThX4AN+5+ebGE2WvAQCVWaitA/xscOms2bQXyqEXP00F/g+x+5tRB
 xIoR4zgqswqnRHNTR83f1Z1g9nFLuGRa2wXgpRw26mYnlriTrNWKJjUrmjJvElAMg0os
 fJOfDlC0HaCSvXWuk5vdcnVGg1hvP2/ehSU8OdD6cDl3Ns9L9rnKE/bzKous8Chd+IjT
 AIft0ZkVLH8Sogt2zVhGjqqcKp6UFBUvyWCHKnp7fS1DKZxcpBZAYa7i39Govj/kM4++ gg== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uc8wqrjaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 12:53:10 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEBENjx012700;
        Tue, 14 Nov 2023 12:53:09 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uap5jye19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 12:53:09 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AECr71c42336518
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Nov 2023 12:53:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF9DD20043;
        Tue, 14 Nov 2023 12:53:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B1D42004B;
        Tue, 14 Nov 2023 12:53:07 +0000 (GMT)
Received: from [9.144.146.189] (unknown [9.144.146.189])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Nov 2023 12:53:07 +0000 (GMT)
Message-ID: <a10ea2e9-f88c-4765-aa5a-5dc00b45318f@linux.ibm.com>
Date:   Tue, 14 Nov 2023 13:53:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: ocxl: afu_irq: Remove unnecessary (void*)
 conversions
Content-Language: en-US
To:     Li zeming <zeming@nfschina.com>, ajd@linux.ibm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20231113012202.7887-1-zeming@nfschina.com>
From:   Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <20231113012202.7887-1-zeming@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3w9a2uho0qMJReGeszCGe9576wqHOJpE
X-Proofpoint-GUID: 3w9a2uho0qMJReGeszCGe9576wqHOJpE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_12,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 adultscore=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311140100
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/11/2023 02:22, Li zeming wrote:
> The irq pointer does not need to cast the type.
> 
> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---


Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>

   Fred


>   drivers/misc/ocxl/afu_irq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/ocxl/afu_irq.c b/drivers/misc/ocxl/afu_irq.c
> index a06920b7e049a..36f7379b8e2de 100644
> --- a/drivers/misc/ocxl/afu_irq.c
> +++ b/drivers/misc/ocxl/afu_irq.c
> @@ -57,7 +57,7 @@ EXPORT_SYMBOL_GPL(ocxl_irq_set_handler);
>   
>   static irqreturn_t afu_irq_handler(int virq, void *data)
>   {
> -	struct afu_irq *irq = (struct afu_irq *) data;
> +	struct afu_irq *irq = data;
>   
>   	trace_ocxl_afu_irq_receive(virq);
>   
