Return-Path: <linux-kernel+bounces-116797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 295CF88A402
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94E311F3E601
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF80E12D741;
	Mon, 25 Mar 2024 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="lbC9nKs2"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D53F19F523
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361295; cv=none; b=RgtU7qsBM1iYF3sAi+OIMwZBL66ZQjnv4TJAHEzygfOl1yXdhq8GnDDMiywYG/w3nQEVH94dKKOvafsrRzhpDMau8y5ZSoeTe8yyndr1OCybKyGtR8TFI26fg7eePVdGvJHth0TTZ9YxOX6zTTc/T7lkvvVWx2kfVDw/R/bL2SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361295; c=relaxed/simple;
	bh=aj12qcWxwHOSiW5ip0+Q6r8HCwXXVgYZqcmXwDmc6a0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bty2qlAd574vgi3Z5EcOmTy76fKBQ8QA72PdRZxBJBi0M1/m5gB0bsefkwMlcb7TZcNeQgT7fO/lY0flcMEJcut2DSDDofwFcEWDT6kBypUZe/xWg9BqJvOG1Z57nqVDrzELfzghq26blxc1GsX5S9Yiz9VlOt3zafAEK8XMEkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=lbC9nKs2; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-513dc9d6938so5211919e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711361292; x=1711966092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aj12qcWxwHOSiW5ip0+Q6r8HCwXXVgYZqcmXwDmc6a0=;
        b=lbC9nKs27h5vbZyk2ozArc1COjHhnZCpbml9EUiMxVGntXUuzJ9C6moWhn8OTHWChN
         ESI55WR4+mqGvfC8kJTMIhP05wx+fuXXiWnJR+mKR2SswXCdXvvF1Ndkt2WQykUsGzlv
         wfneF1MZ3SbpRBriIKsDw9MLlI8obEquBNjTgUtCRN/6a1Y86R55GpRXhIFXKa95LdMy
         710WP69IOOn/ryhFNhMWhR4HGL8jo8JYSo+zCsUzwaxes1zUfdVRFgSvKKMsIam06b6x
         TbtLUlpg2l3/qLExCJjJM0ei8ilfyV12aWp7eZJr8VOQInjhVA4OqIwPVai59ZLhM1DM
         N5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711361292; x=1711966092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aj12qcWxwHOSiW5ip0+Q6r8HCwXXVgYZqcmXwDmc6a0=;
        b=KFY2ZlIelR4b/w1hdvgUnM89Zl+3WogdUGC81DjWuaXcIHgI9kh2M5YblCxoL2hrBB
         C4NTGIWseoFsAKXGbuNtkb4w+pidvz1Und1kdmWXieJlqYfN2zaGurwEOy978C6hYWTx
         ZEXmJc+oUablYklIqJpEvOGv82durStWabeqTFqWFAgd6vAQICMSXHTbqwwiniiHcyis
         0WlLQ6Xq8pWi8JtNmjJGpNtomv/qwUGdEN9lBZJ/4lQm83Yo08cXgWec1PF259XBI9OS
         sjzrTS3DBZkFzT7mnsPI5hiSZN1iKe1jq90bg4bM6byM7m4ATtimA83S0QP+fOYWaS/A
         OEiw==
X-Forwarded-Encrypted: i=1; AJvYcCU++PfB0jRLKQM6CaMcqq6gcl7OdWtqGSt86MgpuPlDSZYU5OUzwCW9uvCo00rD5WdcjMBxkImFgthza8Wafu9nXt+yJRcOSHjs1lOt
X-Gm-Message-State: AOJu0Yy5yCg2649Mv9m9Vx+wSIpGbJuqB3pnydR2qquAAp4W7xBPQozw
	HWbWLWy550ZOfd+/6mqMItq+LfoeYBk5JnmkS9sMEooBZgJFgQtuKm3iEvg7hY9kEXdGevEJPqB
	AHeRKXb2KiUAP7YEoe7+PsXanRm85eY0Ew9Iq6A==
X-Google-Smtp-Source: AGHT+IH9KsyrfR/oKQyP2zv2f4o4+YRFGfWSuYi0Uy5IBlHlqm5xWOl/0UOfEfiHPiDAIWTH17Eaxwh+L1AjnnpG9i8=
X-Received: by 2002:a2e:a0c5:0:b0:2d6:87ab:2543 with SMTP id
 f5-20020a2ea0c5000000b002d687ab2543mr3735612ljm.30.1711361291815; Mon, 25 Mar
 2024 03:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325100359.17001-1-brgl@bgdev.pl>
In-Reply-To: <20240325100359.17001-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 25 Mar 2024 11:08:00 +0100
Message-ID: <CAMRc=Mce+PbCYdBOrWT=aFBUj+c=SU54z0=CJqr4HsrCgzKoEA@mail.gmail.com>
Subject: Re: [PATCH v9 00/13] firmware: qcom: qseecom: convert to using the TZ allocator
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Elliot Berman <quic_eberman@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Guru Das Srinagesh <quic_gurus@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 11:04=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> SCM calls that take memory buffers as arguments require that they be
> page-aligned, physically continuous and non-cachable. The same
> requirements apply to the buffer used to pass additional arguments to SCM
> calls that take more than 4.
>
> To that end drivers typically use dma_alloc_coherent() to allocate memory
> of suitable format which is slow and inefficient space-wise.
>
> SHM Bridge is a safety mechanism that - once enabled - will only allow
> passing buffers to the TrustZone that have been explicitly marked as
> shared. It improves the overall system safety with SCM calls and is
> required by the upcoming scminvoke functionality.
>
> The end goal of this series is to enable SHM bridge support for those
> architectures that support it but to that end we first need to unify the
> way memory for SCM calls is allocated. This in itself is beneficial as
> the current approach of using dma_alloc_coherent() in most places is quit=
e
> slow.
>
> First let's add a new TZ Memory allocator that allows users to create
> dynamic memory pools of format suitable for sharing with the TrustZone.
> Make it ready for implementing multiple build-time modes.
>
> Convert all relevant drivers to using it. Add separate pools for SCM core
> and for qseecom.
>
> Finally add support for SHM bridge and make it the default mode of
> operation with the generic allocator as fallback for the platforms that
> don't support SHM bridge.
>
> Tested on db410c, RB5, sm8550-qrd. Previous iteration tested also on
> sa8775p-ride and lenovo X13s (please do retest on those platforms if you
> can).
>

The Subject should have been "firmware: qcom: implement support for
and enable SHM bridge", sorry for the mixup.

Bartosz

