Return-Path: <linux-kernel+bounces-72830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C5885B916
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8EC1C20928
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DBB6519D;
	Tue, 20 Feb 2024 10:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R/+BE1ct"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE49612C3
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 10:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708425001; cv=none; b=oM2n5arqeeJLr1mDzQSuT/nmauuaLQr1OOoVM1S9zOMpUJECD90aXaDK9rhukSJqFgJVZ7qTLPY9MkxqAaiBDzRUOGozU65Z/McHJldKYyvv3ggtFA/69p9RVKfNBDJCBthDKBUDGYZcYGEqA5eHcw1j2j9cM8MMmncMitcYPpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708425001; c=relaxed/simple;
	bh=GXd9EC7FB+BbzyucFz1V1+w8UBsYjM9QEIlgi5iWqZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCwd6tbtDZ+PEbBCUJoB4KcHaTsxADLDvvJz9uuYenineQMGk9gHQspZHxwJBwKZ2OuS4PCggAIrxfAMhoTAIHBjVLhEgufqnucr4MfrUUr3gr7gapfZNH87HFMzXNPrNsPF5WC6e5f69+xLbbZpSlhi8d0f0bcDmUIB0xdMUss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R/+BE1ct; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3566c0309fso614418866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1708424996; x=1709029796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tiai/zRgk7WwVMG5JaArPLkB9dxopLgSV6PmKDTepQQ=;
        b=R/+BE1ctxZjYJ0S/k9SguXqucyO4lNHWoReN0gtnhTxk09UvA2l0L4DTPAaGd//EaY
         slB7yYau88VBVB+KA0tZ5bLvNtJT6k0a+MUYRhvTaaJsHwkOmWaNC6qHvbCcSjaI0nCa
         qchKb6kLrAjwiZHtF4KDgLfUWo7HahsqydOr12J7C12wF6IFBZlom1nxDd0wr2Sh1MnN
         sfwtZdoLv5i7x74yreiTvxZj9a8USTe5IgyI3koxNK7rE2hE6W5rp+iuKkCLVYHP/vQh
         y0PcRs1FnmBgrlVxP6+QpF7W9etUdrnPzIf7Xupr7ZWEVgTGNQYrOMp/7I5FyQdWOKta
         VbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708424996; x=1709029796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tiai/zRgk7WwVMG5JaArPLkB9dxopLgSV6PmKDTepQQ=;
        b=PX4jMJIixl+74mMTnRAhaJKnGoCg6iFn886H9qYmE27hiW+NFXZ4g+yXbAdNHV1bBp
         5ANl6mTkfX6/qjlHck5UP6zSYgmY/mai8Hw687uQcq6bprJasA6igdcTABsMjtiWE+yk
         gFI9JOgo8fcV/MvC6vBEmtsnuCmgEB9xjxBZhM59hQb6iNEo4yCXLQnEnqMVzw4qUZBZ
         icOinsEK2mod6tUQTKot2tFk3ViJfKVf5Ggi8Cw3H71kY3L28pwW6yTvyUerhG3P7YGd
         2Pm5yqHMzB6kf/lRAKDdHgf2I+5eNtZh/UaGyzSQ7ErBSY6PwLfaqEQtqWLVdbdenD7l
         nlhA==
X-Forwarded-Encrypted: i=1; AJvYcCVQsJGyoaxC8rtOzHkDoTkV22Z1gazozME8zJ3aNDptXdrkzGJwC7bekAASYwbd2nCxIenVWCPId1iEvkBvwA9Ke6oOjSTH/wfdQRPF
X-Gm-Message-State: AOJu0YzixEh7LWwBj/D63MEP6vIk1De2kqIpEDemPJoMuTjEJFlL66O2
	52gyY1r6MQY79dhxY3chT0k6n7JakG0n28Gk0EI1ZLurP9nWn2OGCDAkkwPottA=
X-Google-Smtp-Source: AGHT+IFou+qPItEOHBx+itptCz/bztk/A7e/Rf130E9Aherg/CO8m+VaSvce3VXK9Gil5XekG0mJEQ==
X-Received: by 2002:a17:906:51b:b0:a3e:e0b7:90d0 with SMTP id j27-20020a170906051b00b00a3ee0b790d0mr1643209eja.41.1708424996658;
        Tue, 20 Feb 2024 02:29:56 -0800 (PST)
Received: from alley (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id s8-20020a170906168800b00a3e7a2d9ac4sm2314584ejd.6.2024.02.20.02.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 02:29:56 -0800 (PST)
Date: Tue, 20 Feb 2024 11:29:55 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH printk v2 05/26] printk: Add notation to console_srcu
 locking
Message-ID: <ZdR_Iwc9VgQntGqx@alley>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-6-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218185726.1994771-6-john.ogness@linutronix.de>

On Sun 2024-02-18 20:03:05, John Ogness wrote:
> kernel/printk/printk.c:284:5: sparse: sparse: context imbalance in
> 'console_srcu_read_lock' - wrong count at exit
> include/linux/srcu.h:301:9: sparse: sparse: context imbalance in
> 'console_srcu_read_unlock' - unexpected unlock
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 6c4afa79147e ("printk: Prepare for SRCU console list protection")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

