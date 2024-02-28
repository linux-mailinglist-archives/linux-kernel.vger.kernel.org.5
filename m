Return-Path: <linux-kernel+bounces-85091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC4086B050
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4759028ADC6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA33D14D44E;
	Wed, 28 Feb 2024 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geLb9gs7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F327B14AD28;
	Wed, 28 Feb 2024 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709126904; cv=none; b=PV+iILMP/8tr82PQewUsNtNLq1XC5EG1QpLAXpzII9cpMfzuwwbbQkv0VqJ3Pd2LCmf9b/i8Wz19wagbjjt03E2YFz1hoROCWod8Qr0WKGtzIVuPSiurYrgU/wESm3MnJ2i5Rhl9IHhHsxnEzfiUMv1LX3kbbZAEqmfIXnXUkbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709126904; c=relaxed/simple;
	bh=QPePrt7BYydJyB+XCg3yIqQouYJQOcNHwBd3yY8KpGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ApgVYOr+xT6zji4bESklD6PEXZmgynwRYCY3eLJP5Y61bX1TsSwbGpI+bHOZpqRW/ZhZ+sJZCVzLe1hdl6sZJ1bdRAAdM228dARkvP8PZAmLpd5yKPBCP5o+p+GVw4VLZXtLCLGCQEDArWSiGRyFjXpcZab5QoJyd8QIJml3vuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geLb9gs7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A79BC43394;
	Wed, 28 Feb 2024 13:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709126903;
	bh=QPePrt7BYydJyB+XCg3yIqQouYJQOcNHwBd3yY8KpGE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=geLb9gs7/DSTWMpnNsbZE/FHf2iICrMqgAfpX/Y7iyaRdFkobOj4DeV4TaTiBpj7R
	 kk1VX3akE7RXikvxrrJOLRJsp4DH04mxlOr1wTY9IFDQ+JQ7weTbNoX7by29WOsjUd
	 zsdTVmpx37n2B+uS8XRo7uF0ZDzLFkI06xsTlNzuiVGBWiv/V3YXDioSuRvxeZj3mg
	 nLxxTWf8PcRJd7sKHqOvWj9xR/5hYX8pbVDilnK+JKHEvDycf0GLbFL3/oMOR5kWMy
	 McdqDIys4D5I5w+p5UPELsvBKuKA9hyscthrKkNnCLeSHJM8hzQZ4bG8IFNSSPJNnc
	 cy3GOsh0hd7AA==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d220e39907so85167281fa.1;
        Wed, 28 Feb 2024 05:28:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWgqW5bs0NJM7vq80pOi5U93lm4hvXBswydqDl7s29dbaEols+pMBDdkuoTl4dmYzVBFDjDqK7s9m1mCy9GEJoHd3Rz3M+5yGnKJmwf8wVVpAtMy5Am32msbO3cxgacdeexhi4boH2i6w==
X-Gm-Message-State: AOJu0YxeGhX9hoy9KSYm9PBpTMFExTdFkDilII0fTt0LXnNqZV+wMTD0
	RLV6Hxlse+W+6awvP1UxIlG5rQHuR1ub2PyF1qYcNvhqjt1hM8l5pdEBvIpjvm2ZQjSYBLcEMuF
	egzfgThUbRN99SfVnKPbIlC3sTw==
X-Google-Smtp-Source: AGHT+IFNE3ggmoo0YN0c76XjpmTQyQsVFYj3QOWJW+s5Rqj3IPjETuRB14UQmDqYXEGr0VB5YJgdYGMVjZFmxWKReQw=
X-Received: by 2002:a2e:a7c3:0:b0:2d2:284d:3ae5 with SMTP id
 x3-20020a2ea7c3000000b002d2284d3ae5mr10292057ljp.45.1709126901796; Wed, 28
 Feb 2024 05:28:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228062138.1275542-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240228062138.1275542-1-peng.fan@oss.nxp.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 28 Feb 2024 07:28:08 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJktYv+sSfwtT6ExsES5+HqB2BStnEMMRKVqTO3dFJm2Q@mail.gmail.com>
Message-ID: <CAL_JsqJktYv+sSfwtT6ExsES5+HqB2BStnEMMRKVqTO3dFJm2Q@mail.gmail.com>
Subject: Re: [PATCH] of: dynamic: notify before revert
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: saravanak@google.com, bhelgaas@google.com, pali@kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 12:13=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> When PCI node was created using an overlay and the overlay is
> reverted/destroyed, the "linux,pci-domain" property no longer
> exists, so of_get_pci_domain_nr will return failure. Then
> of_pci_bus_release_domain_nr will actually use the dynamic IDA,
> even if the IDA was allocated in static IDA.

That usage is broken to begin with unless there is a guarantee that
static and dynamic domain numbers don't overlap. For example, a
dynamic number is assigned and then you load an overlay with the same
number defined in it.

> So move the notify before revert to fix the issue.

You can't just change the timing. Something might require notify to be
after the revert.

> Fixes: c14f7ccc9f5d ("PCI: Assign PCI domain IDs by ida_alloc()")

I don't see where the notifier is even used.

Rob

