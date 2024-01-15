Return-Path: <linux-kernel+bounces-26048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9E082DA74
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CAA31F21D80
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0991756A;
	Mon, 15 Jan 2024 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4EpZHYE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E157171BB;
	Mon, 15 Jan 2024 13:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849DBC43390;
	Mon, 15 Jan 2024 13:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705326324;
	bh=3CYq5m9c0Z2YmumV52JE15z62NoUEsxe7VfwOd+rpf0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=o4EpZHYE4CsLFI3cR+A1UgmZAYtPlvqTHIIyHAeZAUabjWiH3V8xJsWPLRxHWMdSJ
	 EXLMqJ9hafmfr6zBox8Jq47WwvGfGw/f7JomKbvknyiyo1UwhARhGO2I2H4P6kgfD5
	 yLvcLZtfgOsQns7AeGG8Dn5e3WleZ46JmMe/KE8Ky4oR1BSqDbcClbjVHMLuUBosPA
	 SRNcnABEIpx7j4/G1dxFLJ2/6bb2a07y1ABgv3lxJBtd1h4MKq5MN1riE3dE3jv0IG
	 1aTqcjau+tUrFAhGup4rIQutQnPL8nGdROkZSYTRRaO0/pMArFgyqZnY2fMFMv9iiK
	 mxBX6Q1ZbswKw==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <305898fb-6bd4-4749-806c-05ec51bbeb80@moroto.mountain>
References: <305898fb-6bd4-4749-806c-05ec51bbeb80@moroto.mountain>
Subject: Re: [PATCH 1/2] HID: hid-steam: remove pointless error message
Message-Id: <170532632324.1146873.6182162741847699008.b4-ty@kernel.org>
Date: Mon, 15 Jan 2024 14:45:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4

On Fri, 12 Jan 2024 17:34:14 +0300, Dan Carpenter wrote:
> This error message doesn't really add any information.  If modprobe
> fails then the user will already know what the error code is.  In the
> case of kmalloc() it's a style violation to print an error message for
> that because kmalloc has it's own better error messages built in.
> 
> 

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-6.8/upstream-fixes), thanks!

[1/2] HID: hid-steam: remove pointless error message
      https://git.kernel.org/hid/hid/c/a96681699611
[2/2] HID: hid-steam: Fix cleanup in probe()
      https://git.kernel.org/hid/hid/c/a9f1da09c69f

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>


