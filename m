Return-Path: <linux-kernel+bounces-17978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4762482563D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 726B5B21445
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACD12E631;
	Fri,  5 Jan 2024 14:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="F8viWQdi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD68A2E629;
	Fri,  5 Jan 2024 14:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7CB236E3;
	Fri,  5 Jan 2024 14:59:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7CB236E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1704466750; bh=1j4bz6n9CeSP+F0OFArAPfzbQCq5MY6AljorywbatRc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=F8viWQdiDnu9txe73u6GQvPT0kFehfhm9nyB6sIirKahYhPfvCkvMBpmffH4r+35k
	 Rb4v8UlAmEyhzAPPHb8ocKZvWNcHANGI5bZDO2VS74EUdZBZGDCZvRZ8KplEP8krCE
	 10ovdwxT2urfyWA5zoDhUWw4dm2VueKbNQPbMcQFbgQsPo4MXWN+Hy2oTl+5aJtBhN
	 aHJYb4bboXlBa6C3FEYgDw5AMuCF7mwr3b0NVdSYg+4GcMNxsITGXiFrZ/Kf0uTzJ8
	 kJ/jcC2DOb72mlcyn0q6/cOEP41K4gz1xjylQ0T9wCqLqrN6YwojMKwfOn8MW67Ksy
	 WnDAY40+xqNLg==
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: Adding warning icon to warning admonitions?
In-Reply-To: <ZZgSGFhvT3SOI4fe@archie.me>
References: <ZZgSGFhvT3SOI4fe@archie.me>
Date: Fri, 05 Jan 2024 07:59:09 -0700
Message-ID: <87edev3jya.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> For the icon itself, the approach is to use Font Awesome [2] (many other doc
> sites that uses Sphinx also do that due to site theme they use but Alabaster
> theme don't use the icon, hence this question). I personally prefer regular
> icon variant (like in TT), but alas it is in non-free PRO plan (and only
> solid variant is free and that is what Sphinx themes using).
>
> Does adding warning icon like above idea make sense for the kernel docs? And
> does it require non-trivial (complex) changes to Alabaster theme?

It can probably be done with a bit of CSS tweaking.  I don't really like
the idea of requiring the installation of another font to build the
docs, though, and Font Awesome looks like it could bring in licensing
issues of its own - that's not clear from the site at all.

jon

