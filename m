Return-Path: <linux-kernel+bounces-136759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BA989D7E3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A8A2287B3C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FA212FB0B;
	Tue,  9 Apr 2024 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DJtQA9IW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316A512EBCF
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712662234; cv=none; b=M3pRinGe6ozaqnukbNgc4QuXCw3JtIRvT+cizDLW20goh/oevOPRc2hWzlichPRNZtmxg2CKNwOxBbB/2lZyd5cZ9wuMvkUkKS7Mh2A0QeuvtmQYPtAQD2Ka/F6rcuDon3h9n1hEQsi47RJ3+U0+LeyN9cD8edPW/uG0e62aC7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712662234; c=relaxed/simple;
	bh=HYQcRDjwuubK7Sq3dwYtItnV9wch/fOBnHCCGhl7Y4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0odMV/mZrRmhvUI5JCTPYThAPcxs28socL74PRfldWqUc7k3uuLOLEjx5GshJ6if9sijIQPVng3gRQ5DcvzgvmTqCO0mPfOoRdZceaGuERTpFvBZV7EUmVFRQydUWp+GJd2It1JnANhW6L81bkorxZmdAUAQLoQnxruk7pp1xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DJtQA9IW; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712662234; x=1744198234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HYQcRDjwuubK7Sq3dwYtItnV9wch/fOBnHCCGhl7Y4M=;
  b=DJtQA9IWII7AUH6/CaIGR0Ue4fftS6SbzntSzrHa28ReuWYfWnm0Uphs
   +cgTI/8Gwp4P4pBL2fr8WXJrTMYLfpxDax39F0f6Ng5xcEG5OACCYw/FK
   irceD0/88hTB0P4E6ZZWo6shVt/vTYPhWAGdjHqSGXJV4KBWYb5yU7jBC
   6XtvhyvJN37K/JpnbWQr7jJXj0E02DiMgWRNGffI93DHclPgSnTAV1sLj
   /bNOlF6pfL1Nhnr+ITLqT53W01+OSSPirhlMJgqa6u3j22qFW2B4aJAaQ
   l39ZCUKgBus/EVhEQAmAiJqyfm4Fkf4DLcDl9nuPzQl+uPmP7qv+LHXA1
   A==;
X-CSE-ConnectionGUID: y6d78V13TV29DUUaucehSA==
X-CSE-MsgGUID: 5q6VDxF9QKK8R9UYoSrKnQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="30460434"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="30460434"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 04:30:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="937093345"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="937093345"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2024 04:30:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 24CB6F69; Tue,  9 Apr 2024 14:30:18 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe  <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Tao Liu <ltao@redhat.com>
Subject: [PATCHv10 13/18] x86/acpi: Rename fields in acpi_madt_multiproc_wakeup structure
Date: Tue,  9 Apr 2024 14:30:05 +0300
Message-ID: <20240409113010.465412-14-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for the addition of support for MADT wakeup structure version
1, it is necessary to provide more appropriate names for the fields in
the structure.

The field 'mailbox_version' renamed as 'version'. This field signifies
the version of the structure and the related protocols, rather than the
version of the mailbox. This field has not been utilized in the code
thus far.

The field 'base_address' renamed as 'mailbox_address' to clarify the
kind of address it represents. In version 1, the structure includes the
reset vector address. Clear and distinct naming helps to prevent any
confusion.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tao Liu <ltao@redhat.com>
---
 arch/x86/kernel/acpi/madt_wakeup.c | 2 +-
 include/acpi/actbl2.h              | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index d222be8d7a07..004801b9b151 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -75,7 +75,7 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 
 	acpi_table_print_madt_entry(&header->common);
 
-	acpi_mp_wake_mailbox_paddr = mp_wake->base_address;
+	acpi_mp_wake_mailbox_paddr = mp_wake->mailbox_address;
 
 	cpu_hotplug_disable_offlining();
 
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 9775384d61c6..e1a395af7591 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1117,9 +1117,9 @@ struct acpi_madt_generic_translator {
 
 struct acpi_madt_multiproc_wakeup {
 	struct acpi_subtable_header header;
-	u16 mailbox_version;
+	u16 version;
 	u32 reserved;		/* reserved - must be zero */
-	u64 base_address;
+	u64 mailbox_address;
 };
 
 #define ACPI_MULTIPROC_WAKEUP_MB_OS_SIZE        2032
-- 
2.43.0


