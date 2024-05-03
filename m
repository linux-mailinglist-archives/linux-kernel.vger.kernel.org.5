Return-Path: <linux-kernel+bounces-167649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D03E8BACBC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E725C1F22010
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5474B67E;
	Fri,  3 May 2024 12:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiUVUmdc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5498152E1E;
	Fri,  3 May 2024 12:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714740299; cv=none; b=aGRqP8fnJ+vgMTehNBNsINZqxt59kuEdSWPPr3i4tasB6CUhLa74LMOwk3YXM2JJpVAOVQK/ZPQ778oiESFHuoctA2LQMeCNXlLhuxX4su5HxTgrOp/S2K+cekRLTU4ipurzEs8I5mZHsuduQcKo0WKg9yMFx2RyrGGSFN5BR+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714740299; c=relaxed/simple;
	bh=Q1K0LG/hc88SOG/DFNfnQeeuOWApQi+WZVzmhWlJmFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t9uxqY9BLWil59u2oYfLRFFQI08RUoQ/p6bNtrqa8oqIpnIOZkEMHv9OojU3wfXl8CvDCLAuWW82IQ4x3rmz9xRO55EBJptf2EihMpZW1HJCtB2LzTgebBvAQxL8DMMIRmni5X3SMjBxjfwd9PuRQsnY4FOqlZeVs1XzYbSZGH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiUVUmdc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592B3C2BBFC;
	Fri,  3 May 2024 12:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714740298;
	bh=Q1K0LG/hc88SOG/DFNfnQeeuOWApQi+WZVzmhWlJmFM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BiUVUmdc1PEABxzY++rsSOM3OPcJbeDk3mZKoqXrHUOljAjMJJRs6DGMbcaAiNapz
	 ekB4AFLwGi9H83+3VTULvORdRfacfQcKdrBnTHk0xnZayj1F2QYAgHaKCWPTSsALaW
	 Wmfn7FwFIPdyuPKFHY80i1wR3Skykw+OwAslZDiHV34TMB5QMkZvoDRylq59Xg1/Qb
	 eX72urZFpjBbaKCcEyS8hNRrFld8n22Wjh6M03kIH3X+tlidJc9wqfe0u6g5DeBfHz
	 EWGt1Um4KPidfUMap960e+VlEss3kRNvzZ1MHv6A9bHOuk4EgOS3peG1cVsTT3Bjcz
	 2oc5OcU0Eh4sw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso14091920e87.2;
        Fri, 03 May 2024 05:44:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVWlLE/j0pLYzMXonwHJ5IbsrtGHtjOxXxDlTrdXEHD46ozshNua1awEBO58eronqnppQvewENu1qn1XuWEz0L+Cm+26kufSfEPWyUxPxXPT8B0H+S+56rolax64j+GJw5eCoArFslC/Q==
X-Gm-Message-State: AOJu0YzY821+uKlLDkUcNB9hauikF/Oz6PE8P/HGHQkWp2OA3GvqWCZa
	Pe/tgRE1p2yhjesNFKQceHbNmV1QNA2KylU7KAFXpglA+AaFD/2VnDN4awWqb4Ll0GolYivOY5i
	In9gZX3U5+bbRcQ6u9z/MIfQ3Zw==
X-Google-Smtp-Source: AGHT+IE/PTZ+vyxHB0vTeYK1HIk16HI614VzsvVRLNOydLs+muABnTwiFLrGXvHp0oGN3rEVNwTMCCIE1utFGI4arKw=
X-Received: by 2002:a05:6512:3d87:b0:51d:a208:2282 with SMTP id
 k7-20020a0565123d8700b0051da2082282mr2966851lfv.51.1714740296560; Fri, 03 May
 2024 05:44:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503141548.68c2b106@canb.auug.org.au>
In-Reply-To: <20240503141548.68c2b106@canb.auug.org.au>
From: Rob Herring <robh@kernel.org>
Date: Fri, 3 May 2024 07:44:43 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq++BkQeXBKqYzQqz_DO=r+s7oT7QoOx3kObjHYDydp5hw@mail.gmail.com>
Message-ID: <CAL_Jsq++BkQeXBKqYzQqz_DO=r+s7oT7QoOx3kObjHYDydp5hw@mail.gmail.com>
Subject: Re: linux-next: duplicate patch in the devicetree tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Lee Jones <lee@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 11:15=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
au> wrote:
>
> Hi all,
>
> The following commit is also in the mfd tree as a different commit
> (but the same patch):
>
>   828215066d88 ("dt-bindings: mfd: aspeed: Drop 'oneOf' for pinctrl node"=
)
>
> This is commit
>
>   8f553c27697b ("dt-bindings: mfd: aspeed: Drop 'oneOf' for pinctrl node"=
)
>
> in the mfd tree.

Now dropped.

Rob

