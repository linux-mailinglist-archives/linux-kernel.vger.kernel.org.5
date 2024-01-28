Return-Path: <linux-kernel+bounces-41476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD10683F27B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 01:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D8E01F23565
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 00:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C8FA23;
	Sun, 28 Jan 2024 00:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JPsBH+Bc"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8E5391
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 00:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706401088; cv=none; b=FvCCN0JVafuQiyF/yCcREKqunQ2mR7ypVbLLe6HuGtAYxjLkIOU8+IVlCtBU11tKVTpI4O/f824pT/WH9qbnG6nQJP0bi5U18/cayPm2h81U6uikrc7DJq32sANoOUO+ZyhosCj9vTkdCYYvxA9N28sJ7vs3lar2AcxG6YPzzJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706401088; c=relaxed/simple;
	bh=j5U43ZFbCsJb6lHwAcl1F4qcbBRnNSRS/V/qvHROetk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8x7xYcLwcUH8dlNRIlzJE8uulVG0Xs/Ef1dlbmh9sJ92iFCPNQTbHrlMcrg0zwZNOZ5CMxTNU1gIrZggsxKqcgHDOXA+x+efEYZjLrYiecYL7KWuQ7GbSiiKco9EnbgWIdujIDHYxeDzSCTPIWyV/cLk5nIRK0vVGEWq+9dd6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JPsBH+Bc; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-602cd92a75bso15660697b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 16:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706401085; x=1707005885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5U43ZFbCsJb6lHwAcl1F4qcbBRnNSRS/V/qvHROetk=;
        b=JPsBH+Bc4/47Z68FUI6jiqsHxV1njVROINNaI1NehFG1rl3cqvLilZP4eGMPS5umSo
         UIcXlJ787OJVMZBI9tDkRKkY+e7Jn5HQp3cngQrfkT75uNBbC86BgjSxdO64znnEJaXP
         6S5XI6DfmAaM5gnUPz2VUpXeCY8ohE8HGISUaUddTCWvo9ewy+xfN6jzKsiI2v+wKZm2
         OZ0x1FlKBMDUQKDsL2EWFQWT7kk78gSjYXH9UitPp2JwLpZWZ18MGLaRhUuI+QWNNCKU
         Khbroirwv+pfui/m21yKITAxx3qEFoCMk4zNBvAhnxldFwdUH/5GsuJILsJaOiVULiSp
         ztNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706401085; x=1707005885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5U43ZFbCsJb6lHwAcl1F4qcbBRnNSRS/V/qvHROetk=;
        b=Sm6kYeTjVkInGRvSCvVMlVHKCLvQMMkszI3ORChFop7aUc3BpG+GSIg4CNXxLCukvM
         O2RYBvUWJ2LWtbyjohBMrZXGkVEsnft8Gq0jR5LkoAiNztGvXdPsgwh/WiTi35beu5f7
         6toHTd6OGoQHsQZLu7Hk1YGPpO0dLvJPELax8EQBeKyT4DZkSUHRIphmtH/hh60YIhV7
         8CMRIe5z+dx+SDD2ga9+fre+9InRtEf3M9as0VwRsjNZ/zGyCFgtRYROHAyW+DzcO/yP
         a3KLHtnDMF4JM8dAiCvsYC4P2IqCSf4bszrQoBu31mVcN7CUP5+F4nQ2+f1oYIFdd3NI
         P0cQ==
X-Gm-Message-State: AOJu0Yy2kcHncDVdOPg/TIZztImnRVz4rj+zpkUHO9mSJ/nJpkVUDZGL
	hi6X+me2o6MKe5mTrsXWzs3fzm7Uv0ksWSCG/HHuQiwWxn4XZjpx1pa64UlmyovXMuUHUb+KxAa
	ucR8LRfIMtsw/2FJEP8BE+97uIzgQpvjY+Vjgyw==
X-Google-Smtp-Source: AGHT+IH8cZ3Ct9kEcx0+uVZJo7csWTgzm3s0Y94pW37sweJX/O3Hp57cxCEs9DZdU0aHUa91xmfqMSQTphzmO4zwC2k=
X-Received: by 2002:a81:a784:0:b0:5ff:95a8:953 with SMTP id
 e126-20020a81a784000000b005ff95a80953mr1717410ywh.75.1706401085482; Sat, 27
 Jan 2024 16:18:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119181909.7079-1-erick.archer@gmx.com>
In-Reply-To: <20240119181909.7079-1-erick.archer@gmx.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 28 Jan 2024 01:17:54 +0100
Message-ID: <CACRpkdaDyF-ujRfsKWvbXrs695yTStpmFm=QovU1bnONyOCn9g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: pinctrl-zynqmp: Use devm_kcalloc() instead of devm_kzalloc()
To: Erick Archer <erick.archer@gmx.com>
Cc: Michal Simek <michal.simek@amd.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 7:19=E2=80=AFPM Erick Archer <erick.archer@gmx.com>=
 wrote:

> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
>
> So, use the purpose specific devm_kcalloc() function instead of the
> argument size * count in the devm_kzalloc() function.
>
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-c=
oded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Patch applied!

Yours,
Linus Walleij

