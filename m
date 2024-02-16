Return-Path: <linux-kernel+bounces-68689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EFF857E6F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F72E1C21331
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB5E12C7E4;
	Fri, 16 Feb 2024 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b="clqUQWad"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6223112AAD9
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 14:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092145; cv=none; b=eqP85CnoDUPr/odx4GlUoLIadDuvJMmls0qUKF7f5VgeCTuXmbAzfjLX37SI3PWOjIywR0U4QztwSAjKOwJ4EBcr4dC3r9cWSKftphzYGQHMz0KsgjmV9CXifHpcqzJVgVs/lCkvUbqyMMclTD8ZaQu9gkijcQe+1TbEso+LaP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092145; c=relaxed/simple;
	bh=nFBgUAAUEN/cLgDxtF+HzukYwlFpuLG9I2LKGjp3pXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W0czktXZnV51TaXMcuO3uDwsH/uJ9W8ApWKtra2dR1BfX+VwEtk3tGNBR457+hykcqEFtCoeMazsftzFRJipIvhKmX4w76pAAaea8Vw1uTUq9/xhHDSTyMwb/1TIMVZw9iUuKCEErsZSuo6cEAmyoaYu5PBLohD9xC/WFkVY8AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=none smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b=clqUQWad; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fooishbar.org
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42de7c6166dso595711cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20230601.gappssmtp.com; s=20230601; t=1708092142; x=1708696942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nFBgUAAUEN/cLgDxtF+HzukYwlFpuLG9I2LKGjp3pXQ=;
        b=clqUQWadO+BuHHDuj1Sdzt4RiMlMHqY82/T0lDB6TQGh+G4Bc6W5nJN9pmSYqzIrhY
         9AtlaTom/PTDdJeBIoY1oakTPzNuI1uJHngibJEvpUtgTBHTfZ4XbI3IWjWd/uJJ60wU
         tMLNzoULGWZDiQRbSqGxK6rU6IzZ5o5BDXo2hUPiwIfRUfJD7FxPdUFBBe+Q9gm+GX+k
         JqrO1hgQ8FaAbbQQzsThU3Z05WcMBaKyHC45y0c2+lKOwuTk0PYoF+TOZosAdXqPNr/6
         s3WZmRVwP4FQE3LAHGF2bcuBzIcj1cguaAnPZz4wdCb+h5aN6t2eJyMCyJb2ezn2eves
         2LUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708092142; x=1708696942;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nFBgUAAUEN/cLgDxtF+HzukYwlFpuLG9I2LKGjp3pXQ=;
        b=pr6s2w6GUqfBZlfRCeBsH3sIjrcHUw94Hf4imlECl4O/YoefofxmHMbOzs2aDy5bj2
         jYjBaFQVN9oFRaUyRPgbjXQs0RzzoVDTAPguLMSwbRXkHLFoXbcZQkSWYcsJVaLrtpvq
         KXLhqpMlbis7NvhPqn7SHKR3mwAvbhtJGW0LEdNi6ak7miQk5JrFfCkM0dwC3lraWmKg
         L7sCNa/SLkwlWZD+kHHs8l4iF9/wa0MAeDTerhNdkC4LntbBnK8OjOXmdBptvSnydnKu
         6PHI297p+VrF+XJ+ba5ighWbWGaAqA6kdCkD5zosUU18kN8uYU741FqsN3EpgJJ2S8nX
         2hEw==
X-Forwarded-Encrypted: i=1; AJvYcCUYe0UZMZ3Eq85VEXo9iVv2uDdjr1kGSmtK/7njVruNFYFph1e9/u7Mp16Gu4mh9GpaKPrYy2jX2KLoW/js8vwbXbciIkfq6+idovyT
X-Gm-Message-State: AOJu0YxhNQqGspOP1lSDLBD56L9zuQioeoEgK8gSAQ8pD1QaXYaqjw4p
	jDgy+gTnGIoSVvc2K2y9V3zp8Ie8t7Pw2SX56eWANOtW4cqXa7z78cziVoVn4doNPgqgLpMhCyN
	QwlzwzLZ7qGzT0xyYg/ISmyEUtSter1NDc0l6tg==
X-Google-Smtp-Source: AGHT+IGcSoJ+2K5yvULHav0aWsEOCSmQfdoZoFCExKbeUxGKS13t32Iabr1wSDMwUBxYJT8cbluJgDZnNDxdPV1vq/U=
X-Received: by 2002:a05:622a:38d:b0:42d:de82:1438 with SMTP id
 j13-20020a05622a038d00b0042dde821438mr1801013qtx.0.1708092142014; Fri, 16 Feb
 2024 06:02:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213-tidss-fixes-v1-0-d709e8dfa505@ideasonboard.com>
 <20240213-tidss-fixes-v1-1-d709e8dfa505@ideasonboard.com> <20240213110440.13af335a@eldfell>
 <bb8089cd-2a57-4ed0-a8bd-2140a89b0887@ideasonboard.com> <ZctCCCJORdDEaDl1@xpredator>
 <CAPj87rPpdOQLLu5oGVfqDUh0_j9NXqc3XgZe5=tcOzUfVoeeqg@mail.gmail.com> <263c5e9b-d6fb-41a8-9d8a-84ea49eef51c@ideasonboard.com>
In-Reply-To: <263c5e9b-d6fb-41a8-9d8a-84ea49eef51c@ideasonboard.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 16 Feb 2024 14:02:10 +0000
Message-ID: <CAPj87rNi4=0Os3dNANmWbHm=sCeyogYDG0ZJUED2PGn0U-7tEg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/tidss: Fix initial plane zpos values
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Marius Vlad <marius.vlad@collabora.com>, 
	Pekka Paalanen <pekka.paalanen@haloniitty.fi>, Jyri Sarha <jyri.sarha@iki.fi>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sam Ravnborg <sam@ravnborg.org>, Devarsh Thakkar <devarsht@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>, 
	Francesco Dolcini <francesco@dolcini.it>, Tomi Valkeinen <tomi.valkeinen@ti.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	"wayland-devel@lists.freedesktop.org" <wayland-devel@lists.freedesktop.org>, Randolph Sapp <rs@ti.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Fri, 16 Feb 2024 at 09:00, Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
> On 13/02/2024 13:39, Daniel Stone wrote:
> > Specifically, you probably want commits 4cde507be6a1 and 58dde0e0c000.
> > I think the window of breakage was small enough that - assuming either
> > those commits or an upgrade to Weston 12/13 fixes it - we can just ask
> > people to upgrade to a fixed Weston.
> >
> >>> Presuming this is not related to any TI specific code, I guess it's a
> >>> regression in the sense that at some point Weston added the support to use
> >>> planes for composition, so previously with only a single plane per display
> >>> there was no issue.
> >
> > That point was 12 years ago, so not that novel. ;)
>
> Hmm, so do I understand it right, the plane code from 12 years back
> supposedly works ok, but somewhere around Weston 10 something broke, but
> was fixed with the commits you mention above?

We always had plane support but pre-zpos; we added support for zpos a
couple/few releases ago, but then massively refactored it ... so it
could've always been broken, or could've been broken for as long as we
have zpos, or it could've just been a small window in between the
refactor.

