Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2835765B36
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjG0SNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjG0SNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:13:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7732D64;
        Thu, 27 Jul 2023 11:13:23 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RIDFNB019310;
        Thu, 27 Jul 2023 18:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=C9gHyrC5PbyD7aJFihXi8PurtAWMW8YRynLzo8zgwWo=;
 b=oG67nY4rwjKGQbd0bo8jy3gFTAebwa5KhBecrwB30LNsPckQIlYKKJlt1n0Y05QiJqBb
 3R14JWDq1n01BgWFN0mqAvcTEGSPB9JhLGHagSVoV1EBfMKHRqeDwpJq6kmd3e+OXOkv
 8WXQWtQQFXhj7zAQQ07bqA0Qf9zJH+MJ8pKpVdavLJtXo4ieDMHIvd2hrBCk0lUgoHsJ
 zx+sLQpeIEklaGSzmyxG4Trcaf2s9aR6OtHJojHKS2mPJabp1BxebqVidohJG6tgJSfj
 pt/SA2nltvuw1UGpBi6RUubCpRcCn6rT5pIUnfe5UlJKjFfGrv9bKfqh4yvlUzPBmD8+ eA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s3w7b0bg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 18:13:15 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36RHpp0I003532;
        Thu, 27 Jul 2023 17:56:31 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s3w7b0bft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 17:56:31 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36RGp95a026217;
        Thu, 27 Jul 2023 17:38:10 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s0sesfveb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 17:38:10 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36RHc9on20644444
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jul 2023 17:38:09 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8849A5805E;
        Thu, 27 Jul 2023 17:38:09 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B271C5805C;
        Thu, 27 Jul 2023 17:38:08 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.140.89])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jul 2023 17:38:08 +0000 (GMT)
Message-ID: <5cbba927f2462f48012f683c923d53b3aa291c46.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ima: require signed IMA policy when UEFI secure boot
 is enabled
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Coiby Xu <coxu@redhat.com>, linux-integrity@vger.kernel.org
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 27 Jul 2023 13:38:08 -0400
In-Reply-To: <20230726020806.926734-1-coxu@redhat.com>
References: <20230703115442.129725-1-coxu@redhat.com>
         <20230726020806.926734-1-coxu@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q7UW1XjHHlPAnY4K10s75-3b3U559Dwt
X-Proofpoint-GUID: fxSGUznar_nmjUvM4e5f8NHPEk7KfPYo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 suspectscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307270163
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-07-26 at 10:08 +0800, Coiby Xu wrote:
> With commit 099f26f22f58 ("integrity: machine keyring CA
> configuration"), users are able to add custom IMA CA keys via
> MOK.  This allows users to sign their own IMA polices without
> recompiling the kernel. For the sake of security, mandate signed IMA
> policy when UEFI secure boot is enabled.
> 
> Note this change may affect existing users/tests i.e users won't be able
> to load an unsigned IMA policy when the IMA architecture specific policy
> is configured and UEFI secure boot is enabled.
> 
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
> v2
>  - improve commit message [Mimi]
>   - explicitly mention the dependent commit
>   - add a note that the change will affect user space
>  - remove "/* CONFIG_INTEGRITY_MACHINE_KEYRING .. */" to improve code
>    readability

Thank you for updating the commit message.  The patch is now queued in
next-integrity-testing.

-- 
thanks,

Mimi

