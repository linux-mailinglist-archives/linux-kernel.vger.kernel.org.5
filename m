Return-Path: <linux-kernel+bounces-67330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6AA8569FE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5351C2387D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5358136657;
	Thu, 15 Feb 2024 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vQ0vNC5Y"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC95136642
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708015901; cv=none; b=uycZqEgLdwHWoepN5dvOPjJxHo6wtKek7bebohRQfQ4j4JY9q6kzMWDcSPTJc5q+dWSSGoyYn8jsMFF4bmUDMzKBNAFfIdBQK+dooLs7gFZKIKoGU+HOrkhbtBM7/959UU8cIJoKhym825CAcXK/yYwinA2ut3UpWJ+5xddA0eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708015901; c=relaxed/simple;
	bh=sha+65CRAruHZvHPgeTNMEaYyVy2ctkRi5VI/uxKmWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=luvH33bxmIrMw98VniHCcx93jeI5W1VuYpleDkNU/BJl9s4QtWjeRRSynf4NRJSqwlwaKdmOrOizqJpCMSCYmPdg8fW+H67SV26guzYxbYMHyqJDD2HXez1kmxX9cwiTleu4bSjdGo9bMAKP9GiE0TQeILsGTwk+Vx3y1mwuQ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vQ0vNC5Y; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso982296276.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 08:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708015898; x=1708620698; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m3IoBRH0M+LFAe74HMw0Du/XeziGoU8xuI+b47PCA5M=;
        b=vQ0vNC5Yidu4gMGYGqCLtj1i35wnsWqAGZTcl34/1OMY4rCPXkiO1WnxeEG/M6OdxZ
         1ok9XTqVjNrdDzNrvD2h+K6Q73fgWHURb2sf8v/cERkb+J+AIBfpv3juwHUD3Tl1DvhE
         kncEai4cGxXo8ccn/Vfg9E3bjKzXTStXFvBq86FVoeK/IpXkB9PWyaxcXlOYHLhbbKF7
         cYAEvXaXhCzM0f2RrAEKPL5oavMnbOh56/WgE5eWsSBe4F/REzb662riyJg4E8DE2CAb
         DfQ15ubow9IXgVsoTB6/44HJ/jpxahDCoTbTtErKiUL3INxABYSTQTjCI33qSb50TyJ0
         Iwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708015898; x=1708620698;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m3IoBRH0M+LFAe74HMw0Du/XeziGoU8xuI+b47PCA5M=;
        b=UEzakKdpoU7th7+WaeP9wuufJMzTXsU3uYSdeJg00dK0mnVjXXp8j8PVwhq+Wnv57F
         e2FBq+oP1PZYlBLxLD4Ptq7n6JrGWxw34CZXnO0Lc6wTlsaBVGattxsTtKyDkU7BKIbA
         LDSGG+/VNLFTzM7jmWbvpLnvp5vpR+Wn6gCSopHjaC5h2Vkt8OUMs1okt1gaVOp0QQKy
         JrGcdrcorJm+h+p0ungm9VCLi++7o5QksSLPy7xOtDaL9YckSQvVXsk+TOKq1efEBhrz
         9iAzRVmT76wIOfAhFHIVMck3iWJnEsZVA1bOGuKB8wYkt5lVD2Paycbm/2D/6RIytqMl
         fEFg==
X-Forwarded-Encrypted: i=1; AJvYcCWJoZVAKSH7IL6c3Pp6cZVSsUfnHch8hQQ4mObkPSDKHOks0SRWDwQbvqx0ewwBmxNxMqTanPLtSOq7e6sBbRVYbBHEpikVCxudZlWy
X-Gm-Message-State: AOJu0YzfpbnvJt5kjmbkKRVnEJQ3Nt2MSKUaC8T4WlsjX43YLy+gWUn2
	leRe8lLPbait2muJjAEThF7gRf7WU225jpQ5t+7DnMrwvd7rfb4cPOr1J7kb34e74zl0m/n36ZN
	MKedRIBiB4zBAtFeaT5OmYtRV4GyX/re7coA1Mg==
X-Google-Smtp-Source: AGHT+IEzADUxXzVHUebD8YQti/ikMzubDEe3ni3UKP6sMKE6WoX/CP5vqMWBdgFxA2yW2vHZvaJYaD+OiBuJd7jLqKU=
X-Received: by 2002:a25:c202:0:b0:dc6:daa4:e808 with SMTP id
 s2-20020a25c202000000b00dc6daa4e808mr4555953ybf.12.1708015898386; Thu, 15 Feb
 2024 08:51:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215161613.1736051-1-enachman@marvell.com>
In-Reply-To: <20240215161613.1736051-1-enachman@marvell.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 15 Feb 2024 17:51:02 +0100
Message-ID: <CAPDyKFpNL_zFgzSNgaSRqaH8tDNjwB16ZD1YGwqM64vcQ2oxtA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Fix PHY init timeout issues
To: Elad Nachman <enachman@marvell.com>
Cc: huziji@marvell.com, adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 17:16, Elad Nachman <enachman@marvell.com> wrote:
>
> From: Elad Nachman <enachman@marvell.com>
>
> Fix PHY init timeout issues:
>
> 1. Clock Stability issue causing PHY timeout
>
> 2. Timeout taking longer than needed on AC5X.
>    Solve by constantly testing the PHY init bit
>    until it toggles, but up to 100X timeout factor.
>
> v2:
>     1) convert polling loop to read_poll_timeout()
>        for both patches.
>
> Elad Nachman (2):
>   mmc: xenon: fix PHY init clock stability
>   mmc: xenon: add timeout for PHY init complete
>
>  drivers/mmc/host/sdhci-xenon-phy.c | 48 ++++++++++++++++++++++++------
>  1 file changed, 39 insertions(+), 9 deletions(-)
>

The series looks good to me. Although, I assume we should tag this for
stable kernels too and possibly add a fixes tag?

Moreover, it would be nice to get an ack from Hu Ziji.

Kind regards
Uffe

