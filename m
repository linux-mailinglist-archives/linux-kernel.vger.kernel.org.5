Return-Path: <linux-kernel+bounces-138122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0E689ECDB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F098B25807
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C4313D52E;
	Wed, 10 Apr 2024 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="PTEG8cXO"
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5304713D277;
	Wed, 10 Apr 2024 07:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735898; cv=none; b=LIRQEEbCscRNsPsFMKz6s5fkvoPrA2jt9A4A67vvgH4WrofGARe246aE+ObwIzZ8rLiT7sJRZXY6aa6+YEIq1zLb5WBC+4lutsjLNnwSM5P1eiLPzTLgSLVd8IMVXPl9jxvEfpEsitIFD6H7VBleDB5AEccJtYWmeb+MLQCP4fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735898; c=relaxed/simple;
	bh=ggAwJ9gKp8m5cmIfIhvJyCQX6iVQCf8TPFb9NPvj2wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzVT/26XZOb3w6cVvRHnNfarjH3JymO6shR92awSBAYjyBSXRqRhsX3wEyAyEbcSInKdxEhm1VQkyCb83cC3hSXR4TohCHI2f+h/bO/9Gto1GAaElHKcIFe6hMDm5GKa63kweyirxlBjVFb/Oq4y9QbtUWQ1b4ElghzJGsTQEu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=PTEG8cXO; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1712735569; bh=ggAwJ9gKp8m5cmIfIhvJyCQX6iVQCf8TPFb9NPvj2wE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PTEG8cXOcVrICTtF3JjPJgD01Crf7lT+mVj+85uh8xn5khfP3LDUufykW8v8wKSf0
	 VmKfwz1ROWdbGwbU+3d48MeYkXBG1204CNCgDZ/FmyFcwAVDuR3GnQ83QU+1M/Z/Zl
	 ez1FbDkXxwwKaT+hzQ1lYfyRuUnKhLPEJasrrM4E=
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Wed, 10 Apr 2024 09:52:49 +0200 (CEST)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 01426804EB;
	Wed, 10 Apr 2024 09:52:49 +0200 (CEST)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id E82B018AFD6; Wed, 10 Apr 2024 09:52:48 +0200 (CEST)
Date: Wed, 10 Apr 2024 09:52:48 +0200
From: Nicolas Schier <n.schier@avm.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, Tony Finch <dot@dotat.at>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] scripts/unifdef: avoid constexpr keyword
Message-ID: <ZhZFUEFJQ-THmulp@buildd.core.avm.de>
References: <20240408071758.2526806-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240408071758.2526806-1-arnd@kernel.org>
X-purgate-ID: 149429::1712735569-FDC5C025-C3543675/0/0
X-purgate-type: clean
X-purgate-size: 1031
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

On Mon, Apr 08, 2024 at 09:17:52AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Starting with c23, 'constexpr' is a keyword in C like in C++ and cannot
> be used as an identifier:
> 
> scripts/unifdef.c:206:25: error: 'constexpr' can only be used in variable declarations
>   206 | static bool             constexpr;              /* constant #if expression */
>       |                         ^
> scripts/unifdef.c:880:13: error: expected identifier or '('
>   880 |                 constexpr = false;
>       |                           ^
> 
> Rename this instance to allow changing to C23 at some point in the future.
> 
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nicolas Schier <nicolas@fjasle.eu>
> Cc: linux-kbuild@vger.kernel.org
> Reviewed-By: Tony Finch <dot@dotat.at>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  v2: include fixup from Tony

thanks, LGTM.

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

