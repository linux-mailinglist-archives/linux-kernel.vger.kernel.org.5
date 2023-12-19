Return-Path: <linux-kernel+bounces-5797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4020818F96
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D76801C251C9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE133D0AC;
	Tue, 19 Dec 2023 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nKQ+NpBh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7443440BF9;
	Tue, 19 Dec 2023 18:13:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB674C433C7;
	Tue, 19 Dec 2023 18:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703009625;
	bh=rl0oGJRj24LNgiZU8UrAeIcpL4ZoLYNFcJBbQXFfYsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nKQ+NpBhVhYf1S9GOtzOlJIgbXu1I0CRJH20nDeKl9+UdJsWedrb/cVqlF5Ld4onb
	 YRJJoUgJR4kpS2qVJ4J/4oKQeK/yqmdzEtbpIdtWoo1Kbj7KUmWwapz3wZ5O5isUOz
	 Ra49I0QD4ox7bS8G0zBg4I6buHPUKP3t46zHVYA4=
Date: Tue, 19 Dec 2023 19:13:43 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Walle <michael@walle.cc>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	u-boot@lists.denx.de,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V2 3/5] nvmem: u-boot-env: use more nvmem subsystem
 helpers
Message-ID: <2023121929-salami-pessimist-c943@gregkh>
References: <20231219174025.15228-1-zajec5@gmail.com>
 <20231219174025.15228-3-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231219174025.15228-3-zajec5@gmail.com>

On Tue, Dec 19, 2023 at 06:40:23PM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> 1. Use nvmem_dev_size() and nvmem_device_read() to make this driver less
>    mtd dependent
> 2. Use nvmem_add_one_cell() to simplify adding NVMEM cells

Shouldn't this be 2 different patches?

thanks,

greg k-h

