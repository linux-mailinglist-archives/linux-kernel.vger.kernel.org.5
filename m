Return-Path: <linux-kernel+bounces-47914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4246E84548F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13E9289FD7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979174DA0B;
	Thu,  1 Feb 2024 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzVuWCGS"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D624DA0A;
	Thu,  1 Feb 2024 09:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706781111; cv=none; b=mBa29szWtIexqaYuL5RgnPLJmTVG9Ui63l8TluDukGG21k9t7fPI4yF3oA0Xs9IOVo7IOCtp36nedz0jVz6tfB5Ws8lEery+GQ4tnSfc5lU+bhrJJKQczqEgWFqRWCww3gYyk1xyJdy/n24fYyYYOPy/nD5f+82N79rcsTa0nig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706781111; c=relaxed/simple;
	bh=E1+GCQDHek1+2wmj8RNma2P9bsBdvtEiwXmkmZ9/tj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FT7y3nSEKIWtIKIvGU5/yopIo/adrgwTym2eLM6v1Jp+eE57adhb0F8orWajDOY/BhmYYu1e/va701TwdOmSBKFsbReUa60b0U7fTydDb0kNVXXyeWt10kUV8Ek5+kJFath1N1eZ55/sVUXeRzZmke6p7b3P7NL2pIIWEZZ3oZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzVuWCGS; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33ae4eb360aso418834f8f.0;
        Thu, 01 Feb 2024 01:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706781108; x=1707385908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTxDGqdpEuvtyT/5nhwfv4UEX1AAehG3D/fXJ8HusCg=;
        b=TzVuWCGSEcxXx2iFx93w8BBmmPNPWdSaIK5LAXv6fanhl+erhGboXBII4BeAY5bxAF
         meyRBx27Hu5DsW0vItBlxltWJQClg7Qvcsjc9bKRuxkXH411tf+E4gbviXXhilJ121eW
         YyezQWQjL6h+FHy9/WV/SABdfvcY6hJZnr8A+NIBEztnf2udvQu8uVqd64C2EGtJpJkp
         HUR9vWVBR3w4yyWSLBetMWsW43CUGVhacEqJcxKc0TkoXTyVxoOQx59fPCALJe/v+Q9V
         ttK+f1hCxyWGfjUqAfe7x+OhVhwYAho4QKX1twZy5kGb9lYitJf9oLLXdE1gHVz5jgjG
         uo5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706781108; x=1707385908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTxDGqdpEuvtyT/5nhwfv4UEX1AAehG3D/fXJ8HusCg=;
        b=WeGuDuF9vD29ZsplstK/iAqwFEZNcNqJO/Vt7Lty/HJoCBDBS4ccXmvE2xUnro4UHV
         4sC0BWtcfNUIO4l1MhNSs4bOq22h6JOOn7oa5VVqPKOjsf91qJ4DrjKPAbKWp5esbP7A
         3C+ux/gSBzLC/UbyI3gy6Lo1PqtFd2Gd0NV1rX+6NJ8ixWrnnsUguy6Wj2h16RXvap42
         wXqowyZqPGGiIZWJ5yhYaDD6sPoHGtaFA5Anaqsco3CgbS9HXrPqIwFsU2uNkZHbjyqf
         ZU5RLX33Jjz27hxAcC2uRkEctJ+8zEUx6a3AQ0Rd3hV6k6F5ZmvEShPN3/bf6HTUnI+S
         fHwQ==
X-Gm-Message-State: AOJu0YzWmT3ZB11og0mlTzWWX3kEMn3C3FsenJylQv6uV+j3CSYtkNZm
	Yp3Ci8gWhG7jL+rXDYQ8dgz+ABAScxwy2uyQsMkPuVxZNTxuzp8tyDgfKT71UaRGryRXxTcXXxl
	Vq3axY7+wZUcB+7P72GR4Tmkgwik=
X-Google-Smtp-Source: AGHT+IE6FpuOwniww3kwxpIiXlxPL2wED9CiYjVdmSfQtdaonn4P9Lxb/XGOgooLPL5oXoKkPzjUlFnpDpylFHowoyo=
X-Received: by 2002:a05:6000:108e:b0:33b:feb:8b19 with SMTP id
 y14-20020a056000108e00b0033b0feb8b19mr1738964wrw.41.1706781108536; Thu, 01
 Feb 2024 01:51:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201092033.10690-1-clamor95@gmail.com> <20240201092033.10690-4-clamor95@gmail.com>
 <523895fd-5a7d-4467-9a51-b5f85668f0af@linaro.org>
In-Reply-To: <523895fd-5a7d-4467-9a51-b5f85668f0af@linaro.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 1 Feb 2024 11:51:37 +0200
Message-ID: <CAPVz0n3VnEAxHviOF1RVzMybVEe=BdMcpPFpZXvpoU7HizTNog@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ARM: tegra: Add device-tree for LG Optimus 4X HD (P880)
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Kees Cook <keescook@chromium.org>, Maxim Schwalm <maxim.schwalm@gmail.com>, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 1 =D0=BB=D1=8E=D1=82. 2024=E2=80=AF=D1=80. =D0=BE 11:22 Krzys=
ztof Kozlowski
<krzysztof.kozlowski@linaro.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 01/02/2024 10:20, Svyatoslav Ryhel wrote:
> > +     pinmux@70000868 {
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&state_default>;
> > +
> > +             state_default: pinmux {
> > +                     /* WLAN SDIO pinmux */
> > +                     host_wlan_wake {
>
> Not much improved around this.
>

All existing tegra pinmux nodes are bind this way. Ask Thierry Reding
about this pls.

> Best regards,
> Krzysztof
>

