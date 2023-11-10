Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825EC7E83EB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345865AbjKJUcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjKJUbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:31:31 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707662B7AD;
        Fri, 10 Nov 2023 03:08:27 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAAgrJE028485;
        Fri, 10 Nov 2023 11:08:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/QEh/yHROhrQPv88nMycKj8jLLlmgatkPVFuzKbePNs=;
 b=pv/EJN9+20kEjtvnFvWfTnT9E59iy0qYyPrCfXjT9RULHw/PK06TZg3GlEeLgJs/Vizo
 FJcQc6q19jf+/3AK1Dnp1jNshZ3C6hRqsvbeUvlvqzL1fD9pykaeLs/iuM9DLJiTEUhC
 hjcw2R9dmkVw7ClBnBAYdgQjlPXRleJikI32yYofGW1y4p/DCWPEFKWVUj1VErZN4z+K
 xP7ER+UOnVpXk1gWmmARxOvnhm6S3o9P2VmtdqGVZCOVEEcMbZzZetkyb9m0rarjcuzd
 sYWHnG/VBeMUsE7Bv0WlSD4pCordTNEMF7XpFC7yJxj3zw9iue4PSz2p/abdGEgRZjxA Kw== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9k0nrkth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 11:08:18 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA88Smd004144;
        Fri, 10 Nov 2023 11:08:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u7w21acd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 11:08:17 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AAB8Ej329491486
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 11:08:14 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF11E2004B;
        Fri, 10 Nov 2023 11:08:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7937520040;
        Fri, 10 Nov 2023 11:08:14 +0000 (GMT)
Received: from [9.152.212.233] (unknown [9.152.212.233])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Nov 2023 11:08:14 +0000 (GMT)
Message-ID: <8ab63386-16b0-4be1-b395-969fdc0246bc@linux.ibm.com>
Date:   Fri, 10 Nov 2023 12:08:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf report: Add s390 raw data interpretation for PAI
 counters
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        namhyung@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, hca@linux.ibm.com
References: <20231109124105.3845355-1-tmricht@linux.ibm.com>
 <ZU0E7j5UJn5ecCAT@kernel.org>
Content-Language: en-US
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <ZU0E7j5UJn5ecCAT@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qL43J8YjhViLa7qBQj4cQxlvHxNIGGAm
X-Proofpoint-GUID: qL43J8YjhViLa7qBQj4cQxlvHxNIGGAm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_07,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 mlxlogscore=664 mlxscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/23 17:12, Arnaldo Carvalho de Melo wrote:
> Em Thu, Nov 09, 2023 at 01:41:05PM +0100, Thomas Richter escreveu:
>> commit 1bf54f32f525 ("s390/pai: Add support for cryptography counters")
>> added support for Processor Activity Instrumentation Facility (PAI)
>> counters.  These counters values are added as raw data with the perf
>> sample during perf record.
>> Now add support to display these counters in perf report command.
>> The counter number, its assigned name and value is now printed in
>> addition to the hexadecimal output.
> 
> Can someone with access to a machine where these counters are available
> try this patch to provide a Tested-by or Reviewed-by tag?
> 
> - Arnaldo

Sure I just sent v3 with Acked-by and Tested-by.
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

