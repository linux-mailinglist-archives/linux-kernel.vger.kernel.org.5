Return-Path: <linux-kernel+bounces-140628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAEE8A1701
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED881B25DD2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F69114D458;
	Thu, 11 Apr 2024 14:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eRRdMZiK"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8903822096
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712845145; cv=none; b=BKIuQEBx+ZCEPNkCrYl5Sn3HVun8hTjJqJZlRViuvCgxCjRhTAeZqzUR7/Ig23+dkMVp/oqOLN49svUOJdH0RyqJKRRofja4nOAOg0hWmrTVpEVp6OLALiCKzZeHN+JW97JJSzywKmHKqv0hiSRsClzdSz6sPVWjpC0h60OaomA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712845145; c=relaxed/simple;
	bh=4aoiyNYDW8jeLy6MMhFifIbAcdv4Nq77FeTI1WAUyos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsBAH2dZiDNclt6muPPiMAlJKKbD0eyF7brAnJu3SpRvN4XVvotRdi+8DfIrxT0GPZzFOp+22YSJx/6uQtmhZZz5Z29VsoMpsyNSy82lqLCOGBcrNLVhQ4y/YZc5Ew8ozctKp6p96cfiKr80f0a/Lh4py0MV74fuftY0+osOAJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eRRdMZiK; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3465921600dso1844542f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712845142; x=1713449942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JdF8TbJ6XCUAykiwO7YxwqEyALXdNC9cLChr84shEds=;
        b=eRRdMZiKXptHSQWDB/Ip8FMS7PiIbaYv5aYQBCrcDfyZ7tVtMjPddhMvJ5J42Q2JQT
         0D6CBF//SIInzVAb116AGpCwDAD5/O7IPaoKjLyD10BlTstVrcxmPXoLabEdBo9BTJct
         VVyjAXCfPfdYIck0R8MCx5jOH7TLr1oTDu7NCFiC/2dRbJZl/LazTnbatReyUMDEy8Qb
         C3NciaZKbl0MeeFVn62sNGZejjG/XGb+Hl3HVbImuhGkdcwvFXSqF+KtwKit2vlJ7NTb
         CFxCQPOvXL0pWbIUEOLg/he6kT5ocSxkijhswUu/iSKeu0tmBdYrTO44KCHTutnVkHvy
         W7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712845142; x=1713449942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdF8TbJ6XCUAykiwO7YxwqEyALXdNC9cLChr84shEds=;
        b=SRUpgXzFZu3kN82cUxlVQPx5LldXFXIyF0iS037Pjg4/rvakztfe5Q2mvAS9MYpmcc
         aMuqSlXTAuPqX/DDBIvPt8qr8Uul9NF/CD+SgmORYGBu0uJVF6W3V3BdrPlr+lTy8XW0
         q29exDcZO1kdfpcmJv9uYaZVFGkGGAq7jIFu2fNBO0Fd0uwUOdH9IN5RZnqlL0JJdOAJ
         9Ey+xKLU4VZyImZ9zuekuaANnIbU6LcplFQcvcR4OwCNHDPtPg/2qhrbLXQuXxbA0ixD
         f0T3GVroradOZBKPFUch2H06f3hddYYb+ubANSH7Kl/+Gq92urrfI3iEolaefmhzVUed
         0Oqg==
X-Forwarded-Encrypted: i=1; AJvYcCXNmoZhD2eIrccYjIqAG9UFdRVpFGgFQgoHgCGptcsH3vrg8L6Tmo+FOiUfDQAh5qGjfeuEcOYuKVVSoL1GP1+icAjileQhEuZRfafa
X-Gm-Message-State: AOJu0YzigJvZmrh2nBfOjex2KLv+cTFjcOuHoVDZLBJy9XoeFvnqgdqh
	DjcttvF7YbpaTLlv68MGEuSEjYUSrtUeLtq73d4IVEjiS6EsNQacBO7RbyZKFyqQcZB+FmCbetb
	0
X-Google-Smtp-Source: AGHT+IF/jTpXRL9xKCYdQlJIK38Ox1W4WBQD9HGUGCN/amDLxTD8+OkF6a5zU96byK2KHKiwF0oZ1Q==
X-Received: by 2002:a5d:47a7:0:b0:343:f3d9:a9d5 with SMTP id 7-20020a5d47a7000000b00343f3d9a9d5mr4777239wrb.10.1712845141836;
        Thu, 11 Apr 2024 07:19:01 -0700 (PDT)
Received: from localhost.localdomain ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id w13-20020a5d680d000000b003433bf6651dsm1880039wru.75.2024.04.11.07.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 07:19:01 -0700 (PDT)
Date: Thu, 11 Apr 2024 16:18:59 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Lukas Wunner <lukas@wunner.de>, Arnd Bergmann <arnd@arndb.de>,
	Uros Bizjak <ubizjak@gmail.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH printk v4 19/27] printk: nbcon: Add unsafe flushing on
 panic
Message-ID: <ZhfxU2KmBBpjU-E6@localhost.localdomain>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-20-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402221129.2613843-20-john.ogness@linutronix.de>

On Wed 2024-04-03 00:17:21, John Ogness wrote:
> Add nbcon_atomic_flush_unsafe() to flush all nbcon consoles
> using the write_atomic() callback and allowing unsafe hostile
> takeovers. Call this at the end of panic() as a final attempt
> to flush any pending messages.
> 
> Note that legacy consoles use unsafe methods for flushing
> from the beginning of panic (see bust_spinlocks()). Therefore,
> systems using both legacy and nbcon consoles may still fail to
> see panic messages due to unsafe legacy console usage.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

