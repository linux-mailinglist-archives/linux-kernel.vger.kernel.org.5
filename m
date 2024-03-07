Return-Path: <linux-kernel+bounces-95204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF7E874AA5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26861C20E0D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5EC83A15;
	Thu,  7 Mar 2024 09:19:43 +0000 (UTC)
Received: from esa2.ltts.com (unknown [14.140.155.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2627E839F1;
	Thu,  7 Mar 2024 09:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.140.155.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803182; cv=none; b=Z/eVuV2HzaDIFy1AEUkss8rRb37zmw9K0gymqAUO/lhQ5qjUerfxpcpL+zLt38z5qUsK+xte+By7aWXgVnaj2sZ/YWqTiwekLNKurl3m7ELgnbG3AcerCv0azYxHvdG8U3i2Rgk2EE4ukpR2bvSMgM6oltbBZXYg2OmAIdcGbsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803182; c=relaxed/simple;
	bh=xN2Adfm3WB83QwdH8jzScFd507HJQvspLjxK8bkDmbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pv72OvMk/2wH1iYkdpgtm+jzjgIMTefQqqIyhl6Gvd6Pk5bd4DC7M9UXvdJAf5sxJcLFt3K9Q0yAm8M0CflhFIvHo6cKlu2w9NiHBoKG9roaVKUNZ12wamlD3M2tf4MjZIMzDKq0qpt0d2kqAatYpCYwJCkqN9rPe+exjOvbcOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=14.140.155.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: OU7dAoQTIbtTp/5fOe/i5uiemmuv4EPuUaryBO/kNFmW7b1BnDXFRL/7gJgrtRGQRzT01R4qEc
 64ohoawppL9w==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa2.ltts.com with ESMTP; 07 Mar 2024 14:49:36 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: linus.walleij@linaro.org
Cc: arnd@arndb.de,
	bhargav.r@ltts.com,
	broonie@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jpanis@baylibre.com,
	kristo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	lee@kernel.org,
	lgirdwood@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	m.nirmaladevi@ltts.com,
	nm@ti.com,
	robh+dt@kernel.org,
	vigneshr@ti.com
Subject: Re: [PATCH v2 13/14] pinctrl: pinctrl-tps6594: Add TPS65224 PMIC pinctrl and GPIO
Date: Thu,  7 Mar 2024 14:49:25 +0530
Message-Id: <20240307091925.171679-1-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CACRpkdZzTheR=+=in7RYTFM2dquEPmGDudB7n1zoiUU4B1UCVg@mail.gmail.com>
References: <CACRpkdZzTheR=+=in7RYTFM2dquEPmGDudB7n1zoiUU4B1UCVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On Thu, 29 Feb 2024 14:24:16 +0100, Linus Walleij wrote:
> On Fri, Feb 23, 2024 at 10:37 AM Bhargav Raviprakash <bhargav.r@ltts.com> wrote:
> 
> > From: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
> >
> > Add support for TPS65224 pinctrl and GPIOs to TPS6594 driver as they
> > have significant functional overlap.
> > TPS65224 PMIC has 6 GPIOS which can be configured as GPIO or other
> > dedicated device functions.
> >
> > Signed-off-by: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
> > Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Is this something I can just merge to the pin control tree, or does it
> need to be applied in lockstep with the other patches?
> 
> Yours,
> Linus Walleij

These patches need NOT be applied in lockstep with other patches.

Regards,
Bhargav

