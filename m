Return-Path: <linux-kernel+bounces-64353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5802853D63
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56C431F2808A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A563362806;
	Tue, 13 Feb 2024 21:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nu+rDl5z"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B12F627E1
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860421; cv=none; b=m0A2U7/eeQyl5jODTgUF/3IPh55RNFLRFIBC3SuzRwDximVpsxCjBwPJfS9UjhSSv0UXgSFINn1tRC2IAsoDCsEWBbHOdP1yKVKLOIqPseR9C/X+my13xPX73ZvBAtuoJ898t5rsXZXd9VaLVa/gyzg3J9ydleCzGBoRQb/L5fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860421; c=relaxed/simple;
	bh=dbFTyn7f3Bl53OcK8D9X/nWjgslx47eYuZAqktCtuuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brCj+/Uq1y/2bTu4fDJT/LgL1AgMcV9khmEsbSZxLyN+hK6cttSt9QjRMiSIVY1bXxxusfqM72jVTBaXGM0+Ea/YCJfp2N/tmhJB+Ec6yj5MGGenDTeMjuieBKxPbAuTMajAMgwkgoR6NWWybP/6tipM248RSYA7Cl3I6nBSSok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nu+rDl5z; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcd94fb9e4dso380784276.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707860419; x=1708465219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbFTyn7f3Bl53OcK8D9X/nWjgslx47eYuZAqktCtuuk=;
        b=Nu+rDl5zo4iTrqjqPj78xjkzT4cMscx1PPubPBWe5N2cMjjLIDO18lFH3dM1JFSKZq
         26UjzIah0cH/OWRiTC0v2MkcZ3kh8jFe6Nlwtqfe3yS7f2EmM8iPK64w3r05XpiJxnNh
         RcjkbuHwbZxK+J1HqDufXLVPgSXUQ29zYnFPWGti6W7VxOgddSZcfIBHjTpHg6wpQ4Rs
         CWQU0ydzXJNutGwSBXpJWpJ8ETw40aPHfruES92QxaBFcp90uiR8oOQRhAPE24GfTRGb
         z2LpAPJ3LVxEoRrd5o3OczWvjTD9cQpM62f2ZRG1qjiNpY+Z4snzZ+N/X4Z5j2jxhcH8
         rVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707860419; x=1708465219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbFTyn7f3Bl53OcK8D9X/nWjgslx47eYuZAqktCtuuk=;
        b=GxPtCOr2PBRMUCgK3XuZQvCMaSpSn1dr/cEjm5aJbSZsA6b3HN0dAwbzSxH+5sSGuP
         MrUmi9B8LqmPOLM9VmQQIgtM6h8NeCT0XB4l8Yfa+8zyRgJDX2JwSJi8zldQ8bwoupRn
         xCEBr2zrcnC2NxfsRDFQSOndvsuIpKIHFfpCmfbHo41IIKeeW2zKX+vWYfPf4jsS23Or
         mltxEFa54rgsVLfWLljx5O6XHU5l+G9H+VYyPUoTF7WaRoo++yaT3JoCPnI8n0PhOx4R
         hCBn6hKF3muHTbKHOhgttEQZV9WfFjXluIqAZHoRkh1H4hjiPK5r3xN6pgBph4NedRc5
         f44g==
X-Gm-Message-State: AOJu0Yzual66LFI1cI0ooE1rJSSRWYgKwWFiQPtBojWQeei6HYRJR+Ix
	lRLkqR2VN5MXJJf+kgveNbbry4GxMW3gXU1UhpQF7sdu67C5yWwviDNbeCmQZc3jrc3Zc8w/Ti+
	WVhUrMSDCVD7UmgpoBXNI/AveBQ164/VXmXmudg==
X-Google-Smtp-Source: AGHT+IG+DrTkq+6t5fDsH9BhBPiao8mavkN9+7BGb5kbh070ERv4KU9R3wW6RVskOso+QLGC3mPrRgt0YTpbyg4aQl0=
X-Received: by 2002:a25:ac18:0:b0:dcc:787:e8f9 with SMTP id
 w24-20020a25ac18000000b00dcc0787e8f9mr426631ybi.51.1707860419256; Tue, 13 Feb
 2024 13:40:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213141222.382457-1-warthog618@gmail.com>
In-Reply-To: <20240213141222.382457-1-warthog618@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 13 Feb 2024 22:40:08 +0100
Message-ID: <CACRpkdYGTay1s=yK6nWXar-AoVzyZhd=i-h2Ff9xdH7_CO=gdA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: gpio: consistent use of logical line value terminology
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-doc@vger.kernel.org, brgl@bgdev.pl, andy@kernel.org, corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:12=E2=80=AFPM Kent Gibson <warthog618@gmail.com> =
wrote:

> Consistently use active/inactive to describe logical line values, rather
> than high/low, which is used for physical values, or asserted/de-asserted
> which is awkward.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

