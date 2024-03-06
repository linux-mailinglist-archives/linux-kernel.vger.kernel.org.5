Return-Path: <linux-kernel+bounces-94578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9748741B1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5CE283DDF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B6F18EB8;
	Wed,  6 Mar 2024 21:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="MCMBbqGv"
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897DE1400B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 21:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709759668; cv=none; b=D+BAEPTpne7Ya86VFQz0ndcp1LkpjUycjSr7Bu2ykhvp328mz3OBuRSh/nZHrF+g3pS+3QJc+yaG65GjFzbHC54Uxy0hOXt1o2vYK70l3FaPUqNzR+njxbGh5UDeKOSW9MzHoYsMTgMfr2gzU6lVcpydgoM4mFzsvBr5QNfMbIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709759668; c=relaxed/simple;
	bh=ga4zgUFXWs7diRj4vqYeVYM02rIrsgYKm1clvWmkzYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FaBLPKSNItMN9ZYBLMJSZ6mQ8YUtBBjrL0ATr3fk0ieU9uzhqvu9orcS8k/Da04zdcIRVFjdxqzhbEN+zDlWRZrC/hEniPd1aAIr+C8plbE/Vp3ndWufhHlirJImVWxb4Ma3iS3Zm/Qz8raLvB4Xq4Re/x0kSD8Z5zEflkNlEHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=MCMBbqGv; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
	by mx0a-00190b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4269jX6H026694;
	Wed, 6 Mar 2024 20:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	jan2016.eng; bh=emefHZakE6HNZ1TpPWmcBXM7ziPm7C6zlzbUYgZW+jU=; b=
	MCMBbqGv6/9/0Dmqg3neFLdXqR/rsGd4m2XZd2ZibSXwsffSwtp38DnzsEejthNP
	hgpuIatT/m2dtMbGdp35tmFdury1c2Un+ELhjiNsOqI4OkWmx5z2a9zGmzj+KLZn
	ktOhAm5WxhfZQT/CMQirDnZXktJ5IN5ZMz0Sg16UNprbRfIYJBxWEHqIF4iXiwP5
	OUCgHmZp+heZsFQ/XRooFLJdKZOSHOcc5ZdMTs+y3ZYLxhKmuKIQ+XVfTFqEyA0V
	o0hOZhuyMgSXmYoqCnmv+r4zGuQc/fzPgfeRBhODGnGqBjv1xaUDK/cEKmlbwv+5
	Eai8c1Ld2hYMu0xau83f0g==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
	by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 3wnhxwtf17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 20:12:09 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
	by prod-mail-ppoint1.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id 426Fe5wP007558;
	Wed, 6 Mar 2024 15:12:07 -0500
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
	by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 3wm0b238we-1;
	Wed, 06 Mar 2024 15:12:07 -0500
Received: from [172.19.35.123] (bos-lpa4700a.bos01.corp.akamai.com [172.19.35.123])
	by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 4E36F32E9B;
	Wed,  6 Mar 2024 20:12:07 +0000 (GMT)
Message-ID: <854e523c-c467-47f6-b977-933cbaadeb62@akamai.com>
Date: Wed, 6 Mar 2024 15:12:07 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug] WARNING in static_key_disable_cpuslocked
Content-Language: en-US
To: Josh Poimboeuf <jpoimboe@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Sam Sun <samsun1006219@gmail.com>, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, xrivendell7@gmail.com, ardb@kernel.org,
        peterz@infradead.org, linux-mm@kvack.org, akpm@linux-foundation.org,
        Paolo Bonzini <pbonzini@redhat.com>
References: <CAEkJfYNNZftjpYBpnH4tEnm82orKtQ6SQn9i3sg7YNO-Df3tSQ@mail.gmail.com>
 <20240306105420.6a6bea2c@gandalf.local.home>
 <20240306193101.s2g33o4viqi2azf3@treble>
From: Jason Baron <jbaron@akamai.com>
In-Reply-To: <20240306193101.s2g33o4viqi2azf3@treble>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403060162
X-Proofpoint-GUID: JNqldSr41N-PhmmuRCJXIOHnE4atJn4Q
X-Proofpoint-ORIG-GUID: JNqldSr41N-PhmmuRCJXIOHnE4atJn4Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 mlxlogscore=999 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403060163



On 3/6/24 2:31 PM, Josh Poimboeuf wrote:
> On Wed, Mar 06, 2024 at 10:54:20AM -0500, Steven Rostedt wrote:
>> Now I guess the question is, why is something trying to disable something
>> that is not enabled? Is the above scenario OK? Or should the users of
>> static_key also prevent this?
> 
> Apparently that's an allowed scenario, as the jump label code seems to
> be actively trying to support it.  Basically the last one "wins".
> 
> See for example:
> 
>    1dbb6704de91 ("jump_label: Fix concurrent static_key_enable/disable()")
> 
> Also the purpose of the first atomic_read() is to do a quick test before
> grabbing the jump lock.  So instead of grabbing the jump lock earlier,
> it should actually do the first test atomically:

Makes sense but the enable path can also set key->enabled to -1. So I 
think a concurrent disable could then see the -1 in tmp and still 
trigger the WARN. So I think we could change the WARN to be:
WARN_ON_ONCE(tmp != 0 && tmp != -1). And also add a similar check
for enable if we have enable vs enable racing?

Although it seems like the set key->enabled to -1 while used in the 
inc/dec API isn't really doing anything in the enable/disable part here?
But then the key->enabled I think has to move in front of the 
jump_label_update() to make that part work right...

Thanks,

-Jason


> 
> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> index d9c822bbffb8..f29c47930d46 100644
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -191,11 +191,14 @@ EXPORT_SYMBOL_GPL(static_key_slow_inc);
>   
>   void static_key_enable_cpuslocked(struct static_key *key)
>   {
> +	int tmp;
> +
>   	STATIC_KEY_CHECK_USE(key);
>   	lockdep_assert_cpus_held();
>   
> -	if (atomic_read(&key->enabled) > 0) {
> -		WARN_ON_ONCE(atomic_read(&key->enabled) != 1);
> +	tmp = atomic_read(&key->enabled);
> +	if (tmp != 0) {
> +		WARN_ON_ONCE(tmp != 1);
>   		return;
>   	}
>   
> @@ -222,11 +225,14 @@ EXPORT_SYMBOL_GPL(static_key_enable);
>   
>   void static_key_disable_cpuslocked(struct static_key *key)
>   {
> +	int tmp;
> +
>   	STATIC_KEY_CHECK_USE(key);
>   	lockdep_assert_cpus_held();
>   
> -	if (atomic_read(&key->enabled) != 1) {
> -		WARN_ON_ONCE(atomic_read(&key->enabled) != 0);
> +	tmp = atomic_read(&key->enabled);
> +	if (tmp != 1) {
> +		WARN_ON_ONCE(tmp != 0);
>   		return;
>   	}
>   

