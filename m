Return-Path: <linux-kernel+bounces-109260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 967358816EA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 379A9B21414
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE6F6A35F;
	Wed, 20 Mar 2024 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cS0C06tz"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0F61E49B;
	Wed, 20 Mar 2024 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957460; cv=none; b=KWcly4M7ggRikmbJ9lrBwFkGr5TWsV52NaDwAlpMn647XQyKpY38QLiBzGLKLlHmFKSPeerbe5SZ6rseemsKemPYuGzS3FrJZ7cQlvyxkBi6tIMZtaC36gegnvmlGmkBdo8VjueypD41vLDZ/9XKB0SgEuS3d+SyOFrndVDsXLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957460; c=relaxed/simple;
	bh=m8HMpkp3Ija5+aozkUZQ69YAEYrm43pkhpPtMTD/pi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJQbyzGmr8YV0T2jn2rF25ICA1Ll/5JjI7BL3AQ4PN0oPUGuiIDr/W5zlcqusovgiCYL8cRNCLMvGHWeGXp5Mf1DWwZYN+R+oc3tnsMx4sGAoa8DF952223lLGDL9CMvFZ4/w9DdLGVvjR6k3hpPS0oSOfwEddToeaDTOcBhYi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cS0C06tz; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e74bd85f26so160029b3a.1;
        Wed, 20 Mar 2024 10:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710957458; x=1711562258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDfSPb8l7GG7oLbxOIDW4/dlXcVC3Y//bNvSJJG/gxI=;
        b=cS0C06tzdWcO2kaG0IOTLtPBayvZKyVoDMYmC/QLrI897YudTmhDURvvocAfHXGNqN
         bdl1aj74hFYYBVzASOadudCDq+j7YRsueghAIqu8dSgsIj4FPC/3BcIAlR/8d5nQCa5W
         qlPDMXuot9TDdPlPyQWglQxn5uYzD1enbqPX+OpFszk2ZRhn3fSHSznBL2wafJClyv1d
         CXrUlvepzmQBoyRzQnJUKPOUSdBXaqCzsfeFdhCOTwrqd+gRbL/301jYUABwDyfatLZi
         6nQyPenwci4A3f5KqoshXrNHZtFolhXV0QWl2jZtp0uOpQmD6B+dgHohxFKweNkxPk/V
         qB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710957458; x=1711562258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SDfSPb8l7GG7oLbxOIDW4/dlXcVC3Y//bNvSJJG/gxI=;
        b=T2Fz0HiOsYUM94tQfGsXTLy3+cVjPhwxsodhVIdfA4X2S1Hg6QVqKdn+pWPfLXNZ7k
         MoN7PM0tx9CvFLM8WfZLCaBzEvzb16fZUeINC+Gm5GvGZHKeRjUsh3+5iOyF/GBKdFZq
         WtSrAklf3pAwYFoMqmrbOunGtg1zzXRCy79qPLfizNp5CZD64+XxZ0sEG6Z5vO93X6bI
         /0CkVxsZSzZ3gYRayI5ernwXBZL76BWTBjCgDWXuojV3dgVZrgbJwPXIBpY9BuLzz7qd
         xwdRq7DdyPmTzHuVANKM2KY1L1ncqhjJb91bGJ/06yEY7TYsrynCTvkqCDKm0WV1pmQl
         31wQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3PoLAdvKyOJdfayNK2NIB5Z3aDq8NbqlWYPzZO5NaMwTXaALESjV8FgtCeXLNGJesKcDsbo6uSS0lX5p2QeY//rYzLMEbq0NAoskh07ePZDLMUlCiavWnFHE9KyGKH0Fk4048oZI=
X-Gm-Message-State: AOJu0YzkXI2SFy6IK/HLObv/IHqLzaKRLTrVE/kYxux8UJTiCiupMGMQ
	tyDorma6mZovqiKWQ9KkyMJ0pwAeSYZM9B/UaccXiKFM1GHzlSnr
X-Google-Smtp-Source: AGHT+IGUBHP10ptXH0poZtV8r4rtr/jPPrYxkkQnqC5bnL4dDK2bANsLAQ7mFcX7pDaWtd78XVwWdA==
X-Received: by 2002:a05:6a00:398a:b0:6e6:9b50:8c73 with SMTP id fi10-20020a056a00398a00b006e69b508c73mr17212485pfb.15.1710957458498;
        Wed, 20 Mar 2024 10:57:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 16-20020a056a00071000b006e47e57d976sm11889521pfl.166.2024.03.20.10.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 10:57:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 20 Mar 2024 10:57:37 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kousik Sanagavarapu <five231003@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH v2 2/2] hwmon: lm70: fix links in doc and comments
Message-ID: <6f5f3110-355e-4933-840d-735b90d53ee6@roeck-us.net>
References: <20240318130840.74589-1-five231003@gmail.com>
 <20240318154540.90613-1-five231003@gmail.com>
 <20240318154540.90613-3-five231003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318154540.90613-3-five231003@gmail.com>

On Mon, Mar 18, 2024 at 09:08:35PM +0530, Kousik Sanagavarapu wrote:
> Update links in the documentation and in-code comments which point to
> the datasheet.
> 
> The current links don't work because National Semiconductor (which is
> the manufacturer of this board and lm70) has been a part of Texas
> Instruments since 2011 and hence http://www.national.com/ doesn't work
> anymore.
> 
> Fixes: e1a8e913f97e ("[PATCH] lm70: New hardware monitoring driver")
> Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>

Applied to hwmon-next.

Please note that I'll push the branch after the commit window closed.

Thanks,
Guenter

