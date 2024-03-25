Return-Path: <linux-kernel+bounces-117350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7D088AA52
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C9862928C4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05AE137C36;
	Mon, 25 Mar 2024 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pWvm9OrQ"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0910137C21
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711379897; cv=none; b=MOL/KWZjTDNuq9h5+pW+TQ6gFoiBK/s2oaoudEEgb6N9qgoQ6HbXc92I1NfPasDT0GuwtDfKdXLtttBRNRSjanpWK9kajw6ztD7g1jtMT1SW4z7mnUwLUL0vBiT452dnXAYWEyAo5m2yPH0XReAvIq3bAidzGvITe0u3J/UJ0Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711379897; c=relaxed/simple;
	bh=TkIg/lvjEPz5lcPcLRg/J/Sr6mWV/AKKVZgeMpHf6WY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZjtoXSqf/yiJ/9YAqSKoUabOG/3Wwq0CQSxytJeDU49v+CtnXJ+4j9bdB4EWMsPIjcpm4c08a+gdSIN+Eu7GSfT75VRlBtS5N6RmfeD59AweljbrLLBOIn2nyp2jhh/4Dk5u/6lXujthPGVMl+7K6Zjo0hplpGmdezhwiWEdq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pWvm9OrQ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e6082eab17so3352646b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 08:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711379895; x=1711984695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpBAbzji3EZqSEp3CbHVVIz9w0o8Ay39z1NWcQVt35M=;
        b=pWvm9OrQCBv3sBn4xWH0vIGXjZLUhBk98tx9Pd+od+zIxS8lYSSdnGGQkQtsdYceNV
         w+hPXK2iUh77vgVaeYJWDYS/rswnwixjlh7eecQd+bSYwKOBlj6B1449P+Wrztz0/rSC
         0f7pFeaPZ8SmrS84VB3Ui+lF5icqeFSK79wILWTQCD2+hthUWRSUGotq6+rgYi9YYz/v
         uskov0NBgb0UgZ+4rMFndM+lDJKKCKRsMeo3zBCHyswOXUPzmkn7H1b9LC4ynjsWo09S
         hgIsrzeAQN5Nrigoz4ppMf+xCul0CkCRq3QwlSoI/ysqPT2FaRhmeyLdaMrU7e3t+ymd
         m6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711379895; x=1711984695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HpBAbzji3EZqSEp3CbHVVIz9w0o8Ay39z1NWcQVt35M=;
        b=TLBdcQNNonO63VuR3GWIbXBFi88lv8uXGChH7TO7IBMpO6QNCBmvc+RQmN9LDsV7j3
         K7Y8pGneYgwrAP0cyLui+vccMJLI1zlJ2bZsBPCZURjXewHWA7sIGigiHUjj6ZMYeH4V
         r4847NQuu9bBI0BTQfZwMQux7d5soICWVArLib1nESxn/wzWQyec00RkAogut0UZbZlc
         QHMeQ49s1rAuD3YYlSHhiwe930H3oRPyz/gFg88wTkkrr08c88YK3JHx0LgnnvGDyYVO
         awo03a9yx15yGdIZvxWRSZAgrQGP00Fw5yX3ks4V6ZvAwcImx+wgV8VTzk083uMTdmXX
         /ULg==
X-Gm-Message-State: AOJu0YzhBb7+qBDbrPmI3dm4g+B/aj3vy8AeCzaRguqfcBryiBYcepih
	IqGp74VbxitOMuodUHhvWOAxOdX0qvbZL1Qvrc4czQqYWhNgHsCFDmkwRNMm7mQNsiKiROBAaxc
	9+HvDoCCVLoUIl4UPJPfaN+RKqB1ADaYnSn/oPA==
X-Google-Smtp-Source: AGHT+IGWAxEkzcutnF2I8XHXBCPmjLrlOrn1iC4dX+mBPPeimz4g2ntb2COkxyTtkZYbEYLiFCeB/h6rAYC15aBHuOc=
X-Received: by 2002:a17:90a:f3cb:b0:29a:8c78:9a7 with SMTP id
 ha11-20020a17090af3cb00b0029a8c7809a7mr23661pjb.40.1711379894874; Mon, 25 Mar
 2024 08:18:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325120018.1768449-1-sashal@kernel.org>
In-Reply-To: <20240325120018.1768449-1-sashal@kernel.org>
From: =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date: Mon, 25 Mar 2024 09:18:03 -0600
Message-ID: <CAEUSe79J7w3=oRAkTks80HLR9CbbkzGXTnubOuzmBYpZBnnttQ@mail.gmail.com>
Subject: Re: [PATCH 6.8 000/710] 6.8.2-rc2 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	florian.fainelli@broadcom.com, pavel@denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello!

On Mon, 25 Mar 2024 at 06:00, Sasha Levin <sashal@kernel.org> wrote:
> This is the start of the stable review cycle for the 6.8.2 release.
> There are 710 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

A newer revision was pushed on to the linux-6.8.y branch a couple of
hours later (f44e3394ca9c) with 707 patches. Is that on its way to
become RC3 or is that Git SHA superseding the previous revision
(eed20d88c6a6)?

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org

