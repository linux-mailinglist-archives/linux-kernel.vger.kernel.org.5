Return-Path: <linux-kernel+bounces-124386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FFE8916C0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C28291F22C99
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBA253E38;
	Fri, 29 Mar 2024 10:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+EStlJx"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4644AEDF;
	Fri, 29 Mar 2024 10:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711708031; cv=none; b=ftEXkea3+kHH01FatktHUE5Ieve1DIpB338E/av//MAx41lywwEJxO1S7Qhact5dQYaJG2cItMKMyH0NOnTdxeVY5DSTlctxAT/DxhQQNmMzS72+Miismyee5CW1d2ciGT5e1P1lCXgOITCN/kSxV0eZJhWu3W6AvynosOtGes8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711708031; c=relaxed/simple;
	bh=9LuXtRdpTRMxadJHryFC6X2b+VM8qPOM/I4Lm6J3rFE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UaGpdX1ly/fSq9bk79pqI+fSAAhTiDjmN7Sopf4MJ0upfYmC2AC8SJEw/Mk242CCbSxl9sk+uVmXoV6hiMLs6YvpsR/AMSACciJ+GGsDwQDukiw6LyFQhrEyWXbjSWG+2I4fQlrdOheHlxTBfr8aAmCMAB6lGm/yZMC+6UJZyzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+EStlJx; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a46ba938de0so250986666b.3;
        Fri, 29 Mar 2024 03:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711708028; x=1712312828; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8LLwF7Wf3KpK5d9C0oJzew2cz/6pNOfGmInaZ55x8RE=;
        b=b+EStlJxyR51gVpEee1r67oZmBDE5+XCgDE0lhu5xOwsIdTdDJpQLYOclI3eYaHpDS
         VGVoyLQk4M63ZJxaCsfVvVI6CVhempNaE8SBwQuS0/oHirCi51MzTSeG/5T6B6x2PMxA
         ZaiMGb112pUWL+3Ded1t444iWNljchRmYFkPZvel5VFewH+1MNBpkkuj4qYybg1rw+Mo
         x7nOOk53TS5g0DPeRNqZ4eA2htfCS76lJpQN4XhZYUHlnvJdWH+N455lKnUtmGTiFAz6
         YaCecTkBZDWxPEqjlUEWpM/XfR8w/4rwa8M5jI9EmARyyeRr0BMEx6MtEN3M7JLipiTN
         oP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711708028; x=1712312828;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8LLwF7Wf3KpK5d9C0oJzew2cz/6pNOfGmInaZ55x8RE=;
        b=h8ExwbtDml5eLPSpHsDgirh4KUTGOFGXYbyS7tShyu6yxu9UXsArE+2DPyQH2+aTMv
         iHk8IIKpr+Ji+XpYmhEoBSEDdZK/PdZRmDo865j1putzJd+zpIofUptRccnRHZO2DsLJ
         ARN0ZAxKHlwAYu9ZCuYV8xuohWXMVzxZ7lqaMlzcDWdtktZJ21uMpuwAsHNh/qtCJp5A
         tA5mS3z+GNKKfrhdy+ZmYOoEVtTdIDVetBsz9xOUMI2b4QtGruKmJAqQVtPh4tOg9auT
         Sl0OtOdIVNZFfAblf+bNskmNsz6fFWyX9p8xbRKan/1QKCOYt7aQZ4x+QacwmlD0A+2a
         hhpw==
X-Forwarded-Encrypted: i=1; AJvYcCVDaXTwALL28yqLGH3NgFJeb1qcuts0tltOgfll1meFDYg/xOCt2m80JF08hE6GzSvSsSzvHbWYvdP3kSSdaXTX7FGegz/SvDmKPxXqFUJwYQO6+QmVJ+QNLTLiU2UkiHjc
X-Gm-Message-State: AOJu0Yx2AjH6Y+th52TZ7xzcH/AM62bzdXVa42uHoj74/KcfRFzcB6oq
	8T9aGsCeIfwObOw0JpfeErhaFE+aNkWy5A9KPOLXji6E3aOIVXkA
X-Google-Smtp-Source: AGHT+IFUPCtD7nmfYo8qe80rPy7NwE0owawjTNXg3BZNB/86Wv3p2VluGpqpdiH9Q+wmKBJi7PoiZw==
X-Received: by 2002:a17:906:1b09:b0:a47:4234:eaf5 with SMTP id o9-20020a1709061b0900b00a474234eaf5mr1303313ejg.69.1711708027787;
        Fri, 29 Mar 2024 03:27:07 -0700 (PDT)
