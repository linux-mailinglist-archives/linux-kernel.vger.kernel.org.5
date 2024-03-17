Return-Path: <linux-kernel+bounces-105322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B70A87DC3A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 03:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 535B5B21925
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 02:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AAE441F;
	Sun, 17 Mar 2024 02:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fqvWrr++"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238DB1852
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 02:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710641015; cv=none; b=P+JMsSScGeNXUHub7RaF82a8i1C3gw8LdgYOA7iuGMZ9FNOIiQTqqrmFR/tR/yEVqfd6gs1D11tFYteFlIjfjtjiYh3Q4ZzyRvkAKM28rTQWyrgl0hQUw3o50TRzFneeZIyQD8+3yFkCMgSLaCTcWtYW/hcIrVMT2auD7dn0tvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710641015; c=relaxed/simple;
	bh=Kv0QSCq59fEtM1NO8t+yR1R5EVeHyVOYWIDdxnJijZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odTTG7vU1w6dMJq0rOzpAapDDPx2V2OmjKogHvILA81gUjjXm1ZRbAzJPZgxHxujnoTac/BdH3VqygFFxnAQRErfEu61pyb3Ih4TLQG4pr4Iz1DPypL8wrpT8oWIakxoIVW5X4gngtV7riEq4yBnvYx2WK51gkUXouLgyfBCPc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fqvWrr++; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so4012346276.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 19:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710641013; x=1711245813; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fDawv7n/Hl1MA12W63Wi04iWswIJUMGvTr6PyC7EIoE=;
        b=fqvWrr++tWaecfls5HihSXzGdXm8jrmk1XlhUUxG9nF3vjRb9vqNrSFUfFfLfpJv6b
         A32zhjjFHzpbquAGn/3JnW/zU4+TA7aX0e7VyOrH/HfNak5wHz1lvmU/I+YBfEnbIfKa
         8tscClynaME8rUu6b1EdJ23u1KGTapRYKvbPEl+azUMvS+sO1KagyQiB6lqJZix74ZS5
         OCy/RAURpZn7zUXjCUTQrnJK5Qvw/AeAkoUS9HvF5vjboJ1TS/Fgk1j8krkJnN4QChJS
         dNKN3mGQlL19qG1ekJCwPWTf7Bpiff+P1wBE/z5UfSHb0J8YyacRLHBKq47u/IutQeup
         rhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710641013; x=1711245813;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fDawv7n/Hl1MA12W63Wi04iWswIJUMGvTr6PyC7EIoE=;
        b=GJhRAg199J4JLYzaf/wGHoU8OzgQkrBPXZykhscBAKzNRlvaccFdATiLT8qEGU8kPX
         PsrjrX9sCLI1J3zjgY4MLiIyPBKt43J34k6b8eavjYrz6hIB4ONwjTi9zlOj8DmHlPSv
         PwlSnxR/B2qVMH7601OzeSp4n+/EDDjY/InJm6hEP59vkJJeho0lm6GE2Jvj64sqosvB
         kQzGB2O+uKMq7EyyN+/yjJKCkiri8NBCN1p75pbhQPAPyIFg0EZSsMz1YxNUPnXVJZ+8
         zrsWIF+sh7VSJfzA5TrvexYHqIqZaCZs5ynCieQOCZjkdZSI9C1CwvYI9mFt0XoSoZ5g
         e4aw==
X-Forwarded-Encrypted: i=1; AJvYcCXp6gb8J2lplV7ft9Sxq0DdRv1NZpd7Q1R/PBb26cwFCa6pMp4qrPT+fI2LnYaBIS0hSQY3qKYq9Io8jwiz2dfQ7+0eA3TJ2+GIJRWO
X-Gm-Message-State: AOJu0YyZJEnw8lBLEVZ7bkKSmXJqWTafJGxKW7bO1JjKlC7i+gtuo22l
	g94BR0UXmvpeSta0zaANiPzm1OWgPFIAQN2zVSxuAbtZMsIqDGin6ncOcCo/kbeTiMdp4HI4ppq
	vgFC8ZpVNyaAMn327ME3Ol+PPuC6ELvzk8Dd6Kw==
X-Google-Smtp-Source: AGHT+IGKP5/QVTFeKJWp0LE2bmqx8+bXO7FoyJVOXlQK9kdHfeZzWq2GYg6yprxmFWn55gcVROku92p+nT0HUkQ0/Ik=
X-Received: by 2002:a05:6902:1348:b0:dcf:ecce:b2da with SMTP id
 g8-20020a056902134800b00dcfecceb2damr6226829ybu.19.1710641013131; Sat, 16 Mar
 2024 19:03:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e09122722190d052cee792a9246c274510f3b928.1710618660.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <e09122722190d052cee792a9246c274510f3b928.1710618660.git.christophe.jaillet@wanadoo.fr>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 17 Mar 2024 04:03:21 +0200
Message-ID: <CAA8EJppcODOQPaP1=0hfb72egS=Nca82OZV1SH1gw9XDubYaSg@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: lt9611uxc: Fix an error handling path in lt9611uxc_probe()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 16 Mar 2024 at 21:51, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> If lt9611uxc_audio_init() fails, some resources still need to be released
> before returning the error code.
>
> Use the existing error handling path.
>
> Fixes: 0cbbd5b1a012 ("drm: bridge: add support for lontium LT9611UXC bridge")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only.
> ---
>  drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

