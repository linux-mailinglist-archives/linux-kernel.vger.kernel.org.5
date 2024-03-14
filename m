Return-Path: <linux-kernel+bounces-103199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7883B87BC41
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64811F2206E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C52F6F507;
	Thu, 14 Mar 2024 11:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOTurZuq"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745E06EB41;
	Thu, 14 Mar 2024 11:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710417172; cv=none; b=DKjWFnxLK1ecH9NmNmiOl0Y57PTI0PB3a5onEItMbVdEhZg1dRdw1W5FufqMXyfQkCTJHwNlnSA47cayRV8N0TKb96s7wuM6QQ+W3Xxft9jVCe0bv855hDOERSISMPYYJPy6hipk8BOA4U6O7V1De8RCHfz2z0oA1W0lIz47g/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710417172; c=relaxed/simple;
	bh=DR7uIQcQtirFNtRaxp4uGyTaLvC4VFi+/92L9+pR+Yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XEDkh/vh7QRAlV6LPfajGm1bLOLwnnEfh1fJ+EiRE8Ltdtk25wEx4Us3J0CGsHxm5kO2A/k9sQTywIC638pFM2byoFBvljLJ/bOcSyH54HQmcU/VsoySJULlM733oLK2TB/XOj6D7ghJCO1IrgmjohFBtrzrd8nHU8zX+Gvfw1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOTurZuq; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a217378ad8so315140eaf.2;
        Thu, 14 Mar 2024 04:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710417169; x=1711021969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tdifjv40tbAIgozYYTGFKCKIMm7LnNYUe3NS1/d4TCc=;
        b=GOTurZuqO2xY72OF5w8SovnrNMYLUNykX64w9uZAAVk6VzAuDS5cWdPfcbUVeCgvIK
         epECDrhCAeodqX2nAYwe5c+uqMRfi+yfoc0dtsZik8pWs93gcr0FFB6akiNOYg/Eggr9
         PYbHzJvqMqexVfk9pK/VWuGqUXawXTkkLfJ3oAdv5bBBDBLqd0mtGQMQbHDDH8VJ4+nD
         9IMVg18aRRftON2Jj0rNMNf2HDb2yV8RfZqg5ZlMtL/1iIgtt/pB6Zd1A3vygGp/jqiy
         fRD86MTPepjv+RkEhT/u9E+V+99nKcbp8LlgPcU1Lphokc+ekWmN/r3n6GH54EwLsHLe
         QguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710417169; x=1711021969;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tdifjv40tbAIgozYYTGFKCKIMm7LnNYUe3NS1/d4TCc=;
        b=bQFClA2B/XYUsV+X1sVUJ6n6MaNjEzVftgchoBEbEX9F3RWc1XOWO8GqistR+6MSTe
         Shxfdt2OBCaQh/HWIXzgvi+i7o1DwfL4YzOGnqCFLIrbxUB6T5Tef+aBHeZvWuM1wqp0
         5powtAtEi0Wv43yAaDDhpVwufsrZ5XTa/jvK5MtGmjH3seQ2KUN+6tgod7tnlaGGkyb2
         bqFcNO8JFUcplvx74XF3Mhy+ujNpj49jK21/Dq12kEK+ZKaVIPPF/auJ6q3b8ft8X59I
         j2mgyDkqnO4fJL2APMQC796AWBvvBEy0HctmouNnLm6kn/ulU6Osmaerxil+IIrdJNNz
         4p2g==
X-Forwarded-Encrypted: i=1; AJvYcCVRgwxMODd0mt8Pq1JHd+e3ZSU5y9OS0bVVAow9mkeHoU5zzx1lKnaexaYIRo2XAw6cIfwF+iSNTqJh70lwlVWqw1gbgrLqxpRusdUAfKWXCk4cvwGHH5JwIzGZWu1WZgwqpf5f54Fann3I2MPYECSuMS6LWAqJEn+kljszIs2dLMjg+z26I2g4rlhrr5umUNo9Zu13t5CCDirFiqvRnN+eL+7am2re5iNlQMw/sbhcJVtrSlcq4c/+vF/Rf0VJgKcKJCsgBidJIBFLCOelHIt5Xk4cF4Dno/utM0s=
X-Gm-Message-State: AOJu0YxzbiGsSvxL30Fkvxv0yHTyVxRuLa5oQucqTVq3BYMIjUdN87pQ
	MX0nSwjue1/DHkhH1E75+GbBnw+i/msjSa22sAkZX4B3EmDh6oBy
X-Google-Smtp-Source: AGHT+IHPtvNpbzsaayWywW7W8tum6qeCMeXLFKZPuvZvQSEuflx/ONggDCEzNvvaKOcLF8ZD/bugFA==
X-Received: by 2002:a05:6358:6590:b0:17b:b52c:c121 with SMTP id x16-20020a056358659000b0017bb52cc121mr1728763rwh.13.1710417169288;
        Thu, 14 Mar 2024 04:52:49 -0700 (PDT)
