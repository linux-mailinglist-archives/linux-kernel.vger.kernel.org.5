Return-Path: <linux-kernel+bounces-14088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFD78217C1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A30F1F21C6E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EA82108;
	Tue,  2 Jan 2024 06:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="PGFmoVed"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C1920F8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 06:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue,  2 Jan 2024 07:46:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1704178015; bh=vg6BjqTzvncnfAzQH0ToV2hPVqpimnYQjISNlAadLsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PGFmoVedAJuF8eeSp4FIpKCg7n7bPEV/yulY/xszmc6h1pUBdVi4XK/ELTbSqjuSl
	 +dMmpdKDBy+OerSX5ZQzBG+MtWenJ/UFvPx6l637amc0sXRL3x9WKVsF4NSxDZiJRY
	 8WZUpcBaf68Vea+k1q0pJWy/uYKK4v+3BGf0epc4=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id D98F5805A6;
	Tue,  2 Jan 2024 07:46:55 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id D50271830A6; Tue,  2 Jan 2024 07:46:55 +0100 (CET)
Date: Tue, 2 Jan 2024 07:46:55 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Kevin Martin <kevinmbecause@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] firmware_loader: Enable compressed files in
 EXTRA_FIRMWARE
Message-ID: <ZZOxXw7ZrmumszkO@buildd.core.avm.de>
References: <cover.1703042081.git.kevinmbecause@gmail.com>
 <cd370037f8c21dc851a2a33a07250459c9c98708.1703042082.git.kevinmbecause@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cd370037f8c21dc851a2a33a07250459c9c98708.1703042082.git.kevinmbecause@gmail.com>
Organization: AVM GmbH
X-purgate-ID: 149429::1704178015-ABEE65FF-6294A09D/0/0
X-purgate-type: clean
X-purgate-size: 551
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

On Wed, Dec 20, 2023 at 05:29:33AM -0500, Kevin Martin wrote:
> The linux-firmware packages on Gentoo, Fedora, Arch, and others compress
> the firmware files. This works well with CONFIG_FW_LOADER_COMPRESS, but
> does not work with CONFIG_EXTRA_FIRMWARE. This patch allows the build
> system to decompress firmware files specified by CONFIG_EXTRA_FIRMWARE.
> Uncompressed files are used first, then the compressed files are used.
> 
> Signed-off-by: Kevin Martin <kevinmbecause@gmail.com>
> ---

Tested-by: Nicolas Schier <n.schier@avm.de>

