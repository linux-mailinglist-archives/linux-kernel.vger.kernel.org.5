Return-Path: <linux-kernel+bounces-144899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC428A4C56
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0409CB24092
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B678C4D9E5;
	Mon, 15 Apr 2024 10:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FZssINlV"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5860E3BBF0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713176094; cv=none; b=AYHKnT6DTyLzrcPv+JqgkHh4IZF1q5A+XRIxkzysEjLRApcAB6jNvVziYTo46qK0gd/RAFFLFcZ3M2Rsxse6lF19Tq7ijtSsJ+Qkj4dgu3hkNm3qgnW8peyfdFrvtdZrZhH0L3hnPo02EY9xfn/FMvXGc48Pn1VoEUdN3uC4o+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713176094; c=relaxed/simple;
	bh=C9sQZgU41qox3cdQNRYM+VmJ0KsaHwAs5oL/6SV1szk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aGIGDpiChbqV3iUADHouc7k5DaMtbt38HsRLHy/AbmbBjR2yA+1BgGjCrybHNBP7GMWVnkxIg+9mqYwMQUPYRhQNWIv8/cRmtLyORMN6KZ2UMDb99IdJ9j/aobqa0Q9q8H7/wAYPIY6yiV/PiLRCYnvfEIWCMvnehiHyI78X6dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FZssINlV; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41551500a7eso16468495e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 03:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1713176090; x=1713780890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ch7nAOdYuE5TTx7zosaZVjyYvnMuu77K7uAtyFJG1J4=;
        b=FZssINlVL/D9xt6U/cHtfuZAcLUnsydZx03U7MJ/jpQjkAMn3wZlR/gfU8hny7ZrtR
         5Hvv4a7IEwqlSqg3Zb0n05GsXTYmGoiP1DH+qZVVfgUtN5fg7b+4V1imxsYXp/ugRBM4
         Hh5hhVWt6I/0nKLnvKNzxHVR6GtLp8IayRseaF244SgsnT3wAG59u8fswU0sq+WE0ide
         zIqpF1AfPwU6CSLDiEy6KHpCd1cYRkHGCQwHJem7EHv2B1XmhjrEJZv7Fi8IX5HTtiNZ
         Kylj184cjGVC2OSEFzf7mCA1Q/sxJGLVLJhZXuDx/rv9RaYMtWgvDoo1hlWI0pPwbZdz
         svRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713176090; x=1713780890;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ch7nAOdYuE5TTx7zosaZVjyYvnMuu77K7uAtyFJG1J4=;
        b=cgNEoMExN5/DZNLzFjre6wSIQzxDMbc0J1aIzSzeT/+Jns+JocIJaX9gHHCmju5BRu
         F8Xg1NWzh6YIbtwRIdstnaJO65DbqyuRCK6T740eNAL5dO72Gv6dy1K7bNe0V7zsXDVc
         3DqOCYxdHN1YC6m8x3PT/sY59iyVRM0JynhZz9KNYmYrO43HXJ7r5crrCMKnByQDpFtH
         yrHPMmcYY9+ZpeXiRlPKxMZhhKo1HrMxjsaNoxlBYTPoOvaXLJq1g5zqpOSjLjomekVw
         YFkngYB8a0bmYzYMfpNph8yt8NU30i2/xMIqbUMnyAP4bBDrTvxetjmUQund4R4taC62
         +P5A==
X-Forwarded-Encrypted: i=1; AJvYcCUcbdj5r2RNMGiHk0BVWTl5sGUi7zZXipSBkhVNPkZWR9cc/WBAz3zIXINKaiPr36CgcVKeCRmpsKkudxHw7Ob5YzZeaRMcGQDKkEIf
X-Gm-Message-State: AOJu0YxI3Y8bNsGgV/80sXuPBOQKBFdSl9ivfgMIUbrbkjjH6Sl341We
	9yMJM2GVdLrB9OS2YWNEt/CAE8k3Pn6+88xkY+nhkIVlAdrMjf7zJm4QJsQYYAk=
X-Google-Smtp-Source: AGHT+IHjhZnZ/UpFBsH2kTHC9OVKKMcAQN8weN22/XUZrv3wNhDL0ai2lMmulhKpKNELcofiW9Zl6w==
X-Received: by 2002:a05:600c:1c19:b0:418:6138:6777 with SMTP id j25-20020a05600c1c1900b0041861386777mr1473992wms.31.1713176089744;
        Mon, 15 Apr 2024 03:14:49 -0700 (PDT)
Received: from ?IPV6:2001:a61:1366:6801:d8:8490:cf1a:3274? ([2001:a61:1366:6801:d8:8490:cf1a:3274])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c314f00b00417ee886977sm13425859wmo.4.2024.04.15.03.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 03:14:49 -0700 (PDT)
Message-ID: <c35f98be-23a3-41c3-bee5-f394ce504545@suse.com>
Date: Mon, 15 Apr 2024 12:14:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: cdc-wdm: close race between read and workqueue
To: =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
 Oliver Neukum <oneukum@suse.com>
Cc: Aleksander Morgado <aleksandermj@chromium.org>,
 linux-usb@vger.kernel.org, gregkh@linuxfoundation.org, linux@roeck-us.net,
 linux-kernel@vger.kernel.org, ejcaruso@chromium.org
References: <385a3519-b45d-48c5-a6fd-a3fdb6bec92f@chromium.org>
 <87mspvi0lk.fsf@miraculix.mork.no>
 <a6ad34d3-9cce-4178-8271-0e09ced2b6f4@suse.com>
 <878r1fht93.fsf@miraculix.mork.no>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <878r1fht93.fsf@miraculix.mork.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15.04.24 11:26, Bjørn Mork wrote:
> Oliver Neukum <oneukum@suse.com> writes:
>> On 15.04.24 08:47, Bjørn Mork wrote:
>>
>>> urb from service_outstanding_interrupt(). That's why it was added. See
>>> the explanation Robert wrote when introducing it:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/usb/class/cdc-wdm.c?id=c1da59dad0ebd3f9bd238f3fff82b1f7ffda7829
>>
>> Well, the explanation is correct in that we must read
>> data available. However, if the RESPONDING flag is set
>> and the URB submitted, we are already doing so.
> 
> Sounds reasonable.  Except that the bug proves we didn't.

Why? I am afraid I do not get that part.
  
> If you are right that service_outstanding_interrupt can race againts
> itself (and I don't doubt that), then I guess this could also happen
> between failure to submit the URB and clearing the flag?

Yes, it can. In fact in this case the behavior should not change.
I am afraid we have a misunderstanding. It seems to me that in the
unchanged driver the result of service_outstanding_interrupt()
is undefined.
Please explain.

	Regards
		Oliver



