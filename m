Return-Path: <linux-kernel+bounces-18210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E148825A0E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C514CB21558
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAEC358A0;
	Fri,  5 Jan 2024 18:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIE+JqRF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5718D3588B;
	Fri,  5 Jan 2024 18:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C7AC433C7;
	Fri,  5 Jan 2024 18:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704479174;
	bh=42Aj2xzoqSAIt6/8r6LJJBpe/usERH1YJszj2babSjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vIE+JqRFoaDeQnDBIfawuUEXj/Am5PxDdsPj28PpA7O1kef1I3cmYEPslrRoVkXQI
	 TrWFwlYbm4zLC+ZSUF4mY4+NdJBZ9LCB5WAB9NB/8ex007q3JhRXN8ya1TClNok2/e
	 WPBFv9oaqSfss+Ufn0sHqlTgb5u3Fd5JLXpT0nNRb0Bcp65upQuoyAxmZb4UGYjhMA
	 3sA+2PO7sj7WCpd7Hia2FSKbIuo3ryG09D6/N5y0372A4O98S0CscoWqtOVMNcC1P6
	 Rnu6JhYnP6TG5E8UcMiestOauuWklZtkmdWYeJg8FNlg0QwZPt5QTCiKxgqak5wvV5
	 BKE3hJZJng7uw==
Date: Fri, 5 Jan 2024 18:26:10 +0000
From: Simon Horman <horms@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v4 2/4] net: phy: at803x: refactor qca808x cable
 test get status function
Message-ID: <20240105182610.GW31813@kernel.org>
References: <20240104213044.4653-1-ansuelsmth@gmail.com>
 <20240104213044.4653-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104213044.4653-3-ansuelsmth@gmail.com>

On Thu, Jan 04, 2024 at 10:30:39PM +0100, Christian Marangi wrote:
> Refactor qca808x cable test get status function to remove code
> duplication and clean things up.
> 
> The same logic is applied to each pair hence it can be generalized and
> moved to a common function.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


