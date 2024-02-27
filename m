Return-Path: <linux-kernel+bounces-82743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2689E8688EE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5111F235C5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C6B5337B;
	Tue, 27 Feb 2024 06:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hir1cSvG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3A353373
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 06:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709015179; cv=none; b=QbR5/Wfntbx4fGq0c9PyCiiwqAaO/2Gi/FXXdp31a42oxOaOpDZxq08gyhmC781eU+/5kWNLlo7A8kAjsSnRT46iJ2kUB00H0vTJ5s6CSqhYPcryRFyR0Eiu3uWNLOajGgPSha9ok4ZC1kRkNCs2CBl1ifcr/1cJ9C7j5utkUwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709015179; c=relaxed/simple;
	bh=dh9eafsR8lA/6L1du13qLNwxxQgJJ9ECt3Bfw1mY4J4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HK2ZOzSxj/Lbz8cleOgKGhOeY6Vpq4MK3onjwvwhsuiSu11ewEpg4Un/ndUxoDoyYCx4Awa9LGhnS1sp3vytbhYAm8wkg8L/EwK2420NZ+9gVwKDmmyfrvxYEvbdix+GCGw/3aPLX5DkyMeqNFprMaq1p2IhWJb6Mq/tAlAPsCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hir1cSvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFF4C433F1;
	Tue, 27 Feb 2024 06:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709015178;
	bh=dh9eafsR8lA/6L1du13qLNwxxQgJJ9ECt3Bfw1mY4J4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Hir1cSvGcnKbzskr7azVr/MYk6CDr5FvcV/tcPvWKSOr/K2fwFlc4b7KjPos9+89O
	 k+m4z/K11YgN0r1cYiI4VTm3kFjczoSkJqeoI8tFlEjZKDUBjbEJWIpLsZwE/UG0go
	 Z5SEBsmZGunqTmwh6894670SLiDwkQMkCxE4qV9W6RHdM9EnC53nslHC2LZKxqbFWP
	 T7Cv18HgHUBx7dZNr6UHB1b6BwFcWEh+2kcrkbb497L6Qq0mEdUFPuAG+9Kk/gTpYN
	 eKKzM736H1xKxks5ON7C7wCIFUnlL4wZl3DRxtDB0mS7ij1YftPIQJnQWcsOaxBV4T
	 s+xyPM+nDl8fg==
Message-ID: <4beb8c78-cd8a-407a-aee5-58d8d2c8d4f5@kernel.org>
Date: Tue, 27 Feb 2024 14:26:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH 3/5 v2] f2fs: print zone status in string and
 some log
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240223205535.307307-1-jaegeuk@kernel.org>
 <20240223205535.307307-3-jaegeuk@kernel.org> <Zd0WLOe89pByO7yX@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <Zd0WLOe89pByO7yX@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/27 6:52, Jaegeuk Kim wrote:
> No functional change, but add some more logs.
> 
> Reviewed-by: Chao Yu <chao@kernel.org>

v2 looks fine to me.

Thanks,

