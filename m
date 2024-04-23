Return-Path: <linux-kernel+bounces-154400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D40D8ADBA3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8518B22995
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A94417BB7;
	Tue, 23 Apr 2024 01:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsE/uXQC"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3A117997;
	Tue, 23 Apr 2024 01:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713836609; cv=none; b=odbXiXUaO20omOUlYpylUMWCiiqTMn73zfZHZstLlWycv8M2D7+TXlHogU31sFIuRGNAVtzC83ETM1R59D0BW8a9Gmu5KhXstjqm3VASxyTnTv50O3IwkBtLsDcjliTh1J/l3+WkvkEYP7BhPSS6SkyvuWin1maibe4Q6QMrZVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713836609; c=relaxed/simple;
	bh=ufSwTEYdLjNh53VNo5n/InjNNNfWiz9aDd8WKQpIqGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjtpURaZbt/FLiMvF/DGXYDKVZIbtZVvUrfc/zB/OUdOT4jD4mIwGlPg5qUEUblWr+aonFf5LODzVtaPGTTe491ix/MN5fGfzJCdl0pCqQP6/7xbRIXPvOoMEDQgyhYuTmtMITAoKUFkYtVJxXbboMrigownT5n2f6s33U5ZPqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsE/uXQC; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f30f69a958so1020782b3a.1;
        Mon, 22 Apr 2024 18:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713836607; x=1714441407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FVv9MGjbF3k+4QlXe6bHKBL0yNq+kWVhwIIKL4GtREU=;
        b=XsE/uXQCN/6TG3l6T2DX0NeV+bTHIV4vN+5qaVPSmiL15rpKSg9yS0IXnscWg7K+wL
         HpYmTOP6J623lV1IYfQIG+gE4yS6kWmwCdBmOgyrZ/xY9pYJZBJ3zcPQIjgwB2iQQPtj
         tQMWSOg2Baj29JIUNhPiGIfoyqBN17FCepd85Xd02FOxOOwvPo33CldHBwIHjlDwlLQQ
         8hC/LBbXsHOj/VXOfO1bNJvRJuKhwcobhyCbgCZDyPv0XKUebgNL9x3ZnTR3/biYBEO7
         QZ/4Msd1/0qpNHRm5iriju4LzQJ18V8613YVXsKqqQC0QvZKFL1BqLl0C76cgtmas9Z6
         Q1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713836607; x=1714441407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVv9MGjbF3k+4QlXe6bHKBL0yNq+kWVhwIIKL4GtREU=;
        b=LZ+lEhQFLS0zvfNvkBRewpF652PwiAbvvmBEEuMnmV5A0+yZmrNTEALjwEPayIcYXL
         jdbzHzqC66ptkcmYLev4Tt6dCXIhg90syaRmVbMJW6lHb2Fs+UQC9iF8yCAn1V1ubaJb
         oibqp5logYVxPJvXMLPXRcyOUVuFEF3D+DUkw6zMfj5k4YpyCkmWGD5I/9zsQaZHSjya
         YhKFiCY/IGmOMuKjPIkI4UlnhC67r9evbdSqsWPv7WWxGOXF7PAdP0r4Jym3OloUqSL6
         8dIKtfudwY1ATS3zPkSKbVe7mrVdTN8/zZZP2cePIQrCCRREq6PmXMNL9kfn2mNBzgvi
         XP5g==
X-Forwarded-Encrypted: i=1; AJvYcCWYJ6ZF7rt1lgZeO2TYI44322++PrkkhU6GNd+u/7qVx0qW2nrp9EVStb/fAMLxqpLZHdiwV/wwplp02ISLmVypABII5Vhk4yArHdplCZ6Wmm9eG2M/QNlMfpcQWTWohSj7fT5/R6RivOpcQZiwiawPeelCBhzc+l6tUH7xfNDqT2BgXf62PcW/cDAPWFMWZhiZk97O31RGSuYN0sE+G4J+dRWYBQIY1NET0lJhAmKeZxX20RW8Lps5L1HCVg==
X-Gm-Message-State: AOJu0YzgXcvTuy0HRNjSOQlqi3WrO/w04DhcsKEwEvwwhweOQncUOTs0
	HtA4L+sAorouIUeXqnm1hCTLU9wHNt/lazxJHsbhU52mVNysTlf2
