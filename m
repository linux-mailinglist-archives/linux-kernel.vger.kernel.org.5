Return-Path: <linux-kernel+bounces-11075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 206DF81E105
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 14:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 518371C2157B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 13:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785D1524B7;
	Mon, 25 Dec 2023 13:53:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-m6015.netease.com (mail-m6015.netease.com [210.79.60.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D6F524AC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 13:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easystack.cn
Received: from [10.9.0.134] (unknown [211.103.144.18])
	by smtp.qiye.163.com (Hmail) with ESMTPA id EB78C4C0290;
	Mon, 25 Dec 2023 21:44:02 +0800 (CST)
Message-ID: <a65e7a06-bc91-4c82-9a65-6066f9f64409@easystack.cn>
Date: Mon, 25 Dec 2023 21:44:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/kexec: fix potential cmem->ranges out of bounds
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231222121855.148215-1-fuqiang.wang@easystack.cn>
 <ZYWPHSmwK8iG6xUr@MiWiFi-R3L-srv> <ZYe3iN816iiKDwIu@MiWiFi-R3L-srv>
From: fuqiang wang <fuqiang.wang@easystack.cn>
In-Reply-To: <ZYe3iN816iiKDwIu@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGEpMVk5KTxlLTExNGR5KGFUZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKSlVKS0hVSk9PVUpDWVdZFhoPEhUdFFlBWU9LSFVKTU9JTE5VSktLVUpCS0tZBg
	++
X-HM-Tid: 0a8ca137e1fd022ekunmeb78c4c0290
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MRQ6Nzo5STc#Fy4DGT0SIzgR
	Gh0aCxBVSlVKTEtITkpKQ09ITE1PVTMWGhIXVR0OChIaFRxVDBoVHDseGggCCA8aGBBVGBVFWVdZ
	EgtZQVlJSkpVSktIVUpPT1VKQ1lXWQgBWUFJS0xCNwY+

在 2023/12/24 12:46, Baoquan He 写道:

> Rethink about this, seems above code comment is fine to be kept, and the
> same feeling about the elfheader region split from crashk_res. So, other
> than the patch log concerns, this patch looks good to me. Let's see if
> other people has concern about the newly added comments.
>

Hi Baoquan

Thank you very much for your suggestions in the patch log and code comments. I
have learned a lot and I will gradually improve.

I found the following patch in linux-next:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=666ef13f2870c43ba8a402ec8a3cedf6eb6c6f5a

I'm sorry, It's my mistake. Do you think it is still necessary to merge this
patch based on that ?

Thanks a lot again
fuqiang

