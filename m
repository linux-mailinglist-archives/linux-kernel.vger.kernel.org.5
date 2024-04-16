Return-Path: <linux-kernel+bounces-146929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B98878A6D20
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF401B22EAE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C4112DD9B;
	Tue, 16 Apr 2024 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9Eo1z78"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752FD12C7F8;
	Tue, 16 Apr 2024 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713275855; cv=none; b=XpeYtENb47EI61mraym5HEeAUn6pk/BVmF6qLoE0HiSLt20tc1HkeEf6lSFzzXuKeZu17t+C78ABlki3iw+rh1qDqya3drrllXolVdFgfixLUk8Qp8iw2tRD30YhwQHEHfP/5efJlPHqyZDi62Oj2kAQfh9sdewTkeR1BFG5hx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713275855; c=relaxed/simple;
	bh=XIW4cnpJhG3AOb3n0mnc7xu18Bd4Jf9pnUIE7j52tDo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rwE84lPm7B1I8yL2KOInKc3TmG1Idy7mQ9u2DPQRk2m3kKh6iNkiQcqt12v757I3lY7T0M+Hk7DJfrikxmkpjpjdgf8q3rPOs+FWhYCClFdUDVBcWL8xCLmNae4M9Y6DqH86hcACA15g2kn02Fl7Y7U6rgp7Bv7RsNcoSOWgcIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9Eo1z78; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d6ff0422a2so55021121fa.2;
        Tue, 16 Apr 2024 06:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713275851; x=1713880651; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GM/ZPv+V4DboncDOmOt7I89cvjgBB42SqfpjqZrobso=;
        b=L9Eo1z78KBZYiPPsap4fmtjpgTAuWur/TE26Dvsywa625RdAbz0WAeZdV0U7/Ie98v
         D4pVEXYRA1M5AmK1hWgnSuXd1wTswIBd0yuHcTWHqJFruQDF3PriJJl4gEjE4kipXV1W
         OZ5OBajzv03UUYqXioiIJmFjHV6BrfVWoANLE40TkleahSPnz1dzrKddUX+aKkOJSqur
         ir2eubDZIm/c+ErKrNff7OI0nh1RovVpLQYZKYTmca0uhDgcmJl0WGkGWhgyvFX24DSn
         O2jq8Z0vOU+TmELUH8XEpfQ72mw+4P/pCZNknY2oJnhYI42ZLOk580xlr3ndsfez+HTq
         CJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713275851; x=1713880651;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GM/ZPv+V4DboncDOmOt7I89cvjgBB42SqfpjqZrobso=;
        b=PbtNo2S4lm/koqiMun1njQpnetU4FfF+du+4E1OvaRIfkSUwK9h/U7Yr3payEdFX5V
         wEFU6EmNQlE1OcmrmN5V8mwMPYnZ2qvP/fTcQkQ3vK8+qc8Lrl5Bap/yQ9I2wWcG8K65
         2als0UdEKsN0c6EK5e0Qd20+m9KoIOpmjqfUCu9ETkZkPeUV/LfLdAQyJS4dlyC5zve4
         2x1ivJqZO9/L49pe8S3Gf7hst7B8Y/YNzp8xK47I88o89JEAsd0aYsi4r+3Ln0HvzZhV
         6srZKWOcU1VmnIpce4aIc26/hFeps5ogFqEpiy+llEHde6N9kk8VY8/P5cBPnyM5Aqwj
         zzTw==
X-Forwarded-Encrypted: i=1; AJvYcCWv4fjRtHgNloVFzf6DFctTAKbvgppWGGthrDeH7fDxjTmsoGYMd8n9d/XHWDzorleqIDxX290glT/mpAw+yjJedpYX+Xo/
X-Gm-Message-State: AOJu0YxLiG5GpWJcxhNvBnamG+f851k8vqMp4NtxQpIe1r1yyfJDBAey
	5n/mFFodi1FxbVsf9o/1vASN3nn3W1fbqdUiMBi+hirYm5x9Q2xk
X-Google-Smtp-Source: AGHT+IHkAJ5vcr5U+nmNThgYGL4nmSjAZHJfhmArM42d0zEyrM5TlmrJFdY+QJqpgZMwNKOGJ1+bOw==
X-Received: by 2002:a05:651c:b0b:b0:2d8:2799:fbcf with SMTP id b11-20020a05651c0b0b00b002d82799fbcfmr10286762ljr.34.1713275851408;
        Tue, 16 Apr 2024 06:57:31 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600c4e0d00b0041898fc168bsm2111798wmq.36.2024.04.16.06.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 06:57:30 -0700 (PDT)
Subject: Re: [PATCH net-next] sfc: use flow_rule_no_unsupp_control_flags()
To: =?UTF-8?Q?Asbj=c3=b8rn_Sloth_T=c3=b8nnesen?= <ast@fiberby.net>,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Martin Habets <habetsm.xilinx@gmail.com>,
 linux-net-drivers@amd.com
References: <20240416134432.9527-1-ast@fiberby.net>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <496dba36-1d40-e7d1-1250-a350bc590902@gmail.com>
Date: Tue, 16 Apr 2024 14:57:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240416134432.9527-1-ast@fiberby.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

On 16/04/2024 14:44, Asbjørn Sloth Tønnesen wrote:
> Adopt nfp-style *_FLOWER_SUPPORTED_CTLFLAGS define.
> 
> Change the check for unsupported control flags, to use the new helper
> flow_rule_is_supp_control_flags().
> 
> Since the helper was based on sfc, then nothing really changes.
> 
> Compile-tested, and compiled objects are identical.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Subject line doesn't match the patch (I guess because the helper
 got renamed).

> ---
>  drivers/net/ethernet/sfc/tc.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
> index 82e8891a619a..5f73f1dea524 100644
> --- a/drivers/net/ethernet/sfc/tc.c
> +++ b/drivers/net/ethernet/sfc/tc.c
> @@ -21,6 +21,10 @@
>  #include "ef100_rep.h"
>  #include "efx.h"
>  
> +#define SFC_FLOWER_SUPPORTED_CTLFLAGS \
> +	(FLOW_DIS_IS_FRAGMENT | \
> +	 FLOW_DIS_FIRST_FRAG)

I'd rather keep the flags in-line, next to where they're actually
 used.  I.e. we have
    if (flags & FRAGMENT)
        blah;
    if (flags & FIRST_FRAG)
        foo;
    if (!blah_supported(FRAGMENT | FIRST_FRAG))
        return -EEK;
 and it's very clear that anyone changing one of those parts also
 needs to change the other.  Whereas with your #define it's not
 immediately obvious to someone reading the code where that set
 of supported flags comes from conceptually.

-ed

