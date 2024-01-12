Return-Path: <linux-kernel+bounces-24490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EDE82BD59
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 562A41F25810
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1DF56B79;
	Fri, 12 Jan 2024 09:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="neMY2s/G"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA44D1B28F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 09:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d60c49ee7so70168245e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 01:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705052190; x=1705656990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qgz5LyPiFVmgCE1Sf1kAN8+Rh5MO+/KEzBX/qgkA63Y=;
        b=neMY2s/Gp01c9UhyWp86qMHoaaFtM9Po9yGmk3hADWi41TxcPhXX9E8a9c/Cj8d6Cc
         ygMBQfm7TFWW6Qo0bPnt1sVxXzwLGLOZE1TAEqv23jxYtDQg0JoKlxCk9vhpCEJHkb4k
         +DWNj3e7LxLjuQHSacG5jbef6O9ck9OR3GdVOKiFGq2HYThyIC0rOOF+ohFSn79+SG6H
         2XVvXrJBFg/hcf2fq9VDPe9zkhaP43UrMmP5Uuwh1YvftVVgS07F3IT897v1kaflL4Bg
         eK7L/p3d10EqAM14q83u6z9BG1l2qUMMoY5ymXM4HC2WkJhm/PBylj5al8YqJKDkS7JV
         tfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705052190; x=1705656990;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qgz5LyPiFVmgCE1Sf1kAN8+Rh5MO+/KEzBX/qgkA63Y=;
        b=MzUNKERcxRm0brA4JePDDXNs3PDs9IJ4aK8vYyVbPdI30dL1QOW3/h6sAHUCzoSYfO
         sTi/q8hiUC4BSxzxnWxB0msDrWcIKOjvXD38GWn1dTtlZtdmtttD06KEW/FXPciLNPJt
         OPT6Sc2GnXp8mtCPeOAagaLzmx1heKewZC5UMM0h2Tm2ub5lq0k3fI/ehOTNpxTVhl43
         y3ZKxYkWUTJIMzRnssKlbfAVXfr/kikAKp3K/IJsxnK66NSYMx4eXdftdWZzGeSxqdc5
         7Aly7q5DiuahbsceJMGkARjTf7gL5BlaJgRRswL8ypuVRSTh1lG9M8hCnsao/dzzu1TH
         9+Bg==
X-Gm-Message-State: AOJu0YyMEotXMlHrtzzSnrYHxqOaeMYJ+kSFjl90g/KHbf5rRHghDrhh
	PjRRGMGSGOT5wcVT4/6ywjh0pPXvtwqhig==
X-Google-Smtp-Source: AGHT+IE9hMSKYuNwGOMj8HRgn3+LdsUoy/a7XvjYTTlp0a9D0GB2cY+25GwRfXaBbeHxcQtDsNr4IQ==
X-Received: by 2002:a05:600c:130f:b0:40e:68aa:8b6d with SMTP id j15-20020a05600c130f00b0040e68aa8b6dmr52256wmf.33.1705052190120;
        Fri, 12 Jan 2024 01:36:30 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id fl13-20020a05600c0b8d00b0040d8cd116e4sm9009008wmb.37.2024.01.12.01.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 01:36:29 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: hanxu5@huaqin.corp-partner.google.com, yang.guang5@zte.com.cn
Cc: jiang.xuexin@zte.com.cn, chen.haonan2@zte.com.cn, cgel.zte@gmail.com, 
 quic_jesszhan@quicinc.com, sam@ravnborg.org, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <202312201048538333616@zte.com.cn>
References: <202312201048538333616@zte.com.cn>
Subject: Re: [PATCH linux-next] drm/panel: Simplify with dev_err_probe()
Message-Id: <170505218910.999327.5319629323020953122.b4-ty@linaro.org>
Date: Fri, 12 Jan 2024 10:36:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4

Hi,

On Wed, 20 Dec 2023 10:48:53 +0800, yang.guang5@zte.com.cn wrote:
> dev_err_probe() can check if the error code is -EPROBE_DEFER
> and can return the error code, replacing dev_err() with it
> simplifies the code.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/panel: Simplify with dev_err_probe()
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=9f78b3ae051d9eeeed9658cf54b3f0ea6920097b

-- 
Neil


