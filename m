Return-Path: <linux-kernel+bounces-136391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6471889D38F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6501F1C211F6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AE97D09F;
	Tue,  9 Apr 2024 07:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAakulLb"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4431776413
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712649057; cv=none; b=f8UVN1YDi1yMAtrH1RxeimNQEy4h9soiNUBCXes8gcIW8fLyp8rxfYVgx/ASb/jvv2+Tu8mgrHTWMHEkIfnNlB8tzm7ePKmAmMmrgoZAciUNa92ZYomxVfm2XVDk+p+vWuYtjagvpbxQyVOd+TPsaDIqGWpdYeE29H/FHYcsaaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712649057; c=relaxed/simple;
	bh=SUKDxAYAJBa11f3M1+5hnx2P0oh7iQ0wsn7fgE+vfYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbVY0YaXVOtMiUeT0oI+N+VsmoF7cjw8QlhPB6UbM1uoZttE1drcqIk38yfm9duI1fkbGKsREDN82a1lvilWKmB9D5JtbVsOalVe1pVyxxUIFntZuey58zoHJo5nqwfsjvsdJH6Gf3TkoL5UT49zrOPIfJRZRqIYeJBm1b3DawE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAakulLb; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-516d536f6f2so3959022e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 00:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712649053; x=1713253853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AUvzM2nxPKrNgeHRp422Nux7KuBAmKnjbO+D+coYVUU=;
        b=UAakulLbM9p/HfNI5urKvifjG/3OxeiO90MHu2UT2MwalBC/NgMaFJcm+vgbqvN3ju
         sGmkfEg+760EYaNH2SZfU2NDZxOJrXy5om7NH0icy7Oj0+R2Dy97nS533G95faLbG4KO
         TL3Pfwh+NQshJLkVdQOBNCCoK1MwTeZy0BlR+VLiFeYWJrzMpQUrcXk8kxp/DhQrcT9R
         v9aZDQcVQCkbjbOW+S2OAEfKHaMHX4FBut2qJqdr5uY1TqGnBtb+VSuVpjcRni+9PqIZ
         OvQ5xc7oDZP6RYtC74Vo3vWs8fTWFmefYCLrykihTQCqK+OlJhi8ja+8w4fQbjIcyWyz
         Oxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712649053; x=1713253853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUvzM2nxPKrNgeHRp422Nux7KuBAmKnjbO+D+coYVUU=;
        b=laPPPHZaBRkMrSzssTWwkLasMkaVoX8x4Tex1H8oVPkHKlrqy/W0CVcV/2JD3xgQBx
         3UiqmBRw7bszVKI5ErfZPjY2eQpPSMR43026FkajNEwBeqwpfpOHK0k0VwerDYBx2UVv
         KQaVCNE8HPEFdXivc0MGVy6Qv8oVPqclNA+JoMh2JYjLKTImEWQt0wukbOAd9O4GWPHr
         EWJWyg8fjTpeG3nJ4NDEXKZJlvvwHdOTazL1reyMAneLoSJqQ/Xys5Og6EfYWdS7948Y
         RBskCaRgLL1bEyWOpnG7lnUkmh3lWC9yef50CdK7bO/6CMM0t2qSY8wMiY3aolBpFU6D
         /rjw==
X-Forwarded-Encrypted: i=1; AJvYcCVr8ZHGKrMlr+wfFtAd6toCUrsmLpL1ezmNxesi062Zk16aJbu6sriATHkTxzI+h0yjhIZ+KHYaOZZGgyA8ERJUg1M9otNPPwnB6r+I
X-Gm-Message-State: AOJu0YwBWliaI7aGX1GgBBazbQ8F+XQWpeLWRfP4MOwO/nybdGfAllcQ
	gXxVkhv/rEiu8Smj+W/wlKML0aGN95GpaFI8LnaJPADwk4r/h0gC
X-Google-Smtp-Source: AGHT+IH7qjigu/p6Ficb8+sbf5h9YDXEhVAT8DcEErnQYNevfODXvLyF1KZZGbnhKHJYM9xLaA1aoQ==
X-Received: by 2002:a19:7718:0:b0:516:cca7:7e3c with SMTP id s24-20020a197718000000b00516cca77e3cmr7399831lfc.50.1712649052881;
        Tue, 09 Apr 2024 00:50:52 -0700 (PDT)
Received: from gmail.com (1F2EF1A5.nat.pool.telekom.hu. [31.46.241.165])
        by smtp.gmail.com with ESMTPSA id 12-20020a0564021f4c00b0056e62c8e3bcsm1993054edz.54.2024.04.09.00.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 00:50:52 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 9 Apr 2024 09:50:50 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/3] locking/atomic/x86: Introduce arch_try_cmpxchg64()
 for !CONFIG_X86_CMPXCHG64
Message-ID: <ZhTzWryKahctH4yZ@gmail.com>
References: <20240408091547.90111-1-ubizjak@gmail.com>
 <20240408091547.90111-4-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408091547.90111-4-ubizjak@gmail.com>


* Uros Bizjak <ubizjak@gmail.com> wrote:

> Commit:
> 
>   6d12c8d308e68 ("percpu: Wire up cmpxchg128")
> 
> improved emulated cmpxchg8b_emu() library function to return
> success/failure in a ZF flag.
> 
> Define arch_try_cmpxchg64() for !CONFIG_X86_CMPXCHG64 targets
> to override the generic archy_try_cmpxchg() with an optimized
> target specific implementation that handles ZF flag.
> 
> The assembly code at the call sites improves from:
> 
>    bf56d:	e8 fc ff ff ff       	call   cmpxchg8b_emu
>    bf572:	8b 74 24 28          	mov    0x28(%esp),%esi
>    bf576:	89 c3                	mov    %eax,%ebx
>    bf578:	89 d1                	mov    %edx,%ecx
>    bf57a:	8b 7c 24 2c          	mov    0x2c(%esp),%edi
>    bf57e:	89 f0                	mov    %esi,%eax
>    bf580:	89 fa                	mov    %edi,%edx
>    bf582:	31 d8                	xor    %ebx,%eax
>    bf584:	31 ca                	xor    %ecx,%edx
>    bf586:	09 d0                	or     %edx,%eax
>    bf588:	0f 84 e3 01 00 00    	je     bf771 <...>
> 
> to:
> 
>    bf572:	e8 fc ff ff ff       	call   cmpxchg8b_emu
>    bf577:	0f 84 b6 01 00 00    	je     bf733 <...>
> 
> No functional changes intended.

Side note: while there's no hard-written rule for it, I tend to use the 'no 
functional changes intended' line for pure identity transformations - which 
this one isn't, as it changes code generation materially.

So I removed that line - the explanation of the patch is clear enough IMO.

Thanks,

	Ingo

