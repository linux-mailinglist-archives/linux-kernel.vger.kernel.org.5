Return-Path: <linux-kernel+bounces-17173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A1D82492B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B92282342
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873C12CCDA;
	Thu,  4 Jan 2024 19:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hjK4Bvhw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB35E2CCBA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 19:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso647725a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 11:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704396985; x=1705001785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5jyLPzGlkBzpMC1Ie2DgS7N7g7HFIfbpKPqTLTs2R68=;
        b=hjK4Bvhwta+qX9IgS73+a13RTbjKwG9l1YvUBiE7VYGu9Wq5EPTvwsakzroPRIyslY
         jVeo3rNztqECE279ag2ZNeUYYbuvMt9vAlfU+zomc4ivz3SgXVRDORg2W/wLEWO/1GaO
         AwNJoV7aWUTDqMsdq0QNKYJKLOou/2Hr/+8UEBR0a+K41i5n540I1T+VtzfBX5llE6lP
         Ds0pscuu0HHNr70Sl7PzREpIqSxNdBn6ikB+Hhd6y1e3SQgfBbszAJJ5lIWWUOyLmksM
         UB+m+JMvwBdIs/bdzMJGX1FtahhGfDPSPyULn1GxbukF6jDikHukID2LYXF1KdWZaeAO
         p66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704396985; x=1705001785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jyLPzGlkBzpMC1Ie2DgS7N7g7HFIfbpKPqTLTs2R68=;
        b=ZlUsjxjVam7lKOM7c77bBeONKYp148zM1wFGXg/efKo4FFQKIP9Bm1QxtUfACpAoei
         Mmc/s6I2tMLmywE2gMNe8q9ZLavc/gXUxOG9smTMgccRf2FJsiMeBJY9s067NSnuNYTw
         ob9QCL2zdJRxvrFF75zT2Y682JEfNL/l6vFDIBxUQVdD9yKBZ8m1eYB1PIExdk6qoS6c
         X1l3hgCeqFVAclVF22VqrfT9EVzuWYIKm7n0BrawAXP9kk22wmqJzGa27V+VtTArV2Mv
         K31Tt8obUbtE0zGiOF4xC8rMK+H1rn4lls/mpqrH3Nlb19gVYirhgVikbVXOvFEBJXoo
         SrWw==
X-Gm-Message-State: AOJu0YzWDmTprM0jbYP4araTYQ2jk6s/4mhDcw9eRoo5pCurCLccd4ff
	MjBRMHxQXlGvPqdywGhv3tNaNgWQsfJIlg==
X-Google-Smtp-Source: AGHT+IG/iL6sTjfq2ya9QGl5wDoK7MD1hL09Yv8G/ovDwT5oWVUmHs7UgRl9PtyO8HocqpDkSoN/6g==
X-Received: by 2002:a05:6a20:8415:b0:197:5be1:262b with SMTP id c21-20020a056a20841500b001975be1262bmr1108314pzd.83.1704396984958;
        Thu, 04 Jan 2024 11:36:24 -0800 (PST)
Received: from ghost ([2601:647:5700:6860:bd91:d703:f34:7cf7])
        by smtp.gmail.com with ESMTPSA id ko7-20020a056a00460700b006d9a0694f93sm23013pfb.205.2024.01.04.11.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 11:36:24 -0800 (PST)
Date: Thu, 4 Jan 2024 11:36:22 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v2 4/4] riscv: Convert relocation iterator to do-while
Message-ID: <ZZcIthn20O1l1DDL@ghost>
References: <20240103-module_loading_fix-v2-0-292b160552c9@rivosinc.com>
 <20240103-module_loading_fix-v2-4-292b160552c9@rivosinc.com>
 <39727434-a265-484b-9ee6-da6611487b47@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39727434-a265-484b-9ee6-da6611487b47@moroto.mountain>

On Thu, Jan 04, 2024 at 03:35:55PM +0300, Dan Carpenter wrote:
> On Wed, Jan 03, 2024 at 12:22:03PM -0800, Charlie Jenkins wrote:
> > Use a do-while loop to iterate through relocation entries to prevent
> > curr_type from being marked as uninitialized.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > Fixes: d8792a5734b0 ("riscv: Safely remove entries from relocation list")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <error27@gmail.com>
> > Closes: https://lore.kernel.org/r/202312130859.wnkuzVWY-lkp@intel.com/
> > ---
> >  arch/riscv/kernel/module.c | 26 +++++++++++++++++++++-----
> >  1 file changed, 21 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> > index ceb0adb38715..581e425686ab 100644
> > --- a/arch/riscv/kernel/module.c
> > +++ b/arch/riscv/kernel/module.c
> > @@ -633,15 +633,31 @@ process_accumulated_relocations(struct module *me,
> >  					  bucket_iter->bucket, node) {
> >  			buffer = 0;
> >  			location = rel_head_iter->location;
> > -			list_for_each_entry_safe(rel_entry_iter,
> > -						 rel_entry_iter_tmp,
> > -						 rel_head_iter->rel_entry,
> > -						 head) {
> > +			rel_entry_iter =
> > +				list_first_entry(rel_head_iter->rel_entry,
> > +						 typeof(*rel_entry_iter), head);
> > +			rel_entry_iter_tmp =
> > +				list_next_entry(rel_entry_iter, head);
> > +
> > +			/*
> > +			 * Iterate through all relocation entries that share
> > +			 * this location. This uses a do-while loop instead of
> > +			 * list_for_each_entry_safe since it is known that there
> > +			 * is at least one entry and curr_type needs to be the
> > +			 * value of the last entry when the loop exits.
> > +			 */
> 
> I know that I reported this static checker and all, but actually after
> reading this comment, I think we should stay with original code.  So
> long as we know the list has "least one entry" which we do then the
> original code worked fine.
> 
> To be honest, I probably would not have even reported this static
> checker warning except that I saw there were some other issues and
> thought "Eh, why not throw this warning in as well, in case the list
> can be empty."

That makes sense, I will drop that patch.

- Charlie

> 
> The other three patches look good.
> 
> regards,
> dan carpenter
> 

