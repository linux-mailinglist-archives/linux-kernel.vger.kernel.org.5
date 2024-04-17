Return-Path: <linux-kernel+bounces-148229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1158A7F9A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC6F2281B8C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523A11327ED;
	Wed, 17 Apr 2024 09:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X7ANKHQ6"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA0912C490
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 09:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346028; cv=none; b=Fj+ECfxAXW8B8xOnpnKKV1xS9tQH4L738eP0pNV9llDsvoyKcZf78XqbYR/0FjgTOlNPTnAorykK9eP3hM6mqLUGyG/DEO1gWLLvCanmYt9pN6s4nbwfsb4XEraE7ZEtTH82GSFRJ085tgIi5qjl/p6eAEALLRiL4H5Dd0SHFio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346028; c=relaxed/simple;
	bh=Yeu4xYB7BLvk9Ill1dF9JRym+Gaj87Pzo5C6ffxxA1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e7VQg7L1Gc96YdF6wogAEauNOXUv6/NAcezM83XwRGbb9FAJYSSNv6dFxI17abjsSmDwOwvXjTmy8sqJD4GFbflFPkIAsMp6gAOAsSN/tUhh0BscjiBWf2S3o23nzsadwZ7fFc2AQBZKM8X5iEQ9YWajCdQuiJmPZIOHTDn7M4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X7ANKHQ6; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dd161eb03afso4831511276.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 02:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713346025; x=1713950825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yeu4xYB7BLvk9Ill1dF9JRym+Gaj87Pzo5C6ffxxA1o=;
        b=X7ANKHQ6t1kIywRRD25rxMVggJ5d2i/P51AF1/qNiG2SMx10lDOCt/rLE9S/jpgGtP
         lsLOyjVlRDNM7zIelUtOA8HUPqwtbx66N+USXavTiMe78G29cVuB2EMOAcwInCNx7A10
         1KHNuJ8is2S2ARuXNkYrqAc9n1fuH9qSo4dZG4WtQ08phNSSkayBllK80VrZ/N/VTRlK
         m12YQjJMt0op7s0xIjCY8w5962NmVoueXraBmnCN/nRzqbztnkciCR5FvKlxBxkC9p7n
         8a5KvhOv+5ij2BaayoBnB6NcyqHvHX1nXjyvwX9ni/UVFFRGIeAnrsaliO1N7nVAF46M
         6jEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713346025; x=1713950825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yeu4xYB7BLvk9Ill1dF9JRym+Gaj87Pzo5C6ffxxA1o=;
        b=ZInF+Kzxgfu8GqNTD1LKAW7+HGgPlBEIpNYM5KXLcuvxcdlwHYu/KoUULdgSWvTo0r
         0suWyazZPoy65briV6qg9iGTaCLwcPI6EUNkaxTuCmFj24nexzXmtS4qGW3SqwNhOQNh
         DivffDx7diFnkajFQMQe9i6uSmWLvPrxu9L4keGY3rbuInCcaBqPACLg55MBt2sar9Zl
         AmVgswdMAZuT9cMOjcFtSKaWx2A9Pv3yu6VUYrIqUr05QYEA6U7YFlzBPx/HIl6DaffR
         q2yyp4d3V4laniBtMFsMM+NhJ4ljAQpE9Ii7yZ7Stq3YzZnnxyWWMMCTsBIsThNGqSW0
         X1ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVm9IBWJrc3RKLaC4oBrSEpeepiA98ItkJnlC1DnwMbL6Z/tDnvy5C29FzxHU/eWcPhuG266bnvBj8MS5FUKcGVpkJsKq4G1/kVl8aQ
X-Gm-Message-State: AOJu0Yzb/eZlR/H4TN9Ol2TUcKmqQrKMaHn6QF3fYVfSD2ASY4XdVipP
	hv/rh3zNMqd7um4ANPlvBEiux7n9DnU6u3tjOnAP5vr7durefc9D4c8xYnR94ybT5LP0+6HWKRf
	UL8sKDQzuU2w8kOD8QJJtFgtfCtc921nkkmbsQA==
X-Google-Smtp-Source: AGHT+IFd6w46gF6cWcu610WNObxuSqT+OycBvkUkCVvHSq76OEyzFC1DzsPH3oOQFPiC1xVXQtj4MKgadM8M8hUGOW4=
X-Received: by 2002:a25:c58e:0:b0:dcf:2cfe:c82e with SMTP id
 v136-20020a25c58e000000b00dcf2cfec82emr14634228ybe.55.1713346025571; Wed, 17
 Apr 2024 02:27:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415141743.1983350-1-github.com@herrie.org>
In-Reply-To: <20240415141743.1983350-1-github.com@herrie.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 17 Apr 2024 11:26:53 +0200
Message-ID: <CACRpkdb5f50z34FVsfCRkF8qG-EE3bDgf7m6NcLj1jjw1L2FOQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: qcom-ssbi: add support for PM8901
To: Herman van Hazendonk <github.com@herrie.org>
Cc: andersson@kernel.org, benwolsieffer@gmail.com, chris.chapuis@gmail.com, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 4:17=E2=80=AFPM Herman van Hazendonk
<github.com@herrie.org> wrote:

> The PM8901 is used alongside the APQ8060/MSM8660 on the APQ8060 Dragonboa=
rd
> and HP TouchPad. It works the same as all others, so just add the
> compatible string for this variant.
>
> Signed-off-by: Herman van Hazendonk <github.com@herrie.org>

Patch applied, fixing subject.

Yours,
Linus Walleij

