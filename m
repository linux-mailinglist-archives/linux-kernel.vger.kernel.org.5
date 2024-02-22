Return-Path: <linux-kernel+bounces-77091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7922860113
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB9971C236BE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D1E137923;
	Thu, 22 Feb 2024 18:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtrrmsRL"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED2812D1F5;
	Thu, 22 Feb 2024 18:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625706; cv=none; b=Y2ir+lLyO0SOQ0cYnTEfAFu7/u3B0UF5AEKVu5P8cKL7/zugKrbOEqojCEnVLvnuk+iJDgKByD+38ZZ0Cq+ENzYymXjyZEYxTXOJPz1QlA7hhVFaied8obPklKbQEvgQKpMMkDReQupfI2kt7PN6VoJx0oS3U7mHNHxyqu9tGDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625706; c=relaxed/simple;
	bh=/YMcS8c2lFHAnLUYHGmV4xYNvSCKSN3WltAWr+gJyKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bAkyPbuRMgUKnlZaUrQ5oIhbLANUynGFhSbuYH6XeCQx1AH+M+UDnRaqN5yfuNz4o65ASwsbfF7G4UFKRNC+MLByWgX0A8+9uki1err4X3VxFHne1ke/K4QltQY05WSkFBCO4SWKgEvZZ9AXxfSTjXZQ5LqTRUI3HIKe6Vet7zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtrrmsRL; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso1188251fa.2;
        Thu, 22 Feb 2024 10:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708625703; x=1709230503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oj2Zk+yOX3iTlO1YnU+dJlP9WROVQ6dXGrz5dId9J7c=;
        b=GtrrmsRLao43J63QdVfoD1f3aUO9euOqv4AFpe+EYLpgIqARVlAeOGuabfJ+h2B2VQ
         OnjFGQpJQhgKXY8NyPki4Gddlwa62fQuV0NunBDH3YHxUCtBX+Wd9Vv78PTqYq6GmZpL
         +r+kntQYnNvMwiyClyfvCEGDu6M7W4Go0OjSj6XmSz0dOAMxm4dlESFVJT24+xC/AScF
         9o6wpDebKhEGESO6sbEDKIOw297CYyGxxZOjIKa26MKAZKAIvu9q8GBeB4Ek0nD6Ga14
         F3UegsletJny6NGC1jzcMpBDdCdqPNI3MFUfai/PFueFaGUBqXke5To/8Kfx/99azYoj
         TkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708625703; x=1709230503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oj2Zk+yOX3iTlO1YnU+dJlP9WROVQ6dXGrz5dId9J7c=;
        b=Bmch7vYCw88fOQjAbu565MD1cA5HpQtIQPs2zOSdDP7mjiwpYq8VvxZUR2EDTGB+Er
         4SWhRAWkC3y5pPvwvo9s8Xq49djNE0ZAn8ksBNNefbfyPs5mAxIafwG6KDFcGnnU0xIE
         ARLX8fWGSpROEvXRm7arofaIDMYvhCvN8xCs/Ex2Qy7gUpJCGF/xJn+/h1I3a5iOZ21x
         PmRPMBoffuiSTvQsL77UpA6BypBzrOYmzAje34bT0ITSMtpfI+scvcUlvAVmSZ7mgyml
         p89oHxT4hhlklKuQ7+fAipSSrFzkGCGGQ3uri5DoLvpX/ji5eDFs5Km/jGAfvHyd/FEd
         u30A==
X-Forwarded-Encrypted: i=1; AJvYcCW4fLVwvy4bbe2di3fMja1LlCdFOWiCQKJ5m7apED6aCWx9WLvTUOOFvMScRN70zkpCzdconBkR3a2G1qKvnRU2+JS2D0B8GW4GClQjRyjRqjLHjqb88nbS18/H/3AIyVZLjyLbruA97A==
X-Gm-Message-State: AOJu0YzhnKCYyrpik4/7Nwr8lfXuKBrS5BebNblgUgx9Dq8wJ7VyoLSG
	Y6uHVK2Y78zUVsTQHZ4hnAtny6U4zRQ82DvQuC99e44ZMCMDqLxjXGTHKPiGRa4=
X-Google-Smtp-Source: AGHT+IFOFkHys1bH4WkLHPGQ3V9fUh1P0YVQPkq70kk/yd9g6H865FEq3BXbnYj7ckxtOrhkoU1gaQ==
X-Received: by 2002:a05:6512:15a7:b0:512:a6cd:b37c with SMTP id bp39-20020a05651215a700b00512a6cdb37cmr11450521lfb.47.1708625681964;
        Thu, 22 Feb 2024 10:14:41 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id x7-20020ac25dc7000000b00512dbd9cf32sm348778lfq.54.2024.02.22.10.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 10:14:41 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 12/20] EDAC/synopsys: Drop redundant info from the error messages
Date: Thu, 22 Feb 2024 21:12:57 +0300
Message-ID: <20240222181324.28242-13-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222181324.28242-1-fancer.lancer@gmail.com>
References: <20240222181324.28242-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the custom error messages are needlessly long so the logged text
gets to be printed in several lines in console. There is some
duplicated/redundant information which can be freely removed from it: drop
the message prefix "DDR ECC error type:%s" since the resultant text
printed to the log by the edac_mc_printk() method will contain the error
type and the memory controller id referring to the device detected the
error anyway; with no harm to readability shorten out the phrase "Bit
Position" to being just "Bit".

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index b0ff831287f5..dfe1abe7c86c 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -478,13 +478,13 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 		pinf = &p->ceinfo;
 		if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type:%s Row %d Col %d Bank %d Bank Group %d Bit Position: %d Data: 0x%08x",
-				 "CE", pinf->row, pinf->col, pinf->bank,
-				 pinf->bankgrp, pinf->bitpos, pinf->data);
+				 "Row %d Col %d Bank %d Bank Group %d Bit %d Data 0x%08x",
+				 pinf->row, pinf->col, pinf->bank, pinf->bankgrp,
+				 pinf->bitpos, pinf->data);
 		} else {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type:%s Row %d Bank %d Col %d Bit Position: %d Data: 0x%08x",
-				 "CE", pinf->row, pinf->bank, pinf->col,
+				 "Row %d Bank %d Col %d Bit: %d Data: 0x%08x",
+				 pinf->row, pinf->bank, pinf->col,
 				 pinf->bitpos, pinf->data);
 		}
 
@@ -497,13 +497,12 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 		pinf = &p->ueinfo;
 		if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type :%s Row %d Col %d Bank %d Bank Group %d",
-				 "UE", pinf->row, pinf->col, pinf->bank,
-				 pinf->bankgrp);
+				 "Row %d Col %d Bank %d Bank Group %d",
+				 pinf->row, pinf->col, pinf->bank, pinf->bankgrp);
 		} else {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
-				 "UE", pinf->row, pinf->bank, pinf->col);
+				 "Row %d Bank %d Col %d",
+				 pinf->row, pinf->bank, pinf->col);
 		}
 
 		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
-- 
2.43.0


