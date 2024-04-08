Return-Path: <linux-kernel+bounces-135282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC1C89BE5F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F741F2180E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8916A346;
	Mon,  8 Apr 2024 11:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHPnomQl"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A10869E07;
	Mon,  8 Apr 2024 11:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712576945; cv=none; b=EiDXexgZQ8CHXzn7BFfYv8h5MYwW0nMkrMtfVQRGzcl6+zmaCiJSMpQYPuf2dO1crZLaEiPvf4bQpALBk8kK8o7UkCIoj1aehz3QYYbqQCxwvGt1V9910M58vIhQyvErnIZNWbuueM8Aq9CIqtvNiHP08eH69GV8jSDKBDcpUJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712576945; c=relaxed/simple;
	bh=5+GW2zqSXOcVY6HLiP1isJnrQthfe56oJBTjTreix4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ALRsAHRFvju92YjWG3wsIowQjW4WzPU6rfG/6Gtfh2BfQGGViXf7isZf0UHiPgB1796RPq8AY2F1VMypGAPPtgwaMavaPkNYY3T2BJVEwVQZRoiI4R0XpN+ZZyvssEWazENl3S7ycMSHFq0cuSL63vBXzUQJtYgDEVx9rC7OoZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHPnomQl; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5cfcf509fbdso853681a12.1;
        Mon, 08 Apr 2024 04:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712576943; x=1713181743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIQh6B6U2unyStwftymRPGVI14zoMCWts9Hg0rctxvI=;
        b=GHPnomQlBem8id70iVdi7aEg1Gm9/EdrpB+cqs4nnowQlq3yiIbaoCjCNSvjvQvMFH
         IV1jbxB97S/niZzUeaeksJ28FcdPK8Im2zbBJvdrg+lnn/xPUKepQQ159YWkiYM1jQ/C
         gyPdD7S6INMhHDLO/JP+yYg9bfpHJVR8KlRehTjPetwma2thmpNpjiOdbjUjPnqhhwW9
         QOgrNCfW30RVCYrcDOAARPzzKWXhax9QsyyBS5wnvVw/ErmeyzwEwdbNFNdUCUtYWl4b
         fhH/B0hUSGunSOC1d57e4oeLRXqa4XpQgVh/N5t5KGGqRJAh6yFO4oyb0EpiHZAXRybr
         2ryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712576943; x=1713181743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GIQh6B6U2unyStwftymRPGVI14zoMCWts9Hg0rctxvI=;
        b=xG17UAi8aLaiGhiojSqBquIN3AnHhOaHetcqzcKKNJpQhmoYpkc3CD6WhF9in2nPuw
         G21cP9iHioDpQ26i/ub37kfDFKjqpC+0hXrvc/S/znXCFx8cQ2QZ9vngXbFsAv2czxMy
         fuLcmOrxV7BxrsTkFx/yoKVJN3FqRYo4lGnnigokds3ITYhxo7Ww7BmZA+6v+VHlLeey
         IL8IHT1V1RKvkGVe0G9lVMubmibLvu9SnLX1wN79A+6bsP55Tz4+rElfspS7MOhRdCIE
         ahZc1rObeTT72slhgEmJ+Wjzw9V+oJ5c9d3F22/FqXLW8SHqTGEhOZ65b6/TwXVsdAc9
         zUlg==
X-Forwarded-Encrypted: i=1; AJvYcCVg9xDD4svGrFjMthhLps8gzDR0L6fxZdJL4m+u2bGhxOrmUjTcQqChzqNOy+XoKXSEXbIFjk4FGV20A3WUiuBO+SF8FneWbmplAqDMX/U6L3GeXJbcfQ3itnkmAL2y5p5XvbPWwvFI3Q==
X-Gm-Message-State: AOJu0Yxx2t0k+yV2cNhlh/CzZ+2vhwaUm/C5hl7U8ch9DvSllcRF/sX8
	KUaX9uRqwuUt9KzhwAHZeOIpKr6K0p0XjLy2OPiAU4CEzpVC0ri46CaG2lnMdmpAm7M4eDrQ9NJ
	Zmt9VnChFql9sHD8LSQvpQqxOAwk=
X-Google-Smtp-Source: AGHT+IHth8BZ/ZebZFfLxBn0WT6zE10ZV962hJtv6q7226AlZXO+232Jcw6YYySMzlV1ysO95yXj8UyPZtQEfm3p3vs=
X-Received: by 2002:a05:6a20:6a14:b0:1a7:c66:121d with SMTP id
 p20-20020a056a206a1400b001a70c66121dmr11270850pzk.3.1712576943546; Mon, 08
 Apr 2024 04:49:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408092449.6-1-ian.ray@gehealthcare.com> <CAOMZO5B-vTRSfi=tNc_iZxnxYstL8JJOd_1rMf4ps9WHyfx0GQ@mail.gmail.com>
 <ZhPYkGLM_b5IEKs2@de2cfed78370>
In-Reply-To: <ZhPYkGLM_b5IEKs2@de2cfed78370>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 8 Apr 2024 08:48:51 -0300
Message-ID: <CAOMZO5CaOYt72pZJ7fsdQgz3Vz=G+WXNE==ZO7nC32M3oBCKxQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp-msc-sm2s: Add i2c{1,6} sda-/scl-gpios
To: Ian Ray <ian.ray@gehealthcare.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 8:44=E2=80=AFAM Ian Ray <ian.ray@gehealthcare.com> w=
rote:

> Thank you -- I will submit a V2.
>
> Would 0x1c2 be more correct?  From the IMX8MPRM.pdf, it seems that the
> lowest bit is reserved.  Example: 8.2.4.158 SW_PAD_CTL_PAD_GPIO1_IO05
> SW PAD Control Register (IOMUXC_SW_PAD_CTL_PAD_GPIO1_IO05).

Yes, good catch. It is better not to write to the reserved bit 0, so
0x1c2 is preferred.

