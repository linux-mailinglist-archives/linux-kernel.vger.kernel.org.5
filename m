Return-Path: <linux-kernel+bounces-153789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBD98AD332
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B57E42838A4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94DF153BDD;
	Mon, 22 Apr 2024 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jt/+8w9i"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C586115218D;
	Mon, 22 Apr 2024 17:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713806103; cv=none; b=m2Z+7lwNxHbJOB94WLGKjnpeVddMVTKH68QjXi2brwgDGSBzIvjlYa4yFQVLADScEFpBTM7E7PBHUIOcgEIWWVvWbjARVkP5LiX3GktG9c3y+UGU1k9tYcJjsSriGEOQj/BF8p4ymGVpocAlJ81D0swZCt2Xr9xEmuviIAnat2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713806103; c=relaxed/simple;
	bh=BrpU3LoTLXHcoM8ORoBD8hzIx4TTKfnlR5i0LAc22wE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IhEnqTpUYYpaqhkNY+ToIbvdmk+XaAosvZoZ2KKgzy3bdmKEvZa7SYKioqVZw9iV8ufoj27qs3o8Cuk5B2pVJqJYUSy1Wq1f7QF/AqOCOkAzc3uzDRjewUCFq0g/wMXYcksSIgYCVHFzuX86sekrhVj5/E+Y9SbPq5YYQHY4QOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jt/+8w9i; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713806101; x=1745342101;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=BrpU3LoTLXHcoM8ORoBD8hzIx4TTKfnlR5i0LAc22wE=;
  b=jt/+8w9i5nHinYghB/xEV2L6aa9nacOFt9AzROrE7LbGnDkLcGjtOi7U
   EocJWKaQ4AWtDQ5TcDtcDMzPAB5QWAPMIztzWkaB4wk5sbKU6u3S5UBXH
   q7B+ng3osd1mE0dMIzEJeUr2S71SYarALKSzMsaELfTKallmnHi1qzxM+
   feHlZbWF/JuJLc0zhMTzn2b/+Cukn/uWnDdwn+4ZELBmY7i8Y0FjjK9qv
   MDIYG5L2ElBW8ZZn5jQ8KUnryf7KyBmk7wibCVQwjDnEExKUAUNf+SXT1
   GZzJUhu81DclI0Az9NANauq+ROQL70Jmu2C6ZTAD7amQJt2FANLnaN6kv
   A==;
X-CSE-ConnectionGUID: zBUy2dtyTfSC2NNijh02NQ==
X-CSE-MsgGUID: TEy1MCXDRTypx9n9T3CyVA==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="13191428"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="13191428"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 10:15:01 -0700
X-CSE-ConnectionGUID: OBS6r4f7Q26O3NNuaAsTEw==
X-CSE-MsgGUID: ccl8swbfSOSg+0+wvS8rXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="23955593"
Received: from ralbanes-mobl.ger.corp.intel.com (HELO localhost) ([10.252.63.128])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 10:14:55 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Linux-Renesas
 <linux-renesas-soc@vger.kernel.org>, Masahiro Yamada
 <masahiroy@kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH 00/11] drm: Restore helper usability
In-Reply-To: <CAMuHMdXCL-gbKr6mUBPWONtRjz=X0vZQgiS=02WXXSFf67yBww@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1713780345.git.geert+renesas@glider.be>
 <87il09ty4u.fsf@intel.com>
 <ff4f9e8f-0825-4421-adf9-e3914b108da7@app.fastmail.com>
 <875xw9ttl6.fsf@intel.com>
 <af6e26d1-1402-4ed2-a650-b58eae77273e@app.fastmail.com>
 <CAMuHMdXCL-gbKr6mUBPWONtRjz=X0vZQgiS=02WXXSFf67yBww@mail.gmail.com>
Date: Mon, 22 Apr 2024 20:14:53 +0300
Message-ID: <87ttjts4j6.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Apr 2024, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Arnd,
>
> CC kbuild
>
> On Mon, Apr 22, 2024 at 3:55=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wro=
te:
>> I'm not sure where this misunderstanding comes from, as you
>> seem to be repeating the same incorrect assumption about
>> how select works that Maxime wrote in his changelog. To clarify,
>> this works exactly as one would expect:
>>
>> config HELPER_A
>>        tristate
>>
>> config HELPER_B
>>        tristate
>>        select HELPER_A
>>
>> config DRIVER
>>        tristate "Turn on the driver and the helpers it uses"
>>        select HELPER_B # this recursively selects HELPER_A
>>
>> Whereas this one is broken:
>>
>> config FEATURE_A
>>        tristate "user visible if I2C is enabled"
>>        depends on I2C
>>
>> config HELPER_B
>>        tristate # hidden
>>        select FEATURE_A
>>
>> config DRIVER
>>        tristate "This driver is broken if I2C is disabled"
>>        select HELPER_B
>
> So the DRIVER section should gain a "depends on I2C" statement.

Why should DRIVER have to care that HELPER_B needs either FEATURE_A or
I2C? It should only have to care about HELPER_B. And if the dependencies
of FEATURE_A or HELPER_B later change, that's their business, not
DRIVER's.


BR,
Jani.

>
> Yamada-san: would it be difficult to modify Kconfig to ignore symbols
> like DRIVER that select other symbols with unmet dependencies?
> Currently it already warns about that.
>
> Handling this implicitly (instead of the current explict "depends
> on") would have the disadvantage though: a user who is not aware of
> the implicit dependency may wonder why DRIVER is invisible in his
> config interface.

--=20
Jani Nikula, Intel

