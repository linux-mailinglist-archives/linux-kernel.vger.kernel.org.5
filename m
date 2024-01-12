Return-Path: <linux-kernel+bounces-24797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A567782C2B4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25E051F23461
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B303B6EB55;
	Fri, 12 Jan 2024 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvW0MyjY"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B103D6E2D4;
	Fri, 12 Jan 2024 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d40eec5e12so55231045ad.1;
        Fri, 12 Jan 2024 07:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705073328; x=1705678128; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/c1f3PuyTSxb/NvzfJZ8cQSSdJ6p0789xGixgh6hA0w=;
        b=YvW0MyjY3A7LkECac01izyegT7njNsZCbNuNdMfaZZSi10d+8Nqpf9SRefcGrktvKW
         NJqw0EIFzK++4h/H1lloYLE4wN6leCkrqogDZbNUi948Wm58yIOgjyQlPvdil6vVrV4F
         9XnWG+j0U+VGgalchMbl0X5qL2Wl8zKvJW2XEewQoBeMf/8j7Atk1Gcd6NfkIqOEXd5x
         vzU5u79sWqZ5Lv2RKq8lBFzlPgKT/nKfabzQriAZdslNC6iEjFN+tx4QWVa9TJqL0fPg
         JvUALLw1QFCu/TCBpoCiY8Qam+bYgI3uq9ml7g3VAvqNspQ2jsfUcvuGhDjJsAsozYoB
         ersA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705073328; x=1705678128;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/c1f3PuyTSxb/NvzfJZ8cQSSdJ6p0789xGixgh6hA0w=;
        b=FUKMg3KSVUXGqKUQwO7TruZz1xsHYbs/1iGHffFnA/e8yHK0ycnOjJSeFp2fLKCL8P
         OP0p/8SSpWCIknN2rGXrEzVGZuGtEr2/MaSbTb8WY8NaFvA8Frvyir1ernTSvisCXWwj
         Kb0PleJ/h42T1fQIsSQ1NsLhhCSs0hRrFpygBSyT5eZHF3Np2y2LQOGT8DaBs1NzqjFW
         utCmfxI87vGLSKpfPwV7mmyJQqGnIVShzbp7U/x/8xBiPcBk58trkIIaVepdDFhCvOfm
         HjtEk/Ijbg1wY5lbSwGaudKT3tRatamEyAs+FoYGfII2+/Z+Q/dQNq4GJVJXfPIiAsYy
         P1Jw==
X-Gm-Message-State: AOJu0YxjoAtsPab4qvTSLgkmkd+2oPtUaFchEVYa+GBQboYsjh3YkM2U
	28kQbOxEGu5xCYzomtR10TU=
X-Google-Smtp-Source: AGHT+IGVtzfNvlC9PKqK8DPj66448oEr3eMVb0hfWf/L8hpWWvgX2RdaMkscPZU19A9DtnzWczxm4g==
X-Received: by 2002:a17:902:7403:b0:1d4:d260:9e87 with SMTP id g3-20020a170902740300b001d4d2609e87mr1293449pll.135.1705073327994;
        Fri, 12 Jan 2024 07:28:47 -0800 (PST)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id v12-20020a170902f0cc00b001d45fd7d444sm3261793pla.175.2024.01.12.07.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 07:28:47 -0800 (PST)
Message-ID: <a445d391-4cc9-4d6d-85ad-02d23aa57ebb@gmail.com>
Date: Sat, 13 Jan 2024 00:28:44 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Documentation for 6.8
To: Jonathan Corbet <corbet@lwn.net>,
 Linus Torvalds <torvalds@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <87sf37vegj.fsf@meer.lwn.net>
 <CAHk-=whtqOvx4_GL8MX+bGroS5hfueP+Arch_qVYwQDJVvFCKg@mail.gmail.com>
 <87v87yk3xg.fsf@meer.lwn.net>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <87v87yk3xg.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Fri, 12 Jan 2024 07:43:39 -0700, Jonathan Corbet wrote:
> [Adding Akira]

Thanks!

