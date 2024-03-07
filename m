Return-Path: <linux-kernel+bounces-95546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2B6874F46
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A2F2B21B34
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441FA12BEAE;
	Thu,  7 Mar 2024 12:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JYXuF7Ul"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7995912A175
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 12:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709815219; cv=none; b=PQYhsaQeTd9ncAEWTxJ7T1VGgEnxK983GEUdyWw6k5X0WepeJkasLVm1ThTj7iy0Rws3yUAXE1CbWaUfQHkd8reRqUnzHHw9/fjTdubOxZgpD+6+gnT2FtmurLmxzb40XKAh6UWjvWC2LP0dqq+RSPAyCe0eD0RRa3jffgeIpJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709815219; c=relaxed/simple;
	bh=7q8x59bKdN+t2i+lMbr/meCuqsyVnDqfKNaz6Kknf/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ia76w6LhyIWQ2Px8mfcL9ByWFHYVro+V4VkQln23qiDl8czqbOgUAkc6y9xNscV9K2XQ3X6sOKZ0nTMoV7aA3xB2f8nhWrYR2qmoJpXLFW9e1oFtx2KhbjwT0rh41QWpkLKsVrrFdBGd88Hl+LHZ3vUb3skUiX7NxH6+XDQuO0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JYXuF7Ul; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-564647bcdbfso1006805a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 04:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709815216; x=1710420016; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VO5eonHO5vIMxGBlQPCGuvzt87yFvPmeAwfVip5Saaw=;
        b=JYXuF7Uln9rx6Nt96m0Bjs4TI/bVcE9lakG/M/TO5pVo1xxsnHXEqjk3lB3Ilx0CzF
         plNWC3zW00YwXCIBv5bObRhal3DAd2U+nUn3ZwYcAd4n1DvZtQuOp+DAvm3yOTrRXw2y
         S2eUp2UtxNp4nCOCHEpta0T2ddvH8FF3J7Mrnfrh5SrOZiZ+foR5MC/xSrT08f+dXJ2W
         uGcInuurDPCvA7de0bwcyvbgQiQVTj4jN0es+R07qx6G7DpecMDo1ipX1tjjBv7Iz5QM
         RAwPN7U+CPtCrF4MS+UK7FRno8cXq/BxvPtW7nbRWwaA4HXfnyNeaHntDWIQE0749Axh
         7Alg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709815216; x=1710420016;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VO5eonHO5vIMxGBlQPCGuvzt87yFvPmeAwfVip5Saaw=;
        b=xUh7r3AeN8VoWnP0MvghWH7Kc8+dFX1Ba67NhDVGoySanInyBVhXuC7BOSxIR2Zgar
         5DmkPksPq+7ZTOBYS+pSrWdZeUgvd8bW6xVMbkKL0bMCQHjxwavCg2exVnFHfMNtdofq
         MzzHLvjeEv1b2kAj43RLBjFjLutHf2gmIzKh8G2Bcpd3CCe/J1B74NRJri4pw87GrkVY
         7T7QcvfMIcPhYoYOqUjl6CG7yrfqvD8OQWZPCkpiozYpqTpDE0lzV5gi0gC++w3OH/qV
         XXl6Kx+oFd63YhTQH+NTN6OClk4PiR3kxyyxH8kN5kFo/mWta5hYQJPT0s6jX1wvweCt
         b0+g==
X-Forwarded-Encrypted: i=1; AJvYcCW3AKDP11izElXjvYRFWEzyG0V/h0xQWb5P4XhBiETtzCCideMrsOLErRwd7V2b7uJwG1ECN6K8/6qDzrz6ZnAkn1+0UVZ10e56Ls3S
X-Gm-Message-State: AOJu0YxPe3x1wKGaJFBsMsrtK1yOvKtQ20SP3WKTWOAvZBIxgYKdabaG
	Pi1YxY7dpHeevcyHOGGWSezRD1fOav/hyEVFeBA63k5rgbsOjU3dr2CNJZ+VBag=
X-Google-Smtp-Source: AGHT+IFfhwE0YjsmQVnMVFnDBE5Nh2To83meTE190u2nCGl8unrdWeOT9klQjZtc2dZO9rFUXlKFtg==
X-Received: by 2002:a50:aa9c:0:b0:568:2149:329a with SMTP id q28-20020a50aa9c000000b005682149329amr118073edc.19.1709815215724;
        Thu, 07 Mar 2024 04:40:15 -0800 (PST)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id m18-20020aa7c492000000b005662d3418dfsm7958712edq.74.2024.03.07.04.40.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2024 04:40:15 -0800 (PST)
Date: Thu, 7 Mar 2024 20:40:07 +0800
From: joeyli <jlee@suse.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Justin Sanders <justin@coraid.com>,
	"Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
	Pavel Emelianov <xemul@openvz.org>,
	Kirill Korotaev <dev@openvz.org>,
	"David S . Miller" <davem@davemloft.net>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] aoe: fix the potential use-after-free problem
 in aoecmd_cfg_pkts
Message-ID: <20240307124007.GC31128@linux-l9pv.suse>
References: <20240305082048.25526-1-jlee@suse.com>
 <170973933432.23995.8994501180418490235.b4-ty@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170973933432.23995.8994501180418490235.b4-ty@kernel.dk>
User-Agent: Mutt/1.11.4 (2019-03-13)

Hi Jens,

On Wed, Mar 06, 2024 at 08:35:34AM -0700, Jens Axboe wrote:
> 
> On Tue, 05 Mar 2024 16:20:48 +0800, Lee, Chun-Yi wrote:
> > This patch is against CVE-2023-6270. The description of cve is:
> > 
> >   A flaw was found in the ATA over Ethernet (AoE) driver in the Linux
> >   kernel. The aoecmd_cfg_pkts() function improperly updates the refcnt on
> >   `struct net_device`, and a use-after-free can be triggered by racing
> >   between the free on the struct and the access through the `skbtxq`
> >   global queue. This could lead to a denial of service condition or
> >   potential code execution.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] aoe: fix the potential use-after-free problem in aoecmd_cfg_pkts
>       commit: f98364e926626c678fb4b9004b75cacf92ff0662
> 

Thanks for your review!

Joey Lee 

