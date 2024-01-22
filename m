Return-Path: <linux-kernel+bounces-33880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EEF83705E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F265B20A27
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE9A50A76;
	Mon, 22 Jan 2024 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="G6R6J2Tr"
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1B550272;
	Mon, 22 Jan 2024 17:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946275; cv=none; b=kwSgKP2oSktTUorTPAg/G6SQYrX0Jrss1tENzC8cXRa6kH0Clwj5iK02CyXPO9T9Xxm15OYcJExMcCxjVA8oD32rscGE6ZfUY+J9PDbsbS81GnLxENwk2SNM41sGXIeKWU1f30GBx91a6ejs7htNaeLVXWydOmWIvhVMOqd6GOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946275; c=relaxed/simple;
	bh=ormRf2c7k0RSk48YWM459e3k1OgtsTd6YXCAGOapFlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JNtiAjG8g4rVnKpZwpOT3t69anxoK4YXC+iWcEZlrb4NLsZl85G4qAUqG6I4ozR8kXgyZQh6AA+CfYmp27RsnnEfNNmbciH2BVTNvK8oz19r58rSVLTmLHGa/y9ZdTBD7yEkkjoo4dZh749zaCHqjQxWIneSZsvCQsqmxXSUNp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=G6R6J2Tr; arc=none smtp.client-ip=80.12.242.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id RyYJrZyS0CqsFRyYJr2t2P; Mon, 22 Jan 2024 18:57:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1705946265;
	bh=CHlsOFd028+jV0LAUMT3aaajLuOQehNM5ywoohsK5ko=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=G6R6J2Tr0yjFFdDfUw8j4W+vMDSPHcYn7lhH9AsHvWwOS3b2fKv5hQSEnK+v1vEX1
	 X340Jilt9mvYEM6pn2jHnHMMwco0kxed5Za++jbP/7XuRkzzgBDoetvw4ac7m7CbuJ
	 v0XwmEa1DdqoP2K+4bf/vaahw7MJJhsMBCKcwXePV7MjqzwRRwAFpNTfMYivbHQc3c
	 ZW0GAOGyMjn+JKmuzWZpGTpq4ODnItBSjzS3P2k1QvWckVZsQ+PCl6W3bViR54tViM
	 hF3rLxCHF4Rv41RJnFyCdLaLrmgroDZjbKRkqg4G82K1FrSut3/drmRYD280/lL6vz
	 a+zdJyvdOZX8A==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 22 Jan 2024 18:57:45 +0100
X-ME-IP: 92.140.202.140
Message-ID: <d11852b1-6d9c-4ced-83cb-96e753edd45d@wanadoo.fr>
Date: Mon, 22 Jan 2024 18:57:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thunderbolt: Remove usage of the deprecated
 ida_simple_xx() API
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andreas Noever <andreas.noever@gmail.com>,
 Michael Jamet <michael.jamet@intel.com>,
 Yehezkel Bernat <YehezkelShB@gmail.com>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-usb@vger.kernel.org
References: <7fce4c8c4345d283dbfadd3cea60fdc49f9ca087.1705007397.git.christophe.jaillet@wanadoo.fr>
 <20240122112922.GH2543524@black.fi.intel.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240122112922.GH2543524@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 22/01/2024 à 12:29, Mika Westerberg a écrit :
> On Thu, Jan 11, 2024 at 10:10:21PM +0100, Christophe JAILLET wrote:
>> ida_alloc() and ida_free() should be preferred to the deprecated
>> ida_simple_get() and ida_simple_remove().
>>
>> Note that the upper limit of ida_simple_get() is exclusive, but the one of
>> ida_alloc_range()/ida_alloc_max() is inclusive. So a -1 has been added
>> when needed.
> 
> Looks tood to me but wanted to check if you tested this on a real
> hardware or you just build tested?
> 
> 

Hi,

It was compile tested only.

Transformation has been done with the help of the cocci script below.

CJ


===

@@
expression i, gfp;
@@
-    ida_simple_get(i, 0, 0, gfp)
+    ida_alloc(i, gfp)


@@
expression e1, e2, gfp;
@@
-    ida_simple_get(e1, e2, 0, gfp)
+    ida_alloc_min(e1, e2, gfp)


@@
expression e1, e2, gfp;
@@
-    ida_simple_get(e1, 0, e2, gfp)
+    ida_alloc_max(e1, e2 - 1, gfp)


@@
expression e1, e2, gfp;
@@
-    ida_simple_get(e1, e2, e2+1, gfp)
+    ida_alloc_range(e1, e2, e2, gfp)


@@
expression e1, e2, e3, gfp;
@@
-    ida_simple_get(e1, e2, e3, gfp)
+    ida_alloc_range(e1, e2, e3 - 1, gfp)


@@
expression e1, e2;
@@
-    ida_simple_remove(e1, e2)
+    ida_free(e1, e2)



