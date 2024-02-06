Return-Path: <linux-kernel+bounces-54385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2CA84AE9F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3371C20A0E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAA7128817;
	Tue,  6 Feb 2024 07:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bg93yf9p"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBC33D54A;
	Tue,  6 Feb 2024 07:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707203120; cv=none; b=U3kVMijZ56WsQhzqr+lxLBmWXgmPXL92Zi/xP/bKbhCVi1IHMGQLJx8AyWgac8QNU/od+luR/3BlbZgOJRFxZzKk3ffM2AFIVGPuXjXXjTQ0gIpf24NPMNehKnAzSxYLheTy1Rebyc5e1h64KRuPLqv/TMqXZYpmCDpTMSYkKT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707203120; c=relaxed/simple;
	bh=8OOrirsFiRy+jWhBqLtOU1x+le6UyiBmtrdSLeywYtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UFp/MX1EkK5fB/ZnpT61IEFeL63VG0R0/mO4FYy97h6FOS2ZJHhqDgu7Or1MDjCWS0C3j3WwsWLYxnmy5HVO1BQSbp6ClioPqCP745In47S7Exy2znjDAX44y6P0IsYEKG01/pEUH8B5yyCutMWGUcnPd1iP9dltmvtnXtxhSqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bg93yf9p; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41671T8f030646;
	Tue, 6 Feb 2024 07:05:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=oubYTPzQSYjeDnzcKC/PnXh+JcfYD5SlolpovnPWjdI=;
 b=bg93yf9poH+ZDELZY9yzTGmRj8fIH0ujT6Q63iSqOwC4rz0giurLn6WfWNaF3ZG6ifQO
 QvmF5Zwbd9pJJlP/N1Iww5MZni8noEq/I+QyeN8AVifuQUMdqVunZ58XzpOGt3FZyg23
 LPt4cD0sPnTyNTGPxO0isG3V4d7yS4unKvPOQMvpuftXb6rh/h0jBa29caVpDvXWbYlm
 MjOlba3CGbzCFpvow1ZSHoFli+iaz69SjeVadkn/RFqaaEl5s3+mn4gbPOxTA2xWL25B
 JJ2tv+YX6A3WLLCj2AQJpLIKXS8+LXoPbhWpZEQbbZ+0tDMgfOavpmTZGz8UQNXTrHrF Uw== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w3fnj8k3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 07:05:06 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4166pf7i005421;
	Tue, 6 Feb 2024 07:05:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w21akd9u5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 07:05:04 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 416752wu39584124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Feb 2024 07:05:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BBF020043;
	Tue,  6 Feb 2024 07:05:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F56C20040;
	Tue,  6 Feb 2024 07:05:02 +0000 (GMT)
Received: from [9.152.212.156] (unknown [9.152.212.156])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Feb 2024 07:05:02 +0000 (GMT)
Message-ID: <35d17995-8707-4ddc-879b-9ed89d292c91@linux.ibm.com>
Date: Tue, 6 Feb 2024 08:05:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: use ring_buffer_record_is_set_on() in
 tracer_tracing_is_on()
To: Sven Schnelle <svens@linux.ibm.com>, Steven Rostedt
 <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20240205065340.2848065-1-svens@linux.ibm.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <20240205065340.2848065-1-svens@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7jn7VMlhO6aBxIcF0qfoBiZ3kpz_4ToD
X-Proofpoint-GUID: 7jn7VMlhO6aBxIcF0qfoBiZ3kpz_4ToD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_18,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 mlxlogscore=940
 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402060048

On 2/5/24 07:53, Sven Schnelle wrote:
> tracer_tracing_is_on() checks whether record_disabled is not zero. This
> checks both the record_disabled counter and the RB_BUFFER_OFF flag.
> Reading the source it looks like this function should only check for
> the RB_BUFFER_OFF flag. Therefore use ring_buffer_record_is_set_on().
> This fixes spurious fails in the 'test for function traceon/off triggers'
> test from the ftrace testsuite when the system is under load.
> 
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>   kernel/trace/trace.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 2a7c6fd934e9..47e221e1e720 100644

Tested-By: Mete Durlu <meted@linux.ibm.com>

