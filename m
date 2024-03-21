Return-Path: <linux-kernel+bounces-110280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 700C5885C84
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED8C7B22DF7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4954A8627C;
	Thu, 21 Mar 2024 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PMrdRguP"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06AF8528F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711036176; cv=none; b=IqVbCSAgKfFgxddDfcyhbbiBn0VLpWdQvZAKkbTEQxEA4L3MKAy8nWBIr8E4jL+S1l176xLQiripG6xsM3pyv+9QUeFdGuYEtzJ2s397TaAq6ZPTZbA8gaxGo7SD0jsZ0xYOFTBU9uHrO1vDbfFWj1txGbkXQNgmlZNGKQkz3nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711036176; c=relaxed/simple;
	bh=03zm1CMeVrOLuwdydHw+vTkdItfVFTx9tilzNEsOzoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCLF1eL8WaHMNy4Sw2helAKYcRMQZhsnfcsCoYkx6+t+3tqq+rlag6kk3nthvi0lYW2aXnvJSRYV2tgMSHt9ekmJaMbKkMZmZlyN0ewQtxUHMdg5+AKFpixiRfa1hBCwTZybboWr15jDss8QlMtbsrr5RJibLFkb6hw8ikMi9So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PMrdRguP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4146f2b3fafso8134925e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 08:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711036173; x=1711640973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nn0KXLTmKo1UAHS+ioXMLgSp1Jk0+gNJVUyK//P+Ags=;
        b=PMrdRguP2ivpzCDwlpDiGj7Y33QDj9TXMe8qZDuExe9fO0k69kvZgx0AUTyFzAHUtM
         ogjIWBCLEg+voM0Ix7SMZMwC4ji1RXw3RCzIQ9j99/ZPvJ3hzkioHac7FZxp8qEkBaSm
         utk3u/RZ3SJJzQol5EyTlY9WkG4XnI/L1IaghSPMrKNVmYI6NLe9YW0MJphqIxc6b+6q
         9/WlE6s0MH/782ma4zQ5KeH0MLB0go50vYgRNcMHVWsMlTK4t2IiGerfq764d6hoJYar
         XKy9HR7YnWMpJvE+UhIocNUbzfpeuHYem9+Y40kIJL+k00Tktc1NiuZZIuXJnAwKCgTy
         YNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711036173; x=1711640973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nn0KXLTmKo1UAHS+ioXMLgSp1Jk0+gNJVUyK//P+Ags=;
        b=W9DxOjhJfeS4rDQI6uHjYzFEbARex4EiUWXj1cni2sbcJ0/HUr6bcXqLHlhvTLCWvv
         ONjqdEnotIPmGDX8X0pWhQC2vdwJ/hOCDFEezuoBPvrO+y7Amf+Of3cKj1/jTrj4p7Wc
         KexQKLE4DS4cs+HJnEyWGu0M+LCfS9DSorr+3X0uieqMoqutjziY+LQzMSRTwsyuyQMs
         Id+1kGoJtyN1R/PWKh9Ylyt04kZSbd8+d+qiXfj9Fx1u3p1eBnso+0YoGIT9LyGDa8ky
         GLCcFfMsBVrwIYy8v7brwVoy3XAjjlhqLrXcLL7zWanblHBxbcCq2d+ie434bFlUp01m
         qHKA==
X-Forwarded-Encrypted: i=1; AJvYcCXUmRk91yGvYnPDkXPvWPrzURVc9F+j+I+TpIdno8Nty/2SShDe0Twsma5Algs8fl9kLCJ8tEXbUTQH+cUuLnOsk/u57ZbF4Taw6/Pi
X-Gm-Message-State: AOJu0YwnkbyuOBE8LXBubEpeUEvLk6y+PupZsxtIn4CJgomG41681uP8
	d8pHDVqgsMBxHqijZXgXBvG7qljxFbCFLSUkgOBCYzsxkRzCbgJymJ7rYaj77hA=
X-Google-Smtp-Source: AGHT+IHS0COvGmxGWKzVrLFKmJH2kCt88HgGRRr5C/qE0aKfK7wiVDsrmhkHV9SjTOUK91PmmME4Iw==
X-Received: by 2002:a05:600c:218e:b0:414:a6d:52d8 with SMTP id e14-20020a05600c218e00b004140a6d52d8mr1687053wme.17.1711036172968;
        Thu, 21 Mar 2024 08:49:32 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id jh2-20020a05600ca08200b00413e63bb140sm5997582wmb.41.2024.03.21.08.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 08:49:32 -0700 (PDT)
Date: Thu, 21 Mar 2024 18:49:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 net] ice: Fix freeing uninitialized pointers
Message-ID: <dd392ed9-9f68-4364-bc9a-ab95d6b54cda@moroto.mountain>
References: <0efe132b-b343-4438-bb00-5a4b82722ed3@moroto.mountain>
 <ZfxTjYUPAFz_LRlk@nanopsycho>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfxTjYUPAFz_LRlk@nanopsycho>

On Thu, Mar 21, 2024 at 04:34:37PM +0100, Jiri Pirko wrote:
> >The change to ice_update_link_info() isn't required because it's
> >assigned on the very next line...  But I did that because it's harmless
> >and makes __free() stuff easier to verify.  I felt like moving the
> >declarations into the code would be controversial and it also ends up
> >making the lines really long.
> >
> >		goto goto err_unroll_sched;
> >
> >	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree) =
> >		kzalloc(sizeof(*pcaps), GFP_KERNEL);
> 
> Yeah, that is why I'm proposing KZALLOC_FREE helper:
> https://lore.kernel.org/all/20240315132249.2515468-1-jiri@resnulli.us/
> 

I like the idea, but I'm not keen on the format.  What about something
like?

#define __ALLOC(p) p __free(kfree) = kzalloc(sizeof(*p), GFP_KERNEL)

	struct ice_aqc_get_phy_caps_data *__ALLOC(pcaps);

I'm not a huge fan of putting functions which can fail into the
declaration block but I feel like we're going to officially say that
small allocations can't fail.

https://lwn.net/Articles/964793/
https://lore.kernel.org/all/170925937840.24797.2167230750547152404@noble.neil.brown.name/

Normally we would try to delay the allocations until after all the
sanity checks have run but that's optimizing for the failure case.  In
the normal case we're going to want these allocations.

regards,
damn carpenter

