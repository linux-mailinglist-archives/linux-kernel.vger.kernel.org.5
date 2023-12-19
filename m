Return-Path: <linux-kernel+bounces-5899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC8881913F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48FFA1C23A1C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD1F39AC6;
	Tue, 19 Dec 2023 20:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BINQLL0Z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D256C39AD2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 20:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55372c1338bso2923727a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1703017079; x=1703621879; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2YQISh9f/hMVihywyg7rkbccdS6kJ5BjuKERfau1fMo=;
        b=BINQLL0ZCytOwwUk4TikD+1YZY+GffE85dzn99BGsE1oa0Kd8jEhgC4tRWjwFIOUKA
         GdzqFpj/hmH98FrC96QUk+7VndK/U5NfHAs4+o+DcMc7scfRIt6CLK26CMSaB4H5bPJJ
         9aiZDyWNuRg88OY2uMQmp5FV5dpV0m/z4Hu6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703017079; x=1703621879;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YQISh9f/hMVihywyg7rkbccdS6kJ5BjuKERfau1fMo=;
        b=QVHD0908MVDG51ngnv6pCjOfvYnxUUf7kk6BXf2UK45wsmJUWQYE8i7rgwnKS6vvKk
         H6PJe0FWF6+d/eHSq/1T+7yJxzFarorJrDTvYamapsw4XC7qWV8HLlzLklTG06eblyu0
         pWkMk8NONoV8hRClxd/COcOaWRusV45yDwmsIko7XVDa6ZgsldncXbanc3OTBkMNDsMn
         rjD5Bubtlee42Ze8tgTUrbJI38DlaQ5kknxt179kS38zmhKyVNKrUeMjzunxwOQZnWOE
         apYaFkvMaEoDHXCc8a9Zc5Ni8MNmvkF4YqbkwWUm3NoTBWmD7bIWq1Ftikmac5s/dRt4
         TFdQ==
X-Gm-Message-State: AOJu0YyTLqMiQ+X3Dnp7yFVdXdn2ti6vJebn/CwC+jLvqwfGjaH++5cN
	2bqFZRmqZk2s8eC4F7EZAWEroWXMP8zFSAA7dHsyTpIB
X-Google-Smtp-Source: AGHT+IHbOFS5c91S6SD490UlGgBKYHbDHr7hquam4MKMkK3GCHdtCVzEVQoFQXQb/ZPlhXc+3yZa0w==
X-Received: by 2002:a17:906:4c58:b0:a24:8deb:351e with SMTP id d24-20020a1709064c5800b00a248deb351emr728806ejw.83.1703017079002;
        Tue, 19 Dec 2023 12:17:59 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709065a9200b00a250c28ef83sm987229ejq.75.2023.12.19.12.17.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 12:17:58 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so561256466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:17:58 -0800 (PST)
X-Received: by 2002:a17:906:aed8:b0:a23:7576:3551 with SMTP id
 me24-20020a170906aed800b00a2375763551mr696466ejb.109.1703017078207; Tue, 19
 Dec 2023 12:17:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202312191507.348721d2-oliver.sang@intel.com> <20231219095821.GAZYFpPUSKexZAcl05@fat_crate.local>
 <CAHk-=wimbX8UF6ECo53Hm4Vz0tCC7jjN9e3tEhZfoEtsxyfU-A@mail.gmail.com> <87013f74-5828-4bef-848b-ffedde8e86f5@citrix.com>
In-Reply-To: <87013f74-5828-4bef-848b-ffedde8e86f5@citrix.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Tue, 19 Dec 2023 12:17:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh=z-aXw6o8Hi9SiC5-vwP403-ZpDHUOXdXmLbaG93dvQ@mail.gmail.com>
Message-ID: <CAHk-=wh=z-aXw6o8Hi9SiC5-vwP403-ZpDHUOXdXmLbaG93dvQ@mail.gmail.com>
Subject: Re: [linus:master] [x86/entry] be5341eb0d: WARNING:CPU:#PID:#at_int80_emulation
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Borislav Petkov <bp@alien8.de>, kernel test robot <oliver.sang@intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Dec 2023 at 11:15, Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>
> -asmlinkage long sys_ni_posix_timers(void);
> +asmlinkage long sys_ni_posix_timers(const struct pt_regs *regs);

I don't think it should be asmlinkage. That means "use legacy asm
calling conventions", and for x86-32 that means pass on stack. Which I
don't think these actually are.

I think it's an old artefect, and it doesn't matter for something that
doesn't take any arguments, but when you add an argument it's actively
wrong.

Of course, that argument isn't _used_, so it still doesn't matter, but
if the point is to use the right prototype, I think we should just
make it be

    long sys_ni_posix_timers(const struct pt_regs *regs);

although I think Sami's suggestion is probably nicer.

That said, I still think that just getting rid of this horrid special
case for posix timers is the right thing, and we should just remove
that SYS_NI() alias thing entirely.

          Linus

