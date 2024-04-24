Return-Path: <linux-kernel+bounces-156839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2968B08F7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0061C227D2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C687B15ADA6;
	Wed, 24 Apr 2024 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="J7z7AbwD"
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B177115A4A1;
	Wed, 24 Apr 2024 12:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713960623; cv=none; b=MiZoRCKq/YNmJR0n1VpOTjCfTur3i3CcvjA5jSO2F2ya6Yx980AYg+GZiK7BUM59QUgI/DGRf5GDbuxlh7FlkeWqqmgbKi1wfMXObm5p+TPQbJtMSsM00O3SXPGX66o7PeeJ+EtiSGD2hHe9nKBOGaJgr7+xjP/180ORqZsrO4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713960623; c=relaxed/simple;
	bh=i3a5yBBghfmP2akK0Z8oaT4ZnYqJfTouuCQgBZkpRis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ruhwfL3Y1tJXAJqlurl+QXYo2YoooN2fFthz+dq1u3Iu5hbZ+8gJ6QtU+IUA+Ttb7XRexlDuhFNplk+GPrpKGgHvsXPOOXmKO9CjIP8TP5VOpyffRYEhHwqen3fU4q+tfFDeOU69c/dfc7mHgzcfz48+Io2dEh6pmZEIoH2NFZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=J7z7AbwD; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1713960283; bh=i3a5yBBghfmP2akK0Z8oaT4ZnYqJfTouuCQgBZkpRis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J7z7AbwDQ4+eKp1rJ1buxApxbfQOQvnowL1pyd0F37tAGh8728EWvdc5xZVl1Uw8n
	 IyMmMpmMX691EbaZDl/vmkC2FOGhbBBTPSFnrmk4Mo6KuKaeGiv0nIvq+dPO0BBNo/
	 SUYoSm6mkpJrelsgcLeum2G3OeNhiyKyzsl852Ac=
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Wed, 24 Apr 2024 14:04:43 +0200 (CEST)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 5E5DD806E2;
	Wed, 24 Apr 2024 14:04:43 +0200 (CEST)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id 51F2C181DB2; Wed, 24 Apr 2024 14:04:43 +0200 (CEST)
Date: Wed, 24 Apr 2024 14:04:43 +0200
From: Nicolas Schier <n.schier@avm.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kconfig: remove SYMBOL_CHOICE flag
Message-ID: <Zij1WyeLSYtkvrOV@buildd.core.avm.de>
References: <20240422161054.2867285-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240422161054.2867285-1-masahiroy@kernel.org>
X-purgate-ID: 149429::1713960283-765C22A6-7CED0527/0/0
X-purgate-type: clean
X-purgate-size: 515
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

On Tue, Apr 23, 2024 at 01:10:54AM +0900, Masahiro Yamada wrote:
> All symbols except choices have a name.
> 
> Previously, choices were allowed to have a name, but commit c83f020973bc
> ("kconfig: remove named choice support") eliminated that possibility.
> 
> Now, it is easy to distinguish choices from normal symbols; if the name
> is NULL, it is a choice.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Thanks, looks good to me.

Reviewed-by: Nicolas Schier <n.schier@avm.de>

