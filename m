Return-Path: <linux-kernel+bounces-158604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1398B22D5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32471283427
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254C014A4EF;
	Thu, 25 Apr 2024 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ft8Z7PAB"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574E114A4EA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714051855; cv=none; b=b3vgrJGtFdL2wyB+KoieQAYQ6ST48oTPlUT+6ymt2ghMQCu34HSuSg0OaT5ABVfqPu5gvw5A5D/bJd0V3lEJ80Q7UApxQvMKyPATvDjiZrDG6x8PWpW1Dt/xK1hOM0xyUJ0zdEKlJrs2hSnJTzeDohArmuZVzqw3Jft1JQKIpiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714051855; c=relaxed/simple;
	bh=JUD47gH4UF+AnvrzsKslOeCDr1ncmmT8PIVPcsNWIC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hM55tzDUBJabevhqoxwWgWoeHe3eZFdXqHWGIFvp6e9R+DQiV3ndm/c7/RxYKkCpZGdm5iPUHODqmneWWK7OH4nJapkJPmI/uVZuFkup5aFP2elkPBIFX1UupJUbKEF3dOZ4YBy3gJyieDiu7sIduX3LzjrRmlA8/izvbmlVTTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Ft8Z7PAB; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E070540E00C7;
	Thu, 25 Apr 2024 13:30:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Eq47PBJSQ7DN; Thu, 25 Apr 2024 13:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714051845; bh=FrYifURfAjBzq0pxyVavkio6kX55D09A8xMz00+qLdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ft8Z7PAB3yW2ZDxBdX4YAAp89CnicRrNxoN5eJ7a4XjJtq8royL5nJISdHHHJb4mj
	 +zLolaKo3UOQ3dznROY2VshQPZDcT4Bw5KHLFnopuK7hs809j+MY99yQ56kmQ90hbj
	 NcRSuSkOTKWtITy8W9rklqeq21mmCijruqfJNqA2vJed41qmodWnXzYtBIILSMSjrv
	 7C5Hr23i0PL9fdNCkdoK7MoeXjqAXfTnVvv78WJy2cZ95Q4PKZNUJdqizgPeeAts8j
	 Nz2JWpw5vBR+kQaFvNcusINb1iqlc6jz0IZ5BhunG5Omeu3+Dk9+6QK7xDNB6WlJFf
	 Jo2Ij3BaZjYbw8xriBGP+fbX7GTjHBt8TnulM37N9vNHkq2KG8klc411va/hhAXH6G
	 o/0+lG8Nu64IG4KaeX/QOnGQgd5uPVnHu74VwAwJWI2rkgS4aRjAV3ndaLDDg5EsNe
	 xtIlU4lpUVotJGjxc6uxIR0a+0j+u7DL10nxnZveOeNNpLsUh4Dz2zIMue0XUOzRUq
	 Fv48Z53ygBG7jHD/0AisjEnBxQWApDrjwzGpBheoyA2jvonWS5uTxnEqDLxOVrMZV3
	 ZlzygCvxDKBR1tUaova6sCKSgvFJ0v+ob6GT4u3xxIV0dhAcMs500Nal0tmQZuIZua
	 QsmmPYt5KOJ8JSJg8QGm9urM=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2337440E0028;
	Thu, 25 Apr 2024 13:30:31 +0000 (UTC)
Date: Thu, 25 Apr 2024 15:30:24 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v4 01/15] x86/sev: Shorten snp_secrets_page_layout to
 snp_secrets_page
Message-ID: <20240425133024.GIZipa8F1tkFGXuNNZ@fat_crate.local>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <bc8d58302c6ab66c3beeab50cce3ec2c6bd72d6c.1713974291.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bc8d58302c6ab66c3beeab50cce3ec2c6bd72d6c.1713974291.git.thomas.lendacky@amd.com>

On Wed, Apr 24, 2024 at 10:57:57AM -0500, Tom Lendacky wrote:
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 995f94467101..6949fbccec40 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -648,7 +648,7 @@ static u64 __init get_secrets_page(void)
>  
>  static u64 __init get_snp_jump_table_addr(void)
>  {
> -	struct snp_secrets_page_layout *layout;
> +	struct snp_secrets_page *layout;

Yes, and I'd go change that "layout" name to "secrets" too because
layout doesn't make any sense when talking about a secrets page.

This, OTOH:

	addr = secrets->os_area.ap_jump_table_pa;

means something: the address comes from the secrets page. Not from the
"layout". :-)

