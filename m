Return-Path: <linux-kernel+bounces-23133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F6782A817
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11131C233A4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6ADD267;
	Thu, 11 Jan 2024 07:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r0e41A1v"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AD9CA6F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 07:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40b5155e154so64267045e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 23:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704957344; x=1705562144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UX20rbF7hlnyWLHyXsogEXaIvZyHEjXlNvsR8Qs9blw=;
        b=r0e41A1vUzhV8KYDP89y4Z08jMC7CEQQfR4ANirMUE83erDaIRq7WCKXYEK55Knx1G
         WI8gHtgn9qGk7ZO91zsBAQYYZEiVki+liCxRmN6NbwKmO3K+eLc7YyzG/+zOJZUMhLzL
         Hsl1SZ81BbGW/lh1ebS8Bi+BjY5w5isG7fyPnWTMG5kcmGkYAUwJ20EdOqWTTBNrSwcR
         R6KIQHUUt1NEwRWfPDZxIt6P1WX+Slu5pPTlAeYaNsjiRlnfGBaXS/zdm10AkDQmtTzI
         QC90PSoas1QVIS1LnBleqc7AHJBPhs012ATidlDsxaR1JqbD0qmskbvwYIuy+uBcB0tQ
         Jrdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704957344; x=1705562144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UX20rbF7hlnyWLHyXsogEXaIvZyHEjXlNvsR8Qs9blw=;
        b=Ox9s2s4LxIhus/awTEyFMe378K5Ibyc/TBAChdsGRzHndFrb1JGoO+38e3l++XDP+f
         goCLhpXoaW0aTQopSVygIFke6+5/sMeMYIgx9PFNNb0TDcbkXHSo+Gj4XkeyKJNieKnt
         U5BODtJACobmHN+kDNR0EeL4Cy6HWf64ypoPc+yZbJMVh521S9rdi8PbUl4BLkKGuvKL
         YKtTkHRDCths4U5ajaai5fH9FXQtjaKj/L3w0vKkj4+U5Be73wrRJF9iFJYk5+u1yhCY
         E/r+BVphGh4j66C/4ry8tnrTMTkh4TrC6Fd0gvnRqvMqB64sKtV4fGMEp0qkR2GThes9
         qLGg==
X-Gm-Message-State: AOJu0YyALKnXEPraYmC+Pia7TexIemRQ8E0gqZaLXgbOjKGWLOPlo/WM
	Jxr05K/K2CfNkXxEQFyVKzokhsYutrj6Wg==
X-Google-Smtp-Source: AGHT+IE3ZG9N0YdyCOamkgAPvxJPh1uuI47g4YgkEb/vAmbAgIDLHmccrGJ7hdBP693w0AFm/dM0eQ==
X-Received: by 2002:a05:600c:428c:b0:40e:52c3:47f9 with SMTP id v12-20020a05600c428c00b0040e52c347f9mr122255wmc.67.1704957344497;
        Wed, 10 Jan 2024 23:15:44 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id t5-20020a05600c450500b0040d6d755c90sm741939wmo.42.2024.01.10.23.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 23:15:44 -0800 (PST)
Date: Thu, 11 Jan 2024 10:15:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kees Cook <keescook@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	linux-hardening@vger.kernel.org, error27@gmail.com,
	gustavoars@kernel.org, Bryan Tan <bryantan@vmware.com>,
	Vishnu Dasa <vdasa@vmware.com>,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, vegard.nossum@oracle.com,
	darren.kenny@oracle.com, syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH v2 2/2] VMCI: Fix memcpy() run-time warning in
 dg_dispatch_as_host()
Message-ID: <8e527ade-fe49-4697-8e36-589775c63354@moroto.mountain>
References: <20240105164001.2129796-1-harshit.m.mogalapalli@oracle.com>
 <20240105164001.2129796-2-harshit.m.mogalapalli@oracle.com>
 <202401081430.9DAB37B46@keescook>
 <9c742547-0021-464b-b7a8-7af46b0a4afa@embeddedor.com>
 <202401101601.30ED61A1A3@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202401101601.30ED61A1A3@keescook>

On Wed, Jan 10, 2024 at 04:03:28PM -0800, Kees Cook wrote:
> 
> Oops, yes, thanks for fixing my confusion. Right, this is a direct write
> across members into the flex array, not a composite destination. Yay
> all the corner cases. :P

Is there a document somewhere which explains what will trigger a runtime
warning?  For example, if you write across members but it's not into a
flex array does that cause an issue?  Or if you read across members?

For example, this line reads from bulletin->vlan and
bulletin->vlan_padding.  This causes a compiler warning in Clang and
GCC depending on the options but does it also trigger a runtime warning?
https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c#L2655

(I wrote a patch for this a few months back but didn't send it because
of the merge window.  I forgot about it until now that we're in a merge
window again...  :P)

regards,
dan carpenter

