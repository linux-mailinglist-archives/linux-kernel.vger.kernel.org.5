Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647D68107AA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 02:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378179AbjLMBc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 20:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378145AbjLMBc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 20:32:28 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBB3B2;
        Tue, 12 Dec 2023 17:32:34 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BD0pBG0012640;
        Wed, 13 Dec 2023 01:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=KMCbxYyj6q/VXSfTdo3NzbZtbBOQtb6Yz6XeblWpLIY=;
 b=Fnt0wkfyFieKdF3BGCpAe9eOVN3w6kqCa+XnTateb0CBsl9vHY4Ed7RLw8Ehy/iWt9pt
 3FoOz0fnaJ3WMqwSIBwSLuomeAcpEMnsrPxJJCHpVFIxdWvoFUI6svDcc2AA+9CiqcDb
 ILz9iNmsMYLcxE2+MtNt2GvdlEig+h21gCdjgp9QARG89M2T2sm226TOniD6YS6FOERU
 y+/qSjf0FmpIy+ooCJGhannVqNe3FMHXtr5saUEXEk0QpO9Z9FjSRw9VeVy2+9puzKNr
 Y1JgZBvvvlLxwoOwh4X74m3X7JX3eD+lFD33Uq2czTmtl0AlN8oTGIjrm8GQMw1uVrDl nA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uy2361d6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 01:32:06 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BD0pIkx013397;
        Wed, 13 Dec 2023 01:32:05 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uy2361d65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 01:32:05 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BD1SnXL005066;
        Wed, 13 Dec 2023 01:32:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw4skd26c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 01:32:04 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BD1W1q015074038
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Dec 2023 01:32:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75E0220043;
        Wed, 13 Dec 2023 01:32:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2758620040;
        Wed, 13 Dec 2023 01:32:00 +0000 (GMT)
Received: from [9.171.70.156] (unknown [9.171.70.156])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 13 Dec 2023 01:32:00 +0000 (GMT)
Message-ID: <626be6deb066627a77470bf80bb76c27222a5e3e.camel@linux.ibm.com>
Subject: Re: [PATCH v2 13/33] kmsan: Introduce memset_no_sanitize_memory()
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
Date:   Wed, 13 Dec 2023 02:31:59 +0100
In-Reply-To: <CAG_fn=UbJ+z8Gmfjodu-jBQz75HApXADw8Abj38BCLHmY_ZW9w@mail.gmail.com>
References: <20231121220155.1217090-1-iii@linux.ibm.com>
         <20231121220155.1217090-14-iii@linux.ibm.com>
         <CAG_fn=Vaj3hTRAMxUwofpSMPhFBOizDOWR_An-V9qLNQv-suYw@mail.gmail.com>
         <69e7bc8e8c8a38c429a793e991e0509cb97a53e1.camel@linux.ibm.com>
         <CAG_fn=UbJ+z8Gmfjodu-jBQz75HApXADw8Abj38BCLHmY_ZW9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uqRL-_gQFksj6cXf_VfQabVl2MwU5Zww
X-Proofpoint-ORIG-GUID: MvszSTT3P12rTHdpiLBCqdmC1cvhFx41
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_14,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=802
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312130009
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-12-08 at 16:25 +0100, Alexander Potapenko wrote:
> > A problem with __memset() is that, at least for me, it always ends
> > up being a call. There is a use case where we need to write only 1
> > byte, so I thought that introducing a call there (when compiling
> > without KMSAN) would be unacceptable.
>=20
> Wonder what happens with that use case if we e.g. build with fortify-
> source.
> Calling memset() for a single byte might be indicating the code is
> not hot.

The original code has a simple assignment. Here is the relevant diff:

        if (s->flags & __OBJECT_POISON) {
-               memset(p, POISON_FREE, poison_size - 1);
-               p[poison_size - 1] =3D POISON_END;
+               memset_no_sanitize_memory(p, POISON_FREE, poison_size -
1);
+               memset_no_sanitize_memory(p + poison_size - 1,
POISON_END, 1);
        }

[...]


> As stated above, I don't think this is more or less working as
> intended.
> If we really want the ability to inline __memset(), we could
> transform
> it into memset() in non-sanitizer builds, but perhaps having a call
> is
> also acceptable?

Thanks for the detailed explanation and analysis. I will post
a version with a __memset() and let the slab maintainers decide if
the additional overhead is acceptable.
