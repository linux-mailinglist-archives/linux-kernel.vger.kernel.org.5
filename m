Return-Path: <linux-kernel+bounces-104348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE1187CC69
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C98D2282C18
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D62F1B809;
	Fri, 15 Mar 2024 11:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LbBooBE+"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B82E171C8
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710502658; cv=none; b=D6hbxuBMz3qf6CJcZ3tJ1E7oyBR3lJhay+0m0PkeC9wua1ZTEIGGz2k6wLTmpQrUEVB/FR/cLoTgZ9n0lpen9AebGxv24mSpFElVd7EUA+2g3Dsga7NC12I/NVBbJyTKLFIGeo2XJ2kEcHqI4yl32nPgXTkwltkV1Hft6StaHC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710502658; c=relaxed/simple;
	bh=XME15Qz6eZI3kyPR3ZDiBzWwrGS9XZbM4DqTjdNxlo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f0Q2RIoPJEdiZHkgiTTc7f1h7Uqxrl9V8GwS+aooqjz0TPWeddLl1iU+clZyVBHCBOQQ+O3WXrkdgwNHbDS7TLyhK+hmXbAwpvDlvxSMUNRShZcyYEpp9g6ot4pe67cvbOpMtB8KnpGc+Y8xe2iHyFgNMhp4C0xXynpBQF2WKY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LbBooBE+; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-db3a09e96daso1726350276.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 04:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710502656; x=1711107456; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W1YjIjeqOSOzfGq2xXT4IYkQmnAHVepprgGXQRagfTY=;
        b=LbBooBE+IFJU5zVBfnesbRVFF+oqtSU1WlJzGBaC2T+yXwx+5BfKnlSeolCY0Ee6z3
         jvsN1r2KSMRcy48cALERuS9fykH49Kn/wPcWWoB/ymtyLH6X2Uq5ZUFbKiE7KJkKcaWL
         bWFlbRthJlAvfBFDbRA6F8Wi0s2GiirOyMogkMzVbkSG3GuWazCVwGpwKy2MyUDLS12c
         I3tJV233bt9LF6+av+v1+RSum1KrJVG8/q9P3/1Z/oA3G7muD2eKkV3ihL46rd4giYQX
         u8yoKnoHq7Mh9xXmsdCrPNf3cKxBlIqe1D9D7f7mnokLt+eU7LvvJAG5RJZPuUuoeJ9e
         Xe1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710502656; x=1711107456;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W1YjIjeqOSOzfGq2xXT4IYkQmnAHVepprgGXQRagfTY=;
        b=S1ks98GPvaj+NeOzq0anIiA3ZjmrqXRv+JHiKijWmy0cgtCl0NfuMg56tLLwi4XuNI
         6IpXXE/fY1gDiX5ZYrAmmnceSHnp1y/enU3lzK7R1AgOp8kjd21lhgLK1ViPSAmSzeQr
         CbJ1ooOZqdc1FcAuwOkAv9QERdLgzk+SXtsIvzbgbHiHh3Qm7HH48NFIHOpW1r9V+hK5
         Dp51PkAcRCQsi4O63pMx/Tgwf59r6af6SJuGqj78PXz48Y8gexK7YcGqI//n0y9Gl0cw
         NSLk4b9e8mfJRzoSIN1h5JM7ZfIdFcVsaZQ3p6jt5fUfuhht1AFpmlNeQLgc62xcSbOq
         iZCg==
X-Forwarded-Encrypted: i=1; AJvYcCVVbApks4OA8mfwOzbKU6nPG83gGYT/zldLhp1OaawUqb7u4D54h1+4Xo7aWR5VZPu1LgrivoimYlpzOUubwYZBQmaJfbohBxXXhXTx
X-Gm-Message-State: AOJu0YzHcShGRKkp0uwSEIBMjAk2jyY0CEea2IpfveIEIWDeAIfJCQqt
	BGOTQv0Y9AkLYrvTrZegV9nm+XyeGjv+yNNkW4MSzR8fqmxXl7yFKiH5Ie139IvX9O5vjHezvBF
	kfQSnOpU29CMbnNKrEKnHb/GLkROHgBfEfYY3Mw==
X-Google-Smtp-Source: AGHT+IGNjJToPdVH5hgnrzbo2/Y+N7SoBZsHPueEWHCi3sAAnAaUw/tww8bYLv5uKat8ny98eFlvnQEHDXDY2PazX2c=
X-Received: by 2002:a25:c5cb:0:b0:dc6:c2b2:c039 with SMTP id
 v194-20020a25c5cb000000b00dc6c2b2c039mr4303557ybe.41.1710502656113; Fri, 15
 Mar 2024 04:37:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306030649.60269-1-vignesh.raman@collabora.com> <20240306030649.60269-4-vignesh.raman@collabora.com>
In-Reply-To: <20240306030649.60269-4-vignesh.raman@collabora.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 15 Mar 2024 13:37:25 +0200
Message-ID: <CAA8EJpo=OXUitC+NPjZd5Kpq9dF04BSffvgsMYnn7LmmEoh09A@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] drm/ci: uprev IGT and update testlist
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, 
	emma@anholt.net, robdclark@gmail.com, david.heidelberg@collabora.com, 
	guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	hamohammed.sa@gmail.com, rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com, 
	mairacanal@riseup.net, mcanal@igalia.com, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 05:08, Vignesh Raman <vignesh.raman@collabora.com> wrote:
>
> Uprev IGT and add amd, v3d, vc4 and vgem specific
> tests to testlist. Have testlist.txt per driver
> and include a base testlist so that the driver
> specific tests will run only on those hardware.
> Also add testlists to the MAINTAINERS file.

I think we should move away from specifying tests explicitly. They can
easily get out of sync. A month ago I had to manually go through the
list of the tests and update it to follow changes in the IGT.

I think we should directly use testlist.txt from IGT and then filter
it out using skips.

-- 
With best wishes
Dmitry

