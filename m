Return-Path: <linux-kernel+bounces-146980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 332518A6DD4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B49351F21BBD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E98B130E58;
	Tue, 16 Apr 2024 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtL4/4Uy"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4985412C522;
	Tue, 16 Apr 2024 14:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276986; cv=none; b=HX480LhN3VLQR3z26Ggd3Yeu4vgNzbRstn5B3UJxqWfT0dGWCu64nk8noKd5NamvhgUnYNTkix2M7vyurVVh+VibLrWS4cj0yL4bfZGeKTx9my7j0JSTyE1QyRXtMSxj/LQP/HNDAb1m2oJ4UzCGr4RN/0Cp6EKngN4leziV0To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276986; c=relaxed/simple;
	bh=6Jaf2Kt6CfHFDNtbbwyaAm7illRxT1JxE79sD2MJt5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryynALZxeN5kX8OQLhn2UC3Q/e0UPpGuOasCSmbr2FCjtEBeuYyxblTQZWU1Bkk8xhN7WuX5BZJdO8Jd65leKhIXztJ52xxml68fRQ9J6lDJAHRf1Y86o2zm2ArqDV05aIJGCgLvGOlUDCzTGJ3VPr3gwEI0ValFWGMV+9MmlpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtL4/4Uy; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ed11782727so3776100b3a.1;
        Tue, 16 Apr 2024 07:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713276984; x=1713881784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/R7TgmFidNar+edYlAImO4xkO4YUQu8Ma2Hm0LsrhDM=;
        b=EtL4/4Uy2233xEBz6l9xQdZBJ19H6CKK4OPdmGPZCeThv/ltCo3OHeVDJTUy64a7UF
         o44blWW7+GHWiUv5id1GbcMT/J41Ly+XcvG7VgyizQkranrsm+h/PX/8rlt0ctzdfUkB
         g3cekeG6+VvCg9x/mfZf/y6Bx460HUd68UBNZRXglJQXni7NhHWpMaHjEo1i5yS9pZC9
         wiBd74N+QcSoYIOqT+JvQ28aNaStXUPuyK2+1pmsXxHhwJ3BACp/Lnvx/YkZHM6iiuSP
         /F6nQQNzD3ZBtvl+gtMi0XO+32ic6fvbZns3wj8frH8rocfkz80wEwH+W/QuFuevjV2i
         DOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713276984; x=1713881784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/R7TgmFidNar+edYlAImO4xkO4YUQu8Ma2Hm0LsrhDM=;
        b=lm97in5GOMjGFqgquszfVTwTkpno6BH+wf240oIocW4qeJMuqTdRVjNyoADHjN93PY
         3oN7a7aGMf8Ffhc0LIqAkEtYiMZTVGWj/kqbzGyE6nXR2PBYjdS/C6oGQQI4dKkhpz99
         jwZZ/B9fzTheXjLbwCiFwDCz8IgV2f74D0gFrVHp8oq1jYl8Z3dORCyLCsiCEmESeyXG
         LltrvhvnoTlRXWPeZOHWGdY8u99v02Q3GKl6JZ9YE/htPmgE+CQ3BEcyj5uLB5PL12Bw
         1SGGfuClDiEvIcOhqNCBFz9wgF+KgwJ1sY4e/7wHEThB1ykd6jEk44mm8l2idwGHaGXY
         RENQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxbtvyB/gZEXpi3XSj4T6rcR8+CRtlb8PrezHng/DrUQ28/fsGd3BhHa2cDsCoE1YxKNgCrqk9QLp8kOrXnCtGTzobeTh5gEIUuAPNdj03wkprMA3UuEOPd1brY7A5QJdYqb56wCfco4k=
X-Gm-Message-State: AOJu0YzdR+ibW3r8N1MatOc41jh/Kg8Rq5meoBJGaYHb+KoEr+AWJLDx
	QBDsh50dmoeua7qM4HAIzIKiPaPoXgxuTPwCdBZ7Tqg/euAv9ZBuUhjufw==
X-Google-Smtp-Source: AGHT+IFutIzf1ZvInZm2HCMbqWYPLrJH7r2Y6yCZ2WK+okAAmqwcjfGGSJAdN4ydw0B/49+RosV6XA==
X-Received: by 2002:a05:6a00:244e:b0:6e6:970f:a809 with SMTP id d14-20020a056a00244e00b006e6970fa809mr15436088pfj.20.1713276984349;
        Tue, 16 Apr 2024 07:16:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ge7-20020a056a00838700b006e567c81d14sm8956774pfb.43.2024.04.16.07.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 07:16:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 16 Apr 2024 07:16:22 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Andrew Davis <afd@ti.com>
