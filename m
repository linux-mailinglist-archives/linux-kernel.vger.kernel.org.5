Return-Path: <linux-kernel+bounces-48654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 967DC845F5D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA4461C21E20
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5AD8564F;
	Thu,  1 Feb 2024 18:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNiOOtZ7"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F74963064;
	Thu,  1 Feb 2024 18:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810638; cv=none; b=e1RygEiqbxGxwmSoAy7T2SG5TLvCDMIOmWKPpEtJIVn1y7V/gg2WI471iVbfT+Pa5+53rIvcLwd0Uwhxwg7C4Kn++UnfOcy8wW/Bl4Ig97MqZu/fToo4yz7FpWzQOwAWVao/YT5CoCnYtmbdPeRPqnP2OeU1t7LgjfSV6Lmu0cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810638; c=relaxed/simple;
	bh=ei3GU93TpcAtuwfzbvmohYvxmckdj+VwphSS7eolsSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJthlddWggC1yVFCf6WOe2ezskBzPklWYLQkhWu5f4kfyVIa+4PnmpIwpvMLEXheOWeRvL2aLKDfuhtVxNzlclMiJu60wFm8/8R17yyvvSQo/HBcuvEQKCaGwd80lKEvw1vX1lHWBPRer1MHaoYbOv230rhzb0ER6dDemiHUSOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNiOOtZ7; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d04fb2f36bso13628291fa.2;
        Thu, 01 Feb 2024 10:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706810634; x=1707415434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTAoHYeKQLtPBdjixfUnNuljkxxPtCdOxpFFRhJl/2Q=;
        b=KNiOOtZ7Mz9h6rE+y5/ee9DcHRRNnvUVf6UdWpFykYHlug0zyu9JVub06MzMTXdC6z
         cytZWE5HXpLaJfUc9gHfWihAYeUjSR7XJCYA+WOm9hydTKfiU+NS4qrZzFdQXFgfIb0B
         Ts6qtfCFKCeQy0gbTRAnpmj1nxNsbqWLMxbiiJU3pRCoP/pTChU5phJRYuNFA1addXbC
         yqnH8t3YoI6ok54CY4uY97z1ZjWH7wxAt0M4beDTNaU5Qzaqt5hTvFc2EhszzNFoNggi
         RIJ9f1e0rQbR62nDLaupURSS3PTHZaE+2bR2K4F5nQ5YbM9hA7/SgWbiD7Abzr0P70pz
         2xhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706810634; x=1707415434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTAoHYeKQLtPBdjixfUnNuljkxxPtCdOxpFFRhJl/2Q=;
        b=SjkOh46HrT+Hp7PaP59trGDmq1sSY2Gpv2h+1K8zWnVAKlz8ot2q7udLVURRoxHwG+
         bPP0drbLcUrAvbajYWEto1iTeAy49I4is8NsHLaYx0xSUIFTw2PdIpCm5+xtPfMcAIyN
         DGIIQd17vRb3toEEcnT/qaNjdf29TzQGrt42zhcW+jq0yY+m7F26mnQyVKZ+33KCpPiA
         Um8blJpBwbLRa7ZQHnIDbrCz5vi6MYYVSJW8ngHN/yOGoMFKWwLCxOH1AOlE14xHtpys
         vKiM+lcL3BlH2LQdjPxiTXboU09ie44g6fFDFbdQrOkNlBpRnIZJCChAE8BLJHlR3XQo
         NXjA==
X-Gm-Message-State: AOJu0Yw6hAlh0TvANysBA1dE8VeC8orcU8GQUSsZM7mtL5MTBVVDFIwA
	YtExibKYviojg8itBcharURVsKzgitsEqsSuJddmQSKJvaC62j9z9oGSvFv3b/kGZZu1mk7v0x0
	BY+6i57zvhhpEKdfp/VXUit1/uh4=
X-Google-Smtp-Source: AGHT+IG6aFTsoUrEMDYFANpK5HAl7Gn8TU4aWP4RDoIE0rQHqlzep51EeKVr0UR3GkDC6FxhKRvQUk8SgxCd4RvOjO8=
X-Received: by 2002:a2e:b254:0:b0:2d0:506f:5c0a with SMTP id
 n20-20020a2eb254000000b002d0506f5c0amr4357647ljm.9.1706810634318; Thu, 01 Feb
 2024 10:03:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bf90de00-4d6a-4440-b6a1-42ac9e358158@moroto.mountain>
In-Reply-To: <bf90de00-4d6a-4440-b6a1-42ac9e358158@moroto.mountain>
From: Steve French <smfrench@gmail.com>
Date: Thu, 1 Feb 2024 12:03:43 -0600
Message-ID: <CAH2r5mv-HdiM2zasyq1F-LN=kqD93EfKf+UMcnR+0_GNv3xB2Q@mail.gmail.com>
Subject: Re: [PATCH] smb: client: Fix a double lock bug in smb2_reconnect()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Shyam Prasad N <sprasad@microsoft.com>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Tom Talpey <tom@talpey.com>, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This (and a loosely related problem   were already fixed in an updated
version of that patch (updated in cifs-2.6.git for-next yesterday);
https://git.samba.org/?p=3Dsfrench/cifs-2.6.git;a=3Dcommit;h=3Dee36a3b345c4=
33a846effcdcfba437c2298eeda5


On Thu, Feb 1, 2024 at 6:19=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> This goto will try to lock spin_lock(&ses->ses_lock) twice which will
> lead to a deadlock.
>
> Fixes: 17525952fa83 ("cifs: make sure that channel scaling is done only o=
nce")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  fs/smb/client/smb2pdu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
> index 2837fc4465a7..dcd3f6f08c7f 100644
> --- a/fs/smb/client/smb2pdu.c
> +++ b/fs/smb/client/smb2pdu.c
> @@ -401,7 +401,7 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon =
*tcon,
>
>         spin_lock(&ses->ses_lock);
>         if (ses->flags & CIFS_SES_FLAG_SCALE_CHANNELS)
> -               goto skip_add_channels;
> +               goto skip_add_channels_locked;
>         ses->flags |=3D CIFS_SES_FLAG_SCALE_CHANNELS;
>         spin_unlock(&ses->ses_lock);
>
> @@ -448,6 +448,7 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon =
*tcon,
>
>  skip_add_channels:
>         spin_lock(&ses->ses_lock);
> +skip_add_channels_locked:
>         ses->flags &=3D ~CIFS_SES_FLAG_SCALE_CHANNELS;
>         spin_unlock(&ses->ses_lock);
>
> --
> 2.43.0
>
>


--=20
Thanks,

Steve

