Return-Path: <linux-kernel+bounces-23232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC9382A938
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A29021C20E19
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D15F512;
	Thu, 11 Jan 2024 08:38:19 +0000 (UTC)
Received: from er-systems.de (er-systems.de [162.55.144.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B9C11704
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lio96.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lio96.de
Received: from localhost.localdomain (localhost [127.0.0.1])
	by er-systems.de (Postfix) with ESMTP id 174E5ECDAE2;
	Thu, 11 Jan 2024 09:38:12 +0100 (CET)
X-Spam-Level: 
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by er-systems.de (Postfix) with ESMTPS id F3A49ECDAC4;
	Thu, 11 Jan 2024 09:38:11 +0100 (CET)
Date: Thu, 11 Jan 2024 09:38:11 +0100 (CET)
From: Thomas Voegtle <tv@lio96.de>
To: Arnd Bergmann <arnd@arndb.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Build error kernel/cgroup/rstat.c on v6.7-1959-gaffc5af36bbb
In-Reply-To: <91fe3dea-ca35-4dc9-ac13-e4eb0df30951@app.fastmail.com>
Message-ID: <23af29c5-55ec-f63f-ddc9-43756fc0d60d@lio96.de>
References: <f8ed4fe9-edcc-1cdf-65cc-7cc9d4f913a4@lio96.de> <c7cb5834-1cf9-48ae-968a-d2807b6b9467@app.fastmail.com> <c6c5fe88-c024-40db-ad1c-4e6681e3d7af@lio96.de> <91fe3dea-ca35-4dc9-ac13-e4eb0df30951@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="933399184-1140405057-1704962291=:22212"
X-Virus-Status: No
X-Virus-Checker-Version: clamassassin 1.2.4 with clamdscan / ClamAV 0.103.11/27150/Wed Jan 10 10:40:48 2024

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--933399184-1140405057-1704962291=:22212
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 11 Jan 2024, Arnd Bergmann wrote:

> On Wed, Jan 10, 2024, at 22:18, Thomas Voegtle wrote:
>> On Wed, 10 Jan 2024, Arnd Bergmann wrote:
>>
>>> On Wed, Jan 10, 2024, at 20:50, Thomas Voegtle wrote:
>>>> Hello,
>>>>
>>>> building v6.7-1959-gaffc5af36bbb I get this:
>>>>
>>>> ...
>>>>    CALL    scripts/checksyscalls.sh
>>>>    DESCEND objtool
>>>>    INSTALL libsubcmd_headers
>>>>    CC      kernel/cgroup/rstat.o
>>>> kernel/cgroup/rstat.c:218:22: error: no previous prototype for
>>>> ‘bpf_rstat_flush’ [-Werror=missing-prototypes]
>>>>   __weak noinline void bpf_rstat_flush(struct cgroup *cgrp,
>>>>                        ^~~~~~~~~~~~~~~
>>>>
>>>>
>>>> git bisects points to:
>>>>
>>>> commit 0fcb70851fbfea1776ae62f67c503fef8f0292b9 (refs/bisect/bad)
>>>> Author: Arnd Bergmann <arnd@arndb.de>
>>>> Date:   Thu Nov 23 12:05:06 2023 +0100
>>>>
>>>>      Makefile.extrawarn: turn on missing-prototypes globally
>>>>
>>>>
>>>> My config is attached.
>>>> openSUSE Leap 15.5 x86_64 with gcc 7.5.0
>>>>
>>>>
>>>> Is this already known?
>>>
>>> There is a workaround in linux-next, see commit
>>> 15fb6f2b6c4c ("bpf: Add __bpf_hook_{start,end} macros")
>>>
>>> I assume this will be merged soon.
>>
>> That commit is already merged?
>
> It's probably missing this one then:
>
> 689b097a06ba ("compiler-gcc: Suppress -Wmissing-prototypes warning for all supported GCC")
>
>    Arnd
>

With that patch (689b097a06ba) it builds fine.

Thanks.


       Thomas

--933399184-1140405057-1704962291=:22212--


