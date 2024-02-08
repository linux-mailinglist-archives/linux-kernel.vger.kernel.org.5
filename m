Return-Path: <linux-kernel+bounces-57855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEE184DE3E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14B41F25CF9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41DC6DD0A;
	Thu,  8 Feb 2024 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lEtSp19+"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1CC6DCFE;
	Thu,  8 Feb 2024 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707387962; cv=none; b=USfXGi2Oi28oV6wNkOfdczBaeVD20r1VqwxtApC5VD3ohcvKscI/Zn3J2yC1NKwfIqSrwSCyIxV9GEUhdg34HxMYMLmZeeS6gnNwnAJgXPXGB3ilZmuO0P5ubhM1GBgjbBGtWS5AdRzUmrWt4n37Hx4L63IUUl4Wn0A/q1G1Grw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707387962; c=relaxed/simple;
	bh=emnpEIwAYGIHVgid4NR926MQK2rJE8cWMDX2nfQ2l5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iR7boCyUt53PGZYwf8MIOdMmzNm9Qus/U3ZShTYQo8u8gNZjKRkIKQo1bQKy7yUzOIYx+viFzmU9LnUHrEmCiPyHkpnyQzUvCbfaDsjpEAuajTf5EGRUVGlU9HgGmgjyXiYkoABfxx73zs1egHJuWq239i7IFAzogmh2sMTAjAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lEtSp19+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4189cIFV002468;
	Thu, 8 Feb 2024 10:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xKeQ9fcUMgud2iiOOvuDdu/2E6NwbXSOAkdeYBuJopc=;
 b=lEtSp19+zrRLKzGQUc/SipIlMgyHTz/orTtxhwvfTnkCZq2UuKrZ/OBDBE+OHofSMKjl
 vhwEBWdjArjFk3TVoO042zEgBASib9TCUvuCkLka/C3EKbUjCp4++FnUwgSl59n/UA7G
 BBp/ccpZXJ+rEGEQg+dyXMyIopeUPfyXDT9RWAif2RdvYBxiv6SHj7rN0qHy8b7HQSIQ
 9IqRlAAxmH5Z7iZxp9a74rrRFCu9g+UYB7lsDmVDXhIVunJTBa6fMF1Ccbrdil42TtDo
 AZHjRA3YZoaOj7VvAHYJiJvlHVpISsXseSKXXOp4NNteFJ8+i3rIiXJgrmYtaLGYbZRd wQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w4vg9h24c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 10:25:53 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4189xAxG005430;
	Thu, 8 Feb 2024 10:25:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w21akuk8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 10:25:53 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 418APpbs44499240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 10:25:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 309EA2004B;
	Thu,  8 Feb 2024 10:25:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE67E20040;
	Thu,  8 Feb 2024 10:25:50 +0000 (GMT)
Received: from [9.171.57.15] (unknown [9.171.57.15])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Feb 2024 10:25:50 +0000 (GMT)
Message-ID: <8c986cb3-61b3-4f65-81c9-ffcfa994390f@linux.ibm.com>
Date: Thu, 8 Feb 2024 11:25:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: use ring_buffer_record_is_set_on() in
 tracer_tracing_is_on()
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, Sven Schnelle <svens@linux.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
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
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <20240207104703.071ee985@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sxZlMAMX3gmObfvP11ERkPRy8Nj5sqUe
X-Proofpoint-GUID: sxZlMAMX3gmObfvP11ERkPRy8Nj5sqUe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_01,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=984 suspectscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080054

On 2/7/24 16:47, Steven Rostedt wrote:
> On Wed, 07 Feb 2024 14:33:21 +0100
> Sven Schnelle <svens@linux.ibm.com> wrote:
> 
>> My assumption without reading the code is that something like this
>> happens:
>>
>> CPU0                             CPU1
>> [ringbuffer enabled]
>>                                   ring_buffer_write()
>>                                       if (atomic_read(&buffer->record_disabled))
>>                                              goto out;
>> echo 0 > tracing_on
>> record_disabled |= RB_BUFFER_OFF
>> csum1=`md5sum trace`
> 
> Note, the CPU1 is performing with preemption disabled, so for this to
> happen, something really bad happened on CPU0 to delay preempt disabled
> section so long to allow the trace to be read. Perhaps we should have
> the return of the echo 0 > tracing_on require a synchronize_rcu() to
> make sure all ring buffers see it disabled before it returns.
> 
> But unless your system is doing something really stressed to cause the
> preempt disabled section to take so long, I highly doubt this was the
> race.
> 

I have been only able to reliably reproduce this issue when the system
is under load from stressors. But I am not sure if it can be considered
as *really stressed*.

system : 8 cpus (4 physical cores)
load   : stress-ng --fanotify 1 (or --context 2)
result : ~5/10 test fails

of course as load increases test starts to fail more often, but a
single stressor doesn't seem like much to me for a 4 core machine.

after adding synchronize_rcu() + patch from Sven, I am no longer seeing
failures with the setup above. So it seems like synchronize_rcu() did
the trick(or at least it helps a lot) for the case described on the
previous mail. I couldn't trigger the failure yet, not even with
increased load(but now the test case takes > 5mins to finish :) ).

Here is the diff:

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
@@ -9328,10 +9328,12 @@ rb_simple_write(struct file *filp, const char 
__user *ubuf,
                         val = 0; /* do nothing */
                 } else if (val) {
                         tracer_tracing_on(tr);
+                       synchronize_rcu();
                         if (tr->current_trace->start)
                                 tr->current_trace->start(tr);
                 } else {
                         tracer_tracing_off(tr);
+                       synchronize_rcu();
                         if (tr->current_trace->stop)
                                 tr->current_trace->stop(tr);

Not 100% sure if these were the correct places to add them.



