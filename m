Return-Path: <linux-kernel+bounces-142825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82BE8A3088
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219B61C2409F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64021127E3A;
	Fri, 12 Apr 2024 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cYNPXzJe"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0D8127E2A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931761; cv=none; b=P/5Yxzf/GwjiIVViib4oYhBCMKY0yInHgTIkffvsjeS3mmbdxUm1i/aQMloPofOiIdLPmhQ0yxRaDg090ppjJTxvvStgFOJyeQpuFvEmJEDMWl9tFKfJge8I9R6570SfR1lzhB5Pv0HNvIllQx8svOwftl9dT35f0Bp+qjgQRhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931761; c=relaxed/simple;
	bh=+IRxEFwc9i6oI9P2rF2fRA5JFBSoqOhGYWv9Q4jR2Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4QmcRLY6ZNmd/ZuD4qETcMg1hwpxwx++ZSy0yDvECAK1C5n2M2r37vf841YcWpfO5yxTExj1XKHXCrnA57BnSZy37SRJMT/HQ8Qfds/WEu+uHHkyvXVy53pL65LLlF1etA3/5E4cT4/v9e+KQgJMa9S27UUuLQVFemLEpwdbFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cYNPXzJe; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d9fe2b37acso10577361fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712931757; x=1713536557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KZjz6ebT5RoHibV4k+w7N5R6e/euEWfeOaFuElHwClw=;
        b=cYNPXzJeSH3AUQL2I8iczpu8hzMGR7/lS+eOewbNYWYieZy4SdtrFpkBXpycy1bnvS
         s/TsFKK/mHEYJWSK3U9nR54WJ5IsgChkSAxQG+dAlevhTe2YFMIDCVk6pYnd9P5ikx9j
         dFpCGry9k43K2Wwz/AG0aNGgduSg62a8YQgde3BWXA/tE0wdxAYG4VrLFT/0akeaNtRh
         3gx/LEAsVuYOK2xy+gg37tLzGBgyyUHLJGy6zOTnhsPh7cmn1hHa4izlxz87OPQHHcXm
         CDaO4/QEm7vMgSqrd2jUdUF8rbEknfDoIXfOnKm/MAumbfcAnWfaQtRDBNGOW3Uz/H5D
         BT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712931757; x=1713536557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZjz6ebT5RoHibV4k+w7N5R6e/euEWfeOaFuElHwClw=;
        b=INpYNB0sWK1qVmu8E56k/4Vmx9ShNk5NR1bAdJfkOvA0PS+K4tthAaqYM89uWQ0oDf
         nEIZEJ9CXkzaOh/fWcGOdxT0OqncadpHPRpqsnQtM0qZXG1Myup0aAYRDXWxcKsS3yOi
         tKudgU0GkeiTbfTczCbWckNHFybwn1fhORdvWsOnI2hogrZ/s19ihpiquTPRYTWoGAOH
         DoYbLYXNW0DWTrZY6XyXQ68Ckol2tmiI297wRY2qVDZZvxG/Mr+HK1AJyTQLkEOlcXfF
         D5gxjw1Cvexm6KkJYDXKVIlZ0vLx/op+vM2PlKVStHkyZ/7tix2NTf8+oVtofK8w+Zx2
         KUXg==
X-Forwarded-Encrypted: i=1; AJvYcCXJa/9DUD0NL7afhEsSDBRJcRNR3Nocj3DSAY3jV4PVNcvhtE3wyKz9tpa8gk1nu4Z1lYRIYJ1/5O4NZ/ChhjSdPT+JOVYAtxLvADbT
X-Gm-Message-State: AOJu0YzjVNIhSnNKSQq+fDceTncCY1iAjVt86KTHthGVXBdnGPhRE7Fm
	4yBT/cWLdi6BUASDnMAkyqw0vr8foUzDLMDNxdKSjHeYdRPAhlfeFIaNDs0/AtA=
X-Google-Smtp-Source: AGHT+IEUU8x1l7wjbdeKsMq+FPv/J7wq2z9f4xVy6YCVoWFTDymS5ycv2fhymEL1ZS92Bi65H1pLsw==
X-Received: by 2002:a2e:8046:0:b0:2d8:8368:e22d with SMTP id p6-20020a2e8046000000b002d88368e22dmr1347399ljg.42.1712931757637;
        Fri, 12 Apr 2024 07:22:37 -0700 (PDT)
Received: from localhost.localdomain ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c4f9200b00417caec4135sm5820623wmq.4.2024.04.12.07.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 07:22:37 -0700 (PDT)
Date: Fri, 12 Apr 2024 16:22:35 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 21/27] printk: Track nbcon consoles
Message-ID: <ZhlDqyYw0JxmfUsr@localhost.localdomain>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-22-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402221129.2613843-22-john.ogness@linutronix.de>

On Wed 2024-04-03 00:17:23, John Ogness wrote:
> Add a global flag @have_nbcon_console to identify if any nbcon
> consoles are registered. This will be used in follow-up commits
> to preserve legacy behavior when no nbcon consoles are registered.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

