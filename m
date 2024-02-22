Return-Path: <linux-kernel+bounces-76724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC42A85FB90
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE20A1C23249
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2371D14A4E4;
	Thu, 22 Feb 2024 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbjGzWym"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E1C149005;
	Thu, 22 Feb 2024 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708613392; cv=none; b=ubzYMkucjlry5BFTbMqlHMH8npCj8X91BPKiRLzFPO4Y4kcS8xTuvOQmnhQZ5RrX4PRe0hV6wQbQJ4GJIrm1szv6dFtZIkTpX3ewHZOXHc53foC3u9eF1qnOu0p8BDuE0IlEGrIoy5/oyVf0+meeZR9QYJJHXAg2XbSgoYpOCiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708613392; c=relaxed/simple;
	bh=bSPci0PAXJevpU6azQzccIzmgmJ88MybrYQxtc3CGCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h1ALO13v/mlO9JZaiU5ee3k04CEqkkL63ixWD0EwRja9Zeb09Hdu+LFmrUiTt0Yj48QDn/X31Dwqt74Vd7IRlvWnUy0jwjusL3cIsxp+RMM6+NdD2KaddIRrXWnl0MN47ZA4rluRdWmOMXmoK+i/zGtpXycoCULJV9LnN9s9tVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbjGzWym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E47C433C7;
	Thu, 22 Feb 2024 14:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708613391;
	bh=bSPci0PAXJevpU6azQzccIzmgmJ88MybrYQxtc3CGCQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AbjGzWymgfburQ/RvWl8P4lwZBkeM3KRlzpQT7k6ql3kiskLU46IjJmUbLhF6Zgju
	 HB5TQveMAqYkOtNlWqgHJI/7aPobUwqK4U57Iapy6U9wFWxK3letUE4aeKegLQREr0
	 fsGoRc3defms8Tvg7DTbdhsc/RdI31LWGzK2SXrVrJo8lnW1wrrZRh2p7WMGUNOla+
	 9y1xrozDbPf/O0datTDC1XGeot/5Vta3FV6oXnZD6RTdCWlxLs7ALHFP7i4fcqDEo8
	 0zQRvjwyc4ZjzabcX4ogCZOUk61oodgLc4giJedkcIb5gBb+Efze3kOwMtaQvbPTea
	 7Exo8N28I2qig==
Message-ID: <22424f1c-3f76-454d-9de4-486c3f2f2478@kernel.org>
Date: Thu, 22 Feb 2024 15:49:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] selftests: mptcp: explicitly trigger the listener
 diag code-path
Content-Language: en-GB, fr-BE
To: Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Shuah Khan <shuah@kernel.org>, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <cover.1708515908.git.pabeni@redhat.com>
 <1116d80f808ea870f3f77fe927dbd6c622d062ae.1708515908.git.pabeni@redhat.com>
 <20240222131338.GA960874@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240222131338.GA960874@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Simon,

Thank you for the review!

On 22/02/2024 2:13 pm, Simon Horman wrote:
> On Wed, Feb 22, 2024 at 12:46:59PM +0100, Paolo Abeni wrote:
>> l The mptcp diag interface already experienced a few locking bugs
>> that lockdep and appropriate coverage have detected in advance.
>>
>> Let's add a test-case triggering the relevant code path, to prevent
>> similar issues in the future.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>>  tools/testing/selftests/net/mptcp/diag.sh | 30 +++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
>> index 60a7009ce1b5..3ab584b38566 100755
>> --- a/tools/testing/selftests/net/mptcp/diag.sh
>> +++ b/tools/testing/selftests/net/mptcp/diag.sh
>> @@ -81,6 +81,21 @@ chk_msk_nr()
>>  	__chk_msk_nr "grep -c token:" "$@"
>>  }
>>  
>> +chk_listener_nr()
>> +{
>> +	local expected=$1
>> +	local msg="$2"
>> +
>> +	if [ $expected -gt 0 ] && \
>> +	   ! mptcp_lib_kallsyms_has "mptcp_diag_dump_listeners"; then
>> +		printf "%-50s%s\n" "$msg - mptcp" "[ skip ]"
>> +		mptcp_lib_result_skip "many listener sockets"
>> +	else
>> +		__chk_nr "ss -inmlHMON $ns | wc -l" "$expected" "$msg - mptcp"
>> +	fi
>> +	__chk_nr "ss -inmlHtON $ns | wc -l" "$expected" "$msg - subflows"
>> +}
>> +
>>  wait_msk_nr()
>>  {
>>  	local condition="grep -c token:"
>> @@ -279,5 +294,20 @@ flush_pids
>>  chk_msk_inuse 0 "many->0"
>>  chk_msk_cestab 0 "many->0"
>>  
>> +chk_listener_nr 0 "no listener sockets"
>> +NR_SERVERS=100
>> +for I in $(seq 1 $NR_SERVERS); do
>> +	ip netns exec $ns ./mptcp_connect -p $((I + 20001)) -l 0.0.0.0 2>&1 >/dev/null &
>> +	mptcp_lib_wait_local_port_listen $ns $((I + 20001))
>> +done
>> +
>> +chk_listener_nr $NR_SERVERS "many listener sockets"
>> +
>> +# gracefull termination
> 
> nit, as you plan to re-spin anyway: graceful

Paolo sent a new version on MPTCP ML only. When applying the new
version, I fixed this:

https://lore.kernel.org/mptcp/e98b8b07-558c-498a-97fb-dd5cab11e439@kernel.org/

>> +for I in $(seq 1 $NR_SERVERS); do
>> +	echo a | ip netns exec $ns ./mptcp_connect -p $((I + 20001)) 127.0.0.1 2>&1 >/dev/null
> 
> I'm not sure of the validity of this but shellcheck complains that:
> 
>   SC2069 (warning): To redirect stdout+stderr, 2>&1 must be last (or use '{ cmd > file; } 2>&1' to clarify).
> 
> Also for the same constriction slightly earlier in this patch.

Good catch!

I should add shellcheck support in our CI to catch that :)

I just applied the suggested modification in our tree [1]. The new
version that will be sent to netdev will no longer have this issue.

https://github.com/multipath-tcp/mptcp_net-next/commit/31f1460d552c

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

