Return-Path: <linux-kernel+bounces-74989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 214BF85E0DF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7DE31F27074
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270ED80609;
	Wed, 21 Feb 2024 15:21:08 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6AF7FBBD
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708528867; cv=none; b=j160fc5I3ClVg9U1qhS2R8plIwBqgLWd8TS/flUOqweRHUSpA2+OdcHaYDXyxIbMokNZg7PDjsa0bQK77FKaBiT5y3TjmI79UQZL8zusOoy1BGH+aFLzGNGn2seihq6EFsCy+rQSUiKWVRDPs11wF4NmRqzXa3K0YL8Z5l0UJAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708528867; c=relaxed/simple;
	bh=obX6VQ0u+XXyt/sOpBUh6IqBL2pGAjmHzdJMUaZZSfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQUcjv9S0d7dmTsU+LbtC26aiRqtt35/an1H6vPKZIyjbu2nH6HWCI8QkHgkuuTVMGhVzm+MnVolwsNQ6k6N1Qy67sS8Ct7dCNsPmM2+c9pMOcVxXdUJpiaHMpQpVA0OrVnIME1NV6IfGFTgbPk4sKQLTNyqnBflO6Ih+OXnMkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-60822b444c9so26626807b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:21:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708528864; x=1709133664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1PRp8JfSe6siv3SHwP32rn6vZ13B8Nd0cz95uDsbJEs=;
        b=FqODviUfU7FJOOmJU2q8w4qm8Fmiz4+czTMy+QU9ZwH6KKqp8fWJf2OI15ZNCDb9p6
         Zgol8WEfJbxifDcUJRI5ewTEITHnTs1UGEkCD+1dV6XZIc1P7Dx7c+fBF9DhpiDYoxDq
         fRu+j+Y+TMM2sbDN1vtKiOD71JdFY7k5cbs3oqwLoLbpf1CsGKhFCYe6DaqMViOFBvNk
         awQjfVwYYpdfvokg/PQddhdQz04GV6U4rauMJZ7cQ5OJnGf1N2v9wW4AXo+41nyLSkFu
         hg2s5qtZ+ayS1Bykp5hIq3Mi8RRdoIDoYZRNZNFIKLCwXnyw1iwhYmqcEbhAjZ4uQuq4
         FxYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYWPksjYyPU+503HNJXJCR7IN4TUKIR3GlF+wb9xpRg9OIessDPnp1UkLm7PQbMplzeujcM6iX1e6Uhx21DdY+eR29hfU+0hbUIVhq
X-Gm-Message-State: AOJu0Yy/+MdcjBWSEjVawnWEJ+NNIHkC82mCFhO3Tlay5ldMsgGD+XX4
	gNLaYRIOHv0KDXuLlBltQp9SrL+kgOObApf2G3aUWi0MHzSYyCox5wHUczYeU34=
X-Google-Smtp-Source: AGHT+IGhLbhIpk1/eHRFwRymSgNIi6w8EcwMbyADRQH4griT6EQYmC34XpeIpiJchGeut9TocUWGzg==
X-Received: by 2002:a81:9945:0:b0:607:d9fb:5144 with SMTP id q66-20020a819945000000b00607d9fb5144mr16528178ywg.13.1708528864663;
        Wed, 21 Feb 2024 07:21:04 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id a188-20020a0df1c5000000b00607c9160c22sm2628748ywf.119.2024.02.21.07.21.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 07:21:04 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-60822b444c9so26626547b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:21:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWUMMND/TjmtHEQ+A6eN7XnZdOhCMda/ftiTxkbPreUlpBiSSpYP/EYSF5HtqfTdGvBPqJ0UqpKw899GWenlCMSp7iiBAMvs79SngvH
X-Received: by 2002:a0d:df86:0:b0:608:7376:afa4 with SMTP id
 i128-20020a0ddf86000000b006087376afa4mr3751103ywe.18.1708528864179; Wed, 21
 Feb 2024 07:21:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221141350.3740488-1-javierm@redhat.com> <1f28256c-e436-4add-aa67-2cfb2248b220@linaro.org>
 <6scz7iti3tzzrd4ph3gnuc2pvkcbtuuicgfgujh3pa3c34kdkt@bhfa4xbxeu7t> <cb8bf006-57df-494e-80f3-947582ec71f1@linaro.org>
In-Reply-To: <cb8bf006-57df-494e-80f3-947582ec71f1@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Feb 2024 16:20:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWYyDzzy1-arw=Yt=cTpJ-crx58oKdQsity2EaRtSNk1w@mail.gmail.com>
Message-ID: <CAMuHMdWYyDzzy1-arw=Yt=cTpJ-crx58oKdQsity2EaRtSNk1w@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: defconfig: Enable zram, xfs and loading
 compressed FW support
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Maxime Ripard <mripard@redhat.com>, Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org, 
	Enric Balletbo i Serra <eballetbo@redhat.com>, Erico Nunes <nunes.erico@gmail.com>, 
	Brian Masney <bmasney@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bjorn Andersson <quic_bjorande@quicinc.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Wed, Feb 21, 2024 at 4:10=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> UBIFS was added recently because one device was using it - you needed
> it. 9P_FS looks unnecessary.

9P_FS is used commonly for file transfer between host and guest, cfr.
commit af9b99647cd2a6a2 ("arm64: defconfig: add virtio support for
running as a kvm guest").

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