> 
> Linus Torvalds <torvalds@linuxfoundation.org> writes:
> 
>> On Mon, 8 Jan 2024 at 10:59, Jonathan Corbet <corbet@lwn.net> wrote:
>>>
>>> - The minimum Sphinx requirement has been raised to 2.4.4, following a
>>>   warning that was added in 6.2.
>>
>> Well, speaking of warnings, github now has this "dependabot" thing
>> that warns about bad minimum requirements due to tooling that has
>> security issues.
>>
>> And it warns about our "jinja2 < 3.1" requirement, because apparently
>> that can cause issues:
>>
>>   "The xmlattr filter in affected versions of Jinja accepts keys
>> containing spaces. XML/HTML attributes cannot contain spaces, as each
>> would then be interpreted as a separate attribute. If an application
>> accepts keys (as opposed to only values) as user input, and renders
>> these in pages that other users see as well, an attacker could use
>> this to inject other attributes and perform XSS. Note that accepting
>> keys as user input is not common or a particularly intended use case
>> of the xmlattr filter, and an application doing so should already be
>> verifying what keys are provided regardless of this fix"
>>
>> with affected versions being marked as < 3.1.3 and fixed in Jinja2 3.1.3
>>
>> I'm ignoring this github dependabit warning since the issue seems to
>> be rather irrelevant for our doc use, but I thought I'd mention it.
> 
> I suppose it is worth looking into this, just in case a hostile docs
> patch that nobody catches might somehow cause an exploit to show up on
> docs.kernel.org.  Seems unlikely but it would be good to be sure.
> 
> Akira (CC'd) noted, in adding that requirement, that newer jinja2 breaks
> Sphinx prior to 4.8.

There has never been a release "Sphinx 4.8".

What I said in [1] was:

 # jinja2>=3.1 is not compatible with Sphinx<4.0
 jinja2<3.1
-Sphinx==2.4.4
+# docutils>=0.18 is not compatible with 3.0 <= Sphinx < 4.0
+docutils<0.18
+Sphinx==3.4.3

So newer jinja2 and docutils break Sphinx prior to 4.0.

One more inconvenient truth Jon wouldn't like to know.

Official python 3.10 support was new to Sphinx 4.3.
So, I guess reasonable version for recommending is Sphinx>=4.3.

But at the same time, The latest Sphinx 7.2.6 works only with
python>=3.9.  If your base python3 is 3.8 (e.g. ubuntu 20.04),
you can't have the latest one.

Sounds very complicated, doesn't it?

I'm beginning to think that we can forget about those subtle
incompatibilities by recommending distro Sphinx packages.

As I summarized in [2], RHEL 9 and debian 11 have Sphinx 3.4.3,
which is good enough for kernel documentation.
Quoting from [2]:

              As of 2023.11.30

    ----------------------------------
    Distro              Sphinx Python3
    =================== ====== =======
    Ubuntu 22.04 LTS    4.3.2  3.10.12
    Debian 11           3.4.3  3.9.2
    Debian 12           5.3.0  3.11.2
    Fedora 39           6.2.1  3.12.0
    RHEL 9              3.4.3  3.9.18
    Mageia 9            6.1.3  3.10.11
    openSUSE Leap 15.5  4.2.0  3.6.15  (provided as python3-Sphinx_4_2_0)
    ----------------------------------

Installing one of those packages should come with compatible
requirements, plus several security fixes backported if we are
lucky.

There was a time when distro Sphinx was <2.4 and wasn't usable
for kernel documentation.  It is no longer true anymore.

[1]: https://lore.kernel.org/linux-doc/50830030-dca7-4c43-bcc8-449c7cfa9fbb@gmail.com/
[2]: https://lore.kernel.org/linux-doc/c3accd5b-c8d9-4eb9-86a1-054e89893a8f@gmail.com/

        Thanks, Akira


  I've been thinking that supporting 2.x is going to
> prove increasingly unsustainable, but raising our minimum to 4.8 would
> surely make some people unhappy.
> 
> I like the Python ecosystem for a lot of things, but its approach to API
> compatibility is ... not great.
> 
> jon

