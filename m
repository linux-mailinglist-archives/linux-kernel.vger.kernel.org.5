Return-Path: <linux-kernel+bounces-135256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4F589BDDD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7119E1F21C72
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B7B651B7;
	Mon,  8 Apr 2024 11:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3XhY/zw"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A93564CF2;
	Mon,  8 Apr 2024 11:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712574889; cv=none; b=tfMqyM02l1pCJucrExKHut8pVwnX2CUmdnaIJ+UdoU9bwq7M6yoQinr1WFz76KSV6uwT2h0BDvoJMg8fJiMKb+OwGmEHyOOLSeV/PK7CwCHEu15a9HfKNwBhcVey3lfSqKuSrxwbnMXkwolC2B4xHiXZ7UAugXU/vUZpMFjc6OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712574889; c=relaxed/simple;
	bh=Hf3/uyTTc7xyvyt0ZRCrCnTsccSJPrqbnLcWcjaVrLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EH8EgtOx9n5Fv+u2RZBvZpxqzF6CQeHoNM9YPqQrbCzqtuKsNIIzIEWsXUunZu8WqRuvEwUxaHj/7R/c4lYfsJJ/w7gjcfZPGhTrCzZF3clUMy0qtqNz0WDAld53Jiu5ka53dlE6hloPjT2VMBW1TNO14j83v9Cs2ivKeeGgUVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3XhY/zw; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2a2d37b8c4fso1218028a91.1;
        Mon, 08 Apr 2024 04:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712574887; x=1713179687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5yiPdvyV9rNRJJhuFWlvTvKqry4UGZkHf/m3Yo7GDo=;
        b=W3XhY/zwK/Yg2VEOLOxC3HGX67BEJzpQKnOnWcwpVkfrwj3OhacWkz4kW3148eeAy0
         Bn1r7fDM5oiNynCKW/daDAbE3PdLFgbS0bxrYBJ6ZWjK+0bhk9qX4wNTbVjcMRr0o0RI
         UrZy8FWvKkk++pjknobsJjNJmyipsTI7bsdEXtpkgTKelpRQQhlALWo37NQEbQE4E3va
         TA8CZf8S28cOFMQYELFEjNQh2BZLirPkXOhSI978Ky3F8lb+kjJRNGsLDldbqAAd2ov4
         /E7/DoVZ2k2dXspBQzAuoAp4qOINYkJTGzt86hdcJKdlXYnMJ562Rr0x9g+MNn4WIHPU
         jcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712574887; x=1713179687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5yiPdvyV9rNRJJhuFWlvTvKqry4UGZkHf/m3Yo7GDo=;
        b=Mvoh474KDRsjhndbJgrpMxTJt+C1GaFamBawpARw/IqNGhG60CMOUhpY9y6UoBZ3T6
         rTDqcnXOrgIFEXcqCLyPncKRz5xqlVmoe0iEByihUnCJtcUC120oXia0cns084luOR92
         apkYRYFxOhBylaEfsJvYV5gPPTtApVl9es9NTbJSWOuxJp2UZlFksBSprw5dS47/AJaQ
         ltWNy2YyzOQ9dNSFuQiFjFYKvG3zyVEOAU45d8ayG0R98jejKMOZ4Az20qymFy7/J/T+
         CQeMmznpDFToDFTJqyqFG+QJYZTvIZdU9lQ3iN4zrNAY4uytSfKxz4Zl9blcg9aDkNa5
         YjgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaanNMmAMMtr2LGxhwW8dTOnwrdrHzME+osIYUmMljKPSyBo6ShWul29HUyFB3hVG0LsCEi7X9CNJ+VryNQ5syteOxPSpE4jagz0xQXhEPN2QwgJDTmEWu0Op9jgzpFLgCo+J0UjgRWoJhgmy5rRG3Ig7t+YK2DsNwWHFc1d7J/NNsqCai
X-Gm-Message-State: AOJu0YzUOvNyl3rohSgQC+2ScCxRhFXrNSsDp5mDF3yr5fvpVVkrb8K2
	eHZTwDdqTxRjy/XxZH22qK8xiPy/o0Dscj8r7DOyxjdlZC4xlinx3zVX/IsoyaPdkdIc7RDzuxZ
	5+xUP2MzD8ihjGjrAYIu+p9j8dUw=
X-Google-Smtp-Source: AGHT+IHCMk1vG85ZQnizg4WMLxtCMOThz1q4RK1dWajN7Z6haa3pN+/ibtoYI3BJZsJ3JH3vODvpabpzfLaIbxL7wQA=
X-Received: by 2002:a17:90a:b288:b0:2a5:3249:d230 with SMTP id
 c8-20020a17090ab28800b002a53249d230mr1160056pjr.3.1712574887276; Mon, 08 Apr
 2024 04:14:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408075806.1194297-1-mirela.rabulea@nxp.com>
In-Reply-To: <20240408075806.1194297-1-mirela.rabulea@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 8 Apr 2024 08:14:35 -0300
Message-ID: <CAOMZO5BRY5YamT9bxPPMQo8A5msZ-kCUcxn9eLCJEEJwxD-J9A@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] media: dt-bindings: nxp,imx8-jpeg:: Add clocks entries
To: Mirela Rabulea <mirela.rabulea@nxp.com>
Cc: shawnguo@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	festevam@denx.de, alexander.stein@ew.tq-group.com, Frank.li@nxp.com, 
	ming.qian@nxp.com, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, mchehab@kernel.org, hverkuil@xs4all.nl, 
	linux-media@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mirela,

On Mon, Apr 8, 2024 at 4:58=E2=80=AFAM Mirela Rabulea <mirela.rabulea@nxp.c=
om> wrote:
>
> From: Fabio Estevam <festevam@gmail.com>
>
> The JPEG decoder/encoder present in iMX8QXP and iMX8QM SoCs need
> the PER and IPG clocks to be functional, so add the clock entries.
>
> This also fixes the following schema warning:
>
> imx8qm-apalis-eval.dtb: jpegdec@58400000: 'assigned-clock-rates', 'assign=
ed-clocks', 'clock-names', 'clocks' do not match any of the regexes: 'pinct=
rl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/media/nxp,imx8-jpe=
g.yaml#
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> Signed-off-by: Mirela Rabulea <mirela.rabulea@nxp.com>

Thanks for submitting this series.

In the Subject, you added an extra : "..nxp,imx8-jpeg:: Add". Please
remove the extra :.

My From and Signed-off-by tags e-mails do not match.

Please use the email from the Signed-off-by in the From field as well.

The same applies to patch 2/2.

Thanks

