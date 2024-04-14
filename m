Return-Path: <linux-kernel+bounces-144110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BA58A41F6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 12:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4450C281885
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A9D2E859;
	Sun, 14 Apr 2024 10:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OtDbD5PH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B20D1E53F;
	Sun, 14 Apr 2024 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713092236; cv=none; b=C2dQK3CVxc4E5Q+8cRXmgeF7BJBpaPSMATfVhlYBXLwKjPufwmg4J2PuDgtD8g9up6aRorHZnasTa4JSKIgPeY2PD3HZDdPZoH3l2PyIYDW6nGKL8jzr9BxU3FRe1beiZuABWI4Jee4DQI0lE1orUAQrpoFtMGevn/0tNaXP2r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713092236; c=relaxed/simple;
	bh=jDdtSOwj0MEVaChxqGUqHKbNJxVOuCR43DhquA3Tcpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4GSs2vN9xOp089E+3Szl33SBMJP+ZWJqRvP48f1pHKjjxm1ya/m+20SobLJ1sDYqzF4jh2xk5nj5XMPJih5an8qBYh4u5YvAHsQtUeYON3EyqC/AzJ17uwrskn2wr6uid1fRB4ZfyxiqGO3QBK4I/QNEIoJlByE6KB24sta2es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OtDbD5PH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66201C072AA;
	Sun, 14 Apr 2024 10:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713092235;
	bh=jDdtSOwj0MEVaChxqGUqHKbNJxVOuCR43DhquA3Tcpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OtDbD5PHfEn1DXagyJX5JdaIIjeblstJ3kByjV7c9z7LBgGw2HZvOb1gkxxF5TIaS
	 8RCe8nV4tohbyz7LTxFXhzu5Rcbk1fTPoQezXX97iBS46Y+Jz7RTv4YZEneGnnniTt
	 Q3CR6GMiDsGB13SkqeguvQs0wh5f4DY7P8aZWIzo=
Date: Sun, 14 Apr 2024 12:57:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: sumadhura kalyan <opensourcecond@gmail.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace function alignment of camel case by snake case.
Message-ID: <2024041457-outshoot-voyage-3e5b@gregkh>
References: <20240414102443.98927-1-opensourcecond@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414102443.98927-1-opensourcecond@gmail.com>

On Sun, Apr 14, 2024 at 03:54:42PM +0530, sumadhura kalyan wrote:
> Issue found by checkpatch
> 
> Signed-off-by: sumadhura kalyan <opensourcecond@gmail.com>

Your subject line is wrong.

