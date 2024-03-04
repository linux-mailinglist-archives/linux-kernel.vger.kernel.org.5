Return-Path: <linux-kernel+bounces-90634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65327870284
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAE22B21A94
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942DE3D982;
	Mon,  4 Mar 2024 13:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="j0vsoZ5h"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02A43D547;
	Mon,  4 Mar 2024 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709558378; cv=none; b=JK5oIyEtNvlApyWLfuvx7Q3qi3Qc8goyx4JtnXuYYhbHbObdsS5FnNMnbSPBqb7cq3OtcnnI/Ks3BG8dXLzCFVqdy1DocphtMLM1POD+0auxcDMupNf/nN3fFqE6vhPY7L/N9EBmKXUWTGGQt5VdQ5RR6ehNsMy/9Yqm6d7kawY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709558378; c=relaxed/simple;
	bh=afzJtdtms/jbY1raMtb1alh1Cys2o04f4eQPLD2PdkU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AohnQpVCXXxyaSd+SxnEAyavEGrESAIKQxFbeX0Vz7RWHODMOdocy3JeK5lo98CO7cWZuL/Tw7R0pYHkbhy7wx/SJqTwdWHYyufcGUsAh2sH5VCwXkPeP09Hfz73iFDLtycTX4zGoiYTD16xntd4AzmloniEZeHA5CRa18Nkt5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=j0vsoZ5h; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C8D07E0009;
	Mon,  4 Mar 2024 13:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709558374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sss8ohSvvwGn3uSwOCh1KZp9GMEloGBYCwOa6wonWFE=;
	b=j0vsoZ5hRpTOvw/xyk1SdAUlqkRAqFVd/BazCSa+SSz7n7eR+kj+vdKiscpSSnHeyrnaq+
	U8wltMM4u2gb8coGq/zn/KrmIbVnENiLSwHcHy57LIYD0cXbScPGALY/kwAuluzYpmu5Vr
	rm33cstmzNS4NWJxpe+IC1EE7U7amKH1DOyUjSPInCGfptYIxCQJBWJLcVVl5ZYABkh8u+
	5ks9A01fsDpnbrlqlK+HeJ4xkFwadmLa2epVbTZhVcgm6r51QjdAwxXngFmx1hNb8v9EwQ
	Wj5t8c0xGhfqKNrNvQg5Ce0qRmvIchJ6VNxej6Peem/KqTRofqqL9Zcxzc7F/w==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, =?utf-8?Q?Th=C3=A9o?= Lebrun
 <theo.lebrun@bootlin.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Lukas
 Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: remove entry to non-existing file in
 MOBILEYE MIPS SOCS
In-Reply-To: <20240222143312.27757-1-lukas.bulwahn@gmail.com>
References: <20240222143312.27757-1-lukas.bulwahn@gmail.com>
Date: Mon, 04 Mar 2024 14:19:33 +0100
Message-ID: <87sf16gmmy.fsf@BL-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com

Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:

> Commit f34158edd249 ("MAINTAINERS: Add entry for Mobileye MIPS SoCs") adds
> the section MOBILEYE MIPS SOCS with a file entry to the non-existing file
> include/dt-bindings/soc/mobileye,eyeq5.h.
>
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
>
> Possibly, this file was part of an early patch series, but in the final
> patch series, this file does not appear anymore.
>
> Delete this file entry in the MOBILEYE MIPS SOCS section.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 28b2013031bd..19ac6a8e46b2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14914,7 +14914,6 @@ F:	Documentation/devicetree/bindings/mips/mobileye.yaml
>  F:	arch/mips/boot/dts/mobileye/
>  F:	arch/mips/configs/eyeq5_defconfig
>  F:	arch/mips/mobileye/board-epm5.its.S
> -F:	include/dt-bindings/soc/mobileye,eyeq5.h
>  
>  MODULE SUPPORT
>  M:	Luis Chamberlain <mcgrof@kernel.org>
> -- 
> 2.17.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

