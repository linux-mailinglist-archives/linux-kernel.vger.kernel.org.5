Return-Path: <linux-kernel+bounces-65279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC98D854A84
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF4D21C2443A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9C254745;
	Wed, 14 Feb 2024 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="2Bwly8Af"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC507499;
	Wed, 14 Feb 2024 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707917455; cv=none; b=GH2NiP6jcLjNtbCIXNdlpbCDCMVnP9wTq7cPHeZ7dCrkLrSzQiI3GP6Owdd6t3KqMirzcfjsPy+rCB8BoPISj1c1TZr+P+fMYOd3fDrJmVEbsJLeyD/rlk9JbRXmT51qVMEyJf7lRtUslb5LvhOkVJHA3Sy9UzoKppPCnhObMMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707917455; c=relaxed/simple;
	bh=K455WI33R+3XbLzWm+QlI6MIT3mn7lkjaRiD7AzxaF4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Jp5t/J7MyHLcRQcE3EGy0wFB3CWPycJcpuq/SxmAg5q69HuWUakF0ZWBLOqBhPj3fl1OfUSOfJ1Uz0CoeSarxro3Z80x/IKvkk6vHxfKBS257w4uEHvlMPoQJLcPicu7CJF85llE/S09B5Ij1p9ojQVg+fn7Y9LH93EULEPiPYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=2Bwly8Af; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C54C433C7;
	Wed, 14 Feb 2024 13:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1707917454;
	bh=K455WI33R+3XbLzWm+QlI6MIT3mn7lkjaRiD7AzxaF4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2Bwly8Af5Am8RU4eqwKTcNBh/zkJGqw0bhqJFxF+8xgUQluNVkggAMsxJJ5ouGMEO
	 kXKZ+BjwS9u8mSUR7Rf6dh4/azAGZV+s4ui/KQ7bo4KQBAStM4vZX/yChJh3LNZJ9D
	 2TGhKOdESaP2te+w/zP0foEfTP1WovcfGQuhLhQI=
Date: Wed, 14 Feb 2024 05:30:53 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: Jonathan Corbet <corbet@lwn.net>, David Kaplan <david.kaplan@amd.com>,
 Larry Dewey <larry.dewey@amd.com>, Elena Reshetova
 <elena.reshetova@intel.com>, Carlos Bilbao <carlos.bilbao@amd.com>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Petr Mladek <pmladek@suse.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Eric DeVolder <eric.devolder@oracle.com>, Marc
 =?ISO-8859-1?Q?Aur=E8le?= La France <tsi@tuyoix.net>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Nhat Pham <nphamcs@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Christian Brauner (Microsoft)"
 <brauner@kernel.org>, Douglas Anderson <dianders@chromium.org>, Luis
 Chamberlain <mcgrof@kernel.org>, Guenter Roeck <groeck@chromium.org>, Mike
 Christie <michael.christie@oracle.com>, Kent Overstreet
 <kent.overstreet@linux.dev>, Maninder Singh <maninder1.s@samsung.com>,
 linux-doc@vger.kernel.org (open list:DOCUMENTATION),
 linux-kernel@vger.kernel.org (open list), Roberto Sassu
 <roberto.sassu@huaweicloud.com>, petr@tesarici.cz, Petr Tesarik
 <petr.tesarik1@huawei-partners.com>
Subject: Re: [PATCH v1 5/5] sbm: SandBox Mode documentation
Message-Id: <20240214053053.982b48d993ae99dad1d59020@linux-foundation.org>
In-Reply-To: <20240214113035.2117-6-petrtesarik@huaweicloud.com>
References: <20240214113035.2117-1-petrtesarik@huaweicloud.com>
	<20240214113035.2117-6-petrtesarik@huaweicloud.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 12:30:35 +0100 Petr Tesarik <petrtesarik@huaweicloud.com> wrote:

> +Although data structures are not serialized and deserialized between kernel
> +mode and sandbox mode, all directly and indirectly referenced data structures
> +must be explicitly mapped into the sandbox, which requires some manual effort.

Maybe I'm missing something here, but...

The requirement that the sandboxed function only ever touch two linear
blocks of memory (yes?) seems a tremendous limitation.  I mean, how can
the sandboxed function call kmalloc()?  How can it call any useful
kernel functions?  They'll all touch memory which lies outside the
sandbox areas?

Perhaps a simple but real-world example would help clarify.

