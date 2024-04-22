Return-Path: <linux-kernel+bounces-153503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCAB8ACEC9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D11C1F21C83
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2C31514CE;
	Mon, 22 Apr 2024 13:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdrF9n3Z"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDC41514CA;
	Mon, 22 Apr 2024 13:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713793960; cv=none; b=HQb8C9ihGKnlk15TL8j2sahsz0nZLzSplV8NT3nCBXPvWKJIk+iM4SCQVvz2toisxwSXaYUNp0tFCzPkUoFLmxE4mublr39gyYeM7fgVSN3hou+EeClrWXJsypWScY5eurqoue7tiIW4UQ6TCHm4KN7AGPMnnkBL3zuvpqk7xak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713793960; c=relaxed/simple;
	bh=RgGV5FgqdRHpNkwTjPwel9vvVJToun4sGSg0EDak+Wk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B6Wfjw5p3NopmCwl6EPHuUUjZ7r0c67I2hTusXrc+ddU9uJBUvdACj9i2h5klmTXy9B5g8CNckF/MCUuEG4CraMjVTFtxEMrBWte1Hl1nuxpnvEGxln87sD7v7byspv8JczHPkTQKE0eH0qfq4U18lts2mWtEkDdaVo3O6JDP60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdrF9n3Z; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2dd6c160eaaso14294301fa.1;
        Mon, 22 Apr 2024 06:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713793957; x=1714398757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uor42cDG2duLAcTKfbf9bXjHsXOuUhmZfr8MyWHfLzM=;
        b=XdrF9n3ZsdjAH/CuIkrN19YnbyafqQXr3GMNVDXq93AKFUMAmbQWvqujGbCIiDN5iO
         5cCQV0dR7YZMIlpLFioe4ShevFHgiYxG59wVhPsSO5Fl+LeVNfm2C4JtACjHbXg9PE98
         NvDNfpn62mASedCI75yxp4wVn5sOMmWfkSw7HuOcmKe8Tj0JfylC/2wGmAo8W2FsYzC7
         rR1FsaTlrlRn+iMsjobdsbGlXISqNlh9E1ENMd5xN5RbeJMdmRnxwfV9MRF5+DpX1F0P
         KxUTcWp8tnoP2H2dPZz3UpsaGscaUizzCNZAbs+VafZL1itWQx+jmd09o2mnMnalPg6B
         mjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713793957; x=1714398757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uor42cDG2duLAcTKfbf9bXjHsXOuUhmZfr8MyWHfLzM=;
        b=LdEMSQV0tn3DN7OFlMCg4eGyObLol1r3vyPUKBH2RoDBlW0452y9bI+6Rjz6ZR6KlY
         jiaGa9h0GI9BfP675bk/eTktZk1qNVWgJ4XX6Sja+4ypyjuDuXf/GM7Em5KpZDrhQ9kX
         MYZh9kXSON4/tK9EAIvNNkcN/Bjx4OI3GKk1JSos4i8z06pgxo47pvwKDDQIRRko0PEZ
         rIpPN4/Kdr3ZF/C13zC0dCR+n36BLvwEFep56O4Tbjvp8hWHfqvYUOcZrfIwN33nnNvt
         HIf/GK5AOS0HzxYeOhy9/2NdxhOdfET4kGJv4JjkBebnHszQcQNHAwFSOJ+8r/DzWMTX
         1+XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHvJpYXB+SywJLyI9FOLGef2Ul8OnfQ+zO0zrFSLUMJ9TVx3gBEYPxDpyxCpZrH09gpm0g6dTeQgElkGj0dBglD6jUGn+qGjf8Im/sM9bD6KuZtKSZbzQybc4neSQBAGitekVaGYHN5h3JsDtQ
X-Gm-Message-State: AOJu0YyOtyHmx0BIqi5KjkNlMrxRDaIZj/6IGbjEUXYouSLMGDYJCBXU
	q3z3NUNFP47Ur8CemQbF6x6hfeGAunkVzF15kWVjlo5lQhu0UodX7BaL3+qt+4vrNHp9KWL/vEM
	KReXGL1FpUX9fvTpeEiI6oZNQb1NxTg==
X-Google-Smtp-Source: AGHT+IH7uPM29sHTywpZ5JvKlAhMuBvVlZHqTFJ8QK0Nvn8oJeo1tb0xJdDt8+slFvuUFNUQnEICi6FTEoudrtk/fgo=
X-Received: by 2002:a2e:a4b8:0:b0:2d8:6175:b6ae with SMTP id
 g24-20020a2ea4b8000000b002d86175b6aemr6342308ljm.47.1713793956648; Mon, 22
 Apr 2024 06:52:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319154611.2492-1-johan+linaro@kernel.org>
 <ZiZdag8fw8H1haCb@hovoldconsulting.com> <438844e9-47e8-486e-9611-ae524d6974b3@quicinc.com>
 <ZiZkK4BAoqxNg7yG@hovoldconsulting.com> <CABBYNZJ1H7eEi8qsZUAxOa5HoE=xQ0wb2YFx0g7-SxxkNAS3Bg@mail.gmail.com>
 <ZiZrZFNLg8pyoOkB@hovoldconsulting.com>
In-Reply-To: <ZiZrZFNLg8pyoOkB@hovoldconsulting.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 22 Apr 2024 09:52:24 -0400
Message-ID: <CABBYNZKyvS7DCALTTTq_nDhCKxdre7CQ4BF6j8HFy+5zdSU67w@mail.gmail.com>
Subject: Re: [PATCH 0/2] Bluetooth: qca: fix NULL-deref on non-serdev setup
To: Johan Hovold <johan@kernel.org>
Cc: quic_zijuhu <quic_zijuhu@quicinc.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Zhengping Jiang <jiangzp@google.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Mon, Apr 22, 2024 at 9:51=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Mon, Apr 22, 2024 at 09:44:59AM -0400, Luiz Augusto von Dentz wrote:
> > On Mon, Apr 22, 2024 at 9:20=E2=80=AFAM Johan Hovold <johan@kernel.org>=
 wrote:
>
> > >         https://lore.kernel.org/lkml/20240319154611.2492-1-johan+lina=
ro@kernel.org/
> >
> > Did you send these to linux-bluetooth? I don't see them in:
> >
> > https://patchwork.kernel.org/project/bluetooth/list/
>
> Yes, I did and they are in the linux-bluetooth archives on lore. Not
> sure why they don't show up in the tracker.
>
> Do you want me to resend?
>
> Johan

Yes, please resend them.


--=20
Luiz Augusto von Dentz

