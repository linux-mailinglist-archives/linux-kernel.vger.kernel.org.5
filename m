Return-Path: <linux-kernel+bounces-18125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1620482592D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A185E28562D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7834347BA;
	Fri,  5 Jan 2024 17:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZAGkAHS+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FB534545
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 17:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5572ffdba53so888369a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 09:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704476320; x=1705081120; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EuEZczdUv3gZvL7IiLeH7OBOW4EIGVkBa564euOCBMM=;
        b=ZAGkAHS+Gj/WhACN9MKcrGl88H3AgkREc5CjZlgEWvFWEbja8QHSbDOddwlbL9Yh9P
         GKA+q/6gR+Dv5ClYvSMA0SqFNlBBU+C7sI1xhqc2ngp/GPd0We7jEzLh8dFWSTq1eeo+
         +xQx924k0a542hBJlgEuMdPYI4UvksAaJeWiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704476320; x=1705081120;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EuEZczdUv3gZvL7IiLeH7OBOW4EIGVkBa564euOCBMM=;
        b=nrXlrVOVas37BDhbAgh0ieryW7mUDoQ3vilOLJCSl9ZF3fkHqGe8aC3wYVtSDPVaYe
         PqI20E61Nl4lEHij0m399Gd9DLqxNuR+Q4l1aEDUW+jVNbylWMyzAF2CKOgDE6KkC8kC
         Ef9bRzgZJOjMpZQgM7aLXVAbQJYio36ShyWFRUpM97NzEYLG37M73k/R7SyKLvs3LPVd
         st9jnIm7HQoCnf6hQvSOzQEd5OnH5Hc31NwDpWpbo1y5c0luthe38YgqQ40oSOTRY6nW
         SqUgFmwTAW6NPBSoRka8r+KQE0E8ukST2HTJky9MiL2i6BKomsoVQOoKFsHN2nxQYJ0h
         2BlQ==
X-Gm-Message-State: AOJu0YyRfQJNcY4P3eLYOZgRkgnIDJNbuGBIJmMFJEtPHoXzX0qoQORO
	UcmMVa9qH8ZME2w398ztVewPpQpgiDAhZmmrfG0I4ufIrE4UThrQ
X-Google-Smtp-Source: AGHT+IFfSIsmbV6MXDd5ksJjxGsqat9Wrj5PSy4fxiyBEboaiaKnIAKqRA6OsSRkaiynrzAOe+YZ3g==
X-Received: by 2002:a50:cc91:0:b0:557:2a10:fd17 with SMTP id q17-20020a50cc91000000b005572a10fd17mr746753edi.45.1704476320132;
        Fri, 05 Jan 2024 09:38:40 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id bt6-20020a0564020a4600b0055510f6527dsm1178197edb.26.2024.01.05.09.38.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 09:38:39 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a28b2e1a13fso205946966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 09:38:39 -0800 (PST)
X-Received: by 2002:a17:906:2257:b0:a27:a7f9:4a86 with SMTP id
 23-20020a170906225700b00a27a7f94a86mr1230919ejr.39.1704476319444; Fri, 05 Jan
 2024 09:38:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104154844.129586-1-pbonzini@redhat.com> <CAHk-=wi-i=YdeKTXOLGwzL+DkP+JTQ=J-oH9fgi2AOSRwmnLXQ@mail.gmail.com>
 <ZZg8kbb3-riiLbrb@google.com>
In-Reply-To: <ZZg8kbb3-riiLbrb@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Jan 2024 09:38:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjc5x_Y=MX35vaoWodpfOU86_gm6BQTGWXgDeFMPneTrQ@mail.gmail.com>
Message-ID: <CAHk-=wjc5x_Y=MX35vaoWodpfOU86_gm6BQTGWXgDeFMPneTrQ@mail.gmail.com>
Subject: Re: [GIT PULL] Final KVM fix for Linux 6.7
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	peterz@infradead.org, paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jan 2024 at 09:29, Sean Christopherson <seanjc@google.com> wrote:
>
> Ha!  That's what I suggested too, clearly Paolo is the weird one :-)

Well, it's technically one fewer operation to do it our way, but
Paolo's version is

 (a) textually one character shorter

 (b) something the compiler can (and likely will) munge anyway, since
boolean operation optimizations are common

 (c) with the 'andn' instruction, the "fewer operations" isn't
necessarily fewer instructions

Of course, we can't currently use 'andn' in kernel code due to it
being much too new and requires BMI1. Plus the memory op version is
the wrong way around (ie the "not" part of the op only works on
register inputs), but _evenbtually_ that might have been an argument.

            Linus

