Return-Path: <linux-kernel+bounces-22910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D8882A53F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 01:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1481F23B46
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 00:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC98A48;
	Thu, 11 Jan 2024 00:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Bk8jsCWS"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A53839C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 00:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e741123acso5346439e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 16:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704933197; x=1705537997; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ecki/5hmhCZ1pJBgLNzGL9kIecS6fNHUeL7VAgIOt7A=;
        b=Bk8jsCWS00+g1h8IQnFBzc2hy0GzlCs8SwyTYIwroZlRNlOvzsfSOOgTVFSn0GTCga
         Kv51ZO7luZxGiphpjF9kjLQfjXU3uXEsRRmRnt2qwo0XyVpiAjFqMxYjTAYDJZCJMeK4
         y+z2/xNVkbSGJpgkvXfd6S8C+3QLX6M4YJV8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704933197; x=1705537997;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ecki/5hmhCZ1pJBgLNzGL9kIecS6fNHUeL7VAgIOt7A=;
        b=iNQgdW35T2CGQWBsTELx8wcznEJbrQKO8qLs7XYj/My7YW2KEX6rHWk/FB11fLwi0Z
         ifoM/ZBIysVG5qNnhLjxx2LA7JaM5Ba1yb69/pX4ZVaTnDLYgquhzmuTsJetCJXt7vNg
         Xv19F1EkE6C9MENw4cVzGn7+C79rPhwkfm4Om8FJwljinpbUZjMhT9H4intuTRuYhO2P
         pY3fta4TWQ/P5YQYpjJufjsb4Wgph20kzxAqvjevRO1Epvegbd/rU1emt9X1DhjK8bZM
         zFPv42IrNgl1G6LgLbLqrDPmF64LMoRvx4Omk2VBh7pAI5MDMUriQkx9+9Fok0A9ukkD
         HIhQ==
X-Gm-Message-State: AOJu0Yx4VMVeLx7c+ohPoQE7+yXvt1hITxm0W7XOMdPUVenEmkX4z2bH
	QAMYHv7kV3Y+/PfVaO5C58GPYbEnj+FOSPgHlY0AaFW4HnIT4FL/
X-Google-Smtp-Source: AGHT+IF8kBsBMnxEoD+G0viIfry6mrHQvykjb1HFqYQOwin0zDNR1BD8Al0Z6B6KtiHGvKbP7Sh0qA==
X-Received: by 2002:a19:4f58:0:b0:50e:bd97:5ccd with SMTP id a24-20020a194f58000000b0050ebd975ccdmr108200lfk.19.1704933196942;
        Wed, 10 Jan 2024 16:33:16 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id r10-20020a1709060d4a00b00a2a13835f4csm2564989ejh.167.2024.01.10.16.33.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 16:33:15 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a26f73732c5so558712266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 16:33:14 -0800 (PST)
X-Received: by 2002:a17:907:1c9b:b0:a28:d5dd:574f with SMTP id
 nb27-20020a1709071c9b00b00a28d5dd574fmr218565ejc.31.1704933194074; Wed, 10
 Jan 2024 16:33:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025140205.3586473-1-mszeredi@redhat.com> <20231025140205.3586473-6-mszeredi@redhat.com>
 <75b87a85-7d2c-4078-91e3-024ea36cfb42@roeck-us.net>
In-Reply-To: <75b87a85-7d2c-4078-91e3-024ea36cfb42@roeck-us.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Jan 2024 16:32:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjdW-4s6Kpa4izJ2D=yPdCje6Ta=eQxxQG6e2SkP42vnw@mail.gmail.com>
Message-ID: <CAHk-=wjdW-4s6Kpa4izJ2D=yPdCje6Ta=eQxxQG6e2SkP42vnw@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] add listmount(2) syscall
To: Guenter Roeck <linux@roeck-us.net>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-man@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>, 
	Amir Goldstein <amir73il@gmail.com>, Matthew House <mattlloydhouse@gmail.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jan 2024 at 14:23, Guenter Roeck <linux@roeck-us.net> wrote:
>
> with this patch in the tree, all sh4 builds fail with ICE.
>
> during RTL pass: final
> In file included from fs/namespace.c:11:
> fs/namespace.c: In function '__se_sys_listmount':
> include/linux/syscalls.h:258:9: internal compiler error: in change_address_1, at emit-rtl.c:2275

We do have those very ugly SYSCALL_DEFINEx() macros, but I'm not
seeing _anything_ that would be odd about the listmount case.

And the "__se_sys" thing in particular is just a fairly trivial wrapper.

It does use that asmlinkage_protect() thing, and it is unquestionably
horrendously ugly (staring too long at <linux/syscalls.h> has been
known to cause madness and despair), but we do that for *every* single
system call and I don't see why the new listmount entry would be
different.

           Linus

