Return-Path: <linux-kernel+bounces-90340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 278A186FDE9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59FB21C21FAA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D028224F5;
	Mon,  4 Mar 2024 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nk320g2d"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0184A224ED
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709545601; cv=none; b=gnZjaLEZyW9s4w5AmRMqZs3veyVZar8C7lsc90B0F1SfJr0/dp8/taunv/JizedCQS2KUkoPZGawlY1z5yD8LhUfFr8T+EQ+6z5fVFXcaCm2dHlpk0AeGYWQySZPgIVS9DnW6If6p77kw8k7uyICj55F4fKo5EN9eAA5LtacHpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709545601; c=relaxed/simple;
	bh=IOg5tTL2EdxX2sOuqblEfmkpCxTVQxFqLrNY/pH/HRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XkdGnvFyGlQtN/H3tThV0Gu+eAECxTa1YOKEVsNBYqKJZVDN8M2wjxlAzC8Tbe+nN1HsfN6/MKz6UgglTjIoJW3u8Sqwe/E8/xrqVOdv9N/ge3gcu3Bqo6aq92PamIyYWk3jOpPlN/SRkMRiECpwyXadp6OypXfTuHL0MccqCso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nk320g2d; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so4976863276.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 01:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709545599; x=1710150399; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BLGlgXihsI1VhplbXrlYAn9SvEI3AGLqfYGV0kshuQE=;
        b=nk320g2dGnsZ0R5TeoBCPqZIYn7JvJHerGm5CNp5gCfzgRnec9bk/s/XWm4QFkHx5R
         A3jdxIDPVkw+tJI8TV7FPRJMFamIONw0LDuH0+1zyPaUa0GPDNChYPwBxNM3rcHvjGsk
         1eIew01d+QcohwAAPoHX00BexqH0nbSaCElR9pQAjSDRIny04vM576BPlsEyAvTneeYG
         6zvvTFvzkKksPEC7VSSIz1N+qk7BMzXmAXKh4PE1uWKwgK//6WiMUyvA4EnInN9R/cVd
         wRkJESHzIADi+Am0ZaV4FNiPMt1Vd5lZLDCVQiyLbLUG9VzcpRCqmbDAygABkFkYMs2X
         1izQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709545599; x=1710150399;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BLGlgXihsI1VhplbXrlYAn9SvEI3AGLqfYGV0kshuQE=;
        b=vPDKGgtbhGVyQJ8A+SmEX/Wq5T6Wp3uCuz6rO/WA+L2ulYk+nYrLDU3Gx/BIzU+RPa
         MnYk+Rq1xVOLY0oePsBuwx0+UZTm09HShELqyfhOciwpWhYRZwFe1oIvdwYbrCyw0vp7
         lV1yiiiB05eSY3Mmke0bxnyESMApQlbfqcmko+pZAaZT78o7oGADvcRxHlv447wXXHCr
         Xr+SgQi1FwGQ5UB26xAOB0DYA+G6vlAFH9j4jiXJYuK3+MoPsf2UIX6+VOWJ0ui9J4pm
         7Do84EFoHyrb2lUWkF99J58qF9tWlbJSf4lvAVkEe4+sOaH8H7mnvv5Q5U7jqBllGV1A
         gwRg==
X-Forwarded-Encrypted: i=1; AJvYcCUuZIdcU1Oim25vgmRKkXgOuzjeVWU4dvFM7J7zfSgrBXrh5maHxsI2OkoNpX0XH5C1MCa1DCeZ0f/5IXu/haghDFYk7nqF1oLNTkjS
X-Gm-Message-State: AOJu0YwaByg6cilRuSlRRby6rVmYsRFEGJA9sSJuQMedH3PVsSdf1CvC
	TXEgfNNnsvSBkvBWfejCWaPB+SfNlZymsOGwpqgYAoSh2jK+vFz2YYt5AR3XJgcHwkdQc0+kJl/
	olksIak8zhgzUlKRl9j6vXsmbfbEQbfjxpVb3nw==
X-Google-Smtp-Source: AGHT+IEbNU5fOYhkOcwfE8i+Fr8S1blQTCr20ozaETwLblB+uHKIvc0Yw5/C0eYI4phk8/rQ63At6c98jlzp9d0hOLA=
X-Received: by 2002:a5b:74a:0:b0:dc2:3a05:489 with SMTP id s10-20020a5b074a000000b00dc23a050489mr5804962ybq.14.1709545599070;
 Mon, 04 Mar 2024 01:46:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228194730.619204-1-quic_abhinavk@quicinc.com> <20240228194730.619204-2-quic_abhinavk@quicinc.com>
In-Reply-To: <20240228194730.619204-2-quic_abhinavk@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 4 Mar 2024 11:46:27 +0200
Message-ID: <CAA8EJpr+gTAQkc9RdDap2z7MvDoZCqBqJh3=7_4OwcXamDz3SQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/msm/dpu: drop dpu_kms from _dpu_kms_initialize_writeback
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	quic_parellan@quicinc.com, quic_jesszhan@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 21:47, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> Following the pattern of other interfaces, lets align writeback
> as well by dropping the dpu_kms parameter in its _dpu_kms_initialize_*
> function.
>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

-- 
With best wishes
Dmitry

