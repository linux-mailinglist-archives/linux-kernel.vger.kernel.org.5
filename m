Return-Path: <linux-kernel+bounces-163586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C10E88B6D57
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6856B22E35
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF424127E36;
	Tue, 30 Apr 2024 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kdkHILsT"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94915127E3F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714467014; cv=none; b=e7dcNZMwGqxZhfEQ8qvFLiTHbgGRvZkElBEFe34ymjHWZ3KKZ6T6t1J21VscktgyFroRk4ZbDSzj4zkCIoLRNFdxV2S9MTRRiVsTCNjnok+4NjHRxiONoCz+EDPZhex2jLAIJCa/xVadHnRdoukaWJ6kDMGVAMX9TORPWCT8Z/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714467014; c=relaxed/simple;
	bh=4mHkxydcDop8+a5U84Ex8zdWyu5bfDu9/m0XyG4I4VE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZBcyDdOq/W2GrJ5MEtXghh0LORenxozLA6vbL8ThIMtY94FCgtglh7eitKdi7mfOb5yiYHCCAJfAysHJIrKWvE/TiOQ3VlYqd1UoyaJSSoj1Yz/g9gywL2ch65F1lfCAfT/prPR6tiN9+r0gGQhZpvRaIOI/MSg18m+i2JlGOsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kdkHILsT; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34d7b0dac54so316753f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714467011; x=1715071811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=reih9iIzksfPYNdrudwShInqxXRFcxpUXA22lqow/ow=;
        b=kdkHILsTneZUA6t2aBz8VcCq3HTTfWhxIAAqI4MGMZw3l87ooybmdOGeHnokll4ua+
         1GIuxer9iwJ02Emn1rdRkRTIYt5xpBJgiECwjz7kWS77//3YHCHpw0NwBWJZgHPxUtaa
         Jvjgf8h1CZ/fBT9wa9H4W18xBkaax3NkFmODL8JKhxrT7sTnc4+js/TCWtZGdmEfwfCj
         9xX+MlQU1ENqHKyhQz4GXGdpsEt1fQ6pLKJG4M5JkOdo7vcP5UUd3/bUkLHUyb5aDYpt
         g8mH4+WJOzbrVtI0JYykSkrVocgzmGhPdXHAv+bpjoCA47jzA2xAMp8JMHlA7lqSWx63
         n0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714467011; x=1715071811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=reih9iIzksfPYNdrudwShInqxXRFcxpUXA22lqow/ow=;
        b=HWQgxMnrV3epOtcX9tHxoUL8hUkE6FludLJKgnnH5ap97TAFrYluFAzaJDxbwOqXaP
         D8V9y49VWIXSrjlQkKLH1QzsDX27IdzIfm4XJWYzmDrfhcdluPc2yrzF7ZnlRriSsr0o
         Ym9oETs4Ywmnb+1jy0EgKV+Z29JKlWtGBdF2YYghlhKixc5AIZqkui4u8NX9yq2SbEcJ
         3uvY46Lqc8Qn+dYFx1L7+kBevyNwTFePwPyy1X8ZnvCZDdtas8S7StA4V0qG6294tOGJ
         qqqms3i3J96OT7Oe/dLLCxfNgP5uy3/U+FqCHxiOBXvOul5mjYCwnAxp7PC60xFxd35v
         n+mg==
X-Gm-Message-State: AOJu0YzaLtLj2AY7q943Pi9UW5OYrfo/ijF4iEg95gqO54l4hB3c7qtl
	Avc/4PnBZE6ECCalJJ1xItZ85w3TsfE3dPY0N6M6YftUdfG3jN+P/mIcttC6ixRlKhkDNvw1xqB
	y
X-Google-Smtp-Source: AGHT+IGGJ44URfVhgwJKaPE1xFQQ1MFEZy8PQSvGRHATo4+2aP+M90WUQMYwdPffVCuQ+RGmSsUzGg==
X-Received: by 2002:a5d:6350:0:b0:34d:a4e8:881 with SMTP id b16-20020a5d6350000000b0034da4e80881mr234734wrw.13.1714467011105;
        Tue, 30 Apr 2024 01:50:11 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id p18-20020a05600c1d9200b0041bab13cd60sm14590670wms.3.2024.04.30.01.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 01:50:10 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/4] slimbus: patches for v6.10
Date: Tue, 30 Apr 2024 09:50:03 +0100
Message-Id: <20240430085007.33607-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=953; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=tPUldmMmpLTSMjdpuw1cCFG5UCwY4H+QhHn50+e22WA=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmMLC8zOcCXlHubbLrSOeG96k3Mr5gGiZ1lnMiT cYRN5XvcX6JATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZjCwvAAKCRB6of1ZxzRV NzNhB/9XxPEiFsmqTdvxyURDI08nC6b7Q0JkjwJfKbMtExwXJdTwg4dzhdWXRFsG0oKzqBtm9Sv HMdBUScCGxri98lvtOV7YRPpGM+UJwrwxKVvJoFtxzO7fYVkonEeO+/gRlLXQ+mYtu2ii8CD6Wj G+P5lQpo1eZR6KQzBCMqu1Wv+0XKYhKx8M129Is4NAB0OmXBGUgmqME4kRvJpcMBNdMHsamuLbk 8dZZ6cwxjgbTClOku96n4c+V5wIxu7xvkqVF25tzL5mIWdhRfof782wmPmd6aMMoNjqdYRDfFKR Bl7i2I4IhMPtVUE2Q+FRHLwYWSnFBF+4M97a3SWjIKYlnpSi
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Here are few patches in slimbus for 6.10 that includes
- fixing autoloading.
- coverting driver remove to return void
- some timeout fixes on wait operation.

Please note that, I have also included a fix at the start of this series
rather than sending another email thread. I hope that is okay with you.

Can you please queue them up for 6.10

Thanks,
Srini

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Krzysztof Kozlowski (1):
  slimbus: qcom-ctrl: fix module autoloading

Uwe Kleine-König (1):
  slimbus: Convert to platform remove callback returning void

Viken Dadhaniya (2):
  slimbus: qcom-ngd-ctrl: Add timeout for wait operation
  slimbus: qcom-ngd-ctrl: Reduce auto suspend delay

 drivers/slimbus/qcom-ctrl.c     |  6 +++---
 drivers/slimbus/qcom-ngd-ctrl.c | 20 ++++++++++----------
 2 files changed, 13 insertions(+), 13 deletions(-)

-- 
2.25.1


