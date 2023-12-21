Return-Path: <linux-kernel+bounces-7681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A885781AB95
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAD901C23933
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B36625;
	Thu, 21 Dec 2023 00:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ao0zN5c8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E77E181
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 00:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55361b7f38eso284621a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 16:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703117854; x=1703722654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAV5X+k1qQI1nOHUSW7EkdUMeMAYS/98mQ/cpqxd4GY=;
        b=Ao0zN5c8zV3VPNmJ7fIu/iYd8SkNJBOHePjTYpwPIzCXoShNQJXY1tcJ2PX1FZxkPb
         JntXZW3mEVk6SRy35Vj/W+7Q0oHvP8jlBISE2ZiT6R2E+rR9UGbGuhVEDjZR5ge2R9rv
         pm/4qJXBEzFzvYTCRpNanv6maJSOGfgsZB9m4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703117854; x=1703722654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZAV5X+k1qQI1nOHUSW7EkdUMeMAYS/98mQ/cpqxd4GY=;
        b=ZDJRbwn5WzoUzAf+auSXJXw69vzuGLUh/yegMidNJCGelU94hW1NpGdZuSQlOVnSy7
         0Gm9NhSQLW+57rRD+AfU27n04CAS2X03gcVpvrDyHAcupIRtDkOL01XXCW+Kq9JRaAc0
         l2VV9V7tsFIH6DTRo0po3evReSBqYUtQabm7XDRHYb6AJCJSa2eZPWwCLW0Kz9/UiUPT
         xpWhkcejK377MA9RYRUosV1/80LfaBadZ6jGsxhdCYW4BW+RIEjkjDrdtIlJ423xuDPx
         Va0San2C6b1vuqYcGRcj7P+8GCZ4C9bUBQyQeWAFeVeIeAiMuVeGESXnpqVAdwCZXB+r
         gClw==
X-Gm-Message-State: AOJu0Yzy1vFxynzTdj3klZ/m0PestA0SY1heQqNfosfTBXsZL8HDbSZo
	+TqTvRpEyk60UGDGih4SqM5SR8r4RA0qi6nsSaoV+3Uk
X-Google-Smtp-Source: AGHT+IGaky/xYoJL4esuEzHCOteS5kdez39zCLgr5zG472yHsCCl+vCiAKzr2xx4RT9k1bwZLrR8sA==
X-Received: by 2002:a50:c311:0:b0:553:dcc7:f797 with SMTP id a17-20020a50c311000000b00553dcc7f797mr591687edb.56.1703117854635;
        Wed, 20 Dec 2023 16:17:34 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id i21-20020a0564020f1500b0055344b92fb6sm427031eda.75.2023.12.20.16.17.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 16:17:34 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40c3963f9fcso8685e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 16:17:34 -0800 (PST)
X-Received: by 2002:a50:f60d:0:b0:553:6de7:43d7 with SMTP id
 c13-20020a50f60d000000b005536de743d7mr3379edn.6.1703117474444; Wed, 20 Dec
 2023 16:11:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220235459.2965548-1-markhas@chromium.org> <20231220165423.v2.14.I7ea3f53272c9b7cd77633adfd18058ba443eed96@changeid>
In-Reply-To: <20231220165423.v2.14.I7ea3f53272c9b7cd77633adfd18058ba443eed96@changeid>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 20 Dec 2023 16:10:56 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WE=HhcBQVVtbm7ev3-MQzeaXuoaRL7WYr0c7-Uhv_v3w@mail.gmail.com>
Message-ID: <CAD=FV=WE=HhcBQVVtbm7ev3-MQzeaXuoaRL7WYr0c7-Uhv_v3w@mail.gmail.com>
Subject: Re: [PATCH v2 14/22] arm64: dts: qcom: sc7280: Enable cros-ec-spi as
 wake source
To: Mark Hasemeyer <markhas@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Raul Rangel <rrangel@chromium.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, Rob Herring <robh@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Bjorn Andersson <andersson@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 20, 2023 at 3:55=E2=80=AFPM Mark Hasemeyer <markhas@chromium.or=
g> wrote:
>
> The cros_ec driver currently assumes that cros-ec-spi compatible device
> nodes are a wakeup-source even though the wakeup-source property is not
> defined.
>
> Add the wakeup-source property to all cros-ec-spi compatible device
> nodes to match expected behavior.
>
> Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
> ---
>
> Changes in v2:
> -Split by arch/soc
>
>  arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 1 +
>  arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi | 1 +
>  2 files changed, 2 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

