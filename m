Return-Path: <linux-kernel+bounces-137923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 952C189E99B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69041C22711
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B394168DC;
	Wed, 10 Apr 2024 05:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCOVBT7m"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E5F5CB5;
	Wed, 10 Apr 2024 05:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712726249; cv=none; b=I4ZIDa2EGMXSFlexom/xp8TItHZSVeGe1k1vtXeHGjBqgWdPeZCeNslgTerZ00/MugIFmXA9aFl8svd25dtKY0lLY6FzsBQEXJctU7wqDRPw+7eJRhSGIXJax4gwfenzCZ2MqrbZGfyt+NYHB7ckLEi0u8xnIgUUsXDoy856MVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712726249; c=relaxed/simple;
	bh=S99Pl12yMcxW1KsDE/lJpG5E0XL0utXBgA3TgH2l8O8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JprBKRl2+DRbEHUEDTKG4v60v14Vsq4yx62d1Ew/K8V0wUkbbNUGfXeuKWWkdEW48Z+4wS0EECxEcLwoTKuX8zCrsDWUxT7ku5jJA1rO/bwIFatLgQQSKd0Ul2aBOJxvEuqXqkLMdAXM1pmxscF1YtjHDxqzkMWZ5OmdkP6bJjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCOVBT7m; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a51a7dc45easo594624166b.2;
        Tue, 09 Apr 2024 22:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712726246; x=1713331046; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2cVybOrxaIWBpdRlHhr2VWcjnmCsXElx5uaR8eooCU4=;
        b=KCOVBT7mF2393s1YpJ6r7jKQ3tPv9ERDFEF3/MgEjRC6EccyiPuDZGlh50kB+bhlN+
         SLkL+yUUIcLciHgs9H2tvm6MqxIjojI6cvpMYM/2sxKW1L4LNL9NqmhFtWB8HNc9m74g
         MQUCPemNvKe0RJzfmy2eMXNfHEDzl3WlOFdZW2S6gmd+RPMKveaLMlYwb2ZYGOuK9uiK
         CPj44kB+g8SrVE0PQv1uVyooNcSmUF8Vk67mOrQlciXrnCw+W0wmmmeCMdQDnTEUSuV/
         NRcokZ1VkBIjRFwLW+VWhAx6Flc795JHlVK8FO6/ISRD7Pkh1pyKHwa9Lsa54+MFsQxI
         cxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712726246; x=1713331046;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2cVybOrxaIWBpdRlHhr2VWcjnmCsXElx5uaR8eooCU4=;
        b=Tx29liJMme0IPqMEZLVmVgZQ4AvMia2rCY3xi53s4/YvjlJ8vO/F/zPECtxIKLPiOG
         vqsxA8wGDMyKluZ+MNKa/pzX6UMBwVDOC5LK/nBlw7324RX0e7hdBBFLVJGnbrI21+iq
         asgpatjoXV5buy6cTckenzMnh+eJG9EqlrJ+x4o7X8Z4uUrkpiiGGeCoNkwkpLX76Bak
         VRFmMFB3xqel52FCzoeFQaDxOmM6sU7JXYih3taaX6S15Tlv+B/QLS8RGfP2jFa2c91p
         mqHLritj9IRgA4w2SbVAMCwHDRKGa+CkKc2ecj5yGcMXfJ81Njw3REu8exaxzsH8oP8L
         RFQA==
X-Forwarded-Encrypted: i=1; AJvYcCXxtSBW2qVGMjLtAvQ4UCOZWW2l3CiCxm/mmeC5ZBQQest1KudjXjXxiXqtzgiRrkSYMhYEhpEIBh0FL86ZRURovG4QztA/Lef4I8zH8dVPZX4TAAPf1U3JFTnuT0XjWBzYbIToCJJjfr/6BeYRzyMwajMfbdtsH0gUplsvqNf1gfU7A3z6S6xSh6Y=
X-Gm-Message-State: AOJu0YyBqiMPuX3cKB2EzV4cGa1LT0HAX+8Qj8PVM39S8Tie7mlOsq4U
	VGE+u74auOe8f+Iv+emI0Qd9ELxVmaUTI1fd4OY0d9AuP2bgquS96LDurv2eQ86eQfqrJ8xzEGq
	CddJx6AavkR6IVsgGN06XqXkugdkIhkuRpv4=
