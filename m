Return-Path: <linux-kernel+bounces-140713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EA58A1813
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF8DBB230D2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E67134A6;
	Thu, 11 Apr 2024 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ox36SUOR"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A1ABE7F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712847946; cv=none; b=JILdZAFHge2gLLyqg8vP1ZVz5AGx+Krxg8/RcVRtYd/28M/gjl9TlxgAwNp4PAA3uivGGRNS+lTO9VIRZv2rv0LESzPYvalcxLEIwGdY1zITY7nO4+WQhqygBS4PimUH2Xjr51V6yAMOkn+2hfTUFf/RDrq5DzUZqI80tzibye0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712847946; c=relaxed/simple;
	bh=lAlok4zEqiaQwBAnt2rrlpAmjwc9vUB1DK10nldsJhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gegPjmmvJqVDLJzwRciMOLF7bdJdx/FlQdz06BdM5V+1LXRBYgoqy8C+OJOzDdMl11Zbn3vAaQRqWyZqUQ/RTFfC+xiiq6Z3+ukG5HARmnJmRBwP+uEn3JegwgQPJFIPtgi3QmJdYrBHfdXadZgAID3Pn07i9u1H6WJk/Zby30s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ox36SUOR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e3e84a302eso35499965ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712847942; x=1713452742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/zr/QOGV8WG6iD30xr5AmhWrZhKjTiULTZdWbAs9kE=;
        b=Ox36SUORAk8nV/oF85yE+kZ62yjqEhgIQmfGv+9WNbA26Dh2336GN//RjgLPoiem6w
         vYNkbof+7ZlZr1dLf/U/rA98TY4fLTnqJUg22SN6lbYoc7eIYZft2u3YAK1a61y01fnb
         W3ItQLCzCw7Vgera4sunQpTE5pDdFOVUGKCwOOEGxNA/hOmWVK4lW3QgEUet1DmkUXBD
         CT9SKG2fKW0hBtp0grGVL0kMlshDnLuQuEthMz7ESHERyQ6X5YSmhHmz1KeUEzoaITqO
         HT8afaMzUrO/o0IDDdWTcguHioOmBLw0sivVpni9D2pCQjsFPI0Egm412t2H8a1LXB3I
         uTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712847942; x=1713452742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/zr/QOGV8WG6iD30xr5AmhWrZhKjTiULTZdWbAs9kE=;
        b=hCwBCeHzY63ECRda1BbL5GJF/m/ZqVtOP+6i1DiuAdyPRDTBKzFhiGNRp+uVEl0QaT
         tIMNzWjxkfeCKMQTCexDDsuTp6eWNGLe0LVLSUuU+2KOub9VcTx/Amdeh3kI84IEUYeI
         jhS0Qb6CmPcRTf0+hN2JfKTvNQxHWEl1naQxEjedTrt0Aebjy7su10ogXwGBpGqMQUSd
         ndwoyrDOPbwdFuQv33A+1GwsCuLA2+avYqECmsttH1UMM4bVEXv5iLnXXOElJ6wfUPLo
         Wh2zUPKUOqadndGvxZUScmmh0srerxCs6AxwVkPbc2xsEfKq+nB4vRDRs5A8zu9HShvS
         fcaA==
X-Forwarded-Encrypted: i=1; AJvYcCUe50qU/ty2z0LSDgfe/zeyaCoaRSPwlaOGKqI0GtFaOE1lYDRjHQyNPfs3JLQLXkW1unawxMd7VRlf/qvz0Xo6i2CHq+7Fo2DlnKv2
X-Gm-Message-State: AOJu0YyZtJmbjRTqegjl7wvpKZVj0kD2k2e729xx13X7k0EZl7yvYBgF
	WkEDX601w3y2v2fY3s4wVeuJU0oQFVjYRrsfXACdHY2AkrgnnR06
X-Google-Smtp-Source: AGHT+IETVeiQ8RBTLZcGj7CIA+eD8hWd/i+I6hT5ZOjRAS152hojcWNb/OuSqUfeqhUw8kva8yEIXw==
X-Received: by 2002:a17:902:7008:b0:1e4:3ad5:b6d6 with SMTP id y8-20020a170902700800b001e43ad5b6d6mr5511831plk.37.1712847942148;
        Thu, 11 Apr 2024 08:05:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090264c800b001e47972a2casm1298551pli.96.2024.04.11.08.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:05:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 11 Apr 2024 08:05:39 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	David Gow <davidgow@google.com>, Will Deacon <will@kernel.org>,
	mic@digikod.net, keescook@chromium.org, rmoar@google.com,
	lkft-triage@lists.linaro.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	mingo@redhat.com, longman@redhat.com, boqun.feng@gmail.com,
	anders.roxell@linaro.org, arnd@arndb.de,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: BUG: KASAN: null-ptr-deref in _raw_spin_lock_irq next-20240410
Message-ID: <fd604ae0-5630-4745-acf2-1e51c69cf0c0@roeck-us.net>
References: <20240410102710.35911-1-naresh.kamboju@linaro.org>
 <20240410152307.GA25111@willie-the-truck>
 <CABVgOSmJX=scCGZ7FWafpKB8CdQD17Uh5MuTeoFx2BhGC0DMSw@mail.gmail.com>
 <CA+G9fYuuLXnVuc2fqy_-EY3QBiUxroU9uw74vZ2i08qW=-q1tQ@mail.gmail.com>
 <CA+G9fYt6U4YzYGvYWxDVvUVKNc0pgVYiGafZ5_OSEf=5r1=YYA@mail.gmail.com>
 <f2d02e35-185e-44d1-9b58-1034336e2e0d@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2d02e35-185e-44d1-9b58-1034336e2e0d@moroto.mountain>

On Thu, Apr 11, 2024 at 06:00:25PM +0300, Dan Carpenter wrote:
> On Thu, Apr 11, 2024 at 08:20:55PM +0530, Naresh Kamboju wrote:
> > 
> > I use to notice kernel panic while running kunit tests
> > now I have noticed this
> > 
> > Unable to handle kernel paging request at virtual address
> > KASAN: null-ptr-deref in range
> > pc : kunit_test_null_dereference (lib/kunit/kunit-test.c:119)
> > lr : kunit_generic_run_threadfn_adapter (lib/kunit/try-catch.c:31)
> > 
> > The kunit tests run to completion and the system is stable.
> > Kernel did not panic.
> > 
> 
> [ Snip ]
> 
> > <0>[   76.808597] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> > <4>[   76.809876] Modules linked in:
> > <4>[   76.812055] CPU: 1 PID: 567 Comm: kunit_try_catch Tainted: G
> > B            N 6.9.0-rc3-next-20240410 #1
> > <4>[   76.812987] Hardware name: linux,dummy-virt (DT)
> > <4>[   76.814123] pstate: 12400009 (nzcV daif +PAN -UAO +TCO -DIT
> > -SSBS BTYPE=--)
> > <4>[ 76.814947] pc : kunit_test_null_dereference (lib/kunit/kunit-test.c:119)
>                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This is a new intentional NULL dereferencer that was added yesterday.
> 
> Maybe these should have a big printk, "Intentional NULL dereference
> coming up!\n".
> 

Can the backtrace be suppressed, similar to the warnings suppression I am
working on ?

Thanks,
Guenter

