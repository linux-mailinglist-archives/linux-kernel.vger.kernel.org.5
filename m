Return-Path: <linux-kernel+bounces-165858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E87D98B9279
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BB00B22057
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 23:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851B0168B1E;
	Wed,  1 May 2024 23:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="CjKthMws"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFE742A96;
	Wed,  1 May 2024 23:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714607117; cv=none; b=SXGHDzsKhtY785H1j5tDaMuuHOUxJtB/jKyRaQ7W6moeckR/APWVLsQlPRfGCn3bzPfU0PtVSr7/dEAC9kddv8k49puc6z+VOPy3Z7oqu3pUztsX7Q/OW3aIDFNtuJwSxW1I5qrtiLaWC87MD6M8tu0sekWc/O7+OBj+uuos3J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714607117; c=relaxed/simple;
	bh=G4pqX1RMSl4RCZYG0IsdfgPoTzDclcLMoFT8Uh1hu1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LBU0NQc69g3pTNCDVPBDCReUIh+2e3Ud52ZaO6LhNDZ+aNN1MMRKk4gYTRBOEsMPX7TFm+7yAPqDHM8u1Tuhilu54xG/qXmo6BswN17bkdRIEuL/8zKjWzSHZnds5cHoZ9zFrCLkk5Pm0LnkGDWf5CecVepUoeUS9mSvyPdZQNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=CjKthMws; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ut6b0SDeFkL5LMt8SlT7mycy5WHbPm1GhBrY2OAen2o=; b=CjKthMwsLJXjsFlsgkKRHaOJGD
	2WpPy8u5p46Z1R6MfHGCNl48S1JRNPwHK/cJmsjI7Rzn0UeF2TCRXmsf7g74zGEVBNe1oOxUqXgDg
	5VOqxkfsWnmKV6GH/3m/mosxHIqKm2Ic7z3aZpeM2PdYxUHYkF7yzJ5epiVQ90DSDtuFXoO6pxXhH
	XYwnaK+5yaH1F7DC/ejrh2YDh4d/8G3C0iUl33yXtZpBWtVy7qi5W8RvQLPLKTOwHTaTCAUt8CoHP
	0mPbb51pBnan9zydhbUMlyF5qpLdVBnAfBhuLPhWtN4Ue0wIDcD6bikaB0Byd+YfAkwn3Nqg9LePM
	o/emag1w==;
Received: from 201-42-129-95.dsl.telesp.net.br ([201.42.129.95] helo=[192.168.1.111])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1s2Jd0-002mpu-CW; Thu, 02 May 2024 01:44:46 +0200
Message-ID: <f052ff72-72c9-4b83-9285-2cd9d52e5f72@igalia.com>
Date: Wed, 1 May 2024 20:44:36 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] Add FUTEX_SPIN operation
To: Christian Brauner <brauner@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Paul Turner <pjt@google.com>, linux-api@vger.kernel.org,
 Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
 carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Chris Kennelly <ckennelly@google.com>, Ingo Molnar <mingo@redhat.com>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 libc-alpha@sourceware.org, Steven Rostedt <rostedt@goodmis.org>,
 Jonathan Corbet <corbet@lwn.net>, Noah Goldstein <goldstein.w.n@gmail.com>,
 Daniel Colascione <dancol@google.com>, longman@redhat.com,
 kernel-dev@igalia.com
References: <20240425204332.221162-1-andrealmeid@igalia.com>
 <20240426-gaumen-zweibeinig-3490b06e86c2@brauner>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20240426-gaumen-zweibeinig-3490b06e86c2@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Christian,

Em 26/04/2024 07:26, Christian Brauner escreveu:
> On Thu, Apr 25, 2024 at 05:43:31PM -0300, André Almeida wrote:
>> Hi,
>>
>> In the last LPC, Mathieu Desnoyers and I presented[0] a proposal to extend the
>> rseq interface to be able to implement spin locks in userspace correctly. Thomas
>> Gleixner agreed that this is something that Linux could improve, but asked for
>> an alternative proposal first: a futex operation that allows to spin a user
>> lock inside the kernel. This patchset implements a prototype of this idea for
>> further discussion.
>>
>> With FUTEX2_SPIN flag set during a futex_wait(), the futex value is expected to
>> be the PID of the lock owner. Then, the kernel gets the task_struct of the
>> corresponding PID, and checks if it's running. It spins until the futex
>> is awaken, the task is scheduled out or if a timeout happens.  If the lock owner
>> is scheduled out at any time, then the syscall follows the normal path of
>> sleeping as usual.
>>
>> If the futex is awaken and we are spinning, we can return to userspace quickly,
>> avoid the scheduling out and in again to wake from a futex_wait(), thus
>> speeding up the wait operation.
>>
>> I didn't manage to find a good mechanism to prevent race conditions between
>> setting *futex = PID in userspace and doing find_get_task_by_vpid(PID) in kernel
>> space, giving that there's enough room for the original PID owner exit and such
>> PID to be relocated to another unrelated task in the system. I didn't performed
> 
> One option would be to also allow pidfds. Starting with v6.9 they can be
> used to reference individual threads.
> 
> So for the really fast case where you have multiple threads and you
> somehow may really do care about the impact of the atomic_long_inc() on
> pidfd_file->f_count during fdget() (for the single-threaded case the
> increment is elided), callers can pass the TID. But in cases where the
> inc and put aren't a performance sensitive, you can use pidfds.
> 

Thank you very much for making the effort here, much appreciated :)

While I agree that pidfds would fix the PID race conditions, I will move 
this interface to support TIDs instead, as noted by Florian and Peter. 
With TID the race conditions are diminished I reckon?

