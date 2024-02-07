Return-Path: <linux-kernel+bounces-56685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B2E84CD96
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9EC292B04
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1DA7F492;
	Wed,  7 Feb 2024 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2p55Hkt"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9480739AEF;
	Wed,  7 Feb 2024 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707318210; cv=none; b=GLeBZK9+KnYW5SCIOkFIAqy2ItcgTvh9gflI05BCq6r4TO3qq01tYrUF5EYGfbEA7PlfcdB/HU2hBQcOJy19zVJmRWhz76d4ihuIk7go3jk//M/Dvg10PMHsU4J1KjIomN9rtBtM04Hn45DCqu9Y5RqNustVFtITjJwgu2lP3pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707318210; c=relaxed/simple;
	bh=MZsznxOPrdsYl6/DqekPPLlTdtOJsdHCWqZe3UWz1/w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lS+f7djHa2PpSDBWEhXoFMtc1/I023rHQ4B5ZR6gTP7ATv7bNHVRVdOEbDqno2x4ErJEIV4hFjPcC2p24PBkwLPA6aU5gXG1ZZMwx2fSmA9ezujogmGjBDoYN1XxMVJ5tGm18bqBmhHx4jLBpax31Z7Cy1v7YLnMT6Vqaczgre4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2p55Hkt; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so878877a12.2;
        Wed, 07 Feb 2024 07:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707318207; x=1707923007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xx4BeSyulnvLfMX/CaptrKTauc8MAXyxo+P2KtIiCQM=;
        b=c2p55Hkt2gOin4hs1UXOi3pXPef9BRb8HUoBaMU6EuhRVZdbKkHS/ZFYcM2/IUZ4dj
         fnsS/g8YKFg9Rx4/sjYZ2AFy3j3D1DB7MkA3IRuCdO8YvmjkRPZCzVDw93qxL+hflimU
         Gtsray0VWda8kOgBkJkB30jM42q4Mdi3+JmOVquXIQVjvSR7z/31k2otyZD1yNbFp/21
         udDAQWOuWpYhp7GKA0O804Rw2rseP4Xne0Uhdec7n4nujpaQJn/VFR9DhN9HANux0big
         2mUdzHQ0pLW/qAkNALi2MI0gvILZMmM03UQbliQYQd4dsEv6tMc9yYJbjJ/cS7rc8Zgy
         2JwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707318207; x=1707923007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xx4BeSyulnvLfMX/CaptrKTauc8MAXyxo+P2KtIiCQM=;
        b=NYEFQ8JWubSfzQDXsLILfShWbbVIZ1mQTVdsdbmQOdr+Ll1kMdgHezHqJkMBq98mjC
         KQ+40aSeoBR1ysUBQYr1+1c3yDUIYvWNlZwnbxBKhj//4wsn9PNMZ5JpcU03KESDPZ1h
         gOaNwoOZ1kvbJtLeD1amYgf4ZkRIe0H8rNkHrNpmcbvTqqgDrDuL7jOFNc1dHDtckN1x
         tqN6cmT0HNemwQSWC27uSjCqqJaXtU/7qYKjfio6jq8iYr998KcPI+gNcwctf9nfkiuc
         VCI5IiIm7WOyLbwK5gKu/MubEnI92QZYIDggpYfKv3VYx82zIZVfW1ToytmG5QWgnEAs
         zF6w==
X-Forwarded-Encrypted: i=1; AJvYcCU6kT5ILr/yFhwcayFrKaclyQ+UlvfZNSRzfX6cz9RVWlcgCn57wFE566bWwef/L8WLwhOT8k+XtNozCC6sdQOVVUJNSqQuDlf//NyXL6gZYhY5vVDbubTdjN+HWps7C0RqzW5F82lW
X-Gm-Message-State: AOJu0Yz6sIbAxZI296gu6rbIv5GhbLf4D25VhYGYyEB/smN6avqsnrUC
	eTDHey8+tK3VB9NOOfwtEGNP2KfCSZ7vNYlr2EjePOIPWGoAbLew
X-Google-Smtp-Source: AGHT+IGs2nMeY+j3CyxEcKu+uLOoreNgh5wRS00gAY/2oZtFnF2Uj/rDWRkilj3ltnrNVSSoAli+ag==
X-Received: by 2002:aa7:c41a:0:b0:560:4e74:9cf8 with SMTP id j26-20020aa7c41a000000b005604e749cf8mr4294934edq.34.1707318206610;
        Wed, 07 Feb 2024 07:03:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUYoPBO52sZpSP0p+CnRy0ZLb3llFXHvFWsCb58k21NC+SgvaO1jJ5fMdxlUZXDTrglt6U+TeYGyDqnEruF+I0zzylGnHXN3Isp7ZkNE1rdmH8og+LX7HHEJ0QmgBQCJjobViWVaserF7xE6wNKOOKa2+sS0wUG/aNwNfbHqUrB87zQUXwH2kWFNlae7njNV6A=
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:81be:a476:88e2:db23])
        by smtp.gmail.com with ESMTPSA id b21-20020a0564021f1500b00560df242374sm600834edb.19.2024.02.07.07.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 07:03:26 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Federico Vaga <federico.vaga@vaga.pv.it>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] doc:it_IT: fix a typo in the config name in RCU torture
Date: Wed,  7 Feb 2024 16:03:22 +0100
Message-Id: <20240207150322.20238-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This issue was detected with the scripts/checkkconfigsymbols.py tool.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 Documentation/translations/it_IT/RCU/torture.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/it_IT/RCU/torture.rst b/Documentation/translations/it_IT/RCU/torture.rst
index 79d9e6932acc..189f7c6caebc 100644
--- a/Documentation/translations/it_IT/RCU/torture.rst
+++ b/Documentation/translations/it_IT/RCU/torture.rst
@@ -129,7 +129,7 @@ Uso su specifici kernel
 
 A volte può essere utile eseguire RCU torture su un kernel già compilato, ad
 esempio quando lo si sta per mettere in proeduzione. In questo caso, il kernel
-dev'essere compilato con CONFIG_RCU_TORTUE_TEST=m, cosicché le verifiche possano
+dev'essere compilato con CONFIG_RCU_TORTURE_TEST=m, cosicché le verifiche possano
 essere avviate usano modprobe e terminate con rmmod.
 
 Per esempio, potreste usare questo script::
-- 
2.17.1


