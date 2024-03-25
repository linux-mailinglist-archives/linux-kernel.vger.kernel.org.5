Return-Path: <linux-kernel+bounces-117967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AEA88B1E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B861F65E5C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C887317B;
	Mon, 25 Mar 2024 20:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibWoL9px"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ECA71739;
	Mon, 25 Mar 2024 20:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399499; cv=none; b=AfQiccP/gWoWnfdXYSR3JPFI3eId3z8eZ8sxveDQoRwRDxRVmkxwSoG8Go2rIcPkY/0Qt4v1Nn2BbhXetG3VD/+ZKVvWuctFpRZmaEOcf/xmnQMWxEYEvXJUYlLAKkzF4QOk2wP/D7TuXb/yEsrLTMvzRijRN6XNE8iEeja8ypg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399499; c=relaxed/simple;
	bh=8Q5dBDtztW2JoXr9nD0hK47pMWPXBqeI3oSF7O+vO+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=paYpFtouHn/71TrMkP4rbNF2IA+Y7IiwusvagECDRcpScfA52AxKCGSxsfUQeLrBThzvfwZDFJGytJEcEcsZsF8EJrLl9fshdRJtzvi2l4BgIDvSPGiGbMOFn+c92s95ZIYIAptTlji7AWTXCB2xihj+qTIxDVBP+OvZia411qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibWoL9px; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7716C433B2;
	Mon, 25 Mar 2024 20:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711399498;
	bh=8Q5dBDtztW2JoXr9nD0hK47pMWPXBqeI3oSF7O+vO+Q=;
	h=Date:From:To:Cc:Subject:From;
	b=ibWoL9pxXqCF2Ggso3naA2fD2G+wfd/tLQLp9GtIz1ZJxRdpx4wyIylnAk70loO4Q
	 fqC++a7QClTXwKYl+rqx2yq/KxOMF6el7gcH+3IItQ2RPBnHtZUU8I8GYnew92AWl3
	 cwdSQoCZSnY2SEyDgnmPRtGNj4aJuPHGBToEMLbw2PF6XKhwqZ+ulQmEuV6A6AqL68
	 9B4r/D1GnrYMTuXJkMJcadrI5i6Ge6BUvUxse+BmTNJ1gck4oChgKclkW9q9eMsXIa
	 B8iM+DBPW0oLwRuH+I4jU1FbJXAAFtB5uBxdiwaPP7FQ/EQm/YGk+HdvpoxZJM4hKv
	 yeX2J6n6l7OfA==
Date: Mon, 25 Mar 2024 14:44:55 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: qat-linux@intel.com, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] crypto: qat - Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <ZgHiR7j2NYl5M4mW@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
ready to enable it globally.

Use the `__struct_group()` helper to separate the flexible array
from the rest of the members in flexible `struct qat_alg_buf_list`,
through tagged `struct qat_alg_buf_list_hdr`, and avoid embedding the
flexible-array member in the middle of `struct qat_alg_fixed_buf_list`.

Also, use `container_of()` whenever we need to retrieve a pointer to
the flexible structure.

So, with these changes, fix the following warnings:
drivers/crypto/intel/qat/qat_common/qat_bl.h:25:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/crypto/intel/qat/qat_common/qat_bl.h:25:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/crypto/intel/qat/qat_common/qat_bl.h:25:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/crypto/intel/qat/qat_common/qat_bl.h:25:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/crypto/intel/qat/qat_common/qat_bl.h:25:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/crypto/intel/qat/qat_common/qat_bl.h:25:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/crypto/intel/qat/qat_common/qat_bl.h:25:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/crypto/intel/qat/qat_common/qat_bl.h:25:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Link: https://github.com/KSPP/linux/issues/202
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/crypto/intel/qat/qat_common/qat_bl.c |  6 ++++--
 drivers/crypto/intel/qat/qat_common/qat_bl.h | 11 +++++++----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_common/qat_bl.c b/drivers/crypto/intel/qat/qat_common/qat_bl.c
index 76baed0a76c0..338acf29c487 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_bl.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_bl.c
@@ -81,7 +81,8 @@ static int __qat_bl_sgl_to_bufl(struct adf_accel_dev *accel_dev,
 		if (unlikely(!bufl))
 			return -ENOMEM;
 	} else {
-		bufl = &buf->sgl_src.sgl_hdr;
+		bufl = container_of(&buf->sgl_src.sgl_hdr,
+				    struct qat_alg_buf_list, hdr);
 		memset(bufl, 0, sizeof(struct qat_alg_buf_list));
 		buf->sgl_src_valid = true;
 	}
@@ -139,7 +140,8 @@ static int __qat_bl_sgl_to_bufl(struct adf_accel_dev *accel_dev,
 			if (unlikely(!buflout))
 				goto err_in;
 		} else {
-			buflout = &buf->sgl_dst.sgl_hdr;
+			buflout = container_of(&buf->sgl_dst.sgl_hdr,
+					       struct qat_alg_buf_list, hdr);
 			memset(buflout, 0, sizeof(struct qat_alg_buf_list));
 			buf->sgl_dst_valid = true;
 		}
diff --git a/drivers/crypto/intel/qat/qat_common/qat_bl.h b/drivers/crypto/intel/qat/qat_common/qat_bl.h
index d87e4f35ac39..85bc32a9ec0e 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_bl.h
+++ b/drivers/crypto/intel/qat/qat_common/qat_bl.h
@@ -15,14 +15,17 @@ struct qat_alg_buf {
 } __packed;
 
 struct qat_alg_buf_list {
-	u64 resrvd;
-	u32 num_bufs;
-	u32 num_mapped_bufs;
+	/* New members must be added within the __struct_group() macro below. */
+	__struct_group(qat_alg_buf_list_hdr, hdr, __packed,
+		u64 resrvd;
+		u32 num_bufs;
+		u32 num_mapped_bufs;
+	);
 	struct qat_alg_buf buffers[];
 } __packed;
 
 struct qat_alg_fixed_buf_list {
-	struct qat_alg_buf_list sgl_hdr;
+	struct qat_alg_buf_list_hdr sgl_hdr;
 	struct qat_alg_buf descriptors[QAT_MAX_BUFF_DESC];
 } __packed __aligned(64);
 
-- 
2.34.1


