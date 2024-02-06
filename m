Return-Path: <linux-kernel+bounces-55336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1404584BB55
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465931C25182
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B184C6B;
	Tue,  6 Feb 2024 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqtuhPB8"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A9A4A11;
	Tue,  6 Feb 2024 16:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707238097; cv=none; b=cDrncft3ygL2fIJOd9Oxq0uIC+1uJ7URCbpEdsL3FAfm0cS/vQxFQ+urc3zBlDdsSuYjBuAqzMUp+WSg4HDQrxl7u7t92ncb/u5bEieaIvBY8P9Ty+RffwfANtZQfzzTOBndAGYao6x5xzihmyRUJuVwKwxWudZcTPKtpZeCclk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707238097; c=relaxed/simple;
	bh=fnUc3ch09Q7XPuc21JoYJnzg6/oFdy32QGbmPJyBzpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j40s4CN9baoJ+6Lup6cpNTvFNWqSelgqCYScF2Jy/435kjG9Of5zMcoQ3upeFwhNSoeBylAcsKXN0XCtVcLxQngrLiKwHJ27DuKG268QiXljQLarfN9UTwOr0oP2tGU79lF9UIoJA5Fv2A+2evHCrXSTy3hYDyYplqWXsGK1tok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqtuhPB8; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-295c67ab2ccso4388159a91.1;
        Tue, 06 Feb 2024 08:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707238095; x=1707842895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Wo9TbjRKDGkCmqo7Xc5Ga2dxiubzrhcmojXzIQdzFY=;
        b=kqtuhPB8Sz3oEFmhpw3YvgPHWEfpDomiknP3xh1kbFIoRvTNXZoXVqHvmfUZ7k7J3M
         42qCGmsUjVVlySF7oE2g0AaC879z8x2UFt041vyC4+VU8i4e/x24+x9RTuDsZBVK6wb2
         vKCqz9RL7gClCFFsUCwu2x5voFDnEoDvzfTB6zMXxbwMy9dnFqeCa2dDoIX3Dp1onmkL
         5DVnOytwn6zDhCHJ/iJLX7CVV5T8pZUDNvUeSeu74r93rTGomB/NyvFA4jpa+sm3ROHX
         m+1OWcX7H1tEEV3OrxxZzQTeP+anWL5OYACLuZW0YYL3Ll5BAPHGAlxzslgaFwJV6Xye
         Jy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707238095; x=1707842895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Wo9TbjRKDGkCmqo7Xc5Ga2dxiubzrhcmojXzIQdzFY=;
        b=ncnaAOkEthVIA+nfllMjQyDXtAClwBw1TErH36N+1lEzxj9a6IrcIMmSw4P4ke3XBP
         GPdCYdVYA0rDVuym0T7I7xn4iYFT7JHzlS7hg2Sg6BiaYYjuyyWvYsaZEZJBzm+ixBDM
         fbqLgvlV+eja2NsSK7dSq5oMEPz/4GXU/X7TLVSrTZEGV3dnzKjiLZITbUB5mAvyCcwL
         0I4+vFKV6kJe9gMNgSDiwWztAh/j93ClVlpKl/uH7DFCyB8wAGB7Gsxrm9EXeTZcXjmu
         6HPzf0tsNOfWVN0nVdvIy6+IxH0a3s9rq2gImmvZzTLV9zNBlQv8Ky+FZ1ctZtl3gWP6
         9alQ==
X-Gm-Message-State: AOJu0Yw/LBtq2Kk0ZcNg8xN5FmaY8ej8//JxKQCsg97FjU5W1Xrtdyp0
	xH9VCFD/uQor9kLffK8zCvvDUpLTGPVfETlvjSpR10/r6oKHgfO1FEhYFtEjZV4SZHLmV9DeQIF
	u1ql3ZElN2nqGj9QsY/t0qWfZ9qiA6/CcAAH/Rdw=
X-Google-Smtp-Source: AGHT+IGyxBMnZVGOaKjqcUgn31TN13lpmM+OWY/WdMiqCVufN/OJQrRMWoTaP4g+EvTo5DATiOgBGW+ZYxZ//VvIQ4Q=
X-Received: by 2002:a17:90b:3bc4:b0:296:9d64:956d with SMTP id
 ph4-20020a17090b3bc400b002969d64956dmr62593pjb.35.1707238095479; Tue, 06 Feb
 2024 08:48:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205191808.998754-1-frut3k7@gmail.com> <ZcH9u7Vo2sFERIHJ@finisterre.sirena.org.uk>
 <CAKEyCaB2Cw0Ey73je96xDgofuXDnsC4DgeS9=HkOM6Kufrwbaw@mail.gmail.com>
 <ZcIwGRU5NEZGpRy9@finisterre.sirena.org.uk> <CAKEyCaCQk+iL_zOr_0LFOA4Fw+SwyuzSWOvVgmO0Tn8Ygv-4hw@mail.gmail.com>
 <ZcI9tWsthu8XMiZ1@finisterre.sirena.org.uk>
In-Reply-To: <ZcI9tWsthu8XMiZ1@finisterre.sirena.org.uk>
From: frut3k7 <frut3k7@gmail.com>
Date: Tue, 6 Feb 2024 17:48:04 +0100
Message-ID: <CAKEyCaC79kMoNSOOs1SREsvEGMGWPftqzDDMebvTVKDvTHeCMw@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: spidev: Add Qualcomm spidev device compatible
To: Mark Brown <broonie@kernel.org>
Cc: Robert Marko <robimarko@gmail.com>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 3:10=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> On Tue, Feb 06, 2024 at 02:57:49PM +0100, frut3k7 wrote:
> > On Tue, Feb 6, 2024 at 2:11=E2=80=AFPM Mark Brown <broonie@kernel.org> =
wrote:
>
> > > This is out of tree, it's not exactly a good guide for mainline.  The=
 DT
> > > should describe the hardware, not how some particular software stack
> > > chooses to drive it.
>
> > Will changing from "spidev" to "qca4024" be enough?
>
> Should be I think.

Should both patches (spi and devicetree) be sent to two projects
(Linux SPI and Devicetree Bindings)?

