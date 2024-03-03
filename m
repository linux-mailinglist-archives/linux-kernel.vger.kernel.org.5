Return-Path: <linux-kernel+bounces-89813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A86F86F601
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 307161F213A3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7216367E80;
	Sun,  3 Mar 2024 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="D7+wRm3A"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A99167C53;
	Sun,  3 Mar 2024 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709481611; cv=none; b=Zg79OIEr95AsJ3F3pJRYqx6KtL7m3USWmvQjeCn1DiPAszFg0u4D5fyGv3mPtagnCGQhoC0GxboxV2WaZ1GZEXUuj4vTjZ6SxReE/tND2LABfJ2oRvvZvruNYyCO/tfLEyfbIyr6YMBc0IplnG2VheC1wJfyQEWY5Q6MGRQJ/v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709481611; c=relaxed/simple;
	bh=Sx8hgvXv4t/MUqwvPfce9U7MPe0mrdw6nzvKR3ya0CE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YmSJdJIKEH/ZxTnVq7VOYaeeNElwM/Gnp4zDnjw4ta8aNftS4dRVx0pNpDKgyNPwTfOZpjoMYrQPobGuTbDPbpKxlzhIxRwuqRNkMrD9A0IcSDOx/BPc5GIROufvey76rjAlRF3BReP2HZJ/DvjDVXiS+dyUQcLvYEQOAhc8Rj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=D7+wRm3A; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7D745418B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1709481609; bh=+lDDxPXqU+cc4fLkXAYANxGoS0kZPxt3j75O2+Po568=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=D7+wRm3AodOF9xpDiE9FZahN+hAQhIetaD9BZ37MGPzPq3e33wxj2NvAyZGueC1jT
	 eMzWCtIqoTsEsXjeMxvkcfojI+KMunVNDu7YB+ziVQ1rlxU2LXTpAGPuB9nwjgnktW
	 7O4K62sGFb0JStHa2wPzu6lTnvI1WYbWwfWlx3DA1/cv4e/nvupkGXqGBSuG+WV3r+
	 zm3vtsRn3VL4d/rm7wQZVwfYF1uBTb63vNFKdTNLh6ZjqjNR/rJLyrlV7KGKkmHlsW
	 EgPpW8yZtRmtWc9sX8BYwuxQjCUo3VD5Wy/ssHzmkFgmwgw0qNvCZdpVpb7wKNkCm6
	 5eXyXeyXTp88Q==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7D745418B6;
	Sun,  3 Mar 2024 16:00:09 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Jani Nikula
 <jani.nikula@intel.com>, Randy Dunlap <rdunlap@infradead.org>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Lukas
 Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH v2 0/3] docs: submit-checklist: structure by category
In-Reply-To: <20240229030743.9125-1-lukas.bulwahn@gmail.com>
References: <20240229030743.9125-1-lukas.bulwahn@gmail.com>
Date: Sun, 03 Mar 2024 09:00:08 -0700
Message-ID: <87y1azxq47.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:

> Dear Jonathan,
>
> this v2 series addresses all review feedback of the patch v1 here:
>
>   https://lore.kernel.org/linux-doc/20240226104653.54877-1-lukas.bulwahn@gmail.com/
>
> Immediate actionable review feedback was:
>
> from Jani Nikula:
>   - turn categories into subheadings
>   - use common heading adornment
>   - change to bullet or autonumbered lists
>   - propose those changes as separate additional patches
>
> from Randy Dunlap:
>   - if subheadings, drop the colons at the end.
>   - acked change to test with linux-next
>   - Stephen Rothwell requested item 1 to stay item 1.
>   - pointed out swapping the config names in the commit message.
>
> v1 -> v2:
> The commit message of patch 1/3 is improved addressing Randy's
> feedback on the commit message.
> The diff itself of patch 1/3 is unchanged.
>
> Patch 2/3 and 3/3 addresses Jani's and Randy's feedback.
>
> The extended discussion and feedback was:
>
>   - Is the checkstack script worth mentioning or can it be replaced?
>   - missing some nowadays more important points.
>   - consider getting it coherent with submitting-patches.rst
>
> I have put the extended feedback onto my todo list; for the next
> iteration on this document---after cleaning up submitting-patches and
> making the howto and submitting-patches more coherent.
>
> I followed Jani's request and created three patches, this might help
> in the next/final review---if any further review happens now.
>
> However, I do not think the kernel repository needs to be swamped with
> three patches for this 'logically one change' to a single document. So,
> I also squashed the three patches back into one patch, sent out as
> PATCH v2-squashed:
>
>   https://lore.kernel.org/linux-doc/20240229030146.8418-1-lukas.bulwahn@gmail.com/
>
> Please either pick this patch series or just the PATCH v2-squashed as
> you see fit.
>
> Lukas Bulwahn (3):
>   docs: submit-checklist: structure by category
>   docs: submit-checklist: use subheadings
>   docs: submit-checklist: change to autonumbered lists
>
>  Documentation/process/submit-checklist.rst | 163 +++++++++++----------
>  1 file changed, 88 insertions(+), 75 deletions(-)

So I've applied the first two patches, since there doesn't seem to be
any disagreement over those.  Once we figure out how we want the
autonumbering to be done, that can go in as well.

Thanks,

jon

