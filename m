Return-Path: <linux-kernel+bounces-39237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC99E83CD3D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B96601C23DF6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960C2136674;
	Thu, 25 Jan 2024 20:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="B3gd0AC4"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AE2135A5D;
	Thu, 25 Jan 2024 20:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706213795; cv=none; b=Zaccve7PVURaAWuwZ83unLFvdP4uyQjpNCdxbjCzcIhr2zHL9moj/A/FT13IHVUIM3l0fc7C+J0WD+rJGVO+UsjhMB8qC9HvzuCzS9+FWDDRr7XXoH2xTeEqGaEIIez0wtX/0MrrheatxgS3uinjYBlmhapGNW1Mxo7+OC92p/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706213795; c=relaxed/simple;
	bh=i63TgTWD8kL/R1vxwHY8bfZpaTN1p4slFVLxqc2gfq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=amrK58lQdhMUFS1cV2qSljC+GldQ3xeboWHwk261IqvDlHQlQQ0jSLQ3wI7DkE5Q6ya9g5ke/ow+aO3/d3qIm1TfOv5CDGSMtlLiV16Iyt3pi3Rm89BswuTxcctvHYt3vmRt0KAP6utdCisnjiO6Klp7Z4IFmdWZPztSSc4qlBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=B3gd0AC4 reason="key not found in DNS"; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-362a24b136fso3027735ab.3;
        Thu, 25 Jan 2024 12:16:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706213793; x=1706818593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eP6syHlZSO3MV3pmkKXM2pg/pvxUb+MsM9lc01Ms13Q=;
        b=WJP4sJtIWxUVnP2pbEARL1jnSnBJo3q5/k8vwmaGQHafWaekcp/aaX93V1VqLPORfM
         QN3GZlbPd3KUF9fqmKN6QGVlaC0hcmFgqpsGwQPB22rwSE51ar0RXSC/npDCvIUn/Dxm
         i5hmE/LP09qozu3RkPP/8tfgGJAf9RfL5A6+y+vD5tOos4+hvGndKoTG3PNAZaNpABRc
         ZKeSxdntJz8uLk64HyIX29mBdNvykQX5JKLaiZjhfDC/Qxq8+bqGXHL3PI2udGagXjjs
         /t3OYms/Gtx0gFlRClCcPmxAuCBwkTMZZ5POruyvtvAiplN1gSiJ6qFV9n/Q4BtTMFOr
         zTKQ==
X-Gm-Message-State: AOJu0YykGftnpmAXPuONLz8xPfag+BrfAAnwhzeJY61j5MLHfW5Yk37l
	DB4j61im/dHUz9eyYQatimbP5DeEg1ZtfACGTGX5KL0GT5En7TMY
X-Google-Smtp-Source: AGHT+IHxPtb3gemZL68RPGRFPyVoqJoCsNaZAO3s3hHsN1WkVpS0ddihT3XcIZP6lrMtqRpKegrMcg==
X-Received: by 2002:a92:cb44:0:b0:35f:fb45:a9c9 with SMTP id f4-20020a92cb44000000b0035ffb45a9c9mr308268ilq.31.1706213793176;
        Thu, 25 Jan 2024 12:16:33 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id y21-20020a656c15000000b005d24e5ae4e3sm4531831pgu.2.2024.01.25.12.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 12:16:32 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706213791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eP6syHlZSO3MV3pmkKXM2pg/pvxUb+MsM9lc01Ms13Q=;
	b=B3gd0AC4FZSl7bJxRkmclm8eUbSczLn71mlejCR2ttryi7vNturVwWw4A9thasFlb4y+WT
	VOEc+x/PijmRS6YDFRlTLzZ1VS1qlAScR7acI//w4YaWW1QxD2ShkbjDTli9Po3seZqISK
	w/lS3R5lP+QrGZyfTr0Dqg9JcA+6/g1OnBC1ifGd0ImiNLeIuPMXeEGikozYn57ku8UhIv
	Xm6qCPnCriSF6bzZqnn+XwJYRRUuBn/SNrhfuSywoQ0ZkwK+y8nQTHFgT1FfmQHItiEs+E
	Y0lVX/KeRja4S9pF9vsEw3MA63sg+OZUATNyGdqn2ey7WoCsQ+nIro7fMehKcQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] add trace_seq_reset function
Date: Thu, 25 Jan 2024 17:16:18 -0300
Message-ID: <20240125201621.143968-1-ricardo@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is a prerequisite for a later effort of making trace_seq more
flexible about its buffer size. To achieve that, initializing and resetting
the buffers need to be differentiated.

Ricardo B. Marliere (3):
  tracing: add trace_seq_reset function
  tracing: initialize trace_seq buffers
  tracing: convert __trace_seq_init to use WARN_ON_ONCE

 include/linux/trace_seq.h    | 11 +++++++++++
 include/trace/trace_events.h |  2 +-
 kernel/trace/trace.c         | 24 +++++++++++++++++++-----
 kernel/trace/trace_output.c  |  2 +-
 kernel/trace/trace_seq.c     |  4 ++--
 5 files changed, 34 insertions(+), 9 deletions(-)

-- 
2.43.0


