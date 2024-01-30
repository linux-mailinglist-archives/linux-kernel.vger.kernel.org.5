Return-Path: <linux-kernel+bounces-44871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F4B84285B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91A741F2746D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6698986122;
	Tue, 30 Jan 2024 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aEC0Ca5e"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37998121A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629749; cv=none; b=RZmy02zIPNmwhlSDpJ4ry78Ipwfg/3xrjDPBDKOiBweOF/bPqFfxQwRF9dYdHf9soJOusOVrww9QiCecd6v5D8RHNpO1WruBj0otWYkGrTw0ueDHrDcAfhFPNUYH33QlKJv5j9byrRBErJgODVfLib1qPdRjdLwqM1xMlLBMX+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629749; c=relaxed/simple;
	bh=pTA0YMokaA0OHcx03bR1lxoroP4wL9uAc1cyu07K0qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTTd8FFx6ea8U8K0dPXpGiEBqO8lBPPBjquLP32oicznry5lB06vEPhT7T10OVu3LU/dKwOZappW4eMmpdRY5T39z1LhKcEzXzWHn0XAWrxnjx6W/c0uzQSCBwVzsCN3cO31EQBG8t4KSUhYtxKzdB4GNKHtlH5ewiPiCaCBCE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aEC0Ca5e; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40fafc8bd6dso3764055e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 07:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706629746; x=1707234546; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YilpzfeTkVydeu8rZL1Heb643X/Jk6q1uV/3UL6XRrw=;
        b=aEC0Ca5ewNdtm92avr3pSba35A8/7klAspPfWi07KLSGMa6TjVtE18SnmcacTEMlXz
         ggACP9qk3yuS1iGos21/fQYW3EV1Qblri8ixCiWrWfpy4Kc933+7mfyBOZ3m6UtySEZI
         vGAXMPtawZKdsQW6v95OqMkxDq/7wFNYb2GqiQvzLhr7x3QtgdY8zstVKUBPrWCaW/Bp
         MATMCF1LTctfTQwHHS+1nYYs/3ObnEEJscm1PaPB/VoFC4pXv8344S2VAsx5cXABSLfe
         YGZ6NBVppppGOzaBYC25xOtQk8VhFa50/JksIJoP9W7uwYBkMp1XjA26Y9jl2GBrmprM
         wVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706629746; x=1707234546;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YilpzfeTkVydeu8rZL1Heb643X/Jk6q1uV/3UL6XRrw=;
        b=JMU9V0DuM6GZ9ujzlQMMNx1lrrFoUCm/nUkW2cJ72/Ly5QOTKZV6JmpYMc3DPCQE/4
         jOgkU+XdzKSgF5oDfTVjAin6WXQ+y7BCTXinYhoyDAMS4kIEnFagloHjHs30CBnDDL2C
         s/ujZwd72H1F7zJtYIwp55vhVKbRymBPF8VZ1I2Owm5JmTZb7U44vFGULO+29ARLNUCD
         0l2MOQonSlZ4Ul9jiHT91/9qt2jSXo4WMyQGyK2pX9IbQc8E6LlWMsYEkYWEY+DpR2sa
         LfQz+IloHUazSKlQotNUf2OU9pGCN+bFeCMvAP+oTclTixAr28SdrT83H47GrZmWHQ8t
         2w4w==
X-Gm-Message-State: AOJu0YyLUIGFH3Vmz68CBh/vwQabjYjYJCsxY8lzC1Wpu1H1TWsaMrOJ
	lZfBrJ5vcYucqD7+CpcVdsYaxJ3cud9S++Ttt77MdZKeIHDguB9O3AD2Gv0hZ+c=
X-Google-Smtp-Source: AGHT+IFcHSOTOqrPAz8LjD4G2eREPrpkyWJ8wUJcJtLmYSq0P709L3wMWpvTQHOdkBEqjyVsfdwaVQ==
X-Received: by 2002:adf:f489:0:b0:33a:e9d9:5e82 with SMTP id l9-20020adff489000000b0033ae9d95e82mr5041773wro.51.1706629745960;
        Tue, 30 Jan 2024 07:49:05 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id ce6-20020a5d5e06000000b0033af3a43e91sm4434425wrb.46.2024.01.30.07.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 07:49:05 -0800 (PST)
Date: Tue, 30 Jan 2024 18:49:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-fpga@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luwei Kang <luwei.kang@intel.com>, Moritz Fischer <mdf@kernel.org>,
	Tom Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, LKML <linux-kernel@vger.kernel.org>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH] fpga: dfl: fme: Return directly after a failed
 devm_kasprintf() call in fme_perf_pmu_register()
Message-ID: <b7e2e9d1-5e3e-44b2-a4b7-327d334b776d@moroto.mountain>
References: <d94376b6-12e8-45bb-a9be-4887bb316d35@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d94376b6-12e8-45bb-a9be-4887bb316d35@web.de>

On Sat, Jan 27, 2024 at 03:55:19PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 27 Jan 2024 15:43:42 +0100
> 
> The result from a call of the function “devm_kasprintf” was passed to
> a subsequent function call without checking for a null pointer before
> (according to a memory allocation failure).
> This issue was detected by using the Coccinelle software.
> 
> Thus return directly after a failed devm_kasprintf() call.
> 
> Fixes: 724142f8c42a7 ("fpga: dfl: fme: add performance reporting support")

This basically doesn't affect runtime because perf_pmu_register() checks
for NULL so no need for a Fixes tag.

regards,
dan carpenter


