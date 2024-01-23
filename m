Return-Path: <linux-kernel+bounces-35379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B04838FD3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29F1C1F2ACFA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AB460255;
	Tue, 23 Jan 2024 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wgJ2Ng5R"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DDB5FB9D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016083; cv=none; b=Un2r74i/YxFatMtu3Dv8IhdQwPfxILyxNgNiMnviqfXtoY9JREZp0YKylree8Wd3EelOG/vWcoefWBc1Kiujc2ixZctDwS5u9v4/fgXjqRQfw0nE1cgqQorCa6P4eed6jwv0yHFe6hs+RuRsrVAK75KLmCFFn760Ee220BlueKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016083; c=relaxed/simple;
	bh=J6T8WoDwMb7zsgWZb3GOYxNrNU8yXYr1cMdOd6QdaAk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A8BFxu5gvM2GNNGlBrlKlVDyzMHb2YHPbGZesnBvffeEllm2buOh5jkRey0qo/v2UdzvRk9c0gHQFIkT45lNcduV1Y8+83q+le4lDABBBkw0si9bhB7Jfv7oaC9/pks9sBXY2NS1/iHspsKKMNd6uWOYyU5TmV0y/GVqrRXDZKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wgJ2Ng5R; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e490c2115so32571395e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 05:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706016079; x=1706620879; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yt0jVKy6IezEYFehA3G6AdAfzr3E3phZ9lpEaZgTEWE=;
        b=wgJ2Ng5R5WFObvCYLWV/FWx8y2zKXe9YKBpoczGpsazgRiaL+xgiGUVHCZzsJSU+ab
         qrmFTaDQMhWDDiP83tDb8cINVWilhDlqiYdK1HNLfXNo/NYMaAfvAjm09+KweyS2L7bU
         lVI9WsYDI9wdyBul4u6mGjCrVetV9ImY35+/cECxLyQ8XAtixuuH1dirqOfEk2NsL8et
         O7JIo6lgKMeNARNUIcpUXkUxsHkIQTkqaR2seXtr2LaTSpQWoy6aAaD0Pljzxl7+Yg70
         BTQGe74eJkaaHw6rusfoxILt546xTi/ltyKI/6Zy/cbPssryHqhWcsL27l7CVXVsnwgl
         f1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706016079; x=1706620879;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yt0jVKy6IezEYFehA3G6AdAfzr3E3phZ9lpEaZgTEWE=;
        b=M6yVsiZqxmNKzmt7iS1TAdorsukTY89+ozIejW9Q3ERpSnv17Rz99fY56j2FnplCRw
         WWXd2//9Q5FtcddOg8rU65d0RdJ/OpSoKzULYu8b8yxKwbqUDATkEdBAAeddGHR2kqvC
         kh4x8v33pLn4U0EL8xKH/E5kVuO6c6W4aVFlU/irph7A+B8Lmq5bxwhZrQoNg3QVdv7Y
         RS9TPRmEEdqGWwtbb2M88M34XC6gTGF62MDFaM4ljTB4XhINDGJHg7o6cUOLRpkNyfKI
         zKa3nBDyRaNdhYb9rCFrTw0dIF7oa09s2utL38NWghS1x2yFkecjInmhhPSmW/zZ99sP
         9rjA==
X-Gm-Message-State: AOJu0YwFdoVc+FVTbuWLv78HsGzmYKVbD8eE/6LzLwJziuI8LgJm3pIs
	QoHFQr1AGwUuPohJ/89kVnrD+va7UVGjYlTYbeQYT/HRpwA9Mv5PS1XOryqp24U=
X-Google-Smtp-Source: AGHT+IHxecADuHESJhPR8sXUtgEPmmxdgher3lXTO9gS/5Xw0lTTS1T14FRK8FogX66H9lrNT8TLcQ==
X-Received: by 2002:a05:600c:154d:b0:40e:c193:4341 with SMTP id f13-20020a05600c154d00b0040ec1934341mr144963wmg.26.1706016079097;
        Tue, 23 Jan 2024 05:21:19 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id hn33-20020a05600ca3a100b0040e621feca9sm39982445wmb.17.2024.01.23.05.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 05:21:18 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/2] arm64: qcom: sm8650: add support for USB-C Altmode
