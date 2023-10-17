Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828157CC4E1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343794AbjJQNjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJQNjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:39:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C71AF5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:39:17 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HDLeQA025022;
        Tue, 17 Oct 2023 13:39:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=/Pbuc6hRixvf0fwrV1pkjF4DHtBgK8NHynPtLQz8Ua4=;
 b=AyqKNKlF83kpNEK33rCha4kOvKRLvqBidEPkmFxaKVRXbf7N1vY88TAQovBIp8EcpyW8
 qczMpasEKdG4d0W0CEiJwfMJkqQsE1isjZ8OwEoa8Bcdzg07wDKDgOVN+DvCDFEr1uBQ
 olZMZwfpCQ15s2dE/n5a920b05A9XyKh9aN6UHE1tB5w5x+GN/qyXH17xPMFkozsEWNH
 fRwMnEyPRxlYbGP7lifl6INvmwB4wYDjZvVyhOUqDIYIfCbviyeejmU4MlFuNWJnczZa
 6tt8FmKS+/xi73q14+tfz+0X6gWQsP1E2iEyNhMGiuH75EI7/X4HNS8++eaIDO5t792q HA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tstjxj1ge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 13:39:09 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39HDUqAN007698;
        Tue, 17 Oct 2023 13:39:00 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tstjxj11x-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 13:39:00 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39HDOHOZ026875;
        Tue, 17 Oct 2023 13:30:34 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tr5as9e2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 13:30:34 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39HDUWCV47514000
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 13:30:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D58B520040;
        Tue, 17 Oct 2023 13:30:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D10642004B;
        Tue, 17 Oct 2023 13:30:31 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.27.84])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 17 Oct 2023 13:30:31 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [powerpc] Kernel crash while running LTP (bisected)
From:   Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <84a6c480-f29b-4a73-bbb0-4908145dc4db@lucifer.local>
Date:   Tue, 17 Oct 2023 19:00:20 +0530
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-mm@kvack.org,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <93251CB3-D144-44F5-A482-0051A398E643@linux.ibm.com>
References: <81C9E2C1-DCC3-4DDD-8466-069893398B5B@linux.ibm.com>
 <84a6c480-f29b-4a73-bbb0-4908145dc4db@lucifer.local>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5o2hsGZjg7EXtF2R7jEHpcKi99y3XOm6
X-Proofpoint-ORIG-GUID: SC_EZLQmn-G7AMdy4gRdi7ugTERNuBkh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_02,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=786 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170115
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 17-Oct-2023, at 4:35=E2=80=AFPM, Lorenzo Stoakes =
<lstoakes@gmail.com> wrote:
>=20
> On Tue, Oct 17, 2023 at 02:46:07PM +0530, Sachin Sant wrote:
>> While running LTP tests (getpid02) on a Power10 server booted with
>> 6.6.0-rc6-next-20231016 following crash was seen:
>>=20
>> [   76.386628] Kernel attempted to read user page (d8) - exploit =
attempt? (uid: 0)
>> [   76.386649] BUG: Kernel NULL pointer dereference on read at =
0x000000d8
>> [   76.386653] Faulting instruction address: 0xc0000000004cda90
>> [   76.386658] Oops: Kernel access of bad area, sig: 11 [#1]
> [snip]
>>=20
>> Git bisect points to following patch
>>=20
>> commit 1db41d29b79ad271674081c752961edd064bbbac
>>    mm: perform the mapping_map_writable() check after call_mmap()
>>=20
>> Reverting the patch allows the test to complete.
>>=20
>> - Sachin
>=20
> Hi Sachin,
>=20
> Thanks for the report but this was triggered in another test =
previously and
> has been fixed already (apologies for the inconvenience!) see [0]. =
Andrew
> took the -fix patch and applied to mm-unstable, this should wend its =
way to
> -next in the meantime.

Ah, thank you. Yes the fix works for me.

- Sachin
