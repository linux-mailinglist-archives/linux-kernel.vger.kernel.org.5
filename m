Return-Path: <linux-kernel+bounces-154983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC408AE3E3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C6B1C22918
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4187EEE1;
	Tue, 23 Apr 2024 11:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="JvzNUggf"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634217D3E6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871685; cv=none; b=CjQbQ448vDcNNK/fvk01r9jYi3HqorCCfDMaiRkZP+LrLFfMtzLhgcRPA6huQ1gRsXwjvt3SBj52xI6ICwbsya6Y1ts/2FdASJWn0j7HER3J9R7alnpHvgaDN4A/RAjbp4cTuPLovqR8ya7nVUrRJ7lyuZWn8HZpSqtt8MmC26c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871685; c=relaxed/simple;
	bh=R3iqpIOIoK1o7CTPRk4sNfkHZGRMhCyVjxP5dycHP0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCIX8hdrBfD0DmRn6AtUjxNHMPTneBOuuvVNbjjrh1Vs0Z+sAINT2gotycU4cEu6/CH/z057ntkwlgVr2nRxy3+/ty8C8KZ00BNbaCgD713YtiXKFGkMUxvssO7HUJr/8HCHrQjHRuUU4YsqGmmIdA98S3PF/gNKXx/ff58V95M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=JvzNUggf; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41a4f291f80so16952555e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713871682; x=1714476482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R3iqpIOIoK1o7CTPRk4sNfkHZGRMhCyVjxP5dycHP0s=;
        b=JvzNUggfIkiFCUl/ONvEAAeT+VihZJFvjTNSW4pyc7hu/IEpJb7N27oXVSNUP5niKe
         KAzwU7xwn959rCz/LhbIkp5BJncRG8wzkGPlqc2yslmMahJ2xVcAU5uFL1bISncDTKET
         +5dzOqNjpvs3YDUowjIWsD5Ok8pw3Ocyx+HamkLHa/974XdD4iNsxJ/klzbuSPzM1UIo
         tD8wVOPvxYzFFErLwfrwDdmb3F8jb2VvREbgRcY5jJgo5h0PC0jRjxvAtoTLHyRFEXWg
         Kek2zusHX9YL/pStsBtmh+yYcaIKiGrObxmFAaZYEfWkFGOhfnNsvH2s14lj+yhwqZhB
         2BNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713871682; x=1714476482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3iqpIOIoK1o7CTPRk4sNfkHZGRMhCyVjxP5dycHP0s=;
        b=KowbdvO2gLPHUytVhuFvsRtWHBcdJbgVCXFHZOJgFrAQuBF4fXWFkQCz2GGe5l7H6C
         J+XaC0xY/goZJcqNDsoP2FnAaxAUzJOXeQKIqWwcrRcdmYzOmhtf3eBG2J0NubvgtKnc
         h03KtCWZi51klVV+Lcpmh17+5UmmPwrycg9YcB/Mqa0cEYoUtcaoydDZOhTD5LN2Zjn1
         Y9k4RmIdLhrtV9/TiF6IQCNyd8Ue9DHWko4Hfu+98SglCBVmheIC80Vb6mTHIbN7VcDm
         nnc0811dfjmngJnyYu95+1JVTYe7/Nhqgvz9suSsbNGi17rMhp0gBh7CiyLCpFLbStoH
         F9Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVNXFwaYMV1Ad3lz60TRYiglFDZFu95rKPOj16iy3N/wH5zoD8wCq3M2KVEk93Q35ntHwQRYIw0Iw0tqVAF3s/F06LASu6btz3UpEy3
X-Gm-Message-State: AOJu0YyeXZWJsUxF3r3MwXQ0px7SA053ChgRfOK/3ue9Xuq9zwtY5e7i
	O4GY7XpjOr1rxM1QLLgaOuCL/ReIu+0gR9pOsTMc3sWLdggbAWtfaIKHufTJOFY=
X-Google-Smtp-Source: AGHT+IFxR+UxcEUSmm6y7PvB/0CvHSOafoe3TVmFX4MNJjWWeZEWNgqz70/4mF1IDjDPrmnI234YEA==
X-Received: by 2002:a05:600c:1988:b0:415:4b4b:1e28 with SMTP id t8-20020a05600c198800b004154b4b1e28mr10779016wmq.20.1713871682525;
        Tue, 23 Apr 2024 04:28:02 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id y18-20020a5d4ad2000000b0034a0d3c0715sm14117203wrs.50.2024.04.23.04.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 04:28:01 -0700 (PDT)
Date: Tue, 23 Apr 2024 13:28:00 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kyle Swenson <kyle.swenson@est.tech>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net-next v3 0/3] net: pse-pd: Fixes for few small issues
Message-ID: <ZiebQLdu9dOh1v-T@nanopsycho>
References: <20240423-fix_poe-v3-0-e50f32f5fa59@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423-fix_poe-v3-0-e50f32f5fa59@bootlin.com>

Tue, Apr 23, 2024 at 11:21:09AM CEST, kory.maincent@bootlin.com wrote:
>From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
>
>This patch series fix few issues in PSE net subsystem like Regulator
>dependency, PSE regulator type and kernel Documentation.
>
>Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

set-
Reviewed-by: Jiri Pirko <jiri@nvidia.com>

