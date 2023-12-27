Return-Path: <linux-kernel+bounces-12073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3575081EFA2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51406B21E8C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C632045955;
	Wed, 27 Dec 2023 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MM7EfUSi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C026745947
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2370535060so1115220966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 07:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703689240; x=1704294040; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V+QRdtWHe0JqGvEi74KS9u9tLLnC1lr1gTxEmPtgNaM=;
        b=MM7EfUSiYulEaPlIc4ZWSB1AJIyuBJQJl5Z0dcBEzqqGWlsdg89Kgx2EAG0HAUWAPG
         2mAyLgBVNb48xziqUlmGHanKKJ7YmdhUnoBEkwT7LYof8GSxo5XIItqGw1mX0BwJddCT
         Y6rLSc+KlnElDP5wR5i5mB+Rna/LjQgI+lXMpcgL0bwh0ITJzFt4opcPGjGoCjmLj1Qv
         s6fpbVv+acMAM4gHyZm63YzjqJ36oSUXMfidEIOdU6RaeSozbLM40rL85VVhC4WgpOwN
         1t4BemeS/tjS6vlxafKsxj1mOOFL7Pb1fRUz4kcqJ9V5Sj1MTQ0fIwKd1Z1eD7b44IpL
         fSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703689240; x=1704294040;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+QRdtWHe0JqGvEi74KS9u9tLLnC1lr1gTxEmPtgNaM=;
        b=F/qYg3ruGRJnpF+I33eBpvmNvK61QS0NPaGlnt0nDT/qOUkTt9A1Ogi56KFQCet0LP
         dLS0qE3O/cEPzP0RHcS2dx4J3Va0k8kH/bZSAv6+JnErQKP4mTseaFzDqkmosR8e9AB7
         e3ZnA2rKn6kdO/NV+ko0VxyPDUS2fVi24Usza7A161Cj+Xq/KlTjJMMCQKphbCEof9xN
         V7FWMb815Cc/gtFwlCYDS7DBFlHyq1SS7fhIOqBML4eJeyOznnE7ZEQVkdiwCjyeCpTq
         Vo/Wc7FJ0SCP2/mD0737QmtylNkR5rAC6CG1TTbiBm7pYZMqcMxoFr7gPSHgWeTm8jQc
         q/iw==
X-Gm-Message-State: AOJu0Yy3v2xms1urPqWnbjGxGZMs5hlsbg7OvbkAuKhccVH1VP/aJ3DE
	zqr0Z4LwCtzuQVKHJv8mIQ==
X-Google-Smtp-Source: AGHT+IEbagaZjU3VlzDnoCO5idV1u6dm5rmIevasviPAH2Ip4fJrELV7fgv7g5P1O9kX9CX9d3oo7Q==
X-Received: by 2002:a17:907:3fa4:b0:a23:671c:2284 with SMTP id hr36-20020a1709073fa400b00a23671c2284mr12644916ejc.29.1703689239872;
        Wed, 27 Dec 2023 07:00:39 -0800 (PST)
Received: from p183 ([46.53.248.146])
        by smtp.gmail.com with ESMTPSA id wl1-20020a170907310100b00a2697984204sm6585366ejb.72.2023.12.27.07.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 07:00:39 -0800 (PST)
Date: Wed, 27 Dec 2023 18:00:37 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	christophe.jaillet@wanadoo.fr, andriy.shevchenko@linux.intel.com,
	David.Laight@aculab.com, ddiss@suse.de
Subject: Re: [PATCH 0/3] kstrtox: introduce memparse_safe()
Message-ID: <861c1479-519d-448d-b8d4-0cdfd872c655@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

> fs/btrfs/ioctl.c        |   8 +-
> fs/btrfs/super.c        |   8 ++
> fs/btrfs/sysfs.c        |  14 ++-
> include/linux/kernel.h  |   8 +-
> include/linux/kstrtox.h |  15 +++
> lib/cmdline.c           |   5 +-
> lib/kstrtox.c           |  96 ++++++++++++++++++
> lib/test-kstrtox.c      | 217 ++++++++++++++++++++++++++++++++++++++++
> 8 files changed, 364 insertions(+), 7 deletions(-)

Please keep memparse stuff out of kstrtox.c .
kstrtox.c is for kstrto*() functions.

