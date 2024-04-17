Return-Path: <linux-kernel+bounces-148310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC9E8A80C1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D57501F236E3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AE013D2BA;
	Wed, 17 Apr 2024 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlQOTkLL"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7B913D299;
	Wed, 17 Apr 2024 10:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713349194; cv=none; b=MjTYvX6wGULxzkSX4Ch7WKjGq2do6GRh7ASXxIxyCVCBb4mdsDhW/YPuXROa0jIWKsaa8GWprIsgE0M1TlCulNqZF7azCyS2G8JO6Yuu3RPFceFLhk0eRXLOE5jlGgt5f7SAM2yooeRgLeDz99Xr/QTJ12MK7bUs7dVrw85Jmiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713349194; c=relaxed/simple;
	bh=O9e24V6PiADRPuas4hKybpLpvCD9gH1/TlfDs45hvPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ez8bmR6CLj37btGMAG+3bTIACIBrY4VGdWbc71yDZ3v6E72iRpSkuSET1tmrVam345UYlKQ/DMFBIk2NLd6DC0uf7Lgu/zCrpzFxzDUiTq3zGD0j4/troB+uSmaDsyALTIrEr5NHKW+vP3vkp+3WDbERqfgYhQ8NLmUrisbeaKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlQOTkLL; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ed691fb83eso4440778b3a.1;
        Wed, 17 Apr 2024 03:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713349192; x=1713953992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f5dQLAEVl6XJIGmhvn4StU4aF5gN006BMgNvMVPMtZ8=;
        b=YlQOTkLLXiF4KHKRG0nhCc1gpCjvBrMkyPWaicLnGzC8YDW0HjmadA1aKZByvD7Zw8
         0lbmj9VZwqNdOLVpM7IsUVMQyGMtVNw+4V/9UNg1GqcWqU25QfGHXCRNLqCgQkqGvod2
         zFoSAjSbb4mrKSHqSVYVpCCNam6wT5JtXjwhWhrwg8YhunrbzPnYIHd8dTpbZdqM1KmU
         gT6shGbnmZ0zwLJpLwE//sn4jf+gXCvw0Yl27Xnu1eVKXdBZIkNZkRKZbfoKVqsOxKAr
         YFtGJ1zbwBLpb82q7IheKgnNhWjIJ1px3akmUozgdvV/SYnSWbKLm4+9HvcqzuVeY27Z
         XZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713349192; x=1713953992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5dQLAEVl6XJIGmhvn4StU4aF5gN006BMgNvMVPMtZ8=;
        b=JEwttoWX/NAI+AM8Mp2xjEb1LEpy8RoVCS2hXCJJxOX9ojUVi5WOuJx7F3TMsiHAGb
         DYev4v79tBAhjGGKmmY/pccyWiSSaO+IFUs+N1BzX5AQYQmytvNfjclWMS0MJrb/4MGT
         PqMEevnWURKYR3BIu8SvZW6MFZ4jkgLituBqzaDf3+hyiZmvq8ver3LnvnZ24bysp/P8
         o8p/8PQLdjXWq2kNTPHOX4jYR4KhAcr83wF7coc9Eh6KU/SfpLpL4HW5dCZz1IexQtCP
         lP9ace8Q+4WE84iF2BYXXiiki6j5TiknZYIHRot8sXtVhrtGzLJ//xSvxCDs7N+B3BnU
         Fcxg==
X-Forwarded-Encrypted: i=1; AJvYcCXVL/x2qU8UfIx+qHtUnlnL9eE5/UJFarEfMMjh3moxiktM/EHon2kJykBCZHR+aYHAO/ss1FADgX2P6gVNNeAbG5ByajOTqSCE+RYhmKyNHVynufDCAlJsydcP0bDqXjxxgs+GQZYJZMjY
X-Gm-Message-State: AOJu0YxXsDJ5U/p6lTitiV5iwAIQhxdiqrUk04mS633V/7RzDtXerZ+n
	0607vgQNf/HBibFdpcW+NlSPKaCsLhuXa0Ifl7cXmHFyRQkkqHQ663djtQ==
