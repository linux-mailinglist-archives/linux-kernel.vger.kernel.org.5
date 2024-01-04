Return-Path: <linux-kernel+bounces-16668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC207824223
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9631C2186A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8052C22313;
	Thu,  4 Jan 2024 13:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKomG6EL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318272230A;
	Thu,  4 Jan 2024 13:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-680d2ec3459so3360206d6.0;
        Thu, 04 Jan 2024 05:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704373231; x=1704978031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nIrL28BMXphB/rrvwi7A3ipYuJ+0Mt1C/a/HABGUGM=;
        b=iKomG6EL+le/sIir45GMtv5PAFxT7PRBTK+faFt7X+e/unXNc9YONdmW/gyUDmAV17
         x3nvanKAKqnWZrVlvpmukrAKISOfWnMHFIhkFDagMGgXOG/mIKeT+89u9C+/KspABWg5
         Dq3NivLS4ZZQIf5ziuDr3zmJRZB0HV3W1TnoM0bVw7G9x5/iqL2n6ZVFAR7z1wYQQfnc
         Z0YfHa/kOsxbfYX7nh72CWZ6cnNKH9tN7GMhzM9anSE/84LtshAQ8yHVPTLDC1fY4Bif
         0qMOdDIPIIfGKC1yRDYwjAbgT+Nx5E+o3qQRHY5+2RhHjiB9oXbQp61Kh3sLcVpeCPJO
         42aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704373231; x=1704978031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nIrL28BMXphB/rrvwi7A3ipYuJ+0Mt1C/a/HABGUGM=;
        b=MIexvL7ExiDFRI1E6aQUcJZtHCNFUeDaYFhtPealkZixvxRN6x46LpNr2arYCANubt
         bdrmKy5t/shXL5i3jlmljEchRIPaGGMkrfaFv16pNCxDo4jINFPCXjQtk1FqnTz7jAuX
         DqUcirfEgipxm/dQRb5CANnbBu2JT29AKvb5oaB4HQ/uE09VUp5iJ39cuF2uA2hYDQDh
         75q9Gukqp3bl5Fk6JB4zKz1Nb3r+hBUJaUt8Rzg6/h1aSUo5B/pG2MQ7+IgjUTTn++Yy
         6ob4HirWVZT5a7QHjuaUfB6jSET+ptjy/7ORT7Pbj01u0bmVKF9PRIi453yOK0djrnD8
         6Xbg==
X-Gm-Message-State: AOJu0YwhThxLCtPpEdTgnRe97DMZ47nO1BiBEaylQnxfW0RsskI+/f7P
	1nxkwqPr9JIBMda9kT1930OFlxzCK3qGivfznmI=
X-Google-Smtp-Source: AGHT+IHKS4qebg5nUXwf/Jgik19KfX2MEHI198BGYVjzKZ5GC8oFuWwJ5+FRovNxNyd2Vc2zwn7xKgEgDgz3ST1P0gc=
X-Received: by 2002:a05:6214:411e:b0:67f:457c:21ac with SMTP id
 kc30-20020a056214411e00b0067f457c21acmr586686qvb.48.1704373230947; Thu, 04
 Jan 2024 05:00:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104024244.12163-1-Wenhua.Lin@unisoc.com> <20240104024244.12163-2-Wenhua.Lin@unisoc.com>
In-Reply-To: <20240104024244.12163-2-Wenhua.Lin@unisoc.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 4 Jan 2024 14:59:54 +0200
Message-ID: <CAHp75VfdCHnPovC+LJyVsh=SGTLXDoDowd+0z+0J-wDF2_yjCQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/4] gpio: eic-sprd: Keep the clock rtc_1k on
To: Wenhua Lin <Wenhua.Lin@unisoc.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	wenhua lin <wenhua.lin1994@gmail.com>, Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 4:43=E2=80=AFAM Wenhua Lin <Wenhua.Lin@unisoc.com> w=
rote:
>
> The eic debounce does not have a clock of rtc_1k in the sleep state,
> but the eic debounce will be used to wake up the system, therefore the
> clock of rtc_1k needs to be kept open.

...

> +#define SPRD_EIC_DBNC_FORCE_CLK                0x8000

BIT(15) ?

--=20
With Best Regards,
Andy Shevchenko

