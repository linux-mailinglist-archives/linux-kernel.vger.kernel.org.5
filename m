Return-Path: <linux-kernel+bounces-121334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D63488E628
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24641F30772
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D52C153816;
	Wed, 27 Mar 2024 13:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="JHt2LDub"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F7C15358E;
	Wed, 27 Mar 2024 13:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711544704; cv=none; b=KDG+TKCDUidK/N+o0uGOhzEk4ilQYBGXweKNQISj86aFhohjVvAPo5zuNCYKWEDoD+0LX+Y916sxNCVkFemfm6jgg+Xvl8eYrHOiA3GUwiFqaW8ZvE3y3nsWKt+QnSkgSWNuDGCwLuhzjBPFiEDoIQy9gKbLKaUaDxFFan3sqMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711544704; c=relaxed/simple;
	bh=f36zv7pQ58Kg3T+FK+BOWk9JDkf2u7A1+u1SLE+NxlM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HEa5dD6PtIzun/+nia6Q/jC6qbi7BqpQiUkj9hD/w6bxZG9SYXn683nSKfzuleyQBPKSAZgTwTn00+rhSsOGW0Z/VWvawRmB/ZYLJ+yIBesPF+fgMZDMGAq66jqj82qkC6WXLQ9SsiurkmvENCtGtJjobyfQVsysDw+/EYgmRwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=JHt2LDub; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rpSxa-003SRi-3C;
	Wed, 27 Mar 2024 14:04:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2eyoBfcpiDO1OaNqBSc35WO98gQLM60AXWoakZdtZOo=; b=JHt2LDubk31UTMyoW36VJUYobl
	a0ZPHRnh8t6POVzBZwcRXikOeu277pJPLqb7PigiYtt2vsg8j87eriKtUKRn9+wQ+XVebF2D4AdoT
	dYMXsq6IVhNJwtijl6OhzE6wiCNcGUXJTdUm0X7Bm9S8+YzRbrFDUhQAWQw/tieKLnTbYBAhGOvM8
	BacMrtzgFDyxxRY49xpX+9vTJrWzNLnsetwTJ9B1khHxap4erCPjv2Vkwm3JkxJ1jXIabEwVI/gJX
	PIgsJfycHr+YMe0BcxCKZdQnUFsB/Djqa5PDbyAiYNDy5pwXLAk31tN6j6yImexNUO1MmcSHnO/sY
	tlYgOduA==;
Received: from p2003010777026a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7702:6a00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rpSxY-0004Ok-3C;
	Wed, 27 Mar 2024 14:04:53 +0100
Date: Wed, 27 Mar 2024 14:04:51 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: lee@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mfd: rohm-bd71828: Add power off functionality
Message-ID: <20240327140451.65ff8e18@aktux>
In-Reply-To: <815e1cdc-145e-4880-96a0-d9c21308b9b3@gmail.com>
References: <20240326192258.298143-1-andreas@kemnade.info>
	<20240326192258.298143-3-andreas@kemnade.info>
	<815e1cdc-145e-4880-96a0-d9c21308b9b3@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Wed, 27 Mar 2024 09:32:29 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> It's worth noting that there is another PMIC, BD71879, which, from the 
> driver software point of view, should be (almost?) identical to the 
> BD71828. I believe the BD71828 drivers should work with it as well - if 
> not out of the box, at least with very minor modifications. 
> Unfortunately I don't know products where the BD71879 is used or if it 
> is sold via distributors - so I don't know if adding a DT 
> compatible/chip type define for it would be beneficial.

yes, you already told we thet the BD71828 drivers are compatible with
the BD71879 and I am using the latter. 
But that at least should be commented somewhere, so that
people do not raise questions, like: Do I have some strange board revision,
etc?
The most terse form to comment it is a separate dt compatible so we are
prepare any "almost identical" surprises.

Regards,
Andreas

