Return-Path: <linux-kernel+bounces-49872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12D98470BB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FE46B21C67
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0473FDD;
	Fri,  2 Feb 2024 12:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XxK6AL0R"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B49846433;
	Fri,  2 Feb 2024 12:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706878692; cv=none; b=E8w3EqTg2/dP89LbLRsCaOwZsSzbOQlxjgO6g8pBc3MMq92f+WbjIGSwumg7trfNX1IlTEoGivyOPz8NgQ3dSbuZhSuHuAP9p725fBhsPFFkUXRILuq0kiLBuuOrRH+ul/4SYwf+PeU+WneLY7iPbqAXP3SLix5sTO+HD80wTFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706878692; c=relaxed/simple;
	bh=eZxOtydVn75KlLDsjhljk2E/9by5DLKsxQBgEm9BoA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eQyhRajEr6mw3VSHng6PaLiYiNn8NY5n1jmO7OFr3VmH/iy36hvFbpVJYiHCgmmwK91OwgwToiuiDAzZzm4fgo1bIjj585URkCjb49LfxRLcUMa9H8FlEsK9N0YDSRgk0fQ9H8pd4t8NsYaKh2XIilkemlzbtcGDqc3ukcnBlvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XxK6AL0R; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706878687;
	bh=eZxOtydVn75KlLDsjhljk2E/9by5DLKsxQBgEm9BoA4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XxK6AL0RPCUwDZCkOln4QsiMSxSV+V+FsoLeSFodim/VeGCBa1gRurxBCEurJn9H1
	 M2eGLmZ+8wJVHWBjjDGOkpEOaya0UT3PXQi1F27UH0gXzNGRVlOL4c/Cez0pazK5Rr
	 d9cB1gGLUlMHG3kODLG+Gi6kn012YCsOX8O9kqZ/jGxnF3UgCGRr0Vn76qmqgatdU6
	 5JZ+kROqn3LJvFe9To2ze9qVVshRt8ZPYqZQBDdxr4afC+bq5B5knr2nVetBzsmkTA
	 /28LyP/bnxgLvhI5Kx9TFGvU4P2UVolG0oliYpt3Pt/ApMa4UW5btQsmVeYAJpdc/k
	 QYH8MpJArwguA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 79E863781183;
	Fri,  2 Feb 2024 12:58:06 +0000 (UTC)
Message-ID: <5658ec37-868f-454d-a149-467e6de139cd@collabora.com>
Date: Fri, 2 Feb 2024 13:58:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] media: mediatek: vcodedc: Fix
 Wcast-function-type-strict warnings
Content-Language: en-US
To: Sami Tolvanen <samitolvanen@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Ricardo Ribalda
 <ribalda@chromium.org>, =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?=
 <nfraprado@collabora.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Mike Isely <isely@pobox.com>, Tiffany Lin <tiffany.lin@mediatek.com>,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240128-fix-clang-warnings-v1-0-1d946013a421@chromium.org>
 <20240128-fix-clang-warnings-v1-3-1d946013a421@chromium.org>
 <20240201221654.GC2240065@dev-arch.thelio-3990X>
 <CABCJKudd3SUy3Qor7Tc0zyJsSAWy0PavbbBFALuWEpBa32pBCQ@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CABCJKudd3SUy3Qor7Tc0zyJsSAWy0PavbbBFALuWEpBa32pBCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 01/02/24 23:25, Sami Tolvanen ha scritto:
> On Thu, Feb 1, 2024 at 10:17 PM Nathan Chancellor <nathan@kernel.org> wrote:
>>
>> On Sun, Jan 28, 2024 at 02:12:22AM +0000, Ricardo Ribalda wrote:
>>> Building with LLVM=1 throws the following warning:
>>> drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c:38:32: warning: cast from 'mtk_vcodec_ipi_handler' (aka 'void (*)(void *, unsigned int, void *)') to 'ipi_handler_t' (aka 'void (*)(const void *, unsigned int, void *)') converts to incompatible function type [-Wcast-function-type-strict]
>>>
>>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>>
>> I am not positive because I don't have any hardware to test this driver
>> but I suspect this patch is just hiding the warning without actually
>> addressing the issue that it is pointing out.
> 
> Agreed, this won't fix the issue. The correct solution is to drop the
> cast and change the handler type to match the pointer type (i.e. use
> const void* for the first argument).
> 

Even though I agree that the correct solution is to change the handler's type,
I think that having a test on the actual hardware done is still valuable.

We scheduled a job on KernelCI to test this commit on our integration kernel,
you'll get results for ChromeOS' tast decoders (MT8195 only) and Fluster tests
on MT8183/8186/8192/8195.


The results should be available in a couple of hours here, relative to commit 
`49955a84129dbe1f94fedf729690efcf28513828` on our tree:
https://chromeos.kernelci.org/job/collabora-chromeos-kernel/branch/for-kernelci/

P.S.: If they don't, feel free to ping me or Nicolas (added to the loop) about it.

Cheers,
Angelo

