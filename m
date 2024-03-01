Return-Path: <linux-kernel+bounces-88620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AAB86E44B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01DA9B2357F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83B56F086;
	Fri,  1 Mar 2024 15:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="jixSf8hM"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F6539FCF
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 15:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709306916; cv=none; b=WOIyAWQ4Ow2GhFeKaJVGm7X2XYRvIzyyJ8UQ68egUPWWxHiRUSLC5WrfYNAiIeQogxJ4n4vk1hc5cf5rXFWtZitDgXaTXTrGvgdTkmow063I5hlwrSivqjFEB1saIJ9V+QKvQsQHprS2jWHeKlg7BZjAQnyEE5jkfyD93Fq52fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709306916; c=relaxed/simple;
	bh=u4F02pEdXW7O5AZ78s2XrXcj0l17Khc03uRgcPoaIdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWj+u2SIBS8hwxaAW1H74ldgQGJFGcwhCYvjJxF+T7b15A6Z/L0vdSBVSsMRF3SP5lEBfQ7xcaByy60fGW9b9e7kDID1CwDSzn54E+ofd7nELRezjMeMYSoymDtnj2o0UJwKOQnSToVGFsCHg9R9j1TkegezCCxj+0hyghfx7aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=jixSf8hM; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a36126ee41eso363990366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 07:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709306912; x=1709911712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u4F02pEdXW7O5AZ78s2XrXcj0l17Khc03uRgcPoaIdI=;
        b=jixSf8hMmbfZNZBOX9z3bebEydzN65R3P98GZxRdGiZbX5DNjG/phA+7unYnDhcxo5
         MeoFlgVW+iaZjeTFrmb/0Hr2kscUBmmfIHETYS5cRvfyLSCKhvjdhxnqjk5+Mzfj3N2C
         wVTkGri1S+d+KcVUodjRETNbUruQhNFmjkLux2YY1T9oV2ZKR3U27DsNJ8xQXDfXHz75
         7pNMsl2OzDoKvj1VhGN7PMcMT1srq20hv2rEKXA/61g4CRtqj+cOleKL8Dqq+ouz8BHm
         B3NhShVDD116LYkKF+/AHWjpeawIoSgNST4A3dNoZeP39j+TlkBdjrA30s8lqCpZMBHv
         reLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709306912; x=1709911712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4F02pEdXW7O5AZ78s2XrXcj0l17Khc03uRgcPoaIdI=;
        b=XUdX1Uabc5bpoVUPvWQDi6HFGEoVxuM4jzWb6xlGf5aCTDibO84P6wX9fwaNcxJERU
         cHG55VLMxa+w+DMGHwTqM91qFhib4ud2oSDL4rDKj9u3LPkrnAgpPLzE61a6YGQcVuLT
         GbNfNbTdONVKPD47DaUAiy7/PLLyEvQnT2ErGF4I+vrsGf9fbGbpcXazEyQU0FmqmGiB
         Zau5Jo07hy+jxS26DFXy4neDyjM0NfdaHR+oTmCBFV4vylEIcjwoiiRCyGAsv/3GxBmf
         QIe7CP2rswLldZXP1jBq33vKoT31sSpCW8Ea6xm/o7WaNi7yuLLs/O1EgozLr6ZIJ4oG
         KZWg==
X-Forwarded-Encrypted: i=1; AJvYcCV8TcvLRdKm+L7gxI1KLGq/XFG8j334rCgd3ZlJWpC8xrC+KaqNSqsHTGifQJw+e480Zfl+SnyOSgOGjhgz4ZJxmWkryR+6f7mDM2Y4
X-Gm-Message-State: AOJu0Yz9tI+i4X8YHWA806dPnoyOgy/Z93WVaQ+O8s4x6UbBUxnHCB7k
	EMI1DZ/Zgexj3VbjtAWE3AkmRIlCWvUa8OHsYG3cMXqOvE5cVVH3uSV8Ikebal8=
X-Google-Smtp-Source: AGHT+IGRJCNFAp8Ays9CaMmFrq0mJYfLRWdDE0maDPH/TQunwknRwH/a47rH2ZFtsk9Der3iyPpFGA==
X-Received: by 2002:a17:906:5f90:b0:a44:29a4:46fb with SMTP id a16-20020a1709065f9000b00a4429a446fbmr1466238eju.16.1709306911814;
        Fri, 01 Mar 2024 07:28:31 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id f26-20020a170906139a00b00a4417c46efbsm1779936ejc.82.2024.03.01.07.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 07:28:30 -0800 (PST)
Date: Fri, 1 Mar 2024 16:28:27 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Lena Wang =?utf-8?B?KOeOi+WonCk=?= <Lena.Wang@mediatek.com>
Cc: "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Shiming Cheng =?utf-8?B?KOaIkOivl+aYjik=?= <Shiming.Cheng@mediatek.com>
Subject: Re: [PATCH net v4] ipv6: fib6_rules: flush route cache when rule is
 changed
Message-ID: <ZeH0G9ePaKRUTyMW@nanopsycho>
References: <09f2ab1b7946339da5092e10aa216e07c579c60b.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09f2ab1b7946339da5092e10aa216e07c579c60b.camel@mediatek.com>

Fri, Mar 01, 2024 at 03:39:46PM CET, Lena.Wang@mediatek.com wrote:
>From: Shiming Cheng <shiming.cheng@mediatek.com>
>
>When rule policy is changed, ipv6 socket cache is not refreshed.
>The sock's skb still uses a outdated route cache and was sent to
>a wrong interface.
>
>To avoid this error we should update fib node's version when
>rule is changed. Then skb's route will be reroute checked as
>route cache version is already different with fib node version.
>The route cache is refreshed to match the latest rule.
>
>Fixes: 101367c2f8c4 ("[IPV6]: Policy Routing Rules")
>Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
>Signed-off-by: Lena Wang <lena.wang@mediatek.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

