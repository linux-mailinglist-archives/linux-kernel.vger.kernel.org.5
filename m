Return-Path: <linux-kernel+bounces-51612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CA0848D37
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3F1FB2207C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 11:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FC4224D7;
	Sun,  4 Feb 2024 11:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gvDqrOcG"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9CE2231A
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 11:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707047134; cv=none; b=N1SvYaF1C9cCkgZDIy4DLkeUlaayhUJmc/7diFoNr2vAcQ0BKIBA5/l7P4HaUAGf6c4Joga5Dj+w72X1p2fUkjEE3BRkvevx0rt8cvJlsGLmWq2Z1IPy/51dV+2J3ljSjSvdJDDWI9rY5Mr72El3vLGEL7qwzUpB/KhaqJt+Who=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707047134; c=relaxed/simple;
	bh=qgF9mgJuwBON3XPXrWsmUJR+tGrDKBmgIGDGKxUWbwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+bOXBYZJ+gwwAA16WV7Jl3YPFEwy7WXfEOUsO743jnc/fWovrQc0wJ6jEz74TuPr69IF2BdfQE9fv6nrJ2LyQfkvMYLRxV3TPzONQYAbmec9xOReG7gL+odrn/2y1iBkVQIGLv3c6aXN+epNnz1/npHkumvzOh07boB7evU9k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gvDqrOcG; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a36126e7459so453439466b.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 03:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1707047131; x=1707651931; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VWi8x1miBJ1PGJBMtpIeIYYJwAHPliiF8cHXBoeQK6g=;
        b=gvDqrOcGI+qfW2Yg1FJSAzMhM5mvboG757dGgBtsDT0Lh5JQWT6oeHO58uMWtg4ow9
         UQkRjgYXyTq1p6kDCKMASLMum4BM5tHsWDN9JV5ghrKi/5HW/kvbDbuVZtke3CI1rdgd
         X7aOOM0hEbdRGMjYLjcO7fd2BID/J5GN8L1Yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707047131; x=1707651931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VWi8x1miBJ1PGJBMtpIeIYYJwAHPliiF8cHXBoeQK6g=;
        b=uWUM6bD4V3dV+my8++jkj7qta7IA4Seirrw2j4FLuWf7S9UAvZOHO273DTVxR56Mgj
         OQEuPnzK8U6sxm4rNu5cgidPdYe4y+qal0p00M6pkq8XWr/Tr1xt5AQbem2d2jqKPqgh
         LwU/8uYsbGXMPU/NwslZdvHq8JA3xHDncSi4ROjiqBQNFO5TV7MsIK+0wji79kl4Lvjl
         CwJKFg6I+M8W82gARZJrZtb6D/x2KO3//cbRTkNluOtdZlEwgDswUySfTXYQZC51dxo7
         2HmjaR3lNjJ6I/udcDYokxi+7+tG9trD7732mkIsZUdrZ/3wtWRdftnYvTASTTEXNFtK
         x6ww==
X-Forwarded-Encrypted: i=0; AJvYcCUexottMHgTAp5+zRncQ2A96Hhv77oJUFms8nHxrr90y9eJ3mAPsWIUBkIWfVciJ2YeocHaZjyLbmC8Bib3ffzM1k/EzjDFKPflGxoE
X-Gm-Message-State: AOJu0YxHfF1xFDX7+uPvPLSlC/CvIsDC9Nq1nMsL9dTlDZsSTyDkeVvA
	cch9WkX0sdweNBxoQ+BV0FHpWUorxv+LHiVo6zrOpUWwoemTPaEhM2ha192wkMBds5PMw4wjZ1R
	540I=
X-Google-Smtp-Source: AGHT+IFvU0+fp66rG356ahWBK1M8aq1VvHsV509YLlq3Dekct58or4ApSu4TBUh7ZN8Qyce93jhz1g==
X-Received: by 2002:a17:906:2dd5:b0:a37:4d06:50b8 with SMTP id h21-20020a1709062dd500b00a374d0650b8mr3378987eji.64.1707047131205;
        Sun, 04 Feb 2024 03:45:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUkjRR4KRMJAwOUGsjXMVhFzdXSd+z4CUcx1FqVSl6LAtAfUEa/paGJinq7nl9yT35eZJUH069X4dy3qKhJMVWZmOA+8TQ12JtYU7Fn
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id vw3-20020a170907a70300b00a35920de35dsm3044945ejc.188.2024.02.04.03.45.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 03:45:30 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so4712132a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 03:45:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCViDzaygXQGKtAF9zFWZLTIgoPi2s0h6ibXIuish/zMvgPOK/mv/FefE8UHf5ayxkHzcZDpKDjFlF+ypOlwguortSHbY6WBvFVEwiM4
X-Received: by 2002:aa7:d294:0:b0:55f:8bba:d0ae with SMTP id
 w20-20020aa7d294000000b0055f8bbad0aemr3329700edq.23.1707047129481; Sun, 04
 Feb 2024 03:45:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202-exception_ip-v2-0-e6894d5ce705@flygoat.com>
 <CAHk-=wiaSjYApqmUYCdCyYfr_bRsfVKDkwU6r6FMmoZzrxHrKQ@mail.gmail.com>
 <eeb92d70-44d6-47f4-a059-66546be5f62a@flygoat.com> <CAHk-=wiUb1oKMHqrxZ6pA7OjNmtgw6giTKWiagUC2kt-ePCakg@mail.gmail.com>
 <716af17c-136b-4852-86ce-a23bafe34fbb@flygoat.com>
In-Reply-To: <716af17c-136b-4852-86ce-a23bafe34fbb@flygoat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 4 Feb 2024 11:45:13 +0000
X-Gmail-Original-Message-ID: <CAHk-=wjvt75XFUWxPQQJZE0Wdi8HtSLtqQm2L-ZrqH7=2g3ByQ@mail.gmail.com>
Message-ID: <CAHk-=wjvt75XFUWxPQQJZE0Wdi8HtSLtqQm2L-ZrqH7=2g3ByQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Handle delay slot for extable lookup
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Ben Hutchings <ben@decadent.org.uk>, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	Xi Ruoyao <xry111@xry111.site>
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 Feb 2024 at 11:03, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> Well this is the tricky part of my assumption.
> In `exception_epc()` `__isa_exception_epc()` stuff is only called if we
> are in delay slot.
> It is impossible for a invalid instruction_pointer to be considered as
> "in delay slot" by hardware.

Ok, I guess I'm convinced this is all safe. Not great, and not exactly
giving me the warm fuzzies, but not buggy.

         Linus

