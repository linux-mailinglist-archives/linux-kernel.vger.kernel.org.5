Return-Path: <linux-kernel+bounces-96002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0468755EC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A0AA2830B2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF01131E49;
	Thu,  7 Mar 2024 18:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbZ6kMNF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE33130E59;
	Thu,  7 Mar 2024 18:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709835363; cv=none; b=B6PsTcj9/V58vUifRuBV2bx2KiEbC/cb/V2at/CgwWuterQ9gcn+TvykssTiEyqdl4q4ERsS+k14roxNorDK59Q2H2PcxH0Tru189L2Z6X/qVvxvfHwj8fV5bJee9Y7MLqydJ1dG8kHxEdvbjPInj26cV/S8/fpYE0i48n0tpXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709835363; c=relaxed/simple;
	bh=dPTPHjpCRLgFm/lxnmSiKFph90OqA6fCyXoBFtp7HgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mq4+bnPFBaSiOyol9RqsnHg2N3DUiqbfrXgrhWy92lS9Anv+FBboc4LmxYSGuEvwM7PPxY06l2cz+kTygzWvDTnJvWR4F0fQ4Ew5/ZH/fAKakuPMXnH9ArZnEtqU6+nTwsGMer/hSjoSlfAXluUIQtRbVtFH6S0veZhJ74YuZb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbZ6kMNF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F6AC43390;
	Thu,  7 Mar 2024 18:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709835363;
	bh=dPTPHjpCRLgFm/lxnmSiKFph90OqA6fCyXoBFtp7HgI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cbZ6kMNFOkqi+7zE5sc/Pm/lwZqYTLfDaqQhaj5pW8MtTwucVP5YmR1AI7k6Ne9K9
	 JF1MEO8ho44ojQvrGTotYT+v8JVtyxY5cIdkxj+PafS1ucT4/mopGa/TP+bOkkCos5
	 WUK263hl8RH7XSBatFCN9LEX7M0QkziThw8SWmjM7t4ZnjXUAM6KYOE3a3dERknIz5
	 5cS43qeFOkK+pFb23/H5NKciBwgsqwjM2PBQV7yPnRW6WmafhGkkTe+eaw0Td0ZJFm
	 f9N2a2PxwIuS+SSQKqIg5/pFdUCeaFNgxP/2mpA23OYbdFUc9f8it6c+IbudqBIT3G
	 /d1f0QizmEvOQ==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d2505352e6so17840721fa.3;
        Thu, 07 Mar 2024 10:16:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUTo+MKwE+G1DLEQes7AdcPl8HqrtoAN4e6lWG7jYgJOz8hB9BjK1m6N6jO0pk6zm9RTbfgErmnnWT/DkWk5QChUbzSBKcUrbSXVxCWOIbQzDP+rE5AYpffW7xouHopXoQQoKy1dvkX+g==
X-Gm-Message-State: AOJu0Yz/MHdFDfUmKnX6I54WsdJVjeOu/sd+hiqeJaXo/JK88aO4KL7P
	OJkna2IuPKVkZxmAl9HrEKp3JfopnrvZR5i9eGmFgmiRe8EpysV/F0rpuHTON7TDCpp3ueUAJgt
	/IVGaHMfgd8ETEv0UcX5i6fo+fQ==
X-Google-Smtp-Source: AGHT+IHSczJ87wbSLjyRnbI+ltnna+Ea2X/Todom8MfI6gfwI0NKJYZDpNsic5AtpHJXDE7KYe9zt3aMQkOjFiGtHhs=
X-Received: by 2002:a2e:3317:0:b0:2d2:4637:63f with SMTP id
 d23-20020a2e3317000000b002d24637063fmr1814686ljc.45.1709835361141; Thu, 07
 Mar 2024 10:16:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220929122901.614315-1-angelogioacchino.delregno@collabora.com> <20220929122901.614315-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220929122901.614315-3-angelogioacchino.delregno@collabora.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 7 Mar 2024 12:15:48 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKrad8JndQhxHAYjFXPkj7eaJ0GXqkSJy=xrfa=EHvOwA@mail.gmail.com>
Message-ID: <CAL_JsqKrad8JndQhxHAYjFXPkj7eaJ0GXqkSJy=xrfa=EHvOwA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: timer: mediatek: Convert to json-schema
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: daniel.lezcano@linaro.org, tglx@linutronix.de, 
	krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 29, 2022 at 7:29=E2=80=AFAM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Convert the MediaTek SoC timer txt binding to json-schema.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  .../bindings/timer/mediatek,mtk-timer.txt     | 47 ----------
>  .../bindings/timer/mediatek,timer.yaml        | 86 +++++++++++++++++++
>  2 files changed, 86 insertions(+), 47 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/mediatek,mtk-=
timer.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/mediatek,time=
r.yaml

Looks like this never got applied. I've applied it now and added 8365
which got added to the .txt binding in the mean time. I'm not sure
it's right though. The txt binding says it was CPUX timer, but the dts
says otherwise. The 6795 dts looks wrong. It says the timer is CPUX
and GPT timer. That warning remains.

Rob

