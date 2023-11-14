Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5674B7EB049
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjKNMwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbjKNMwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:52:33 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9C8D7A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 04:52:26 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AECRWEH016003;
        Tue, 14 Nov 2023 12:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=a3MNvW4RJuSiy14HxHQVb3Vq2nNKwGxdR38eSTasnoA=;
 b=R9fzO9PrKTgGqZ27VCRCnl8rD1su/s0c2CPPZPO3+aGVuP4fGvpG4jalUKfDRp0MNA0X
 /tmuThScLKY5sJBrFxATNNyqXFZ1Ws7Fe3WQvpYaBnPvsV9XE0cOaMrF5XKmWcVCkC2A
 ubunHRns0O85EDFLAuThXYNU+/ik1e8LmCr632uMbc7BUd1WZSC05B92CQM5ExJSDPZX
 VkLWDwBEFAQ2pB2Blg2s9+uLzeoNJnZ0EnBI1IEz5IdiBeABinwtI5X9OLqtwbvw09D0
 DTIOQw6c52Z6KpTMIRs4YHSLNiCbrzAZ0e7izJk9ZufmbFXnHmFZEKQomM15eBMXPKRW cg== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uc8ws0m1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 12:52:07 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEBI9Nf014687;
        Tue, 14 Nov 2023 12:52:05 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uamay80gx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 12:52:05 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AECq3xF56230168
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Nov 2023 12:52:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE2622004B;
        Tue, 14 Nov 2023 12:52:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FBDE20040;
        Tue, 14 Nov 2023 12:52:03 +0000 (GMT)
Received: from [9.144.146.189] (unknown [9.144.146.189])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Nov 2023 12:52:03 +0000 (GMT)
Message-ID: <7c03da2d-b62b-4b1d-ad55-2399c2b163c4@linux.ibm.com>
Date:   Tue, 14 Nov 2023 13:52:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: ocxl: context: Remove unnecessary (void*)
 conversions
To:     Li zeming <zeming@nfschina.com>, ajd@linux.ibm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20231113011543.6940-1-zeming@nfschina.com>
Content-Language: en-US
From:   Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <20231113011543.6940-1-zeming@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: baKY2wO5AmFBmeKova7xZpwSuTcJn4_O
X-Proofpoint-ORIG-GUID: baKY2wO5AmFBmeKova7xZpwSuTcJn4_O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_12,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 phishscore=0 malwarescore=0
 clxscore=1011 suspectscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140100
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/11/2023 02:15, Li zeming wrote:
> The ctx pointer does not need to cast the type.
> 
> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---


Indeed, it's useless.
Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>


>   drivers/misc/ocxl/context.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/ocxl/context.c b/drivers/misc/ocxl/context.c
> index 7f83116ae11a6..cded7d1caf328 100644
> --- a/drivers/misc/ocxl/context.c
> +++ b/drivers/misc/ocxl/context.c
> @@ -55,7 +55,7 @@ EXPORT_SYMBOL_GPL(ocxl_context_alloc);
>    */
>   static void xsl_fault_error(void *data, u64 addr, u64 dsisr)
>   {
> -	struct ocxl_context *ctx = (struct ocxl_context *) data;
> +	struct ocxl_context *ctx = data;
>   
>   	mutex_lock(&ctx->xsl_error_lock);
>   	ctx->xsl_error.addr = addr;
