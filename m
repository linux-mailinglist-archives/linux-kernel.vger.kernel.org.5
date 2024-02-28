Return-Path: <linux-kernel+bounces-85710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E01E86B9B4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F9EA1C24E19
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCD213AF2;
	Wed, 28 Feb 2024 21:14:50 +0000 (UTC)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72CD86241;
	Wed, 28 Feb 2024 21:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709154890; cv=none; b=lCmNbR4W3qwIdm0NfxH363zHis8xuoTiGP7j1k+Q8qJ3FZdX2FxmNCtThL7paAPBQVjWzKOYTvnHnIszn7anYLb3M86RR4q9jm60HOIDHtegw2Qoe9/OmiQrbYrbEFbljat9vUUtHyZfAAtz1Y0ASX/gFOJM756a0793SMVPwF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709154890; c=relaxed/simple;
	bh=vga5pA+ojUatokeTJQVGmvG5MkhEI6W2dbJk1EB3qrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sxYyLQePr0VpWq9q+N8mEzn5D3PuHAZJAr/qQQiMeAdhJgY4WTT/LOA+eh6rVvqHBjzQsdWt7QrQu9BAs0h1+Exe165c9/iDKHZ9lbQVu0H3k6UiJT+fDpCzJhBpWgZGyiUtj+b908TXqqwM8uMz94wNGm5d/qdEGaeYIFAHeIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e2b466d213so38915a34.0;
        Wed, 28 Feb 2024 13:14:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709154888; x=1709759688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9hD0YbFqBXT/nXqtV3fYDeNO40gmiO0A4+0rNHvkIk=;
        b=LAnkfUFSGPyR3aqU8uuC+Ig2vg6IVv8WgofgMh6a3JasuoM//1CUthoRTPVljKXWCC
         v66FbGzP9To6h/7HHOJgqopDoiHZ1N6UzkHl8dWGp+fTSElNB3iTR/LSw57Cc1+tCHH8
         PKEvXtAU0tKsri+X6+NtVYMrSeSnBlcT/CIm7n9Q592BK9BBLsqqd/mT9E8nLcJli/NA
         tRuCw2xzs25ueIsGRV5UvV6kexeYz02wBFDcz3G1cS2qM7iOKMa/rUKDgb/DIGo5pZ4p
         swbUAID13R6c8HmG3s6IezaVmCIP46niOFF2dWn0PAf1LTdgOb0KOSWhPDgiJcNfO5gT
         C4fg==
X-Forwarded-Encrypted: i=1; AJvYcCXVfGiR3A93Yxcp3lN3DSrI915qpcyHgLMQ/apPGHNqTuzkx/LDEL3tPTL/eC7A4YLpomUAbkZrfX79vvNEyAEhZZs+HvrKq0IBLZ9HOBfC+cHjscI+ba/C0vzZzsCQCChU8Cf7fdrZWw==
X-Gm-Message-State: AOJu0YxANWcdDB5ThaW8kNNrSINfcJ+nGMcbsCwtAROtrjhWharwnWFX
	SZAd8GBqzv5nhW864vmz0Vx68J00dcFX7s6YyfH0H7QYSE1fIqnofD1sBnS4HAsPTPZtDHNv3W3
	XpRkmKHJPg5LC0Dhh22BqLbOqAEsHZkdx
X-Google-Smtp-Source: AGHT+IFR7qFdUqz48+gGHmdyqSr7YuDPzeNmv6VTZEBxCB9UizCjvZI5i60mgaTaHiqy7YBJ7WfwSn306BNwE3vBPUA=
X-Received: by 2002:a4a:620a:0:b0:5a0:6de5:a880 with SMTP id
 x10-20020a4a620a000000b005a06de5a880mr347558ooc.0.1709154887860; Wed, 28 Feb
 2024 13:14:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223155731.858412-1-andriy.shevchenko@linux.intel.com> <20240223155731.858412-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240223155731.858412-3-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 28 Feb 2024 22:14:36 +0100
Message-ID: <CAJZ5v0gmJYZ==O_xn7v+=-9dr9n+GvV2TmcjWVsRvXc4F2UcYQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] driver core: Move fw_devlink stuff to where it belongs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 4:57=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> A few APIs that belong specifically to the fw_devlink APIs

It would be better to say which functions specifically you mean here.

> - are exposed to others without need

This is not particularly precise.  I guess you mean that they could be
static and are not, which is fair enough, but why not just say that?

> - prevents device property code to be cleaned up in the future

This is completely unclear to me.

> Resolve this mess by moving fw_devlink code to where it belongs
> and hide from others.

This could be more precise.

Also I think that the patch is not expected to introduce functional
changes, which could be mentioned here.

