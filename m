Return-Path: <linux-kernel+bounces-3981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF2D81764C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BD16281E0B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE794FF61;
	Mon, 18 Dec 2023 15:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExhYsNyj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6353D54D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5534dcfdd61so2170248a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702914452; x=1703519252; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0eNl2vsDtnWZ+IAcuQvLIHQD/Xi40xLCKLfqrufOQbE=;
        b=ExhYsNyjaOn6BFk4FuSUhHqep/osl0vIJz0vRSSqP0Nl7M70BTF+AlY+9pmwkEgDak
         uMvsTbzWK5McP5xp61pr0tJZQ2g/1wss968bkfF/NVhc5uK2knGbx53tF6P/tL0kdws5
         nZmvjdvg0QJGXLlfqCOshC9mhJ5qcIOrY30eLBq55MSSAIR6Xu0ACAurP1cnafuEhECS
         JDbvOeCeNlG3B4dtirJS0MgsXNIywOxkzyIOkLje9jFFnHQOeb0YiDngZnWkxIDSMfUL
         hOvk5Yp5MxK+FmJ2uRfkKUZjemIEmJYfSEYq8m0Z78GpuGoyIdMm3HCrqWAzkde7FWw2
         76RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914452; x=1703519252;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0eNl2vsDtnWZ+IAcuQvLIHQD/Xi40xLCKLfqrufOQbE=;
        b=ZsdmL/Ay9yZzwWaoXr9sGhlN6MKSS5dgjsP2RjJXekM8zV2mAJwFGRih13GxIXXAIl
         hCjkKhwlFvkrWRt/NMWOwE99vIFjeSkCTjZbKivV3soq/ypKHaGNkBFYTi8/jnHwk1nJ
         aeIWRdStdtxQ3qQ9i7yqLRpYXyP0twIVSp8uzNQMgsY3nN4yldvwSYLd0bKQHybBDJCi
         ZThfBPwOUewJTdS4jvVblvFgGSHo9H5K9Ffp1Vz9FV37ixGHWAJXIoLnP7G2tPB7fySI
         wvNj6z22uLOG0MOMIzZqvGXjru6UzVQnLuILqFOvHhODAEk7unJuGU/oO3p50JfMDH/G
         t4Lg==
X-Gm-Message-State: AOJu0YzX3PgQM+vdG2r9B7Co6FHyPuiCJApuzRWn4rANDSbuDrA8SrLE
	h4oJaAvxrwhbLofOoZvhs4H0rdBu+Us=
X-Google-Smtp-Source: AGHT+IHC5qktQQ4b2sM7UtIt484SaKUejdtlj+rponp9uZJ7sZ97THniapcreVMbePgmnF2+r8RohA==
X-Received: by 2002:a50:d6d7:0:b0:553:2f15:6245 with SMTP id l23-20020a50d6d7000000b005532f156245mr2498083edj.26.1702914452056;
        Mon, 18 Dec 2023 07:47:32 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id r13-20020a056402018d00b005537b9f7ce7sm216914edv.68.2023.12.18.07.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 07:47:31 -0800 (PST)
Message-ID: <f86ec29f-194a-800d-0aaf-9e16e551b37d@gmail.com>
Date: Mon, 18 Dec 2023 16:47:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 0/2] Rockchip rk3066_hdmi update
To: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Update the Rockchip rk3066_hdmi driver in a somewhat similar way
to what is proposed for the inno_hdmi driver.

Changed V2:
  Drop already applied patches
  Remove "Remove useless output format" patch for now
  Add fill_modes hook removal patch

Johan Jonker (2):
  drm/rockchip: rk3066_hdmi: remove unused drm device pointer
  drm/rockchip: rk3066_hdmi: drop custom fill_modes hook

 drivers/gpu/drm/rockchip/rk3066_hdmi.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

--
2.39.2


