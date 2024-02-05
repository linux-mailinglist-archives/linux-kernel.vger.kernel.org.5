Return-Path: <linux-kernel+bounces-52700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872E9849B92
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAA131C22337
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE2420DF7;
	Mon,  5 Feb 2024 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SOeVKHx2"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0929E1CD1C;
	Mon,  5 Feb 2024 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707139001; cv=none; b=doHVOObdKxCDteMgOIlilzRJkzvJ50Dqdg59eFDh42Tnlp2Yht1olzhYsJNowXjmBhoupaSBjYj3iQsdkF99dFyExg1mNUTF6KaGb4iho8D/mNcsU+o9W66a/tMM057+K/aalr7X/85n1LUV8RVl8iwfIeqYzOYcqizMNBv3vQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707139001; c=relaxed/simple;
	bh=phFE0J5htpNCpRR8HNzbHVFzQ7uv/MuQlbk2fQvCWH8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OgwCYto237oA7d4i2/Z4UqCjiD8lCcGnH8St0d0pDAWZN5LsHqb+WTK9lIScYzc8vTVXm5xgO14TVCYt/79IQMR+njcm3ypfYE/M+hlJN62IdJ+14kUZvLTq9JEL+gKNOMg9e3ZNQJaKISo6UXtGdpQ/oge4aqg7FEqjFGmr/a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SOeVKHx2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415D807c022337;
	Mon, 5 Feb 2024 13:16:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=ky2sP7LC9ehECK2EtOMlyelCxIov3dSWzHcvB/YNGhs=;
 b=SOeVKHx2rsVkW2qPu9iDzKJBTWysxuv64PilpuOkIT57Omgdki2uIVVyQggcKjJ0oZuH
 u3pgWJUVNolekILVwWAwfaD6ywi/vJPXOgvy68bGc+EiqswF7ydBepJjYDIJM0Jcxajl
 Rlc7ES7JPFJ1JvVYHkWCfIkS9RAhDOTUSaYnX2cw7fzbOzwDIcXi9AMPZhemhPcoBsT5
 OzwWn1B1Bv3o57618QmDWXk5vNpJjzPoSg0bfiIhJGvQpJ+C0Z1owHzAhFz6C549/Sk6
 2ccXEvtQdtm4qdpEKU10ah8oVtuIbbdr+vGCY84uRtVsIay0/RBpCNTR3PP/FlbdbpVJ Ww== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w309q88nv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 13:16:33 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 415CmN57020469;
	Mon, 5 Feb 2024 13:16:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w1ytsrvab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 13:16:32 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 415DGVHn40567042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Feb 2024 13:16:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 411A52004B;
	Mon,  5 Feb 2024 13:16:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08C7920040;
	Mon,  5 Feb 2024 13:16:31 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  5 Feb 2024 13:16:30 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Mete Durlu <meted@linux.ibm.com>
Subject: Re: [PATCH] tracing: use ring_buffer_record_is_set_on() in
 tracer_tracing_is_on()
In-Reply-To: <20240205075504.1b55f29c@rorschach.local.home> (Steven Rostedt's
	message of "Mon, 5 Feb 2024 07:55:04 -0500")
References: <20240205065340.2848065-1-svens@linux.ibm.com>
	<20240205075504.1b55f29c@rorschach.local.home>
Date: Mon, 05 Feb 2024 14:16:30 +0100
Message-ID: <yt9djznj3vbl.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0EOqI_za7h_Y6-9CYERr7KRQCuGyNNCr
X-Proofpoint-GUID: 0EOqI_za7h_Y6-9CYERr7KRQCuGyNNCr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050101

Hi Steven,

Steven Rostedt <rostedt@goodmis.org> writes:

> On Mon,  5 Feb 2024 07:53:40 +0100
> Sven Schnelle <svens@linux.ibm.com> wrote:
>
>> tracer_tracing_is_on() checks whether record_disabled is not zero. This
>> checks both the record_disabled counter and the RB_BUFFER_OFF flag.
>> Reading the source it looks like this function should only check for
>> the RB_BUFFER_OFF flag. Therefore use ring_buffer_record_is_set_on().
>> This fixes spurious fails in the 'test for function traceon/off triggers'
>> test from the ftrace testsuite when the system is under load.
>> 
>
> I've seen these spurious failures too, but haven't looked deeper into
> it. Thanks,

Another issue i'm hitting sometimes is this part:

csum1=`md5sum trace`
sleep $SLEEP_TIME
csum2=`md5sum trace`

if [ "$csum1" != "$csum2" ]; then
    fail "Tracing file is still changing"
fi

This is because the command line was replaced in the
saved_cmdlines_buffer, an example diff between both files
is:

       ftracetest-17950   [005] ..... 344507.002490: sched_process_wait: comm=ftracetest pid=0 prio=120
       ftracetest-17950   [005] ..... 344507.002492: sched_process_wait: comm=ftracetest pid=0 prio=120
- stress-ng-fanot-17820   [006] d.h.. 344507.009901: sched_stat_runtime: comm=stress-ng-fanot pid=17820 runtime=10000054 [ns]
+           <...>-17820   [006] d.h.. 344507.009901: sched_stat_runtime: comm=stress-ng-fanot pid=17820 runtime=10000054 [ns]
       ftracetest-17950   [005] d.h.. 344507.009901: sched_stat_runtime: comm=ftracetest pid=17950 runtime=7417915 [ns]
  stress-ng-fanot-17819   [003] d.h.. 344507.009901: sched_stat_runtime: comm=stress-ng-fanot pid=17819 runtime=9983473 [ns]
- stress-ng-fanot-17820   [007] d.h.. 344507.079900: sched_stat_runtime: comm=stress-ng-fanot pid=17820 runtime=9999865 [ns]
+           <...>-17820   [007] d.h.. 344507.079900: sched_stat_runtime: comm=stress-ng-fanot pid=17820 runtime=9999865 [ns]
  stress-ng-fanot-17819   [004] d.h.. 344507.079900: sched_stat_runtime: comm=stress-ng-fanot pid=17819 runtime=8388039 [ns]

This can be improved by:

echo 32768 > /sys/kernel/tracing/saved_cmdlines_size

But this is of course not a fix - should we maybe replace the program
name with <...> before comparing, remove the check completely, or do
anything else? What do you think?

Thanks,
Sven

