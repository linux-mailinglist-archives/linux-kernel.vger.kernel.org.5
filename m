Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32397EF76B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 19:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjKQST7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 13:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKQST5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 13:19:57 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10155AA;
        Fri, 17 Nov 2023 10:19:54 -0800 (PST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHIEwvQ011834;
        Fri, 17 Nov 2023 18:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=1L8Q24kr/qoZtRFffr6tjC4KNExzi4YYSRiTIwu6veo=;
 b=kHmczCcSNffDIrXKSJdlsWgmXNJZaJkkhRlWbt30w8GtKWTwW7ESbR8hQtrnOQPCFRV3
 UHe2nC5Hxyc53V3JnwqzZ9mnWk2cpQxeBSASyOm/fuR9h6gZDM0uDKpyOcFNjNE+dlco
 74VT51OIy6ILJ/4AW6yO9n9aOH7/OkjU9h2cKT9vTUg41Y2gjxveXQ+4YK5iMS5f23qe
 6tTXt7p+xr6cwCwopxhTNtAX1qmFBSM+mpE/q7zm3BBkx11AWQW5ZzySYzwzNGnV35ki
 WLe2Xn5jBxPqhs+Av+oar7UXLjfwThZVcBTpWIzayNQWIiaTeaCh6HrTDraQxMirVeKm sA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ued9ag415-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 18:19:52 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AHIEvnl011815;
        Fri, 17 Nov 2023 18:19:52 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ued9ag40w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 18:19:52 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHG48vs014752;
        Fri, 17 Nov 2023 18:19:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uap5kqf4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 18:19:51 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AHIJmlx39191124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 18:19:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82AA020043;
        Fri, 17 Nov 2023 18:19:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 852FE20040;
        Fri, 17 Nov 2023 18:19:47 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.53.3])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 17 Nov 2023 18:19:47 +0000 (GMT)
Date:   Fri, 17 Nov 2023 19:19:45 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Steffen Maier <maier@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: zfcp: Replace strlcpy() with strscpy()
Message-ID: <ZVeuwT1rhMT5UWGB@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20231116191435.work.581-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116191435.work.581-kees@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: maESwB1EAdoeU8RWF2zU727eC3-w3W6G
X-Proofpoint-ORIG-GUID: 1LYYqnlCuehy9DM5_O13BK4b2dszfG4z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_17,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 malwarescore=0 adultscore=0 mlxlogscore=885 spamscore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170137
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 11:14:35AM -0800, Kees Cook wrote:

Hi Kees,

> diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
> index 4f0d0e55f0d4..1a29f10767fc 100644
> --- a/drivers/s390/scsi/zfcp_fc.c
> +++ b/drivers/s390/scsi/zfcp_fc.c
> @@ -900,8 +900,15 @@ static void zfcp_fc_rspn(struct zfcp_adapter *adapter,
>  	zfcp_fc_ct_ns_init(&rspn_req->ct_hdr, FC_NS_RSPN_ID,
>  			   FC_SYMBOLIC_NAME_SIZE);
>  	hton24(rspn_req->rspn.fr_fid.fp_fid, fc_host_port_id(shost));
> -	len = strlcpy(rspn_req->rspn.fr_name, fc_host_symbolic_name(shost),
> -		      FC_SYMBOLIC_NAME_SIZE);
> +	len = strscpy(rspn_req->name, fc_host_symbolic_name(shost),
> +		      sizeof(rspn_req->name));

Could you please explain why do you copy to rspn_req->name instead
of rspn_req->rspn.fr_name?

> +	/*
> +	 * It should be impossible for this to truncate, as
> +	 * sizeof(rspn_req->name) is equal to max size of
> +	 * fc_host_symbolic_name(shost), but check anyway.
> +	 */
> +	if (len < 0)
> +		len = sizeof(rspn_req->name) - 1;
>  	rspn_req->rspn.fr_name_len = len;
>  
>  	sg_init_one(&fc_req->sg_req, rspn_req, sizeof(*rspn_req));

Thanks!
