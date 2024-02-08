Return-Path: <linux-kernel+bounces-57764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A9784DD26
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4328A286EE7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960866BFA0;
	Thu,  8 Feb 2024 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="XvVmf/1n"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5969F6BB2F
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707385149; cv=none; b=eCG6k4ZA8hQv+AGqJlnJm45dWfQ7yiDra5RgvZSxY4BnwiA7RGetxqSzlKZoJ0Lmk4qSF1ezy+WvhyUlZENfD3RjW9pg2BClDx3e07iQBJRYKRBFs520gHaKqhoJ47eHSp93uA2jvpGHPM/ZXH/56hxNE988BdCh/aN1sQ3QyvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707385149; c=relaxed/simple;
	bh=Sny5SuUsVI8atYqqphegc1gpp5T+LtTvGDD9J2PF+M4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OnW+YF7wU4v3GejDJ0GToT2A6tqSpRDwVAvqktWENQY87XCpdy2Fi/HwqxfeuLlGcORZ0jj25LHc2tltxGC68gY6PYVzDXFmeey9acCsvIqs/+K7FF45QixiojHEaENDMf+kuyxdr9o9fDelxmjPvP4kanHzIEsPaOgBeODHl80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=XvVmf/1n; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4c02806ff45so643890e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 01:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707385147; x=1707989947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sny5SuUsVI8atYqqphegc1gpp5T+LtTvGDD9J2PF+M4=;
        b=XvVmf/1nZFbv7r3jX5s/M0vyx6MiwZYrNYPdotUk9TBOdy3y2ExJplDZapqupVhmIV
         ohGjH6s0erz5Hs6z4iTqQuD5BqsVTnUy/JyKQdbcDC0HpJoWdw6IWJF7jSY5G0vaCElr
         eDAUwQpe+NlKANyZ0u4bL/qdNWTrJEu3vyb4UE+T6kFjLzynV4OJ8h286CKWtm7rUgL+
         Tb1sz+mJL/QkjrlCYzkirbrocN9JVOt4TOE7Q5PZ9grVp1Z4mqoDm9cORqNfwDxeVdCo
         sOr2pHua6IKw/29UsIC98cck8l+8nLM3JOzuzQyNA9gta1tRawyo9+TKs99tj3oGlbp8
         PXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707385147; x=1707989947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sny5SuUsVI8atYqqphegc1gpp5T+LtTvGDD9J2PF+M4=;
        b=LkhyaufHLck6EbnHzv2Vm6dcF7BNz/CQdAFTfIfJk65tbSh0qi3yZD6Ma6s3CbHxHc
         PpjsEocNgNA4PQJAzxbHE/Y8TqcbQML7Nae3ik5K4JZMXyQUH4xIYi8Uf4kx4yy82X21
         9gti58z+VJ6B46QdE28r0cPOD8qZgchRBe3vqcW8LG3XzNULpWLDszDFsDhi0M2NDQ16
         YQe/ozHiPOtZMg++3jsRMcjyeElqZXNZdtvUfWZ6c70fsPSpezaHvus3U/1JhblpHq2b
         njR5GcEwoHwgxtPRE5Ix2xOQ/oPq66V9vjCEbMstmx6BwZ6rLALRsNa5ib2vymY7M66Z
         jeGg==
X-Gm-Message-State: AOJu0Yz2RttLg6boFPLjcAdpA3p8C2IVMKMMUrD2bvHqVJ9tqEUYQe5W
	cnlnHWOZixhcOkOwSCqWaIuRRCRtI1yJfI9SHDPuoaVnMh6pmYA9PG4B5e6trp+sRTK1gu1UpW5
	D8o0zsYvzrxyd9s2jJ1OLE9/6M4QuZ+hLqdYl3A==
X-Google-Smtp-Source: AGHT+IFUez3CnqGQlqA3KfMvqOutQYj5rGN5MK/NThGGpDKLSDVXO+5cWP7waHFECsS81Pn+Wf9sHClUhmALDsS2Iw4=
X-Received: by 2002:ac5:c5cd:0:b0:4b7:3875:72d2 with SMTP id
 g13-20020ac5c5cd000000b004b7387572d2mr4666662vkl.1.1707385147243; Thu, 08 Feb
 2024 01:39:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205100811.41534-1-brgl@bgdev.pl>
In-Reply-To: <20240205100811.41534-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 8 Feb 2024 10:38:56 +0100
Message-ID: <CAMRc=MdWBbVeuxU9XO9xbcgnBxnMnAMXRy7TXU7H9La-QyD9yw@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: set device type for GPIO chips
To: Linus Walleij <linus.walleij@linaro.org>, "Ricardo B . Marliere" <ricardo@marliere.net>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 11:08=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> It's useful to have the device type information for those sub-devices
> that are actually GPIO chips registered with GPIOLIB. While at it: use
> the device type struct to setup the release callback which is the
> preferred way to use the device API.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Patch applied.

Bart

