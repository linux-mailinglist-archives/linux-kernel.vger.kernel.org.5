Return-Path: <linux-kernel+bounces-62153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F12E4851C44
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADEDA28233E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C6C47A63;
	Mon, 12 Feb 2024 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FW81aVlN"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37733F9E5
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 17:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707760512; cv=none; b=t5VmDkW7EvtN/ThqJ+w6q3M4sWELMJ5+WFP3tQnDUbjpBnHLkTCByES4BobGkXDP0bws+Evx+jfoCo2BilDnw7QQ4oS1Nsp7dQhCSjhOC6T7tebJZGsoq876cwbhPI+CsVy8qCg7aWkLzpH22QkvL/YA5aqxxoCif9wU42+MZtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707760512; c=relaxed/simple;
	bh=Og8NnqP02pab6hxhGswPot4+uZWlv3wF0Kx/7BPs+og=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fTIhNK4C6Vo8V6nRWdZQvAFkxE0jRObcLAytY1LlfEE6Gz9s/kAeAyGnlkdNaG4dGVbZh2R8V7YxN/li8ZHHIb+wbp5vAuYY+f+NUTsDh2P3kSu4BK2/cO4V3L5xxBQF55Fh/MTbJ0iruX+SeFozSvYWE2z2eVHwYH2UBu0tgqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FW81aVlN; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4c0819d4890so7041e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707760509; x=1708365309; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3t18idpy1yL8hjQMjo5EA0cSeouRX8+0f9MTy1s1S9E=;
        b=FW81aVlNH/BZR7XB6KSg9JUX43XkT524bJJN/na1N8YGEV/8nJiSKNEH4+Y9HOK8ON
         Og0bM9IG/Niffc/U1puuUBWQ28932tn7Dk/p0wg9IQjmUA4kWzqWcSyobwk54GAYQ28F
         HhbARWgTvPp3WqZPbayUAzST7xTgYh8B+jeMAwo5P+ZSVAypqQgUHjPmMzauOmeUxYp2
         VAZfynnFRoqGk1dSnbZcoL0Frbwtjp+mpevzWO7lhQecxvNtwZ4GURtTJcWsZLkldLwu
         GgVZAN5spajPqFW26TJ2Rn/0rlNLruCQ34ZCBv9JFoFJQinVWh2UeNlsWc62Rahro9ng
         CfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707760509; x=1708365309;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3t18idpy1yL8hjQMjo5EA0cSeouRX8+0f9MTy1s1S9E=;
        b=QrWh8BIpjkGfb84Y/5gNFeQkqOm93mvNU65bZN2nrryAkau6MkluVU5rRNccWSByWA
         gt+E1WCjuU2BGPrLrx9L/z8cC/hAUHSmM4WSdDgIaYklFFvrjPw9LxCKQZUQ0+hg9tmh
         ILdLW3jYScjdHMZhDnxdXvuUa/OLwyJmenjlOp1GumnVpX40n4xoOZLL+BxEvEK2nqbX
         NqDNWxWBvWDcnmsNPvJTAIVsbKnkPRvmN2JlCn9uDqQqmbxBWz4PTUgJh1EqkuUGqBBC
         1bNoZ3hExpixW4EZQrefC1eaNfjsNpX4e3ijpsLh01L4utvtOw4m8NLz49KOoyb7/TZo
         10Ow==
X-Forwarded-Encrypted: i=1; AJvYcCW6Cs7E6jlgxt9kRcdaCFmJimBmNGQHfqMW8/ESmCW+MnFBM3ouyPalMqnPvStNXezbTr1ASw048kHW1r031Afrmt6GNCq8AGsfbmA3
X-Gm-Message-State: AOJu0YzrRiAA0Jz2P5+B/BRiMiIa/4Ds7ripb126wPfN87a+DcWohIdj
	zibev1UuDYanc3j+4wdsGtB5DJufrEzZXZrf1X+5TDfuWOe+RSycVPOgYyqzt6+iaxekGrd508y
	8Nwp/owuzTyeHTaZrqPir9URFPDaH+3djf7Na9g==
X-Google-Smtp-Source: AGHT+IE+fTlUlm6S5i/bXd/mDL8so/lGTPpD+/HFFykbPEgOk5IuqJAenCRnR7NuEVF9ZDb1qbAIbtcT+Jirb2/ibvk=
X-Received: by 2002:a1f:e0c3:0:b0:4c0:51da:bb6d with SMTP id
 x186-20020a1fe0c3000000b004c051dabb6dmr3908276vkg.8.1707760509453; Mon, 12
 Feb 2024 09:55:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 12 Feb 2024 23:24:58 +0530
Message-ID: <CA+G9fYsY7Uz_CnyqgyhAr6QsS9dJzC-9wMoDwq0=9=Rzmz5S5Q@mail.gmail.com>
Subject: next: fs/quota/quota_tree.c:674:8: error: variable 'blk' is
 uninitialized when used here [-Werror,-Wuninitialized]
To: linux-fsdevel@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Jan Kara <jack@suse.cz>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

I encountered the following build warnings/errors while compiling the x86_64
kernel on Linux next-20240212 tag with clang toolchain.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

fs/quota/quota_tree.c:674:8: error: variable 'blk' is uninitialized
when used here [-Werror,-Wuninitialized]
  674 |               blk);
      |                             ^~~
include/linux/quotaops .h:34:41: note: expanded from macro 'quota_error'
   34 |         __quota_error((sb), __func__, fmt , ## args)
      |                                                ^~~~
fs/quota/quota_tree.c:666:10: note: initialize the variable 'blk' to
silence this warning
  666 |         uint blk;
      |                 ^
      |                  = 0
1 error generated.

Links:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2cFjnmDh1oofs8YfpPEBSMDvU9R/

As per the other reports, this has been fixed in Jan's tree.
https://lore.kernel.org/all/20240212131615.6jvnwweivkydv3j7@quack3/

--
Linaro LKFT
https://lkft.linaro.org

