Return-Path: <linux-kernel+bounces-165856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BBC8B926A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A0411C20DAA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 23:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68858168B1A;
	Wed,  1 May 2024 23:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJJU5NG8"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7786C42A96;
	Wed,  1 May 2024 23:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714606741; cv=none; b=Mm2YzPOm3s9roIKixHz4ir6nch9Km7QFmZV5l4GcDh8YjSQA7/wp8JZliUOiufcHEp8YV4c5tN44ZjEqTX93lKIFhbO9M0L3vxOGCI/aupyx+BrJ7/gEmj6h9QMjoJepvKezn9VVjsq+RHEtUj0l000L7QYT5nMJfnA9VUVq164=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714606741; c=relaxed/simple;
	bh=sAWhs9jOyU3K4rULubdKQssmAH2mklmjkWpo7Fp5YOA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oiEgzkvSROjnd7r5r+qLtKp6r2XRM6UgDAkaDvMhu6jXQVtw50fgSzJgv5jo5o8mO3z4ejCtsag8cVscNLcBV4Oc6MjmDMgfiCFRwkZpDJSXm8C1DaIyd3d9vamr+KuuzMr6aOFENMPQsaU5yjJJ8bSNKpSFNbykmAvckToWAHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJJU5NG8; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5f80aa2d4a3so6030070a12.0;
        Wed, 01 May 2024 16:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714606739; x=1715211539; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75Xvc7zrlEfmkMI9nebj9FrvBmWWK0w54I8lGIIUNsQ=;
        b=UJJU5NG8ZVIKWvJNojKuP+a3ZXBLOUVABvawytVl36BZF5w+YwoStdlYqZZbTXdLYx
         ejzF37RFUctcQIzPoptR56Dx0k8e/Z6AQ8AxiHv7iwCOhUN9nauy9OvB7KqiNlD+vm5u
         KVBAZgaHIxkv8UeZ/+lSV23VspCK8Ko5hnVoUwmkgBQ8QkdND8D7oMVq55Lq0lctGNyD
         aw6+cjyYH+NFU+Dn0vZL56eTRroKviC/bR2bwMVHu61T/N/EBxRRBJe2Sd2HYjwwnMJ3
         Kwy+DXNsoVVupzgDiQ1XJz9v1sqPKCBfdEgMDpzVoNYHmKeYqCfHAicfRVMJeRGxM39J
         Zgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714606739; x=1715211539;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75Xvc7zrlEfmkMI9nebj9FrvBmWWK0w54I8lGIIUNsQ=;
        b=cCU0U4zd3RTLD2CFJGnYi2S6BvGVXvPGc2qRMpKDzBEBTLZcqWK/a8JqiyLs9wosVJ
         yqz0cYRLN6fsJQv3FeukigJKecXYAExaKNasAxBlbHgjrWQ6Bzwu4iqGOm0lIaIZSMJI
         2KmXTsSYjFhQkrFyidM8NRKHeC34c+/Iu8dWkx+TMxqDuqEwkNnhgoXd/mRgpK8Z63Oz
         lglp/OSGsLk3QqT3jF5lZ4g78jgm9Ur/IBieiGzpxBswIkKUXedi/gi0pkkQQBaYhP+n
         2eo1C8PvNJh1XkxH5yjZFmJJ7wkJKQLv3c268hdeIF44loIQ+BhcsasJid6BKWwuNBgQ
         YvaA==
X-Forwarded-Encrypted: i=1; AJvYcCWfQ1H5bjfxcfiT5XJ6ryiQddnxLXA2dn2wvbARCHKrg06df5W5y/0ZNAPES3E1VhmuoEeyYi4DyWyR8/IwVr30Q8UPhDBvWUvJgIME
X-Gm-Message-State: AOJu0YxLt/7X2aJaHhakg1k7yPW43frd6V431Pbjh6B3nI17munwOJL2
	kdbA//TSabppVA6MqYSFt84eIFrHeCqphjIyx4p5JzGI28mjoDAGB0ZiYA==
X-Google-Smtp-Source: AGHT+IHgNxy49xxZrYAd4l6cvOp4qdcb4LbJ2Zz0Ly2t5SVNdkiQgxiZxYZtrJZGUqogxVpg3CuJ0w==
X-Received: by 2002:a17:90a:d08:b0:2b2:7c42:bcd7 with SMTP id t8-20020a17090a0d0800b002b27c42bcd7mr4048748pja.21.1714606739395;
        Wed, 01 May 2024 16:38:59 -0700 (PDT)
Received: from joaog-nb ([189.78.25.116])
        by smtp.gmail.com with ESMTPSA id ha24-20020a17090af3d800b002b1b1a3611dsm1889042pjb.43.2024.05.01.16.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 16:38:58 -0700 (PDT)
Date: Wed, 1 May 2024 20:38:53 -0300
From: =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: joao.goncalves@toradex.com
Subject: Supporting a Device with Switchable Current/Voltage Measurement
Message-ID: <20240501233853.32y4ev7jvas5ahdz@joaog-nb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello all,

We need to support a hardware that can measure current and voltage on
the same differential analog input, similar to a multimeter. The mode
of measurement is controlled by a GPIO switch and goes to different
ADC inputs depending on the mode. If the switch is enabled, a current
loop with a shunt is enabled for current measurement; otherwise, voltage
is measured. From the software point of view, we are considering using
the iio-rescale driver as a consumer of an ADC IIO parent device. One
of the problems is that we need to change the mode of measurement at
runtime, but we are trying to avoid using some userspace "hack". The
other is that for a minimal solution to enable the mode from boot, we
can use a gpio-hog and control it with overlays. However,
still would be better that this was done by the kernel. Do you know
or have some guidance on how to properly support this in the kernel?

For the in kernel gpio solution, this is a draft of DT we are thinking:

current-sense {
      compatible = "current-sense-shunt";
      io-channels = <&adc 0>;
      gpio = <&main_gpio0 29 GPIO_ACTIVE_HIGH>;
      shunt-resistor-micro-ohms = <3300000>;      
};

voltage-sense {
        compatible = "voltage-divider";
        io-channels = <&adc 1>;
        gpio = <&main_gpio0 29 GPIO_ACTIVE_LOW>;
        output-ohms = <22>;
        full-ohms = <222>;
};

Regards,
João Paulo Gonçalves


