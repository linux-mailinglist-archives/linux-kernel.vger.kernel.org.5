Return-Path: <linux-kernel+bounces-27766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8832C82F58F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C4D1F24CCB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035131D547;
	Tue, 16 Jan 2024 19:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHdd04mx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D0E1D69B;
	Tue, 16 Jan 2024 19:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705433958; cv=none; b=aPAjAtS83vLg7uweNn3pLa3O6EGps3s5KwZ9r3s5MrWX4+bzGYqeEh3Jxzu1/6fkthd+Xke4Gve4eLqsPycAvbutq/iaV19zNJzEjncCkuXeO3NhQKZ8UD9HMKPnFf7lZtsymZyItkwZmOMO7adXhU53aqFWvPZT2VgkjCPO/t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705433958; c=relaxed/simple;
	bh=pjDgdDVU36HSsdeAh8iqjM/fJHnEYcbqQIdZRgQQpxo=;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding; b=jZ68VpzCp5BRlmh+yNyNeL486EcklZhG++UJsAi6Jq/+M8OU4lWxNnP76imAQznPOnNe9JzNm/3XDoGOiEdbymG6JJN54gyfyvLJXvEx1+icnmhiT29xFE6rE6O6G++foRbfnpZ8CI7HdOd7x2L+FIrR5TPzRox9n+dDbFaMrbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHdd04mx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5238C433A6;
	Tue, 16 Jan 2024 19:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705433957;
	bh=pjDgdDVU36HSsdeAh8iqjM/fJHnEYcbqQIdZRgQQpxo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iHdd04mxCP+tOwIJVpVwsLiix52+TwrftpE748cBUHhjPy92EUpa6S++7uqtmVG/z
	 TNw6IND5Q2iTwLW0o8XJI7dh8mF5cjI5oPpGvMq5ovWMsBLI4BHDSk7v/TbKZC+WtD
	 xeRjeZWTXdp43zoGXVMvssyHaRkfIZ1yNIoo00OWd54XUCHGrv8JUpb0UaKo/dwprh
	 E4tDiVadkiMzCQdRFEwfnc1y6Dby2nqUYq7q3qrlYf72er/mY43ps+UHnIrlHd5+Ia
	 qSMnxm0UO7eTv4tNwagpV8JHgS3gNHPgCDXP0QQnB9cYhPA3OnR4VBTuXGmkQ27H6B
	 5hF2abXdNgMPw==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cd0f4f306fso119800291fa.0;
        Tue, 16 Jan 2024 11:39:17 -0800 (PST)
X-Gm-Message-State: AOJu0YxnbBV862HtwpLzo+JRd+A6VI13ZyPqsXj8LnRbO8UUr/abKF8c
	nDGx1W8eQOGBGRsNKJOm+pl+aD5YEpxc5ZH3NA==
X-Google-Smtp-Source: AGHT+IHXHjYON9ofprozxosV1rLsC6hkADTeC9xOtqdXDcdf4lotORYA2DspdiZkDAvS/+SWb8KBa8qFkc+G/Bp+/vM=
X-Received: by 2002:a2e:390a:0:b0:2cc:ea0d:f6c0 with SMTP id
 g10-20020a2e390a000000b002ccea0df6c0mr3767274lja.83.1705433955919; Tue, 16
 Jan 2024 11:39:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116084618.3112410-1-tim@feathertop.org> <20240116084618.3112410-3-tim@feathertop.org>
 <170543385965.291741.2100641423770592209.robh@kernel.org>
In-Reply-To: <170543385965.291741.2100641423770592209.robh@kernel.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 16 Jan 2024 13:39:03 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ0BfVY0zO4SAB6rjZVvXYrZObZ+6bfWkPBC1NO=VOzFA@mail.gmail.com>
Message-ID: <CAL_JsqJ0BfVY0zO4SAB6rjZVvXYrZObZ+6bfWkPBC1NO=VOzFA@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: rockchip: rk809 fix compatible string in examples
To: Tim Lunn <tim@feathertop.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Lee Jones <lee@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Zhang Qing <zhangqing@rock-chips.com>, 
	Heiko Stuebner <heiko@sntech.de>, Chris Zhong <zyw@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 1:37=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
>
> On Tue, 16 Jan 2024 19:46:17 +1100, Tim Lunn wrote:
> > Fix typo in the example specifying wrong compatible string
> >
> > Signed-off-by: Tim Lunn <tim@feathertop.org>
> > ---
> >
> >  Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
>
> Acked-by: Rob Herring <robh@kernel.org>

Err, withdrawn. This doesn't pass tests.

Rob

