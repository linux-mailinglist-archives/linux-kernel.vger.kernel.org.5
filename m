Return-Path: <linux-kernel+bounces-34636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA4783857B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F021F291C0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724E142A8B;
	Tue, 23 Jan 2024 02:29:07 +0000 (UTC)
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0873129403
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 02:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705976946; cv=none; b=G3vm4g0jYZqWoohaDMYSU+5Gzz4eZENUVdZE3tU5CdptPaTwBXFYXvQN3J7I5sGkNDAWAJF/LMJjNXsCRum5kLF/MWHx24B2tCWgzer3zmL7Et3nmrfCRTzIoGHYwiHR4C895rLutx0i/g0qTzklG1rebVg6PhX1i+jBdhbwOIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705976946; c=relaxed/simple;
	bh=TYytRoBRPO460xz7ymBTlU+vkWrppd7xtwrj5lYa8s8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JdHvPmUoCTK91cYn1rTpEPAqXs7BMxxudObJspUdDUj4aeN1ztj7+r9yoHqawJvoho6ClIhQo0XMmW4AgPSdr8OyfG9iJYymYdWt29NPFmtBtukUx/tuzSnnGuI7nbrM7qY4DiyfWrbeIkJi4kspCXBr5q2k63t9lZIQ/lZqeMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1705976935-1eb14e0c7f272d0001-xx1T2L
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx2.zhaoxin.com with ESMTP id zsstOb7ku2RIE6lw (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 23 Jan 2024 10:28:55 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 23 Jan
 2024 10:28:54 +0800
Received: from localhost.localdomain (10.32.65.162) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 23 Jan
 2024 10:28:52 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<seanjc@google.com>, <kim.phillips@amd.com>,
	<kirill.shutemov@linux.intel.com>, <jmattson@google.com>,
	<babu.moger@amd.com>, <kai.huang@intel.com>, <TonyWWang-oc@zhaoxin.com>,
	<acme@redhat.com>, <aik@amd.com>, <namhyung@kernel.org>
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>,
	<GeorgeXue@zhaoxin.com>
Subject: [PATCH v2 0/3] Add Zhaoxin hardware engine driver support for SHA
Date: Tue, 23 Jan 2024 10:28:49 +0800
X-ASG-Orig-Subj: [PATCH v2 0/3] Add Zhaoxin hardware engine driver support for SHA
Message-ID: <20240123022852.2475-1-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1705976935
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 3585
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.119809
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

Zhaoxin CPUs have implemented the SHA(Secure Hash Algorithm) as its CPU
instructions, including SHA1, SHA256, SHA384 and SHA512, which conform
to the Secure Hash Algorithms specified by FIPS 180-3.

With the help of implementation of SHA in hardware instead of software,
can develop applications with higher performance, more security and more
flexibility.

Below table gives a summary of test using the driver tcrypt with different
crypt algorithm drivers on Zhaoxin KH-40000 platform:
---------------------------------------------------------------------------
tcrypt     driver   16*    64      256     1024    2048    4096    8192
---------------------------------------------------------------------------
           zhaoxin** 442.80 1309.21 3257.53 5221.56 5813.45 6136.39 6264.50***
403:SHA1   generic** 341.44 813.27  1458.98 1818.03 1896.60 1940.71 1939.06
           ratio    1.30   1.61    2.23    2.87    3.07    3.16    3.23
---------------------------------------------------------------------------
           zhaoxin  451.70 1313.65 2958.71 4658.55 5109.16 5359.08 5459.13
404:SHA256 generic  202.62 463.55  845.01  1070.50 1117.51 1144.79 1155.68
           ratio    2.23   2.83    3.50    4.35    4.57    4.68    4.72
---------------------------------------------------------------------------
           zhaoxin  350.90 1406.42 3166.16 5736.39 6627.77 7182.01 7429.18
405:SHA384 generic  161.76 654.88  979.06  1350.56 1423.08 1496.57 1513.12
           ratio    2.17   2.15    3.23    4.25    4.66    4.80    4.91
---------------------------------------------------------------------------
           zhaoxin  334.49 1394.71 3159.93 5728.86 6625.33 7169.23 7407.80
406:SHA512 generic  161.80 653.84  979.42  1351.41 1444.14 1495.35 1518.43
           ratio    2.07   2.13    3.23    4.24    4.59    4.79    4.88
---------------------------------------------------------------------------
*: The length of each data block to be processed by one complete SHA
   sequence, namely one INIT, multi UPDATEs and one FINAL.
**: Crypt algorithm driver used by tcrypt, "zhaoxin" represents zhaoxin-sha
   while "generic" represents the generic software SHA driver.
***: The speed of each crypt algorithm driver processing different length
   of data blocks, unit is Mb/s.

The ratio in the table implies the performance of SHA implemented by
zhaoxin-sha driver is much higher than the ones implemented by the generic
software driver of sha1/sha256/sha384/sha512.

In order to support Zhaoxin-sha driver, make padlock-sha driver matches
the CENTAUR CPUs with Family == 6 and add two Zhaoxin Hash Engine
cpufeatures.

---
v2:
- Make Zhaoxin SHA depends on X86 && !UML
- Update MAINTAINERS for Zhaoxin SHA

Tony W Wang-oc (3):
  crypto: padlock-sha: Matches CPU with Family with 6 explicitly
  x86/cpufeatures: Add CPU feature flags for Zhaoxin Hash Engine
  crypto: Zhaoxin: Hardware Engine Driver for SHA1/256/384/512

 MAINTAINERS                              |   6 +
 arch/x86/include/asm/cpufeatures.h       |   4 +-
 drivers/crypto/Kconfig                   |  16 +
 drivers/crypto/Makefile                  |   1 +
 drivers/crypto/padlock-sha.c             |   2 +-
 drivers/crypto/zhaoxin-sha.c             | 500 +++++++++++++++++++++++
 drivers/crypto/zhaoxin-sha.h             |  17 +
 tools/arch/x86/include/asm/cpufeatures.h |   4 +-
 8 files changed, 547 insertions(+), 3 deletions(-)
 create mode 100644 drivers/crypto/zhaoxin-sha.c
 create mode 100644 drivers/crypto/zhaoxin-sha.h

-- 
2.25.1


