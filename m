Return-Path: <linux-kernel+bounces-74189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3178D85D0E9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF5F92868FC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449DE3BB4C;
	Wed, 21 Feb 2024 07:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rKmildM2"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032BF39FED
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499314; cv=none; b=eNv/7XGpX1Kjjg/WmTecHaFidutEz549FVVYCWeFhtplGbXjPYXYoSKd4BxdvxJMzGs/tgW1W1qgLghadVdUfL8QmCCVkhk0ZfYUViDo/54Y2YrTnyVrIKTiZQcbk22RBLB9lteLGNoBC5tsF3HOq73ktIVGoxkxinTR4/NZ1eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499314; c=relaxed/simple;
	bh=ILMWXHf1c4fKHxaiL2VfH6xoMnEXAVo72XaCgHVtOAI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ipdG70aGIJLQKg7hLh+6TNSS42HGWmEDP/AiLr8xSMPCO/I4ZGUCf+923N+YcWUS9xH4cp+lx04Wz2WMgsVVyfZ3GL93Ch4NIv5wda6N4xoDLMKw9FZuKtNGiVfI2CObeZh6AofXDoqxEdn/kfzvHSDSmdmU8xM6mwuMFqsZ6Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rKmildM2; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41272d42207so5879615e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708499311; x=1709104111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wz/aacgnQr6q7J4QTYXshFSvodlW8ID/l/+tL4l/K6I=;
        b=rKmildM2H485LDT1Lcl3yjYXtkhF6AgUCCufhtZrnrswDT3qyGcwH2x0miM8iYxyRS
         r5mr5yAuxodts+4Hj84m4dlNt3ilKBEcmFYPJ3sZ79pDYGrnE6hTooJUmKn9KSewdkzh
         2vKHQCrRyCYTzEsJVCTeBkDoRBm9YvMMRYMRhjZ90n+mJRwFCEEUqmTGtaq0SZpgNXmm
         0W9mbfBA6XVQdqSpxnniaz5MHztQ/Loa4tpyv7b9p+AVskxN/am0rc1qP+52i+OcVz2p
         di9E0MYvj+ZC+DtM/PD4kRQW13H8DBIIWCbWs7G2vWriXUBPbITfVnGvhA7wXXGARqMw
         DuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708499311; x=1709104111;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wz/aacgnQr6q7J4QTYXshFSvodlW8ID/l/+tL4l/K6I=;
        b=L0x98DQnIphdF6bWpQsykjbKQedU793ZZFT4i8GltsdGBwS8aJKMQD1EyDd1BSb+HZ
         SA1sxeFNqcIHLNSN1n+ooScBRe3dPZBVDTgW7Ezi4lp8VZ3T0y3YpZmURVoHjJrG/XEq
         SgMGsUZFoa7eIRl2UGgWWieaFhz/039otAR7sL/kYzdk4hhNL7d7qn9OmxZygoCsKdML
         8Yf8Ufpt8Gx7gWLj10c5DSY7z5eWLXopcH8xNaUtFnp8jXBv0N1XF82h/1R1bNOzEBCx
         JNXADQdt2om2EydwUe5af2hibkjZykRM3noiZjeE906ybDJF5XAFC2cvRyCXooQ45V9G
         i2ww==
X-Forwarded-Encrypted: i=1; AJvYcCU+ymnTosPCoagRD7Epuwct/AJ8wpUCm21eHirc2dvpA/rYW/HBGxQ6HaJtoS3IueeWgHSGdl6ajiiqR6Ztn5msdthqyWjQ2cu7ryRL
X-Gm-Message-State: AOJu0YzC2ZiIzzbJuv3k+0nM4bav9bEyorza9B486mFIcEl2BHuV1ZXH
	y5+V13+6VjNnoXyJOARHCL+/tiJUVIX327H7fvRGHpBp1HuOMzfjBSmVQqRCbWE=
X-Google-Smtp-Source: AGHT+IHkNCk1VUxhjyPZwK1t9iqMEkJTTUWnWg1Cbi1kKmz7lDz1AItpjPBmJIU2ebvjOgJ900bIrg==
X-Received: by 2002:a05:600c:1c1e:b0:412:1d7d:6c51 with SMTP id j30-20020a05600c1c1e00b004121d7d6c51mr12626174wms.6.1708499311213;
        Tue, 20 Feb 2024 23:08:31 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c3b1000b0041262ec5f0esm10700077wms.1.2024.02.20.23.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 23:08:30 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: linux-arm-msm@vger.kernel.org, Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
 stable <stable@kernel.org>
In-Reply-To: <20240108100513.19993-1-quic_ekangupt@quicinc.com>
References: <20240108100513.19993-1-quic_ekangupt@quicinc.com>
Subject: Re: [PATCH v1] misc: fastrpc: Pass proper arguments to scm call
Message-Id: <170849930946.22958.1400106110222273867.b4-ty@linaro.org>
Date: Wed, 21 Feb 2024 07:08:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Mon, 08 Jan 2024 15:35:13 +0530, Ekansh Gupta wrote:
> For CMA memory allocation, ownership is assigned to DSP to make it
> accessible by the PD running on the DSP. With current implementation
> HLOS VM is stored in the channel structure during rpmsg_probe and
> this VM is passed to qcom_scm call as the source VM.
> 
> The qcom_scm call will overwrite the passed source VM with the next
> VM which would cause a problem in case the scm call is again needed.
> Adding a local copy of source VM whereever scm call is made to avoid
> this problem.
> 
> [...]

Applied, thanks!

[1/1] misc: fastrpc: Pass proper arguments to scm call
      commit: 5169a077f22a23d27660d048d5f43a592fd2c62f

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