Cc: Jean Delvare <jdelvare@suse.com>, Juerg Haefliger <juergh@proton.me>,
	Riku Voipio <riku.voipio@iki.fi>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/31] Remove use of i2c_match_id in HWMON
Message-ID: <cd6ae1f7-33e7-4e1b-bac8-c5566b22b392@roeck-us.net>
References: <20240403203633.914389-1-afd@ti.com>
 <0e43aa83-2e02-49e2-96b8-24cac0362a7b@roeck-us.net>
 <77b2f8ce-0b71-4a7a-81bc-a64a1af3566d@ti.com>
 <fcafe904-383c-49c0-b576-81cbcde045c5@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcafe904-383c-49c0-b576-81cbcde045c5@roeck-us.net>

On Mon, Apr 08, 2024 at 04:49:43AM -0700, Guenter Roeck wrote:
> On Wed, Apr 03, 2024 at 05:06:43PM -0500, Andrew Davis wrote:
> > On 4/3/24 4:30 PM, Guenter Roeck wrote:
> > > On Wed, Apr 03, 2024 at 03:36:02PM -0500, Andrew Davis wrote:
> > > > Hello all,
> > > > 
> > > > Goal here is to remove the i2c_match_id() function from all drivers.
> > > > Using i2c_get_match_data() can simplify code and has some other
> > > > benefits described in the patches.
> > > > 
> > > 
> > > The return value from i2c_match_id() is typically an integer (chip ID)
> > > starting with 0. Previously it has been claimed that this would be
> > > unacceptable for i2c_get_match_data(), and chip IDs were changed to start
> > > with 1. Commit ac0c26bae662 ("hwmon: (lm25066) Use i2c_get_match_data()")
> > > is an example. Either this series is wrong, or the previous claim that
> > > chip IDs (i.e., the content of .driver_data or .data) must not be 0 was
> > > wrong. Which one is it ? I find it very confusing that the chip type for
> > > some drivers now starts with 1 and for others with 0. Given that, I am not
> > > inclined to accept this series unless it is explained in detail why the
> > > chip type enum in, for example, drivers/hwmon/pmbus/lm25066.c has to start
> > > with one but is ok to start with 0 for all drivers affected by this
> > > series. Quite frankly, even if there is some kind of explanation, I am not
> > > sure if I am going to accept it because future driver developers won't
> > > know if they have to start chip types with 0 or 1.
> > > 
> > 
> > i2c_get_match_data() has no issue with returning 0 when the driver_data
> > for the match is also 0 (as it will be when the chip type is 0 here).
> > 
> > The confusion might be that returning 0 is also considered a failure code.
> > This is a problem in general with returning errors in-band with data, and
> > that is nothing new as i2c_match_id() does the same thing.
> > 
> > Actually, i2c_match_id() is worse as most of these drivers take the result
> > from that and immediately dereference it. Meaning if i2c_match_id() ever did
> > failed to find a match, they would crash before this series. Luckily i2c_match_id()
> > can't fail to find a match as far as I can tell, and so for the same reason
> > neither can i2c_get_match_data(), which means if 0 is returned it is always
> > because the chip ID was actually 0.
> > 
> > At some point we should switch all the *_get_match_data() functions to
> > return an error code and put the match if found as a argument pointer.
> > Forcing everyone to changing the chip type to avoid 0 as done in
> > ac0c26bae662 is the wrong way to fix an issue like that.
> > 
> 
> That doesn't really answer my question. It does not explain why it was
> necessary to change the chip ID base for other drivers from 0 to 1,
> but not for the drivers in this series. I fail to see the difference,
> and I have to assume that others looking into the code will have the
> same problem.
> 

Just to follow up: I am not going to apply this series until I understand
why the chip ID range had to be changed from 0.. to 1.. for other hardware
monitoring drivers (lm25066, nct6775) but not for the drivers changed
in this series. I have been telling people that chip IDs need to start
with 1 if i2c_get_match_data() is used. I'll need understand when and 
why this is needed to be able to provide guidance to other developers.

Guenter

