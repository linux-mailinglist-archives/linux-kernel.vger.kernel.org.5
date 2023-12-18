Return-Path: <linux-kernel+bounces-3299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D868B816A9E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161C31C20D9C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDEA13AE0;
	Mon, 18 Dec 2023 10:11:47 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay05.pair.com (relay05.pair.com [216.92.24.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DB813AC9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=pobox.com
Received: from iguana.lan (99-122-168-208.lightspeed.irvnca.sbcglobal.net [99.122.168.208])
	by relay05.pair.com (Postfix) with ESMTP id 9F4FE1A23FC;
	Mon, 18 Dec 2023 05:11:44 -0500 (EST)
Date: Mon, 18 Dec 2023 02:11:42 -0800
From: Adam Goldman <adamg@pobox.com>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 8/8] firewire: core: change modalias of unit device
 with backward incompatibility
Message-ID: <ZYAa0vJYppKgr9x7@iguana.lan>
References: <20231217103012.41273-1-o-takashi@sakamocchi.jp>
 <20231217103012.41273-10-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231217103012.41273-10-o-takashi@sakamocchi.jp>

Hi,

On Sun, Dec 17, 2023 at 07:30:12PM +0900, Takashi Sakamoto wrote:
> +	vendor_directory = search_directory(root_directory, CSR_DIRECTORY | CSR_VENDOR);

Setting the CSR_DIRECTORY bit here is extraneous since search_directory() also sets it.

-- Adam

