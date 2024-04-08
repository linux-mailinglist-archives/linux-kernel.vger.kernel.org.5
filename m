Return-Path: <linux-kernel+bounces-135234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 055D189BD81
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66A57B22496
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3E060260;
	Mon,  8 Apr 2024 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ih/rQPfN"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D525FB89
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 10:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712573394; cv=none; b=BrO2xA7IcKl/V0La1c9/fe6ril6jiD2rWUGagk1rT1vmQU6sVN9h/Yo/ehiTqJqFw1GtmVJxO2yJeNLRcgsJOuJpyiwUjX2kfwRpzGQZWR+KyTZ0HkBf1E4KsIypkXSNdLArZJrv4rW2tZnayn6YYE52bTari2xCnN1D/6HeWWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712573394; c=relaxed/simple;
	bh=ruahLZ5cqFYo3cZzozbeUAyIutI+Fzsi9MunwK1v35I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxqTMSg8B0xLRiY06kizzAPp5crfjfNGuThq0hSsVjQTqunUp1sIGc23WH3NVk0HGhJN1/LP/ECyrntDmtM5aQtJ0xQ6lUYITMRq+tjwo2N5QSgC36usAdJgcMHBYlyUmWvUv8hSzH/c63xoiwBo2ox4jLxIQHxPD9BEXZsAJss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ih/rQPfN; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-516cdb21b34so5397705e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 03:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712573390; x=1713178190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NTkXeepmy/WsKrFaXkMtM2C3u0L2CRoo+S2hVzROBZ4=;
        b=Ih/rQPfNSAI7pEbM//yK/chONQJHA2cNy2/g8AH+SfeKwQ3q4ieyr2rbuhOvWCO9Rq
         fwk4Ky1A96ZZbuQHo5R1mclouxnEyRkuP0qXcQiFnZ/ArDt51/QuVWas35SQwEyk11yf
         eiRZ9hZDL7h5bFYq4PeSQu39uTH2DZnhAxsQMxCqJcpDSvS+/QCoz9ymglkAQQTixNE7
         tgxFqNfi0KCNBWJyTTSGlNsZuXhOS+OxDVflvYHrZu+ThR1cTprafUEr2tMh23esmEvA
         zRHw0NTeLg6j/n02a+JWy6WGlOPp2lxoadrQUMjH21AIdODB3L5Z/TpE9jmUvVtwmxdw
         VTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712573390; x=1713178190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTkXeepmy/WsKrFaXkMtM2C3u0L2CRoo+S2hVzROBZ4=;
        b=WMd2PRuzHk4F9Yi/s0m3wpcWhMFIrppCii6AnAOmbJD09OtK5ne+ZUnDvILe1l9uQK
         YhmXwrOZl5/Op3dF68m0DUbqkceDL+9C74GpCqGuQLbB8fJhhmMyxdQk6fFoyskHXQ1E
         NE3l0LqV6VUP9V/uJNRnRHrQ5TyR/WfyVBImQ/MDEskB1ljd7GL4BIzwTD7JguRRvFO6
         Mfq9gJa63ZGt029Dt8/BqkO/qwp+OzeTOosWFe3ZCbv9P0hRSq2ew1qaT/LbNRb82bRe
         yIDDLyG9SuWyR89U5oEUx8VgI0BlILwLDx6hHXtxStFKKB8IMVUojPkoUop1hHUbuuhp
         TvEg==
X-Forwarded-Encrypted: i=1; AJvYcCXEclzR7dPMyctfKm2mGWaWjlEMk6iDbsIkxion3tT+g23rZ6i8FqHvd2lM7/3ANkDtl4vGtQo2GFqE+yGa2tAFwZ5URcyMHeekvgh7
X-Gm-Message-State: AOJu0Yze13I37+ttj4zwNAWD/iOUpMMyN/3KZU3PYX1SWySDgxwKep36
	vNwfxgdCkON89PdKcAC9WB9poaZEAUn6wNJ+4gElFrDbkfb2njG74VBI5vAHAmU=
X-Google-Smtp-Source: AGHT+IHCpZ4Ih2Z2P9PDG65HHXxVvxBaBSvyEfwgzNxHCU8qNwDgiqqmquSPp24kflirGRGNmoxL5w==
X-Received: by 2002:ac2:560a:0:b0:515:a8c9:6ec4 with SMTP id v10-20020ac2560a000000b00515a8c96ec4mr5684729lfd.42.1712573390358;
        Mon, 08 Apr 2024 03:49:50 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzyjmhyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a00e:a300::227])
        by smtp.gmail.com with ESMTPSA id f28-20020ac251bc000000b00515b5cd2361sm1146257lfk.164.2024.04.08.03.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 03:49:49 -0700 (PDT)
Date: Mon, 8 Apr 2024 13:49:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PATCH v2] usb: typec: qcom-pmic-typec: split HPD bridge alloc
 and registration
Message-ID: <2ejpom6ykci6o7d7luwa2ao4stpm24aoyi66aoncxcqcwgidxz@gcsqvpb3s7nr>
References: <20240408-qc-pmic-typec-hpd-split-v2-1-1704f5321b73@linaro.org>
 <ZhOYpHXz6t0fkzZ2@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhOYpHXz6t0fkzZ2@hovoldconsulting.com>

On Mon, Apr 08, 2024 at 09:11:32AM +0200, Johan Hovold wrote:
> On Mon, Apr 08, 2024 at 04:06:40AM +0300, Dmitry Baryshkov wrote:
> > If a probe function returns -EPROBE_DEFER after creating another device
> > there is a change of ending up in a probe deferral loop, (see commit
> > fbc35b45f9f6 ("Add documentation on meaning of -EPROBE_DEFER").
> > 
> > In order to prevent such probe-defer loops caused by qcom-pmic-typec
> > driver, use the API added by Johan Hovold and move HPD bridge
> > registration to the end of the probe function.
> 
> You should be more specific here: which function called after
> qcom_pmic_typec_probe() can trigger a probe deferral?
> 
> I doubt that applies to tcpm->port_start() and tcpm->pdphy_start() in
> which case the bridge should be added before those calls unless there
> are other reasons for not doing so, which then also should be mentioned.
> 
> I suspect the trouble is with tcpm_register_port(), but please spell
> that out and mention in which scenarios that function may return
> -EPROBE_DEFER.

The probe loop comes from from tcpm_register_port(), you are right.
However then putting bridge registration before the _start() functions
is also incorrect as this will be prone to use-after-free errors that
you have fixed in pmic-glink.

-- 
With best wishes
Dmitry

