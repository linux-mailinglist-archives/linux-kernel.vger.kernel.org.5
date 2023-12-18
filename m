Return-Path: <linux-kernel+bounces-3562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32655816DDB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D271C21C9D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A324A4EB21;
	Mon, 18 Dec 2023 12:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxto+SCH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33534EB27
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 12:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AECC433C8;
	Mon, 18 Dec 2023 12:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702902122;
	bh=3mazpgyORGhF3jEjGhny3Nxv5ONTjfktTe319AXAMV4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uxto+SCHCEvQ4kQpuRaIQeQkRGn/Lw1oA1OO/T0Ioi9OgyVHpwzlrz7aD263PgRJI
	 EsoywLyVqgWXo2qCKxq998DNlHi7OjIUZzHg45/SMii204Zwj/7ADBSxWEW76Qge4O
	 4PgHqeB/hxhZ9m1oZj6UCct2mM5OaTWbtn557w0hGGQiQ4iI1PmPkiD9VOmavCKDC0
	 08pKD+qPq4fnN5Kg7ij1ObbNredrL3ocXwTgYI2XW64KBR/cM6k4NpiX/8krFW61eY
	 6S1lsUTkWDKRTkknuH4HbBPaeGbAlwIYM79r3hKBha4mAwnuJhq6IWHnQBiYjc7PR0
	 7vkWcieSrqYoQ==
Message-ID: <15ed1a61-a707-4ec6-8783-205388d8345f@kernel.org>
Date: Mon, 18 Dec 2023 20:21:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] f2fs: show more discard status by sysfs
Content-Language: en-US
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com
References: <1702897676-12851-1-git-send-email-zhiguo.niu@unisoc.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1702897676-12851-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/12/18 19:07, Zhiguo Niu wrote:
> The current pending_discard attr just only shows the discard_cmd_cnt
> information. More discard status can be shown so that we can check
> them through sysfs when needed.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

