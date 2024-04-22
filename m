Return-Path: <linux-kernel+bounces-152785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEFD8AC42F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2F3A1F210AA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160ED41231;
	Mon, 22 Apr 2024 06:28:07 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E642BAEB;
	Mon, 22 Apr 2024 06:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713767286; cv=none; b=OvOMs0KMz/+k/1tPVNNCDgDLmXtdV8n46Pk7EPmLDu9yYQw9gr3lzIyyLfNRahGY5nhe444G1qmWyaewpbDF15PDH5S3N4ScBA/fyFSfo9SW0YRo6Zcm9OxYQWMqJIzp8z8JE0i2NnPKRZPNpOroRlQmsC1q/jC06MEtzUv6DxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713767286; c=relaxed/simple;
	bh=3nJxs6KDCzEvXDgS/hhsIWpVpzHE7gksU4iMi6yQ1hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t4dmNAmKlgGzuQZI79cM6ihlASdbOpVg16IJvQpNX3+colh8IU46OCkNU6pci+AbLvpOTv5GJ9saxNqJV5+NP0VKz1J2+iyRobJQpXH18a3TMcSZrObiAGRnGOwI+9fHidYKPtulmaa84i54/xDY1Ks9wZgm7BZDp/BcLGieWao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51aff651083so1362089e87.0;
        Sun, 21 Apr 2024 23:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713767282; x=1714372082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3nJxs6KDCzEvXDgS/hhsIWpVpzHE7gksU4iMi6yQ1hk=;
        b=MLVhyW+t5RuTPk8rdyC4iVp8KCnZRE3eIHbG0dCEkel4H/RiLh0IUggs17xUVnmwsg
         UF0Szpwjc2JLCz9+vePot4p6UsAOnODQMPGp/RvNRj65XJcBevzr3Y4lPueGMOyT2516
         k1PyJi2OAWU4Ztn5P30ifZe/kprSLpJJ5E1SgS6VyPh86Sxjc8lQVhKTKe/KHyL9qDqk
         fwE7TgL9Qm6y8TaJAyrPNM69Mve3G/xYQpsEEOl4T+7Bv+9b2Av4RyV1aScEfoEQUyWq
         6fo/OqKyFor6SxpjfkA6g6CxIBAdIXu5nBvZsEcSOubPMoZ3yrwPso0yz32SohQsdcXq
         vTqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqOkrdZ6RGJQimd8xlem3EJ5tcbW7/hC4JHwQoP4LYSW9AtlFy/hAQnmJVW56K4PmMb4ZnnTS21SHthalBe4ZCwBn9tP+TBr+4m45MLU9/ZFLAgCU+Eew12umcD+MD3Xzl7RBelW0=
X-Gm-Message-State: AOJu0Yx49Zj8SCC94daFSY8KCQNGQ6/Y2IBYwD3S7UPMCsCkz4zg6Lxi
	ST0dSb+KjY+acXGEKwu0l3+QrOhVfUayGy8zLyCxilPZA2EMp9IDZ/y+UVJcQ+Y=
X-Google-Smtp-Source: AGHT+IEt5yS0ewKc7shXUG97ACf+yNKsqItvuEFDXLMLDhmn/DX4qA8eS3MNFUWRTsEWxMneBsXMhA==
X-Received: by 2002:a2e:988c:0:b0:2dc:d7a6:1e53 with SMTP id b12-20020a2e988c000000b002dcd7a61e53mr5225067ljj.18.1713767281985;
        Sun, 21 Apr 2024 23:28:01 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id w25-20020a2e9599000000b002d9fd8b0670sm1379958ljh.123.2024.04.21.23.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 23:28:01 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d895e2c6efso60507361fa.0;
        Sun, 21 Apr 2024 23:28:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUh1g9yP3eRttwc3gRzkeLno00F7C498HUgTq0yFaa81DEebeNDO4R/O+0husHxhYyGE40ADkbaamiF1+4WxaUxkfGTiBVovKa03KE4cA/ACa/V9gbuRAiXaJ4vcQExhb1UG10MyN0=
X-Received: by 2002:a05:651c:608:b0:2dd:97e:3481 with SMTP id
 k8-20020a05651c060800b002dd097e3481mr3120608lje.51.1713767281436; Sun, 21 Apr
 2024 23:28:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <285de20a187f3e4baeb28f639b5bf55e914a3821.1713756666.git.viresh.kumar@linaro.org>
In-Reply-To: <285de20a187f3e4baeb28f639b5bf55e914a3821.1713756666.git.viresh.kumar@linaro.org>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sun, 21 Apr 2024 23:27:50 -0700
X-Gmail-Original-Message-ID: <CAGb2v66X94Y0zkHxNLb1KCoCR+q+z-mCm_21eUJ_C7D_srhDkw@mail.gmail.com>
Message-ID: <CAGb2v66X94Y0zkHxNLb1KCoCR+q+z-mCm_21eUJ_C7D_srhDkw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: sun50i: Fix build warning around snprint()
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Yangtao Li <tiny.windzz@gmail.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, kernel test robot <lkp@intel.com>, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 21, 2024 at 8:31=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> The Sun50i driver generates a warning with W=3D1:
>
> warning: '%d' directive output may be truncated writing between 1 and 10 =
bytes into a region of size 2 [-Wformat-truncation=3D]
>
> Fix it by allocating a big enough array to print an integer.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404191715.LDwMm2gP-lkp@i=
ntel.com/
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>

