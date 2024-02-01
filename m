Return-Path: <linux-kernel+bounces-48358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE78845ADA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1881C27DF1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CFB5F49C;
	Thu,  1 Feb 2024 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dWi1pMtD"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3909E5F483;
	Thu,  1 Feb 2024 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706799966; cv=none; b=s5YqlRqkk/zuqhNJTBF8u11V7Nc9RHXCCcvPTYRkBxevQYHE2tBvETFszWVO4/cZzIF//cgtvOH5GcLPhXINbmuduz+LmvRj75gv00luKGqBUZ1NOx6hKrY6rARN6uDaE6RPXrR8O+DWj6cvNiD8tD/ZrlGOx0LUZbYWAe5xyOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706799966; c=relaxed/simple;
	bh=S5W6WfzDD24UKk6TKlxKn9NwVUe04q9gxb3Fe1QIr3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGr0jziSRl6g7pzh+HxtJzxrQi5OQQxkABob8Y5vfh3TQTwcXOyEEx+iibQjZz5CTi8HbAHI+AkovfoOQc/GccmeTC68E5cL+Bh+E9scezhaw0TCY8YKGYZSuJH0AFAJjQYYtBz/Dd50GbSnkreqUO8ooH91qSr6dXzMVInQhNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dWi1pMtD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C715440E00C5;
	Thu,  1 Feb 2024 15:05:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SBVyHGM45hjf; Thu,  1 Feb 2024 15:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706799956; bh=1EFnbWTi+D9yOaN/XKFCv+5Q1h6LUOkuPwy5uJuICtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dWi1pMtDmKqrt7jFrg5XBi6ap0pKbmwJrckXp7k6XJF3axu5uV1Q5V3H+X2vF4q7k
	 Dtv1rf+uXCAeuIkRwiuzYV/lYq9vUgfbFpUsPjNxF8gyb9nWJZZZjB2ZfgX9wv+3/G
	 HF11Zg5XRfUkplS6Pm3OzhBcuHNsPuHiF41d7seeZPg986+rJofrvmmKpSxU9mK2ta
	 iUPa6m2kKHhKTKmmToStiNFA3ayS1IakaEBZni9mDS1IEslVYIK2Ub0MprDU44/xL2
	 fjGFltGsrcl7xM6QS+8p2JVb73T7yClAfIyXuKpvqY2JkBqxTv8cLv5O4zd8fhQtjH
	 QsPNATDVc5HBQ/oeE2cCCuRVC/T8g97DoQvrmu1aIBLU0UFGz8m7OJOHB27JBLYNzV
	 2G72ONfhymeFjf8eP51FhacjnI7e1CH00TVQGOnT3yuW02PiMnQPrvohjg9UskBvzQ
	 aYJZY0pI4uQEoD4STw1b0t67c8301t1ArRPqWDHg3cDFEQN2HUqzpjyYYy30k6saze
	 a8EjFjgvch8+tuvIOKmLxobwNOJDgQbGb9C9uJGTXvJXFr6IGdAwYBMO2rI5xVfaYM
	 CUA2cRR29sYKthe+Fupc7XMUbfFq3FalALD49g4+KgDf7rpkcCP6EtN45sB2xG81aB
	 w7XH1lWJtjWVSP2BzAUW8wMo=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A005940E01A2;
	Thu,  1 Feb 2024 15:05:49 +0000 (UTC)
Date: Thu, 1 Feb 2024 16:05:43 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, muralidhara.mk@amd.com
Subject: Re: [PATCH] RAS/AMD/ATL: Add MI300 DRAM to Normalized address
 translation support
Message-ID: <20240201150543.GHZbuzR4_KJHbCTI1H@fat_crate.local>
References: <20240131165732.88297-1-yazen.ghannam@amd.com>
 <20240201092148.GBZbtirOfNAR3SYmht@fat_crate.local>
 <132e22b9-2e42-4d8d-a2ea-14023bd5dae1@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <132e22b9-2e42-4d8d-a2ea-14023bd5dae1@amd.com>

On Thu, Feb 01, 2024 at 09:35:13AM -0500, Yazen Ghannam wrote:
> It's an operation on the bits within a value rather than between two values.
> 
> BTW, I looked up "internal" in a thesaurus, and nothing seemed much better to me.
> 
> Maybe something like "xor_bits_in_value()"? This has the verb-first style too.

Ah, ok, easy:

---
diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index 67dc186a1226..7e310d1dfcfc 100644
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -49,7 +49,8 @@ static u8 get_coh_st_inst_id_mi300(struct atl_err *err)
 	return i;
 }
 
-static u16 internal_bitwise_xor(u16 val)
+/* XOR the bits in @val. */
+static u16 bitwise_xor_bits(u16 val)
 {
 	u16 tmp = 0;
 	u8 i;
@@ -181,8 +182,8 @@ static unsigned long convert_dram_to_norm_addr_mi300(unsigned long addr)
 		if (!addr_hash.bank[i].xor_enable)
 			continue;
 
-		temp  = internal_bitwise_xor(col & addr_hash.bank[i].col_xor);
-		temp ^= internal_bitwise_xor(row & addr_hash.bank[i].row_xor);
+		temp  = bitwise_xor_bits(col & addr_hash.bank[i].col_xor);
+		temp ^= bitwise_xor_bits(row & addr_hash.bank[i].row_xor);
 		bank ^= temp << i;
 	}
 
@@ -191,9 +192,9 @@ static unsigned long convert_dram_to_norm_addr_mi300(unsigned long addr)
 		/* Bits SID[1:0] act as Bank[6:5] for PC hash, so apply them here. */
 		bank |= sid << 5;
 
-		temp  = internal_bitwise_xor(col  & addr_hash.pc.col_xor);
-		temp ^= internal_bitwise_xor(row  & addr_hash.pc.row_xor);
-		temp ^= internal_bitwise_xor(bank & addr_hash.bank_xor);
+		temp  = bitwise_xor_bits(col  & addr_hash.pc.col_xor);
+		temp ^= bitwise_xor_bits(row  & addr_hash.pc.row_xor);
+		temp ^= bitwise_xor_bits(bank & addr_hash.bank_xor);
 		pc   ^= temp;
 
 		/* Drop SID bits for the sake of debug printing later. */


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

