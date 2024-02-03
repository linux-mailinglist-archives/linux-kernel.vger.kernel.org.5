Return-Path: <linux-kernel+bounces-51188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C853848782
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331681F227D8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E4F5F859;
	Sat,  3 Feb 2024 16:50:17 +0000 (UTC)
Received: from mail.r2rien.org (srv.r2rien.org [92.243.11.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5918F5DF0C;
	Sat,  3 Feb 2024 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.11.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706979016; cv=none; b=irfBvMOq8ihVnky7yS0PwlLBo88Rnb/w7VemagPKOsJ3D/+QeFcbIQujflNNT1lhibobtc9+SaQLBa5gYDSSWJHsSHfYL5eS8uorwTPmCZt4sL7auCYpJp16faJ7pnSimgWZHsvNNH6fsjDRNLbHDXCG2hj3gTTU4BKPZG0BO0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706979016; c=relaxed/simple;
	bh=Y86ictid7gY0ft+rClKcRFxQAdXWDQup5I+qVZWiij0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Pz2kPUxmdodU4fD2HNEBqUWKC5T0FwIptQx0C6FKFkqS2RnTtpuqBAasA5D6YhXBummGijd52PgQCuSMeJmA2AERJINxs/VefS3rexgOC4jE0XmmrKCPc+MZ3ra0QNEODgeRckniu/4V47lnKxl+KC055IDz1o2d4nV9dCOX2Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=r2rien.net; spf=pass smtp.mailfrom=r2rien.net; arc=none smtp.client-ip=92.243.11.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=r2rien.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r2rien.net
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=178.132.106.162; helo=[10.8.3.5]; envelope-from=debian@r2rien.net; receiver=hdegoede@redhat.com 
Received: from [10.8.3.5] (unknown [178.132.106.162])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.r2rien.org (Postfix) with ESMTP id 6B0AB31F9F;
	Sat,  3 Feb 2024 17:13:36 +0100 (CET)
Message-ID: <bc166c19-8da3-cd42-b749-e35eaebe7822@r2rien.net>
Date: Sat, 3 Feb 2024 17:16:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.15.1
Subject: + XPS 13 9343
Content-Language: en-US
To: hdegoede@redhat.com
References: <0aa4a61f-c939-46fe-a572-08022e8931c7@molgen.mpg.de>
 <f27b491c-2f1c-4e68-804c-24eeaa8d10de@redhat.com>
From: Antoine <debian@r2rien.net>
Cc: Dell.Client.Kernel@dell.com, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 pmenzel@molgen.mpg.de, regressions@lists.linux.dev, 1061521@bugs.debian.org
In-Reply-To: <f27b491c-2f1c-4e68-804c-24eeaa8d10de@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/20/24 21:26, Hans de Goede wrote:
> Can you try adding "i8042.dumbkbd=1" to your kernel commandline?
> 
> The next question is if the keyboard will still actually
> work after suspend/resume with "i8042.dumbkbd=1". If it
> stays in the list, but no longer works

Hi, thanks a lot for taking into account our hardware,
just a supplementary feedback:

In my case (Dell XPS 13 9343/i5-5200U):
- Dell Inc. XPS 13 9343/0TM99H, BIOS A19 12/24/2018
- Linux version 6.6.13-1 (2024-01-20)

commandline with `i8042.dumbkbd=1` fixes the issue,
with capslock functional but without led
+ as a side note, hibernate doesn't trigger any issue

(before getting informed of and testing `i8042.dumbkbd=1`)
I had attached logs before/after suspend against 6.6.11 and 6.6.13 :
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1061521#30

I remain at your disposal for any further infos/testing
best regards,
Antoine

