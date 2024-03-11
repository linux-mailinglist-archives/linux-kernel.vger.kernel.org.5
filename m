Return-Path: <linux-kernel+bounces-98739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 073C1877E9D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5231AB2161A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762E538F84;
	Mon, 11 Mar 2024 11:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKUbQ/gy"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7B9381AA;
	Mon, 11 Mar 2024 11:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710155270; cv=none; b=bMHtb6pg0/urjs8YPa2gFCZF3Q9+gLn/MsOWbVMRmbXOXilewC7OQLaL0Vp6cvzziKw1WAnhtl63MnHJBdmi3RCikoIQ91IU4RJQZ6xjInM0ww0rTi+DG7POlODommyP344uhHj5hNBhQzl0ts017LklLwahnvYkMDFhIDB85C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710155270; c=relaxed/simple;
	bh=u9d1JzSR66zNZVrsrBQoXqaf0LOJADaj132DQ7l374M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5IFrPZI1w3Tq+iEL4Ek+ekKf8tQilBZTBu8iC1rnmy83fThsS4XZ79g5Mew6FCsqTyZ2VNXDly0uAs3ZGy8AwGhIapNfh9jMCoCvL/x/0qUIZS2BRXf7JRTpGSzKgkCBeaDao43cSa2efHGegSA5Tp9/4hsRv/wfotwsOhQ3ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKUbQ/gy; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e4d88b93e8so1360076a34.0;
        Mon, 11 Mar 2024 04:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710155268; x=1710760068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9d1JzSR66zNZVrsrBQoXqaf0LOJADaj132DQ7l374M=;
        b=kKUbQ/gyfR0e6VqjCQciMwtX/dDi7Dc2wpbH+ig1mRVj1VmFaNFdbVfPyr3uyRu3Ng
         tZJa17sUkHzTbs18Z5CHdOnBpAiZxI28yrTcsdhsYrPzz3LnL1P5qzmtcmV4AnYM2Q7m
         unjiA9Z3WouU5tJRwHT/GwrNHAX83ZE/rN/SnmaY5i+YWtp3YCLjYmDQvHln1ZMQzEdK
         D31sr4lWm1LSPdyn/9yXqM/dQR8X3WWm4jGh/P+7Sw7cHmElMy6c1Db5yr6Wlig/c8dS
         yWjXeZ+Eeu0n+OaxpL9ePb1FY/p1oreG2kTV6gs13HpU+HIbTvc5bgkh8YaIob+WR10d
         mPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710155268; x=1710760068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9d1JzSR66zNZVrsrBQoXqaf0LOJADaj132DQ7l374M=;
        b=aH+Y/pYn882hDkYqxhAD6zsYbigUb+cBXFleTHa50y15NtzMSn3a73MnSNeeRwJAMJ
         vKWCauA+6ylybW0Gdscgw3PH5M02BFXK9IeBNi2I/axNkSt58ibzHNRnHtsIJg42VFRl
         xsEO+7nn9SWNIy3Ibdc3gMKkqglOVmXz+ll+2uJgoxPlX7V2cNEUaD69NfE1jHQd4M2u
         VX1ZtD+y3qt4oIulE3EXo8GtxbgKjvtgM3KAnSFmBp41hj3JOAWsP2sPdyDc+bpnJRlF
         4R2jpOOyW9QEXBaq5Ix0rAX064HNAObkf9LfQFVfZlAuPMWVNTA3eBXEFZxyXYQ98/8x
         xBCg==
X-Forwarded-Encrypted: i=1; AJvYcCXJ/kEd378WU0fIIZbZ2hwuV+wWpLmR6Oy9vp2mrEQ8bU0uOIiQNPJWwEQQnsTJ63wzbwNW/lbihKXpHxZwkgxwom/s1bZYXosDXMNwUQqWMGkfTDi6aSM0f9VcHGMQ9cXRhos6txgaFqgf4PZWgikb9N/rKVORwrJ0sHunpzP3Xr6Ggw==
X-Gm-Message-State: AOJu0YzOM8iTZpoaZ47ukQ4LgKlEAqzu88nuvEC7p6WzScdiEksQzJp3
	7rv08q1qJO9aloTo31H06IMi44vVjN7lBpNS8PZtLnUeW/uWhY1tybBA0ZOjZ5rjvCVD0wYuwSO
	7UWUy8Fz8GOt/DjrzSg/xwQzAacQ=
X-Google-Smtp-Source: AGHT+IFWQlDG5Q9QZvHc/TFMFGK3Mj4QuHhayOL/c+lQnUCCmF1z3P59KJBls0b5yIanAR4KNRYJnGoF6xtPYH7dHXk=
X-Received: by 2002:a05:6870:b149:b0:220:9eeb:b4a2 with SMTP id
 a9-20020a056870b14900b002209eebb4a2mr6371067oal.29.1710155267993; Mon, 11 Mar
 2024 04:07:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310175217.20981-1-animeshagarwal28@gmail.com>
 <448f9d20-8b45-4794-9440-89d6a6888aee@linaro.org> <011b7c4c-ae44-41eb-b7eb-1a71da669f26@linaro.org>
 <CAE3Oz82ZC5Vz125iLzjsdvZd1YLd4YgQsrGPgTRJ=ugEc=e=Ow@mail.gmail.com> <087db56b-13c3-4624-b3a3-f02989aa5409@kernel.org>
In-Reply-To: <087db56b-13c3-4624-b3a3-f02989aa5409@kernel.org>
From: Animesh Agarwal <animeshagarwal28@gmail.com>
Date: Mon, 11 Mar 2024 16:37:44 +0530
Message-ID: <CAE3Oz80ef3ESw3cus9wyGy2RrMfJWDAd7zkokUPZkTgLR3m5WQ@mail.gmail.com>
Subject: Re: [PATCH v6] dt-bindings: imx-pata: Convert to dtschema
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 9:39=E2=80=AFAM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
> It is simple: the commit message should always explain *WHAT* you did and
> *WHY*. This is to give some context to reviewers and to help with checkin=
g that
> your code actually does what you explained. This also helps with potentia=
l
> future issues with a change as the commit message remains in the git log =
history.
>
> Regardless of the version of your patch, always have the what & why expla=
ined
> in your commit message. This implies that the commit message must change =
if the
> patch content changes between versions. Keep in mind that the changelog a=
dded
> to a patch is lost when the patch is applied, but the commit message rema=
ins.

Thank you for your feedback and guidance.
Your advice regarding the necessity of explaining both the *WHAT* and
*WHY* behind each change is duly noted. Moving forward, I will ensure
that my commit messages provide comprehensive context to facilitate
smoother reviewing processes and to maintain a clear log history for
potential future issues.

Thanks & regards,
Animesh

