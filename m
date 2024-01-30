Return-Path: <linux-kernel+bounces-45340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCDE842EC0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AECA91F24D42
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CE678B73;
	Tue, 30 Jan 2024 21:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bi62CBMF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C03878B4C;
	Tue, 30 Jan 2024 21:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651055; cv=none; b=rX4MOzbU9qSvoij7W/5oYsafJWq7mMz3kJgGkKY3W4y+/jRuLl25e9nT/oi30nyCicIp1zwXAYK8FHlehuqC434pL80KkW2sViue5oufePvL+/9TuQGbOOlcV3UfrtzOMWuYaANhibdrZDHUzEMr0EOmENo7BRv7BcOr3zBIcOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651055; c=relaxed/simple;
	bh=g6hr6LR3xoUAgXzeQqjncFC5OG0aiyGIcL8UiWBwqIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rS0JdK2r1DNUCEe1diGOm9s2KWvtQ17TLKovNizgI6tD5WxMKtuzWiT7eYd/YYLJXyHVvFAIA5KllA8T/okPIT7ukzdxBpTyd+0YirNs6vJ1s4swvuM6CLOKPMGaPsSeBEDtzeyQrbMB9NFt7394CBfgRgUkARRcgJCfXkLqPJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bi62CBMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42D6C433C7;
	Tue, 30 Jan 2024 21:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706651054;
	bh=g6hr6LR3xoUAgXzeQqjncFC5OG0aiyGIcL8UiWBwqIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bi62CBMFV89cP3C48f3mzPsmWlkaFPNdacrfVyxXb9Ms/V80yOaz+L9EeARnrlP7j
	 7KjTvkeFwcmMua3GoVsLOS3jrXgLichidGrxxCrYdhi1SUWJSGtHc4rweobzSv1Rko
	 iC1tcV8sdyy6DJCba2dFaeTPJSe/i8RRWh/WzqM8W2mtFdc6A+y4A5MKluLNyirTXo
	 GFrLmJQrO4EZcFowwj7KGq2Nzqi9NQ9ZmD+5bDotjSWZWkG1Q5ycppCtzi8j77Ge34
	 Q3Pl1Sk58EYVuo0C/5lfbedKxbIr/MkvTGl9XdPEq+O473BC3GJJQ64pM+6jla9l/9
	 SzEN/cljxx8OA==
Date: Tue, 30 Jan 2024 16:44:13 -0500
From: Sasha Levin <sashal@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Andy Gospodarek <gospo@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.7 036/108] bnxt_en: Add 5760X (P7) PCI IDs
Message-ID: <ZbltrdwtzOsiAumV@sashalap>
References: <20240116194225.250921-1-sashal@kernel.org>
 <20240116194225.250921-36-sashal@kernel.org>
 <CACKFLinMgFcKzKv8=n0MM7XZGhDO1=NFmFAu=pKsj0+BNCqKOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLinMgFcKzKv8=n0MM7XZGhDO1=NFmFAu=pKsj0+BNCqKOQ@mail.gmail.com>

On Tue, Jan 16, 2024 at 11:47:59AM -0800, Michael Chan wrote:
>On Tue, Jan 16, 2024 at 11:44 AM Sasha Levin <sashal@kernel.org> wrote:
>>
>> From: Michael Chan <michael.chan@broadcom.com>
>>
>> [ Upstream commit 2012a6abc87657c6c8171bb5ff13dd9bafb241bf ]
>>
>> Now with basic support for the new chip family, add the PCI IDs of the
>> new devices.
>
>This should not be backported to 6.7.  It won't work without all the
>driver changes required to support this new chip.

I'll drop it, thanks!

-- 
Thanks,
Sasha

