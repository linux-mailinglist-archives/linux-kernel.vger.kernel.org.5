Return-Path: <linux-kernel+bounces-85288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C50586B382
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DAF51C211F5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE09215CD6A;
	Wed, 28 Feb 2024 15:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="bioa0AJG"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C87F15B988
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709135013; cv=none; b=WCHV4ISxSU3xZa32TUXS9K8QDdFFla3LHNy0wGiQ5AZun0oM4w6R8n1hn8dAf1X8g9Oht+lPWw8k7nT2OwEx/0Tu2xW1oDW8ljU2AOM6pBWVUJ3FxR0Xg0PXqLIRcXUuu3rvZeOT6Q2zR9XFTeOH9hGsNHVoB1lEfTqXemB+uwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709135013; c=relaxed/simple;
	bh=yvohejmN6XM3X6H8sG6UQlBEcYoW/hyrUsMHzhgBzWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zm81+QTC8vqghvuatOWV9+B6OCChEj8heIfPPe7p7GZnGN4F1Qny+zucuO1HIRtT+iZjcuO0pDVRzRv8qlPxU+pkGVk+AS6ppHEwCu5k4uIkD7R4arxDyRsGX+vHU430Obm0qDWCPhNqLqWWX2xsqinuHzG4gIxaHiM8jUnqmYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=bioa0AJG; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512bde3d197so5263968e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 07:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709135007; x=1709739807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yvohejmN6XM3X6H8sG6UQlBEcYoW/hyrUsMHzhgBzWQ=;
        b=bioa0AJGjH0cAZyx2Hcpem9yR4KPxcLq+ISbM1pxYE79T0CWzICViAn5u2jaRh5lAM
         DajhPFeV4R1yOa28WW6E7qgyxL7N3r17GIonS8mYiYiFwNcW3I6ORJHaFNQ266CrkA8k
         AlJFhlAFcOPXCZZLdUd/2jJX/4nb9ZPPKfp8f21IVbQGntROOgZCafZhTc0bvuaHaloL
         EEPNhcBFHP+Iq9oNHorup0cVK8K5YupsegzVeDXBV3mlPKcqekfIWaC/YVl+q6PeoeH3
         dAR5iY6+sCtWq853lezyVYod4xkIJUzLEiPpXhIv/Vxcqm8uRoFFbpd/SVdqp+lrPA/D
         8OPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709135007; x=1709739807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvohejmN6XM3X6H8sG6UQlBEcYoW/hyrUsMHzhgBzWQ=;
        b=n8v3RUE82akItZxAg19Wj0wMjw65y56c36C3I5CtiIU80fU8RBXtpmOlZJ4NHlLTB9
         z4TLcCFUNdIMN3LTFIguYOclGZbJRAsL8GSpecd6OwDxh4+I+GKFcg3MAg348hBep9RT
         AamET+mhSWcLWPHisl43TKet/CydH63rzCbPnDcQlrmYi1JftJHgwVAMVxcPVZ+fItA/
         oYICdezujjQZugLdVV/81kKojqMT1DZZRmlLgjGjTTPLfaj3CAGk3u8vbmkrqS4zgnjJ
         MaDNH3TfgsbRpajUoGE1Rgcl8rDUosFU/EP+tw7X7DJWpfASRcGRdmddQ9ceoHlUkhG4
         wq2g==
X-Forwarded-Encrypted: i=1; AJvYcCXGL0ftzzJbiNAvQJ4UdE0nK0XmZ4ppfqcHeDNuYotkk+lR6a3IznEzxJUzZCZ74v7rHJ8XTrVzvhmPR+KzfmbQ7Z3KzWw9JBRXmiPL
X-Gm-Message-State: AOJu0YynHCQEevqqjYPF0KurnOoJj1NurZbnOQ0Z8TfMNEsnWZ4hHwrj
	krFJ/v8eNloLJ2DXz3inn5/SdwFODU0RTOr7ZcyCU9WLBn2JifxxWr8OlnYv6b4=
X-Google-Smtp-Source: AGHT+IHlyFN4PQiCKyj3XpTBh4GMnAKVvTIaow+duOgknVcTt+1tsIlTRgTt5SmzLwpzBhh2ogpG/Q==
X-Received: by 2002:a19:5214:0:b0:512:e4f4:b562 with SMTP id m20-20020a195214000000b00512e4f4b562mr56550lfb.31.1709135007261;
        Wed, 28 Feb 2024 07:43:27 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id n6-20020a05600c4f8600b0041273fc463csm2500472wmq.17.2024.02.28.07.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 07:43:26 -0800 (PST)
Date: Wed, 28 Feb 2024 16:43:23 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] Simplify net_dbg_ratelimited() dummy
Message-ID: <Zd9Um1LHjQ6NXVlP@nanopsycho>
References: <5d75ce122b5cbfe62b018a7719960e34cfcbb1f2.1709128975.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d75ce122b5cbfe62b018a7719960e34cfcbb1f2.1709128975.git.geert+renesas@glider.be>

Wed, Feb 28, 2024 at 03:05:29PM CET, geert+renesas@glider.be wrote:
>There is no need to wrap calls to the no_printk() helper inside an
>always-false check, as no_printk() already does that internally.
>
>Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

