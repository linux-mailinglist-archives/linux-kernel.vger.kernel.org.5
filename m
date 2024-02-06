Return-Path: <linux-kernel+bounces-54386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 244FF84AEA0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D7F1F246C1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6730E128804;
	Tue,  6 Feb 2024 07:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4Var3sV"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4981A3D54A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 07:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707203252; cv=none; b=o/3FosngHlU/fxHk12uI9G3RITDXgz7PfUB/eq9Nt5zFsU+ldBdlDgP89nlmDvHMIdOZmxixtJFMqrBHqWgaSx6VM0UtVr4+6Zz7LJrvJQr2YvuufJNg5poV1rnS2kHfvYCjuKj9yRjb3LKZBjpmd0yJ14uJYEXRDaiS8GvfcqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707203252; c=relaxed/simple;
	bh=wS6zlNuXwAPfuedZAvA3ZrUiC/nMjWU0rCS5L6PsMgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOYQDrizLT/E9nHOBkYxNyYZDCJfsbYdaNWsO23TGMO6lb81HOo2iCAag5f4KBQSLsXF73iuccd73SDHKY+9UIRCWLEGbk3pUEUsuRQEAgcRVRIWmPo/IwYXvgm5U4zeB6riEUs+MpOHoCnrt/Hb39BG3jxH/jEK7ykm86gdufQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4Var3sV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d9bd8fa49eso12318985ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 23:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707203250; x=1707808050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1nVgxtxxB24ooM015/bjH1PamdQQY17NCPa4n0g2/8c=;
        b=S4Var3sVfbMiuVftzK0izarCSDbhqj/Ihv0Z78mo9OzWKyMoSWvkuy6yvvY6A9IEug
         +QEMb3jfdBWN/DDDJNyXCrpgWDfwQALNasNJR2VZo+3GYxgJrJZNTtMr0UNf70M9joP/
         HVVoTe5zS4w4DQ3+70FkgETeCwxWSm+/3vROGojrSdWUDa3U6lvu0Zm+WsJ1dh95f5zK
         Fv2KQdrIqnt4CcJx7B8ofphbVA9qhxaAxdKOuEDBUGq0FnCvkjV1gALcFrZPO+8HKdIv
         Va4KEOU9xeXvWRez0PzzS3RoECzg7dgqJKr11lnU6Wylm9WFaY7QSWHGcvsH9pM7HsZ6
         La4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707203250; x=1707808050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nVgxtxxB24ooM015/bjH1PamdQQY17NCPa4n0g2/8c=;
        b=obSQFnVP9af4dF8lTmFYKixbAXpn0zkRfH+0WuCpyTcMB5gt97mc0dNW6lazYTon+9
         KSNnkn/seDtuWn8UTTspXorZLPOzsc1TdBDYdK0SEjW2TS7O3p2bNgd6P4aKgy2qYzmY
         4RYtJ39o/tcG6d8of1Jp11rQbW6L+jCrwId9doottnJmL9TyjmYLfRTTzj3xloBDNyMq
         xU/Oe3EAUGB02nPXJjYAjVs8UZIOtErFoZ6UORNsHp4mIkT0Bg+Qfo2r1yg5UwH6Z2NR
         hbpYvTC7mitoaOReoLg22BxkU+pPOCHQhzFbZ3FXa2RnQk2Y3nDdj0dyUjKJ0EbiqzcB
         QI8Q==
X-Gm-Message-State: AOJu0Yz0NBoOprE3pXrAGdklqbkPiG/HYsTdCeqMS5/k93au7VSwn2l3
	57TTro7RaLWNokvR4hvK34TNVBS/+thLqdHBpLzceWY2E18MffvA
X-Google-Smtp-Source: AGHT+IGOc6rrXPB1S9d1QiU78oRJLaHBtNbQ06ZRU0AUlLCWpIimBm/knEqicCOHNU4qjV4EH+7XAg==
X-Received: by 2002:a17:902:d2cc:b0:1d9:bed3:ba0b with SMTP id n12-20020a170902d2cc00b001d9bed3ba0bmr975627plc.9.1707203250524;
        Mon, 05 Feb 2024 23:07:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUCcxcEFPgZFK73jbaI0vIPkcdpUfWSZmClbsGqVh3dIf3HjD3nd6n7lkU1vNa+O+zLZzPBmPtKIiR/dPBY6pJ77ngNf/nPhvRmIFnjEwqrk+NE5OdG/Le/L6CON7GUw4mf+PjNzjnNFbiuVfHyNkf65KkDAKTpFSaZx0U+Eah+b/B4jA==
Received: from dragon (144.34.186.27.16clouds.com. [144.34.186.27])
        by smtp.gmail.com with ESMTPSA id iy15-20020a170903130f00b001d8f3c7fb96sm1079796plb.166.2024.02.05.23.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 23:07:29 -0800 (PST)
Date: Tue, 6 Feb 2024 15:07:21 +0800
From: Shawn Guo <shawn.gsc@gmail.com>
To: Charles Perry <charles.perry@savoirfairelinux.com>
Cc: shawnguo@kernel.org, robh@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: imx-weim: fix imx_weim_gpr_setup()
Message-ID: <ZcHaqasXS60LtbVn@dragon>
References: <20240122205738.2432552-1-charles.perry@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122205738.2432552-1-charles.perry@savoirfairelinux.com>

On Mon, Jan 22, 2024 at 03:57:29PM -0500, Charles Perry wrote:
> Commit 2a88e4792c6d ("bus: imx-weim: Remove open coded "ranges"
> parsing") changes the parsing of the "ranges" field by using
> for_each_of_range instead of of_property_for_each_u32. The number of
> iteration of the loop is now equal to the number of range within
> ranges. It is therefore no longer needed to check that i is divisible
> by 4, otherwise, valid configurations will fail imx_weim_gpr_setup().
> 
> Fixes: 2a88e4792c6d ("bus: imx-weim: Remove open coded "ranges" parsing")
> Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>

Thanks for the patch!  But I have picked up the one [1] from Lucas.

Shawn

[1] https://lore.kernel.org/all/20240119185026.1192333-1-l.stach@pengutronix.de/

> ---
>  drivers/bus/imx-weim.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
> index 6b5da73c85417..837bf9d51c6ec 100644
> --- a/drivers/bus/imx-weim.c
> +++ b/drivers/bus/imx-weim.c
> @@ -120,7 +120,7 @@ static int imx_weim_gpr_setup(struct platform_device *pdev)
>  		i++;
>  	}
>  
> -	if (i == 0 || i % 4)
> +	if (i == 0)
>  		goto err;
>  
>  	for (i = 0; i < ARRAY_SIZE(gprvals); i++) {
> -- 
> 2.43.0
> 

