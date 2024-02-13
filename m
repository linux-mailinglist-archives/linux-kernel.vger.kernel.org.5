Return-Path: <linux-kernel+bounces-63930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0859853683
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31CD1C22405
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E465FDD8;
	Tue, 13 Feb 2024 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpjM2CsC"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9005FDC4;
	Tue, 13 Feb 2024 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842820; cv=none; b=T0uboLj10Cwwu/Ng79X9uO57UMWj3sHmItQszTZpseg9V4Qy0jJoS3Z+SY35E9Cy1VO3uXtNaYqiZB0I+DTRPQkoyrb/rQPBESnPlc7hgf46TB+EYfl54fSqXk9fKIsrBi8eEf22vWhlsPN304JYjxRa5igXcmxTk20Nni5cKqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842820; c=relaxed/simple;
	bh=geJKg2I7LNYdPbFdc9UH/iCmUpyiA5IJaHKKy0d92EA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Z17SeNBlkvhG9jtUQTEJC3qBmeml+nMxXIgMf94pDI1qarPXmUnCMZZgRwWoXzgeCrmgSyQB3HF2/3jDJSkJE0XqLlOi9qpzlmUOXCAVXx2NXEB4HgT+VulaA3KI6Rbe5rYvjIzOmiFfMbXEtpoTp7m6dF5kT6RHJ5dKr8RurtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpjM2CsC; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-560037b6975so5081135a12.2;
        Tue, 13 Feb 2024 08:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707842817; x=1708447617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jt2WxlQdO4fysvQIUvE9sZzH3jia5VewAudv21NzUl8=;
        b=CpjM2CsCO1uO2WgJ7FOxf2E3toV+6tCizgtXsNeSU6YKUDmD5xBwayv1EiAnrdKp5R
         KP411laMz9/KF+FlZf1bRH2tPmfFXwKh0vF8oAm/XWEkL+jFduEgSmkgp5+k/X+Q8Kwf
         dDNVH27dqCmP/tzuEwGhlZMP9am40uDMhEYnraiHV3NVFpRqC9mBUa+B/1x1HTYuyiec
         vkQqEccgQIo70ShpIosCDbzOscxDAWhBhXZQzkmp1SKYFm2uQJTdxvreEy9ntYCIB7RC
         LNPS+NHE/ceqbKYm8si9C3j3Sj0pKpeZwgehbggNRpe68jeKj+P+UgZRK5tuBh1shJtz
         +H6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707842817; x=1708447617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jt2WxlQdO4fysvQIUvE9sZzH3jia5VewAudv21NzUl8=;
        b=QXRQkA7eWS4ggzBexx/WchCCz1I82sRD1guJQL6zC298WcNvraKL6TfnCS9/9m6eWh
         4mqZGMD4dsbqAWWB3+WwxoV2WOw2pq3OplEYp1w582g/1XgN4EVOipCpDqVWtJHS4r3b
         fEtshH7N4mt6OkWx92R98s1WueDNdDbZTgKc9UpP1mElUgSGDUsnzbJye8nkx4E/lCjv
         LHnjqXNa1AZODZc+A06NFAdWprdpRNrYKU1iuR3m7Imhb1y0B8A8YipaSpioH42OwrJm
         fs7NBox9iHEnVFsMcPc2KLY6bRS5wgpy4VeWyG21MZVtWe8m0U+0BcB41uPQyc1Pk5sA
         +wjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTLtI8nZwQ+IVCXbZnyUhXOJk+UtZRABKfXp+svybZh4Pt1FMb8XVAegSKGZ+KFD6Ul8dOKplKYAg60BRNgOcYUErSTyZcKQnziDzUohVQYDm5Dxaw4z31qi+3qI/OZxHSX9N38CQYfgeCH2mEqizJ2zz2PDIbzAu/t0kI1NQGsLXXDA==
X-Gm-Message-State: AOJu0YxSrNFrOT2FezGw5Uo/iEPF+1nvp/3PKdPQFoER3guzom437Pf5
	QevyDbvEXy9dUqnpw5inrC2AlTJFtlAgbaI0M+y1pQ+MHaC2IWNw
X-Google-Smtp-Source: AGHT+IEOCuvXmALVsWy4q9bGIKo+OXF34mZhyPYSUBl6z9/EoOR8YE2mtz0a0xXVLC4slWArIRenxQ==
X-Received: by 2002:aa7:c40c:0:b0:561:1917:eb9e with SMTP id j12-20020aa7c40c000000b005611917eb9emr150247edq.35.1707842816518;
        Tue, 13 Feb 2024 08:46:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUp1qw97K6riBY5hQWZ39Xfd6wBeiupyxbDZhQ9Tw0QXIGrw09l88kbuSjt4WSUlnYTmfmDSo+5AG1vhQGUSPSmPYVmd2kCMAlXPM2tOdLdoUvzGq/VqyEXih48rOYxOn0LW/aV+jnI3nF32md93O7aqg52dc+zOzxx2SnoDllN1R2MX59F1wwDQPTa8jGYsqWhxmp+kul1yUbi9XKt+cIbCH3pD4zRPFfbnTnRxrJ3RJkiUqu+ZL6wSqR60kXr1yGS9LWTCREp9hK/uxr92f9iZ+HetZHfE3FdkncOrnxaFxzGwqBAPr02WfachN0NWEyYzulhEUU5eo6axA6zyHE4rokQMd8a72hiAsD2ZvxLtWNirXV1bmioFIJfvLwNmVsL3kx57P/I1Gn+RGDktMP3UnRVRI0D2/APSMPtsNlfPW482lxJ5TcHsWExx7/Yh+vO2VlQxUQhhek97SlV1qJlsHmyYBe7DiYHxLHtMchQX5yHK5Pit6oWnTem22k/g7bmxsIUdVOP7PTHeOaw
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id v10-20020a056402184a00b0055f0b3ec5d8sm3863582edy.36.2024.02.13.08.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 08:46:56 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: John Crispin <john@phrozen.org>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/2] dt-bindings: pwm: mediatek,mt2712: add compatible for MT7988
Date: Tue, 13 Feb 2024 17:46:32 +0100
Message-Id: <20240213164633.25447-1-zajec5@gmail.com>
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

MT7988 has on-SoC controller that can control up to 8 PWMs.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
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


