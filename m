Return-Path: <linux-kernel+bounces-1027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6BF814971
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC3EF1F25F9A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017B42DF96;
	Fri, 15 Dec 2023 13:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YQB9rvIg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2FE2F869
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702647403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PeGoU3o+S7+CrRMsRKZCUSMgsVnOClZrkqDfWJvQpQE=;
	b=YQB9rvIgW9rL6fo4SUrjobSlWd+8zdcTAcY6n8iEea6amGLovqBDgdB4anCBzLIDFlYMw6
	YsY7vTWrbKJV2U6UKQnjwcbNLollhGzVAe+1ZxXm/j1Y048zyY6XIMRrI9GB4fBPLpP+iu
	2GcPaXfHg5XAl9cVrzgy1mjnnOcCR2o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-JuIpaKHZPyehnP8hS5vNDw-1; Fri, 15 Dec 2023 08:36:42 -0500
X-MC-Unique: JuIpaKHZPyehnP8hS5vNDw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40c35d1d776so5320985e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 05:36:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702647400; x=1703252200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PeGoU3o+S7+CrRMsRKZCUSMgsVnOClZrkqDfWJvQpQE=;
        b=ASleW1597b32rhDOI0gsUzYosa4RWeJyO9MawI5jQleUOXKQGFTrt0MoyEsL6mGHkf
         ceryARtq3+GYN6Zy3q7huF/mD5mGcGEjR7N2UBg/xKqXbMyeO2Uon7+CAI4bXEmB/RH+
         qko7fdVGtm77o+JBqNrMnZLSeSNKWOQhH2e2Vg0HTOI0sOeC4N9ZoNHqXD6YDw7MxMPl
         u68WblwYu7OMiUhUbEdB3qFAX4tgBbCGsYIhvAlY41k/Xx1bGBd3z28GL6hKGOlPvCKJ
         nXKHts6xwduBaqrhm3L6fg/RSDsuMG2Cq8gfymjPxQOw3IU9Hg7uLvXTclMDeerENaif
         HYuQ==
X-Gm-Message-State: AOJu0YzsnqWE7jkEXPSDK/NCJpiRLK+XUlJ1jDKXUbknudb/RcuNj5wm
	XknLk+n/fWgt+f9vAt7cN/Svr2gmOXtwHBOQhZIikOYosVPeHbPZ62Dodd7jewu+r5edKfLRAyB
	K9rzpuO/s8YCnDUuHOqSA3xMhBvh8z5to
X-Received: by 2002:a05:600c:30d2:b0:40c:4378:f111 with SMTP id h18-20020a05600c30d200b0040c4378f111mr4670768wmn.80.1702647400358;
        Fri, 15 Dec 2023 05:36:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNqnCnqPED8jOPTrsrHmCaOogZEFFYNAlGMfhhBxoxOjIysGAkQmntROKUnv2U3WFzoyYr1A==
X-Received: by 2002:a05:600c:30d2:b0:40c:4378:f111 with SMTP id h18-20020a05600c30d200b0040c4378f111mr4670759wmn.80.1702647399910;
        Fri, 15 Dec 2023 05:36:39 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id kt17-20020a1709079d1100b00a015eac52dcsm10720815ejc.108.2023.12.15.05.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 05:36:39 -0800 (PST)
