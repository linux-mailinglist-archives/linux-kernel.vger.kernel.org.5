Return-Path: <linux-kernel+bounces-35535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 473FF8392C4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01209293AEB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63E15FEF1;
	Tue, 23 Jan 2024 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="XXbo1DEE"
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02875FDB9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023987; cv=none; b=LSurszR221/bCgYHvgpaNsA6xQFAFep/e3BKJSj6oNU+b1XPIpWjwNF9yQjwSK2ZiZAjZ8nP9/SDpzNqoa9jYkrE4N/IkGz/Hb4po0w/3Pg6PkXbzhjEnzqjp7gDnilQmjWHvd3pFK9oLR3K1msxmMuq4syY6u8HL4AgeR4Qz04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023987; c=relaxed/simple;
	bh=zgqI9UR8YogjZoN9u8vWb4dHmJvB8ik8X67zHyKWp0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbXCgTJc3KkqCdbaeIQfNv6CHHnwMZy8uW2tF93JpMg3CSf3Zv8y0XNVrqVt65zaJ7J2Oxv0D/Aw3q0ZvhLlQxogg4oJJMiZTgCifMD608ftxt8ThK+NL4XJzfHWIqNLVkfkoeAwmLhKoq/0OufqUPWJ6YvYMRWG6li6jMjh12g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=XXbo1DEE; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TKB1N6n0DzMq5jw;
	Tue, 23 Jan 2024 16:32:56 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4TKB1M6BnkzrB;
	Tue, 23 Jan 2024 16:32:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1706023976;
	bh=zgqI9UR8YogjZoN9u8vWb4dHmJvB8ik8X67zHyKWp0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XXbo1DEEM3NL5OR6r67arzFI93BlDNA3jzA0bdkXrlPcz9PWoynqbZ9DRchI+s6Hg
	 sumZzKWpg5rsuUXtHAg+MW1vTX8Wek22Z+dFFd/K6v6792zx7BcdklDSFmE1Z7xIYb
	 udJuqxRWB40sTpRe3IUczKgQk87Ey5o7YLkGSRLM=
Date: Tue, 23 Jan 2024 16:32:52 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Huyadi <hu.yadi@h3c.com>
Cc: "jmorris@namei.org" <jmorris@namei.org>, 
	"serge@hallyn.com" <serge@hallyn.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>, "amir73il@gmail.com" <amir73il@gmail.com>, 
	"brauner@kernel.org" <brauner@kernel.org>, "avagin@google.com" <avagin@google.com>, 
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "514118380@qq.com" <514118380@qq.com>, 
	"konstantin.meskhidze@huawei.com" <konstantin.meskhidze@huawei.com>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH v4]
 selftests/landlock:Fix two build issues
Message-ID: <20240123.deeT9hegh4vo@digikod.net>
References: <20240115102409.19799-1-hu.yadi@h3c.com>
 <20240119.Ugaehae2ze5b@digikod.net>
 <adec399e50c74b30b59480d92c431241@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <adec399e50c74b30b59480d92c431241@h3c.com>
X-Infomaniak-Routing: alpha

On Tue, Jan 23, 2024 at 12:04:17PM +0000, Huyadi wrote:
> 
> >> Changes v3 -> v2:
> >>  - add helper of gettid instead of __NR_gettid
> >>  - add gcc/glibc version info in comments Changes v1 -> v2:
> >>  - fix whitespace error
> >>  - replace SYS_gettid with _NR_gettid
> >> 
> >>  tools/testing/selftests/landlock/fs_test.c  | 5 ++++-  
> >> tools/testing/selftests/landlock/net_test.c | 7 ++++++-
> >>  2 files changed, 10 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/tools/testing/selftests/landlock/fs_test.c 
> >> b/tools/testing/selftests/landlock/fs_test.c
> >> index 18e1f86a6234..a992cf7c0ad1 100644
> >> --- a/tools/testing/selftests/landlock/fs_test.c
> >> +++ b/tools/testing/selftests/landlock/fs_test.c
> >> @@ -4572,7 +4572,10 @@ FIXTURE_VARIANT(layout3_fs)
> >>  /* clang-format off */
> >>  FIXTURE_VARIANT_ADD(layout3_fs, tmpfs) {
> >>  	/* clang-format on */
> >> -	.mnt = mnt_tmp,
> >> +	.mnt = {
> >> +		.type = "tmpfs",
> >> +		.data = "size=4m,mode=700",
> >> +	},
> >
> >I requested some changes here.
> >
> 
> Could you give me some inspiration how to fix it? 
> it looks fine to me to assign value as above, which consistent with other pseudo FS tests.
> Thanks in advance.

Just add and use this for the two tmpfs data:
#define MNT_TMP_DATA "size=4m,mode=700"

You can also make the mnt_tmp variable static const.


> 
> >>  	.file_path = file1_s1d1,
> >>  };
> >> 
>   

