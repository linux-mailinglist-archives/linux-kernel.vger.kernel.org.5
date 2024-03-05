Return-Path: <linux-kernel+bounces-91619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FDF87144C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBB591F2417F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7AF38FB2;
	Tue,  5 Mar 2024 03:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="F6SSSykS"
Received: from out203-205-251-80.mail.qq.com (out203-205-251-80.mail.qq.com [203.205.251.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E99729CFE;
	Tue,  5 Mar 2024 03:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709609437; cv=none; b=OqDxGGxPGQRXiBNnNnDE8FhP2aELn+fIf7e47CeaNnupnej8IzIb6Q5307YPad3uhgMxuzBnJAgUSpQIsQuT4k056C8k/HJrFVQozf23iddw4iGlcNHkWITZwrHt/oJw9CyuSUyOGVlMVhmpGfOmpAuLY25AWCq7mdlUwNkRPOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709609437; c=relaxed/simple;
	bh=lQ8Kjv0cR7uSFIU3UHCqcBAPrZckuBw+DO0qfNJIuk4=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=N/okfzd00k37tc48ICMMK6zGj+9acCY0QWRN2DNsSFAAx/fAjwncE5I82kOm1J+HSX3E74HWZ+CEgqWodkUYhA3E+eMuFquHGD+1rxSc9Z0r1vHDJ5zFHHgsUUa1FZqederJ6D7D9R2f5JuShK8SSayH56UxxH1ezrmIVnEYtt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=F6SSSykS; arc=none smtp.client-ip=203.205.251.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709609432; bh=XTTyZe6yfmWl5Yz80sSkDqdfIhQ7dsX0F5Wl3RTRwjg=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=F6SSSykSVHnXuCLJwg2pQdjhRaEzECRA6+LbQ7q+R3Sh7nD+TCafTXw3Wcr7WRMHy
	 Y6HYPJgRkHh3mx0Enxej2aD2tfRZun1XjSnkngh4SNXjHWYzv01sp8er0BQhAxcr6z
	 Fi57OkkR8c/udANl9fBl6kzm+8CrPvkAlbpym05U=
Received: from smtpclient.apple ([218.94.142.74])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 79D3C2CC; Tue, 05 Mar 2024 11:30:29 +0800
X-QQ-mid: xmsmtpt1709609429t6nn547dj
Message-ID: <tencent_2E076343DA2D43D9B05F9DE3A01E0ACF2407@qq.com>
X-QQ-XMAILINFO: MFdGPHhuqhNo8kGylBpk9VRGhycbdvPpiulEO06TXfpsLgRfCdXEs2JwyujlD9
	 b5l75eoTXQB6bFZPWaFguZ5MSe099DyKGkaENtgsHOUkIhrdFNeYi6x7qF/rmzFqVNGEvMqPTHIq
	 +5YerZH1R/5Fb5de40L6gZ9osP85m0eYsDVfF58vHoxPHNcH5eUI5VuDzHgmf5GfUax/QVHA8UvV
	 DkP1msYXd83UZZSpRsE5CmbXeXPAKaF6NfgRQ4umHxf5NXwucIJhJKBdcRd5eLNvLP0LeGJC/sUa
	 4W/kHDJrp0hgDKRjwyoJat8FwJXy7ve+lVcrhMa987gQ4hoMGoc+ljVuKEq2gxhYslETn509bI3O
	 BBu4n75/oi/RcVtFDRZw1EhoueAbbpVp+BkqayUsDs5n0NgtC72LFYg3RWi4J0LMMKqMprdvPiai
	 gF3EZ9lfNGk+e5lfag0PH4T7AbNnSL+B1kPh99RD4ZlZWBkuAhK4cpNWtTbdjJc5/Y42nm5+KMiu
	 9R89Gb5z1YYyY9POBoh8dR6BJgvmnCOl03SN9/sHHKeQbtUn5VCrkq3jJRpEhEAQeZvlo05q/i6n
	 kfA64c0ZNt5Sr3WVou0sRoSKG/rlLOWgOjEYge16nfmBKK6We6E3i6nn0jO9IEUrP2SrofN7hJhO
	 bj7wFdjBd+v4DcQYTiN+fpqqFdFvDIMvikTR9XqclPwjSDapjAS74OuZkhXkdnmlqjdsi2/oLxx1
	 lQ1PtOpVOEPZ8bYef6131E+rx402fTEe2s5hBPu/Nm63uTylpDXBfIILJsrKYxQ2q6HCKEZWw00Y
	 OpKUsxkeLNlgSSJ4VBTqfUv0S4WBR4CKILeWzIGokuIIg0N5J+41ADlHLMbOUu0wqRUledI+esFy
	 O9EqSqT1Ua6Z6jOrn7FFLF+tF01uA/28P+hPWOpEnZxQLiatFMN/8UxK3h8yM0X/VTE1+67m/6AF
	 pA6wQJEvUGpem/f2L7Jw==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] rcutorture: Fix
 rcu_torture_pipe_update_one()/rcu_torture_writer() data race and concurrency
 bug
From: linke <lilinke99@qq.com>
In-Reply-To: <0640c3b9-fa19-4c2d-9158-a6aa5b398da3@paulmck-laptop>
Date: Tue, 5 Mar 2024 11:30:18 +0800
Cc: Joel Fernandes <joel@joelfernandes.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Josh Triplett <josh@joshtriplett.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <quic_neeraju@quicinc.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>,
 linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <A2FCFD70-2D2B-4D23-A3C7-DE9D6C2DF064@qq.com>
References: <tencent_B51A9DA220288A95A435E3435A0443BEB007@qq.com>
 <f3624f39-bbb1-451d-8161-8518e4108d8e@joelfernandes.org>
 <4857c5ef-bd8f-4670-87ac-0600a1699d05@paulmck-laptop>
 <a8e9c84f-c354-4536-b676-d38043913d09@joelfernandes.org>
 <a9ff4787-1b07-4d47-b2a0-5eb1336d3710@paulmck-laptop>
 <51c4b25f-1cdc-4bcc-8b40-c98096bebacf@joelfernandes.org>
 <0640c3b9-fa19-4c2d-9158-a6aa5b398da3@paulmck-laptop>
To: paulmck@kernel.org
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Thank you both. This looks good to me. I will send a new patch.

> 2024=E5=B9=B43=E6=9C=885=E6=97=A5 04:47=EF=BC=8CPaul E. McKenney =
<paulmck@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Mon, Mar 04, 2024 at 03:13:10PM -0500, Joel Fernandes wrote:
>>=20
>>=20
>> On 3/4/2024 2:44 PM, Paul E. McKenney wrote:
>>> On Mon, Mar 04, 2024 at 02:10:09PM -0500, Joel Fernandes wrote:
>>>>=20
>>>>=20
>>>> On 3/4/2024 12:14 PM, Paul E. McKenney wrote:
>>>>> On Mon, Mar 04, 2024 at 11:19:21AM -0500, Joel Fernandes wrote:
>>>>>>=20
>>>>>>=20
>>>>>> On 3/4/2024 5:54 AM, linke li wrote:
>>>>>>> Some changes are done to fix a data race in commit 202489101f2e =
("rcutorture: Fix rcu_torture_one_read()/rcu_torture_writer() data =
race")
>>>>>>>=20
>>>>>>> {
>>>>>>> 	int i;
>>>>>>>=20
>>>>>>> -	i =3D rp->rtort_pipe_count;
>>>>>>> +	i =3D READ_ONCE(rp->rtort_pipe_count);
>>>>>>> 	if (i > RCU_TORTURE_PIPE_LEN)
>>>>>>> 		i =3D RCU_TORTURE_PIPE_LEN;
>>>>>>> 	atomic_inc(&rcu_torture_wcount[i]);
>>>>>>> -	if (++rp->rtort_pipe_count >=3D RCU_TORTURE_PIPE_LEN) {
>>>>>>> +	WRITE_ONCE(rp->rtort_pipe_count, i + 1);
>>>>>>> +	if (rp->rtort_pipe_count >=3D RCU_TORTURE_PIPE_LEN) {
>>>>>>> 		rp->rtort_mbtest =3D 0;
>>>>>>> 		return true;
>>>>>>> 	}
>>>>>>>=20
>>>>>>> But ++rp->rtort_pipe_count is meant to add itself by 1, not give =
i+1 to
>>>>>>> rp->rtort_pipe_count, because rp->rtort_pipe_count may write by
>>>>>>> rcu_torture_writer() concurrently.
>>>>>>>=20
>>>>>>> Also, rp->rtort_pipe_count in the next line should be read using
>>>>>>> READ_ONCE() because of data race.
>>>>>>>=20
>>>>>>> Signed-off-by: linke li <lilinke99@qq.com>
>>>>>>> ---
>>>>>>> kernel/rcu/rcutorture.c | 4 ++--
>>>>>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>>=20
>>>>>>> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
>>>>>>> index 7567ca8e743c..00059ace4fd5 100644
>>>>>>> --- a/kernel/rcu/rcutorture.c
>>>>>>> +++ b/kernel/rcu/rcutorture.c
>>>>>>> @@ -465,8 +465,8 @@ rcu_torture_pipe_update_one(struct =
rcu_torture *rp)
>>>>>>> 	if (i > RCU_TORTURE_PIPE_LEN)
>>>>>>> 		i =3D RCU_TORTURE_PIPE_LEN;
>>>>>>> 	atomic_inc(&rcu_torture_wcount[i]);
>>>>>>> -	WRITE_ONCE(rp->rtort_pipe_count, i + 1);
>>>>>>> -	if (rp->rtort_pipe_count >=3D RCU_TORTURE_PIPE_LEN) {
>>>>>>> +	WRITE_ONCE(rp->rtort_pipe_count, rp->rtort_pipe_count + =
1);
>>>>>>> +	if (READ_ONCE(rp->rtort_pipe_count) >=3D =
RCU_TORTURE_PIPE_LEN) {
>>>>>>=20
>>>>>> I want to say, I am not convinced with the patch because what's =
wrong with
>>>>>> writing to an old index?
>>>>>>=20
>>>>>> You win/lose the race anyway, say the CPU executed the =
WRITE_ONCE() a bit too
>>>>>> early/late and another WRITE_ONCE() lost/won, regardless of =
whether you wrote
>>>>>> the "incremented i" or "the increment from the latest value of =
pipe_count".
>>>>>>=20
>>>>>> Anyway, a slightly related/different question:
>>>>>>=20
>>>>>> Should that:
>>>>>> WRITE_ONCE(rp->rtort_pipe_count, rp->rtort_pipe_count + 1);
>>>>>>=20
>>>>>> Be:
>>>>>> WRITE_ONCE(rp->rtort_pipe_count, READ_ONCE(rp->rtort_pipe_count) =
+ 1);
>>>>>>=20
>>>>>> ?
>>>>>=20
>>>>> Thank you both!
>>>>>=20
>>>>> At first glance, I would argue for something like this:
>>>>>=20
>>>>> =
------------------------------------------------------------------------
>>>>>=20
>>>>> static bool
>>>>> rcu_torture_pipe_update_one(struct rcu_torture *rp)
>>>>> {
>>>>> 	int i;
>>>>> 	struct rcu_torture_reader_check *rtrcp =3D =
READ_ONCE(rp->rtort_chkp);
>>>>>=20
>>>>> 	if (rtrcp) {
>>>>> 		WRITE_ONCE(rp->rtort_chkp, NULL);
>>>>> 		smp_store_release(&rtrcp->rtc_ready, 1); // Pair with =
smp_load_acquire().
>>>>> 	}
>>>>> 	i =3D READ_ONCE(rp->rtort_pipe_count) + 1;
>>>>> 	if (i > RCU_TORTURE_PIPE_LEN)
>>>>> 		i =3D RCU_TORTURE_PIPE_LEN;
>>>>> 	atomic_inc(&rcu_torture_wcount[i]);
>>>>> 	WRITE_ONCE(rp->rtort_pipe_count, i);
>>>>> 	if (i >=3D RCU_TORTURE_PIPE_LEN) {
>>>>> 		rp->rtort_mbtest =3D 0;
>>>>> 		return true;
>>>>> 	}
>>>>> 	return false;
>>>>> }
>>>>>=20
>>>>> =
------------------------------------------------------------------------
>>>>>=20
>>>>> That is, move the increment to the read and replace the re-read =
with
>>>>> the value "i" that was just written.
>>>>=20
>>>> But that changes the original logic as well? It looks like with the =
above
>>>> change, you're now writing to =
rcu_torture_wcount[READ_ONCE(rp->rtort_pipe_count)
>>>> + 1] instead of =
rcu_torture_wcount[READ_ONCE(rp->rtort_pipe_count)].
>>>>=20
>>>> I think that might break rcutorture, because there is an increment =
outside of
>>>> the first 2 entries in rcu_torture_wcount but not sure (need to =
look more).
>>>=20
>>> Good point on never incrementing the zeroth entry!  Clearly I should
>>> have waited before replying.
>>>=20
>>> How about the following?
>>>=20
>>> =
------------------------------------------------------------------------
>>>=20
>>> static bool
>>> rcu_torture_pipe_update_one(struct rcu_torture *rp)
>>> {
>>> 	int i;
>>> 	struct rcu_torture_reader_check *rtrcp =3D =
READ_ONCE(rp->rtort_chkp);
>>>=20
>>> 	if (rtrcp) {
>>> 		WRITE_ONCE(rp->rtort_chkp, NULL);
>>> 		smp_store_release(&rtrcp->rtc_ready, 1); // Pair with =
smp_load_acquire().
>>> 	}
>>> 	i =3D READ_ONCE(rp->rtort_pipe_count);
>>> 	if (i > RCU_TORTURE_PIPE_LEN)
>>> 		i =3D RCU_TORTURE_PIPE_LEN;
>>> 	atomic_inc(&rcu_torture_wcount[i]);
>>> 	WRITE_ONCE(rp->rtort_pipe_count, i + 1);
>>> 	if (i + 1 >=3D RCU_TORTURE_PIPE_LEN) {
>>> 		rp->rtort_mbtest =3D 0;
>>> 		return true;
>>> 	}
>>> 	return false;
>>> }
>>=20
>> Yes, this looks good to me. Thanks,
>> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>=20
> Again, thank you.
>=20
> linke li, does this approach work for you?  If so, would you be =
willing to
> send a new patch along these lines?  If it does not work, what =
additional
> problems do you see?
>=20
> 							Thanx, Paul


