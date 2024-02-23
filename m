Return-Path: <linux-kernel+bounces-77845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D996860AF3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED183B246AA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D47112E50;
	Fri, 23 Feb 2024 06:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IYuc23ZA"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F4E12B84
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 06:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708670836; cv=none; b=Z+aXffLYDc5NKXxRcvOOAelWJFLHE4NafPU6wV/gz8POQ+NFrNuloiILfLHkU9Yoe7NG4sOly08BctFx+7av+q7NoxJIJZ/4FkID6hsjBYchKhBsCH9fJU++L1ZrgC3rNqYQ9OQ62MkDtqgOVECOjy8mQCUYyehlOvB4wtLsVKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708670836; c=relaxed/simple;
	bh=XaikJ0Vqxv5/owJt8g9Lm4uWIq8JbSQckm1iXMFhiCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRRUIumsSGIskvR8vTgpGDZ6mZ9npOITfL3XKqst9prCf56g1hmW9Gr5rOyEXl3/6LUypF7MNUK7dpK0dfds4kdJ1kQtR03HMrpmi6Qm9bk9Hh2X58+3ge2poNvFE0EVTDEFrPNvJAzeKkvDYhbv3hDJn847rRovL2nEQqiPB2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IYuc23ZA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4129038a3deso3284255e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 22:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708670833; x=1709275633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kyd09IvSF7omogU+h/zyCJafYe8OOZZRjtS0nOars3k=;
        b=IYuc23ZARILW5/tjz24Q7ZgV3ioxyVwmOk7nkZtO2lTIgxBC2dmmGkVswGM5iksCu4
         f/LEQh06dQTRUB3cgh/pCUJndVMSlcrgXQkumHUTiE/umpjgevsfb7z6Y+0USqSdUawe
         VIrbMH09DbT9HHS0qFXYuSjbZcegV0S9ONNoG4fQNK3sr7FrQiJkjtTFArmfbnL9etvG
         b8e3M5dyWhxZ7zywnUmQrf0Sjj3ywELZYzf7WW43wBbarwfpSrHRDSj4pIZ/6ZrW6xyl
         RkLA1WZK909brIfVav3dbkfDJr4YLtDkPjScFPreq2MnSipM3y6zKvoh43/2etauIjX9
         XMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708670833; x=1709275633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyd09IvSF7omogU+h/zyCJafYe8OOZZRjtS0nOars3k=;
        b=ck+VaQ2RxGON8YYvmme4fos0EIFCjIvgoqx6lWadFogRZhuYRQjCRmLeCVylhi9rf3
         jxNRspIzg/lUNS5nCqIdirPgnj4D/n0n7MK3EmQnAW4l4UpRYI8Ud1Ctx7d4RElS4aLJ
         w3goJT+GgmgK9xkbMtjuA1mFOrggRGu32xk7l/xtt+0OkMnRXgFBWAWrOFqtXtvB8kiN
         FnG29xVgwVbFmrbwn8z0k+ud7AEJIZNsLeGK4YfVtcFJO8CYnuvxkM4DhkoUuMZTeUjr
         67hYwnFUYQMpPx3g0Z4FBvEQ8F5Jgq8dMDXc5gU5u8Y/QGAjz5pAMrP+AT0dGvXU/66Y
         ChaA==
X-Forwarded-Encrypted: i=1; AJvYcCVdmvY3iD023kN4vt5PGLnZP/nXzc5DVhQfLtnLOZe/GEKC3skJKlb+q5hcqk4Jf8kCtPo58FY/Z0ivH4XVPI48P/PSFfeYIWM8oXBl
X-Gm-Message-State: AOJu0YzEMZWrAELRz5L7yeMi+aIvnbQb6Hcsm2wZH6hLeeG1tB7nA8YI
	kmO7EF5xWWDL2eEURyxP+nE49LbTQleEXM0/ttXY3ZIt11phoyka4XF+bVaOcU4=
X-Google-Smtp-Source: AGHT+IFa4F7JCo816qd08qJytnkaOEApdM3plMi+keu68PlvjipxHkYq76LVVneFPr/ZB9QKYJYcvQ==
X-Received: by 2002:a05:600c:1f10:b0:412:5a3a:7ff4 with SMTP id bd16-20020a05600c1f1000b004125a3a7ff4mr643537wmb.38.1708670833141;
        Thu, 22 Feb 2024 22:47:13 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id t6-20020a05600c450600b0040fdf5e6d40sm1162858wmo.20.2024.02.22.22.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 22:47:12 -0800 (PST)
Date: Fri, 23 Feb 2024 09:47:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Ethan Zhao <haifeng.zhao@linux.intel.com>, bhelgaas@google.com,
	robin.murphy@arm.com, jgg@ziepe.ca, kevin.tian@intel.com,
	dwmw2@infradead.org, will@kernel.org, lukas@wunner.de,
	yi.l.liu@intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Haorong Ye <yehaorong@bytedance.com>
Subject: Re: [PATCH v13 1/3] PCI: make pci_dev_is_disconnected() helper
 public for other drivers
Message-ID: <88915639-b6cc-43f7-9ac7-8e2dde982757@moroto.mountain>
References: <20240222090251.2849702-1-haifeng.zhao@linux.intel.com>
 <20240222090251.2849702-2-haifeng.zhao@linux.intel.com>
 <9c4637d5-6496-4c68-b2db-4be1e56ca746@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c4637d5-6496-4c68-b2db-4be1e56ca746@linux.intel.com>

I'm not a PCI maintainer, but first two patches seem good to me.  For
the third patch, my complaints were really minor.  Let's just add a
Fixes tag for sure, the rest is okay.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


