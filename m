Return-Path: <linux-kernel+bounces-15685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38617823045
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E07A1C23665
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631E01A71A;
	Wed,  3 Jan 2024 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIUKMdGI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A941A71F;
	Wed,  3 Jan 2024 15:13:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECBBC433CB;
	Wed,  3 Jan 2024 15:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704294792;
	bh=bFm0Z1sKJZItmcrSwYlr++E/l6Wo9Z9RcEYIw1gv8/k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TIUKMdGIxBTc4tUVBKOOy03kAHheVOgCdA51aToMHMZ3YINlt8SR9K5e66IhWeB5U
	 zxG67KSJBbgpwPAaQZff1JkqfEfErcjUrKEWcQx+7DCcDCNvcRAjVmemKiMiHx8n6V
	 4dix+n/6EfSLm7kDjjlcnKTgdyh9wQGxqpO1aT8Ec7FSzHcrCvgeyL7b9IHpR2IMnC
	 hs/h09zfO6J+pln+zbQCz9kEz+9vdjetSzsnVuyS0bhQPOD5Wg3zVo6y30skbhn4pn
	 1C/BgAnXSyByvbAMPPs9eeEJFgaONm+1RmIACU2lPkn8cnZjrUQZhX8tQevBifBfFf
	 QmmgCKVUQaRJA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cc9fa5e8e1so114008371fa.3;
        Wed, 03 Jan 2024 07:13:12 -0800 (PST)
X-Gm-Message-State: AOJu0YxHmCm3TXmE7jYJzpLvY5VRIi3LGCy987pZPjZmwJq3ra6rfXV/
	dPu/KttpdmpJxPbNjUn4GltKf/KN4yxSAiLPYw==
X-Google-Smtp-Source: AGHT+IFSlj6nZ8ZUfTGFMSFmV/q5bvx3ay0bqNUHIfGx+Gz9YS2Lv41/6TR2DLdMKsWU/APCPg4voqSUFRKuaq9MzdA=
X-Received: by 2002:a2e:98d5:0:b0:2cc:843a:ec97 with SMTP id
 s21-20020a2e98d5000000b002cc843aec97mr7360555ljj.43.1704294790370; Wed, 03
 Jan 2024 07:13:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103142051.111717-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240103142051.111717-1-krzysztof.kozlowski@linaro.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 3 Jan 2024 08:12:58 -0700
X-Gmail-Original-Message-ID: <CAL_JsqKAKNHz4wPuJPX7ULhVUz=KFRtNn=coWhs3d6LWk+jtGQ@mail.gmail.com>
Message-ID: <CAL_JsqKAKNHz4wPuJPX7ULhVUz=KFRtNn=coWhs3d6LWk+jtGQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: thermal: correct thermal zone node name limit
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Amit Kucheria <amit.kucheria@linaro.org>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 7:20=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Linux kernel uses thermal zone node name during registering thermal
> zones and has a hard-coded limit of 20 characters, including terminating
> NUL byte.  The bindings expect node names to finish with '-thermal'
> which is eight bytes long, thus we have only 11 characters for the reset
> of the node name, not 12.
>
> Reported-by: Rob Herring <robh@kernel.org>
> Closes: https://lore.kernel.org/all/CAL_JsqKogbT_4DPd1n94xqeHaU_J8ve5K09W=
OyVsRX3jxxUW3w@mail.gmail.com/
> Fixes: 1202a442a31f ("dt-bindings: thermal: Add yaml bindings for thermal=
 zones")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/thermal-zones.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml=
 b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> index 4a8dabc48170..bbc883fd4044 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> @@ -49,7 +49,7 @@ properties:
>        to take when the temperature crosses those thresholds.
>
>  patternProperties:
> -  "^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$":
> +  "^[a-zA-Z][a-zA-Z0-9\\-]{1,11}-thermal$":

Now off by 1 instead of 2. It should be 1 starting char, 1-10 chars,
and 8 chars for "-thermal".

Can you also add a comment that this length is due to the kernel.

Rob

