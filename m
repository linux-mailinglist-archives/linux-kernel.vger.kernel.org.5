Return-Path: <linux-kernel+bounces-79707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B7A8625AA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 15:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA35D1C20BB2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC0945976;
	Sat, 24 Feb 2024 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=telus.net header.i=@telus.net header.b="RXZ1lLyj"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48FD45028
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708786657; cv=none; b=UImVahU+9nDTQJf4sdxGSKtSlbPonsmziqPelSaBIL5zhvnKTAfIuOackwjRa2H2a3rYRbfXQoQCcK2OXbEyZpE6O4nsVoV5t4gafwa59aE1MZQAsbxq+oxqL93rFJownWY3omLRzyXNQ7rhf5ILIGNKeTdEcKTaU81cUV3VtU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708786657; c=relaxed/simple;
	bh=ntz5o0LszKUCtCDmWmFQe0AFSUNs4yhu3EOKdO2PuRA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nbj8Yfxu/YObl0JqNTsJ3upe400v8xu0QMd4kWxsrZIF7KXn1up3EbNVYzB3Q4qCRE4Hg4OsTiUCjid1Q//yLIzASB0GcV8xMd20awb3LnyuZcbZe7fKRjzHvqSOu+lOcB6DKhzVr4FZuXwUgTi54IHgqkqaFvRMwZDsL7u0FIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=RXZ1lLyj; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dbb47852cdso14976025ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 06:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1708786655; x=1709391455; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ntz5o0LszKUCtCDmWmFQe0AFSUNs4yhu3EOKdO2PuRA=;
        b=RXZ1lLyji16dQfH+tU2acZ3NJFiBnh+j5yOSP0SVsclNrb1fVE+1MBt9+cPYDB9i/8
         gZasi+BsbL1Jn5YydFlU6qMuI7T+F5JTnasYsj8N9jOedDMW9c6DhcGJkR2MxvC6yYSK
         xMpHy6a8daY0d2JdCFr2SO6XNgn6RioWCukOirsFMnFQt5+VUSb30UEKvf6q3h9axWnA
         p3LdDRara3YoyjGNm+gAyl0xoY45tvX5gZ2fjBUHERLAhbMIZdogqkBj+pBwYEdSi6fd
         3HdYxBJ8imWFYhaoFRj/qYg5uW/LTOGroJk7c/RJZ0Bi0OTrAgN3yKy2tCNTPUglMdbj
         MH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708786655; x=1709391455;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ntz5o0LszKUCtCDmWmFQe0AFSUNs4yhu3EOKdO2PuRA=;
        b=l0DmXysTA9AO5vttYIvsM4I9EHe6haA8gMnRWCmiT8x9G16qug5ydJyhPXf7M7XYW9
         s/RBqgCQb18cPMAGxg9+XXC5kio9HbyjwePugmRo82ObFXvfO68FcoZo5I0ug48z6Gsr
         PSyr5G/sU5+2A8r/5LW6YpMgH1mTpPzxFAWayTEEIrDJK7q5SGtqjWEgDBTcqdcKBpQs
         sBwyQXDFfRNkTqw6RsLJm09tuYLXDmuZvOTiNeLEOOvzkYLar+6wIXPlCb1aWACfnH8k
         epBzOyyFsUKM1mKU5mgvHR7pKJssba3izNJc/Vzdt+Jz2JJJoaGHSjMiMMrpI+Htnig0
         QQdg==
X-Forwarded-Encrypted: i=1; AJvYcCVcMmNIujWgdlbeWZ5T7iD7oK1dLwinkrrZLkLo1f2wHKWghtxqDZ+m8j1NOiPpxIOInsFCpjm/9NRr6qoslTdGeP0P456VSCLhJD0A
X-Gm-Message-State: AOJu0YxqIsrOvECGtY/zqtf4agmeLs4rCHUtdRYAi37KZGXiO8GW5up3
	Zk2jLQoNpHU2nhWciP1d10stBx939aKLTXzZ1vYdGSzfdk4MGJMhV38NDngt19o=
