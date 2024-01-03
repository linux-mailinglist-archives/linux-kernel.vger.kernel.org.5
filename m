Return-Path: <linux-kernel+bounces-15455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FDA822C3F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEB6C1F24078
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE34818ED0;
	Wed,  3 Jan 2024 11:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1zpEmBDY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P3QjEhPJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D42718EA5;
	Wed,  3 Jan 2024 11:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Jan 2024 11:36:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704281818;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L6PGemwVLGVGWi79MkC0P0/Vl48MOuCzhcbwDpFRZoQ=;
	b=1zpEmBDYdrTlmuXtVC5bHDHnpmuT+y442NSsugTpJ/E/HNzUQM8EZMF2JUF9Z2nykjWf2o
	OhbKGjeishd/xkNe7fCEPIhffyuJp46q5z39iYOAaXSyGs++PQGHNZY414uEcJofWbvM8O
	Zw5/ZklN//tp9+xdPBYN3RV3xgQwGuml+Q3KEk8unYjFn7zz6UtGnO8euF3DfY36eN5yK6
	RDF0wWXxiwJn3VzC8ZbdFjyIeYT7UPOvhBOe3/bD2TvpecIUaSxo+4JkOqQSaaUBDf4Rw7
	xlmocK1N/RaT1kEiyY0H6fXHLhGSby8Lk7VC8qPxMpeFQLZF/wEr6sPgryH1jA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704281818;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L6PGemwVLGVGWi79MkC0P0/Vl48MOuCzhcbwDpFRZoQ=;
	b=P3QjEhPJcUi0jmydebALWqmVH8fxDAn25WRMbKc+uE4QcEXSo/fFscWubxDxI6Xz3FRB58
	eWjxPDf3j4ndUQBQ==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: ras/core] Documentation: RAS: Add index and address translation section
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231218190406.27479-4-yazen.ghannam@amd.com>
References: <20231218190406.27479-4-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170428181719.398.2710931428449495987.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     d48d30d8c358004c7b1cb2e16969a569d45953b3
Gitweb:        https://git.kernel.org/tip/d48d30d8c358004c7b1cb2e16969a569d45953b3
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Mon, 18 Dec 2023 13:04:06 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 03 Jan 2024 12:29:42 +01:00

Documentation: RAS: Add index and address translation section

There are a lot of RAS topic to document, and there are a lot of details
for each topic.

Prep for this by adding an index for the RAS directory. This will
provide a top-level document and table of contents. It also provides the
option to build the RAS directory individually using "make SPHINXDIRS=".

Start a section on address translation. This will be expanded with
details for future translation methods and how they're used in the
kernel.

Move the error decoding topic to its own section. Links to other error
decoding kernel docs will be added.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231218190406.27479-4-yazen.ghannam@amd.com
---
 Documentation/RAS/address-translation.rst | 24 ++++++++++++++++++++-
 Documentation/RAS/error-decoding.rst      | 21 ++++++++++++++++++-
 Documentation/RAS/index.rst               | 14 ++++++++++++-
 Documentation/RAS/ras.rst                 | 26 +----------------------
 Documentation/index.rst                   |  2 +-
 MAINTAINERS                               |  1 +-
 6 files changed, 61 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/RAS/address-translation.rst
 create mode 100644 Documentation/RAS/error-decoding.rst
 create mode 100644 Documentation/RAS/index.rst
 delete mode 100644 Documentation/RAS/ras.rst

diff --git a/Documentation/RAS/address-translation.rst b/Documentation/RAS/address-translation.rst
new file mode 100644
index 0000000..f0ca17b
--- /dev/null
+++ b/Documentation/RAS/address-translation.rst
@@ -0,0 +1,24 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Address translation
+===================
+
+x86 AMD
+-------
+
+Zen-based AMD systems include a Data Fabric that manages the layout of
+physical memory. Devices attached to the Fabric, like memory controllers,
+I/O, etc., may not have a complete view of the system physical memory map.
+These devices may provide a "normalized", i.e. device physical, address
+when reporting memory errors. Normalized addresses must be translated to
+a system physical address for the kernel to action on the memory.
+
+AMD Address Translation Library (CONFIG_AMD_ATL) provides translation for
+this case.
+
+Glossary of acronyms used in address translation for Zen-based systems
+
+* CCM               = Cache Coherent Moderator
+* COD               = Cluster-on-Die
+* COH_ST            = Coherent Station
+* DF                = Data Fabric
diff --git a/Documentation/RAS/error-decoding.rst b/Documentation/RAS/error-decoding.rst
new file mode 100644
index 0000000..26a72f3
--- /dev/null
+++ b/Documentation/RAS/error-decoding.rst
@@ -0,0 +1,21 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Error decoding
+==============
+
+x86
+---
+
+Error decoding on AMD systems should be done using the rasdaemon tool:
+https://github.com/mchehab/rasdaemon/
+
+While the daemon is running, it would automatically log and decode
+errors. If not, one can still decode such errors by supplying the
+hardware information from the error::
+
+        $ rasdaemon -p --status <STATUS> --ipid <IPID> --smca
+
+Also, the user can pass particular family and model to decode the error
+string::
+
+        $ rasdaemon -p --status <STATUS> --ipid <IPID> --smca --family <CPU Family> --model <CPU Model> --bank <BANK_NUM>
diff --git a/Documentation/RAS/index.rst b/Documentation/RAS/index.rst
new file mode 100644
index 0000000..2794c18
--- /dev/null
+++ b/Documentation/RAS/index.rst
@@ -0,0 +1,14 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================================================
+Reliability, Availability and Serviceability (RAS) features
+===========================================================
+
+This documents different aspects of the RAS functionality present in the
+kernel.
+
+.. toctree::
+   :maxdepth: 2
+
+   error-decoding
+   address-translation
diff --git a/Documentation/RAS/ras.rst b/Documentation/RAS/ras.rst
deleted file mode 100644
index 2556b39..0000000
--- a/Documentation/RAS/ras.rst
+++ /dev/null
@@ -1,26 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-Reliability, Availability and Serviceability features
-=====================================================
-
-This documents different aspects of the RAS functionality present in the
-kernel.
-
-Error decoding
----------------
-
-* x86
-
-Error decoding on AMD systems should be done using the rasdaemon tool:
-https://github.com/mchehab/rasdaemon/
-
-While the daemon is running, it would automatically log and decode
-errors. If not, one can still decode such errors by supplying the
-hardware information from the error::
-
-        $ rasdaemon -p --status <STATUS> --ipid <IPID> --smca
-
-Also, the user can pass particular family and model to decode the error
-string::
-
-        $ rasdaemon -p --status <STATUS> --ipid <IPID> --smca --family <CPU Family> --model <CPU Model> --bank <BANK_NUM>
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 36e6178..07f2aa0 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -113,7 +113,7 @@ to ReStructured Text format, or are simply too old.
    :maxdepth: 1
 
    staging/index
-   RAS/ras
+   RAS/index
 
 
 Translations
diff --git a/MAINTAINERS b/MAINTAINERS
index 87a5a61..39ecc16 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18170,6 +18170,7 @@ M:	Tony Luck <tony.luck@intel.com>
 M:	Borislav Petkov <bp@alien8.de>
 L:	linux-edac@vger.kernel.org
 S:	Maintained
+F:	Documentation/RAS/
 F:	Documentation/admin-guide/ras.rst
 F:	drivers/ras/
 F:	include/linux/ras.h

