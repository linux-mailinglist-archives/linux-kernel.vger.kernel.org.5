Return-Path: <linux-kernel+bounces-167530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC0F8BAAEA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A61E1F202CA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4391514F2;
	Fri,  3 May 2024 10:42:37 +0000 (UTC)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278B47E766
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 10:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714732957; cv=none; b=hiasikDwqVKYw4kdG/sOPcCj5wrMhNrDmqrxzfBnxXYEpInH+cx6fNXV0VTUUMJASoos8QN1BRRmFtl8L3cRSBdaOm2gHSGU2wg380P0i93nvOtZOoQPQVT7R35YJheCUDXotgQ0uDm7HFD7jRz0xS1bEg2GQdKLNqxAHAfwCfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714732957; c=relaxed/simple;
	bh=xDzCGU/il0raaq050KId8OVqVXxRU9JYhEjQkOakulU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZcFEtf6Q1pU5UFJ5JcLKpOXzTSlmbqWRiBI7JmlMokYHQB8dMAzfQvlwtZb4ZOsLWyahqax96YrtLYA7t9vpVpA+U7fa7IQw6BN3bSl87Sd5G7idmCg7TgrztY7SneXxP6L3QrpJLdpO5zhSj2zVD8So2RLAn4AJAFDZBhzy5tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VW6ng6xftz4xPM;
	Fri,  3 May 2024 20:42:31 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: yangyingliang@huawei.com, mpe@ellerman.id.au, sundar <prosunofficial@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com, Julia Lawall <julia.lawall@inria.fr>
In-Reply-To: <20240424150718.5006-1-prosunofficial@gmail.com>
References: <20240424150718.5006-1-prosunofficial@gmail.com>
Subject: Re: [PATCH linux-next] macintosh/macio-adb: replace of_node_put() with __free
Message-Id: <171473286295.451432.11707762913723680358.b4-ty@ellerman.id.au>
Date: Fri, 03 May 2024 20:41:02 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, 24 Apr 2024 20:37:18 +0530, sundar wrote:
> use the new cleanup magic to replace of_node_put() with
> __free(device_node) marking to auto release when they get out of scope.
> 
> 

Applied to powerpc/next.

[1/1] macintosh/macio-adb: replace of_node_put() with __free
      https://git.kernel.org/powerpc/c/84030aacf127d000180fa3cb4b589d8ab1b0d46b

cheers

