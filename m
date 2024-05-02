Return-Path: <linux-kernel+bounces-165974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1D68B941B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8FCEB20E1D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 05:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858A11F947;
	Thu,  2 May 2024 05:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Qjaog+Dw"
Received: from msa.smtpout.orange.fr (msa-217.smtpout.orange.fr [193.252.23.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B78B134B1;
	Thu,  2 May 2024 05:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714626395; cv=none; b=TNbn8vPlyrYSb7OttI9Y5DNNIe/2pFEunrTkedEaUHbDAuiRpyZ9d0s+AWCNSo7QZOMlleWRTBZpHuZcdXwE80E/xNx/DK+nBzU+88eRwb353opK9Pfxl4Z0HzTDNsJCLvkXhU2MvWJ2GirJvwVLDR7wCw6bJ2hlMgyqDwSUxVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714626395; c=relaxed/simple;
	bh=i6vj/PwQB7gB7UJ91ISxfENpDqOjWzxS+DmVM14cbFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CrVnXCa4Z+WMVOaMbBGBs7BlZ8SbRUkwVxcezA7Ynaj0+QrZnfmh7VNW57ha4EiXwSHAQOZzjdEfZS1P8wCCrjGyD4Gm+HL8/oTgaT/xxzWM22DwdE8Jj3gY0GpHAu0DdswG1fJrWZGbrbDRQp7QfnxbzdgWLMhtCzUQxDhGfZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Qjaog+Dw; arc=none smtp.client-ip=193.252.23.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 2OeDsPOIB9Rhy2OeEs9jKt; Thu, 02 May 2024 07:06:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1714626384;
	bh=6XIylefjhMGlw6giRBdG9DxUt6yfGF+tcJ6Bmbp3i7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Qjaog+DwHttjDLg3WOnG31H+yPjtNhVWhcTmXDYyBTPW2jTzf4zPceOpP6uzPZJSt
	 yL2QZ+URtKOPLWwdoYa+z/Meqye3onroN3l5Me3g+6I2nvEUuHLeJ0+DboD5cl4BhA
	 6DTWrIcN6zLdgKhJj3RbmjHbcwNDIfJXUbaGeJLvuSWDGzDqE3h1CuQvbQvcHjk/bA
	 xJVknUrsvRoeNM3eQ/44AdtZTDL7VVs1eVD/ThpOH4LRkekkIagJKMozH8cOrgz/yt
	 6+qHb+DgPXiXTmUy0JgFoTajMe8uZT3fiZKOgE9JV8YsPCUvZO2txONENyW8Dspa5R
	 YnL35IpVxJgIA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 02 May 2024 07:06:24 +0200
X-ME-IP: 86.243.17.157
Message-ID: <289aa316-5067-446e-96d8-7b318fa367a9@wanadoo.fr>
Date: Thu, 2 May 2024 07:06:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] printk: cleanup deprecated uses of strncpy/strcpy
To: Justin Stitt <justinstitt@google.com>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240429-strncpy-kernel-printk-printk-c-v1-1-4da7926d7b69@google.com>
 <7cdc63b3-31cc-442c-8c2e-75adb2c76b52@wanadoo.fr>
 <CAFhGd8rO=-DYvXi0YHvQqnhTteV+Hgeuou0X3USx61oTobj0kw@mail.gmail.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CAFhGd8rO=-DYvXi0YHvQqnhTteV+Hgeuou0X3USx61oTobj0kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 02/05/2024 à 01:18, Justin Stitt a écrit :
> On Wed, May 1, 2024 at 2:39 PM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>> Hi,
>>
>> Nit: The { } around each branch can now also be removed.
> 
> There was one line before and there's one line now.

In the block after the "else", yes, but now the block after the "if" is 
only 1 line. (it was 2 before).

So, {} should now be omitted on both branches.

-    if (str[0] >= '0' && str[0] <= '9') {
-        strcpy(buf, "ttyS");
-        strncpy(buf + 4, str, sizeof(buf) - 5);
+    if (isdigit(str[0])) {
+        scnprintf(buf, sizeof(buf), "ttyS%s", str);
       } else {
-        strncpy(buf, str, sizeof(buf) - 1);
+        strscpy(buf, str);
       }

This is a really minor nitpick. Not sure you need to repost if there is 
no other comment.

CJ

> 
> I'll remove the brackets but I will briefly wait to see if any other
> concerns come in.
> 
> Thanks
> 
>>
>> CJ
>>
> 
> 


