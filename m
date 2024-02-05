Return-Path: <linux-kernel+bounces-52292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E9F849661
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384801C22134
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D7E12E45;
	Mon,  5 Feb 2024 09:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOJ0Tssw"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B062812B87;
	Mon,  5 Feb 2024 09:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707125032; cv=none; b=r7COisJzI4lglTSE1lWO8ki2V2HmdBXDD04/IsagAcdUv9l5+XNdsIHtoOZdlzKgWFOK8MR17SpbPttHLNAILWoa2ieWENHGnX49o1qFl0LZtdDoK08vfBF8XiXSI4ovFyV3oyOA17FVeZ6ubz8q/QaJEmzG6Q/oCbxATDhWF/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707125032; c=relaxed/simple;
	bh=vesw9nReaEYQSnlpLEmp5VkPghcT1fv0nasGh3Xohoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJ6/GY7kNAjE0w5zO7+MEUY+p/lADCEjTd6pn83rjXnb93+oY6W8gNdro9G4t6nEWDlfMp7KsCwdgj59sZ9HSbZgkKJ2L0gq3U7AcjOJ3ojkROqbsEXGfIPMNRRD6DH1BcB6/qg9VsK7Y9H3oL5+v7Brycoeq5Gln4Vqa9DuO8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOJ0Tssw; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e12b917df2so2643641a34.1;
        Mon, 05 Feb 2024 01:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707125030; x=1707729830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eXGLtcAing6I+rqyu946RGS8G20QQw7klC67GhMF8fs=;
        b=LOJ0Tssw0V6uMHsq1dPnZBO2IA/QyGPH2G2BLW5hMiGTwvxeh2oF05odhrnR4UVlm9
         S0LWCdCNP+J4tAoTWm3qtYeFUjYhlxuaxhhXCdS9JYibEbPPmZk85Y4mrBaD/v0n2c52
         vGwWCszu91KYkDU3jb3jbnL6FDQEqDTVH9FmSBxSFd0svP4WWcwcjJ9VTC7Sp2CTz8so
         6vt13abQW9XmREbtx/Tz0LYVQ8/mwxb5oMg+g2l2jfgAxLNHJygxGirMi7yZVKCsEbR3
         Q/wpBn+xsoOG3mDlku4upwv4oEL4CUNroB+9HhmjyVuQtjCGl5tVRb1N6kOrxb/gwoAc
         Q2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707125030; x=1707729830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXGLtcAing6I+rqyu946RGS8G20QQw7klC67GhMF8fs=;
        b=tWNcLrbFG+dm8smZEMmmVigOke8lYoSYU6i/fpjtI4JCGHzIgySz6aUe/8JpRScBTj
         /c95tgNnXWF6DULTqeXTzKp43LzBsG6TPNnNxod9yt5B79m1UDbyHj9HTQriBYzfxDg0
         WlmixjyfpJFZsYCYznj+goT7CudlGZYRiGriE9F3IrjfRPlP0CvSBPGLq9v3sOTA8xrl
         +ujUJ0gIeWiRi8io5V4moWkPf7WKPjFD8PXpd3HDI+RSQSgW20hO2+BJUwLd2N1gsq4f
         lpymk75i79GCMD+0B0LtMMtyPleD2qDHlMr4qq7hxXgc/tioc2PRsLS+1L4lPzeR56H4
         R+9A==
X-Gm-Message-State: AOJu0YxOeVVWqq2dyYusFZFRNbrJbgFeJDaJPMX3KyM/p3z2bF+jInWk
	UwvGD6JS6Ievn6xJPqHDymudB1WOQg5u3UWHv2WsnQ6Px5nTlKVl
X-Google-Smtp-Source: AGHT+IHyzrCmXAD2KqmUui2/onuNFffyESi/3/YrEkBVkh2zKCowtSrmTuuBCT7CD9CDtTibt8b4iA==
X-Received: by 2002:a9d:4e93:0:b0:6e1:10f1:345d with SMTP id v19-20020a9d4e93000000b006e110f1345dmr15703036otk.29.1707125029849;
        Mon, 05 Feb 2024 01:23:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVXK0M68TNzn4cU7jgVzzXN3TdoGqbIcc/G7r4AMi7+458SD/vr9x+X1sK+EE76uRrnRWTqR0QnHWfWAivIWTWsgU3ZFMZleuGWcG27U54paP7L3MF4uW2LfzlKTxk3QMWqBMoPYtrhlTDUjhM1zLm4Xjzty/ai3eaWTdOMkiK4Pr9ouUOAgJbF5GMoR1hFa9B/DYgbyCUgsTvqZIfH41TnMxniB1v1IZB+KbmYWsIHfHeDEp3d3KXDVXxpXR/ul6FaepST31DwspUCutDRG6JmWFH4F5Bp8E9MbKC5dYryVjjj5C838kdEjvvEPLVVSr0hAiCXSeP3PUUss5/T3A==
Received: from t480 (89.208.247.201.16clouds.com. [89.208.247.201])
        by smtp.gmail.com with ESMTPSA id c24-20020a634e18000000b005d7b18bb7e2sm6591016pgb.45.2024.02.05.01.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 01:23:49 -0800 (PST)
Date: Mon, 5 Feb 2024 17:23:46 +0800
From: Shawn Guo <shawn.gsc@gmail.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: imx: Remove usage of the deprecated ida_simple_xx()
 API
Message-ID: <ZcCpIli/KGRDJi5d@t480>
References: <5807287732785d81b9c3ef9e6a25e4f3bc2e2159.1705005016.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5807287732785d81b9c3ef9e6a25e4f3bc2e2159.1705005016.git.christophe.jaillet@wanadoo.fr>

On Thu, Jan 11, 2024 at 09:31:55PM +0100, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> This is less verbose.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied, thanks!

