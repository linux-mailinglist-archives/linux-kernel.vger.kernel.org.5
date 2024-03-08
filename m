Return-Path: <linux-kernel+bounces-96637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F97875F40
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D91D282913
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B70951C27;
	Fri,  8 Mar 2024 08:17:59 +0000 (UTC)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A01E2C85C;
	Fri,  8 Mar 2024 08:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709885879; cv=none; b=Z8s12nn/mAE8KuA6QPzVk4kSkkHLsp7waApoiawhBN9j31ClesN6zYRmBBYxvVxY+vzPRmkUa1rjr9q7s/WHsvFhLSHZMXs5TyI6t5ZpW9W9Ffpu7UonBphVzwE+hWXHzBRDNUkjkDrTlZ1dgNJOqB7FftAN0LeQtFaaIAeWMEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709885879; c=relaxed/simple;
	bh=T7iublfK+ZPIwjrzAGmCfYEsCsxVNUG2x0R+fC7UVD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=te6L1BkAyxdkCiUWtGA5DxDomnOPAvkHa/+NesdB9ysvUQ7jN8npWpUW7IWQHKNLXgkxFA7j0k+1GbOfPrnjDtEZJC2UVVKBZHLtVRGnlqxB69hGv65Ydp4tLAgeIYGWVii8MxqmeBI2Dmsvci10CoOFmEUm/Za5Ul7MT6wxe4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso1820558276.1;
        Fri, 08 Mar 2024 00:17:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709885875; x=1710490675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/IkhyCdM4H5HfWEwIeyhRcVXKn1ukDp4iKJkf4mNGA=;
        b=NDycTDIY1yCPGQNB5V28BJH0RbIXc0URL4POjUvNUYTkA6DrpTKBUssO/IfYSzbCn0
         cL4FX0bEjLhUaAu0LEnLMUIoMlTPrURf/4rkzfxT1KZ2XvLCbTbvLbMfNUK7eoK52eBz
         UOEKEsoHYZTcS35BYv+C757/8S/svJZ/oauEHdRKAanRN80hk+y4WhcN/HsS4U/yCOPk
         b30noLs4UMUKDrQnJwhSVA9xpU9g8dsX9RKkXEvM7u9h2IDu35GQf7MHwPw3sjIl01TD
         RScO6LqIBOaXpE5UcU1h3MPrfMsw8u8Km5HRlh5L+fTYFfSsz/OIsUCYjW7lvqPlh6zM
         daig==
X-Forwarded-Encrypted: i=1; AJvYcCVjGBRmFeLCePYSpq7Eydw9Z3eooM09YMIQTI3b054CETzD0rGzfytG64YnQtqytMsORvn6CvHp7HI+Yor5/u59pz63EVxUNbEikkm9D1IwUYWMCLaezGEprrX0M2VlqrVn517XWNQ4gvsQUmyRvxzLnHrvfxwYjTz1zN2o/8BgNZYTtoI=
X-Gm-Message-State: AOJu0YxEZrR4WV2Thi+ydNJ4Rva1v7dEjpQb2FSBaMkrDOsXbiEBfQyq
	VFka5vroDggTQa+wH+tSWtSNLb5pI4hQu4U1k7ubnWvFJ4I7Fo45tm79+mMys5U=
X-Google-Smtp-Source: AGHT+IEKMt7G5aS4iy5Q3WxlP8Jd0vN1xTpEQGoYNCKx8QP5UOLMrdqA13fuwwWLveT2QklPvnSeMA==
X-Received: by 2002:a25:cec6:0:b0:dc7:5a73:184e with SMTP id x189-20020a25cec6000000b00dc75a73184emr19778154ybe.14.1709885874790;
        Fri, 08 Mar 2024 00:17:54 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id l2-20020a5b0582000000b00dcd56356c80sm3712557ybp.47.2024.03.08.00.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 00:17:54 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-609408d4b31so18758987b3.0;
        Fri, 08 Mar 2024 00:17:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+3vr2D0j1sqMM0zQNtjRgefxX2TXZ8eAqoNNdun02qXsxN3vsslwuKLxRDRaxMIFGwp5Q4yGgpAKgS90ryI8kN/eKPIJNg/uM8REvLiAYI5NZ26/TE4zEHI7n1J53R1KnVSsN8locwOZU/zTgrL7NQVC6wpf0SwLz98ejEsm6CQYEQwU=
X-Received: by 2002:a81:48ce:0:b0:609:fe55:20a1 with SMTP id
 v197-20020a8148ce000000b00609fe5520a1mr2739599ywa.44.1709885873954; Fri, 08
 Mar 2024 00:17:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307195053.1320538-1-chris.packham@alliedtelesis.co.nz> <20240307195053.1320538-2-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20240307195053.1320538-2-chris.packham@alliedtelesis.co.nz>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 8 Mar 2024 09:17:41 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV_L0GpD1y4X7UqJQyZQ-L0rnSF0OVHaVA=ZsC1YhYphQ@mail.gmail.com>
Message-ID: <CAMuHMdV_L0GpD1y4X7UqJQyZQ-L0rnSF0OVHaVA=ZsC1YhYphQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] auxdisplay: Add 7-segment LED display driver
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: andy@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, andrew@lunn.ch, gregory.clement@bootlin.com, 
	sebastian.hesselbarth@gmail.com, lee@kernel.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 8:51=E2=80=AFPM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
> Add a driver for a 7-segment LED display. At the moment only one
> character is supported but it should be possible to expand this to
> support more characters and/or 14-segment displays in the future.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>
> Notes:
>     Changes in v6:
>     - Enforce maximum number of GPIOs
>     - Drop unnecessary 0 in initialiser

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

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

