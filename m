Return-Path: <linux-kernel+bounces-94069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF42873960
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D29C1F212FF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2B3134743;
	Wed,  6 Mar 2024 14:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fQzIn7iW"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFCE13442A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 14:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709735927; cv=none; b=eOl76lyl2v8r0DRMx3f49PP7DelAN6t8dVRWMcTGPjHR6FPq/9QQHiqv4EynvnE9a+uTlq725wlWESLLTlRPrDla8if6pSRNTMMTjZ07ULrVkLN/Pk8bJznvXUqmtECuRMGhPSvpZY+jxWOwuQS1S9kcjmtgPZ5CxXbZV0TJBR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709735927; c=relaxed/simple;
	bh=UYQElA21Vc/pmhp4gVpQGCZky5AHWUDbfIp4Jo9TBWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOf3IVNed4J8h9/2UFbni9FQBYhlOilS0/dABBy+KYETtafyf0pA2WJLJcsUuNqBR1edyRGq3FepZ//+rmGGEq1WvvvbzRjr1tv2lV1m2FfkkJpBxzCzhSrFMZy0qtKy6P+afipxnB11hmcE/f7jZakXGkP4sSDKIMTedFHoQ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fQzIn7iW; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso7144471276.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 06:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709735925; x=1710340725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbF9LUE00uQRPWZd4Zl2CO3WAagI5yDkhO9LWfTGu1g=;
        b=fQzIn7iWzCw6LFRZ5+Fo0f5reaGVdKKJHmu4aBw015uAsEg4nS8VX8rzc7ybMU7fJc
         HjC40kZvV3d4+3a3rUsGDb7VtZP6gAJbA7F9MUdagPC8UvMcdpbYOmJGhcHQ592WlYbx
         e6HLP/Csv/M1djh7tiXFtyVp9suOLZvTwFlR6yKLaSNvoy2Bu0BgEE6/CruiegtJVM/5
         wJzXwCTZFyRSXQxwjV/xON17tlcz5viLl5R6SpLM3/RLy0T7lBhFBTWlokQ82FyKDpi/
         dJRxYKZizqO3Ey6k7Z0j+1m1Pf4ycsEBHkNxOesZqMcizVDI4mJXiSjBrEP1Mqa98J46
         5dlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709735925; x=1710340725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbF9LUE00uQRPWZd4Zl2CO3WAagI5yDkhO9LWfTGu1g=;
        b=ZAQkk/tjf6isygSfFQfGGSziCa6Y2OPt1X3dS1NUDDwGPiLD4rlP9jMsKtckTXEOPv
         nN+iDDT0K2wsp6GDU5C7AY+cuC/JwLDjykkLhVUCoLGqYGVcLaQK0nbz5YQaPbf5sSGA
         ZIxSjcW09riklQZXrG4A4tafk82hAg1q+EGCiVXeWUbLm68DtEztnJJwuh0JgeN6ID0T
         YyBPSwAj6ynEYyzuWKiPTIyIOjyqsdYHpmg4lntgD2OXQL0gZnazWP0rAkiuh/w/xllb
         tkWr2bDUyJl7AMPEDHwoAiVsuFOTKCaVFIKp0KJXKBhfpyYTpUCuAxNV0tubh5bMZZU7
         m+rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVFQi2AOYq1yjlwC69SG/Br5TffwAFqye0PrytQy9jR04UpezTAsYxxwAJow03wbeHua4uLLC4cSieyKFaiYicvnfgbc3C1OeKs3zl
X-Gm-Message-State: AOJu0Yx0a371Ca8AwEyCIgIGo907WGxqCy2wngBxZu4CWmQPIl6jNn2A
	1bArGN8QWB7ALHQok/e7NBYuag9QpkvhXaQsU4gxEDU/bGxZnAwGNF/98B5v+sR6p19By2A/xoQ
	u6BsIBl/vcmhixy0ds+bARqNADCzLqEQlKUrQ5A==
X-Google-Smtp-Source: AGHT+IHaircIiKXYxywtnPc3zF52U66kpfR3sTMrrlwd5QsIFlNiZoKojAWOv4vxuACm2tLLwUri9wBXyjK8S8r+NMM=
X-Received: by 2002:a25:814d:0:b0:dcf:a52d:6134 with SMTP id
 j13-20020a25814d000000b00dcfa52d6134mr13225878ybm.26.1709735924948; Wed, 06
 Mar 2024 06:38:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306-mmc-partswitch-v1-1-bf116985d950@codewreck.org>
 <Zegx5PCtg6hs8zyp@trax> <CACRpkdYZrDgVVCp2bqJqY1BpeHSXDWbRSqk6d=N_QhC4OVv=Ew@mail.gmail.com>
 <Zeh8HGDToMoHglD2@trax>
In-Reply-To: <Zeh8HGDToMoHglD2@trax>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 6 Mar 2024 15:38:33 +0100
Message-ID: <CACRpkdZ1ervTXj6++oBPDNJT3TpVgPeYsyhaEMRYavJQ5iZPqg@mail.gmail.com>
Subject: Re: [PATCH] mmc: part_switch: fixes switch on gp3 partition
To: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, Tomas Winkler <tomas.winkler@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dominique Martinet <dominique.martinet@atmark-techno.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 3:22=E2=80=AFPM Jorge Ramirez-Ortiz, Foundries
<jorge@foundries.io> wrote:

> I still cant grasp how "target_part =3D idata->rpmb->part_index" is
> helping in the design.
>
> What happens when:
> 1) EXT_CSD_PART_CONFIG_ACC_MASK > part_index > EXT_CSD_PART_CONFIG_ACC_RP=
MB
> target_part now could be indicating a GP instead of an RPMB leading to fa=
ilures.
>
> 2) part_index <=3D EXT_CSD_PART_CONFIG_ACC_RPMB
> loses the part_index value .
>
> So part_index should be larger than EXT_CSD_PART_CONFIG_ACC_MASK even
> though the comment indicates it starts at 0?
>
> /**
>  * struct mmc_rpmb_data - special RPMB device type for these areas
>  * @dev: the device for the RPMB area
>  * @chrdev: character device for the RPMB area
>  * @id: unique device ID number
>  * @part_index: partition index (0 on first)    <---------------------
>  * @md: parent MMC block device
>  * @node: list item, so we can put this device on a list
>  */
> struct mmc_rpmb_data {
>         struct device dev;
>         struct cdev chrdev;
>         int id;
>
> is it just possible that "target_part =3D idata->rpmb->part_index" just
> needs to be shifted to avoid issues?
>
> I think the fix to the regression I introduced could perhaps address
> this as well.

I have no clue how the regression happened really ... heh.

We should probably rename it part_cfg because that is what we
store in it, it's assigned from card->part[idx].part_cfg.

Then the id field in mmc_rpmb_data should be deleted along
with all the IDA counter code etc and the partition name hardcoded
to be "0" as there will never be anything else.

Yours,
Linus Walleij

