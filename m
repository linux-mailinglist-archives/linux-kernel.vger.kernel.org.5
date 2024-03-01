Return-Path: <linux-kernel+bounces-88744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A012786E606
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D088E1C22B34
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362C8282F9;
	Fri,  1 Mar 2024 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="Yay4jHhy"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C0FF9E4
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311260; cv=none; b=QCwQnIIQ178XXzxAOrA+XTHXPsylRTuh17fT0vwM54gfqmrPTgnFPUPszli2vyzJxeTpS4B3fb2xTdn60+09Z68japZzHzxOtab7b52287fs0Sr9T69IkgQ50j1LoF3kkOfT9Tto2meo52/3wfuwxnHUgCFL+xvVJ+DCoho7GwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311260; c=relaxed/simple;
	bh=umTXz3ZT5C8ePr1KzuYmsw8QvuSyN39VEUFqMYPBI90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fuF1jIU1HwWxSGTeUMamELWQovQn45yetJbENhT7g+szQ+9jVGdIjlnROT2FbvHcS0K2sEnL48H0cNpeeUFGetTJvS5mmPbziM3F9DV39owfx4xe6tlmt0AoLbquMl26dNRBzjbVuVQ7dQoZwVvhdrKyvvKWSbnhAoEROIRsAc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=Yay4jHhy; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc6dbac5fd1so807537276.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 08:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1709311257; x=1709916057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umTXz3ZT5C8ePr1KzuYmsw8QvuSyN39VEUFqMYPBI90=;
        b=Yay4jHhyQty7PS90139PV2sT1NSMNvr0neNkhIua7u+WPOM1znpaT1D7t388wjjmJd
         BiZ2rZO4etL4D4tACvnfAFsEwyRwWzzLKRharz0m3kmIxE23Ysvitdv3clSPetRMcLZn
         CMhHll5lyzO9FCmMKTE++pU8SD9PgfBfYu6gkH2Mh3jNknFHEwrlOzuW8+afe+/Zlt0d
         h0WNd/HxCq86038zLfvHnQ3tzdV9aMWuJzNs0fkfI6ANrR1dtrjUpMHEn7qzWGjVIhRz
         bNmzdZk0UEs9B8ym7HM0n7lF5eALL/+SjxrrpWNXI755NknFNpmi9+s8sg201bQQsrtC
         8lCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709311258; x=1709916058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umTXz3ZT5C8ePr1KzuYmsw8QvuSyN39VEUFqMYPBI90=;
        b=LCf7QLIKf2DmgzU3IJ+mCvXZX0G4vRyW8eq01WzRtTjAzyQ7h6JdW3DkftejRBR9/n
         PphO4AjRCwaKr/EsO9ixnY+r+1k27p/kd/Yf+4k/Gw6RdVzgw6Q8xM+1+tCXGHacgIk+
         L0zV7dG4XNdMQ4Rst8afCetwy2BJfP5qVAPABEFLbjwiAr2UM6xHhdwOpPi1xx0rIs3N
         pJJx/vCVNfMwCKIyToAayKLVz5adEMoE0K0BgGM2Uc23VKx2CyjgiwrYUDx6tpOxvADh
         liNumZhIFE33UB5I1zd0hSVsJ7yOYK699rFojE6mp57bMT3zNEs20WoZO9lLmIqXHU1z
         ODEA==
X-Forwarded-Encrypted: i=1; AJvYcCXg628sT9cngOTKqqMPpgDTVd4sKZ5cuPk6s+ypKJ5W/OqG6UtRt15lWbYdqKUJg4B7yhYhBvJ8bxPoJ8PbGqCvev9UIr9nqSsl/zye
X-Gm-Message-State: AOJu0Yz26S8Q6AOaJCvevNIMuHAR8d6MaHCv45XJDe1Re58GwS6Qt+XQ
	r6cfv2QL0DhzIEynWcuSJ2dO1NXVAzylUC73/uEh9KR056N3ktwGUWYthVrF8A4i2xf3QowNkiL
	0IavyeKo9ElGSn9bh78JAKlujUFg2M2Q7ODxTug==
X-Google-Smtp-Source: AGHT+IHXRFn/QAl4LlF978N1B1MGBJwuHJP+r4EDD9WxRcKB0FgCLphss5DFEjZedgGla55+Smy8fhz4NDuMrngyZ0o=
X-Received: by 2002:a25:8044:0:b0:dbe:9d18:31ea with SMTP id
 a4-20020a258044000000b00dbe9d1831eamr1826145ybn.1.1709311257708; Fri, 01 Mar
 2024 08:40:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216062412.247052-3-jhp@endlessos.org>
In-Reply-To: <20240216062412.247052-3-jhp@endlessos.org>
From: Daniel Drake <drake@endlessos.org>
Date: Fri, 1 Mar 2024 17:40:22 +0100
Message-ID: <CAD8Lp45=Kd4pG0RHhsTdg4p3-v+X3xfG=O_cH1OxOqJ4xPx=cA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] PCI: vmd: Enable PCI PM's L1 substates of remapped
 PCIe Root Port and NVMe
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, David Box <david.e.box@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux@endlessos.org, 
	Jian-Hong Pan <jhp@endlessos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn

(Stepping in for Jian-Hong who is on break)

On Fri, Feb 16, 2024 at 7:25=E2=80=AFAM Jian-Hong Pan <jhp@endlessos.org> w=
rote:
> Power on all of the VMD remapped PCI devices before enable PCI-PM L1 PM
> Substates by following PCI Express Base Specification Revision 6.0, secti=
on
> 5.5.4.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218394

Curious if you have any feedback on this latest patch series.
https://patchwork.kernel.org/project/linux-pci/list/?series=3D826660

Thanks
Daniel

