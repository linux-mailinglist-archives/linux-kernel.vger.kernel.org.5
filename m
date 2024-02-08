Return-Path: <linux-kernel+bounces-58172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DCA84E240
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92531F21E43
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238D476C79;
	Thu,  8 Feb 2024 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZN0qOwJm"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19D4768E9
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400009; cv=none; b=iGI3+ImQ/9zKI6wi+Fxa1K6xzE7a9PzawsY5I9OUBJbDwC6+XduDX7a76UagBj/FvegMte+uTMcK5d7PMaEdQ3++ykqGYSHqjWplrHBwPJn5wa4nPIN4Ykppzli11jPimbddMMMB2OZSMDtWTCPOW0lpB47DZs9AorGNfRU9les=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400009; c=relaxed/simple;
	bh=qCVhFVtPC5tbl66HtqtFrAlZz3ol3WalO+JusmTAcyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kBLLFu7x0LIGpOiIBhKR66FCd7nXayV7skar44PZMJfzl7Ecg3ZmsxXz4eEh0gV7nf6xjN1DBuTxy4QyRx2927kDfm62LeGWzjNXMCUFDnW9H+PmiDS/0NdFtUZkx/ComCit3OtgQe48qjCA3Lxt2IFpRWq+kHdi6cF6xFISPrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZN0qOwJm; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc6d8f19ab3so1951099276.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 05:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707400007; x=1708004807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCVhFVtPC5tbl66HtqtFrAlZz3ol3WalO+JusmTAcyY=;
        b=ZN0qOwJmOLvWTEJ/UWk8Jn9oOh8uONsiiaSfqQQvpehSoaXG3VWqobRNyImqCcuAZo
         VnNAvPMXcyYxHBeMvNo5B/WQ+qmT62AT7IN2YNZf3VOCPTH+Zmo0IKtWH0JHLnjR1GA3
         IrvMhSP1p+Z0p/wp832+0vQ6FOtcpAcb6kNqFYaC0uPL9rUMcTQEVKOCXf9QKptL062C
         5S/csN4yNSqolv/+6CopVcqedm4Mb6VVYiOxowy/73aOhe2JocDXgpDN1FABdTriACSJ
         T6RrobyUTQqpvRP7NPSW150Lqe10XA98QXquShpST8q4vKU6mHzPEAQYubAZVG5/j1PA
         RrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707400007; x=1708004807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCVhFVtPC5tbl66HtqtFrAlZz3ol3WalO+JusmTAcyY=;
        b=BbtPaPmhlK2DLcHTzpnEnKiOpVID8CxloYaS4jhtcAeClqQnYeIJST3HomJdxLx7yx
         PwpG+Uie7kCuotyts7e+Se7yQeddcQP65bwkdznE/JqRoSmFqAOu6RojXV/upBu7MObw
         /RcXEEtQ//l2gYXXsJCp9VOY+xn11MofDidg/wJuz6elm9jR21J5zcd+g8nU7l/Rc+Lv
         mJF2lIklKgQ/11c0lafHXeZ5gq/8Ne+wlVIBuexe60fx/ZB2BQC5j7kDtrUUeBtZQ3VV
         TlW8Sym9Du5X1MD+Oc6ryAaVq5ED+C4ibVwFEBkQedPEr7qD4gTq/y7Kfb1SEdVpnMh3
         TBUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2rrAySHVhxoAfSqbh/IU7/v8+/FF+JfX1GEcSLixT5Gw+TZSdrSndoXrfhHneOIBxTiNvFngUTcfYRZaECcPqIywmP/KOYx4fOuW0
X-Gm-Message-State: AOJu0YwWj3dSSZ7/fbWl6cvyqp1yUptz0cQpu+y3/qdMjgb10UR2z0aS
	mlKjVT4AOXUH7UMZb8aTtXFbYagNRZmW0tXGq79FpszyAzjrHnLZ5DAgyi5ZIvo7jzzWkMKu19Z
	J7kXF3M/tZ9lG+wcgQLrUWoFoReF2fByIhe5VUg==
X-Google-Smtp-Source: AGHT+IGudlPEl6/lvKujeI4dp5nYTC7DGljHLLRLLV91qux7C5p+u/hDiKcrt2xWwb8aTa7LUTk2zQ6teOWNlj5s5Yw=
X-Received: by 2002:a25:2985:0:b0:dbd:7491:368f with SMTP id
 p127-20020a252985000000b00dbd7491368fmr8246474ybp.7.1707400006818; Thu, 08
 Feb 2024 05:46:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201141406.32484-2-arturas.moskvinas@gmail.com>
In-Reply-To: <20240201141406.32484-2-arturas.moskvinas@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 8 Feb 2024 14:46:35 +0100
Message-ID: <CACRpkdaftsHBW5uJe4WkQRW1+YrdROuVewxDTfzVKoz9q9ZyqQ@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: mcp23s08: Check only GPIOs which have
 interrupts enabled
To: Arturas Moskvinas <arturas.moskvinas@gmail.com>
Cc: biju.das.jz@bp.renesas.com, akaessens@gmail.com, 
	thomas.preston@codethink.co.uk, andriy.shevchenko@linux.intel.com, 
	preid@electromag.com.au, u.kleine-koenig@pengutronix.de, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 3:15=E2=80=AFPM Arturas Moskvinas
<arturas.moskvinas@gmail.com> wrote:

> GPINTEN register contains information about GPIOs with enabled
> interrupts no need to check other GPIOs for changes.
>
> Signed-off-by: Arturas Moskvinas <arturas.moskvinas@gmail.com>

LGTM, patch applied!
As Andy points out, the commit now links to the discussion thread so
people can find the details if need be.

Yours,
Linus Walleij

