Return-Path: <linux-kernel+bounces-105828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BA787E518
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17041C211A2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F88288D7;
	Mon, 18 Mar 2024 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="gWzGAQRd"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFBC1E866
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 08:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710751321; cv=none; b=b4dDDR8jYuY0fXIVQwbIAqiZYFKgVqFjw5HiHIyZi2vC8QtRA+A8ymT53XVhXNSFia1tXMY7ZaPZAWL/isNjLUVsjVUbWnJ0JKbvqVIyhfYwO2GIkW0M/224a9OYX10L3d4O1b7xeLmwKWBS4dn6QIQ+U38XCigFiygsrw1a5kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710751321; c=relaxed/simple;
	bh=/Ao+rO9SYdti3VAE+xg23jyg7XXRQAwBbXmqo0PcSys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lEELEhaFOZeKjWUVPwS+CWW1h3XwUL5yUdaAz7A1qKWKclCM5OI1CJ/GvJIOh5vVPjEcAsIEx+2kRBXp7S4bsvjSUvpY1X0CNxjSLUDeWRyVng3zTNiTqCC4Vm8kTo7ZRLMQALEKb/LofJes8HLeuJonF4Qrsin/JR+TNCM+rYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=gWzGAQRd; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc74435c428so3618480276.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 01:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1710751319; x=1711356119; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VIYSHAzUIRDojyXoAAjEUNZdKBZsmGjQo4tf8URh/nU=;
        b=gWzGAQRds3KPLEur/AKy97iaStaFYbCPhFa77YwxLX5x5pRyScgPw38g3pkPRKWcNs
         QeHRlakv/Y6IXjTlJ40zQGdrKeCmsd4nwXb/upaPBy1Lufq0Aq59Fmni4jXmN/LClpjY
         xLqU2nV8kppFIi/0SqxJE7091klTmwXQz3+AOfapy8NWk+Z7tKECRFYpcQmvuFmjkgZs
         d5E3nELDFKNyMiDVv2n5eLJXe/VPgllbSOj0xSCK1jUUWwgO4+AbJAjpIEFT30jhEUlV
         bZ9da+uV/kOrTLywy007+LeZbajHzJGfwNQAGuSslC1HjUuNvW16DKTvo4r5KaBYKfWw
         8Ibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710751319; x=1711356119;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VIYSHAzUIRDojyXoAAjEUNZdKBZsmGjQo4tf8URh/nU=;
        b=qznanjh2cYNb2HumS2DllWbuM+5IHgpM/pef4DrrBR9CQsOiVUfKRpOWELl+bc45Q6
         rtnjWwM3KHm9gzw1a2zKSrsRB6kwBkutvXalmHDXpHALIIyAXnAWrdIoUcqvQZsGLMUg
         xpFov0BKCyFo1EIZ+iUNUnTJeLvI/gwHPf1pPER2vhOWtUAYlEooMbwFjdoOs4iCS9ka
         WhiemZPjycIjUTywZUSznjcYQf34/BBd+fotVkH8nj9rdp3UnxdSnLaPXcl5AQWKtslG
         dQcKkyfroWLay2wKueYyWrw7Ay98D2nZpDmB4a+z58FM2SIsasJso3uJ11BhAN9nPqDZ
         XFWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqM1MLN5CuuFaLngjq+Pm/lRwlEdLIVMVcQd/Tom/0cXst9Acl3o8r8J0JXjDMkrmz6NnL6R1lQz4yA8grM61eoZ69TQQCv0y039Zs
X-Gm-Message-State: AOJu0YzxGOc64tlfK1vALJywDsldHdQuqqWQiCZj3i6xx57IkNF30nG7
	30Ov987pWZ6bi3x9zq+FOgV4wUoo6I82OPAgQrfqaEDsSXtFaPwxUUvIhUzemyFSli2VaUEN08p
	R/T1vQ7pK0UY6TLg1SYRr2sh0pxWvWquKvd+AOw==
X-Google-Smtp-Source: AGHT+IF8wwv3ZYqOOUIu6PR6XNV2RjVzHn8LILTUbDnyIninSmaNrCNUbexvDIyHwBt+lTK8AMVnuSEbUvEpBilkN18=
X-Received: by 2002:a5b:a84:0:b0:dc2:4f34:c964 with SMTP id
 h4-20020a5b0a84000000b00dc24f34c964mr9280814ybq.23.1710751318958; Mon, 18 Mar
 2024 01:41:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315-mc-graph-fix-v1-1-91d59d752614@ideasonboard.com>
In-Reply-To: <20240315-mc-graph-fix-v1-1-91d59d752614@ideasonboard.com>
From: Naushir Patuck <naush@raspberrypi.com>
Date: Mon, 18 Mar 2024 08:41:23 +0000
Message-ID: <CAEmqJPoMmneTZAjJgOMRpd_B_236jh8NU8bpnaK6Odvnd1zcWg@mail.gmail.com>
Subject: Re: [PATCH] media: mc: Fix graph walk in media_pipeline_start
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Tomi,

Thank you for this fix.

On Fri, 15 Mar 2024 at 15:13, Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
> The graph walk tries to follow all links, even if they are not between
> pads. This causes a crash with, e.g. a MEDIA_LNK_FL_ANCILLARY_LINK link.
>
> Fix this by allowing the walk to proceed only for MEDIA_LNK_FL_DATA_LINK
> links.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Fixes: ae219872834a ("media: mc: entity: Rewrite media_pipeline_start()")

I was having problems with the Raspberry Pi Camera v3 module (IMX708 +
DW9817 VCM) that would crash in media_pipeline_start().  This patch
fixes the issue for me, so

Tested-by: Naushir Patuck <naush@raspberrypi.com>

> ---
>  drivers/media/mc/mc-entity.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/media/mc/mc-entity.c b/drivers/media/mc/mc-entity.c
> index 543a392f8635..fcafe5c59052 100644
> --- a/drivers/media/mc/mc-entity.c
> +++ b/drivers/media/mc/mc-entity.c
> @@ -627,6 +627,12 @@ static int media_pipeline_explore_next_link(struct media_pipeline *pipe,
>                 return 0;
>         }
>
> +       if ((link->flags & MEDIA_LNK_FL_LINK_TYPE) != MEDIA_LNK_FL_DATA_LINK) {
> +               dev_dbg(walk->mdev->dev,
> +                       "media pipeline: skipping link (not data-link)\n");
> +               return 0;
> +       }
> +
>         /* Get the local pad and remote pad. */
>         if (link->source->entity == pad->entity) {
>                 local = link->source;
>
> ---
> base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
> change-id: 20240315-mc-graph-fix-8a2a245d7346
>
> Best regards,
> --
> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>
>

