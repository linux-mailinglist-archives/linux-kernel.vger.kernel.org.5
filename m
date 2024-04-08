Return-Path: <linux-kernel+bounces-134839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5AE89B7AF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A897128191D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED87D182DA;
	Mon,  8 Apr 2024 06:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i+OSYLn4"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B857E1D540
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 06:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558127; cv=none; b=bKNRxkm/3BbEi29iVfc6hsGkfMeBBlpVHCV0QHptpslcOwHmUJo4EekJRMNF/DID0rkJbr4PcyejcMub7ACCDiC2ydCMTubG7TaeM93m7Md34rTow9A01kJU/9MVBritopb9eH2Sevvr6QfsS1K3eyP7j9u1m5H26SDO6/F/QoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558127; c=relaxed/simple;
	bh=/a3dQF9z2JQVz9cciOeh+y8wRKyVwnn+yO0CdzhrgHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WchaYv7HNSuPWE+EancYgPp5nDnrZYSEtFNa5RteXY71J8O1jK1AB6IEIOI2R1TDyRsL6X0ymp6uvRuCkJQcWgjJmGb+15vNz3T2LDTnAWBLWnFuY2RE6QkA0GhgBenER/9xNTrJBC939rDeyYoKer0Q3E1PpHqgq+/k8G8KWVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i+OSYLn4; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a51d05c50b2so98476066b.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 23:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712558124; x=1713162924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FgLtq4Q2TlcP1vQLZpHaRdv1skB8tG59UvbmyPM0V6M=;
        b=i+OSYLn4mZmdJnMZ5pZA2PyU6zqUHRebwArdxncaSGr3tk/yMEH3aBP8uifGQ8XQFV
         saVhD686lKd1hIihM2MGct1FfN9dlbLNhfZJkHR2YzNExRsDU0AX0ILAu8qbxMlG344I
         jchjduM1GY60PIUym5L4xrYw583Fma07u8klFPnCXHhdwEl1sxHGHhtX0QhvwZ4+BGa1
         wQhxonENWSQgAgpzXx0UcfQUon7H4Nv4vGag7stVF8zKdn00W9vyeaFrpls5rcVUvLBH
         CWgthrttMXXlR021QC9P3kOw6DikzrduJVJctJPtKzERkMPruMTZY6nbTqsdf7ApOnyr
         DM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712558124; x=1713162924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgLtq4Q2TlcP1vQLZpHaRdv1skB8tG59UvbmyPM0V6M=;
        b=WGhmoYTTDCeEZcuE3bgsQTH93VKU6lzy9iKEkZAj/YgjXjQuEbx1Hf4FOhSNSjyRdT
         C6mQQf4PbvBL8j6qv+eH5HnckCOseao06Uap63kNJA8SqiR2JFDDb+FF+xfgaz6nsLAE
         AYc2pbPl6K0Z0R4b0BOlRM2njP4JeeFnECAHd/bh1hWfRtrWcvVG8l7YgQ/x5FGMfXVi
         14heEQ5DwgbsG70HrL/0Ix6bj1+o0wBDJLEM/+jxJyNwirpyggkUuLaM3uqnqNfPj4gp
         2iNyyaT07Ko1AVxQ6YvcvpVrBP8XK22XrBPMWwsKAcnR1pDa9JbyLtiVY01m8lwiDE2V
         KuQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0F8Gi2fim1upIu9/18JGLaofZtm9ejw6/b3uD4h4ZDo2bcBCtHb/2P+rBC3wYFyxSpk5H4XMfd/bQc23tIW2gDRgyzj0JOb5dknr3
X-Gm-Message-State: AOJu0YxAZnLme9K+l++q22s24aYplZvSnFYYWLzv42xy4QhIiGuPbMcs
	hNgoVGqyATObMbrAS+kOfRTTTMZPFGb+ScmsBtgxfPG5XgXwqy0W5qUf2NEkklY=
X-Google-Smtp-Source: AGHT+IF4EKTTmquAMoLVkOL3W63bmhNdWh38zIYl5ZaMdc7DqN4H52hPc5f4R3mNWxMKNOJbOZxeIw==
X-Received: by 2002:a17:906:3752:b0:a4e:23a1:9ede with SMTP id e18-20020a170906375200b00a4e23a19edemr5078782ejc.36.1712558123980;
        Sun, 07 Apr 2024 23:35:23 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id i21-20020a170906a29500b00a51a2711177sm4054925ejz.13.2024.04.07.23.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 23:35:23 -0700 (PDT)
Date: Mon, 8 Apr 2024 09:35:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jackson Chui <jacksonchui.qwerty@gmail.com>
Cc: Alex Elder <elder@ieee.org>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: Clear up precedence for gcam logging
 macros
Message-ID: <e037e303-47b3-4758-914c-980ebe88d450@moroto.mountain>
References: <20240404001627.94858-1-jacksonchui.qwerty@gmail.com>
 <658e1f40-d1eb-4ba7-9ba3-0aa05a1ed06e@ieee.org>
 <ZhBrff8qkkmum4wc@jc-ubuntu-dev-korn-1>
 <5eb3afe2-da7b-4f98-aac2-bff529a02cea@moroto.mountain>
 <5e1c5156-d906-4473-970b-bff71e4dcd96@ieee.org>
 <ZhHOKkqVIdsuZ-4Q@mba15m2.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhHOKkqVIdsuZ-4Q@mba15m2.local>

On Sat, Apr 06, 2024 at 06:35:22PM -0400, Jackson Chui wrote:
> > 					-Alex
> 
> Dan, Alex I think both of you are spot on.
> 
> I like the suggestion of adding 'gcam_dev()' as an accessor
> function and directly calling to 'dev_*'. I'm busy this weekend
> but will send out a new patch with this change next week.

Nah, don't bother with adding the gcam_dev() function.  Like Alex says,
it's only 4 characters shorter.  Just get rid of the macros and do:

                dev_err(&gcam->bundle->dev,
                        "Unsupported unsolicited event: %u\n", op->type);

regards,
dan carpenter


