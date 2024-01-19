Return-Path: <linux-kernel+bounces-31560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF69833013
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEFD71C21969
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC78157873;
	Fri, 19 Jan 2024 21:08:02 +0000 (UTC)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475DE56B96;
	Fri, 19 Jan 2024 21:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705698482; cv=none; b=rs04iX9Bd81l0rH4+t7UIjDROcLckNiyI9u5gmSeijSy+qPILZWQHQytGt3VG+nladeSB9ozEtxO/wFuuGtUkPypPj5GicJun893Yk+7MSHva5VghdWfeM53a1uFHbqIO68wAP7Awjf74/RmaU/4b8ZTNzy2ubS3vo2ReJhfa+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705698482; c=relaxed/simple;
	bh=shIrJzqbvkHFBoQ+kSoPEZhnPZe17BYIWe5TgOsMEC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GD3WCkO7IsRRPWn370LSpf3rntTGSJFMFFq6jFVTjuhPJA14AEnckTN98S3eg0knecKwJSyABgIivuglc5W3mE0uIoge1gNbAqd+JULfMGWrFklKa7N+P2x5md6qAi4pGD3ovAgGtrnxf+oF8xBqbXPemRIhXPMRAYqvjsVYQsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5958d3f2d8aso73829eaf.1;
        Fri, 19 Jan 2024 13:08:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705698480; x=1706303280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shIrJzqbvkHFBoQ+kSoPEZhnPZe17BYIWe5TgOsMEC8=;
        b=gyLehvxWd1d2vLx9bHUsSOz031uVP4RMFBXC1fuacolaagYOqooJYmMyWJEb+EaD+1
         QQms5RWD1lwOaSBnWTpf44fAOIrVxHAFqEq4kfMrwY8onvwWnl6alOlSytXhhJRBANNl
         GPWjX/LAT5xphmKweGtgnNsccx5hoNB2nLgUSUzVLJV5sQIaRcGN/bupdm/s95uAmn3X
         1GFQv/5H83OsF2zvDfOKn/7zk5DaWADN/jm+KeVdQ06mEgeMBvyOzSXAi3FaEL92QYBI
         GmH3V7j3J7QG0li9pSbg38ee4kqhVcHL26l3HXhILvCEs/IiBnHT23ZI1sqo4AVT7w9j
         urmw==
X-Gm-Message-State: AOJu0YxK8/jZSGCT7g4D9raKHQo92OO+nqwTrnfswK1+zcIr4t2z5zqU
	3ORYtYhvAvtLajlt5NgUACOLltQ6Dz8h3XQ2T/tZePpjxmSaDewI+rauKKYl4sYEXC2Z0Acob4k
	0xu8DfUG0dM80qotxjioRm7YfuWo=
X-Google-Smtp-Source: AGHT+IFtk8XRXm/QsT078/xASU6IzLPGBlqhAp7qz3M6Y3IPB5hxSxvh+lRl+Kt0oAP0e/+KGwrPmBfOJez7AeUBNQQ=
X-Received: by 2002:a05:6820:e03:b0:599:2ad1:f1c1 with SMTP id
 el3-20020a0568200e0300b005992ad1f1c1mr610751oob.0.1705698480267; Fri, 19 Jan
 2024 13:08:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170359668692.1864392.6909734045167510522.stgit@mhiramat.roam.corp.google.com>
 <170359669607.1864392.5078004271237566637.stgit@mhiramat.roam.corp.google.com>
 <20240117090706.3522d23763fab9dcea21aee1@kernel.org>
In-Reply-To: <20240117090706.3522d23763fab9dcea21aee1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 19 Jan 2024 22:07:48 +0100
Message-ID: <CAJZ5v0gqWRsSGQZp7tz-0Kw6od+fjd_iof4Rj7fkBy80ySkcEQ@mail.gmail.com>
Subject: Re: [PATCH v7] PM: sleep: Expose last succeeded resumed timestamp in sysfs
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Randy Dunlap <rdunlap@infradead.org>, suleiman@google.com, briannorris@google.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 1:07=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> Gently ping,
>
> I would like to know this is enough or I should add more info/update.

I still am not sure what this is going to be useful for.

Do you have a specific example?

Also please note that suspend stats are going to be reworked shortly
and I would prefer to make any changes to it after the rework.

Thanks!

