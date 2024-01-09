Return-Path: <linux-kernel+bounces-20889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBD18286FB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72ECA1C243A3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B294739842;
	Tue,  9 Jan 2024 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kYdI5mgg"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7500D38FB7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 13:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e52ebd643so1653425e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 05:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704806532; x=1705411332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BqpeTcL0k5oGVabBc1U+iO/jvu/aOAZcR1mMG7pClgQ=;
        b=kYdI5mggI88RkRb9f/wl6szMNqm0wunJ5LMB8h4Sl8lW15JKfoUGb8pKETWJdoCNGY
         w5Q7dRRCY7e8SRB8Hqetul/AFFbAzE2R/L9SPNWM4R01Tz7zSfNkrJd5RcKdJoJN/Y7G
         AMG1aax8Z6hUyF7W//2uXaPE21rC+auJUwhdEDIjVxMrB6UbsRhgvkrQVPtHQRwI9icl
         El8GqknFuM1EKCF6tS3j8OKu6dCLf4E+zauEBrRu6IvnaZY5Ms+ZqIgKwx2LPsRASg1x
         /vJyHE8hx3NgKiN8Bdd7p092VauekiTBLbx+CXzTtyzKmN+fwo0mV278Wir5ZgYFZbZ0
         bkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704806532; x=1705411332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqpeTcL0k5oGVabBc1U+iO/jvu/aOAZcR1mMG7pClgQ=;
        b=f44enp1bCWUNwIvZ7unUvoj1eBKT4o4hIMiDlMaJmC0Xe3/MMj8TGa061c9SxGEGgu
         KtIpblSj82fMWnBEF+83N0L5oziNWF2hj/rHjhZ5UYkA8y9OMdSlGAyQ9kDLyfdfxC1P
         65G6bSb/JPd5diKxqNmQ6l3hxzGdJlJYLfqBdUnMZkoidN6aN7vSY7PhU/TMo3dElpLL
         Fgbhvu2r0sk2P/LCSLYn57w14vSS5lrM43ohDCa4NBYD8m2L69nhJOg3++8Sq2zPvIg3
         8E6gMANEZQdCkQe7/1ZzlTqCBlyIPSROm1OQtujsugvL3cmjiTPLcgLnQcB8S57mKdkE
         avnw==
X-Gm-Message-State: AOJu0Yy4DAMWpo7tgwLL+wgUQWE66CdP5F99QdLJtBHkErHU2sn/NbZx
	yVCdsJb0epdABy+RJvy/J/BT/d3F6C/1xw==
X-Google-Smtp-Source: AGHT+IGHU5onWBzSXDDK6xzwiAJ6Do7Z1PdUmbySUVdyTMwb8DuI8Pj6wTTd28JDR/tvi7JlWFWMSw==
X-Received: by 2002:a05:600c:458b:b0:40e:4f7a:bc29 with SMTP id r11-20020a05600c458b00b0040e4f7abc29mr481967wmo.159.1704806531714;
        Tue, 09 Jan 2024 05:22:11 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id d14-20020adfef8e000000b003373fe3d345sm2393561wro.65.2024.01.09.05.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 05:22:11 -0800 (PST)
Date: Tue, 9 Jan 2024 16:22:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Kees Cook <keescook@chromium.org>,
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
Message-ID: <36aecc9a-ac30-436f-b42b-39f63513d743@moroto.mountain>
References: <20240105164001.2129796-1-harshit.m.mogalapalli@oracle.com>
 <20240105164001.2129796-2-harshit.m.mogalapalli@oracle.com>
 <202401081430.9DAB37B46@keescook>
 <9c742547-0021-464b-b7a8-7af46b0a4afa@embeddedor.com>
 <79ca2f85-1f8d-4a12-aa5a-09137033605f@moroto.mountain>
 <7d7b94ba-9a1f-44de-8491-dc4864338f80@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d7b94ba-9a1f-44de-8491-dc4864338f80@embeddedor.com>

On Tue, Jan 09, 2024 at 06:31:41AM -0600, Gustavo A. R. Silva wrote:
> 
> You're arguing that fortify caused a problem.

Yes.

Before: Code working correctly
After: Kernel Panic

At first, I started to question if I was going mad, but then I looked
through the email thread and Harshit tested it and proved that the
kernel does actually panic depending on the .config.

I mean realistically we should backport this patch to old kernels,
right?  And if we had to assign a Fixes tag to this it would need to be
the commit which adds Fortify to the kernel.  Prior to that commit the
code was fine.

Again, I'm not saying that Fortify is bad overall.  Probably in DnD it
would be Chaotic Good where it's overall good but sometimes a pain.

regards,
dan carpenter