Received: from [192.168.254.38] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id 192-20020a6301c9000000b005d7994a08dcsm522636pgb.36.2024.03.14.04.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 04:52:48 -0700 (PDT)
Message-ID: <a4d24b2c-7dbf-4354-9514-f8a253aac14b@gmail.com>
Date: Thu, 14 Mar 2024 04:52:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Re: [PATCH] crypto: pkcs7: remove sha1 support
Content-Language: en-US
To: Eric Biggers <ebiggers@kernel.org>,
 Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Karel Balej
 <balejk@matfyz.cz>, dimitri.ledkov@canonical.com,
 alexandre.torgue@foss.st.com, davem@davemloft.net, dhowells@redhat.com,
 herbert@gondor.apana.org.au, keyrings@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, mcgrof@kernel.org,
 mcoquelin.stm32@gmail.com, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, iwd@lists.linux.dev
References: <CZSHRUIJ4RKL.34T4EASV5DNJM@matfyz.cz>
 <005f998ec59e27633b1b99fdf929e40ccfd401c1.camel@sipsolutions.net>
 <f2dcbe55-0f0e-4173-8e21-f899c6fc802a@gmail.com>
 <20240313194423.GA1111@sol.localdomain>
 <b838e729-dc30-4e18-b928-c34c16b08606@gmail.com>
 <20240313202223.GB1111@sol.localdomain>
 <db86cba4-0e61-441d-8e66-405a13b61a3c@gmail.com>
 <20240313221043.GC1111@sol.localdomain>
 <f0492c92-1015-48e3-bfce-598c7a4843d1@quicinc.com>
 <20240313230611.GD1111@sol.localdomain>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20240313230611.GD1111@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 3/13/24 4:06 PM, Eric Biggers wrote:
