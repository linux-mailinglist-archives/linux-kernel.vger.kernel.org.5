Return-Path: <linux-kernel+bounces-27316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A694582EDB6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D31E1C23274
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411151B80E;
	Tue, 16 Jan 2024 11:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKWagJjt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD271B7FD;
	Tue, 16 Jan 2024 11:29:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45F3C433F1;
	Tue, 16 Jan 2024 11:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705404586;
	bh=6w6HVjkdpppHRgfqwMZmBwawH3Y4Fnl30VFp/Ugh2Rk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NKWagJjt1E81Cfdajv9z0xej0D/Ht7ATq2Bo3pPI8I/Jt8Si7Obqhwhff90rFufHt
	 0ZZ2zovpUFdZiuJ/gpWkM87CN7zJ+w3pADxpVtDmg/auD/m/4b7NkldRldvQTjPGQg
	 FPQ339PDlMpn6nXukfTeFJWqSmWWCInieij9SDinnbA2j2+3u+rV5Gg6wHHlwRjzH+
	 fWVlBbwaEKoW/A0fImZnZpRF9yqbYMKkJQwz9LbZiR4ETZoGjo6nzxRYHseKFc7bVK
	 Y8NS9JkTOc6jkQAZcOXNes3h8ggL6MRPjhZHARZAZfLgPNgyj5hdBgg279gGnem80w
	 Bg5YQojv1O9CA==
Date: Tue, 16 Jan 2024 06:29:44 -0500
From: Sasha Levin <sashal@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Willy Tarreau <w@1wt.eu>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.4 7/7] selftests/nolibc: use EFI -bios for
 LoongArch qemu
Message-ID: <ZaZoqGxvuUEZ04Wo@sashalap>
References: <20240116001514.214199-1-sashal@kernel.org>
 <20240116001514.214199-7-sashal@kernel.org>
 <CAK7LNAQHRwqjLcjLoOm8SEn5wje6A7aKhbjBdyFpxU1jorhPcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAQHRwqjLcjLoOm8SEn5wje6A7aKhbjBdyFpxU1jorhPcw@mail.gmail.com>

On Tue, Jan 16, 2024 at 07:50:17PM +0900, Masahiro Yamada wrote:
>On Tue, Jan 16, 2024 at 9:15 AM Sasha Levin <sashal@kernel.org> wrote:
>>
>> From: Thomas Weißschuh <linux@weissschuh.net>
>>
>> [ Upstream commit bdeeeaba83682225a7bf5f100fe8652a59590d33 ]
>>
>> qemu for LoongArch does not work properly with direct kernel boot.
>> The kernel will panic during initialization and hang without any output.
>>
>> When booting in EFI mode everything work correctly.
>>
>> While users most likely don't have the LoongArch EFI binary installed at
>> least an explicit error about 'file not found' is better than a hanging
>> test without output that can never succeed.
>>
>> Link: https://lore.kernel.org/loongarch/1738d60a-df3a-4102-b1da-d16a29b6e06a@t-8ch.de/
>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>> Acked-by: Willy Tarreau <w@1wt.eu>
>> Link: https://lore.kernel.org/r/20231031-nolibc-out-of-tree-v1-1-47c92f73590a@weissschuh.net
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  Makefile | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>
>
>
>
>This backport makes me upset.
>
>The original commit, bdeeeaba83682225a7bf5f100fe8652a59590d33,
>changed tools/testing/selftests/nolibc/Makefile.
>
>
>However, this backport changes the top Makefile.
>
>
>What is happening in the back-port logic?

I'm... not entierly sure. This wasn't hand massaged.

I'll drop it from everywhere.

-- 
Thanks,
Sasha

