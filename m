Return-Path: <linux-kernel+bounces-86892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AD386CC57
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9AA01F21518
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37811384A8;
	Thu, 29 Feb 2024 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KsB3fYdG"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59536137758
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219203; cv=none; b=Iphm/XMAr68Yo5rQX/Xs7b849IrNnYcVDw5sqRtGk+/fFH8XKDoOkXN6cniU2whLvB/kZVVEbIo15mua68vWdYKudHre42ZAE0JJO4tahfHR7B1HiITv5lVpG0bf1CKBrW4mnt2nMt9IQ9C/MjTqq9hWHykP13mB3fxHtpfkmW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219203; c=relaxed/simple;
	bh=PQ/k0j/+e1mnfwmxiUbzUWJRrlV0ylYhakUhgNYyuQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oFyp1VLsV1Hs+QvvvB1wNwwLJ861Qo3Nuk0VtwLcSM35v7E0f7YKBF/Q5W66LZRfL4Obj8Y8rXM20pI88DA3bU/kcBJZBFh6jPdn1kHnPzqAHkcYuL3NKkpnlkdHAxTC8RCb6rdyvQB8B7BFk8Gzn4gFJ9rOKzzCVntsAYc29s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KsB3fYdG; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so977821276.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 07:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709219201; x=1709824001; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=26MU8kHY9/G5Vo/Dcv5Tts/6jAZMZIquioYpJYzi0xE=;
        b=KsB3fYdGhLGct4kjtdL0Q713IKX2Aa3fWKkRV1Cugx3CStkNQnyhtXWvrxEu2zM1PB
         CmyHRZjvPIwkbbWqODjHxitkWyI2i5teoFgr+5Cw0hEnik93Zp7oFuKFgiyzca7mMp9i
         4gyrWSQRqQd7vkFP2+1eV/6fsyE+Qbr4euV6ZhcwI8w578yQGpC+xgRMTL0c/fU5fEYH
         ydnSBuWlEqz+XLZjv/tWYWjopwXn9PLU1/bs7EZrF7TBbjKMzRZ6ucgjImr5r+ltgMao
         ypFc+AW/e2HLgfQkMN0FyyymgkyTnlEXAesawPoerSHazj0Y4WOcW6+T7+t/RlBYJXu9
         U3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709219201; x=1709824001;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=26MU8kHY9/G5Vo/Dcv5Tts/6jAZMZIquioYpJYzi0xE=;
        b=XwS9SzMXKVUni3lRf1G6rX7k0+ueDh1VObg9XpHPVJNBwK/QealYdIqw5K69JkxdIl
         Rl8fmUzlFb7eMhIEk2Jb+tZDAKKPr4sWpb9H7zlMgiEuxwSTiXxDg1EQHl4FW33WjAPf
         gYwm6AihpvP++TuQ51keL3cmF0cLwKSc/31ndu8eYFuQ21kYMy84evfgsxgyUXI5PBdF
         nr/SvjgsdgYWgSYGLsApmr0kbiNW02PIraR9m8GyAjfQC8IuNneamRQbQsbIVYnmQTMZ
         bVtKygOqlu5MQv0jCB7ez+qLVuaEnax9xJPpuHv9eYIqniCHyZ/mv4KowupjVHQy42r4
         B72w==
X-Forwarded-Encrypted: i=1; AJvYcCUnLh5mU2rS+MHrrUZuX3blXJJ/tPPU2BBkNYpYCXlXBErgqjJT+r2CHbgZ6KlQdb1YRPG4igs+wbNqPpHaCrhASynLXz7YLJL3VSLD
X-Gm-Message-State: AOJu0YyfnBloPDTiRYRe0OROXoTm2Npm0eZT1sx85pSjPe5tLyCvwRF+
	B0+v9Y//8w7FiV85Xwsw+DRWXN4zJ4PIlpNia/iUbz2GzXrTC1QIU82TSG0ZXn2QQBzsWeIs/Ct
	VWCHffN+9LELyNplY53bCcavA64UP9+b12/EKTw==
X-Google-Smtp-Source: AGHT+IGyVzxlO9P2N2/Nle4urv89zandwAhtRJZVVvNItIuQ0pBbBhYt18T7OWc2iTv2p8Tw14IEUrXNp6FevFF8nO0=
X-Received: by 2002:a25:e812:0:b0:dcd:a28e:e5e0 with SMTP id
 k18-20020a25e812000000b00dcda28ee5e0mr2521252ybd.25.1709219201044; Thu, 29
 Feb 2024 07:06:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223181439.1099750-1-aaro.koskinen@iki.fi>
In-Reply-To: <20240223181439.1099750-1-aaro.koskinen@iki.fi>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 29 Feb 2024 16:06:04 +0100
Message-ID: <CAPDyKFq-KuoMNE56zjc329OTfF-O8Qm5pDxtkNotZWi2aTBd2Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] Fix MMC/GPIO regression on Nokia N8x0
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Feb 2024 at 19:15, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
>
> Hi,
>
> Nokia N8x0 MMC has been pretty much broken starting from v6.3. These
> patches restore the functionality. Tested on N810 with eMMC and external
> miniSD card, and on N800 with SD card in the inner slot.
>
> A.
>
> Aaro Koskinen (5):
>   ARM: OMAP: fix bogus MMC GPIO labels on Nokia N8x0
>   ARM: OMAP: fix N810 MMC gpiod table
>   MMC: OMAP: fix broken slot switch lookup
>   MMC: OMAP: fix deferred probe
>   MMC: OMAP: restore original power up/down steps
>
>  arch/arm/mach-omap2/board-n8x0.c | 17 ++++++-----
>  drivers/mmc/host/omap.c          | 48 +++++++++++++++++++++-----------
>  2 files changed, 39 insertions(+), 26 deletions(-)
>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Nitpick: Tony, while applying I think it would be nice to change the
prefixes of the commit message headers for the mmc patches to "mmc:
omap:".

Kind regards
Uffe