Received: from ?IPv6:2a00:1858:1027:8084:dcff:fef3:4040:e18d? ([2a00:1858:1027:8084:dcff:fef3:4040:e18d])
        by smtp.gmail.com with ESMTPSA id qf31-20020a1709077f1f00b00a4df4243473sm1757419ejc.4.2024.03.29.03.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 03:27:07 -0700 (PDT)
Message-ID: <f2e1c5dc6f6ea2c7f046e8673dd364dd14056781.camel@gmail.com>
Subject: Re: [PATCH bpf-next] Fix latent unsoundness in and/or/xor value
 tracking
From: Eduard Zingerman <eddyz87@gmail.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, 
	ast@kernel.org
Cc: harishankar.vishwanathan@rutgers.edu, sn624@cs.rutgers.edu, 
 sn349@cs.rutgers.edu, m.shachnai@rutgers.edu, paul@isovalent.com, Srinivas
 Narayana <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte
 <santosh.nagarakatte@rutgers.edu>,  Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Fri, 29 Mar 2024 12:26:50 +0200
In-Reply-To: <20240329030119.29995-1-harishankar.vishwanathan@gmail.com>
References: <20240329030119.29995-1-harishankar.vishwanathan@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-03-28 at 23:01 -0400, Harishankar Vishwanathan wrote:

[...]

> @@ -13387,18 +13389,19 @@ static void scalar32_min_max_or(struct bpf_reg_=
state *dst_reg,
>  	 */
>  	dst_reg->u32_min_value =3D max(dst_reg->u32_min_value, umin_val);
>  	dst_reg->u32_max_value =3D var32_off.value | var32_off.mask;
> -	if (dst_reg->s32_min_value < 0 || smin_val < 0) {
> +	if (dst_reg->s32_min_value > 0 && smin_val > 0 &&

Hello,

Could you please elaborate a bit, why do you use "> 0" not ">=3D 0" here?
It seems that having one of the min values as 0 shouldn't be an issue,
but maybe I miss something.

> +		(s32)dst_reg->u32_min_value <=3D (s32)dst_reg->u32_max_value) {
> +		/* ORing two positives gives a positive, so safe to cast
> +		 * u32 result into s32 when u32 doesn't cross sign boundary.
> +		 */
> +		dst_reg->s32_min_value =3D dst_reg->u32_min_value;
> +		dst_reg->s32_max_value =3D dst_reg->u32_max_value;
> +	} else {
>  		/* Lose signed bounds when ORing negative numbers,
>  		 * ain't nobody got time for that.
>  		 */
>  		dst_reg->s32_min_value =3D S32_MIN;
>  		dst_reg->s32_max_value =3D S32_MAX;
> -	} else {
> -		/* ORing two positives gives a positive, so safe to
> -		 * cast result into s64.
> -		 */
> -		dst_reg->s32_min_value =3D dst_reg->u32_min_value;
> -		dst_reg->s32_max_value =3D dst_reg->u32_max_value;
>  	}
>  }

[...]

> @@ -13453,10 +13457,10 @@ static void scalar32_min_max_xor(struct bpf_reg=
_state *dst_reg,
>  	/* We get both minimum and maximum from the var32_off. */
>  	dst_reg->u32_min_value =3D var32_off.value;
>  	dst_reg->u32_max_value =3D var32_off.value | var32_off.mask;
> -
> -	if (dst_reg->s32_min_value >=3D 0 && smin_val >=3D 0) {
> -		/* XORing two positive sign numbers gives a positive,
> -		 * so safe to cast u32 result into s32.
> +	if (dst_reg->s32_min_value > 0 && smin_val > 0 &&

Same question here.

> +		(s32)dst_reg->u32_min_value <=3D (s32)dst_reg->u32_max_value) {
> +		/* XORing two positives gives a positive, so safe to cast
> +		 * u32 result into s32 when u32 doesn't cross sign boundary.
>  		 */
>  		dst_reg->s32_min_value =3D dst_reg->u32_min_value;
>  		dst_reg->s32_max_value =3D dst_reg->u32_max_value;

[...]

