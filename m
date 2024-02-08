Return-Path: <linux-kernel+bounces-58049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B29684E09D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E236A1F22A75
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1E671B47;
	Thu,  8 Feb 2024 12:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwemKtfd"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0696071B3D;
	Thu,  8 Feb 2024 12:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707394933; cv=none; b=j6VrYUaaZ1FmTBSpDadYP+AaC7MrdcrHOBu+G+YwgVKcV1sw3a1qYC55eOmfC10U8ZP9akAyo5q+pkeo2AO2JXpbB/91jc8A8JCR3Wlu/tOoVSnPnqYcfCoI8OwF0bVrxHvwny08VWJm+7iIjHps3iJEaj8F8FyqwC9pNoF8BTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707394933; c=relaxed/simple;
	bh=U+DMwyzmRR9CBmLaai/l5Kwrec1I3NSB8lkyrSvGNhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gxb27/q1Zk1IR9eQZrJE6TuV+6ghW4QYdmuFIUG9dmA4WwT71RTsAXjRu7F+DaGd+czalH4/O8xClsb3AAk7MM2XeLPA6Jhx7gnFtTCq6mfuMogd8HX9mLLkXltsInObP2/uNN2oQzXJWWXJXXW7B0icxDJpfRzdkG1sVGtkpjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwemKtfd; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59883168a83so730233eaf.2;
        Thu, 08 Feb 2024 04:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707394931; x=1707999731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=144DI0Veqaim/iJs6xSww4yxnMJMOZLoTbkMNqq6X2I=;
        b=IwemKtfdD/EduiqhzSGczFRaqaD7HkNWph3RayS94+voyUO79QP84adDH03EE6vPCi
         7/wf+0qPdAsSPlFNsrz7Y6BougHbI4rwG1gM7DpuO/mm91UDuHLMtgujPeXOIM1u/yTV
         3RSed6DZfbFdhDCeQp7yZdS28sgPv1ClZ11dgz1TmZOlhW4FvBgGEBInwqosfhAMVYg4
         KcSEvKGfLWvRtFaQnfA7drG/ECJjuaIoige6yS5ssvagS5SsSrLjpjkZMhxT2u/Wzhh9
         kc6pwukF+7XpzQInJ/8VIq9j7l8nqYBHEJleUoYclp564fmINAl99HXP0WttG/MvX1wk
         e1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707394931; x=1707999731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=144DI0Veqaim/iJs6xSww4yxnMJMOZLoTbkMNqq6X2I=;
        b=dfd3aBSgAxkxifOu+Phd95ExHJaKVQ7oknm+HR4DId5k+vOnVFbLcMFOPz+TB2RkBh
         Fp6i7GSbe9Scx/P8ODy29MG8H1O1y0RqrjLPXUrgrSQAAbrb49XIUnS2rRnJw28TqMvF
         CJH+m7h7Nuy/vgWtwUD/PQbNKK4PZPWhufylfCpsPFffX42pStK9BnNRBEcY9YPFYYqI
         BNLAPQ90AYxqphRmgf/VKLMjblg5jnQHuXVeoKGYq9rnjRoITkLPMDPoXHEL1JntTtWF
         oZGJygaSUT5G5EzP8iQMBazjf13TdBFBJw1x1yNL1LdGehWkv7GXH4T4ZFTHPQy16BYX
         Cxkw==
X-Gm-Message-State: AOJu0YyYbSYs7vP8M6Rd9GqhI9J+Lv/vVqPw56UIT9LbAuaV6mAi1qA/
	R7G+i4xOQ+A7uQj0hHMC1B948HmnwDNZiVZ+vgxxcUSZIQorgF3bdEabtnC28HDhwGcWQb27swF
	nv31PUebORwlzOw0KPttd5y45XOXUXD8U
X-Google-Smtp-Source: AGHT+IG13xHQ8kqedwCWNwc/qwyWt1WGpgo6+wuuRZvSVxqlnEmZfCjVMI7BucUhbClqS8tlT9jncicgJGayDNswwjI=
X-Received: by 2002:a4a:850f:0:b0:59a:38b4:1038 with SMTP id
 k15-20020a4a850f000000b0059a38b41038mr2105048ooh.1.1707394930791; Thu, 08 Feb
 2024 04:22:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208120959.2513-1-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20240208120959.2513-1-ilpo.jarvinen@linux.intel.com>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Thu, 8 Feb 2024 13:21:59 +0100
Message-ID: <CAMhs-H98us8rNOyQYfYsyU+Gu7pCgwOC15LaM8zfoDA2nCxOEQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] MIPS: Cleanups to PCI related code
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 1:10=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> Cleans up PCI related code.
>
> v2:
> - Convert also return 0 -> return PCIBIOS_SUCCESSFUL
>
> Ilpo J=C3=A4rvinen (4):
>   MIPS: lantiq: Remove unused function pointer variables
>   MIPS: ath79: Don't return PCIBIOS_* code from pcibios_enable_device()
>   MIPS: PCI: Return PCIBIOS_* from tx4927_pci_config_read/write()
>   MIPS: TXx9: Use PCI_SET_ERROR_RESPONSE()
>
>  arch/mips/pci/fixup-ath79.c  |  2 +-
>  arch/mips/pci/fixup-lantiq.c |  9 ---------
>  arch/mips/pci/ops-tx4927.c   | 18 +++++++++++-------
>  3 files changed, 12 insertions(+), 17 deletions(-)

For the whole series:
Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmal.com>

Thanks,
     Sergio Paracuellos

