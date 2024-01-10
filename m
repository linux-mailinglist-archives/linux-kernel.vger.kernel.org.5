Return-Path: <linux-kernel+bounces-21850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2378829534
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D42D289F35
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6CC3FB2C;
	Wed, 10 Jan 2024 08:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f78MSN4O"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CA53FB1F;
	Wed, 10 Jan 2024 08:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28c7c9b19f1so2170414a91.1;
        Wed, 10 Jan 2024 00:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704875375; x=1705480175; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LYyKNmJzAuYDth/rUVZfoc/l/f34a5W01pQ2NRIEnqc=;
        b=f78MSN4Ol2qyw9OcVztqbccA6ee5ILz8Cmn9IftJap+Pecp8nV51tAAYV+nSFa8yh7
         Yd89b0UFmkXSeAYDEQ01PCn4U4ORCgq1/duxbr0FSv4BSG8DmxNZbe6JvN4h0KNXcVfu
         vRgH7+T19B//Xvh1ax02K/VMx5Cps3FOAaZgxy4UTUhXiV5IxEn7J7nkDY3MTTJvEtni
         DS+Gc8CHLV+rtK7Rh3tdGzrIpxDVS4LynfHN3XGbXM/p8OC4/mxuY4RxPkY2kmh1VNUz
         N2IHSpDMACRH0YB/eOEXqilbyxDqeLx2YTmHNQQwoOiyDHp+pDTDPEJHHXh4aOdmGMLx
         LoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704875375; x=1705480175;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LYyKNmJzAuYDth/rUVZfoc/l/f34a5W01pQ2NRIEnqc=;
        b=uz5EwPNqgHnAEZXhVpepXiRebqv8owa2GmcPiTmastRY9H8wzhPQQLTgyYAQ4ElesE
         9mHRJDT7m1qvFH1rziSqh75BKtNaL0NV9a8WYhYrB+DMgVL4AkYw6AZDpyJEJdIfi3RD
         fYC6sxGWF5H9fHAdyagibP4iJ6n+buYaKW0bkVYKpk20D433J3Ik4vxC+aIKQNxGpOYQ
         y04FMhNSoek3Vj21FavXk7W8kCoTwryoy0UfVykdXzOfHKsgS6Kt1yJW0PluqthyUnZp
         d7rJJmgLqp5Xg537d9tb9jgLbNXgkzG42Eqzjtxfz4muLZQmrjIlq2GhpfcczbShm9Le
         WWNw==
X-Gm-Message-State: AOJu0YwNrhWodhn65eTn1iru0pKUQu6aPLlOxL2FiSeLZxCca5gomxKy
	d3m4Zp6eaAcDztSbBjr78enYkJfMMU4Gx7/bapk=
X-Google-Smtp-Source: AGHT+IFgzWc6u+euiW/Lv0XdJuj/p/9gVdrh8o1MqeSQFfBG6OdavIrbN8P7sGbPTho8oKx7hKIYrsOT7ClHTabc3cY=
X-Received: by 2002:a17:90a:df97:b0:28c:3d74:5b28 with SMTP id
 p23-20020a17090adf9700b0028c3d745b28mr313568pjv.86.1704875375439; Wed, 10 Jan
 2024 00:29:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ddc610d5-5047-4921-869b-47bdafb38d9a@gmail.com> <20240110023019.10096-1-amadeus@jmu.edu.cn>
In-Reply-To: <20240110023019.10096-1-amadeus@jmu.edu.cn>
From: Robert Marko <robimarko@gmail.com>
Date: Wed, 10 Jan 2024 09:29:24 +0100
Message-ID: <CAOX2RU4d5FbtTuNW6OWXaoB7M-YH7xtTbkot9_mLy29qrG=QKg@mail.gmail.com>
Subject: Re: [PATCH 1/1] arm64: dts: qcom: ipq6018: enable sdhci node
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: andersson@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jan 2024 at 03:31, Chukun Pan <amadeus@jmu.edu.cn> wrote:
>
> Hi, Robert
> > L2 LDO should be used as VQMMC supply, otherwise you cannot change
> > between 3 and 1.8V.
>
> Some ipq6000 devices do not have pmic chips, resulting in l2 being
> unavailable. So vqmmc-supply should be configured in the dts of the
> device.

Yes, but you need to at least register it in the RPM regulator node so
that they can easily reference it in the device DTS.

Regards,
Robert
>
> Thanks,
> Chukun
>
> --
> 2.25.1
>

