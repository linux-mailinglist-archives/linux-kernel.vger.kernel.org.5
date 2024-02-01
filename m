Return-Path: <linux-kernel+bounces-48043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 470B8845693
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03D92283873
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E6415DBC4;
	Thu,  1 Feb 2024 11:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlFjP2OQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1046C15DBB5;
	Thu,  1 Feb 2024 11:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788409; cv=none; b=tHk3Pf41QR7hz0mFJ/p7SQ2W2Z9Fuw/wg+WPyDlSw7XJYIdMcQOTX/JXzZ6K8s/zaQcV8tgjn83vGVCdaBnv1vxd6BnwGqtn59um0WsdWEmKNS/NHSh+p9y+zFzoKe9ER4rPr8rMjMsa4QUqXxafx6kxB8Vj08FliDz3KD4gBN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788409; c=relaxed/simple;
	bh=xwCxROJx6BTu8Xiy2MItJhGUPUJPgxHfmZNp5V9yd+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IjkO7j4uQ7Z7lARoFPIBzMun2/OpmPcZZjbfZlpnVVI59NIrzGivm+/p/zCkBeYPMFpStzNFUFuceNTdK19nxUP1R5AqrwD52tFhzhjX/LKdsTm2/GOzTASfcDcSVP6GZWgQWf8X0HQLqCnyD4ncMDHDzLDl5tztV2UjiTT8Xxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlFjP2OQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBFD5C43390;
	Thu,  1 Feb 2024 11:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706788408;
	bh=xwCxROJx6BTu8Xiy2MItJhGUPUJPgxHfmZNp5V9yd+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HlFjP2OQLDmLrfJsg0whXAVlV1xn0/yUniabZMEmxjXL4al4CquZM2uNcGrCz0dYx
	 Xc54nBxg9+nhEv85g+B2mHcPJ6gFh6g78bkCgSBs3npFVJ7qruLuU2W3R9WjCDEkns
	 dnmchPRH3i9z/E2degffIXzOzAEolhhQdvA+bNl7baVXTGkEGWa65AyhWZzPljBR6L
	 nXDtHNMmJa3CcLVWjHf/BWXRizFmu+8sjC0qi6Zp0H1co7Rst+CF2GdsRiwZ8AA+Eu
	 1QSHG4Ez6frUDDR5Ql0Cz40iH6vGJXghYojyYl8ZRxvqMGv4NqReMXnCBPTnu1esCB
	 EmvCIPuAOBAdg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/7] HID: wacom: remove unused hid_data::pressure
Date: Thu,  1 Feb 2024 12:53:15 +0100
Message-ID: <20240201115320.684-3-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201115320.684-1-jirislaby@kernel.org>
References: <20240201115320.684-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pressure member in struct hid_data is unused. It was
added in commit 5ae6e89f7409 (HID: wacom: implement the finger part of
the HID generic handling), but never used.

As this is not a struct to communicate with the HW, remove that member.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Ping Cheng <ping.cheng@wacom.com>
Cc: Jason Gerecke <jason.gerecke@wacom.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_wac.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index e63b1e806e34..6ec499841f70 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -309,7 +309,6 @@ struct hid_data {
 	bool confidence;
 	int x;
 	int y;
-	int pressure;
 	int width;
 	int height;
 	int id;
-- 
2.43.0


