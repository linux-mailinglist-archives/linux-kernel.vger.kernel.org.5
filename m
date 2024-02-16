Return-Path: <linux-kernel+bounces-68184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 388DC8576F2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99D0A2828CB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67B6175BC;
	Fri, 16 Feb 2024 07:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Npyaki0t"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B58D10962;
	Fri, 16 Feb 2024 07:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708069546; cv=none; b=Y7enPDo6IsK7HlhaSIZ2innNepcv9BK+7NGWUAcY36SH+heTCkC1+xx+eUWDamUVYTKjeE/+iNGaOEBNYGaJsdCLg2B9N0yHZNJXzTnoUIj7Z5fFfJ8sbVrN18FP9K7Z9PAVUyAUYOiKqDV/uk2zzjsyjNOEMp7EFYl2oXtkIxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708069546; c=relaxed/simple;
	bh=H5Cn/kat7fnjZH35kMK0oH3YmXnUuv6zK85IWPk9t9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZECBUTmpqwI1Xu6KaaID4wbExKJMlhTHNdY7no1Fvfe8qJMjeZBSao/IILHCyJpn9M1UDJTe31i34B1LI8khvn0F9L9d/BacXKZeJacBrnc6TNh6A528vhLsvGDzUtxhFYfUHESY30UlmuQZHqtAvDEsvSUn9bZqlZ448c/PzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Npyaki0t; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id AFA77211F4;
	Fri, 16 Feb 2024 08:45:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1708069533;
	bh=Y4+Xtt/2QR/jaiCB77YYEz6l8UyC17iHPmEtlyWjDIE=; h=From:To:Subject;
	b=Npyaki0tZpmnvQRONBP6sCJMD1vO+WcjHYJ2sv/Op1uU3jHx2gn97VetZ+LpW1nZH
	 AN/grT1xX6iFVFpff8uUMWF0sBdCqFkbUIlSRU/QV2nU0tDbuFb+OOPogmStZRIh9p
	 +0P/b7msCR7Le02Tcl6uStHn++6wEyuWr/9TMRsvh/ESAxo2QSKh0RdSMYCQrYxwm4
	 xPGtuEfiqG58XZPvt4m5bHdazAyFBOg2JLLWwGYaNCnLb7lBUzndn6rwE3SUOaW49e
	 JBLTb0EP50jJvgTq1v5LqKDh/66lZiHnfLb3h2j95pJHXmbJWlW42kT75zz9bJWEMx
	 0+uWpqU8y9U1Q==
Date: Fri, 16 Feb 2024 08:45:27 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: m_can: remove redundant check for pm_clock_support
Message-ID: <20240216074527.GA5457@francesco-nb>
References: <20240104235723.46931-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104235723.46931-1-francesco@dolcini.it>

Hello Marc and Vincent,

On Fri, Jan 05, 2024 at 12:57:23AM +0100, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> m_can_clk_start() already skip starting the clock when
> clock support is disabled, remove the redundant check in
> m_can_class_register().
> 
> This also solves the imbalance with m_can_clk_stop() that is called
> afterward in the same function before the return.
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Did you missed this? Or do you have some concern with it?

Francesco



