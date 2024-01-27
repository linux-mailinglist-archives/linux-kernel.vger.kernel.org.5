Return-Path: <linux-kernel+bounces-41464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 609FE83F23F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 00:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 014F1B21FD0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D75E22F05;
	Sat, 27 Jan 2024 23:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pz3t44NH"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C242263C
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 23:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706398653; cv=none; b=Pq/pkXDEKiL15eO2GsJDUtQDowKOm/YAsfKZ/YCksr+6hoODuX+Tsh+57JdlO37Pv7S9x7tGCT548YxqIMmoAwMQ3pfcwC6nGuDxXZ6aCcV0+HrEGXLMgkEirXWlz9zXNajx0Kvy+X6yhzGYSAFsVXBfF76+Y9peeoNwxgrId+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706398653; c=relaxed/simple;
	bh=jb6WzNOjU69Ryl5VimSWdc7WcJrT6NYdCN35vtE0l8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qus+lriwwlhAla17VKglGvFEkzQCy/w3wu+5oIZnPJiktYvW0OFRkvva2mIRQaST2l0z4hhKIaudA+p39Vpdu0JBGUpBhZ/5xgtkV7jrTLmFJQOMx8EZG0bFHsjlhxvrOF08LLKRXQVFzE/T5SfOu83pqQQ7mdbaTM6N2bHMQtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pz3t44NH; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5961a2726aaso1069920eaf.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 15:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706398651; x=1707003451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jb6WzNOjU69Ryl5VimSWdc7WcJrT6NYdCN35vtE0l8g=;
        b=Pz3t44NHws+MW6CPKZkXfaUZxr5+ibUMP/khUegDU+QMX419n60XIKmM2OlyACmt/K
         2nF0ffY674tqINF1lgjv34C9B9zDHb/XczUJcI16706Lxk/+GO1BLNdyQVItEi9jyFbJ
         82/9DnwAKHzXxwDMRsWM1vCQgmPg9DC4qGEnyVlsVG5DwII0z0lC2OHWZVw1MwJiZTCT
         G9MdzhlIMbncS8sO/m0OVkzZpp3aNj7mWyrUrFQpLIjVUcEKwUHVozoz83EKHsOAQuy7
         3e9vLgFJYlfYDAnFU98wEBje6DGt68kHyxSPYNFB/ET3A77MZoJzVeMDM4kYmagd744v
         cD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706398651; x=1707003451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jb6WzNOjU69Ryl5VimSWdc7WcJrT6NYdCN35vtE0l8g=;
        b=pjqj6eunQWCMn6SGhtIQwZzeYi/I25WLoKroeBALIUnXZ77iNtWPmFzX7dtTNLjh5Y
         WEy1bqptth32Et7wKcUjehCWLgXXjCyWuH55C8HJgF7DDnIOpuflhImyX+UALW61kVNs
         hjIXn/izgVOQGdO6pswcKkB+MuRro0fms+ha4lTQal0Jutx3IkigytIvwGafK98pJDr4
         +47meW2cfSusAy2H8IzOqyP34wfLS6wXwAH4B1tPT4o9AEJiG5gcfF+pqok9VggYucTK
         NsjS9InXh1dMbbpdEcmEwcsr75wj9nAYHnFAV71DbiwUprQTbNyeEbTaZEb2ck1wNaZv
         0B4g==
X-Gm-Message-State: AOJu0YxMuTudHsDhXymQLGkdpUCnwBkYEqBjzUWvxby57KgU6sjEWYoz
	GJIhFv5VghkTStsT39SK5z5rIx7O0WXziNquilpThXOaPpqswdGfc+sa+dCBgZ+f1J20pmMul0o
	VsZvaUDlQb5wsM1mUcMR97c61OZPSVwiz+proUQ==
X-Google-Smtp-Source: AGHT+IFs1SEre5NR+L5aDvXgbQuHgUDG6N0Y5iH1sPtUeHn1yOVyVhTtmjBICXXTiujpD+0Wo9kngI/E6d4tsay4770=
X-Received: by 2002:a05:6358:24a6:b0:176:351:377 with SMTP id
 m38-20020a05635824a600b0017603510377mr1356541rwc.38.1706398650988; Sat, 27
 Jan 2024 15:37:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111045126.13768-1-rdunlap@infradead.org>
In-Reply-To: <20240111045126.13768-1-rdunlap@infradead.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 28 Jan 2024 00:37:20 +0100
Message-ID: <CACRpkdau1QDDCWviEd_aLqokesFutDeorAbWgVYTW09bA9mdZw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mt7986: excise kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, linux-gpio@vger.kernel.org, 
	Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 5:51=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:

> Fix kernel-doc warnings for enum (anonymous): the enum values are not
> documented, so don't indicate that the comment contains kernel-doc
> notation.
>
> pinctrl-mt7986.c:68: warning: Enum value 'GPIO_BASE' not described in enu=
m '(anonymous)'
> pinctrl-mt7986.c:68: warning: Enum value 'IOCFG_RT_BASE' not described in=
 enum '(anonymous)'
> pinctrl-mt7986.c:68: warning: Enum value 'IOCFG_RB_BASE' not described in=
 enum '(anonymous)'
> pinctrl-mt7986.c:68: warning: Enum value 'IOCFG_LT_BASE' not described in=
 enum '(anonymous)'
> pinctrl-mt7986.c:68: warning: Enum value 'IOCFG_LB_BASE' not described in=
 enum '(anonymous)'
> pinctrl-mt7986.c:68: warning: Enum value 'IOCFG_TR_BASE' not described in=
 enum '(anonymous)'
> pinctrl-mt7986.c:68: warning: Enum value 'IOCFG_TL_BASE' not described in=
 enum '(anonymous)'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312110210.x3vxq42A-lkp@i=
ntel.com/
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-gpio@vger.kernel.org
> Cc: Sean Wang <sean.wang@kernel.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org

Patch applied.

Yours.
Linus Walleij

