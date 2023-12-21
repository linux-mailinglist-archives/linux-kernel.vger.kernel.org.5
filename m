Return-Path: <linux-kernel+bounces-7683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9A981AB98
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACB79286DF5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEED91367;
	Thu, 21 Dec 2023 00:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E8lOxwu0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC3110EB
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 00:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a2696852965so201661366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 16:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703117939; x=1703722739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mYEduXCSX53GxkPa+3HzLZx264zuWEFs+pArKbO8ws=;
        b=E8lOxwu0k2StF/mgd9M5IdUJUlM7u/C3m0ggaJS8Ouaptnvp9Amaoaoq/2LNfGZ75s
         +85dlkjuuqi0qJV57WxAZRss4ZV1WtvvfEYT7VBKHq/TbeP5SOEU4f7ntfJ17Rn9y0W5
         ZJykDLcAuJiB7zfm+SABQOO0CVZEzLL5puBDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703117939; x=1703722739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mYEduXCSX53GxkPa+3HzLZx264zuWEFs+pArKbO8ws=;
        b=s//TnMdYHcY9D/SsrjuKgo0LRRhCLYeK70h+Dk1lIwFdJke44/vT5bPsOkAUQ9Pjs8
         nDwskSjDM6A8EwlGLYrw5FEvRyP0xaab69FMtym5ClKi0gmUZCZo08yFK8/aW7G7/9mm
         VbHvoyucM3US2bjaahmTMcos7SrjHKlAS7chsLVkHrck5jAjvRkk5jsrwIy6sgf69t4t
         js8qOYPdz7RLG+lBYY+jG1Zi4QQGiwhUBR7zTCpH9q4pBK/86CbtQMWaO70bVZHMT6aB
         LC4FqsKaeKG5HWw2avltIX4rRHY2oWtS2qqNVOaQ0dVK+EuG1dZ8DMZ7WFTrmJ34rhHV
         BetQ==
X-Gm-Message-State: AOJu0YzS64uBm9qQ3r3oqE97di5uLRjEs9whOcpfqmH/CYndAAStSTKl
	VHXgMIJ+qzYfhvkYjxsbIJOVUtnyLW0L8Yy9j76sVINe
X-Google-Smtp-Source: AGHT+IGqtncv2qRAvtgYkizHsPsCf/C9RwQCBlZtRj8UsjBI/N5hXQPwkjkhLsd2nXj24UNJh36kTQ==
X-Received: by 2002:a17:906:74d8:b0:a26:859a:87bf with SMTP id z24-20020a17090674d800b00a26859a87bfmr2489352ejl.4.1703117938734;
        Wed, 20 Dec 2023 16:18:58 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id z17-20020a170906715100b00a26966683e3sm353378ejj.144.2023.12.20.16.18.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 16:18:58 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso1956a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 16:18:58 -0800 (PST)
X-Received: by 2002:a50:c316:0:b0:553:773b:b7b2 with SMTP id
 a22-20020a50c316000000b00553773bb7b2mr3837edb.6.1703117488506; Wed, 20 Dec
 2023 16:11:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220235459.2965548-1-markhas@chromium.org> <20231220165423.v2.15.I870e2c3490e7fc27a8f6bc41dba23b3dfacd2d13@changeid>
In-Reply-To: <20231220165423.v2.15.I870e2c3490e7fc27a8f6bc41dba23b3dfacd2d13@changeid>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 20 Dec 2023 16:11:16 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XwT62H+eBH-PRfQPH-X17_BmWQd5wrHTj6o8Zxkf72sQ@mail.gmail.com>
Message-ID: <CAD=FV=XwT62H+eBH-PRfQPH-X17_BmWQd5wrHTj6o8Zxkf72sQ@mail.gmail.com>
Subject: Re: [PATCH v2 15/22] arm64: dts: qcom: sdm845: Enable cros-ec-spi as
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
>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

