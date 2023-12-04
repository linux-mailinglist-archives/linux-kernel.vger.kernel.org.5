Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6891F803B48
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjLDRWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjLDRWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:22:21 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E866383;
        Mon,  4 Dec 2023 09:22:26 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4HCIHI028303;
        Mon, 4 Dec 2023 17:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to : sender :
 content-transfer-encoding : mime-version; s=pp1;
 bh=NxIy4VEpMCawUCxTglyUaxp9xTHr90CdtW3JJB/GfzE=;
 b=Y77okf/tKDf5sPcasv0lCc7iELDhoQrdfJPwCzGhygCudVz+dbRVhNmjmfGNsFz0Hfex
 bmjYBLvp1r7dnCfWrOcHORHKHS9j9VXJTHNH4JGAyYtdQ9By1egu4vN4aPB0Fv48nHrq
 0LpqIF3gmq7L/NipaO8+pRLLenbF/MBunknZX5qOPsDv7hsrlPo1FYiTQsHY23DnTw8C
 gTQkXUjzDZpaEh+NYMBn0Ml+h8Zq0XlMe9FJ505wj7bkeG8jv7jKAiDpwY3s+nYCbaG0
 vTAIrk6fCQoJj2kwszjNpBmLk2nGeDLB2v2UPc5pLkITLvZfGe1K5zo0c2Ets1cQwJrI iQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3usjy5gdb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 17:22:22 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B4HDb6Q032342;
        Mon, 4 Dec 2023 17:22:16 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3usjy5gd7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 17:22:16 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4H1crv031932;
        Mon, 4 Dec 2023 17:17:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3urh4k95wx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 17:17:34 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B4HHVs819202716
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Dec 2023 17:17:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E2FA20043;
        Mon,  4 Dec 2023 17:17:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84E3F20040;
        Mon,  4 Dec 2023 17:17:31 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.171.89.46])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon,  4 Dec 2023 17:17:31 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.96.2)
        (envelope-from <bblock@linux.ibm.com>)
        id 1rACZX-000HVZ-04;
        Mon, 04 Dec 2023 18:17:31 +0100
Date:   Mon, 4 Dec 2023 18:17:31 +0100
From:   Benjamin Block <bblock@linux.ibm.com>
To:     Kees Cook <keescook@chromium.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc:     Steffen Maier <maier@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] scsi: zfcp: Replace strlcpy() with strscpy()
Message-ID: <20231204171731.GA62399@p1gen4-pw042f0m.fritz.box>
References: <20231130204056.it.978-kees@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20231130204056.it.978-kees@kernel.org>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 00mXfE6W_NeckrXu1gZw5l6qKRxrB-Jn
X-Proofpoint-GUID: 4rodcN7COY9Dr5pZ2wBHwlKUIUiEnPBI
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_16,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040133
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kees, Martin, James,

On Thu, Nov 30, 2023 at 12:41:00PM -0800, Kees Cook wrote:
> strlcpy() reads the entire source buffer first. This read may exceed
> the destination size limit. This is both inefficient and can lead
> to linear read overflows if a source string is not NUL-terminated[1].
> Additionally, it returns the size of the source string, not the
> resulting size of the destination string. In an effort to remove strlcpy()
> completely[2], replace strlcpy() here with strscpy().
> 
> Overflow should be impossible here, but actually check for buffer sizes
> being identical with BUILD_BUG_ON(), and include a run-time check as
> well.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy [1]
> Link: https://github.com/KSPP/linux/issues/89 [2]

> ---
>  drivers/s390/scsi/zfcp_fc.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
> index 4f0d0e55f0d4..d6516ab00437 100644
> --- a/drivers/s390/scsi/zfcp_fc.c
> +++ b/drivers/s390/scsi/zfcp_fc.c
> @@ -900,8 +900,19 @@ static void zfcp_fc_rspn(struct zfcp_adapter *adapter,
>  	zfcp_fc_ct_ns_init(&rspn_req->ct_hdr, FC_NS_RSPN_ID,
>  			   FC_SYMBOLIC_NAME_SIZE);
>  	hton24(rspn_req->rspn.fr_fid.fp_fid, fc_host_port_id(shost));
> -	len = strlcpy(rspn_req->rspn.fr_name, fc_host_symbolic_name(shost),
> -		      FC_SYMBOLIC_NAME_SIZE);
> +
> +	BUILD_BUG_ON(sizeof(rspn_req->name) !=
> +			sizeof(fc_host_symbolic_name(shost)));
> +	BUILD_BUG_ON(sizeof(rspn_req->name) !=
> +			type_max(typeof(rspn_req->rspn.fr_name_len)) + 1);
> +	len = strscpy(rspn_req->name, fc_host_symbolic_name(shost),
> +		      sizeof(rspn_req->name));
> +	/*
> +	 * It should be impossible for this to truncate (see BUILD_BUG_ON()
> +	 * above), but be robust anyway.
> +	 */
> +	if (WARN_ON(len < 0))
> +		len = sizeof(rspn_req->name) - 1;

Looks good to me.


Acked-by: Benjamin Block <bblock@linux.ibm.com>


>  	rspn_req->rspn.fr_name_len = len;

Martin, James, can you please pick this up for the v6.8 queue?


-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Gregor Pillen         /         Geschäftsführung: David Faller
Sitz der Ges.: Böblingen     /    Registergericht: AmtsG Stuttgart, HRB 243294
