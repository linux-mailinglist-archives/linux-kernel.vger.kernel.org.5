Return-Path: <linux-kernel+bounces-102722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E0C87B67F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7D31C212EF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 02:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9E44C9F;
	Thu, 14 Mar 2024 02:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6GmGRTb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DB44A15;
	Thu, 14 Mar 2024 02:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710384298; cv=none; b=Dx/5Is+NK5chHimMvVv1mW2AgdvoabLkcLaAIPde61nrrg4TNOrrwiG/xu3bZdhTe7pk//vROSc9kgxmkCg08CTNHCxvSeE2ur1b3UsVjdh2i4bySiLvCZO7DwFwjQSSxQmgxbrxPDXieBfJFDPlUEc2RRv0GWXhFJl/HQlLbZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710384298; c=relaxed/simple;
	bh=zpXun0U0mFZ/WUOEpPGTdJhPFwQ4U8x7VrbLbI/AWA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJ6QBl9kM7oXDuA/flNJWy4TxynLqDGg7sNniAN5Ujsmn6qn9dWZp4FhoJEtwDuR+df1De08/SnPs13kaHbhj5IJvG04PMWqhBBmV8idA2SEPgW5Fyx/EHPjhoBRuHrMLHl+q+JmOK9f1nLSS0sGkkorq95X7Zj5Z8/sQG1mEy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6GmGRTb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5138C43390;
	Thu, 14 Mar 2024 02:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710384297;
	bh=zpXun0U0mFZ/WUOEpPGTdJhPFwQ4U8x7VrbLbI/AWA4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l6GmGRTbyXJJdKtz1LyMU27xPf3a/z6aD1uQr1wC1aF+JjxwBAJdbDKYgB5uF4uVu
	 3cdOaujqXl/gECX9xruKvfOizQQdtWYyUdFXUnwC74hZON404bQ2bD51p+b4g41CIT
	 TL2p3isPzv0CWifUSmfa+Ybre37gH7H/+epVxbmicbG0kCuu8Xqpl3qXmQGi9xeuCh
	 FOlBb+PHsl/LDk4+1QCLGT+aEi9iAC2d449QHbEkzWzH44iSaDbbndIKQI06tM/zV1
	 509VTTBFpJlh/RXCAkxFDsUwuNjCqFyu+/LIGqc/8giL4hwsCG7EqrZuyqIMLU2oYi
	 kjwbNi+f6WXhA==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-221a4f9557dso309888fac.2;
        Wed, 13 Mar 2024 19:44:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWb+9YBGhMAVUgy1oRFFJcbC0a57tNDQ8MhwSy2wp5YGHC3fY+K5Thalyer0kjw0D91CyTIj5qTiuN8JCYdD4YBceUVqsxTzBendtljMP2XEqcwBqq8S6e2YNKq5EWYadqPAtTJSMdIFgfSEPkbHAp42CJRdxkH7/ZKDNrVoqiQ8obOdmIRZJhgbQ==
X-Gm-Message-State: AOJu0YypCnF2aAqVeBXMy4AldPIQDa0RV09velkbjsn6NGyXhh07u7ZW
	ugzX7ZZALZq+wyIjrKZ66N1oTGF//Z0wlArhY0Y32tp4F26TL2EhlqUL/zrs428HPpd4ZQD1jnx
	SFdfx37+3yG23Ie+oA/rWY/LvR5o=
X-Google-Smtp-Source: AGHT+IHRMvUyXhaS/qB0en9fxIF3carecNgLcCingHznCZFEMFXIA3UgYdz7cmgz22K/LmOnmhqFQO0zQd8nsmdrUBI=
X-Received: by 2002:a05:6870:910b:b0:221:bcde:29cc with SMTP id
 o11-20020a056870910b00b00221bcde29ccmr680399oae.21.1710384296981; Wed, 13 Mar
 2024 19:44:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313091616.2266107-1-colin.i.king@gmail.com>
In-Reply-To: <20240313091616.2266107-1-colin.i.king@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 14 Mar 2024 11:44:45 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-wa_K4APq3QCdf8Fp1Qx8-j9=3ub9e=kZrN2TS4U06GQ@mail.gmail.com>
Message-ID: <CAKYAXd-wa_K4APq3QCdf8Fp1Qx8-j9=3ub9e=kZrN2TS4U06GQ@mail.gmail.com>
Subject: Re: [PATCH][next] ksmbd: Fix spelling mistake "connction" -> "connection"
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=EB=85=84 3=EC=9B=94 13=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 6:16, C=
olin Ian King <colin.i.king@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
>
> There is a spelling mistake in a ksmbd_debug debug message. Fix it.
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Applied it to #ksmbd-for-next-next.
Thanks for your patch!

