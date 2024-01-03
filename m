Return-Path: <linux-kernel+bounces-15951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6F5823628
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9561F212C8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8181CFBC;
	Wed,  3 Jan 2024 20:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XK8FdQRd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1A51CFAD
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 20:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28c5af37d3aso1917597a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 12:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704312529; x=1704917329; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZbXC5eCmmqFTARmpyDuedcNTwdQFCtXDKnroQ3f3H6o=;
        b=XK8FdQRddv8dGDTR1terofZteJ3QHeqR+b3/Nvx0iq+WEAAIBXY1zFDs6h5sXsD+0F
         //kINYySjm0DyDMWg44jCVKfiotniTseQi/ja8s/VbIqh9DVNrTU5wtOm75PtkIZAdAn
         uqm8FrpjQVbFCls9M3olItQObFujNl3q5DpEhEJwL0M22MWeZSiRpO9AaAV3iHLwhIqI
         0K+f1429nr3YAEECQ09s6AcAKvzu4fiP21PEN37FZsKw2+CbNix8DILLIrckiQb7SHEq
         tqDPIsbzHrvaz2aPWIjZd7E5p5La4b5um/l5MgUPhQjr1mxsGcdiDgiYfzW9OzzSSNUG
         o2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704312529; x=1704917329;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbXC5eCmmqFTARmpyDuedcNTwdQFCtXDKnroQ3f3H6o=;
        b=cNL4vtJDpSHFOJqqjZ6h2SV/b//H3JHsJ7YrmOKZHRVbPGVd3mLGwuZjrl6AU3nJa8
         kFPFdaKDM2zJxW+MM7apObAxDQezAOj0HDkvXv2XphF3FJ7gfvNeYBmvpl5gl5ef0xhT
         dJAvaiLsJ1/UjX47anDdWCHtGp2tu3HTaVGxiPRkddyvhHPHr3kwZbvSVFQAtF/INggu
         lcxK72IDsKWJU/paTE1eX7tdobwns87JPGtEsHlSBKKosQtLcldbF/rquvniCkfTOJrB
         JjiWmsytPk0hCt6cnx8HWtdHaWCD5sHi0IC9hiBVOyhr0dlGBWhutIqVkc3SL+s2uF3r
         ndRA==
X-Gm-Message-State: AOJu0YyFunaJvvSodt4nwjt8QI+RKsM2vADRqOjOqXq/s5vWr1k6VDUK
	/7tUfKc6NPf1SMuKqx2Zs2y025gUD2E=
X-Google-Smtp-Source: AGHT+IGLiJzgmgB4U37pca7hhkT8SbqE+p0v4GxcS3Qwg3LOfexhPnD8ksQK8oGV2dG9n66nZP+osw==
X-Received: by 2002:a17:90a:71cc:b0:28c:c24d:165d with SMTP id m12-20020a17090a71cc00b0028cc24d165dmr9719579pjs.1.1704312529402;
        Wed, 03 Jan 2024 12:08:49 -0800 (PST)
Received: from visitorckw-System-Product-Name (IP-216-168.cs.nctu.edu.tw. [140.113.216.168])
        by smtp.gmail.com with ESMTPSA id ca13-20020a17090af30d00b0028acb86f7b5sm2214914pjb.44.2024.01.03.12.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 12:08:48 -0800 (PST)
Date: Thu, 4 Jan 2024 04:08:45 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] min_heap: Min heap optimizations
Message-ID: <ZZW+zcfFOa5YgK2j@visitorckw-System-Product-Name>
References: <20231220083224.3712113-1-visitorckw@gmail.com>
 <CAP-5=fXwa-GSDJX3pO-LSz-D_X7qk2Ck1vtdddtV8ixzsO+5BA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXwa-GSDJX3pO-LSz-D_X7qk2Ck1vtdddtV8ixzsO+5BA@mail.gmail.com>

On Wed, Jan 03, 2024 at 09:56:29AM -0800, Ian Rogers wrote:
> On Wed, Dec 20, 2023 at 12:32 AM Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> >
> > Hello,
> >
> > The purpose of this patch series is to enhance the existing min heap
> > implementation. The optimization focuses on both the heap construction
> > process and the number of comparisons made during the heapify
> > operation.
> >
> > Kuan-Wei Chiu (2):
> >   min_heap: Optimize number of calls to min_heapify()
> >   min_heap: Optimize number of comparisons in min_heapify()
> 
> Thanks Kuan-Wei,
> 
> The patch series looks good to me. Given the extra conditions should
> there be some updates to:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/test_min_heap.c
> to ensure coverage?
>
Hi Ian,

Thank you for your review.

The current min_heap test is sufficient to cover all the code changes
introduced by this patch series, even when only tested with a known
set of values copied from the data.

Additionally, I'm unsure if the commit message title prefix I used is
correct. Perhaps I should use "lib:" instead of "min_heap:"?

Best regards,
Kuan-Wei Chiu


