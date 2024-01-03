Return-Path: <linux-kernel+bounces-15300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E57C38229E4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 894CAB22C95
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6952B182B3;
	Wed,  3 Jan 2024 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWZ26c7u"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8D418C05
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 09:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704272650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kimaz79paVloj/e6SryFhzLQ5bfwrfwnGX6HNnH18gM=;
	b=CWZ26c7u78ulUNnZy21j+Iyoz+/VXcq0X5lT0Ap2JE+gWUtS/F4nPO7Ek5KkHa4hIeBXZh
	sHYXRMKbyq/IgauXfHMJTy+FRhwjHBDtpoMf1FOFsx1oFslCUmQp8ZTgiopGEw7UYeChtY
	0FPbhPnyA1/9bp3ClWyjmRqoXyGeozU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-clzl96yvOnaK54Pu-1wRLg-1; Wed, 03 Jan 2024 04:04:09 -0500
X-MC-Unique: clzl96yvOnaK54Pu-1wRLg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5561bf805daso1083194a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 01:04:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704272648; x=1704877448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kimaz79paVloj/e6SryFhzLQ5bfwrfwnGX6HNnH18gM=;
        b=Sljj/RGIgq3psoS7A1s/Z9xmnoYFeuhBV6Y52SoxF0zrQY9JHIhl0VwMfB/OhrYrc2
         9KJshHr14DpJCR2/D5YWhB0oDnBwq9mVLmHKe4Gq55pvPlDsk+XvjbcFmRBaZbZ/Rcl1
         MtWZv9j8UZm85yZRs3wk5eE2cXyTmuNBDsWd4tGecd7HO/HqCEoG1liT2z2mkvsUyHZF
         1DKHMopFH27Ly4PbcLARvy0UPNpqSt2yEQHNty/+XG7dSz0eWgJt3Plo+fDO/9eJ6fNz
         BqaDJDpjAPBEJ4bGIXDdDQcO6+3X0DyZFeyxXK0DByvHm0Ws+7xghcCbUnwyOW5eWKxU
         SJ+A==
X-Gm-Message-State: AOJu0YzpPt37t8L9C8z6BwXOjycZfkJ2ijJSnJdlcuYzhu9VlM21HfS+
	eH6R4N1wX7gTVYi70KNHvAJs41HFNq0Aai1m+NiNr1VwZ6QcGktHUlIShpWbiP8Y6684a8TAuy3
	prF0pkIbZ0gOV4MwbAhVGlLbLQvayy6R/
X-Received: by 2002:a50:cd56:0:b0:553:7f36:b90c with SMTP id d22-20020a50cd56000000b005537f36b90cmr11355403edj.1.1704272648350;
        Wed, 03 Jan 2024 01:04:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnzXW1T/PtiyMEePFAeIfjoDdcIOAwrLU81pstOcxV+Ri0wVlPHV3elGdnjF9boBnTgsZDvA==
X-Received: by 2002:a50:cd56:0:b0:553:7f36:b90c with SMTP id d22-20020a50cd56000000b005537f36b90cmr11355396edj.1.1704272648000;
        Wed, 03 Jan 2024 01:04:08 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com ([185.140.112.229])
        by smtp.gmail.com with ESMTPSA id ck15-20020a0564021c0f00b00555f908b2e4sm5623610edb.40.2024.01.03.01.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 01:04:07 -0800 (PST)
Date: Wed, 3 Jan 2024 10:04:06 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Woithe <jwoithe@just42.net>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [Regression] Commit 40613da52b13 ("PCI: acpiphp: Reassign
 resources on bridge if necessary")
Message-ID: <20240103100406.0c5ff818@imammedo.users.ipa.redhat.com>
In-Reply-To: <ZYPYIpO36YE8V8hQ@marvin.atrad.com.au>
References: <ZXpaNCLiDM+Kv38H@marvin.atrad.com.au>
	<20231214143205.4ba0e11a@imammedo.users.ipa.redhat.com>
	<ZXt+BxvmG6ru63qJ@marvin.atrad.com.au>
	<ZXw4Ly/csFgl76Lj@marvin.atrad.com.au>
	<20231215143638.032028eb@imammedo.users.ipa.redhat.com>
	<ZXziuPCKNBLhbssO@marvin.atrad.com.au>
	<ZYPYIpO36YE8V8hQ@marvin.atrad.com.au>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 16:46:02 +1030
Jonathan Woithe <jwoithe@just42.net> wrote:

> On Sat, Dec 16, 2023 at 10:05:22AM +1030, Jonathan Woithe wrote:
> > On Fri, Dec 15, 2023 at 02:36:38PM +0100, Igor Mammedov wrote:  
> > > On Fri, 15 Dec 2023 21:57:43 +1030
> > > Jonathan Woithe <jwoithe@just42.net> wrote:  
> > > > As mentioned, testing another kernel can only happen next Thursday.  If
> > > > you would like other tests done let me know and I'll do them at the same
> > > > time.  I have remote access to the machine, so it's possible to retrieve
> > > > information from it at any time.  
> > > 
> > > lets wait till you can get logs with dyndbg='...' (I've asked for earlier)
> > > and one more test with "pci=realloc" on kernel CLI to see if that helps.  
> > 
> > Okay.  
> 
> I added the "dyndbg=" option to the 5.15.139 kernel command line and booted. 
> The resulting dmesg output has been attached to bugzilla 218268.
> 
> I also tested 5.15.139 with the "pci=realloc" kernel parameter.  This was
> sufficient to allow the system to boot without a GPU initialisation failure.
> The dmesg output from this boot has also been attached to bugzilla 218268.
> 
> I used kernel.org's 5.15.139 for these tests because I already had it
> compiled and was a little short of time.  If you'd like me to repeat the
> tests with a different kernel let me know which one and I'll see what I can
> do.  The Christmas break may delay this somewhat.

Thanks for collecting tables and debug logs,
I'll get back to you if more debug info or testing would be needed.

> Regards
>   jonathan
> 


