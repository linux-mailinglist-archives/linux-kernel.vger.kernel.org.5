Return-Path: <linux-kernel+bounces-139520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C31E8A03F0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1C672886E8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479922EB0B;
	Wed, 10 Apr 2024 23:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flaQermv"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140216110;
	Wed, 10 Apr 2024 23:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712791135; cv=none; b=W0q+8h+f+p5Dm04iHUrcL2mhD5B+6/vT7/8yxIu2uyycgg5fgZyWLj7nUvg4aH/V77IBBNBcEx97sNBaCkS097/MdC8LnOKx2i8UoEhP/McSxw9Ink55ERDxKX0fMy4rF5YN6XaWvnWMzzQHwEVLtxnUL+U7M1ab9Pz9heuR7z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712791135; c=relaxed/simple;
	bh=y7ykmQGubP0HgUu+JV1VJu0nnGMVEU/CM1aWGA20PoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CM2EvwYPqXPYqwS935BgqCQXj9uSaGNY+LZTCQ+Ls6Ad0J80cHeUXf/3a4aQd/Rkz7RWI0jJyr+Wb6dtnBQwqy68s1H5GzmUQ2Ieh1lytiuxJlb92IQtRz5GIT8X9RTRB9L3DVpgd00Ab8T5VjtPxc7WW+FRg7rlCI8ZUUfUJts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flaQermv; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-416b5f6813cso21413825e9.0;
        Wed, 10 Apr 2024 16:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712791132; x=1713395932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yd9896NKzJmOgOV+9xQfBdEzg91ECEA68tJTt2NR6lM=;
        b=flaQermvahWuvClDVsT004VK8dLYuPsft3NhAByCLaZ1LmfeavH2yYxbuJaqeJa++g
         0RvtlWZ97mMlU6UydxE0s5D7sWMS6ngn1igN6HjYWXfn0uT/IZdmd6rvpsvGseho2Qyh
         eK92rVINCj+X9SxOTH1YQBbsy7OjfLqE7r5lXCut0bKMAwWNU24XVb5E/KvGa8QgZL3G
         j5zKjTHHYAaeQVOzFMlW3DKa2MiYJNBNccQiDEJpfbSPjz8KIDam58E3G/AiX3r2Srxf
         Vh1yJxulYtNfqWBJFV/oZ4vpjglWRTkpoYmWgNrf62oofENE4C3ZGGCwrtoSk60HCxC+
         c2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712791132; x=1713395932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yd9896NKzJmOgOV+9xQfBdEzg91ECEA68tJTt2NR6lM=;
        b=Xxj0I9JbBml6KYs2G1ERAaSM05P+rG1G6zCQRFiaYHGZtud9A0oFR2L13ZnLPvh9jr
         dgWf2Pu6R1JPvKgKV0oxnctEQL5o9XxhFyetwoW9Pd0pkEv0qTq3o1Qq3kP9zrshA8+c
         JoFaOyUmtfOwRTg2c8shuC6Tj3RT2yx789S9kZ4hzLD6h9ApqjErd0/njPb4HXH3+5ds
         kZs0q62cCv7LfK6YpLOUkHcIt759vC6sJETPNEjuVzaEsfpMSIbs99j8fmOGpSll1Bp1
         dLYOdfTp2W2BT8xgTK0XhxJzUTeZe+o2s40sNIAgXYDo7go26zYduUHKxZdQh/sKI0XC
         83nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWffTlLFddK5iZdZ2AkO2EDmNvGMVAJJn77Z37s4iWYvEWUG+J+vNejSWGkOHMf+VeWO910Dc1X6LfbEa8R8TXl2n2ffMBqmTD3mLodnbr40JXa9XQMgoNTYwqpau8inHNYJUmK
X-Gm-Message-State: AOJu0Yw1H5SDubUGi8bASsHQz+mDyWya7qr1C2x8UHtjEDGdZd9lvkxS
	7V8AMfSvO9JkIJK4BOG/T0iNM7+wXmGhpL/nGeDPknDoORO+5fSH
X-Google-Smtp-Source: AGHT+IGPqcomcyzrLIjIeAaX+GM+5Zg/cl0kZ5cSwNaaTtdIHnbx7wkMcWIBQ96PtOHebpeFJxGEeg==
X-Received: by 2002:a05:600c:4695:b0:415:6d1d:603e with SMTP id p21-20020a05600c469500b004156d1d603emr3658016wmo.37.1712791132243;
        Wed, 10 Apr 2024 16:18:52 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d201:1f00::b2c])
        by smtp.gmail.com with ESMTPSA id r13-20020a05600c458d00b00417be508e44sm485053wmo.34.2024.04.10.16.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 16:18:51 -0700 (PDT)
Date: Thu, 11 Apr 2024 02:18:49 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>
Subject: Re: [PATCH net-next v6 0/9] Enhanced DCB and DSCP Support for KSZ
 Switches
Message-ID: <20240410231849.dmmlhaictptcof2r@skbuf>
References: <20240410080556.1241048-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410080556.1241048-1-o.rempel@pengutronix.de>

On Wed, Apr 10, 2024 at 10:05:47AM +0200, Oleksij Rempel wrote:
> This patch series is aimed at improving support for DCB (Data Center
> Bridging) and DSCP (Differentiated Services Code Point) on KSZ switches.
> 
> The main goal is to introduce global DSCP and PCP (Priority Code Point)
> mapping support, addressing the limitation of KSZ switches not having
> per-port DSCP priority mapping. This involves extending the DSA
> framework with new callbacks for managing trust settings for global DSCP
> and PCP maps. Additionally, we introduce IEEE 802.1q helpers for default
> configurations, benefiting other drivers too.
> 
> Change logs are in separate patches.

In whichever way this goes, could we also see a selftest in future patch
revisions (similar to tools/testing/selftests/drivers/net/ocelot/basic_qos.sh),
which (beyond the basic task of proving that it works) sets straight the
basic user expectations of _what_ works and can be done in terms of QoS
classification on these switches?

