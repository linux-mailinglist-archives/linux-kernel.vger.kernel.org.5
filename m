Return-Path: <linux-kernel+bounces-14608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0014821F8F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 890F7283E07
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C38B15495;
	Tue,  2 Jan 2024 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="OjvbQM1D"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AC614F87
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28c179bf45cso6491079a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 08:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704213056; x=1704817856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KkUQDV4v54E95UdJBzXyZy84b0c1XJbZTZp7leh2wE=;
        b=OjvbQM1D0wXRHBQzv6zp6qECA29sLpOKGnJ/+ZnyoMaqvVzPL1hvi3LMUdADKR0lhz
         DNwbkqDSR9dxRvxC/uLFKkUdJlew223ANNBB2mKyJJwFNHhkkUQJ9nvZ+tggZGsYwjry
         JiBComD0iLvk/IghZUZ/QcRL6s62rDSeZu83vec7SS23699CKJWcx9+61xts+/zB+u1p
         gjkkgxNmj7j0WA1JAfP5tJ+SwvxP1h9FXenHcDWDOG7NGVUNzyklti+WMRS6KJ/5mt77
         K+qh572pSwmYh3yCbpIJfD1imAVCC+Nt9WEqs32kavcUqd8aVnaypI1dbBGQ1N/illZu
         4Qjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704213056; x=1704817856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KkUQDV4v54E95UdJBzXyZy84b0c1XJbZTZp7leh2wE=;
        b=EAVdT9gu7wWwOvHl1yMkV/QGTAteQabv4in+j9v/82aaKi5R9piGTiLYLmgNgQ2t0D
         rM9O/5dkrc1ZrZz6MicLWOI2X0HPNYwatCJW+E/Ws20Sygrt6bVLoAj5ZvJcGwQie9R8
         bgHfDV49bJbUy2oERyt3yknX7zPElXBjcxjUWkop8g6DYmTRh+zi1Nbp5bQSGcUCn1tL
         sykVfeHkkPdQXT3UJI1XVcXSnp1kh05b1F8TRBmb2OjMhVPkiYAyVne8PlBfBBDOmIVL
         tpo9WgJHVZ/GwQvhvdzy3n6iM5CAZYhSW1tNyCH7MxvpaAJCvolAjXvFSypSBK1uSYHK
         ZJYQ==
X-Gm-Message-State: AOJu0YyMIt1IZIn6ZaEc+0tajkOnk6xyj17ED3QsoovkKIL4ie/2qN0Y
	BWw+vLEJ7adO2ov/cud13P0MDgQK5jjprQ==
X-Google-Smtp-Source: AGHT+IF3r26omkcxVtQHwd2LEZ1N2oumCWEltJUNfhV1+PjxwJfGcY3aGiQQqi4c9WHNalHUZ3ehZA==
X-Received: by 2002:a17:90a:d3d0:b0:28b:12f5:eb59 with SMTP id d16-20020a17090ad3d000b0028b12f5eb59mr8626353pjw.44.1704213056012;
        Tue, 02 Jan 2024 08:30:56 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id nc13-20020a17090b37cd00b0028098225450sm27288207pjb.1.2024.01.02.08.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 08:30:55 -0800 (PST)
Date: Tue, 2 Jan 2024 08:30:51 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] packet: Improve exception handling in fanout_add()
Message-ID: <20240102083051.26f3aa80@hermes.local>
In-Reply-To: <828bb442-29d0-4bb8-b90d-f200bdd4faf6@web.de>
References: <828bb442-29d0-4bb8-b90d-f200bdd4faf6@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 Dec 2023 16:39:02 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 31 Dec 2023 16:30:51 +0100
> 
> The kfree() function was called in some cases by the fanout_add() function
> even if the passed variable contained a null pointer.
> This issue was detected by using the Coccinelle software.
> 
> Thus use another label.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---

Since you are seem to not listen to feedback from others,
I hope this patch is just ignored.

