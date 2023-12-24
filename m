Return-Path: <linux-kernel+bounces-10674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAF381D88D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 10:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824FB28225D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 09:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573BB1C29;
	Sun, 24 Dec 2023 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGBnclPC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDB915A1;
	Sun, 24 Dec 2023 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ccaf5955aeso13919141fa.0;
        Sun, 24 Dec 2023 01:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703409040; x=1704013840; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBVE73X6pZtCh4ZrtD3z2JLYV2oRce/Nn8OnEwMxt2Y=;
        b=DGBnclPC73PnM1GXLCS+/l5siubdS/sOzbevFl91Q5n5UKQfVeXsHXw+OVps8S2HAX
         UKWGYZhB24Nt7bDhVL1NIR0vl6Wm2OR9gjcSf5semeGZ6XVZcBWPboslliG3OmsQ3Hel
         kbz8ITQqcoMJRoGvJOAVjqbMis2t/090rKlXevSQyg7AhxVXamhF0kuoQKClyCxejcQx
         8PjfFJfSY06bgC3MVHao0ryVArVvjcfpCFp1HprS/FgErbDIxHdubPqaxUrfXC4Ljq6B
         FuvL9Lu801q4MVNrr1CHjiGcDOAm8Pa0BoFRgtRAeWc33Daj7yD3XGIgiurHkbKUyDlF
         /F+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703409040; x=1704013840;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PBVE73X6pZtCh4ZrtD3z2JLYV2oRce/Nn8OnEwMxt2Y=;
        b=As2JfQy6m5G7XqclYRX3K62arm//LYMd8aDOxzwfLEiGK3pf7kxlgLS8DdXOhg1ipU
         /w58KKSM6HbuDJQtxEl7sMeGPi/4CvXMKgsdXllQROXGqt6LUz5XH/W0J3mOMAWsAF3o
         D/u9eQ7tJKk7v3ZTjhLjNYx2j5dVulc9wGgfi9mLBaLy5AaSpo7AJp+nG4r07zUE7xv7
         YytSkBht1xXQj5S08Ltfp6qRCH/qBFl9r4nsZvIsTsIQ/GyHfxSfKFPLnejyF1603ckd
         PXxxznoxdkJajYDK07NbyzWp7Cgy9Yl5k/UglRiI2wuntfN7NKH1Txua2VoFp3AaWzCq
         hIUQ==
X-Gm-Message-State: AOJu0YwbYU6PsPRidjacRCrL50qxMHk1L0mbAOf7hS34zesLhun58eKl
	QUoQI/a/U8tI1mAVbD3fwCHulx0ClEw=
X-Google-Smtp-Source: AGHT+IGbGhfwbIQh5L6tQlH6hypy0vrbD6qQqLcA+Pvp6baySYLC0RQF+XBCeT6K2nWmJmJgyUP/LQ==
X-Received: by 2002:a05:651c:19a0:b0:2cc:bfe7:b81e with SMTP id bx32-20020a05651c19a000b002ccbfe7b81emr291622ljb.58.1703409039532;
        Sun, 24 Dec 2023 01:10:39 -0800 (PST)
Received: from [192.168.1.104] ([31.173.87.203])
        by smtp.gmail.com with ESMTPSA id x27-20020a05651c105b00b002ccb5fbdc76sm571218ljm.120.2023.12.24.01.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Dec 2023 01:10:39 -0800 (PST)
Subject: Re: [PATCH] usb: core: Add quirk for Logitech Rallybar
To: Ricardo Ribalda <ribalda@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231222-rallybar-v1-1-82b2a4d3106f@chromium.org>
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <f955e3c8-580e-5d8b-a71b-06ebabd6a0ff@gmail.com>
Date: Sun, 24 Dec 2023 12:10:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231222-rallybar-v1-1-82b2a4d3106f@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 12/23/23 1:48 AM, Ricardo Ribalda wrote:

> Logitech Rallybar devices, despite behaving as UVC camera, they have a

   "They" not meeded here...

> different power management system than the rest of the other Logitech
> cameras.
> 
> USB_QUIRK_RESET_RESUME causes undesired USB disconnects, that make the
> device unusable.
> 
> These are the only two devices that have this behavior, and we do not
> have the list of devices that require USB_QUIRK_RESET_RESUME, so lets
> create a new lit for them that un-apply the USB_QUIRK_RESET_RESUME

   s/lit/list/?

> quirk.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

[...]

MBR, Sergey

