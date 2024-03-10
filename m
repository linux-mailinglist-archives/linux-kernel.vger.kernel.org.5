Return-Path: <linux-kernel+bounces-98156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D628775CB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 09:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CDD61C20DD5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 08:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FC81D6AA;
	Sun, 10 Mar 2024 08:17:40 +0000 (UTC)
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C4718646
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 08:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.243.71.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710058660; cv=none; b=n3HfaBAl+7MceSrJrr+ujjg1FyahjPg0sWCVpWz+Q3ucxBy9tARlEF0IUpji4konnyfID8n4l8Nf8SFE2bNFRMoevU6bbt/h1cAc+3whKJNoanoSaESoifgi8+omtTOSnC6ohoNVl6w/NvjzC+13zQPCCF/SJamTiLkoavoo6Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710058660; c=relaxed/simple;
	bh=AqdbfwnuVEB/sDhG2yXcjRauBfVGmkLG7gVxljkokdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gw2PCzwo9EX7ceXQ8jeWGNoqUASt2EriY/b+KPLdRXCIm58Skd+uOaarMOJRTZ73cQvPWl3ML8uxH0SzM0FWz2XXITZP2ytfZkkwu5OvAMW3RwJR7jIvVzCIoneMmE8PzFGatDLBKg10b31aEIC7JqFnTUgkolmJ3BuYOdbQThg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net; spf=pass smtp.mailfrom=dominikbrodowski.net; arc=none smtp.client-ip=136.243.71.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dominikbrodowski.net
Received: from shine.dominikbrodowski.net (shine.brodo.linta [10.2.0.112])
	by isilmar-4.linta.de (Postfix) with ESMTPSA id B2C7F2002BE;
	Sun, 10 Mar 2024 08:17:32 +0000 (UTC)
Received: by shine.dominikbrodowski.net (Postfix, from userid 1000)
	id 267D9A006E; Sun, 10 Mar 2024 09:11:23 +0100 (CET)
Date: Sun, 10 Mar 2024 09:11:23 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] pcmcia: cs: make pcmcia_socket_class constant
Message-ID: <Ze1rK27nlT_nCAM6@shine.dominikbrodowski.net>
References: <20240305-class_cleanup-brodo-v1-1-9bac7b015641@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-class_cleanup-brodo-v1-1-9bac7b015641@marliere.net>

Am Tue, Mar 05, 2024 at 04:38:25PM -0300 schrieb Ricardo B. Marliere:
> Since commit 43a7206b0963 ("driver core: class: make class_register() take
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the pcmcia_socket_class structure to be declared at build
> time placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Applied to pcmcia-next. Thanks!

	Dominik

