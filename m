Return-Path: <linux-kernel+bounces-104003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D808D87C7C2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 753541F224F9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4ADD272;
	Fri, 15 Mar 2024 02:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcfKqZvb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B50C8C7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 02:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710471540; cv=none; b=crzqgKAilJobjFi8APAserdqdTxdh9ZsuwYLgjsBBZy+MZvsxDCVdIUGcEsRaZhaRocOMH2g3xDQKEgucU47QKBCPUX8U2xYtugsKC2wU4bGRZzGOFlo+B88PC9JjG0ygFjpbxAcTu8ILJjPdwfMyDdYats29Z3IcFhCwG9WWCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710471540; c=relaxed/simple;
	bh=qXwkEeaqeKDKD2TfToeMulydtYdY4J94j5SABNK7Rcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ap9aZ+DKfU0Oworj59Y5i5UIv+hNrz4oJgDJLg3Z9bFEF4ZahsaiHRWyH4WdUxZWZ9vDI1KmbAmJ3wznBKB82FYbPOmf3qWXL1AtMXNMDc6fBYqySogio2pZHCnpf/TlIHfbSQSdnBxMT9FER3pZEfB1NOhTKY47UVHFDiblpe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcfKqZvb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8AAC433C7;
	Fri, 15 Mar 2024 02:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710471540;
	bh=qXwkEeaqeKDKD2TfToeMulydtYdY4J94j5SABNK7Rcs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fcfKqZvb5UrJHQjPhuVJO4CleCyL+p3TZYKAsKfbcp3lvlbMgzG7HNZA8+c5MgU0y
	 OJM3MEWswFoRTuWsEjsy2g7k5TxYkgCZeLU30kvFscS5TamWw/060mP/6vEBdLZk2S
	 PKfoIYqe/yt+YUvY8do97prbAk3iAyPqJf4QJ8LLklMcLYaHrinM6V59QDnkpqv7Qw
	 VI07NO6yHDre02yHmFbPbYQBIpnQoKN2DumijMkIhtsXqzBbspGqfi7P/cFk1FeEd5
	 thXTsyWz/xC09T0E3HFD7gySqBfMJ/OQEj1UbH4o3VdXwqkzJgzfHUBOnpFlLy3Pu/
	 YsNc6tIeiK9Fw==
Message-ID: <e558d9ba-9444-4cd1-804c-fd678dac46a1@kernel.org>
Date: Fri, 15 Mar 2024 10:58:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: erofs: add myself as reviewer
Content-Language: en-US
To: Sandeep Dhavale <dhavale@google.com>
Cc: kernel-team@android.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20240314231407.1000541-1-dhavale@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240314231407.1000541-1-dhavale@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/15 7:14, Sandeep Dhavale via Linux-erofs wrote:
> I have been contributing to erofs for sometime and I would like to help
> with code reviews as well.

Thank you for the effort and looks good to me. :)

> 
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,

