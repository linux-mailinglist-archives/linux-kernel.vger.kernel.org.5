Return-Path: <linux-kernel+bounces-150188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFFB8A9B7F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62EB2283878
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C38161330;
	Thu, 18 Apr 2024 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Px2cdxHX"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149D4165FC4;
	Thu, 18 Apr 2024 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713447763; cv=none; b=fTysEiTkyQrIt4hg1opvKWTEb7oPoOYZOxGYfv/Bz56NiVyecxTK9EYJ41GtK+5r14K5Ci60mULOegtSrtGjhrh3Z6rhbjYhC91MZAi+XcngYLeFPVFBpYwveu+Y2Vl/OU/zOUdfxOEOfzjIZZEc8ZK91WRqYTqzi8sm47mDG0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713447763; c=relaxed/simple;
	bh=5R7F3f6tjT0gqEhUGUPVdLLImI03/iPgl6xs+OV1mgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clQuBd0lUDRA/R+YUx/fDhTiaNGsR/hYQivijwHhi7oxprnddQuNIc4v+RqrRNKuO6Oz8sIeA5UcdxKhIbFM+zp00MSTu7YzHl1SQqii3kgEpQqWozawx05pom1PxnGYeC5dpbGPNFPwQ8N2sqbQjFlpSTQlRWxJ0uH3YHU0DkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Px2cdxHX; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6eb848b5a2eso472562a34.3;
        Thu, 18 Apr 2024 06:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713447761; x=1714052561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mwD6D1T0Raq489SMEFFgoKUcTuSJ6kvgxPfdmfdOOQw=;
        b=Px2cdxHXgXOt6Y9NqFGhvJIS97e8ov01Tr9ZfTsjjXlA7X/lwNejrcYwir3TQV7jpn
         L4X2mRE4iMkhzi4BD1T3yqjy4z0vq6O37ypBt+PxS/KUJfcc6Vl5RC58gylcp8axTrgO
         RIrV9mHwPM/uQQyRnQpiPKs8EWfGz94ThjfbwFcxZkBHfyfaH8RhMs1TGKpcxopiVsb5
         n6yaD12EIazQozknApflK4ZLdAUcTG4ScClHL58f0smC+iP7f2edh1MnXftk5fBJ9d5f
         QxJHT3xptgLuBwSe8WTGHZCMg3GfFRK2BxQ4wrFbvAfmOKpNnLsiqdcp9TJLXsfw8xUb
         JkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713447761; x=1714052561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwD6D1T0Raq489SMEFFgoKUcTuSJ6kvgxPfdmfdOOQw=;
        b=YXYXvQGQ4vjoX/xdL4uq5aeEFueHUxIDnxKsPcMlcFDxASCtVzLDtruStEp1hGE1J6
         sLAZFcjUUUWcr3Y6XnLnj5DzztOLZwgs316wcE6dF7Zw9fFGljlBq+XrSh6QN9VAo+QE
         8l22Q2b3Wd4PlZVW4vqniIe2luEFr/X51cS1CAPFgYnz+x3vrPHnt0yWstztyEyyUFQ5
         gcOfl+bqbvRvXc4sMqrzfk2fzix3hRwoqyaMpD2kKVWDHZlsT4TyVEt83+0huybjwkTS
         hRrkVBK39S5gTh/9jyvHnAfuc0er6infZISz+LOCrC/tP+noel51yve8xUIt1Q/Keil8
         Lefw==
X-Forwarded-Encrypted: i=1; AJvYcCX1GVeqDh7KSOJER5gMXa1kGks2qyFfaz2EZ/eFZsKfVXBRXqXJ1R+uczQPcTMeynSU+XO6uuF0A/CY0pJ1L0RgUYL6BJ7zKdZN2Frr3soMcESLuNUpCpCiB2XpyzDFA7DdOl87sp9fkrU=
X-Gm-Message-State: AOJu0YyZRJ2XRGqwghOh55J8JuLtjYYneR8UYm6kxRWu1yUpqivfzFSN
	TknFkqcsuZtOOgjvIhrKvnnCGDKtCMyg9rkOKHpofDfkQsQAEsdI
X-Google-Smtp-Source: AGHT+IERDKS1ud8LvJJrYgvlREQjcZ+3AyWvA4FsaHVmRb6cWe9aSiMdn9rKGTFF+d8nbkWKZI4mMw==
X-Received: by 2002:a05:6830:204b:b0:6eb:9497:5d46 with SMTP id f11-20020a056830204b00b006eb94975d46mr3478484otp.7.1713447761019;
        Thu, 18 Apr 2024 06:42:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 9-20020a630b09000000b005dbed0ffb10sm1428026pgl.83.2024.04.18.06.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:42:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 18 Apr 2024 06:42:39 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Andrew Davis <afd@ti.com>
Cc: Rob Herring <robh@kernel.org>, Jean Delvare <jdelvare@suse.com>,
	Juerg Haefliger <juergh@proton.me>,
	Riku Voipio <riku.voipio@iki.fi>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/31] Remove use of i2c_match_id in HWMON
