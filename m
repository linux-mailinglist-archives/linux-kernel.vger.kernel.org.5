Return-Path: <linux-kernel+bounces-51556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE55A848C74
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C61C5B2344C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E73199B4;
	Sun,  4 Feb 2024 09:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JrniFYRf"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D888A1946C
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 09:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707038724; cv=none; b=QMv7puudgI2RYGc/RyCfdsHxZP2TcGXxP0oRx1qow8txC3vzg6GieJ12l03f8L4b3nP5Ll3jsjOxJ+REX8ziRF2n8Nm5ml4wR+vdl0o1qvY1D5s7doJ5aydtOgBc1UtkiwA5cY5VY3QWfzbTQTJ6vLP25l6IHLsoFRlP8nz7cB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707038724; c=relaxed/simple;
	bh=TdIB0jx+9eA/Z7nasWaijsRxtKSpDYNAaVOYscyn8VY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=akgHY5DvxtbPC8wOgpxyDMWMtsywcN0MDPtqy+h83UDrAKzlX+PFbp+hPASEOOpd0EdEMEFwhEBp88b0t7KqwYSg2PkehZASMYtPB702WdttHHnokMIuj98oMv7XrQNECSGv+Vcpb7hQ4pVVnPemoJv0TpHREMJ5zz6xgXmxt8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JrniFYRf; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc6d24737d7so3287341276.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 01:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707038722; x=1707643522; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2SXF+EkSrrLNKoa2FlybzpWwNVCRg86hQFSJJz01/SM=;
        b=JrniFYRf6JuQ/9VHi0PTgoao/jirxz7dEB9KXtYWVaRu2hqCwVcZWdijaaQrguYb+w
         vhNEsM/c9ZqVsBoVl6xnqPYI1Ryc4hk+Ae5k1Ov5Ut8RPcNwkD07ROXxS5G1u8gEL1OM
         sog2bGQpO6wmwI59XP+KTme0OJLfAhEHdnh8T+aGZxs9paJHW6BjkZd9buT8KOWRTr+6
         hVDZW+MCYfun2+dkLj1v7gKQDAes75zRDtthdlmI5nsRblP8NRwiqf6dLp3nxY9vI+1m
         lUQQyupGkK4JHXXKJh8LS/W/fEkaHUXhYSf5agyER64eVNr54B5PCaVbEYC40vVq5prX
         xT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707038722; x=1707643522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SXF+EkSrrLNKoa2FlybzpWwNVCRg86hQFSJJz01/SM=;
        b=ksHvdY5SZqu3Ln9oKFkK2mhtBF1tcGokeXu+vXpMdx4C01R/Q4HKNk0SWRfPgPCVMD
         xk90d4hm4JVtxx6VNKP/szaZj9hXk27cBvVd8vURo2MCEee2Qw7LJvlv1i1UhmiaHqVM
         3kY3aC/CvqNbnMjariUWSZ/WREKS1sDCDBrN86D1atWiBrwRIqp121RU9nPUPCDE7fBI
         lvDKGqaUX5Sw/XfpZwtnC56vXCuVUbavzt340Q9AaIllkD472KRuS4dvCfgsqkx67InG
         GSF8yrY/3MpFfcTVkRJzBsqmYJI6qsZSyZ9UO7ak+mg1fkIIWGeLa55loiuWUaYC+q+X
         LJJA==
X-Gm-Message-State: AOJu0YwsRKMb7ki/IwNtj+19NyTq40zz96t27w9ESeU59w2NQujrv0Ta
	QiaxcimKmyN6F592zBX2mjgVkXuL7IuDVCYNgc0D4cj+35dw2wQDYTi0xRn6tUFbSRZXSQmBFEB
	UiWESqZQYCtvQToiTomWPrRfH49p9w62RkCC9nQ==
X-Google-Smtp-Source: AGHT+IFmzJa4zOHFO8ia/94liHzIiX3hsumeresJHf6afNJ6JvX8upG0PmXWdabKnDLxoS8igzBJqDPfMRtlVHNZa6M=
X-Received: by 2002:a25:ab68:0:b0:dc6:898:150d with SMTP id
 u95-20020a25ab68000000b00dc60898150dmr13819614ybi.25.1707038721826; Sun, 04
 Feb 2024 01:25:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203-bus_cleanup-gpu-v1-0-1b6ecdb5f941@marliere.net> <20240203-bus_cleanup-gpu-v1-2-1b6ecdb5f941@marliere.net>
In-Reply-To: <20240203-bus_cleanup-gpu-v1-2-1b6ecdb5f941@marliere.net>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 4 Feb 2024 10:25:11 +0100
Message-ID: <CAA8EJpqcYaN9fdDzWv9QFtHcaXbm9JoRYyoNxnMzcrHGV+nKsg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm: mipi-dsi: make mipi_dsi_bus_type const
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 3 Feb 2024 at 22:20, Ricardo B. Marliere <ricardo@marliere.net> wrote:
>
> Now that the driver core can properly handle constant struct bus_type,
> move the mipi_dsi_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  drivers/gpu/drm/drm_mipi_dsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

