Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455317FD368
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjK2J7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjK2J7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:59:08 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8206419A6;
        Wed, 29 Nov 2023 01:59:14 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT8lip4006099;
        Wed, 29 Nov 2023 09:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Hv358qHkkkSpvNupSHYh3b+P8ZW0/9o2ISigxsZiDRc=;
 b=RYnmXqyqNjkB3uPhASHqAqrdeBHCZVBTxp4yZ1GDyirYoq5bC5pBhSa++iFQeyh0as9s
 BM4domMZ6U2OkVj7juZTPWO+mwaRVwfeDNQWEZhxb9/dsC7YsQVPSCEs8aaHrSw2gSFq
 wE94DR9pxWA9RoQA06NyL0WvwBuwpuN4YLn735gp/NBHE5y8oSgj0Yx4sFfu1dnihdeX
 d40OOZHROD0R3ypUCpJRh6r+UPlCkzc4FoFYaEbpHm4JdJYCtZPkTPVk2zQ/P5+ElFLW
 YDR2jmwA3SiO3MWDFCWY7tAwn2mKybltZq+SUcjruM5urKbfrRicmqFu2Iby1OnGFX7J Fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3up23phqtg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 09:58:52 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AT9hwi3002169;
        Wed, 29 Nov 2023 09:58:51 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3up23phqsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 09:58:51 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT8VHNw012197;
        Wed, 29 Nov 2023 09:58:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukvrkp9tm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 09:58:49 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AT9wkHg16057068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Nov 2023 09:58:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F79A20043;
        Wed, 29 Nov 2023 09:58:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 646F820040;
        Wed, 29 Nov 2023 09:58:45 +0000 (GMT)
Received: from [9.171.93.155] (unknown [9.171.93.155])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 29 Nov 2023 09:58:45 +0000 (GMT)
Message-ID: <edd48d556f3951384f9ac72462f16ee9309a739e.camel@linux.ibm.com>
Subject: Re: [PATCH v2 33/33] kmsan: Enable on s390
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>
Date:   Wed, 29 Nov 2023 10:58:45 +0100
In-Reply-To: <CAG_fn=XCeE7JF5hbpzXu2A0Cae3R16_hnDwF0==oJMX320wBHQ@mail.gmail.com>
References: <20231121220155.1217090-1-iii@linux.ibm.com>
         <20231121220155.1217090-34-iii@linux.ibm.com>
         <CAG_fn=XCeE7JF5hbpzXu2A0Cae3R16_hnDwF0==oJMX320wBHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bHuUrUxcKhPwsCQNukrG6dt9RnefPY2L
X-Proofpoint-ORIG-GUID: XkNrh_4ciRiXY49x-H9GVRo1-JXJIiVh
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_07,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=832 priorityscore=1501 spamscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290073
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-11-29 at 10:19 +0100, Alexander Potapenko wrote:
> Hi Ilya,
>=20
> Sorry for this taking so long, I'll probably take a closer look next
> week.
> Overall, the s390 part looks good to me, but I wanted to check the
> x86
> behavior once again (and perhaps figure out how to avoid introducing
> another way to disable KMSAN).
> Do you happen to have a Git repo with your patches somewhere?

Hi, yes, the latest version of the patches is available at [1].

[1] https://github.com/iii-i/linux/tree/kmsan
