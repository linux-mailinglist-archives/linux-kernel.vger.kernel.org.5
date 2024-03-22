Return-Path: <linux-kernel+bounces-111739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 837C0887026
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4F2C1C22783
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790DB56754;
	Fri, 22 Mar 2024 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgPluiGB"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3937154744;
	Fri, 22 Mar 2024 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123190; cv=none; b=KHi+UzxWCyPD5V/ki69+v1CMWcPsLeQi/6ugCG0fbmJcg+9Izi7JwsMV6jTBqI4oja7oY7JA74CfSHDECM96q6qdIPXHxNUJLOmtWuhD0CirHKQJDZMx8lGP8S//PevUSA5ot/MgJcogbs1gRTEmlQK/TL6zh3ACdLvuhmj6ens=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123190; c=relaxed/simple;
	bh=N9NyQeoZYI6Mc7PdTUg2nHN+SIulmxpQHe50iCc+N9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ReQgmKQcmm5GgChNXz2IGeeRgBwizJKEFZr3nEs7aBhu+Jhw2qeJ9IF8VPGIdtLy0YQPrJUsNAE+6CGMtbOd+G0lrJL9VQQDgP5Bnsq12SFDn/0TvmMMDlI/2H51jHfoQJUHYZtd47ce8ZtUFfdp8d3qrrgMCAbvbhUHOkqvzS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgPluiGB; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a46d0a8399aso566113166b.1;
        Fri, 22 Mar 2024 08:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711123187; x=1711727987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9NyQeoZYI6Mc7PdTUg2nHN+SIulmxpQHe50iCc+N9w=;
        b=LgPluiGBJtQCMWGPWPxW1ZoG+FnQnsdJnjtXB5VpcLKkvdiEE/S2bHPV0rMrqOY7Oa
         N+3o7Ff0Klxb6KTiYyTBp2Ev8r9k+cXDdVPBo09ZqxNd9Bsd4QByjMibebqPUZcmL8Nh
         FDLYOTu5KubTHxbXzdNuyPinXFyOVeBU+cg+zEfaZNeNmCf7rEC/n73QlUx8UPCRHdC9
         IO59Y9Je+h1TtnVshzm2NMbo7qI7426GgnkWkeHcruR09KcKPvGWnfxiiMgFkgCAOiBl
         XjchrTkh5dFdJVlOBhHdbDvlpTsBoZR9/Tcd0MLFdYlK2mukLGEbysqxopJ+GaL3Df63
         aAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711123187; x=1711727987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9NyQeoZYI6Mc7PdTUg2nHN+SIulmxpQHe50iCc+N9w=;
        b=KV3zYBNfL9U2cYxxjlAQtvvYf/DOZZ99yjzmxmEQFsQRy74NMderkw7o3QYkovzjlo
         OpvqFLUvyEG3SB3aCfbyTbVlYb4YbXaX3HnI+0WlCkuSgAx96YfmJbzLqaI4V102EukJ
         zziQ98feCAAXWuOwkEcyEp0nR2B8+YMzEvxUgw0grEZuk2rBhmxmffMIFAS9qL/8VFuI
         b0bfY8COgD9UTfkxvUiU1+R3qRFTUj+cDfAgD0gj5Vy270hhzkvl9NG8HtdloN4rqUbY
         Ngg/6z4tMoaPdAA2/anXFqpzrKtnD9VJjArEnQoqUhITXpN+YoMwTGrishFD5rwY+qwW
         Thdw==
X-Forwarded-Encrypted: i=1; AJvYcCULiesM7yBGRhY4DuzpBn5iGfNiBs7o6x7fXrLk3slXNC3IxFo5IlEMBJ7ph4wu/mrxo0XwjpB2X3cNA5fEf6f+RU+Xvb+yK5FdhQ9GOcUlGEoECrY2LVmVywHDYobiOLpGEpaDGeqAag==
X-Gm-Message-State: AOJu0YxSczotr5zWqND0XHJcylzdZ+yVt1F2Qhrp9QYaF23chftBo9Rh
	xAsZUtLTQEBmsU9pefuotvqQ3U+F1VNgTZ9DZzcR5UPIttrACASP536/pD5JW4ajzBEMRT1V/1+
	hpKl8+8iQktJ87IW2rBpIynbla0Q=
X-Google-Smtp-Source: AGHT+IHmRGEicYM4+wa71dUBZ89CpP0EAP7GTpEBsjRp7A2HQjIetZqfWsCMm97JGXINzNjeOwrUpYwst+YV9bPiF7g=
X-Received: by 2002:a17:906:5790:b0:a47:322b:c94d with SMTP id
 k16-20020a170906579000b00a47322bc94dmr1795315ejq.6.1711123187198; Fri, 22 Mar
 2024 08:59:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322073725.3338266-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240322073725.3338266-1-peng.fan@oss.nxp.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 22 Mar 2024 17:59:10 +0200
Message-ID: <CAHp75Vds1dmjbaDa0D+Xxoyt_9CgHhoS2j0cR3EQdMp3sbwg5g@mail.gmail.com>
Subject: Re: [PATCH V3] gpiolib: use dev_err() when gpiod_configure_flags failed
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 9:29=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> When gpio-ranges property was missed to be added in the gpio node,
> using dev_err() to show an error message will helping to locate issues
> easier.

Bart, are you aware that this will add yet another possibility of
scary '(null)' in the error level, which is much likely visible to the
end users?

I propose to apply my fix first to avoid this happening.
20240320165930.1182653-1-andriy.shevchenko@linux.intel.com

--=20
With Best Regards,
Andy Shevchenko

