Return-Path: <linux-kernel+bounces-145259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E6E8A5188
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBED11F2420B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93723130E4E;
	Mon, 15 Apr 2024 13:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MwMoSGj1"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6348130E44
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 13:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187362; cv=none; b=jolLHWRVxCOpBrgYLluUs5PlhUcKnn0gXwFO4yyQGstz3YKfX2rAzddMA+508y5204AfhbT/v4nxpran9IOhJw+ZLsK6VKikwUskaGQRUK7raomF9KFXLAf/eSa6FpJftC7D1Hexbx6/t5Ib9MjEZpqJ2FslrxvSAg57mH6JrN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187362; c=relaxed/simple;
	bh=SiAD+lNn5qt1AfifpMOTrh9BBWpeB1mhfNZqSx4YEm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sa6wFnRkRoOnUiAJeqoQbyeUuDy/0/61Ko9l6VHCbX9xeEg1tgL2lvEY+6acmJunI7vsWexitI3GDKdkg6Zz4wH0qqkx4khZ6bExk9C+lFWvd+rXxzxi6Jd0hJlhWglRxFOGHI7oRHkqiEKd4n8mM5QqfbSL9wyoti9kwkC2UKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MwMoSGj1; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3454fbdd88aso2909145f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1713187359; x=1713792159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qxmfrKsb6A/bEXzrV4nCTqSszBxTGkGAoaWGV5tnXz8=;
        b=MwMoSGj1puMpfzh8G9npyXz8N7xtZqDcOQz172LOVfunfkU+fbeQ5F+l2axf2xS0ik
         suiek8RieBUAbaS7ElzazfYTUVBxXKjjBjFyl589cl1y8pK1765nrKN4Q7B3yyK8+ooP
         qns/25vVhuMjAhNzdu7hd2usUnozMgCkYOizvg0E1Mv9Zws8LmnLvv7s0zReMFKN3n5j
         BJHRo1lyAF8rlT4r40ARIwc1CzzEio2dDmpEo2FN0+iKmyi3RlrOdo+mY+rVH/h0Cnqj
         ejMjBLakqkoMIdwk+tdffjtVUxRQ7v4oCDs9cCrlxe0Tdqmd/61AomfqJvNo9h9Danrg
         qwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713187359; x=1713792159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxmfrKsb6A/bEXzrV4nCTqSszBxTGkGAoaWGV5tnXz8=;
        b=LICAGZk5K3pNik/DIHXCwPgKJRDN9v7ZrWRponx7OeRaB4RT9LQcDICzfx2E4MauFD
         EwiIoS/jKvQnFLWP9L4zsubpACkReo9AfkUDul9ZQj3Ron21AtOlu5vUtA8uUB8149tp
         AsCDCZKArts85QHVvzgjAptDGKJBZy+NJngyJEjJqJq6VIQOiVpR5BufTOjHMpXTCXnb
         4p0/E3yHvBGpVG1LTZFz3xIzV1LD9yEe4wWhbyeYgC/JbRvMJUJqV4Npv+pzvGeTMIC5
         7wG55mErHYZVLYMTsx7dq4+vX9ZelcrR4pPSjR8KOhJoR3iw/1gx9/UaBcaBVmzxouqa
         p4nA==
X-Forwarded-Encrypted: i=1; AJvYcCX562ijwnWXMrLX/7Gn822HFRSxonumSJ4PCzgQSyHBMJc/iUeOnfydAAoYtFjfuR4ePJhdcmC9XOahuWMA+3vPM7o/CaGv5mQPKZZY
X-Gm-Message-State: AOJu0YzOHFKkOnHgC46knGIb24lbFezt+eaOkJif0dpzuLf0aED6QKni
	110FiwF6N/iA1SjnuenWan5iXfvy7GpNuES8n85VKi3qyiwjRVAmjuV+vvtNPa8=
X-Google-Smtp-Source: AGHT+IHIqqATY/SO8Itg7WLpsZbZ02wVvfmIcTq0xshbt1npyxbYXlPkhDaXIjND1c7dBYf1hLksrg==
X-Received: by 2002:a05:6000:1849:b0:341:c58e:7b47 with SMTP id c9-20020a056000184900b00341c58e7b47mr9381877wri.63.1713187358967;
        Mon, 15 Apr 2024 06:22:38 -0700 (PDT)
Received: from localhost.localdomain ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id q3-20020adfab03000000b00346c231231asm11838357wrc.86.2024.04.15.06.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 06:22:38 -0700 (PDT)
Date: Mon, 15 Apr 2024 15:22:37 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH printk v4 25/27] panic: Mark emergency section in oops
Message-ID: <Zh0qHXS7NPcAR6Qi@localhost.localdomain>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-26-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402221129.2613843-26-john.ogness@linutronix.de>

On Wed 2024-04-03 00:17:27, John Ogness wrote:
> Mark an emergency section beginning with oops_enter() until the
> end of oops_exit(). In this section, the CPU will not perform
> console output for the printk() calls. Instead, a flushing of the
> console output is triggered when exiting the emergency section.
> 
> The very end of oops_exit() performs a kmsg_dump(). This is not
> included in the emergency section because it is another
> flushing mechanism that should occur after the consoles have
> been triggered to flush.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Let's try it:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

