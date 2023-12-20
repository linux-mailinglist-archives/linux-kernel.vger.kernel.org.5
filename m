Return-Path: <linux-kernel+bounces-6860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8448819E9A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0725A1C218F5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DCC21A1F;
	Wed, 20 Dec 2023 12:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J+jleEFa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FB7225CA
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 12:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5e82f502a4cso9480347b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 04:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703073808; x=1703678608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7KfOLNy/6GgxQnOTO2g/ZHm1XcTVDhhqMNRL/JKAVw=;
        b=J+jleEFaZ6TIYclD4PQOIonnZfXEK9Z6C0TiPvJNcSQRI+8ms5SSkbxuJtokLOlU0J
         wPuc41fX+a+GuYgChrBgFtHZRF6oL0/ZVkLFgYY8tFyUaaPyDufzHCE+JEtzLQtOg78K
         xph9bb60P/YABo9S1AyP2ZDTophdOuPSFitu0NEGXQjD4nCBL2VxdWXSHkB6MJghGBT9
         lrH51I05tvOjEp+OdL+a+EEI4/5oyymUxE51eoGNdvUxMP7qSPrarR+R02O+ekf+IILJ
         nhSoL9iAt8grP85ioexxWq89TT/jKio9Bfmf/V1XH3GxyNq5uk4uTddu4iHfqTgAxlfv
         rvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703073808; x=1703678608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7KfOLNy/6GgxQnOTO2g/ZHm1XcTVDhhqMNRL/JKAVw=;
        b=Ew8tjDnOsB2g+/K2Iii/vbxmy3W8yuw6M7vsdIHaJKE5He9yX6AvU1PNZeU03/ATnZ
         lQVuJrzxKkVl4Lo7lhixjtZ5a4+Tri+fbGnRWMgQo5OSSh/aG5AnNkRV0+eIeDTZvR3C
         1y5/pXl69K3qkAc+QApFKWE8HM1oVeS1eqzrw+CLwzX8i+bIjjP4sdCwZfR5F3ciPx5w
         4GFlgITF4QGlm/hi7rtKuJKl21lYo+JEYJ/KoKZ84nBpU4L9/aaid5OrjPlcpFmvOy/H
         ncciBOMgriVs6hUjfOyHQsMXap6rIqYAMpkiLHlgNoisaV9DlJCKjLfSGuV3TDb7nokw
         beRQ==
X-Gm-Message-State: AOJu0YxzyOtbK6yys2Pni6SnBEn4BXWCfB01324ycykXnZs54NVlq46f
	utuONQQn5/yS1GUcFavtuj36HsrQgjOH1/EGbhVP/w==
X-Google-Smtp-Source: AGHT+IHq226PV5Y6ea/o/Mqcbuu6CEww47a289jWoxU6UrTvZHZpqreR8lMz60qHcyTdLKhizbHRBA23IMXeAcTadSQ=
X-Received: by 2002:a0d:ddce:0:b0:5e7:7c40:eb1b with SMTP id
 g197-20020a0dddce000000b005e77c40eb1bmr1775193ywe.31.1703073807813; Wed, 20
 Dec 2023 04:03:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219125120.4028862-1-patrick.rudolph@9elements.com>
In-Reply-To: <20231219125120.4028862-1-patrick.rudolph@9elements.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Dec 2023 13:03:16 +0100
Message-ID: <CACRpkdZAYbY6Uk6mVdeQRKOWkO3R9RNs=Tdj1KFE6D7stiEEzQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] pinctrl: cy8c95x0: Fix typo
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: naresh.solanki@9elements.com, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 1:51=E2=80=AFPM Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:

> Fix typo to make pinctrl-cy8c95x compile again.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>

Given that the code doesn't even compile I just applied all three
patches as fixe for current.

Yours,
Linus Walleij

