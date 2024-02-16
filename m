Return-Path: <linux-kernel+bounces-68092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB378575E5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A991F233A8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222A51401F;
	Fri, 16 Feb 2024 06:15:51 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768A6134A9;
	Fri, 16 Feb 2024 06:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708064150; cv=none; b=oRY1RMBX75sn/5swBH3FqwORphsTilDQVtOtfo9DYgx3ESKPADhUkr1qADxOpt9GKeHlIQYSKbd1EwxJxyAIVpw3aw1efGfBXwaAVfJkuO4cxqYP+6TfeZCqsUbyP9bnpqSHU/4UogTq5FO8I6G2PIW8eh04psjG3s3El4VxAS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708064150; c=relaxed/simple;
	bh=Ubc/MvalYUWkd+30i+jxBtN9hVIKtcmQjeQHCy0qO6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ua9UQPCSkiKaf4BFcM5GdhwpYMvcuSc0Cons1RIQaJ0McrOMiamJY5V0BTvdXVHZ6iJiXaxvn9PMJdgA19WouOSD2GfZPvnGwNCGlmE2r3cS2g5wiClNJO7feUqhjYQLINdPYxaqlf7QTgiaNiiHYatSEDgnnR1+tvvjrDnfFSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rarVh-00045P-0e; Fri, 16 Feb 2024 07:15:45 +0100
Message-ID: <379b81ae-b95e-4a55-ab42-597c58c3fe35@leemhuis.info>
Date: Fri, 16 Feb 2024 07:15:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: =?UTF-8?Q?Re=3A_This_is_the_fourth_time_I=C3=A2ve_tried_to_find_wha?=
 =?UTF-8?Q?t_led_to_the_regression_of_outgoing_network_speed_and_each_time_I?=
 =?UTF-8?Q?_find_the_merge_commit_8c94ccc7cd691472461448f98e2372c75849406c?=
Content-Language: en-US, de-DE
To: Mathias Nyman <mathias.nyman@linux.intel.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: "Christian A. Ehrhardt" <lk@c--e.de>, niklas.neronin@linux.intel.com,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com>
 <Zb6D/5R8nNrxveAP@cae.in-ulm.de> <Zb/30qOGYAH4j6Mn@cae.in-ulm.de>
 <CABXGCsPu73D+JS9dpvzX78RktK2VOv_xT8vvuVaQ=B6zs2dMNQ@mail.gmail.com>
 <e7b96819-edf7-1f9f-7b01-e2e805c99b33@linux.intel.com>
 <CABXGCsPjW_Gr4fGBzYSkr_4tsn0fvuT72G-YJYXcb1a4kX=CQw@mail.gmail.com>
 <2d87509a-1515-520c-4b9e-bba4cd4fa2c6@linux.intel.com>
 <CABXGCsPdXqRG6v97KDGy+o59xc3ayaq3rLj267veC7YcKVp8ww@mail.gmail.com>
 <1126ed0a-bfc1-a752-1b5e-f1339d7a8aa5@linux.intel.com>
 <CABXGCsN5_O3iKDOyYxtsGTGDA6fw4962CjzXLSnOK3rscELq+Q@mail.gmail.com>
 <a026ecd8-6fba-017d-d673-0d0759a37ed8@linux.intel.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <a026ecd8-6fba-017d-d673-0d0759a37ed8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1708064148;76dc59d5;
X-HE-SMSGID: 1rarVh-00045P-0e

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

On 08.02.24 16:43, Mathias Nyman wrote:
> On 8.2.2024 12.32, Mikhail Gavrilov wrote:
>> On Thu, Feb 8, 2024 at 2:23 PM Mathias Nyman
>> <mathias.nyman@linux.intel.com> wrote:
>>>
>>> My guess is that CPU0 spends more time with interrupts disabled than
>>> other CPUs.
>>> Either because it's handling interrupts from some other hardware, or
>>> running
>>> code that disables interrupts (for example kernel code inside
>>> spin_lock_irq),
>>> and thus not able to handle network adapter interrupts at the same
>>> rate as CPU23
>>
>> Can this be fixed?
> 
> Not sure, I'm not that familiar with this area.
> Maybe running irqbalance could help?

Mikhail, what's the status of this? I wonder if I should track this as a
regression to ensure Linus is aware of this.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

