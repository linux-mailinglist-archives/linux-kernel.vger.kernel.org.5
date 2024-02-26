Return-Path: <linux-kernel+bounces-81831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D39867A93
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21816294C14
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B3712C7FB;
	Mon, 26 Feb 2024 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VrsStQxc"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2822012BEBD;
	Mon, 26 Feb 2024 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962243; cv=none; b=ChXHu7IluvBvSd4CJ3E0VRM5gyFUTD4c5vgiXQFYn6q1sFRvOuiFarwoDF2L5aacCywFjwf9craLn/BglWrlx2tkDwr/WSOQqzwf8lb/r4Fi8tapPCzcbk2wdcP3UyS+LbdbBSvSWNV4xTrNGDwFyf8R/SVOmH8NsMsCma5NIzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962243; c=relaxed/simple;
	bh=p19kTaortInEha0cwpwtBZnqivplGiTeVDdaQ9egqbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkRr7oFhca9p+s2UgEa98fH2Iargimx05JG1fChH+Vn1CoCU2OSPCkOzY4OxfFoaSPvIRBWYRGopeN7FodpO5B4nSAtkczYkGkL4vZ2jdZxXQNNI0JqJUjkrnL75aDu+0WVCj/vYIgJJZtAy/gbBfPa4SFxXO438wKTFSI+d5NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VrsStQxc; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BD49B40E0192;
	Mon, 26 Feb 2024 15:43:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zQBq6k5xoCaZ; Mon, 26 Feb 2024 15:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1708962234; bh=MQZvRp1V0lIMTMZthnsmol8I4kRgnl75tJYZUkvpj8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VrsStQxcO/dy3x+x3wa1y1hi5a5pKkUi36+spe97eUaQOa6OwLy03JeVYFDTTlxSm
	 b7nv6Obb27or0Kez96zL+EV3dte70DQWWtYY5nXaJ43mgx5E9iIt2bAmZku6QOmGQm
	 j0ehgJ8cXjloiGZpVXsbe1VTmTdzBYX6q2yqat0yX+SHtdivV/ZtoyTjcdUxeQuFvK
	 C4gAZQodqzv858TLzmEYk8ipxM0LsuQJnRkUCVEyBk4kBglYhRie4+eSbOjSFfbTY9
	 7Mqd7OKoLQHKdKOxhdOpsydjkBre6SHTUjMYxfdLudckSH0RiQyJGecGrQFAl9gVu2
	 ZiQAq1Ha19Xmu6/J9pioJt9RLBpHy34pQ27fyOU9XzbueP/l9slxGncgfedfwmK2wO
	 L8fSldA53IXqtvNxH87t8827Dlx0uQ23g6LnKlfrBYPlxln4eXIO0ST+tt+sm6sRHR
	 TGL9tKSjcjeNuj5LJZDUtbqIgKqhBXmlXOGVpmH0DBz0K1n6A8cn+txqlLmQZrAjp2
	 rAKPp/RAtEqNnQe/wM6Cu800xrz3mMNaY8iAOlBkxoWryUyaznS8Wb1mFRBvvhXkGG
	 B8uAAQzyB9KShfv++tjeuh2xUPk9VBdY4b5U3QrxvbZycKbYZy+udD4LWXrhd+no2r
	 rrWsanG6VV9X6CgsYs+YxoLQ=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AC90D40E016C;
	Mon, 26 Feb 2024 15:43:45 +0000 (UTC)
Date: Mon, 26 Feb 2024 16:43:39 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, muralidhara.mk@amd.com, sathyapriya.k@amd.com,
	naveenkrishna.chatradhi@amd.com
Subject: Re: [PATCH 1/3] RAS: Export ras_debugfs_dir
Message-ID: <20240226154339.GDZdyxq7YoDLPXdi8x@fat_crate.local>
References: <20240226152941.2615007-1-yazen.ghannam@amd.com>
 <20240226152941.2615007-2-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240226152941.2615007-2-yazen.ghannam@amd.com>

