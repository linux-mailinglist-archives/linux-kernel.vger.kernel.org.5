Return-Path: <linux-kernel+bounces-163016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E32E38B6385
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FFDC1C21DE7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0231A1419B5;
	Mon, 29 Apr 2024 20:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xSjOtVAd"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F921419B4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 20:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714422535; cv=none; b=b+TK1TYzY5iIsOkt8KMzQ9Kf8BdDiVLxXAWqHVQkrbzujsb792IbavQeshroiphIUYhBr0oMWLEUEGYrx5sMlQg4u5uvDb3VqKXYEfqEdh4ddeKXUuhctOWydNUgg6ULyelejhXe7q5XWM1lVhr1IjrkGSB2wiocGTIedYvWHqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714422535; c=relaxed/simple;
	bh=qD9fA+6x5YEjH6N/bnfv4m+coO6ZZOEi8S65u1eBRvM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iqHOnIauU4MI4WGEqSL1tgrRNQVnY/FItBkxCfSjXESZGUdTODx9oJxdl+WOgOv8w2zZ8CuBRJE1gc3FZI7cIjFKer65qjqdTRENISdT4FjvVsCLTRjs0x/ynlv7EZ0IhJRqLB+yZKzVxs6fr8r8bJ8lR78iybfb8E1o+Lii03w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xSjOtVAd; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4affeacaff9so1025348e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714422532; x=1715027332; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lKuZuU03NTynIqlQQqRGb6a67x7v1EBlFYJcjyUFQ04=;
        b=xSjOtVAdPBiDeq+zZQjPW8x+wzsBe/N4ImR1v3wOB/iC0ayq3MgIZP2rpzBNplGlNF
         S3FdSyMZpGDZp9G0pnx1iHiwdhg+WJLxdAJV5OLfKmn8khNnvscOpOgZEHwFlcKBczX2
         0+b3PD1c29mzNL8Fjsdq66s5d6x9T5ddZDyA6q1NtyQkD0wuLdE9g1XcVWzddrzfRbii
         FGKpoXkHfwTp0ziFqO8c3MpDgMDOU5IoCCuCX0TNKdnaTF+f10p9gC7GciX6LhneAbQR
         l1+JgmXvTcYOsT3PTfe33mLPH5y6p4kOnJX4tELHYXLijJfjB1j3G2YJlgves14dkhcH
         ZdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714422532; x=1715027332;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lKuZuU03NTynIqlQQqRGb6a67x7v1EBlFYJcjyUFQ04=;
        b=O6WfzmY7sxpQpCjvPCzq4hzEo2+c3o78qGI1z4sq4ENl4sk3AYKt4y7RAWyfA794xO
         UyPfQud3GlknKaDwlhhl08zYt3RsXnKvMlIlfKg6K+ghBeDYVkAEkmBGDkuUYyWE06RX
         oIX2NNou5jBYtASyDCxj0jMxQC7LqP3iFlgjAGSNjqOsgv+OSLDIULnKVAqIPCaxkyQI
         7/AWQGDEfRuGmi2paNWF7d46X1mpGb/1XqJpK66mKM7xWxwKyJ6ZXBSzCqo+yIPbTjjQ
         0q9oyIrNmA0Af35mTgOACWf1sdKMUmeUPBX/yp06abpJ/PATgpGdeKSXPQPcov54Pz54
         7fGw==
X-Gm-Message-State: AOJu0YxCbDjwk+j6g0IbKfglYqoS8znRRjp4ltAio35C8djOkUvMQ4RN
	viY9Pw/c3ge7dkAfSjW8J+0DMdQOWCF43F55rnM886GDU2YkUizVAzQJhahsfOvdFdmTvy2MykA
	2ue+Ucx+HnnuTX5fXC3PwVkvpgqfNi85MWQz59IIdGnIvpjwhmr4=
X-Google-Smtp-Source: AGHT+IGWE4dZTf8eDRkrviqbjY4zijszcVXO72v7h15YxEvhFegCWLtOLh372/gBc1wZQisnIMhcKj7hvdbxUkY8IEQ=
X-Received: by 2002:a05:6122:2221:b0:4d4:20fa:eb0c with SMTP id
 bb33-20020a056122222100b004d420faeb0cmr11396869vkb.5.1714422532382; Mon, 29
 Apr 2024 13:28:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 30 Apr 2024 01:58:40 +0530
Message-ID: <CA+G9fYsXkn3xcdOm7H3+s4Xw_vc0f+uqCbFHHOcQE6OUascTsw@mail.gmail.com>
Subject: arm64: dts: ti: k3-j784s4: No rule to make target:
 k3-j784s4-evm-usxgmii-exp1-exp2.dtb', needed by 'arch/arm64/boot/dts/ti/dtbs-list'.
To: open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, Chintan Vankar <c-vankar@ti.com>, danishanwar@ti.com, 
	krzk+dt@kernel.org, Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The arm64 gcc-13 allmodconfig builds failed due to following dtb issues,

Looks like the recent changes on arm64: dts: ti: k3-j784s4: are causing
build breaks.

arm64:
  allmodconfig - gcc-13 - fail
  allmodconfig - clang-18 - fail

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build errors:
----
  make[4]: *** No rule to make target
'arch/arm64/boot/dts/ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtb', needed
by 'arch/arm64/boot/dts/ti/dtbs-list'.
  make[4]: Target 'arch/arm64/boot/dts/ti/' not remade because of errors.

metadata:
------
  git_describe: next-20240429
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_short_log: b0a2c79c6f35 ("Add linux-next specific files for 20240429")

Steps to reproduce:
----
 # tuxmake --runtime podman --target-arch arm64 --toolchain gcc-13
--kconfig allmodconfig

Links:
----
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2fmJ3r7MbjcUn6ZjBeDKT6SpKpH/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240429/testrun/23715285/suite/build/test/gcc-13-allmodconfig/details/

--
Linaro LKFT
https://lkft.linaro.org

