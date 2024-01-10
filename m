Return-Path: <linux-kernel+bounces-22373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4009C829CCF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612AC28229E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC394BA80;
	Wed, 10 Jan 2024 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lDCj+0wS"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B274B5AF
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 14:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5e734d6cbe4so34745937b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 06:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704898248; x=1705503048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hohz0/UiuBsLbwxSL14WKEDa8ZCk0Pl6T+VpxtIF/ck=;
        b=lDCj+0wSveyoYqkjPrx4su5zcxCFdeClBRv7+uoZrxkJ7dQB3dIW1hy/Zmauvi3Ipo
         Xns5U/VMQwIZg+Qh2Z5D2Qvo/bL+vZYtXB3XTsuaQCrdZBVdK2ScQ391qOYuiCY8l4ha
         8TzB9FJ/cjbmfS52rW3anLoKwgXL5XEfSOg3+t5NOmFDy1W6x8Sxk9E9QlCW2XIJdfRU
         VXghNhypihBGcowI+GUSJtXqKFLZc7B40Bc4BclVNCoO+C8yXzNuP+Dc/bhkiMThFEaf
         m+r+D1PdQJNMP1D6vZ1fyyHFd85aiyKxkImIf13WzAjd7ExrFB6/qohti94KWZQrhXzT
         NQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704898248; x=1705503048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hohz0/UiuBsLbwxSL14WKEDa8ZCk0Pl6T+VpxtIF/ck=;
        b=Y5P8Vwozqsk3FoWUV/xMaL6bliz9XcAXnnnzecE7COgET9IBEM5j3YvjeQ5FqU9S19
         kGyC9N6+AA2BAiIi5RRUkk7+ZUMqbbn1wPKEP3wbZDYlBMcaDL3ESGhIH8STUn/hO0kL
         iCfpcVYvuOTaxXfNOHKWqm89W3AMho7hL7HHhRpizrayg6KBOcGWUZg92IOKGRbJBxXw
         4GTgFfjxKrANhgiFksZ0XQVoFMZNpUG2wx3bzuwBThKowIXy11gQMLNSSLRQCIsOCBY1
         iFdIDvUyn007eA/29px8DI2fLFHVB9rIOnju/b9JwExjg+EW6P1z58gsXZs37cJTf7+5
         kpvw==
X-Gm-Message-State: AOJu0YxKzhhi1hzB2DyLsWSoHha0nxydKIlr2YM2mj1weA+FvtciCYWF
	+xqak5OWut8nbklOFKUf2MRZEcZzomN4nE8CjJr+2vERj65u/A==
X-Google-Smtp-Source: AGHT+IEt4zjMzgfN9keS6JIQ1KmVhoHg1tBbzdFEc3JIEhFb2uX0TYy6clLoa7MGzXYbgSkqzEPm58QxxheRnv5qpgE=
X-Received: by 2002:a81:8843:0:b0:5ee:6923:233c with SMTP id
 y64-20020a818843000000b005ee6923233cmr1311954ywf.10.1704898248220; Wed, 10
 Jan 2024 06:50:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109135952.77458-1-warthog618@gmail.com> <20240109135952.77458-2-warthog618@gmail.com>
 <CA+kSVo_347gS+w_7ZXFDi9qDtT1aw15qoWRJZAVSkfbHShz7kQ@mail.gmail.com>
 <20240110130158.GA28045@rigel> <CACRpkdY9yXknHVQMq09Ep_y_Hk6iOkNqDS8icAKFW+fLDdwi-Q@mail.gmail.com>
 <20240110143428.GA47193@rigel>
In-Reply-To: <20240110143428.GA47193@rigel>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 10 Jan 2024 15:50:36 +0100
Message-ID: <CACRpkdYSnQ9=RU+TXfzTzwRXorPOBaD8Z3YR5H=jYTFK_6PKJw@mail.gmail.com>
Subject: Re: [PATCH 1/7] Documentation: gpio: add chardev userspace API documentation
To: Kent Gibson <warthog618@gmail.com>
Cc: Phil Howard <phil@gadgetoid.com>, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org, brgl@bgdev.pl, 
	andy@kernel.org, corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 3:34=E2=80=AFPM Kent Gibson <warthog618@gmail.com> =
wrote:
> On Wed, Jan 10, 2024 at 03:27:50PM +0100, Linus Walleij wrote:

> > I like the current wording.
>
> Can you clarify which current wording?
> Are you ok with the proposed chardev wording, or should I be more
> closely following the sysfs?

I think what you have in the current patch looks great.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

