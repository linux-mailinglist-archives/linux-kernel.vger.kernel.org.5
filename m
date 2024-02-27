Return-Path: <linux-kernel+bounces-84158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D82A86A338
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B371D1C24392
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5229F55E48;
	Tue, 27 Feb 2024 23:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5qzDTP2"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3660354673;
	Tue, 27 Feb 2024 23:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075034; cv=none; b=XnGh3/prKji7FFYgKwQUhxXav6rHJhPFdDu14gfOZUyH2Ukvl3xKwZyCMI8nULCOpLhDGjqEbIIW3qfw4kHQfiMu4birhMjxsL3fZ4j6vPqg08W/EoaenggMFHNP+z8ViWBB3Kd39lUfTYatBIlSPbeZ0msVmUfg/Fa7daNGgCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075034; c=relaxed/simple;
	bh=RS9cpFSeTTXbKFeGO6nCVsKpFRKp+oQHaPY0gzPdSrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIANPqw2iNUusUM/xhRSIxMLWmZAwTBaj4573pvIOJ4UQf24zNrhpphJH9dSN0OprtVDizMACP9rsMHyKRz8PWAimtm2oIuJvWiS8jvCQE0FTXFtcy2qsW+x6PSigs3aU+dn/yqm2fyynMvPTs2X9TkhlbkYpwEZxOby9Iu62ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5qzDTP2; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e4ca46ab04so3053622b3a.3;
        Tue, 27 Feb 2024 15:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709075032; x=1709679832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LqroY/eSaYOruRUIz4FV37kZQGVpkhWqQp6wqfnEjoE=;
        b=Y5qzDTP26ceQgbHeNVnPgnxCLaUEbVMEBFEkTxVejjXZmFsEv8yTefnAH0dt9T3HOR
         GCbVSaPg+bYeaIvVhnYwp4SdzIVbls3Rex7tjME9/Kbw8K5PN6jyrAyJVdNPQRuwqE6X
         4doWfZaw47s73pkii+aD44jnmnlwcgh/cgEgBhKSirBdnLJboOQyXf9qYCYcXjQBd4e1
         JBEZ9kfKepG2iVn3MjD91B2m+14XPYHnxSAZuZj5q2M3IcX0ij2DVjR3cM8zvVttIRup
         Whke5RJoF5Om3Nkx0A7HiGGsEhwLtNjXlwP+5+basNPSXr0N/PYXVyTeO/dCKzB7vxhW
         kXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709075032; x=1709679832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqroY/eSaYOruRUIz4FV37kZQGVpkhWqQp6wqfnEjoE=;
        b=UP9fAzb6afGuw+QVYpGiX00j9VNFY94O3uGdBEb4W7Rl+CwHCzE8eLslArUUozc/Nw
         E2XjDNRnvtZi4LpadS2VOLY5V05i53Z1ikugPYEedJMUlaQVYTBw+7g3o6plxpI8pTp9
         aqUuTDay0nOLX87Myk2TZGpLmcRT3uJ6tgHJHopGL0hsmBIDhOXHyAxB5EWmnWX8XvXD
         oiVGTi3nrxSXMl0A80hVxVDCVBN6RG4hbCWMjWdBKrOxuiGcg1y3gqebKJI0skevBLpz
         SJAZwMdQ+TQrQo/6VlqcX3ZT1jxbMXODdha2N7TP4vEI1RnUc7kQ6rr6Lx+dudkO/QLq
         W5PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgi8qmcO/dW+EbzLNTmVhoPbBujcitRruLvnvsWO4FhGomuhAFNvqhoOpvLihoa450I4vgscVTb1ntmkqcX4nmtKXD7gR1C3l0i5E5lp1Y/SIwoUWiF6px5imlg7GgTNOLbR4CnyWxgOGKHWYA
X-Gm-Message-State: AOJu0YxXj9xcxXxLSTxr5xIcD46Psv/VGZ4TAjFPR41Jj+/V6SQ6iwsA
	ApT0nm9FHAOfwcVDT+XnDLwDIpowGFtW2aSXAHVu/Y7ldzMeMDcK
X-Google-Smtp-Source: AGHT+IGlLK84S8MWrY9t+1+YVpKU0bZ/ZJHxh+rMM6qbHdXCwosrhRXHlTYLGtwOYTWXmV7iXbYjpg==
X-Received: by 2002:a05:6a00:4403:b0:6e5:265:fd31 with SMTP id br3-20020a056a00440300b006e50265fd31mr13271740pfb.7.1709075032276;
        Tue, 27 Feb 2024 15:03:52 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e5-20020a056a0000c500b006e530aca55asm4041625pfj.123.2024.02.27.15.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 15:03:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 27 Feb 2024 15:03:50 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Kees Cook <keescook@chromium.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lib: stackinit: Adjust target string to 8 bytes for m68k
Message-ID: <a4bf4063-194f-4740-9c1d-88f9ab38b778@roeck-us.net>
References: <20240227224653.work.603-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227224653.work.603-kees@kernel.org>

On Tue, Feb 27, 2024 at 02:46:56PM -0800, Kees Cook wrote:
> For reasons I cannot understand, m68k moves the start of the stack frame
> for consecutive calls to the same function if the function's test
> variable is larger than 8 bytes. This was only happening for the char
> array test (obviously), so adjust the length of the string for m68k
> only. I want the array size to be longer than "unsigned long" for every
> given architecture, so the other remain unchanged.
> 
> Additionally adjust the error message to be a bit more clear about
> what's happened, and move the KUNIT check outside of the consecutive
> calls to minimize what happens between them.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/lkml/a0d10d50-2720-4ecd-a2c6-c2c5e5aeee65@roeck-us.net/
> Signed-off-by: Kees Cook <keescook@chromium.org>

Hmm, guess I misunderstood the other e-mail. 

Anyway, it works. After re-enabling the m68k tests:

Tested-by: Guenter Roeck <linux@roeck-us.net>

I'll also run it through qemu for other architectures to be sure that there
is no negative impact.

Thanks,
Guenter

