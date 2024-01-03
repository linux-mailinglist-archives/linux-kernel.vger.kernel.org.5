Return-Path: <linux-kernel+bounces-15984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4CA823692
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1C5A285EEC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414CB1D522;
	Wed,  3 Jan 2024 20:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="YVpFbnd6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B82B1D52F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 20:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6d9bc8939d0so2945603b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 12:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704313638; x=1704918438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xcsOQ9nD5GPnMMvdZNgPzZalWOKW9Ch4bNlsftdutyM=;
        b=YVpFbnd61kSxJs8pNoR9WNm0ig9qBgLqqwQ6bHkBVroBOsf8s41xdjjAh4ZxmfVrQZ
         AONmXMOd2WkX2mU/WfkEDkvqS9zPIKm6LVM8q05FrNfqxIWSMxgwZj/LuqD/5yLSz04s
         wkykAVRS/sI+EvER9WlsohNwCOj2n5RwvWwg9FRmBrc0QhqLr/TXiXJho89S1xixq8ES
         H/sRWcu2Z1qvTfkPUQB8RDcDZisnB5BS1LIEG13Q5rO/ZCOjnoa1VtEEJWnbwg+uvWsb
         Tp+ZZw9g/CLcvcx/c2uqa+Pghl1HgmqMX6LfNxj3W790rbjWwIKos73M3f1p5uWh1yEV
         iiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704313638; x=1704918438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcsOQ9nD5GPnMMvdZNgPzZalWOKW9Ch4bNlsftdutyM=;
        b=TXqDYW1W4bvTwqUrRJsKcFreIGRaQcSPQ3JsbHiNZmkoCVgCTUKmyhrZPYXwI6eVNi
         Pn2d+DEpgTonPRTkydqy+XCgrzyxSEUapJGoOfCQX8oV2pvgB1g6rdI/Uy6Cjesyu4F4
         o+Eg1Zayz/WLcCfNO/s/cYPE/TJxKk6EWhL6rLzllOJ3nGGvjxRbhdSLR2OZ+FQHZeST
         3qyGqCZfCY766gNIZmMyoCKIw7oX77207Wlb6yFwICJSrXUQekFrtwkmnoWnreCmXid3
         dSCQzW26lmAe40QsCXk1ULIhWOZYTcEDoEA3nGSLeP4zIpesc1OPPbC1Qdg1EKq9Mx+V
         ZvXg==
X-Gm-Message-State: AOJu0YzyGk4HtEIKWkY4wZXwDnzSyqOwHbQCnM2+qigxtfATn60uzI43
	YaafRcoKFGg9THSuvn1Rz8yayvgbEVjtuKg2xKXMuMVm/lo=
X-Google-Smtp-Source: AGHT+IGfGjwL1gOAZN1cJcV3cHT0ah1Btx46k+DeH+QlmZ3yh13pe7S1KrdoMLLsu6lIidEfExM5yg==
X-Received: by 2002:a05:6a20:938b:b0:197:58b5:3251 with SMTP id x11-20020a056a20938b00b0019758b53251mr2377252pzh.113.1704313638634;
        Wed, 03 Jan 2024 12:27:18 -0800 (PST)
Received: from ghost (070-095-050-247.res.spectrum.com. [70.95.50.247])
        by smtp.gmail.com with ESMTPSA id u16-20020a056a00099000b006d9c7f2840bsm16045592pfg.57.2024.01.03.12.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 12:27:18 -0800 (PST)
Date: Wed, 3 Jan 2024 12:27:15 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: arch/riscv/kernel/module.c:639 process_accumulated_relocations()
 error: uninitialized symbol 'curr_type'.
Message-ID: <ZZXDI78QsaXzbfR+@ghost>
References: <d0897fb3-1af8-430b-aa8b-9aa829bad1d7@suswa.mountain>
 <ZXoFhu2TPXgrsInY@ghost>
 <a46f0c36-8fd2-4a85-880c-eb462d4a837b@suswa.mountain>
 <ZYzIbVfge6I8Ptw0@ghost>
 <c11513b4-6e60-44b5-ba12-83fbb9b7e2c3@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c11513b4-6e60-44b5-ba12-83fbb9b7e2c3@suswa.mountain>

On Tue, Jan 02, 2024 at 03:37:34PM +0300, Dan Carpenter wrote:
> On Wed, Dec 27, 2023 at 04:59:25PM -0800, Charlie Jenkins wrote:
> > On Thu, Dec 14, 2023 at 11:00:46AM +0300, Dan Carpenter wrote:
> > > On Wed, Dec 13, 2023 at 11:27:02AM -0800, Charlie Jenkins wrote:
> > > > > 8fd6c5142395a1 Charlie Jenkins 2023-11-01  638  			}
> > > > > 8fd6c5142395a1 Charlie Jenkins 2023-11-01 @639  			reloc_handlers[curr_type].accumulate_handler(
> > > > >                                                                                        ^^^^^^^^^
> > > > > Can the list be empty?  Uninitialized in that case.
> > > > 
> > > > That's a tricky one, the list cannot be empty. Each bucket in the
> > > > bucket_iter is guarunteed to have at least one rel_entry. I can probably
> > > > resolve this by extracting this for loop into a do-while loop.
> > > 
> > > You can just ignore false positives.  It's not really a fix to change it
> > > to a do-while loop.  I reviewed the do while code before reading this
> > > email and I still wondered about empty lists, but just to hear that it's
> > > not going to be empty is enough.  Just the email was sufficient.
> > > 
> > > regards,
> > > dan carpenter
> > > 
> > 
> > The fix isn't the do-while loop but rather the use after free, the
> > incorrect sizeof, and incorrect error handling when
> > initialize_relocation_hashtable fails. I decided to include the do-while
> > code because I was already touching the surrounding code. Can you review
> > [1]? If you would prefer that the do-while is reverted, I can do that,
> > but it is important that the rest of the fixes are merged before 6.7 is
> > released.
> > 
> > [1] https://lore.kernel.org/all/20231213-module_loading_fix-v1-1-da9b7c92ade5@rivosinc.com/
> 
> 
> Most subsystems wouldn't merge a patch like this which does so many
> things at the same time...

That is a good point, I split it across 4 different patches.

https://lore.kernel.org/linux-riscv/20240103-module_loading_fix-v2-0-292b160552c9@rivosinc.com/

> 
> regards,
> dan carpenter
> 

