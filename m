Return-Path: <linux-kernel+bounces-38624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B65D83C354
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83FC4B22CB4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F674F5F4;
	Thu, 25 Jan 2024 13:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MruGMY2N"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEB54F5EC;
	Thu, 25 Jan 2024 13:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706188202; cv=none; b=DzlIm6FzDMUkxv/EyeC9TlO0GKWDHu/V5lSN+rWaPLjjrRZoD1TdFn0t+1LBipEDL8R64DXZrtofeUybdpfvWlAa8+6RpJ99pPk8UrcSqw15mhGv9lula7lJjrK9iUn2ODsiBkpKX5d8ErieOK+0DQFD2qJ9hFNEtfZBbo99+Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706188202; c=relaxed/simple;
	bh=ixOUbUgwpTbStFY8CHWFIMXLd1AVkqVhgHcVTd6hCvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqpFfRxmhYSv3B+vnR3aent53ER1sv8ut5U60/JFcytBVmBW+nm7LlZlTe13VjoBVC8LXvhQX+XSwQKJXTbLHYvn/U+sJ89eXGWWJbd6ZgQWFR8ZEHBKi4ZOGMxksKY8rcMC4WL5SH9rLhAASmZuTzbcvjEjbi8kXcw3m8OFeu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MruGMY2N; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AA17240E01AE;
	Thu, 25 Jan 2024 13:09:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wUxfKDr1SADY; Thu, 25 Jan 2024 13:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706188194; bh=x3hC8ihP+GWasuSyIpmywSNUiv9Qfrt/J4c5qImuHHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MruGMY2N/v+nFUJ6fC/PORHL3a93ojDPu9Y2niB99j99SGApPgdbP5F6+a3Ew3tNY
	 LL5ldJpTD9AIcT7T6RIFz7MKIy5OecPyaV/YoTykFhUi8S9/obEQBwRkFKcobQgcet
	 xe/moviYYqssfXLq/wGO6t8gD9LOhzmuHUmi9uLlhVpjhWPTUSJRR3qZGBn6onBYA3
	 +1N81udaM9Bdk86gAldOB0NB8MPkqEOTrFdqF3bitLME8g3hK6QRIjcxfDrqyXc1K+
	 X7q50TeDsOmv3yvagxkwsA1qbFMJsShDlmCaxstuRMPbeo2lEv4MxqHeRLIR0uid8H
	 wA6J0MNMrj447Hvf0XqxevBvnOof52Nos6dbEUWOFciGVWvQutRMXdtqn+MPkM0ofU
	 JXKGjeXus7iKyxA0CMx5Nx9LMZfcrcTZ5npMkuVDEPi4mZT1/WMkohANmYiLlpxMvd
	 KBOHSfLfLO4CjM6EP8Hsr5aFDbBso72TpiY7HAeo+bx89kNPrmvmfRycUvIug3lFHh
	 OK65kRqhJb8FvqvxKDScQLGzNYxV98eCA26wBTURd/Ql0UdxPdf7hD39+GnzM3ZBOz
	 xQoZjyNbIUfELfcBY9iqStstsz1Z4KOFlYdoxhj3pG5THa1Fpn9lCekbW8YekDKfMY
	 6EqzAuTKqFeN7VVTjXDuTy6w=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 793CB40E0177;
	Thu, 25 Jan 2024 13:09:42 +0000 (UTC)
Date: Thu, 25 Jan 2024 14:09:36 +0100
From: Borislav Petkov <bp@alien8.de>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
	error27@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] EDAC/device_sysfs: Fix calling kobject_put() with
 ->state_initialized unset
Message-ID: <20240125130936.GYZbJdkFOQds9w0hAp@fat_crate.local>
References: <20231128183037.3395755-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231128183037.3395755-1-harshit.m.mogalapalli@oracle.com>
X-Spam: Yes

On Tue, Nov 28, 2023 at 10:30:35AM -0800, Harshit Mogalapalli wrote:
> In edac_device_register_sysfs_main_kobj(), when dev_root is NULL,

When is dev_root NULL?

A real use case or this is just from code staring?

> diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
> index 010c26be5846..4cac14cbdb60 100644
> --- a/drivers/edac/edac_device_sysfs.c
> +++ b/drivers/edac/edac_device_sysfs.c
> @@ -253,11 +253,13 @@ int edac_device_register_sysfs_main_kobj(struct edac_device_ctl_info *edac_dev)
>  
>  	/* register */
>  	dev_root = bus_get_dev_root(edac_subsys);
> -	if (dev_root) {
> -		err = kobject_init_and_add(&edac_dev->kobj, &ktype_device_ctrl,
> -					   &dev_root->kobj, "%s", edac_dev->name);

What cb4a0bec0bb9 did looks wrong. That if (err) check should be inside
the if (dev_root).

IOW, that function's error checking needs balancing. Something like
this below.

And looking at the other one, it has the same issue...

---
diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
index 237a542e045a..3476ef13e681 100644
--- a/drivers/edac/edac_device_sysfs.c
+++ b/drivers/edac/edac_device_sysfs.c
@@ -228,8 +228,8 @@ static struct kobj_type ktype_device_ctrl = {
  */
 int edac_device_register_sysfs_main_kobj(struct edac_device_ctl_info *edac_dev)
 {
-	struct device *dev_root;
 	const struct bus_type *edac_subsys;
+	struct device *dev_root;
 	int err = -ENODEV;
 
 	edac_dbg(1, "\n");
@@ -243,26 +243,26 @@ int edac_device_register_sysfs_main_kobj(struct edac_device_ctl_info *edac_dev)
 	/* Init the devices's kobject */
 	memset(&edac_dev->kobj, 0, sizeof(struct kobject));
 
-	/* Record which module 'owns' this control structure
-	 * and bump the ref count of the module
+	/*
+	 * Record which module 'owns' this control structure and bump
+	 * the ref count of the module
 	 */
 	edac_dev->owner = THIS_MODULE;
 
 	if (!try_module_get(edac_dev->owner))
 		goto err_out;
 
-	/* register */
 	dev_root = bus_get_dev_root(edac_subsys);
-	if (dev_root) {
-		err = kobject_init_and_add(&edac_dev->kobj, &ktype_device_ctrl,
-					   &dev_root->kobj, "%s", edac_dev->name);
-		put_device(dev_root);
-	}
+	if (!dev_root)
+		goto err_module;
+
+	err = kobject_init_and_add(&edac_dev->kobj, &ktype_device_ctrl,
+				   &dev_root->kobj, "%s", edac_dev->name);
 	if (err) {
-		edac_dbg(1, "Failed to register '.../edac/%s'\n",
-			 edac_dev->name);
+		edac_dbg(1, "Failed to register '.../edac/%s'\n", edac_dev->name);
 		goto err_kobj_reg;
 	}
+
 	kobject_uevent(&edac_dev->kobj, KOBJ_ADD);
 
 	/* At this point, to 'free' the control struct,
@@ -273,9 +273,11 @@ int edac_device_register_sysfs_main_kobj(struct edac_device_ctl_info *edac_dev)
 
 	return 0;
 
-	/* Error exit stack */
 err_kobj_reg:
 	kobject_put(&edac_dev->kobj);
+	put_device(dev_root);
+
+err_module:
 	module_put(edac_dev->owner);
 
 err_out:

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