> On Wed, Mar 13, 2024 at 03:51:10PM -0700, Jeff Johnson wrote:
>> On 3/13/2024 3:10 PM, Eric Biggers wrote:
>>> On Wed, Mar 13, 2024 at 02:17:29PM -0700, James Prestwood wrote:
>>>> Hi,
>>>>
>>>> On 3/13/24 1:22 PM, Eric Biggers wrote:
>>>>> On Wed, Mar 13, 2024 at 01:12:54PM -0700, James Prestwood wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 3/13/24 12:44 PM, Eric Biggers wrote:
>>>>>>> On Wed, Mar 13, 2024 at 10:26:06AM -0700, James Prestwood wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> On 3/13/24 1:56 AM, Johannes Berg wrote:
>>>>>>>>> Not sure why you're CC'ing the world, but I guess adding a few more
>>>>>>>>> doesn't hurt ...
>>>>>>>>>
>>>>>>>>> On Wed, 2024-03-13 at 09:50 +0100, Karel Balej wrote:
>>>>>>>>>>      and I use iwd
>>>>>>>>> This is your problem, the wireless stack in the kernel doesn't use any
>>>>>>>>> kernel crypto code for 802.1X.
>>>>>>>> Yes, the wireless stack has zero bearing on the issue. I think that's what
>>>>>>>> you meant by "problem".
>>>>>>>>
>>>>>>>> IWD has used the kernel crypto API forever which was abruptly broken, that
>>>>>>>> is the problem.
>>>>>>>>
>>>>>>>> The original commit says it was to remove support for sha1 signed kernel
>>>>>>>> modules, but it did more than that and broke the keyctl API.
>>>>>>>>
>>>>>>> Which specific API is iwd using that is relevant here?
>>>>>>> I cloned https://kernel.googlesource.com/pub/scm/network/wireless/iwd
>>>>>>> and grepped for keyctl and AF_ALG, but there are no matches.
>>>>>> IWD uses ELL for its crypto, which uses the AF_ALG API:
>>>>>>
>>>>>> https://git.kernel.org/pub/scm/libs/ell/ell.git/
>>>>> Thanks for pointing out that the relevant code is really in that separate
>>>>> repository.  Note, it seems that keyctl() is the problem here, not AF_ALG.  The
>>>>> blamed commit didn't change anything for AF_ALG.
>>>>>
>>>>>> I believe the failure is when calling:
>>>>>>
>>>>>> KEYCTL_PKEY_QUERY enc="x962" hash="sha1"
>>>>>>
>>>>>>   From logs Michael posted on the IWD list, the ELL API that fails is:
>>>>>>
>>>>>> l_key_get_info (ell.git/ell/key.c:416)
>>>>> Okay, I guess that's what's actually causing the problem.  KEYCTL_PKEY_* are a
>>>>> weird set of APIs where userspace can ask the kernel to do asymmetric key
>>>>> operations.  It's unclear why they exist, as the same functionality is available
>>>>> in userspace crypto libraries.
>>>>>
>>>>> I suppose that the blamed commit, or at least part of it, will need to be
>>>>> reverted to keep these weird keyctls working.
>>>>>
>>>>> For the future, why doesn't iwd just use a userspace crypto library such as
>>>>> OpenSSL?
>>>> I was not around when the original decision was made, but a few reasons I
>>>> know we don't use openSSL:
>>>>
>>>>   - IWD has virtually zero dependencies.
>>> Depending on something in the kernel does not eliminate a dependency; it just
>>> adds that particular kernel UAPI to your list of dependencies.  The reason that
>>> we're having this discussion in the first place is because iwd is depending on
>>> an obscure kernel UAPI that is not well defined.  Historically it's been hard to
>>> avoid "breaking" changes in these crypto-related UAPIs because of the poor
>>> design where a huge number of algorithms are potentially supported, but the list
>>> is undocumented and it varies from one system to another based on configuration.
>>> Also due to their obscurity many kernel developers don't know that these UAPIs
>>> even exist.  (The reaction when someone finds out is usually "Why!?")
>>>
>>> It may be worth looking at if iwd should make a different choice for this
>>> dependency.  It's understandable to blame dependencies when things go wrong, but
>>> at the same time the choice of dependency is very much a choice, and some
>>> choices can be more technically sound and cause fewer problems than others...
>>>
>>>>   - OpenSSL + friends are rather large libraries.
>>> The Linux kernel is also large, and it's made larger by having to support
>>> obsolete crypto algorithms for backwards compatibility with iwd.
>>>
>>>>   - AF_ALG has transparent hardware acceleration (not sure if openSSL does
>>>> too).
>>> OpenSSL takes advantage of CPU-based hardware acceleration, e.g. AES-NI.
>>>
>>>> Another consideration is once you support openSSL someone wants wolfSSL,
>>>> then boringSSL etc. Even if users implement support it just becomes a huge
>>>> burden to carry for the project. Just look at wpa_supplicant's src/crypto/
>>>> folder, nearly 40k LOC in there, compared to ELL's crypto modules which is
>>>> ~5k. You have to sort out all the nitty gritty details of each library, and
>>>> provide a common driver/API for the core code, differences between openssl
>>>> versions, the list goes on.
>>> What is the specific functionality that you're actually relying on that you
>>> think would need 40K lines of code to replace, even using OpenSSL?  I see you
>>> are using KEYCTL_PKEY_*, but what specifically are you using them for?  What
>>> operations are being performed, and with which algorithms and key formats?
>>> Also, is the kernel behavior that you're relying on documented anywhere?  There
>>> are man pages for those keyctls, but they don't say anything about any
>>> particular hash algorithm, SHA-1 or otherwise, being supported.
>> <https://lore.kernel.org/all/CA+55aFxW7NMAMvYhkvz1UPbUTUJewRt6Yb51QAx5RtrWOwjebg@mail.gmail.com/>
>> "And we simply do not break user space."
>> -Linus Torvalds
>>
>> Is this no longer applicable?
>>
> As I said, the commit, or at least the part of it that broke iwd (it's not clear
> that it's the whole commit), needs to be reverted.
>
> I just hope that, simultaneously, the iwd developers will consider improving the
> design of iwd to avoid this type of recurring issue in the future.  After all,
> this may be the only real chance for such a discussion before the next time iwd
> breaks.
>
> Also, part of the reason I'm asking about what functionality that iwd is relying
> on is so that, if necessary, it can be properly documented and supported...
>
> If we don't know what we are supporting, it is very hard to support it.

IWD uses AF_ALG/keyctl for _all_ its crypto, cipher, and checksum needs. 
Anything that wifi requires as far as crypto goes IWD uses the kernel, 
except ECC is the only exception. The entire list of crypto requirements 
(for full support at least) for IWD is here:

https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/tools/test_runner_kernel_config

For KEYCTL_PKEY_* specifically we use it for all asymmetric crypto 
operations, (query), encrypt, decrypt, sign, verify.

I'll be honest, the AF_ALG/keyctl support in ELL was mostly done by the 
time I started working on IWD so I was not aware the documentation was 
so poor. That is an entirely separate issue than this IMO, and I'm happy 
to help with getting docs updated to include a proper list of supported 
features. In addition maybe some automated testing that gets run on 
kernel builds which actually exercises this API so it doesn't get 
accidentally get broken in the future? Docs/tests IMO are the proper 
"fix" here, not telling someone to stop using an API that has existed a 
long time.

I'm also not entirely sure why this stuff continues to be removed from 
the kernel. First MD4, then it got reverted, then this (now reverted, 
thanks). Both cases there was not clear justification of why it was 
being removed.

Thanks,

James

>
> - Eric
>

