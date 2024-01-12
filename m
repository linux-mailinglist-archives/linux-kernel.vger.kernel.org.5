Return-Path: <linux-kernel+bounces-24491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3829882BD5A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D661C23D3A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B00557303;
	Fri, 12 Jan 2024 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mawCA5/4"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB11251C2E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 09:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e54f233abso31526035e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 01:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705052191; x=1705656991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrigGjhUftMsEvvhMgmyslWsk/A848z/GQjhjvTjG/k=;
        b=mawCA5/4be53fynPQBvy4OVV1P0XzS82li55NAuCX6XeGOGq6MjgkoWY8XnzicHh/W
         WIeSmWTXK4ZhvKUYq5B0kJ1M69OKXuo1hIEzd0CEt7/BmfETnCRY5TR7BGFw05HNcEfg
         4yKAYOIqjAJA7eRdI3d3dyPc83Bqnb308ALftmgJ7jhvDZMsVeA0tx4Qp8dbP0k5cqLc
         PNOcwkhY6yIQWVffQRek1jXb2qXhnZ9jCYrbXRl2NImhW13wpGlCBZPhHw9BUMqVAwja
         Q+hi/G3i6n6kk0JNMgiXvjnGm4V+WmaoqonHDIuyH+gvffTZKu2P6EKIDRDVp1HD96dj
         lIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705052191; x=1705656991;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrigGjhUftMsEvvhMgmyslWsk/A848z/GQjhjvTjG/k=;
        b=s5HCQfk143CRYy6/bRSLK5rLzrmppwQWBHVdcuFmgEYCZweG1T3GHDiGrFR4Bv6xBK
         p1cvD0QTD+q7PX+s688O3KJqLY/I8iCQdB2QMUQ9eEfqi4Txyyx5+/6QNc/8fq8ly6Ig
         zvdIxHzI4VTEFW1o3+m1//3rdINnI+mhOYYZDA5RFUAgJA7xpWrnVuR7cuB4WA6DGpyp
         Aiocu9U+e1KNlzeTPAgbguanGH2WkmgMDoXI7zYy3BY+BMF41Dp1amwdd32N0PToqw6A
         taof3f+6xWXj+WHJPVzi/E8SEF0PqS5lWYeKzlYl/yoiNO+m5sGYJZP2ukSgW8ExCyXT
         Zkrw==
X-Gm-Message-State: AOJu0Yxibbjc9A5T3mlkdqD3LaJKw89d+0iqisnqQDZUvZzLPREWIa00
	TRDc8dvK0pKwex2m5DrZ/QO40k7dizzLsw==
X-Google-Smtp-Source: AGHT+IHgqUL55KHKFHM7XsRYKmr5WOBKPZJZ5ZbriznBeeHT9jeaIeg+abl+at93zuAmnmr9t1om2w==
X-Received: by 2002:a05:600c:1f92:b0:40d:70c3:5f3d with SMTP id je18-20020a05600c1f9200b0040d70c35f3dmr577626wmb.105.1705052191103;
        Fri, 12 Jan 2024 01:36:31 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id fl13-20020a05600c0b8d00b0040d8cd116e4sm9009008wmb.37.2024.01.12.01.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 01:36:30 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: hanxu5@huaqin.corp-partner.google.com, chenguanxi11234@163.com
Cc: cgel.zte@gmail.com, quic_jesszhan@quicinc.com, sam@ravnborg.org, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, yang.guang5@zte.com.cn, 
 jiang.xuexin@zte.com.cn, Chen Haonan <chen.haonan2@zte.com.cn>
In-Reply-To: <3ac20d355b0b3ad3cedb87c8f4efa819a055624b.1702967834.git.chen.haonan2@zte.com.cn>
References: <3ac20d355b0b3ad3cedb87c8f4efa819a055624b.1702967834.git.chen.haonan2@zte.com.cn>
Subject: Re: [PATCH linux-next v2] drm/panel: Simplify with dev_err_probe()
Message-Id: <170505219020.999327.8364667104260922232.b4-ty@linaro.org>
Date: Fri, 12 Jan 2024 10:36:30 +0100
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

On Mon, 25 Dec 2023 22:26:15 +0800, chenguanxi11234@163.com wrote:
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


