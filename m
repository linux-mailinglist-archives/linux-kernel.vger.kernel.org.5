Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CFF7E2243
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjKFMuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 07:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKFMuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:50:20 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A2DBB;
        Mon,  6 Nov 2023 04:50:17 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6CfA1A006204;
        Mon, 6 Nov 2023 12:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=rafE2bUGXUp3AF0mlhurwVQAwbwKCc65LzqP5Sz+UJc=;
 b=azQ137T9Lbgj1hSNi25Cs7hjbZYNUtKIaenoChmC0sbBk8xn05DxEB6PBg09tO1ZV2Fu
 mKA8QrMv/QD7hWBkpkuSUiXXPcDvJ9Zg94Ra6a4bYrJ4I0PkRNEORTVSyPUjn4LesojF
 4r+k+JmRq6Fk9QjjE27cc9gFefSz3H4YHRwTFQxZaqlj6Axj05EQvYE2AOJMLEbCmYAD
 2XDITc8svRw0IMvmsJN21V00fttUAl+Civm7H39kUFxvTmaDFzFzOPsoTQi5OG5FOZkJ
 a8QcpFw2A1A7wOAnHFnQHAbPW3cWEqpp5eUchXdlkRXZpBUH9S03WJjIeq4NiVt4p4OD lg== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u6yjtsqhg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 12:50:16 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6CWD4X028237;
        Mon, 6 Nov 2023 12:50:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u62gjrwge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 12:50:15 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A6CoCmv30998844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 12:50:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C65D42004E;
        Mon,  6 Nov 2023 12:50:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB22E2004B;
        Mon,  6 Nov 2023 12:50:12 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Nov 2023 12:50:12 +0000 (GMT)
Date:   Mon, 6 Nov 2023 13:50:11 +0100
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Steffen Eiden <seiden@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v1 1/1] s390/uvdevice: Report additional-data length for
 attestation
Message-ID: <20231106135011.07155487@p-imbrenda>
In-Reply-To: <20231106124922.3032370-1-seiden@linux.ibm.com>
References: <20231106124922.3032370-1-seiden@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Olnqh5kVbHTnyVrgFZPWLyrzOo2ntsg7
X-Proofpoint-ORIG-GUID: Olnqh5kVbHTnyVrgFZPWLyrzOo2ntsg7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_11,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 adultscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310240000 definitions=main-2311060104
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Nov 2023 13:49:22 +0100
Steffen Eiden <seiden@linux.ibm.com> wrote:

> Additional data length in the attestation request is an in/out variable.
> Software provides the capacity of the buffer. Upon successful request,
> firmware reports the actual bytes written to the additional data in that
> field. This information is lost, as the length field was not copied back
> to userspace before. Attestation might fail, if user space did not
> specify the exact amount of needed bytes required, as this length is
> part of the attestation measurement.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  drivers/s390/char/uvdevice.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/s390/char/uvdevice.c b/drivers/s390/char/uvdevice.c
> index 144cd2e03590..42c9f77f8da0 100644
> --- a/drivers/s390/char/uvdevice.c
> +++ b/drivers/s390/char/uvdevice.c
> @@ -109,6 +109,7 @@ static int uvio_copy_attest_result_to_user(struct uv_cb_attest *uvcb_attest,
>  					   struct uvio_attest *uvio_attest)
>  {
>  	struct uvio_attest __user *user_uvio_attest = (void __user *)uv_ioctl->argument_addr;
> +	u32 __user *user_buf_add_len = (u32 __user *)&user_uvio_attest->add_data_len;
>  	void __user *user_buf_add = (void __user *)uvio_attest->add_data_addr;
>  	void __user *user_buf_meas = (void __user *)uvio_attest->meas_addr;
>  	void __user *user_buf_uid = &user_uvio_attest->config_uid;
> @@ -117,6 +118,8 @@ static int uvio_copy_attest_result_to_user(struct uv_cb_attest *uvcb_attest,
>  		return -EFAULT;
>  	if (add_data && copy_to_user(user_buf_add, add_data, uvio_attest->add_data_len))
>  		return -EFAULT;
> +	if (put_user(uvio_attest->add_data_len, user_buf_add_len))
> +		return -EFAULT;
>  	if (copy_to_user(user_buf_uid, uvcb_attest->config_uid, sizeof(uvcb_attest->config_uid)))
>  		return -EFAULT;
>  	return 0;

