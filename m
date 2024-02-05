Return-Path: <linux-kernel+bounces-52134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013F5849479
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C158B22C3B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE05DDBD;
	Mon,  5 Feb 2024 07:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mhs0nIZa"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963B710A0F;
	Mon,  5 Feb 2024 07:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707117893; cv=none; b=pvZR/6G1E7AotpIBpDVbUBLC4PYpKPMrIs3nGcIkCjN3Fyo0bP0L3CAq+Kv3xVjcqqDiW7qMkGJ63PwPqGeF0KeTG1TVf5t1peI6KCG8tHsc/usXM71kJ5g7ngQQQtHqqMjmvI0rda/T+X8+jLqeMJzm3vPtg3hfJRfFE8kDpL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707117893; c=relaxed/simple;
	bh=OcsGUXHuY6mO67By8CJwPJxF0/wdBI+5oHN+zO3LbSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhxpkeDVAH+gJ/A3lCm2trrTXdMG+ec93AcQrDDxaAS7PMJsphL6RNmyUiLKb2q5DSYWZ8dFnW0PeuPIRn+IrGPgBV58imC0VEClw9dxeo2dGLu4jX3vM89S5fJKawFiysqzDLkzWZqo1JOKaGWKlYgMC9+LYXmy4exSNutNfT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mhs0nIZa; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d7232dcb3eso29457785ad.2;
        Sun, 04 Feb 2024 23:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707117890; x=1707722690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YLDq/Sesk4rfMhUhmusiUvWvREipTt/285KdbFrFbs8=;
        b=Mhs0nIZaTi4GDFUGXCg3W9zbricQwswPIUaT3xVbx7zDkewqz756LJDHiykHDz5NVa
         nJVEk6TWny0q+u9lxDTVOblxEqxFrpsJ7PMJDCXvTxoS2+gmEos70U6FBdjC6jfneQKa
         G+oNGFAas4BKHRmNXVGsAHKxZJNy4IdKnJ7s2Ooh82Cs/G4J4ORHF646WNhqCEoCYtZL
         CdhLV7RE473CJ4yJs8WyX6kTFoSNlzgjIip1QT0W5xpDub5iyWgM+kr9tZQU6D1aRXup
         5o1+f4WQSK20xW/vxmJhb3M2EhJbFQjxSiauX8u6O+jPQDo4derA3UIcaXGS1vWOQPeq
         F9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707117890; x=1707722690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLDq/Sesk4rfMhUhmusiUvWvREipTt/285KdbFrFbs8=;
        b=DT4Hz9D4+0PcESgmNxu3azmGsGMnmSopt0qeJW1wiI3cwxDQXfB02DUeZHE6SFfUAM
         3zHDwHANncdT/VOP55VoEZcYuzB5AC9mMa8rAZdyQE/7z3a8nPwHE8PLtZhM6dDAhdt+
         AAVAYm2XAVpGkmF3I11pYH8K+vHFOhITK5yVQhk4OsvHs2KOrrLoR+8jAQdKQA/h+BsV
         s23FQUd7a/H8FH6oi8POURBAUn2iYx/WyAU1CeJ3E8cKmqX9tl8R4zvnFEsbjmUnyo2M
         NipEHvFf76cfO4GL08G+NCg5yMJz/l/9dghxEbAJEaHr8CysiiZcwW8XNAGcqxQBi2pn
         mJSQ==
X-Gm-Message-State: AOJu0Ywir694ROgcUjlZoBXf9LYEdCYgT3CbIYsrA37uBXDLtQs/IAev
	NqFzK0+MVeaWswPGr6Waol/qYtSJiPTDJ2BuMMRksN3P/1D9hdtW
X-Google-Smtp-Source: AGHT+IGfFrTBy1PptKLsXy3//pUUDUIfPuSHIpOKjprQaYu+Z0gKESkJjRPouClgZae4FwRI/MEwug==
X-Received: by 2002:a17:902:680b:b0:1d9:6fce:54fd with SMTP id h11-20020a170902680b00b001d96fce54fdmr6386898plk.42.1707117889804;
        Sun, 04 Feb 2024 23:24:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWO9fP5gbm+f1YOE5fd10Prim7O/vPV/GitppTFuBpWEgSe/otccRBOtlHWP/+KCxMPVd3B+gty71BFMg4iED3nlLdFHeV2VvqeKb8cOBJd1s4Ui6QwBSmBLDW8ZnUXGCGOQj6htrDx0egQOV0RSmyqE2A4QwWGEEvigMcEIQQVfejCZ7xzPEX3mskbeSXTefiEKwlK9uRXmjwVGBq2mq13KNAoZCJcfQ8a/gKqd4LXxX8kXxYcuhG4tkgpvQALW+nDtTlA6+8eX9gIq84SKcrvxFtL0+eGVclgmP+dAPRGJ2xmluPW9Mdfpj1kvRlg/7tiP3gwJJmIG/FI8XTLKdjAar7IvTZhY+rARxgRqwKJFkZfSTsEtJ0JpX2NkUflBe0Q1xgtHx05FgQpzkHzKWuB+fl9fYm0NmU2mvSi/MC+8xRVDkJsC0H9opiv5qFdKkBhNfizuKEg/ax1ZV/nzow=
Received: from t480 (144.34.186.27.16clouds.com. [144.34.186.27])
        by smtp.gmail.com with ESMTPSA id o2-20020a170902d4c200b001d8f3ba10b4sm3350556plg.236.2024.02.04.23.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 23:24:49 -0800 (PST)
Date: Mon, 5 Feb 2024 15:24:42 +0800
From: Shawn Guo <shawn.gsc@gmail.com>
To: Philippe Schenker <dev@pschenker.ch>
Cc: devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Francesco Dolcini <francesco@dolcini.it>,
	Philippe Schenker <philippe.schenker@impulsing.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	NXP Linux Team <linux-imx@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: imx8mp-verdin: Label ldo5 and link to
 usdhc2
Message-ID: <ZcCNOjbPrDKaKiYv@t480>
References: <20240109121627.223017-1-dev@pschenker.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109121627.223017-1-dev@pschenker.ch>

On Tue, Jan 09, 2024 at 01:16:27PM +0100, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@impulsing.ch>
> 
> This commit labels LDO5 as `reg_vdd_sdio` in `imx8mp-verdin.dtsi` to
> facilitate changing its voltage to 1.8V, necessary for an SDIO
> peripheral that requires 1.8V at default and high-speed modes.
> 
> Additionally, it links `reg_vdd_sdio` to `&usdhc2`, aligning with the
> hardware configuration specified in the datasheet.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>

Applied, thanks!

