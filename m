Return-Path: <linux-kernel+bounces-59162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD8184F260
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50AA61F235BB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7B967E98;
	Fri,  9 Feb 2024 09:38:50 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CB76773D;
	Fri,  9 Feb 2024 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707471530; cv=none; b=l+ZM3bEvefvHAhbJU6PrXy1TzQSdyd5X1jCuTa+oJhj4Ud0t89PiGk5tLUJ5WpUmxmDMwbj+xNy0mVeRif0XI0U8qP64qumOuMG5DoFPQo9OSJzT3o3Gp01cQsoqFoRX9RaXn/j+0eDStbFr51qvTAylnSWBkxaIajQokHnzOWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707471530; c=relaxed/simple;
	bh=4m6a5876SQA1NUief4+jK7LVq+KiWq9Z84xoR9gABks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTufNZhYH+CDdzzxVN2PacSQ7Ze8pzsjyZySIpy2/LcDV4F06ZShE9ISiwrs7bilNkKANJrIvFpctf/XUU+mSiVVSIPr7vWuEayj0nWHolKYHsUEYKHm2NHTalfw8k7fxycCmum2U/IX9tZn4VlpBvo1zs2fzszyFlfbLJMDREE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so86659566b.1;
        Fri, 09 Feb 2024 01:38:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707471527; x=1708076327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFK69TN15uEx6nooZheXSTnCffm62/HtBc6JubI+FHk=;
        b=Ofm8gr6ER0rm+YjiLKGkMt/Cknp6I69q2J9NIvUZ9OnI0t6RtvDPYtmT7BpRpbZwvx
         EnsQZtvs5gWxGZGde0wIPEl59bQrlhHK4HB0x83piNAGddBkv65GTB7U9OQBxuefaQlT
         Kns19n053wsIsOEWggJ3xZNPAdcNzQXJEWMTlbSTpM8T/4FpNujoDd8RNrpXkmSNQfDW
         JOrgeTMjElc6r+MI6nVRfQbFqV31qN5gybiqN+NGvS+kxv13GyLpkKUuCGnY6dZH2/cO
         XKP6nRF9YliOWp/NMqXy3YILC/7tK4s6kAh2F06jb1CFjd4TcHiuROq+oyo6kPDvnKHh
         A4vw==
X-Forwarded-Encrypted: i=1; AJvYcCWiZIKXLmACJ96vHKGTRv9ZqK5yHE9ZppXoUDsPe7S7baM9YYoEyckq1GXTCUEz11beRbJQWP7adC4ZnpveMldAedViBPbsHC2JHr78qwo+H+23PyV+51DtcLTaNLzP/M67DL+KXhrh
X-Gm-Message-State: AOJu0YydpxEsmyAAvTzrwYU1CBzMZgXDewl+oOOt5/AQi4Iw+9xiMt/3
	iHi5xzi6VFLZzvn8Z1veXz9Y8gHiVJNIFaRKCmR5foj4YNDyl/EX
X-Google-Smtp-Source: AGHT+IGQpexiA41S9wrLVOCjQw3Q9x4yhvKyTawb3dBy9ugqpL32UraSTrCIfnWl0hbGFdXvxWVVKA==
X-Received: by 2002:a17:906:bcd6:b0:a37:e33b:816a with SMTP id lw22-20020a170906bcd600b00a37e33b816amr716548ejb.26.1707471526764;
        Fri, 09 Feb 2024 01:38:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXanI7PzSQum0+qpq9wGAXLqvuzuAxdZRTHKJMS6PgP6TGHXJHaYCoD8DkwvvNMo+/okvjg6Gium1BaTCw2pm9hN8mYnwBnnFiFzvz6N5Y/oWJYHI7W/SwoZE70Dbhim1fXEY1wWV36OH+BTdtFBF39mWaDYkQ1pBCCsjxMBTxq4cM=
Received: from gmail.com (fwdproxy-lla-119.fbsv.net. [2a03:2880:30ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id kq22-20020a170906abd600b00a35de0619dbsm570280ejb.200.2024.02.09.01.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 01:38:46 -0800 (PST)
Date: Fri, 9 Feb 2024 01:38:44 -0800
From: Breno Leitao <leitao@debian.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Thorsten Blum <thorsten.blum@toblux.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH] docs: Makefile: Fix make cleandocs by deleting generated
 .rst files
Message-ID: <ZcXypIwlSZnH/kTf@gmail.com>
References: <20240208145001.61769-1-thorsten.blum@toblux.com>
 <87a5oafu1z.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5oafu1z.fsf@meer.lwn.net>

On Thu, Feb 08, 2024 at 03:52:08PM -0700, Jonathan Corbet wrote:
> Thorsten Blum <thorsten.blum@toblux.com> writes:
> 
> > The script tools/net/ynl/ynl-gen-rst.py (YNL_TOOL) generates several .rst
> > files (YNL_INDEX, YNL_RST_FILES) in Documentation/networking/netlink_spec
> > (YNL_RST_DIR) which are not deleted by make cleandocs.
> >
> > Fix make cleandocs by deleting the generated .rst files.
> >
> > Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> > ---
> >  Documentation/Makefile | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/Makefile b/Documentation/Makefile
> > index 3885bbe260eb..4479910166fc 100644
> > --- a/Documentation/Makefile
> > +++ b/Documentation/Makefile
> > @@ -176,6 +176,7 @@ refcheckdocs:
> >  	$(Q)cd $(srctree);scripts/documentation-file-ref-check
> >  
> >  cleandocs:
> > +	$(Q)rm -f $(YNL_INDEX) $(YNL_RST_FILES)

I haven't check but I _think_ that just deleting $(YNL_INDEX) is enough
here, since $(YNL_INDEX) depends on $(YNL_RST_FILES).

> >  	$(Q)rm -rf $(BUILDDIR)
> >  	$(Q)$(MAKE) BUILDDIR=$(abspath $(BUILDDIR)) $(build)=Documentation/userspace-api/media clean
> 
> So this seems worth doing ... except that there has been talk about not
> depositing those files into the source tree in the first place.  Adding
> Vegard and Breno to see if they have any thoughts on the matter...

Agree. This is definitely worth doing.