Message-ID: <340e8274-dd6b-49b0-906b-32da60745b22@roeck-us.net>
References: <20240403203633.914389-1-afd@ti.com>
 <0e43aa83-2e02-49e2-96b8-24cac0362a7b@roeck-us.net>
 <77b2f8ce-0b71-4a7a-81bc-a64a1af3566d@ti.com>
 <fcafe904-383c-49c0-b576-81cbcde045c5@roeck-us.net>
 <cd6ae1f7-33e7-4e1b-bac8-c5566b22b392@roeck-us.net>
 <fce93a8b-7225-4775-b265-d283a863f969@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fce93a8b-7225-4775-b265-d283a863f969@ti.com>

On Tue, Apr 16, 2024 at 12:08:50PM -0500, Andrew Davis wrote:
> On 4/16/24 9:16 AM, Guenter Roeck wrote:
> > On Mon, Apr 08, 2024 at 04:49:43AM -0700, Guenter Roeck wrote:
> > > On Wed, Apr 03, 2024 at 05:06:43PM -0500, Andrew Davis wrote:
> > > > On 4/3/24 4:30 PM, Guenter Roeck wrote:
> > > > > On Wed, Apr 03, 2024 at 03:36:02PM -0500, Andrew Davis wrote:
> > > > > > Hello all,
> > > > > > 
> > > > > > Goal here is to remove the i2c_match_id() function from all drivers.
> > > > > > Using i2c_get_match_data() can simplify code and has some other
> > > > > > benefits described in the patches.
> > > > > > 
> > > > > 
> > > > > The return value from i2c_match_id() is typically an integer (chip ID)
> > > > > starting with 0. Previously it has been claimed that this would be
> > > > > unacceptable for i2c_get_match_data(), and chip IDs were changed to start
> > > > > with 1. Commit ac0c26bae662 ("hwmon: (lm25066) Use i2c_get_match_data()")
> > > > > is an example. Either this series is wrong, or the previous claim that
> > > > > chip IDs (i.e., the content of .driver_data or .data) must not be 0 was
> > > > > wrong. Which one is it ? I find it very confusing that the chip type for
> > > > > some drivers now starts with 1 and for others with 0. Given that, I am not
> > > > > inclined to accept this series unless it is explained in detail why the
> > > > > chip type enum in, for example, drivers/hwmon/pmbus/lm25066.c has to start
> > > > > with one but is ok to start with 0 for all drivers affected by this
> > > > > series. Quite frankly, even if there is some kind of explanation, I am not
> > > > > sure if I am going to accept it because future driver developers won't
> > > > > know if they have to start chip types with 0 or 1.
> > > > > 
> > > > 
> > > > i2c_get_match_data() has no issue with returning 0 when the driver_data
> > > > for the match is also 0 (as it will be when the chip type is 0 here).
> > > > 
> > > > The confusion might be that returning 0 is also considered a failure code.
> > > > This is a problem in general with returning errors in-band with data, and
> > > > that is nothing new as i2c_match_id() does the same thing.
> > > > 
> > > > Actually, i2c_match_id() is worse as most of these drivers take the result
> > > > from that and immediately dereference it. Meaning if i2c_match_id() ever did
> > > > failed to find a match, they would crash before this series. Luckily i2c_match_id()
> > > > can't fail to find a match as far as I can tell, and so for the same reason
> > > > neither can i2c_get_match_data(), which means if 0 is returned it is always
> > > > because the chip ID was actually 0.
> > > > 
> > > > At some point we should switch all the *_get_match_data() functions to
> > > > return an error code and put the match if found as a argument pointer.
> > > > Forcing everyone to changing the chip type to avoid 0 as done in
> > > > ac0c26bae662 is the wrong way to fix an issue like that.
> > > > 
> > > 
> > > That doesn't really answer my question. It does not explain why it was
> > > necessary to change the chip ID base for other drivers from 0 to 1,
> > > but not for the drivers in this series. I fail to see the difference,
> > > and I have to assume that others looking into the code will have the
> > > same problem.
> > > 
> > 
> > Just to follow up: I am not going to apply this series until I understand
> > why the chip ID range had to be changed from 0.. to 1.. for other hardware
> > monitoring drivers (lm25066, nct6775) but not for the drivers changed
> > in this series. I have been telling people that chip IDs need to start
> > with 1 if i2c_get_match_data() is used. I'll need understand when and
> > why this is needed to be able to provide guidance to other developers.
> > 
> 
> I was hoping one of those patch authors that made those 0->1 changes
> would speak up (+Rob), I can't know what their thinking was, only
> offer my best guess as I did above.
> 

I can see three possibilities.

- Chip IDs must start with 1 if i2c_get_match_data() is used, as I was told
  previously. If so, this series is wrong.
- It is ok for chip IDs to start with 0. If so, what I have been told
  previously is wrong, and the patches changing chip IDs to start with 1
  can and should be partially reverted to avoid confusion.
- Chip IDs must sometimes, but not always, start with 1. If so, the
  conditions will have to be documented to help driver developers decide
  the valid starting value and to be able to determine if all the patches
  in this series follow the rules.

Someone will have to step up and explain to me which one it is.

Thanks,
Guenter

