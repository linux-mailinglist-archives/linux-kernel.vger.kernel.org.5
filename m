Return-Path: <linux-kernel+bounces-17829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EB6825351
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0D711C22F7A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 12:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA0E2D614;
	Fri,  5 Jan 2024 12:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nNWtshWn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1092D601
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 12:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dbd7248ac28so1278771276.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 04:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704457381; x=1705062181; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C991Kcbi8EdmQDb3tJTHkkPG5xfVAMnq4S41RyLoAJA=;
        b=nNWtshWn9oJvdWnyqS+Ns9La/+xMhCn9m/A9Svu7HtKmnCPhFhAW7vAcqR0lQWVn2O
         dsoXAuFj3B1N0Q04ZzhunxyBifeowuaJwolIPOMsyfW5mH+eLCB/HrpKGwNvxUDwhxtA
         m4lJcZLzDIYyzqhh2XX6wmkk9NXNc7/RAhYBDPvvakBojk0vU+s976y2rwys5s3lshiH
         /kN5qAtYbeN5K2ey1Y6IGk70S9QeD64R7kZte+LeJiSrIRQV2T4qyeKwOpBMAsu7i8Gj
         zc9VTWGi9SQL0ULdm/2Cj2fqUu3YwKM7tfpFz1TJNEPb4UL6bV5DSB+2FyBSAr3QqDNz
         m09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704457381; x=1705062181;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C991Kcbi8EdmQDb3tJTHkkPG5xfVAMnq4S41RyLoAJA=;
        b=msGWj4tJy0AC4TFCSdhBIj/ZmKH+IRR9/ApAQuT4SKtCMN2OMdwSb2TBergGQlhjGO
         pMLIVv8KHztmrZDUM27H+b5d0hHAA75zJNdTKS0DVOj4z2mDPcwx+UHaKT0q3JL8TIT+
         r5KclniMjgKlRutt7XsOBySo4ohMC6dNOcJMSKB+bXmdqZIVHTZ3K0uZuloczB0ukSDK
         6x0H5DOR16ckwdjWD1GvlDgFFScG1XVrr7v4GVbHn5nov817sf3iMOjE4bKMhDEDFOQS
         mBJSknW+DRUC0wIk+COnpY5QL3PYvfXwDeXr5H/MnXBi1S6RxrXzDMrM52qtE/zrkNqH
         X3nw==
X-Gm-Message-State: AOJu0Yx48nqwg46re3WoC6zBnAH7UfO5XVNY5oyxro64IF3Mofs15piI
	SMqrrHuWYHqH8P2pQTlG7ydF2iEMjEttTm0kNONjRdhSZqGlFg==
X-Google-Smtp-Source: AGHT+IEQgV5OrCEbtp12b8sdijpFbATgHeBlCuEInqUi0Sz+2wa1gWwH/h4tiEQ1nlBc7EOO+X2z81ICI/1YvwpoHec=
X-Received: by 2002:a25:d64e:0:b0:dbe:32be:f6ab with SMTP id
 n75-20020a25d64e000000b00dbe32bef6abmr1591563ybg.47.1704457381162; Fri, 05
 Jan 2024 04:23:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105-phy-qcom-eusb2-repeater-fixes-v2-0-775d98e7df05@linaro.org>
 <20240105-phy-qcom-eusb2-repeater-fixes-v2-2-775d98e7df05@linaro.org> <158df3b2-a7fa-449d-9cc8-1e4cdf6ef49b@linaro.org>
In-Reply-To: <158df3b2-a7fa-449d-9cc8-1e4cdf6ef49b@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 5 Jan 2024 14:22:50 +0200
Message-ID: <CAA8EJpq88bhFFY2RcSEqaecoTw4a_ps6Osx5rJs3s0Mi7toXyQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] phy: qualcomm: eusb2-repeater: Rework init to drop
 redundant zero-out loop
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Abel Vesa <abel.vesa@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Elliot Berman <quic_eberman@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jan 2024 at 13:44, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 5.01.2024 11:16, Abel Vesa wrote:
> > The device match config init table already has zero values, so rework
> > the container struct to hold a copy of the init table that can be
> > override be the DT specified values. By doing this, only the number of
> > vregs remain in the device match config that will be later needed, so
> > instead of holding the cfg after probe, store the number of vregs in the
> > container struct.
> >
> > Fixes: 99a517a582fc ("phy: qualcomm: phy-qcom-eusb2-repeater: Zero out untouched tuning regs")
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
>
> This looks good as-is, though I think my proposal of storing the
> peripheral base reg instead is still better, as it'd require less
> memory (no kmemdup as the regs wouldn't be modified).

I'd second this. We usually handle such cases via the base + offset
rather than patching the data. If regfields can not handle this, then
the regfield should be fixed.

-- 
With best wishes
Dmitry

