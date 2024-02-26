Return-Path: <linux-kernel+bounces-80437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287BB86686C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71BD281AE5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE40179B5;
	Mon, 26 Feb 2024 02:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oudjE6Mc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B425317722
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 02:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708916379; cv=none; b=qxBvHIg1VzPVJhKn3n62oOaM6PmjeOr5i/tEfjUa9eoVggx7J8DhKcBocaY+PTtoOB6Uia6aXF0M/rKk05FaHG9Mmiko3XkzuH5XdJJKHOrqzEJD9jCveDN0PdMKlKpC7ky9q8w8gg6dzFR39WUgvutOLALiz1BQoT5D5+Ve4HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708916379; c=relaxed/simple;
	bh=taKs/RPbNJKiITCMU+JxhHq8kEWFW9sKdPpxHB/iRHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GbwT7zoBdMfQKyL7kcj8K4DP0U/QhC/mCpeFtpP7xUW5Dl54jsGfJuPIwjKMOQAjRmc6N7LWaAAkcrhLZ/pIKROrzoKvbqzT6Yp4R8nG4j+9iks+6GtErRjN2VMArFmeRVIcR7w7GVm/Txu5RRER5ZDnIQTEle/twuZqZVUA/zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oudjE6Mc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C75AC433F1;
	Mon, 26 Feb 2024 02:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708916379;
	bh=taKs/RPbNJKiITCMU+JxhHq8kEWFW9sKdPpxHB/iRHQ=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=oudjE6McByKnZwSCcQDqCnm/MOwr6ZFScZTuxETM9ZtzUvbFWr0+uPg0VtSQIxJad
	 AXwV/LQLDTAfRDFTlNZhfZeQ7cRE5XdTtDSPm4ZBLmviIp4Vv1d+gS769OQIvm24/v
	 WRlKBh6AE7NcXN48/uVNrFHgLos55hiFo9e7fPHC7HOf3S1o7ki/dyCeD7wsvMyG5q
	 Aslq3s9YP6sOQB8/axCHcUK4cTNtIEHLap3hODqMb/VzeDlpV9Rq90PcNtYDdNTa30
	 BKz6LX/tBO4UIIzZLiA5uE0SXoOT26tUt3xLfwUDoJzWPBy8mQGuQZ1ObeZaKVRW7K
	 uKnJbxaBfihYQ==
Message-ID: <b0ceea04-19e4-45ad-aee5-8ca3585e2171@kernel.org>
Date: Mon, 26 Feb 2024 10:59:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH 5/5] f2fs: allow to mount if cap is 100
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240223205535.307307-1-jaegeuk@kernel.org>
 <20240223205535.307307-5-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240223205535.307307-5-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/24 4:55, Jaegeuk Kim wrote:
> Don't block mounting the partition, if cap is 100%.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

