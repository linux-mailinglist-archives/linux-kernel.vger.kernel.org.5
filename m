Return-Path: <linux-kernel+bounces-65315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 365E5854B0A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA7E282178
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD68354F95;
	Wed, 14 Feb 2024 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enzfK2AJ"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6387D5467A;
	Wed, 14 Feb 2024 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707919505; cv=none; b=uUoeW9arPHLrpYI4jeMjVomJr0Dca/w3J+cmGkmLHiIh83DcUlN1yza1iucvrxN8UJR7Kyj99DJORAPh+BdGNGVsVygMY3ap3xvf8ddG7CQYVrvc7VCNEe52oZFsMqbK3juYxSw8o7X/tYHnPskEkznWyTKWgvlWtCpGsxrEMnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707919505; c=relaxed/simple;
	bh=XTHsakMKCRvGMeYX+V9AYEltoRSA1pIrIQBwCDAiBXg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=T89zSXPJMDvBwAgzNXN2hSNFDM8v5ANbI5R2LDXsdNL+WX1E9Xvdd7OVzID9ZVWhwOhIV7980tNWJaSl6hrzVQ0Ztyz0keqqy5/rM5w7fMJBAEipdBwEFQ04SGXve/BPlTprE29NE82rmosZao6V47IQl9nNAfgj0qrFZnCFqbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enzfK2AJ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5638dbf1417so493729a12.0;
        Wed, 14 Feb 2024 06:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707919501; x=1708524301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z7Q1BpdFE96j/+901jCtibE5f/f88ZZPNniLXRQM0DA=;
        b=enzfK2AJ7PAsh90saisXmtk9KmF8WKUlCesV602TvNxpl5beHjDkrbcC//VVO5DPdy
         CsOJrWWixYDj3lcqHxk3UUSr7NCjpp/uMC6QF37jPlbAwcUuPwRS2MwMmNrqqtdRAQU3
         GONCX1H6GqRNYCOBwIPboGhMvs0KZemKiMmGBL0LXJyORvocxBj+9XZTebr2qx9aMq+9
         vttBtlf5+4B+7jMmXeJIh1nsN4tWTy0Vvg6Q7V0AFL74yCP6GiXZSA9HUVbJNV0t59CG
         iDF0GuRRN+IslOsd7E1YNDIhkU2rBwiuwERjUwWz5Mv9mnwOAFA4T7y/1OYuhbzFk9cz
         bHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707919501; x=1708524301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z7Q1BpdFE96j/+901jCtibE5f/f88ZZPNniLXRQM0DA=;
        b=NgSyfe8KhlPBI756W1tz7eTyR0Zbm4GKLPOmS3Rm18Zzp82Tv6WebzaQq5qUeodii7
         5e3eNKgu/owYYYdaJ49Y4gMkv+h9Ns9F5YiRkQL4qs6iBrJ765Rf+/b521G1L+x/sg9m
         OPIU7+yF28c9UGW8jipPaxlVMhMlqcISuluibMTHVnD4Rsb2psbLP3F4IeaZzEPFWGjC
         yFKSv/ZDyXY2ualfwq0fqs10RxFBjYbGUepqQQPiZw54j4Cwmb0op9G/HOTIUyrPPo4e
         iCeEx9UPoy7ZkmjgwndxdXz4AbmxD6Zdf//rSFOV7YvjgOOCecmZ/V7KAT9MGacMjlrJ
         xryg==
X-Forwarded-Encrypted: i=1; AJvYcCVlOo5Hsb3J/J0Jzu/w22+SwrvQqIx2RtrbTcNt6hr44spNwiJ7BK3ptlDPtAjF6iyaXJ8NOgrUlI47QanJXnd8OAA/WxGm9MWnWO/dEpw8nVcQhKhKt4Hf0MYzp0Jnx8JglQzu3lbWt3O8IQIWqfrawia0EMVcj+Qg6/wpomvGnVTflg==
X-Gm-Message-State: AOJu0Yx9Uh0+4zWZ3SneSa73AcmW/DOW6mMvlqKBWXkEB4zvmGkHGN6n
	BFN5cp7cwQVH5l4QvVhCq232cgNtHXXcrbaCOt1uojZmKDB1N0OkBTzSsKCz
X-Google-Smtp-Source: AGHT+IHV5lTBSsU2P4rgMTuePMzPF3w3ljb7dMNL+67Z2B7qY19FGGj9oQip/nDTMA6wH9kRqjNzqg==
X-Received: by 2002:aa7:c61a:0:b0:560:799:f802 with SMTP id h26-20020aa7c61a000000b005600799f802mr1932526edq.21.1707919501304;
        Wed, 14 Feb 2024 06:05:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUtmzNXaugjkX2Lbay0q+RsXHbXxui68JmgAB7AAmk4fN6jM65+wulw9ikFfckzf4uYl4dacm8xHp/v2UQatJoXIMh9DdY4tfvpVmwaS8QRN26anrUvaF40ZtJauATQNUIsMTq7FYNnfRokS3gSUXM2eLI33PzYCSVvpQiDHEuJk81vMeQX2XhGl6jYHsBVrk22H67C4u8N+drhgxpW2To1xIPETJ8yOjudZKLtwmBEIvy/VaytbZGFC5FcZQBMSl1/azpXi+FC16ov9Iv4Tz+CikGEFzMUZxfRTlukzTpTaSDTWrlC5aEYVUl0EaWshVPu+v9XjqKmshRUdwH7HGTkIprdv/AYXAXMiFYqDqplLuVKPHl/OmnMHinF+8gTyWy/2P6Gd8pfN09kXEM6KlzG4q+VuzFZHKCYPtrc72Z67u21U0VQJzM5lPAOlld1uLGGuJoHHWrhGCkvLqV1zYzp77iazMGiQSMqtOk1/a2fQuY13LupsaYThSx/+PlTPg==
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id p23-20020a056402501700b005614409022esm4700646eda.63.2024.02.14.06.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 06:05:00 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	John Crispin <john@phrozen.org>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 1/2] dt-bindings: pwm: mediatek,mt2712: add compatible for MT7988
Date: Wed, 14 Feb 2024 15:04:53 +0100
Message-Id: <20240214140454.6438-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

MT7988 has on-SoC controller that can control up to 8 PWM interfaces. It
differs from blocks on other SoCs (amount of PWMs & registers) so it
needs its own compatible string.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Explain new compatibility string reason in commit body

 Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml b/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml
index 0fbe8a6469eb..a5c308801619 100644
--- a/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml
@@ -24,6 +24,7 @@ properties:
           - mediatek,mt7629-pwm
           - mediatek,mt7981-pwm
           - mediatek,mt7986-pwm
+          - mediatek,mt7988-pwm
           - mediatek,mt8183-pwm
           - mediatek,mt8365-pwm
           - mediatek,mt8516-pwm
-- 
2.35.3


