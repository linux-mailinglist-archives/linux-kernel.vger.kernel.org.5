Return-Path: <linux-kernel+bounces-13996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 724EE82169F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 04:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8762B1C20F53
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 03:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72873ED2;
	Tue,  2 Jan 2024 03:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcuOUXZr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4893FEC0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 03:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3367f8f8cb0so9240360f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 19:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704166178; x=1704770978; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aAPnRDupHYO8J0cnhYoWNgnAK1njZUIZXNIt1cHMVR8=;
        b=BcuOUXZrCY/jGz5Xt9z0olxJLeCU13Iq50pLb/thIVu7gGlCy7+fzDnh0Zz+vT0n+S
         Ewh8Bh16PJnUjQc9zCct8jloQ/Ks/ZaoYXizl6FZ5W2qkPnJfdAG3B801z9GBMf+fzX3
         fNSz32SZb7G/szckBwO+/n6nJ/s20COIi53UMor1nIohvgzqLtGwY3maCU56aqxWoz01
         C1T78nlsiPk35MqIGPxcLeYARYTq5j7WWvlbecBDOPpQqTS/cFdppn3AMb9taQ5euSux
         1QNhbiyeo/CnwWwXhYPlrDumqiq4AUCXnLzqEJ75J/9Qmk0pKfoJBOjlOnpML6II2ip/
         /7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704166178; x=1704770978;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aAPnRDupHYO8J0cnhYoWNgnAK1njZUIZXNIt1cHMVR8=;
        b=weEsJi1wJhds8VJboLZmWzrZyHIFZbT72v5IAQqBk9W/04ufwZswL77hqQG6JoxNOK
         hb3CNCvovykS80l2shcKbHT1m83zgytnocXAhU3mB2tkDjU0t45Dlye7KgoHgg98sFYR
         zeDGwSOWaiA9jbxaLvmA9Eol9bLTJWx5vQtRgpSU7Xu2F24diC7REVyXUF2An2+7+qhA
         UxtswutbdEKsYJfvNmuwNGnSd/NCuvsGt/0VyiH9jCVtDm7bq8dU0ulhbz/Aac+P6bqD
         zg2GeECYYsjhugUbEway/N5tJdNIka/P9A1GHk1zq1+ze8ZJ2VFp6CtZaWOygisK9RP7
         fPaw==
X-Gm-Message-State: AOJu0YzXqx1QgeKQLgVCrKWIL04cDP8NMfLWmK2ZBn5RgOXuWC+RilZI
	UBDZUf6quaibG+VpgW5eqC9C4R7TsQ+suIz4JZ8I1RBz1OY=
X-Google-Smtp-Source: AGHT+IGRpxJUvcp1w4bvaKK7+hhEg1wcqnmyBCcSLc2DBIKxuOPZilIjhC9APaDmdcPT+haqLFu3MTmoFVlR61TyGO0=
X-Received: by 2002:a05:6000:1a44:b0:337:39c1:da05 with SMTP id
 t4-20020a0560001a4400b0033739c1da05mr1989222wry.64.1704166178215; Mon, 01 Jan
 2024 19:29:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: richard clark <richard.xnu.clark@gmail.com>
Date: Tue, 2 Jan 2024 11:29:27 +0800
Message-ID: <CAJNi4rO+Dw5qYDtyJVbuo0OqAoXpGq_Qq6xjH9cvMCAUnW+77g@mail.gmail.com>
Subject: undefined reference to `__aarch64_cas4_sync' error on arm64 native build
To: gcc-help@gcc.gnu.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I have a strong power arm64 box, and the linux distro is ubuntu 22.04,
the native gcc version is:

$ gcc --version
gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0
Copyright (C) 2021 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

It will abort the kernel build with the complaint by 'make Image':
ld: Unexpected GOT/PLT entries detected!
ld: Unexpected run-time procedure linkages detected!
ld: ID map text too big or misaligned
ld: drivers/net/nvidia_eth.o: in function `osi_lock_irq_enabled':
osi_hal.c:(.text+0x3cc): undefined reference to `__aarch64_cas4_sync'
...

But the cross-compile with aarch64-linux-gnu-gcc on the x86 box
doesn't show the above error message.
Any comments/suggestions? Thanks very much!

Richard

