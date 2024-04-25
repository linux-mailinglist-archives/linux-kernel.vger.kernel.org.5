Return-Path: <linux-kernel+bounces-158481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF018B20BC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F27131F26176
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4319E12B154;
	Thu, 25 Apr 2024 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kyi2H011"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F5C12AAE0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714045826; cv=none; b=del4m6ttjxhHTZsbtgQhrDMF/rf1jjAG98tn62i4EajFAGhLbD7clK4xeOiED/PrPS13N1hgo+jRH+tl26gJjczpSh8wbT6z0ji9kfKTTP3iblZWdVO7FC2UodtMpuR1ZnUt8YNWOftgVLoAho0u4nYhvu3eBM1XW8oqZqFqmf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714045826; c=relaxed/simple;
	bh=6X90SrMENmPj2F8E+j2MRnzGgHoMOcwnFY9jZAuri3U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZzWzt4y6k2Edhn17Yq5NgBH++8xpr+ya2fWz/Rmb3Pa8h3IkM1++tBXkhqvjz0Qe138LdTHW9slht0qufjYqH0gFLeetMqolO09GMI3kvBH2wYRjf+BsO7TUnXGsU0IN0OIlzp1mVGyehDp5b3xHGQnyn80zPzVGjf2Odq64r7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kyi2H011; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3499f1bed15so1175171f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 04:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714045822; x=1714650622; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6X90SrMENmPj2F8E+j2MRnzGgHoMOcwnFY9jZAuri3U=;
        b=Kyi2H0117xIsE8cvv7in4YmWqDUx33JTPlWpOsXzJ7clB2o8iFYfwTBa64+ZJKmIS6
         kAYT1YvUKsWbZT7K9k48W8dDGAFDDC7Dm8aWJek+6nmIVLwfrH32pkTNSEnKHHBgb/Xm
         LBFpet4OqALHQefnHOd1hCx0XLSxnJXC0WsDhy9W8Y+ByveTjcwgnf6WbDrm/Ecqszf1
         lBo9dCOSr+/X4WxieS/r+RG0cls+B7e7yGU1h83p3tMgGtR51zA4JH1GK/9OaIoTqALY
         Mzr85czlf/JGYe1HAtgnVrZMl4Nm0HDxpR1o5+5Xbw7OvMpt6EkWv6yfm9+Ys1T47UbR
         IGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714045822; x=1714650622;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6X90SrMENmPj2F8E+j2MRnzGgHoMOcwnFY9jZAuri3U=;
        b=BaVM54hCTG4FHijsBhgmtVoNQshESmIFp2QdJI5bnRGsbNYxJi2Cbj3RLgpEdAeYXa
         5RmTYHqa8uC13PqubDJZ1gt2KFQZq37qMvG4Z7wQ02VlnfwqI1bUXt6VfR3C3D4tFFQ2
         bmllqkncY5rfh/CmOrevPRcOb8MBY52hbLPLIzrgV8yGTZMnlou4vsMq/plmrzVjd/Wh
         uhviK3zJujRFuAYeaWr4u1kxLo8KJgM8569JyHBkzJdw/QVV3dlaiKw6lF4K1GIpvxsH
         BmzWMrczjrJlcP4i32lz8KB8SEj+tbZVrEgdekzExvHq2uQyWFdyMz30lTNdI1yedliF
         p5Ng==
X-Forwarded-Encrypted: i=1; AJvYcCU82+3pfuZmNOyUpkLm/fJem+oXquateenFm944Eb1wMyaco4rgJDmrtEf3grjkoo3AdGytn3rk3GMhIbCbIW9Y4LjQGc2Os4H0MfBp
X-Gm-Message-State: AOJu0YwNjD9Qikdf15Scs2/Zs1Z3WPuYYbM1li62Gq7RDdV1fEnb9lHp
	L1JxtGirr9YfpFyH4mz/6prI/0XpseFKPDME4x3lozD+z7nkq7PUh0kLbN1aXNg=
X-Google-Smtp-Source: AGHT+IFd3IUrl2RhAWqNwz+jhkozMToyJuHkmRsv7L8RtAZdqq/rmyIrab8etOh0MMSjsigMRTo70g==
X-Received: by 2002:a05:6000:789:b0:349:bb17:6e60 with SMTP id bu9-20020a056000078900b00349bb176e60mr2805121wrb.2.1714045822352;
        Thu, 25 Apr 2024 04:50:22 -0700 (PDT)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id he5-20020a05600c540500b00418e3c5bc8esm26152587wmb.18.2024.04.25.04.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 04:50:22 -0700 (PDT)
Message-ID: <db857c14d2463f643dc602012329b75df8146c0b.camel@linaro.org>
Subject: Re: [PATCH v2 05/14] arm64: dts: exynos: gs101: Add the hsi2 sysreg
 node
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, mturquette@baylibre.com, 
 sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
  vkoul@kernel.org, kishon@kernel.org, alim.akhtar@samsung.com,
 avri.altman@wdc.com,  bvanassche@acm.org, s.nawrocki@samsung.com,
 cw00.choi@samsung.com,  jejb@linux.ibm.com, martin.petersen@oracle.com, 
 James.Bottomley@HansenPartnership.com, ebiggers@kernel.org
Cc: linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, tudor.ambarus@linaro.org, 
	saravanak@google.com, willmcvicker@google.com
Date: Thu, 25 Apr 2024 12:50:20 +0100
In-Reply-To: <20240423205006.1785138-6-peter.griffin@linaro.org>
References: <20240423205006.1785138-1-peter.griffin@linaro.org>
	 <20240423205006.1785138-6-peter.griffin@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-23 at 21:49 +0100, Peter Griffin wrote:
> This has some configuration bits such as sharability that
> are required by UFS.
>=20
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

