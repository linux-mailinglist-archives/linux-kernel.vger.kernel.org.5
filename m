Return-Path: <linux-kernel+bounces-28845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F2A8303AB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 089081C2462C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589BB1CF90;
	Wed, 17 Jan 2024 10:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.hr header.i=@alu.hr header.b="EqerjZEj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="UCZ2W8OW"
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00C41DDC8;
	Wed, 17 Jan 2024 10:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.235.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705487473; cv=none; b=qBwVbZXnJo3Rug8zrqxEYxHNzrWFlj1Y3aO1d9YtVP7MwscPa1vrFt4hSB1Q4UIyYHwjp+bU0L9NjHEJsAnCKKvrjXetEGoZ6/yXU+f1mro4OdDUEugQe1mItLqiO8Y2S8QdEew6MPLsmhFGzIU493empeNXZRPvHdmTg94aJrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705487473; c=relaxed/simple;
	bh=iwSt0dX080YAZAjn6l0J2DH9z0NHNrOKDfSGJeVuk2Q=;
	h=Received:DKIM-Signature:X-Virus-Scanned:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=AsYpUik46Eyk7zrBXocw9UkQ+Rd6SqEbcBJMy4ej/T6Oy+fz2qkVcGZ2wgb1e8mYjxt+p+PwrOJxLh1j4Ct6tbV5RCzmUzqSp1g0rtiR7TJAuk9yrm2biOlLbGfIBs/Jtx1WmGUXuOY84o9PSANjChd8DmYQWg5+HCbcW+OWGYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alu.hr; spf=pass smtp.mailfrom=alu.hr; dkim=pass (2048-bit key) header.d=alu.hr header.i=@alu.hr header.b=EqerjZEj; dkim=fail (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=UCZ2W8OW reason="signature verification failed"; arc=none smtp.client-ip=161.53.235.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alu.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id C14606017C;
	Wed, 17 Jan 2024 11:30:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.hr; s=mail;
	t=1705487458; bh=iwSt0dX080YAZAjn6l0J2DH9z0NHNrOKDfSGJeVuk2Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EqerjZEjtm+TYGTrkvZPBdK3LDNPyshZ60TIZ4IrfuBJQp27noPbojxqjy2OSfC8m
	 JEh6pqhDqa3TqL/NofyF4qkdH2S3WCm6ALq/QjCpfsm/1r0MLkYxGC4TCdTQzMiAqX
	 dAAkh+M/oUMY44Z6J1ExB8aPRRnKBZCCGMPqzbKn66MUMWHcZbTu+1Ig8JP9D5B/aS
	 O6CnZkk/uQTQh9zmBmKahW3zcZiTK9fJWQJ2QbN/bPa61+qJ8QxGjLoSbdwWOFrQ8j
	 +OxFp3ia/qOTQDAYXhseMBW9A0Q8GZNU5sY0qxC3sWLuzMPYERid1gyGC07ZgjwRbD
	 HHQoWq4WaOhIQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eKV4VozrfsID; Wed, 17 Jan 2024 11:30:56 +0100 (CET)
Received: from [10.0.1.190] (unknown [161.53.83.23])
	by domac.alu.hr (Postfix) with ESMTPSA id 3681860177;
	Wed, 17 Jan 2024 11:30:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1705487456; bh=iwSt0dX080YAZAjn6l0J2DH9z0NHNrOKDfSGJeVuk2Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UCZ2W8OWe6R7kIOQORPkPRTQEi4uf3Ss1maQsrE0OcNLWMYJbGVY1S2+JxcnaQtaA
	 2Dk0gsR4EhZp5UXV+qjyj4Z3w1wtPHOcZ5isE+fPLlRveY2R+IuoQXF9ZR6nTF02a5
	 41z4NCbpfCr7qVugG3F2JQ8XAw556XGtER+dKO1gJ5vXwV1qBcVMeHjJXp8731lmb/
	 ate34pEnVTz4Po8vQwNrtVkXb3fOGsHhj6EiwYmNCzsvd6IJW/VyPWQn949ExMCsPs
	 4HkL8OFm0fff45WNsQA9Z0uio/4meJ4LWTKH2/EwxNc+JZjq7VN6o+O9zmEal1DY2Z
	 ScsjErwWMm3Xg==
Message-ID: <4523ad21-d06a-4ba2-9b46-974a6093b189@alu.unizg.hr>
Date: Wed, 17 Jan 2024 11:30:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.7 021/108] r8169: improve RTL8411b phy-down
 fixup
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
 Simon Horman <horms@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 nic_swsd@realtek.com, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20240116194225.250921-1-sashal@kernel.org>
 <20240116194225.250921-21-sashal@kernel.org>
 <20240116174315.2629f21c@kernel.org>
From: Mirsad Todorovac <mirsad.todorovac@alu.hr>
In-Reply-To: <20240116174315.2629f21c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/17/24 02:43, Jakub Kicinski wrote:
> On Tue, 16 Jan 2024 14:38:47 -0500 Sasha Levin wrote:
>> Mirsad proposed a patch to reduce the number of spinlock lock/unlock
>> operations and the function code size. This can be further improved
>> because the function sets a consecutive register block.
> 
> Clearly a noop and a lot of LoC changed. I vote to drop this from
> the backport.

Dear Jakub,

I will not argue with a senior developer, but please let me plead for the
cause.

There are a couple of issues here:

1. Heiner's patch generates smaller and faster code, with 100+
spin_lock_irqsave()/spin_unlock_restore() pairs less.

According to this table:

[1] https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/perfbook/perfbook-1c.2023.06.11a.pdf#table.3.1

The cost of single lock can be 15.4 - 101.9 ns (for the example CPU),
so total savings would be 1709 - 11310 ns. But as the event of PHY power
down is not frequent, this might be a insignificant saving indeed.

2. Why I had advertised atomic programming of RTL registers in the first
place?

The mac_ocp_lock was introduced recently:

commit 91c8643578a21e435c412ffbe902bb4b4773e262
Author: Heiner Kallweit <hkallweit1@gmail.com>
Date:   Mon Mar 6 22:23:15 2023 +0100

     r8169: use spinlock to protect mac ocp register access

     For disabling ASPM during NAPI poll we'll have to access mac ocp
     registers in atomic context. This could result in races because
     a mac ocp read consists of a write to register OCPDR, followed
     by a read from the same register. Therefore add a spinlock to
     protect access to mac ocp registers.

     Reviewed-by: Simon Horman <simon.horman@corigine.com>
     Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
     Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
     Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
     Signed-off-by: David S. Miller <davem@davemloft.net>

Well, the answer is in the question - the very need for protecting the access
to RTL_W(8|16|32) with locks comes from the fact that something was accessing
the RTL card asynchronously.

Forgive me if this is a stupid question ...

Now - do we have a guarantee that the card will not be used asynchronously
half-programmed from something else in that case, leading to another spurious
lockup?

IMHO, shouldn't the entire reprogramming of PHY down recovery of the RTL 8411b
be done atomically, under a single spin_lock_irqsave()/spin_unlock_irqrestore()
pair?

Best regards,
Mirsad Todorovac

-- 
CARNet system engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb

CARNet sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu


