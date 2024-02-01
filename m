Return-Path: <linux-kernel+bounces-48233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF478458E6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422311C22941
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2742A5B680;
	Thu,  1 Feb 2024 13:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="hGvAmb/g"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C68B53377
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 13:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706794180; cv=none; b=SgAJEegpPHZ0qWXrEhGBb23OSoFXAwPHzQ8/gBCjQe4nfb6r4Q2u4N+5jrj6sytl+O2EKJMJT+6dcNFLJuZjhlJ9h84l6mrwpv8MVQRBVGkj0kXk4B3keFuMwDqHg8hY1Ax609He9Kv3VeFqPwL/dq9a3I33iyUkKFfUp+GRL5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706794180; c=relaxed/simple;
	bh=0VlpjAp2SlS6JO8lIERx+7gJSJn9Jh0iF1Fda7ZpJl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOM2HVx0ClvYitwcSdzZLPIToW7EICuBK8Lvbo0NR10exHve8ocljnXN/8NcSFSKOyVJ5SUF1qQ+B2qxHnQ5Y7yuB4U7bI3z6x3FxkT9P0Jbyro5GuW3iCbMkgJ7SkNMEQ4nhoVCcccSBm1h2nyq9plgyix12b//iyyc/kbpFX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=hGvAmb/g; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e7e2e04f0so8436985e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 05:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706794177; x=1707398977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U/BeW2cpD6ru893hI9+7SCo+Mu2PUKhC7M124bcVy9o=;
        b=hGvAmb/giJyhmJNTpbzjdAfxpQCTySpnDqivFnZB6oJnWV3zKqZT575HhehS0+4ObE
         WCBkKBEjLWCG4Deklyn5/W9nmsQ1ttEXjB1yO/wSLGKBGMBxRyopOWplNXNmap0uItui
         RseNnAulKBPmDQdplkXwdw68I3kO1t/ZQ/mezekLw8Dzal+/W+Zz45B7+Xlsw/WsFhuS
         eU8uwtpoc8FEgy7XFdk5UAtcQym52BJMjCO2lihGS5NviYxPgzzjfuE5sq4eygZ2mHLG
         pjrEk7ZDanSmBisTVE35JyEpkiP8VAPg2wDH3Aq7wUvqws2k2oaK7JTyM9ubBDGVigku
         BzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706794177; x=1707398977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/BeW2cpD6ru893hI9+7SCo+Mu2PUKhC7M124bcVy9o=;
        b=Q9kbWkP1JIz1/QGU0PZi1Stb7+fq8b5RK14tTotCCRJvBcQ6BEvFxgQBPmDtes1kvk
         FP3qrvlNy+6tNWIHc1o0R2HjL0quRqnng3aADq22mwHYk7aRakyf2PerKd77oQgOWD0X
         fqtXzb8fG0QnAccPepDRMtm4rJs7PM4mp1o/KYW+yaqapRk3VNOoToQTKF/B1xylF6uY
         h2PylEdQyD9BR30U6OpHxw3z1Y8/+RFj4xRJ4+mM7v5k0XzDFoeczEZrT1Z61nLhD9dG
         rtq6K4z8MqQiEkJH9Waje5RS8O71/7htEO1gWtbkXU52N1PsC+Pta5l+78X0SmlRaZ7y
         HbyQ==
X-Gm-Message-State: AOJu0YxE0UC5YMWzZmMjuIEplijMio/g3Zy9/2We2LbsNLSMFGVAgiCt
	Y38spWc5jHfCy9L6eaVhI7kWxQxXMbsZJNbvv1tk6BF9K2aWU4umEbyhk4L0+1k=
X-Google-Smtp-Source: AGHT+IHTRa1UkwVXGtyRAPyEYRC394xx5ZpT6FMzICUv8VeevBMItX0RaZRIZAMscJ09ZC24gAP0QA==
X-Received: by 2002:a05:600c:1516:b0:40e:c564:a9ea with SMTP id b22-20020a05600c151600b0040ec564a9eamr4101212wmg.20.1706794176729;
        Thu, 01 Feb 2024 05:29:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWDtk4SiULsmGF+rYf4Ndm8X/2G7bbQWGi6mFC737BjNIjXl7rA9UYaCnA0biIhIHyDSSF6jHdKCcBhLjbrvGJiF+ESnohW4ELcRpT82/+uHEI6GiwgcVB4/+Nne1dK+sPDnCE6qny7FAQOo1fG4cheYOiAdq/bkKQpmaJns2FT1HUNTE/HWQ1JuyjJoTA5Pua4UAUxKhbw98JaxWFDymo=
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id az28-20020adfe19c000000b0033b04f7585dsm4272369wrb.3.2024.02.01.05.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 05:29:36 -0800 (PST)
Date: Thu, 1 Feb 2024 14:29:33 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: Chas Williams <3chas3@gmail.com>,
	linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atm: idt77252: fix a memleak in open_card_ubr0
Message-ID: <ZbucvTJswt41cpcI@nanopsycho>
References: <20240201124108.3052635-1-alexious@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201124108.3052635-1-alexious@zju.edu.cn>

Thu, Feb 01, 2024 at 01:41:05PM CET, alexious@zju.edu.cn wrote:
>When alloc_scq fails, card->vcs[0] (i.e. vc) should be freed. Otherwise,
>in the following call chain:
>
>idt77252_init_one
>  |-> idt77252_dev_open
>        |-> open_card_ubr0
>              |-> alloc_scq [failed]
>  |-> deinit_card
>        |-> vfree(card->vcs);
>
>card->vcs is freed and card->vcs[0] is leaked.
>
>Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

