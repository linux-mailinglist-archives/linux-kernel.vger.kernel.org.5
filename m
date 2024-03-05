Return-Path: <linux-kernel+bounces-92585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9E1872280
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D45F1C21A2F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE031272B6;
	Tue,  5 Mar 2024 15:15:18 +0000 (UTC)
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244734683;
	Tue,  5 Mar 2024 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709651718; cv=none; b=bQL+A3dB2vZibYGqW2DvJMDOMJqn847H4Zjx7cD4wzBtl6m/b0nvDgH5sbgFQcRBlRI29KSz7aR8j4JjhG0WcXJhAnDtzcXQ1Pjzt1nC+iYo9yiLSd/wynP3el2GLl68HmuSKy9DnCzWEFTt+yTDQfOaa2Ch9HiulvSV0kPkLDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709651718; c=relaxed/simple;
	bh=ErqQUkJuZVCDN+rlTHGkow9sEbDhSyeI9kVCG07KoLU=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=MeuccMTn5x2HuCqtswFfTy/p+v3OjXMu0toqLhhDNSylQ1MXCzcHhkCL62VJqaag7hv2mhwxDbASZwqX0IUHZ2YEXP1yD3495e0keJa3z6EDzOMDDZkcoIIzV9oP/2V+8pZ3quAVJc1r6QZMT8WPkCErmB/a4tCxiBBq8buoG9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=5808ba57af=ms@dev.tdt.de>)
	id 1rhWCG-00CvxE-IF; Tue, 05 Mar 2024 15:55:12 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1rhWCF-00Cvwq-Fi; Tue, 05 Mar 2024 15:55:11 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 140A3240049;
	Tue,  5 Mar 2024 15:55:11 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 752F9240040;
	Tue,  5 Mar 2024 15:55:10 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id B9DE1363BE;
	Tue,  5 Mar 2024 15:55:09 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 05 Mar 2024 15:55:09 +0100
From: Martin Schiller <ms@dev.tdt.de>
To: Justin Swartz <justin.swartz@risingedge.co.za>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, linux-x25@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: x25: remove dead links from Kconfig
Organization: TDT AG
In-Reply-To: <20240305133139.29236-1-justin.swartz@risingedge.co.za>
References: <20240305133139.29236-1-justin.swartz@risingedge.co.za>
Message-ID: <18c63e9cba846c65b83532e3d73b9f42@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate: clean
X-purgate-ID: 151534::1709650512-7D69FAEB-CF5D0AE6/0/0
X-purgate-type: clean

On 2024-03-05 14:31, Justin Swartz wrote:
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

