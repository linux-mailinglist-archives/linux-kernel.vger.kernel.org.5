Return-Path: <linux-kernel+bounces-88360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8F886E075
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CDB5B24286
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76046EB47;
	Fri,  1 Mar 2024 11:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPkJaUyw"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF536E2BD;
	Fri,  1 Mar 2024 11:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292924; cv=none; b=YV/4LJo3EtubPEUqeDq9+bpk9ngWXDqjAPiVbDBy+/5gWW+7nuaNxlnmEHrtHR2pYBVkDt3V0lQOfoyyLmdB2bvMlsYZrui6NTzhOV18w0q3PDFq0J+Q5d2Giyg7VSMAFIfRnxnscxYmIRrHVwLi8g0zXwlDm3q1VJMNVZZVUdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292924; c=relaxed/simple;
	bh=3p4HZ3C6lOgMZhrP29rO9tuvpZ+Znwb2y/y2EEATIj8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sx1AVCot2j54RGVBS81CzEFSdwn2Hq4ec7uOaOryRPVCoZ8mx9I5bwtJNGbsCOGVMEb5hglGOWhpVWnnvxLaslq4H88xOWW4ybFmNXIjCaId+f6pqe4Sy8Qm4KHv02+hPyzOIErLbNskp+j7YMB41tqdRwKKJ+kriuxkrJ5xcN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPkJaUyw; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a44665605f3so177999266b.2;
        Fri, 01 Mar 2024 03:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709292921; x=1709897721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxqbj/ocA3XTw0PwIH6SKfo971zCPHh+xqWvl5TLr3Y=;
        b=YPkJaUywSc9Zk2atBLwe0Yw8ovqzMpFpylBmi49rd9PUeCh8yaZzwlQoxGgYtmtUd+
         dJOKEwRP3kQLw/SayBOUQMWavnHOjdqPcU7a9IqI7ckPnqU7CewhgaODrBeWX0oB6T4v
         M4qx6ItWN2lKNPmzfx3ivY5wjLoJE2Ms4Ix+0if/TO+j0xQ6hBaZkvK9BbMcnZiIqw4E
         Wps0rfOroVMT5uQR3hOfhqmgMSKw3lUAPzSMDlyp4CR74dOavV9V1yYPJEqjWX/W7JLG
         1VE/mD2F/eEXZT1E/IJYtP8nCBpNor3VPF9QMiqRPn8XyphMdl7iJhkG9xo3WYkqtU+/
         nOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709292921; x=1709897721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxqbj/ocA3XTw0PwIH6SKfo971zCPHh+xqWvl5TLr3Y=;
        b=iUN8BjIWelzEal+kD6AVQiANCBNT5QJUzHe9387Uq6+jmjCimc9CGjp1IRUy8wvzGC
         FUce4QFyvBLB5pRMLz+MPoBvmZFwbxlwyDv27oTxNbs7eFNPZZL6T1OAsOptFZi4ic8D
         FNyPGNwaxZmcFdE++UGaAH0trTBoAFPUIwJ/5COKh1puVJXVvoOTdceG+XeNm2+k/8YK
         AuGhqyy1kBwR4GbAwSdiRR2CaCJUIZ4RckZYhH6VLd9Paxjw8ShjZMTIx2LNZAFhhmen
         6OTrtD0rJEv3K92LK5eCDxeNwxJh9rIhGD2Lr6ZmhfbhqVp0YkNhQ26oV68WlzX43e82
         mzwg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ9S3pNK6VZcM7XGFqZxMk12T0JxQQ9UgjtAtRrXJ4lUsVXqKR2oIOZVBpCsCjol69fAieo7Z2900DxsEzi/GldOwaA5nLhXX87mVJ
X-Gm-Message-State: AOJu0YzhqTSvYKreBglVHpfEqVGWPt4cWEWz01lRdsu667FMFi3fzZp2
	2LJFa/2aQa4bIsdlmHyIXHs6LOblPw0X0+Gkmko3MpegQw6gERV8
X-Google-Smtp-Source: AGHT+IEusKw5AANSYydo35dgANjE1ZmVrxajIOk5xAKaQw6gjEeQtPFnEVp1cHheO6ADgKYdNu6tPQ==
X-Received: by 2002:a17:906:2313:b0:a43:fe92:f9b7 with SMTP id l19-20020a170906231300b00a43fe92f9b7mr1121278eja.3.1709292920767;
        Fri, 01 Mar 2024 03:35:20 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id st11-20020a170907c08b00b00a3f5c39bf2asm1618457ejc.0.2024.03.01.03.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:35:20 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 4/4] arm64: dts: mediatek: mt7622: drop "reset-names" from thermal block
Date: Fri,  1 Mar 2024 12:35:06 +0100
Message-Id: <20240301113506.22944-5-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240301113506.22944-1-zajec5@gmail.com>
References: <20240301113506.22944-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

Binding doesn't specify "reset-names" property and Linux driver also
doesn't use it.

Fix following validation error:
arch/arm64/boot/dts/mediatek/mt7622-rfb1.dtb: thermal@1100b000: Unevaluated properties are not allowed ('reset-names' was unexpected)
        from schema $id: http://devicetree.org/schemas/thermal/mediatek,thermal.yaml#

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 7da4ac273a15..9d19dd8ee524 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -513,7 +513,6 @@ thermal: thermal@1100b000 {
 			 <&pericfg CLK_PERI_AUXADC_PD>;
 		clock-names = "therm", "auxadc";
 		resets = <&pericfg MT7622_PERI_THERM_SW_RST>;
-		reset-names = "therm";
 		mediatek,auxadc = <&auxadc>;
 		mediatek,apmixedsys = <&apmixedsys>;
 		nvmem-cells = <&thermal_calibration>;
-- 
2.35.3


