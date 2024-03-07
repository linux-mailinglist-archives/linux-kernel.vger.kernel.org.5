Return-Path: <linux-kernel+bounces-95986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0151B8755A8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9ED91F2288C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39766131750;
	Thu,  7 Mar 2024 17:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTa0C0Yx"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2550C12FB2B;
	Thu,  7 Mar 2024 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709834278; cv=none; b=JGGgDWGO7HdO1t2GsPAuUDk6qCmDGzyHit7VntNk0NLquOR3CG0mWV0q9R3jPzkpeeRGKxPDo3WwVpzUK6ZhNhIrqEM/CNmQR48105inj05LU7zjjM7ATSFav32ho7FAfq2HUxgpYGhbUNBjuIeIs+yFlggGoOiPTdd+2Po2Jt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709834278; c=relaxed/simple;
	bh=nuK04bZ5oslOthMQ4lVLof11GO1EGLvX/wxmyW7M/nQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hu2o1amLbcduU4XxsQw4hIbG/20IVq+GWLv9/7k8YL3osZku01HDzDkUKgrru4FpZB7Gr4v4C3QP+rssv8Gna7UZNog+qs2EFF6SpvjcEMd+SnniVyh6UNEA7pKA9upSFnu6YzH5+CerM7jC3LYLQoYkIwCnxsVDHNczWyUN0v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTa0C0Yx; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7883e1e01daso54529585a.3;
        Thu, 07 Mar 2024 09:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709834276; x=1710439076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxRjqNnvdF7ZPp1g7/U1YFRgJVDUpSznFhQFeF1O+XU=;
        b=kTa0C0YxQozUUIZY+1CZGGizLLo8TCVLHYZv8nrcWkwE20rDCeHBtbjU5lOauk6WPa
         ot/7Z3SyTvIsK1XFR0OVGRQx6ywkNs5klen5FvxvUoxEhsY0whW1bDnr/K0JHavzpfsE
         Is/t0wwoIwemMTyCCba19KbJIRmMMS/hGPJShrN5sUnC4FQ6DESOtb4HR0jfOr85nKMR
         7/3wXanS+WsfWTy3aQ2oAuvOiPGK2Xel59lOmiZ1J6Zjsy0lGumRIo8tLPqAC9/XJyt7
         lhKSlEmvvc+TIFeem+aVgYIw+XChrZN02TM9gFs7l814y3CNPb/86y115kSLbp4ZNudN
         6/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709834276; x=1710439076;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sxRjqNnvdF7ZPp1g7/U1YFRgJVDUpSznFhQFeF1O+XU=;
        b=SezbMM8LlOf5dkMSmsWJ0vQb32p+vKaYpQ922QbS6zg2z8bCmcgY6XKwy5hRpWD1JU
         ViByDSmYKMGR9o9ONw4cd7cZCC/acc9XxUkqU7uzk7tlttVaTOVn7Cnbd6qINr7cQn87
         0e1S9bQ19NjDUp03HXrjuKHUjSqBi8VAVIYcvKQC0zowEun20tWT9KCOLjttmB2x5I+B
         89sukBMyNXPmqfROISqdbbbX4JBxKOn3m+CczJE+xV3VqveJiNzPdMSJkEwaN2calk6M
         4qSN2qLTBmKgsT68jWkSAan5k8Ns9tWUgYRsFPbQpXPL122cEYKCaV4kqfw2DBZE/8wq
         BLwg==
X-Forwarded-Encrypted: i=1; AJvYcCWVlHMkI96SOhVf93D05VsB1t3yEcGB0pa2RphXWK/WVGYha+05mKTeFnwIkl1U94MA0J2aHeQvTPZmWfb109Z8W+kKDMWkL4c/x4TFQsDZRd4b/PiV+/ZS54UXHoCkM5soedHv
X-Gm-Message-State: AOJu0YwOz7UrseuCHiwSrV1yaOPZOgSVIzat75PDeTqFIPEyMXInB6r9
	hrRj29KSd4t0svf/VJ1QBuOrzlpWjVLnVoKYuaEzBTOKloC+FXjMysXQhtbOsvk=
X-Google-Smtp-Source: AGHT+IFMyRC8dAbtScVUWoFeeq9w6Lej/+0B1lbzIhd5ZKoDtLsZ65Wgk3qDC1PE1TCtXJMASnvb7Q==
X-Received: by 2002:a05:620a:4ec:b0:788:2e68:be51 with SMTP id b12-20020a05620a04ec00b007882e68be51mr8851072qkh.11.1709834276049;
        Thu, 07 Mar 2024 09:57:56 -0800 (PST)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id bp9-20020a05620a458900b0078812f8a042sm6307036qkb.90.2024.03.07.09.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 09:57:55 -0800 (PST)
Date: Thu, 07 Mar 2024 12:57:55 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Marcelo Tosatti <mtosatti@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Valentin Schneider <vschneid@redhat.com>, 
 Paolo Abeni <pabeni@redhat.com>
Message-ID: <65ea00236e921_106619294ea@willemb.c.googlers.com.notmuch>
In-Reply-To: <Zen126EYArNCxIYz@tpad>
References: <Zen126EYArNCxIYz@tpad>
Subject: Re: [PATCH net-next -v5] net/core/dev.c: enable timestamp static key
 if CPU isolation is configured
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Marcelo Tosatti wrote:
> 
> For systems that use CPU isolation (via nohz_full), creating or destroying
> a socket with SO_TIMESTAMP, SO_TIMESTAMPNS or SO_TIMESTAMPING with flag
> SOF_TIMESTAMPING_RX_SOFTWARE will cause a static key to be enabled/disabled.
> This in turn causes undesired IPIs to isolated CPUs.
> 
> So enable the static key unconditionally, if CPU isolation is enabled,
> thus avoiding the IPIs.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

