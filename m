Return-Path: <linux-kernel+bounces-62505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8AA8521CB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125CD1F230DD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138474F8A8;
	Mon, 12 Feb 2024 22:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GmEOXWVj"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA244F895;
	Mon, 12 Feb 2024 22:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707778453; cv=none; b=V2PDkQOgDYxgfcc0Uz2mY/poJ7xe27W/BG+hIblgFoVq8weJrK1CB/UN45+Ov80byM4PdtoXJ+oEoNtjIo23NIPx+P90qeeABh3JL5/3dpHfnKjnLKP82LYDSOanxjpfO3qVlF1302RF7csfqU7kChLApYHVVMpFx+SnxCKhUPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707778453; c=relaxed/simple;
	bh=CRMISy2p24Ue65dVuL1E92o/9nMUj2CgBQns++yqL8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YFAQS5Yw+nFfvJN4uvLh5K+vVvljKp+MCBEl7YD1UKc6X6Il5HTbXMPw2y813ijK2Y0o7liGURSnwmZW9dSfW9arNHhEb4dZ48G6zusCs/HLKcn+jddXIck4KSTlwJc0Y4VI+7lZQpS5rjzcZ93z/O6hQ3cdbAEeNCmpzOQErhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GmEOXWVj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CMqQim021745;
	Mon, 12 Feb 2024 22:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=rCC1ghtzJzM0/3MEqBjKiVOGubjNvEKTtkOGCu4haLQ=;
 b=GmEOXWVjxQrVBKG14kZu2pOX+qjec5vg1Q8zWLv85Cs4WA8uJB+QMQ33EttawsxS5u+b
 jlgyIaYUOVLy85QtiqZoriW4/aCBISNlu7T9mcNwVAf+6K6swp9ADcxLyFAc3NHOpMsp
 k/FETd25Co/OUjzw1xEzjBGJF6aX5MdWOCyUBzQxhv0JjmCLm0jrtQnDUqANprgECmmX
 AcMbKotO5+qzYDz01HOFTzeaGCmuOyk+HFsQHSiRZ4Q24Bhe1ALfvCa0VOAvqtrmCPZP
 1fQKV9nCrk65MeZEzcxLvx8NfZZp2HhSQCeLuwsaqqWW/qy3Yjh4vvriLhZyYmqfZSPZ Ww== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7vgj80um-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 22:54:05 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41CMSQa7016495;
	Mon, 12 Feb 2024 22:54:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mymbjrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 22:54:04 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41CMs1P439256706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 22:54:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12B2520043;
	Mon, 12 Feb 2024 22:54:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A775820040;
	Mon, 12 Feb 2024 22:54:00 +0000 (GMT)
Received: from [9.179.3.44] (unknown [9.179.3.44])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Feb 2024 22:54:00 +0000 (GMT)
Message-ID: <957e4c37-954f-4c35-98ba-df5edde4b5ce@linux.ibm.com>
Date: Mon, 12 Feb 2024 23:54:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: use ring_buffer_record_is_set_on() in
 tracer_tracing_is_on()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sven Schnelle <svens@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20240205065340.2848065-1-svens@linux.ibm.com>
 <20240205075504.1b55f29c@rorschach.local.home>
 <yt9djznj3vbl.fsf@linux.ibm.com>
 <20240205092353.523cc1ef@rorschach.local.home>
 <yt9d34u63xxz.fsf@linux.ibm.com> <yt9dsf262d2n.fsf@linux.ibm.com>
 <20240206060113.39c0f5bc@rorschach.local.home>
 <yt9deddovn3w.fsf@linux.ibm.com>
 <20240207060923.182ecb55@rorschach.local.home>
 <9a062196-ccbe-440e-a2f9-23eb8c5eb837@linux.ibm.com>
 <20240207072812.4a29235f@rorschach.local.home>
 <yt9dzfwch00u.fsf@linux.ibm.com>
 <20240207104703.071ee985@rorschach.local.home>
 <8c986cb3-61b3-4f65-81c9-ffcfa994390f@linux.ibm.com>
 <20240212135320.26f90f28@gandalf.local.home>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <20240212135320.26f90f28@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7hafZk9ABcnUOTGZf4dYNy0I_3Fknip2
X-Proofpoint-GUID: 7hafZk9ABcnUOTGZf4dYNy0I_3Fknip2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_18,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=850
 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402120178

On 2/12/24 19:53, Steven Rostedt wrote:
> 
> Right, it will definitely force the race window to go away.
> 
> Can you still trigger this issue with just Sven's patch and not this change?
Sven's patch makes the test cases much more resilient. I needed to ramp
up the load up to 4 stressors on a 4 core system before the test starts
to fail again. At this point it is fair to say that the system is under
significant load.

The failing condition is now different, which tells me that
Sven's patch have already solved(or improved) the previous issue.
What is failing now:

   echo '** ENABLE TRACING'
   enable_tracing

   cnt=`cnt_trace`
   if [ $cnt -eq 0 ]; then
      fail "Nothing found in trace"
   fi

Adding a sleep between enable_tracing and cnt_trace seems to improve the
situation a lot. (my guess is that, the trace writer isn't getting any
runtime before the test checks the trace output)

   echo '** ENABLE TRACING'
   enable_tracing

  +sleep $SLEEP_TIME
   cnt=`cnt_trace`
   if [ $cnt -eq 0 ]; then
      fail "Nothing found in trace"
   fi

Didn't see any failure while increasing the system load until 8
stressors (this might have been luck). When system was under load with
8 stressors, I have seen the test failing 2 out of 10 times. Definitely
an improvement over the current situation.



