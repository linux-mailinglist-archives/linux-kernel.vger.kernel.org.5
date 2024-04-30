Return-Path: <linux-kernel+bounces-164564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8008B7F58
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDEFE2855CE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785A8181B89;
	Tue, 30 Apr 2024 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pJh+Fm2H"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D61181328
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714499991; cv=none; b=krQ+2F1CcUKnp4WvtDuGO0IrikUnJMFv1AAnkNbxZaxMIU4Gb3ERvSR+UTlgmUdjdPVTIzFQhjjAAZbOzW0YyrCuWWOydI8un8lYtuLim9iExmKmicz9I4YNMA6xIdOSEgPLGiG4p7U21GAxJVinFpeDthpmYvHKjbFLIlCGgN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714499991; c=relaxed/simple;
	bh=L9oTYqz7coCes4v46W8uTEssCznxNlmpxkBvoifmY60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHFlOPiHQMdlu3V3bMOk1AD93+571HLSGk2JPMYdArfZXwLxlIKQ6afy1bXtgWQk/FWNptvO6Ddc0R7leO8wUaO+4MMwFVGn5XxGdzGzVA4NFwNAa9sxe8HzHZKc1QmlsAsxXC9dhlhCA8mFJYeIC914YqQCOfw29eQE91nMZDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pJh+Fm2H; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-de54b28c3b7so6675903276.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714499989; x=1715104789; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vseX6k1o+B5FqObwflCIgJI2bSMTOCAMOHrgjYjS0ao=;
        b=pJh+Fm2Hu9uyHqmGO6wSmYgTyjcEk+KP0ZnDWNfk8Vj6EhzHHv/VQqt6eXq7wisjeV
         Zn6ypK79yrC1hBz+VvWu3JPbJfntKCvfA5Q1YcvH0weJEYQLR9J3iAHdVoKu4eeN8KUe
         QrWC2rTACvbnGF29DSRSLcWwb1A2Em0UQ682Ej8ZIU0SsGBV19pci9xXtMnM34pbNi7j
         e0Kndd3hCTEY/coaLzeTUFPoRdY6QoyMPtgKrAdvXl2EsWzDJ/icDR5NjOgkTnKSFJsa
         cZrHm1qR3z4xbA8e/+VI+BvTWGgnjnhsRxgoiWBzvHmY1q9u9+c5f4Z5sUkwB8NPpZ21
         Z+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714499989; x=1715104789;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vseX6k1o+B5FqObwflCIgJI2bSMTOCAMOHrgjYjS0ao=;
        b=u+aTowcQFZ9tis86ejgG0ftDpiNFQ9Q+x5WdUZmht847gkbmNc+4aNjB/7mNhYHZmh
         PTyBDt0bmTj+HX+LyGRyqtA0UEM5mAzk/0ajWr4rtC9m2y7qs8RuZMLKYrGDglUnxu/E
         DbdLhbNBnEuffrcPai4GKODY05fZVDj1sseK2eDrue6K7b2ytZL0eyIlfFpjdfak5aI2
         dci2ovvq5C0w6lIYuL5FdnUVCfRLfLnQIcOasff2lgOJ9s6qbi8Z+fluO6JR0x8o+V+y
         qbgoMFaKhrXeXf4V8rewA3X1XBOaYdHN0NC509J7150oigneeeZUrV2JVmkm6I7ZTGdc
         8k/g==
X-Forwarded-Encrypted: i=1; AJvYcCVqaGxuePmSZ7cRTJqf1l9Yf9nGi3S8uXaWxVRH7zfSB6YpV4WKnv/8ciZ/YVrHKrv4GDFWtLeiT9qUyfqSHYOk1b9z9zP0bgRj4Uvq
X-Gm-Message-State: AOJu0YxGYRb7bGD6sW9/G09YXmwX2SblFpK9lk1PQfTGq7fnNJUxD6/z
	klu74XQwNjClJYLpoKNmUtJGigppiF8JvuLdd4xcqujhgB3uw5cxTq0nwLBhZ8gs4hXJ8A0n2J4
	LhT6rtuBMa61O7XnP72j64epRrs+m1RqU3d6Ciw==
X-Google-Smtp-Source: AGHT+IFxTsE2SveaRlTBhB+EE6DHBgwYOYt11ZOE5SdTfnq52tv68cpVnXh2QMmknwt5E8opTI/WtCOAflJ81I1ljMk=
X-Received: by 2002:a5b:648:0:b0:de4:7f18:4a3 with SMTP id o8-20020a5b0648000000b00de47f1804a3mr316138ybq.25.1714499989331;
 Tue, 30 Apr 2024 10:59:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123144543.9405-1-quic_bibekkum@quicinc.com>
In-Reply-To: <20240123144543.9405-1-quic_bibekkum@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 30 Apr 2024 20:59:38 +0300
Message-ID: <CAA8EJpo2nU81K275eze9W_LyXwrrzP-u3DE2OaVfBgsVgHcK=Q@mail.gmail.com>
Subject: Re: [PATCH v9 0/5] iommu/arm-smmu: introduction of ACTLR
 implementation for Qualcomm SoCs
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>, Rob Clark <robdclark@gmail.com>, robin.murphy@arm.com, 
	will@kernel.org
Cc: joro@8bytes.org, konrad.dybcio@linaro.org, jsnitsel@redhat.com, 
	quic_bjorande@quicinc.com, mani@kernel.org, quic_eberman@quicinc.com, 
	robdclark@chromium.org, u.kleine-koenig@pengutronix.de, robh@kernel.org, 
	vladimir.oltean@nxp.com, quic_pkondeti@quicinc.com, quic_molvera@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jan 2024 at 16:46, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
> This patch series consist of five parts and covers the following:
>
> 1. Re-enable context caching for Qualcomm SoCs to retain prefetcher
>    settings during reset and runtime suspend.
>
> 2. Remove cfg inside qcom_smmu structure and replace it with single
>    pointer to qcom_smmu_match_data avoiding replication of multiple
>    members from same.
>
> 3. Introduce intital set of driver changes to implement ACTLR register
>    for custom prefetcher settings in Qualcomm SoCs.
>
> 4. Add ACTLR data and implementation operations for SM8550.
>
> 5. Add ACTLR data and implementation operations for SC7280.

Colleagues, just wanted to check, what happened to this series?

-- 
With best wishes
Dmitry

