Return-Path: <linux-kernel+bounces-98487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC36877ABB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 06:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B6E61F219B8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FEABA57;
	Mon, 11 Mar 2024 05:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ji07QN3A"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB8A79EA
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 05:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710135924; cv=none; b=otfb5ql2nf9eXnEFq+iPiNuadoRDPVxwT5jk5TkiM4NFclLgveymk9BkWtKfS9umC9wb2urKocroAO+FJXgeNunmiJGBkV1r2Rh8Gm8UpOzfGodn+i2+kYnUp7lZWELDx3VqpiQ4ob23KlbWttLHR8FQc/PSYpZmUJJADdB353w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710135924; c=relaxed/simple;
	bh=1U926oL0MDod9834V/+y8z2gIy7U+dCjf8CDW1Dhy+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kz+HQ3M6MdYRpJob5g4WQ3l3hAIZxXB9Eag7Nw9WVCj8h+MlIgSlTm33U9NmzNg7thf8VtQ3epoabuifirPxC8REmhYbn808KZbHOkIml9nYyhqQbXnSHLcIktuXqYDXOUv1Tn8H648/y/FI99XaT1MmKk661pVK72zQizmvRA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ji07QN3A; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso61298431fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 22:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710135921; x=1710740721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1U926oL0MDod9834V/+y8z2gIy7U+dCjf8CDW1Dhy+k=;
        b=Ji07QN3AZu/152RvTihbQbO4fdK5+sSJkoUuV6RFSltcEZxB8AGEEB0CQAKddomsmZ
         fk25kf2srM9sMTk0LmUrnBbkpLSshTrtkLDcITMnpDxe417DaDnJPvYWydRBjaPBXJOA
         4JKew45tQgi+G6iDgkSQsGBkvVm2EskBtuBzMvriZwWDkO1JWfFqTNbvUhQogaCjHkE2
         FYqlBPJDwJzRiHx0xbS2Uh3diYvWXSKUh7c9HINjcL0VPKVGxIrZL7SMcWLMJl5bOhu9
         YdFAY/3mrkn54NBTPjmGFza0c36j+18IlpJxyV6IOYMRj1vsGg12JTkBQwuBJNHwyUIi
         km3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710135921; x=1710740721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1U926oL0MDod9834V/+y8z2gIy7U+dCjf8CDW1Dhy+k=;
        b=AcFm96SDUbWDh9Xpp0W4L2yKWsGDMTVL/a6BNFvaCjMmHJ51hvTRw8nj4SmpybXDJ5
         HRBivL8EBqM3tpgKsDU51PewiNqayIxQJD3rZbVTczfIkXNUetYztEIiufNpmKc+Awy2
         Ie49wh06CoP/Lj5KfDvJ5j/ILG6WmKs5U8x8Ki06ciBjYn+hXna/KyETs4wR2nRlda0J
         09jjt3rgawUfUHfPi3YZfyPfIvjzlwbLu98pBhknVINxsR4BsF/bvOzInWqTAkc4OZGj
         Bn63BOlYm41DEoMvLyhSEKC/Cxx8CichBm1zOEpNZhWpnrcGo/9IU/0OxFf0rOjypI64
         ulsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIY6sbQxtqzcwhCF1st8sw7k/ah5wP/HcEYANVd6wn2A9gNiBnigWHyo49jtUxRLzxBL5Z2yrxpicp8JdCfuOQgC6hdpIUBICq1HKr
X-Gm-Message-State: AOJu0Yy1zI2kpS+vbu/G09/ZczxqYbLVpyMMuP+K2/+LbBV2pv2auRFA
	JoYaOnnY2YSbUgpQgXPWti1RqpOdiWh9MNNe1KaePBBtXrXHaRfzUIOiQlBXG4o=
X-Google-Smtp-Source: AGHT+IHJ2gbnZ9MnnVvT5DXlGW3ZTzM+KRjQJdC9cAu2KH49RjtR0glNyuPgGWfqlYRnvMKuLREuzg==
X-Received: by 2002:a05:6512:2c9b:b0:512:fb30:aade with SMTP id dw27-20020a0565122c9b00b00512fb30aademr3725265lfb.3.1710135921306;
        Sun, 10 Mar 2024 22:45:21 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id hg6-20020a05600c538600b00412c8117a34sm7713946wmb.47.2024.03.10.22.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 22:45:21 -0700 (PDT)
Date: Mon, 11 Mar 2024 08:45:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tree Davies <tdavies@darkphysics.net>
Cc: gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com, anjan@momi.ca,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] Staging: rtl8192e: Style guide Renames and Macros
Message-ID: <4d4a3566-4591-434e-9226-f3d41a364531@moroto.mountain>
References: <20240310235552.4217-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240310235552.4217-1-tdavies@darkphysics.net>

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


