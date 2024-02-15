Return-Path: <linux-kernel+bounces-66592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA80C855EB8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74345283530
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F9469940;
	Thu, 15 Feb 2024 10:04:27 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1370664D3;
	Thu, 15 Feb 2024 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707991466; cv=none; b=DQxl4jdZXc/5Nf5bpfsf1QTRlCYCd0+aYb9ndUyYogP2QOGkxKcOhdF6JHnerAXMvyMQHdXPsJs2tifmm+ns0eB6VEXoo9a+v9fQB6T1mo9EOHYlNPszUDm0OYB3oFAXRMBRnDxogI11iZr+sgyQeogCBru/hwj6QjENzaJpLwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707991466; c=relaxed/simple;
	bh=umxe+HevEuQ8a3QralC64f4lRth1UKeoy8cHUkWWiMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ga/HuPL2ZtrC0/CsDBEWxDkHsUf26DFvxb5KXjTGL/c8tGejLZzXzWVQ68l8LqSkj6a+QuyPquAtxYooWX1eqrnf5tbDHGqVCcnucVYcTEs4XIZLWGqIzGN//bCARkPzA+1EVohFa7CuZwU2onMBgvNyQfQ5S7nlKaZhq1rPzzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5114fa38434so756079e87.0;
        Thu, 15 Feb 2024 02:04:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707991459; x=1708596259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OY+/yUhiKzD1HrOUuU2WuJMQtZdN4DZu18+CgK18Wc0=;
        b=X/9z/YXW0/ZDkAaackI8oUspWOddB5zS1MqEpbzh/86XNOOrW6sxV7X/808SXoXJi6
         CB4P3bjfsDcEdzgrTlqe5KwBYJTN99HeBb9pxH11oatHlpirmJNktjFoW6oxGeM2O7MU
         wq/zeKDxDe0QmnmedBeELPYkILWZccpqB9KwRj+RXJYXjvrRk2pSUJAvGsNAEs8rsiao
         FDDnqaWoJB9b/XE928IxdJYnC/yQUjZ9zGDQsAaK4uI9LBfD78Lpy9r4n/EZxmqWz6FK
         BC/NopKVQ0Y5PPypImJ9zBDps9DwZLW8+dyt9ukKquWkaerE0y347gySF9MUYoasWXJd
         rXKw==
X-Forwarded-Encrypted: i=1; AJvYcCXmD6f+d9Pr0xtY1fxSuk83yGYBsDd8YmipKkfY2wNl0k4/YFtyp+UrpKxHURxz7NetUi+IPtlzSMw1/RdlxQpSy1ls3DK1B9l4b+5g
X-Gm-Message-State: AOJu0YzlxdEd0C0RFQ4lkSjztfgWOBBNuZYvUH9ycOtA7slQXhNy8tMS
	eRwrjDVX1gl1aOZlZa3SjD+APq+SDDUZO1BSiSe1Bi347p4hWUV4YaN5mS9vNobuDw==
X-Google-Smtp-Source: AGHT+IGiccJxjxw06EFLXjgZ7qTWEd0R0AxBI8ORa5V6hblzf4DdRN7MMavJ9+S3HrcLlWVrwaV9OQ==
X-Received: by 2002:a05:6512:b95:b0:511:6fe4:efdd with SMTP id b21-20020a0565120b9500b005116fe4efddmr1402471lfv.5.1707991458766;
        Thu, 15 Feb 2024 02:04:18 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id x9-20020ac259c9000000b0051166fc7faesm178077lfn.75.2024.02.15.02.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 02:04:16 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-511a4a1c497so693528e87.3;
        Thu, 15 Feb 2024 02:04:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVsGM2ib+PW3tb4WmqIn7e3AalLT62ut2/B7HAGiYLnQy/Gx8FijwNsZGoDGKWq4yPcvROkdURiz8e/vcbF/cQCx6pRUgFsbRcS3Oxp
X-Received: by 2002:ac2:5936:0:b0:511:9bfb:feb with SMTP id
 v22-20020ac25936000000b005119bfb0febmr1118784lfi.57.1707991447492; Thu, 15
 Feb 2024 02:04:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com> <20240212170423.2860895-6-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240212170423.2860895-6-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Feb 2024 11:03:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUPqWPpveAG_4wX21BbYvcQG9SVJXL=ZWSEBfgKA_Ex=w@mail.gmail.com>
Message-ID: <CAMuHMdUPqWPpveAG_4wX21BbYvcQG9SVJXL=ZWSEBfgKA_Ex=w@mail.gmail.com>
Subject: Re: [PATCH v2 05/15] auxdisplay: linedisp: Add missing header(s)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robin van der Gracht <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 6:04=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Do not imply that some of the generic headers may be always included.
> Instead, include explicitly what we are direct user of.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

