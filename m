Return-Path: <linux-kernel+bounces-40969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7DE83E91C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 02:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1357B1C22114
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398259476;
	Sat, 27 Jan 2024 01:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgEyTbz7"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D00633F6
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 01:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706320199; cv=none; b=NhL3RTCEWV4lH3OPvUQlFqCvNTyhoLIA2mDOYAJgwuX9axLPZAZbu76R32OjYryFNWXZ/OCiPC1TcfNNbUHKXMLpc1mxfSEA/D58hW+9K5ZwFlcnaN5Hs1QXiAOsgrTzE5qm5CmFSHGTgyw8jKt5V8YSKECguQTg6+P0ZD89Zu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706320199; c=relaxed/simple;
	bh=5MQ7JayJvoUP9LA2w/yC9FYAsCrCx1bz/Nw9RIMpdzI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GHykLiz5C3rHhycA56bjfMEWXZLkhWfUG0sUDVPc7Dh/wXBdLrci6FA/nPL4cA4L/3KcH/s7mDwRJpJIriU+zJTGUzHFEGgc0lOWVdVqL8G34u3aZ5YIKBKyD0iOtW/bCkb7kHS29MarqYT/wNwP7GmMmIQhEboofiNzsR/YmY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgEyTbz7; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bda741ad7dso874288b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 17:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706320194; x=1706924994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJXuS3ZFCT9vQXXQeSNaeXPTVoMcLrWWgpD8WrejEEE=;
        b=QgEyTbz7nr1aU4iNNqXhKwwzJZZJlPZavLDaipxxkbvYuKA8LnlBTl29qB0MS3MrCr
         Uebeg5TzTFwefSsYbUS6xCd5U2PV0NRoalFq6RNnTYYYWWEoVMNUd/HP0Cl2IHhC9YP1
         R7jfSNKwqvW9C5ZLoXxNvTN76XnP4YOsroydRbWXRxt4aq76FTZfjxKKPuYmFLw5btyQ
         QiA7c0htPRPc8Bc9238Az4MsPJUyfg1JQRCaAzbEqtIxkhkVVv6Gg9gL/Lunl/R19rlK
         tHPj4+u+DoASJhbclpRRrxyjswcEpQ12j2HyQrUdIXGh7HHD9v6wTHcXGT4tG40FbAFx
         5W8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706320194; x=1706924994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJXuS3ZFCT9vQXXQeSNaeXPTVoMcLrWWgpD8WrejEEE=;
        b=L31xUtxiyvxfvmYdD/NeEpbQVq1pO84tL9iOmQA9eVLVWKBrPAzut3Aus1AjGdE5Bo
         sqUaWnv3tSGEbclxJBAWcP+/uWC9PO8odTHbBn6r70H91rZ0T+5qntb6ASK6bp8ghHoS
         hJPxElF2msvT/h48IH4+ZjbJ2O1fBvhyq8g5xo8oczrFPyZtBtSjwzpLanMR82qkj1Ij
         jZja5KMparYb5yICWviLcdoSoJ+xwolTkCeWssd8PI7X4FrFAqIiGGcX3ViHinqWmF9X
         xmWpgNRkWo1sOAE+hSl7SQlKVdEn9wdEn+4lRO6qMAm3tQuPnUGx9tzLNIRPr2ewPfgu
         DT+g==
X-Gm-Message-State: AOJu0YzObIfreZxNYhxqhakIMTRCyikaTqQord7B5VrIJ7dDZ6FfFnIh
	XuZdoQwdP9mrn4u5psOPheY8sraom8TcJWE5v3gDVltcmZjakDed
X-Google-Smtp-Source: AGHT+IFGvnwjmF0C3gdAh3PRjAZSEAE3+CW0ftwWg+IEhC8FUASoZNpwKtOHudmubC7tTgDD7GF3Ow==
X-Received: by 2002:a54:408d:0:b0:3bd:db8e:b1d8 with SMTP id i13-20020a54408d000000b003bddb8eb1d8mr1060194oii.31.1706320194011;
        Fri, 26 Jan 2024 17:49:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV/DCWLVHwsBwzLWWTWXqarQ1zEpRKCVskDt7zJGu+qXSqto1NfpS4PX/ZwBfa5cVwB5d1GnRoqxu4Lp6goOcXiiXwMmMDTYsoomJqyJwSiCiKSlb6RE2DAaKXy+JitmoJSs+g4PQGLc2eiEQ4WUPxv9ybA+nBclJkIAVtSL/q3/UrwfiMF2zQ=
Received: from localhost ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id l17-20020a635b51000000b005cd64ff9a42sm1747681pgm.64.2024.01.26.17.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 17:49:53 -0800 (PST)
Date: Sat, 27 Jan 2024 09:49:48 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Chunhai Guo <guochunhai@vivo.com>, Gao Xiang <xiang@kernel.org>,
 huyue2@coolpad.com
Subject: Re: [PATCH v4] erofs: relaxed temporary buffers allocation on
 readahead
Message-ID: <20240127094948.000024ad.zbestahu@gmail.com>
In-Reply-To: <20240126140142.201718-1-hsiangkao@linux.alibaba.com>
References: <20240126184656.0000561c.zbestahu@gmail.com>
	<20240126140142.201718-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 22:01:42 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> From: Chunhai Guo <guochunhai@vivo.com>
> 
> Even with inplace decompression, sometimes very few temporary buffers
> may be still needed for a single decompression shot (e.g. 16 pages for
> 64k sliding window or 4 pages for 16k sliding window).  In low-memory
> scenarios, it would be better to try to allocate with GFP_NOWAIT on
> readahead first.  That can help reduce the time spent on page allocation
> under durative memory pressure.
> 
> Here are detailed performance numbers under multi-app launch benchmark
> workload [1] on ARM64 Android devices (8-core CPU and 8GB of memory)
> running a 5.15 LTS kernel with EROFS of 4k pclusters:
> 
> +----------------------------------------------+
> |      LZ4       | vanilla | patched |  diff   |
> |----------------+---------+---------+---------|
> |  Average (ms)  |  3364   |  2684   | -20.21% | [64k sliding window]
> |----------------+---------+---------+---------|
> |  Average (ms)  |  2079   |  1610   | -22.56% | [16k sliding window]
> +----------------------------------------------+
> 
> The total size of system images for 4k pclusters is almost unchanged:
> (64k sliding window)  9,117,044 KB
> (16k sliding window)  9,113,096 KB
> 
> Therefore, in addition to switch the sliding window from 64k to 16k,
> after applying this patch, it can eventually save 52.14% (3364 -> 1610)
> on average with no memory reservation.  That is particularly useful for
> embedded devices with limited resources.
> 
> [1] https://lore.kernel.org/r/20240109074143.4138783-1-guochunhai@vivo.com
> 
> Suggested-by: Gao Xiang <xiang@kernel.org>
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

