Return-Path: <linux-kernel+bounces-145457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACDA8A565A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34CD82846F6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE36778C90;
	Mon, 15 Apr 2024 15:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YdTjEKEC"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1DA76046
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 15:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713194836; cv=none; b=tAFyHwGQ56yhGBPqR5C2JDvOWXmSOkq2k5Ejn3pcJdZCPMZd4eTwTm0DjGKl4I0qrkf5neO4owzT0a0YmBSXFUu4iEK0yQhiTsMqNon/1jbCdIow0RuU9Ux22yuge44aeRw0wdINzgH0PdHd8qvTwV2DHKwUX3ewrZwxlaoXvTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713194836; c=relaxed/simple;
	bh=u3ZrFnJ3WA6PO2I5zXiala3pmUd5BrnSjRlI9qLqNVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/xlBIUSeyTJOqBVfKt0A3pUORqyVSy3wOFQrnTUvIpvEi3ommdzszYAVhK6uU2S4Y+bEXZmfvRjyMuXP5REHQdvdStgGju12Fn/xjXp8BaxkHNPPVOTtNKNYscSV8mSBZ8Iqt2M2xbqzRRrT89oxfcAFm/EMIXm5mk8Us73Les=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YdTjEKEC; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-417f5268b12so29003575e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1713194832; x=1713799632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cNYAe9G5dywbCJuioffAso3TSqn5Ayt2vh93iXM+GDU=;
        b=YdTjEKEC7OjvB4OsPkd0isETEU4BZsJy+1pjTQNGY0/XCbCo4hQwKaORwzK3lKXwHn
         bCeeBn/CfLkod6iI/pjneoCziX2mM4chvwEbaNfA8lJJaoygrGICF14g11iTmkdSmfNs
         kuq0ER+6XtrZWe4QtuvZSOyl+NCFG7F0JnMg8yftoxTgibLI3/SYEx+DbHosIsZ+zczI
         85lfrcsaAh8Rh4kWNP42zjL2KZR3NSjy6d1ixaM7kcE4IdIZON1i5J6GiMThXKNYUGO0
         5WTYoJG3900qycuyuNJl45GkHATabcPJ5tApych4dBstcSghJPXFeONU/wpiBhcr87Sy
         AwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713194832; x=1713799632;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cNYAe9G5dywbCJuioffAso3TSqn5Ayt2vh93iXM+GDU=;
        b=YsrBkSR0yG06955AXoWuwELPN8O3JwDgEabOUj+Ob4JjLftatV/JFzVV1eotcFJZ1E
         +zcgL3VCX9x9XVlykViprD/q+4Cr2dCsG75AhgpuME8O+sP/mIXZVeoJ89mq3dW42cR9
         1FDbj8H+HUw6ddGGfnsHYBRCAh0eLvbmX1Ufhbf1ePjVNr4EPEw5TrbY3kNi6D/JvMfm
         Mkv8Py1pJKxhzrJbrxpytqeGFOP62iY3E8E4aVDry2KHSUMFOJG6qBklQJMHZcfUWPlg
         dsHcCkpBVIX19l1Tk2ArFM5OMiyklno667T5NBitj6ws6X+cBZohPd4q8KMc3lSLPEjI
         HKJg==
X-Forwarded-Encrypted: i=1; AJvYcCXPXJi8ij9yh1TB3zuo6f/JKkFG72yWVfQzcM/QFsmKoZuf1w4V41oOg8lmRq2wEayDTalbmVlOs7qDMkuYtzcoOzT0maocjBNnbAGe
X-Gm-Message-State: AOJu0YxrPB28CRGhRm0hJ3qIH+pTsNPNAh/KuTx4Be3HFsOma+toiAyv
	kBeVOwREHvHA8XW7DFojS2OLwBPwJ0TJVPeDjQpXUC15q2AhflGnzrTubeIAEoI=
X-Google-Smtp-Source: AGHT+IHWqvkOlIBs2yK6q8jSBGtnqudwpQR3ntq/AIJU0hvwL35AqrELrZCieHzxwE99BF67W5xusA==
X-Received: by 2002:a05:600c:3b98:b0:417:e563:4aa4 with SMTP id n24-20020a05600c3b9800b00417e5634aa4mr9300834wms.5.1713194832378;
        Mon, 15 Apr 2024 08:27:12 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [109.121.142.9])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c4fc400b004170e0aff7asm19427283wmq.35.2024.04.15.08.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 08:27:12 -0700 (PDT)
Message-ID: <7f7df1f6-345f-4062-aa00-40c260b14040@suse.com>
Date: Mon, 15 Apr 2024 18:27:09 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] x86/bugs: Only harden syscalls when needed
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Daniel Sneddon
 <daniel.sneddon@linux.intel.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Alexandre Chartre <alexandre.chartre@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sean Christopherson <seanjc@google.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, KP Singh <kpsingh@kernel.org>,
 Waiman Long <longman@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>
References: <cover.1712944776.git.jpoimboe@kernel.org>
 <079f24edefb5b47e922c2804f199463e04ccf0c8.1712944776.git.jpoimboe@kernel.org>
 <8aee08a9-0d7a-4b5f-aee1-c70bad9433ca@suse.com>
 <CAHk-=wi0QrKuxQQmNsJhn5rE9Qe-Cz_9NsJOcOM1FK+knLeAFw@mail.gmail.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <CAHk-=wi0QrKuxQQmNsJhn5rE9Qe-Cz_9NsJOcOM1FK+knLeAFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15.04.24 г. 18:16 ч., Linus Torvalds wrote:
> On Mon, 15 Apr 2024 at 00:37, Nikolay Borisov <nik.borisov@suse.com> wrote:
>>
>> To ask again, what do we gain by having this syscall hardening at the
>> same time as the always on BHB scrubbing sequence?
> 
> What happens the next time some indirect call problem comes up?

Same as with every issue - assess the problem and develop fixes. Let's 
be honest, the indirect branches in the syscall handler aren't the 
biggest problem, it's the stacked LSMs. And even if those get fixes 
chances are the security people will likely find some other avenue of 
attack, I think even now the attack is somewhat hard to pull off.


So in any case this could have been a completely independent patch of 
the BHI series.

> 
> If we had had *one* hardware bug in this area, that would be one
> thing. But this has been going on for a decade now.




> 
>                Linus

