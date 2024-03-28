Return-Path: <linux-kernel+bounces-123573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5619F890B38
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAE841F25FC4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6C713A41C;
	Thu, 28 Mar 2024 20:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkYuNZhr"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440B014265F;
	Thu, 28 Mar 2024 20:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711657077; cv=none; b=fgEn3gZtyyXLodiQKCXLH5M9JyzEMpqh/bCkWW+ug8mQIJNmxLwHLhkCuc463nhoobMDNoEpSS8kQ70SiA69YMoWCxNYS1WaPWogFsd6MOI6nhvYH2Gfgf/ZUoAaEyJPuwLWtIXKSvGfYkD5jMzpLr34NXadhy1M0F349UutNdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711657077; c=relaxed/simple;
	bh=9jYHvj/0a/yHqut5NhaqVyMqutJHLvv2Ne7s1n0MDn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFf0nubeL0AwpF/IklEFyFvW9+9gdMml8F7kfGAeVaOpxQjRiC5NwT81Ehb0O59yfO/9ZTvIKBfVtBv/LXqG+bkDKYuNaGIio2Gqe2kQLelN+PwqNECTU9M+auQpS3mzrT/rNphFLYMwnL+ukp64Smeox0zuw2lv678O8vKL8AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkYuNZhr; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e0bfc42783so12571685ad.0;
        Thu, 28 Mar 2024 13:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711657075; x=1712261875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nEayUKz9gKaOZC4X5AV80mwdg3zyZD5G0L3PubFSTFo=;
        b=OkYuNZhrmbLKklSR7dNY25GnY5vV5LmFstQgyDJTbIHdIQrNEWmglY+T5BMK954Amp
         xiJCjwCKI8/wWFXp/tYMuhHkYVx1nrvy49WdZr0QuyclNV7aHJLjI0aqOblJvJuIEXgg
         jp5E1gevsiXqfrELSilL9lm5XlbRBLt+4gP01Rpnk/xW8wL7rGBG4VrABemXdpqyTghM
         LMU2vRbPaY+WCZSENuLeo/JutjHgO7MWpvZ+AITEwsfgTbAmu+E91gPUnpWaTD1kGy2N
         bMUv0Yacnp4vYL0MxLMdsI6XZx5PxopvPrOJEpvOorICKX52pUxxvJ24WdCtrUCUvftt
         60Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711657075; x=1712261875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEayUKz9gKaOZC4X5AV80mwdg3zyZD5G0L3PubFSTFo=;
        b=lu8P5QGFchgahQV1oNsHoEqGaJ4+mVMDkaaMgPC0KwWw2FumeXG+6/jxQmMVSwyoi7
         SS3JIbjB+6XGZIHFvn2p2ecvxGu5bwk+RLPLR2hMdLWoaqa/qVuH6vqJDJgYbVaPFi8X
         x2DHlf5DIGrDWL1xPCOZV4bBM4fK4t47DBVpaekNfkf3aJ32Z5EhCaRLyNiiqsrmb3Wf
         e8mQcqQDqLmyFwFvV9dyLdFdv8HPbI3OLziXNbs3QgzelQ6GmwCYy8FVchbthxFcEbej
         7z3FGegzgkmlr5Z5jcJGN2Z8v1YfeFwQzs1JOrgm8Lfe6Rm06rk8t42kcSi+Mqu8G3Do
         65Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWP2afHBegpe2vRiZCt4Snwy5+kMIX15f7WH8wBlCkggt4LS7ybz3H1fVW76CJ78n0nD8RwcpH7z/8bwZ7vhtJDq9v8Kt4UQT4cOgFKlt6rtKRSWTuWNPK1z3KiOTuFGCfVjM6PnCk8qVRNcFLLnrdLvupqfgCTRIPpWlPE9Qrk/7wZfiWz/FzMWQGkEucxNJhS/eo+YpE14MOKaHA+4EJl9D6C+PxHutWFsWK8zjoyeuJX5O5bWMi8vBuRFw==
X-Gm-Message-State: AOJu0Yy5Ci2Z6FYWGbWdqMVG+3l7l8PWuoEwW/+l+V/7OkI/4Blb4dPN
	2PAlekdab84rwGQSzcnk8wa83eu7NG8udZU5biSRXuTdHPEpJ3RHYrUsyOB9
X-Google-Smtp-Source: AGHT+IF2rPO6hFqFWtIX3SdzDeOGVa2ri0rsD7VKNpG6/c1HmD1Dag/mcKtYH3XvXNUZLF0lzYTQIw==
X-Received: by 2002:a17:902:8549:b0:1dd:7da:e0a9 with SMTP id d9-20020a170902854900b001dd07dae0a9mr508604plo.69.1711657075433;
        Thu, 28 Mar 2024 13:17:55 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:493e:82a3:49f9:d88])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902b94100b001dd0c5d5227sm2022519pls.193.2024.03.28.13.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 13:17:54 -0700 (PDT)
Date: Thu, 28 Mar 2024 13:17:52 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Corbet <corbet@lwn.net>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Support Opensource <support.opensource@diasemi.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-input@vger.kernel.org
Subject: Re: [PATCH RFC 1/7] regulator: devres: add APIs for reference
 supplies
Message-ID: <ZgXQcGlMiewRzki5@google.com>
References: <20240327-regulator-get-enable-get-votlage-v1-0-5f4517faa059@baylibre.com>
 <20240327-regulator-get-enable-get-votlage-v1-1-5f4517faa059@baylibre.com>
 <ZgWw66OpLnLPdCn-@google.com>
 <043b347b-2652-4ffb-a8e0-954a89899ade@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <043b347b-2652-4ffb-a8e0-954a89899ade@sirena.org.uk>

On Thu, Mar 28, 2024 at 06:18:32PM +0000, Mark Brown wrote:
> On Thu, Mar 28, 2024 at 11:03:23AM -0700, Dmitry Torokhov wrote:
> 
> > So because we decided that we could not have devm_regulator_enable()
> > because of (IMO) contrived example of someone totally mixing up the devm
> > and non-devm APIs we now have to make more and more devm- variants
> > simply because we do not have access to the regulator structure with
> > devm_regulator_get_enable() and so all normal APIs are not available.
> 
> I don't follow what you're saying here?  What normal APIs are not
> available?  AFAICT this has nothing to do with a devm enable, it's a
> combined operation which reports the voltage for the regulator if one is
> available which would still be being added even if it used a devm
> enable.

You can not do devm_regulator_get_enable() and then call
regulator_get_voltage(), you need a new combined API.

> 
> > This is quite bad honestly. Mark, could we please reverse this
> > shortsighted decision and have normal devm_regulator_enable() operating
> > on a regulator?
> 
> Nothing has changed here.

Yes, unfortunately. We could have:

	reg = devm_regulator_get(...);
	...
	err = devm_regulator_enable(dev, reg);
	...
	err = regulator_get_voltage(reg);

and not multiply APIs, but we do not have devm_regulator_enable().

Thanks.

-- 
Dmitry

