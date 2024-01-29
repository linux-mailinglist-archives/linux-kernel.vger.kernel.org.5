Return-Path: <linux-kernel+bounces-42925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE308408AB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A82C1C22FAA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B18153517;
	Mon, 29 Jan 2024 14:36:42 +0000 (UTC)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F6C152E10;
	Mon, 29 Jan 2024 14:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539001; cv=none; b=JEZNDhvosGQbIhVRrcF8TRjoWLRJ1hXvNLFdk6/yJXBE3zsnGsPCarb1+aU6L2NiTbYXK1P2gLCDquHtbxjtJrBAnwcW4KM5ZlikTsTRwNiYaYIR2ssMJwWJyWn8LkqDmUs0ggi2OIyAd64wKq/5vA121q0tsiesb7rJptfwwHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539001; c=relaxed/simple;
	bh=a4swcnAUnYMsfzUSOgSWrzzXe4Gb/P6RaaQB0A0FyDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lvU1GRq97a0SQQ+AIRygHT43YV3J5YfGSlg6Z3xn8RR1j2CXGMqNzaLH4EQdedTWlGVQoQR9ODUL/OXEysWVkIWT9Rho0B0bAAbNAL5gZ9zfGwYIxempIUDB91dYPBLAx5iP/7zEo3cShwAq+0ej8z1FOI8l0U59wXu74buvWyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-59a1f85923aso132697eaf.1;
        Mon, 29 Jan 2024 06:36:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706538999; x=1707143799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4swcnAUnYMsfzUSOgSWrzzXe4Gb/P6RaaQB0A0FyDQ=;
        b=KkVKMLtpPsggIdJp+YH/ILJExQKkwe91HkLV2YDsmNMGCI9IKVju3kccrDd731c2oL
         ixzbofb6T7aEAwvhl7YAhiSbj4U2zYSTgpN/qnSBokl2bJiR47cyLmV4a6m0DkzGlJ1Q
         PcPseufxa85AqofIL/ywDgbV2dSKx1N0zqfe3QN77AFIb5U0B5ooObXvdl5fIbGV4hf4
         p8SF0BFU/GhGXVDpQoP3igRiS5LbShhZnhqPSy9nvDrKuwjyX3d6Z6cXoetdqsBHjSOV
         y5/bjKcl/SgRrIhhaFJx4yRRH2kXomKWmZEPhDWaXiqiLPIbI+eDAlxi9oMf9nlEKZg4
         NRNw==
X-Gm-Message-State: AOJu0YyI9FE9bm5LMet2O2sK6q03UoufW462Xd7VmR+00ezTpn1r71JV
	fgD61V+Ikq1mW6WHMmwm2Tg3ouYBmEF51WJhF18Xd0Nw8inV+M7UnYSKAwgpJrnKGbTpxb1HLFl
	fCku2/iE13dSQVSH6uGaA9KHKJV4QWU1H
X-Google-Smtp-Source: AGHT+IGo3hPicktspkSjYmRtfjq5fZzhRva9brgU9eBR8iJWheJxju10QOpo154p3Fooo4nOhqKlLwpWkiOeWfeXp/M=
X-Received: by 2002:a4a:dc92:0:b0:599:e8ff:66d9 with SMTP id
 g18-20020a4adc92000000b00599e8ff66d9mr6687123oou.1.1706538999152; Mon, 29 Jan
 2024 06:36:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12389773.O9o76ZdvQC@kreacher>
In-Reply-To: <12389773.O9o76ZdvQC@kreacher>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 29 Jan 2024 15:36:28 +0100
Message-ID: <CAJZ5v0gyd+y0kToh2d=6Rg6sL25ieejfa-L1cSF8jehZiEmLWg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] thermal: A couple of minor governor fixes
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 6:57=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> Hi Everyone,
>
> As per the subject, the patches in this series fix a couple of relatively=
 minor
> issues in thermal governor (fair share and bang-bang).
>
> Please refer to the patch changelogs for details.

From the lack of feedback I gather that this is not controversial, so
I'm going to queue it up for 6.9.

Thanks!

