Return-Path: <linux-kernel+bounces-14212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DEA82192E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183D3280D38
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B824CCA6B;
	Tue,  2 Jan 2024 09:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A4p/GRB8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7099AD2F0;
	Tue,  2 Jan 2024 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4029CRcE032503;
	Tue, 2 Jan 2024 09:53:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=AYCtOkc+9831jYDs1FcN1a+YAqrskx92og3tUg087YU=;
 b=A4p/GRB8tYMsaukAXGbxqDfxjEzDvMEliKa8hYQmNs7BFfB6R65lKIZlu1ZUP6dFOAwL
 Xxby3Udype6QMnCQuDTf3KHkKxrEAj+/DDduq3C6UaPMRgq0ugPng8y33PySPOxcgZEn
 LomZMsH8RuEXqG8OMwVi0ul8ctQ6DWcU+1cFNKNZ31OmXhO3kQdfkOPBpGlCkoNGC9U3
 BwfiRx5CO47Bup0tjf3gtD4dGiqSkPOgi1RX2GU669QC+BF8TjSoCY2rIWpTQ1RgT3px
 lJ1TeRMssl4RX6wNf6Y5T++zZ1VV7N7bwLgOauzY8ahN7CAJBo5/COEe1W9W5so4wv1l wg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vcfn6rnnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 09:53:20 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4029Khff019456;
	Tue, 2 Jan 2024 09:53:19 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vcfn6rnmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 09:53:19 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4029PIKJ024559;
	Tue, 2 Jan 2024 09:53:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vb0823kb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 09:53:18 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4029rGAI4915940
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jan 2024 09:53:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D25BB20040;
	Tue,  2 Jan 2024 09:53:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 483AE20043;
	Tue,  2 Jan 2024 09:53:16 +0000 (GMT)
Received: from [9.171.21.141] (unknown [9.171.21.141])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jan 2024 09:53:16 +0000 (GMT)
Message-ID: <2bf1b0cb-86af-4e00-a0aa-23e3944617a2@linux.ibm.com>
Date: Tue, 2 Jan 2024 10:53:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH 1/2] net/iucv: Improve unlocking in
 iucv_enable()
Content-Language: en-US
To: Suman Ghosh <sumang@marvell.com>, Markus Elfring <Markus.Elfring@web.de>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Wenjia Zhang <wenjia@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <cde82080-c715-473c-97ac-6ef66bba6d64@web.de>
 <81f7db31-a258-4dc8-b6e1-c1ef1844a9d2@web.de>
 <SJ0PR18MB5216C27127E46490951A1E5DDB61A@SJ0PR18MB5216.namprd18.prod.outlook.com>
 <8123a895-c7dd-4a75-94bc-6f61639621eb@web.de>
 <SJ0PR18MB52168AC4B874C0B99BD37039DB61A@SJ0PR18MB5216.namprd18.prod.outlook.com>
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <SJ0PR18MB52168AC4B874C0B99BD37039DB61A@SJ0PR18MB5216.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C8uidfJ9Rbzq5X89ajyI9gGmOvlv4ngY
X-Proofpoint-ORIG-GUID: F-_IGs_ztXSTS1-qI-16oqhFy018xpAq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-02_02,2024-01-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 mlxlogscore=833 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401020075



On 02.01.24 09:27, Suman Ghosh wrote:
>>> [Suman] This looks confusing. What is the issue with retaining the
>> original change?
>>
>> I propose to reduce the number of cpus_read_unlock() calls (in the
>> source code).
>>
>> Regards,
>> Markus
> [Suman] Then I think we should do something like this. Changing the code flow back-and-forth using "goto" does not seem correct.

I share Suman's concern that jumping backwards goto is confusing.
But I think the Coccinelle finding of freeing a null-pointer should be addressed (see patch 2/2)
Thank you Markus for reporting it.

The allocation does require holding the cpus_read_lock. 
For some reason Markus wants to reduce the number of cpus_read_unlock() calls (why?),
so what about something like this for both issues:

diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index 0ed6e34d6edd..1030403b826b 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -542,24 +542,22 @@ static int iucv_enable(void)
        size_t alloc_size;
        int cpu, rc;

-       cpus_read_lock();
-       rc = -ENOMEM;
        alloc_size = iucv_max_pathid * sizeof(struct iucv_path);
        iucv_path_table = kzalloc(alloc_size, GFP_KERNEL);
        if (!iucv_path_table)
-               goto out;
+               return -ENOMEM;
        /* Declare per cpu buffers. */
-       rc = -EIO;
+       cpus_read_lock();
        for_each_online_cpu(cpu)
                smp_call_function_single(cpu, iucv_declare_cpu, NULL, 1);
-       if (cpumask_empty(&iucv_buffer_cpumask))
+       if (cpumask_empty(&iucv_buffer_cpumask)) {
                /* No cpu could declare an iucv buffer. */
-               goto out;
-       cpus_read_unlock();
-       return 0;
-out:
-       kfree(iucv_path_table);
-       iucv_path_table = NULL;
+               kfree(iucv_path_table);
+               iucv_path_table = NULL;
+               rc = -EIO;
+       } else {
+               rc = 0;
+       }
        cpus_read_unlock();
        return rc;
 }

