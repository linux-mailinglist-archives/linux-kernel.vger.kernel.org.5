Return-Path: <linux-kernel+bounces-139234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1648A0037
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A032870FE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA501180A6A;
	Wed, 10 Apr 2024 19:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZaQRep0W"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D66C134CC2;
	Wed, 10 Apr 2024 19:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712775699; cv=none; b=FfkcsW7zplH0pAwGjwL4gMyt5CJ1ZhryJJAOhBxEvCp572N4duvdt4/cPRtR82LG0Xjq83ZSWfQ3JlFwk4tyuNktNsgd5dN9FADLeg7tdMPdIJwgoi7Kg4JvOfppaDXAjbo4lfTvCEceJCNRSP5C81aLuXJ7W6QB1MFxZAvLk1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712775699; c=relaxed/simple;
	bh=3Yq8cuuw7WI6+8aRN0KBuQMrYv4dTTJGQ1IaeMbXNFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xg/CXkq1jRfHRJYo5uvQ0tCBGJWw9eBkvX2YjTg6qhaGVbg+5eNtwbeN6WoA4dt5FqGDrDBp2CGj7+6VdaUyibGLskPhQtJ2grTRGyhaPU1Bq7qD5Y5+S4gbMaV6RwElJbYmiOnRJIo/Hoer25Bu9NWc/TnRdpf+JQBvgU7foKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ZaQRep0W; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e220e40998so45945905ad.1;
        Wed, 10 Apr 2024 12:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1712775697; x=1713380497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQGIuC9fhgYKv0jGpAIt5La8/Y4BHfZvvmnOc5ODMp8=;
        b=ZaQRep0WcKL3iWkLZNPxYRhx3Z0Bgj3j0GcsaK/e9KFVePRuNsMoHtKHKTOu5wyIQ5
         vO3GiVsXV+EksVtj+ItjGy5owApinbW12N/9Kj98taHtZxtNdPRDodCBCXPkpD02JpwM
         j+c7cTMRUXsbnuQSKorSz/Lifu5nEDyy9+QQ3lzo/wSOIFPdtquMQHDTI9XFsdknRaCJ
         6rMIvk/qhcQLSlZdU4Yg4sOS976gsBo8cDjtCrqiL8QjEyuR/q5Cyj8/KA2XblIv+pJN
         vFj0MF2mX9gOJSuhiuIpsThxTylMfsIlt3Pc47DT2yagUEbAlFufHCP6XD/gHkrXbb+1
         MYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712775697; x=1713380497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQGIuC9fhgYKv0jGpAIt5La8/Y4BHfZvvmnOc5ODMp8=;
        b=LjB9RahNsDEbqwoDqLRFZBV8T6cuc5M57bFapA7lG17xhpABWHSqCs2CJ5C6rHisMg
         +Xvs3b3dJ+iIezU4B8a2ESqOzyoG081H0bFVCSQO0NGIkg8YKDNSI8qT8jhA+dEAN7Hu
         ijkr1N/5tOgujYsC5uTMUCIaWxqVNjXYLBy2BmPw2/PNjMClGXTjaj2pR5SdANMvesJh
         Et3DKfooI6G5DW+K6/6lPaBDm8Hs3dN0YsF1Xo8SC9O+28TfDL9HuBSwqzD5vXY0epUM
         ewJZRHCOZgh/1RPNbSw2regD0HrFn6BAt4KeeIaT9altpjAqjTA/RyaCtbVy8zfEtamm
         qBXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbHDcFi9iG40kFCWbRxCQxF6bnWFOIQVdLEoK4i7AAdHWwEkeGR97ujgZUY1ozd169umy3ztYgOm7yWuWkJn89gBQY27zpPOXMjseDTuftHeGigI24cctOXZQbbtT7/kKHAlxl+3nC
X-Gm-Message-State: AOJu0YxsNPwQpI0B/+ZmGIFihISmg1GzbSmD7plEViBU6fviCpRp9vU9
	2ZkWj0YKTZ0+0nCuiLNKsIv56uon9tLDuSkZiKwjVxZgMMcRtfdHGXTQw3m746RM+r7Si389RrL
	sW27UpAC1moI8jNe1xWHwTV1Y4OUDgYDLhD8=
X-Google-Smtp-Source: AGHT+IEROyQwnsZ2mJRiQBK9B8AlbdE6ckE2JKAZuRGsMr3HiSh0XYkFX2esld+9JLkEVgvtnIu/uwZKqkAMsWTRoa8=
X-Received: by 2002:a17:903:1cd:b0:1e0:b6d5:bed with SMTP id
 e13-20020a17090301cd00b001e0b6d50bedmr3490508plh.5.1712775696824; Wed, 10 Apr
 2024 12:01:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410155406.224128-1-krzk@kernel.org>
In-Reply-To: <20240410155406.224128-1-krzk@kernel.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 10 Apr 2024 21:01:25 +0200
Message-ID: <CAFBinCDHp0r7jje9pS4u+2OgiC2LfhHBA1T6OveZhiuKX=jomg@mail.gmail.com>
Subject: Re: [PATCH] clk: meson: s4: fix module autoloading
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 5:54=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from of_device_id table.  Clocks are considered core
> components, so usually they are built-in, however these can be built and
> used as modules on some generic kernel.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

