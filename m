Return-Path: <linux-kernel+bounces-15400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B64822B82
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147C31F24926
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FA318C2E;
	Wed,  3 Jan 2024 10:40:46 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3AC18C1D;
	Wed,  3 Jan 2024 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id C288828136;
	Wed,  3 Jan 2024 11:34:25 +0100 (CET)
Date: Wed, 3 Jan 2024 11:34:21 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: pratikmanvar09@gmail.com
Cc: thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-imx@nxp.com, linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Clark Wang <xiaoning.wang@nxp.com>, Jun Li <jun.li@nxp.com>,
	Pratik Manvar <pratik.manvar@ifm.com>
Subject: Re: [PATCH] pwm: imx27: workaround of the pwm output bug
Message-ID: <20240103103421.GA3758@francesco-nb>
References: <20231229063013.1786-1-pratikmanvar09@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231229063013.1786-1-pratikmanvar09@gmail.com>

On Fri, Dec 29, 2023 at 12:00:07PM +0530, pratikmanvar09@gmail.com wrote:
> From: Clark Wang <xiaoning.wang@nxp.com>
> 
> This fixes the pwm output bug when decrease the duty cycle.
> This is a limited workaround for the PWM IP issue TKT0577206.
> 
> Root cause:
> When the SAR FIFO is empty, the new write value will be directly applied
> to SAR even the current period is not over.
> If the new SAR value is less than the old one, and the counter is
> greater than the new SAR value, the current period will not filp the
> level. This will result in a pulse with a duty cycle of 100%.
> 
> Workaround:
> Add an old value SAR write before updating the new duty cycle to SAR.
> This will keep the new value is always in a not empty fifo, and can be
> wait to update after a period finished.
> 
> Limitation:
> This workaround can only solve this issue when the PWM period is longer
> than 2us(or <500KHz).
> 
> Reviewed-by: Jun Li <jun.li@nxp.com>
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Link: https://github.com/nxp-imx/linux-imx/commit/16181cc4eee61d87cbaba0e5a479990507816317
> Tested-by: Pratik Manvar <pratik.manvar@ifm.com>

You need to add your signed-off-by at the end when sending a patch, no
matter if you are the author or not.

Francesco


