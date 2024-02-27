Return-Path: <linux-kernel+bounces-83275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A141869129
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A38C91F23BF1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8989213B28E;
	Tue, 27 Feb 2024 13:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="doMEcxip";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iJjpvobV"
Received: from flow3-smtp.messagingengine.com (flow3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FA81E867;
	Tue, 27 Feb 2024 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709038824; cv=none; b=floBqBEwV/4D3sYFi7OOXuwVO5S9Mx/HODW03CckAv9nbdQYAha79iHDYy8IJaBupXUqLWpVMJqY6qxcT8qIp3y5MudwQQqnDO/9arqcIwL0DIGV0AKMtqxGKgOke4P6Jd0Ob+PYlEa0GXJNpGvq5N4+vMQAj9QrpipHcGlK8+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709038824; c=relaxed/simple;
	bh=48fVYdZIAfrNMXN/Ees34xjBvsXwLRNhCIA/vmywld4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=k6VPBsQM0TOjPVnS9HuyEC/yOAx3uxC6+7oYjQGV7AAGoV+TW/c2vPspEXPvkk1C3SX0V+9sNQGC+3GgvB8jAGGLSoNZbT+SHia7U7vQWwXO47nWwTboCGKbdlcAeVquSD+pPi1565LZXEX3zykWJTEjq5pjrbRcIAWgCnGu0uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=doMEcxip; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iJjpvobV; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailflow.nyi.internal (Postfix) with ESMTP id E922820017E;
	Tue, 27 Feb 2024 08:00:21 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 27 Feb 2024 08:00:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709038821; x=1709046021; bh=qPhWauWFG9
	Eq5yPAsXD3zB/CxlDkLHGeIaX5cUViM3k=; b=doMEcxipmJOZYakN3E69jPQTdJ
	35sJW+eMxDEU8wKW5gL+aFVD9Lr2+/edhVCxEueBE4SjPQOOss9i9kkMWRN8dYRs
	0cHV1uSXJYAAVbYRiGTlv5y2d1eXgfQkS91+dtyGHqyfZajToxSHp5gJGx4NU/cw
	9Pjc1gWLfwK3f32OZwnzMAv5Y4kiAxJvPqbJvqJ5St9yq9p8Od3wmm+ZnmOXrZ2n
	/Dfr6WSnp4B0ELzxOcQBhJnu7CO1t0Bmf/SZIojeTgenD+MPZl3P3xlv1Ajwu5qC
	HucusYS22u1ijyfs8TDmYhuB/7drh5dT8Sf2P6Gc3IbZx259GkWereX/KiYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709038821; x=1709046021; bh=qPhWauWFG9Eq5yPAsXD3zB/CxlDk
	LHGeIaX5cUViM3k=; b=iJjpvobV8lNMXdJ3c9X5ZoAAm/tB04RwJ+tFspixbk+l
	hz3A64T3SgGeYuk55UvKXWvbIKHLgmy0TG3nY3NQz+m6bxzoKx/2HPz9ihZrkCno
	jADwgmVs0EptdeWMszSZvRVT4CySjCnvCVU2Siw4tNNrNWCGvGlOnNdI5B8VCa22
	otMigDXjT17c5/6vcf6B+tuoh+MaMCpLqriInSba2m0fOuHXAzr5a7Qz2mPTA2V4
	EDlo+WH2ug6p4Yx9jIAo6bHwYGKKVYDt54ZNLyUkqeyMkGP1KCzP1HK/L7NaPJES
	QCcr4Lc1WL2dYkWeNgepRALAxeizpyhylJ/nShJOtg==
X-ME-Sender: <xms:5NzdZZGAK9VhWesFRNNqNkG96wMflx-scjSiaMqTXVDS0j51JzogHQ>
    <xme:5NzdZeUfqmTtfxQafXKrGTwTvt8V7k5ITBoIQIPmeawTFgAFAztj4QHDvouWN5p__
    VB6rgcxw95y3Gke9qY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeehgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeeiteejheekhfdttefhieffjefgvdelhfelueffueffveehfeelleelffeuvedt
    teenucffohhmrghinheplhhinhhugihtvhdrohhrghdpkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegr
    rhhnuggsrdguvg
X-ME-Proxy: <xmx:5NzdZbKqk6nDm5QR8YNCcucQCZU_V6L7yapRoyhF3aavtDGeVCBaJg>
    <xmx:5NzdZfEFN9zLKP1x3Bx_sC-jOfni3oqSjeCUGUDiapdNwL9sL4b7Hg>
    <xmx:5NzdZfXRM-fbGooB_ZPCBUQpYnWgH9phi_pNy8oHELaSWMS_O0Fiig>
    <xmx:5dzdZc1qsknl85aTY6dDAmAkBxVQUtq9_xxQMiHx6UwxsCloMWfgT5zYEJ8>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 84657B6008D; Tue, 27 Feb 2024 08:00:20 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8e3e7d82-a9e7-4697-8147-d3800f0307db@app.fastmail.com>
In-Reply-To: 
 <CANiDSCsMVR7gqzwrhPCWb7dQcezWbcHxkPNLZJrW=TWaAn+kXA@mail.gmail.com>
References: <20240226-fix-clang-warnings-v2-0-fa1bc931d17e@chromium.org>
 <20240226-fix-clang-warnings-v2-3-fa1bc931d17e@chromium.org>
 <c25638af-d40d-4dbc-a179-efb6f29c38aa@xs4all.nl>
 <CANiDSCsMVR7gqzwrhPCWb7dQcezWbcHxkPNLZJrW=TWaAn+kXA@mail.gmail.com>
Date: Tue, 27 Feb 2024 13:59:59 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ricardo Ribalda" <ribalda@chromium.org>,
 "Hans Verkuil" <hverkuil@xs4all.nl>
Cc: "Mauro Carvalho Chehab" <mchehab@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Mike Isely at pobox" <isely@pobox.com>,
 "Tiffany Lin" <tiffany.lin@mediatek.com>,
 "Andrew-CT Chen" <andrew-ct.chen@mediatek.com>,
 "Yunfei Dong" <yunfei.dong@mediatek.com>,
 "Matthias Brugger" <matthias.bgg@gmail.com>,
 "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 "Bjorn Andersson" <andersson@kernel.org>,
 "Mathieu Poirier" <mathieu.poirier@linaro.org>,
 "Sebastian Fricke" <sebastian.fricke@collabora.com>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2 3/3] media: mediatek: vcodedc: Fix Wcast-function-type-strict
 warnings
