Return-Path: <linux-kernel+bounces-50804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB03D847E12
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 02:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A1ED1F25D05
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B0C1FAD;
	Sat,  3 Feb 2024 01:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X+jmuCIl"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D43137B
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 01:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706922935; cv=none; b=bVk6I2Hhxz4mbDQqEYB+P7/NdACaVdH/ZZZNoqPY3bk2PvBQD2w9GuTzv6XHKyctSDZAb7lfN4DiWvTR+qVJIl7/yxqO8ZUGZpYshxalzorXA/H4weUyLCASU7zFGmLaC+07Ho66tKXAJC5qzi0IaLBqFtIbWSJWPcP2j4qX7YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706922935; c=relaxed/simple;
	bh=nvnay/4uCgXmChspVH6RP98KJoCMdybd69jOnyBiEcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CT9UHmnMQbzqUQR+bySvwkm2c0NVCFpTK/jUzxKe6cIqOE06EyPoLyMRQaZfX1FJzl/r7CrVsr8DmfGJjRA/veJ7q4z2uBvFAxwK9n5LF+0/KzGmTbuZvMkNrA3OSvLmh47mwvKLq7PRYAThHDiLbcZh9Xok/TXqnfScs4uXBuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X+jmuCIl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=ZtSs4NzCnS3T4/1ZtZah9hG0s9USDmL9V21BtkIFvM4=; b=X+jmuCIlKoec9chHyzY9878/TE
	LYnmkSotwepsYg2WtxyDWnjhFy1AE35He8NnyrFZPubBT4TQFfOc1sKg+px1vHfhA24usKb390QRY
	g+J6hW9/27Wa4TQUdNIe9v+qHfrzQqQY+Ht+6186PabLbY+i0JhjKVSABZejOm+ZLXCWrk0S9g6h3
	2rN4Q0ofv/ywBd47hiOI5aoguH6p0Stzlw2Si2zh7QipqBb6HCrj+LwBs4F5SZwDCoM1e5ZKTwTKo
	mOCVYUMnqnnfXB2wzi1QRU2MZUjjpaT8K6LdxSfHLTxAEXJP0PECtyclCLUO6P88sm+ohpGhwnUp7
	w4IFT1VQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rW4d2-0000000E6Jj-3Qlf;
	Sat, 03 Feb 2024 01:15:32 +0000
Message-ID: <43a769dd-aa09-4da3-a226-ecef98f32e0f@infradead.org>
Date: Fri, 2 Feb 2024 17:15:30 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_This_is_the_fourth_time_I=E2=80=99ve_tried_to_find_?=
 =?UTF-8?Q?what_led_to_the_regression_of_outgoing_network_speed_and_each_tim?=
 =?UTF-8?Q?e_I_find_the_merge_commit_8c94ccc7cd691472461448f98e2372c75849406?=
 =?UTF-8?Q?c?=
Content-Language: en-US
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 linux-netdev@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
References: <CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/2/24 17:02, Mikhail Gavrilov wrote:
> Hi,
> I'm trying to find the first bad commit that led to a decreased
> network outgoing speed.
> And every time I come to a huge merge [Merge tag 'usb-6.8-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb]
> I have already triple-checked all my answers and speed measurements.
> I don't understand where I'm making a mistake.
> 
> Let's try to figure it out together.
> 
> Input data:
> Two computers connected 1Gbps link.
> Both have the same hardware.
> Network: RTL8125 2.5GbE Controller (rev 05)
> 
> When I copy files from one computer to another and kernel snapshot
> builded from commit 296455ade1fd I have 97-110MB/sec which is almost
> max speed of 1Gbps link.
> When I move to commit 9d1694dc91ce I have only 66-70MB/sec which is
> significantly slower.
> 
> I bisected the issue by measuring network speed on each step.
> I save all results to file [1]
> 
> [1] file is attached as a zip archive.
> 
> # first bad commit: [8c94ccc7cd691472461448f98e2372c75849406c] Merge
> tag 'usb-6.8-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb

a. Do you clean the object files between each test run?
or at least clean net/* and drivers/net/ethernet/* ?

b. I am far from a git expert, but in the bisects that I have
done, after each test run, I just say
$ git bisect good
or
$ git bisect bad

It looks like you are typing
$ git bisect [good | bad] hashID

Is that correct?

Anyway, I am interested in your outcome just to learn
how to handle this problem.

Good luck.

-- 
#Randy

