Return-Path: <linux-kernel+bounces-130545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9023C8979C4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8E361C2177D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12538155A46;
	Wed,  3 Apr 2024 20:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxO0e2xm"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B2043AB6;
	Wed,  3 Apr 2024 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712175985; cv=none; b=reyvnkhCDBpAIPxN4qyUd5S+FPkSZs3OlpbThvb9QnddJAWW9fofdZIXki70wSS2BF39cFFkA7pUyMYbXFeCBuf/y+COFwAlCFbYpVNx7t8Wc4H3kCqfleiXq+aR+hSq/URcbXDKW5z4YGetuB6yZHW21a9G7rx5g2xJYRmf6Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712175985; c=relaxed/simple;
	bh=U/ik6ZerHWS9g3vVLA53Xj/8Jv27CN/2MsZ0+ElQNpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NFt3FnTRS6SEpXOCagEW0onjRwsqMpP45maJ024jOsZjhqVbE6UI/Wld55v0xbAGsqjW4KNteAGqKiT+VuiRDzW3iYhNTgw8Dc3ATBPbe7bSoc3C6sM0kqz0Yz2bBr8M1dS6DchJxtpNHc0akHgY0SStvNgAH2O9QzN9rtTxYa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxO0e2xm; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51381021af1so465427e87.0;
        Wed, 03 Apr 2024 13:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712175982; x=1712780782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P9vLyZapUJvAgqkHdKP2bDi5kwoB6rqIDuXTA4xWhoc=;
        b=cxO0e2xmyd4LcBXupHHzy4BqhZ0ShwYTN4OZ+x9yJisIlccJ9lhe+IZOaPtmxNGfXX
         ig6aUra0LvN1rAWGxc06WbzbmpdaY0fKR2Pc2Ohz8DIMWHF7Xkt95qAFkStXyqzq5vb6
         7mP9POw2web2iNpz1FVkMADGnCiS/Z8jhwUY3KMTgADI2rpeCzcQu0xWLE8VbXqevT8y
         OP2mGxkR86f1rkbjcJxTwiBbwrJdiFiYwn9o75oEVBfciHEjPRN9SVSKBtdmT1XEID/N
         tm/6IKTehNQoJVy4VIx/xNPYgSXQc5QYGJ2pljF1qy4SJ+Emti2SODMJnC9zjDZzuMzt
         KFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712175982; x=1712780782;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P9vLyZapUJvAgqkHdKP2bDi5kwoB6rqIDuXTA4xWhoc=;
        b=X3Pft3+RE1BkXqoXlCpzuSuyz/ruv6ORFjlQV7EcG48c1pZqJgICuLf/P6k8/UBtC2
         wrRjtAvJVq+/y4QBG3bhQY4Z5SoQnUnYn2+52RyhzaJvBrrs4ujRbEbmkFtlAIAbPTHJ
         KZzfqH92TgSmtYWpDOyOWkiPYj3tviRN1KBpK7WOpmrGzJWPzrDAVKD/bNp25N3Ap+7B
         ZdCJXiy16vHptd5WRdSRSy6xviR8NljDuqgAEEKPniem1DxAwfDOJU3xnxZAGWa8nwMG
         SGkbUlz+XbdOrZ8rAjbYLyrw9IkV9Ha9ro3T2OXUhYcLSitrgshyYFXQUC3HwlJF2MY9
         NCXw==
X-Forwarded-Encrypted: i=1; AJvYcCXJ58bMgWNyld7jh0P14C7WxnxOcb67Gz2heE4fpNasblyO9XWBTz2MJzU7cVgb8/8QlxppPhrJXTQ/7qXLQ3+bbiXUhDPG4qLQTdPYVdbLXKk91F5T0Ulf+PpMZDIseuvVZB4emN0lPqylKUzeXNs=
X-Gm-Message-State: AOJu0YyfzuCwtuxEd0RYpkSHnURdubnuGJxLk8qPYHCaBdAnGNrmFFmA
	1o6WgWjX/r7OpK8URetpkHoHgB4o7/u3sJmdzuPRk59GdtJIATlP
X-Google-Smtp-Source: AGHT+IHcZfwsBmLESX5y8kKFaF3TXTZZFK3D8XCjEw/wMe0EJgGTWMLIC4yzVw2AIjJRBEw3K5yTVQ==
X-Received: by 2002:a19:f812:0:b0:516:c44a:657d with SMTP id a18-20020a19f812000000b00516c44a657dmr459758lff.64.1712175981537;
        Wed, 03 Apr 2024 13:26:21 -0700 (PDT)
Received: from ?IPV6:2001:678:a5c:1204:59b2:75a3:6a31:61d8? (soda.int.kasm.eu. [2001:678:a5c:1204:59b2:75a3:6a31:61d8])
        by smtp.gmail.com with ESMTPSA id x25-20020a19e019000000b005159ff27541sm2143324lfg.22.2024.04.03.13.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 13:26:21 -0700 (PDT)
Message-ID: <f37a111b-f5c5-4337-8eaf-46a2c28f01da@gmail.com>
Date: Wed, 3 Apr 2024 22:26:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -v2] x86/retpoline: Ensure default return thunk isn't used
 at runtime
To: Borislav Petkov <bp@alien8.de>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, "Kaplan, David"
 <David.Kaplan@amd.com>, Ingo Molnar <mingo@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "x86@kernel.org" <x86@kernel.org>, David Howells <dhowells@redhat.com>
References: <20231024201913.GHZTgmwf6QMkX8BGbo@fat_crate.local>
 <20240103184656.GEZZWroPmHLJuP6y5H@fat_crate.local>
 <20240104131210.GDZZauqoeKoZGpYwDd@fat_crate.local>
 <20240104132446.GEZZaxnrIgIyat0pqf@fat_crate.local>
 <20240104132623.GFZZax/wyf5Y3rMX5G@fat_crate.local>
 <20240207175010.nrr34b2pp3ewe3ga@treble>
 <20240207185328.GEZcPRqPsNInRXyNMj@fat_crate.local>
 <20240207194919.qw4jk2ykadjn5d4e@treble>
 <20240212104348.GCZcn2ZPr445KUyQ7k@fat_crate.local>
 <78e0d19c-b77a-4169-a80f-2eef91f4a1d6@gmail.com>
 <20240403173059.GJZg2SUwS8MXw7CdwF@fat_crate.local>
Content-Language: en-US, sv-SE
From: Klara Modin <klarasmodin@gmail.com>
In-Reply-To: <20240403173059.GJZg2SUwS8MXw7CdwF@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-04-03 19:30, Borislav Petkov wrote:
> On Wed, Apr 03, 2024 at 07:10:17PM +0200, Klara Modin wrote:
>> With this patch/commit, one of my machines (older P4 Xeon, 32-bit only)
>> hangs on boot with CONFIG_RETHUNK=y / CONFIG_MITIGATION_RETHUNK=y.
> 
> I wanna say your old P4 heater :) is not even affected by the crap the
> return thunks are trying to address so perhaps we should make
> CONFIG_MITIGATION_RETHUNK depend on !X86_32...
> 

Probably, I don't have much knowledge about this stuff. The machine can 
at least be useful for testing still :)

