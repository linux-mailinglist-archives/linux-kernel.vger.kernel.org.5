Return-Path: <linux-kernel+bounces-89056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EF486EA0B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB17288DBE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685DB3BB4C;
	Fri,  1 Mar 2024 20:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q+jbGsF2"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B09A3BB25
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 20:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709323479; cv=none; b=i1473fbnhpMUO5d2ET2jIpFVWCofXkxmrOtgZfTEm4Mso/Fs9d70ZrZD3s7jTY3UhJ/vtPjtQvL1NuS/xizGBU4I3710850Ugn+AIhERx1F+tQCCH2gF1fYaE004NECRjILLK0I277Lv4j4fs+IQIQ4dEZplIsRdbeX1VJvcBQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709323479; c=relaxed/simple;
	bh=R5oeZu3MZmiPdNeeqv6OukFHlLZcN450keDyMqO0GUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=joUDGXe3/6LDqfiIWHy+7hEU6gubYAgJHiStmrFo1X7fiJDzVtd2Otor2/fknAMWBeJEZLkzFu1L2D7ECpKsCcrZ/N3epUkJ18Kfq/8wiDLOJeJRrsxSSeYVj/uWPpsYvttStKiSDnyhi4bh/YZX7eQiCp9aV2xxiSWYfMDAl60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q+jbGsF2; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-608e0b87594so26136967b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 12:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709323476; x=1709928276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5oeZu3MZmiPdNeeqv6OukFHlLZcN450keDyMqO0GUE=;
        b=q+jbGsF2wPZ/JXhAMrFupjx4zeMCBrYX0gGhEnp47NcOAJHs7Lfz7xbfWt4+Mi/1QW
         kV5YwDpagkG9an0ZCVjv9KwgIu9dt3lSF7E/JRwpAwG4ja4g2WgtRBzKj3UUrR2kvsrr
         YujdrgJ7lnRj+76sXJ9TgqZPsgxbl1oH0VYqCh6/+cj8GdkF9M0vRvKL3hIkpXzFYLgS
         tCKjCJimqLla7UbybJhiND1UHnhZcERUXakcQ0widCo4DvWFVY7LwPA0Hzn+ATnJtldV
         BXnSc5hSMmcTxf1IN8bYNrYvc2SGBQshLDsv+aGubwoWGWfpm4XhK87twh8G1DBgqM9M
         Vu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709323476; x=1709928276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5oeZu3MZmiPdNeeqv6OukFHlLZcN450keDyMqO0GUE=;
        b=knH1eggfA5oCrV86qhBvizCMyS9oGuv6rP313q+XMfLIuT5hRk9EjZnoHtqvBRJ+WY
         gIpGw/Uc6T/9ylPBwDett3caD6ECVt2U+gOi0fPRZsyOYlj8815G4FN1jUUvsFWO6cF7
         SpNeH03w9lq7siO3U960wpamv3Un2/fsmwOOOkZBOZfGATN0hOZ73FWF8E5gghNeeTR+
         Fda5W/wGJDYB5E7Jov2B+AkcxcsUEhaogyU5S5do3+D7S2peci/yJYFbN5QvkyQfDbKU
         5SKQW2zyz3V5gVccG+xbpM9XS/H654/C07Ynn3HGVp+wCzQa3VFb7QSyWtezn+U0rOrJ
         HHBw==
X-Forwarded-Encrypted: i=1; AJvYcCVHcdYiFGm8776henkTwyvdEXAUV6SRnGf6MzK3EOYY/62GC5t63o9y+DdgT3Q1ihBS0NClxdo0ArHNGbAO3gp1Pa9rt0ym1s7Rwc08
X-Gm-Message-State: AOJu0YyhC92bxjKotMHgbJvGFmVFMeuDDbgSKVfagaEy/Gpepxu45R+s
	xZkILZOM4rRAT7EfZTK3RkMhUrWCdQwL5mft47yQruBy4pyJLxfZ0N0iLDQAeaT6r76pQqKBonP
	sp6OPtPQDJoffWCca3AaGXGvKLeTeVo5Y2aPhhA==
X-Google-Smtp-Source: AGHT+IEERwKVobzxEtEm7cJ4e3nbLqrW6YJjiZfXhLITgygWG31PEVgI4ANxEKFA5swXszNxIZzpyt7dNzDPzhJ+Oqs=
X-Received: by 2002:a25:83c1:0:b0:dcf:2cfe:c82e with SMTP id
 v1-20020a2583c1000000b00dcf2cfec82emr2513188ybm.55.1709323476391; Fri, 01 Mar
 2024 12:04:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301-class_cleanup-power-v1-1-97e0b7bf9c94@marliere.net>
In-Reply-To: <20240301-class_cleanup-power-v1-1-97e0b7bf9c94@marliere.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 1 Mar 2024 21:04:25 +0100
Message-ID: <CACRpkdbVUUTh+VA0Tjp6Y=L5nx-p6YKuJ5XjWYTm_Q_Kfmz9ig@mail.gmail.com>
Subject: Re: [PATCH] power: supply: core: make power_supply_class constant
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 6:46=E2=80=AFPM Ricardo B. Marliere <ricardo@marlier=
e.net> wrote:

> Since commit 43a7206b0963 ("driver core: class: make class_register() tak=
e
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the power_supply_class structure to be declared at build
> time placing it into read-only memory, instead of having to be dynamicall=
y
> allocated at boot time.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Looks good!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

