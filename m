Return-Path: <linux-kernel+bounces-57560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4171284DABB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDE971F236E1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E5C69312;
	Thu,  8 Feb 2024 07:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjuhtJe0"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438576930E;
	Thu,  8 Feb 2024 07:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707377703; cv=none; b=IVarO22Jnd/RjkC68ew+N1eYHEa8WHKAB0jXFlFgquTKCwkbNqlseHbSWE5JVu5pjY4b/YpJ0qGkI4UN2m9uxgdjYYhICrY1KwKXbY6ShCOlryS4BUr2+/CCC9NmLU0q0jeSJl1IvrMAjSTsQCIPJZdTfWJflpCm60jm3NWfFWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707377703; c=relaxed/simple;
	bh=1XADCEM8vRbIH6R9VOUbWP8/IpprYucwod/GjqTaZKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QN4FXQwrMvw7Bb9NLGDMhCongjmq1osKhYP04iuU56rO2qHFGhcoAfbvxkO4NayhynYXWyxKeH0qYaiFigwleAOM2vXzJ/atvCYpdYHnn6oM3nrOjkohgYbCNbd2dyVSsREeljUv1WH2PApwjVZAkHh3iuqAIZKOAgeHFXBeoBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjuhtJe0; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-db3a09e96daso1516756276.3;
        Wed, 07 Feb 2024 23:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707377701; x=1707982501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OwiLWf5rY+M5k7F7A5kk6IJ+AFJMy/SNlblmJ/d533s=;
        b=JjuhtJe0uTVCjPpz3CjkM7yVBmk31CQXVRuLKX7xj+aRUfzbD131mUkrepqIT2yH3o
         9GWzFMTEZaYOHFlP1xtXshWzyWsNBnMeFcwUqXxFkL9B0XN+lRFl1SWvvNiX4vLVGbVD
         h5IsgYd3bEF7SuxA4lqgc7WIYktXsSvCB5ZIxXm37BXB2f5w4Q8bpB3/4tjq/QhSuaPi
         76yHDqIoMqu2v03LjtRReCZaj+6mQlu/S3vY7RzW/d8bx+DmAu7nVwR3MqUSc//ow1Fl
         NdozHxcBnzT22yFXV+INQBNbOI29l0W6Ha5ZijwR77zsZhzRyVHBwJNSNejRX6kEz5df
         ppFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707377701; x=1707982501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OwiLWf5rY+M5k7F7A5kk6IJ+AFJMy/SNlblmJ/d533s=;
        b=r33S6fFf7swmiwlm3tdQjdzRm8FQ/VS+RnaXwZeDztDqg70d0w8LL6sJdJf7Op49q8
         M53bXjvgN7wMnpZmF7+Q/AtTBjBqL9AkIfiKddcniJd6EPgEWqPiK0hnwhpqRoWaQS+N
         qF3fsYFbaSPL3PgBnOnVzr7jYxiuqlYMvw2t5tRr7kqyXbI4FEEN5aFy2Wi56+vi4lVL
         5y2vLY41k1fRvOw++oy1UGP+rzUKxg74B2vQaEh9ZpJPLiMPErs7UWQOCNwt3+StS4zz
         BS3jNPm6VKKxEWZ7ANlAKeJvWbugqcWbhDBvitSLd1YNXfs2BQNnhMvKLag/co4kONLX
         +dIA==
X-Forwarded-Encrypted: i=1; AJvYcCWmxHq+xDdixHGyxorepK5BNfebdFeBf8S3YGzk6poiP3BWMfhhDLorzFmUGpRz2dydntOtMpdCPsF59f1Q77xDJKiZeW1GR6CPMz4UwZUdpj7Mrnyh0zg0Bd26zRAZOy1gwRPqUX4j1psrgBdOnssACqik8SwblfijMUTLa9Cb
X-Gm-Message-State: AOJu0YyzvMk2Fs9/7PUFPI9JSWFK0PVjFwPSQ4TpCDADuCg1q3Lde6/A
	CSp7c/c/hKCxWAGEDGYUCpZj4UPvav3fXyHTiTFkmEet95swhPJgbEMiRifTTTJWij+xAKwezWT
	INviIxAFl5/q8iiTT47yTVm+QIv0=
X-Google-Smtp-Source: AGHT+IHGcjkvccjmKXkUVl0dy4auf3wes5FH5BEijtfhWmT3ZweyADdEGnbtjanITGRXfjgeqxb40zpZi79vnfnfwQA=
X-Received: by 2002:a25:6981:0:b0:dc7:461f:6920 with SMTP id
 e123-20020a256981000000b00dc7461f6920mr325253ybc.48.1707377700189; Wed, 07
 Feb 2024 23:35:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131134621.1017530-1-hayatake396@gmail.com>
 <20240131131258.47c05b7e@kernel.org> <CADFiAc+y_SXGtVqZkLoiWw-YBArMovMkuWw3X596QDwEtdBJ2g@mail.gmail.com>
In-Reply-To: <CADFiAc+y_SXGtVqZkLoiWw-YBArMovMkuWw3X596QDwEtdBJ2g@mail.gmail.com>
From: Takeru Hayasaka <hayatake396@gmail.com>
Date: Thu, 8 Feb 2024 16:34:49 +0900
Message-ID: <CADFiAcK_XjLNjzZuF+OZDWjZA4tFB8VgeYXVJHR8+N3XryGxwA@mail.gmail.com>
Subject: Re: [PATCH net-next v6] ethtool: ice: Support for RSS settings to GTP
 from ethtool
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mailhol.vincent@wanadoo.fr, 
	vladimir.oltean@nxp.com, laforge@gnumonks.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jakub-san, and all reviewers and maintainers,

It has been a week since I last received any feedback on this patch. I
apologize for the inconvenience during this busy period, but I would
greatly appreciate it if you could continue the review.

Sincerely,
Takeru

2024=E5=B9=B42=E6=9C=881=E6=97=A5(=E6=9C=A8) 9:59 takeru hayasaka <hayatake=
396@gmail.com>:
>
> Hi Jakub-san
> Thank you for your review.
> I apologize for the delay in resubmitting the patch.
>
> > Could you split the uAPI changes and the driver changes to two separate
> > commits? You should post them as a patch series, but combining them
> > into a single commit makes the uAPI addition to easy to miss.
>
> Understood. I will split the patches and submit them separately in v7.
>
> Thanks
> Takeru
>
> 2024=E5=B9=B42=E6=9C=881=E6=97=A5(=E6=9C=A8) 6:13 Jakub Kicinski <kuba@ke=
rnel.org>:
> >
> > On Wed, 31 Jan 2024 13:46:22 +0000 Takeru Hayasaka wrote:
> > >  .../device_drivers/ethernet/intel/ice.rst     | 21 ++++-
> > >  drivers/net/ethernet/intel/ice/ice_ethtool.c  | 82 +++++++++++++++++=
++
> > >  drivers/net/ethernet/intel/ice/ice_flow.h     | 31 +++++--
> > >  drivers/net/ethernet/intel/ice/ice_lib.c      | 37 +++++++++
> > >  include/uapi/linux/ethtool.h                  | 48 +++++++++++
> >
> > Could you split the uAPI changes and the driver changes to two separate
> > commits? You should post them as a patch series, but combining them
> > into a single commit makes the uAPI addition to easy to miss.
> > --
> > pw-bot: cr

