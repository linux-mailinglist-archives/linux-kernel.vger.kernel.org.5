Return-Path: <linux-kernel+bounces-2489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 575E0815DD3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 08:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC5C1F221DC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 07:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518021860;
	Sun, 17 Dec 2023 07:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnNBlneH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80FB1849;
	Sun, 17 Dec 2023 07:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d3954833a5so708221b3a.3;
        Sat, 16 Dec 2023 23:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702797188; x=1703401988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/OlZxS28FU6QF9vejcUnauZ8JZX3EgsVBv/YhrCTHE=;
        b=jnNBlneHpqqWJPSoWymN0rKrXKB+pzpqrShY+jqtUempsy6QGMIi9aTv+/4uTiYKFe
         86ctQxfuEAWzjh8Edng0zU3rf2y4v5sXK9rvfTcFe2lcqJRp4/AjnYMc/VSoSM34tkWX
         x8I86I4YTHArmNHb47tppsokX1yDTABuMz2Yytt+lS0/tS1Ej+VkdV/6Pj6sP3RYrYmd
         WiixOd+T6szkB+C9Dnupa80G16eIcOrnxl1plgRyy2lHMpamKYlb5ys12HMIXuIgJujn
         Fjjd4SJxzFVWsoAszh2zVVGZiKe0wLjNvNyA8bPqsQgitxNFu37fS2qPrZjN1XsG3Ain
         834Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702797188; x=1703401988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K/OlZxS28FU6QF9vejcUnauZ8JZX3EgsVBv/YhrCTHE=;
        b=kn/sT2BOdCog31BNjkz7K+B3OWwC1iyJyAmPHU4XX2VDJmQ095itbset5f0jC+aJ9L
         84FW4zNIXgliaLn7TShYFRqSeSa+zQdLrUX15hyceMIGK2Ofb2tORl+iy3o5ClfJdkL8
         t+cpZoHHW23h3jqX8gjT4IXF/VyAPygZ1tcfAje+KdN6JRyz/tcDyKdNDBWL7UhsqeRa
         sp97aQ9rO7rEvPjkhfJ5VrH0nz3G1s5aovtUvWN2SfbgVKeGlCw0526Bqz3lINE9Zmdc
         XOBekkd6JQWtoQ5eBUxmIQaM5/VuA8TxWWJJsx5OyjLQQ0e+slCRnH6kSc/2onRshtEf
         6Uww==
X-Gm-Message-State: AOJu0YyrbyngEG8tcGi8cDYQcsgD2IGMgenGLlFjl+0GEBUld9uG/J57
	Fu4K/jP3mi8XafGrX+xlNTk=
X-Google-Smtp-Source: AGHT+IFxMlvYSWZWat8Aq90wEuzfdSDwGMZhSaejtN9wktxc+poxuchy1Y0xvv1GYQfiOPXgcK+Pjw==
X-Received: by 2002:a05:6a00:b90:b0:6d0:a1e7:eb14 with SMTP id g16-20020a056a000b9000b006d0a1e7eb14mr12941321pfj.54.1702797188353;
        Sat, 16 Dec 2023 23:13:08 -0800 (PST)
Received: from XH22050090-L.ad.ts.tri-ad.global ([103.175.111.222])
        by smtp.gmail.com with ESMTPSA id b17-20020a056a000cd100b0068ffb8da107sm15740231pfv.212.2023.12.16.23.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 23:13:07 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Kees Cook <keescook@chromium.org>,
	Petr Mladek <pmladek@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marco Elver <elver@google.com>,
	Brian Cain <bcain@quicinc.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	linux-hexagon@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v3 0/5] bitops: optimize code and add tests
Date: Sun, 17 Dec 2023 16:12:45 +0900
Message-Id: <20231217071250.892867-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221111081316.30373-1-mailhol.vincent@wanadoo.fr>
References: <20221111081316.30373-1-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series make sure that all the bitops operations (namely __ffs(),
ffs(), ffz(), __fls(), fls(), fls64()) correctly fold constant
expressions given that their argument is also a constant expression.

The first two patches optimize m68k architecture, the third and fourth
optimize the hexagon architecture bitops function, the fifth and final
patch adds test to assert that the constant folding occurs and that
the result is accurate.

This is tested on arm, arm64, hexagon, m68k, x86 and x86_64. For other
architectures, I am putting my trust into the kernel test robot to
send a report if ever one of the other architectures still lacks
bitops optimizations.
---

** Changelog **

v2 -> v3:

  - Add patches 1/5 and 2/5 to optimize m68k architecture bitops.
    Thanks to the kernel test robot for reporting!

  - Add patches 3/5 and 4/5 to optimize hexagon architecture bitops.
    Thanks to the kernel test robot for reporting!

  - Patch 5/5: mark test_bitops_const_eval() as __always_inline, this
    done, pass n (the test number) as a parameter. Previously, only
    BITS(10) was tested. Add tests for BITS(0) and BITS(31).

  Link: https://lore.kernel.org/all/20231130102717.1297492-1-mailhol.vincent@wanadoo.fr/

v1 -> v2:

  - Drop the RFC patch. v1 was not ready to be applied on x86 because
    of pending changes in arch/x86/include/asm/bitops.h. This was
    finally fixed by Nick in commit 3dae5c43badf ("x86/asm/bitops: Use
    __builtin_clz{l|ll} to evaluate constant expressions").
    Thanks Nick!

  - Update the commit description.

  - Introduce the test_const_eval() macro to factorize code.

  - No functional change.

  Link: https://lore.kernel.org/all/20221111081316.30373-1-mailhol.vincent@wanadoo.fr/

Vincent Mailhol (5):
  m68k/bitops: force inlining of all bitops functions
  m68k/bitops: use __builtin_{clz,ctzl,ffs} to evaluate constant
    expressions
  hexagon/bitops: force inlining of all bitops functions
  hexagon/bitops: use __builtin_{clz,ctzl,ffs} to evaluate constant
    expressions
  lib: test_bitops: add compile-time optimization/evaluations assertions

 arch/hexagon/include/asm/bitops.h | 37 ++++++++----
 arch/m68k/include/asm/bitops.h    | 99 +++++++++++++++++--------------
 lib/Kconfig.debug                 |  4 ++
 lib/test_bitops.c                 | 32 ++++++++++
 4 files changed, 118 insertions(+), 54 deletions(-)

-- 
2.25.1


