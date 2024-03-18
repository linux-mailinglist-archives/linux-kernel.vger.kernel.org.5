Return-Path: <linux-kernel+bounces-106366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 977D487ED2A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B083C1C21979
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6928E5338C;
	Mon, 18 Mar 2024 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Rj8MVJL1"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9787A53391
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710778506; cv=none; b=KrZvWSZsTVLNZPS99E+LZw6vdH+LQRgEeID4C5Y5MFA3y38tU2g1zSFJDl/Wg/bCRPB1oTc1uKQBmuAhA+7HyebC6cwCr5r1Yom0kAcN+lYOhVzTTmmO/rBVHGM7h6aAA7dBDsHfLdjZQ42veeCE/J0sy4dS7pOYlEwcIaNfgVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710778506; c=relaxed/simple;
	bh=fgbBJX2XFrA4ko2jgUsyKZTlP69l4E6nEpoEHcOA0oo=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=sMLZ/rcaU/CpS/yiuyZmPQLXXik3pJKHKeGNBoUOQbIfWR01ULv5GH8FquQaA+59VcZ7lUtJ8LQWtmTAyqC/7vJTRsnosuvX960eSp629kbRAsttJCXBhPTGrNdHrriAxeuXiHEHZ4lb1bCw8Q++j7RjlB07k+i7Be1wirSoN2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Rj8MVJL1; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e6ca2ac094so4144746b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1710778504; x=1711383304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gjx92w828ciIAkc1HsEl6Axd7/QMgJ7aIhxMeT09mMA=;
        b=Rj8MVJL1iE/oBiXcQHTSV1EfWAKOSHHFXd9F/rulwN/z4GTO+joP3/Kt/SCqAE89B1
         R8m9sQtLf4fmBwrXwte37QpLaWXZI3KzJrQj9dVENKVW9AUDvyHPKlSbi4XXE214g+pf
         YPzpwZJzRyCcWrgx4097T8OsNo5/R3aPxBeb7zupryjCRAULkU0Z5klnDTM7kN+ijRCt
         rMP15LR0sZX/L2VGypKmLhj+rARXR6dKT7PhAb3FfD6/Xzev8tKvj9Aq6X2ZuGtxyFjk
         z0Qzd+MhVWihJnC1mMz6BhkxN6WnNoHFhS90JFmdGH9R7mxUrO9lpTCcyk2WH9jHvUFH
         n4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710778504; x=1711383304;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjx92w828ciIAkc1HsEl6Axd7/QMgJ7aIhxMeT09mMA=;
        b=q3fy6YmkwzwMji1reygxvL763co9U0JdLYUZypCQARzLc8u0WuFMwGOjeZ5S2xPhhD
         quJPg57ecf7rSppY2tY6XgxrdCrNFDXG0TvOLIV1WjYaz0ffDJgWdtTSoDXL84Tc6vSP
         5uQyOIuFOMGo8bzUfbN42iRlxSPQYC1IjfD7P2nDfLu4oQ0gZy17JkUpK8ThymnriM7m
         r9TzsHBrTW5oQnDzx7O7weLKxWDta3ozKpKtYGnG8PaSOAntbCttcGWkfIyWpWLOO+mi
         iXfNcb57g8eNItt00O+hH3jfB4BjHz8lbYZDqykYL/8QuT9vCb7RVbSv5JL6sthv27vP
         AwuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNJKJ8RXt6aSQBeMk7eimx+rHwpra50RI2uobuNDFyXfxCDdeturhRUgzhpgCTGC+DUAX0vVKtzr/6LrAwR6n/TNO94LC8ovga4mmn
X-Gm-Message-State: AOJu0YxiL4C93bkJSBxi0nZ5dNWRHOORpNTA8TpV8i5cwKxHMeQNKaGE
	qj5DN42Fuu/cw32wiUmerrHF0rz8aLibaNfPsedjmeGD9IyNMgkr5JIRodxea+O+7z47EM29U/Z
	e
X-Google-Smtp-Source: AGHT+IGJGAECTPixBKSWVeI9OcdeXsk7x3qyIB4yxWwMTXhJumLXo6PR85kzQz7cucHvKAj9TYWShg==
X-Received: by 2002:a17:902:c20c:b0:1de:fc12:ee5b with SMTP id 12-20020a170902c20c00b001defc12ee5bmr175875pll.33.1710778503434;
        Mon, 18 Mar 2024 09:15:03 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id li8-20020a170903294800b001dc944299acsm9528985plb.217.2024.03.18.09.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 09:15:03 -0700 (PDT)
Date: Mon, 18 Mar 2024 09:15:03 -0700 (PDT)
X-Google-Original-Date: Mon, 18 Mar 2024 09:13:28 PDT (-0700)
Subject:     Re: [PATCH v1] perf: starfive: fix 64-bit only COMPILE_TEST condition
In-Reply-To: <20240318-emphatic-rally-f177a4fe1bdc@spud>
CC: linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>,
  Conor Dooley <conor.dooley@microchip.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
  jisheng.teoh@starfivetech.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Message-ID: <mhng-abf741db-9f86-4803-b143-2948e9a099af@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Mon, 18 Mar 2024 08:35:04 PDT (-0700), Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> ARCH_STARFIVE is not restricted to 64-bit platforms, so while Will's
> addition of a 64-bit only condition satisfied the build robots doing
> COMPILE_TEST builds, Palmer ran into the same problems with writeq()
> being undefined during regular rv32 builds.
>
> Promote the dependency on 64-bit to its own `depends on` so that the
> driver can never be included in 32-bit builds.
>
> Reported-by: Palmer Dabbelt <palmer@rivosinc.com>
> Fixes: c2b24812f7bc ("perf: starfive: Add StarLink PMU support")
> Fixes: f0dbc6d0de38 ("perf: starfive: Only allow COMPILE_TEST for 64-bit architectures")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> CC: Will Deacon <will@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
> CC: linux-arm-kernel@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> ---
>  drivers/perf/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 5060e1f1ea10..7526a9e714fa 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -87,7 +87,8 @@ config RISCV_PMU_SBI
>  	  filtering, counter configuration.
>
>  config STARFIVE_STARLINK_PMU
> -	depends on ARCH_STARFIVE || (COMPILE_TEST && 64BIT)
> +	depends on ARCH_STARFIVE || COMPILE_TEST
> +	depends on 64BIT
>  	bool "StarFive StarLink PMU"
>  	help
>  	   Provide support for StarLink Performance Monitor Unit.

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

