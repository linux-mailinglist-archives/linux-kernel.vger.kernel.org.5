Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2621805C0E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345312AbjLERFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345276AbjLERFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:05:53 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58891AA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:05:57 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54917ef6c05so7367557a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 09:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701795956; x=1702400756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R1K+1G9jV9cMz0Q64D03lk7V9VhpTBUeMxZV0+5svsQ=;
        b=eYAZgBe9AnTUIGjB8x2atLqkRwVED9EMyILEDhnTQvkqk5VZ8+SBCQMvoxHjcNNbrR
         /B+7HpqYRkvyme7hlFPK95gEG+DfBmjnVMdTICfepesC51EOlAUR0bvVNwDOcK27JA76
         nr41CYTqvcbxER4+Xneugu07UcnpbAVVuuKeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701795956; x=1702400756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1K+1G9jV9cMz0Q64D03lk7V9VhpTBUeMxZV0+5svsQ=;
        b=ecc4CvQA+0RNo7vEjZDwomlG0pLr9yr+AQmNk3tNzVkOVtM1TZKsfPD7XVR7lmAkPy
         uQULaesuWw7p0TQ574HJppqWn52MnHGdgYT5q5bd6ZimfHb1B1aNalF3gdti0vtzfPjN
         HtyFBYIbLbD7T717wYSEsia7vAkluX1Kzf/9y0qlGdwg+qlI4dmBgg5PiDDx1oDrtWxr
         Y43fm20VwaWR6mld0/wDR/n5Y0yC5qZrbXpj6HuXhQWC8SQaazcgXRIUJiCnQS6st+mg
         aQu+rwhx3BhNgIipDrEe40wwmT+0GU2UHIDv/h8dxZZhn6KGdZUlSEJL6nfBbjdf5SqK
         temA==
X-Gm-Message-State: AOJu0YyqjkJV/DELIjOwHry2UJVvLlo85JbQTTIWgL37MO6wL4tvY155
        7s2VIBckgpPA/XkzwWLFNEw7/A==
X-Google-Smtp-Source: AGHT+IEJjv6k4HHDmPuN/DOL3JgyIPQJ5mOx/E0GmdjiSXKSC5qRKQSfAzW1uPBtvrB536WJjRMELQ==
X-Received: by 2002:a05:6402:520d:b0:54d:255a:4354 with SMTP id s13-20020a056402520d00b0054d255a4354mr608038edd.13.1701795955970;
        Tue, 05 Dec 2023 09:05:55 -0800 (PST)
Received: from google.com ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id l4-20020a056402124400b0054c9635b24esm1334843edw.21.2023.12.05.09.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 09:05:55 -0800 (PST)
Date:   Tue, 5 Dec 2023 18:05:53 +0100
From:   Dmytro Maluka <dmaluka@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/thp: add CONFIG_TRANSPARENT_HUGEPAGE_NEVER option
Message-ID: <ZW9YcT6jH3JjdJSy@google.com>
References: <20231204163254.2636289-1-dmaluka@chromium.org>
 <20231204111301.7e087b2f851b30121561e8fc@linux-foundation.org>
 <ZW4vLV_LDFLf1cJQ@google.com>
 <20231204121524.dfa9f98e809c91b353968d34@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204121524.dfa9f98e809c91b353968d34@linux-foundation.org>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 12:15:24PM -0800, Andrew Morton wrote:
> On Mon, 4 Dec 2023 20:57:33 +0100 Dmytro Maluka <dmaluka@chromium.org> wrote:
> 
> > On Mon, Dec 04, 2023 at 11:13:01AM -0800, Andrew Morton wrote:
> > > On Mon,  4 Dec 2023 17:32:54 +0100 Dmytro Maluka <dmaluka@chromium.org> wrote:
> > > 
> > > > Add an option to disable transparent hugepages by default, in line with
> > > > the existing transparent_hugepage=never command line setting.
> > > > 
> > > > Rationale: khugepaged has its own non-negligible memory cost even if it
> > > > is not used by any applications, since it bumps up vm.min_free_kbytes to
> > > > its own required minimum in set_recommended_min_free_kbytes(). For
> > > > example, on a machine with 4GB RAM, with 3 mm zones and pageblock_order
> > > > == MAX_ORDER, starting khugepaged causes vm.min_free_kbytes increase
> > > > from 8MB to 132MB.
> > > > 
> > > > So if we use THP on machines with e.g. >=8GB of memory for better
> > > > performance, but avoid using it on lower-memory machines to avoid its
> > > > memory overhead, then for the same reason we also want to avoid even
> > > > starting khugepaged on those <8GB machines. So with
> > > > CONFIG_TRANSPARENT_HUGEPAGE_NEVER we can use the same kernel image on
> > > > both >=8GB and <8GB machines, with THP support enabled but khugepaged
> > > > not started by default. The userspace can then decide to enable THP
> > > > (i.e. start khugepaged) via sysfs if needed, based on the total amount
> > > > of memory.
> > > > 
> > > > This could also be achieved with the existing transparent_hugepage=never
> > > > setting in the kernel command line instead. But it seems cleaner to
> > > > avoid tweaking the command line for such a basic setting.
> > > > 
> > > > P.S. I see that CONFIG_TRANSPARENT_HUGEPAGE_NEVER was already proposed
> > > > in the past [1] but without an explanation of the purpose.
> > > > 
> > > > ...
> > > >
> > > > --- a/mm/Kconfig
> > > > +++ b/mm/Kconfig
> > > > @@ -859,6 +859,12 @@ choice
> > > >  	  madvise(MADV_HUGEPAGE) but it won't risk to increase the
> > > >  	  memory footprint of applications without a guaranteed
> > > >  	  benefit.
> > > > +
> > > > +	config TRANSPARENT_HUGEPAGE_NEVER
> > > > +		bool "never"
> > > > +	help
> > > > +	  Disabling Transparent Hugepage by default. It can still be
> > > 
> > > s/Disabling/Disable/
> > 
> > It is in line with the descriptions of TRANSPARENT_HUGEPAGE_ALWAYS and
> > TRANSPARENT_HUGEPAGE_MADVISE: "Enabling Transparent Hugepage ..."
> 
> Those are incorrect also.

Ok, corrected in v2. Also clarified the changelog wrt your 2nd question.

> > > > +	  enabled at runtime via sysfs.
> > > >  endchoice
> > > 
> > > The patch adds the config option but doesn't use it?
> > 
> > I should have been more precise: it is not a new option but a new choice
> > for CONFIG_TRANSPARENT_HUGEPAGE, in addition to the existing ALWAYS and
> > MADVISE choices. In mm/huge_memory.c in the declaration of the
> > transparent_hugepage_flags variable, if either ALWAYS or MADVISE is
> > chosen, transparent_hugepage_flags is initialized with such a value
> > that makes khugepaged being started by default during bootup. This patch
> > allows enabling CONFIG_TRANSPARENT_HUGEPAGE without setting either
> > ALWAYS or MADVISE, so that transparent_hugepage_flags is initialized
> > with such a value that khugepaged is not started by default.
> 
> OK, thanks.
