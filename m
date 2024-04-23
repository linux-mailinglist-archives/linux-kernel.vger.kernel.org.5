Return-Path: <linux-kernel+bounces-155129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A896A8AE5A3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9B6D1C22F4B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E2A84DF2;
	Tue, 23 Apr 2024 12:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="rPWobqV/"
Received: from out187-13.us.a.mail.aliyun.com (out187-13.us.a.mail.aliyun.com [47.90.187.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1842E83CC3
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713874190; cv=none; b=rIci9aOZMZi7shnVEqHU/IXrG5ZB8I+9D7QAluxv/RfLlqpPMgXl+rleMl6dJ5mr90VOqCiFHRCkb5h7Sm84J/o5mDq2PMNLjNMLAGeuZ3zfmbf510+7JXd1SJoe0DpJqHvkuVlOFisg1WpT3VwjB4I8plf/MyeExDoo7500LeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713874190; c=relaxed/simple;
	bh=cKQ7sIqwMIKOom6wGqlRgxSRBGE2B0BqMz48jaLBQEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aWB/fZWcX9hCqdaAKB2fSJkL9LHk4GDZEP+o1YDe5GviUKLpD6phu0T06Y2R4uHk0yIPX9TR1nBRXit6hw2UQyXoSUmgMtjRv9gf2qya/qo4c/SiFX4Utw+on+v8NM/Bgt9tWdQV/pDkPcSrdc6VL6xlVWYQZB5OP8S9O8/i/jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=rPWobqV/; arc=none smtp.client-ip=47.90.187.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1713874176; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0ToxibymbxSxXu/3U2e7lO1wHttOZIGCXSzIiNxS0Sw=;
	b=rPWobqV/Hs21rYMJBRYoFe/HwxrIa39aIbw6Bf4FqjReisKbfCJgIZWyYdEm9xfKmYDkmbBPeVMGUjUR/ww5Ak8+xTJ82zsmSz+8pEDr/OijUuRL+kX32UW4eqxkJLiXvOCM9LzSZHWgY6U+QPIvLqqfObDa629Vocjh+pIOSow=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047213;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---.XJWNYgx_1713874168;
Received: from 30.230.91.3(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XJWNYgx_1713874168)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 20:09:35 +0800
Message-ID: <ee636701-3f92-4424-8b04-dd2cecd8313a@antgroup.com>
Date: Tue, 23 Apr 2024 20:09:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] um: Add an internal header shared among the user code
To: Johannes Berg <johannes@sipsolutions.net>, richard@nod.at,
 anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240423112457.2409319-1-tiwei.btw@antgroup.com>
 <20240423112457.2409319-6-tiwei.btw@antgroup.com>
 <e850e5016348805e7e2f427ed98cb1eb539fc434.camel@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <e850e5016348805e7e2f427ed98cb1eb539fc434.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/23/24 7:30 PM, Johannes Berg wrote:
> On Tue, 2024-04-23 at 19:24 +0800, Tiwei Bie wrote:
>>
>>  $(USER_OBJS:.o=.%): \
>> -	c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) -include $(srctree)/include/linux/kern_levels.h -include user.h $(CFLAGS_$(basetarget).o)
>> +	c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) -include $(srctree)/include/linux/kern_levels.h \
>> +		-include user.h -include $(srctree)/arch/um/os-Linux/internal.h $(CFLAGS_$(basetarget).o)
>>
> 
> Why not just include it explicitly?

I think it might be more convenient if we include it implicitly,
especially since there are two levels of directories under os-Linux/.
But I don't have a strong opinion on this. I'm also willing to
include it explicitly.

> We do have the warnings?

Yeah. Without this patch, I can get below warnings with `make ARCH=um defconfig && make ARCH=um`:

arch/um/os-Linux/skas/process.c:107:6: warning: no previous prototype for ‘wait_stub_done’ [-Wmissing-prototypes]
  107 | void wait_stub_done(int pid)
      |      ^~~~~~~~~~~~~~
arch/um/os-Linux/mem.c:213:13: warning: no previous prototype for ‘check_tmpexec’ [-Wmissing-prototypes]
  213 | void __init check_tmpexec(void)
      |             ^~~~~~~~~~~~~

And below warnings with `make ARCH=um SUBARCH=i386 defconfig && make ARCH=um SUBARCH=i386`:

arch/um/os-Linux/elf_aux.c:26:13: warning: no previous prototype for ‘scan_elf_aux’ [-Wmissing-prototypes]
   26 | __init void scan_elf_aux( char **envp)
      |             ^~~~~~~~~~~~
arch/um/os-Linux/skas/process.c:107:6: warning: no previous prototype for ‘wait_stub_done’ [-Wmissing-prototypes]
  107 | void wait_stub_done(int pid)
      |      ^~~~~~~~~~~~~~
arch/um/os-Linux/mem.c:213:13: warning: no previous prototype for ‘check_tmpexec’ [-Wmissing-prototypes]
  213 | void __init check_tmpexec(void)
      |             ^~~~~~~~~~~~~

The compiler I'm using is: gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0

Regards,
Tiwei

