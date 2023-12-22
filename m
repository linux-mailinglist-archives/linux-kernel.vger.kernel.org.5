Return-Path: <linux-kernel+bounces-10082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC19681CFCC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8191D1F23D93
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F061EB33;
	Fri, 22 Dec 2023 22:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jc1gwCwy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3056D1803D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 22:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6dbb650ad59so1433113a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 14:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703284254; x=1703889054; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WwejgOu3CLIEy7WBg6DtMDhgjRDGncrbITb/o+9tVKM=;
        b=jc1gwCwyQC21YuJLxDsICmF8Dbjr0sHq5z+GvXy0tBzbhINVUHXoKTR0gSBjt4G+w8
         eDOeDBMbAgN9/1sDZrT6xsfOPHi9t9AWRVlSc2GGUBCLE3/GMmblVr2nA6eqkaKl4dop
         eKga4UW2c2Ia9GROQ/9shFmdwHRT9crzltIKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703284254; x=1703889054;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WwejgOu3CLIEy7WBg6DtMDhgjRDGncrbITb/o+9tVKM=;
        b=Q+o7wkj7aZqE1MOkMdgTnOu1vSE+RWU2ywe++8fYH+M8B0/dE4208yXaaCgfkKbGl/
         v7C1xajRGbVCkmE4D5JYPhz+1dwhN0k3oGosPqHw7GHn4p788OYpR242tqUzq8ocmvYt
         Q7Kghm62eEJLPiyXIC13McZwTP/jxW2Ay0sElIf35XTTJ5LarW5paHSXJgoHB6jWF3Fw
         D8Pupody3Fjd06d/BvMW8SoyUhe6guHPpZ3eZZqfGV1oYT7z0M0kwGpLx76XGMuWk1m0
         IGbYklhsWJc51yuB8b1oCJu2/d/cpQqVW+RTsYjjPML438mByf9XAC6tgLjmEDJkwllV
         bKEQ==
X-Gm-Message-State: AOJu0YzL0wN2ogBVJyvpJUg5w81BV2omRnY5larNzVa/e71xicSBPAY/
	KLHD0KyuymgzUUtBSrFN3bi7bG5KDKbH7QemVrWzarB2SnDS
X-Google-Smtp-Source: AGHT+IER1bh8jMPP1/3cXJs8YlZWz0DMEgd5cLDf4OrRRbTGp5gF9dbStw6xbzqvzSRoXTPBelayfBgYtrmw0We3VHY=
X-Received: by 2002:a05:6830:97:b0:6db:c040:b5e9 with SMTP id
 a23-20020a056830009700b006dbc040b5e9mr1589627oto.51.1703284254400; Fri, 22
 Dec 2023 14:30:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220235459.2965548-1-markhas@chromium.org> <ZYRAuY1LGdD8_u5K@smile.fi.intel.com>
In-Reply-To: <ZYRAuY1LGdD8_u5K@smile.fi.intel.com>
From: Mark Hasemeyer <markhas@chromium.org>
Date: Fri, 22 Dec 2023 15:30:43 -0700
Message-ID: <CANg-bXDw+bYNTu-HFaNAPb4e+_oKt2ExR6PehWR_==vpboKGaw@mail.gmail.com>
Subject: Re: [PATCH v2 00/22] Improve IRQ wake capability reporting and update
 the cros_ec driver to use it
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, chrome-platform@lists.linux.dev, 
	cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Just wondering if you used --histogram diff algo when preparing patches.

Not knowingly. I use patman which uses 'git format-patch' under the
covers with some added options:
https://github.com/siemens/u-boot/blob/master/tools/patman/gitutil.py#L308

