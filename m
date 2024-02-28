Return-Path: <linux-kernel+bounces-84988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB3286AE9F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45BE8B21544
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD99F73532;
	Wed, 28 Feb 2024 12:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzQN76Pb"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70CD73511;
	Wed, 28 Feb 2024 12:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709121735; cv=none; b=IG03B6f0w5Dw+7A7DHhqI6v/vGSvrpg5A03YcZe4DuiOBLhedsYDLHbbEzjvXckJXr+qs9dU5EmmfA5XT7zzm7K46f4R4G/kJEGb5S3ohkmBnqXOdh4pzNs2O2zqrCJ6p1oCBtT/KAr5cAlneUzCrHFbs2xGX30Ho0ulX6UF9CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709121735; c=relaxed/simple;
	bh=6V9fLnX4djEHIHnxWds6qMnJtXmi2aPHUDNuD/uxng8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uLhMlUk54Xz/xGKyJCdq8gMsGyaaccNnRuLi7bLLDWSaCsHTSrfpDT6sOe/q2MU8tzK6kH5Zx9u16rnUbUNpboVptl7vG1qQ8yhtVNq4W1kFYyDvrxMAIR/P/1urbKKp+Q/UUfq4JDCatPJ/8A/4O5v7PC9CkZKE+7uEqKDy2FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzQN76Pb; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7c78b520bc3so198155039f.0;
        Wed, 28 Feb 2024 04:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709121733; x=1709726533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9EbFg5rAlApTq4Ur/KjS2tqf+My7HKA0PMj35gGR2V8=;
        b=CzQN76PbicNYox5671sKJwQOrvfML0r/Fea/aETK+pyRWmd9Y2vrrMz5j3kPRu4Z4P
         UFioKOr8S7NbF3lQhCztNh5DFhPCdm1kEPffgzmQ7aMRzByOXBWeQXzqP2skm3p7UIS3
         ARj1zjNyzuWgKzoNlpwdaxuA16UvQt0vY+Hd5srfFpkNAHX2lMOMN+Dxjc/duX0t6TsL
         jIag1/dsLOhwfoP7BCQm87a/Hh0bvZdo1gTUeo42S2Xd5/+8/i6eaDldWYmT5E4ZJruV
         qdKlMnhg1ufXurQMbfhnJCdkUlD0yymPSlVLY6X21PUxyZKSrqiUfECeNHcPAFkB5DfF
         xN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709121733; x=1709726533;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9EbFg5rAlApTq4Ur/KjS2tqf+My7HKA0PMj35gGR2V8=;
        b=Td8DXD5tctQrA2UdCKlYB5uQU4d+94CBx9z29H//zlCCvD0+zrXNYicl3ZutV9Sp22
         113BhHOn6Se3TyKisakTQmDeaY9rwzxdYcTICktWuHdKlZtzVVJzHvBbSackLNKWas7Y
         KMKomuvAeJOQEyIsTHOkDZ6lFDCcL10JpXFsxnse/l6kHObY2txEWkCcsterg1Z1sbb3
         ZW2u+N1z8sSpYZJKVqBdwDDm8f9lsejtM5d6t/D1kFYj+is8grFri+n8MHXir7/STRAR
         xaDU7Qk2rIjYxU91mOV/u3QFxyK+HWrjSTZST9bDIBjLPKo2jfcvGNZajAdsuLeVp3fy
         U8ug==
X-Forwarded-Encrypted: i=1; AJvYcCWHMpfcs6BgJbfm86O4Na4a8iUmL1lSaBlhZ6p6DhCZ5vAmslCXNGj9UiQluMQn3/holcNNnBACb+7TtyXQeSm0iFh1hJ5vwlnNZeBIo7mu7Kw7YzG9LTGwTfZyeyM9VdgGjlD/
X-Gm-Message-State: AOJu0YwyYr7OiVTdq0lKKgCMG5C3V65tjgQB9R2DNOzS8I1SOMq8B2EF
	A0OSh3idWntMlyvWrUcV8FcQ+AOWPvOWLhH8bcIEckUkdYZr1x70
X-Google-Smtp-Source: AGHT+IHQ2x000uqQolclyzQgafNQ9xKVlzClv2eZYrTcDX5jTDSRh0RJ/VLEbKeg09C1QMdrtitnjA==
X-Received: by 2002:a05:6602:358:b0:7c4:61e7:9d77 with SMTP id w24-20020a056602035800b007c461e79d77mr15494595iou.19.1709121732669;
        Wed, 28 Feb 2024 04:02:12 -0800 (PST)
Received: from [192.168.0.107] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id c8-20020a62e808000000b006e4625a0f0dsm7596575pfi.169.2024.02.28.04.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 04:02:12 -0800 (PST)
Message-ID: <b2b21bca-9c99-4df5-9947-29d19abd89e6@gmail.com>
Date: Wed, 28 Feb 2024 19:02:03 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Network performance regression in Linux kernel 6.6 for small
 socket size test cases
Content-Language: en-US
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Abdul Anshad Azeez <abdul-anshad.azeez@broadcom.com>, edumazet@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 dsahern@kernel.org, Linux Networking <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Boon Ang <boon.ang@broadcom.com>, John Savanyo
 <john.savanyo@broadcom.com>, Peter Jonasson <peter.jonasson@broadcom.com>,
 Rajender M <rajender.m@broadcom.com>
References: <CALkn8kLOozs5UO52SQa9PR-CiKx_mqW8VF9US94qN+ixyqnkdQ@mail.gmail.com>
 <Zd7vqSnT6ocYLuZ4@archie.me>
 <8015b1f0-d37b-45de-bd24-12fc21cbf83d@leemhuis.info>
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <8015b1f0-d37b-45de-bd24-12fc21cbf83d@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/24 16:09, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 28.02.24 09:32, Bagas Sanjaya wrote:
>> [also Cc: regressions ML]
>>
>> On Wed, Feb 28, 2024 at 12:13:27PM +0530, Abdul Anshad Azeez wrote:
>>> During performance regression workload execution of the Linux
>>> kernel we observed up to 30% performance decrease in a specific networking
>>> workload on the 6.6 kernel compared to 6.5 (details below). The regression is
>>> reproducible in both Linux VMs running on ESXi and bare metal Linux.
>>>
>>> [...]
>>>
>>> We would like to know if there are any opportunities for optimization in
>>> the test cases with small socket sizes.
>>
>> Can you verify the regression on current mainline (v6.8-rc6)?
> 
> Bagas, I know that you are trying to help, but this is not helpful at
> all (and indirectly puts regression tracking and the kernel development
> community into a bad light).
> 
> Asking that question can be the right thing sometimes, for example in a
> bugzilla ticket where the reporter is clearly reporting their first bug.
> But the quoted report above clearly does not fall into that category for
> various obvious reasons.
> 
> If you want to ensure that reports like that are acted upon, wait at
> least two or three work days and see if there is a reply from a
> developer. In case there is none (which happens, but I assume for a bug
> report like this is likely rare) prodding a bit can be okay. But even
> then you definitely want to use a more friendly tone. Maybe something
> like "None of the developers reacted yet; maybe none of them bothered to
> take a closer look because it's unclear if the problem still happens
> with the latest code. You thus might want to verify and report back if
> the problem happens with latest mainline, maybe then someone will take a
> closer look".
> 
> Okay, that has way too many "maybe" in it, but I'm sure you'll get the
> idea. :-D
> 

Oops, I'm always impatient (and forgot to privately mail you) in this case.
Sorry for inconvenience.

-- 
An old man doll... just what I always wanted! - Clara


