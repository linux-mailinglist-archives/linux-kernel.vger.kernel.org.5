Return-Path: <linux-kernel+bounces-121114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D5588E27F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A6E1C23861
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90FA13BC10;
	Wed, 27 Mar 2024 12:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klofewBM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FB517262A;
	Wed, 27 Mar 2024 12:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542117; cv=none; b=twI2J8HEZlCekLTePH8shzVmTZxyaYH7rMhyaIgBaGLhwSRjzifHfb3xfUusYoLsoushVmWRQF9PmHzBfgxKGIUNMKz9/q2oKm1hhUFDAe2Kdq0LqF/t6IBQL2v3PH7Ecm4P/oXchb2ySxoE/7/HbJcu1RDElBTKoz/LD+yFz+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542117; c=relaxed/simple;
	bh=kLO9hRBcZRTsX5ymOvHk+Kx3kBu7HKdYh2vmlHOqgjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h/u2uqROTGvJiPGDxU+hqdZOGywvsTbXJKK/LrgioH3nvzKsRbWWyFDN3N8nKW/GK8rBFcVRvmctM6AtxDVBuyxjvgmJNY4HNll+3kpXgRvkoFkMapHQ5tmlfdbLXl61bveFpdgaq5iTxELscHRBoEsE/pNXrCAq/3tVSj6gbpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klofewBM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E298BC433F1;
	Wed, 27 Mar 2024 12:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542116;
	bh=kLO9hRBcZRTsX5ymOvHk+Kx3kBu7HKdYh2vmlHOqgjA=;
	h=From:To:Cc:Subject:Date:From;
	b=klofewBMjomTecW+jJZ+VSzMJAfoqE0pdze9axuLmpL97ZF7hnoSCJngjWILi5ARw
	 Sp/Ee/TpRCDibAO3i2CkY0KXlQytKlTkUX6DQRxEdSUJTSdsIasgTM6+/Oyi3RC1Z5
	 JPZiKlRGPlAG8dhh54QLOHIzkK9aUbwk1HfsQ9xR5q3cF7TFMxrucepe0ox5AO+OAn
	 CmZabICmUc2E+65EIliIjQBNtbfQFcy2plG6eZXHEbun5dSUpsAO1ia9W8x+ov7iML
	 Cux4oZjzDG0l5o0KJZ1OsDCf2hGktxzd6J/Msl4En8pFO4QQfmkkfQS4KGcfsh9I98
	 Nz8SC9mjkPxBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	linkinjeon@kernel.org
Cc: Yang Chaoming <lometsj@live.com>,
	Steve French <stfrench@microsoft.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "ksmbd: fix slab-out-of-bounds in smb_strndup_from_utf16()" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:21:54 -0400
Message-ID: <20240327122155.2837257-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d10c77873ba1e9e6b91905018e29e196fd5f863d Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 20 Dec 2023 15:52:11 +0900
Subject: [PATCH] ksmbd: fix slab-out-of-bounds in smb_strndup_from_utf16()

If ->NameOffset/Length is bigger than ->CreateContextsOffset/Length,
ksmbd_check_message doesn't validate request buffer it correctly.
So slab-out-of-bounds warning from calling smb_strndup_from_utf16()
in smb2_open() could happen. If ->NameLength is non-zero, Set the larger
of the two sums (Name and CreateContext size) as the offset and length of
the data area.

Reported-by: Yang Chaoming <lometsj@live.com>
Cc: stable@vger.kernel.org
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/smb2misc.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/smb2misc.c b/fs/smb/server/smb2misc.c
index 23bd3d1209dfa..03dded29a9804 100644
--- a/fs/smb/server/smb2misc.c
+++ b/fs/smb/server/smb2misc.c
@@ -106,16 +106,25 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 		break;
 	case SMB2_CREATE:
 	{
+		unsigned short int name_off =
+			le16_to_cpu(((struct smb2_create_req *)hdr)->NameOffset);
+		unsigned short int name_len =
+			le16_to_cpu(((struct smb2_create_req *)hdr)->NameLength);
+
 		if (((struct smb2_create_req *)hdr)->CreateContextsLength) {
 			*off = le32_to_cpu(((struct smb2_create_req *)
 				hdr)->CreateContextsOffset);
 			*len = le32_to_cpu(((struct smb2_create_req *)
 				hdr)->CreateContextsLength);
-			break;
+			if (!name_len)
+				break;
+
+			if (name_off + name_len < (u64)*off + *len)
+				break;
 		}
 
-		*off = le16_to_cpu(((struct smb2_create_req *)hdr)->NameOffset);
-		*len = le16_to_cpu(((struct smb2_create_req *)hdr)->NameLength);
+		*off = name_off;
+		*len = name_len;
 		break;
 	}
 	case SMB2_QUERY_INFO:
-- 
2.43.0





