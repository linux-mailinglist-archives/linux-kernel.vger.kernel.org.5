Return-Path: <linux-kernel+bounces-77062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C1B8600BB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D540F1F269C6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC6A15A49C;
	Thu, 22 Feb 2024 18:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXHfdYv+"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB4A158D9C;
	Thu, 22 Feb 2024 18:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625671; cv=none; b=SFp4e7P0HCr8p/Mftevv16lJ8Q/zf89CPl/TN+d8zyCRUn0x5dOuV5ZLrKDRNBydZvDUhAWBXX6eQ5Kwxd6dqbg7JbwrplFe9w2azMswpQ6JxxfD/AiTeI/fEICC5eEHwwG1FR29IOx0d4HQVCes9gJvnsncWQFLKp0KvmQl/uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625671; c=relaxed/simple;
	bh=dfE8/fN+nDw0npX+fEVeYJzEd30RZQVbS+TjqYr8HB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjT79kx7guLWPWoMecFam7Bf8SqVJQD3hzNj5xMBdNiTcbwT7FlqMpTU/l1CMEOWtd+ShoPvh3qfqtP//r4Q8dMPs6fxWpaR3PYqOHLpJt1x/9ot1P2/UU4RqVcu91oS+kTti8eBPTd/JvDO4hXLZFPJLDL1dxV/q5rAyQbJfIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXHfdYv+; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d23d301452so1068901fa.1;
        Thu, 22 Feb 2024 10:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708625668; x=1709230468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3HjL25KMxGa56gkLYon0vOuoqvhZeVF+dp0oSQkrO0=;
        b=hXHfdYv+aJkVGblsQVERsYlh/Y12RJh5lSo8xtTFKqaryDvmoREn1ZPtGZzFYaBQOA
         aeEmQI21vC1tm1tVBji9ISbRGGwibj9mFGld1pniffv1dWZBCj1GFoOz6Up8QAUURlbq
         p8scr1jq/hQWsE7DAXmmsXssjhV157/45NWfH1fzbxusk/XaRe+EmkwKlxzajAnxFezW
         LM+/VHPK2GmkeDl6v2Cm/3F/9popi+h15Oeh1aeJp/pE+sJqs8sh4oNHPG9NV63ejMpf
         URQeMqRbx5qUNUJ5LiSpvFZtNkqiw3xxr9yX+qnpRnfnv5IiyhMOVwDFXxeOhhObuyOy
         MvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708625668; x=1709230468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3HjL25KMxGa56gkLYon0vOuoqvhZeVF+dp0oSQkrO0=;
        b=Qtouci7NBvSnMz0446qWUUHdeIQjtKTDnyBjZHcPwJVi8eZ3xewMExjYoCMJZGS1nR
         mgCRLd04PLoCIgZyVE8BaRhmHKYumJeLJ7+t7xa2sGbHLTOpeTcvGGLXSwQKwqP2lE2G
         VWfZ+8yz1qc/a+ax/OJBLyabTnZbQul1b5Sf2YXI+/hTugJpMsv15Yi/ULJBuwVL/JCm
         Y4qJ3Fmrgwglm1VzUXs9Syjz3qptNKalAj6hgFlMIlfELxqqyjiC8oMPFwiTlp4bhOPs
         gVgyZS+d8a+P5vWs/Di1PM3Fu+fs1EX3hv28b6IwCweXBdwfmSIYycKAIYrI8FsScywH
         6/zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwoQf4yeXWbd6Nb1RprZjobO9u0pK2PXp/vf+cY8jo9sJafM7DxzgaOdmtpTVb3jUTL0xCCIrS/HxbtVMQ9RT4tyweH8kBaac/MJCGckvy+9KdWmHdvlTeBlwVqAcyVXo3Bi5i7IdHAQ==
X-Gm-Message-State: AOJu0YxpVV+iqfNWZklhYMc1r6lKxTXg7CK41lCI9pPV8+7x1M+B56z7
	GM/freh/vdYqOCY9XU68/pd8wboSKnT4T0oKlDIeaIZ53wKv0j84
X-Google-Smtp-Source: AGHT+IHxkZX3auLTPAfGj/5QgChR12wrYdWdu9SKHx0EmevS1A3wDKwZARalLbPB/ZrSULuvY5aXew==
X-Received: by 2002:a2e:b169:0:b0:2d2:643b:df06 with SMTP id a9-20020a2eb169000000b002d2643bdf06mr1365251ljm.2.1708625668311;
        Thu, 22 Feb 2024 10:14:28 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id j26-20020a2e801a000000b002d10d093c4csm2381337ljg.111.2024.02.22.10.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 10:14:27 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Manish Narani <manish.narani@xilinx.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Borislav Petkov <bp@suse.de>
Subject: [PATCH v5 04/20] EDAC/synopsys: Drop erroneous ADDRMAP4.addrmap_col_b10 parse
Date: Thu, 22 Feb 2024 21:12:49 +0300
Message-ID: <20240222181324.28242-5-fancer.lancer@gmail.com>
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

Currently the ADDRMAP4.addrmap_col_b10 field gets to be parsed in case of
the LPDDR3 memory and Quarter DQ bus width mode. It's wrong since that
field is marked as unused for that mode in all the available DW uMCTL2
DDRC releases (up to IP-core v3.91a). Most likely the field parsing was
added by mistake as a result of the copy-paste from the Half DQ bus width
mode part of the same function. Even though the field is supposed to be
always set to the UNUSED value (0x1F) drop parsing it anyway so to
simplify the setup_column_address_map() method a tiny bit.

Fixes: 1a81361f75d8 ("EDAC, synopsys: Add Error Injection support for ZynqMP DDR controller")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 7c57c43b4d31..bd6e52db68bc 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -1236,10 +1236,6 @@ static void setup_column_address_map(struct synps_edac_priv *priv, u32 *addrmap)
 				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
 				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
 				 COL_B9_BASE);
-			priv->col_shift[13] = ((addrmap[4] &
-				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
-				((addrmap[4] & COL_MAX_VAL_MASK) +
-				 COL_B10_BASE);
 		} else {
 			priv->col_shift[11] = (((addrmap[3] >> 16) &
 				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
-- 
2.43.0


