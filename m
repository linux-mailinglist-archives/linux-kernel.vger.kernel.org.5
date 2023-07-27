Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAA47658D2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjG0QfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjG0QfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:35:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CD52135;
        Thu, 27 Jul 2023 09:35:08 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RGDFN2018453;
        Thu, 27 Jul 2023 16:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=j1GCHC88bNq2UpqisYkcGQFb/1PV8EOHsfyuy65SSS8=;
 b=NwXRpQpYW6CS4+kRiBpaUzltyAroaCYQKU3JWrabrNOS/FKe6Rx5Dy1c6qmwfs4AB0gF
 NjPhKqtWOoeXQftk0FI96jELED5sWLNRYMpA9O2XKmbmPmHg5wW7QX81O+RqoWGvdhuI
 yvdeAFGntU8E7rjw3RQ0bm66GAqRia5Va3VHFd7JFuJvjy/1ofVtaROHH79CTdUwpGPq
 x+YbcdmBiEpoWsa5Bosd4iUzEqsiof2onJIahqGNMFm+T1upc0LU0+C/rCY/zzGYlrt7
 IvOgR9lPwHcKm8q5VVlNzwTUJ/IdxaFov27/NBfbspB6UJrEW/bgW4AzUZwcexYRTi1j +Q== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s3st4n8ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 16:34:43 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36RGQxgp002181;
        Thu, 27 Jul 2023 16:34:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s0unjxn44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 16:34:42 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36RGYexQ44171636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jul 2023 16:34:40 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F2B720043;
        Thu, 27 Jul 2023 16:34:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FD9020040;
        Thu, 27 Jul 2023 16:34:40 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 27 Jul 2023 16:34:40 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anastasia Eskova <anastasia.eskova@ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:S390 ARCHITECTURE" <linux-s390@vger.kernel.org>
Subject: Re: linux-next: Tree for Jul 27 (arch/s390/kernel/cert_store.c)
References: <20230727143346.079d4e5a@canb.auug.org.au>
        <8ecb57fb-4560-bdfc-9e55-63e3b0937132@infradead.org>
Date:   Thu, 27 Jul 2023 18:34:39 +0200
In-Reply-To: <8ecb57fb-4560-bdfc-9e55-63e3b0937132@infradead.org> (Randy
        Dunlap's message of "Thu, 27 Jul 2023 08:57:35 -0700")
Message-ID: <yt9dlef15n4w.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 79VygCutHpGW_mn-IM0fyMzSkEhzjM8_
X-Proofpoint-ORIG-GUID: 79VygCutHpGW_mn-IM0fyMzSkEhzjM8_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307270150
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> On 7/26/23 21:33, Stephen Rothwell wrote:
>> Hi all,
>> 
>> Changes since 20230726:
>> 
>
> on s390:
>
> gcc-13.1.0-nolibc/s390-linux/bin/s390-linux-ld: arch/s390/kernel/cert_store.o: in function `check_certificate_hash':
> arch/s390/kernel/cert_store.c:267: undefined reference to `sha256'
>
> so config CERT_STORE should select CRYPTO_SHA256 or CRYPTO_SHA256_S390 ?
> or both?

I would assume it misses 'select CRYPTO_LIB_SHA256'. We'll prepare a
fix, thanks for letting us know!
