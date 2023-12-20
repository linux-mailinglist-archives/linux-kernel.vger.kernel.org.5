Return-Path: <linux-kernel+bounces-6845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDE2819E73
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1459C287ED0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E56F21A04;
	Wed, 20 Dec 2023 11:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jjSEIKK4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291F0219EA
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dbd721384c0so1297230276.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703073050; x=1703677850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENZiFDY9dzKiwXJYDovPLkS8MWEkOTJIkD9WmcdrBZo=;
        b=jjSEIKK4D45vt/gyDc5n/5UxVF9ihfxZwtEHLqAFcW8863BrXxRlxnYfS2dpl6EKWR
         ZsUij8XcKwMiM5URfPYdGZWLYtSNl4bN/NiCa65w93YAMpcfMGk1GpkHzgAVI+3VcX4S
         0jC5nHhEVf3AzQNpB3G3fGbEs0cKva4x8RjwyA6dGaX+McODSWdNmIwyH3M3cvlbMuFB
         jBYhEQfGbjE92uN46lasHuMPvQPwNPUJg6pPmaX0t8Bjx5Kdf8uVJLp7IT5FvLkRZ8Mk
         qBhKXjYQ26tfHRKxjVB60lC87+M5WBinBYSJfNgx3pnL7+He+uekSbN9oK7KIwSOahZP
         KVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703073050; x=1703677850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENZiFDY9dzKiwXJYDovPLkS8MWEkOTJIkD9WmcdrBZo=;
        b=hxcQR+HYKTUsN3TshkqJ78XG9pUpKdl5nEK5qLV+gcvMxjaRA8V0DXP3CdM6dUfw3K
         O4WVB0X2fcoB4SZ/wqfCpIWNup7jEs8rgVWbT6gy8U680e0VKrw2eq9A/0TpKPfU9cCX
         SPZG51YxOFqnQWCXdUr6/0GE9gqsytbuEr/Mf5tL4PfdHGK4NWqFj2M0inql+yla+X26
         uxymlfRqqEzSCyH1oks7gNll92A50syNtudBwSJzA/+qSNbhlAHk7POuQsRV+bxtwUbJ
         YEtltPSDfEQ3I+CigXHxIG01I3woaHedYwsdBeTbTofhNJI1GD5KvG3W6pBGJ1rNjkXO
         P34A==
X-Gm-Message-State: AOJu0YwvwkTeRp8EvDuBZEGurm0S22jq/hIRmncUlbTT2VZ/b3noF6cW
	kKkbguJHKM7DRxqmT31xLG5jNIei9RfZSFQbP0tqmQ==
X-Google-Smtp-Source: AGHT+IGEpNhS7yXamseKl7c1M4nKOmbpO4zGBeq5d3MuzpWLfieU9qZ138SjQ+sOe4ye8yDBnUE/BHY/uK8F2xi5yYk=
X-Received: by 2002:a5b:306:0:b0:dbd:45f0:9eaf with SMTP id
 j6-20020a5b0306000000b00dbd45f09eafmr2570179ybp.114.1703073050151; Wed, 20
 Dec 2023 03:50:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2e3a1f1f57cf929bd05115bc081e6d01d5a53443.1702996859.git.michal.simek@amd.com>
In-Reply-To: <2e3a1f1f57cf929bd05115bc081e6d01d5a53443.1702996859.git.michal.simek@amd.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Dec 2023 12:50:38 +0100
Message-ID: <CACRpkda4nqcBpF6Xv2gAS9QzrmWOTeKi52Fe1qW+t7NuM2i_ZA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: xilinx: Rename *gpio to *gpio-grp
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com, 
	git@xilinx.com, Conor Dooley <conor+dt@kernel.org>, 
	Krishna Potthuri <sai.krishna.potthuri@amd.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 3:41=E2=80=AFPM Michal Simek <michal.simek@amd.com>=
 wrote:

> Anything ending with gpio/gpios is taken as gpio phande/description which
> is reported as the issue coming from gpio-consumer.yaml schema.
> That's why rename the gpio suffix to gpio-grp to avoid name collision.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Patch applied.

Yours,
Linus Walleij

