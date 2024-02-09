Return-Path: <linux-kernel+bounces-58988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B77784EF71
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5CF1F221F3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBF0522A;
	Fri,  9 Feb 2024 03:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2TNklhy"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B504C90;
	Fri,  9 Feb 2024 03:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707449892; cv=none; b=HvHElv1nSrDTn2fvyHi7BDRKWbfpaR8LqgRHKKTHuUzralWwtsEQf5EkDXd09SuBXdWlWJWuQY2Nn40qM5bCU+m/rSKrpyfXdMX2ow2W9+hUc9mhyiZd9kX3M4QQziN6Yri6bajD/diB8vQtCRB0Ecjb6zW833cARHHitd5RFYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707449892; c=relaxed/simple;
	bh=GX/+DS78vZhRrtiYhOHAjyvo8eiqrfMYqj2AlJu7hmo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=piCdPlfFLt/GLy4kIpnRlDaJvwb3ThKWkMzCx6MYCcdznnd5o+U7aUCbPwKhFV4OR3WfAij5UM0kD4RErp4KtczVl9zvQQZ8OE+ctBIzmPdY1flN/qaUTtv71ijmjktohRy7oLregejL3DymUwVTJNBiJ/RtU68aEWoSBAWmoTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2TNklhy; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d8b70b39efso415139a12.0;
        Thu, 08 Feb 2024 19:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707449888; x=1708054688; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+exzC8FxxlmEGoFzeebvnQTCtDzJ36K77Ic0tPa6NG0=;
        b=B2TNklhyy1j2rEuMIviEC32I/UyJ4eCodv4Xw8VROBfhW1zEpv6eRQ3RtiUN08QOw2
         rmcKjDwajwWRPiNpSH7OmrcJctU9vFfQrKkbz2b3QHBcKhPonC9mURgSoQUs90++wDqb
         Il2IIDW5cp4YQayOr+N3LFbj3fiHi5NKUL049wvPbBM8f1CK8FqOIlDIttlLRw3Wavoa
         MlbmphR/LwHVyTxmyCcyBJ+8v7Y4zosa1QOI1VSZ/meLJQBVn1VYB+qhvf+iT9UHZQQV
         k+TbQuBawwzKgjubm5GYsRMNbEZirMlVej5i9tmvt3756U39nu4tjF98e6QAHs3qgCnG
         3thA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707449888; x=1708054688;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+exzC8FxxlmEGoFzeebvnQTCtDzJ36K77Ic0tPa6NG0=;
        b=BwbOoarMleUYj8RjcNryCJGI8yjAnf7GAOOOnMtzauaV8H56DeNIxmQnQ3m40nv4Rj
         mq2vS8hwhUTHdIHwoBAA0AXS63OFlO7BCb2tmL1kQ7U6soN4WoymP3yXuwY/54obbKN9
         irKxf5EwKfk2dmwR9V/W6Q+KH/eFyGYWzay6iqfpZb60erbe8WIF7lCuNqOHR4iK9vct
         KDvCijuvzZQV1DOByNAF1MKRGu+DQDPJj8IBjr8qss+vq+F4PAQo0dWYcU/JMvGoX9bs
         Iy6/KBxgvPh48twY0l/xARL9F2CaTiV81rWTQS9kb8tIMAeJTgB5iGI2uMaHqsAps30E
         MBJw==
X-Gm-Message-State: AOJu0Yxkkr9fm+TkHUtSOFSxya+I4bv/USPAk1qU0ym7y5EGU8zdCGiA
	z5z+qaLu+24TeQnvq6q/t9Q2nah80p9r4+SbJQvDE/DC6eZwT4eS
X-Google-Smtp-Source: AGHT+IFAXbnV5TW0cUkYpJih4U9cPn4/SX1EN+1r22I5ui38caXGIrOO980EM5KCUY0cOnmcHCqIYg==
X-Received: by 2002:a05:6a20:9f47:b0:19e:957c:f7e6 with SMTP id ml7-20020a056a209f4700b0019e957cf7e6mr769555pzb.13.1707449888531;
        Thu, 08 Feb 2024 19:38:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWlQOyVqCqmarM7+4FjzI9xeTntxER/MhKs1jzkz2Roi6HZlVgAnQZCo1A5wff+8lwTuNHkyujvc8AaISsuE9MPD7055vkS6rCsDQ3OaVtbISCNko3BLSi8X1Xd8nRvH4AqITbVhuRzwPFPO4+sG0y3HIBX99cprFvnhPIA8M/Jg00tMN/EL45C/udbxAfm3xDZYtSCzaqR7+fOAX0HZevclJRs9e4SArP5NBxCw70YcLMSLG6d6vC3NYlIQoSoCp5QQrxjh/X3CXFA
Received: from localhost ([1.146.65.44])
        by smtp.gmail.com with ESMTPSA id z8-20020a1709028f8800b001d911dd145esm505119plo.219.2024.02.08.19.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 19:38:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Feb 2024 13:38:01 +1000
Message-Id: <CZ08GUY1Y35T.2U33WWSJN7JVH@wheely>
Subject: Re: [PATCH v2 5/5] sched/vtime: do not include <asm/vtime.h> header
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Frederic Weisbecker"
 <frederic@kernel.org>, "Ingo Molnar" <mingo@kernel.org>, "Michael Ellerman"
 <mpe@ellerman.id.au>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik"
 <gor@linux.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
X-Mailer: aerc 0.15.2
References: <cover.1707422448.git.agordeev@linux.ibm.com>
 <e0827ac2f96d87f623575098f9d55e77351b63c6.1707422448.git.agordeev@linux.ibm.com>
In-Reply-To: <e0827ac2f96d87f623575098f9d55e77351b63c6.1707422448.git.agordeev@linux.ibm.com>

On Fri Feb 9, 2024 at 6:15 AM AEST, Alexander Gordeev wrote:
> There is no architecture-specific code or data left
> that generic <linux/vtime.h> needs to know about.
> Thus, avoid the inclusion of <asm/vtime.h> header.

Nice cleanup!

Acked-by: Nicholas Piggin <npiggin@gmail.com>

>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/Kbuild | 1 -
>  include/asm-generic/vtime.h     | 1 -
>  include/linux/vtime.h           | 4 ----
>  3 files changed, 6 deletions(-)
>  delete mode 100644 include/asm-generic/vtime.h
>
> diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/K=
build
> index 61a8d5555cd7..e5fdc336c9b2 100644
> --- a/arch/powerpc/include/asm/Kbuild
> +++ b/arch/powerpc/include/asm/Kbuild
> @@ -6,5 +6,4 @@ generic-y +=3D agp.h
>  generic-y +=3D kvm_types.h
>  generic-y +=3D mcs_spinlock.h
>  generic-y +=3D qrwlock.h
> -generic-y +=3D vtime.h
>  generic-y +=3D early_ioremap.h
> diff --git a/include/asm-generic/vtime.h b/include/asm-generic/vtime.h
> deleted file mode 100644
> index b1a49677fe25..000000000000
> --- a/include/asm-generic/vtime.h
> +++ /dev/null
> @@ -1 +0,0 @@
> -/* no content, but patch(1) dislikes empty files */
> diff --git a/include/linux/vtime.h b/include/linux/vtime.h
> index 593466ceebed..29dd5b91dd7d 100644
> --- a/include/linux/vtime.h
> +++ b/include/linux/vtime.h
> @@ -5,10 +5,6 @@
>  #include <linux/context_tracking_state.h>
>  #include <linux/sched.h>
> =20
> -#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
> -#include <asm/vtime.h>
> -#endif
> -
>  /*
>   * Common vtime APIs
>   */


