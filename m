Return-Path: <linux-kernel+bounces-3300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF26816A9F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9CB1C22A46
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD09B134C1;
	Mon, 18 Dec 2023 10:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3LKPLYv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034F21401E;
	Mon, 18 Dec 2023 10:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ce4fe4ed18so229386b3a.1;
        Mon, 18 Dec 2023 02:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702894308; x=1703499108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWVfo0YlGfjE9aDQP2Ly3L2JCb3LpM/ev0NxuURn88c=;
        b=F3LKPLYvNsLSAjIf6bFDgT6NL3mkYVdoBJbBT+NiKbKsAsVtYrkOBlV1ILSr1/E7id
         xiof1aVi2r/nLkEzcXNfo7hn10Ila9xFVz0II22HbAtO6JlOfgK97jpoxdrEXnNQe7aS
         wTo0EKxwFuEdW9p/iRz4zXwNUmuLS82R7qFflyoZGAj3ZjIMcnad4VQ0bE9NPMwp4jpl
         nRH9HG/UcspH+K4Jo3J09e2r/H05GjTLnXSTBFIwHg1GaWi1O6PTwFrO1DZAvXeG4n2d
         bukxkON91yf9GzBLhhDiOg1njwJTXWJzsC0z93LkdFgnNJWOii6WtnongFkTxzb6SPX+
         8ToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702894308; x=1703499108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWVfo0YlGfjE9aDQP2Ly3L2JCb3LpM/ev0NxuURn88c=;
        b=Kx1mHtQ2NIolQwwplgHk2PE1k79VESWZKaSY926pIggIB6B0YUQIsSidtOZGYLSIaO
         /ajobdXOPdhdhruB88AtiHZKrkiSm+MBkb2+Mxe+x46gCkw4aNLUDECP82IhQ7V8GIqZ
         xm/M9+qaNyVtAgKnm2IyyuSuK0GqaXyvvbp1qaVq/xDt9UJyNgjGYoaw1XmGTztl5Sr4
         aacVolva/rbtXZYpdXwctmP052N6uq0HLOkGF/7og0TERYC+bVMeSAAKjh6MNN0sFsCR
         F1nmTtQVOHbdt7/zeVg3M+rR6w/JOzC5iR/xo9SQAdx9cTg4m9blULGR9RETb/6sbuOD
         KptA==
X-Gm-Message-State: AOJu0YyeSrTVMwDBO2JYLhUt0fSyK/IKyFFSfj49tWxwNXMFxYNVgYSE
	9fKUun4PX/NlXaV1fXVUs4uQH0Q88VUeZimeqVCkiff+
X-Google-Smtp-Source: AGHT+IFYAnVfFiaPLV3aOQmZxk09vqA3D8C1S99StKDu8dlQoGIILh+9qvsyJUfc1ZciBzGtPeAUAdzf88ItNIDemXY=
X-Received: by 2002:a05:6a00:2288:b0:6cd:e3ef:ce54 with SMTP id
 f8-20020a056a00228800b006cde3efce54mr34661547pfe.0.1702894308316; Mon, 18 Dec
 2023 02:11:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1702891731-3417-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1702891731-3417-1-git-send-email-shengjiu.wang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 18 Dec 2023 07:11:36 -0300
Message-ID: <CAOMZO5CjoXFx4uX7w7My_zSeo_+mhQqhWYH3PNdV6SQOUXTxtg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Fix channel swap issue on i.MX8MP
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, 
	lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 7:10=E2=80=AFAM Shengjiu Wang <shengjiu.wang@nxp.co=
m> wrote:
>
> When flag mclk_with_tere and mclk_direction_output enabled,
> The SAI transmitter or receiver will be enabled in very early
> stage, that if FSL_SAI_xMR is set by previous case,
> for example previous case is one channel, current case is
> two channels, then current case started with wrong xMR in
> the beginning, then channel swap happen.
>
> The patch is to clear xMR in hw_free() to avoid such
> channel swap issue.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Fixes tag, please.