X-Google-Smtp-Source: AGHT+IGwxT5TodcQX9BdTWkFfX+o3yEickfJa9v5Vw8oISLh69bG6evjEbBbh8B6dtZazqKXTSu9wg==
X-Received: by 2002:a17:903:1249:b0:1dc:51ac:88f5 with SMTP id u9-20020a170903124900b001dc51ac88f5mr3244730plh.65.1708786654970;
        Sat, 24 Feb 2024 06:57:34 -0800 (PST)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id e21-20020a170902d39500b001db37fd26bcsm1112672pld.116.2024.02.24.06.57.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Feb 2024 06:57:34 -0800 (PST)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Linux regressions mailing list'" <regressions@lists.linux.dev>,
	"'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: "'Vincent Guittot'" <vincent.guittot@linaro.org>,
	"'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
	"'Ingo Molnar'" <mingo@kernel.org>,
	<linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <002f01da5ba0$49cbf810$dd63e830$@telus.net> <CAKfTPtA-jizig0sh_shmkAMudAxDPYHP0SdanZe=Gc57jVKouQ@mail.gmail.com> <003801da5bae$02d6f550$0884dff0$@telus.net> <CAKfTPtC7pOtb-srrgQLFbTueLLDqHay+GQBm9=sNsnZDg_UYSQ@mail.gmail.com> <000b01da5d09$8219f900$864deb00$@telus.net> <CAKfTPtB8v30LzL3EufRqbfcCceS2nQ_2G8ZHuoD5N1_y-pvFbg@mail.gmail.com> <001b01da5ea7$86c7a070$9456e150$@telus.net> <CAKfTPtD4Un-A2FcdsvKnNZskG=xH0wrsT3xzaWDs--mQjgZ3rg@mail.gmail.com> <003001da6061$bbad1e30$33075a90$@telus.net> <CAKfTPtC82YXOw5yYPNkHHyF+DYSG+Ts9OjnwsVjbd_HcUsZQMg@mail.gmail.com> <c03533dc-73fc-4d97-8248-0affbddbed32@leemhuis.info> <CAJZ5v0hfMuiZCFU6e9TZ7yZV1qER2ymOM7d=AAf5beyMOyHg+g@mail.gmail.com> <a831a69f-fa75-4ae2-b7d5-a2bbfd6bd9dd@leemhuis.info>
In-Reply-To: <a831a69f-fa75-4ae2-b7d5-a2bbfd6bd9dd@leemhuis.info>
Subject: RE: sched/cpufreq: Rework schedutil governor performance estimation - Regression bisected
Date: Sat, 24 Feb 2024 06:57:35 -0800
Message-ID: <000b01da6731$cdaa7610$68ff6230$@telus.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHymzO4ho/iLx8gQfQ33x85MlP38AE230H5ATs9P70BGBlhKwIBEbUgAWfpSqoB1OxCigJA5W0AAaqAerYCnLdoYQL2zC8KAiN+cn4BxRsBOLA3rPVg

On 2024.02.24 06:31 Thorsten wrote:
> On 24.02.24 15:11, Rafael J. Wysocki wrote:
>> On Sat, Feb 24, 2024 at 2:44=E2=80=AFPM Linux regression tracking =
(Thorsten
>>> Leemhuis) <regressions@leemhuis.info> wrote:
>>> On 16.02.24 14:17, Vincent Guittot wrote:
>>>> On Thu, 15 Feb 2024 at 23:53, Doug Smythies <dsmythies@telus.net> =
wrote:
>>>>>
>>>>> This email thread appears as if it might be moving away from a =
regression
>>>>> caused by your commit towards a conclusion that your commit =
exposed
>>>>> a pre-existing bug in the intel_psate.c code.
>>>> Ok
>>>
>>> Well, even in that case it's a regression that must be fixed -- =
ideally
>>> before 6.8. Did anything happen towards that?
>>>
>>> I noticed that Doug send the fix "cpufreq: intel_pstate: fix pstate
>>> limits enforcement for adjust_perf call back":
>>> =
https://lore.kernel.org/all/20240217213010.2466-1-dsmythies@telus.net/
>>>
>>> Is that supposed to fix the problem?=20

Yes it fixes the preexisting issue exposed by 9c0b4bb7f630.

>>>Looks a bit like it, but I'm not
>>> totally sure. In that case I'd say it likely should be applied to =
6.8,
>>> but Rafael apparently applied it to 6.9.
>>=20
>> This hasn't reached linux-next yet, so I rebased it on top of -rc5 in
>> order to push it as a 6.8 fix.
>
> Ahh, great, many thx!

Yes, thanks.

>>> I'd also say that a Fixes: would be good as well (to ensure that fix =
is
>>> also backported in case anyone backports 9c0b4bb7f630), but I know =
that
>>> subsystems handle this differently.

I left the fixes tag off on purpose, because there was never anything =
wrong
with 9c0b4bb7f630. Apologies to Vincent for wasting his time, but thanks
for the help finding the actual issue.
=20
>> So I added a Fixes: tag to it, but it points to the original change
>> that missed the check.
> Yeah, that totally works for me as well. Again: many thx!

Yes, thanks. A fix tag pointing to the original commit makes sense.

.. Doug



