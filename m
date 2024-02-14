Return-Path: <linux-kernel+bounces-65830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A856A855293
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB1E41C22293
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614601384A0;
	Wed, 14 Feb 2024 18:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ka6xeXbs"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18EB32189;
	Wed, 14 Feb 2024 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707936441; cv=none; b=TXzw6JdLaHrJyIcbzB3DOkqFP27HYZtppe+NKzbLNRdsKel+fZM7uPihJFJuaIF4vuNCz0tWF4rulAFYGi7aW0PTTOIdnEr/vebi+c/OU5J0fNAMB60zIYk4+Pmh4ni85UT5Rkzyd3l3kPfp+Imuc05Atv/BeCj2VU84WqF9q/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707936441; c=relaxed/simple;
	bh=NIm3IgEloLvGBvBH4Zaebzho0OXqos2EvaBHzn4DpFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWhmW/JvkpFAz6nw/WW2hfxbMjLtMICeYQ5MMlvw3DISxj5QUxi6CD8nXnMNxuIEj8uC53uEFvfhUCIoCoJkB2YMpivPaoELh48CbbO9amOp286K8h2sX236b1G1cY4Vts+fkUoBRWd+IlzHbp13W0zpYvTnzyb3gU9052Blwvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Ka6xeXbs; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9521840E0192;
	Wed, 14 Feb 2024 18:47:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uDEVClmVslPA; Wed, 14 Feb 2024 18:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707936435; bh=GXB5NuZcN+0hs/uqer3xg1+8nRfnzlvMrvLEydd0vfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ka6xeXbsBZvqA0MO+I0wjdoS12yKludbo+NrYYxB9HDpt/5av4wXvEsyhmLlmdgOt
	 SXRxtwGy3gfHiqKWka2mocfRj3kwhp1fE3f4tWpMVDlJmQHXo0IDRLJO+xQL9T/sGm
	 b95ToRa699l+GXzanSQdx2zmbkEuOS50yurvk0rfCfMFS6uf3kQkeQN9Kg6TaQHypD
	 Cjz7eJYiCGJjZQqC6m2Lm4OXQTMK80x3NjJGBFGH1l4yiy/uU3iIlrRJVdgkakbGN5
	 P1JWtlBnMHw1kntNbz8OC518mxEkrPZBcfnNiukfzhkGqac9bTTzjw9khloEkB1lGr
	 kEL1xlvZSLcSgun1qNTZAWzuq6PrDHwGxmqEQ48cA5U64pYJwFKbX/LDPjVuUX3GAp
	 zYtA6zEqAeTr3N2rfC7q77FtcHO/Jl6FGoWahjEuXecW+CYSvyN43DsVK0rEu2KRbE
	 9rM2ugaws6jE9kxFyeeSP77UFGXU0ZEobf9RCGWvuNaWDY/yys4z+EoJmI2dri/E68
	 h2knqFGX74hCwqKXsUT5nR6vA3sNcmR7v0BfXoxgh4AYzeaDnSCH+t+YlFIERaEl7U
	 7t8+GNwWdXWOf9bqgU+FhhKctXihTasO2Z+dQlcWaLTAw6QHd8YjBckbibxa/hIOjw
	 MHMGxS2Og5XvBwYbeZsQon4E=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7331840E016C;
	Wed, 14 Feb 2024 18:47:06 +0000 (UTC)
Date: Wed, 14 Feb 2024 19:47:05 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, muralidhara.mk@amd.com,
	naveenkrishna.chatradhi@amd.com, sathyapriya.k@amd.com
Subject: Re: [PATCH 2/2] RAS: Introduce the FRU Memory Poison Manager
Message-ID: <20240214184705.GOZc0KqTyCJEBD-B0i@fat_crate.local>
References: <20240214033516.1344948-1-yazen.ghannam@amd.com>
 <20240214033516.1344948-3-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240214033516.1344948-3-yazen.ghannam@amd.com>

On Tue, Feb 13, 2024 at 09:35:16PM -0600, Yazen Ghannam wrote:
> +static bool same_fpd(struct cper_fru_poison_desc *old, struct cper_fru_poison_desc *new)

The usual convention in the kernel is:

diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index 643c36b6dc9c..e50f11fb90a4 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -220,7 +220,7 @@ static bool rec_has_valid_entries(struct fru_rec *rec)
 	return true;
 }
 
-static bool same_fpd(struct cper_fru_poison_desc *old, struct cper_fru_poison_desc *new)
+static bool fpds_equal(struct cper_fru_poison_desc *old, struct cper_fru_poison_desc *new)
 {
 	/*
 	 * Ignore timestamp field.
@@ -250,7 +250,7 @@ static bool rec_has_fpd(struct fru_rec *rec, struct cper_fru_poison_desc *fpd)
 	for (i = 0; i < rec->fmp.nr_entries; i++) {
 		struct cper_fru_poison_desc *fpd_i = &rec->entries[i];
 
-		if (same_fpd(fpd_i, fpd)) {
+		if (fpds_equal(fpd_i, fpd)) {
 			pr_debug("Found duplicate record");
 			return true;
 		}


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

