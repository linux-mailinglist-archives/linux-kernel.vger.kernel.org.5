Return-Path: <linux-kernel+bounces-87838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D1886D9C9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858BE284F0B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D7E3FE52;
	Fri,  1 Mar 2024 02:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsPJi7Nd"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6933FE24;
	Fri,  1 Mar 2024 02:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709260404; cv=none; b=q73kSpXzC6EoBbdzuaom5jLS+2nY5PdpskljqMyu06Pv8Zr6+28GI8tGeciIr3k6F6fnpdhZpG/0uF7cRCgUdVJmdvblQDKmm8VULxwZh7lycIrtabg3qGBmVkG5dQDvq5rbarz3XTDmwIQhFVlp6MipG+S9hPHj0AkNq44pEsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709260404; c=relaxed/simple;
	bh=yZZp+0BpYaUOsBZPJaH080lTaejacCV5/Ei7kqR3es0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ggBBQKSlI+Blw9+etYSsBdMwe5ptt5Xt9IhRl1fZqu0b8UQe8lFvt+uNdS8KWEm6MjDC5uYSvkTGwVRH9H2725HgbmV+3g9xdb9XAyZqyJ+aWfjsb3TZGFDSe1oYNLVpP0I6SFhfpmVOagRftszFTETb0ZID2I6NA08jsLQVI58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsPJi7Nd; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso1477249a12.2;
        Thu, 29 Feb 2024 18:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709260402; x=1709865202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V/uM30sjNa+4vpqQtvZNxYTbK+VqRmciTbx7e14tIgs=;
        b=LsPJi7Ndt/tC/6f8kQpWsqoWjcmdaDdFE1JZ8NmC4FfJnrk+4mYih/7fZK+khk+OTQ
         NWbL6OjgisifubdoX6C2xA07nD6XsQdd7+g8XyyWcrvW+ejU5ydwFYzUbyWkz3Yt6ul9
         lKioNRPr9xicKpgLLewidesb4+98tCf2RzjF7qm1vcqMd/getUF5olM2cCtT1bVJNlTq
         aC6st0fLBFGAutmND4XAazRpGJJCS9MwJLwZAqX1ftfrcRKc2xoYnOakjylzLzVIIWFC
         6vF12mVmuJ71f1LeUV0V6K1kiZ3FhtGv/fxtafslNLbDH2im/jTnDWJVAuK6xeeWm8ht
         VWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709260402; x=1709865202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V/uM30sjNa+4vpqQtvZNxYTbK+VqRmciTbx7e14tIgs=;
        b=aQAvupL3m8wdF96umqwCc4lZbEzs0iJO0OVLj4eO4JXwUdaPpfHohvDnpa9WIQ9s9N
         cDsH/hKEUYItSPyz9kfZ0AspD6axD8oN+yqfKmsPCsfic4Xtt4LGUkmRR2G6l1WeEbtA
         eUorFtkeopX6uuoPPY0raGkUz8qTBOyRjkaIj/ooCauI5Q9bOOe8664FccTbeGKRbTZP
         /9BxTOI8kCRqN9RUrStYHXJO8d1LpwnKyNj5wnIyQhUcVZe4mseP5Y3kUfLbChAMlp8V
         GVHCYvaW6g1v1CpBgUUu+GLPFc9+Ozn1e3mCn2aJgaN0EQQd/zBMgbFINy7vEkFoP7vt
         Odsg==
X-Forwarded-Encrypted: i=1; AJvYcCWt3QgPSf1srQbqJF8vt3k5Wln+1EYc5oMVobzCWf3r7q921TgOzEUDGhBVhMmb6zF0xuacAtWK+AZQZW3fqCIXv97bFa+bUGS3
X-Gm-Message-State: AOJu0YwWc3cBL5y0dqsFR4lL+Hl3yjTem8oTFCiveYCibOjFv5ami44I
	XJCQXwV0IJE78qCXxznNx7mkb2IRy18aNXcM2uoMG2k3bQWAWb94
X-Google-Smtp-Source: AGHT+IFkRGslidnYnWet6U/TEjA6aXDimgR6M3die+6UNX1Y1gdMccWz+UdMlN6YKgFP0f+63FFZJQ==
X-Received: by 2002:a17:90a:db0a:b0:29a:bd5b:380e with SMTP id g10-20020a17090adb0a00b0029abd5b380emr435890pjv.4.1709260402066;
        Thu, 29 Feb 2024 18:33:22 -0800 (PST)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id m2-20020a17090a858200b002997a5eea5bsm2141366pjn.31.2024.02.29.18.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 18:33:21 -0800 (PST)
Message-ID: <fc6563ac-e705-48ff-9581-ac4154a064ac@gmail.com>
Date: Fri, 1 Mar 2024 11:33:19 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: drop the version constraints for sphinx and
 dependencies
To: Vegard Nossum <vegard.nossum@oracle.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
 Akira Yokosawa <akiyks@gmail.com>
References: <20240227131410.35269-1-lukas.bulwahn@gmail.com>
 <e6441dc1-6821-4514-b285-ebc24114aece@oracle.com>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <e6441dc1-6821-4514-b285-ebc24114aece@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Thu, 29 Feb 2024 15:39:31 +0100, Vegard Nossum wrote:
> [...]
> 
> $ scripts/sphinx-pre-install
> Detected OS: Ubuntu 22.04.3 LTS.
> Sphinx version: 4.3.2
> 
> 
> All optional dependencies are met.
> Needed package dependencies are met.
> 
> 
> One remark I have is that it didn't encourage me to upgrade to 7.2.6 in
> the last one (using the system Sphinx 4.3.2) although it did for the
> 2.4.4 virtualenv. Maybe that's expected. I didn't look into it. Anyway,

Yes, it's expected.

Sphinx 3.4.3 provided as distro packages of Debian 11 (bullseye),
RHEL 9, and so on is good enough for kernel documentation.
Suggesting upgrade to a latest release would be noisy.

The version is assigned to $rec_version in sphinx-pre-install.

As a fix to requirements.txt for v6.8, this looks to me like a nice
minimal change.

Lukas, many thanks for doing this.

Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

    Thanks, Akira


