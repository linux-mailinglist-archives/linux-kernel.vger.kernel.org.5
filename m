Return-Path: <linux-kernel+bounces-106049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8646887E855
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8C431C213AE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100DC364A7;
	Mon, 18 Mar 2024 11:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K2d95yni"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A59D36114
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 11:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710760605; cv=none; b=Q8davwhHDh14wiieDuL0Xxj4zRqgjbs7hUWo5cZwV+cWEW6LG3s1B78wU0P3EPuryr+yxwEOSWDO+5EsAWkMJ/5/bD4N5pTyx0TWsAtOTyRqNCFfgG21Mow69t/KFCmTnvpIkxCrknHG+aXkYthSv5Gjo2vet9fQzYIVxAZx7tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710760605; c=relaxed/simple;
	bh=K/B9jshhQTO4EDidb9xFu7jg5/YHjfatld4X7iyOsJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgcZd23KFEW1RC6dcYmTCIVfq9hLxD40OvEwDhS6IjTQRcUr5RVfZ7npI+NBL4Sf2x2zAAIjCwHr0vcVn8N5pOfboDbxQJaGy8gj4yqY4pRnugvek6uebR5JP9YWLTUlCwiulwTKa3jdzaIei4SzQLNC0Bz7r4/spSuHzyZeUHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K2d95yni; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5687e7662a5so5672222a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 04:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710760602; x=1711365402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KnHhyb7uDpQBPnfr4V2y5wGYxknsht7Nq/KOV466kCg=;
        b=K2d95yniZgrEVp/MnijD4bieQxXizdmrePBdLfGdqUOH5HDeQHduf/gLR67hQUqsfF
         H066RbZMyqWubbfxL2toHNaEZcokEvDzh1lrHmz+giLZByIl2Rz4i2rHO31ZXlByOREC
         arQXIh7J8A84ZYeF5V0F8OWJluw5YZDnFOw1NUSXNPuMwLVIUXkSYyrW5gevlL6krk1b
         TiaISAPzJ91K6gf8TSA05j57RqZmZDevVDcDM32Yp92CLZEJdZ3Qb0QgsHgAjH/WEXoL
         E5+jkedRRPuZL7FkzxGrIzCBM1PrCPTq/DLGXRYPvwA5oNdPqp23egxIaGcGU06LEL2h
         qU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710760602; x=1711365402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnHhyb7uDpQBPnfr4V2y5wGYxknsht7Nq/KOV466kCg=;
        b=QQbyZYLWpj8blId6M1b73dVt2JyMQgjf0FCgHLnnDK2ph76s3cGaBMHwr61jVSOZsT
         aeC8Mfvklv4t+OMod5oGDJ2LN3qdIJ3rD4ZJuPm9Gt+sTcm8xwMLSBgW2Bt3KfVp4vaG
         0L1BWfKUlUFU0mhpfWCiYIOtZEZ9UDX9nXjWyBF39D6jbYWLcfOwYCkBJ79ENgLJP0xc
         qKoryRAoI9PYefkSgQmp9d9Aj0bmimHqTym8vv44bULPN4ZTAgul3KJLct7EKmwYigXu
         z61H6EiKHEbFXxh1U65SKcCbwKhmIzi4fQNW29hBOXld9V7q2jJYWvFOrLWJagAhossF
         Kcpw==
X-Forwarded-Encrypted: i=1; AJvYcCWMy39q3WeKD9qUWDvO9Xgmpdcre2Y+fDBVIvQ3rOhp9pEA9HYpHykq9L8Ho39Hu0k/3Fm7UioJszvbcaKRNsf9TU4FakmfMIXNpJ0x
X-Gm-Message-State: AOJu0YyXIE28MyD5hdX5UB9+wgHyMnBUUFQUj4whe7dhj32SFnIEKSKp
	e2Ij8Eud35+YqIa4eNWCUwrTdaWQyhJOPYJoT4W/2W+THB/ZEv0p5GhAKps2q4ypXdqBEE6RMBm
	5
X-Google-Smtp-Source: AGHT+IFLgonsgY/3PtzQAbuX1V/tusa6WXagx6nFGjo08BezauKdmdlJY/CD9Qb58XVaazG7ruBA0Q==
X-Received: by 2002:a17:907:60ca:b0:a44:5477:bb46 with SMTP id hv10-20020a17090760ca00b00a445477bb46mr10100474ejc.61.1710760601717;
        Mon, 18 Mar 2024 04:16:41 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id w17-20020a1709064a1100b00a466e772597sm4798756eju.177.2024.03.18.04.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 04:16:41 -0700 (PDT)
Date: Mon, 18 Mar 2024 14:16:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
Cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH v5] staging: greybus: Constify gb_audio_module_type
Message-ID: <ea44d965-e727-4fc4-86cd-b727e1e0d2be@moroto.mountain>
References: <ZfXj1WkJ3nrYh3qL@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfXj1WkJ3nrYh3qL@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>

On Sat, Mar 16, 2024 at 11:54:21PM +0530, Ayush Tiwari wrote:
> Constify static struct kobj_type gb_audio_module_type to prevent
> modification of data shared across many instances(instances here
> refer to multiple kobject instances being created, since this same
> gb_audio_module_type structure is used as a template for all audio
> manager module kobjs, it is effectively 'shared' across all these
> instances), ensuring that the structure's usage is consistent and
> predictable throughout the driver and allowing the compiler to place
> it in read-only memory. The gb_audio_module_type structure is used
> when initializing and adding kobj instances to the kernel's object
> hierarchy. After adding const, any attempt to alter
> gb_audio_module_type in the code would raise a compile-time error.
> This enforcement ensures that the sysfs interface and operations for
> audio modules remain stable.
> 

Basically the patch is fine.  The only comments have been around the
commit message.  And all the reviewers have said correct things...  But
I'm still going to chime in as well.

The commit message is too long for something very simple.

Basically all kernel maintainers understand about constness.  There is
sometimes trickiness around constness but in this specific case there
isn't anything subtle or interesting.  You don't need to explain about
constness.  Maybe you can say the word "hardenning" as an explanation.

Julia asked you to write what steps you had done to ensure that the
patch doesn't break anything.  And I was curious what she meant by that
because I had forgotten that it would be bad if there were a cast that
removed the const.  So the bit about "any attempt to alter
gb_audio_module_type in the code would raise a compile-time error." is
not true.

Also we assume that you have compile tested everything so you never need
to write that.

The information which is missing from this commit message is the
checkpatch warning.  I'm more familiar with checkpatch than a lot of
kernel maintainers and I had forgotten that this was a checkpatch
warning.  Please copy and paste the warning.

Basically what I want in a commit message is this:

"Checkpatch complains that "gb_audio_module_type" should be const as
part of kernel hardenning.  <Copy and paste relevant bits from
checkpatch>.  I have reviewed how this struct is used and it's never
modified anywhere so checkpatch is correct that it can safely be
declared as const.  Constify it."

regards,
dan carpenter


