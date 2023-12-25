Return-Path: <linux-kernel+bounces-10973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B534581DF7A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 10:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46F7DB20ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 09:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318161118A;
	Mon, 25 Dec 2023 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="IAMdZK4v"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557CBE540
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 09:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7b913830d8eso164545239f.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 01:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1703496545; x=1704101345; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rM3L8/KXyNSKVF6DKDu5/tgBl9vyRql4RKhzWcWNp34=;
        b=IAMdZK4v2DgkCh+nxJniIxfQp1U7Ed42ezYPtesOiw4cZtugjjeV7WBvQ26eggt5VT
         tyUm6IMIVLjZvHf4EvXwOgwhWokJ60EFXj4qSPwsBtoOAec7Yxs9xKUQPI6Baux65GEI
         1m/ql9Ga1Clh8c7kHIiPzdHovG2gVg1psavo811zzyw3aQKhl0c2fW+w4ussQaqtewMw
         aGCqZnx9FOfZQbj6qJaoIqPzyaDMFvstykhIMHLoM/YREjNmIVWYchpBcjtpM1XJOx7J
         U4HoK/RCVFM59XwIkAy9Y+Kky2bU2VnXnU3hTaOxSJ+K0xN5JBHw6aY/pdFUEk4fpTfm
         Qlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703496545; x=1704101345;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rM3L8/KXyNSKVF6DKDu5/tgBl9vyRql4RKhzWcWNp34=;
        b=iirEDQztrmjEmbDMmK4LyQH0Qwo3kySjBdx+FkQeiV4GCxZJREj9f2+VYXYLK25kl6
         LWSaom4tR8oc6BsuinxyYS4j7kjmI6dM2iq4Wk7a4iT02ktoIdXXWR0pWRQUfg+TVRsy
         VWi/d9R0XeU16KA9XDdky92o3MHUqAyJL/kibQpCQiAkbsTWqAKESH5A+elNHYGk1cQU
         ekEL2K/n/FoVmmf/4+9p+Z3GZS3qN+BaLpyAgFSHfF+yeRbeMKvVAHGRQfCm+TngTgZU
         N8QA7f2eXwQ3yddvB38WnlHc8hCoJFOMCdCjL4ncjOP3b+dkbpqqBil876uQD5xyqzql
         AEtw==
X-Gm-Message-State: AOJu0YwW6nYzK3Hqk/dEvcgkrIaa7QtUfwIyWpcNq02IAn3rtXXm0dNb
	Dg6zPb4BYFMlYoNSX8pH+4dY/o7bgKS6gQ==
X-Google-Smtp-Source: AGHT+IHswuLbWFKWVyxQw9iVsv7e0nhmJv+NQhgMEIVwhya1dkcNSvL+xxHdq92XjCodwj5kFXFaNQ==
X-Received: by 2002:a05:6602:b90:b0:7b7:8429:68e1 with SMTP id fm16-20020a0566020b9000b007b7842968e1mr6333981iob.20.1703496545279;
        Mon, 25 Dec 2023 01:29:05 -0800 (PST)
Received: from ubuntu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id l16-20020a656810000000b005cdfa6f5aeesm4393267pgt.94.2023.12.25.01.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 01:29:05 -0800 (PST)
From: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
To: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	robh+dt@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	dianders@chromium.org,
	xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [v1 1/2] dt-bindings: HID: i2c-hid: elan: Introduce bindings for Ilitek ili2901
Date: Mon, 25 Dec 2023 17:28:42 +0800
Message-Id: <20231225092843.5993-2-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231225092843.5993-1-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20231225092843.5993-1-xiazhengqiao@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Because ilitek, ili2901 needs to use reset to pull down the time for 10ms,
so we need to control the reset, use this drive control.

Signed-off-by: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
---
 Documentation/devicetree/bindings/input/elan,ekth6915.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
index 3e2d216c6432..b9e51432b9e8 100644
--- a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
+++ b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
@@ -20,6 +20,7 @@ properties:
   compatible:
     items:
       - const: elan,ekth6915
+      - const: ilitek,ili2901
 
   reg:
     const: 0x10
-- 
2.17.1


