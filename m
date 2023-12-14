Return-Path: <linux-kernel+bounces-12-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A0A813AB6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8D49B21839
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC67769794;
	Thu, 14 Dec 2023 19:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qYY7+BPW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D046978A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 19:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d367e7092eso9325865ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 11:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702582004; x=1703186804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WGe+uUYlDw+uG476SCRJ8n5xCAk3qfvXoM3VQJW7/IQ=;
        b=qYY7+BPW3giEoiFFZ2cP/+HW+VGTFB549jonZLeyDlOeO7gHbgv32VrpOXRFUErtWi
         y3UuH4hif6Xjx9VnwQXGrDCytMvka4qbJKVj4VVPqdqjTicUfjtIkxJ+HQIMouqiUe7s
         hW/o0k12cyD0pf51qJfLElb/jWFMX9edVU8Pdcf2uBUcKTkf44AyXFgAmxzFP14qRwCF
         4vp/yJVXpdKk/4Mgk2hNpoizXGbfnKykEeOBkt5Qi2AWPgHGPPamKdzYTIy91S1Vrbpl
         B1t8T9TMb8jJCgPigccbpaD/GerA4+dkbO5UZn1FZAvCSUv3Nh7lVanyheMeHDyCGubq
         v+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702582004; x=1703186804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGe+uUYlDw+uG476SCRJ8n5xCAk3qfvXoM3VQJW7/IQ=;
        b=hg8QIjGok+w/0jiO8PDGYZBm+M/y49BakYULSwi6SwOAof+FeSQUBf4B92Qu33OxaY
         Lmu1ekPO4K+fK0jrLFQpVmU9DotGnbeNXiIF7zNuWeFBTaULtz92+QSnF5S2EFY1XCXy
         eCuQYHSLpE5gnHoG3AnNBESKgPmglvcScK3+ZM79lW7yplqcMKVL2rrhdXcQO8f7hnzs
         eqEXrgadJBbbv8ZXrfO5SXGwjv7hQ6bwKrAjYWsoWLt9SpNKqX+0a6kYX6LZ9jQGqxXI
         1suWCIWl3XQPRuGoYEWzQUkE/30Nx9K5z70G+H5lRsiyWBLgYcem2O2plNGCBU/UscVo
         uWKQ==
X-Gm-Message-State: AOJu0Yx4bZa4/W0Pl/F6Vnn+WQ1T8DC/w36IYaYW1sA+p1tnzbj7ZaY1
	u2Cr0bYkrm5ABmtqpiV4GAdxbA==
X-Google-Smtp-Source: AGHT+IEGBbmy7QSIym83oljmFI1tPJjJEUP52og7dAI+4/8CMcuOzUA25xCsZbu3ULE4qkw5fTN+hw==
X-Received: by 2002:a17:903:496:b0:1d3:752a:f4ab with SMTP id jj22-20020a170903049600b001d3752af4abmr877729plb.79.1702582004021;
        Thu, 14 Dec 2023 11:26:44 -0800 (PST)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id ja6-20020a170902efc600b001d1c96a0c66sm2564197plb.130.2023.12.14.11.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 11:26:43 -0800 (PST)
Date: Thu, 14 Dec 2023 11:26:40 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: arch/riscv/kernel/module.c:639 process_accumulated_relocations()
 error: uninitialized symbol 'curr_type'.
Message-ID: <ZXtW8IjL1Kf/2B1B@ghost>
References: <d0897fb3-1af8-430b-aa8b-9aa829bad1d7@suswa.mountain>
 <ZXoFhu2TPXgrsInY@ghost>
 <a46f0c36-8fd2-4a85-880c-eb462d4a837b@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a46f0c36-8fd2-4a85-880c-eb462d4a837b@suswa.mountain>

On Thu, Dec 14, 2023 at 11:00:46AM +0300, Dan Carpenter wrote:
> On Wed, Dec 13, 2023 at 11:27:02AM -0800, Charlie Jenkins wrote:
> > > 8fd6c5142395a1 Charlie Jenkins 2023-11-01  638  			}
> > > 8fd6c5142395a1 Charlie Jenkins 2023-11-01 @639  			reloc_handlers[curr_type].accumulate_handler(
> > >                                                                                        ^^^^^^^^^
> > > Can the list be empty?  Uninitialized in that case.
> > 
> > That's a tricky one, the list cannot be empty. Each bucket in the
> > bucket_iter is guarunteed to have at least one rel_entry. I can probably
> > resolve this by extracting this for loop into a do-while loop.
> 
> You can just ignore false positives.  It's not really a fix to change it
> to a do-while loop.  I reviewed the do while code before reading this
> email and I still wondered about empty lists, but just to hear that it's
> not going to be empty is enough.  Just the email was sufficient.
> 
> regards,
> dan carpenter
> 

The freeing was actually broken so that needed to be fixed and I figured
that it was worthwhile to include the do-while in the same patch to get
rid of the warning.

- Charlie


