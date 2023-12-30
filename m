Return-Path: <linux-kernel+bounces-13379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B43820434
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 10:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C42A81F21843
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 09:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED66F23AF;
	Sat, 30 Dec 2023 09:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWN7YEBr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6E5441C;
	Sat, 30 Dec 2023 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-594965fbb3cso2929930eaf.1;
        Sat, 30 Dec 2023 01:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703929960; x=1704534760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2ug4vrrJxLoeI9/pb4M3tzSvC+dUh/AitXDBaOV7p4=;
        b=lWN7YEBrbiawchx6zUE0B2jNRbKHxIn7PKCTqRs+g8ldxs6EO0/deNbWmIcuUSHbUy
         VnJMH+YNwBpzWjYvQSafgE3bP8Ot6k/xTyoaBr1/A6Csjb/hMBIZQRyBKCxXSZBQvIGs
         JNExpOzwhYZ0cALe+GiGfZQuKV+PIMUthkaBbeaKaUAf2ztBnIvpLMlgiHhLnPvTMj0f
         VLroFDIdCURXPq5E0ebFGg8K35g+ZDfEWw9DnBLBJp4xtCrHO2ZctjwLryIdUOJZnn9s
         hpE8M37TWLT7+xmpvR/N/gnhZhthRGEnwao8CLGRdFcdAS9oE31FY8UAspj4R6e8+tsw
         RMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703929960; x=1704534760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2ug4vrrJxLoeI9/pb4M3tzSvC+dUh/AitXDBaOV7p4=;
        b=RoiB6Jxb7BF4BVtR7DUd5oDNMsrrpG6xKRc3Y3nRRd3d9vc4Op0DdvY8MjzAdSey1i
         U2l1Xc/L/5Bz6EXuaDI3rnkI3J0l6BWPmQsXebYsXbOduCRWySDQaDe7tsySzKbJr3LW
         nzeJHShSA3Lp6M03FyM24kAPplAvtccj4Me0tYyciwwJ+TSxqmhHPm6an39Gx379wev9
         g8J2Qj8yOSJjFSoOgKudZ++dkd+oBJl3wZaqIcvsPUEiIDjsFOEMzCNOJhQ1MLbxbkkM
         XNlG6XT3ZpPRW8b7gbFLX5kAMmkHoulDyW97g6geyHAU1XhWslPGufYj4fKCc3IuS+mx
         VxlQ==
X-Gm-Message-State: AOJu0Yze6JOx2kYIuF3m/5d6zudXJ+c6NXD50SZ1Nt49kQaK1OysAuQV
	rbKLp2bCcKogRc7JUPKbrfGbaLsTwPLqjyWc
X-Google-Smtp-Source: AGHT+IE4ydwPSSJsdouK6gFidOvqGq0hFHDyDo7Z8qjafOwU9NYVnsO6so+ScA/jFOskXKE46w/iIg==
X-Received: by 2002:a05:6358:cc1d:b0:170:c991:d419 with SMTP id gx29-20020a056358cc1d00b00170c991d419mr13188168rwb.48.1703929959838;
        Sat, 30 Dec 2023 01:52:39 -0800 (PST)
Received: from localhost.localdomain ([2408:8207:2540:8c00:23b7:4d83:3222:c5dd])
        by smtp.gmail.com with ESMTPSA id m20-20020a170902c45400b001d316770044sm17170905plm.56.2023.12.30.01.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 01:52:39 -0800 (PST)
From: amazingfate <liujianfeng1994@gmail.com>
To: sigmaris@gmail.com
Cc: ezequiel@vanguardiasur.com.ar,
	p.zabel@pengutronix.de,
	mchehab@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	sfr@canb.auug.org.au,
	liujianfeng1994@gmail.com,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] Add hantro g1 video decoder support for RK3588
Date: Sat, 30 Dec 2023 17:52:28 +0800
Message-Id: <20231230095228.3739806-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAAXNxMT3f68-ptM7Crhrfmn7iwTyJc9pwz4Beob+5beVODaSHQ@mail.gmail.com>
References: <CAAXNxMT3f68-ptM7Crhrfmn7iwTyJc9pwz4Beob+5beVODaSHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for your test with fluster. I also tested on my rock-5b(rk3588)
and orangepi-3b(rk3566) which are sharing the same hantro g1 ip. I am
running on ubuntu jammy so I'm using gstreamer 1.20.1

rk3566 and rk3588 are sharing the same results:
JVT-AVC_V1 test suite with decoder GStreamer-H.264-V4L2SL-Gst1.0:
  Ran 112/135 tests successfully.
JVT-FR_EXT test suite with decoder GStreamer-H.264-V4L2SL-Gst1.0:
  Ran 27/69 tests successfully.
VP8-TEST-VECTORS test suite with decoder GStreamer-VP8-V4L2SL-Gst1.0:
  Ran 59/61 tests successfully.

H264 decoder test has less test case passing. I think that's because
of my low gstreamer version. If you have a rk356x board I guess you
will get the same result as rk3588. That should be the mainline support
status of hantro g1 decoder.

For ffmpeg at the moment fluster doesn't support v4l2-request decoder.
I tried Kwiboo's fork[1] but failed to pass tests with decoder
FFmpeg-H.264-V4L2-request. I can decode video with ffmpeg command like:
"ffmpeg -benchmark -hwaccel drm -hwaccel_output_format drm_prime -i Big_Buck_Bunny_1080_10s_30MB.mp4 -f null -"

[1] https://github.com/Kwiboo/fluster/tree/v4l2-request

