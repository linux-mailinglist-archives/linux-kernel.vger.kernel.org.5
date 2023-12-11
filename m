Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624FC80C6DF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbjLKKkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbjLKKkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:40:08 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804E6CF;
        Mon, 11 Dec 2023 02:40:14 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BBAMu3T015214;
        Mon, 11 Dec 2023 10:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=yVHr17YdvQe0ydCo0BKzg0tAiF/vmW+T/J/qFqM2G7w=;
 b=cKZ/RnKAy3o4w3XegTJc86TXCDMOE4PLt1DpaWH5gq8tHmTZgSsaHoh59iTzYlkc0vUw
 eSUgGLPwCvULtBJFQEwEbbfIkxknIyH5Xc6EOgCVtITB0EaF7twSEjllUgDWn95Y110i
 wGh7kbzHHmUlvi4D+CezKwxCQZ+GVEvglJpT8SC/tGMCn5Uc7XLbPQ85bcpOZMpBCiph
 kRG6nPmnEFc8eu97S4/liAEvztAv/tQwHI3ifSIL+nWOoXJQq07GazUEqnUbuK67P47P
 tFFRM4t8ZpW7WV/cI+elUwPsnN1IJYDH6RP0EpUcbbersGvUMyAWPl3r8eY2wo0Pm2Dd VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ux0m50d6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 10:39:54 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BBAMv4L015310;
        Mon, 11 Dec 2023 10:39:53 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ux0m50d68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 10:39:53 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BB9FbH0004701;
        Mon, 11 Dec 2023 10:39:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw4sk0cg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 10:39:52 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BBAdnC017236688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Dec 2023 10:39:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 621BD20043;
        Mon, 11 Dec 2023 10:39:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4276B20040;
        Mon, 11 Dec 2023 10:39:48 +0000 (GMT)
Received: from [9.171.76.38] (unknown [9.171.76.38])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 11 Dec 2023 10:39:48 +0000 (GMT)
Message-ID: <13e3e073f6ed6aa48b39ec16add85baa677d17b4.camel@linux.ibm.com>
Subject: Re: [PATCH v2 32/33] s390: Implement the architecture-specific
 kmsan functions
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
Date:   Mon, 11 Dec 2023 11:39:47 +0100
In-Reply-To: <CAG_fn=V5zMxGUQ=KmJh-ghTUHa-AZYn1CPTQNbf3x7Lu0w=HvA@mail.gmail.com>
References: <20231121220155.1217090-1-iii@linux.ibm.com>
         <20231121220155.1217090-33-iii@linux.ibm.com>
         <CAG_fn=V5zMxGUQ=KmJh-ghTUHa-AZYn1CPTQNbf3x7Lu0w=HvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1ivu9TPpbV33bJspuyHdGPksD1bDTXIu
X-Proofpoint-GUID: NVWxg9UEFQWh9310drT6RwvUw1xWNTKv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-11_04,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=313 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312110086
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTEyLTExIGF0IDExOjI2ICswMTAwLCBBbGV4YW5kZXIgUG90YXBlbmtvIHdy
b3RlOgo+ID4gK3N0YXRpYyBpbmxpbmUgdm9pZCAqYXJjaF9rbXNhbl9nZXRfbWV0YV9vcl9udWxs
KHZvaWQgKmFkZHIsIGJvb2wKPiA+IGlzX29yaWdpbikKPiA+ICt7Cj4gPiArwqDCoMKgwqDCoMKg
IGlmIChhZGRyID49ICh2b2lkICopJlMzOTBfbG93Y29yZSAmJgo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgIGFkZHIgPCAodm9pZCAqKSgmUzM5MF9sb3djb3JlICsgMSkpIHsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICogRGlmZmVyZW50IGxvd2NvcmVzIGFjY2Vzc2VkIHZpYSBTMzkwX2xvd2NvcmUgYXJlCj4g
PiBkZXNjcmliZWQKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBieSB0aGUg
c2FtZSBzdHJ1Y3QgcGFnZS4gUmVzb2x2ZSB0aGUgcHJlZml4Cj4gPiBtYW51YWxseSBpbgo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIG9yZGVyIHRvIGdldCBhIGRpc3RpbmN0
IHN0cnVjdCBwYWdlLgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLwo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYWRkciArPSAodm9pZCAqKWxvd2NvcmVfcHRy
W3Jhd19zbXBfcHJvY2Vzc29yX2lkKCldCj4gPiAtCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKHZvaWQgKikmUzM5MF9sb3djb3JlOwo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGttc2FuX2dldF9tZXRhZGF0YShhZGRyLCBp
c19vcmlnaW4pOwo+ID4gK8KgwqDCoMKgwqDCoCB9Cj4gPiArwqDCoMKgwqDCoMKgIHJldHVybiBO
VUxMOwo+ID4gK30KPiAKPiBJcyB0aGVyZSBhIHBvc3NpYmlsaXR5IGZvciBpbmZpbml0ZSByZWN1
cnNpb24gaGVyZT8gRS5nLiBjYW4KPiBgbG93Y29yZV9wdHJbcmF3X3NtcF9wcm9jZXNzb3JfaWQo
KV1gIHBvaW50IHNvbWV3aGVyZSBpbiBiZXR3ZWVuCj4gYCh2b2lkICopJlMzOTBfbG93Y29yZWAg
YW5kIGAodm9pZCAqKSgmUzM5MF9sb3djb3JlICsgMSkpYD8KCk5vLCBpdCdzIGFsbG9jYXRlZCB3
aXRoIF9fZ2V0X2ZyZWVfcGFnZXMoKSBvciBtZW1ibG9ja19hbGxvY19sb3coKS4KQnV0IHNpbmNl
IHRoaXMgcXVlc3Rpb24gY2FtZSB1cCwgSSBzaG91bGQgcHJvYmFibHkgYWRkIGEgY2hlY2sgYW5k
CmEgV0FSTl9PTl9PTkNFKCkgaGVyZS4K

