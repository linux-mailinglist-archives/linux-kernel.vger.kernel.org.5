Return-Path: <linux-kernel+bounces-158891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DB08B2658
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C21F9B21B81
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E9014D45D;
	Thu, 25 Apr 2024 16:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GhYKPTuS"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C45B14D2B1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062163; cv=none; b=b2FM4p1lL9eWlZGonPcIpDLDkXP/9Bwk2AbJIjDd1Sizl9jTRfWfgd1Y4WRKNsfk2IwPn7vuUAkSY0TYpdueQRlCd3S/bLEDmGSJbgqunt+e2PFoSpEbc2vEHDmtTxvhiqPZUnY9RzDNWQV8sXAgaoRgTd7bYSs3oecuFTFMzio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062163; c=relaxed/simple;
	bh=i+P+k68CcmymOGvSb9vwn08NeXxYv0s2xH5x3OQW8tA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FTsBRMUlf4yMCL1CgRQTBlFbcxPi2Vbmxk99UXskx1UykMA9UqDqKBG0iLZPvx0l+NUpPcjZWew7CyHcAuhTpJa3PTp2uDqaWm56+1NPu66kYINbj3twN3vWxHB0G59CgFuYXn6ufoIg5lTy75fcKGJ+q/bf5tnht1C0NpqRfPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GhYKPTuS; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-61b6200fcb5so12600477b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714062160; x=1714666960; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i1JK7+wEtbfY7qkRNIeP+416+igSJp+SapW7jNKxfo0=;
        b=GhYKPTuSruRSYHht/AYnaoLRkqLy9SBVbXZAQEu+H4hN0qUPzZFsYhbROycVpg3kqA
         AmKYFGGNHrNxsin8wi7jnalG/Dut4NMuDpZC5ir1DoCfBidA+G4lXOmfO6wjdVfz+wjV
         IDw6i54hdq9fgw1Kx2g16GSIV5VWHFilIx99ByrRuMEjQuPCVplrkxziWfulCVxjilVQ
         3Qo4a47CzVAZlBWphXnP6MryuSVzsoKQsS5gLPUGeOEWBeECPwoIIL7wIgjnixkz2cpQ
         7qUr+VzWN5lzixjRb0rAHR5uhHjJEAQnO3MbAKWBvIHcMjRZOMlWj4JxgpyLI7xpueSo
         mAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714062160; x=1714666960;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i1JK7+wEtbfY7qkRNIeP+416+igSJp+SapW7jNKxfo0=;
        b=knAbeBzQLVCWW+Y/Gi+9uuVLi3xHB+q7c7/nWQhWGE/U4Omrip1OpWF4+13EodxC1E
         0FhdlZdrCt7BMD+YvKPtB3rhmraeqoyODfwNCGD0T1EtxTqzbqSp60crxA1ptaDE4qBi
         Swi2c0/1HmIJaUBgShwHV01N3arjHQZGbs8YGw3uiOizzKpXnfRGK88P6rmD5fJqy+jm
         bfFSFz33w4+TSspqr/+4Rpp28F7pM+9kx/Upb3DmSsbZ4zn5rO4/M9lGCkAfN6DgFHIf
         m2q966Ow8RAAA41+zfxH0lLkC7DEKopzoa50WxjrubDpGjvds8V2TSyE1SxX9PbHXPuU
         ssuw==
X-Forwarded-Encrypted: i=1; AJvYcCVk4aApN8lKjZ4c9MinE1M2RIVWOAFbv493j3dcBPWXTYY0hauSKjextgFRX0A5beo0SegvipyvOZCUzTlQjnrSlaRQGRO/dptQF/hY
X-Gm-Message-State: AOJu0Yzlwm13i22AKNqlhLbFL+1n7d8ma5YXhMIDFcOUCxILHjVEcu2i
	Xmj21FobjbSfGrnGz6HyFghvYBg8QmDUyNH5fDB3AtLYseZtcSwFg3T0Spct/gKnHX6dPkJaoIB
	p2kmca6eNLA2l/L9x5aD3aW+Qu8gbH8s3DjmtWFFVi1s9C0W5
X-Google-Smtp-Source: AGHT+IFwYxHrIdsfhr3Jta5nV0D+DvLpBWGX7J4D9bw5RjuKbvDtZnGIcR2Op8i48Ly4Ck4MI6LQPnK6/2Rea8NdNs0=
X-Received: by 2002:a25:ef0e:0:b0:dcd:3e78:d080 with SMTP id
 g14-20020a25ef0e000000b00dcd3e78d080mr177868ybd.4.1714062160661; Thu, 25 Apr
 2024 09:22:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417165708.2965612-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240417165708.2965612-1-andriy.shevchenko@linux.intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 25 Apr 2024 18:22:05 +0200
Message-ID: <CAPDyKFqac92AswQvORoiAUxpSj88GVZScLsW8+Wap=NScN3Y3A@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] mmc: atmel-mci: Get rid of leftovers and clean up
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Aubin Constans <aubin.constans@microchip.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Apr 2024 at 18:57, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> I used to have some patches against the driver, but it appears that part
> of it has been applied (in different form as done by someone else).
> However, there is still room to improve, hence this spring cleanup series.
>
> Andy Shevchenko (5):
>   mmc: atmel-mci: Get rid of platform data leftovers
>   mmc: atmel-mci: Use temporary variable for struct device
>   mmc: atmel-mci: Replace platform device pointer by generic one
>   mmc: atmel-mci: Incapsulate used to be a platform data into host
>     structure
>   mmc: atmel-mci: Switch to use dev_err_probe()
>
>  drivers/mmc/host/atmel-mci.c | 308 +++++++++++++++--------------------
>  1 file changed, 131 insertions(+), 177 deletions(-)
>

I decided to pick patch 1->3 for next, leaving the remaining patch4
and patch5 for you to re-spin, thanks!

Kind regards
Uffe

