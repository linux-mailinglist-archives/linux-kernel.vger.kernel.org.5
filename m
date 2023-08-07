Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B5F772738
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjHGONW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjHGONU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:13:20 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B21A4;
        Mon,  7 Aug 2023 07:13:19 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 377EA8Jx027339;
        Mon, 7 Aug 2023 14:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=n84BQ09XyZvS5KUY2JrmSWiOSun89MF1BFDg9O40w/Q=;
 b=qQj+gKQWBPPopqtFLXQxL2+L26wqPCnUNRTVuIqD46ZluBWBLjlqCNmEKIq2RP9BF76p
 C8YuhGSPgCGMNJNFzBRRTpxTtsAVzapMTWLk4Dnv4PvH9c/D3QfHhAAuJ2/fn10NhTwj
 viU/DmUwuYVWfSvk4VuxnyVZr8vT1P/gW3jivDBUr3puhAfYcSkXAnaZWIbp5LJIzDcJ
 WnDlYP4NFxlQlsKLCr7fZX9S+IQHwMTwc9YSgZCwNQIP2G5pZ/U4/gWa/E8XWfI62OeZ
 0n1EgWoUnWszxF6Kq2LiQtJ3MDYRsj32LIO2gheG/BSZux2SrsAS9hR4dqlFbRoaWQo1 +g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sb209r6ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 14:12:20 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 377EBKEP032235;
        Mon, 7 Aug 2023 14:12:19 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sb209r6jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 14:12:19 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 377DKBhs000404;
        Mon, 7 Aug 2023 14:12:18 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa28k5hj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 14:12:18 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 377ECIIC1638968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Aug 2023 14:12:18 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D6B758045;
        Mon,  7 Aug 2023 14:12:18 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EC9F58052;
        Mon,  7 Aug 2023 14:12:17 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.107.174])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  7 Aug 2023 14:12:16 +0000 (GMT)
Message-ID: <53b8559db650886f013d5e91704ce8f4df77d815.camel@linux.ibm.com>
Subject: Re: [PATCH v2 RESEND] kexec_lock: Replace kexec_mutex() by
 kexec_lock() in two comments
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Wenyu Liu <liuwenyu7@huawei.com>, ebiederm@xmission.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org
Cc:     akpm@linux-foundation.org, vschneid@redhat.com,
        pmenzel@molgen.mpg.de, bhe@redhat.com, louhongxiang@huawei.com
Date:   Mon, 07 Aug 2023 10:12:16 -0400
In-Reply-To: <20230807025206.3682381-1-liuwenyu7@huawei.com>
References: <20230807025206.3682381-1-liuwenyu7@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3MTXnmgIWlUckT8r0RJNoUpKvEmNRFKG
X-Proofpoint-ORIG-GUID: Seemm6eNkL6LT_0YpO8DJa7mQCDyrpLg
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_14,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=930
 impostorscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 clxscore=1011 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070130
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-08-07 at 10:52 +0800, Wenyu Liu wrote:
> kexec_mutex is replaced by an atomic variable
> in 05c6257433b (panic, kexec: make __crash_kexec() NMI safe).
> 
> But there are still two comments that referenced kexec_mutex,
> replace them by kexec_lock.
> 
> Signed-off-by: Wenyu Liu <liuwenyu7@huawei.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>

Thank you. It's now queued 
https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/log/?h=next-integrity
.

--
thanks,

Mimi

