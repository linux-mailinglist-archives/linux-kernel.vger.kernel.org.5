Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3ADD7E81D0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbjKJSfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235820AbjKJSev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:34:51 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09B633FB8;
        Fri, 10 Nov 2023 04:36:25 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AACI1vm009871;
        Fri, 10 Nov 2023 12:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=6yxpm78rFMLJRZodQU6fvWzHWHo52kLHQcZXjcXCYho=;
 b=CUshjWI6AqCuWAQRw7N/TdCElHOQBFYdjvpaPkU9lTmEXg0CdhTm7dhCSBIpSHRm4ltq
 X1s4tCPc2h9VFtWp9eSPhMYoaHbfd18tBBcrvPqK98goUrdFLLKFubwrBTuMoLt57td0
 jEG35gYz3TlZfe+1V+t2Zn/F0zO6OM3SLVPN4LAhVemDmEaJfmLfukTLDVbpYmqBhhby
 CPo40x+fKw+h514pLKuVbK9FyOOKs2Lrj9yBoLuJ1kYdxGIjUidozq8jUdTQrFMoQivc
 AV/FDwBw/rC/cLB6hL8ZO/cqaGCbmkT4caCUcMKdUWpiuWk9eRf9rU3ZH1eOg2lDHk+Q fg== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9kd5j13s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 12:36:15 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAB6Vbq004129;
        Fri, 10 Nov 2023 12:32:03 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u7w21asmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 12:32:03 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AACW0MT30999020
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 12:32:00 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F3CC20043;
        Fri, 10 Nov 2023 12:32:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08A8720040;
        Fri, 10 Nov 2023 12:32:00 +0000 (GMT)
Received: from [9.152.212.233] (unknown [9.152.212.233])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Nov 2023 12:31:59 +0000 (GMT)
Message-ID: <6d5a8310-d3e4-4fa7-8103-b50b100e22f7@linux.ibm.com>
Date:   Fri, 10 Nov 2023 13:31:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf report: Add s390 raw data interpretation for PAI
 counters
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        sumanthk@linux.ibm.com, svens@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com
References: <20231110110908.2312308-1-tmricht@linux.ibm.com>
 <ZU4d0G23WOKwpIwb@kernel.org>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <ZU4d0G23WOKwpIwb@kernel.org>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AWfigPQbooAU8ChVKF1V67em-vc7D9Ls
X-Proofpoint-GUID: AWfigPQbooAU8ChVKF1V67em-vc7D9Ls
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_09,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=653 adultscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311100103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/23 13:10, Arnaldo Carvalho de Melo wrote:
> Em Fri, Nov 10, 2023 at 12:09:08PM +0100, Thomas Richter escreveu:
>> commit 1bf54f32f525 ("s390/pai: Add support for cryptography counters")
> 
> Where is this commit?
> 
> ⬢[acme@toolbox perf-tools-next]$ git remote update torvalds
> Fetching torvalds
> remote: Enumerating objects: 25591, done.
> remote: Counting objects: 100% (12820/12820), done.
> remote: Compressing objects: 100% (2379/2379), done.
> remote: Total 9481 (delta 8254), reused 8289 (delta 7086), pack-reused 0
> Receiving objects: 100% (9481/9481), 1.76 MiB | 2.89 MiB/s, done.
> Resolving deltas: 100% (8254/8254), completed with 1792 local objects.
> From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux
>    d2f51b3516dade79..89cdf9d556016a54  master     -> torvalds/master
> ⬢[acme@toolbox perf-tools-next]$ git show 1bf54f32f525
> fatal: ambiguous argument '1bf54f32f525': unknown revision or path not in the working tree.
> Use '--' to separate paths from revisions, like this:
> 'git <command> [<revision>...] -- [<file>...]'
> ⬢[acme@toolbox perf-tools-next]$
> 
> Looking using the description I get:
> 
> 39d62336f5c126ad s390/pai: add support for cryptography counters
> 
> Is this the one?
> 
> - Arnaldo
> 


Yep, I apologise for the cut & paste error, this is the commit number in question.
Should I reset a corrected version?

Thanks

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

