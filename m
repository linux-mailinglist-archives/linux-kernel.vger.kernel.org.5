Return-Path: <linux-kernel+bounces-14452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C473F821D3C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A56E2837A9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DFE101D5;
	Tue,  2 Jan 2024 14:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fjBFpDQn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE50812E59
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33723ad790cso3028931f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 06:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704204193; x=1704808993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=euPFm6DrMI0+wW/k92PU5TU57T+pTbdKKdKloQ0vt4M=;
        b=fjBFpDQn+rKpd5C0IyqZHp+wzfjeQfH/sm80HwSjWUpHz/zAGqamLC+eZ8cmEGQv9p
         O2yjMBNHcTsn5hUx7SIz2nW9YIHYczJYqd/OfKkgtXYXGMy/dfE084BcpyYckX8eTVHs
         w13ThAQLkrQ7tGysu4LH926feFHL7UkcjyEPGRm8QptKB4iOyGhMqFRVZ8ULHsBFmmH5
         fhGy5Ids+3dQwY919aX2pUMKGQ7TP7pvzQ9+j1oMD7LKG54xy5puno0uaMeE+qEZXOmI
         LxCpR1u5xS/lg/YyaYc+LnwkMzSy5VCyGe4PRGeDu7DS2tmikhCfRST9BKC2i3KeGh1r
         JDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704204193; x=1704808993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euPFm6DrMI0+wW/k92PU5TU57T+pTbdKKdKloQ0vt4M=;
        b=nlzIEx2VThQ/l3Adp8kB6bbZoHJUqvKdUsoBoHORPpEPq7XBGY97cLr+EyzK7XOlnT
         OcUeqpRZ8zjTb9KMJej6qv0Kpz1MJfvG/KMSdcc6mAG/QVHCDVezBwXWgqX8yYEN7XSU
         31AjO4PjAr1LGMjOwF/L8uzYFj3FATtw++XgzcTJ4dzZ+8pN30gBsyFtzUaMtQq4n+CF
         GG0yeG8hoLmSGE4OhK3sQ776AnHmrcbq+N8bOu8lgAKFUNiMz4++MDdTyAFCqddzaKHa
         +gchbBvM+uP+cWjZu9hUl52wmGDCr1uDz4CgHnQ3eKrWcEUC5rlbijXciGFhoDzVMJ/q
         TwvQ==
X-Gm-Message-State: AOJu0Ywoq0X2uxPJma15PvXWja7Q9W1tYxVzhZDDG9rviKzfarv/KI49
	71GjodHmyK3cYEy3GuWnkbUhDyVP7nwoxg==
X-Google-Smtp-Source: AGHT+IExbck5usnFUfBjH1gPXmE5ErcKMgjEsukLhzziZv7BvexAfj4jA2oeb+j+WPaWR5rgjiPNvA==
X-Received: by 2002:a05:600c:4f54:b0:40d:8580:4f1a with SMTP id m20-20020a05600c4f5400b0040d85804f1amr1443638wmq.171.1704204193127;
        Tue, 02 Jan 2024 06:03:13 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id c18-20020a05600c0a5200b0040c6d559490sm45398508wmq.3.2024.01.02.06.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 06:03:12 -0800 (PST)
Date: Tue, 2 Jan 2024 15:37:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: oe-kbuild@lists.linux.dev, lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: arch/riscv/kernel/module.c:639 process_accumulated_relocations()
 error: uninitialized symbol 'curr_type'.
Message-ID: <c11513b4-6e60-44b5-ba12-83fbb9b7e2c3@suswa.mountain>
References: <d0897fb3-1af8-430b-aa8b-9aa829bad1d7@suswa.mountain>
 <ZXoFhu2TPXgrsInY@ghost>
 <a46f0c36-8fd2-4a85-880c-eb462d4a837b@suswa.mountain>
 <ZYzIbVfge6I8Ptw0@ghost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYzIbVfge6I8Ptw0@ghost>

On Wed, Dec 27, 2023 at 04:59:25PM -0800, Charlie Jenkins wrote:
> On Thu, Dec 14, 2023 at 11:00:46AM +0300, Dan Carpenter wrote:
> > On Wed, Dec 13, 2023 at 11:27:02AM -0800, Charlie Jenkins wrote:
> > > > 8fd6c5142395a1 Charlie Jenkins 2023-11-01  638  			}
> > > > 8fd6c5142395a1 Charlie Jenkins 2023-11-01 @639  			reloc_handlers[curr_type].accumulate_handler(
> > > >                                                                                        ^^^^^^^^^
> > > > Can the list be empty?  Uninitialized in that case.
> > > 
> > > That's a tricky one, the list cannot be empty. Each bucket in the
> > > bucket_iter is guarunteed to have at least one rel_entry. I can probably
> > > resolve this by extracting this for loop into a do-while loop.
> > 
> > You can just ignore false positives.  It's not really a fix to change it
> > to a do-while loop.  I reviewed the do while code before reading this
> > email and I still wondered about empty lists, but just to hear that it's
> > not going to be empty is enough.  Just the email was sufficient.
> > 
> > regards,
> > dan carpenter
> > 
> 
> The fix isn't the do-while loop but rather the use after free, the
> incorrect sizeof, and incorrect error handling when
> initialize_relocation_hashtable fails. I decided to include the do-while
> code because I was already touching the surrounding code. Can you review
> [1]? If you would prefer that the do-while is reverted, I can do that,
> but it is important that the rest of the fixes are merged before 6.7 is
> released.
> 
> [1] https://lore.kernel.org/all/20231213-module_loading_fix-v1-1-da9b7c92ade5@rivosinc.com/


Most subsystems wouldn't merge a patch like this which does so many
things at the same time...

regards,
dan carpenter


