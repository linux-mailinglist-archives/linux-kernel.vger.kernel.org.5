Return-Path: <linux-kernel+bounces-61710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 581C085159F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E08DEB2492B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C433F9CF;
	Mon, 12 Feb 2024 13:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTMCKoR/"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B831E3F8F0
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745058; cv=none; b=j9MQqTWRu7GtMRrYBZ1Mg7/7NiIzupmalauU3j/S1tTXpXqYOh1cQMMU0MmoP9zqgpqkclBYEbq4jUWqwaRhpj9ofE3Elgc0OD4LZi8N3OshijUCqEVb2HxGJnwX2Ridl77HZPB+vE+PE8vcY5vGd6xP/2e5pJtkfwQ0Q3s3G70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745058; c=relaxed/simple;
	bh=snujTeGHnR3dPf9//rrzM9yApNcJDQHqczJLK6AWKn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQ5NLmroTTBVJpIWIBKWmxVnfrJ9PB2Sx6nsDQ3fJdsWWYV/nbH/zATwiENaZSvf8PuDBH7PSZraeYHo5MTJxEW5HziAUV1EYT8BYb9aC96hwHzUlQbYolq3uCAL2Ni/9dYAYb4NDe5Bqkl+4qJa0/8OiIVG0MUkJLGqJudnSLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTMCKoR/; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc742543119so2548806276.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707745055; x=1708349855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snujTeGHnR3dPf9//rrzM9yApNcJDQHqczJLK6AWKn0=;
        b=jTMCKoR/HgYNThBCCW0vooMDSyehZLGxoQnni0OcGCu7ca6m/keU9KZhU1h9a1wQAM
         SduHdAW8RAZORFef1LJ+mbyVFe1lxVGq8LzeBHXTSTNpw/E91e7sfXI8bKhUVq/D8vbM
         zKE++UL2IZsM5YV4YSsPBNoUIPCQwupdGQnlznTF24rH5kJr1/WXUXLS4qiwkRRuOd9E
         6mGGeFm6xQoLvPklT+Vk43Jac2JNqTEjC8X+PSQEdQ7RExhnAIeIQMqkZ0Z5xYQ+MFdJ
         M+J25qVrPMpsAJYnriiI45S1LpinYkosS95u8+h3puplcxmzZxEONb23oYsF1GC/7uce
         LVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707745055; x=1708349855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snujTeGHnR3dPf9//rrzM9yApNcJDQHqczJLK6AWKn0=;
        b=qV7Mfg/KAYVOQcn1NetdwnawvNx1JWmzqMkL3Iw8wO5fX5whGB8608v5RiCGPK040U
         +jIwymDnvPZ1gK2m+GCi1yA8hYl7W+/yT2N0/YnfHeuQzRvTzz2ktpty+7443Bywmdp3
         YY1qT2Hzx+9QxVS8LA8O6POB8cThoajYbCZ+xDoZkExdfxp2PcBHsLdK2ULb1tsWkiNC
         MqJOSzY1u8CqcXbk62bfStv4/0JVbcaksKaiYQ0gJfBID1DlPBYkjRuaU5YBO1TqZq8E
         vwdv8lPhOzpNOpod01cYQVLMaBslqWu/pp5Noy3YpRRCN9/E46Z5eR10gGAccFZvkwqU
         Zrtg==
X-Gm-Message-State: AOJu0YwwMs7mgN9NkQGfhoDotMNHsMoVsg+gshG34kIZM9xI26piga2w
	n0MZajNAq71yKHarnkWEKtzpRQKneXXKN/bpiU/xg/Zc2eVZ0/ekS4pygAgQ3gTbq2qBS8j/miW
	qMugrfyDVqj7FlnSK3Mzz4D4RNRg=
X-Google-Smtp-Source: AGHT+IFOu43f96+QadK+r9cBK+ff1oKp4KjmY4DCjk2xEuyJBapWpCL4StASjTys0XLwP4NZ7wFhpXFByv35Kq10kIM=
X-Received: by 2002:a25:6b4c:0:b0:dc2:279f:f7e with SMTP id
 o12-20020a256b4c000000b00dc2279f0f7emr3359573ybm.10.1707745055682; Mon, 12
 Feb 2024 05:37:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212113653.2625776-1-andriy.shevchenko@linux.intel.com> <ZcoSqHIknAvalzf4@smile.fi.intel.com>
In-Reply-To: <ZcoSqHIknAvalzf4@smile.fi.intel.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 12 Feb 2024 14:37:24 +0100
Message-ID: <CANiq72kmGVwFo6hakdcFN6Zu9yDg+e+41W4HHEj1q-S_TV079Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] auxdisplay: Take over maintainership, but in Odd
 Fixes mode
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 1:44=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Okay, Geert agreed to be a designated reviewer for this and I think I may
> establish a separate kernel tree on git.kernel.org. I'll send an updated
> version of this.

Yeah, of course. We also need to move it in `linux-next`, so I will
let Stephen know when you have it set it up.

Thanks again!

Cheers,
Miguel

