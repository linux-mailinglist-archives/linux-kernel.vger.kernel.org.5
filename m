Return-Path: <linux-kernel+bounces-86251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFD786C2DB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7A59288E70
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E57F47F53;
	Thu, 29 Feb 2024 07:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKDn3jSD"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5392736123;
	Thu, 29 Feb 2024 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709193161; cv=none; b=hX+J4o+KTwUPXy5GqnoWFCcfCLX7eaZF+HaP841Gmpt/gKRrlgkaEnXeOC2BfIEnhilZYG/bfFvhBCrpvKs633k+hdwqu0H3BT7mMJiv6DlPJedAC0OBFcWeUEEDrCCiXQfqVLCPLUXBZC+dEJoCM4h5F7mXsFjw7ZoiJhdJ3vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709193161; c=relaxed/simple;
	bh=e0kBmdz6lHm0agLmmbZC7IlJJ22/X6+f6wHkV+FAG88=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=oCePv8BJhn4ACEgAK5tFzclGQXRpg3pYi0H5MGmv27GOu/mLDio89gOJU+Hq0XMtlFyCqywEwJlGzfARek4cKZFWYf03wTGTagOVryBR9T7Yy04fs70R5tn58DUcMgThITqom4eF1Czk4+iKCnWeGroigMA57NTyEvoNOhORT50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKDn3jSD; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dc49b00bdbso6458595ad.3;
        Wed, 28 Feb 2024 23:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709193160; x=1709797960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5un4ACCZ7NErWeeOUddptPFbjqDwYB5cCq+sufhY4Dw=;
        b=JKDn3jSDiP7Y4BykhdLllsCEvlPw7W6WVuPdfeGcLknk6w9hWrcZsu+f0q6rK5+7n+
         4fH9GhKmxtLl4cwxBoZzTDVwlLed5emGaYGasAOO6kEh/9PX8uGm5lSucgxrN8x6U77v
         qZXF+KFJzCZGr68UFLwjUWwUKwlkvclV//D8ASJb8pDkjb9gJXqrAZuHX3Vpf9EVafj8
         daBpLgysAl5crljn4D8O5tOzGE2kixXFj1DzvGVCvLRPiOahEs+0QJUFjQRDZfEwsP2Y
         ye760P7at0HE/jL0yaZqKvzmmpgInKJKCOLmyEc4zWaZZ4LMeIsQM+p/A2FgGApsSTyS
         vy+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709193160; x=1709797960;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5un4ACCZ7NErWeeOUddptPFbjqDwYB5cCq+sufhY4Dw=;
        b=lCxSg6muYI0p3fPCTXyTlWFUCLX9pRU8IvNreuuUS4Kj1f+gTqV/JuSsBmCEr6buuR
         YVuT46h2RGtXvKRWmNH0NC+HB3tecYQN2/8Njd41/zpLDeepq4/LHaipFZiEoQLNmdfG
         /dUH4BZs6GvwEgbKvYdobub+/tjNcITmIflV9bSMI9wl/Lq03Inosx84TWfY+vVZyStK
         VKKc7fM/2JDOcTZKN+C2gj6Kq/1KOctoSUV5ETXEj5eM0adsP2nQLaCnFQ6+8mDLbK3F
         bV0sCN1YYErMX84GkjBsdLk9xwl6bs5wIAhbR4Ky2U4BeVxtShWzYhOJEuyGwz2Wpkg4
         fubA==
X-Forwarded-Encrypted: i=1; AJvYcCXXjCysE9rgiBgAc3A72QWGcDOFfLQTABj4QZ8sMwBsMGPZGK0ucDLYVU6b/Xof7SARniElHstqQtBLdrXrDIgsXgU4B09ee3pEN2JTgkzPKLLvxMS4YzSJ9KQqQOfZMFGejeZyjrGlE+0oUkXbAPZDslb+arX8us/0smbAXQjDW9nMyP2uucnedDoKce0/HrnBogKrolBXWLLMvetLFjOysbob
X-Gm-Message-State: AOJu0YySm8acZZVkBDstVjjBcsebm5owAA3enlBRdFXSqgWUdz/kHusc
	kOghvW/NObgop32wXeG/XQD32DK64gb85Yum6EGmCecGikTJNrN4
X-Google-Smtp-Source: AGHT+IEZEymE5vyIjhpOWpiG7w217jlxxRMWq4kcbp3e+Hrb0BRhZh/isKM4x8enMJ/Z6+yecEzxeQ==
X-Received: by 2002:a17:902:f682:b0:1dc:483b:534 with SMTP id l2-20020a170902f68200b001dc483b0534mr1371017plg.68.1709193159506;
        Wed, 28 Feb 2024 23:52:39 -0800 (PST)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id u8-20020a17090341c800b001dcb4a30685sm754120ple.4.2024.02.28.23.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 23:52:39 -0800 (PST)
Message-ID: <8df0c587-8f5b-4523-89d7-dc458ab2c1df@gmail.com>
Date: Thu, 29 Feb 2024 16:52:41 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: lukas.bulwahn@gmail.com
Cc: corbet@lwn.net, jani.nikula@intel.com, kernel-janitors@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 rdunlap@infradead.org, workflows@vger.kernel.org,
 Akira Yokosawa <akiyks@gmail.com>
References: <20240229030743.9125-4-lukas.bulwahn@gmail.com>
Subject: Re: [PATCH v2 3/3] docs: submit-checklist: change to autonumbered
 lists
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20240229030743.9125-4-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Lukas,

I might be nitpicking too much, but let me go ahead...

On Thu, 29 Feb 2024 04:07:43 +0100, Lukas Bulwahn wrote:
> During review (see Link), Jani Nikula suggested to use autonumbered
> lists instead of manually-maintained bullet numbering.
> 
> Turn all lists into autonumbered lists.
> 
> Link: https://lore.kernel.org/linux-doc/87o7c3mlwb.fsf@intel.com/
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  Documentation/process/submit-checklist.rst | 48 +++++++++++-----------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/process/submit-checklist.rst b/Documentation/process/submit-checklist.rst
> index e531dd504b6c..c984b747a755 100644
> --- a/Documentation/process/submit-checklist.rst
> +++ b/Documentation/process/submit-checklist.rst
> @@ -14,62 +14,62 @@ and elsewhere regarding submitting Linux kernel patches.
>  Review your code
>  ================
>  
> -1) If you use a facility then #include the file that defines/declares
> +#. If you use a facility then #include the file that defines/declares
>     that facility.  Don't depend on other header files pulling in ones
>     that you use.

Wait.  This will render the list starting from:

    1. If you use ...

In patch 1/1, you didn't change the ")".

It was Jani who suggested "#.", but "#)" would work just fine.

For details, see docutils' documentation at:

    https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#enumerated-lists

By the way, you should be able to use auto enumeration in the 2nd-level
list as well.

> @@ -77,7 +77,7 @@ Check your code with tools
>  Build your code
>  ===============
>  
> -1) Builds cleanly:
> +#. Builds cleanly:
>  
>    a) with applicable or modified ``CONFIG`` options ``=y``, ``=m``, and
>       ``=n``.  No ``gcc`` warnings/errors, no linker warnings/errors.

While the first item needs "a)", subsequent items can use "#)".

Either way,

Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

        Thanks, Akira


