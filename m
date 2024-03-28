Return-Path: <linux-kernel+bounces-122425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 671CD88F741
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 981441C27795
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 05:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BEA4A9BF;
	Thu, 28 Mar 2024 05:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tbg8POKN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411EF2C19B;
	Thu, 28 Mar 2024 05:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711603725; cv=none; b=IdY0U9Kf480GpiXHH8nh4xjl9QldF/iRwtNnuvt7v1YsAz+u8dj+yqNDY5P0zJ6SuJril8c05xSrNo7Ev6QCJvAG+VXbeJkvVCoZ88fYy6LVTGkAXvugdrTLJz05X/ubBnWc34SUOIdGbBDyU/0lff6ImeSJWQWiBQ0jcRXSZ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711603725; c=relaxed/simple;
	bh=baXI8FUz6bZRMfsAVddS0YOu+Ahk/pnkvxz+NYj8V/A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=NPD0DZtuCmfAkbMwYg9uc/5uPYQx9wFDTxnlkwMgq+KfFvkVjc/DtnV8S3zwra0wbXlxqhni93ykv0MjcYaBCflpeV+r4+tptO+tMtuRamZEq/UekCI6WBEbKIoKYiU/tADLye/gOn65DsESzc6ggs5a2Arz8joejxEjAyjnYSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tbg8POKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70648C43390;
	Thu, 28 Mar 2024 05:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711603724;
	bh=baXI8FUz6bZRMfsAVddS0YOu+Ahk/pnkvxz+NYj8V/A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Tbg8POKNNoOJq0D0phAMHk6pYkZCMmkQ2EIzZqi8JGN0hkEtRq8Nq2LyooOr7rK1M
	 SYfVCYmv5Ye9Sq1qEerMbARJZ5ZiflHRja5EeNzagne841dwAOgpmGy8CoGfruHFYS
	 NexSskI//ddnkulMX2+uGZ1r3zBQSlFGzjPNhD/dWmTR7NM8CkHgN4dFnOgGi+4wOu
	 TjccFs2RDsQ0f9cDEVTCBw0WP8SkGz5rPplzoOAY19EBhFjBEHTejhFT1UkRwgAnHk
	 g6Gz1yJzVfFMEmF0XW+j/OTgxfg2ujYwuQfLt2zamoxE23aGN20WgzxGWYik/u7f60
	 r3zJOhyVNuPEA==
Date: Wed, 27 Mar 2024 23:28:43 -0600
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D=5Bnext=5D_Bluetooth=3A_L2CAP=3A_Avo?=
 =?US-ASCII?Q?id_-Wflex-array-member-not-at-end_warnings?=
User-Agent: K-9 Mail for Android
In-Reply-To: <d5b0c70e-8369-4b99-9a42-9a4a93098251@embeddedor.com>
References: <ZgRIF1bkXlZlaK22@neat> <CABBYNZLi_PCbRB6CVYxwOG04917tDudMvuVT1NU3LVth=xpCtw@mail.gmail.com> <d5b0c70e-8369-4b99-9a42-9a4a93098251@embeddedor.com>
Message-ID: <E3E65D27-9A43-4D99-8AF7-C857A169D8E2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On March 27, 2024 11:08:33 AM MDT, "Gustavo A=2E R=2E Silva" <gustavo@embe=
ddedor=2Ecom> wrote:
>Hi!
>
>On 3/27/24 10:55, Luiz Augusto von Dentz wrote:
>> Hi Gustavo,
>>=20
>> On Wed, Mar 27, 2024 at 12:23=E2=80=AFPM Gustavo A=2E R=2E Silva
>> <gustavoars@kernel=2Eorg> wrote:
>>>=20
>>> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
>>> ready to enable it globally=2E
>>=20
>> Which tree is this base on, I just rebased bluetooth-next on top of
>> net-next but it looks like CI is still failing to build it, so either
>> we don't have all the dependencies already in net-next or perhaps you
>> had it submit while the tree had not been updated=2E
>
>This is based off of linux-next=2E
>
>I think net-next is missing this commit in v6=2E9-rc1:
>
>d8e45f2929b9 "overflow: Change DEFINE_FLEX to take __counted_by member")
>
>https://git=2Ekernel=2Eorg/linus/d8e45f2929b9

Just FYI, that is in rc1=2E (I sent it late to avoid a netdev collision=2E=
)

--=20
Kees Cook

