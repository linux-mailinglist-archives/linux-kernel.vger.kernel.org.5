Return-Path: <linux-kernel+bounces-6577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F3D819A8B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD511C24076
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7C6156E6;
	Wed, 20 Dec 2023 08:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MS1W87yG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480EB1DA5E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 08:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so966107a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703061150; x=1703665950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+LSOy3Goy6zCWTJY3GxgeKUH1EDGRsZP5XnykUKJ21Y=;
        b=MS1W87yGcmgGp2tNbaUxJh/qyIS88Td9OQyYJO+Kldr7ylQEnxNJLd2Gguah+MDCAr
         8YxJUOUWRyCXnCuoxDBaz6Gf4cFCNfOxYUBn1ApbCEQJoLJISkpeAVL5e1c0t5BC1Bz4
         G+QnDC6VeSvaWzrx73u3OzA6g/GD6/6uLkF9JVeMdSFimQgiG5DuZo/zpRZbM5m0InkR
         0SeAmCrH7GIIp23qJF9SZ6A/83TCn654grMWTYOKcdL+90fr/Zug11pTA2Qm/0/yqOBR
         MG/ATz1d0LjS4YKFc0k5GccXV3SVLKbTSuJGrdEJmht5LHbFfFX0HoxK1/3S6ObkpMXD
         DM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703061150; x=1703665950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+LSOy3Goy6zCWTJY3GxgeKUH1EDGRsZP5XnykUKJ21Y=;
        b=V73nCjy91f2oB9eYZVsU0NNFbLHV+shce3uNKPhUWrMEH8IFNxwkPe6pxZQRYHhMv1
         S7JKPOncE8YcekrRc9sjGoiOKFxPnjVa3gAdtKeaBfRwTcvdQm1Chfxjmc1nhZsuZNqm
         jBhr/8IIakAeqZjlvCAa7/0Iw51hbKMVkrCbRJr57uWmPZciBsgZ5pEx3SVyA2W7tvdW
         P+mPb5C9dQ2iBDDUiVTUfRDxff5j/WiEJcwxGBNogbzxqBQ93FNtzroX9L8rxKJC/eZC
         1tp3intR7s6wzc2QUHmEg1pWiKBfK+jJdwZNRVNy+dDcY+mGm47SJ7z978Eebqd1posn
         0fZg==
X-Gm-Message-State: AOJu0YysOaRA2fzI3f/+eWGqcxAPCcPZ2GVI34cxrNYZH/3rQZ09D+6J
	Uatbxv2fQjDdxUUZW8nwi+0=
X-Google-Smtp-Source: AGHT+IGpey6+mX2ufBqZOBqcECgUbO46e6sDWP/QwsDtCIEeKT9u4yC1ydAHq+JMM8V1Ia8haVeigg==
X-Received: by 2002:a62:844a:0:b0:6d9:5c18:ad96 with SMTP id k71-20020a62844a000000b006d95c18ad96mr1099942pfd.0.1703061150386;
        Wed, 20 Dec 2023 00:32:30 -0800 (PST)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id r13-20020aa79ecd000000b006d49ed3eff2sm6583815pfq.75.2023.12.20.00.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 00:32:29 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org
Cc: irogers@google.com,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 0/2] min_heap: Min heap optimizations
Date: Wed, 20 Dec 2023 16:32:22 +0800
Message-Id: <20231220083224.3712113-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The purpose of this patch series is to enhance the existing min heap
implementation. The optimization focuses on both the heap construction
process and the number of comparisons made during the heapify
operation.

Kuan-Wei Chiu (2):
  min_heap: Optimize number of calls to min_heapify()
  min_heap: Optimize number of comparisons in min_heapify()

 include/linux/min_heap.h | 44 +++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

-- 
2.25.1


