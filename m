Return-Path: <linux-kernel+bounces-117326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D669288AA07
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14B8C1C34B8C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4A66CDD6;
	Mon, 25 Mar 2024 15:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="HyKVrXbA"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E657054279
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711379267; cv=none; b=updZgs+Q8IhYZsnxETCWqYEjTB9uwLj9I7/GoTxPOylomXB/YFyMVd+qeYc73PKRqGTL5ys6dkCdgTVPz9yoZEQ1jy6WTpF4IEl7tQqBUSSz4hJl544G0SAeGxl+DwGPAoYt4wzp4mZw+8etPYNjxehSk/JU8t3k2Od/ysmU6u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711379267; c=relaxed/simple;
	bh=6+wM/5Eml0jJjXbueM68ZzKT44rHBgaiZRCLtSh/Yuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FUfIAfNTrAsrJB9HH9RXWk2ars/hJmxFbkiYSikBq9oLrwv6kaQjuWvvWfbPqUyFa+UqbZtrZ6kwb9J9lRMjNCkg5D41aR6GU+xQiMk6XmEKF4dKvUOyDWYUNN0WY2ObaPY0QSrJiPKZakGRB+uSPhDsJlJH6hkjc0IevnT8bUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=HyKVrXbA; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d46dd5f222so55030891fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 08:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711379264; x=1711984064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+wM/5Eml0jJjXbueM68ZzKT44rHBgaiZRCLtSh/Yuo=;
        b=HyKVrXbAJgia2qR6aWAERV8S7eWY4GME5+3qgZENTj1xEl3lwVxlHgU9KSmRBaQZ52
         vBOIk2P5KeSd2OBBaTXoHv0wleHCrpVsVdtO3ofFpsLpVMLOwlQvG1qs8G9gK0utvyqn
         L1y788i6AU2L92D68kTLsutNK8VTHjjgp1qtcchMHttp6DVVYy64K4pBGttr9wwV6QtQ
         unJXEVk54HBM27b9ZCgeRDXYeZquH0s/Di527OTl8evAWXOjOp+ZZVkoPSnWHvxnFELp
         NYMMlqnsZnFGK9fGdDW76LxuFTFsRmvKu2md7U3UFPNdEPrubSCPY2szuFkVwsbdSgCE
         MP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711379264; x=1711984064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+wM/5Eml0jJjXbueM68ZzKT44rHBgaiZRCLtSh/Yuo=;
        b=LQeqSP0gplnTHhWinzKFmXT3vJGexEPn7X5njjvPkcjgSWR6sBWVh+H3/WAPYNr9ql
         jxtKGo2LKrXRo3lIpJXzGaKSuL+bkqcB/t8ereZX1jPluiWkyA3nQG0AyeGcFcC/PvyO
         CLa6CSTCzsxA+xXn7DmsiVaCRB3A5h+Ixjqg46F+YFl4x+CmTUFvfdjXlJ4rzLnLquCU
         iZtoIRIqFAfxlK7C8pTAQ0IRHUam/0h94yySMGGlbx3jxtCPKCBc0CSsXtSo+4cjxIb7
         Xs5/iyoB43/rqUGTCBiAAIbpev9wmtZAOP7TRRZDMdMYdeo6tZR/rA0znUv0w1PRqYaf
         Qn3A==
X-Forwarded-Encrypted: i=1; AJvYcCWpoiWfAKUNwvXtc6qrDVdPL8IrIYk2HTcDX9v4Ma6PWlQJ2KQTkB432TdFpsgdnbTjOur4mUnQpePHf4PEjkpqWtYCvK7+S171MDdG
X-Gm-Message-State: AOJu0YyXKUNLngejX4wvokATI/yJNAkRI1tmyrPN5LMlf3qWSTp3iES6
	yXxhaDrQRHZVduyUfd4FDX7Q8P9W2HNedikz2TT0qozEYhVlifkfwoph9wHjctMlBEEmjBgpNAX
	5vx/PUL10cZxNkFO6KbBKiy2MBw+jFFz23LSVRdG/45cEBZ3m
X-Google-Smtp-Source: AGHT+IF/D4oCFYlUK7HSZAQYxwcFlwbDpWsdJDLKuSRu3iGVi4RXC64dlOM7/dvQhbaOtDEjTxQoWt3Cd5SxBlG6+sA=
X-Received: by 2002:a2e:2a82:0:b0:2d4:5d44:fe1d with SMTP id
 q124-20020a2e2a82000000b002d45d44fe1dmr4553062ljq.52.1711379264142; Mon, 25
 Mar 2024 08:07:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322132619.6389-1-wsa+renesas@sang-engineering.com> <20240322132619.6389-16-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240322132619.6389-16-wsa+renesas@sang-engineering.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 25 Mar 2024 16:07:33 +0100
Message-ID: <CAMRc=Mf8xywzkF0cMHRC_AJeEozUhT31-gNpdT=FSmAZ+JQg8w@mail.gmail.com>
Subject: Re: [PATCH 15/64] i2c: davinci: reword according to newest specification
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 2:26=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Match the wording of this driver wrt. the newest I2C v7, SMBus 3.2, I3C
> specifications and replace "master/slave" with more appropriate terms.
> They are also more specific because we distinguish now between a remote
> entity ("client") and a local one ("target").
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