X-Google-Smtp-Source: AGHT+IHNvVbE9cA2XCQLQKjnl3qgdgnVkMyNXB6fh5i88nUQTMFnT4C4mWly1ZAKH13pWuCwaxCS8g==
X-Received: by 2002:a05:6a00:1950:b0:6ec:fe38:d94 with SMTP id s16-20020a056a00195000b006ecfe380d94mr14924140pfk.33.1713836607279;
        Mon, 22 Apr 2024 18:43:27 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id gj14-20020a056a00840e00b006ed93e7ef22sm8471175pfb.39.2024.04.22.18.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 18:43:26 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 6C2B718688A48; Tue, 23 Apr 2024 08:43:23 +0700 (WIB)
Date: Tue, 23 Apr 2024 08:43:23 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Wesley Cheng <quic_wcheng@quicinc.com>, srinivas.kandagatla@linaro.org,
	mathias.nyman@intel.com, perex@perex.cz, conor+dt@kernel.org,
	corbet@lwn.net, lgirdwood@gmail.com, andersson@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
	Thinh.Nguyen@synopsys.com, broonie@kernel.org, bgoswami@quicinc.com,
	tiwai@suse.com, robh@kernel.org, konrad.dybcio@linaro.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH v19 41/41] ASoC: doc: Add documentation for SOC USB
Message-ID: <ZicSOzE8KyaYGi0v@archie.me>
References: <20240422224906.15868-1-quic_wcheng@quicinc.com>
 <20240422224906.15868-42-quic_wcheng@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240422224906.15868-42-quic_wcheng@quicinc.com>

On Mon, Apr 22, 2024 at 03:49:06PM -0700, Wesley Cheng wrote:
> +.. code-block:: rst
> +
> +int snd_soc_usb_setup_offload_jack(struct snd_soc_component *component,
> +					struct snd_soc_jack *jack)
> +..

You forget to indent snd_soc_usb_setup_offload_jack() prototype:

---- >8 ----
diff --git a/Documentation/sound/soc/usb.rst b/Documentation/sound/soc/usb.rst
index 3f7c3ef6a0c03c..0b6da0be9f317f 100644
--- a/Documentation/sound/soc/usb.rst
+++ b/Documentation/sound/soc/usb.rst
@@ -218,8 +218,8 @@ state.
 
 .. code-block:: rst
 
-int snd_soc_usb_setup_offload_jack(struct snd_soc_component *component,
-					struct snd_soc_jack *jack)
+        int snd_soc_usb_setup_offload_jack(struct snd_soc_component *component,
+        					struct snd_soc_jack *jack)
 ..
 
   - ``component``: ASoC component to add the jack

> +USB Offload Playback Route Select Kcontrol
> +-----------------------------------

USB offload playback heading underlines are not long enough to cover heading
titles, so I have to extend them:

---- >8 ----
diff --git a/Documentation/sound/soc/usb.rst b/Documentation/sound/soc/usb.rst
index 0b6da0be9f317f..5e0e9fad131b24 100644
--- a/Documentation/sound/soc/usb.rst
+++ b/Documentation/sound/soc/usb.rst
@@ -482,7 +482,7 @@ into the physical USB port and enumerated.  The kcontrols are defined as:
     kcontrol exposed by the platform card.
 
 USB Offload Playback Route Select Kcontrol
------------------------------------
+------------------------------------------
 In order to allow for vendor specific implementations on audio offloading device
 selection, the SOC USB layer exposes the following:
 
@@ -545,7 +545,7 @@ along to the external DSP.
 
 
 USB Offload Playback Route Status
--------------------
+---------------------------------
 SOC USB exposes APIs for keeping track of the offloading state, and expects this
 to be maintained by the BE DAI link that created/added the SOC USB device.
 
@@ -573,7 +573,7 @@ When executing the kcontrol get callback, it will loop across the active_list ar
 and report to the application for active USB sound card and USB PCM device indexes.
 
 USB Offload Playback Capable Card
--------------------------------
+---------------------------------
 USB sound also creates a kcontrol for applications to help determine which platform
 sound card USB offloading is linked to.  This will allow applications to further
 query the platform sound card for specific information about the current USB offload

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

