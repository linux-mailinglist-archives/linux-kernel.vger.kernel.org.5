Return-Path: <linux-kernel+bounces-12282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7122681F24F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 23:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D05B1C211F0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 22:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672BF481CD;
	Wed, 27 Dec 2023 22:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mFZroxFU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038F1481A3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 22:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e67f70f34so4357429e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 14:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703715348; x=1704320148; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UaweJOUZhA3J0eI5gLkKX20Jp7IChzn7EYWBfNX1EM0=;
        b=mFZroxFUV1q+iwgUFAmDrjZHN/6Ddy+13uh/bdWv+cTX61+lN/hPGLKdCLHbKLAFD3
         oUz/hcbQ1yW8D68ukJsQh4R8z4hlD23oVe5jB9JQNbh5v/4UuYYHzqbBKajc16aJzb51
         SvmMVUvT7vRfvoRQRc8V6TgEDgRMA6rfQ6h9P0L3SfI1pVnaoDIxiAcLzwlayZSRjXTO
         oyzC5tWoW+rbVfSpsRlJam1D1SKwPQYYl1mDPKEnLz76gWaFJvgEz5NIL0e91PG6aNvX
         ylsj1zKCxtoXGxZ6ZB4eBbc8DNI34Cd7eQFBa9/dXiH5Wsoo94DQmY/aZQONpzeH53Oe
         2k1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703715348; x=1704320148;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UaweJOUZhA3J0eI5gLkKX20Jp7IChzn7EYWBfNX1EM0=;
        b=qAwhC8YbwfxIMiIJ8Io9G+i6Db0OfPz8tVauN3uIiBglWPJ3SM5Bid6hPlSuL/d6Ju
         lOvw7EQ/Ys/CuoOtZN/sdYVhmwnvfnm+2K+1a3rQ0z0o1vUAIFpuujgOFVDPAsC8a8ZM
         0I8bKwVzGJMbhRW5CCBQCsSZyP89WdWP62rUIAEuMKz2en8My9cRkEgDYxxOylGvh7N8
         qJ3S6GLLpxDbDH0WoiS36GCzMb5xM5SjqSPwrYgqFM/WlMbTUcI7UGojCE1u1uaz4esz
         s1h2LeBswYGmGo13MmNl37MuQUH4gbQYv+bR14wEYy4OHXEtVxfrqWRf+fPXzM0FhM9O
         YY2Q==
X-Gm-Message-State: AOJu0YwxzLN9iD4PgqM0m38n6aTAzZqZuRqkMaGOgM6Ug/jBH9cviT/i
	o0yyRsHCEVdec42JGyJHwl4p+uTuisyflw==
X-Google-Smtp-Source: AGHT+IFlsXGFoF67COkuE201sgiR0FJiM1XT3DBqVq7fGOfwQohZ0saWlu2MNFjEFMfxhpkB3+RAHw==
X-Received: by 2002:a05:6512:ba6:b0:50e:7be8:46f6 with SMTP id b38-20020a0565120ba600b0050e7be846f6mr2633774lfv.83.1703715347918;
        Wed, 27 Dec 2023 14:15:47 -0800 (PST)
Received: from [10.167.154.1] (178235179028.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.28])
        by smtp.gmail.com with ESMTPSA id vw17-20020a170907059100b00a26f3d6062csm2821501ejb.50.2023.12.27.14.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 14:15:47 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/2] Advertise pm_resume/suspend_via_firmware with PSCI
Date: Wed, 27 Dec 2023 23:15:29 +0100
Message-Id: <20231227-topic-psci_fw_sus-v1-0-6910add70bf3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAGijGUC/x2N0QqDMAwAf0XyvEDNQMd+ZQxpY5wBqaWZbiD++
 8Ie7+C4A0yqisG9OaDKrqZrdmgvDfAc80tQR2egQNeWqMf3WpSxGOswfQbbDGNIgUI38q3vwLs
 UTTDVmHn2Mm/L4rJUmfT7Hz2e5/kDQX2yIHgAAAA=
To: Mark Rutland <mark.rutland@arm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703715346; l=1011;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Rck/esDXRrOWaEACIothwBzUAgF0KQN27onJv0JCYOU=;
 b=95GrHAoDTaaGen2QvwWaM9ccYun2A59CqjzfHNp/lNupMeKqrKSJK+rGrgiAxdYHYncj3V4nj
 YKx1lfYCx69CzFzTO0d2xpu+gvjrEfW3n5ydzpuiAGgMe9wTt3HSIXo
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Some device drivers are curious to know if "the firmware" (which to many
just means ACPI, because x86/ibm_pc is clearly the only arch on this
planet :P) is responsible for suspending/resuming the platform, altering
their behavior if that's the case.

The same flag makes sense regardless of the type of firmware used. PSCI
also happens to be the suspend handler on many platforms even without
ACPI, so it's only natural to report such capabilities as well.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      firmware/psci: Set pm_set_resume/suspend_via_firmware() for SYSTEM_SUSPEND
      firmware/psci: Set pm_set_resume/suspend_via_firmware() on qcom

 drivers/firmware/psci/psci.c | 67 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)
---
base-commit: 39676dfe52331dba909c617f213fdb21015c8d10
change-id: 20231227-topic-psci_fw_sus-a0b0206dc876

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


