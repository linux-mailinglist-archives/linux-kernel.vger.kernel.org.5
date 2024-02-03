Return-Path: <linux-kernel+bounces-51030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4AC848538
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 11:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0349B2CFBC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 10:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368EA5D8FC;
	Sat,  3 Feb 2024 10:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vCb/lVju";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5peQ+UkP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A8D5D737;
	Sat,  3 Feb 2024 10:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706957442; cv=none; b=IxihiU3ys4j48Z+ZlVIcH+DADDYh11oGGSZSndu04DXuINeeKQAUMStG527scbYgBI2WvDPOVYaVOhBNprJHe0wmO4wP5B9LlgXor58/erqAQwcejpXTkqizRx9OCncJo1GiGSXyBoEwZj1xULGLdofvDj/ofCc4Mxc42kIMRXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706957442; c=relaxed/simple;
	bh=aWCOzQqgOFKDUQJx68iHdcEhe6YBP2AarwHisn+qFuE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OiO9XDVHY8E5UmoDMYxRMLLkXbJcWEbLu9MTQqbAiA0Znhq9f6E6C8agQZ9QRN6EPemgU5Xv8I6V30q7WvKcP9CqQ4O0IsRmf/DSjPB3UtuFVbbp10N9BBLs6lr0skiAPoW2LkjVR/W2FAaZdCvCe+kOOs7QZFwQGnUYGl6wGqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vCb/lVju; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5peQ+UkP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 03 Feb 2024 10:50:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706957436;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XthI37Rn5AE+IkZ15bLGzPARq8tp0utJz+1j7r9ZG7k=;
	b=vCb/lVju2329REks/bzPD+PEdJtoCHnatYBM/Qt8Ln4Nq+JlP14jcJDLD5PtPHEo9i/Ter
	5iUrDB4jBc5An/nElbjSuHOXxCZQjRtSM8QhaY+NNkAVnVmdMfjo60nHdPoyk5VMqp0Bl5
	7IoXuq9QLUwsWx2IhPgLjq0DiEoEtYx5OsW1HbPxYxeZMewcXAyzc2R55WrafTXKwIuwOF
	HASHuYf8IuT3Xrtw3ViB3RgQRvfqgm7zELN8gtPxVmmiUfWGq5djpgEBkNEEXnqoFwpo3C
	E7qEN+ym87/maP+7Gkmm+HZ/MNYhXAiRNbDoQWGyak4J8lBPTAQUaxNPCB+n2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706957436;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XthI37Rn5AE+IkZ15bLGzPARq8tp0utJz+1j7r9ZG7k=;
	b=5peQ+UkPcqlyidnMjjWZNr40AIqnGDC/0aP6V6kTMKdYxHSJ5urI8s8mGY9kKgPcRbmakX
	IQnoWerMCghMzVBg==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] crypto: ccp: Make snp_range_list static
Cc: kernel test robot <lkp@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <202402031410.GTE3PJ1Y-lkp@intel.com>
References: <202402031410.GTE3PJ1Y-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170695743567.398.10498615272513461095.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     f9e6f00d93d34f60f90b42c24e80194b11a72bb2
Gitweb:        https://git.kernel.org/tip/f9e6f00d93d34f60f90b42c24e80194b11a72bb2
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Sat, 03 Feb 2024 11:40:48 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 03 Feb 2024 11:41:41 +01:00

crypto: ccp: Make snp_range_list static

Fix:

  drivers/crypto/ccp/sev-dev.c:93:28: sparse: sparse: symbol 'snp_range_list' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402031410.GTE3PJ1Y-lkp@intel.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/202402031410.GTE3PJ1Y-lkp@intel.com
---
 drivers/crypto/ccp/sev-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index f1a5795..182427f 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -107,7 +107,7 @@ static void *sev_init_ex_buffer;
  *   Array containing range of pages that firmware transitions to HV-fixed
  *   page state.
  */
-struct sev_data_range_list *snp_range_list;
+static struct sev_data_range_list *snp_range_list;
 
 static inline bool sev_version_greater_or_equal(u8 maj, u8 min)
 {

