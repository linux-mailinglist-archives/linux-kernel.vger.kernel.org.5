Return-Path: <linux-kernel+bounces-139945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE568A0970
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE841B28C8C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FD413DDC7;
	Thu, 11 Apr 2024 07:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2yW8qZY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EA513CAB3;
	Thu, 11 Apr 2024 07:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819630; cv=none; b=UvAbggGjjkkO5IecAL9GsN0wJRjT9WKATng8cES+zR4h+3SDPEWh+jmgqn16m5A9/1do7wFKNmeRfLHy1Bg92a6kJn87A2/0b/efgX8G2eQUvqU0eZ24l3WBZIuT8hLEUuCwo1uB1h1pngHf2sYbzpFmcBtwmsgOAHh/3Mxk1YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819630; c=relaxed/simple;
	bh=T2onanXhUB90qbp92d4O/yikgUDkfoXcWX/VnkksrUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NyGoVVl8Ahn/g3IEIBwBxyKsjMKCkag/An8RvBg+CYIlLE/y1PRs/whAon6geUE8TbIxPMwPEaL57Ov854pn10WIKNyHWaJt+nBswyORF/5PCnSGuiXt3n3WD7+txpbdPeH0+ufsk1zLMZWGF2DqTHBCteNODRt/x1lKB0VRnEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2yW8qZY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6868C43394;
	Thu, 11 Apr 2024 07:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712819630;
	bh=T2onanXhUB90qbp92d4O/yikgUDkfoXcWX/VnkksrUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V2yW8qZYPrgZm48lFWXmmyAAjk2yjr5uXgZynyxgAjZ5UeSBzPdwmAWIvaPzuY+EJ
	 7Ds/gv9fjtHA/z1Y7SI8FFrIXyw3aP+chII4UQF0VDcYjwMrm0LeAwdpGEUnSbk0A3
	 MPu1uJqxNOSibXBYK+ochRdRk8InqS6377pLX7rgx1zYrSeje3TypkX+5tYUVBDtvH
	 ORARQNKLYmnykXV76oafHFt+MzRgznD6wazUGOEP6IMRJ8xo1+OSAqCbQS0eULBD/x
	 Tsqsk+QSq+d0/TaAvAqR9pdCcQEIiPzWXSaTvnBz2zvp+YBF25AMvnzc5px/DJqBD0
	 ILVJS10uJ2ZQg==
Date: Thu, 11 Apr 2024 08:13:45 +0100
From: Lee Jones <lee@kernel.org>
To: Gergo Koteles <soyer@irl.hu>
Cc: Ike Panhc <ike.pan@canonical.com>, Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Pavel Machek <pavel@ucw.cz>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: leds: add LED_FUNCTION_FNLOCK
Message-ID: <20240411071345.GF6194@google.com>
References: <cover.1712063200.git.soyer@irl.hu>
 <8ac95e85a53dc0b8cce1e27fc1cab6d19221543b.1712063200.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ac95e85a53dc0b8cce1e27fc1cab6d19221543b.1712063200.git.soyer@irl.hu>

On Tue, 02 Apr 2024, Gergo Koteles wrote:

> Newer laptops have FnLock LED.
> 
> Add a define for this very common function.
> 
> Signed-off-by: Gergo Koteles <soyer@irl.hu>
> ---
>  include/dt-bindings/leds/common.h | 1 +
>  1 file changed, 1 insertion(+)

Hans,

You can take this in via the x86 tree, but please capitalise the first
letter of the subject line when doing so.

 dt-bindings: leds: Add LED_FUNCTION_FNLOCK

Acked-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]

