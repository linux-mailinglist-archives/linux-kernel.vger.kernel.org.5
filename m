Return-Path: <linux-kernel+bounces-1977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 728F781569A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DFDE1F25732
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 03:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7501C32;
	Sat, 16 Dec 2023 03:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KuhMqLw/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0448E5670;
	Sat, 16 Dec 2023 03:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=m1kkjflSaXlRG8CRCUF8DyyydFgrQziYsG0nGeB4/64=; b=KuhMqLw/iYusyNgvEAy8QduJNj
	1/kUrf8rKilum4ck/VlP4mKtyDerXqHsNAH89IFr73dM7z8U6mG/Sy6cPA8KkCJFHouA6g/1wHVEm
	FtEdBpaZpWbj+DmT7/9H4UckblBvoM+eOlEzETWhU3FsVvYFlUYJADEDJXi8oFhSRRp3Y0R5ghP7h
	X79MizaeoWbXyfBcbC8vftSotHMfsc9nffdUY5qc2FwefsLxpQjTSXTMnbW7iKL830Nv43jTpdIhH
	tSppyZdpTDfGQ2l2CN/fqVdQBUbFE2fcuC1x5z3dR6aHGLGImA8rPXeQVkhKqKR99fGwLSGt/bdIs
	86Jsst5g==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rEKy6-005DN6-2d;
	Sat, 16 Dec 2023 03:03:58 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <sfrench@samba.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org
Subject: [PATCH] ksmbd: auth: fix most kernel-doc warnings
Date: Fri, 15 Dec 2023 19:03:57 -0800
Message-ID: <20231216030357.7728-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix 12 of 17 kernel-doc warnings in auth.c:

auth.c:221: warning: Function parameter or member 'conn' not described in 'ksmbd_auth_ntlmv2'
auth.c:221: warning: Function parameter or member 'cryptkey' not described in 'ksmbd_auth_ntlmv2'
auth.c:305: warning: Function parameter or member 'blob_len' not described in 'ksmbd_decode_ntlmssp_auth_blob'
auth.c:305: warning: Function parameter or member 'conn' not described in 'ksmbd_decode_ntlmssp_auth_blob'
auth.c:305: warning: Excess function parameter 'usr' description in 'ksmbd_decode_ntlmssp_auth_blob'
auth.c:385: warning: Function parameter or member 'blob_len' not described in 'ksmbd_decode_ntlmssp_neg_blob'
auth.c:385: warning: Function parameter or member 'conn' not described in 'ksmbd_decode_ntlmssp_neg_blob'
auth.c:385: warning: Excess function parameter 'rsp' description in 'ksmbd_decode_ntlmssp_neg_blob'
auth.c:385: warning: Excess function parameter 'sess' description in 'ksmbd_decode_ntlmssp_neg_blob'
auth.c:413: warning: Function parameter or member 'conn' not described in 'ksmbd_build_ntlmssp_challenge_blob'
auth.c:413: warning: Excess function parameter 'rsp' description in 'ksmbd_build_ntlmssp_challenge_blob'
auth.c:413: warning: Excess function parameter 'sess' description in 'ksmbd_build_ntlmssp_challenge_blob'

The other 5 are only present when a W=1 kernel build is done or
when scripts/kernel-doc is run with -Wall. They are:

auth.c:81: warning: No description found for return value of 'ksmbd_gen_sess_key'
auth.c:385: warning: No description found for return value of 'ksmbd_decode_ntlmssp_neg_blob'
auth.c:413: warning: No description found for return value of 'ksmbd_build_ntlmssp_challenge_blob'
auth.c:577: warning: No description found for return value of 'ksmbd_sign_smb2_pdu'
auth.c:628: warning: No description found for return value of 'ksmbd_sign_smb3_pdu'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: Steve French <sfrench@samba.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Tom Talpey <tom@talpey.com>
Cc: linux-cifs@vger.kernel.org
---
 fs/smb/server/auth.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff -- a/fs/smb/server/auth.c b/fs/smb/server/auth.c
--- a/fs/smb/server/auth.c
+++ b/fs/smb/server/auth.c
@@ -208,10 +208,12 @@ out:
 
 /**
  * ksmbd_auth_ntlmv2() - NTLMv2 authentication handler
- * @sess:	session of connection
+ * @conn:		connection
+ * @sess:		session of connection
  * @ntlmv2:		NTLMv2 challenge response
  * @blen:		NTLMv2 blob length
  * @domain_name:	domain name
+ * @cryptkey:		session crypto key
  *
  * Return:	0 on success, error number on error
  */
@@ -294,7 +296,8 @@ out:
  * ksmbd_decode_ntlmssp_auth_blob() - helper function to construct
  * authenticate blob
  * @authblob:	authenticate blob source pointer
- * @usr:	user details
+ * @blob_len:	length of the @authblob message
+ * @conn:	connection
  * @sess:	session of connection
  *
  * Return:	0 on success, error number on error
@@ -376,8 +379,8 @@ int ksmbd_decode_ntlmssp_auth_blob(struc
  * ksmbd_decode_ntlmssp_neg_blob() - helper function to construct
  * negotiate blob
  * @negblob: negotiate blob source pointer
- * @rsp:     response header pointer to be updated
- * @sess:    session of connection
+ * @blob_len:	length of the @authblob message
+ * @conn:	connection
  *
  */
 int ksmbd_decode_ntlmssp_neg_blob(struct negotiate_message *negblob,
@@ -403,8 +406,7 @@ int ksmbd_decode_ntlmssp_neg_blob(struct
  * ksmbd_build_ntlmssp_challenge_blob() - helper function to construct
  * challenge blob
  * @chgblob: challenge blob source pointer to initialize
- * @rsp:     response header pointer to be updated
- * @sess:    session of connection
+ * @conn:	connection
  *
  */
 unsigned int

