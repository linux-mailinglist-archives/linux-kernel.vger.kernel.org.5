Return-Path: <linux-kernel+bounces-84740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 175AB86AAF0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B3D28732B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F8C2E62B;
	Wed, 28 Feb 2024 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="1bRsgAC9"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD322D605;
	Wed, 28 Feb 2024 09:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709111362; cv=none; b=GjnIX77xJnqmLr92F3b6Y6/wJwd6p46psDu/oCVxdp8jagiX3Qz8grtAtLWBIJg+SlrWUN+TRuE0RZaUpkvDfzZI4x/hlSsk0YzRT/1ejnG9A6OvK5fuK4kQ70Uf6zqAn5311NjWY7ZZDbQ6NFun33CBZn0i5YsQTKM1ZTVxYPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709111362; c=relaxed/simple;
	bh=PUo2nuzZfsQJk0wJ4A+TlJb/U4OyoYIe7zyKbRAH2j4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K1Y8Beuc0eTpAMGK5HTPLKHAbMUiBUk8ON3pc5fCBJ4RiKq5UZNxMthQQjWrWNfGhqQuY1G0nv18t/gRCjZMiRbhbmPqa4Lm/hWJH3d4S7VYFLZnx/0PP/w6Tz6SI3TAwZ6Getnm80l5KRgtXletTU6vJ4srhUXPn8Oddo7OUfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=1bRsgAC9; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=ihAIQavaiuL126frFYxJ2J//2OLR+lm4YBVeYk3AGSM=;
	t=1709111360; x=1709543360; b=1bRsgAC9aFQOu7f+zrKhF6ecB+vT/g0rBKrFwDzkiwF8xBq
	r/1azdWzS8Hty/lYbMLJQRjpzzoUuJeSTffY2qXP4HXh2xp1e/IM6237DNyXrrngrjR+nx6vvjQcm
	+kT/dOWJ9Vdh0Xrwyax3rwWIvm2gFESE40axQjup2ZMu884BAya6stNJ7iU6WJ3FLkow78dsr43he
	GVpvc60ksZuimeTyd637NppIm/MVtUzWW7J2e0tUfvrFrVAH90LcFKy96xpocrDO4685hmUAh168C
	TfhwXE7/ssFH/3pL2bHPv1wQcYzySTu0R3JEI7VAUUAA34m+Ke3Yi3Xy1oDiy7fQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rfFw5-0000L9-8a; Wed, 28 Feb 2024 10:09:09 +0100
Message-ID: <8015b1f0-d37b-45de-bd24-12fc21cbf83d@leemhuis.info>
Date: Wed, 28 Feb 2024 10:09:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Network performance regression in Linux kernel 6.6 for small
 socket size test cases
Content-Language: en-US, de-DE
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Abdul Anshad Azeez <abdul-anshad.azeez@broadcom.com>, edumazet@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 dsahern@kernel.org, Linux Networking <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>
Cc: Boon Ang <boon.ang@broadcom.com>, John Savanyo
 <john.savanyo@broadcom.com>, Peter Jonasson <peter.jonasson@broadcom.com>,
 Rajender M <rajender.m@broadcom.com>
References: <CALkn8kLOozs5UO52SQa9PR-CiKx_mqW8VF9US94qN+ixyqnkdQ@mail.gmail.com>
 <Zd7vqSnT6ocYLuZ4@archie.me>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <Zd7vqSnT6ocYLuZ4@archie.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1709111360;82913b45;
X-HE-SMSGID: 1rfFw5-0000L9-8a

On 28.02.24 09:32, Bagas Sanjaya wrote:
> [also Cc: regressions ML]
> 
> On Wed, Feb 28, 2024 at 12:13:27PM +0530, Abdul Anshad Azeez wrote:
>> During performance regression workload execution of the Linux
>> kernel we observed up to 30% performance decrease in a specific networking
>> workload on the 6.6 kernel compared to 6.5 (details below). The regression is
>> reproducible in both Linux VMs running on ESXi and bare metal Linux.
>>
>> [...]
>>
>> We would like to know if there are any opportunities for optimization in
>> the test cases with small socket sizes.
> 
> Can you verify the regression on current mainline (v6.8-rc6)?

Bagas, I know that you are trying to help, but this is not helpful at
all (and indirectly puts regression tracking and the kernel development
community into a bad light).

Asking that question can be the right thing sometimes, for example in a
bugzilla ticket where the reporter is clearly reporting their first bug.
But the quoted report above clearly does not fall into that category for
various obvious reasons.

If you want to ensure that reports like that are acted upon, wait at
least two or three work days and see if there is a reply from a
developer. In case there is none (which happens, but I assume for a bug
report like this is likely rare) prodding a bit can be okay. But even
then you definitely want to use a more friendly tone. Maybe something
like "None of the developers reacted yet; maybe none of them bothered to
take a closer look because it's unclear if the problem still happens
with the latest code. You thus might want to verify and report back if
the problem happens with latest mainline, maybe then someone will take a
closer look".

Okay, that has way too many "maybe" in it, but I'm sure you'll get the
idea. :-D

Ciao, Thorsten




