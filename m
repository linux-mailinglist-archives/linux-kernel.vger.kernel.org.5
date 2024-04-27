Return-Path: <linux-kernel+bounces-161191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 177498B4831
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 23:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529791C20FC0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 21:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDEC145337;
	Sat, 27 Apr 2024 21:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="3aAgJYC8"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFF163B9
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 21:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714252179; cv=none; b=FqzUn+fx3q0bvn3c/Q9hc0ZqG6E3L4QUlY+QsZLB/egmylLPLFVdxkYodnx3f6NIurB2iLdpEBy+9MOBdl74SuXChqoDFk3KZJjn1xEVUuCGJKXkC0U8KA7cOBL/lRVUhkb/FnT25caimP7z1YN2boYAhgAI7Dd8V8lctXM2V5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714252179; c=relaxed/simple;
	bh=yM5PWgZeiUSTVvfdIQdobAEEnf+XmPghsPqHz0QFhJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTkopWTrD5lPUMJb2ACIEeCqy7Kmn243Ry0fefh9TdIgQnRHCSlj9CA1CyEjuetLi/8sCMjYeFg2lWcMJ1+lOIfuhDhKgw8tjrsFrWbxyPSHV8XKAduZnrLnnYB4jqKqE9KxZAA/yXzeohh74l6IlGnoX+MmUMKNgjMLQltJGUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se; spf=pass smtp.mailfrom=ferroamp.se; dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b=3aAgJYC8; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ferroamp.se
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d8b2389e73so39019381fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 14:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1714252177; x=1714856977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c2zTIoadr8RExdz4xMeAhQeS4RkPDjUKmRxEp7ueNe4=;
        b=3aAgJYC81418Hx2lRVt6IfnEeWBAm9hX6JcTfOTNnrx9SpCM+Z/SkHXEdz/bseDMbZ
         l8sGzCA6nYB5137zUPXINbZCZ0X+EoxkqxRcuF0YAQBNnXZX1+YXEGju6z75AQNf7o7E
         q0Ehl89f8dlVy527VquR0WWBBSiKfCJUpB1jwrUFjQdDJscwSUdSEvvPBSV9FtzRrsFo
         4CyCFyBvMrRlV5xgjNrRALX4NfKEb3gdQBriNh+w/nPylMz2zZcFipKxv2uTZaeFgO7h
         1qn1sgsV7CEORYdGxze+ScNYq0nDC7Y+eThLttg6y6ZxawR/rKmKObURyATlJq59kklu
         GeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714252177; x=1714856977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2zTIoadr8RExdz4xMeAhQeS4RkPDjUKmRxEp7ueNe4=;
        b=oVza/Ft+l6Z21sADqac74UVAsoUJzdhHNond5yxpbILKDE5ByHLoR5fiypmVWFNZwj
         oFKb92afo7fOKKnamguh9YvV8puTsaP9gRTW4idbdjpKPDltM/6E/h9ync98gl6Yr39S
         c99ukLH5ILSkHZGWRxgcBK8ouNvtF63GsScqbRgm0aPwMGelherLB7pK+qaqv8a3/XXE
         CWAwmwBOhZN+V8cSXHgSbXNy33Z1yz+b3++LVYx5G1rwgHiWljWTJyRz8C5yCjvaHCu6
         sl6vYcD82V9bkdvgFI9TwfX2iCju4v6QI0czP6O0QyrhkSucRR1Qff5AbfeNZOwc0kVE
         l37w==
X-Forwarded-Encrypted: i=1; AJvYcCUCLMq9oLV/hyyBjx7Kvk7EOv0hTvWZpIiB67c9EZOtaeGzV3D7JsS/O4eEc8HQCGv1G+jdS0ZDz41ZPDa/6WznWu9ZbGhqXnmX1mqA
X-Gm-Message-State: AOJu0YypGkxzXi/5QXepjX2VgkdDmNj17gRhjayobCQ/zeXAaB33aUmh
	rGhKJgOi/GatYHnBz/jN+mkI0KvyQ4eiDlGpV7sesBVORF2vF/NIhP1QkuC1HsI=
X-Google-Smtp-Source: AGHT+IGDtQZoTkTFz5qjYB1+ezyxCNNT2QBqmEwUhpivw7iry0dGY3XBbfNI0/XF2v1BbI18pjRlrQ==
X-Received: by 2002:ac2:5e21:0:b0:517:87ba:aff3 with SMTP id o1-20020ac25e21000000b0051787baaff3mr3459847lfg.43.1714252176841;
        Sat, 27 Apr 2024 14:09:36 -0700 (PDT)
Received: from builder (c188-149-135-220.bredband.tele2.se. [188.149.135.220])
        by smtp.gmail.com with ESMTPSA id w23-20020a0565120b1700b0051d22e9dfcfsm277139lfu.21.2024.04.27.14.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 14:09:36 -0700 (PDT)
Date: Sat, 27 Apr 2024 23:09:35 +0200
From: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
To: Conor Dooley <conor@kernel.org>
Cc: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, andrew@lunn.ch, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 11/12] microchip: lan865x: add driver support
 for Microchip's LAN865X MAC-PHY
Message-ID: <Zi1pj28Eb57bByef@builder>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-12-Parthiban.Veerasooran@microchip.com>
 <Zi1PxgANUWh1S0sO@builder>
 <20240427-vaporizer-pencil-be6a25030f08@spud>
 <Zi1cbScrKzFN3PNT@builder>
 <20240427-attention-negate-a3b6ede708d7@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427-attention-negate-a3b6ede708d7@spud>

> I think the error pretty much is what it says it is, the driver doesn't
> appear to have a spi_device_id table containing lan8650. The name of
> the driver is lan685x which is used in the fallback clause in
> __spi_register_driver(), so it complains as it does not find lan8650 in
> either. If my understanding is correct, either a spi_device_id table is
> required or the driver needs a rename with s/x/0/.
> 

Right you are, no gdb necessary. With the caveat that I only get it
working when setting DRV_NAME to "lan8651", setting it to "lan8650"
still produces the log

R

