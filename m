Return-Path: <linux-kernel+bounces-58736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B541784EACC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E46CB27796
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014824F21E;
	Thu,  8 Feb 2024 21:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZX63bl3"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBA74F1EB
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 21:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707428718; cv=none; b=eKPuGGBK1ez7IfTQR5pcfVEorNh/fVMLdYdHSPFUUolBW8WanlhRqeZz50w9qGL9rwFXW9+s4RH+kUfTV41wTdfgoduuZSMQUNtoMqJXPVwExFEDsTK8wMDDsl6e2XsgGJJYIj06ILZbVMe5vLqSXb8cyvzgZ/1hizgc2B44GP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707428718; c=relaxed/simple;
	bh=Zsg3OhFHOjZClNrv0wJ/6M8UkH0ZEjz2XLVeVSR2fks=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fCTfCrd9cVbUA9yWIcOkzwHqndOjHsaeewxKKRcwgPKw3KBZ53gELapNN2CXnEwa0/noXybzdW3ldAfVJZQCMp9jOhhvBz7RDIBETi/hUkyT3mWaBN71+aFLesZfZ1i/KLKJ+GnTuoFA8fplhiUk6hXgP2jqlIiKAjDv3pXk8T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZX63bl3; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e0518c83c6so213184b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 13:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707428716; x=1708033516; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=r12B6iMDcbLF268BqC/QcI4CqA5RhxZKMKRxOEIxFcw=;
        b=TZX63bl3WE7yasqkTZlhXWcvwxQhRAihjRv8SdKuoZbUsLU41+ZQ+vbe5eVrsNRaWf
         74OMAkXhjOH9WgaqKC8i1pEGccw3s5G9rwiQwqpv6fgc0rejTxd9OfoApuEVzrKJAnM9
         TCqtWkgaNTFXKYBkoLFGCmtENE7XTn9XUTLUGtUMp0tZEE6PPVZRzZ6TkmikFH2G/4LQ
         i1vH60iw/qQpf/O8E27mwQ4TOTTrD1CqU46SjAoSuQmbRWZX7x9jbIprLDE1WBjhnDmL
         iu7m2n8LTm3/E8zP2XKBHSV3F11l7kBWdHKiGcOwo8yASP5sxAWwfszb/+D7ZcUxf1k7
         wUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707428716; x=1708033516;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r12B6iMDcbLF268BqC/QcI4CqA5RhxZKMKRxOEIxFcw=;
        b=SH5xoLhMHZ5kGndU08EcfwYer0+uM6IwQhxInTKRUtwQuu8jgFwgprEQy8gDxDsBmD
         rRGLqPiGlgTm301gzIchopmMvIBRK5kywOtdwl0QovI/uK6wilanPiGPckS8y7HJ1BnM
         Ku42csw3uq3W8ox/9DI9EzRvZvJn5kSWrZ/bYOmCeUu2YLVam8hFerfFH0B5Fprxmmjx
         9zn+0UeOu06/jLvHRpoZICsIGYPcsVMZvwCj9dAGbPYjdfUTAY0eX4h35z9wtMZjsaZT
         0Di11HdWdWmmZdUa4Qw26cdikiLQP/doEKxpLnorsxgR6i9xS2rDvZsvBgydM/01jrPh
         f9CA==
X-Gm-Message-State: AOJu0YyUBGTPfhnztckUpltI4d80qvQ5lN9KdwdLx5Z3UtAQoBlEcmwS
	WfAAukCZovmI3KEZCOeRrfXtLoh2KQz+aGjci3OKwmE6ibsaT1F/ZeSmtGSx
X-Google-Smtp-Source: AGHT+IGKn+PJBm91hwlkMXMFW73ySOhCGfRxZUEu7NuCxzGb7RnIRkiuMD2YJWr/LNRcoMYOlw9D8w==
X-Received: by 2002:a05:6a00:23c9:b0:6e0:5960:861f with SMTP id g9-20020a056a0023c900b006e05960861fmr616185pfc.17.1707428715890;
        Thu, 08 Feb 2024 13:45:15 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e14-20020a056a0000ce00b006e08202b5c3sm228725pfj.183.2024.02.08.13.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 13:45:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 8 Feb 2024 13:45:13 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Sporadic regmap unit test failure in raw_sync
Message-ID: <dc5e573d-0979-4d7e-ab4a-de18a4711385@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mark,

I have seen the following error with the regmap unit tests:

        KTAP version 1
        # Subtest: raw_sync
        ok 1 flat-little
        ok 2 flat-big
        ok 3 rbtree-little
    # raw_sync: EXPECTATION FAILED at drivers/base/regmap/regmap-kunit.c:1305
    Expected &hw_buf[6] != val, but
        &hw_buf[6] ==
         57  30 
        val ==
         57  30 
        not ok 4 rbtree-big
        ok 5 maple-little
        ok 6 maple-big
    # raw_sync: pass:5 fail:1 skip:0 total:6
    not ok 25 raw_sync

This is with regmap: 'kunit: fix raw noinc write test wrapping'
applied on top of the upstream kernel (v6.8-rc3-47-g047371968ffc).
So far I have seen it only once, with the x86_64:q35 emulation in qemu.

Guenter

