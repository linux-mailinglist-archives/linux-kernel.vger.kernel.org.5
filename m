Return-Path: <linux-kernel+bounces-63333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E91A852DBF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DD051F243C1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D9922616;
	Tue, 13 Feb 2024 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpXnPfrk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310FF225D7;
	Tue, 13 Feb 2024 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707819635; cv=none; b=ebfRTSWD73emWys3/fBov2jSAd24reflxnOaVN3S3/5jAniMDs5ZV5sRCxft6cuU5Gg40MP7jFPJwxaUkmQyN4zLW+ABtasgBXGQhqrV5n5we/I3cU6HZ3/+GJiS7mapHswwWr0RsAyoK8qXOQO7TCWDkNxjl7I8v0wXtOK3qrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707819635; c=relaxed/simple;
	bh=n0ou7WD7KMKANeWLKX2bwvZBLP/2QLNRWLdKGrEsIXQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Us1cB9/6aMH4Xt7xc21p22GGxFgAgs4afmjbqotD/oNKLiY6NX7x9yGTH3Q9qIlDU70ye3AbHiRfFZjs9l3oowd62vxWzTUYLT8JRVH9rxse3V088v32w+v2t/l2dJed1czwFcOQ2X+ThG6C+qa4HNNktN4atYaUw/cTPL3Zo7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpXnPfrk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B7EC433C7;
	Tue, 13 Feb 2024 10:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707819634;
	bh=n0ou7WD7KMKANeWLKX2bwvZBLP/2QLNRWLdKGrEsIXQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=lpXnPfrkr0/pJ7fRmnqZJrRpevMori6NOvl1ZbunemzQ0Hb+Ajb2Mq/Rp9Ik7ZTiO
	 +aV416Vz23KWqjzQk2MnnzmnBfFJMXwx3T5HhRyZmBumE/peAvi25i7sj+TzLun8JZ
	 d4/RrdRoAn28iMwAtKgyklkg/25jcncvG4nekkGf6msK+SChrwnnwLwQSe9D1hp4yq
	 cRP4pcweZG/xAjq6UPyD17AaWrfF+Mw7yu5faY48Vb99EiTlKcL4g76wRPwCT4kpbu
	 nAzpaG/qbbqyB5HwhphCz72CeiUuOx/AnYcPmKAHUMVxC83ymyVsu/9CII2iwpY3/p
	 4mqwOnLOqC0Ow==
Date: Tue, 13 Feb 2024 11:20:34 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Michael Zaidman <michael.zaidman@gmail.com>
cc: chrysh@christina-quast.de, daniel.beer@igorinstitute.com, 
    linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
    linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com, 
    johan@kernel.org, gregkh@linuxfoundation.org, equinox@diac24.net
Subject: Re: [PATCH v1 00/19] hid-ft260: Fixes for serial driver patch v4
In-Reply-To: <20240210215147.77629-1-michael.zaidman@gmail.com>
Message-ID: <nycvar.YFH.7.76.2402131120070.21798@cbobk.fhfr.pm>
References: <20240210215147.77629-1-michael.zaidman@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 10 Feb 2024, Michael Zaidman wrote:

> Modifications on top of "[PATCH v4 RESEND] hid-ft260: Add serial driver"
> https://lore.kernel.org/all/20231218093153.192268-1-contact@christina-quast.de/
> 
> They are mostly the fixes to the original v4 patch and should be melded into
> the v5 patch rather than upstreamed as separate patches.

Agreed; I am not acting upon this series now then, and will wait for v5 
with these folded in.

Thanks,

-- 
Jiri Kosina
SUSE Labs


