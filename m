Return-Path: <linux-kernel+bounces-56462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB70F84CA76
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97D1C291340
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CEF5A0FE;
	Wed,  7 Feb 2024 12:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZbggBApv"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112ED5FF0B;
	Wed,  7 Feb 2024 12:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307667; cv=none; b=Tnij9kLePwvQgX6kptAe5un/hBiiDHQ1yuAMDfh62kO7+vX6kKpQaHOU51i5O7KA6rh2ZCePvvpYeJQOtIpVj8AuC7flI7uNzkLdGTdxj8Q9iDCsDYR2eSsBOXFNzDcrb9Rq++KZy+mSlbw+6SyvygaSYaQTDzYSTQnLK4lXEsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307667; c=relaxed/simple;
	bh=PlolVA2Uq5vfWyJ+VAGoyESdTtODOM/K5PRvrl/m4+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pk8cMgdtTZkMSEQ8zKfZV5Q4eSkoHTyzTD044x+VqIQi3rcOr9RJ0wVs65aBpcLadGB2wKaKQYvtGHfRPDbpUDDq2MeQ6UoAIn0j7Pa0cjMguxPUk07iBW2G8RNUPrabThp2ma7gxcyk0bkxspZxRigaUGrpYFvU0HOC1/GNVDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZbggBApv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 417C1qIk018941;
	Wed, 7 Feb 2024 12:07:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=WTN03rlia1fYtVPWykAVShx/Ou55i03RJrS3PYcZalg=;
 b=ZbggBApvH26MTerYdJXpM0DZT97tHYLC57rUwfdD7r63zGvtwJy8/uSSN3eK+FrwJKe6
 n+Tl3L3P5HFXt/kKCKmSAYDiRa39e6NL9Aqz5OIS184OXGbNS0SLknG+plCgpRGIs956
 8KFcXvYgTJCwV0u1rqrphmOhMxdlvD/ne5VMaCDvOJSfKUhNbGkfyS7UHPAEsGXMoMVV
 s8A18q2ZefWcjvKz6rJnwOFHr3zsd1xbVFNLiszShkuu5vHezK6q5Uxk9fO8MYza8xla
 eANnC5jyag1+i8z15U03to4gXkpr+/xvJ2zhnfQ8QbhDAW8uG71wa1bqktaZP+OOOTzC ng== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w495fgkh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 12:07:39 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4179TmVd019991;
	Wed, 7 Feb 2024 12:07:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w1ytt5t85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 12:07:38 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 417C7bvq23986758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Feb 2024 12:07:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 305FA2004B;
	Wed,  7 Feb 2024 12:07:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD14320040;
	Wed,  7 Feb 2024 12:07:36 +0000 (GMT)
Received: from [9.171.43.244] (unknown [9.171.43.244])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Feb 2024 12:07:36 +0000 (GMT)
Message-ID: <9a062196-ccbe-440e-a2f9-23eb8c5eb837@linux.ibm.com>
Date: Wed, 7 Feb 2024 13:07:36 +0100
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
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <20240207060923.182ecb55@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pZxaHXIU0ArPNDRRR7HuCihoq0I7URgP
X-Proofpoint-ORIG-GUID: pZxaHXIU0ArPNDRRR7HuCihoq0I7URgP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=862 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402070090

On 2/7/24 12:09, Steven Rostedt wrote:
> On Wed, 07 Feb 2024 06:50:59 +0100
> Sven Schnelle <svens@linux.ibm.com> wrote:
> 
>> Hi Steven,
> 
>> Not sure whether that is enough, have to test. However, it's not really
>> a fix, it would just require a bit more load and the test would fail
>> again. The fundamental problem is that even after disabling tracing
>> there might be some tracing line added due to the lockless nature of
>> the ringbuffer. This might then replace some existing cmdline entry.
>> So maybe we should change the test to ignore the program name when
>> calculating the checksums.
> 
> Have you figured out what caused the cmdlines to change when tracing is
> off. It shouldn't be updated even with just 128 entries.
> 
> I'm also looking into a way to keep more of a LRU command lines around,
> but nothing concrete yet.
> 
> -- Steve

Hi,

wouldn't the following scenario explain the behavior we are seeing.
When using event triggers, trace uses lockless ringbuffer control paths.
If cmdline update and trace output reading is happening on different
cpus, the ordering can get messed up.

1. event happens and trace trigger tells ring buffer to stop writes
2. (on cpu#1)test calculates checksum on current state of trace
    output.
3. (on cpu#2)not knowing about the trace buffers status yet, writer adds
    a one last entry which would collide with a pid in cmdline map before
    actually stopping. While (on cpu#1) checksum is being calculated, new
    saved cmdlines entry is waiting for spinlocks to be unlocked and then
    gets added.
4. test calculates checksum again and finds that the trace output has
    changed. <...> is put on collided pid.


