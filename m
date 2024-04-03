Return-Path: <linux-kernel+bounces-128903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 351C48961A5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6457C1C22682
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AD2E554;
	Wed,  3 Apr 2024 00:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BjBHlNMs"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489E928FC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 00:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712105478; cv=none; b=OvAWo/VaScUgqjW31QbGjOcDXCZBWv6CuqpF4TJSymU1IAM/Q+z8WTYD9B1lXM660F1W02ASka8kVznNvFnUaz2Uavx9vohkNhpUuksBd6NGP9heSDswsEFF0Q8gVLWHzxeNIe3Esi6szgabSBqSU0FmV4AgAuYlK9Z4jeLaoCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712105478; c=relaxed/simple;
	bh=qTyq5Gw+MhcMN5mTb2IXkM6rqV32gk6sroaiKtJGkXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4dibpjEFPADFgmG/yfD0FhIJoGyuYrZWX2G4pbrhn7Ufw1mjJUz42uSHXpK4No1q0g66/9qpsyGHMvQzEUUmWEVV8PuV/fJs+L4eytGtPYivRBStcfjKeHqqqd0OHbzoL78hlIhUD2I7nH+wbNtwAfgJesg0IyEf0ufsVl4TaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BjBHlNMs; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-513da1c1f26so6989008e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 17:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712105473; x=1712710273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GWHRA9QpgbMHjxrXRwpYcGFaFTNivreKL1s0uQUDObo=;
        b=BjBHlNMsuKMrPTpm0v3kZcg9ARBBmXcwaAhXvRZdJ/RlZpd1kLWSDy1Pgtup6Hqm42
         GTNAYY9plzVREjRPNW+vX7UYjzryMjOQQdo3Pj/+phPhVdN5ivwKhdE4zftnX8nkonJD
         nMLML37UqMl5UXZgjB/UmCltjZaLA3UP10g/TyyZTJauxAve6AdGhcpN8pS9m3L7NqZy
         /beLeWRXSKeR3gbQqw6Qw895/tkOlm0Uk70T3td5xuJFnPINBoJ6Bn3gKSCB3ZsNlNnZ
         TxEDgUqFo2VTwGWZCuTWIWQz51dJDQbvSFj5bwYzLOSpPiZCiBnrptq62e9+n7VrhsyM
         AZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712105473; x=1712710273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWHRA9QpgbMHjxrXRwpYcGFaFTNivreKL1s0uQUDObo=;
        b=gcss/dojN2+KgntvquZuOnWYWJvnTYksGakdVZtThUJcLNtpqeQ9yrZiWWEJWdBAPH
         TUtepHSencdZ1if6LM2b+fURkgeFa7y5ku/6ybKBD7SLPlyzTEIW6P/UQmn7JcjzWkHU
         amknnYLUSzaVb9tzEEX09FSfdfbVet0UjQXIUTQLfbJL6Xgv7buUICc6dGI+Tt6vQ6Wc
         gNG/XUz6yT5gKaWr28KWZwcwXYRNDHPVXrQPbqma5kGdmbvrDGm9QXNAUVUoJ5oFA8CC
         79adqZXW7QsmGB5EB2C36HStSDCJrYvPhjmcNwi1cZE9NQ5R/VkuKngDcf9jkVALkBYj
         bRNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBohjwMF4x03QzIGLbny7R5LQzLhMyNRpoQ9K9tfsiBujCdIM5yELOG+QfxryYX60eBDtV9pU8ZjIrVRUHfY3+Ra4jsqBO2YWjhtOs
X-Gm-Message-State: AOJu0YwMpOH93CJfHzva2/Lzdkspsw/68bdL+bkZZar+NOd3s1NqZit5
	v+n8zvnGSokPxjrapHT8XOlvq6xeq8BczQNEvhNfQxnD+bFDzr+llRld6OVqXFg=
X-Google-Smtp-Source: AGHT+IFdYWW/kAAnQoA5IRo9Tv52gkqmNbWMJpe/JRsfmA/mRxHEpRhzCrfHlRnsuqaCYtAolee3xg==
X-Received: by 2002:ac2:5631:0:b0:513:39a0:1fec with SMTP id b17-20020ac25631000000b0051339a01fecmr618732lff.66.1712105473384;
        Tue, 02 Apr 2024 17:51:13 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzyjmhyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a00e:a300::227])
        by smtp.gmail.com with ESMTPSA id f8-20020a193808000000b00515bbc2feedsm1907527lfa.102.2024.04.02.17.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 17:51:13 -0700 (PDT)
Date: Wed, 3 Apr 2024 03:51:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Caleb Connolly <caleb.connolly@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, 
	Caleb Connolly <caleb@connolly.tech>
Subject: Re: [PATCH v3 1/4] dt-bindings: panel: Add LG SW43408 MIPI-DSI panel
Message-ID: <odtd5tfurh4kkhclsi3zmumrucmiz3jpqsukflbsvhmgvtyehl@bobsiymwtsys>
References: <20240402-lg-sw43408-panel-v3-0-144f17a11a56@linaro.org>
 <20240402-lg-sw43408-panel-v3-1-144f17a11a56@linaro.org>
 <9fbb9058-ccfe-436d-b413-b3ba27e4e5f9@linaro.org>
 <CAA8EJprwWd=ZtwnpTm3cVP8RBEqxCcSGyBu-bHj=iV=+X2=FyQ@mail.gmail.com>
 <t3cx5qxiteer27vsvysizbrxkbamxgrcbn2oafisodjopwas5z@nxlasb4rlnml>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <t3cx5qxiteer27vsvysizbrxkbamxgrcbn2oafisodjopwas5z@nxlasb4rlnml>

On Tue, Apr 02, 2024 at 10:59:11PM +0200, Marijn Suijten wrote:
> On 2024-04-02 10:23:22, Dmitry Baryshkov wrote:
> > On Tue, 2 Apr 2024 at 09:31, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > >
> > > On 02/04/2024 01:51, Dmitry Baryshkov wrote:
> > > > From: Sumit Semwal <sumit.semwal@linaro.org>
> > > >
> > > > LG SW43408 is 1080x2160, 4-lane MIPI-DSI panel present on Google Pixel 3
> > > > phones.
> > > >
> > > > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > > > Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
> > > > [caleb: convert to yaml]
> > > > Signed-off-by: Caleb Connolly <caleb@connolly.tech>
> > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > ---
> > >
> > > Tags missing.
> > >
> > > `b4 trailers -u`
> > 
> > Excuse me, I keep on forgetting it.
> 
> Does a similar thing exist for adding Cc: tags for all reviewers/replyers to an
> earlier version, even if said reviewer didn't yet provide R-b/A-b or other tags?
> 
> I'd like to have the next revisions in my inbox as well after leaving
> comments :)

Unfortunately I don't know such option.

> 
> Thanks! - Marijn

-- 
With best wishes
Dmitry

