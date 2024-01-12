Return-Path: <linux-kernel+bounces-24413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B81B582BC3A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ECBEB23AC4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54685D74D;
	Fri, 12 Jan 2024 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoerW4Ib"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A272C5B5C1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 08:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50eab4bf47aso5410787e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 00:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705047091; x=1705651891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3NoH8qoCkKWJ/xlxXV8t+mbxpkVHWg2gJxhM/Ol3TbQ=;
        b=BoerW4IbKx/T03vK1lqFpL0Byf9U2V4A7XF8bcATZu2kQ7IjmKUJrStSC0sPafR2Fz
         nzTXVZoTiMiBZ+rGF62mfzA++whlsr05W+k6R/XZhC1t5AjWjwJTFfItlwFIAKzlXgXr
         OV+wAwH/mZ26B0mly4LynDUQWrhsGANaVmZC8CB0sFVeXL43KfCoklrs6KDOXPhPJe9K
         OS0L/gw/guN2IuykrqUijup62OjQfMGRdfgy2kkHPR6MC5p9mriopZ8LgHe1g/G2HlG3
         vPB6H9UIUZCqC15b+YtZ2PeXVUw4M6HJAgRYXci1pNO6b2g0tIM45fB3MwEyxYWvmxsS
         /xQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705047091; x=1705651891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NoH8qoCkKWJ/xlxXV8t+mbxpkVHWg2gJxhM/Ol3TbQ=;
        b=DRMOuNA1Z0t4/SooihpdtBOr1GZE4ff3QIZ4vKGpAiCokMoKDR3M4XsfTrlQuMQP5p
         Vj5loTt4JKWk4jOcRYCS+E0j6dprWKeswJ8tGFHSAKF0WZgkQi0tfEoZntktuhzSARiq
         CPq8Vy7K3eTCLBcuqmP9zVAIbYcol29TFuygn5AXjBfF65/YevAPjS+O3GK2jQFW0PeJ
         C48yaPQCZniaL/q3ybjhs/f0Yceq/ShPrM+/6iE3aOtiBVKb/GTY/uZwTBss2riEuSsq
         5MZsf3HgCBCFNGiLYDSQ+7kJzDIFzwAnh+09qwDUbLw6sHN+3Qj0lixxX2btr9I2Rwwb
         4BBQ==
X-Gm-Message-State: AOJu0YwmE5ZL+32HwNM4ug+neFOTK762EnhSaWda5hMYFbrNEs+XzMIU
	M7iuPFQUUPN+hfTqDp8RAqs=
X-Google-Smtp-Source: AGHT+IFQHhtOxsieltG8UGyMgmlTgU2cFPw74mB3f7bn0Nu/nnaBO9NoFsVJcHS5gLdLYx89BE8g0g==
X-Received: by 2002:a19:4342:0:b0:50e:4b1f:5ddb with SMTP id m2-20020a194342000000b0050e4b1f5ddbmr396182lfj.16.1705047091328;
        Fri, 12 Jan 2024 00:11:31 -0800 (PST)
Received: from pc636 (host-90-233-192-22.mobileonline.telia.com. [90.233.192.22])
        by smtp.gmail.com with ESMTPSA id eq9-20020a056512488900b0050e76f2591bsm437820lfb.58.2024.01.12.00.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 00:11:30 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 12 Jan 2024 09:11:27 +0100
To: Christoph Hellwig <hch@infradead.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Dave Chinner <david@fromorbit.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/1] mm: vmalloc: Fix a warning in the
 crash_save_vmcoreinfo_init()
Message-ID: <ZaD0L7nkFeTwv_g5@pc636>
References: <20240111192329.449189-1-urezki@gmail.com>
 <ZaDSmY5oObFqWCfs@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaDSmY5oObFqWCfs@infradead.org>

> On Thu, Jan 11, 2024 at 08:23:29PM +0100, Uladzislau Rezki (Sony) wrote:
> >  #endif
> >  	VMCOREINFO_SYMBOL(_stext);
> > -	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
> > +	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", (unsigned long) VMALLOC_START);
> 
> Well, the right fix is of course to make sure VMALLOC_START has a
> consistent type, else we need to plaster this crud all over.
> unsigned long seems like the right type for it, so at least m68k should
> be fixed to confirm to that by adding a UL postfix to the definition.
> 
I agree with you. I wanted to focus on fixing that particular place
because i wanted to avoid other(on this step), possible side effects
or drawbacks if i went with patching the arch/m68k/* files.

But, in general arch/m68k/* has to be fixed.

--
Uladzislau Rezki

