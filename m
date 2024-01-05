Return-Path: <linux-kernel+bounces-17715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12357825181
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FDD7B226F0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3FB24B51;
	Fri,  5 Jan 2024 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwzST4hG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B4B24210;
	Fri,  5 Jan 2024 10:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C022C433C8;
	Fri,  5 Jan 2024 10:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704449425;
	bh=KRltSTi0bD8VHHjBqa6/utOjY8l/zzl7utSN3i622lI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TwzST4hGkmVSzCe8hHuXZBQyIEQV6QYTh4/hwdFLQuUykPzRlq7jCMbjViO+Zq8Ph
	 EvnHkzQ4BAwuL7zOEnF1fiViVjhKpKpXbtyuNw0y3lywBt0gNjTIRiVkL2znWvsZHW
	 9eLA+eSaD80AQPk+d3cKGNfyFD1rBfAJzon4KotcAUlnzQfowRfwxaWxMLAJbMOtyD
	 UK6y9rBqGnI40gex4jRuCElFv0PwKkfFnRHosrmk2ByCD6dokK+qLKZAm96K8a1pmg
	 ipqATxnycGUJO6W7i6p9u3maCqAq+JuGc+zIoC8oUkr+rOnCYpHOKgRdnewPdI9OTH
	 uKLeOMfgEvM8w==
Message-ID: <a3bacc32-b4e2-4141-8106-486bbf783f52@kernel.org>
Date: Fri, 5 Jan 2024 12:10:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: tipd: Separate reset for TPS6598x
To: Jai Luthra <j-luthra@ti.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 r-gunasekaran@ti.com, vigneshr@ti.com, d-gole@ti.com
References: <20240105-next-tps-fix-v1-1-158cabaec168@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240105-next-tps-fix-v1-1-158cabaec168@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05/01/2024 11:06, Jai Luthra wrote:
> Some platforms like SK-AM62, SK-AM62A cannot boot up to prompt if
> TPS6598x is cold-reset during unconditionally on probe failures by
> sending "GAID" sequence.
> 
> The probe can fail initially because USB0 remote-endpoint may not be
> probed yet, which defines the usb-role-switch property.
> 
> Fixes: d49f90822015 ("usb: typec: tipd: add init and reset functions to tipd_data")
> Closes: https://lore.kernel.org/linux-usb/vmngazj6si7xxss7txenezkcukqje2glhvvs7ipdcx3vjiqvlk@ohmmhhhlryws/
> Signed-off-by: Jai Luthra <j-luthra@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