Content-Type: text/plain

On Tue, Feb 27, 2024, at 12:35, Ricardo Ribalda wrote:
> On Tue, 27 Feb 2024 at 12:17, Hans Verkuil <hverkuil@xs4all.nl> wrote:
>>
>> Ricardo,
>>
>> First of all, note the typo in theo subject line: vcodedc -> vcodec.
>>
>> There is also a similar (but not identical!) patch from Arnd:
>>
>> https://patchwork.linuxtv.org/project/linux-media/patch/20240224121059.1806691-1-arnd@kernel.org/
>>
>> That patch and yours share the change to common/mtk_vcodec_fw_vpu.c but otherwise
>> they are different, which is a bit odd.
>>
>> Can you take a look at Arnd's patch and see if you need to incorporate his changes
>> into your patch?
>
> We went separate paths :), I tried to make everything const (and
> therefore the remoteproc changes) and he removed the const.

I had the same patch 3 originally but there was still a
warning or a cast from const to non-const pointer, so I
went with the simpler approach that I posted. 

Without that regression, your patch would be nicer, but I
think the version you sent has the same regression that
I ran into.

> His patch looks good to me. Shall I resend the series without this
> patch or you can ignore 3/3 and take 1 and 2?

I also sent your patches 1 and 2 with minor differences in
whitespace. Both of these are already in linux-next, so I think
you don't have to resend anything here.

I sent a whole lot of -Wcast-function-type-strict warning fixes
to address all randconfig builds on arm64, arm and x86, all but
three are now merged. Aside from the mediatek vcodec, the only
missing ones are

https://lore.kernel.org/all/20240213095631.454543-1-arnd@kernel.org/
https://lore.kernel.org/all/20240213100238.456912-1-arnd@kernel.org/

I also had one patch for s390 but none of the other architectures.
I think once Hans applies the vcodec patch, I'll resend the
last two patches together with a patch to enable the warning by
default.

     Arnd

