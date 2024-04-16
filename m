Return-Path: <linux-kernel+bounces-147397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03F78A735D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E03651C21839
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4EC136E0A;
	Tue, 16 Apr 2024 18:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbetQuDr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBD585C51;
	Tue, 16 Apr 2024 18:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713292846; cv=none; b=WWW0RUYIErNiTvA2c1NvdOJrx0WDdbJ6W12MyRq5xldUavFrlCMjXVMqJJiBVIfKkL3SfQDE8qBGxPHVTa43qyOYRYaHpuG088Ie5IzrATbaCYW4mJZR/ITwXRJJp/2zBwD4VKM2r2GlT3wRbfdGjNcKWKk8CkZxpDGoWZS4yEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713292846; c=relaxed/simple;
	bh=nxSZFf13GJ6gPxVDpjdFx1f46eGRR2qmOA9vcH9/Ju8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ERGdvJFB5bj9FF0fnkPMS28Gs0gmCNPpEjQvhxrFWYPZpHKxUMBYYQvQXQRBACxfUfJ6/cmHW2l5CoMrT43jfuOqmAOihGq5hhEuxjdNs6zjFU7ix6++kt0sO9E0GwhHDBkf0fY2Y6VOjOWbOmXD48SBz0IZ2Vvn03ZZ+xrs/Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbetQuDr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A0CC113CE;
	Tue, 16 Apr 2024 18:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713292846;
	bh=nxSZFf13GJ6gPxVDpjdFx1f46eGRR2qmOA9vcH9/Ju8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lbetQuDrOp+4N56X4d/A7V/XM/Y7aaLvqkAeawoYUJfiJ7UmbA7BGx766xosIC/ee
	 acmlfTXt5jEQ2Q9SRGfzpGBVFvKEidyZyUJCXJ+EK+U7A6Ts+PwJBadW6phkF4hlXl
	 UbuGGD1kiteSrVNpBOVDLkJMHqOsJoR4a5pnYQVwCJ9A1eZbn9eGulWzcZASbak8uN
	 tQHgxiladEL8hKf7J0xFHGS1FE79lK6DJNIcpmNh4A+4BAqMO3x865Ou0B3EwA1hYE
	 OidEg7Rfi/Vf01XLe1svoXqql4gO+T57UeVpGEojsDm5EWLCF+2oIe4xou2JxCQqXO
	 3Po/mOXMqd3UQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-damon@amazon.com,
	linux-damon-trial@amazon.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Third in-person DAMON Beer/Coffee/Tea chat
Date: Tue, 16 Apr 2024 11:40:44 -0700
Message-Id: <20240416184044.98993-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20220810225102.124459-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Wed, 10 Aug 2022 22:51:02 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hello,
> 
> 
> In short, I'd like to start an open, regular, and informal virtual bi-weekly
> meeting series for DAMON community.

I'm attending Open Source Summit North America 2024[1].  I just booked a time
slot and a half of a room to use it as an unconference session for the third
in-person DAMON Beer/Coffee/Tea Chat instance.

- Time: 2024-04-17 (Wednesday) 16:55 to 17:35 PT
- Place: Room 444 of the conference venue

The time slot is just after my LinuxCon DAMON talk[2], and just before the
evening event of the conference.  I hope this to be a good chance to meet with
other DAMON community members and chat anything fun.  Please feel free to join.
Looking forward to meet you!

[1] https://events.linuxfoundation.org/open-source-summit-north-america/
[2] https://sched.co/1aBOg


Thanks,
SJ

[...]