Date: Fri, 15 Dec 2023 14:36:38 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Woithe <jwoithe@just42.net>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [Regression] Commit 40613da52b13 ("PCI: acpiphp: Reassign
 resources on bridge if necessary")
Message-ID: <20231215143638.032028eb@imammedo.users.ipa.redhat.com>
In-Reply-To: <ZXw4Ly/csFgl76Lj@marvin.atrad.com.au>
References: <ZXpaNCLiDM+Kv38H@marvin.atrad.com.au>
	<20231214143205.4ba0e11a@imammedo.users.ipa.redhat.com>
	<ZXt+BxvmG6ru63qJ@marvin.atrad.com.au>
	<ZXw4Ly/csFgl76Lj@marvin.atrad.com.au>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Dec 2023 21:57:43 +1030
Jonathan Woithe <jwoithe@just42.net> wrote:

> On Fri, Dec 15, 2023 at 08:43:29AM +1030, Jonathan Woithe wrote:
> > On Thu, Dec 14, 2023 at 02:32:05PM +0100, Igor Mammedov wrote:  
> > > On Thu, 14 Dec 2023 11:58:20 +1030 Jonathan Woithe wrote:  
> > > > 
> > > > Following an update from 5.15.72 to 5.15.139 on one of my machines, the  
> > > 
> > > looks like you are running downstream kernel, can you file bug report
> > > with distro that you use (with a link posed here as well).  
> > 
> > I am running Slackware64 15.0.  The kernels supplied by that distribution
> > are unmodified kernel.org kernels.
> >   
> > > For now offending patches are being reverted, so downstream bug will help
> > > with tracking it and reverting it there.   
> > 
> > The patches will be reverted in Slackware as a matter of course when a
> > kernel.org "-stable" kernel with the fix is adopted.  Slackware does not
> > apply any patches to kernel.org kernels.  Nevertheless, I will raise a post
> > in the forum, hopefully later today.  
> 
> This has now been done:
> 
>   https://www.linuxquestions.org/questions/slackware-14/heads-up-pci-regression-introduced-in-or-around-5-15-129-commit-40613da52b13-4175731828/#post6470559
> 
> > > > The output of lspci is given at the end of this post[1].  The CPU is an
> > > > "Intel(R) Core(TM) i7-5930K CPU @ 3.50GHz" which is not overclocked.  Please
> > > > let me know if you'd like more information about the affected machine.  I
> > > > can also perform additional tests if required, although for various reasons
> > > > these can only be done on Thursdays at present.
> > > > 
> > > > The kernel configuration file can easily be supplied if that would be
> > > > useful.  
> > > 
> > > full dmesg log and used config might help down the road (preferably with current
> > > upstream kernel), as I will be looking into fixing related issues.
> > > 
> > > Perhaps a better way for taking this issue and collecting logs, will be
> > > opening a separate bug at https://bugzilla.kernel.org (pls CC me as well)  
> > 
> > Sure, will do.  I'll be able to get the dmesg log from my earlier tests and
> > config easily enough.  Testing with another kernel will have to wait until
> > next Thursday as that is when I'll next have physical access to the machine.  
> 
> A bug has been opened at bugzilla.kernel.org as requested.  The logs, kernel
> configuration and the "lspci -tv" output (requested in a subsequent email)
> have been added.  The logs and kernel configuration are from the kernel.org
> 5.15.139 kernel.  You have been added to the bug's CC.  The bug number is
> 218268:
> 
>   https://bugzilla.kernel.org/show_bug.cgi?id=218268
> 
> As mentioned, testing another kernel can only happen next Thursday.  If
> you would like other tests done let me know and I'll do them at the same
> time.  I have remote access to the machine, so it's possible to retrieve
> information from it at any time.

lets wait till you can get logs with dyndbg='...' (I've asked for earlier)
and one more test with "pci=realloc" on kernel CLI to see if that helps.

> Let me know if there's anything else I can do to assist.

It looks like  pci_assign_unassigned_bridge_resources() messed up BIOS configured
resources. And then didn't manage to reconfigure bridges correctly, which led to
unassigned BARs => thunderbolt/VGA issues.

Something in ACPI tables must be triggering acpiphp hotplug path during boot.
Can you dump DSDT + SSDT tables and attach them to BZ.
PS:
to dump tables you can use command from acpica-tools (not sure how it's called in Slackware) 
 acpidump -b
which will dump all tables in binary format (so attach those or 'iasl -d' de-compiled ones)

> 
> Regards
>   jonathan
> 


