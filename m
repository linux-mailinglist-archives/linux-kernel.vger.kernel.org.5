Return-Path: <linux-kernel+bounces-53901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F5D84A7D7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BFE21C27C17
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4376130AF7;
	Mon,  5 Feb 2024 20:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZy4Oa9c"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8716612FF91
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 20:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707164000; cv=none; b=Kc7Rei3BSpSpdUVQaGGCn/VQ+zm/L4xZXnS3xegGn8c7lcfmAYNhbQ5vvP7fN689qbMFgXxW7h3oevxklIdqQnBDfUeqjZCd/kOfnHXmGBMV5LJrzAMbpJUHN5GrBsb1EISKpkwrgzkK+Uyo6CkbGk0LODkYToovrH+859T6OQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707164000; c=relaxed/simple;
	bh=FuyRo9wiHTogfIk6Rq9E/M8hAwRbpbNFWVoNdCW2zcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rg0BTI3Qzv8Gg2cdxzq3/ZvWDhp/x+qcCMz58ICooQhbv7GbOf5F5+FO89O2ALPse7LMQhMfyIn7O9DA5wP9xfoG2WXOIQGsBpYfe9vC6e46IrNNHlahK4m+InuAa3m9AA9nYL0PmsDborvTyknxK9fsI8YJblWnBTkMUCfLhTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZy4Oa9c; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d958e0d73dso28678795ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 12:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707163998; x=1707768798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jIF/GjavlTkOoi1U2fmM/cQ0FDzd+uPBwDTvOoR/ER0=;
        b=XZy4Oa9cazzF8bZ6hSmhKc3tMn2iv6gw/G8rk5dzB26MYqVhyaTk2YNDjiqU4yfBjT
         xs7zE6TUtLvg52KkyQS74w6q4H3eavkxtpVc37FzBY6vhhpPWuc/v+GtlbGUurvYm5q3
         1pNCrL10zcMooJ1Hw1h8crPYnq5VOGYTdd1WDQ0e6johOVl/B+TznIXlGKIVQGvlMBVP
         cfGpi9bQGAI1E4rbh78P7jPkwOQL+hf+YvSM0o7sFE3eI7MtP1b8DBUuvYDF8EaoXOUR
         M9B68di2V12UDanstR47LF2n1/sd9D10mzeCR2troVDIGZc2tNvuEVUTFXTLegQ86r5r
         zhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707163998; x=1707768798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIF/GjavlTkOoi1U2fmM/cQ0FDzd+uPBwDTvOoR/ER0=;
        b=juPLIRMDxDZuuDKLV6RZGLHXvwxRVKhUN5QSBu3HKYV7P/7AcFpIhtttbIm4SSgs4C
         tajLyYPOlZVprHuQUtxhC1PP7SNl9QmcmOPX2A3GQLY//xaypuSrKjajZ6zsu/SxBXFP
         ltq6MQkkh93BHEJ+ZwfMK96OsJ5rBZfyDFgF6ANQnUQabzOj/iYh2rs/B09t1MYPgiMh
         K7Rkz6Tu+GN+2pe5llbi2wb8o1L4N/wfjHQMyjh8hJ7h81Z1Ffr3EWqF6SE+Bc4NfDHy
         wb0RNDsVb6NZaqtMYlh53eaR1/hDkzjkNWNro8avOzJp66mQ6XR/6cyBHJX/B8sV1u7h
         AJqQ==
X-Gm-Message-State: AOJu0Yy88rRao0Bhu36AOxdmZbi1HrER31MRQiLOCEx1CBPkBSlCu9FJ
	Ct8WsjsPzxs+TkRlkfwuZv5PUyY9IWNJQhCnI56MQ6w5bhQ++OJK
X-Google-Smtp-Source: AGHT+IF2Sx+KswX7vsOae00vSDKFbddRQ/gTn6apiyxuMvw0b5FPNWjMrPfkXaulxP4/EBEBfqp+BQ==
X-Received: by 2002:a17:902:ce89:b0:1d9:435b:a6f3 with SMTP id f9-20020a170902ce8900b001d9435ba6f3mr920663plg.26.1707163997726;
        Mon, 05 Feb 2024 12:13:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCValCZNtTvPDAP3HPIDcBiSDqZ0DQeLDgc1BPk8NPvU63o5q+c5lRbK41GM172muJSCS9vwChVDQIFRlMbFFfrEb2SvFjtLKrw02A8CtM1IKZQUKBvDz7B7zMChyjIwyoiTmxu1QlE7ifHkxWiCFKBfyVl0XfSH3Ejs
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l15-20020a170903244f00b001d95a6afbc2sm265580pls.244.2024.02.05.12.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 12:13:16 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 5 Feb 2024 12:13:15 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: Re: Spurious problems when running regmap unit tests in qemu
Message-ID: <745d3a11-15bc-48b6-84c8-c8761c943bed@roeck-us.net>
References: <fc1d865d-3e2e-48bc-8cd1-389ec6b15909@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc1d865d-3e2e-48bc-8cd1-389ec6b15909@roeck-us.net>

On Mon, Feb 05, 2024 at 10:03:04AM -0800, Guenter Roeck wrote:
> Hi,
> 
> I am observing spurious regmap unit test failures in my qemu test runs.
> Examples:
> 
>   # raw_noinc_write: ASSERTION FAILED at drivers/base/regmap/regmap-kunit.c:1243
>   Expected val_test == val, but
>       val_test == 65581 (0x1002d)
>       val == 45 (0x2d)
>       not ok 8 maple-big
>   # raw_noinc_write: pass:7 fail:1 skip:0 total:8
> 
>   or
> 
>   # raw_noinc_write: ASSERTION FAILED at drivers/base/regmap/regmap-kunit.c:1243
>   Expected val_test == val, but
>       val_test == 65556 (0x10014)
>       val == 20 (0x14)
>       not ok 5 rbtree-little
>       ok 6 rbtree-big
>       ok 7 maple-little
>       ok 8 maple-big
>   # raw_noinc_write: pass:7 fail:1 skip:0 total:8
> 
> The problem is not seen all the time. I see it with various qemu machines,
> but not always the same. Endianness does not seem to make a difference.
> The failure is always in raw_noinc_write. So far, I have observed the
> following individual test failures:
> 
> not ok 2 none-big
> not ok 4 flat-big
> not ok 5 rbtree-little
> not ok 8 maple-big
> 
> The most recent test run (on v6.8-rc3) failed on the following
> architectures and machines (again, those are not always the same).
> 
> arm:npcm750-evb:regmap
> mips:malta:regmap
> mipsel64:malta:regmap
> i386:q35:regmap
> 
> I only recently started to track unit test failures, so I don't know yet
> if this problem has been introduced recently or if it has existed since
> the tests were introduced.
> 

Actually, the failing test _was_ introduced in v6.8-rc1 with commmit
d958d97848a6 ("regmap: kunit: add noinc write test"). Copying the author.

Guenter

