Return-Path: <linux-kernel+bounces-9940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AA381CD86
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBE92B21C7F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B732B28DBB;
	Fri, 22 Dec 2023 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ain3UOoc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766EA28E01
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40d3c4bfe45so20763655e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 09:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703265421; x=1703870221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mq4hw0QEMuAE36vGSIkC6Ps61LI2Ve4bHaG1hFDZ13Q=;
        b=ain3UOoc4wEJaaHa7ZZEKan2qNhcinKrcxqyQ1dTwrrKTf7XwsSzGSTTe1OEsEONHP
         6E4t1xsIzKpVYJ9RpeFNlHnlXwRRtpr6YOwSsetUcXrQjCcrBNj2T1wzC/Ug6+IA2st1
         iCCjI16Znl7SgWUsu4eP2Nq8MfOKdO2h85x5q1dUCM4kjEErew33MUDsOgnBRjKHZ8VK
         CxT3QPflRiKYn4oKv20IqTVqPz/jXDyceNJom1+e5GOq//qhr/2PnpSUYvMSaskTAV4U
         t+8yTzenPKBmDG2vfkO811vOlLfDVDjKdPX7Qg8ORbQGykExg3eNNRxR3B4vbPnuO952
         Fb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703265421; x=1703870221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mq4hw0QEMuAE36vGSIkC6Ps61LI2Ve4bHaG1hFDZ13Q=;
        b=Mm3LhWy2b1VDgRREbbdiIAIyU3GNXC9+pjgf9Y4RPNI8JHsaQ6kjfEOc91OOkZQjWS
         3moEyxXQKlVOhoP0VmfxYvlpsSAu+0F7HvZkuZT9S886mWH7fdHhPC/aHfhB75CcRNUy
         zQrfNTSEDZwSy5w2q9gHoy2wli60WLcdRnuH9zAXhPHGEmApdqpx83OTX+8Mb5QUzgUx
         5dn47fqOdf2+8EbY2+tMeZ0Ij1UdRCgiEb5DoPVboaaqllLeeB26nOdSqNfAs9Bl1t49
         dyvuQKjyO1A5VPP7hciCuDErfhO5Z3Bd/XKgSrlDWjzDTsTfTLR94e8rLdQk8aOsZlSk
         TbuQ==
X-Gm-Message-State: AOJu0Yy+1A2hC5I+LaLXaX8yq8EtG7NETF+R0RTa1Ghbic4UsPT+6B8c
	b8L2upwzfO2J8HQewbppsl2XIS2+Ig5WVg==
X-Google-Smtp-Source: AGHT+IFaN3v5QDgb99GGaLTsrTekLQJWsCsgqmcpdKm8JNeIDtdrU8yC3cSdFSgBABXMYnt8bkW5/Q==
X-Received: by 2002:a05:600c:4e4b:b0:40d:44c6:6fc3 with SMTP id e11-20020a05600c4e4b00b0040d44c66fc3mr405225wmq.349.1703265420232;
        Fri, 22 Dec 2023 09:17:00 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id v14-20020a05600c444e00b0040c58e410a3sm15458709wmn.14.2023.12.22.09.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:16:59 -0800 (PST)
Date: Fri, 22 Dec 2023 17:16:57 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Yauhen Kharuzhy <jekhor@gmail.com>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: sensor-hub: Enable hid core report processing for
 all devices
Message-ID: <20231222171657.GA78460@aspen.lan>
References: <20231219231503.1506801-1-jekhor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219231503.1506801-1-jekhor@gmail.com>

On Wed, Dec 20, 2023 at 01:15:03AM +0200, Yauhen Kharuzhy wrote:
> After the commit 666cf30a589a ("HID: sensor-hub: Allow multi-function
> sensor devices") hub devices are claimed by hidraw driver in hid_connect().
> This causes stoppping of processing HID reports by hid core due to
> optimization.
>
> In such case, the hid-sensor-custom driver cannot match a known custom
> sensor in hid_sensor_custom_get_known() because it try to check custom
> properties which weren't filled from the report because hid core didn't
> parsed it.
>
> As result, custom sensors like hinge angle sensor and LISS sensors
> don't work.
>
> Mark the sensor hub devices claimed by some driver to avoid hidraw-related
> optimizations.
>
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>

I dusted off the Yoga C630 that provoked me into posting
666cf30a589a ("HID: sensor-hub: Allow multi-function sensor devices")
in the first place. Keyboard is still going strong so isn't not
comprehensive but for whatever it is worth this is:
Tested-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

