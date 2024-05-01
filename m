Return-Path: <linux-kernel+bounces-165383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A678B8C16
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06B80B22B07
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195D338DD3;
	Wed,  1 May 2024 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmgYF5og"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB05539B;
	Wed,  1 May 2024 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714574676; cv=none; b=O5KDi2fGbPkP0wbjl3+3dFv3aSs8yqVQl0TPwsfVJAFfLRS4+BvdLydCKR7Juk4Lhm5I6+Pi4mexzYKJf1S9M5vKQXnn0XVHlHmEF05BCmlyyjKUFXlz/lSxaL4J4fU9IbvgIsldVJ4NQiD2D7aJsIgyIIdiejViFL0Muz0aIik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714574676; c=relaxed/simple;
	bh=30HPuZ58E7cYWRUYfILDJ24COeg/BX7Wpsp0mUvZlf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1BMI2g8fHaiwNZhNVBu23SepFBzm9EtUA0gq0U7wT3BYvwfuh6DWHV5kNL9IHvxIY3q9bHuC6Hx0fBt9q9GcztRYIanrfTfWpwLGsD3kDoKZQstS7VFIjOofLpbyqsxYCSS9jGHCBiLK3B9y4Hvk0wBfWOtWe9DH8AJbW5vlgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmgYF5og; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ee12766586so680891b3a.0;
        Wed, 01 May 2024 07:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714574674; x=1715179474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jz3Dws+0Ba3z4vjOW72cUWWmnziT6zcAd3qWk//p20c=;
        b=CmgYF5oggM25fUmyJKOUk8qMm136LfLSAIqP33Bxb+lGrAZ465D+OHb+vdjHKXZdQ3
         lSwR4gz2Us340PJ8XtmO5wMRvqHRLv15+Sm20cy8M7rdJgvYfvw9I6w0eY5sgmtO0gfs
         p3/7YzqNIOXjb/rdlO0B9nBPEPkYQOTRmJ+sxTiAw1XkknmjfLZG66Ff3hdTdmRx/2y1
         fuGZkKwlI6t0OpfvcA/kZi61bTSg1O752bfIz1Gk++5U4Nh8gQ/e5jNij4qRBJHe0nu6
         M72KuBX7G9zRCWqRnUyx9/H715oqXqSCz6JhB1/hBWvEeiNp9ywr2t74VvQ58Npv33NI
         jwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714574674; x=1715179474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jz3Dws+0Ba3z4vjOW72cUWWmnziT6zcAd3qWk//p20c=;
        b=a0T1mFpFbNLjZQ+b5+J8vqURS2lieX8+YgjeHYTXMmwbLiFIZoz8pYrtwOvjXpGdXK
         TNH1VaD3AsvASJPYv3GZi/M/iiO7EC8DnOXyFX+xqQsL5qxVL/BV9Y6ppqnCaGpnDR2q
         JWRt7+cLf9Ty7hf6EYl8Op4qUriMUufABcWwcNmtWHStdjvef95HvwUUxOmIs5CrppnV
         bn33hjG7TVt90k660yqcSCNN9LcHob1gz2Oh23/48DdPIAQOYZugeyXBJYo3tgUWq1SB
         aYFk4SZDpLYnyolqLYtCTu4OnqOtZQg62CDQ8MmvPawsAbRDI+IbHhtIvD1lld3WyXAL
         bidA==
X-Forwarded-Encrypted: i=1; AJvYcCV46RF2Q/IVu8siLXDZII/TeWiH425KfqECt+9TfkAJjOPFx9q5zjvTlMPN76oO5bnAwHKp8o/wQk9dTsqMB7tm8pvar+dsfkeihRmZc2vEufKJ6pl3Zkx4HeWpJaIq/Hcat29uX5k=
X-Gm-Message-State: AOJu0YzJlYmXMp/VWI4KerGGChMCRewlSEZT0brz9IHV6z/mDPCyWb/1
	S49IYN2t50bc9Ph1bFmqucQ0nXV1EbxXXUgyl3sW/X8slSTUX7Jo
X-Google-Smtp-Source: AGHT+IHjI5fx+6c98bbfYhluopqGEWiSnIU5oVpetFWGMd4H591d0gOF/Oe4LxaFY0zdDXm0vM4XfQ==
X-Received: by 2002:a05:6a00:3d05:b0:6ec:fa34:34ab with SMTP id lo5-20020a056a003d0500b006ecfa3434abmr5114877pfb.9.1714574674106;
        Wed, 01 May 2024 07:44:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y9-20020a056a00038900b006ecf3ff65absm22644496pfs.104.2024.05.01.07.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 07:44:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 1 May 2024 07:44:32 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "sh: Handle calling csum_partial with misaligned
 data"
Message-ID: <a489b335-9174-40b1-8ffd-a34eb83fa8c3@roeck-us.net>
References: <20240324231804.841099-1-linux@roeck-us.net>
 <059d03a5da257660fa0bc188c6cc8d0152e97704.camel@physik.fu-berlin.de>
 <a9ac59cd-82db-45a0-9f85-ec3880c54dbf@roeck-us.net>
 <cb8d3d2a-b843-49d5-a219-10a29b5877d0@roeck-us.net>
 <1e77ade4fb1d924ffaf226cb946ba3314ba59a1d.camel@physik.fu-berlin.de>
 <fb0293d85dbf82341c6b7e4d56fe8f1d23f7768a.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb0293d85dbf82341c6b7e4d56fe8f1d23f7768a.camel@physik.fu-berlin.de>

On Wed, May 01, 2024 at 10:28:11AM +0200, John Paul Adrian Glaubitz wrote:
> > > Did you have time to test this on real hardware ?
> > 
> > Not yet. I just returned from Easter holidays and need to get synced with work first.
> 
> I might have to skip this for v6.10 as I haven't been able to test this yet.
> 
> I agree with the change in general, but I want to make sure I can reproduce
> this on real hardware.
> 

No worries, This is not a new problem, after all, so it doesn't really make
much of a difference.

Guenter

