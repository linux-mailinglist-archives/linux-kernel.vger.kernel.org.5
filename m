Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CFF7B11B1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 06:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjI1Er2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 00:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1Er1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 00:47:27 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D6D92
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 21:47:25 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38S3ZvBl016763;
        Thu, 28 Sep 2023 04:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=/p6uaCgkwiyGbZEhvNiURzs31q+CpDrmch4m+ytv3vM=;
 b=XCvvcJs6E3wUyFbBkYc13AeA3EKFqIJnzJN8ceYGII2XMBIYzuwaTTdfB/3je7L836By
 aqtDCQoN8SaJnW/eo5O45CZBgmOIFfvMqqENOLDmKElwNgfqrtFhniodUXhQpnoCquqr
 OuyrrZdEEA47QVe9sMXMecV9FYkP4FLnpqNwJJmlWAEg1SQrzKEP6ea1UDjSMgdVNFGd
 DN2cEo/heFvbaVqg7fJzH/iLwaM2lvMnWawO4jjo4cWrJzh576i1RFOl0x+ezrTw+DXy
 y0CiebuYiN2+rt1XHcqADR53trgqQx/jYyhBMboTeM2CSLEKdi5OuChikDmr7sy1sQDZ 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcw4cqb99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 04:47:00 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38S4aLRM010520;
        Thu, 28 Sep 2023 04:46:59 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcw4cqb8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 04:46:59 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38S31U5C008399;
        Thu, 28 Sep 2023 04:46:59 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3taabt1s1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 04:46:59 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38S4kw0w3146366
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 04:46:58 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D0BE5805A;
        Thu, 28 Sep 2023 04:46:58 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A3F958051;
        Thu, 28 Sep 2023 04:46:55 +0000 (GMT)
Received: from patel.in.ibm.com (unknown [9.109.195.211])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 28 Sep 2023 04:46:54 +0000 (GMT)
Message-ID: <5c933e2b06ab9090d9190bac41ebbc175b0a9357.camel@linux.ibm.com>
Subject: Re: [PATCH 0/4] SLUB: calculate_order() cleanups
From:   Jay Patel <jaypatel@linux.ibm.com>
Reply-To: jaypatel@linux.ibm.com
To:     Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Thu, 28 Sep 2023 10:16:53 +0530
In-Reply-To: <20230908145302.30320-6-vbabka@suse.cz>
References: <20230908145302.30320-6-vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -iGIWfAupp86IGjW8KxcKyb_CRtjO41T
X-Proofpoint-GUID: 8JsgIpeAPJ3moOntpi6WmNbi8DUmBC9R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_01,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=929 priorityscore=1501 clxscore=1011 phishscore=0 adultscore=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309280039
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-09-08 at 16:53 +0200, Vlastimil Babka wrote:
> Since reviewing recent patches made me finally dig into these
> functions
> in details for the first time, I've also noticed some opportunities
> for
> cleanups that should make them simpler and also deliver more
> consistent
> results for some corner case object sizes (probably not seen in
> practice). Thus patch 3 can increase slab orders somewhere, but only
> in
> the way that was already intended. Otherwise it's almost no
> functional
> changes.
> 
Hi Vlastimil,

This cleanup patchset looks promising.
I've conducted test
on PowerPC with 16 CPUs and a 64K page size, and here are the results.

S
lub Memory Usage

+-------------------+--------+------------+
|                   | Normal | With Patch |
+-------------------+--------+------------+
| Total Slub Memory | 476992 | 478464     |
| Wastage           | 431    | 451        |
+-------------------+--------+------------+

Also, I have not detected any changes in the page order for slub caches
across all objects with 64K page size.

Hackbench Results

+-------+----+---------+------------+----------+
|     
  |    | Normal  | With Patch |          |
+-------+----+---------+-----
-------+----------+
| Amean | 1  | 1.1530  | 1.1347     | ( 1.59%) |
|
Amean | 4  | 3.9220  | 3.8240     | ( 2.50%) |
| Amean | 7  | 6.7943  |
6.6300     | ( 2.42%) |
| Amean | 12 | 11.7067 | 11.4423    | ( 2.26%) |
| Amean | 21 | 20.6617 | 20.1680    | ( 2.39%) |
| Amean | 30 | 29.4200
| 28.6460    | ( 2.63%) |
| Amean | 48 | 47.2797 | 46.2820    | ( 2.11%)
|
| Amean | 64 | 63.4680 | 62.1813    | ( 2.03%) |
+-------+----+------
---+------------+----------+  


Reviewed-by: Jay Patel
<jaypatel@linux.ibm.com>
Tested-by: Jay Patel <jaypatel@linux.ibm.com>

Th
ank You 
Jay Patel
> Vlastimil Babka (4):
>   mm/slub: simplify the last resort slab order calculation
>   mm/slub: remove min_objects loop from calculate_order()
>   mm/slub: attempt to find layouts up to 1/2 waste in
> calculate_order()
>   mm/slub: refactor calculate_order() and calc_slab_order()
> 
>  mm/slub.c | 63 ++++++++++++++++++++++++-----------------------------
> --
>  1 file changed, 27 insertions(+), 36 deletions(-)
> 

