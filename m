Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7965D7B7761
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 07:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241328AbjJDFNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 01:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjJDFNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 01:13:06 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC4890;
        Tue,  3 Oct 2023 22:13:02 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39456UMb029838;
        Wed, 4 Oct 2023 05:12:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=9oXZNhn6w+pg5hULt5s1+fcnfjNHQQlRIHLopRjYlqo=;
 b=K1MLwyCVZM7DFSZulbMUZVQDUPV5Tnusq586Zhsl9Z8D25gRdP2lb1R5JTz2ZuCfz4+Z
 z2DZxzfKlqGwAOX5vSBkwJaHAJm4gSV4tL6buZU77YH4LZeqkzu38OHWd0RH3y9K/33E
 Pc465HLhDKNpJnrbPiM8cDBqhNHuAaMDy5H7ADh/tTvnSsh05OMTytLIootRTh8JwPou
 nTsDiso2sywz0IFbuicdcRTREQ44z5VDxijt1oZ4a8ema7LvgXZUzFq0BzF7zOh/2AS1
 O7CXrSeiFkP8QJJeDLJNqcdzJHQ0AyALQZSKby0h0H/fb9Fa/ewhOT9avvNZuUJrt1sx aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3th0y290c0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 05:12:26 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39456X66030400;
        Wed, 4 Oct 2023 05:12:26 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3th0y290bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 05:12:26 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3944Qi3j010941;
        Wed, 4 Oct 2023 05:12:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tf0q1qyf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 05:12:25 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3945CN8W23397092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Oct 2023 05:12:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F06A20043;
        Wed,  4 Oct 2023 05:12:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2738220040;
        Wed,  4 Oct 2023 05:12:21 +0000 (GMT)
Received: from [9.109.212.144] (unknown [9.109.212.144])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  4 Oct 2023 05:12:20 +0000 (GMT)
Message-ID: <6e636e70-cbe5-45a7-8918-abdf196d5437@linux.ibm.com>
Date:   Wed, 4 Oct 2023 10:42:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] dax/kmem: allow kmem to add memory with
 memmap_on_memory
Content-Language: en-US
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "david@redhat.com" <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc:     "Hocko, Michal" <mhocko@suse.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jmoyer@redhat.com" <jmoyer@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
References: <20230928-vv-kmem_memmap-v4-0-6ff73fec519a@intel.com>
 <20230928-vv-kmem_memmap-v4-2-6ff73fec519a@intel.com>
 <73bdc58d-edc1-4344-b42a-4b83ca885329@linux.ibm.com>
 <e1600e8d3986b1ed371847d4863628b8d7ad2091.camel@intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <e1600e8d3986b1ed371847d4863628b8d7ad2091.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lwr6gmcUVDz9kvKRX2_JLfm8fM4InJpt
X-Proofpoint-ORIG-GUID: q9xukhjGvTEJd5H1i7EYqmnB_Vay5YoE
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=664 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040035
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/23 5:18 AM, Verma, Vishal L wrote:
> On Tue, 2023-10-03 at 09:34 +0530, Aneesh Kumar K V wrote:
>> On 9/29/23 2:00 AM, Vishal Verma wrote:
>>> Large amounts of memory managed by the kmem driver may come in via CXL,
>>> and it is often desirable to have the memmap for this memory on the new
>>> memory itself.
>>>
>>> Enroll kmem-managed memory for memmap_on_memory semantics if the dax
>>> region originates via CXL. For non-CXL dax regions, retain the existing
>>> default behavior of hot adding without memmap_on_memory semantics.
>>>
>>
>> Are we not looking at doing altmap space for CXL DAX regions? Last discussion around
>> this was suggesting we look at doing this via altmap reservation so that
>> we get contigous space for device memory enabling us to map them
>> via 1G direct mapping entries? 
>>
> Hey Aneesh - was this on a previous posting or something - do you have
> a link so I can refresh myself on what the discussion was?
> 
> If it is enabling something in CXL similar to the --map=mem mode for
> pmem + device dax, that could be incremental to this.

Yes. Agree that we can do that incremental to this. 

https://lore.kernel.org/linux-mm/b6753402-2de9-25b2-36e9-eacd49752b19@redhat.com

-aneesh
