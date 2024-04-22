Return-Path: <linux-kernel+bounces-153036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDA08AC827
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97EE3283770
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79ABA535D2;
	Mon, 22 Apr 2024 08:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LJPvJdYf"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB5352F70
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713776072; cv=none; b=ggbp3j5TB3fN3w7DOEl9hbb5XviRk80aHANGIHS3mCnVlMALF7S8U2gUiSDnobnEbkyLwGEmREQ1cRJnIN4cHwerJoxR+j8GZoRhkYz2oh3DmNgjqF13ej2y8uOu5ct3AJcL7GOOTLOa/kMofG6kUGNwrP+nqpyFq9m4H6Fu8QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713776072; c=relaxed/simple;
	bh=Ojlb8Qt0GEEE4R5EwrEjmiMm5jfeRBt1cc/0bYnuMEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HREX6RtOvsXlMKRMuWPwUCu/hiGx8VMHwjawBDY2CJ5Otytfccrx6wiUhzdZll5DdciorI+04ljl0osihs+UyND77zchsxb97rsckcP+veMga9s/+hSj4vzzdqdCMzvBxgT6GxteQ/bCaSL4Vq6IjLyDC9Hh+yUWKzVvb88KKjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LJPvJdYf; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41a523e2888so4517985e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 01:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713776069; x=1714380869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ojlb8Qt0GEEE4R5EwrEjmiMm5jfeRBt1cc/0bYnuMEU=;
        b=LJPvJdYfzCOidJJq73BMPDAC8MQv0mpbRbL6XNN/KyQyssMb6hl4aspFxewZsgCVPK
         tXoG2vlqumypH7N8F7/fva8Mm7LmzK8/5qcOU9mpX25/4XrA5iPv8qViXE7Rk9zDLlqs
         yluEothypDf3RpGU4vl41PbGGe3P+NXXPIUtp8nT58OtjjOhh4oC+QOZIMVl+MDw45Y4
         WBrIBYnEuCI2CRaiHAsg9FAK/XNmmRPtKNG3r/Jmw6xuvXSzfaWwR143F7tOE5jxF627
         M4NMqW/c55JA+ThSG9N5v81iHwSkcI5huLdvV6N/TwFFDLsPXmdbYGdqrpmxEyFk/EUh
         BQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713776069; x=1714380869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ojlb8Qt0GEEE4R5EwrEjmiMm5jfeRBt1cc/0bYnuMEU=;
        b=Vcqw8htIogP0ERWILz5OYF9URHGjXJC3/U8y1WzaPQQ3T6J3kPO0Za0X+Tx3TYjAWN
         vhS5IMyMVFjwfi/We/F4NAtv6FLUA6cIossVTMVgFhGdmbcetfuB7Yctf8MfUsWfVp2S
         OAe8g+WmY9Hkbx7MsGABKGMEPgyQtWys9arNiWMOvpjAMHbLB25e5E4Xq/TSL2Q56ekU
         lGJJnXOESaKApDoHholV4ZKBRyguw7a/mDweAq5Igbk3MUVc+8OkKUp5k7xT5108fl1P
         VHZx+Ii6Wv/CrysBVv1rteUZZ9qbKiOrDGsNXMZ2CSLK6jOE3Mrzs2cltcO82YcROpVI
         GznA==
X-Forwarded-Encrypted: i=1; AJvYcCWT6fnpbwunp1kVIMarl5PPyp7XVsP2ZSP+7ouzAyhj4pxFGInRDAZpEjBzbDhzAnyHqd+tKrQo2J7PbIywBifBuS4vhxYU3UfR0wb5
X-Gm-Message-State: AOJu0YzRY7443ul+22aOHhMy521c/daLggaPAKB3mG3XtFoCxBvEbnAj
	YhQijt7Ko9itz8jaLxWBGkBxyodZ9FYxDfHLINHthor/IRMuMQ26cLoGNKR06QI=
X-Google-Smtp-Source: AGHT+IE7k4brxBhxy5f7GNJIFfsaxDyj1gLwlLlyGFa1Xx9lcO7UuR/zgUeMyHEzAhs2lPsesXwQ/g==
X-Received: by 2002:a05:600c:3586:b0:419:f447:c323 with SMTP id p6-20020a05600c358600b00419f447c323mr5006365wmq.27.1713776069623;
        Mon, 22 Apr 2024 01:54:29 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id jx12-20020a05600c578c00b0041674bf7d4csm19372412wmb.48.2024.04.22.01.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 01:54:29 -0700 (PDT)
Date: Mon, 22 Apr 2024 09:54:27 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Shresth Prasad <shresthprasad7@gmail.com>
Cc: lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH v2][next] backlight: sky81452-backlight: Remove
 unnecessary call to of_node_get
Message-ID: <20240422085427.GA1290623@aspen.lan>
References: <20240421104916.312588-2-shresthprasad7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240421104916.312588-2-shresthprasad7@gmail.com>

On Sun, Apr 21, 2024 at 04:19:17PM +0530, Shresth Prasad wrote:
> `dev->of_node` already has a reference to the device_node and calling
> of_node_get on it is unnecessary. All conresponding calls to
> of_node_put are also removed.
>
> Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

