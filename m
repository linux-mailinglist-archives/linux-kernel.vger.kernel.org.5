Return-Path: <linux-kernel+bounces-19938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 029EA827718
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D851F23980
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E3454BD4;
	Mon,  8 Jan 2024 18:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="FHlvxu/A"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA1354BD6
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 834053F171
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 18:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704737694;
	bh=8rMOKkse4wjMTTtYDomrsUBpyENezfU388gN3eWqcTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=FHlvxu/AA38jcHcBp5lPy7Zui1JgM4uGXbt9+gs4DTJH+ARnWlWxiR9ISfVd7v49d
	 Fe9y107e0GQR0UaeR49NNe3tCHm47FQzOujdYcxOZ6dOU4WfQHTDzXVdcmDuYTbved
	 khEmc/VaPyBlTgJJepD+ovzyCA6vclUOyYrPY6eua7o7fIDT15bNhZbMI1dnv6CZ3D
	 1kSsui4R/OUlR4z8QqMneAe1iQa7JnHIXqji/ImAfIN0Ma4Y1Z7IRrAidzYPBrv+dA
	 Iuh+4P1+XFqS1IU5gScEp7oyMwMLCBJtU6r6dcB9tpjnrMpmYdeUUVens88hUv5Mk4
	 facB/lOH7FTRQ==
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e4c1dd8a3so1591625e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 10:14:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704737694; x=1705342494;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8rMOKkse4wjMTTtYDomrsUBpyENezfU388gN3eWqcTM=;
        b=Vamr3GDrZd2cTjj/r3hFCga+WeViR/jwOMRc3LqdHwWlV/ys6sLxwH9yV1s/3LrWM9
         CH267XAw3PaesdxUugWWWqogiPnqRgp6H04WgUTpUIBjIHmB2Lu8x/USRtjmGTqXZLIm
         BZ0mXaXs8Pu9nUrXcyEXvhit5Vox3RqA1e+/zzbtHZZIdkj1C64yWxqoOEdO1Ws2rCxv
         amZxYS1wbRgm7VlgieuLidaLyAdOQe0/PuKSRd7iFzX701hzpe+rLRzDpmw8vZ3eiyGr
         /VYSZYag5N4IGmEgIjRE+jOEfHmK5zYqHeY8ifopKftETPxja5tM1I/SozETAYySWY7A
         yCgg==
X-Gm-Message-State: AOJu0YzBB1oKOzufxmZrOtFjFPewqLziFD2MAPV5Qtr2iKduzRBxyAU3
	SehbeCPPZEqUAK9V0Cyy875aBuyLUDjUd8vqrbJofhHtoXWwrGVhb2mdXBtf0DKRfHZr1KHYpc0
	/XcInE738CAISzVuwqf9GiGWOKblRcNyD5w2EtbuwNVfGTnPABTJ6ECKNwJDZLcX6
X-Received: by 2002:a7b:c8d7:0:b0:40e:486a:b6b1 with SMTP id f23-20020a7bc8d7000000b0040e486ab6b1mr684938wml.157.1704737694251;
        Mon, 08 Jan 2024 10:14:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFfPDwQ3ezf+hwIJhBtk5iOj7f9MPJha155Qp+We/u7PZr7OCoypYMZZN9M8G/xdU6yaM+HUJM+8HQIICNYJU=
X-Received: by 2002:a7b:c8d7:0:b0:40e:486a:b6b1 with SMTP id
 f23-20020a7bc8d7000000b0040e486ab6b1mr684927wml.157.1704737693828; Mon, 08
 Jan 2024 10:14:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZwk8nFBTIMISLXp@shell.armlinux.org.uk>
In-Reply-To: <ZZwk8nFBTIMISLXp@shell.armlinux.org.uk>
From: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Date: Mon, 8 Jan 2024 18:14:17 +0000
Message-ID: <CADWks+Y7JOsvzWc50syVwOB9LF2Lxc_YiLzLxCkhEv8sBxrNvw@mail.gmail.com>
Subject: Re: [BUG] SHA-3 causes kmod 28 to segfault
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, 8 Jan 2024 at 16:38, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> Hi,
>
> When building 6.7 under Debian Oldstable with kmod 28, the installation
> of modules fails during depmod with a SEGV.
>

What is your kernel configuration, and I hope you make config choices
compatible with your target host OS.

> Running under gdb:
>
> Program received signal SIGSEGV, Segmentation fault.
> __strlen_sse2 () at ../sysdeps/x86_64/multiarch/strlen-vec.S:133
>
> I have no further information as I can't remember how to get the debug
> info for packages under Debian - and even if I could, it's probably a
> bug in the kmod package that Debian will have absolutely no interest in
> fixing (based on previous experience reporting bugs to Debian.)

For latest kernel and latest kernel features support in kmod, latest
kmod is required. I.e. patched with
https://github.com/kmod-project/kmod/commit/510c8b7f7455c6613dd1706e5e41ec7b09cf6703

Or ensure that you use a compatible kernel configuration by for
example using SHA256 for kernel module signing.

SHA3 is added as a future alternative to the currently recommended
SHA2 based hashes, as it seems not great to only have a single family
of hashes supported out of the box that are still deemed to be secure.

-- 
Dimitri

Sent from Ubuntu Pro
https://ubuntu.com/pro

