Return-Path: <linux-kernel+bounces-52466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD9584988C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD261F21F8E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9466718B14;
	Mon,  5 Feb 2024 11:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8Yqak/C"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5EA18C3A;
	Mon,  5 Feb 2024 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707131496; cv=none; b=qZlEruHnevnHRFXEQomzJuf1/wm+xEHknlFNIHEktjulvaTPPX1dUFP8eHWg/zf9ctaZwun2XELHMsbG2E8tyl9T3fuDbM0+gIeoyNCdVyVU54/PI4gYQgTvTOwY21DP5JskOw8K7LF4PSmJPg+K32E3tfddBHI/+UxOmtPrFtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707131496; c=relaxed/simple;
	bh=48ce7/5oNmdgj/pm/z0gfq3CLVKSsiCn61ZHEcIkDgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOvQEMQUiRjQNpHRnAh6vjw2bMWGe7NkKcAa6jDYCDfgSX17o/0trc5Fv1dhf0Z+BQqCZoJ7NIVxUi4CS3sJanAWdNgUS2UbtBib/e0OsEl5iwlD+bXmM98BbtMIPc0pnsCvj+I9Lyoo1s/bIewgrrI82pLHCG4AzeKf2V8jCQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8Yqak/C; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33b35323341so971869f8f.3;
        Mon, 05 Feb 2024 03:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707131493; x=1707736293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q89gRwpKdLFgd3RL1o1XYTcKQtxZQ/8oMcTWr624ImU=;
        b=D8Yqak/CaXtGvzrIWLa3q5QnkMn8rg4hdIgmoGYbajd/y+nIPHitfMz1qD9dFU1vbR
         yR6YMDlU+Wu6cKt6G+lth65g5ANoQXaOJ2zOd1kzkn3YjbFwkchWG4VVzWwRqdyQx9CO
         k1I2xgYzMPEdWgTj1ZDO8caoMcoWbcN0t5GisNZYr0449yEL9xm7/2ttzKVifDrg5Xwy
         k5U0k40b0DvX+fsN8WrYnblt0rY5jOKYq/LNIA6sFX0zlN6GC3yMwfMhb3cV/NN8BaWU
         ecuHRBuQIuRht8UFB+CpkhlhcR70QKvLGiXuciRzO86NbhPwuOR+Kokh5I98crhCPu49
         J/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707131493; x=1707736293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q89gRwpKdLFgd3RL1o1XYTcKQtxZQ/8oMcTWr624ImU=;
        b=j8ita9FNXgbV4Y4gty5bPXTX2S3oNr5MJP1LLRa0h/hH210rCjrthGLSYkbiHAH9Qd
         MRaSUeMWlUtAskkLRuBhYAndLTvylxPBXp+sGxLU6sndSgFp5vECrgYcP1E9HBnUk6od
         SM2qZrDSuoXsIhzwvtIqSL8rfW2Rp7MWxfijY+wrWSWJUtZ56nXrrdQaKNpsbC3qnc9L
         l8sAxKaw6uKLLrjKtU02ps/jnndGiXjG0DijIqCSp3evi1BruZZ+EfIaRbbaqlBj327a
         OqVbCLrTvMLxOniQOKAB+xwGr2QYaW4kiIQn6ThbLif2FcoPkuZtrtT7SqGYXUnoLIZI
         HnQQ==
X-Gm-Message-State: AOJu0YwfmawbdfNlFSTtXlK7YbaQT/KPQ6spF3N/lAt/NzkaaVECeZHc
	yzQ6WNY7Px56dGBx2jNlm+EXHbl0vpW/98m0ijzmVhqiMxXr7OIc
X-Google-Smtp-Source: AGHT+IErg86qD66LdfLj6qkRhwS8ZHZghTbwyG6fT6VTDfzyXDofvL0sVbdu7bQfXTizA6DTwb7XLw==
X-Received: by 2002:adf:e950:0:b0:33b:3648:d25a with SMTP id m16-20020adfe950000000b0033b3648d25amr2523768wrn.53.1707131493265;
        Mon, 05 Feb 2024 03:11:33 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWWuTV0TtsAO9e/4elu0yeTjfJWJNZgP1aXWHhVIQVQP49gBVZ8Mj1QgWwj0i1Fn6cxVIH2Mc0sU1zGG0/M0MK50YeDFGmY9nkhYUXwzB0NxNhshzuBh1QP48CzNbQM+URi6jrxmbVeQE5S9yAhqIoMBkwZCne/HkegIg==
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id h17-20020a056000001100b0033b2157fd7bsm7271303wrx.53.2024.02.05.03.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 03:11:33 -0800 (PST)
Date: Mon, 5 Feb 2024 13:11:31 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: andy.shevchenko@gmail.com
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Minjie Du <duminjie@vivo.com>
Subject: Re: [PATCH v2 1/2] spi: fsl-dspi: Preserve error code returned by
 dmaengine_slave_config()
Message-ID: <20240205111131.sk46mukva6ewmqlk@skbuf>
References: <20240204203127.1186621-1-andy.shevchenko@gmail.com>
 <20240204203127.1186621-2-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204203127.1186621-2-andy.shevchenko@gmail.com>

On Sun, Feb 04, 2024 at 10:29:18PM +0200, andy.shevchenko@gmail.com wrote:
> dmaengine_slave_config() may return different error codes based on
> the circumstances. Preserve it instead of shadowing to -EINVAL.
> 
> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

