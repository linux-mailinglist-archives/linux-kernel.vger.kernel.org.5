Return-Path: <linux-kernel+bounces-1546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C933814FEF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F1FFB234E7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24FE3E49F;
	Fri, 15 Dec 2023 19:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cR6YrTav"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47213010B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 19:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5e4dc41ab59so4221507b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 11:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702666873; x=1703271673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YZIxJDdM8Ta7FkKejANIftBLEc7/cPcQYut694WCkb4=;
        b=cR6YrTav93vzOW1QNeUBj4YU5mHQvFqcNCGetX28tVdQZ+ymvHTsll5fltOnkaH5+5
         bInMLJiqxT6ALmnFzmFtMnIA3BI/SigyEm1oA6NWsaNIFLZzQGdzHbBZLcQ3RweV5/6D
         IyU61MddqZf8U1cR1JBn7qt0G9nAVen1NWaCSHbH4RRC4Xl+qkpJcoc/B1FrWPppizWh
         9ghEBcdwipskDwKImGH01bun1GxTEyismOZNo0/3ixW6C7JJwhVTFN2amJGRz686bWQR
         aiGnuL5CLijZZe4MSYH6urOGPAb5UBd3enN+dg2lZYg7+txlMW3DboqdThO0KCbNTcKB
         L1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702666873; x=1703271673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZIxJDdM8Ta7FkKejANIftBLEc7/cPcQYut694WCkb4=;
        b=gHPlfisrBPYYg3G0LKLqhWMukyLWpskqlNFVIf7ZwJyeSPqBW1uJkR6tnhh5dSriCi
         ajgQHWfnvpqnJgVf7QdD08wgBZVWssbKO4pKX3j2wv8Pr0nkF656OsuVZKg9U3d8rH8K
         jWItMtg/JEwVrifmYTg9yLuB4uu+cPJSHDvn+HEw3PWYPGLrp2OOnn8EDsFVWa5iUT9S
         PSI2eyy4utyt00zmfFFuVmSBixoWCqKxlXCgcUbg+1rM8uCvQx/sy3WGUdEQVni2p4yz
         KStlmklLfzRYz8l7X/XFFiOqhP0jU/g2piSyOjtkN2A4t4B27Yp5suIiLtuKWsYYfG3A
         sO9A==
X-Gm-Message-State: AOJu0YyE2/cFoe9WM/7EyfX2SMiyhEA1lj7Oka5svE6wi8NZoK01O6Yt
	kzDatCciVYBjpYUo56CH0FjMvoLN1rE=
X-Google-Smtp-Source: AGHT+IHgXbie7WlgathaEWLaWS61UjpTXP62R/Sm8aHPyKJ3JREFU2TmwfgYuMB8RE+wMzTQJ97FnQ==
X-Received: by 2002:a0d:ee86:0:b0:5d7:1941:3567 with SMTP id x128-20020a0dee86000000b005d719413567mr9602659ywe.78.1702666873291;
        Fri, 15 Dec 2023 11:01:13 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:ffe6:85e9:752c:601b])
        by smtp.gmail.com with ESMTPSA id d18-20020a81d352000000b0059a34cfa2a8sm6418597ywl.62.2023.12.15.11.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 11:01:12 -0800 (PST)
Date: Fri, 15 Dec 2023 11:01:12 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 0/2] bitmap-str: A couple of fixes
Message-ID: <ZXyieGvEDXLqHxhn@yury-ThinkPad>
References: <20231215184218.2005611-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215184218.2005611-1-andriy.shevchenko@linux.intel.com>

On Fri, Dec 15, 2023 at 08:41:07PM +0200, Andy Shevchenko wrote:
> Imtended to be folded into original code, hence no proper commit messages.

s/Imtended/Intended

Didn't understand why you didn't write commit messages. It breaks the
very basic rule. Can you elaborate?

> Andy Shevchenko (2):
>   bitmap-str: Get rid of extern
>   bitmap-str: Add missing header(s)
> 
>  include/linux/bitmap-str.h | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> -- 
> 2.43.0.rc1.1.gbec44491f096

