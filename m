Return-Path: <linux-kernel+bounces-128988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E039A8962C5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D381285993
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4A31C2B3;
	Wed,  3 Apr 2024 03:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y0Lo2DMB"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133F61B950
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 03:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712113732; cv=none; b=qEXJTjRyfOt1+6af3sDQCwJROALPezEJkJ7ytd5CnPNzplo448oNkLpaZeSsAoJr9nKcfDjnp1B0fSx2wgL6MW2HgDwejT5F262Cjdd6cAzcE4AZ2lA6jLP1+Tm6WZ5/fQz03tBWWl5JCUXdSx1M8GWzYuszenF7p8v1s/9OAW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712113732; c=relaxed/simple;
	bh=JNaloNg7IAffGuYznhJyHxVMJLnQeiWsK6eJCMSM1lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ASKiIHliOdeLjuQWHnXjtCVXzw36hU0MGj3rbkFISYxu1Z1puL8Lzk8FCNYV5aKffoDkdgkRagrM6ZiDp9+1WKE0OuYquJ41EloCaKKbnQvgKRiUlZ1FVg+wHoGJfUQgpsHBduQ0vPAK7K7tg2kw2/KzZcxtIHvSuIL107nqT2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y0Lo2DMB; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso5538562276.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 20:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712113730; x=1712718530; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SLZyQwWsOZDMsjJgKKASz9enfm362tPeU6p67BPPPcA=;
        b=y0Lo2DMB+RHXQVqn5l7qJxzM67eEoMfTLlb8T1sKG+VsZRT49biWUCwWcKYdTK/v1+
         KswUEa+ylsVuyX8/kIVx2YVmOnqKfuBl1IOBWMZ9FIUriAQA+7IL5bFtSKqUZqxdl1Cp
         yBFV5I6z9Qm6AA6jY4pCQVc/KkNRxhypaB9y4M5WzaZo+Vx+adB3KhqviG8f1Wh6r+Kc
         b0Q4IMrLTkU+qM9pifGelxuv/+UZtugrL33sRTxUPHWkqFurxBF6YK3fOKLK2i4eGUNn
         FBjrI30NzO+bSXsNXFg+OZLbTAjOOSN1cwKFtFrvo0py+KnDANtLpQRtUiOtnHa2RQpb
         baqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712113730; x=1712718530;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SLZyQwWsOZDMsjJgKKASz9enfm362tPeU6p67BPPPcA=;
        b=SGR9VLE+PhbfZsaZNiczXO2OlQVxZ+2NxyCVaRvyDNwHz+R6bhrVK/GdNFXrhGvXgZ
         BdjogmajEesUtR4ZPVc51jbr8A78l49lUANGwDT2XSOhXp3RjSjnNLNFgCA7E1JimUnR
         Qk3aMW3nkr33WevFVAKrDqDtHOTTDwki/lLSiN+xH3DYaMdptKACeJGbMdR/CccnEwll
         p2pFkQQvNV72ciZMRLVGSmincAnOwl8RkoPfGswx0BHocv6/+1ewXcRvbnpS25aAqG8e
         Nb7KOlK9UUaDcQrjQKy6cE6XStC/Rp3KyS5/bc/f4xZtS14e8e9iNm3Y/A12cv7AAE6i
         obZw==
X-Forwarded-Encrypted: i=1; AJvYcCXxoptrzG74fQA0tJXNYb6axrJTaKKjLuO5hQ+t4NbcnEMkq/+xF6OJB5jImSuaPr80bHsVDX2MJmvc1NSbdaNtS2NWCxtNRpvrBBYR
X-Gm-Message-State: AOJu0Ywu+YQsaBekJiU1qdWe0ggtmbDRaclPWiFOL5Tqjkz7N19lTTcD
	EAiLji79SK+HdWVlPDXcACHCzz96gsronAJPn+EP/WcqYruK6S3YTEDNPoPy2vT1V47eMZWNXOD
	qut6Na8uCl7OLJVCxnzwwet5DUDNo9rtVHGui/Q==
X-Google-Smtp-Source: AGHT+IE9EKkUidiGL+XeA4Jbotmjrpuh9J5aIMY1ZE+6LKcfeu03OjvrZFEzBWZxBUNuUXBXoDTkhOq3x4vkxpn0sWI=
X-Received: by 2002:a05:6902:82:b0:dcc:140a:a71f with SMTP id
 h2-20020a056902008200b00dcc140aa71fmr11987883ybs.60.1712113730070; Tue, 02
 Apr 2024 20:08:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402-pmic-glink-fix-clients-v1-0-885440b81c65@linaro.org>
 <20240402-pmic-glink-fix-clients-v1-1-885440b81c65@linaro.org> <bnxrstkmjmmbhzrqncfwwnxa5vpx3ioysykqr3sbiirlatneu4@vlewrjturppo>
In-Reply-To: <bnxrstkmjmmbhzrqncfwwnxa5vpx3ioysykqr3sbiirlatneu4@vlewrjturppo>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 3 Apr 2024 06:08:38 +0300
Message-ID: <CAA8EJpqkU2bBwkdW5aQ=ZKvPBoRWaxFVQAxmg76zhLQqV4C-UQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: qcom: pmic_glink: don't traverse clients list
 without a lock
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 20:56, Andrew Halaney <ahalaney@redhat.com> wrote:
>
> On Tue, Apr 02, 2024 at 08:07:06PM +0300, Dmitry Baryshkov wrote:
> > Take the client_lock before traversing the clients list at the
> > pmic_glink_state_notify_clients() function. This is required to keep the
> > list traversal safe from concurrent modification.
> >
> > Fixes: 58ef4ece1e41 ("soc: qcom: pmic_glink: Introduce base PMIC GLINK driver")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/soc/qcom/pmic_glink.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
> > index f913e9bd57ed..c999358771b3 100644
> > --- a/drivers/soc/qcom/pmic_glink.c
> > +++ b/drivers/soc/qcom/pmic_glink.c
> > @@ -168,8 +168,10 @@ static void pmic_glink_state_notify_clients(struct pmic_glink *pg)
> >       }
>
> Does pmic_glink_rpmsg_callback() deserve similar locking when traversing
> the clients list?

True. Will fix in v2.

>
> >
> >       if (new_state != pg->client_state) {
> > +             mutex_lock(&pg->client_lock);
> >               list_for_each_entry(client, &pg->clients, node)
> >                       client->pdr_notify(client->priv, new_state);
> > +             mutex_unlock(&pg->client_lock);
> >               pg->client_state = new_state;
> >       }
> >  }
> >
> > --
> > 2.39.2
> >
> >
>


-- 
With best wishes
Dmitry

