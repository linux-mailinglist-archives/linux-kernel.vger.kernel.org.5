Return-Path: <linux-kernel+bounces-105011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5219687D796
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 01:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9461B216B6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AAE1373;
	Sat, 16 Mar 2024 00:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deSXI4qK"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97F1634
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 00:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710549066; cv=none; b=ETbF2PtebLTjy13dS84LNfIyyNTYEBYr4HOx7mKbLMa3iLmeRPbljWG2vGBzbCvr6mgmUjPWannK2z3/Pv7URSMZdyEcqDp1+PDJkOziDq5e1tucYTchXV9M55TLpPK6YCVNM785o2j3GhA1jXb5V0VNXjK4T/FOiPVpCxnSHHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710549066; c=relaxed/simple;
	bh=VRrrETmGhhpjmnTjOBocZGtzzHnWjWes1vJPKtIeRT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1AdTdH7PcieY9PQ44nBjsDdZz7ohh6Eu/VPsFhjHgiKIl6rzg4LhV3IClzix2xeXS0PWAWIa8NpPcqfnLJ51KIfPG1O8KnM/k/FqbfdBGvaRzbNuFl3Ac2ieDSAYKkEDGCWowYB5q6r4g0pB6cugXQx3N+9tghO+QtxJG49up0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deSXI4qK; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-568aa282ccdso1927746a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 17:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710549062; x=1711153862; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXqCLMl6FPg3KVepZhCZISIw8iqQ6wM3Iz0e0kowd1c=;
        b=deSXI4qKAY2jRrwiHNrD2IVhmxCdOi6lYQIQlHeUCcvFEIYP1kbl40bv1cxqRyF+xR
         J83Kuo1i8hxOHruyAvZn8tSAKz094fVHgHgfs2ZvcZpZCQy1FHqUBbGohA5/XoIX4XSj
         NETuV5J03Ie994NSYkIFhQVeXAInm26yTwhvjnvzmgiuWvn2NimWuDo15xKdPzKZBpGx
         aFH5cqaMCXY+2/+IBENruZkMHIabkjQ+tJZzeNjuV0al4i/8oaI54MKRvpgylXblLcTd
         6RhGJDzotzc84nZhWTaM2EI8CLPXUAcRMhriyqL0ZqIRlZMgMt1chPi0qwzQTWvYDs7X
         EEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710549062; x=1711153862;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yXqCLMl6FPg3KVepZhCZISIw8iqQ6wM3Iz0e0kowd1c=;
        b=kQsVVipqIbUl+Ah3fO0wLPZwAjOai/QUo+odbsaooFaVxglcbASCljxp7KRl+lOrtu
         cdtIyue/LobVZyNgSSdCbjLa36LmH5yofgeLuAMwi/rs7LmASd4yB18QVUnJV8JI3MjJ
         diPjDaEIU3ZzmucLzzwRv0Zene80tLueYT0H/p5aJXjcWlpqF7Ry9lvqPs8YBBn7rxFC
         Q+v0tVcNjgFFx3NgtgkfaXhdXKTpYN5vPKZra8DGW/fMEl1k8a2QcK2O4BnhOw1z2upC
         jpfHm0dIYL6rhcWvhVFjT41ESLp8RbrzKI1pKra9pbNoGWPaT9OxZ1h3CJm8fwgBIcCu
         WUig==
X-Forwarded-Encrypted: i=1; AJvYcCXL5obruoJ270fW29dOwD+8ApBKwBqwojJkHusOIPQoh0/Vu857HyhL0GrrS3VyIXT5+1FJgIkccI3NAXOhkZJnKyYzHhnXziU336Z5
X-Gm-Message-State: AOJu0YwS68g7YAzzQZAimvzArviRDMdERx6r2ZfcEW9UWBWKBd3zQeWp
	73ZKT+DclKV315SeVJdCcJm+hAZuCu5Sexcx2ARBtqDkHcKWaPA6
X-Google-Smtp-Source: AGHT+IFkh65kaYff5+Zz/bl9YaCjB9pWgspD5NWXjRHk5mwwGjHN0Wht+t2L5fly1ykLxTCloPDjSw==
X-Received: by 2002:a17:906:4a12:b0:a46:42dc:1f67 with SMTP id w18-20020a1709064a1200b00a4642dc1f67mr3048739eju.74.1710549061767;
        Fri, 15 Mar 2024 17:31:01 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id e13-20020a1709062c0d00b00a43fe2d3062sm2160672ejh.158.2024.03.15.17.31.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2024 17:31:00 -0700 (PDT)
Date: Sat, 16 Mar 2024 00:31:00 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, x86@kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
	Michael Roth <michael.roth@amd.com>,
	Brian Gerst <brgerst@gmail.com>
Subject: Re: [PATCH] x86/head_64: move parameter close to call function
Message-ID: <20240316003100.4vgiatdsnm77irhg@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240315041420.12802-1-richard.weiyang@gmail.com>
 <CAMj1kXFRG8notqdt7toS9n3V-Y0KPHZBr3kZBJredCACMSubfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFRG8notqdt7toS9n3V-Y0KPHZBr3kZBJredCACMSubfw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Mar 15, 2024 at 10:10:06AM +0100, Ard Biesheuvel wrote:
>Hello Richard,
>
>On Fri, 15 Mar 2024 at 05:14, Wei Yang <richard.weiyang@gmail.com> wrote:
>>
>> startup_64_setup_env is first introduced by 'commit 866b556efa12
>> ("x86/head/64: Install startup GDT")'. Then 'commit 469693d8f622
>> ("x86/head/64: Re-enable stack protection")' insert some code which
>> leverage %rdi, which is removed by 'commit 8f6be6d870e8 ("x86/smpboot:
>> Remove initial_gs")'.
>>
>> This left the parameter of startup_64_setup_env a little far away from
>> where it is used. Let's move them together for better understanding.
>>
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> CC: Joerg Roedel <jroedel@suse.de>
>> CC: Michael Roth <michael.roth@amd.com>
>> CC: Brian Gerst <brgerst@gmail.com>
>> CC: Ard Biesheuvel <ardb@kernel.org>
>> ---
>>  arch/x86/kernel/head_64.S | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>
>The code that you are fixing here no longer exists.
>
>If you are going to send patches in the middle of the merge window,
>please make sure that you are at least up to date with Linus's tree at
>the time you send the patch.
>

Thanks, will do it next time.

-- 
Wei Yang
Help you, Help me

