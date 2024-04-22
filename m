Return-Path: <linux-kernel+bounces-152695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A348AC2FE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C435B20C53
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 03:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A0CEADA;
	Mon, 22 Apr 2024 03:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="a+HYj5sp"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B3EDDAB;
	Mon, 22 Apr 2024 03:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713756568; cv=none; b=cKuzXz7bmQ7IKm+0NaN7LqhU2VM4oupvVev/ldXuECZFrU4T7gn68TfUtOKuXYpqasbmzYJ+RAJpz28KNNuLUoO5P0kqDRyPCuzT7jHRGqoBPKlR3iwMVdTTXoROXqnUfLDA+VDukmd5uTHKuSl/ZUKQ6vyhw/vlVaM95698o4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713756568; c=relaxed/simple;
	bh=r8Qpr4ucM7+Hwg9wj59p5hxKfCnDkIHvT3XZ3KCX2iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCV84gIxN7EnW5sXIWwX842Bo+/WP3FIWtgSxMONkPAaUaQHgI/VD3tMZzUqGshVCRH/3Pa0XbWO5Cz2J7ThL+lD75a3tCPGATYtllCfuvlbYCJN/PAjHrjz8XJ6qVvBDuJqang/ZoXbYtJxGLvaHPSJ28f/+4My5sVnkKk/OP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=a+HYj5sp; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=Mg4GQsUB46WfDA6t6amPXP/MvXAaedMjLDYmCMx+L18=;
	b=a+HYj5spNqtVeC7pMXyJgHFhcX5xpi183EfoCkgTUcCa8JDTnw6hP8CMprcz5N
	RpzA809xqd9UdbpJpyPtkQtgNHtFZbgZVZ1SrfXnnGv6COkJIgIWP5TnSsfcpWT4
	5dHVtuxPE8e0q4WTd72thqRBkRTAUAXgfZKMhhRq9kmsU=
Received: from dragon (unknown [223.68.79.243])
	by smtp1 (Coremail) with SMTP id ClUQrADXn0QR1yVmBSErAw--.21732S3;
	Mon, 22 Apr 2024 11:18:43 +0800 (CST)
Date: Mon, 22 Apr 2024 11:18:41 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Michael Walle <mwalle@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: ls1028a: sl28: split variant 3/ads2 carrier
Message-ID: <ZiXXETdD7Q+9ldQr@dragon>
References: <20240403083812.3898480-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403083812.3898480-1-mwalle@kernel.org>
X-CM-TRANSID:ClUQrADXn0QR1yVmBSErAw--.21732S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrXw1UCw1xGr4kAF17KF48JFb_yoWxXrc_WF
	n8ur1kCws3JF4vqw1akFn3ZFyUGa47X3srCw1fJF97ArykJayqgF95K34vyrZ7AFs2yasx
	Zw13JrnrWrW5WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUb8hL5UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDhTIZVszYg7p3AAAsG

On Wed, Apr 03, 2024 at 10:38:12AM +0200, Michael Walle wrote:
> The devicetree files can be (re-)used in u-boot now, they are imported
> on a regular basis (see OF_UPSTREAM option) there. Up until now, it
> didn't matter for linux and there was just a combined devicetree
> "-var3-ads2" (with ads2 being the carrier board). But if the devicetree
> files are now reused in u-boot, we need to have an individual "-var3"
> variant, because the bootloader is just using the bare "varN" devicetree
> files. Split the "var3" off of the "-var3-ads2" devicetree.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Applied, thanks!


