Return-Path: <linux-kernel+bounces-125949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0261892E88
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 06:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69DD1F21804
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 04:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C17B20E3;
	Sun, 31 Mar 2024 04:06:21 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C71F15A5;
	Sun, 31 Mar 2024 04:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711857981; cv=none; b=RXz6u4bPbdizqQF8XF7PS7cKzfGJq1zSUz2vziQdt4FG06gsM5B7+foABAoPcH9dscXvDTy162KttUkKAFZuCWnG8iJRLi53lzKfKIkgwk40XZHfYwboAz/2E4bIA1IKgB79/r5zoB/0OvDVhT4ySv2XcflwcbR0EECS9ZVqIm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711857981; c=relaxed/simple;
	bh=e3bRxDH+wQoPJin/nfB62E2/Uu/KG61lMcFAauOvRdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUtIxRFEpNk/v9KFhsh0tfPMTuoMf3BAMU2g5Bw2qKK1AZ6XamXtSTjAk52UEbngdcKYWZEPwSIYum7AMIwxpCeT4SNVk3Cf6f6CBqMn58ZijENIgxn14cGFT5FQCMWv89KnzPaRrCp5IO76QoiSMoJHZlRtdLm8YpVXK49APSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-513d247e3c4so2928152e87.0;
        Sat, 30 Mar 2024 21:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711857975; x=1712462775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e3bRxDH+wQoPJin/nfB62E2/Uu/KG61lMcFAauOvRdw=;
        b=I1F2S5VYy3rLcPzz9C3DkCbp+ZcjzEQtCOIIxORk1qM037SN8O5zrkcp9Jwx34U1TZ
         0QpxesOBv/3oLsBiL+n6LNxDporrCS20E3b7ICFnE2Wl8sg2V4p5fbzLJyitF0AxbEjC
         eVLBxRDmSq4Ig96jT/Es5GINAKWxHowSQ8jABLV4iM6dQEgOJJpOKfl7MC+CCgBJSJCL
         7rQuVyUNTLu0hoeMNfCp7URb6MgzT0PfrwHkHoAoqbD2kwZQobY2OSL5l/wsR3r1+WaU
         mUuMcHR6alfROgrIQVMDSHo/9pXdxOkTfhWQcuJ72ZcJQmwFaC9DpIJLcP9pixFrUC1m
         mcCg==
X-Forwarded-Encrypted: i=1; AJvYcCXDrTypFd+gt6HT18ZL6k5NCFdDIfFXSciaCDBSPnH3AB452oefcFBUXUM2Kdqk6E5NTFiqYUe8jZTPupCkpMN7chSlsKJCAFTcmwzallsBifa/csHV99I25qSvKuUm+TlC8ZwKKL7MPw==
X-Gm-Message-State: AOJu0YxmV2g3i++ZOM0UT4Tfe+KGgSYnFv/zBHDkTlnFWXyfbFm24rXs
	/s2k0FRILBzGfsfhI/4VWlE+MZb344cyrJVvay+oPCOCc4Fm1zYxAUYZISuqFH8=
X-Google-Smtp-Source: AGHT+IG6RBaueZP6VDXU5oiCyPxSA+oHr/37vq/u50rDkqdHZ+Omc2Q5aHxcYBSebIdmW0PBCYSlAA==
X-Received: by 2002:a19:384f:0:b0:515:8a20:71de with SMTP id d15-20020a19384f000000b005158a2071demr3049154lfj.5.1711857974945;
        Sat, 30 Mar 2024 21:06:14 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id q12-20020a05651c054c00b002d437894f49sm988817ljp.100.2024.03.30.21.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 21:06:14 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516a01c8490so503218e87.1;
        Sat, 30 Mar 2024 21:06:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXKoPIlvQB8kfKIQ4VgbcOrJXElzR5ox6PAXR4R0Avnq70TmLNJpCe0DSpKoaMDb/vE03Rlb5q/mVvyER0eBVbtRlyLY8Usy+EwLGY61KfboAUCjyHEsO1nLhoiNq0vpZ4wZ3bKPRrQIA==
X-Received: by 2002:a2e:a167:0:b0:2d6:b801:a85a with SMTP id
 u7-20020a2ea167000000b002d6b801a85amr2088014ljl.23.1711857973221; Sat, 30 Mar
 2024 21:06:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240330210954.100842-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240330210954.100842-1-krzysztof.kozlowski@linaro.org>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sun, 31 Mar 2024 12:05:59 +0800
X-Gmail-Original-Message-ID: <CAGb2v65vSm5i7qN4t7vsrMA1LpfLWmMBk7tbOXieQNk-egPYYA@mail.gmail.com>
Message-ID: <CAGb2v65vSm5i7qN4t7vsrMA1LpfLWmMBk7tbOXieQNk-egPYYA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sunxi: sun9i-a80-r: drop driver owner assignment
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 31, 2024 at 5:10=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Core in platform_driver_register() already sets the .owner, so driver
> does not need to.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>

