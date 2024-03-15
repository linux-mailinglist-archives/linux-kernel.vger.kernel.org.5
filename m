Return-Path: <linux-kernel+bounces-104571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF48787D01E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D5C81F2378B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273463D564;
	Fri, 15 Mar 2024 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="abnvPiIY"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E713B795
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 15:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710516264; cv=none; b=O/sPZFIY4sK021xhx2PVyam9N2kHJae5sDtum4r/QFFmOZkglVu3Ge1qKmq3ouLdIGcAe65C9i5KcFTuAmbalF5mivLcwK3hMj0dcMCnQ9wdr66/ETb0Q1zmJ/TFopsjDFJpYZIoRP2afMvujMSa3NecG0/0E6r8p+ojBWeT9C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710516264; c=relaxed/simple;
	bh=T4YX1b9LsLnqJz2Qbe2p7m1lcJV/OztGgaPBguPahx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rz7hylMj6X3ayl7WR99MsPcvhPAghuCpGiay3OudQSHVPASLoiMCXDMC7vspfOeGvJy2ax7AC24v640lHhmu2NYbp0dO2RoeU+LZMcbTq+5fSNjQPGoHL/6vGuyi77V9NJtluL4cg6mXs8gPqDSfp5SrfJpyK3qXX0VzZDfTOAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=abnvPiIY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1de0f92e649so14510095ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 08:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710516262; x=1711121062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qeyR8khuj1JXfQUm8Drp4Cj0k4eD9xD70/NCm/3VaRE=;
        b=tCFzq4CC6ZuQizOlIKytX5VfMrNjTBhuZ/p/oLiMTDu4UvUdgpmBfC6ereINFtPMtw
         3VwpCVCEgOCxvRj76VIrsbDvHvJ75CyLm09oQqFAYBSUE6RYIPgkvts20OnMHu7teIwn
         ccn9M7h+ODMtLmR0WFEURj+JDobx1rlJ7yLYnP7HuUSegulqh3jwoA4nqHFM+foyTEoZ
         JsLiB3YId2To3i6bmwUofJjscNi+aO7Lg5VRAa38coLQK6LJgaFKS84YPrSlCt8pjtrL
         4Y6OiEnMkCKzhqUreZg7qZM6WCxvQGq6W/bDD47MK7tJAk3nchlKTpk/lr3f54PAsi9b
         rhVg==
X-Forwarded-Encrypted: i=1; AJvYcCVfvZeF9v11OUJjAXzuF1U743dULgomdjzra1WcwhptjhvdcADKXIKDdyf125mKPXJXpI1/Ociid7pS1ompj01uBdcYAVsDMJGLPDaJ
X-Gm-Message-State: AOJu0YwiBcqB2TNsgIn84po3xuMxn6GDeM5txRm2oSXq96HaY16AdJFk
	Thtx/6scWYYijn/XVzNuRg8qm0kEro/sEGNjt1hTMKSSqtsLTqI9v47UFUbH
X-Google-Smtp-Source: AGHT+IEhWT95POVi8wGCLTB07L4RPs/aufcR2aEZ6qtFUJa05DMSbGrARac8eqL0hY/SRAhTZQ3gtQ==
X-Received: by 2002:a17:902:bc41:b0:1dd:e008:9b4d with SMTP id t1-20020a170902bc4100b001dde0089b4dmr4956171plz.35.1710516261728;
        Fri, 15 Mar 2024 08:24:21 -0700 (PDT)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id u11-20020a170903124b00b001dcbffec642sm3934395plh.133.2024.03.15.08.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 08:24:20 -0700 (PDT)
Date: Fri, 15 Mar 2024 12:24:15 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1710516259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qeyR8khuj1JXfQUm8Drp4Cj0k4eD9xD70/NCm/3VaRE=;
	b=abnvPiIYHaKWn7ZM4C3l8liaxu27ryVGqqAXJdfeX7WwZzDIg7/kfNKrY1EOxqHejQxLG1
	rDYxJcjUu6SlR5Izax6p/k2/6YIANaIwDgmupQuRbgWtXOnX1aDxQwNOvHKXzwGzzOWVh3
	vJHG3EWgywUOI2FgFzjdchJ9WKyob6onS3Ydj7efGc/uIIecgyfKDfZTEk3w73F6XT5p/z
	i/l6DGlXpePBxmvqu5sMIp5SHtXyKTsPoMyn1DTZGDJ9bDCGnt48lSft6MOufUdY8qyfD0
	bc/8C4WmwPmVOenwST8lwBmhHvjKR6K6Zr6mxI68aR3rNt6mQEHr37mMY+Ipzw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: John Hawley <warthog9@eaglescrag.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ktest: force $buildonly = 1 for 'make_warnings_file'
 test type
Message-ID: <is6fmigqmsc5gke3hvubwqo65ry3ya744ufniz36jo5uqapdzi@syzccrvffn5y>
References: <20240305-ktest-v1-1-5a93b8b17dba@marliere.net>
 <20240315112240.42c725bd@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315112240.42c725bd@gandalf.local.home>

On 15 Mar 11:22, Steven Rostedt wrote:
> On Tue, 05 Mar 2024 14:02:47 -0300
> "Ricardo B. Marliere" <ricardo@marliere.net> wrote:
> 
> > The test type "make_warnings_file" should have no mandatory configuration
> > parameters other than the ones required by the "build" test type, because
> > its purpose is to create a file with build warnings that may or may not be
> > used by other subsequent tests. Currently, the only way to use it as a
> > stand-alone test is by setting POWER_CYCLE, CONSOLE, SSH_USER,
> > BUILD_TARGET, TARGET_IMAGE, REBOOT_TYPE and GRUB_MENU.
> 
> Ug, I almost forgot this patch.
> 
> > 
> > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> > ---
> >  tools/testing/ktest/ktest.pl | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
> > index 829f5bdfd2e4..ab4bf87ba991 100755
> > --- a/tools/testing/ktest/ktest.pl
> > +++ b/tools/testing/ktest/ktest.pl
> > @@ -843,6 +843,7 @@ sub set_value {
> >      if ($lvalue =~ /^(TEST|BISECT|CONFIG_BISECT)_TYPE(\[.*\])?$/ &&
> >  	$prvalue !~ /^(config_|)bisect$/ &&
> >  	$prvalue !~ /^build$/ &&
> > +	$prvalue !~ /^make_warnings_file/ &&
> 
> I think the above needs to be:
> 
> 	$prvalue !~ /^make_warnings_file$/ &&
> 
> Can you quickly send a v2? I'll try to get it in this merge window.

Hi Steve,

Thanks for the review, I'll send a v2 now.
-	Ricardo


> 
> Thanks,
> 
> -- Steve
> 
> 
> >  	$buildonly) {
> >  
> >  	# Note if a test is something other than build, then we
> > 
> > ---
> > base-commit: 7e90b5c295ec1e47c8ad865429f046970c549a66
> > change-id: 20240305-ktest-9e4452112c93
> > 
> > Best regards,
> 