X-Google-Smtp-Source: AGHT+IGaaZja4PRU1ctflcpS2ogtjcMwFa+oKkRP67URbw+72wWAhM4uMJwv+s5bxIQMO5SGVuCjEA==
X-Received: by 2002:a05:6a00:3913:b0:6ea:8e89:7faf with SMTP id fh19-20020a056a00391300b006ea8e897fafmr17078587pfb.28.1713349192337;
        Wed, 17 Apr 2024 03:19:52 -0700 (PDT)
Received: from libra05 ([143.248.188.128])
        by smtp.gmail.com with ESMTPSA id y7-20020a62b507000000b006ed00ea504asm10309282pfe.159.2024.04.17.03.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 03:19:52 -0700 (PDT)
Date: Wed, 17 Apr 2024 19:19:48 +0900
From: Yewon Choi <woni9911@gmail.com>
To: "Starke, Daniel" <daniel.starke@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	"Dae R. Jeong" <threeearcat@gmail.com>,
	syzbot+6e3e8f30f269f5028e5d@syzkaller.appspotmail.com
Subject: Re: tty: n_gsm: race condition in gsmld_ioctl
Message-ID: <Zh+iROsYkqoRsJQj@libra05>
References: <Zh5Zj35zeobGGzKj@libra05>
 <69b4cd22-3a02-4d5c-a110-152b8ba8200b@kernel.org>
 <DB9PR10MB5881D2170678C169FB42A423E0082@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR10MB5881D2170678C169FB42A423E0082@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>

On Tue, Apr 16, 2024 at 12:26:30PM +0000, Starke, Daniel wrote:
> > We think either (1) gsm_dlci_alloc() should hold a lock(mutex) and do 
> > internal check about whether gsm->dlci[addr] is NUll or not, OR
> > (2) all callers of gsm_dlci_alloc() should hold gsm->mutex and check 
> > whether gsm->dlci[addr] is NUll or not (like gsmtty_install()).
> > 
> > Could you check this? If it makes sense, we will write a patch 
> > following one of the suggestions.
> 
> We are currently dealing with multiple race conditions in the n_gsm. Not
> only for the syzkaller reports but in recent exploits for example, too.
> I believe we need an overall concept/solution for these.
> 
> Currently, the following actors can race:
> - ioctl (e.g. resetting the mux or one of its DLCIs)
> - ldisc callbacks (e.g. receiving SABM or DISC in gsm_queue())
> - tty callbacks (e.g. gsmtty_hangup())
> - internal write task (gsmld_write_task())
> - internal timers (e.g. gsm_control_keep_alive())
> - driver removal
> 
> Each with another and ioctl's from multiple threads.
> 
> Guarding these is not trivial for the following reasons:
> - execution context may not allow sleep (timers, write task, tty callbacks?)
> - creating an atomic section may conflict inner sleeps (e.g. ioctl)
> - dead-locking needs to be considered
> - locking may introduce high performance bottlenecks
> 
> Still, not guarding one of the racing actors does not appears to be
> possible as I see it.
> 
> Unfortunately, for the same reason the sleep while atomic issue when using
> a console on a virtual tty has not been fixed yet, I have no solution at
> hand. We are dealing with a quite complex situation here.
> 
> Nevertheless, creating many small patches here and there should not be our
> solution for obvious reasons. This does not give a complete solution and
> makes it harder to find the remaining corner cases.
> 
> I can assist to find a solution here, but I have not enough time to do this
> alone at the moment.
> 

Thank you for your comprehensive explanation.

As you described, there are many concurrency issues entangled each other and 
fixing single one will be rather confusing.
I hope this mail is supportive on solving the problems.

Sincerely,
Yewon Choi

> Best regards,
> Daniel Starke

