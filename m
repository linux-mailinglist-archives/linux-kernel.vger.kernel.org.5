Return-Path: <linux-kernel+bounces-137266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8178B89E004
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D32EB2C05F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B960137C50;
	Tue,  9 Apr 2024 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XEoWtRGR"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E54136E1C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712677762; cv=none; b=n7N7FrXkwm4mnDdY4BHfngU0gCFu83sT4xcEiyjFq8NG7//Sz+Uax4Eit4ivqw2r5NqdPqhhi4/JLaC/XYR4eRu8fTkZ1wktsRktevT99l77si1d2Cxv+zcEXrrRDfAROVO+Rd/+NoiSt3xftMvWgSOh0jg9p1ElRPywMchBOTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712677762; c=relaxed/simple;
	bh=xEPOMa3UUwi6CuJPtWx1BPTo8A6Ak+U5QsgkngA70eo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdHoV1gR2ctuGtkValSjY8cnx6wma65w/Dadr/i9TRGJbuPEI0wSgQyoEh6eNUPhJPTT295lCeTea//aTwFUcbviY40i2HT5D00VzPiVYJOIoJGblt0/iQ73h9FexzDKczL0+lFDgyZ7e+DhAc+o3OS3f9Oavb7aUjZLelgqg7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XEoWtRGR; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-617ddc988f5so45976677b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 08:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712677760; x=1713282560; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OkNdlbndNp8toNAiOgiu6/Unce3sg3CUz/W3fWtHCzc=;
        b=XEoWtRGR9YJT9bjncQLLvPXnXo1IB3VJWowGnu2TLBLafDrA4ksBdOo9YIi7ubs7pP
         ZYudbMrsk+qUzh52TNTuxEp9fgyMObAnUgGDLCZ5bm5/NX7ffFOdl1bjjNEQxFT/6Ogt
         sqkx6RbaSqXQaRNsPlkVnuBFqR7ym97o0mxGaMB/nMK5HDkFoSx8yCOYq1ETPEjTN93V
         VHfaGcCp9YDMhh4DDkZzlGWNfz1x3z9BIX1ZHcZw45iEXpQr70kanUjUtsGdR1LqmDal
         /LgdLF/Q93p6vy5imR7s9oCLenSPTO4p0ShMDa1j7ftjPLaM6WEGeaYe0mwWlqlp5gFg
         y2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712677760; x=1713282560;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OkNdlbndNp8toNAiOgiu6/Unce3sg3CUz/W3fWtHCzc=;
        b=wmmJIUy5X+cVfNK13diDrXih42AnX4PEPZK0UULhcsi8UhDClSeVrL3yrT9iPK9659
         O3haJMM1hQDubNH4KAtbNjcxPQkABND+NDEuPnwWkohPeWKX2xYJJ0GF1rIpHx9oNyA5
         5wBqZRvb1Eu3glM/E/BTwQpK18PIongQ3dT6qxVo04Al6NK3EZ/Sw5OQdrgpFx+K+Hw+
         LAVo/XUAO2EPGTsjTigfAudWWdTOzveZy3rc+u8S62mF9wO/jtaNsuxR3JtXCrxHUNA5
         sF9Kqlr5XPabwWcMJ20FkaeQWMIx/uM74DPV4cwCPA6Q5Np74I3hNAxzk1aaqbazjX/u
         P3Ig==
X-Forwarded-Encrypted: i=1; AJvYcCX4wdymYbbGe1tTWCRRz1jFu1w9WZTKBwxDkcMj9QdbZwZIaPeI6fEmcBTorgkpTc0aryd5HSWVzskqx8fUmXT+CXGq3e2CaMDPkiuM
X-Gm-Message-State: AOJu0YyD9qsWfJyB4SFb6u2G1ivkuPTpr+c+zIJOM7R/TJ1fNqQEAbD8
	5ewgCMfY9WUJ+yqUvuksjw7i7vsL0POWhPdDb8WE/n4YcG7JtYmmGCXraS9gptPZ5YwjrWnEa7N
	KN4n1dw0gPPiBfxKFmeh6T+WxTFDeji3b50DFtg==
X-Google-Smtp-Source: AGHT+IFeh65C1hwVrDbeDlM5B8VF02m23KjP2P6B/Tn9ctw/X6XN3vvtAf3zkCKw6Th02bnJpA3n/2Fe18UxYwd3G5Q=
X-Received: by 2002:a25:7b83:0:b0:dcd:4d:d342 with SMTP id w125-20020a257b83000000b00dcd004dd342mr120504ybc.50.1712677759847;
 Tue, 09 Apr 2024 08:49:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409-qcom-ucsi-fixes-bis-v2-0-6d3a09faec90@linaro.org>
In-Reply-To: <20240409-qcom-ucsi-fixes-bis-v2-0-6d3a09faec90@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 9 Apr 2024 18:49:09 +0300
Message-ID: <CAA8EJpqV+jfE4p943pjVPWS_VOUth5r9JSg=mSyH0x33iaahtw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] usb: typec: ucsi: additional fixes for Qualcomm platforms
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Apr 2024 at 18:29, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> Fix small issues in the Qualcomm PMIC-GLINK UCSI implementation.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Changes in v2:
> - Fixed indentation in pmic_glink_ucsi_notify() (Heikki)

I have sent this version just few minutes before getting notification
from Greg that v1 was added to usb-testing.
Greg, you can ignore this version, the indentation change is the only
difference between two versions.



> - Link to v1: https://lore.kernel.org/r/20240408-qcom-ucsi-fixes-bis-v1-0-716c145ca4b1@linaro.org
>
> ---
> Dmitry Baryshkov (3):
>       usb: typec: ucsi_glink: enable the UCSI_DELAY_DEVICE_PDOS quirk on qcm6490
>       usb: typec: ucsi_glink: drop NO_PARTNER_PDOS quirk for sm8550 / sm8650
>       usb: typec: ucsi_glink: drop special handling for CCI_BUSY
>
>  drivers/usb/typec/ucsi/ucsi_glink.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> ---
> base-commit: 25e918cf1bb906bd9aca19ae0270feb7f6d68783
> change-id: 20240408-qcom-ucsi-fixes-bis-6b314764c5be
>
> Best regards,
> --
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>


--
With best wishes
Dmitry

