Return-Path: <linux-kernel+bounces-146894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCADF8A6C96
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2012822FA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF9B12C49E;
	Tue, 16 Apr 2024 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sp13Bn2q"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D134B12C49A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713274421; cv=none; b=tq67H3/TdKekp8sEhPWmEAfnFy89n25bF7/A01f8ITPinkRUBhSFH3RfSOjdAfJQXlWfDvIy7BDwcpetzhh4fUPjSsk33FdfMb7r0povRZXxpxWIGCWp8UoKD/SplK/Gyd4BTdb9+EpEJmmD8f02cWcjBV85Q4HiRMhBCDPJdAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713274421; c=relaxed/simple;
	bh=xm6C2Ao4ypYVX1MhC1/uBnS+FZuFYDGrl9Ts/4p+yMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eoOCjmVE/qYHOJUVU4yAueJs76uJFow50PbBAVM0MqFfpDUepx/XhixGvAlmymx8J9F5zL1tSoC75HjxFn/Y7lECii9EFjWCTkB1LEHBlfCv7K+T8K9e8COjt02q+g9Mg5BOvhOHZkCy5gxNMa1TITjkHBjIiR7r8omaPw3b4Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sp13Bn2q; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dd10ebcd702so4110180276.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 06:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713274418; x=1713879218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xm6C2Ao4ypYVX1MhC1/uBnS+FZuFYDGrl9Ts/4p+yMc=;
        b=sp13Bn2q9evfeJd9EipdsvPvJJ20fsLxtu0e2T4sOIsoVi6tEwHFgTMPr5hJ4xvL3+
         /XdlATepihbkYiwQOGMiQDKuWfJuUPxUKDbuB1868msZGPLH4GWxbaadktcuzaeRHXMO
         tuViVW0TSHIgH6skftZVOmR8Fhkg+9pMlPtQ8AQ7RwXLqRr8H2N4R+feh4gRPn1fIYcX
         /hhW/WFC0qy9cyzSZxT1fNQ0o+1rIFQkUtLBrqYizWYrrDK95ubNBUibgZGr7HU8fmKR
         8CXciflHH2xxD7qZEqv0QauO8hzpcjneMx+nNtikSGMwFLA6/crxNdOJvXptr5Ir6E5z
         UO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713274418; x=1713879218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xm6C2Ao4ypYVX1MhC1/uBnS+FZuFYDGrl9Ts/4p+yMc=;
        b=DOU3A6LyR3CvXUmIyzKbSDtoOYJma7TMF01Xzd9K/9yJPwp8vZykmrVrlra/op0Yi1
         zG1ViNI1fJW4wTIZBfbVwJ754gX/6pRlzVD610aYvM+OVi5zEGnk/7xXf9BRdgXdr0ue
         IxE+UZO9uaHaWPx76JID14cerk0WTtgoItC/eGlcmMWG7Bz/M/NPf1L4VQbgYOKiAGGw
         I1O1G1gTRLwWHhai6AhoRQjwAXZN8gi1WE1tk0HZUvrVdLDzRlqsNn/Ufi/NfhbyLrYX
         MAJSd4awMFt/F0yEXKStP6CLpe/nto0OOkUJ+uV50mCVbwY8rHSHA5vlHgvAi1ZFchHj
         M5hQ==
X-Gm-Message-State: AOJu0Yx0yS2PinbM9nKTJ8kFUwNYZ3A82XXVHGBR3tYzZ3sfqEQH3rbw
	7RYAEB7qbhSTuAiP5pMIAWFWB3Qoh5mm4XBZD7YhLg9BAt0P7cDFLv9/cTQBABxuWhJE+gZ1+R7
	6pjWmFdXmvmUfRGnNThI3m9as7sP/DneQY1bOig==
X-Google-Smtp-Source: AGHT+IGhXYN8RFtzdBC2XFtqBYQ0YqRkDw4rw6+jm0oCglv8rsHArIyTep+NJikgb3knd6W2WrjZHHfgC8IvOHzqHkA=
X-Received: by 2002:a25:3341:0:b0:dce:1871:3d30 with SMTP id
 z62-20020a253341000000b00dce18713d30mr11319804ybz.21.1713274417844; Tue, 16
 Apr 2024 06:33:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415105328.3651441-1-zengheng4@huawei.com>
In-Reply-To: <20240415105328.3651441-1-zengheng4@huawei.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 16 Apr 2024 15:33:25 +0200
Message-ID: <CACRpkdZz0zD62T8cxXQkTjkR58CZ3_0uVr5F0Amy0Qa9jrc3nA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: devicetree: fix refcount leak in pinctrl_dt_to_map()
To: Zeng Heng <zengheng4@huawei.com>
Cc: linux-kernel@vger.kernel.org, xiexiuqi@huawei.com, 
	linux-gpio@vger.kernel.org, weiyongjun1@huawei.com, dan.carpenter@linaro.org, 
	liwei391@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 12:54=E2=80=AFPM Zeng Heng <zengheng4@huawei.com> w=
rote:

> If we fail to allocate propname buffer, we need to drop the reference
> count we just took. Because the pinctrl_dt_free_maps() includes the
> droping operation, here we call it directly.
>
> Fixes: 91d5c5060ee2 ("pinctrl: devicetree: fix null pointer dereferencing=
 in pinctrl_dt_to_map")
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>

Patch applied for fixes.

Yours,
Linus Walleij

