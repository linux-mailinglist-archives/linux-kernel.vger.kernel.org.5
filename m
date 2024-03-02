Return-Path: <linux-kernel+bounces-89273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6E486EDA5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A53891C21D29
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D225244;
	Sat,  2 Mar 2024 00:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="T1NvoCAM"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A544A32
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 00:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709341052; cv=none; b=FXfDklfiC324zzym5EkAXKmsDnvubs8bDrXT6xv+i3CcwgL7Z9xcQxecpuK9WVmH1eeIueFPzklMmOERqAK3qDm+YqVsLm8VTlp8IbH6+MnmV3zjo/XsTGIb8HcHRNoC25Svz5KzUZwS+ZVoUQteDFinZ+9Zl7w42ka3oZluzgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709341052; c=relaxed/simple;
	bh=5NeWRhfqhllmCD9mFMx/PgmwIdXK3vIcl4ByQ0zu5TU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uFT8QZQTa9OQs0UL3kd4MfGYcMAe/Jg/h9prG6nbRVCdu8a9YTTXhBg/7M/D0v7cZE5HghZNAD2t+NpgSfFy+NlV6zezpPMQlNANPC4S4y/KNTRVonHY3nFUEd9ItP4nDvGzAbLZP6nuPh5Nd/UcD9ZLjzzcs9FlAhpu06fa2fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=T1NvoCAM; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3122b70439so459080166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 16:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1709341049; x=1709945849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XfkelKUHIIHCQK6GQkZSqQAl8iGPsieC5jUUCHXhVW0=;
        b=T1NvoCAMttmKhyE1F7y7Eq7lqUO1/dtKM2PWUxAxP2AkqEDhTQJ/kLpclmIRY1rXX4
         2DrR3Jd5/5w8Iyzo73Fdjgb6c7ZE+jvblkYmAy/pr4n4hALFoy8beCUUEKm98YjWHwG0
         Sf55qoers/6KUoLWls2Ojhl0cigdnW0S1ZXUMy7IBCxZR7idVJRDtIHHcKXr9N6jLIx5
         TFe7HLytSjP6gwTcVh+E0aoyrfdZWR3PwM0oEYSdY1DkDtkMjMcyO9IWzGbAnuWmYRlG
         HXzvcaOhI56vCNcgzd7bcKKP2FtwSZpctGWEuiaNRckWSmy9KQSmiBFWtDwQRCg2tHEn
         bAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709341049; x=1709945849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XfkelKUHIIHCQK6GQkZSqQAl8iGPsieC5jUUCHXhVW0=;
        b=ABsk9QeN6wl0j2A/3LQbT1AtdJuGHp2iZc2Cl1CPw05xMx+HbsdLogJXRsmU++o69q
         IbUorlXspsaziGT1R8qzqDaApvRazeMcEj+SyBQ8XnLntgrMptpvWIQbRV/VCensB3hC
         tyC1t4DIt5dA82zP3FqKrcu0nN7McpJh0bYmLTNedTu2hWg4FeK52sYtPxjOI67A8xhb
         ouEbHDD4YHwxAGsod6WxMcJ9m/siZ2K/gJnJf1lDrfwdNjI5+kl0ZBF7kVfiiooqNsbR
         bC3EKbJ9NUAcKxgHvNZyZd4H+WMatAhswyrMJgOf7W1c5qX/LGhK9qOCg8jr9v10LolW
         oIDg==
X-Forwarded-Encrypted: i=1; AJvYcCWrLlFSfroqp87gtNOjuZ2bAB5zh6YwXqeJuvaKKknG8sH4yGngJ4gdPmonoVao7XDlLluLY0ve9ImOeHqTBNF2IHG+RNb9GREgx4pp
X-Gm-Message-State: AOJu0Yz5O/661QwWe3Jqt+EjL2H/TN9mcD6CAbolOYMZ/MhScFJt7vSs
	xxd2aS91fDMe8P4CxBjjYXxqBkJNhrb1dhuYxAdIix0h7r2VxQL3Ty7bTNIsKlY=
X-Google-Smtp-Source: AGHT+IHCSp7S1z3p2QExM8xCWQEwzBwSLu1JprvqTg2FQC64lmgA38holXeFo9lsrS/n5MuIyoc8Tg==
X-Received: by 2002:a17:906:a84c:b0:a44:9a5d:2be2 with SMTP id dx12-20020a170906a84c00b00a449a5d2be2mr2186969ejb.56.1709341048786;
        Fri, 01 Mar 2024 16:57:28 -0800 (PST)
Received: from fedora.fritz.box (aftr-82-135-80-35.dynamic.mnet-online.de. [82.135.80.35])
        by smtp.gmail.com with ESMTPSA id u22-20020a1709067d1600b00a3d2d81daafsm2215372ejo.172.2024.03.01.16.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 16:57:28 -0800 (PST)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] libbpf: Remove unneeded conversion to bool
Date: Sat,  2 Mar 2024 01:54:54 +0100
Message-ID: <20240302005453.305015-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes Coccinelle/coccicheck warning reported by boolconv.cocci.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index afd09571c482..2dda7a6c6f85 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1801,7 +1801,7 @@ static int set_kcfg_value_tri(struct extern_desc *ext, void *ext_val,
 				ext->name, value);
 			return -EINVAL;
 		}
-		*(bool *)ext_val = value == 'y' ? true : false;
+		*(bool *)ext_val = value == 'y';
 		break;
 	case KCFG_TRISTATE:
 		if (value == 'y')
-- 
2.44.0


