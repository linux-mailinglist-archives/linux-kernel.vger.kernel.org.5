Return-Path: <linux-kernel+bounces-123432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C7489088A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA97C1F256D4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3FF137912;
	Thu, 28 Mar 2024 18:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4G9dBqz"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CDB12F38B;
	Thu, 28 Mar 2024 18:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711651645; cv=none; b=YPUb5TvhV1En/k0PWbKx/P7NB0otHWGSIPLIBrkt0OGjqdreDZS0aLkeUcSJ5qcHDVyjiNC1msKraC6TZ5AwMA/KPrMrE0GKpZpY17gLsm/6PhMDvxqvj4qpmtH0hIe226KgdG02+du3UUDodn9Y8kc0b/swwGLoqrSfv6boVOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711651645; c=relaxed/simple;
	bh=hZcpotxQXgYZCgwQSFwHplGgALMDuSMOW4BVWfQ6+9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RYO7AwZDd+GNvp840FdueHs2f23AnPWDR56QOwvhWdRfVOvdKx3KjFs9bHB2P/QUU0O5o6B+tdrzB5pB4gKNoedjCTIcoLgNjy/0SRj1yMMw/STTFfPmnR1NvggfOdqC6SirIyuRErfQcoACgCa6YS2GYNOISrJUisFgl87/PnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4G9dBqz; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-515c198e835so1461586e87.3;
        Thu, 28 Mar 2024 11:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711651642; x=1712256442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZcpotxQXgYZCgwQSFwHplGgALMDuSMOW4BVWfQ6+9A=;
        b=Q4G9dBqz7e2sbggDY9O4F6ocJJx5X6rzLXfROL8hznE8CyQ4ArbexBNeTJaI9aadiF
         cxYh9PtpBDsoWJM2lJYtwN4zdz1G4S/VnJ+2z4qZwX0+1DVMJDhDlVfEsHN+5WtRwfgq
         U0dZ5YDAkMIiIPTQnyTzoYOzXq1xyohdABR9omRQpZa2q1Dry94h1H/8daIDnV9T0TEe
         z6ZMe4c2/i5ghUiNamgAm8zkRNZMuRmiFFxearlMQa8pnYFqj7Q0erNXkV2w8TqJ454G
         k050g/6SPx37eZf8pDopL00BNfmkerBGURexYxC63U3aBsJO3GcFek+10+QZee/mWCrb
         4NMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711651642; x=1712256442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZcpotxQXgYZCgwQSFwHplGgALMDuSMOW4BVWfQ6+9A=;
        b=g25mc07Wbq3T8HqdnTWWOPIqfGgw5LR2nbVbmwputEkseE1zJBT0ynAxXmA05kB2BL
         mvILNCsDbzuPxNbMO/nP4Xe7L58nP9CxAM3P20ARb+H2XFUNT+x0T1y2GymqAJpJ/5Bo
         DcTuP5Cnslc3P03JllX9OEgU9ACN/+4FPAlYnoRN9KHo/PfoeZbTRnFIpjgRCVt967I+
         VCH96RUbMhCOwS5wk5SrFZr+7k8j/JyrHX74LU+lR4eiQ1mBl+zV9FDNaZ1lZO++U2Fb
         QgtMB8SUYLlamCptDMvpEuzUFQXIKtszg/5jRj9HUTIco0vEQsCWVUEuQrzYokKDB5FJ
         Viiw==
X-Forwarded-Encrypted: i=1; AJvYcCWKwzrvcofoSfRJOG6USz3EG9XzRLgIucD109IohV6rck6I1Xo1sHGlmk0e8tcm6Y+6pnavljJZ66evg80N/uF8I1fSBFCa2mKnLukNnP6jH4wequWNsTvvXqd6ftr4DYvph+vYuBDwB6E=
X-Gm-Message-State: AOJu0YwDvmWfE4CO/Yqd8EleD45BepLxXbKztBGJYMISLw3nzKZE9dxU
	GmN2d4UVnXonPzpJkWbgUollL3HMvdJbdmunRIlsyyD4x6YBI92qNCwfhkeh+dzDi4FuqiZ3s4x
	BVORaSE88IIX3Jw8r2vYFDFB8Q9M=
X-Google-Smtp-Source: AGHT+IGrUuWiVBRFGJLa2HHSOZSFA2vD/h9fV90E+9dmixoq6VsYE1/GCZtKZYQGR4OnS8a+gJ8E+4yj5f4ATtiXG7k=
X-Received: by 2002:a05:6512:48d1:b0:513:eac3:9f7d with SMTP id
 er17-20020a05651248d100b00513eac39f7dmr199474lfb.65.1711651642040; Thu, 28
 Mar 2024 11:47:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322214801.319975-1-robdclark@gmail.com> <1Wwj_q3RYer6np0Orz0wJd9dlF82iBSX-PIVSlhCgJbpfVBMHF_CF04gHojkvqnvz9NXH6kACZGXQG9yXwtkbjIzLmdi-GNDkO5Nz2E-J9Y=@emersion.fr>
In-Reply-To: <1Wwj_q3RYer6np0Orz0wJd9dlF82iBSX-PIVSlhCgJbpfVBMHF_CF04gHojkvqnvz9NXH6kACZGXQG9yXwtkbjIzLmdi-GNDkO5Nz2E-J9Y=@emersion.fr>
From: Rob Clark <robdclark@gmail.com>
Date: Thu, 28 Mar 2024 11:47:09 -0700
Message-ID: <CAF6AEGvUsP7fjqFH9Co1vE0ZGRmMXmFBCrNc3hCQwxky3mME3A@mail.gmail.com>
Subject: Re: [PATCH] drm/prime: Unbreak virtgpu dma-buf export
To: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>, 
	Dominik Behr <dbehr@chromium.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 2:15=E2=80=AFAM Simon Ser <contact@emersion.fr> wro=
te:
>
> Makes sense to me!
>
> Reviewed-by: Simon Ser <contact@emersion.fr>

Thanks.. any chance I could talk you into pushing to drm-misc-fixes?

BR,
-R

