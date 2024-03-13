Return-Path: <linux-kernel+bounces-101531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EEF87A85A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD6391C215D0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA1547A7A;
	Wed, 13 Mar 2024 13:27:55 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE650446B6
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710336475; cv=none; b=cP5gIekcfR4bMVNA+nbcdaoqOOZ65fhUy/TZs6fMt1o7dEvJY2A4Fcl3AVLYVMDHMdvzPwPRMn0+hxFoAlHNjL8BzN0Utxp2uQHCiqJcCsQfrgrCxTfh4F3JLYGVv6B1jNITt1Bb/GzkN16zyTLYPHvh1sggnmvboxDTvgB9+B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710336475; c=relaxed/simple;
	bh=VRJh0R+0013TbsoCeZulZdeuxp8wqDD5Jwio9im/E0c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kFK+6NJI5700keUmQCjZEjurcsOodFt4RAIdmiLbssxSWoxtZHN+iaNkEqtwbKu1rbFMRsLtD1af7qwv8lQpE9Mq1V/WrTClGJaG+P0Jfv4E4i2h8jn/U0jk0aVOyvFLBQbjYFkPQ5IzjDnZaKjabih5HN92MPB3gSrxuk2ZyeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tvrsz1SVFz4x1Y;
	Thu, 14 Mar 2024 00:27:51 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <b4907cf4339bd086abc40430d91311436cb0c18e.1708078401.git.christophe.leroy@csgroup.eu>
References: <b4907cf4339bd086abc40430d91311436cb0c18e.1708078401.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/kprobes: Handle error returned by set_memory_rox()
Message-Id: <171033598336.517247.65852176947279996.b4-ty@ellerman.id.au>
Date: Thu, 14 Mar 2024 00:19:43 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 11:13:28 +0100, Christophe Leroy wrote:
> set_memory_rox() can fail.
> 
> In case it fails, free allocated memory and return NULL.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/kprobes: Handle error returned by set_memory_rox()
      https://git.kernel.org/powerpc/c/f7f18e30b468458b2611ca65d745b50edcda9f43

cheers

