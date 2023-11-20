Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D44D7F13A8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbjKTMlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 07:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbjKTMlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:41:01 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917F3F2;
        Mon, 20 Nov 2023 04:40:57 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKCRTA6020937;
        Mon, 20 Nov 2023 12:40:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to : sender :
 content-transfer-encoding : mime-version; s=pp1;
 bh=1+HhEt9+VzVP+gvV72c+hoGVjZxonRZpoYZ9ixdDD0U=;
 b=AiOXUd3mLfsZOSEnNSYR7x0nXcghVBEWCg+ufk+sUdP/eHCDYTfkdU8VNwyqUqPxkx2Z
 w62rPJcvIn9F5Znz/8n3irBFETgElLeL9/1zkgRvOAw/BqyV8173JBEXQ436mDyD2QJ+
 Z0wJ/1jYz+Fj8mIeZVIcC38SVfc+fSdDPbge5zdwXqK/+MrID6TIZA+RVneQvGTIwK7/
 9lWNFmYpwgePwSE5z2QJNMv8xOuXTUMX3icHfT65PT5bgYGd/Wr3X7MhkL1SHN11UDzR
 vUQWkxmNZfnqd9dlEK40VAhG8GdKbRXqTdr6lGBLStJm2ccIRpikNFmm/PvSaUViF4sW YQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ug7fkgcv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 12:40:55 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AKCShnj027175;
        Mon, 20 Nov 2023 12:40:55 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ug7fkgcug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 12:40:55 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKAPmLN010137;
        Mon, 20 Nov 2023 12:40:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf8knh42x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 12:40:54 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AKCepRG28181092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 12:40:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BE4120043;
        Mon, 20 Nov 2023 12:40:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFA8520040;
        Mon, 20 Nov 2023 12:40:50 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.171.78.204])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 20 Nov 2023 12:40:50 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.96.2)
        (envelope-from <bblock@linux.ibm.com>)
        id 1r53a5-000IhD-3D;
        Mon, 20 Nov 2023 13:40:50 +0100
Date:   Mon, 20 Nov 2023 13:40:49 +0100
From:   Benjamin Block <bblock@linux.ibm.com>
To:     Kees Cook <keescook@chromium.org>,
        Steffen Maier <maier@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Mailing List linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] scsi: zfcp: Replace strlcpy() with strscpy()
Message-ID: <20231120124049.GB18672@p1gen4-pw042f0m.fritz.box>
References: <20231116191435.work.581-kees@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20231116191435.work.581-kees@kernel.org>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xEpWiVxcG4O-iU7h3w1PBw3O7Bse4y4g
X-Proofpoint-GUID: nqq-clRy7zOMtGGo6E33j85YGlVLG0Ep
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_11,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 clxscore=1011 impostorscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311200087
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Kees,

thanks for the patch.

can you please send this patch to linux-scsi and CC the SCSI Maintainers
(Martin and James) instead (having linux-s390 on CC is fine)? zFCP doesn't go
via s390, being a SCSI driver.

On Thu, Nov 16, 2023 at 11:14:35AM -0800, Kees Cook wrote:
> strlcpy() reads the entire source buffer first. This read may exceed
> the destination size limit. This is both inefficient and can lead
> to linear read overflows if a source string is not NUL-terminated[1].
> Additionally, it returns the size of the source string, not the
> resulting size of the destination string. In an effort to remove strlcpy()
> completely[2], replace strlcpy() here with strscpy().
> 
> Be explicitly robust in the face of truncation, which should be an
> impossible state.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy [1]
> Link: https://github.com/KSPP/linux/issues/89 [2]
> Cc: Steffen Maier <maier@linux.ibm.com>
> Cc: Benjamin Block <bblock@linux.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Azeem Shaikh <azeemshaikh38@gmail.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/s390/scsi/zfcp_fc.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
> index 4f0d0e55f0d4..1a29f10767fc 100644
> --- a/drivers/s390/scsi/zfcp_fc.c
> +++ b/drivers/s390/scsi/zfcp_fc.c
> @@ -900,8 +900,15 @@ static void zfcp_fc_rspn(struct zfcp_adapter *adapter,
>	zfcp_fc_ct_ns_init(&rspn_req->ct_hdr, FC_NS_RSPN_ID,
>			   FC_SYMBOLIC_NAME_SIZE);
>	hton24(rspn_req->rspn.fr_fid.fp_fid, fc_host_port_id(shost));
> -	len = strlcpy(rspn_req->rspn.fr_name, fc_host_symbolic_name(shost),
> -		      FC_SYMBOLIC_NAME_SIZE);
> +	len = strscpy(rspn_req->name, fc_host_symbolic_name(shost),
> +		      sizeof(rspn_req->name));

This is corrct.

> +	/*
> +	 * It should be impossible for this to truncate, as
> +	 * sizeof(rspn_req->name) is equal to max size of
> +	 * fc_host_symbolic_name(shost), but check anyway.
> +	 */
> +	if (len < 0)
> +		len = sizeof(rspn_req->name) - 1;

I'd rather have a compile-time check, whether the array sizes of
`rspn_req->name` and `fc_host_symbolic_name(shost)` run out of sync, or
against our expectations.

Something like:

	len = strscpy(rspn_req->name, fc_host_symbolic_name(shost),
		      sizeof(rspn_req->name));
	BUILD_BUG_ON(sizeof(rspn_req->name) !=
			     sizeof(fc_host_symbolic_name(shost)) ||
		     sizeof(rspn_req->name) !=
			     1 << sizeof(rspn_req->rspn.fr_name_len) * 8);
	rspn_req->rspn.fr_name_len = len;

Then the last assignment should also be correct; and if something changes -
unexpectedly, because this follows a FC standard - we need to adapt the code
anyway I'd think.

Or am I missing something?

>	rspn_req->rspn.fr_name_len = len;
>  
>	sg_init_one(&fc_req->sg_req, rspn_req, sizeof(*rspn_req));
> -- 
> 2.34.1
> 

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Gregor Pillen         /         Geschäftsführung: David Faller
Sitz der Ges.: Böblingen     /    Registergericht: AmtsG Stuttgart, HRB 243294
