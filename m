Return-Path: <linux-kernel+bounces-9585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8356881C7EA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B61341C25061
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E441173C;
	Fri, 22 Dec 2023 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1ttZV5w"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218B811718
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 10:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BB5C433C8;
	Fri, 22 Dec 2023 10:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703239957;
	bh=219GP91d68zGoZ1cFfjVthGnJx/nc2d6y0Gb+Spz9BQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i1ttZV5wTLS0aipOuZ7Vimv3aTekOWo4PtDf8LspdJB5Fi7GHxsWyWuGQiLMzjNzm
	 ZuJbod0ykU39/qoXXw20zQ7Yv25NYxU1PqqGOY+dN2BS4tOSZpYIPGdUK85IDGJ6lJ
	 HgnSyNjiD55DjaMp+geTO/sBNKHsYQZJRdllk5LaukY+6ZOutpnTSlnitR4E+hvw7B
	 dQPsBNFAHPGigJSBwNZNw4yERYJe0QSYAqt9cwXii624qxeuCEWmgrKUGWHpRvEnnM
	 imDcaUjSlP9xnyp1RbZWJlHypkiIbSohEIgzgipdO+QE021OKGiI34c6tlkIJ3Y1HX
	 W+ULD/m0nkJfw==
Message-ID: <09cd6d99-6a06-4920-9ed0-78661060b759@kernel.org>
Date: Fri, 22 Dec 2023 12:12:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] phy: ti: gmii-sel: Enable SGMII mode for J784S4
Content-Language: en-US
To: Chintan Vankar <c-vankar@ti.com>, Maxime Ripard <mripard@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Sinthu Raja <sinthu.raja@ti.com>, Andrew Davis <afd@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
References: <20231221102956.754617-1-c-vankar@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231221102956.754617-1-c-vankar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21/12/2023 12:29, Chintan Vankar wrote:
> TI's J784S4 SoC supports SGMII mode with the CPSW9G instance of the CPSW
> Ethernet Switch. Thus, enable it by adding SGMII mode to the list of the
> corresponding extra_modes member.
> 
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

-- 
cheers,
-roger

