Return-Path: <linux-kernel+bounces-52349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C20C849703
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCAABB277DC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E7913FF2;
	Mon,  5 Feb 2024 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="SP27NyN1"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB939134A5
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707126708; cv=none; b=q2PQXgP3qtsVzlbNx+TEQ0zvGJ0EIv4zsCm2rSMhG1HhWPSRFNKkhs5zHhCa+sS2DgtysF1m7uFyIK/B//1Kw/H0qLCbF8GSnbeG91vmJ22yyLac8aAmaRWnEo7aBhxSjyEudV5QYhqF7zSp9OLe7uHYCut/BbDWHwPGghsSKmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707126708; c=relaxed/simple;
	bh=ty8WN63mt50YPdGFaXjaf2SluhPVzZf3WFRAX94nEFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qrG1eFUaNqzdccv1UBxvn7fuPD7CpiSjdqPApcdO3lhxSOVp1/sDKi3dgzzxZ+zDs2tSCl3kl97rb4oS1Eg0fufoAiemY1+Qwnd9VWp6c8SjKKGsp9BRZrdBLKMcMlLU12NyOAoJ5NVrMPAYi6OKmtH15xOmIxYO3G0y50GiprU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=SP27NyN1; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3394ca0c874so2921192f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1707126705; x=1707731505; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IbKVC/6rW/A9zlEdDawOO5GD/uHrSUeNWUBFrySamCY=;
        b=SP27NyN1dQ2HZM+rjdr8ZIPweBroYzQKwsLZwBdQrtLKyjsW5LeIdQ6z07XCOCPk7N
         Blq6CQ2IEN3h5QD0G8NYLHVuhcfDGoiAsnYtWv0pX3IALAbICHdqKVz4O0bZEjkVTt/6
         1gjZbo4FNd8DwNXKrrTry7bLoX9eb+o5FK0bJdHab6RfVRWMfdrtng2it0ZnlXI1SGA5
         jweALgOUqp8X/3Sl/jJm6PcplNmsL7b+SdyQi8IMBkH6JAWhlNFE71OI+8si6uf4H/aZ
         lpf9Vzs7lxoDSV8La9gHjsNzn6fa3X3xBrkw+cHBJ/68k9fUhAjw29qJwwiVhfAl6lTy
         NVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707126705; x=1707731505;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbKVC/6rW/A9zlEdDawOO5GD/uHrSUeNWUBFrySamCY=;
        b=elVAa2gDEIdHrD2b2nB3C/ZNgbBNWR2/4/kRzXrFolPgpdcTB60XaCi6i7u7rRayms
         2n9Q70y43EJN97/RFKX+0BmOtFPkYCKPeES6jXfisMySG+Isyyl38JfmVLLbhT+WYf0l
         nI/fVkdmzrYItw8OkGfxnn/q/fO5owwS7YVDO/whU7SYhI9bUyGBJBULWeO4KaSv9dJr
         2C2a8JJXSR8s/XcEmiwrjye6fwDyPLw29uvttNA5xsynScmdz6eL6KXPVw4mrdKcdEbI
         q2YCC24ZuGbl6lFX6cgMRduw+5bLYyFojFY7abOWunyxhZ88kQMqiqiGg9Ru4Ui0U0W0
         Y1og==
X-Gm-Message-State: AOJu0Ywc2XesBjIAHF8BxGjM6rbhhIyOgP8ksna1rQdOlno5yWvs/idf
	lw1kjvUiF58Vb492pY4ZCU5arBiqaalCqN9qxeEIsWwWhN5hSpfRyeCnKhDRUJ59uKJRZJppBfY
	dMB0=
X-Google-Smtp-Source: AGHT+IGOJAjSI9lJ9RvQfrOq3TJ6cBHRlKsbr9Liz22glAu688BuPiBQxvbdov4vb5zD8a8NuOMByg==
X-Received: by 2002:a5d:6308:0:b0:33b:37f4:f42 with SMTP id i8-20020a5d6308000000b0033b37f40f42mr2781964wru.2.1707126704768;
        Mon, 05 Feb 2024 01:51:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX9WYLA8nfuZrQJNOxBrP9FW8e+9J4Lc9IoeFPDHvP7OeMiwgKTf7t8ZJw0ugDnAU1diPxGgTEbXoiqJu9VdGquxBrJY28ivS+rr2o5/5aLIuoY1Yu02ghzX0Rkted2SIHHYlkDbnkB0BBkj6aLLZKEpHgDHS6GRfI610IBjDu8HZh92oQiGvVhs1Z+sX+xRSme1yzFN/7J7xcBUq/L+LF3Neng6xtiMSdhOdfUi8dbBBEy3wQg2NhJWLH6o/33GuSfr2AiHPxVCcbXikOGFlT1PJPP9FimV67AJbfDVuLJ/vFs9WSHntX06M7YBGQ0Q1aqBIQrIgLdpcX93l+olI/aOlgpGg1zme+/cdiMUJal/hSyiG34jwf/gPscsm+dnyfjDuWqenC8RkIAvPiu1FA2NY2dj+e43g1bFQYKlU02OhvgGslqrLAqJ53N0CRu5eAuEl8REvl1tCKyFnVVts07Jx57kvkWRtQLbsMliacwGBpoAne25XG2mL0X0mrQB2d84bsBiOSue3+ZJtwFtjly4z4x
Received: from otso.luca.vpn.lucaweiss.eu ([2a02:a03f:6aef:6800:2f37:ce90:b91c:e85a])
        by smtp.gmail.com with ESMTPSA id n12-20020a5d400c000000b0033b3c2e73e2sm2278283wrp.113.2024.02.05.01.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 01:51:44 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Mon, 05 Feb 2024 10:51:40 +0100
Subject: [PATCH 3/3] arm64: defconfig: Enable QCOM PBS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240205-pmi632-ppg-v1-3-e236c95a2099@fairphone.com>
References: <20240205-pmi632-ppg-v1-0-e236c95a2099@fairphone.com>
In-Reply-To: <20240205-pmi632-ppg-v1-0-e236c95a2099@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.4

Enable the PBS driver used on e.g. PMI632.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index cfa3e00def09..e92a5fd9f660 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1375,6 +1375,7 @@ CONFIG_QCOM_STATS=m
 CONFIG_QCOM_WCNSS_CTRL=m
 CONFIG_QCOM_APR=m
 CONFIG_QCOM_ICC_BWMON=m
+CONFIG_QCOM_PBS=m
 CONFIG_ARCH_R8A77995=y
 CONFIG_ARCH_R8A77990=y
 CONFIG_ARCH_R8A77951=y

-- 
2.43.0


