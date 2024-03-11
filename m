Return-Path: <linux-kernel+bounces-99522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2871878992
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A81C21F21D52
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB0253807;
	Mon, 11 Mar 2024 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+JYnl7l"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F123CF6A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 20:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710189649; cv=none; b=qBJJSwj6GjrZlSkC4lMMnGFCdBadoxmMNqC6uIZPLn5MM1TzWBr1eUoZQNurYNApRRbu0wJFhr8DtkzUxC3Qa5X3fqgi5s29U4dhG7ibe3vSYjoqqBRWzlpyLS7+yJbSlzt/M55yCCC67SnJ/F3OEKllePPGk3T+2hWcjpYkXjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710189649; c=relaxed/simple;
	bh=0Kq0Kgx3d6qdBteVdc49v+B1oL6Tx1LvVDzpIfXgHLU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RS1ghf/EnvPG+TrqsNn7bU+wLKIWATkkpuKPyQqDFicZdYsabpvfBSRTlrXJOyVb52VUi1jbZmTraKlOBzgEOomIvQ0gK6PClRqxYGEzhtkZrLYgS0PURXCo2qNmMbqBJoksmY7HCzXGIEuUbCfp78BArsdLwRZIFpKu11ZhfVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+JYnl7l; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33e1878e357so2842826f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 13:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710189646; x=1710794446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SeoEezW9/4VkOixPnqAE9ztYSH2P2V/0rjgAzL/X/r4=;
        b=J+JYnl7lszzAGvgNzjnPmph1Um5qKeb4SQf055wLSvTi5FTxUCMa0jPRwU9QKRsCzq
         GbgNV8HVcyakI0gyvh2FVEFPrrBmdBw8BnAiGcDtARfPUljXst80XMkquowvn1JNTrCA
         2UgoeTIWFZUoYfjQR+oArVs9N/UejanYKvGYvcDMifcP0hIEK318Q8rTlxCsbwy9OSNG
         j1cZ1rFv5lIvbHF1U/q0Ohao/LU1s0vu9eE4qeXE2c4QmwFqcCSaQmFI0oZ+N93lqJx5
         vqZm4Ohn51HFlsyylw67BKzj6uEa4MyapDhaCbJqedsKZboPKUTmPVMARZ0/Z79ll5CG
         BCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710189646; x=1710794446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SeoEezW9/4VkOixPnqAE9ztYSH2P2V/0rjgAzL/X/r4=;
        b=AJHIdFv5FCjH+FbmOMCE4mU0HJULmV5R+gMk29F60dIm8LFnzvae898QYoV174U5V5
         g0jQrfkojnMCb0id6Pu92KQwRDsSS3q7dM4ZmA6rVclkYls5oxpoo0MgzyWq8lQKlEdy
         YNWQtT2yV8xBq5aTd3/kncQbogJZ74FIvalZ/5qhpXsZTDMa2MTFQmXtncij8qLqZYRq
         OYjWB90OHyMKayHZKCQhXIiSa/hJyqDXRA11Q+wGDuBwAml6qM3+7PPR21tYmO4AA3gd
         HWqQX0BZDA+9/hcbPg3cKArAkssFNmT6UXNp8+CNN7Uo9UpMKBCrj6zx1cLFLrkNJl31
         MORQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYPmNpHegsRrflk0ZtSDT7ricxEMTPTwCyUc5js9YEOR/vU33wK4vP2T1LX9ybByWv8lcb6F+aVJkqH3fxcIdbcHJmhPa/Hh6qF7h8
X-Gm-Message-State: AOJu0YxmD8ICSr7M4Owx6R76clmxusKVtYYrm3b856wWPSHm1BYfiGnb
	9GH/HJ4d4Qstwr+iOq1XBskWjNN8fXc0gHvE8/xGZW/DrV4LKiB/cE5/31+Gf4o=
X-Google-Smtp-Source: AGHT+IHm/wmXAJCdAIcmk8VCIZUos9PwX0mRIoscbcVEURvjgXYI0XxqavO7+97e3hMh2fhIDT8haQ==
X-Received: by 2002:adf:e6c5:0:b0:33d:1739:aed3 with SMTP id y5-20020adfe6c5000000b0033d1739aed3mr6147704wrm.60.1710189646093;
        Mon, 11 Mar 2024 13:40:46 -0700 (PDT)
Received: from rex.hwlab.vusec.net (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c198e00b0041312c4865asm14929355wmq.2.2024.03.11.13.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 13:40:45 -0700 (PDT)
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	linux-kernel@vger.kernel.org,
	Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Subject: [PATCH 2/7] scripts/faddr2line: Combine three readelf calls into one
Date: Mon, 11 Mar 2024 21:40:14 +0100
Message-Id: <20240311204019.1183634-3-bjohannesmeyer@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311204019.1183634-1-bjohannesmeyer@gmail.com>
References: <20240311204019.1183634-1-bjohannesmeyer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than calling readelf three separate times to collect three different
types of info, call it only once, and parse out the different types of info
from its output.

Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
---
 scripts/faddr2line | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index bf394bfd526a..f011bda4ed25 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -105,10 +105,14 @@ find_dir_prefix() {
 
 run_readelf() {
 	local objfile=$1
-
-	ELF_FILEHEADER=$(${READELF} --file-header $objfile)
-	ELF_SECHEADERS=$(${READELF} --section-headers --wide $objfile)
-	ELF_SYMS=$(${READELF} --symbols --wide $objfile)
+	local out=$(${READELF} --file-header --section-headers --symbols --wide $objfile)
+
+	# This assumes that readelf first prints the file header, then the section headers, then the symbols.
+	# Note: It seems that GNU readelf does not prefix section headers with the "There are X section headers"
+	# line when multiple options are given, so let's also match with the "Section Headers:" line.
+	ELF_FILEHEADER=$(echo "${out}" | sed -n '/There are [0-9]* section headers, starting at offset\|Section Headers:/q;p')
+	ELF_SECHEADERS=$(echo "${out}" | sed -n '/There are [0-9]* section headers, starting at offset\|Section Headers:/,$p' | sed -n '/Symbol table .* contains [0-9]* entries:/q;p')
+	ELF_SYMS=$(echo "${out}" | sed -n '/Symbol table .* contains [0-9]* entries:/,$p')
 }
 
 __faddr2line() {
-- 
2.34.1


