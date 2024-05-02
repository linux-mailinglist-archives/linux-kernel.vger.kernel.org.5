Return-Path: <linux-kernel+bounces-166038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0FD8B9513
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B76951F218C6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A08200C7;
	Thu,  2 May 2024 07:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X0q9sNLd"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637F02032D
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 07:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714633718; cv=none; b=YqgXbSIqCE6VWg4Kyc5i79mdQiYt+vw0FZb1U2Bs3RvIVV/ng13R3cSyqsRQqeU910wtnH6QGKLMsoPir95lRZ2k77d2GXL2HJ1eEu2bB0UZqnnh6iKs/WlNYVz/JRIEmbTwbPUlUgcOAS5UFd0p7Y8H4yCiyOTCv49HIh3lsJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714633718; c=relaxed/simple;
	bh=E/JYmqvpE2HASs6arYE5LbOOv0IH0iOwjjlIdgyafdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzJmIN5WFRhxWGg2rEJH7w3GLa0OX26ZAePc2EabW9F7+rAwm8QC90e0iQfuDuqqbkIGXSI5lPsl28l/z+wdT/FrNRi4y2d8NxIi8Hl3Zl5XH++PBrpWeT/IdicBL7AU82mrQaqa/uR4ZIOnothXgg93VXWNahH4h0Opn/B+w64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X0q9sNLd; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51f0b6b682fso627752e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 00:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714633714; x=1715238514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GcpO4YIhi4cMr/3aRrZ2Ono6fZHeRtd6mWwLqXNR7eI=;
        b=X0q9sNLdjwTzcKAbqDVccGO00VB2KjvPN/6bo5QeBiA9bScpid2pp+F8xtWTtoM+a5
         IGkCUnfvuxXln6V2reu/jBJWliy/sGDHgAqQF2E/TisJMwqjY1IDhSyY/OWfxvjNWUI7
         HlK+oaOKJqugMrQ6+hdBxV5U3kZd2IT90vwrzERSJcI3R/KLL5vQxd49nEH5+zUZqCgN
         ohaSdCncegxI2hSDABKQbk+25CICMzm3lbOEvQHdvoqzepc9csZ/yRBSkqmnc/k2r48V
         x/n7MLGZMOgz5D+GPc5iiKqbzJVL84Y1pulinTHEW7RYBJGK/Io6p+oDWb5w743ZTVB8
         ScTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714633714; x=1715238514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcpO4YIhi4cMr/3aRrZ2Ono6fZHeRtd6mWwLqXNR7eI=;
        b=saljCeg1UeF4e+P93E/H6lCBImkQMkH58jwxXV4K50ZQ6bq5XA6OPPTEHyRSh6n38w
         DcC7WMaSLvWmSl9YhlyXAuH4XJl1QSdC3GP2RdTcGbkrY3IId324N/omi+3cB3uNuy4P
         kY5crkA39Kddux3q6RXDhRZ+5TwrX7C8h6nqRJGGARCBIwtIbGiPvjzG9SJ5GqCSTD7d
         jKqKrlD5IbvsRv5ooVWi+2bVhEO6jEtHz2sL5JgbGul+InEInGLXRFN2HMXTvJNKOGI/
         /xSltx3Cpuh7buwKx29r6W8mgZp0QZGU3bE2Acw7df53luGfcXAO46i0PUiajpaBqu1t
         wgpg==
X-Forwarded-Encrypted: i=1; AJvYcCVzTuV0y8/eBAugGZvuPtN3LG4mSCKBCDeUeWuOPZv6bjY3O3jSs0Sk2iopDGMw/4rGai1xjvbQxl6HMrtNgoBk8YmsHBBkKv5r+Kaj
X-Gm-Message-State: AOJu0Yz4/sAkZM+OfbFQqM+8j+MkHtqOfMj5i1GWUTOisl6sUyBo8TOc
	bhs/Ypt+a5uujIGwUn1Psv/K9c26GQQ4ZQcM/4xsdJ5kI3D36xenyQIn7mAxEbY=
X-Google-Smtp-Source: AGHT+IHfGC5fb5+xzCq7HdQyG0wydAOHQEnT2zQt/yt7dSkvzBCJ4sIL9rZ6EbjnuOTX3Q9XLS3ajw==
X-Received: by 2002:a05:6512:20c2:b0:515:d1a6:1b07 with SMTP id u2-20020a05651220c200b00515d1a61b07mr685682lfr.15.1714633714220;
        Thu, 02 May 2024 00:08:34 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id b26-20020a056512025a00b0051f026412b5sm66082lfo.141.2024.05.02.00.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 00:08:33 -0700 (PDT)
Date: Thu, 2 May 2024 10:08:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Abel Vesa <abel.vesa@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] spmi: pmic-arb: Fix of_irq_get_byname() error checking
Message-ID: <dba8658a-f13f-4fde-b610-57a391b0a1c2@moroto.mountain>
References: <53c31752-c8a2-4098-837e-2f84f03c8748@moroto.mountain>
 <0d26a80d9b595954aabd8f6c6e18c710.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d26a80d9b595954aabd8f6c6e18c710.sboyd@kernel.org>

On Wed, May 01, 2024 at 05:55:03PM -0700, Stephen Boyd wrote:
> Quoting Dan Carpenter (2024-04-24 04:42:46)
> > There are two bugs in this code:
> > 1)  The "irq" variable needs to be signed for the error handling to
> >     work.
> > 2) The of_irq_get_byname() also returns zero on error so change the
> >    comparison from < 0 to <= 0.
> > 
> > Fixes: 932282f154ac ("spmi: pmic-arb: Register controller for bus instead of arbiter")
> 
> Sadly this isn't stable because I just send patches over email.
> 

If you're going to send these as email then you should fold it into the
original commit or otherwise people will be confused.

> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> 
> Applied to spmi-next

Thanks!

regards,
dan carpenter


