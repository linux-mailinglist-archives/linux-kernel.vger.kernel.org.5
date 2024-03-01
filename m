Return-Path: <linux-kernel+bounces-88614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C7C86E427
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70BBC1C22CDF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA6970ADF;
	Fri,  1 Mar 2024 15:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DL3VrTm1"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCF46BFDE
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 15:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709306308; cv=none; b=kcYOtHSN5Ke7UtnxlVFnXUFLOIumAa+/a2Bi7nvB6+njnCP+6oMpZDNQj0Mn8EWSIBPFOPXAELxbcKzA4v396KYeUxlqQHa6lEpv7aB8sQnT1kWjL8KRsaO+glb2eizNk99H7UXm68sKuutG/PSUDQEa7uxwCTUuXgTSi5eMpUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709306308; c=relaxed/simple;
	bh=beAmNvfR879nx/BDX0OEsLcWJ25vfKK/Tq/Cb7bWRYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8VGorCq4sPs918hPj0UBgVouqmJ1tUjHMMpnC7aGTLK/UmvadqUwojjFes70igKk6e9kScn5bVtL/9E5lfWCsHReNzeAvwVgCzHpiKx0cBLztYEvvu6s1Mr7AecqBX06HksKpyoJrK9hOyc/W6iHj2Ie33upfTQ6OE7uPssQSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DL3VrTm1; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a293f2280c7so429697066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 07:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709306305; x=1709911105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aos9MqXsF1xOY2jZMEtY/lcIeAPnqSm3ELtqtU4n2jQ=;
        b=DL3VrTm1O/jb5Rw9dgxVS0bJKjw98/jWX9Dww6PCYkBVY9oMG+M6aCrqPo4rLmb+6+
         Kvotge3G5INXwl5uG3QIw1aDvrkeKozOuFcciwuiAovK7POQ9sGdYnxeeLobSP/qcVNA
         VcSP9qM1UNH0jjVNhEFz7ws2IwsMLsaUMu+eTyhoV9s6jLMuPCk/2Zyu2xL3sGxmOTKy
         f1TcsYbVJAoZat3MqSV17tM5DV/FBgJzCINf6dZE+ehbvOKCdYVU5dZsGGosOSPLagAw
         qikJkPq3l1UyuzGOhAA1mT4m70AX3cdp1F+osj6z2wP+39gNo81zPHljpIcpwyelvTCR
         /X/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709306305; x=1709911105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aos9MqXsF1xOY2jZMEtY/lcIeAPnqSm3ELtqtU4n2jQ=;
        b=OHUb7oIbNiMm++4WJqstq6HKLHjTPtmakdurXurTHYjwJM9Ob14+XV3hI7f1dS04F/
         luuHoFS1uesRq+YnkqVeL6uEdA3mJix9piibZgHXqHb5dkGwSl3bAM++laWqEjOSnFfC
         wZMReczNxHVF7OIIMP0m+FoUems2asajsdxhttSZtb4DrSOcHmHTQh445neBxPhdVXs8
         c+/u1gzx7q0G4JhL3auiPTAqy6PfUJqhDqRXY1yCKrN+tTAV5lD/LeyV5Eg7XEIVNacU
         xc6sOx/ACM5qLDl8SouysGjwM8W3EcFROtCFbYSFte/B/FaXajC2zUr42oEs4OZT7FPv
         9CWw==
X-Forwarded-Encrypted: i=1; AJvYcCXeuiwk1mDQNWjNSmLdJQAL8FUNWPkHV7ehFNi79VU6rffxmzZ7P3ACr+I9qJzQSeefFnLqBncTnOPai1+rKZ8l/gRTFVdWll4+2/Zg
X-Gm-Message-State: AOJu0Yyxe+ruaneZgHF6Ov2rUE99FPrWAdCwoCo1XdElVi8r/c+OEdqz
	/dRIHsm/qCVkKHsDy8OAWAegqvHwLGwMqXP8Kf7qX0lA6LN/hIhUY6sjw/R+BMM=
X-Google-Smtp-Source: AGHT+IF5CguTytJh67cp9oC8R3rw4kdjmEM51Pfall6sFe8sSNqkIniachACb1r5c5idTKCMPG1aXA==
X-Received: by 2002:a17:906:4107:b0:a44:378:d3b0 with SMTP id j7-20020a170906410700b00a440378d3b0mr1647858ejk.41.1709306305164;
        Fri, 01 Mar 2024 07:18:25 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id n9-20020a170906688900b00a44b975170csm148256ejr.190.2024.03.01.07.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 07:18:24 -0800 (PST)
Date: Fri, 1 Mar 2024 16:18:23 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH printk v2 26/26] lockdep: Mark emergency section in
 lockdep splats
Message-ID: <ZeHxv4QW_N4XomjM@alley>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-27-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218185726.1994771-27-john.ogness@linutronix.de>

On Sun 2024-02-18 20:03:26, John Ogness wrote:
> Mark an emergency section within print_usage_bug(), where
> lockdep bugs are printed. In this section, the CPU will not
> perform console output for the printk() calls. Instead, a
> flushing of the console output is triggered when exiting
> the emergency section.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

The patch looks fine from my POV. Well, I expect that you will send
another version addressing Waiman's concerns.

Best Regards,
Petr

