Return-Path: <linux-kernel+bounces-123806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F7C890E53
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D6AA288733
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5F454913;
	Thu, 28 Mar 2024 23:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IO5XsPnw"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D861CAA4
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 23:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711667452; cv=none; b=nux6bLEs6U7Y+f4bNKqyUvc0CZVguTvAAxoB1MazS9Asr8eZkemhMbX7SGnAVD8HXBWmd2yaqEHrNTv5CWJM5KFjrWeh6rsHYsLiNKXdCXvpX655qwYj7Zo9lMJa1HOMOlJO/qoyFYPCRj7+H/j442vjNqnBPfEkbN9a490oIgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711667452; c=relaxed/simple;
	bh=0y8coj0+mQQPGC8OXljV4UuS/PYbmLCErGfzrrSuPSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2d43LtPWYNsQbQoRWPsnICMCRhwict3z4JpHpIRKK201AOlqVFJcsNjfS+m775tGcsmNEMWZHVShs4sIOY2YSLZrDwOPgttP3v5jDjem5p2Dk1Oktnc7Ws7o/BNEiAQN4IGH3yoWjQLgfSCPbj02rMdNBEV0lRDPRkERJH+spU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IO5XsPnw; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7d0486e3250so59104339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711667450; x=1712272250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pmlJUaTfqfou50yhLN4yiBmfHrUkQYfBdioXp5GpAWg=;
        b=IO5XsPnwaTiW7ZBYu3+jh/ziVQdFRno0buC9ee3SnHwOlEfNwVoE0v++1TQpo9UkY1
         z1/eHXvmfkEbRd5GhxkR7cdZJD1Su+fbY6YPDHz72Axm5zlGbltmIisYP/t/cyjUPDtA
         ErZp4JvMx5zOzfqD2hiMTorNIuhGWJa3pjZ1sQilx2ZaxSNvbwTBFSXdZnMYmpPob75p
         C6Ej0XuhclqvgqHvgGjDDEsFBKGRPswstCDbXmLvqgpPr5ns+EHbnMN/eX2U62jQKWPa
         x8EeatuMVHgx8FHJ4ph4MYqqmDMUcDfU2IxVAhNFZC2ALVKUmOSiC881mKhpf5eXbGCG
         LTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711667450; x=1712272250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmlJUaTfqfou50yhLN4yiBmfHrUkQYfBdioXp5GpAWg=;
        b=JYB70TkuY4UY+w7IGAnjpvaMVZOudw1ulrkKwySdgncDxBZT4IH/wOalHKltCEuuAg
         Zgij5IkbVq6npc21QuGn05KcXLLv5ykxgwJncIdih5Qqq0/6ASdk9aq+mxAKsu54sGLi
         aK6PJRy/hO7d4ZJAZLW7PGMT6GiR46KqtawD3DTma1hyZNsRBM6EGVj5U0dXJh0j+9fP
         9JDx/PLIOc3+I3aMeEiYi/yxMewebGL5ZMLQSReFjDz0a7Gj9izJDmkI2S/TNJsx5/Ol
         +aWDsRyccf1q+WUbrIgA3kW8qGnP/pg61nlUII7TTxQFi/6qWgqk6OSt0XK5vmABS8hZ
         T7uA==
X-Gm-Message-State: AOJu0YyguLpiwIu3q2p1ShQjWV3Mk3k47dPjHemDzI/jW17Cp06+sGxI
	A7WfBXXitjltLJNtjSOWqcnGEu6hRfuzJTSbncU3D5L2VnDQ0EG08iXqIedPmQ==
X-Google-Smtp-Source: AGHT+IHQfPBAN6+CqMvntTVcDubTpW2Aufa4WgLyOK0enhUXjNvXbnr12eNJW5kapUHT3+2CUrQ0lQ==
X-Received: by 2002:a5d:9485:0:b0:7d0:23b2:c96e with SMTP id v5-20020a5d9485000000b007d023b2c96emr752226ioj.5.1711667450017;
        Thu, 28 Mar 2024 16:10:50 -0700 (PDT)
Received: from google.com (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id r1-20020a056638130100b0047ecdebb896sm231622jad.16.2024.03.28.16.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 16:10:48 -0700 (PDT)
Date: Thu, 28 Mar 2024 23:10:44 +0000
From: Justin Stitt <justinstitt@google.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 01/11] staging: vc04_services: changen strncpy() to
 strscpy_pad()
Message-ID: <hbwxiid52lv2dq7rdtvard3up46khu5uv335tzavwag3v6s6jl@dzjrnooz553m>
References: <20240328140512.4148825-1-arnd@kernel.org>
 <20240328140512.4148825-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328140512.4148825-2-arnd@kernel.org>

Hi,

On Thu, Mar 28, 2024 at 03:04:45PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc-14 warns about this strncpy() that results in a non-terminated
> string for an overflow:
> 
> In file included from include/linux/string.h:369,
>                  from drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c:20:
> In function 'strncpy',
>     inlined from 'create_component' at drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c:940:2:
> include/linux/fortify-string.h:108:33: error: '__builtin_strncpy' specified bound 128 equals destination size [-Werror=stringop-truncation]
> 
> Change it to strscpy_pad(), which produces a properly terminated and
> zero-padded string.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

If there is other review that warrants a change, we might as well switch
over to the new 2-argument version of strscpy{_pad}() introduced in
Commit e6584c3964f2f ("string: Allow 2-argument strscpy()"). No need to
change for only this reason, though.

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> index 258aa0e37f55..6ca5797aeae5 100644
> --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> @@ -937,8 +937,8 @@ static int create_component(struct vchiq_mmal_instance *instance,
>  	/* build component create message */
>  	m.h.type = MMAL_MSG_TYPE_COMPONENT_CREATE;
>  	m.u.component_create.client_component = component->client_component;
> -	strncpy(m.u.component_create.name, name,
> -		sizeof(m.u.component_create.name));
> +	strscpy_pad(m.u.component_create.name, name,
> +		    sizeof(m.u.component_create.name));
>  
>  	ret = send_synchronous_mmal_msg(instance, &m,
>  					sizeof(m.u.component_create),
> -- 
> 2.39.2
> 

Thanks
Justin

