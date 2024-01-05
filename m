Return-Path: <linux-kernel+bounces-18403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE820825C95
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 23:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434B91F23F5B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 22:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1B2360A4;
	Fri,  5 Jan 2024 22:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AldvIK7K"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BF536096;
	Fri,  5 Jan 2024 22:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=yMeVG/Fp9FA+UiEjbyTIyLKYgRqI9k4EOU9gvb1YxA4=; b=AldvIK7K5GbQmdvRbtOOisjQUw
	aQO09FVDccUz/Q5GK6Y4e/j90g2LrQOXK5gb83o75t86u7I+zM6UlRquM7K2+j+9u/r5Khl4YrZWZ
	Ip+9OI0y6hYkAsOI1jSBZgz/yQ+sNIL252Y70/Vm2itgQxlRYIDFAPUTzt7vOlxCiUAVTAJrPyzyI
	nYYZYznMuYzIs5pHHygLVmcy78Cg8wsIqUc9ZZ9247oQ3/dcpRcjz6xTheiVqm40FcfFzztc095wC
	CPZOc6Fu6DJTRDoiCsCMAeun60jdDdgRh0f45Zv3esMwXCi9P2LGIUJ+r1liBGAenWZNwns2uwonS
	qmk4uDFQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rLt07-000NKY-0H;
	Fri, 05 Jan 2024 22:49:15 +0000
Message-ID: <107b6b5e-ca14-4b2b-ba2e-38ecd74c0ad3@infradead.org>
Date: Fri, 5 Jan 2024 14:49:14 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Irrelevant documentation recommending the use of
 "include/linux/kernel.h"
To: Yueh-Shun Li <shamrocklee@posteo.net>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <bc63acd7ef43bdd8d9609fa48dbf92f9@posteo.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <bc63acd7ef43bdd8d9609fa48dbf92f9@posteo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/17/23 15:46, Yueh-Shun Li wrote:
> Dear Maintainer,
> 
> The section "18) Don't re-invent the kernel macros" in
> "Linux kernel coding style" (Documentation/process/coding-style.rst)
> recommends re-using the macros defined in "include/linux/kernel.h"
> instead of the improvised ones locally.
> 
> However, There's a note in the comment block added by commit 40cbf09f060c
> ("kernel.h: include a note to discourage people from including it in headers")
> two years ago, saying that there's an in-progress splitting of kernel.h
> and inclusion in headers under include/ is discouraged.
> 
> Considering that the section was added 17 years ago by commit 58637ec90b7c
> ("Add a new section to CodingStyle, promoting include/linux/kernel.h"),
> the section about kernel.h in the "Linux kernel coding style" documentation seems outdated.
> 

Yes.

> Reproduction steps:
> 
> ```sh
> # cd to the kernel source tree
> cd path/to/source/linux
> # Show the git blame of the documentation section added in 2006
> git blame -L 1051,1071 Documentation/process/coding-style.rst
> # Show the comment note on top of include/linux/kernel.h added in 2022
> git blame -L 2,10 include/linux/kernel.h
> ```
> 
> Should we change
> 
> ```
> The header file include/linux/kernel.h
> ```
> 
> to something like
> 
> ```
> The header files under the include/linux/ directory
> ```

the necessary header files in the include/linux/ directory.


> 
> or a specific header that contains standalone helper macros?
> 

No. That would just end up as another catchall file that
gets too large (bloated) and contain many headers that are not
needed for some or many source files.

> It might be out of scope here,
> but such a header that collects standalone helping macros
> seems non-existent so far.

I think that we don't want another one.

> It would be great to have one that contains things like
> "STRINGIFY", "CONCATENATE" (or "PASTE"), "UNIQUE_ID"
> and other helper macros without external dependencies.
> There's one called "include/linux/util_macros.h", but it depends on "include/linux/math.h".
> 
> It's the first time for me to report an issue in LKML.
> Please kindly point out anything
> that I should fix or could improve.
> 
> Best regards,
> 
> Shamrock
> 

Thanks.
-- 
#Randy

