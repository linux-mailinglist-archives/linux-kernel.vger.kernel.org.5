Return-Path: <linux-kernel+bounces-44920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA2F842916
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740B11C24E6A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5C11292D2;
	Tue, 30 Jan 2024 16:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OafZhq6O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BGn9jBrx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06208612D;
	Tue, 30 Jan 2024 16:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631960; cv=none; b=AI0Jp4uj6xV8mpW5Qqb73Hr3weU/F2ktYxt1FC27yk7nb+eExLZDUG/AFzo4iNoFtoY8TnxpEZN0yqCs23i2WJB/X/ULRdLbFkoiV/5ibbdRKGlX5EEgzPLZVn3DupZBEFnUYMM7+X1ENAKmWGEwaz9/BgNYr1Zernu+2XdfBhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631960; c=relaxed/simple;
	bh=07ZU4uwd0D51YFoSvWwE9Tjto+Otorjm1/aiN8L9RK0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TwEz9z8L59TBpeLzmhoUpU+pQVd0tB6JCjj5jR4JyJqntR2cwu59V8heDvCOucCGNANBF/74+4sEKTvbw6kay1Yc9HTfUUcrlDPBiegFaWL5Cup5OGz8lPVQPH5Rsz1sFk/qkJyGoWCcqHRluinluIXnwvnDkLp+VFgOtViPlOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OafZhq6O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BGn9jBrx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jan 2024 16:25:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706631956;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ToATIAXrSNNzPQ6DZa0QVLlkHcKjOCQ26rk6WN2JWOs=;
	b=OafZhq6OkO6pVeb0v4IDOnNmDouyNn3pZykkcWqCDhR6Du5W/lFXYR+MtN2jsTWHYAJwrq
	eUW0Kf9+ijR8WLvStHBnm376tMQFAVeam/nbzauvoQ3Q73sE2aAnpo5RIO/c2qodBVS0je
	GGHzhRnCCaU3fc7M3l+EedVQxMHRGKlE/177McpdUvOk4nyBopsUjgGDH7j8EsLR3qMWh7
	CIYwEwjZUa9f2Cy5LnJ3JqrULa28z1clJsOAC7uPdqny9YFvK/puUxx4FLtMfkm/S+IdHm
	MtUygEb9okeB/t/gI057RP42vy/FCT4LUPlvhHI9DIOa3F6pXHzz/BzUf86J5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706631956;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ToATIAXrSNNzPQ6DZa0QVLlkHcKjOCQ26rk6WN2JWOs=;
	b=BGn9jBrx31Wr7tCmDmPleGbK9Fhau0y7eXd9q/ZObdYZcjHQfl4yi7suK+SpgUyqycowCH
	4mznBRWBFNPUcKAQ==
From: "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] crypto: ccp: Add the SNP_COMMIT command
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240126041126.1927228-25-michael.roth@amd.com>
References: <20240126041126.1927228-25-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170663195578.398.11227857999059061766.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     fad133c79afa02344d05001324a0474e20f3e055
Gitweb:        https://git.kernel.org/tip/fad133c79afa02344d05001324a0474e20f3e055
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Thu, 25 Jan 2024 22:11:24 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Jan 2024 20:34:19 +01:00

crypto: ccp: Add the SNP_COMMIT command

The SNP_COMMIT command is used to commit the currently installed version
of the SEV firmware. Once committed, the firmware cannot be replaced
with a previous firmware version (cannot be rolled back). This command
will also update the reported TCB to match that of the currently
installed firmware.

  [ mdr: Note the reported TCB update in the documentation/commit. ]

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240126041126.1927228-25-michael.roth@amd.com
---
 Documentation/virt/coco/sev-guest.rst | 11 +++++++++++
 drivers/crypto/ccp/sev-dev.c          | 17 +++++++++++++++++
 include/linux/psp-sev.h               |  9 +++++++++
 include/uapi/linux/psp-sev.h          |  1 +
 4 files changed, 38 insertions(+)

diff --git a/Documentation/virt/coco/sev-guest.rst b/Documentation/virt/coco/sev-guest.rst
index 6d3d5d3..007ae82 100644
--- a/Documentation/virt/coco/sev-guest.rst
+++ b/Documentation/virt/coco/sev-guest.rst
@@ -151,6 +151,17 @@ The SNP_PLATFORM_STATUS command is used to query the SNP platform status. The
 status includes API major, minor version and more. See the SEV-SNP
 specification for further details.
 
+2.5 SNP_COMMIT
+--------------
+:Technology: sev-snp
+:Type: hypervisor ioctl cmd
+:Returns (out): 0 on success, -negative on error
+
+SNP_COMMIT is used to commit the currently installed firmware using the
+SEV-SNP firmware SNP_COMMIT command. This prevents roll-back to a previously
+committed firmware version. This will also update the reported TCB to match
+that of the currently installed firmware.
+
 3. SEV-SNP CPUID Enforcement
 ============================
 
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index ae02efe..6e375d1 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -222,6 +222,7 @@ static int sev_cmd_buffer_len(int cmd)
 	case SEV_CMD_SNP_PLATFORM_STATUS:	return sizeof(struct sev_data_snp_addr);
 	case SEV_CMD_SNP_GUEST_REQUEST:		return sizeof(struct sev_data_snp_guest_request);
 	case SEV_CMD_SNP_CONFIG:		return sizeof(struct sev_user_data_snp_config);
+	case SEV_CMD_SNP_COMMIT:		return sizeof(struct sev_data_snp_commit);
 	default:				return 0;
 	}
 
@@ -1990,6 +1991,19 @@ cleanup:
 	return ret;
 }
 
+static int sev_ioctl_do_snp_commit(struct sev_issue_cmd *argp)
+{
+	struct sev_device *sev = psp_master->sev_data;
+	struct sev_data_snp_commit buf;
+
+	if (!sev->snp_initialized)
+		return -EINVAL;
+
+	buf.len = sizeof(buf);
+
+	return __sev_do_cmd_locked(SEV_CMD_SNP_COMMIT, &buf, &argp->error);
+}
+
 static long sev_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
@@ -2044,6 +2058,9 @@ static long sev_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
 	case SNP_PLATFORM_STATUS:
 		ret = sev_ioctl_do_snp_platform_status(&input);
 		break;
+	case SNP_COMMIT:
+		ret = sev_ioctl_do_snp_commit(&input);
+		break;
 	default:
 		ret = -EINVAL;
 		goto out;
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index 84eabbf..3705c20 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -801,6 +801,15 @@ struct sev_platform_init_args {
 	bool probe;
 };
 
+/**
+ * struct sev_data_snp_commit - SNP_COMMIT structure
+ *
+ * @len: length of the command buffer read by the PSP
+ */
+struct sev_data_snp_commit {
+	u32 len;
+} __packed;
+
 #ifdef CONFIG_CRYPTO_DEV_SP_PSP
 
 /**
diff --git a/include/uapi/linux/psp-sev.h b/include/uapi/linux/psp-sev.h
index f1e2c55..35c2076 100644
--- a/include/uapi/linux/psp-sev.h
+++ b/include/uapi/linux/psp-sev.h
@@ -29,6 +29,7 @@ enum {
 	SEV_GET_ID,	/* This command is deprecated, use SEV_GET_ID2 */
 	SEV_GET_ID2,
 	SNP_PLATFORM_STATUS,
+	SNP_COMMIT,
 
 	SEV_MAX,
 };

