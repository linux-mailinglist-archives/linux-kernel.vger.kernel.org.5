Return-Path: <linux-kernel+bounces-68950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8238C858251
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C022811B8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E1B12D770;
	Fri, 16 Feb 2024 16:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="GdvfW9IH"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7C312FF7E;
	Fri, 16 Feb 2024 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708100490; cv=none; b=Y2bYAAQY+bgGEP6aNiTpv6ycsqRB/goOnypuWTzOgDcL53iqxWcba84cEMs6JY6JoKbQ84OADWP9ckBXrHPEkNCiIHZ2so4OmF54ao2yF3baE8TBYyHpe9aDCCt+SX8gu3dys/yDPZHgSuF84vhveeEpQrkrY6FNkjllNaV9ooE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708100490; c=relaxed/simple;
	bh=7iD9q0Gwldur64dA/55/MQ50Mw4xBPg23TbfvVZYhxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kWzbh2u4m4+7w1hKaG+8/6XBtZBiozPHKwHTalWDqAE2gf6J+muW++flMlyUvumTnDA0yEPNrHoBXMz25ghE0tCUpQYzK3mah0jJRS8VNRKZFS/gEURkExKsBKiXZg+38QTY6yPCybMCbkB53jJyY6qOnLK8MwKixL/sldlyTYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=GdvfW9IH; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4TbxyD3WSLz681h;
	Fri, 16 Feb 2024 17:21:24 +0100 (CET)
Received: from [10.10.15.23] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4Tbxy75mrHz681Y;
	Fri, 16 Feb 2024 17:21:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1708100484;
	bh=+EhGQqpz9ZldhZddNobac3SACJQDyJzAy13hPzzS270=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GdvfW9IHmAfvlsr/J3nEhiOtIE3QGPO/aTM8c7XI8JvHfY1jHozVcEekSjg06hyhE
	 RXyR+udvJgVeft3ow0rRjTj/hf3X1PgtutTx0Nqpb79uT/hXmYrODoSek38vSmrstn
	 LJajJbPa2bxIfxK/io0uXEIvg5McpyC4ja3rwIu0=
Message-ID: <93abcc66-81cc-4ed4-9881-ff8f4622acd0@gaisler.com>
Date: Fri, 16 Feb 2024 17:21:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc: vio: make vio_bus_type const
Content-Language: en-US
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
 "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240204-bus_cleanup-sparc-v1-1-4ca7fe8de5f7@marliere.net>
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20240204-bus_cleanup-sparc-v1-1-4ca7fe8de5f7@marliere.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-02-04 16:19, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the vio_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Applied to my for-next branch.

Thanks,
Andreas

