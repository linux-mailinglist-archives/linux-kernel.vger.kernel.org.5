Return-Path: <linux-kernel+bounces-11123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B60381E1A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 18:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45A6F1C21108
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 17:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DC051C3A;
	Mon, 25 Dec 2023 17:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1adtD7f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6C838DD8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703523742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TZZm8uBDiMjjsh2k0v+Ijtz0bQpTltXijl66KHAtGuw=;
	b=D1adtD7fAoJ5Yb5T4/sGUzauw4JhASbTU1KKB/ZUXUdQczt8+/c20+wgDwA0/o0KbhkZm9
	jIpP/ne2ItISIPaluzm4J7SZOoGDUjIKfbTi1P+I/lLhrPgnSdh94vQcMOnVYqpRSKZ7Px
	dKpB//E1AsqNVIZQ1XmDlnoHR2SXnts=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-xQ192CZRO2qyf00h7XPP4A-1; Mon, 25 Dec 2023 12:02:21 -0500
X-MC-Unique: xQ192CZRO2qyf00h7XPP4A-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40d39bbe215so34821665e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 09:02:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703523740; x=1704128540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZZm8uBDiMjjsh2k0v+Ijtz0bQpTltXijl66KHAtGuw=;
        b=cvF4tUt1oDBU+B5VXKbMmmpV/+HDOVwhG4JKFFrpZmXT9NlayfdmjNvw02B71xSb2j
         kLeMvWG/4VFjlQ5KQfGVq+qSWnQbLg5t59/zrW17VkE35/bXXC5qT6TrfAWzvTRHPYSi
         jYZDNoQtcjdO9DQdPhYwjt27SyCl4Id/XqehMyjDFqOtQG8ugFg6IW5g6M6YnsZUoAyr
         Ct6O5fJMsvbW3LI2NaHCEgAiC0pwvsIzCCAe9gbjptYTxXylUOb3+tfI+AidWbug0+O0
         jU/zXsQ4XNgxCPv52U5P06VbVkqlHc8xUfAT6jaPXEkk9cH32IklUc/Ia5nojCs6Z+cD
         72rw==
X-Gm-Message-State: AOJu0YxOmZPRpl2ggA0KpWjP1p/LO7uaLGUKnbf6SaB/XIzkXYx0OcOJ
	YZMdDV69z99/Z4nHPLpNZPAHQ3SFqTJxr+BJIZ3GnkSdXqkJsDCRxXXFm5cKke2uLFpuU3M/EEr
	gge7jhcxquF2JaY8+EKuyLYpI7JuDweCJ
X-Received: by 2002:a05:600c:354c:b0:40d:3aff:e067 with SMTP id i12-20020a05600c354c00b0040d3affe067mr3630424wmq.20.1703523740277;
        Mon, 25 Dec 2023 09:02:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFI7/aHwtUm1PRRr4I1Ip9nypv342ACCr/ubj0f4dRys2i9jMSSS3I0aQfMD0TtZ7OlYEvzzg==
X-Received: by 2002:a05:600c:354c:b0:40d:3aff:e067 with SMTP id i12-20020a05600c354c00b0040d3affe067mr3630410wmq.20.1703523739857;
        Mon, 25 Dec 2023 09:02:19 -0800 (PST)
Received: from redhat.com ([2a06:c701:73ef:4100:2cf6:9475:f85:181e])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c4f8900b0040d56075463sm4512840wmq.44.2023.12.25.09.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 09:02:19 -0800 (PST)
Date: Mon, 25 Dec 2023 12:02:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Olivia Mackall <olivia@selenic.com>,
	Petre Eftime <petre.eftime@gmail.com>,
	Erdem Meydanlli <meydanli@amazon.nl>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v7] misc: Add Nitro Secure Module driver
Message-ID: <20231225115827-mutt-send-email-mst@kernel.org>
References: <20231011213522.51781-1-graf@amazon.com>
 <20231225090044-mutt-send-email-mst@kernel.org>
 <363ca575-f01a-4d09-ae9d-b6249b3aedb3@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <363ca575-f01a-4d09-ae9d-b6249b3aedb3@amazon.com>

On Mon, Dec 25, 2023 at 05:07:29PM +0100, Alexander Graf wrote:
> Hey Michael,
> 
> On 25.12.23 15:06, Michael S. Tsirkin wrote:
> > On Wed, Oct 11, 2023 at 09:35:22PM +0000, Alexander Graf wrote:
> > > When running Linux inside a Nitro Enclave, the hypervisor provides a
> > > special virtio device called "Nitro Security Module" (NSM). This device
> > > has 3 main functions:
> > > 
> > >    1) Provide attestation reports
> > >    2) Modify PCR state
> > >    3) Provide entropy
> > > 
> > > This patch adds a driver for NSM that exposes a /dev/nsm device node which
> > > user space can issue an ioctl on this device with raw NSM CBOR formatted
> > > commands to request attestation documents, influence PCR states, read
> > > entropy and enumerate status of the device. In addition, the driver
> > > implements a hwrng backend.
> > > 
> > > Originally-by: Petre Eftime <petre.eftime@gmail.com>
> > > Signed-off-by: Alexander Graf <graf@amazon.com>
> > Alex are you going to publish the spec patch for this device?  Important
> > so we don't need to guess at behaviour when e.g.  making changes to
> > virtio APIs.  Also, which tree do you want this to go through?
> 
> 
> The spec patch including ping mail are sitting on the virtio-comments
> mailing list since October. I haven't seen any reply unfortunately :(
> 
> https://lore.kernel.org/virtio-comment/20231025235345.17788-1-graf@amazon.com/
> 
> Happy to read feedback if you have any :).

Oh I forgot.
Now that I've read the driver, I actually have some :)
I think there's an assumption that there's a request buffer
and response buffer queued by the driver, and that
the device always first consumes the request buffer
followed by consuming the response buffer.
If that is right then driver is ok but spec needs
clarification, will note on virtio-comment.


> This patch here is already applied in Greg's misc tree which I'm happy to
> have it trickle to Linus through.
> 
> 
> Alex
> 
> 
> 
> 
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
> 
> 


