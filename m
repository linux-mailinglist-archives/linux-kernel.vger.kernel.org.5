Return-Path: <linux-kernel+bounces-4372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4ED817C31
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88041F24557
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A7774E05;
	Mon, 18 Dec 2023 20:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MjdduzvJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3761B76094
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 20:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7b7cea31f44so20288539f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 12:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702932433; x=1703537233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RmMlyFW3/T9szLmC8QLXU7Ar2oqGtNuKLtSBUONO2Hw=;
        b=MjdduzvJoPj8qgRCJkSjs+OTL2B+daxGJZ9WCAQPEmlvSrztory/uf5AgMV0GTk7W6
         yyc/pKk9kgSHXaSzudpDt0NCXjUnjOepHr/2HnK6ami0UH9eWMlvDd2+PRRUHcEwblb5
         7ogVRqFeYEIfBkDbJwTINb6pG4gfLY+gv9qP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702932433; x=1703537233;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RmMlyFW3/T9szLmC8QLXU7Ar2oqGtNuKLtSBUONO2Hw=;
        b=VceAxtE27qQ6espSRcWNtgvwRUBD6VY+Tn7S9KfZrLWpDJk4hks8Fs/xnVwv3KnzH/
         e/HEvRjByCfOZZD/iu9Rn7ISxJxGefaWOo1NsQWxmSCXRTRIPLPapsVLK38LDbORD5gz
         FXDmN0BJmufBQACWopUE4e91cGUEZLAltR3Zyt60O0D6VwwMFgAJMszmI0cHEKCyc8Ei
         Y4Dr7iYcR9kuEt7w8Vlj09NxkoHQ4tk/F+5XSfXgZdAwlw9GEKXrUhDJVDlpxWFf6MJy
         lsLS+tbvcuu8eJgHLZVfTfXONoGDgell+Iv+CYU5c5NNa/xAjOJBWyysppBvYT7LBrjP
         tnkQ==
X-Gm-Message-State: AOJu0Yw5+nv4qOHxPTRdzE+D6NEghi630aGSaUIYqR+BePsu5q1hELnn
	rKnoMOZtW6fZtT1exlhdb1RIkw==
X-Google-Smtp-Source: AGHT+IH56x3NfZ46rTKDRzkFQ293+fOQe4LCbT9bAV97A7FWr5XkqjLfqcnUyLhjbpEHtO3fJPL2eA==
X-Received: by 2002:a05:6602:b90:b0:7b6:fe97:5242 with SMTP id fm16-20020a0566020b9000b007b6fe975242mr31704186iob.0.1702932433168;
        Mon, 18 Dec 2023 12:47:13 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id bs6-20020a056638450600b0046b14785710sm2264469jab.113.2023.12.18.12.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 12:47:12 -0800 (PST)
Message-ID: <3a6b1886-c133-4893-8113-73f290b97390@linuxfoundation.org>
Date: Mon, 18 Dec 2023 13:47:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] selftests: livepatch: Test livepatching a heavily
 called syscall
Content-Language: en-US
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: mpdesouza@suse.com, Marcos Paulo de Souza <mpdesouza@suse.de>,
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 live-patching@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231031-send-lp-kselftests-v3-0-2b1655c2605f@suse.com>
 <20231031-send-lp-kselftests-v3-3-2b1655c2605f@suse.com>
 <f9d82fa6-08d7-4ab6-badc-691987b37a82@linuxfoundation.org>
 <unpg4z7eig6qbudgulnr6sog65fq7s2dy4u2vp2dgkdrq5csdw@dltnxuw6kw5b>
 <8b95b96c-6aeb-4bf0-8ee9-2ba62330c672@linuxfoundation.org>
 <12a9ec1bc84dc6d4b461e5c780ba7d3c3aa91740.camel@suse.com>
 <76c4b967-1cb6-4f77-9402-f835b15adb10@linuxfoundation.org>
 <alpine.LSU.2.21.2312061530470.13051@pobox.suse.cz>
 <2498bf91-8057-43e8-98f2-4ed93c53ce9f@linuxfoundation.org>
 <8a433f12-b930-6095-9a49-db5f1d2836b5@redhat.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <8a433f12-b930-6095-9a49-db5f1d2836b5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/15/23 13:36, Joe Lawrence wrote:
> On 12/11/23 16:53, Shuah Khan wrote:
>> On 12/6/23 07:39, Miroslav Benes wrote:
>>> Hi,
>>>
>>> On Tue, 5 Dec 2023, Shuah Khan wrote:
>>>
>>>> On 12/5/23 05:52, mpdesouza@suse.com wrote:
>>>>> On Fri, 2023-12-01 at 16:38 +0000, Shuah Khan wrote:
>>>>
>>>>> 0003-selftests-livepatch-Test-livepatching-a-heavily-call.patch has
>>>>> style problems, please review.
>>>>>
>>>>> NOTE: If any of the errors are false positives, please report
>>>>>          them to the maintainer, see CHECKPATCH in MAINTAINERS.
>>>>>
>>>>> I couldn't find any mention about "missing module name". Is your script
>>>>> showing more warnings than these ones? Can you please share your
>>>>> output?
>>>>>
>>>>> I'll fix MAINTAINERS file but I'll wait until I understand what's
>>>>> missing in your checkpatch script to resend the patchset.
>>>>>
>>>>
>>>> Looks like it is coming a script - still my question stands on
>>>> whether or not you would need a module name for this module?
>>>
>>> I admit I am also clueless here. The module name is given in Makefile. In
>>> this case in test_modules/Makefile. I do not know of anything else. There
>>> is no MODULE_NAME macro. Could you elaborate, please?
>>>
>>
>> I see that now.
>>
> 
> Hi Shuah,
> 
> In the other replies to this thread, Marcos noted that he would add some
> text to the commit / documentation on running and building the selftests
> directly in the kernel tree (that would get my Ack) ... is there
> anything else to be updated for a hopefully final v4 (for your Ack)?
> 


I am waiting for v4 with your comments are addressed. I can take
this through kselftest tree.

thanks,
-- Shuah


