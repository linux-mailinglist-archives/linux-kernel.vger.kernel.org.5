Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29127EF664
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 17:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbjKQQmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 11:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjKQQmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 11:42:32 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030AF194;
        Fri, 17 Nov 2023 08:42:28 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHGcfOD021383;
        Fri, 17 Nov 2023 16:42:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=StP4cu79FPer/ncWhUGarKu7uDEe4P30IUkZKgB8Pno=;
 b=oMXbX3n5GyfZLCltDw9T3hB63sji3rTYRx2aiONgdcwcpnWuRgc0UaDtfD/i573Ikj1A
 6V9MX+hD7DILjp6VLLj4hiHg+6J/hbUCPqr8FP1jWUNJufvk/ikPd5I21POmO6CPtCFL
 4BpSWLn4nTxXmW2iz7fBrpx8paIUZHIHjm74n6KPk6qFuW0g5u3fu1m3NEa+U72LVgYg
 ZzsxRSOHtHAjAASPhdYn90yowjjsJOmnSfR7bB1bnU1L6EkoozrSzhXtaqT2II1bi/uz
 F3c9vm+G3eBn1HIvzsAZ/8GdlrhS/3JAU+MV1lL76f4dj+HpQlFwpen84Yj7hAp0rJ27 hA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uebve828t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 16:42:05 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AHGdXHQ023036;
        Fri, 17 Nov 2023 16:42:04 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uebve828g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 16:42:04 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHG48xD009036;
        Fri, 17 Nov 2023 16:42:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uanem75jx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 16:42:03 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AHGg0dK20775522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 16:42:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 935B020043;
        Fri, 17 Nov 2023 16:42:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C1C820040;
        Fri, 17 Nov 2023 16:41:58 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.53.3])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 17 Nov 2023 16:41:58 +0000 (GMT)
Date:   Fri, 17 Nov 2023 17:41:56 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
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
Subject: Re: [PATCH 26/32] s390/mm: Define KMSAN metadata for vmalloc and
 modules
Message-ID: <ZVeX1K6jIihnXIox@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20231115203401.2495875-1-iii@linux.ibm.com>
 <20231115203401.2495875-27-iii@linux.ibm.com>
 <CAG_fn=XSKh=AmU3mEC7dNmEFk5LaLt+y+TfsVcD0Dn5NsbTBSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=XSKh=AmU3mEC7dNmEFk5LaLt+y+TfsVcD0Dn5NsbTBSw@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uOIqbaNKTfMkkRxqsp7HM2Lax2N0tjjf
X-Proofpoint-ORIG-GUID: cilvsidISOBHr1Hvn1uIcIjCKlM8WL09
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_15,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 impostorscore=0 mlxlogscore=633 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170124
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 04:03:13PM +0100, Alexander Potapenko wrote:

Hi Alexander!

> >         /* allow vmalloc area to occupy up to about 1/2 of the rest virtual space left */
> >         vmalloc_size = min(vmalloc_size, round_down(VMALLOC_END / 2, _REGION3_SIZE));
> > +#ifdef CONFIG_KMSAN
> > +       /* take 2/3 of vmalloc area for KMSAN shadow and origins */
> > +       vmalloc_size = round_down(vmalloc_size / 3, PAGE_SIZE);
> Is it okay that vmalloc_size is only aligned on PAGE_SIZE?
> E.g. above the alignment is _REGION3_SIZE.

Good question!

This patch does not break anything, although the _REGION3_SIZE 
alignment would be consistent here. Yet, we might rethink this
whole code piece and the next version would reflect that.

Thanks!
