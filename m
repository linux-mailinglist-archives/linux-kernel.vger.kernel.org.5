Return-Path: <linux-kernel+bounces-37001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DE083AA0A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D242897FE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3E077642;
	Wed, 24 Jan 2024 12:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Uvb+SQo1"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07B463115;
	Wed, 24 Jan 2024 12:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706100050; cv=none; b=ArjGISUraA6NR9hLeKTXQj4dcHKJKN0C+Ra5TV/Odf36v8DjVU2fDKspJqfYAStMHD0ZTyY/tB5q425QWVk+WmVAtbHAkGjOILJl7v7VZHTzMkdZURKr6j6ngNZ51lbTz6pu5VZABRLsonwKB224xMNVNK8sqHrG9hVkuGHvIQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706100050; c=relaxed/simple;
	bh=eoeoSFIZ7CKYXQER52tCY7k7U/0rsarKREYpuJQthIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppMz99CYpbuuiw5Ly8r2s0F43mJgPC/eGdzkP8HecB4GUV1KZwSOMg/4jq+m5c0uJOlzh2M2U1aSaVLZOl+PkW/VRMR6MY7zaaASM+e7mIETo/vMZr5eBQPqQ2ojHKnazaB15GLzEwqp7/JY5pS2erHt/pMtoOkXdjNSPorPUh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Uvb+SQo1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 804FF40E0177;
	Wed, 24 Jan 2024 12:40:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dXgm0DEHlj5L; Wed, 24 Jan 2024 12:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706100043; bh=s9j4sEEUupwX7DeTzX1tcjryCab2sKE+Ss019hEuHDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uvb+SQo1cSLGsY4ET4IMBGtDeCe/MsvHTdnTZ356bg4qKC86czHs9rlArerOYLh9G
	 NVLolhAPjMwSVYD9A5P8XSVMfAk6Sr6mmoJ6oAHmJWl6aBFmiEN+rxK9aWAugQce/z
	 Z4McpmMe5Md8lWnAmpDc+WDAoGAM5XaOI3+G2mFbcomDRiqxWVocqG/TeYz2ZpSy+p
	 o/wyoJz08fJqfmeMw/xvxY0uhaN4+jaDHukA6aYzf5F1YEPT7M8VoWWumL4EaqiD67
	 P/HGjlRKk0h1++7duTlkNq3Hm0TVfsa6uLe1reUB2QXMLf7KlaQ/0BdLn/60fQUcYh
	 zv4cTvdmU2KetYqiIVSKW4ve7VtJdKTXEu/8WWysRVqbYaXt8+XkVk4SHzC/euuhuO
	 iXZZqZ76+HiILCAjh3j91fIM1/fGq3lVz9OQKloEnCZ47Za/BbMBUtVSAeVy7OnEuV
	 0iCaOW6E7FyVW1R5j0qixLspzmy6KqUK2Btu79Eekr2JJLmEXS26ozJudObE3n1ZdJ
	 WNDF1/tHEykF1U14Eb5NobiM1i7Ugf5QcOnceM+4j7oNX/el80SBA3F2Hm4C8mqRqT
	 UK44g2oeyvuWg5vWQP0yRXZB5RfR32xlF1rIR2ZArya0fgjsJNUHqMtwmZ5xvk638c
	 +oNaK7QAQYxeAUj40fat9+vo=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 561C040E00C5;
	Wed, 24 Jan 2024 12:40:35 +0000 (UTC)
Date: Wed, 24 Jan 2024 13:40:30 +0100
From: Borislav Petkov <bp@alien8.de>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Tony Luck <tony.luck@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
	Muralidhara M K <muralimk@amd.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muralidhara M K <muralidhara.mk@amd.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: Begin a RAS section
Message-ID: <20240124124030.GDZbEFPo4APcggdE33@fat_crate.local>
References: <20231102114225.2006878-1-muralimk@amd.com>
 <20231102114225.2006878-2-muralimk@amd.com>
 <20231128142049.GTZWX3QQTSaQk/+u53@fat_crate.local>
 <87a5pes8jy.fsf@meer.lwn.net>
 <20240109183646.GAZZ2SPiMZv83J3f0a@fat_crate.local>
 <87wmsiqok6.fsf@meer.lwn.net>
 <20240109200434.GBZZ2m0vWjm9v795YX@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240109200434.GBZZ2m0vWjm9v795YX@fat_crate.local>

