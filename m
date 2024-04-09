Return-Path: <linux-kernel+bounces-136061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 064C189CF9E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26EB2857C4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0869D6138;
	Tue,  9 Apr 2024 01:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tV9xse1W"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924FD23A6
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 01:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712624917; cv=none; b=QOuicoFpeP8eVmnqkCDSndWWs+Oy/uQ58KrmGwUazu0Sqca6CH4Gj7dDEs0zGYy/vPgtI18lPDBLGzxrfUNMY5WZRly9I+Fo4cO8MiRCm7i7/sbbSHDrXQWqYkRVW2nmWAp/+ipsnXHNpRZSR/qND/QYeItEdNi86ED+BpGyYR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712624917; c=relaxed/simple;
	bh=LBwhlCZISB2W+Dbl7vZfWeWvtRLIIIDG3aeJd90Kjpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHGJh1KRlY8WpIj2EtYMVc+3FqZjzwlXRCnM/a9iRB6PP89WgGxeTvuHeJagH/T/7SL4oBfgsOSWNoVPL0lSQi8DmKXP2DazpqCFJ8Dih9/p/PPn/s9bev0Eq5TBvtmcATHi5CkyX3xJmjokRigfZEi0HGAYSpeecKuTYzfv/qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tV9xse1W; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d4a8bddc21so71436321fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 18:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712624914; x=1713229714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y702sD6lZazSpofQh99p5zeY7MVLXMvfgYYg7IYQZsQ=;
        b=tV9xse1WfTDoPmbYNdQ/CF6BZcXVbjZZL+mo0dTVwtlVDL47LGc/ih9M+VuO78AVxc
         Dke3l3XglI+mj7iTJM4CWjZEi1XBKOeQNPg/aZbRVRQxHkic2KaA7JJG6iPhTPr+HN53
         Kj0HjQpy6UydHfJBFhamSDPC7w+7Hii+rOvc+LMy1XA1rsg0f4Y7HQdAvHYlU8sZvOU/
         fLq8gGv2aTqfJK5xrmVYC21xhojguoFVGBcGhhKXPRk/MheWXBqmntXDRagq5AQA4nYa
         eeJ+Vmea/57+WU1vZBbVTGAQrGSdWbP1qKrf2yUqb+VLPUlHQS2XOyhHrzLz5NZJbthT
         /2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712624914; x=1713229714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y702sD6lZazSpofQh99p5zeY7MVLXMvfgYYg7IYQZsQ=;
        b=EbZyfn+301ZF2lDdP022aQTsMTB56dX26uPOlPWvpsonyR8GQC46uHsLcRu5nzGvfa
         rDjSp+DHxn3cI8G3td31GlFEUdS3NO86lF0uQiORWTPbk0Eg8ZQb7W7QaWqSi8Ol/H48
         Xuj4WAgsUlTRaqw6enVmLgK2A2/TSNWiaS8CV+3nn7D6Y2VHTS7+v5fFTIbtRTueBHaA
         cR7rmVVV6jSf5GvUaHoBYLqgAuIMUaCu/2wxIRqo/1KV+ahnjSiMFTpHrl9bYIKOO1yz
         zJcZEXeOv+L/1CbJ8WuPtHXPgd8D6ejFPS29Z9ILh0l81hAw03JtgaLdROxuU2fMvmdh
         JnXw==
X-Forwarded-Encrypted: i=1; AJvYcCXlw0c+pqK6pzF2bY3eiDB0GdMujtvnt1bzQ1YqovydnO5v1xjpkTSs3eOdZju9QUpNZe1c0JMLyLrI7eT5oP9n9Tz8exBdrHbE5SIU
X-Gm-Message-State: AOJu0YzOtpmN6+zAl0sfviroTlFYwymiiNUc1ZNoT3Xb3bSjTWH0OWFU
	j42C9H95FpKob+GLqbDaRkM2f3OfxVWJnUtkQJcKssZQDzVAOxcUypZpUDMCG8Ppux5hn/jboDa
	M0BHbuCs41gC1REKzaACKmfkiDGfWkTUJKavYkQ==
X-Google-Smtp-Source: AGHT+IHiy9qBSXkFrD9zOe8AVd14AwotGKD6BHTslXygXNglhd/58kA0ThQYKsDSq4+gjwlvtr0FPC+LDTBg0n+dnPM=
X-Received: by 2002:a2e:8913:0:b0:2d4:5c0c:77db with SMTP id
 d19-20020a2e8913000000b002d45c0c77dbmr7214260lji.3.1712624913705; Mon, 08 Apr
 2024 18:08:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403-msm-drm-dsc-dsi-video-upstream-v1-0-db5036443545@linaro.org>
 <20240403-msm-drm-dsc-dsi-video-upstream-v1-3-db5036443545@linaro.org> <qlabqrtsnw4mu23li6r6liujch5mf7n2bdbuuqrsukwfw24bmn@nyw5sandj2cu>
In-Reply-To: <qlabqrtsnw4mu23li6r6liujch5mf7n2bdbuuqrsukwfw24bmn@nyw5sandj2cu>
From: Jun Nie <jun.nie@linaro.org>
Date: Tue, 9 Apr 2024 09:08:36 +0800
Message-ID: <CABymUCORNVKOnNnZEhzLC9XjPuDOiVGuJ-NCh-r3VCXT_8o1fA@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] drm/msm/dsi: set VIDEO_COMPRESSION_MODE_CTRL_WC
 (fix video mode DSC)
To: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Vinod Koul <vkoul@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Jonathan Marek <jonathan@marek.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Marijn Suijten <marijn.suijten@somainline.org> =E4=BA=8E2024=E5=B9=B44=E6=
=9C=889=E6=97=A5=E5=91=A8=E4=BA=8C 00:45=E5=86=99=E9=81=93=EF=BC=9A
>
> Can we drop (fix video mode DSC) from this patch title?  It looks like mo=
re
> patches are required to get this done, such a mention is more something f=
or the
> cover letter.
>
> We could also clarify further to "set Word Count for video-mode DSC".
>
Accepted. video-mode DSC is achieved with the patch set, not this
specific patch.

