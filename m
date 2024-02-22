Return-Path: <linux-kernel+bounces-76039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 259C485F23E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53B191C23206
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B035117BA5;
	Thu, 22 Feb 2024 07:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvSkri+9"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E3117C60;
	Thu, 22 Feb 2024 07:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708588691; cv=none; b=HddWUWMAq02H7YQhgE9+28hP6KBs3I1xesK3xDcREeY9whppR68Lk9f93eCPp0DLRUiXObSbkBwIPPUJOsLgrnpRwb9Z6oxa9Zi6vpXxBWUzAexpJb9+ERh2xc3wGBm7GqwQlgoMDoC5Li0Gk2FCqrILyiQB6b2RXOXY8tTx9Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708588691; c=relaxed/simple;
	bh=1JzcUDfvmHquetvvSPz+vy+dlup0b04FsUEp0hY5uu0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eWfkWRWUJF/cfnZhb7mdM8wtc0Wm9a0mfNTV1U8/n3yavfs0w5kVg7Bg3W0FQGX/8chVs82ZHvWoyEckelevR8170PX9SXJuFBU30igU2/FEhPwSeCB/ylTqW4Lsd/cf/Xk7tHh4WLVzDRjm/P4l45Oz+g69sTNii3/oYE1mdV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvSkri+9; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33d568fbf62so2328267f8f.3;
        Wed, 21 Feb 2024 23:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708588687; x=1709193487; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1JzcUDfvmHquetvvSPz+vy+dlup0b04FsUEp0hY5uu0=;
        b=FvSkri+9JPGjS85Q6TIVl2IxfSXGDE9C0NmJoYDxLejoKL8AmnbAYsf2023I73LrAF
         ko9/kge2S3T/KN1m3Ot1EJKYXXDtZii5lS1pmm3ws7PZ9PlYwxMZ4a6f0oKtK5Op+QIc
         jLEBSjU8ouCUle8flDW/dF72Z4bDMW9b/vIW6l0DkAJrYxC+DYaU9q9U4K8zNRla9+id
         KMO8wkM6cofZjvoiePwls1JTFlvpkY792KYgjh8j/IifyIuE3PkPUt1Tf1bepbuooAgC
         cOeQJHZ6cpy5vO/TFMCIxgkgk81y3isx9NP9IT32c+AsFOSw34lASJe1J1H2uq3bIFD8
         vSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708588687; x=1709193487;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1JzcUDfvmHquetvvSPz+vy+dlup0b04FsUEp0hY5uu0=;
        b=FEh+4+FuhnVQBR0l+eRyC47RKpj0VtW1+7psxMNUJTyrcpnkKk8pBycsumxhBMIBch
         tHTllkelS0/vkP7+YhLlrs4EzfxgzwxXur49Ouhcu9NUBiHGq2k7+JhJnh3SnKgb3+Z1
         K01sne4FDwHyz5CgC37LNECYFb3Le6vLhDWjXA/Ct35ECDFi8rqnlWXolnXshdxmPySO
         IM35ixpBrAU00ZR9Zxqh+FrcrwTKvLQqSRl6OyPFkwklod9pPoe++kAXvZ8Gug6Dpm+6
         Zm0qtj75DHWUi3yxBVhHfCNz3MUgGWi5dBErNI6LQliiT+QqHIZxd4indkJg0MEL2iAk
         GX5g==
X-Forwarded-Encrypted: i=1; AJvYcCWw29/NN1D6mbgCLE5obGaov7Nv1AKfxRdxGLvYqkSJGpq1u8OagsJvN6SRQag+rtjJ764YvHFopz+YwyM0cHbhFOVIyVKGcFyAriZp2m5ctkdwBTI1ZLWVg6krg99H5vp6BQPCNjQa
X-Gm-Message-State: AOJu0YwL+oTHvUoIgdlKBElgPQcTcUCaOJNVd3SuZYiCLYT3BWjEUsvV
	S7EzeczdECthZ9hzd14HgNtGMIC3NMaZPvyVguOojAe3jrpGtfOx
X-Google-Smtp-Source: AGHT+IFsAFkCvtM6mWVq89G33ylVubt6ebXMp8cmmvElTsIzP3v1zzmNNlgBcFpzIlA0P4Npz95org==
X-Received: by 2002:adf:f18a:0:b0:33d:27b8:954a with SMTP id h10-20020adff18a000000b0033d27b8954amr10906179wro.22.1708588687299;
        Wed, 21 Feb 2024 23:58:07 -0800 (PST)
Received: from [192.168.90.166] (146.red-83-35-56.dynamicip.rima-tde.net. [83.35.56.146])
        by smtp.gmail.com with ESMTPSA id bs17-20020a056000071100b0033d47c6073esm13656319wrb.12.2024.02.21.23.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 23:58:06 -0800 (PST)
Message-ID: <e6598bf07b9c64534b772f7fa5dfb92e40f37fb6.camel@gmail.com>
Subject: Re: [PATCH 2/2] drivers: iio: pressure: Fixes BMP38x and BMP390 SPI
 support
From: Angel Iglesias <ang.iglesiasg@gmail.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com, 
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Thu, 22 Feb 2024 08:58:05 +0100
In-Reply-To: <20240220224329.53729-2-vassilisamir@gmail.com>
References: <20240220224329.53729-1-vassilisamir@gmail.com>
	 <20240220224329.53729-2-vassilisamir@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-20 at 23:43 +0100, Vasileios Amoiridis wrote:
> According to the datasheet of BMP38x and BMP390 devices, for an SPI
> read operation the first byte that is returned needs to be dropped,
> and the rest of the bytes are the actual data returned from the
> sensor.
>=20

My tag from the previous round:

Acked-by: Angel Iglesias <ang.iglesiasg@gmail.com>

Kind regards,
Angel

