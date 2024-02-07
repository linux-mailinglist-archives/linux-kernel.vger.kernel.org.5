Return-Path: <linux-kernel+bounces-57048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFF284D34A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939FA1F23DBD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129ED126F15;
	Wed,  7 Feb 2024 20:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="104iJj7N"
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494008593E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 20:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707339317; cv=none; b=Ui87RR41fpmxraN1cSNqKnHX0rPCBMwflfiG/Sq77pJJncHQCGmkFVS97eZAI0JJza1Z/K/R08AX8Zceur8lv9lEpGGz+FeszCPab69wd00Q82Hu9ESbBEtEp1OWZhQ94ry6GXjk0Ft2tmO9edoF9fSo24MllM7w5EifJIQu19M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707339317; c=relaxed/simple;
	bh=0eve9TSICHlgGWraOmtO+lqctetBC9VEkOfBIvtM2+w=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lR8Y6+K2qCMWRue7oMV4t+jLw3CV5M9duq7QM2ktF9PhMTXofGFVGYn8eULJsM7/P3cBg+X1pDw4Blp2N7DPO9Ykfrztje/n6zR5NOCarorFY5NH0sQZG5rw9Mq+9kSsRLD18HcSaTgWq+tg91HoJR97zgNVF8qD0oTyVgSGvAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=104iJj7N; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:To:From:Date:CC;
	bh=0eve9TSICHlgGWraOmtO+lqctetBC9VEkOfBIvtM2+w=; b=104iJj7NyFHC09OKYx7sqURpGn
	LoAqNeSHp6PT1d7ICxQkKqgtjjbew25Lbk3+Fwwhouej7+jtN9Tw94BFpJXMGGbPhZnPD4+LOdEts
	0jxM+qkYiJrKOh8Yu08xn4GNffUjccjRTncdjY4iCu5dq1wLLcDoV5djIVMmkqmXIDfyNPqPvDS4Z
	+snKttQnRYfPazWWE9TndLaee4kF9ZdgJttm50Ys36fL74zyEpseC05kk2gvA4iCAEMpWxrbUEHfD
	qi76KTNHtamhZv2MhtYMjzlYMKNmPyX6nFahCWFCPfZt6+6t5Hbn77NnyfPGzWcczY/Mo2Q9ke3jn
	w5Y9A/pZ+TasKLn8ZPaJp88sdCFFTzRESmLnRhiCGqwNbanpPm5LSRT5agAGgfSgC7LOPGaoqSYIc
	oWrfX7sOCzoMxkdYPFfBrxzjlZe7YQQF1ioShzIcMWhyWuZAED4SJ0GSid9/kdY4WAxslROPW8RWT
	g7R4wb4vhUwHGDmf0mPMNWlL;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1rXoiR-00C0sD-1i;
	Wed, 07 Feb 2024 20:40:20 +0000
Date: Wed, 7 Feb 2024 12:40:15 -0800
From: Jeremy Allison <jra@samba.org>
To: jallison@ciq.com, jra@samba.org, rafael@kernel.org,
	tansuresh@google.com, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, djeffery@redhat.com, hch@lst.de,
	gregkh@linuxfoundation.org
Subject: Re: [RFC PATCH 0/6] async device shutdown support
Message-ID: <ZcPqr+9hqH1UXdwr@jeremy-HP-Z840-Workstation>
Reply-To: Jeremy Allison <jra@samba.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

> This is another attempt to implement an acceptable implementation of async
> device shutdown, inspired by a previous attempt by Tanjore Suresh. For
> systems with many disks, async shutdown can greatly reduce shutdown times
> from having slow operations run in parallel. The older patches were rejected,
> with this new implementation attempting to fix my understanding of the flaws
> in the older patches

Hi David,

It may have escaped your notice that I was shepherding a newer version
of Tanjore's original patchset through the nvme lists already. Please
look at version 5 here (I am working on version 6 currently).

https://lore.kernel.org/linux-nvme/20240129181953.1183084-1-jallison@ciq.com/

As your work is very similar (although has some of the same problems
that people already asked me to fix in earlier versions of the code)
maybe we can collaborate on getting a unified version of this work
reviewed.

Please take a look at the link above, and see if we can merge our efforts.

Thanks !

Jeremy Allison / CIQ.
Samba Team.

