Return-Path: <linux-kernel+bounces-146819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0117B8A6B6F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B255728477C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82A412BEB7;
	Tue, 16 Apr 2024 12:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3YAYb6T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A56012BE8C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713271743; cv=none; b=SwyVbKnRtiE0g2wgft0t8+kZcUL9+/Rd2mqHX+tOZy7Bff0K17ZhUGNQoC2VpqFd/nzxo8P8Kg0btvXX5pSSgu4HuMVLQwawJx778cCwMvFK0yf8Nn8+XYkwJzudq/9YNC4QYYgn6x/kvbeZtwe6oWsrCLS1uYWroE355lDQrtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713271743; c=relaxed/simple;
	bh=ExN5VZDbu1uMRKfTi1+MWR/LiYL0qNAbMNNa6R9usIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTO6Rv/oUe+H5f42w6fu960Y9/TjNjqwelvU3/pMZDoCzIuURTgcrh/RaJx6znOlLTeiCcGpdRmg3eHnxgXLpYcsfIChxo7XzSQ0IZoi6oqjsKdF85uhirmnjfQyegwgXaWc+fBbLNJA862ng59btvNmAqewHMf8sOfXJ6IFNrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3YAYb6T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9767C113CE;
	Tue, 16 Apr 2024 12:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713271742;
	bh=ExN5VZDbu1uMRKfTi1+MWR/LiYL0qNAbMNNa6R9usIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f3YAYb6Ti24Dt8/ASYiF70VzOb4XvgpbiVIHoOs+OskHIWLhIPs5+s2mXENIi9lyh
	 sLpyhZuFEw707WSdUamdQcw6g704Cnk1QFSzPnnL0TEKB7LQRRwNFuk/jk5gxSZjst
	 7CzSUIKz50pbJHke16Pbp3vf2oPcUtC8ScZ8pQQYXzJp7xyqqEvl0Yd+42oLjSMcZi
	 oceWDZHXETaOv2v4Arx323GcyHIbqUcsPLnajhPYHg2M2VRBNUyd0vliY4co8nQDbb
	 VjD5uGE/EVzatkmGOeEv4XbTwUS7Auce/cIrBL95Ave6aysVOKJCnvNNqPk9umZs/6
	 59L+ymAY/J2OQ==
Date: Tue, 16 Apr 2024 13:48:58 +0100
From: Lee Jones <lee@kernel.org>
To: Min Li <min.li.xe@renesas.com>
Cc: Min Li <lnimi@hotmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH mfd v1 1/2] mfd: rsmu: support I2C SMBus access
Message-ID: <20240416124858.GX2399047@google.com>
References: <LV3P220MB12022B2F96505825BDDE6A2AA0052@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
 <20240412074344.GQ2399047@google.com>
 <OS3PR01MB659315BFEC1145363E4482B4BA042@OS3PR01MB6593.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OS3PR01MB659315BFEC1145363E4482B4BA042@OS3PR01MB6593.jpnprd01.prod.outlook.com>

On Fri, 12 Apr 2024, Min Li wrote:

> > 
> > These are still not connected.
> > 
> 
> Hi Lee
> 
> It is my first time using --thread option. Can you let me know if I am doing everything right.
> Thanks
> 
> 1) git format-patch --thread=deep

I believe --thread is the default here.

These are the commands I use:

$ mkdir patches
$ git format-patch --cover-letter -M -o patches <baseref>..<topref>

> 2) git send-email

git send-email --no-format-patch \
 --smtp-server=${SMTPSERVER} \
 --smtp-server-port=${SMTPSERVERPORT} \
 --smtp-encryption=${SMTPENCRYPT} \
 --smtp-user=${SMTPUSER} \
 --smtp-pass=${SMTPPASS} \
 --from=\"${SMTPFROM}\" \
 --to=${TO} \
 --cc=${CC} \
 --annotate \
 --compose \
 patches

-- 
Lee Jones [李琼斯]