On Tue, Jan 09, 2024 at 09:04:34PM +0100, Borislav Petkov wrote:
> So I'm fine with admin-guide too - just pointing out a potential issue
> I see.

Ok, how does that look like?

I've merged it with ras.rst which we had there already and with some
more new documentation that is coming from:

https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git/log/?h=edac-amd-atl

Thx.

---
From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Wed, 24 Jan 2024 13:37:52 +0100
Subject: [PATCH] Documentation: Move RAS section to admin-guide

This is where this stuff should be.

Requested-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 Documentation/RAS/index.rst                        | 14 --------------
 .../{ => admin-guide}/RAS/address-translation.rst  |  0
 .../{ => admin-guide}/RAS/error-decoding.rst       |  0
 Documentation/admin-guide/RAS/index.rst            |  7 +++++++
 .../admin-guide/{ras.rst => RAS/main.rst}          | 10 +++++++---
 Documentation/admin-guide/index.rst                |  2 +-
 Documentation/index.rst                            |  1 -
 7 files changed, 15 insertions(+), 19 deletions(-)
 delete mode 100644 Documentation/RAS/index.rst
 rename Documentation/{ => admin-guide}/RAS/address-translation.rst (100%)
 rename Documentation/{ => admin-guide}/RAS/error-decoding.rst (100%)
 create mode 100644 Documentation/admin-guide/RAS/index.rst
 rename Documentation/admin-guide/{ras.rst => RAS/main.rst} (99%)

diff --git a/Documentation/RAS/index.rst b/Documentation/RAS/index.rst
deleted file mode 100644
index 2794c1816e90..000000000000
--- a/Documentation/RAS/index.rst
+++ /dev/null
@@ -1,14 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-===========================================================
-Reliability, Availability and Serviceability (RAS) features
-===========================================================
-
-This documents different aspects of the RAS functionality present in the
-kernel.
-
-.. toctree::
-   :maxdepth: 2
-
-   error-decoding
-   address-translation
diff --git a/Documentation/RAS/address-translation.rst b/Documentation/admin-guide/RAS/address-translation.rst
similarity index 100%
rename from Documentation/RAS/address-translation.rst
rename to Documentation/admin-guide/RAS/address-translation.rst
diff --git a/Documentation/RAS/error-decoding.rst b/Documentation/admin-guide/RAS/error-decoding.rst
similarity index 100%
rename from Documentation/RAS/error-decoding.rst
rename to Documentation/admin-guide/RAS/error-decoding.rst
diff --git a/Documentation/admin-guide/RAS/index.rst b/Documentation/admin-guide/RAS/index.rst
new file mode 100644
index 000000000000..f4087040a7c0
--- /dev/null
+++ b/Documentation/admin-guide/RAS/index.rst
@@ -0,0 +1,7 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. toctree::
+   :maxdepth: 2
+
+   main
+   error-decoding
+   address-translation
diff --git a/Documentation/admin-guide/ras.rst b/Documentation/admin-guide/RAS/main.rst
similarity index 99%
rename from Documentation/admin-guide/ras.rst
rename to Documentation/admin-guide/RAS/main.rst
index 8e03751d126d..7ac1d4ccc509 100644
--- a/Documentation/admin-guide/ras.rst
+++ b/Documentation/admin-guide/RAS/main.rst
@@ -1,8 +1,12 @@
+.. SPDX-License-Identifier: GPL-2.0
 .. include:: <isonum.txt>
 
-============================================
-Reliability, Availability and Serviceability
-============================================
+==================================================
+Reliability, Availability and Serviceability (RAS)
+==================================================
+
+This documents different aspects of the RAS functionality present in the
+kernel.
 
 RAS concepts
 ************
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index fb40a1f6f79e..dfc06fab9432 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -122,7 +122,7 @@ configure specific aspects of kernel behavior to your liking.
    pmf
    pnp
    rapidio
-   ras
+   RAS/index
    rtc
    serial-console
    svga
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 07f2aa07f0fa..9dfdc826618c 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -113,7 +113,6 @@ to ReStructured Text format, or are simply too old.
    :maxdepth: 1
 
    staging/index
-   RAS/index
 
 
 Translations
-- 
2.43.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

