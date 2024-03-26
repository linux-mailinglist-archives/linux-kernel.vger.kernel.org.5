Return-Path: <linux-kernel+bounces-119644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AA588CB7F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CFD93056B8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D1953803;
	Tue, 26 Mar 2024 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3vsMRQ3"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4344D1CAA6;
	Tue, 26 Mar 2024 18:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476302; cv=none; b=tgLP3wvcaApkMoLzoqsbyGYZzIYh51XB8Jhp5cKXJqkLanjd7lABjdt7c5qOoSRUt7tTpM6d/NYI7t/3tY8Zist7rIpAwSU6SeEMmFYdi7GHeGY/tmdjftq9raf4ER5D9SQCL44vuQHObYqR+WgBPStLLvYMsCQTnEpaM7pEzEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476302; c=relaxed/simple;
	bh=FaCP1X4xsv77SJjjy+RF+r5fjTpHS6ox04MrkiMrTpQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NTfnsf3mVkxMNfbLMeWlG+IkimXYLvQvOBIpbGuetQy1S8hciphXBTFqgcWxrwEQouyaamr0ztSODc9Ml+ho4vvlJ2SI5lLSRhYFGSxOLLWvhYYo5R/002y7d8LygJpPjQGFVTejPAWjiWVCfauI0gkkkWPtw6jynRq4qkIjsGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3vsMRQ3; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso4457001a12.3;
        Tue, 26 Mar 2024 11:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711476300; x=1712081100; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7eMWpGiB38YJtVZd9B9lRA2TBkHD9tD0FrImJN6Sv8A=;
        b=R3vsMRQ3aR8mPwsTVnJRZdkErSTe+F/1saWkGykRCWbofOK1DF+6XkZY/8dpn/INYS
         y8U60d+o+6lGTP6wg1wCmiyNAIz41iju/mvY1jacQYiBilxYn5lXXVbgmnqHFJYcNUi5
         Motf1F0wlDj8MPCZkTZMx1ZZkXgsmbPH0A/jSnzQ/RcnS+OWVCPOC6fkdc9OeWpBv4gJ
         6mfbh9hqyHuyBF786OXO0ZQNzDGFTydrn/4jwCEaFROxkO3QZ1GFtpgySBTlDHsXu33U
         OYlu/QxLB5NTP2yfYzLCutT05/SDOs2nKvvPXg93r23vOcZkT2hHhJBesLqSwcOWLszw
         IFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711476300; x=1712081100;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7eMWpGiB38YJtVZd9B9lRA2TBkHD9tD0FrImJN6Sv8A=;
        b=jKo5B5e7eayHhB/4MfdBIR0fMfXsD21qdtQ80zojsds6Z4kXBTnaDYsFR/2z3z1ucm
         xTt4qqSJ1BYFy8jfi5p0ffN8VR7+lT/n5rk9C4VB4xb2c9R50N9/IzPf+VbSjM5lTH8G
         kc84XOTaXnrYbRrKkpw5A//JI50k85lX2dSzRhbGhGHCh750Wdxk53uxOLDwOk7a1b7x
         tQiB1UGCKSIbitkaMPKO8z2DVj4LYTg7PlZIZaEd3TcLxYo9F88vG8KngAmmglOtkqyo
         7oAHe0/lO7qLcxIvHmHa60bHidg7WGHzpa3dMw/LSFc96qbT7n9CrYCuz++tTQbsaaHC
         yaxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7rrggmjIphTU7NJtYnP0g/Y33GwvQjVxoYXFSG3YK8Jz1X1NepM/oyjz7uofWlWCHRaCHvZiaNynZMmnieoPVHZn8jZUmqo2RV7t7fDvPbadpw6UQG9ComCz/qzfKfyL97d004j+LreVuqw==
X-Gm-Message-State: AOJu0Yy5r1xCORtTM7Mb15HTqfH8PcDt5I+T1rUe4y+GGHLVDjBDHVjd
	cgplbICegFxuvB1UZbZVlcNQCJAGIvNE3EVyBbAei90lqV+MFGgGF4XXiqd0BY/bJRllqJGspxr
	PKC7CZbgNIOUkD5ztMBuYpZyq2Dw=
X-Google-Smtp-Source: AGHT+IGvvgt2+h25XM0X3VAXSRyRgKXJ48v9Kzeutnr3W8gcWQwcEQKbgUgAeAh3qw6Qfjc+OoTfXR99bSWeh+7bAwo=
X-Received: by 2002:a17:90a:d150:b0:2a0:4a33:c3a6 with SMTP id
 t16-20020a17090ad15000b002a04a33c3a6mr3012373pjw.44.1711476300538; Tue, 26
 Mar 2024 11:05:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 26 Mar 2024 19:04:33 +0100
Message-ID: <CANiq72mjc5t4n25SQvYSrOEhxxpXYPZ4pPzneSJHEnc3qApu2Q@mail.gmail.com>
Subject: drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:843:6: error: variable
 'out' set but not used
To: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	linux-arm-msm <linux-arm-msm@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, 
	freedreno@lists.freedesktop.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

In today's next, I got:

    drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:843:6: error: variable
'out' set but not used [-Werror,-Wunused-but-set-variable]

`out` seems to be there since commit 64d6255650d4 ("drm/msm: More
fully implement devcoredump for a7xx").

Untested diff below assuming `dumper->iova` is constant -- if you want
a formal patch, please let me know.

Cheers,
Miguel

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index 1f5245fc2cdc..a847a0f7a73c 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -852,7 +852,7 @@ static void a6xx_get_shader_block(struct msm_gpu *gpu,
             (block->type << 8) | i);

         in += CRASHDUMP_READ(in, REG_A6XX_HLSQ_DBG_AHB_READ_APERTURE,
-            block->size, dumper->iova + A6XX_CD_DATA_OFFSET);
+            block->size, out);

         out += block->size * sizeof(u32);
     }

