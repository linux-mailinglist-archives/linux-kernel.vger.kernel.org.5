Return-Path: <linux-kernel+bounces-74162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1FD85D09A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE251C22D1C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257A8364CC;
	Wed, 21 Feb 2024 06:48:32 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65A1365;
	Wed, 21 Feb 2024 06:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708498111; cv=none; b=kuV1OEOI1jbDEnu1kvEfMyHE8jSQo3zeZ0DPZ9EILGqfRGOqtFRON+Y1GsPUNlI0N2kG5XMVyh+X80JKJJRFvb099vqyRjVLcJE76szpbiEAs+bIQ1YvHeyKwiwzb8vbo08/Q/Sax7tAlNS0/pgs6CeUoVEN2IkjmawhSkgqLqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708498111; c=relaxed/simple;
	bh=ddbPwhC7SnNRNXIB5oEsGmFtV7TO/BXd6KKtcjQfq+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kM9UQSpzvAz3wNgyIj9V8gFHNcc9+LBrCp++uytopk765Jsbc9Iv0kkI7BE1qcPKwgaNLzqG/NJYwp/qmeWT2NhKcs3+7GxI6v8+nlHS2dyPf4DS5VG12HETj10nw8XYAHqfqi2ujkSFRNVeciPR8m5wHs5dCyVFn8cNxrbXa3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rcgP5-0004DH-N4; Wed, 21 Feb 2024 07:48:27 +0100
Message-ID: <28a136ee-4332-49ae-9d77-ef1abc12d19c@leemhuis.info>
Date: Wed, 21 Feb 2024 07:48:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_This_is_the_fourth_time_I=E2=80=99ve_tried_to_find_?=
 =?UTF-8?Q?what_led_to_the_regression_of_outgoing_network_speed_and_each_tim?=
 =?UTF-8?Q?e_I_find_the_merge_commit_8c94ccc7cd691472461448f98e2372c75849406?=
 =?UTF-8?Q?c?=
Content-Language: en-US, de-DE
To: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 linux-netdev@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com>
From: "Linux regression tracking #adding (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1708498109;44e2ff5c;
X-HE-SMSGID: 1rcgP5-0004DH-N4

On 03.02.24 02:02, Mikhail Gavrilov wrote:
> Hi,
> I'm trying to find the first bad commit that led to a decreased
> network outgoing speed.
> And every time I come to a huge merge [Merge tag 'usb-6.8-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb]
> I have already triple-checked all my answers and speed measurements.
> I don't understand where I'm making a mistake.
>

To be sure the issue doesn't fall through the cracks unnoticed, I'm
adding it to regzbot, the Linux kernel regression tracking bot:

#regzbot ^introduced f977f4c9301c
#regzbot title irq/net/usb: performance decrease now that network device
and xhci share IRQs
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

