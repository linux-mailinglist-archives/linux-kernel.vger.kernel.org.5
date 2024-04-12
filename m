Return-Path: <linux-kernel+bounces-142519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6F58A2CB2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF0E41C2154E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AC344391;
	Fri, 12 Apr 2024 10:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I2ptgfOs"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277863CF79
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 10:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712918547; cv=none; b=iaE+hGsoxQydd9xpTBsHjKWPj+czcjDnNYu/a8hvEqBc4WET4b+7RISviw0VcaBsZHvyyFDKa3/f3Es30q/d5kLEGwjgf7rgkcGjG5gTHXxW0CGWB1aZLb7phX31yGMY/ANpEZu3rc/BnYTXm+QS87rxhIaVDEI9kUkAh81KNf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712918547; c=relaxed/simple;
	bh=0H0hMWcNgkbz+OoHU/6BAy/ktYGB04j8mn1Ne/MmgnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MxWoqcgZ+5eTqf6mquWI2ZYdbITbF9GDSPBjDs8Ld6yO7g96f1QN56kDDZuq6wdsHZRqg1DGnQ7doZtJ0vNwH7sEEVseyHnAAHRddb4k2Cp09VeHCtZlzo+FZ+xKVSn4FSn9BVxiJRE2RgSZqkNoLG74XIaqLso9JW0VJtRvmxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I2ptgfOs; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-516d1c8dc79so1001240e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 03:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712918544; x=1713523344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9dyIX2GIRxyxtjQgoTbfebK6wI7hUKbyAEauzQCGs4=;
        b=I2ptgfOsjYS4NpoENOH4c08wdBXsmZ0wngsRYoDitmcqYRPX36XvY3GpEnNm5Yhyrb
         tREzMYLGVY7Ok35+s6b1ofFaHWkN9UnJLdcY1D97JCJIzGvQf4I0h59OT9Qns08MsdD+
         tAnBO2/mzlZ6C+0Uacs7TA66WDFVZ4SXnkOLoj3DfkTqyu50jD2cHwzPE6QobmYVRJuy
         E9mg/U83eCj8soZSDLhdr16deZ6X7kwS1F+w4vRuywnf0Mn7L7qby/u4VenJI0XfBjBT
         hrrpC+qzuDoxnDZC6rcdW7oLqYHo2RDljVnpeakiE6K5e37OBLiOMEkUoKZ6tDb2Tc/3
         l6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712918544; x=1713523344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9dyIX2GIRxyxtjQgoTbfebK6wI7hUKbyAEauzQCGs4=;
        b=uaf8tpdjFsBauI3wUjh2sE3FzCP/fOtpnmmQ28UZGrG8B0RZO+5DTp+ld/opu7SO9L
         BJ/9bFIUdypxilkI0WQqjwqBCiatxueAl+Zwd75kuEjElKvikT/mZXjV8MN7f63ylVKH
         rTYqWAxmYykrf2450MohPF4EavACWxVbVhHiCjIOpTs/+YfeVn5B14iNY5lYNftAjEUX
         l/rKD+JBUKVtiLUcqCDZrTyOZuGtXBdJA1mWG1mQ9xzLJjRF8NaiaX+/+H1yu8CwoAnW
         UDuGcPM+8sJdsgDM7bybY1Ukwf90rr+YUqAm5sLHi1I4wtgIKROLs9FohOWDBrgEbHzA
         DjJw==
X-Forwarded-Encrypted: i=1; AJvYcCUpv2doVWdNciINg5uwGks5C/tfQfRp0F0Kea62ZxMG4IZNwZCFZSZxcvXpvUl+7jLkuRtm3XNNdD3Lwme1g65I9+quFacEihscFIO1
X-Gm-Message-State: AOJu0YyVfLG2Z/rKMQAaYe8d1Lu+ojDII1ROEMpk4fQfb5lKP7xdhdfB
	rje9BczKVH+v6c0/mt6IZo5kTge1gbAEq4a6EraJIygkqcDOyTxtLh2VShZSX7Chdffji6dwnhT
	k
X-Google-Smtp-Source: AGHT+IEZwUht8/pnBTEaDnGWHh3CxFUN2Na4wDCS6x/BRz79j0pltI+VYdSu7+r0i6OuXZDbWru1Tw==
X-Received: by 2002:ac2:5982:0:b0:515:af1f:5bab with SMTP id w2-20020ac25982000000b00515af1f5babmr1431306lfn.40.1712918544283;
        Fri, 12 Apr 2024 03:42:24 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id v10-20020a05651203aa00b005135f60f486sm493689lfp.112.2024.04.12.03.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 03:42:23 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] pmdomain: core: Don't clear suspended_count at genpd_prepare()
Date: Fri, 12 Apr 2024 12:42:08 +0200
Message-Id: <20240412104208.74361-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412104208.74361-1-ulf.hansson@linaro.org>
References: <20240412104208.74361-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no longer any need to clear genpd->suspended_count in
genpd_prepare(), as it should be correctly incremented and decremented for
all cases. In fact, if the counter isn't correctly managed we would be
hiding a problem that we shouldn't. Therefore, let's not clear it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 903ea0c193e1..342779464c0d 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -1255,10 +1255,7 @@ static int genpd_prepare(struct device *dev)
 		return -EINVAL;
 
 	genpd_lock(genpd);
-
-	if (genpd->prepared_count++ == 0)
-		genpd->suspended_count = 0;
-
+	genpd->prepared_count++;
 	genpd_unlock(genpd);
 
 	ret = pm_generic_prepare(dev);
-- 
2.34.1