X-Google-Smtp-Source: AGHT+IG7FsrMS6CbdL9Mbapbf5TiD5C7IPsXjHCtNalZJ7TlDDnxe6ENgm+0pMmGC+GCa3XGnuZUVLKpFfiXMzh3+Zk=
X-Received: by 2002:a17:907:7da5:b0:a52:13ff:5317 with SMTP id
 oz37-20020a1709077da500b00a5213ff5317mr18170ejc.38.1712726245708; Tue, 09 Apr
 2024 22:17:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404071350.4242-1-linux.amoon@gmail.com> <20240404071350.4242-7-linux.amoon@gmail.com>
 <20240409015352.ocpjbgxrx636jmk4@synopsys.com>
In-Reply-To: <20240409015352.ocpjbgxrx636jmk4@synopsys.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 10 Apr 2024 10:47:10 +0530
Message-ID: <CANAwSgQtfOG9FSygNMsNfgdmxsr-HyvyqaYr=UXE2UC_mxKJQA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] usb: dwc3: exynos: Switch from CONFIG_PM_SLEEP
 guards to pm_sleep_ptr()
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Johan Hovold <johan@kernel.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Thinh,

On Tue, 9 Apr 2024 at 07:24, Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:
>
> On Thu, Apr 04, 2024, Anand Moon wrote:
> > Use the new PM macros for the suspend and resume functions to be
> > automatically dropped by the compiler when CONFIG_PM_SLEEP are disabled,
> > without having to use #ifdef guards. If CONFIG_PM_SLEEP unused,
> > they will simply be discarded by the compiler.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > v2: add __maybe_unused to suspend/resume functions in case CONFIG_PM is
> >    disabled.
>
> The compiler discards the code, yet we still need __maybe_unused?
>
Earlier version had not added this since but I removed the
guard.CONFIG_PM_SLEEP.
added __maybe_unused just to safeguard the function.

I have tried to build with config by disabling CONFIG_PM and CONFIG_PM_SLEEP
but could get the warning compilation by adding flag W=1
-Werror=unused-function.

diff --git a/arch/arm/configs/exynos_defconfig
b/arch/arm/configs/exynos_defconfig
index 7ad48fdda1da..43110e42076e 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -29,8 +29,19 @@ CONFIG_ARM_EXYNOS_CPUIDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_KERNEL_MODE_NEON=y
-CONFIG_PM_DEBUG=y
-CONFIG_PM_ADVANCED_DEBUG=y
+CONFIG_PM_SLEEP=n
+CONFIG_PM_SLEEP_SMP=n
+# CONFIG_PM_AUTOSLEEP is not set
+# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
+# CONFIG_PM_WAKELOCKS is not set
+CONFIG_PM=n
+CONFIG_PM_DEBUG=n
+CONFIG_PM_ADVANCED_DEBUG=n
+# CONFIG_PM_TEST_SUSPEND is not set
+# CONFIG_PM_SLEEP_DEBUG=n
+#
+CONFIG_PM_DEBUG=n
+CONFIG_PM_ADVANCED_DEBUG=n
 CONFIG_ENERGY_MODEL=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_MODULES=y

But since these CONFIG_PM and CONFIG_PM_SLEEP cannot be disabled,
I am not getting any warning related to these functions.

Do you want me to remove __maybe_unused ?

alarm@archl-xu4b:~/linux-exynos-5.y-devel$ ./buildkernelexynos-arch.sh
arch/arm/configs/exynos_defconfig:43:warning: override: reassigning to
symbol PM_DEBUG
arch/arm/configs/exynos_defconfig:44:warning: override: reassigning to
symbol PM_ADVANCED_DEBUG
#
# configuration written to .config
#
  SYNC    include/config/auto.conf
  CALL    scripts/checksyscalls.sh
  CC      arch/arm/mach-exynos/pm.o

> BR,
> Thinh
>

Thanks
-Anand

