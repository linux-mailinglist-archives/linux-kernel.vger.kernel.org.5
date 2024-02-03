Return-Path: <linux-kernel+bounces-51272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEB6848893
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 20:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E00B7284D64
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05ACC5F56E;
	Sat,  3 Feb 2024 19:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y5wYOtFC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212865D908;
	Sat,  3 Feb 2024 19:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706988988; cv=none; b=HpIwgs2AbVsGb4O5qAVTN5ppf8IaAEWEuUHGFWtZCvyczqS9yyDJ2UsFUTBcWKnIO9MVGkGsvixXiNq5Rxzk2sgCxXtQH1dmtoUADwx0mLtFiRDul5lr4r26MhX3gm+K0r6+dLdxK7jibM1N4pesb3JlMYJmxqYO3UVS4afMR7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706988988; c=relaxed/simple;
	bh=Yw4DbedyqWVxCHUvx+FFSR/BiUzj1+FwEAIyQ8nexTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dh1UUrcZjkakrUpIEi8L2FWXYo27wHUpe9MxugzDmjxnZtkpnwyLiSWqnF56yfYY/AFCE5TwBv1HVkvTuyJvLVoDqu32cTgv+TSbfxPHc68NdB1FhNCMj92nCFLa080wg6XI4IjCIMrhfaWP7zrJwDIboF5dG887ZRHEkrZdW9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y5wYOtFC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640E1C433C7;
	Sat,  3 Feb 2024 19:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706988987;
	bh=Yw4DbedyqWVxCHUvx+FFSR/BiUzj1+FwEAIyQ8nexTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=y5wYOtFCBi/VQo8AIacMyDZF++dGr28Pm4sYX5RXCR3tCU8Fc+MkI4u/08/9i/MIT
	 LPTjgbYJphjnnW/2s/wn9aniFK5rxaNjBJ5HzTK0NV2UdTcfu9okLS2hot+f+H0y5d
	 F97S66o+Q1+pC2rHpUZRVA7UtPDKFe2/WJwsNc3Y=
Date: Sat, 3 Feb 2024 11:36:26 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ronald Warsow <rwarsow@gmx.de>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.7 000/355] 6.7.4-rc2 review
Message-ID: <2024020319-hate-unpleased-d7f2@gregkh>
References: <6719bb63-7857-4da4-8f18-a97602c1e27a@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6719bb63-7857-4da4-8f18-a97602c1e27a@gmx.de>

On Sat, Feb 03, 2024 at 08:30:06PM +0100, Ronald Warsow wrote:
> Hi Greg
> 
> *no* regressions here on x86_64 (Intel Rocket Lake: i5-11400)

Nice, thanks for testing!

