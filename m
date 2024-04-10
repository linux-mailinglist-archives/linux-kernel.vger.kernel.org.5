Return-Path: <linux-kernel+bounces-138883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E914C89FB9B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D091C22A91
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8317016F0D2;
	Wed, 10 Apr 2024 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HCEe7uhe"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FCB16F0D1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712763121; cv=none; b=gTW3KRUoJQq284Xh/yYmdgS/MFY+bMH6TJBucMZ1JiMm7al4uqu5S/Gjoa5dxNpj1M/k2ZzNGratAmKTmAVMbJ6Q2vVWFUeKN98p3yBUOlVb2TJ105yT+x1myKUWU96MVcT1EAoXpdUjqjB96YAhnvKyogQbvORJvK6FCRoYPWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712763121; c=relaxed/simple;
	bh=6Vog+dAt2cAMqsPI+yh28GngocmuMJI+7wvR2qyxv7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQyrtuH3S8YHLV4lX7vyR7AaESAB4piY59TzGpR2ynM15NWKpgMXiODOLoBWbVC+5J+U5ug8jKFGXdIq5NvQDL1W4Gehwg97Z0RFh+oCHICnmSdJAP7x9rn6jhlvLSNJQyNXmUhoV3t4AfjHn1Vs7DxSJuB5rMJzEHHgOVtxKWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HCEe7uhe; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e56ee8d5cso5336787a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712763118; x=1713367918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cTPhvP3A5r7MS8UL1VvzFtK1xJvz3SKxBGHHR0/FSwI=;
        b=HCEe7uhet4O578NU7bREoB9lnXlswazrADXaijHRHIiiM43eEhpFQ2SmslgWH1lYXz
         36jEE735iRRtHxBb2PPWYQ80tE1r45Bu/lnxOYuC4d3aKTtK+/5twZhPSkmADwafhsSo
         zPWlRupNwHoy5osC92zpb+u363TsErKxqbWAH3BkwLLIR+Gl2wLc1jEccldxV0yaMLNj
         mCBQ89Nz2oHyyrQMI6ljL1GY9zsdZa/WSU0quaEGMoMAqQrgaN4yB9rp62h4R/re7g7k
         KTlXKjF7t0KXaNt/eV+Y9L3tcwvyZYBCPTdfF1IAwGuoFBYuU8cMenla6uOG74aDVAqU
         4yPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712763118; x=1713367918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTPhvP3A5r7MS8UL1VvzFtK1xJvz3SKxBGHHR0/FSwI=;
        b=wo0Fyky7DOftZ8sWbUBJNOMjOo4WxbPV8r1ilMOLWp+psXxuwefElMlNIEC1zMNAeD
         W/OujhdAdhYvk+UP0TLllNfIloqUHrI4ttbFQAsnDD8KFRJfI4i4LNpes/fHTJm0ZKQ+
         alPP1hsrTbQWMohOQJoTmmhsmfqPNNEc6loblhSMsiQtT5qhQaK9Xs8+IpWnjl8TbAbQ
         oMsKLyCq1WxYlKwZA719UVlXg/ljYUsbInNRPU4TqkbqYVTbY9qdPRfkXfK0Trkyh2vH
         hFlukIWxRTDEo9wBVqsLKyZiXgThsDf6owI1VNN2ZkHPTkdEyKH6B8Q74h7FNWJSGsKQ
         pkpg==
X-Forwarded-Encrypted: i=1; AJvYcCXNi9uoCgNzH4xcuQ0fGk+198bL2i5TXdt8kou1m6PLmxdJneNWhAQ3jeH78kcNNw6y0Q7P6g6VwWs/OzU6gtRmaRQseunNtMuG0R4D
X-Gm-Message-State: AOJu0Yxuu2GqDDoXcoF6ZmPdl4u+5kZgn9Pz2ELdphaZ12FbcehweFeG
	gpFEEAEATVXcO6i5X+BggtxYfNMXjWOfdSLxZPzEXafGZ+RzNEJZF82yfXSdfxk=
X-Google-Smtp-Source: AGHT+IHI2Ekpl25h0Yy4yKCuyZYB9KuHYXbJc3VeE6shatg6Hicrdayi5+NJC9iLQkC8NWx5z+JrZw==
X-Received: by 2002:a50:a6d2:0:b0:56d:fdb3:bcc5 with SMTP id f18-20020a50a6d2000000b0056dfdb3bcc5mr2136474edc.12.1712763118023;
        Wed, 10 Apr 2024 08:31:58 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id et6-20020a056402378600b0056b8dcdaca5sm6501104edb.73.2024.04.10.08.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 08:31:56 -0700 (PDT)
Date: Wed, 10 Apr 2024 18:31:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: soc-card: soc-card-test: Fix some error
 handling in probe()
Message-ID: <6aaca4c3-46c4-475a-aecd-cf471370e97c@moroto.mountain>
References: <2db68591-64e2-4f43-a5e1-cb8849f0a296@moroto.mountain>
 <c8e9a7a0-6fcf-4bbe-a659-b2360f5980d8@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8e9a7a0-6fcf-4bbe-a659-b2360f5980d8@opensource.cirrus.com>

On Wed, Apr 10, 2024 at 03:43:45PM +0100, Richard Fitzgerald wrote:
> On 10/4/24 15:22, Dan Carpenter wrote:
> > Fix this reversed if statement and call put_device() before returning
> > the error code.
> > 
> > Fixes: ef7784e41db7 ("ASoC: soc-card: Add KUnit test case for snd_soc_card_get_kcontrol")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > v2: call put_device()
> > 
> >   sound/soc/soc-card-test.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/sound/soc/soc-card-test.c b/sound/soc/soc-card-test.c
> > index 075c52fe82e5..faf9a3d46884 100644
> > --- a/sound/soc/soc-card-test.c
> > +++ b/sound/soc/soc-card-test.c
> > @@ -148,8 +148,10 @@ static int soc_card_test_case_init(struct kunit *test)
> >   	priv->card->owner = THIS_MODULE;
> >   	ret = snd_soc_register_card(priv->card);
> > -	if (!ret)
> > +	if (ret) {
> > +		put_device(priv->card_dev);
> >   		return ret;
> > +	}
> >   	return 0;
> >   }
> 
> Thanks.
> Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> 
> I can see that put_device() is also missing earlier in the
> function:
> 
> 	if (!priv->card)
> 		return -ENOMEM;
> 
> I can send a fix for that.

No.  Let me resend.  I'm sorry, this patch has not been up to proper
standards.  Also I should fix Smatch to warn about missing put_device()
calls to prevent this sort of thing going forward.

regards,
dan carpenter

