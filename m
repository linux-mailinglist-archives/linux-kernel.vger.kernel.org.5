Return-Path: <linux-kernel+bounces-54420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A24E684AF04
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419691F23C3F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443F97EEE0;
	Tue,  6 Feb 2024 07:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KldxFJC1"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CBB128821;
	Tue,  6 Feb 2024 07:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707204736; cv=none; b=fdA335vhYymtrpjpKwy8IQ6uypSq9vPB2wYpYvQAeErLhVj03D8esRfVX2Nhqk3IL6gLu2ezhkYlUfgbIzan83dw3JqaYa625BlPUrR4w/vF8bKnkcrBcXAI+Cymobe57UnHT4tSmyNgAbKILJM8RAK4zzOwaVt2Cmb5H785ZRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707204736; c=relaxed/simple;
	bh=byYCRMx/N+GZh+e3eL8SF/WkTDnPO2LUbyw3eCLNJNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kESevwbd9whXqajJJ27bkcSvH5d2VkD0NiI4ZZpkUkDhxhJub2WCgeIkSdQycX567Hs+YYkIWkFcPEk45tDDRvwf94dIvVs0zV9gTQL6biBI2O39aKJNU/mXE/mOB+PxrsxnkJVYN9Og1V/xAvQSxDIPlxoRNRWlqK9l/lpulLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KldxFJC1; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d8df34835aso250716a12.0;
        Mon, 05 Feb 2024 23:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707204734; x=1707809534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l8Ic/7ZqQNN9pKqwAasZzAHy//XqdnT4TIY9t8+tW+U=;
        b=KldxFJC1sVEqj5Pw9hnlmXdw19Ybw8mDFJDRc7o/YyABW9sL4rpAVAI/+fbq/UQJ+Q
         dFGSa8divf8K5CQiRfbXYHzprnR9aFFL1WyGuxDT0NYNRlHJ9e9yuWPkKCIUwIHpaIwH
         iYCwX2cVMt+pfOl3f10yQDiEtrFPIVKd/vBCHyzNbTsOZ97d5La2CiPc3Un4iETqwaLW
         1NvJ2P4mAuTINUTv8dn8dJb7VOJFw1Nz9wBgiJkqjCRh3saNZSO1VIaB5+g042grs+PW
         ekZlcZvZDTbt6UYLppgi1EgD6yXMrVMkuTFosuTbiyRgDlOUzVye2YOOW9KtBNmCsdzw
         lGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707204734; x=1707809534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8Ic/7ZqQNN9pKqwAasZzAHy//XqdnT4TIY9t8+tW+U=;
        b=hy+GDh2SkkSDmVY4eLNSpSd5axhku+aqO9NaThOVRDV6u1pRxgZIuEYQqL1wl8X2Mj
         mgQhuuGhPvvpQdbQOnmAqcvDgqoy2h+5CJjXrgJyoN2yZFdcSvov8XH8LJ9d4QMMT/bO
         65jV5rd7FSAn+mRirchHGyUCUq80OQajWu+2XmipBmq9m+i0PZxIHe9b4R9udBrP/R5w
         o7YxpMg1UeseuDkGwxZFVSunjIS6lj58VIDGzjiSuiy9anjgKJ6aXIOgk4t3P6G5JYNM
         kjXvQTb0owu6Cxu62kaq4rMV4Lq/WGD0liXE7jJLEgQdUO8jTGAjyREx+ZjMKk2hLwW1
         L3ug==
X-Gm-Message-State: AOJu0YwQxXBqTJzC4rJypE4ZA47gqb2v8L61FLdraGp+wIB5ip4CgdOR
	lzW91UN8PlMcgrNtF18rbwihklCF/5lYPqohWjjIXm4rNAFY5Ebr
X-Google-Smtp-Source: AGHT+IEd+h+zMzYf095OK36P2DgF0n7FFAe5VTL2/fjW+Z0Fyq7R6VLQwHKKUXgaG3EG5SYnm9VZtg==
X-Received: by 2002:a05:6a20:6f8e:b0:19e:5ac2:a342 with SMTP id gv14-20020a056a206f8e00b0019e5ac2a342mr1485684pzb.17.1707204734407;
        Mon, 05 Feb 2024 23:32:14 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU/Gj84XSufReOxKgpj72n1VzF06njLWMKKj+fvYxf3vdNdY8gKR2zt9GHd4ZtWh0vFYyhavtfOU1jdRuvUaOiVIr1AO6G0qyvaXYQrOMlUkT795WN54Wmz4qslwm2ClHa8WPFWaJznX72eMyppxOrwu3TvTuJkmgNhHUCsmVs/v1AY+DhIMpLVnb97SEV2/aoqPwitWRDANa3lyD6PHkyTLwyhqKuzrfQlUI/Er53AQZSXeySOkU6bgicJrWJkTRMcnfiWLFtzRY02fI6p2Po4kffwBr+l/svj+0HwRgnP6+QjeGlE/di7MizYx3HFXkurYJ9hh9MHLKolLPu+jbhRbamYsEyhPTwPXCvfOXjxufcBXq7dMIhvEn42hCLRcIHiLT7kljqV6vD6kiDAOyKysiz/dqEoPmPZmmiRIDpoid36YdMIUkZNJ8ACNygXmdxH0bditA7H0rog+Vc+ok6vK++vq39oqhSGzXwkmVVXd85idwKd+X9aO+u68R/9aA7b9F41BsqDRhDWly/4IhEPvY0niImU52GQ
Received: from dragon (144.34.186.27.16clouds.com. [144.34.186.27])
        by smtp.gmail.com with ESMTPSA id z12-20020aa79e4c000000b006dfbecb5027sm1160173pfq.171.2024.02.05.23.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 23:32:13 -0800 (PST)
Date: Tue, 6 Feb 2024 15:31:59 +0800
From: Shawn Guo <shawn.gsc@gmail.com>
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, Li Yang <leoyang.li@nxp.com>,
	Primoz Fiser <primoz.fiser@norik.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Christoph Stoidner <c.stoidner@phytec.de>,
	Wadim Egorov <w.egorov@phytec.de>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 3/3] arm64: dts: imx93: Add phyBOARD-Segin-i.MX93
 support
Message-ID: <ZcHgb4egPKh+Yqnf@dragon>
References: <20240124074930.26101-1-othacehe@gnu.org>
 <20240124074930.26101-4-othacehe@gnu.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124074930.26101-4-othacehe@gnu.org>

On Wed, Jan 24, 2024 at 08:49:30AM +0100, Mathieu Othacehe wrote:
> Add basic support for phyBOARD-Segin-i.MX93.
> Main features are:
> * eMMC
> * Ethernet
> * SD-Card
> * UART
> 
> Tested-by: Primoz Fiser <primoz.fiser@norik.com>
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>

Applied, thanks!

