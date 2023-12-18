Return-Path: <linux-kernel+bounces-3323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A920C816B02
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEA961C22205
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD57A1426E;
	Mon, 18 Dec 2023 10:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="or79mqv0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190541427A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-336417c565eso2556388f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 02:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702895187; x=1703499987; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bfGdeEVtAP039z0DAM0GYB1EstdhuI6lhd+nU30URD0=;
        b=or79mqv0DmfSPsZl0+1pURdyfvgaCcvmJyubu+sYJZyfJiQzK2lCmEMLVAGh8Ykflh
         m279BP2fFAUH+VLuL5cC07MZoUVmkmIkXwxztQAo9W5WbifVH2NF5Y4Deb+OkdepFcFm
         G3Pgl2IipX2UNZzldvj/Dd4csPCz3VVqltZDJhYpbQpi4z95fxE9IQPMXQRUvh5p07d5
         EgtgUKNp6ohYQM3hCHn0dkr2FZYBQhqvwyeYaF+tgbKTUKXhfpDgAyiYIkzy/yvQMrA4
         X0j1RKLJ5DyqH0B1QfA27I3TaMAjmtnCKUBxBvI3H2UTC1IYFqZoaxB/q5/mwd5zGhn1
         6I/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702895187; x=1703499987;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bfGdeEVtAP039z0DAM0GYB1EstdhuI6lhd+nU30URD0=;
        b=DqmcXyIqEIXdaefJfbQMq+EIouKoPGuiQ2QdiB9P0axAUqREqYbezsKvX1CBiyuHDb
         htZ4r27GH41ov7OLTP/Uxl9yoGZ8PQOLnSbIpXUJSDer2U5LZtxBbmmJN6GNgDKSCr4W
         TPD8HctP06abONUKhpUbLwbXfIKFrkBkVq8zDbUkPsGVHMA/PSk8fPFFTCCu1pDq7BWR
         AZyb/Y45ve6K7hRw5DCRPvt61OEMehV1koJQTLciGuASh8kNjFsLDZ4WiolMcf6oAgmc
         P9WazWpmksOUA9pRtaOGfninzVGZunQShmcnGC7bmfQbCUP7uqqgYsIY+b8bwI3XduLs
         C5vw==
X-Gm-Message-State: AOJu0YzUV/DgyPJ9KZu7KgKDzMJMekwuSjYAuhVfC51OaGA5to09/spF
	msJQAV1qy2Css8ITIgDbnJoGmw==
X-Google-Smtp-Source: AGHT+IH7gTI3sQVTip3YEHMYyOyuTBxGVnDnL5oom7hwIOvttarBXpmokCWLuyMer7EXlHTmngDC2Q==
X-Received: by 2002:a5d:5264:0:b0:333:2fd2:3bc4 with SMTP id l4-20020a5d5264000000b003332fd23bc4mr5414962wrc.125.1702895187323;
        Mon, 18 Dec 2023 02:26:27 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d62c9000000b003364aa5cc13sm11365333wrv.1.2023.12.18.02.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 02:26:26 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] arm64: qcom: sm8650: add support for USB-C Altmode
Date: Mon, 18 Dec 2023 11:26:23 +0100
Message-Id: <20231218-topic-sm8650-upstream-altmode-v1-0-7900660693cf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE8egGUC/x3MwQqDMAwA0F+RnBcw1YnsV8YOpU1dwNrSVBHEf
 1/Z8V3eBcpFWOHVXVD4EJW0NdCjA/e128IovhlMbwYyNGNNWRxqnKdnj3vWWthGtGuNyTMOzDR
 S8M6FAO3IhYOc///9ue8fq3SJvW8AAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=781;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Sx1JlgYzlpqCvtOmR9gBzgN6SutXNYs6O5wotkCENgs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlgB5RlV4PyBkoraDzOeocIlIUn6+YTLgJwgl9aYOl
 l5bIyziJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZYAeUQAKCRB33NvayMhJ0e/QD/
 oCutKa/EAdw7aTS4OPR+sn2lJuf0HO7YJhYShx0tLKRTD/DhiMape+ug+q1HVM65Hq/O238TYgEooJ
 Sp/OXGzquanrJJ5VoXXHc2Ge/ZI57Brg8ghkLU0rrRrBHrNAw/pbFKteXCBbGmW9OkZVWq4OTJBpbQ
 UpV79ZOD2YGa+ylfaZu/a4uuEuOLnXBgpRzY5JkAeOMGCJRkWbWG9VTWYoSnyGGqiF7E5qEB5v/EFO
 zX0+m3EXmN485kCPrlUEYZfE638XzN04qEvn/hajiO3bBA3JLBX6jzT86VkUK3S4fjxvvOqsyCfyEy
 ARLmRA64Nc8HoupyK3mlD/2Z3Yo2jNIcYutaw1/g4LW81ZBmNE6T/1FRH1utDz1VxCzrTl8ut2qaky
 2I9mhuZw1ndTQOy4qSBpGAQ5gFyiYyj1F6cHeMxWw0WatNmCnAK3VDAAU9u/yv1XdBZUpiEbMAol+k
 km+7G8LY/EMhc6u1H4v5CKyCZn4mzp5itkiU8sgEdKgq0NgCzNViN6XmpPgSnoRXFvRWDt97x4pF8Y
 WR6yD+JzEPLVgK+fF4pwMp194DMIFYPsgjxe5w/d3zxjwqBOogQJ8/EBOGqQRtdH3wfm/gLhgN/aFY
 IjJDqPorbqtyfQfUOA8gHCW0xc33APuWNk6GjqLr7vQ8y1L4BSw12EfWhMtQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

This adds the missing bits to support Display Port external
display over the USB-C Altmode support using the Redriver/Retimer
and WCD939x USBSS Mux/Switch to provide the correct switching.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      arm64: dts: qcom: sm8650-qrd: add USB-C Altmode Support
      arm64: defconfig: enable WCD939x USBSS driver as module

 arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 104 +++++++++++++++++++++++++++++++-
 arch/arm64/configs/defconfig            |   1 +
 2 files changed, 103 insertions(+), 2 deletions(-)
---
base-commit: ceb2fe0d438644e1de06b9a6468a1fb8e2199c70
change-id: 20231218-topic-sm8650-upstream-altmode-3ee141fdccff

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


