Return-Path: <linux-kernel+bounces-6814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4308819DF7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 756691F22126
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EABF2136A;
	Wed, 20 Dec 2023 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N4tdfm6w"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D53421353
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 11:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5e637faa52fso27600277b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703071500; x=1703676300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MkrPgvriaapHgxKhH5dFZOwr9TJ6NZGBv+hFxrYVcA=;
        b=N4tdfm6w4BaZ1RjD+QqfLPJQX5NEvCfdaK/LBT7/Y1b3OwAUrqbn8ZVy34LfAqmeGq
         DxKxUXtNzJMf9VbA0sVOENqJSRTSMJyBzIUQKsEQDnDDr4vcVi8+36n830A8wji4ros5
         G6MZ7e/OyNIe3LLekhGXeAcuGvbiW5PYaNJwZ8GkJdz6fUm9aGpmENT98ygnn+7nfLyL
         HfG6k2/1A82E6JceiUze3cgTduYGWsqG88psRHb9jeUEu9YtFwIIx2T3e53VlEQ+b/ST
         hDJm6g0dagg8Kybt7d86PXYj3j6Lgxp9k8QAkcYNFrlcN0BXj3WLljx8IyXjqXB1jU6p
         nmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703071500; x=1703676300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9MkrPgvriaapHgxKhH5dFZOwr9TJ6NZGBv+hFxrYVcA=;
        b=QRPsVYIsNZ/YDwqmNtwHf3EinTuKD1cDqutaCC+ZzrwhAFMxZfVJP6xidi6LHcTZy1
         u8E3GdVadlFoDdids2hYzbHbS811t9i44AEDhIWMsux49NCaYSSY7j6tHC7OcMGIvuf7
         OwOuRq0UcId+zsR9j2HkWs6haE1oL2KkVu0vuAcbC+m7PExPRp+KZVjINyYWqIUTCwXQ
         Bd2oGEjq1WhjIJZItB7UTxSfUx+4Tm9KrobZIV3I4iKxU/zM8kS+1iLN62nyp4DhW8RE
         IjbklAh5mJ20ohDeEjUJrj3LubaOEPVT2FEcuyRXA7v0o/JbmjlZrWhM7WWDP9ObqCoQ
         pCvQ==
X-Gm-Message-State: AOJu0Yx1+3yKppD3vgWLiv2YXpqQolBJLIC4ZuQchix9Zy1qbjIhgJUP
	t/eDIgqOvo+9NRy/Z8RX+7PxYH3MoojY0BB9P4sDhQ==
X-Google-Smtp-Source: AGHT+IGABd8YUhwXb+wGSiQelsWGkfNMOgeUo8f9/5IaSVjpAM9VOFyxBYFQZK2uj2lA/FDLpNkMdI9OxdIES+0iFMo=
X-Received: by 2002:a0d:c3c6:0:b0:5de:7a72:3577 with SMTP id
 f189-20020a0dc3c6000000b005de7a723577mr15710645ywd.58.1703071500506; Wed, 20
 Dec 2023 03:25:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218060834.19222-1-rdunlap@infradead.org>
In-Reply-To: <20231218060834.19222-1-rdunlap@infradead.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Dec 2023 12:24:49 +0100
Message-ID: <CACRpkdZqf0osxfBT2n-Gri4CiQpFgKUkXOsp3W=UrBGN9vQ=_A@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: std_dma40: fix kernel-doc warnings and spelling
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	linux-arm-kernel@lists.infradead.org, Vinod Koul <vkoul@kernel.org>, 
	dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 7:08=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:

> Correct kernel-doc warnings as reported by kernel test robot:
>
> ste_dma40.c:57: warning: Excess struct member 'dev_tx' description in 'st=
edma40_platform_data'
> ste_dma40.c:57: warning: Excess struct member 'dev_rx' description in 'st=
edma40_platform_data'
>
> Correct spellos as reported by codespell.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312171417.izbQThoU-lkp@i=
ntel.com/
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org

Thans Randy!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

