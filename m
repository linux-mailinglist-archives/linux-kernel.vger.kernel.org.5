Return-Path: <linux-kernel+bounces-44706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A3A84264B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40611289B0C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7446D1B8;
	Tue, 30 Jan 2024 13:41:06 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09796BB54;
	Tue, 30 Jan 2024 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706622065; cv=none; b=reTrB8BEMGxGe3BjfJXQk19ulA71A6qBjGNi7aIEeuURG5Xy1UtHuLIS2/dED/Zs9D8v8O2yvAHpYptPmOY3E/+Csx6yJ3IBaqzrQXCrJWmyTULe00mXNXEdy76EUnG/u5v9+25fxV1eJFzPaGWFT5vRvzIx+gTB7JUEFiAIoQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706622065; c=relaxed/simple;
	bh=RiNHswsYrPk3kor4Gr8r0ain5u5aP5cCPnQ3TBQxNew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HUdlv6pfrfUr9Tg/zVSlu0qiKVeqoLb+ZOSE436MlgE/wawsBmtVdgUrAX6qdm8Le4s/Qwtdwk0uZiYng4E8s0/oXBY6+i+SOyub+lLhK67nYeFxKP+uv4Tngmk6r8wDczF5wboyopcJK+QyXU9u4kzVVmId5VZ6JYCcK99ZG3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ddd19552e6so1922685b3a.1;
        Tue, 30 Jan 2024 05:41:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706622063; x=1707226863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frJDUedpI3YTH8Ki9s8KdkIUfyDUhvcxZMMZkPB9gtA=;
        b=F25CRAbFZaKg0ABrkpkG4pGRGalgtMoPBOM1itxRvfF2t0VBJLJxta35g/K97lHr5v
         EPrdPp9cDG8COz7kd/Hf31zCCAoudv9fB+mO0Jkc6lEBMZ1jxuhaPVJnkH96eKDIJiyQ
         RJ+iDfDWUDBos2+xhet5htR736OjvMdkZAl+FxT+CPEBUDCP9zPT5kVKw9wq8AUPA27V
         IZUM/mXi3SGfwm3L5N8MnxMqc7W+a+NyWPjGqUJhHXXReFVBkD8iY7fUa8kXRlNiHJ+s
         GIXUZjdsQEZvSvCEn/itQNwFOZnmL2/UnflioVLDeey8xPFF37FxCGX3C3ZqH+KbozJs
         IrLw==
X-Gm-Message-State: AOJu0YzMIB1Wi8VfnEZCp5jtv/SVxVMe8OYn1j6XvwcF+/RmGj8qXj/D
	Ef7UK2bKf5bFH0N1y6zCO2atRSgof1nGnpqMr5Ec2KxDga4HiiDIbXGYZ+ixk08=
X-Google-Smtp-Source: AGHT+IHHJCN/DA5nDwh/W1iGS9pLTv+8/BwgtjewsS/JVnv80HpaGXOBEGUKUqWzXskzFujFpvaFKg==
X-Received: by 2002:a05:6a00:1805:b0:6db:cf34:8a96 with SMTP id y5-20020a056a00180500b006dbcf348a96mr8296734pfa.26.1706622062919;
        Tue, 30 Jan 2024 05:41:02 -0800 (PST)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com. [209.85.215.182])
        by smtp.gmail.com with ESMTPSA id w18-20020a639352000000b005b458aa0541sm8089838pgm.15.2024.01.30.05.41.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 05:41:02 -0800 (PST)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5cfd95130c6so2224411a12.1;
        Tue, 30 Jan 2024 05:41:02 -0800 (PST)
X-Received: by 2002:a25:b20c:0:b0:dc3:78d1:c5a3 with SMTP id
 i12-20020a25b20c000000b00dc378d1c5a3mr5877288ybj.13.1706621652312; Tue, 30
 Jan 2024 05:34:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130111250.185718-1-angelogioacchino.delregno@collabora.com> <20240130111250.185718-7-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240130111250.185718-7-angelogioacchino.delregno@collabora.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jan 2024 14:34:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXgT0g=0uky9FYDXk=KuC1HjkGEX8sCQdKbUMoBFQKDqQ@mail.gmail.com>
Message-ID: <CAMuHMdXgT0g=0uky9FYDXk=KuC1HjkGEX8sCQdKbUMoBFQKDqQ@mail.gmail.com>
Subject: Re: [PATCH v1 06/18] thermal/drivers/rcar: Migrate to thermal_zone_device_register()
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: daniel.lezcano@linaro.org, miquel.raynal@bootlin.com, rafael@kernel.org, 
	rui.zhang@intel.com, lukasz.luba@arm.com, support.opensource@diasemi.com, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-imx@nxp.com, andersson@kernel.org, 
	konrad.dybcio@linaro.org, amitk@kernel.org, thara.gopinath@gmail.com, 
	niklas.soderlund@ragnatech.se, srinivas.pandruvada@linux.intel.com, 
	baolin.wang@linux.alibaba.com, u.kleine-koenig@pengutronix.de, 
	hayashi.kunihiko@socionext.com, d-gole@ti.com, linus.walleij@linaro.org, 
	DLG-Adam.Ward.opensource@dm.renesas.com, error27@gmail.com, heiko@sntech.de, 
	hdegoede@redhat.com, jernej.skrabec@gmail.com, f.fainelli@gmail.com, 
	bchihi@baylibre.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 12:15=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
> The thermal API has a new thermal_zone_device_register() function which
> is deprecating the older thermal_zone_device_register_with_trips() and
> thermal_tripless_zone_device_register().
>
> Migrate to the new thermal zone device registration function.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

