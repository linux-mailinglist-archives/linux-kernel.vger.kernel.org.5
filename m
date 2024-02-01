Return-Path: <linux-kernel+bounces-48180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497A984584C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038C8284286
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1E38665E;
	Thu,  1 Feb 2024 12:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="IpGk9qCS"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C74C8664E
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706792244; cv=none; b=FbL2O8FMJN0WjbJreGVq3eKTzG5f7o+U9PxrZqmBZlM0sLIYhxnSwCMR0U7AaMZ5HtCgZB75E9Jw6NKTk4SRBfkDyyurxudtIHbrp+sBj60ptb10G/zSMU6OR88lyEMharBS1+3+FL12F3maz/qG5O+Yv/3HhFHmGdJw86Xl2T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706792244; c=relaxed/simple;
	bh=JA6kcM7RfKhUH5r5RJEs2EEkeq9o7pz0HEuBZXSaz68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Azue+GngUURyqh1Z75enxokyLe4rBKsM2pbUWxwBfp210YcyFMVqK9o1SxWjQPjhZjRLHT1yZMOeMJn3YK3iZ4Zs6uv7s9RWwEIfPjfkwV0O1UMNiv62BbWtS5rGlwjN5EU3X3cFTznYXCU7mQETgk51vaZQaqWxqtDZx48jPec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=IpGk9qCS; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e7065b7bdso7450785e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 04:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706792241; x=1707397041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JA6kcM7RfKhUH5r5RJEs2EEkeq9o7pz0HEuBZXSaz68=;
        b=IpGk9qCSsgyNE44t72nR9YSNz1I8gXxBWP0T9oxS10hdsQk40l8d+1SXvfA05kA8lv
         ZawMz9YndQZj6a2FqyL6REaNg/UgVGgJxldWKNCazZWj1p5ekufskJ8cYZ2qNFL92mho
         SBDGDGaJzFpxB7/PLKFYpQw4gD85F9wNa4kP4BSa3JeqdyK67cM/vrsCKLHBQe/15g3A
         qINZT+ZeqHNuOBsbt6lA2dRCQWN3REoJ6YOWojCj3ebYpTlRPX3OWYNwx+BsWgV4leyd
         lGB+nosYP+Uox5zsKuRiwosRdlzYWmtyitTa5pQcyIf/upvI99bzQPLreeI55McFgMxK
         SMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706792241; x=1707397041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JA6kcM7RfKhUH5r5RJEs2EEkeq9o7pz0HEuBZXSaz68=;
        b=VeJuiolpOwetz6z7cmOvpnPNQfdDhPuK/TTNFzWAmyykkDKt36GdNrtwZzaUPf5VaI
         /tubo+myHNSScUFR+T3SozZ45tzdllsptz5OCFxHRzTuNpbPUTUOhIaXrDNbCXfQEGsT
         r9n3VElbsHFRlWwcQBYbM3ykHWA+WdLXfZywmlm8X1xfzKLhCbW4JxCPRTzwl2wQFiQP
         WTuepYWm2dTiGk8ivpP+IUyJARYnmZiG8LeWBchFoPnRJkgcJz5bkQJlZZxH/+LZOofR
         yO7tuXNXDFetqrUJ53BekbiYVOtefjQ59qAiDLxyz6NbSq2ga/F0wcukbL2Jslz6YL0n
         YAJw==
X-Gm-Message-State: AOJu0YzNakV2tYQQoPsQdNnJ4nJSIBV0JP7EZgr2P4aqSxodIFgdqiSq
	arxN1aOeQRPIy0HbCm4i9nkQfMdsvQedImqlBEdwfrqSb/NVAta9LdCIf1d412A=
X-Google-Smtp-Source: AGHT+IF7bWHVjtlzV4nYixkAlVqWFWJ31Vy1BovZd3K/8w/E92PGZGN/5E1zwdq430FWylGSyEvvkQ==
X-Received: by 2002:a05:600c:46cf:b0:40f:bd81:e738 with SMTP id q15-20020a05600c46cf00b0040fbd81e738mr1180090wmo.29.1706792241181;
        Thu, 01 Feb 2024 04:57:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV/WsZhiVM7lHdbIs2EwARWsK7t67gKeQBkjX8kfXNuL1MR/nnHCs9TltYmTRDzTFo9iWtFBNvTFhePoox/qTTZyy3CWACyiie2hipb2zT1vMwNxkKlFqLoPnIk82eDEhL4ZZS8bdL8D1/OLan+KmHDT2KFANPFrr1t/wI3CGkgn06QA5iA6I5AUrP2Lhx3axfXuqLcCSQ7oCefeGrlbStD7/Mfv+Ml3mV3ZqVtjIg1K4nTmCs0DhyYZYRQQn3CncW/GSv4Qis=
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id q18-20020a05600c46d200b0040efd192a95sm4428156wmo.1.2024.02.01.04.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 04:57:20 -0800 (PST)
Date: Thu, 1 Feb 2024 13:57:18 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Yunjian Wang <wangyunjian@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com, kuba@kernel.org,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xudingke@huawei.com
Subject: Re: [PATCH net-next] tun: Implement ethtool's get_channels() callback
Message-ID: <ZbuVLlqKxskEoamq@nanopsycho>
References: <1706789109-36556-1-git-send-email-wangyunjian@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1706789109-36556-1-git-send-email-wangyunjian@huawei.com>

Thu, Feb 01, 2024 at 01:05:09PM CET, wangyunjian@huawei.com wrote:
>Implement the tun .get_channels functionality. This feature is necessary
>for some tools, such as libxdp, which need to retrieve the queue count.
>
>Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

