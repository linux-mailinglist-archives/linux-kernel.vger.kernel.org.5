Return-Path: <linux-kernel+bounces-131481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CF7898878
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4FDE1C21D44
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADFF126F3A;
	Thu,  4 Apr 2024 13:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="acikMhq+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760728665A;
	Thu,  4 Apr 2024 13:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712235837; cv=none; b=MpYxjcttHpeY0ZfIYZyF9sHNFAIEQJWDt2boIhMPThu/6zXW4SbF4u2Y5wQvLn/nLdRxPR/XxEBJsPjWi8VgJCYPE6zMszl5ovHdghzFgFrIYI1Ik24GDPEF+0T5Y6utCiE92O0PikaGljFnBXhhQbI3YEbL4Ug9amwRA53bVao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712235837; c=relaxed/simple;
	bh=6vE+UcIUJNByBl+Hc1aeBMyGSNWr++Pony7d67w/f1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSeGlretz0b0zWoHzzULiT4j7dtx33wHLO5RHtaiboo+/iv7NLaaxsfASog2FKCoZDEZ9II30tNndMrCOjkl+XKhDJINOPR0P3NT4hAHwXEI8CztGPGZBNCpb95I+3dCy1MT0098+HZ40HItEOrt9IdqrKmyJkFzNKBGhoLj5cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=acikMhq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C32C43399;
	Thu,  4 Apr 2024 13:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712235837;
	bh=6vE+UcIUJNByBl+Hc1aeBMyGSNWr++Pony7d67w/f1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=acikMhq+/EhUeZoAT1FUlGbw5zzuDSSPkHEEOcr4j1q4N7pR8kiIWPfxUHOqPw26G
	 gswRqMI/qq515Oi1AhvXa6NYmiPvn57IWSpF58D8euIVFsTgakXSIZZI7vh5EQtH0w
	 Uv8MLn7ohNis6jQp2SyuJsKH4jyj1RsLFWdWJMJM=
Date: Thu, 4 Apr 2024 15:03:53 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: AKASH KUMAR <quic_akakum@quicinc.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Jing Leng <jleng@ambarella.com>, Felipe Balbi <balbi@kernel.org>,
	Pratham Pratap <quic_ppratap@quicinc.com>,
	Jack Pham <quic_jackp@quicinc.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PATCH v3] usb: gadget: f_uac2: uevent changes for uac2
Message-ID: <2024040415-parcel-statutory-ba79@gregkh>
References: <20230829092132.1940-1-quic_akakum@quicinc.com>
 <2023091702-unbutton-handoff-558d@gregkh>
 <3d34daf2-1e8a-4087-a8df-ab5208ca83ca@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d34daf2-1e8a-4087-a8df-ab5208ca83ca@quicinc.com>

On Thu, Apr 04, 2024 at 06:03:03PM +0530, AKASH KUMAR wrote:

<something in html removed>

Please fix your email client, this was rejected by the mailing lists.

And get review from your internal team first, and get their
signed-off-by on the commit, before sending a new version.

thanks,

greg k-h