IOW, diff ontop:

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 25056346bc18..790e4818f7c6 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -648,7 +648,7 @@ static u64 __init get_secrets_page(void)
 
 static u64 __init get_snp_jump_table_addr(void)
 {
-	struct snp_secrets_page *layout;
+	struct snp_secrets_page *secrets;
 	void __iomem *mem;
 	u64 pa, addr;
 
@@ -662,9 +662,9 @@ static u64 __init get_snp_jump_table_addr(void)
 		return 0;
 	}
 
-	layout = (__force struct snp_secrets_page *)mem;
+	secrets = (__force struct snp_secrets_page *)mem;
 
-	addr = layout->os_area.ap_jump_table_pa;
+	addr = secrets->os_area.ap_jump_table_pa;
 	iounmap(mem);
 
 	return addr;
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 04a7bd1e4314..654290a8e1ba 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -59,7 +59,7 @@ struct snp_guest_dev {
 	 */
 	struct snp_guest_msg secret_request, secret_response;
 
-	struct snp_secrets_page *layout;
+	struct snp_secrets_page *secrets;
 	struct snp_req_data input;
 	union {
 		struct snp_report_req report;
@@ -743,26 +743,26 @@ static const struct file_operations snp_guest_fops = {
 	.unlocked_ioctl = snp_guest_ioctl,
 };
 
-static u8 *get_vmpck(int id, struct snp_secrets_page *layout, u32 **seqno)
+static u8 *get_vmpck(int id, struct snp_secrets_page *secrets, u32 **seqno)
 {
 	u8 *key = NULL;
 
 	switch (id) {
 	case 0:
-		*seqno = &layout->os_area.msg_seqno_0;
-		key = layout->vmpck0;
+		*seqno = &secrets->os_area.msg_seqno_0;
+		key = secrets->vmpck0;
 		break;
 	case 1:
-		*seqno = &layout->os_area.msg_seqno_1;
-		key = layout->vmpck1;
+		*seqno = &secrets->os_area.msg_seqno_1;
+		key = secrets->vmpck1;
 		break;
 	case 2:
-		*seqno = &layout->os_area.msg_seqno_2;
-		key = layout->vmpck2;
+		*seqno = &secrets->os_area.msg_seqno_2;
+		key = secrets->vmpck2;
 		break;
 	case 3:
-		*seqno = &layout->os_area.msg_seqno_3;
-		key = layout->vmpck3;
+		*seqno = &secrets->os_area.msg_seqno_3;
+		key = secrets->vmpck3;
 		break;
 	default:
 		break;
@@ -898,7 +898,7 @@ static void unregister_sev_tsm(void *data)
 static int __init sev_guest_probe(struct platform_device *pdev)
 {
 	struct sev_guest_platform_data *data;
-	struct snp_secrets_page *layout;
+	struct snp_secrets_page *secrets;
 	struct device *dev = &pdev->dev;
 	struct snp_guest_dev *snp_dev;
 	struct miscdevice *misc;
@@ -916,7 +916,7 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	if (!mapping)
 		return -ENODEV;
 
-	layout = (__force void *)mapping;
+	secrets = (__force void *)mapping;
 
 	ret = -ENOMEM;
 	snp_dev = devm_kzalloc(&pdev->dev, sizeof(struct snp_guest_dev), GFP_KERNEL);
@@ -924,7 +924,7 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 		goto e_unmap;
 
 	ret = -EINVAL;
-	snp_dev->vmpck = get_vmpck(vmpck_id, layout, &snp_dev->os_area_msg_seqno);
+	snp_dev->vmpck = get_vmpck(vmpck_id, secrets, &snp_dev->os_area_msg_seqno);
 	if (!snp_dev->vmpck) {
 		dev_err(dev, "invalid vmpck id %d\n", vmpck_id);
 		goto e_unmap;
@@ -938,7 +938,7 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, snp_dev);
 	snp_dev->dev = dev;
-	snp_dev->layout = layout;
+	snp_dev->secrets = secrets;
 
 	/* Allocate the shared page used for the request and response message. */
 	snp_dev->request = alloc_shared_pages(dev, sizeof(struct snp_guest_msg));

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

