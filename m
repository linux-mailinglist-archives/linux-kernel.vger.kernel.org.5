Return-Path: <linux-kernel+bounces-85660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D546186B8D3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65957B26294
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6122C5E09E;
	Wed, 28 Feb 2024 20:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeuT4jM8"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694385E082;
	Wed, 28 Feb 2024 20:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709150743; cv=none; b=ARpbiA53cCw/MM7gF5zgolPG49VueJAF8XE0Qm3FWnNOeo1twtU+cFvOud6P9kZbwP1GglMPvqytUCDs12+2Gn5+3DNXfoBbd8FZlouOBSKwytyg2fe9kTzGzzDL2qaYtK14BZdy7ntcMN6SWgoflWgpsXr6f5aFFerY5HMqi+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709150743; c=relaxed/simple;
	bh=JyzblYRLS8E8XE3eC8RA0bLn5Z5XB1jUOsQNmooG598=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bfJHV4mKHxWm9Ho4mLWzNhdVllnvH1GKVXeGG3R0kPV94RVPIteqHXyJ/jGyjsvm3ktMHtviZ+z7mWluhPGA81buuYM6qzqOT4lIrRWFLxgAR5jHshgQZe37ir3eYyT3BZbsNi6sxpOVKd+RxJ1zZMHEtm8ppOKj+hLqP+7A7a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeuT4jM8; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cdbc42f5efso30933a12.0;
        Wed, 28 Feb 2024 12:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709150742; x=1709755542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyzblYRLS8E8XE3eC8RA0bLn5Z5XB1jUOsQNmooG598=;
        b=CeuT4jM8P1TEMiDVRWCHIUEc5fiZQDStaI++aBrsFNLcIAL/DhdCYf+yI6psoKwA1V
         bReTCUjcaXz88xM1pe8Inmd7vUYD7GsspXwQagSMuePZXrd0qO2Y0Pnheu5LzM6GLs6X
         VcEBQQV7YCiRDFx6h7/ix4wPztQILuvXFWkiJxMurp4zledi/A3ueqoV4QmcOIrcpcCm
         UIyJ4dG6GpgyGHaEs/Cwf0gtvTUmvxlRNgPZqTLFrGpeomcPY+W3ys9UIfAuN7WwsaGy
         2PZPxyOBOMbme3jdUEcL6X6ai+/mfwXMSlrffQAh8odcGoTtxRn7V2+mZ8reYJmnJcz0
         8GAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709150742; x=1709755542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JyzblYRLS8E8XE3eC8RA0bLn5Z5XB1jUOsQNmooG598=;
        b=GeZCpwMR7bG7XtAqlTk7YrgR6QRxprAftymJ6BONjxqNiRuCflrOL61GCUMNaBfSc5
         /QJ56gZMJXuB2QVoUo936hssP2gs9DuOLtmLTFJhzstN0vg+KL5vX9tUPlG9kUNI9/aI
         Uqoagm58xziCqZ+mBD6GdfbgUxmBbiJTqV33f8k5uak6Z0E9KJTeW1pQNsua4YGCPLO2
         uunhh+tSxwx871bGw7IkItoXHdtFgfg8LFODzgc9KS944NFOOtKRnog7gsbYTFV2jf/J
         TFrpHkUnHISgDXjAyL89PNxkrjn1a1FrkTT7ETcQqBCK6kiinv54+LS7pmjA8aVJTdbX
         sA4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWP0Ze+/UXHhp5X3r10TFjcGTjv/wP184i33EhwATVb8CSyZz1Hc21CYGaU1kFI72MoPTFOqK4V9VPxngi8m2hnrE0ZoiPY9uP4vn4bTfvUtgstp88lpxpoyO8tC5cxt3/w2m9k0zfThA==
X-Gm-Message-State: AOJu0YylF0+0UUGR6BEpLKmwAIz6k4DIQhoGg7BXMhyf5WqU2spqENPx
	urgxPaeL5bbjt5V3/2x+npRwUNcMWUbCeoRGshHY7B+CKq2flET/xi5wu3rSCEo/YHva/r9mGOz
	f/qhIbqoZbgxip3cNP7F1NFKTuSw=
X-Google-Smtp-Source: AGHT+IHsZRLMml+PbJzbAC5hyexFcCLbAN6MYAcVHavIcmX4gHOzbuOqL2mhWHFmJXyDbJ0yPEVtzoItViR3sAG6KG4=
X-Received: by 2002:a17:90a:7565:b0:299:3748:4ada with SMTP id
 q92-20020a17090a756500b0029937484adamr228138pjk.1.1709150741772; Wed, 28 Feb
 2024 12:05:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228-m4_lpuart-v1-0-9e6947be15e7@nxp.com> <20240228-m4_lpuart-v1-2-9e6947be15e7@nxp.com>
In-Reply-To: <20240228-m4_lpuart-v1-2-9e6947be15e7@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 28 Feb 2024 17:05:29 -0300
Message-ID: <CAOMZO5CiO6jhyHv88xySn+rFEqeYbdcGjN_KTQkOApy0H6efnQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: dts: imx8dxl: add lpuart device in cm40 subsystem
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 4:55=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:
>
> From: Alice Guo <alice.guo@nxp.com>
>
> Adding lpuart device in cm40 subsystem.

Don't start a commit log with "Adding". Use "Add" instead.

