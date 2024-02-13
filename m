Return-Path: <linux-kernel+bounces-64020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB2E85390D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF251C2438D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F85E604DF;
	Tue, 13 Feb 2024 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ndlVir0a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E90605A7;
	Tue, 13 Feb 2024 17:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846867; cv=none; b=kVemcT5BBl7WUNBAwYE7ANX4tEnA/khwHRX6rvLsoORnCV+upOPLiHCZjt+F10CbC8GYbUghnHU7Ro9wZk3OMIiJ8QmzK6wRXESm7IOWsa7IcaaqBKT4/qoHKGyvrAYrQCrdnULsOVSJ1g3lmBnqYNb/YgtjOJ+S/uEmAIqpr4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846867; c=relaxed/simple;
	bh=vIvh25d6sb8bZomcyiOvXEW9/3+G1tT3pFcYGHQA4Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVx7pOVpgrRB4bAE7gwB9Cbh11BJPTX6tdU3f024spRK5WQYC0s/wxtc0V3RhVZKwUC9oLvsGfLz6XAfhkbfTSvOkNnAs99jYefGEnnSOGwum8Q+m2xNytBha6IVWq5Wdq69nbTEUHzeuLkk5y8dlSOPaGQ4dLVog++CYfI9wMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ndlVir0a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C98AC433C7;
	Tue, 13 Feb 2024 17:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707846867;
	bh=vIvh25d6sb8bZomcyiOvXEW9/3+G1tT3pFcYGHQA4Pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ndlVir0aCLxAm2kfqAZPwwhVbzoMYg5LIearQI6q8AbKO8EM7HqAKfrTZV61AY8uh
	 TBWcCdY0pebputz/uHv2VtyoH7Gi+iTsWR4TL6g0Fna7bbVmie2iG/dHlprlo2ZDm3
	 byDYDuDbQhC6vDZVvZC2aQLbNAzfIuxGrv73/AnQ=
Date: Tue, 13 Feb 2024 18:28:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: mdio_bus: make mdio_bus_type const
Message-ID: <2024021359-afterglow-reentry-d0cc@gregkh>
References: <20240213-bus_cleanup-mdio-v1-1-f9e799da7fda@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213-bus_cleanup-mdio-v1-1-f9e799da7fda@marliere.net>

On Tue, Feb 13, 2024 at 11:48:00AM -0300, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the mdio_bus_type variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

