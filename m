Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA64380A22F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbjLHLaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjLHL37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:29:59 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF06310FC;
        Fri,  8 Dec 2023 03:30:05 -0800 (PST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B8BCgXq006707;
        Fri, 8 Dec 2023 11:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=H2NsPvcybphcX4wW35K0YOfsE3eKKcWCxuFaCU1L90s=;
 b=q/IFnqm6kLqEVqIVmYaPwEw4WWcSsytxMw3rgfTxcI716sWBH5jkdR0I8By+jqE1xKxf
 /dahZoqb/5pfwRUkkVb5ksuY5YdU9q+lbK37MkEwE2waxAT3RnPrhNQvgeMTuDY9Ydv2
 cHL73bwpHkiGn59dDE5g9S5eIOUzMGkX7TKnSmvWwRLNLi4OAkF2gquKmhhi+x607RFe
 T5vDbS3gbhqrs0QJKEXoFya41Rr8vBz2aTOYhYdUPz7j8/OvB/y+gZCI6Qk26moLfvec
 LAWNf3TDbXn98PiaNx6N/TSaPtA1Ss/19hx+Ohu++zFxXgDuJXguSaSYkI8HIVbfr+pb 2Q== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uv22p8h3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Dec 2023 11:29:56 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B89mvjj015459;
        Fri, 8 Dec 2023 11:29:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3utavks8s4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Dec 2023 11:29:55 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B8BTq7u11928292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Dec 2023 11:29:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 694142004D;
        Fri,  8 Dec 2023 11:29:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 205BE20040;
        Fri,  8 Dec 2023 11:29:52 +0000 (GMT)
Received: from [9.171.29.29] (unknown [9.171.29.29])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  8 Dec 2023 11:29:52 +0000 (GMT)
Message-ID: <7451a263-82e8-4daa-a7f6-009d5560445e@linux.ibm.com>
Date:   Fri, 8 Dec 2023 12:29:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test: Fix fails of perf stat --bpf-counters
 --for-each-cgroup on s390
Content-Language: en-US
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, hca@linux.ibm.com
References: <20231207125716.1947860-1-tmricht@linux.ibm.com>
 <CAM9d7cgJUgVGpQJ=KgH+3RzAJ8Ce50Acr=gSZh_ZLuiTa3-sEg@mail.gmail.com>
 <de0dd86a-4c49-49ed-a90b-4890c82a7b2d@linux.ibm.com>
Organization: IBM
In-Reply-To: <de0dd86a-4c49-49ed-a90b-4890c82a7b2d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gadYk7MrfdohAf8bNu0U9IebSsD0hYwy
X-Proofpoint-ORIG-GUID: gadYk7MrfdohAf8bNu0U9IebSsD0hYwy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_06,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312080095
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/23 12:07, Thomas Richter wrote:
> On 12/8/23 00:26, Namhyung Kim wrote:
> 
>> Thanks for the patch.  But I think it should support
>> machines without systemd (or maybe with old versions).
>>
>> Also probably you want to reset the behavior after
>> the test.  I think we can just run some built-in test
>> workload like `perf test -w thloop`.
>>
>> Thanks,
>> Namhyung
> 
> Thanks for our feedback.
> Well regarding the use of systemd daemon-reexec the manual says
> this command restarts the systemd triggered processes.
> There is nothing to reset. All ports stay active while the command
> is processed.
> 
> I tried your 'perf test -w thloop`, but that did not trigger
> anything on system.slice.
> 
> I do not understand enough about cgroups and system.slice, but I am
> under the impression, that the system.slice just increment counters
> when executed by processes under systemd control. Maybe I am wrong.
> 
> The only other workload which always incremented system.slice counters
> was 'ssh localhost ls -l', which involves local login and a running sshd.
> 
> Thanks for your advice on how to continue on this.
> 
> 

I have done some reading and found this:
Special Slice Units
There are four ".slice" units which form the basis of the hierarchy for assignment of 
resources for services, users, and virtual machines or containers. 
See systemd.slice(7) for details about slice units.

-.slice
The root slice is the root of the slice hierarchy. It usually does not contain units directly,
but may be used to set defaults for the whole tree.
Added in version 206.

system.slice
By default, all system services started by systemd are found in this slice.
Added in version 206.

So it looks like system.slice attached counters get only incremented
when systemd controlled processes do some work,

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

