Return-Path: <linux-kernel+bounces-107762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D21088015E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B17E11F24770
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8458174B;
	Tue, 19 Mar 2024 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="1GD/VRLI"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01FD651BE;
	Tue, 19 Mar 2024 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864240; cv=none; b=rkrLrW4yvMF2vvckJKbWvBAcjW5Xlcqs+WoaYIw9ur+26H2nQoEQuMEkDL4A1YwN/A0F3SVuhcZuo732QBh+J71ACBS6ZasbFc6eutuleo2PCipgWmWCL5nTecEtWVOEfTAmXt+6VBobhVizUmVPReyPra2bgomxyc/5akJJ7Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864240; c=relaxed/simple;
	bh=CEUhq594SW1Z9wHf3qYoTJ70gFZ0XXHV/NW7y+d4pYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GEl3ZOwfEzTQFosArQnqegSGMA1uOExUSeXFv0aYNCsPfZcEOn1xB4JpJfjAclZKQlj1pJkvIxfC8JTBtyw0VxQgdYo6hHpqmMSsOhzygfNWLKcFRnJegI0pK3sn7Kt+w8agGO4tr289MZ70VjQgCAKJMdL60xz7fq4bw4V7nRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=1GD/VRLI; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Tzc3D2nP7z6Cnk8y;
	Tue, 19 Mar 2024 16:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1710864229; x=1713456230; bh=eS0GccxVXWypqUcgMEYj0E+W
	EKgYMi2i2cBpKDqor1Y=; b=1GD/VRLIz8hJStZSXeXadtBmzhDOchXyKzRp3CJ6
	homyFeEjoIlh8ztTY0SlA0u2gFi/eIut8oAM5LKT7I9zmKPS2WLGb98Pte1N2wZH
	OsOK5eNRDehPTPcworC2UL2sEpJObmbkU3KLpg0MYcwsTEOkS1E1pyYit8CtT/Gr
	8OcxuKRM/UdxIiHbd+3XfaYnuVj1O37HInp4nTGf2ExFSbgVRkltofgxko1UgfBz
	rBcZRPpnkn5stjJYOHfHDW9QWEJM1G3Fcnqo7SKo3BE0YGHGD/FhcWsKsC5H8j1o
	vae1oJA5MAZ7WCKtgad/q35lGWzuyqwpeeWVHk2sJvpYyw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id L_Mqn8hu0QZA; Tue, 19 Mar 2024 16:03:49 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Tzc3771Nhz6Cnk8t;
	Tue, 19 Mar 2024 16:03:47 +0000 (UTC)
Message-ID: <d1a1b0b8-41f1-4ead-b393-d8d2f099b0c4@acm.org>
Date: Tue, 19 Mar 2024 09:03:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: core: Make scsi_lib KUnit tests modular for real
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Mike Christie <michael.christie@oracle.com>,
 "James E . J . Bottomley" <jejb@linux.ibm.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <48ca5e827ca420bbdbabb1643e2179dc95c9e0b7.1710849638.git.geert@linux-m68k.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <48ca5e827ca420bbdbabb1643e2179dc95c9e0b7.1710849638.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/24 05:02, Geert Uytterhoeven wrote:
> While SCSI_LIB_KUNIT_TEST is a tristate config symbol, configuring a
> modular build of this test does not do anything: as the test code is
> just included by the mid layer code, it only works in the built-in case.
> 
> Fix this by converting the test to a stand-alone module.  This requires
> exporting scsi_check_passthrough() and adding a MODULE_LICENSE() tag.

I don't like it that scsi_check_passthrough() is exported so that counts
as a disadvantage of this patch. Why to convert scsi_lib_test into a
kernel module? What are the advantages compared to the current approach?
That information is missing from the patch description.

Thanks,

Bart.

