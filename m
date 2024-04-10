Return-Path: <linux-kernel+bounces-138559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94F989F392
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 446D5B252B5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D92715D5CE;
	Wed, 10 Apr 2024 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fW4mbz1e"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6C615B54E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754387; cv=none; b=B/4NUFxRoHgxoobzkaCWKusM8zR9Nux4KEKYOUOHUQbDAVVihrTNPylfgHmH2GDToG3Px3XtwqWF6LeaOUJuPkf6xXA+8mT7kEEg7bXk+bbIw+dmzZ1i/zfsbcFgCdGYpNFS2ysFeudUNSgPwgcy7GLftdsBWVgBBZyXYzWktMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754387; c=relaxed/simple;
	bh=hOwpvQla7asma1yn+lUp8NUECXNmemIO2Gbo0NVpx+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhmKtOMxRhdNbCm0wKGSFWf9x7ogPvAfAPydxmqYyah7tKm43ni22v5uhA/svVwvjnKZ4pA7Va+H2YamRHfuPTsJZAIHiA31Yn0h9S79Wm41YNCet+Do6EBThZrIQkLN7somKmkcPSuIKucEIyLGCqxTleZpvVuER7n+2HABBYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fW4mbz1e; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d87450361fso58768511fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712754384; x=1713359184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b3F26X8KjuosBmiP6LxnCx7dNTrwfYeDh4qGzxMKBto=;
        b=fW4mbz1ey32xt45OmE0zSh34vom3oTjUr+H8vs195yem0IzhkO/5+C8/i1g3jLMl4X
         paffC6iydu8fFmYRN89KL9qi6rKAiD1kehCOUnv9TCgGt9l+LOLP8dVnLBEY+CZyQckR
         l/r+KD2wMxPq6/MN41yz+IS18Q+JH0dWqJU6PIlnPXKXHhX/XV5FoFY8tdysce/xnVjb
         FYX4cly/kaDPWzrxUg7jgVnBB+Fr9+4YxyUAWZZ1xr9mKzenEqVN+VChmXmpGfvAy/fP
         f/KJo7hUFSnX83aEH/9YpMC1sbgXrw+DZ8DOLR/FctU9JEAlUvCIDtWAGs6sV699QYpL
         I0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712754384; x=1713359184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3F26X8KjuosBmiP6LxnCx7dNTrwfYeDh4qGzxMKBto=;
        b=Xo72reQU68bkMJ1C6t7a+WZMiDwQduSTEK4g3zHhU5hWdike0QhQMkxyR2TPF/PCAe
         EVdqfSQpVO1RvrBE5kbH5kKgkc/IXcBPcywiXGHzNdOVQMssp99/XQUWzNK9zy74Iq0Y
         JGP446KCjy4on6uWGUkRrYiynPmqRS/ipcV9Fy/yuosoGSOdg3123r6BG0M19oIQ9amp
         TLTEyQ9Yu7KUgN2QF9+sdmFyJBiaV2tOo9uTUi7EuxG0qU/qluvBIxClZ1cD7zKCpORR
         CRTl4D8zGRGr3QasqFc6TQRSOwYP+vXHF/+MAN2EttG74ZmhbVd9YfRvamrIlIi4NOVb
         76VA==
X-Forwarded-Encrypted: i=1; AJvYcCVu55X/MGakJNBVkIZa/OAZm6zl5RGRWuM5qlASSmVJevPPzYOt86zu1yeAGXRq8GfG5dBNEWuh+JRInDYn6O54SGj4K0I/qWtSi5K3
X-Gm-Message-State: AOJu0Ywkf53mVNpXpJNZj+MUkOpxqrYNzC0Oj08mnFbbtkNEi42AGxZL
	f1XM3MNcLQttaXs3vHg8ZDNUYPEKyvvkkGlAF+olyeFN6dWcdcLbmnQOTwFdLeeh0aCMH6iuyXN
	B
X-Google-Smtp-Source: AGHT+IECNTinesnpMbCpWxYz68kYBcmpk87IabL89YQLuMvPsMVXs1UQ6BeIm/wSQ4uZEq/cbjA77A==
X-Received: by 2002:a2e:a58a:0:b0:2d8:a82c:9e1e with SMTP id m10-20020a2ea58a000000b002d8a82c9e1emr2679657ljp.15.1712754383665;
        Wed, 10 Apr 2024 06:06:23 -0700 (PDT)
Received: from localhost.localdomain ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id c8-20020adfe748000000b00343a0e2375esm13688183wrn.27.2024.04.10.06.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:06:23 -0700 (PDT)
Date: Wed, 10 Apr 2024 15:06:21 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH printk v4 10/27] printk: nbcon: Do not rely on proxy
 headers
Message-ID: <ZhaOzfXYdeur2Mid@localhost.localdomain>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-11-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402221129.2613843-11-john.ogness@linutronix.de>

On Wed 2024-04-03 00:17:12, John Ogness wrote:
> The headers kernel.h, serial_core.h, and console.h allow for the
> definitions of many types and functions from other headers.
> Rather than relying on these as proxy headers, explicitly
> include all headers providing needed definitions. Also sort the
> list alphabetically to be able to easily detect duplicates.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Looks good. Well, I haven't really checked the list of includes one by
one, so I only provide:

Acked-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

