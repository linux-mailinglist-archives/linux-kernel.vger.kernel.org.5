Return-Path: <linux-kernel+bounces-100593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 349BC879A8E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34C7282087
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5451B1384A7;
	Tue, 12 Mar 2024 17:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="cSvuBUIo"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6055179B88;
	Tue, 12 Mar 2024 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710264129; cv=none; b=Lu7uNned7ZHU9Qujs7IGCJKTll4jK+Ft3IZa88zQTW2G9pqc4j14H+C4LpDFhyVGM8iyexH5F3vedC4K9Wqq4PiSRBpvlVyHpLFplH8YiEH1//HM/hSzLYaJzQy295emnWK+Z+xnpIsou7l3t/wQk71EJBp602jTmtlIrLW9nkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710264129; c=relaxed/simple;
	bh=Lg3YxM8eUEBc9g+6Xg7fQm4MadKxmFFVoPCigj3f77g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dL/mo8PUKK6mW1WvGgdnR8i6GYHL3Z2xwQAfmRmcwjYrduYXjTwP3NdfP4gw4yk2a2YVKP65IIXweciIgAZgHhvyKLuhT18u4ETYkiZZeU9qhvELUsSspq0aTTLGi6ddW+Ey/ceckdTw6cebK2mCf9+Dlrf30Vi7Mgj5oHPO4H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=cSvuBUIo; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dd8d586126so1408845ad.0;
        Tue, 12 Mar 2024 10:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710264128; x=1710868928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pW6mgK4CR5cBf8JQ9xAERN+Lfkqo7JYFnynnT8jRXe0=;
        b=cSvuBUIoX2ke6RufAOSlKWWEuZ4Ka4kvmkkJ6lsOfg6/8pnqaD8zOoEEEDykiIx4d+
         d0EIkIz9VZZevsELbwaOc8Rh21cKu6vyXFTTN+7bSNJO5/7S579OJhul4n/tfvARaXB/
         vdnHL0xlAhSXrsMr3AgM5HKFxSmOcQrQWV7iv1N2Z5KrwP9TqHq6oWn5ys6ANheRC7p4
         VTyhoiy8owQwYmV0TH0BcCtv+dNCcuierOgRyGkZLDd2itBhJ/GkZjsamru8WQ66IB/f
         mExuijmlMb177G83Fn3Uy8z99ZNejzfDr5DUbzpTgKiVisW57kCsjVi0l0NFOwDUPrhp
         vb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710264128; x=1710868928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pW6mgK4CR5cBf8JQ9xAERN+Lfkqo7JYFnynnT8jRXe0=;
        b=uPwqbbUedMZoNef2dBKO9nv6kcyhbBXFhnIxDXA/dWRnwawjmcfzqSFPXF83txWbVC
         w+6z5w9Whg7ui2U6OUyJkTO1LU1vNnfkPf/7uYSw7WtdaVD840JDBBH96T7yjxEmaEdu
         9YVqRBZavnEiwGz6go/JOux1DalRzwMcmAa/CmhtueFD57VObXVG5NG8om3HLPacRymu
         BX+yjsDK6SCGXyoe/TS1o1uHKUm93vGe9RT+5hZlGFpVA6faac+zllAaDBbdFMuN1Cyw
         QKrIK8rz2S54C7BUwLaRT+0lPzTNLfrcd8tGVJI9abN7LwyJt58W4YSfqTF1U16fcd5d
         SbYA==
X-Forwarded-Encrypted: i=1; AJvYcCWqBfhSoV/H+4VHzbQSLjAnfaGuAjTYKWd/BDyIQNrVfmTfAUnr+1H0BU/UEhXDJVejIqgDhIelksE+irjpeShhJNAt58oPRDpmhzv4F4mSnINdI9B1NKNQUGrkXOb6WIQD/t6HU8AL3g==
X-Gm-Message-State: AOJu0YxmLpuW6Js6IqFqSeYjBaqwew9+DVodA62MPUexawR6T7wZaSNF
	eegaqWd06rwxhKPuP/H3w8NDAOjXLHwJew74cJW977mNLRJ+uvNvwgNrRjXIBTnVdsIyJF7XScr
	n7LbPfGT2q4dpZxJ+d+ZaruBEOjE=
X-Google-Smtp-Source: AGHT+IGohFeA7qz3PV8ixHbJEb+jrVPAw1ItAoo+rIPl3SMXMz/LBVXnwGqZU6IP0ru8Xel2fopHaI5YBqR39t0IDAM=
X-Received: by 2002:a17:902:7245:b0:1dc:cb46:6810 with SMTP id
 c5-20020a170902724500b001dccb466810mr3406182pll.41.1710264127680; Tue, 12 Mar
 2024 10:22:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312-basic_dt-v1-0-7f11df3a0896@amlogic.com> <20240312-basic_dt-v1-2-7f11df3a0896@amlogic.com>
In-Reply-To: <20240312-basic_dt-v1-2-7f11df3a0896@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 12 Mar 2024 18:21:56 +0100
Message-ID: <CAFBinCCzmmVf+iyFkjNRmyyrjcuSS-s7qCYZMwwK0z-FnYMeqQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: arm: amlogic: add A5 support
To: xianwei.zhao@amlogic.com
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, 
	Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 10:19=E2=80=AFAM Xianwei Zhao via B4 Relay
<devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
[...]
> +      - description: Boards with the Amlogic A5 A113X2 SoC
> +        items:
> +          - enum:
> +              - amlogic,av400
> +              - amlogic,av409
Similar question as for the A4 SoC: this series does not have a .dts
for "amlogic,av409" - what's the plan with that board?

