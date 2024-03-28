Return-Path: <linux-kernel+bounces-123588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DF1890B64
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D594D296174
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234DF13A89E;
	Thu, 28 Mar 2024 20:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjeOnd2g"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A51581AAA;
	Thu, 28 Mar 2024 20:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658091; cv=none; b=tzo8joP3zQF3JA2OT0PYCjsMzsUeN7bwTwc36Pe/Bu0iEiXteuQqiHE6NCQOY6i7M0xmKsANtYei40BQ6rwAFspqq/gBnAnY4d/Jrz+DLrr1+p8qKeX/As141FyxMb4Vj9I4WyT7keHblL2l822Fpk8+p5Pk2gD2Xj9husweLGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658091; c=relaxed/simple;
	bh=DSSn4dYb57i6Mxgq4Q5lhmvmsupd4EPzrI7J2K9/zyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6RL1bqzEEnLz6MCl4byp/MZN534y3s8sriUYrAhwVx5285FF0dmm4aGKgoP+y6jEcTeg0FJ0S8d+MevuH715XxfOaGYUjYp6avFWc3o/M2FXjxRrRhaTZEqcoyORSDc+D5jYCaGrQmWP2hfQRYxwSVFtufYJzcUxBecRkggbcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjeOnd2g; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso1054973a12.3;
        Thu, 28 Mar 2024 13:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711658089; x=1712262889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SLbu+KB+7pwzhjMcsbthnbW/ew5+GsJMASoSWw2F5YY=;
        b=EjeOnd2gphWXxcwX0h28mXx6fUMnlXsgYHS7TzKE13Hy255++CwEy9W400gbSQIdFK
         z83629febnuvw6OCtGsSnZ432l+0p5J4VTZZQUFmOzcwHZP1SFmi7u0Zfy2KMVSDFT0t
         +n3zL0ZyTuoxZtB2rx39PXAYDX/7ORWfnT2QQL1u1p+TnHkA3l37DnIdR4ek266vR+RQ
         ++xrX9ROTGZX4HS/p5Cy0X0YNuDU3w5z9x8bjh0PeKEds7Hwb8hh8kNsGu+PluU+aXHw
         BiZabsNiSfqOqaF0T9T9pxkZcpoFUwyMIqCyDcUmMISQVFv6yrVJa8JqDsPQUETFgaPo
         ZA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711658089; x=1712262889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLbu+KB+7pwzhjMcsbthnbW/ew5+GsJMASoSWw2F5YY=;
        b=Worm0lC1Yu/xfdFyxv9dhUPi75RN4ZbuZ1kO1QsEyXpVnxOieCw6gTFANj43fPOo9q
         o4ueHTEYeOO4x7u9NACWk/fnFL6D0HoL7wIA4LtXsupRHAoKj18385j2k583g2MZvy/2
         yt06cdHqtLRa5GpAkIhVAb+vNeMnQkokNU/UMEXimhPusdibj08Xhw2ic9Odsk8UK+Yg
         4ubM55qc/05dJLK4YYUGmu8AB5TGGkVNqTURURTSn3zAH3Rh1fuQpoH8/xc+3ac9GlmT
         yJIMG2J8xx7eW6VE0GT7rfaAMla8WArrvEwLxK22H1VmGgAKzhRzCUuN7RjlCoAwkOiO
         xluQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8q4rIMYXY2EEvesI3nkQ0X3iyWEmyDHhV5SN0OmNLXxz2pCvQMAzJh32qYSFStPIsmMTm4QxVrHv09DR71VByK+JC0DNEyAibqz53vje2yEtmu17iegZ8Xdk8/besO6Kd0unPe6iPg3c=
X-Gm-Message-State: AOJu0YwpBHopIWfF8pgxXbD8VYWfy2dYrU06vBzvfEaSIwBe0ssyrlPt
	a1ettvWPWNgah22//fvhrdCdmJK31hUQGmzrxFBWHbc4VxMLFaCX
X-Google-Smtp-Source: AGHT+IGI1aEQDWHmKQBUmQs1CLDGzfkuMWxc6VD+3sktx+tNgpOrIFo2satat2f4wSA9R6zPsOQhhg==
X-Received: by 2002:a05:6a20:6717:b0:1a3:5bb3:ce11 with SMTP id q23-20020a056a20671700b001a35bb3ce11mr221125pzh.25.1711658089316;
        Thu, 28 Mar 2024 13:34:49 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:493e:82a3:49f9:d88])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902e84300b001deed044b7dsm2056462plg.185.2024.03.28.13.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 13:34:48 -0700 (PDT)
Date: Thu, 28 Mar 2024 13:34:46 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: WangYuli <wangyuli@uniontech.com>
Cc: rrangel@chromium.org, shaoyang@uniontech.com, helugang@uniontech.com,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	huangbibo <huangbibo@uniontech.com>
Subject: Re: [PATCH] Input: PS/2 - add support for Lenovo Xiaoxin keyboard
Message-ID: <ZgXUZtEwHEF8Rs3i@google.com>
References: <593C1A73FB93BACE+20240326131718.20497-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <593C1A73FB93BACE+20240326131718.20497-1-wangyuli@uniontech.com>

Hi,

On Tue, Mar 26, 2024 at 09:17:18PM +0800, WangYuli wrote:
> Modified keyboard_ids in function ps2_is_keyboard_id
> for Lenovo Xiaoxin keyboard.
> 
> Signed-off-by: yuanjianye <yuanjianye@uniontech.com>
> Signed-off-by: shaoyang <shaoyang@uniontech.com>
> Reviewed-by: huangbibo <huangbibo@uniontech.com>
> Signed-off-by: helugang <helugang@uniontech.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---
>  drivers/input/serio/libps2.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
> index 6d78a1fe00c1..39d46526c56a 100644
> --- a/drivers/input/serio/libps2.c
> +++ b/drivers/input/serio/libps2.c
> @@ -189,6 +189,7 @@ bool ps2_is_keyboard_id(u8 id_byte)
>  		0x5d,	/* Trust keyboard		*/
>  		0x60,	/* NMB SGI keyboard, translated */
>  		0x47,	/* NMB SGI keyboard		*/
> +		0x83,	/* Lenovo Xiaoxin keyboard	*/

Could you please tell me more about the keyboard? What ID does it use?
Majority of keyboards are using 0xab83, does your device forget to send
0xab by chance?

Thanks.

-- 
Dmitry