Date: Tue, 23 Jan 2024 14:21:14 +0100
Message-Id: <20240123-topic-sm8650-upstream-altmode-v3-0-300a5ac80e1e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEq9r2UC/43NvQ6CMBiF4Vshna3pD9Ti5H0Yh6Z8hS8RStraa
 Aj3bmHSScf3DM9ZSISAEMm5WkiAjBH9VEIeKmIHM/VAsStNBBOSC65p8jNaGketGkYfc0wBzEj
 NPY2+AyoBeM1dZ61zpBhzAIfP3b/eSg8Ykw+v/S7zbf1XzpwyemoZU4qpVlp3ueNkgj/60JONz
 uKTa39xonBGMd0IrVVt5Be3rusbj9sCqBoBAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1090;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=J6T8WoDwMb7zsgWZb3GOYxNrNU8yXYr1cMdOd6QdaAk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlr71NDzQbq6rTyaQcwx2ypUOggJiz7CcJsBUdWI6b
 DnlhIhSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZa+9TQAKCRB33NvayMhJ0WixD/
 9r9eYxVzRN4NVIzkRmXrP3l9xmqbRBc0gOdsvD29M/4fAPe3nQQUprUo+UmqBL2pny3JOXwyOAA3qz
 Pf4c4SUVl4DDIL16daLAIC/cLFWav6/6nPeXtmR/ouNhgPp5so3eVeVvah80raB0bvpF/NF53qFPJz
 vgnEoYecaTAAbFfr5VAOUibuxeRccmhfWMFCO8QiNpkxdzks13cJOwuZvPFdJAa23IX0GT1cv0sg6r
 Zdv5zYle+g8UTA1wVXAhHIYkZ+GTI4YjPrqIV4u8G+EYU9A4V40TLziwtMK4nc+Li9YXi2d3nlctUc
 kvteTrUD1faOWTeBVdD+aGg6LA4d5CiGOHlJ/Ed2vFlCbw/cKr1HOw+JXzuoLuVrV915IEoFBJM9qg
 bjBBQE8BXsTvN31ric80v/aKH84WjD+2D2PebKW0frBRt9SAQGZf/Z+SIG6ZyWhiynV2EXKwld+ruK
 al9/1UXrIzTD0oKfiHBv2a49jUPNkHIlwpE3G0o6W1FGfew2ddAvXXYSBI08n6QrxyVb5031gcgTcI
 4TnK+v3qdrXz2ou0njCB1LpfV+CWpBZlMq9ZE+bC9XpoyUmH/1ucrfQSTXg6XGTKmJudkI2nfKObpp
 1wH/YPavMdm+1DbCNyzXrC7wNQRkyO/lTsBQ4NZ3b9Gh2SVCCnfEXFO/VYdw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

This adds the missing bits to support Display Port external
display over the USB-C Altmode support using the Redriver/Retimer
and WCD939x USBSS Mux/Switch to provide the correct switching.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v3:
- rebased on v6.8-rc1
- Link to v2: https://lore.kernel.org/r/20231219-topic-sm8650-upstream-altmode-v2-0-a608528864a3@linaro.org

Changes in v2:
- replaced "ok" by "okay"
- Link to v1: https://lore.kernel.org/r/20231218-topic-sm8650-upstream-altmode-v1-0-7900660693cf@linaro.org

---
Neil Armstrong (2):
      arm64: dts: qcom: sm8650-qrd: add USB-C Altmode Support
      arm64: defconfig: enable WCD939x USBSS driver as module

 arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 104 +++++++++++++++++++++++++++++++-
 arch/arm64/configs/defconfig            |   1 +
 2 files changed, 103 insertions(+), 2 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20231218-topic-sm8650-upstream-altmode-3ee141fdccff

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


