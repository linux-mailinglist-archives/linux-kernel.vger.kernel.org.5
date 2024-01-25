Return-Path: <linux-kernel+bounces-38189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B77B83BC34
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F67286F90
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E231B973;
	Thu, 25 Jan 2024 08:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jHovY/vh"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340881B94B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706172213; cv=none; b=spcayjOfDGpR5MNXKyDEX7r+cJ+0c8nlYXF+dWh11AKHbK6+6l9xuSzG8T67x5m2dKY26cGOf0a2EWcx8LcLy8fEB17x0H9jDi6T//relnzKJlpHP7FU/2gwcnAkLLiRGswomNfK000pE3Ngoz8Pz0KyTiDEqXv0tQyr4DMCyCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706172213; c=relaxed/simple;
	bh=R6xBsFIzxs3ZX3VwdwbYtSZ2G1w2NKp7zYhPX2+phdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LhypIFhRdmw2dXNcbPMQwTAgBqKOhzPmadHKtNWZyS316y7ZM6Myy+phQyForLMpZd1fbGG/VPJLcgH1a0Des+wLeDaK9PDlFvqrKx0lAedv3ATamDwbo4Mv/Fe0hDXCEeY1YuSNciGYewxgsUYgTRc0KCss619ba5sDVdDFkas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jHovY/vh; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7d2e1832d4dso1479063241.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 00:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706172211; x=1706777011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6xBsFIzxs3ZX3VwdwbYtSZ2G1w2NKp7zYhPX2+phdM=;
        b=jHovY/vh27gGi83bwSC1nxezO1U38Th7Yr+oeesczc0u1vRIrqI56PvBSDDOQJapq1
         KJKQcS0JofaOnpRCVUwGoGZY1038ln9dpjyyGi5BOczjhnWE5/i0diSAyGIOtf0u4Sew
         aPT6WgX64VFgu/BRzSseqDJ9BXBIwQJs5z9hJqAb2eFXJdkmN97e5h6eQfoGp/85LZw5
         7qsa3AF0wujZqQgk5DHUnX0oXWfins7l/7Q+s4Ol8+mnfeXCXzfB+gobdYuEcOxjsaiI
         VA9mfO+3nqvY7KIWiAhsnD0Nz5IgZYLmR93oNqTfagEEyJpCwPdmx/9qYWl0ecAGYjoi
         UaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706172211; x=1706777011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6xBsFIzxs3ZX3VwdwbYtSZ2G1w2NKp7zYhPX2+phdM=;
        b=lW/WJxPkN+/VFrNHHFdA/1pRYqzGW2dnw6ur+Z7kY9e1b/bNAW9VWcqgeKxMD3ekpW
         /IbdBJeQgL/9fLmJyqBYRfWklrvE24GNz34g+Weug4s+74JVu+zmSavkf+gv4rjJPxr3
         V1JrIsy3FJFKWdrzglMZkdDIVZB8G/otpgWPuC8WATVPa8kNJkQkMchAr0NHM2RYFGfO
         fxNt27WCogT2CJOgkF/a4920t3BSMVbRs6pd2R3Wb2Eg8u+v+ZBRIc5nQ/sy58bTqj5L
         eYAlVOHXzD+SmJKdCNui5u/M7JNvzKJAPxo/sC8HveCyrzobkvmjbcvZ6QFBZ1SJBeGG
         jO4w==
X-Gm-Message-State: AOJu0YwXdGSbwJR214X3WtPuztRtdP03NSRmjmpq4JvNKHtgcW/PeHDo
	SPZ1zWcNGUZegWHxEh8HsKfXanJftCAonm10+3npq59WosXhQSfyX60Iu+dZY7eQfgykRg8Wk8U
	jpmhilX2L8wwRnxxqkDzwa3Zpt+W8uruhyvzDbA==
X-Google-Smtp-Source: AGHT+IEbxXAzBMt9uknzb02Bu18zwPl1FJlUa5sv2Pkf2R84ZO0GUaj5kptWwmB77ttmAnfgr6+xWwyt6cR6zJEEknc=
X-Received: by 2002:a1f:ee4b:0:b0:4bd:7bf5:934c with SMTP id
 m72-20020a1fee4b000000b004bd7bf5934cmr177165vkh.4.1706172211020; Thu, 25 Jan
 2024 00:43:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123133828.141222-1-warthog618@gmail.com>
In-Reply-To: <20240123133828.141222-1-warthog618@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 25 Jan 2024 09:43:20 +0100
Message-ID: <CAMRc=McEwWQuJMb+25Yo23yXbhTsCDN4kMT=K0Lwg8xyJTrHpw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: gpio: describe uAPI behaviour when
 hardware doesn't support requested config
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-doc@vger.kernel.org, linus.walleij@linaro.org, andy@kernel.org, 
	corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 2:39=E2=80=AFPM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> The existing uAPI documentation does not adequately describe how the kern=
el
> handles the case where the underlying hardware or driver does not support
> the requested configuration.
>
> Add a Configuration Support section describing that behaviour to both the
> v1 and v2 documentation, and better document the errors returned where th=
e
> requested configuration cannot be supported.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> ---

I applied it but shortened the commit title a bit.

Bart

