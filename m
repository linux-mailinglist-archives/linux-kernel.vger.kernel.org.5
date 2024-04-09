Return-Path: <linux-kernel+bounces-136766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB89689D7EB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 185111C242BF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6636130E3B;
	Tue,  9 Apr 2024 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kS7yQxWx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B50B12FB23
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 11:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712662239; cv=none; b=aPMkvp1ivomGsvYOvRfjnxrj87avkNnZW7JDQO+89F4ULAczRb+k7p87ggMpY/fhg8Ils6Tlm0XdY9FGzRwG2GTybT6dMjbr7boIpKhEu52xSF7dBr6lLuL5b87mPdI3Sx65UVnzzdDD2xK0hajFUS2B2PvWJSX7+Ckqp5/RzMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712662239; c=relaxed/simple;
	bh=ooehCP2CqaQsm8Y5n6o6IXL6w/UgTt+BI7m7NlJA8lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uvLBTX00YbIjHhRSYL+LjYsZDyIKst2DfvhoiN9ABv9wVxEvJR7aCD/nb3FCtVEkEPxPxPx3WJHyW13wYouMu9eoxpzweiUcyGNdHSZCh5L68NrP/daTfF8By+UQL5TB3c/LHrtTqz8ljelVAp6BKnESj4pioCThmnB96XlM8lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kS7yQxWx; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712662237; x=1744198237;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ooehCP2CqaQsm8Y5n6o6IXL6w/UgTt+BI7m7NlJA8lI=;
  b=kS7yQxWxSEj64z02mZ+uKoWYlb1CEc9/FXxpba8LBjqAI35NfCoKlkJN
   RHcBzF0XQnq2hgE6A+zFPm+yoEqycUXVMvv8F8iKuLFI0ipDsGJBJGcRq
   Ir2rwSXM4Gv3t2M1/bSYhCysn9O0CW+tVcmvTt0UhVvYIbBO8x3Qkj6GK
   Ltqv9F7PU3vnPowAmABdwpqfdY0SctEa5clbd80Nzq4oP884Ts95VH6Ja
   K+xY7R8w9MTE4EF4bM1C2SMG13KmFzmaB7taQrWJwvcnJO957olSZ3Wjs
   qsROTzDVdjUmOfhh+JkwU/lBTiwsiEMg3wkSBFWtW/dbumdDmWmDToKDE
   w==;
X-CSE-ConnectionGUID: OnfBNNSkRTamAn1DEeb2kg==
X-CSE-MsgGUID: wqiTKTSGQYqBC3R/xmskIA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="30460483"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="30460483"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 04:30:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="937093355"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="937093355"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2024 04:30:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 5F96C16F4; Tue,  9 Apr 2024 14:30:18 +0300 (EEST)
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
Subject: [PATCHv10 18/18] ACPI: tables: Print MULTIPROC_WAKEUP when MADT is parsed
Date: Tue,  9 Apr 2024 14:30:10 +0300
Message-ID: <20240409113010.465412-19-kirill.shutemov@linux.intel.com>
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

When MADT is parsed, print MULTIPROC_WAKEUP information:

ACPI: MP Wakeup (version[1], mailbox[0x7fffd000], reset[0x7fffe068])

This debug information will be very helpful during bring up.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
Tested-by: Tao Liu <ltao@redhat.com>
---
 drivers/acpi/tables.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index b976e5fc3fbc..9e1b01c35070 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -198,6 +198,20 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 		}
 		break;
 
+	case ACPI_MADT_TYPE_MULTIPROC_WAKEUP:
+		{
+			struct acpi_madt_multiproc_wakeup *p =
+				(struct acpi_madt_multiproc_wakeup *)header;
+			u64 reset_vector = 0;
+
+			if (p->version >= ACPI_MADT_MP_WAKEUP_VERSION_V1)
+				reset_vector = p->reset_vector;
+
+			pr_debug("MP Wakeup (version[%d], mailbox[%#llx], reset[%#llx])\n",
+				 p->version, p->mailbox_address, reset_vector);
+		}
+		break;
+
 	case ACPI_MADT_TYPE_CORE_PIC:
 		{
 			struct acpi_madt_core_pic *p = (struct acpi_madt_core_pic *)header;
-- 
2.43.0


