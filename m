Return-Path: <linux-kernel+bounces-118023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5F088B56C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56640B36CC0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10956DD0D;
	Mon, 25 Mar 2024 21:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rWMDnrDf"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E646CDA7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 21:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711401405; cv=none; b=icoMfLSnselTLSCkIX+dYDrmfGJUzg+d4xMyEPgOdZ3M6fp9Nq7XX/RM/Booj7qh+ClohoR2x4P4KxHWEV0JTX0n7UklzPQwHXCaXjQ7sxWeC0FVg94uCemcFGdiaL9WOs5tilQZvsVnAgg1hLFhmLI60lNcvbYOSNsO7JvyHKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711401405; c=relaxed/simple;
	bh=XnYxg44n9UmMwx+BfT1Lx7/A6qiY0HCS3q4AwEZrM1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f5FgjI9mxHbFAFUDQLwxBpDN+53yOre62nyLgYN9fAFevJGjmbTskVIWgk/cCSiLcdcjKcMrXWW84jom5OgpPM7iZdavRrdPBlhEsgjqksXb4MaxsW1rCEZoBWOiBPpGPmM+wQErR+jVhAEn4JIJ7gVLgPRjLQAyKsCqZ7804iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rWMDnrDf; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso4624057276.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711401402; x=1712006202; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A8IFRn6aSsHl1VGtupM1OXfTkfRMf//PoRLv8D0xq6c=;
        b=rWMDnrDf9gHNg2/QKWN0eeANEUs3l7Usx9Nv7FF0YV24qnJVsRVxiGxKGQM6fYfTmx
         EaJCK6hq+TpXrA7qQA9CCMbBpn8eKXZwusj1fOxyMZMGQRwiulq3A9zn77cGUFQ2ia1z
         Hvd+dnVRE0ctsG90OBRYwVQkT0DFORZkwyBjIZgz0+6pYzWbkF+yR4EzN1YRq3RZqHB3
         nsjn8UD/Ibw47p5qD2vOU2V8bvl8rPCuO8UIZTq1THlnoc9fZQOjR0jG+UR/Ux+Loyyc
         SeTwj5uBeHO+fJ60ONCBPJAaWREls86BlFrKHchUmgHqR9n+RvqB1spcN8XFkB68UH1V
         0keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711401402; x=1712006202;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A8IFRn6aSsHl1VGtupM1OXfTkfRMf//PoRLv8D0xq6c=;
        b=Z+e9OkNw6TjFdtRoB82FiGXn08mjuZKfmtB0FCKrXMFgTF/ynWGYnkwWrdhiovN9eV
         7FWzusGZvn2JqPJ/y4BaqyUYtZWawmVCFDqJPBb/PfG/uYmPgj4OQMNbAHwdbHNhFh+e
         I9ZVua/XFnlLa9dPMPsHmAi2unidtcBb1fiQi6KPTA7g78IJMkLXKLNE/1QpjkggsgYw
         HoP3acSJu6QmpKykgptQf86iqyf+mVqv3RIT74NZ6O+Ml6huGqJNuEDGv0iyuMbRC9l2
         g2QkRK/mcnC6KAxt2KbHojJWSmpb+zDNJOB7FXF/76OQ2kLjxLjNiIKXpkNyD45AcSNw
         +47Q==
X-Forwarded-Encrypted: i=1; AJvYcCViBqBCSqYSa+DaiNSUihbT599ryhrpRFs51HgCN6ltPL3+XlPMuHFK0xs2n1HK4Ijthwt7wVKIisVSRTzpb55Zt0uSGgx43oFaVBg3
X-Gm-Message-State: AOJu0Yz4pTHyFgaS6H/i2UP23Y0cL6rDI/DUxe9MsQvFQKqvFcl3e0l6
	adQ2vPNkdohHA/e+VpZeWnUVsdTkbYbQUMojB80PnyHcjtVDWIhiHd4gZqQqVUCSxI12mfkoFYO
	2MWdWk3LWvzYkfDjyjKFq5o+Pk4dZOxK4yLMYHw==
X-Google-Smtp-Source: AGHT+IGmfJuEEZK0xXYu1atPPd7gdTrXAHTMAqXWgAFibdrfnqzHArI0XM86kbZ4hMgAFB1mDKzR3VsuVkcuM2xu2sk=
X-Received: by 2002:a25:a1c5:0:b0:dcc:52dc:deb5 with SMTP id
 a63-20020a25a1c5000000b00dcc52dcdeb5mr5391964ybi.20.1711401402341; Mon, 25
 Mar 2024 14:16:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325210810.1340820-1-swboyd@chromium.org>
In-Reply-To: <20240325210810.1340820-1-swboyd@chromium.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 25 Mar 2024 23:16:31 +0200
Message-ID: <CAA8EJppFc7+ca1JA9cbtAEV3+Ln6BoTkzdqyq88_gfN+m9fiPQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Add newlines to some debug prints
To: Stephen Boyd <swboyd@chromium.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Mar 2024 at 23:08, Stephen Boyd <swboyd@chromium.org> wrote:
>
> These debug prints are missing newlines, leading to multiple messages
> being printed on one line and hard to read logs. Add newlines to have
> the debug prints on separate lines. The DBG macro used to add a newline,
> but I missed that while migrating to drm_dbg wrappers.
>
> Fixes: 7cb017db1896 ("drm/msm: Move FB debug prints to drm_dbg_state()")
> Fixes: 721c6e0c6aed ("drm/msm: Move vblank debug prints to drm_dbg_vbl()")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/msm_fb.c  | 6 +++---
>  drivers/gpu/drm/msm/msm_kms.c | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)

-- 
With best wishes
Dmitry

