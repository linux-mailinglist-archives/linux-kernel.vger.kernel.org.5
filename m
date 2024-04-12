Return-Path: <linux-kernel+bounces-142854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8D58A30E8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBCFC2829D9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D161422D4;
	Fri, 12 Apr 2024 14:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K0Ors/iX"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6806F1420BC
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712932788; cv=none; b=R1zQKeoDY4txC2Jm7LkJUcyCxdhBNtL8KLpGjcNCGNvJorgqJloABa6/y2H9TifP33kLAket/Vsmf/wvKZkEpfthV95jYBgBsgzW3MJu1+L4XQYs4iL+yVBMOBiJV559XUqgA3PgdgJd7xKIHUT7uXjVSau+PN383kgCbS/msVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712932788; c=relaxed/simple;
	bh=uSW3gmM6s3gm6HjTZdqo9XxJ0FE2Z90G8rB5ljcYnhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLxDujxK3iYwHxI4DHhEYsyaQOsoAjlqq+yaEcVzutNDVRnLKHUrdGRCLs8c+tuWp66THbJoRQljcBiyzwKZmzT8EHBJEr9Af5mWHUkWPO9lo4qrUTRX/9bgI2SXrZ/Dq7zMXdd40m4p/BjSx4zNH6viGau5gg2YP4YUXN1JlsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=K0Ors/iX; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41650ee55ffso6999065e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712932785; x=1713537585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ePwNGum3rU9WF/wdJXVESYJ3V8VOaeIXd86GkRlv3Qs=;
        b=K0Ors/iXA51Wkba4O/4kSTfZm++saO2qMDinFZfIGjz4viWZTR48Ubv9SA7GJ2bKku
         ndqQLgb+5rJkR7SFEg9CMGOENl1LGY1KsKsfvK49H9cou5jIxHUOv6Rx/XUT7x6syZPA
         UTcvhuWtC90vyTTXHk6Wekamupr072RXNqt/R8zwQHqm0+jlLXx0YJUPsnRQcshaA8tc
         f3zE2knIeMRKz7yXL/v3KXtWLzMacliGk+wHq6WQAKdfI6L8uXgJyVDDACHOHq+fjaHM
         nIoTzl01SuIHSYoRO5Jf/4JYKKbz9N3XLj3++ai5EaPSsTORLxv3Q7tgMlE85RN3fTsn
         SUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712932785; x=1713537585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePwNGum3rU9WF/wdJXVESYJ3V8VOaeIXd86GkRlv3Qs=;
        b=av1qn80JY+LwZKoJdoE6idHwzol4CqIgniGsSinJBmYCE8KGqa3nX3YJQ1PInwsGT1
         zTP1feZxVokH4ry3zxyYfBZKY7SfaHusRTicX3hFVB5kdM2ptOwyOfHopAT7CEz/LXes
         dCd/ZyGuH4ebTYfbJpQnAJQ38Vct5ExOFcNtOn2TTmmiI2SVjzj/TwotYvqN9Slky2pK
         PLSSf4QpMJlZra0O2sK9kwg+ucOLxoS7RgollH0Ltf0Uf/3UEf2xUfXs/rvF28SrHZPW
         toNZTbDG4Gt2/FVN7isYfai8iEhtbet+eMWIHeikWQFIxhQzxaCQ5H/c+v70y3/ABODU
         47MQ==
X-Forwarded-Encrypted: i=1; AJvYcCViGzBHKr6+lMIwsumvCQiUWvLcYmxnUaQwHR/wWVjGLJYI+QtZkDEecxe7cN/xKERpwUiwR/SR9wZbvtH600yahK4qFtK6Eb4ZptTr
X-Gm-Message-State: AOJu0YzrHxHup1YilL6Z8YVVMo6rNY3pnl+07r8QkHL1bsdcgzF/KzaC
	GiO5ZqiJS6yXODh2FuTHKhjxpC+1buDdzTW+z4WA7gup+88qPCD2zJS53RM6Mdk=
X-Google-Smtp-Source: AGHT+IEch6uOEfL5UmZEsPCqefo5a+rpMYn4SrDRiK8FTZ3NCPmE7yeYv0sExBM7NPXPwOhR3NX5cA==
X-Received: by 2002:a05:600c:5493:b0:416:6e42:ecc5 with SMTP id iv19-20020a05600c549300b004166e42ecc5mr2081986wmb.40.1712932784757;
        Fri, 12 Apr 2024 07:39:44 -0700 (PDT)
Received: from localhost.localdomain ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id j24-20020a05600c1c1800b0041643c9cb0dsm9147087wms.42.2024.04.12.07.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 07:39:44 -0700 (PDT)
Date: Fri, 12 Apr 2024 16:39:42 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Lukas Wunner <lukas@wunner.de>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Uros Bizjak <ubizjak@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH printk v4 22/27] printk: Coordinate direct printing in
 panic
Message-ID: <ZhlHrorXffMdJfkZ@localhost.localdomain>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-23-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402221129.2613843-23-john.ogness@linutronix.de>

On Wed 2024-04-03 00:17:24, John Ogness wrote:
> Perform printing by nbcon consoles on the panic CPU from the
> printk() caller context in order to get panic messages printed
> as soon as possible.
> 
> If legacy and nbcon consoles are registered, the legacy consoles
> will no longer perform direct printing on the panic CPU until
> after the backtrace has been stored. This will give the safe
> nbcon consoles a chance to print the panic messages before
> allowing the unsafe legacy consoles to print.
> 
> If no nbcon consoles are registered, there is no change in
> behavior (i.e. legacy consoles will always attempt to print
> from the printk() caller context).
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

