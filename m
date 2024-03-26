Return-Path: <linux-kernel+bounces-118352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D829A88B93F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 05:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65F031F3C566
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 04:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05389129E85;
	Tue, 26 Mar 2024 04:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y67xj/fe"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD069129A99;
	Tue, 26 Mar 2024 04:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711425945; cv=none; b=esOSRvratdkFlK5Ird7kp1iexSNBZgXMXJQgrE1n9ZUrbprPrLLbVLkmwufG5On0OWAQilp9lBG6XasB0ApcYqMGdacETLdvDBx3DJkSwcNfoflOeTEYmpGDqZZAoSCgTHVk50eePbqjnvc/p7kAMCqBq1qbCLUXJ0kQyTe7kuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711425945; c=relaxed/simple;
	bh=Ia73zZiD+hK+jAxhTj3Z3D/jPYuJWilL4Y+EFN/8Vb0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=uCGKZQrasZ3eP8YdcigVJZJUOjIE+qyrd0sct1m1U7yeNXYScvEts8sUhcBshUHQtaNBNkggZxtiHlhonYwJiykV72H4Pvo3SykMOTBKWCAUL85OA+fc3WdDuSBvzcB2eSvG3QvCGPpFQZv0sKlBMbqrgAdD6uQXZsfEC3x/NWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y67xj/fe; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e0411c0a52so37008345ad.0;
        Mon, 25 Mar 2024 21:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711425943; x=1712030743; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mp/iSgbfnW8orknThf8Mk8F+cZ9YlXVvw/K4UD94uzM=;
        b=Y67xj/fejraRyfOlXKJnW6PmVp66EOmujeLTKWFba2PRwZRQONNWLyQshcKF8rcRS6
         IxrVo4AJsG7X4OLWBtBn9x5Gra8BZiRK7DBcOhxpDTdUUEAMm5APtuw9+hdAuVlRRS0J
         lSIn26yduYmGIO2MQsEFEV+c9t0PfovD+01+FGBl13Eq7KjW8PqqBq5l9oADQTcLks6T
         EUHomie/ywN1/yYfz6USvCd1Quwl/u3Fw/u+vQYwllUf0omNW5XbxoWL1Um1X4uxxKGs
         rcghSH0uMyXk5iaD3PHIcM31b5x2m01NtZzl4+xQvlZ/ZkR2jNCZ1cgaAmB5CGTFzmN8
         w7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711425943; x=1712030743;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mp/iSgbfnW8orknThf8Mk8F+cZ9YlXVvw/K4UD94uzM=;
        b=LdWPM6ICooxwCvBrXhi0GrScrlLtDaeGzKIO1Hcn/86mYcnfvJ0FrHdf+v/ui1PLgq
         54ztI7gIdiaDvbVoE4bsI7FOsIE89b9ymmaCOCsIIEWWRCl9sANKRwm3OnFZrVWd9Wqi
         nr4veY+B5uI0oTf9aaG9LcvlNNxmViHZAs1rQN7hQ56BLov8/uEomY76dIBizXa3ekkg
         8jaTkNT71R9fLv03xH42Lz3dT2bug/47Nre2H4fsYJemjXYwrryfx5V+EUoMD078bAML
         MCOqs+ZZrtmLmosIn0GEhfoQn7RK2h/xpuLaGUmQ1DB1mN0WNZoxIuF4aE6SKZ4D3mc0
         hvrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqIp97WU/fliKN1dyF2Pk5oCweaPqRYQUlnkR4VUngQIetwsNJxYg7HYs3wvtZefJ6NlZnzfcL5ZetNRYqluvw+P53Rhp3kjd0R+cO66QKziK8hsX7VpQktizcTwllTLHTO6VHhrsw
X-Gm-Message-State: AOJu0YwiE4p46vChwr7JwZrXqN2Cx39OYyyxdL5rcD2BF1fBkKRnKVug
	UZktzC5qmZ9Z/ZapjHz9cHVdiuZWbtgHGXY3fGI2yziJhiQOC9l8
X-Google-Smtp-Source: AGHT+IFcsLR2C8+ZtR+yv0vJURk4SVpANVqlGc8m55n49GRWtgUneeT/o1MgeBxrYA4ZsVSCliHjzQ==
X-Received: by 2002:a17:902:eb8d:b0:1e0:115c:e03c with SMTP id q13-20020a170902eb8d00b001e0115ce03cmr8588174plg.53.1711425943001;
        Mon, 25 Mar 2024 21:05:43 -0700 (PDT)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id t21-20020a170902dcd500b001e0cde860dcsm1810252pll.51.2024.03.25.21.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 21:05:42 -0700 (PDT)
Message-ID: <f735ce0b-db1e-49bc-86ac-b5ab8e4aec31@gmail.com>
Date: Tue, 26 Mar 2024 13:05:39 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: amogh.linux.kernel.dev@gmail.com
Cc: airlied@gmail.com, corbet@lwn.net, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org, javier.carrasco.cruz@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 skhan@linuxfoundation.org, tzimmermann@suse.de, willy@infradead.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>
References: <287eb3f74e4c31adb065668ff49c8e1577388227.camel@gmail.com>
Subject: Re: [PATCH v2] Fix duplicate C declaration warnings
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <287eb3f74e4c31adb065668ff49c8e1577388227.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello.
Let me chime in.

On Mon, 25 Mar 2024 13:03:10 +0530, Amogh Cheluvaraj wrote:
[...]
> After further introspection of the file drivers/gpu/drm/drm_fourcc.c, I
> found that the warning is caused by having the same name for both the
> struct and the function as in "const struct drm_format_info
> *drm_format_info(u32 format)". This is an issue found using the latest
> version of Sphinx as reported by Akira Yokosawa in message id
> 564cbd05-8788-9223-1ecc-59e7fc41b46a@gmail.com.

That message of mine just pointed out that the Sphinx bug of false
duplicate C declaration warning first reported by Mauro (+CC'd) at:
https://github.com/sphinx-doc/sphinx/issues/8241 --
"C domain issues when building the Linux Kernel documentation".
It had not been resolved despite Mauro's recognition of the issue at the
time.

It was closed without fixing the bug but delegate the issue to an earlier
one of the same nature at: https://github.com/sphinx-doc/sphinx/issues/7819 --
"C, distinguish between ordinary identifiers and tag names", which was
opened on Jun 12, 2020 and has not been resolved.  (almost 4 years ago!)

There is two pull requests attempting to resolve the issue at:
https://github.com/sphinx-doc/sphinx/pull/8313 --
"C, distinguish between tag names and ordinary names" and
https://github.com/sphinx-doc/sphinx/pull/8929 --
"Intersphinx delegation to domains".
PR #8313 needs #8929 as its prerequisite.

Unfortunately, both PRs are still open as well as the issue #7819.
Honestly speaking, I don't have any idea what prevents those pulls,
give or take the need of rebasing with conflict resolution.

>                                                  So by changing the
> function name to something like "query_drm_format_info(u32 format)" is
> a possible fix. Question is what should I rename this function to, that
> aligns with the coding standards? Also suggest a new function name for
> "drm_modeset_lock" that causes the second warning.

So, I would rather not rename valid identifiers for the sake of working
around a bug of Sphinx.  Rather, I'd appreciate if you'd send a message
encouraging Sphinx devs to resolve the issue sooner rather than later.

        Thanks, Akira


