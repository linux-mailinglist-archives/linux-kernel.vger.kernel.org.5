Return-Path: <linux-kernel+bounces-95029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E56874860
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D51E2867FE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 06:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEEC1CFAD;
	Thu,  7 Mar 2024 06:58:33 +0000 (UTC)
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B2D1CD2D;
	Thu,  7 Mar 2024 06:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709794713; cv=none; b=UJE7dTOvCS4cGJnct66WPFu5HEBQUecQ1gD/WFbFZ/zmvVSXZv6BloGmRhV5MMSb0PsX8JoK48CNbak9Z4Hepy/EmpncmJghW8YuEBhIiPluReaB1eOiPYpwYqS42Ia4YVwZ0J2y1X+D/Wdq2q1mmgaVs6NH64W056Sky+bv4MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709794713; c=relaxed/simple;
	bh=Wt7lhglpodByb4CJI8Cl6YkErPTUMOpVoSpfMcFq5RM=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=RPoTGlOS//Pn3gx69+TTYjXmH3i/y/gmvnKGs3sBxxFEKTLgK//4YbOtukziGMZRZdO9XUT0oaaeESb0SAKym+4civhLYAQxfTs63PTWKxk9eJofioXuQI59k2xLnby8pQ1tNIc/LybDJRkitPczk4rR+4wFYzKarAEsPERxGyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=5810c20468=ms@dev.tdt.de>)
	id 1ri7hj-000o8L-6v; Thu, 07 Mar 2024 07:58:11 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1ri7hh-00AuCb-V3; Thu, 07 Mar 2024 07:58:09 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 7D5BF240049;
	Thu,  7 Mar 2024 07:58:09 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id E6FB1240040;
	Thu,  7 Mar 2024 07:58:08 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 2DE01361C1;
	Thu,  7 Mar 2024 07:58:08 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 07 Mar 2024 07:58:08 +0100
From: Martin Schiller <ms@dev.tdt.de>
To: Justin Swartz <justin.swartz@risingedge.co.za>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, linux-x25@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: x25: remove dead links from Kconfig
Organization: TDT AG
In-Reply-To: <20240306112659.25375-1-justin.swartz@risingedge.co.za>
References: <20240305193024.6bcfa98f@kernel.org>
 <20240306112659.25375-1-justin.swartz@risingedge.co.za>
Message-ID: <345ce600c11ab1eb7618fd4c7fcd268d@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-ID: 151534::1709794690-1BF9DB6F-6A7F1771/0/0
X-purgate: clean
X-purgate-type: clean

On 2024-03-06 12:26, Justin Swartz wrote:
> Remove the "You can read more about X.25 at" links provided in
> Kconfig as they have not pointed at any relevant pages for quite
> a while.
> 
> An old copy of https://www.sangoma.com/tutorials/x25/ can be
> retrieved via https://archive.org/web/ but nothing useful seems
> to have been preserved for http://docwiki.cisco.com/wiki/X.25
> 
> For the sake of necromancy and those who really did want to
> read more about X.25, a previous incarnation of Kconfig included
> a link to:
> http://www.cisco.com/univercd/cc/td/doc/product/software/ios11/cbook/cx25.htm
> 
> Which can still be read at:
> https://web.archive.org/web/20071013101232/http://cisco.com/en/US/docs/ios/11_0/router/configuration/guide/cx25.html
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
> ---
>  net/x25/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/net/x25/Kconfig b/net/x25/Kconfig
> index 68729aa3a..dc72302cb 100644
> --- a/net/x25/Kconfig
> +++ b/net/x25/Kconfig
> @@ -17,8 +17,6 @@ config X25
>  	  if you want that) and the lower level data link layer protocol LAPB
>  	  (say Y to "LAPB Data Link Driver" below if you want that).
> 
> -	  You can read more about X.25 at 
> <https://www.sangoma.com/tutorials/x25/> and
> -	  <http://docwiki.cisco.com/wiki/X.25>.
>  	  Information about X.25 for Linux is contained in the files
>  	  <file:Documentation/networking/x25.rst> and
>  	  <file:Documentation/networking/x25-iface.rst>.

Acked-by: Martin Schiller <ms@dev.tdt.de>

