Return-Path: <linux-kernel+bounces-143399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D468A381D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D6C1C2270C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630F7152181;
	Fri, 12 Apr 2024 21:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Pf7V8BTo"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5439E14F122
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 21:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712959121; cv=none; b=Bs2+2XXsQ8ctsNj9U77+Yq0qkvKE1/B5GIi9d5LGq+zJqiUAjfdS4IbusDyL7k7JjMHvvgwwWWMbMwIOuyXUMuJy90CCZ/209l4xy+xLjtlGIzBUqj+V9mvvBxvXjFIc6NwnirSum51PryBbVTsP6hlqZRlLVs7wMJZDdIT97eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712959121; c=relaxed/simple;
	bh=sUrCeSRuN1AgHGz+TliAi2YSUcHKJxlopXa8Nm66Vxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHn8YkSRLCcbqcOKuLVc8K2FRVgVLFlRcn5QfRhrEm7Y65PI6WjcBA8GXT4wfF5IVgsSvNqD6K8pqyTNECBY55viENfDLHrLX61juqzR3/oDnvBrQ94gPbI++7p27wFNn6O6O/ZCp5Uww/wPf9InQ/9IWiKJ7kFdzmk4/hpAIz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Pf7V8BTo; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41551639550so9163205e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1712959119; x=1713563919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJ32s1BONnzC61piCM2zghhCEX6pmq6Ffv/Ga55RjGY=;
        b=Pf7V8BToJVeLUrPTU9/1HMwPQkwM5kZZifP5cHwAmVrD9/VHlDUx9mbtja0LepHfmg
         l87PRM7r5UptdxKWu01zSmIINpMl3W9YKB8xU4VqzOwwACwfOSwVX5vXlywET91VQQ7/
         SfRk+Se0hF3VgClO7rpi/L9/+4A7bhBOX1yGWBPgjV/ZclozBlCEP0THweS1Tv4gHWY2
         zL64A9gFqACqrnBCks5r9bFtgwfvZCyhup+/8kfVt35SmbkjVvQe6e8uMmF0A6piwKLD
         z5KeCmhr9+sIbXk73mpb5/Wq3NvQmOknmVE7a7UHMXkbG2JJ8Eww5eEjjNC29pFij6Y+
         oFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712959119; x=1713563919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJ32s1BONnzC61piCM2zghhCEX6pmq6Ffv/Ga55RjGY=;
        b=aBeZwdL/UrraQOiK5NWWvtZxvIHZuSx5QqHMbudW6vpXp+nfelMb7GpFCAhb0Yz2hk
         t4ujAUcCQI+WLSZNe288hVBCXNBdeOd8jgPaDK/6vqtaMndM//p+oTI7VKnYHHciVQrY
         W7zaA08cqMbly3nnsp/+/CeoR7p/Wrum/jxP758ybcZ2Unpn1U9sPhWrwHTZoQxrnw1F
         wV6YQplGEgNADU6vEc2C2QXWxMQj95tuRcNNlUQap1kK98U0srxQel6iuWgBcQI/m9Ax
         JcyXqdAWzQyK2ehfAGFZRlZbT3J1ql4+7TqGl8HnetZK2N+0F/LQct1BDRCB1RPN8mmi
         6EEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbgDgUrq926eo4jVU4i0p5xdgjX/5e4CJH4mBbv7Oy9TxBmi89rK5z79jSLBQhDAkgeeVCxr43WILRA/DW+wk3CUlzql1Km1DpOr0+
X-Gm-Message-State: AOJu0Yw8eqZCLYkoscXR+0eqboFJdquRbLKFki6ektMqHR0iv5dhfV8M
	hoRBkXmLbU7c7txX0xGzUEL8aky/TGBUeJsUPYpSup9QDODDSeNqHfT6dBGnVvg=
X-Google-Smtp-Source: AGHT+IHV5fCe36SFn7L7PyMHbd3nP6FgtWZBD0K/H/INpxXjFgp9zRGGtBW0eioaeFkNgAT5hLK9dQ==
X-Received: by 2002:a05:600c:5693:b0:417:eed9:e29a with SMTP id jt19-20020a05600c569300b00417eed9e29amr3125688wmb.23.1712959118717;
        Fri, 12 Apr 2024 14:58:38 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id c18-20020a5d5292000000b00341b451a31asm5079516wrv.36.2024.04.12.14.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 14:58:38 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: thorsten.blum@toblux.com
Cc: gregkh@linuxfoundation.org,
	javierm@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	lukas.bulwahn@gmail.com
Subject: [RESEND PATCH] m68k: amiga: Use str_plural() to fix Coccinelle warning
Date: Fri, 12 Apr 2024 23:57:07 +0200
Message-ID: <20240412215704.204403-4-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240330175720.126122-2-thorsten.blum@toblux.com>
References: <20240330175720.126122-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following Coccinelle/coccicheck warning reported by
string_choices.cocci:

	opportunity for str_plural(zorro_num_autocon)

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 arch/m68k/amiga/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/amiga/config.c b/arch/m68k/amiga/config.c
index 99718f3dc686..d4b170c861bf 100644
--- a/arch/m68k/amiga/config.c
+++ b/arch/m68k/amiga/config.c
@@ -836,7 +836,7 @@ static void amiga_get_hardware_list(struct seq_file *m)
 		seq_printf(m, "\tZorro II%s AutoConfig: %d Expansion "
 				"Device%s\n",
 				AMIGAHW_PRESENT(ZORRO3) ? "I" : "",
-				zorro_num_autocon, zorro_num_autocon == 1 ? "" : "s");
+				zorro_num_autocon, str_plural(zorro_num_autocon));
 #endif /* CONFIG_ZORRO */
 
 #undef AMIGAHW_ANNOUNCE
-- 
2.44.0


