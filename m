Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685DA7F0F38
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjKTJj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjKTJj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:39:58 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A325CD;
        Mon, 20 Nov 2023 01:39:54 -0800 (PST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK9MbmM022686;
        Mon, 20 Nov 2023 09:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=+CHgsTGKnTpbF8MedKWJQOq6ykdOdu6WVq7LnYx1a7Q=;
 b=etwpbxU6zp6AgOTdX8UqfPg8zF7yyYh1SdvY1wMGVkOa3BpOjCMwXSorJSofrxedgpN4
 3/EBpWJGK34s6UYJNl3k0mqIZhvOiid4ApMu62x5+8h7ddY3DUf7Wa+t7MM3Sn8wsIc6
 xd+4iZPqDe4++tUGqsTuob+VKuhPs4m8KV9twFmzKld29P89yQPmeAMcM3hMcd8qwyDZ
 bSZ0S32Xqkxt2ncCGX94W5RM0WLUd6YlrYEBMLkdCjtB2Wdwg1l/lYG7LGNDFsYWyN5V
 sIY3LzVtoVgDRjGUD+7m4rWdGeW6/y119IKe3QSFZxcKn5EZQoG2FUdWay7JtYyeQj+R GA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ug4rv0g4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 09:39:44 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AK9OiqB029893;
        Mon, 20 Nov 2023 09:39:44 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ug4rv0g08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 09:39:44 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK7KM1o008909;
        Mon, 20 Nov 2023 09:39:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf7yy8e4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 09:39:40 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AK9dbaq39846224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 09:39:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C87D2004B;
        Mon, 20 Nov 2023 09:39:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E20B20040;
        Mon, 20 Nov 2023 09:39:36 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.171.34.73])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 20 Nov 2023 09:39:36 +0000 (GMT)
Date:   Mon, 20 Nov 2023 10:39:35 +0100
From:   Sumanth Korikkar <sumanthk@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] mm: use vmem_altmap code without CONFIG_ZONE_DEVICE
Message-ID: <ZVspV8zMMFPQxRaG@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20231120072317.3169630-1-sumanthk@linux.ibm.com>
 <20231120072317.3169630-4-sumanthk@linux.ibm.com>
 <f16a4214-332d-48f1-b825-f39cfbdc0f71@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f16a4214-332d-48f1-b825-f39cfbdc0f71@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Vcg2raKPY6RueXma9dVQd7y2O_sVaTn3
X-Proofpoint-ORIG-GUID: 9GXehSnBmUTDmVh2u1Uvqyx1pa7sbyHS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_07,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=333 malwarescore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200064
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 10:01:13AM +0100, David Hildenbrand wrote:
> 
> What speaks against just moving them to the header instead? They surely are
> tiny ...
>
I followed the previous convention. Sure, will make it inline and put
those definitions in header file.

Thanks
