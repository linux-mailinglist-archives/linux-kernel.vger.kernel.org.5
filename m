Return-Path: <linux-kernel+bounces-131303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B83EE8985E8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7CE61C22CAC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268478286B;
	Thu,  4 Apr 2024 11:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JyNHx/po"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A3882860
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712229607; cv=none; b=baQJH3pXXCHI8iO7miIAO+lY/JTws+zbuloD35b5LdXmiO9HxD2RYxEwxyXSWenNQM59sRA9B7mK4V+L2xEX18cT5r7xGXyn7a4Yhb+wZdy+40qyqjw3H8z9Uf2BP3mjLMx0/WXR20YuDYCkrc8Y7vhmW5xeyT9LRnPmfwApjU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712229607; c=relaxed/simple;
	bh=SgFyjVI7skGqGufmNsJfs5VYJ8IwI+CIbwdMTiKmSD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qESFkKLsxtWbzMQo9C06o1ZBVD0zRjdHBbCpfa1nR9FwvL5m4lm8NmYYaZpVlfvSd1syEz7WJvcYkNDYlLd52PkJ2z+KKNNlVT3+S2mg2iRwE1PW2KoEX75jB2/fgu950fiOrL9qLxf4BbszOCG/DVmYEtVZVW0Uh6ERq1u/rzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JyNHx/po; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dcbd1d4904dso879402276.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 04:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712229605; x=1712834405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgFyjVI7skGqGufmNsJfs5VYJ8IwI+CIbwdMTiKmSD0=;
        b=JyNHx/poqfLlD4cjbCsFo7O36agnBvBbnIsGWZlVKHUjS/9wxaqWzzWmnmmn48V2Tl
         kB0iU2xRNnDRvayLamHJiKTNArAadsiLxQmY5JyKAK3YTHa95uXs0iOu+ioB+dywNolg
         8DwtVtCCPtpQ+H1l1W9gRwl9Zkx0CSQh1JVGq0yQ2dTwulmzfB/ljRaGE3UikZ4wbiaF
         iT6EZpQSTt2xKs71WkoVPnM64kROP5p+Sx7FLK7l7lKe6R0Bo2Ihf5n08eX4hYzx9vuz
         a+Hoky2W3pwcyap2isF20I6AnMpkPcOoNVdEdMu5VA0FYGPYv9wk1akhvmX9AWNs09wN
         grsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712229605; x=1712834405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SgFyjVI7skGqGufmNsJfs5VYJ8IwI+CIbwdMTiKmSD0=;
        b=KgTbgvWcHM0ycoo64tWZ2KTgSrPfKymINonIDSy6B+iE9yjxyb9znwWdMRZB7nW6vt
         SNYqZpEj+F8vhV1dSKnhU+qovv+/+ao+Rz60BVIYBsx1TvvhOegOqQsl+kx9Ggx+fUQD
         UxpLxugR3keeEkneqtOS9PcI0WeIVZS3Kl/5NUUQpAOhHoa2L1DX8EKZRFGrBLtaEMx3
         BmjlcwoPpwE/b3aFcpNP7uZr1dYsL0igx7ul0umFsmcP9KiS54XqtjrD3yF6VffAnWd9
         /njYgluX39qWTE47GqCl+tUrcELGB/coXwDF5b85MnoT0D/etO9+VesZ/U4+49mafWhS
         BNjw==
X-Forwarded-Encrypted: i=1; AJvYcCUiMwf1Ve5bOo2MFagjVZgVu5tp/bqV0gX5dyNXMbsDNPsJCLFU5iQwuoPjTNbKsgbytwMDbAU9SlnfFakCvCDnX05sSYvwAYphxqBQ
X-Gm-Message-State: AOJu0Yya+3K9qzdqQWkjxXkJ4kFcnifaqUaAN4Odlmd6P7D/CPxckLBM
	f82GF41c4irwrJ7MkJZdMNC1Conu5pQhWwJP/AabSkOVqQXYX9lsSPvMOGYQ+742udAvwVennQM
	tKN6AWYQr9ZDL+yhJ6ZQz7cRr6kDYz871SpcW8HzZSOFE+1d4
X-Google-Smtp-Source: AGHT+IGVjPLP5XGVqd8J5W4eYI/XCEWM3gv+qj66WPaPpCXMykCACqcRsxZcNsZfydLYjM8mo3rNCXIZdkK3WjrCAZQ=
X-Received: by 2002:a5b:bce:0:b0:dc6:bd4c:b119 with SMTP id
 c14-20020a5b0bce000000b00dc6bd4cb119mr2010810ybr.55.1712229604946; Thu, 04
 Apr 2024 04:20:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329105634.712457-1-andy.shevchenko@gmail.com> <20240329105634.712457-12-andy.shevchenko@gmail.com>
In-Reply-To: <20240329105634.712457-12-andy.shevchenko@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 4 Apr 2024 13:19:54 +0200
Message-ID: <CACRpkdagjPLMUjYa0z1sFGVJJ4+0Tp9Kvf6umU2JWHeOB+fbPw@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] pinctrl: aw9523: Remove redundant dependency to OF
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 11:56=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> Driver does not dependent on OF, remove it.
> While here, add missing mod_devicetable.h.
>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Oh the kbuild complains about this one because the driver uses some
DT-only helpers. How typical. I kept patches 1-10 and dropped this
one.

Yours,
Linus Walleij