On Mon, Feb 26, 2024 at 09:29:39AM -0600, Yazen Ghannam wrote:
> ...so that RAS modules can use it.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/ras/debugfs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ras/debugfs.c b/drivers/ras/debugfs.c
> index ffb973c328e3..fd3d4595c122 100644
> --- a/drivers/ras/debugfs.c
> +++ b/drivers/ras/debugfs.c
> @@ -4,6 +4,7 @@
>  #include "debugfs.h"
>  
>  struct dentry *ras_debugfs_dir;
> +EXPORT_SYMBOL_GPL(ras_debugfs_dir);

I am never a fan of exporting things so let's add a helper this first,
in a separate pre-patch.

Also, I'd like to have this:

-       fmpm_dfs_dir = debugfs_create_dir(KBUILD_MODNAME, ras_debugfs_dir);
+       fmpm_dfs_dir = debugfs_create_dir("fmpm", dfs);

so that we don't accidentally change the module name and fsck up scripts
in the process.

Thx.

---

diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index e0811a71e6e7..b8e3e4c81f7e 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -913,10 +913,13 @@ static const struct file_operations fmpm_fops = {
 
 static void setup_debugfs(void)
 {
-	if (!ras_debugfs_dir)
+	struct dentry *dfs;
+
+	dfs = ras_get_debugfs_root();
+	if (!dfs)
 		return;
 
-	fmpm_dfs_dir = debugfs_create_dir(KBUILD_MODNAME, ras_debugfs_dir);
+	fmpm_dfs_dir = debugfs_create_dir("fmpm", dfs);
 	if (!fmpm_dfs_dir)
 		return;
 
diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 321af498ee11..e440b15fbabc 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -480,9 +480,15 @@ DEFINE_SHOW_ATTRIBUTE(array);
 
 static int __init create_debugfs_nodes(void)
 {
-	struct dentry *d, *pfn, *decay, *count, *array;
+	struct dentry *d, *pfn, *decay, *count, *array, *dfs;
 
-	d = debugfs_create_dir("cec", ras_debugfs_dir);
+	dfs = ras_get_debugfs_root();
+	if (!dfs) {
+		pr_warn("Error getting RAS debugfs root!\n");
+		return -1;
+	}
+
+	d = debugfs_create_dir("cec", dfs);
 	if (!d) {
 		pr_warn("Error creating cec debugfs node!\n");
 		return -1;
diff --git a/drivers/ras/debugfs.c b/drivers/ras/debugfs.c
index fd3d4595c122..42afd3de68b2 100644
--- a/drivers/ras/debugfs.c
+++ b/drivers/ras/debugfs.c
@@ -3,11 +3,16 @@
 #include <linux/ras.h>
 #include "debugfs.h"
 
-struct dentry *ras_debugfs_dir;
-EXPORT_SYMBOL_GPL(ras_debugfs_dir);
+static struct dentry *ras_debugfs_dir;
 
 static atomic_t trace_count = ATOMIC_INIT(0);
 
+struct dentry *ras_get_debugfs_root(void)
+{
+	return ras_debugfs_dir;
+}
+EXPORT_SYMBOL_GPL(ras_get_debugfs_root);
+
 int ras_userspace_consumers(void)
 {
 	return atomic_read(&trace_count);
diff --git a/drivers/ras/debugfs.h b/drivers/ras/debugfs.h
index c07443b462ad..4749ccdeeba1 100644
--- a/drivers/ras/debugfs.h
+++ b/drivers/ras/debugfs.h
@@ -4,6 +4,6 @@
 
 #include <linux/debugfs.h>
 
-extern struct dentry *ras_debugfs_dir;
+struct dentry *ras_get_debugfs_root(void);
 
 #endif /* __RAS_DEBUGFS_H__ */

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

