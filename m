Return-Path: <linux-kernel+bounces-60255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A620A85024A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 04:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF3228CA2C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 03:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C488C523D;
	Sat, 10 Feb 2024 03:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vq75Suos"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F538149E12;
	Sat, 10 Feb 2024 03:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707534057; cv=none; b=MYI/YtlY8iQit8SnmUjyRqcZdlMCH41b8m81KC++wX0gpExgJqo3+mItwwyTIKn6HwpFu61DIWMFd5QdAbUKKIzE40X34P7fyNkvUg+yitauZVhWgDmA9bCAPuv5J3IhE4WBrXbTZOWfdpLy6ud0LtmlaNjtp+fgkpE5M5rijKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707534057; c=relaxed/simple;
	bh=s+6djX/WTXkTUm/OOJnyCT2c88+8AQe3/IE6cDatMww=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=JfkdFkxXpiNVLVjRUEhrjhHnCtnl+6z2czb1h0IVOa/ZkZa+0WmBXwGEndWC6Xf5cmlUZnSzdtZBLm6WhNdxLRAmAjlYUDgkRHtAZHPTFjSPSMnSDvZaHcomn/HRymmEMhGtfT47qiuxmm/t0vXanob9GCkl2GnkYG/hSq5j5l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vq75Suos; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d934c8f8f7so13912765ad.2;
        Fri, 09 Feb 2024 19:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707534054; x=1708138854; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R3IJGWTJWIPw+M65843DklH9eyEFW7vwcdstM0zz4C4=;
        b=Vq75Suosfs/NrgPk5JainipgJkiZwF9l9FL4LSzXz7jzZ+Pov7rWib8DreKFk4QQnF
         7G5R+qh5NCoPKEwWEXN/d+fX8KOluV7BSmdJ8FcD0NMDu/AwgoZs4LT+ZPIcQwhh/gJV
         tH+OLNsrHdAJDXUCB5hz3ipM7SDc8m+yJ5sf8LLclgN0GM7fQQ11BJSVyFHkJ6GqbrrX
         ZwFqH0uTz1mZ6EC2RzLVtoTNUsHWV7QhuLs+AewZ20uenWaOwKmiIe52uTm8D61UBGEz
         g0/KSZvQg5zp65TEzagIYBvuHs7Ka+hidh2pAK0Eo9FGbsOiwT/SJku9DfkL/kVyOuRe
         GgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707534054; x=1708138854;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R3IJGWTJWIPw+M65843DklH9eyEFW7vwcdstM0zz4C4=;
        b=eX0nV4ZGhybU544rl9Mq0nwO4PYfy0o9x0rN1zqiamphiGzP8s9Yy7JwZuh/W4bfP7
         Pz7rURB5HgZAutjVAXPcybbPQurRljumS3DegxyjaqwstrhqGs1GCogSL/pQrWZohUyC
         kdVcm/5/EAM3KawTR9kABbjsBwWFVFWL9mfEhqmTEpFA+KS5iztd/GmtUJuVuG2xeH1p
         r4KV/1/puhQUg3+on37f2i3rN1VR0UqQWHHv94JTA06BpVa80OMXxqsGde+K7KDyY6PR
         ze3sOunf0o6aJzSHyBNvg6ntNpI3lkObBhSO/lqMWzseODrP8qJnwQMd2Z+NQw/Jz5V9
         IPnw==
X-Forwarded-Encrypted: i=1; AJvYcCXlGDH6HQAvgXoymRXefbhrsm8hpIIMFirI1xFjfcmEcVJF5NEtZ11UfK0blIIa1K8eS/sj3mJt8tkjmIoTKuR+wESosK7PhtkgtgxAM+hmDEqXJkjzbNlSIvsJXjqgz6SypLucxRmbsGMytA==
X-Gm-Message-State: AOJu0YzhZ4yHhrujOsZqKU48GUiDwU1mjgBfOGoPj7T4vupsQCcInHIS
	dNIZGv+xRHFztSnV00c/jX5NxItJn03v/ca28fAHO8da2a+otfzp
X-Google-Smtp-Source: AGHT+IHUNt3lZOFNPsZ7DhYo9HuUfhWqlZhn6AHJ+/w7nIfoM+7ydXiUbGUVtQF9GQ2R73aeCQyPCQ==
X-Received: by 2002:a17:902:b688:b0:1d9:c86c:39c2 with SMTP id c8-20020a170902b68800b001d9c86c39c2mr1115476pls.14.1707534054302;
        Fri, 09 Feb 2024 19:00:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXtoL/jA1UuRhntMmsM4MTDQXi+O2ERiHQ92g3p5uymlaKsD5mJEmRvgXy9G6DDqfRkMytcfx9ZfgIudCR86GW2x/2gTg201T5LFcJxjXwecaP55iW9/WUJ/PKYrBYavGij35dSTDBg/BerrQa7UPU8YKLr6VVX6lEKwMW1wpZWNg18LS5su/7+0gRL6VkaOnSSayiazSpLnf6ARR8k1McJ+LGZ5+oVMr2J7qR4eQyjfoZ3ZZi6dC6H7+U=
Received: from dw-tp ([171.76.84.200])
        by smtp.gmail.com with ESMTPSA id q2-20020a170902edc200b001d91b617718sm2193534plk.98.2024.02.09.19.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 19:00:53 -0800 (PST)
Date: Sat, 10 Feb 2024 08:30:27 +0530
Message-Id: <874jehc9bo.fsf@doe.com>
From: Ritesh Harjani <ritesh.list@gmail.com>
To: Jeffrey Hugo <quic_jhugo@quicinc.com>, adrian.hunter@intel.com, quic_asutoshd@quicinc.com, quic_bjorande@quicinc.com
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: Re: [PATCH v2] MAINTAINERS: Update bouncing @codeaurora addresses
In-Reply-To: <20240209160934.3866475-1-quic_jhugo@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Jeffrey Hugo <quic_jhugo@quicinc.com> writes:

> The @codeaurora email domain's servers have been decommissioned for a
> long while now, and any emails addressed there will bounce.
>
> Asutosh has an entry in .mailmap pointing to a new address, but
> MAINTAINERS still lists an old @codeaurora address.  Update MAINTAINERS
> to match .mailmap for anyone reading the file directly.
>
> Ritesh appears to have changed jobs, but looks to be still active in the
> community.  Update Ritesh's address to the one used in recient community
> postings.  Also Ritesh has indicated their entry should be changed from
> Maintainer (M:) to Reviewer (R:) so make that update while we are making
> changes to the entry.

Thank Jeffrey.

Acked-by: Ritesh Harjani <ritesh.list@gmail.com>

>
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> ---
>
> v2: Change Ritesh to R: per Ritesh's suggestion
>
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4be2fd097f26..56b3311e51de 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7832,8 +7832,8 @@ F:	drivers/media/usb/em28xx/
>  
>  EMMC CMDQ HOST CONTROLLER INTERFACE (CQHCI) DRIVER
>  M:	Adrian Hunter <adrian.hunter@intel.com>
> -M:	Ritesh Harjani <riteshh@codeaurora.org>
> -M:	Asutosh Das <asutoshd@codeaurora.org>
> +M:	Asutosh Das <quic_asutoshd@quicinc.com>
> +R:	Ritesh Harjani <ritesh.list@gmail.com>
>  L:	linux-mmc@vger.kernel.org
>  S:	Supported
>  F:	drivers/mmc/host/cqhci*
> -- 
> 2.34.1

