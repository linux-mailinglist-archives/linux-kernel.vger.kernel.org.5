Return-Path: <linux-kernel+bounces-133433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF65389A399
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843E21F23EA5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF88171E44;
	Fri,  5 Apr 2024 17:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgfL5TFa"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB7B171072;
	Fri,  5 Apr 2024 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712338743; cv=none; b=fFKdDReROQyXI5yhDg73ar4tNr3CY48GrgHvQgRvYYa2Mv7VvZ2Pxr8QcXWUNAMmEHCfbA3iE5bVh66bWFvB39keNuGOpQjAz2+QQhC4Pjq6KO5GWC6U24a6g3/3wtroaQqi2CXuXtCDV1GNIUzp/KsLFkEEhGKiyDrwhDeYh/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712338743; c=relaxed/simple;
	bh=XkNv1Lje8tREP4a4egM0yUzbQRvo5OybpHj233Dw/9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2ovSSJ7jjiJF2L3fwC7kQSYxc99p36TJo/X1c3Zt2GAAIqLT5AdmeAtOwwW1czQSlu/7kcATb09v5gmcObWdpFnU5OHMGdPtsMNYqNkVTg6iTPXgtkOBGdd3VRz1qj0cNCt7eCKtx15OFr/+zfU1/a54UWHlJqSoyGVsIcCO1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgfL5TFa; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d862e8b163so487107a12.1;
        Fri, 05 Apr 2024 10:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712338742; x=1712943542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkNv1Lje8tREP4a4egM0yUzbQRvo5OybpHj233Dw/9o=;
        b=kgfL5TFabPuF+rEuDwCSE63s92ax/yBKgJi+yrvWwbDP/ncHYt7E481YDWBZfbnDoO
         Bst7Kcs24TAbyaCQ4RNb4vvUHboAzy5TmTzT4uxgV+Tz7c4TRXzuWubEk9841LW6m/8p
         nuXIW8o70UDQnHPiL5Zr5F8TCODIjm1yeRLnms5QJOpd2Wn6UzxsJ/Tid9Q85OaurJe1
         SWf5IHAfOB9CQnREkCloGA2yU6i5sUCsQKr7b6BGbnzhA01v8K0VwPx1aZED3GiP4i5I
         7WmSo4p6tlKIvaK1WnetzfIOc5oBH5NiqKS0iD7a9A/sxv5L9tOwONAaX6f3NucDHrTf
         CPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712338742; x=1712943542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XkNv1Lje8tREP4a4egM0yUzbQRvo5OybpHj233Dw/9o=;
        b=G0rpP6D9Htwss0oI27Uai63ahfPIHTd3hsrodH/d/GMvKdQGcTwv3z5vJSHABEDEHD
         7O6QWTkNKvL5LYxWBhia3qLuOjK3Is2wxm/uudmVu+LBadLpqS3CqqhtsApKF6fof/VR
         8X2d6tbW9At/+rl+tz232MVqs3JH0w18lgn7U0t6Vm5VjUbnc9biZl3gdhzQLzUqUfDj
         pCI7pC8GN3GZG5HrS4QcckCv7FwG6lwHb9J115RaTtUzKHa6qx99C9Cu2qhxTolFkD5W
         sE4OjQNKVWfM707//mrSe6nxqUNd6hXJIANNtp7genTnyNrIYpQExWYgZ5W0wmrfSSJY
         ZiYA==
X-Forwarded-Encrypted: i=1; AJvYcCXEpUz6Sb2egFLR0izh26ba8IpXx53kCF6jOJgUvwGZS4Yd6eOkCvE9RoPTsccwVbWaUuWniW0+rO92ffed2Qv5tzmA6BEs3Alb3AvjFD072sxMmQ49c7P6ZUf2P2yG9F3NZIiWgy+LNAfs
X-Gm-Message-State: AOJu0Ywe9TbutLq/vNESdn1ezUOjpE/J8XQEuQ+27cEsx4yPcsuuLq0r
	kf7iwqEC3R27jJLF+DSmsRKpRRsnRS/3dFmH6pgC3rh2LBL1PRwJo3cyUYzyMBf4RYBbBzPAt9F
	CbAKw+nM045OFiuYz+VB3b7bvovo=
X-Google-Smtp-Source: AGHT+IG0fdWiO/DDhWt+ydU2XsAmvp8DjslGdEn7xhs3xLBJ4xyuh09Wa2suF3tZOlzI8PazH3O11cA/0Kf1hRuxMYk=
X-Received: by 2002:a17:90b:e89:b0:2a2:386e:3921 with SMTP id
 fv9-20020a17090b0e8900b002a2386e3921mr2035370pjb.3.1712338741681; Fri, 05 Apr
 2024 10:39:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <76cf9ce9cbf9dcdf78bc00ce7a919db1776ebce1.1712309058.git.esben@geanix.com>
In-Reply-To: <76cf9ce9cbf9dcdf78bc00ce7a919db1776ebce1.1712309058.git.esben@geanix.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 5 Apr 2024 14:38:48 -0300
Message-ID: <CAOMZO5Axz7un+9H2uEoQtE0=pYNC0hEyZiNobrSi2m0ajj8N+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] serial: imx: Introduce timeout when waiting on
 transmitter empty
To: Esben Haabendal <esben@geanix.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 6:25=E2=80=AFAM Esben Haabendal <esben@geanix.com> w=
rote:
>
> By waiting at most 1 second for USR2_TXDC to be set, we avoid a potentita=
l

s/potentital/potential

Could you elaborate on this deadlock? Have you seen it in practice?

Should a Fixes tag be added?

