Return-Path: <linux-kernel+bounces-136821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2936F89D8A6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D82FB286610
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FA912A160;
	Tue,  9 Apr 2024 12:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dFAqjXez"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB8E12BE93
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 12:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664023; cv=none; b=u/TXvxc8+Ks6qFjH4NCxwSge2cDJ9/WoKu/7q7OieRHew+BKveFBKhRN5whTsBz3Ihky5vrJ7uQhg7deSwqaG4i9emVqSbA0fEsdSGuLEzwMhGqJrXidA2Gq/KI/DWK2JHtmUH8O2gAwXZ8c/yqBShRJ1VIq4jvtljbUxMiwxCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664023; c=relaxed/simple;
	bh=9ioVAtBS6mJHjzjQVsH+ySnnVVovVrs0CN+nbCwKczk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=taEzisMcpHoDBc0k06xRL8iidM8xEvTqfPyufVIBWNVO2QWr0AiTWABaAW3OmRd3S5wJ86uDsKLVfbewDmTc1ancM+qnWS67uDtpygMFuUxdd9sxXq5/57SW8ecpvEGp6M3rl0+FQ6IaqNZOECQQX9xZqfFXbklz48Uz6QrqgK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dFAqjXez; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-416923f05faso9115425e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 05:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712664019; x=1713268819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hTJa7iV3b9gjm+sfpsG6XF4RYgkUlLa38F2U++9H9m8=;
        b=dFAqjXez/znzIg4htXhpbZeZK3oPS1HDhk8CHgZaZ2hWAWU9YwNiTnxqaTynxweGng
         FOL8J6FTdzBZB2lqzNDMWAFpH3oWPDs6bL9mdlwcvodGAgT/qAmK+Y0yq/IZ23aHPHvN
         Owm2Yq8UUW2eBlqekpAfWq9jhUd/S+7oYboUw69DRDSRROoOJy/M0bi0yxraIoR0Cno+
         ncWinxZOSKur4lL74CqTHmB+gxekJkfMYoVqpJYsiPKMuRIkc4P+sTQv3ubsXOJfC7bl
         X+wMExVh8N5IA/w5VJ93a3iufPY4A4peS5yp4a5P9XopKRwOEMuLnB4Bvr+C+07wE0Ub
         eDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712664019; x=1713268819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTJa7iV3b9gjm+sfpsG6XF4RYgkUlLa38F2U++9H9m8=;
        b=EcsV+pQZacoXbSytimBrAluSJZKW4hPMYMxJcDMIieze0fLKXu4bZACkXif7KnnCEY
         7b4WdXFKEAM7p8jLqpiCWae5+Y3jtYMDCFXKATuvcasBrD5AMRrdJO4cX2Xjtkzq5FFs
         tCjsuyWnXqsitx/qJiykrfPt0iuWg95h7bmOZUwE7i67EApqPPxYicmjsUaafsRrBRPE
         PvyFUKS09rECImdlKGfUqqwfe9x0TF6HWisfUp4If8E57oPm+voVyUpO2nLHCtH8QQ5L
         JcThs+PMUEQmkk+ze0fmt4A5SsLCwg4GAYoa5v3ldjKP5ZbFsgoglJsjL6S6Jse5a/8S
         qTCg==
X-Forwarded-Encrypted: i=1; AJvYcCUxoZVpAbArmMKChiirLPsmB556KhXkOi57W9q0xssvRjxEvTGLXjcMoL6v5d2NP8g7vEKuRQXNMQf0HA5rjPERBJT/jYc5ZNrCTyc1
X-Gm-Message-State: AOJu0YxfNFNYjmrXdz1fWg1WfHSDpgxehKZxH+3HMJv/q6O+9bT6TiMs
	ndrrDLql7KAv24FZK+hLaH5lPz6wdB5yBeyFG0NPa+B2ACA7n+U522ACGZPn3/A=
X-Google-Smtp-Source: AGHT+IEenJ5fVLWDCUgpbL2lvv7/84Jdct4K06qEzDgMrmjzy9n0KwhGkQ1sssD/6NtntOrANaus4w==
X-Received: by 2002:a05:600c:1395:b0:414:245:f6df with SMTP id u21-20020a05600c139500b004140245f6dfmr9065198wmf.21.1712664019450;
        Tue, 09 Apr 2024 05:00:19 -0700 (PDT)
Received: from localhost.localdomain ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05600c3d8800b00416b92dceaesm434506wmb.11.2024.04.09.05.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 05:00:19 -0700 (PDT)
Date: Tue, 9 Apr 2024 14:00:17 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v4 08/27] serial: core: Provide low-level
 functions to lock port
Message-ID: <ZhUt0ZX5aWZ6G8nf@localhost.localdomain>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-9-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402221129.2613843-9-john.ogness@linutronix.de>

On Wed 2024-04-03 00:17:10, John Ogness wrote:
> It will be necessary at times for the uart nbcon console
> drivers to acquire the port lock directly (without the
> additional nbcon functionality of the port lock wrappers).
> These are special cases such as the implementation of the
> device_lock()/device_unlock() callbacks or for internal
> port lock wrapper synchronization.
> 
> Provide low-level variants __uart_port_lock_irqsave() and
> __uart_port_unlock_irqrestore() for this purpose.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

