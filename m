Return-Path: <linux-kernel+bounces-63701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D29F853371
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11E591F262B2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E9058119;
	Tue, 13 Feb 2024 14:44:28 +0000 (UTC)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F815789A
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835467; cv=none; b=uFiQKqcoXl1y4nOYbLRBHXZLe71k/am+NS6KCyDqkTHvpXEOTNUOZBbKXM2O4CR+EZSnI6SMTHZgqAu3AQlsm51n0hIutFx+sD+4oZrePnXiedkELYhuPGpTbWS+0mkBhITUxBuVXyxreFUaltcJreVQ/239oEZ7VvNxa2PrWws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835467; c=relaxed/simple;
	bh=4T6Z+T+8+wgSIZaaE8oQJZMCq24ZtSpur1maeFVGFmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MaBUuxkFJrZFTD1d35MC7u/kRRCB60YRanairIpUI/lWjmUzayKlwembiNSNliIbLSH+L3FC0eLr4RTCe0iojlvfO+ss0vh1jiFPqQyDhqeiwxDL0cnvAchvSmJE+dPvKcAzUC1lqZ9HGWebt7XVUkWAjzGfhFOVhOt5wHfuk70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc6e080c1f0so3789957276.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:44:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707835464; x=1708440264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RWOHboTTtc8J+GRIzyUUHApRBnZZYmJFISH7bck1uo4=;
        b=DUYm7SXjWE2+QHBB8CCIumhANRj8hsFhyqZSpgixwszEI722zLTYBGq9G56pSq9CvT
         bQ4UZ+gs3S/jx+tIPSLH2M4gYYt1WYIJZ/vXMu/QNv6VlLfUFq3CBtwJ4WXKmXCTszWz
         95IIMmDxsukmZknn2tbBeRwqD3LcIe0qurb8zR2lpQ8tioT8+6/JAeWzp2Pp1vfdKebz
         W0nWs2VTK87tCxqDEOSN4DluiS//5A7dwnTkIjiHwCZWT87jzS/2sdfjHDg+RPDEKgO2
         SXV99zy6JiFsHVNeQhjsmM1ltJIoOr7RFZlm/+Iz/iiWdKaM8AQwIt4AEUTqwtht03vK
         IcYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeWZ5lOW4cURs+aQw1YBWNuSJv9E4xUArWLgbQyddecCxGoZ5BioRyKZ4alFFlI9zU4aTjOmuaxdWjcXqwKp6MI9ZUkKuXQS7L1FXZ
X-Gm-Message-State: AOJu0YxTW3lyli+OeVuiIvmVZYvZ/yYzJe0jEelZRd9Ni/0VQv38ARsK
	vFYW9lM24Qua/2oKup+GLWgF5an0jFJsb+6tMX8in7YeQJt1KGzXyBBYdKjVV+I=
X-Google-Smtp-Source: AGHT+IEFMrBJN6e5SazLZoTTC8yHqZTGyIDaJKdafs5c8tJCI2a58DKMY8s89sVUp6wmCt+VWE+zqw==
X-Received: by 2002:a5b:94b:0:b0:dcd:6dea:5d34 with SMTP id x11-20020a5b094b000000b00dcd6dea5d34mr305162ybq.36.1707835464152;
        Tue, 13 Feb 2024 06:44:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXeq1o5UBQZ0Cg4RnqndC+TxzPz4pbnVZkQmecPw0TnKrDGYjjK8xojN4NNaa/twESEpmHYMrKLxtUB5HAn41P4PrdQzNGU+//rEnw5
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id i3-20020a25b203000000b00dcc234241c4sm490763ybj.55.2024.02.13.06.44.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 06:44:23 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso591893276.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:44:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXbHGpkUYh85Gcp9G2NjfAesshFz6LaVr8k4G7E12exI5rE2tWuN9NhhVSPUXHsZkWz0dPu6UWek9pY3864q09Ct/8NKTBx0DzisAyG
X-Received: by 2002:a25:848b:0:b0:dc6:d738:1fa6 with SMTP id
 v11-20020a25848b000000b00dc6d7381fa6mr9937843ybk.6.1707835463699; Tue, 13 Feb
 2024 06:44:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213-bus_cleanup-zorro-v1-1-388ceed8e7bd@marliere.net>
In-Reply-To: <20240213-bus_cleanup-zorro-v1-1-388ceed8e7bd@marliere.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 13 Feb 2024 15:44:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX472r7nY1QenJcG1VQWAF_Bx53UyXOWdPENTQKdDvLCw@mail.gmail.com>
Message-ID: <CAMuHMdX472r7nY1QenJcG1VQWAF_Bx53UyXOWdPENTQKdDvLCw@mail.gmail.com>
Subject: Re: [PATCH] zorro: make zorro_bus_type const
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:40=E2=80=AFPM Ricardo B. Marliere
<ricardo@marliere.net> wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the zorro_bus_type variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k tree for v6.9.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

