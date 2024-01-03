Return-Path: <linux-kernel+bounces-15136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77842822794
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 04:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801F21C22DB4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 03:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1C710A32;
	Wed,  3 Jan 2024 03:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPERcpUv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C13817980;
	Wed,  3 Jan 2024 03:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E784BC433C7;
	Wed,  3 Jan 2024 03:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704252855;
	bh=crfu/A0uKyvBIlvYcV6K1Hvp0K01b3WuW61+LgN4slI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lPERcpUvn8en32iPt3b9KWvf31zof5f9g4wtcK7sUgDlK6dPubDQLPCuUj6TOM3pP
	 2xmEMkgrCljY9+1rfxIw3+gxCY+9Mr5oALBcxZvK4Kj3Zdq4fyygIuQO4N7UyTGVe2
	 UXkuqv+QRw2DO8H81UQkaA0zzyWCbEuNoRi0fj8TBOWdEkbASJ8gLleCAxjQsJmS8D
	 pbDhej0Rt4/q1mddh3GQeYf5mjMhFFaA43USdVLJR2YH3hQa3IcducoolZuvYr5kA9
	 2rD6oE5vbu0RFvJxrsFkGItCfUvNdxUIrYu9Yn8aT5KxzoeeRDlKiQTu5uhT7Vr6JG
	 NTOQMPVJcdC6Q==
Date: Wed, 3 Jan 2024 11:34:12 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: chrome-platform@lists.linux.dev, kernel-janitors@vger.kernel.org,
	Benson Leung <bleung@chromium.org>,
	=?iso-8859-1?Q?G=FCnter_R=F6ck?= <groeck@chromium.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/chrome: cros_ec_i2c: Less function calls in
 cros_ec_cmd_xfer_i2c() after error detection
Message-ID: <ZZTVtOumDlR4iZPa@google.com>
References: <5db36d2b-afe0-4027-b22e-ded163a409be@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5db36d2b-afe0-4027-b22e-ded163a409be@web.de>

On Thu, Dec 28, 2023 at 08:56:38AM +0100, Markus Elfring wrote:
> The kfree() function was called in up to two cases by
> the cros_ec_cmd_xfer_i2c() function during error handling
> even if the passed variable contained a null pointer.
> This issue was detected by using the Coccinelle software.
> 
> * Adjust jump targets.
> 
> * Delete two initialisations which became unnecessary
>   with this refactoring.

The patch saves few instructions but makes the code less readable a bit.  I
would prefer to leave the code as is or wait for other reviewers' input.

