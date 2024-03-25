Return-Path: <linux-kernel+bounces-117382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D2688AAB9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E8A3340CA8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66ABE5DF1C;
	Mon, 25 Mar 2024 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nMyliOQC"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD79A5E099
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380988; cv=none; b=JGEIKn4eTkvpJXlAGwgoyNg4xsAlmwpRmCd5HcPavYVS/GqvXSHCOk1Jfd9wBRu+vzeCLAQuecwhJqp7s70/svChua6eyk3DjLKOFbPyRM4mcaWV6X4fYTL164G/Sif5dB7QQGAFhvlCuK+9d8FJ+Nd4Sj1tWfzyeiQvVLgm+tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380988; c=relaxed/simple;
	bh=kX8SJsy7Wu9qxWsB/EuNbqjpIU+HpoK55f1JMPu/7D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDOtRy0RK5kcoy65lALSocoCYxDsa9kWkkNo6tyGDOKeOMtiHZXPyMHAfI+ejmcMof2L8EFSXzyfwTZVjwcWYjosSWoj3yoSQ9opCqUZWmjFAGRmwmXN59IcUfumRL8jmvWZ4pAzlPcQ4n4novULQJM5yn1s4toHLFcWQt0LJUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nMyliOQC; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a47385a4379so462906766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 08:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711380985; x=1711985785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JYD9V/lEsf9uqiYf4EWxgIYLkJpRooIT1PnEwEiySfg=;
        b=nMyliOQCyLZxIm+T6Wup3xSrA2CVl05uNOeBy5CZ5gMyOaI7YwVeNJyNAHpPbYcgJw
         v8cpHwygtsMlNht65yZttit1IsMQcVsCODC7+njkzMvE9+AJG6vFG5B8ZDd5RDFWOsq/
         zuLFFyuz3rNk1DLUEnAz+rHibP5Jc933I5qifTep0KMj72l/s3vTG4qLixa/b4L68Rb8
         PW8TFJ3vuILA/BChL7wZ3y4ocjo/sPX8mJUQY4RasMnSmuhdPuq/t16yudja2w3DAxdx
         S8tjJW3n6wQ6UffAyhWhGQCioW3XMisMnNq3A6gO8SkAbjCM1asqIPazCmylOUix9mFh
         m74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711380985; x=1711985785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYD9V/lEsf9uqiYf4EWxgIYLkJpRooIT1PnEwEiySfg=;
        b=tqh23NAmVDrOEJOG98ym8Mmx+zvpHcR/VMnSCCLPwkRD/JT2eHUWXjdIwJU5ZoCu/r
         J1+E9J/KixTh+001LlNZu2jUp1dPniqr1jnC925/dxF55TBZzcLwbUi/+11j7acaeBWZ
         6kfgFWPCHq1xq3nPug/yqjhc2Nl+nP22AzHe5qVVDVAWW5WgFi4m3c3uxXy4wGPQVqxw
         2a32PdxrNvQkVhtE7D6xeK3EpCVXd2Gh9kekG0igJ98J73TqskfNvk4/spEBkcIwjdh6
         qGwCwPNZG8edGbrgwQl+BWoieewOs2GCWco4Yf/fu/m/yX6/5OemkZ2VlZ2VIVnQR3EH
         wo0A==
X-Forwarded-Encrypted: i=1; AJvYcCXL5lB/MqhZDkKf7GYGyeW1CrnTdFOs5RNbovCL5DMxgyAJURl1hLheHkOeENx/I31W1iKvOikIJcDE4x33FgMQNsd26KPLksHx564v
X-Gm-Message-State: AOJu0YxOlcB718iUia3nJj+sh63NhY9gVg7y1tmZDBjwxTxSgLJN/J0+
	3Im882bw62sKtIcY+9Gd4cQk4jDYR1+wUtG9SRdnGNRLRmcKelxFaSSMJhsjLlY=
X-Google-Smtp-Source: AGHT+IF2L6kelCSMu/YRNMu9WaK4KKCHqMviE11VEijc/cs+BMMniJENJTygPUjr5tPFrc3qxoCONg==
X-Received: by 2002:a17:906:69c2:b0:a47:3cd5:b3f1 with SMTP id g2-20020a17090669c200b00a473cd5b3f1mr5421382ejs.35.1711380984859;
        Mon, 25 Mar 2024 08:36:24 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id z3-20020a170906668300b00a4750a4a1f7sm1999823ejo.6.2024.03.25.08.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 08:36:24 -0700 (PDT)
Date: Mon, 25 Mar 2024 18:36:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
Cc: Su Hui <suhui@nfschina.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Geethasowjanya Akula <gakula@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"nathan@kernel.org" <nathan@kernel.org>,
	"ndesaulniers@google.com" <ndesaulniers@google.com>,
	"morbo@google.com" <morbo@google.com>,
	"justinstitt@google.com" <justinstitt@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [EXTERNAL] [PATCH 2/2] octeontx2-pf: remove unused variables
 req_hdr and rsp_hdr
Message-ID: <21c3a484-68a1-43a0-ac48-e9a85027605c@moroto.mountain>
References: <20240325073549.823832-1-suhui@nfschina.com>
 <20240325073549.823832-2-suhui@nfschina.com>
 <CO1PR18MB466675E232FA99415D766F68A1362@CO1PR18MB4666.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR18MB466675E232FA99415D766F68A1362@CO1PR18MB4666.namprd18.prod.outlook.com>

On Mon, Mar 25, 2024 at 12:44:44PM +0000, Subbaraya Sundeep Bhatta wrote:
> Hi,
> 
> >-----Original Message-----
> >From: Su Hui <suhui@nfschina.com>
> >Sent: Monday, March 25, 2024 1:06 PM
> >To: Sunil Kovvuri Goutham <sgoutham@marvell.com>; Geethasowjanya Akula
> ><gakula@marvell.com>; Subbaraya Sundeep Bhatta <sbhatta@marvell.com>;
> >Hariprasad Kelam <hkelam@marvell.com>; davem@davemloft.net;
> >edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> >nathan@kernel.org; ndesaulniers@google.com; morbo@google.com;
> >justinstitt@google.com
> >Cc: Su Hui <suhui@nfschina.com>; netdev@vger.kernel.org; linux-
> >kernel@vger.kernel.org; llvm@lists.linux.dev; kernel-janitors@vger.kernel.org
> >Subject: [PATCH 2/2] octeontx2-pf: remove unused variables
> >req_hdr and rsp_hdr
> >
> >Clang static checker(scan-buid):
> >drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:503:2: warning:
> >Value stored to 'rsp_hdr' is never read [deadcode.DeadStores]
> >
> Consider this also as a fix and add Fixes tag. Also please add "net" in subject to
> easily identify whether this patch as net or net-next material.
> 

It's not a bug fix so it doesn't need a Fixes tag.

regards,
dan carpenter


