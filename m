Return-Path: <linux-kernel+bounces-31345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4747832CE2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C3D1B23D0C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F0954F8C;
	Fri, 19 Jan 2024 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNY9mz2y"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF4C54BF0;
	Fri, 19 Jan 2024 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705680609; cv=none; b=LDm7LaoXzyvjwpGImD+4QJ7le8iXNrP9tsYgPy7wG+Md70quFiG25h3GXddD4UgA1OhvP7TawnFSPMpX5ogZW3sZWpUnjDw9VJDx2CSm8FaULMHLiz5B0tOgHqLBHYHNcY8dUbBPueOkI0fqkQp27mbHebeefRSipUxfh2KAdCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705680609; c=relaxed/simple;
	bh=vrfrQmaR7zVk3WtIOmDG6fhQnohSJy5l+phLzlOEZ2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/dEhD0ZmhuvkTHzkoS1wohZdzts1fHf/YHU6L31g2hawGpEHIoXNrA2b3tHlcptPkZr+A0DPx74QpTPrM7EX89aY2yVRkzEmNl+SEAK7CDE4yIkhQhTmfFSPgqzA7tp1mpxwV1e6qXbFYlsAj0xi4mF9y5BxyHw0oJT3x5KDA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNY9mz2y; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e7f58c5fbso1184549e87.1;
        Fri, 19 Jan 2024 08:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705680605; x=1706285405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xe2AZJ9rG4DIKTX8/he/utaFFdUl2hwHY++4l7rMVNA=;
        b=bNY9mz2yhuev4/zguk0T2YsXLIquxkOuuOX5LMgM2+j8aXRkLnL8B7f0wWkDtRBQKr
         3psTOvtq2haQeXW7x/QiP8b7dr7pWfSx2x9dfaMY22NF1a7KCLxcxigGN/O+UkJAYjWP
         44QCSsdJigZKOOM9x9aX6ouWQz8ti3GPJPDM1OnT14AMiFnBVS3vqTtrNhBNrES+1/P0
         gxqAhtvlWvT+miFEZGC5A547HFBQAaWaWPUiyIcLQYXFiKPshJnh+gba+he6rMRhyPDA
         3YEdtMckr8g2zHXRztIHYUfzHeMP5ayF7MQA94cY0egbdqpbK9x1RnYj7AO7vFA+H2is
         wJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705680605; x=1706285405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xe2AZJ9rG4DIKTX8/he/utaFFdUl2hwHY++4l7rMVNA=;
        b=sIxEXF77RF10+Kz/Q1iUmWQ5DUS+C9bVqiqOa4eK1GQ3oosUethV3y9IvobkXEtYWI
         DCFY71l5ta/+dvI1vV6NZpc2DBurNz31lf97MaceSbAZjoydRgAaNufPXptkjW7AoS8H
         rNwlKdp3Fh2QbpEDkOQvD7dJJHoTYltPiPKPPzUtLVwYUX9fY7L/B1RRPLv7X4NuPvNw
         FFJHWJA6aOtf66LjFYs/QP3kJrb7Tl5jfmtzq7hSB8sF63+m9wDBffM0MCbY22oIfgT7
         qDxpcEy0TUQManLiqOGKL9SKvmb+8VE7YV0Y61rXeWBAE0eqp6fYgklABxgmQ9iKuvfA
         v73g==
X-Gm-Message-State: AOJu0Yw/tkca/XAwuJLZbshSYmnw2fYf2f3ug0cgfw+Nnc2pBx44YWDz
	Au+VFzCpY7o7iOzNZITfukoUVeg5AcasIG2T7uUulREOnTCGjqJkmzmHYCzA8dzXSY0sOzZ6Qud
	sHIuz5tfO2kKzLXzqGTXZQMIqPHM=
X-Google-Smtp-Source: AGHT+IGe5hGb3AQxEzUByESuCQYg8t9XsnK7jKBnEML9VYgxTrUlh51XrlhoAVDfHHhRdN684YROYUuUrEhYSmYrlgU=
X-Received: by 2002:a19:7413:0:b0:50e:d5e2:92cc with SMTP id
 v19-20020a197413000000b0050ed5e292ccmr804081lfe.81.1705680605272; Fri, 19 Jan
 2024 08:10:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230804104602.395892-1-ckeepax@opensource.cirrus.com>
 <20230804104602.395892-6-ckeepax@opensource.cirrus.com> <ZalahZkCrBm-BXwz@surfacebook.localdomain>
 <20240119114917.GB16899@ediswmail.ad.cirrus.com>
In-Reply-To: <20240119114917.GB16899@ediswmail.ad.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 19 Jan 2024 18:09:28 +0200
Message-ID: <CAHp75Vf0BdOj_Bcxs3L=aznUzoMptPF+tDBpOcBKOcVTH45+Hg@mail.gmail.com>
Subject: Re: [PATCH v7 5/6] spi: cs42l43: Add SPI controller support
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, lee@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linus.walleij@linaro.org, vkoul@kernel.org, lgirdwood@gmail.com, 
	yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com, 
	pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org, 
	patches@opensource.cirrus.com, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 1:49=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> On Thu, Jan 18, 2024 at 07:06:13PM +0200, andy.shevchenko@gmail.com wrote=
:

..

> > > +   if (is_of_node(fwnode))
> > > +           fwnode =3D fwnode_get_named_child_node(fwnode, "spi");
> >
> > You can actually drop these is_of_node() tests and use another variable=
 In
> > ACPI there can't be child node in small letters.
>
> is_of_node feels pretty clear what the intent is, rather than
> relying on nodes not existing etc.
>
> > But main problem here (and in another driver where the similar is used)=
 that
> > you bumped reference count for fwnode. I haven't seen where you drop it=
 back.
> > Have you tested rmmod/modprobe in a loop?
>
> Yeah it should drop the reference will add that.

Note, this will require an additional variable anyway (as in the
infamous `x =3D realloc(x...)` mistake).

--=20
With Best Regards,
Andy Shevchenko

