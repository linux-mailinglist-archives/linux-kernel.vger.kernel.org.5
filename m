Return-Path: <linux-kernel+bounces-124451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5266B891831
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA458B22089
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C976BB22;
	Fri, 29 Mar 2024 11:51:37 +0000 (UTC)
Received: from relay161.nicmail.ru (relay161.nicmail.ru [91.189.117.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180983D0A1;
	Fri, 29 Mar 2024 11:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711713096; cv=none; b=Q3A0h+YqJnmzrBgm/K+xuEtHAi8tjvfSps+8CdqmOprtnPkfqgJ+so4yvLhW+ett2QHFGcwBwDQTP68uJQY7l/4a90yah32owx3VSjjQ758ikO8Zclw3DnbPQwowLeSVAyoQ1vYydkh8n+IGdERntKBU0i96fbkAPQzyFFJal2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711713096; c=relaxed/simple;
	bh=2GnwskMTl6/LsiyyDEvmLkf6hrvzIaBKi8AW6Xhoh6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nSvzQakcf9ddalc0EI+tlC3Fa46NFhR/KBkD6LZa3N3NtiqJM5gArOX/2QOKWWYONdNGsFfdrCacBZU0HKIPkIC01pguuBj6+KZs4M6ARz5VMSR1SArkqXX87IQKbPylPbG8HZpQUqLsVJRZoyvCs1TYDr2XLSc/x1FbCON26jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.136.255] (port=60432 helo=[192.168.95.111])
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1rqAlU-0006nB-3b;
	Fri, 29 Mar 2024 14:51:20 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO [192.168.95.111])
	by incarp1105.mail.hosting.nic.ru (Exim 5.55)
	with id 1rqAlU-001fw8-00;
	Fri, 29 Mar 2024 14:51:20 +0300
Message-ID: <31ae4628-037a-4ccf-87d5-4cf00ae9c21e@ancud.ru>
Date: Fri, 29 Mar 2024 14:51:18 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] tg3: Remove residual error handling in
 tg3_suspend
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Chan <mchan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, Michael Chan <michael.chan@broadcom.com>
References: <CACKFLikPmtbkvVFerB0WNvLN3w=ia_vd6fUAo8iWpAqNsegMaQ@mail.gmail.com>
 <20240326183544.488242-1-kiryushin@ancud.ru>
 <20240328181020.1bc21a3c@kernel.org>
Content-Language: en-US
From: Nikita Kiryushin <kiryushin@ancud.ru>
In-Reply-To: <20240328181020.1bc21a3c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MS-Exchange-Organization-SCL: -1

Thank you for the feedback!

> Please stop adding these lines, they are unless.
> If you want to attribute the work to some project / employer
> add (SVACE) to your author lines.
>
Tool used signature line (the SVACE one) in that format was put in the
patch as required by lvc-project protocols. I guess, it is used for some
automation by the project, but I can agree, that the needs of some
specific project should not add cruft to the general code base/version control.

Thank you for expressing annoyance about it, I hope it will trigger conversation
about better way of adding the needed information for further iterations of the
project (as this thread is being mirrored to the project mailing list).
> How is deleting dead code a fix?
Originally, that was intended as a fix of a potential problematic case, that
tg3_power_down_prepare() could change in the future, returning a
non-zero status (which would make the removed code not dead, but undead).
But than, as patch evolved, it became a straight up dead code removal.
Probably, I should have removed the "fixes" line at that point, but
I think it still useful as a reference point to know, after which commit this patch
becomes relevant (to know, if it should be back-ported to some version or not,
for example).As I guess from the guide, patches "Fixes:" tag has some special treatment in the development cycle, but what would be more appropriate in that case?
> Hopefully you can find in there whether we suggest posting new versions
> in reply to the old ones..
Thank you for pointing this out! Missed the part about "The new version of
patches should be posted as a separate thread, not as a reply to the
previous posting. Change log should include a link to the previous posting"
while reading netdev guide.

Should I resubmit the patch in the separate thread now? If so, should I
make any changes to it (as discussed)? Would it bump the patch version
(the patch would essentially be the same, as only some metadata like
change log itself would change)?

