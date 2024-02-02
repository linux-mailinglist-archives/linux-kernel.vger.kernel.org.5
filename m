Return-Path: <linux-kernel+bounces-50535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C79D0847A59
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0401F2722A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3451F80634;
	Fri,  2 Feb 2024 20:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KkX+zAQg"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EB680632;
	Fri,  2 Feb 2024 20:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706904957; cv=none; b=DXkwIzfA5g9O7NNbZm7+iP7vlPS2aSC0tDOfvZPySzxTv5ieNweO03feVVJBCn/TLi2JSneYO5n2G4jGYdIewBjh2qqg0nJdlqWPbUDAODEzmScslNIt1lTTN0JC8a0OPhdpna5IL90UhDdKAx/yMXZcM0HWwQ3sH/m5UYFwO70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706904957; c=relaxed/simple;
	bh=8Eb6CVHvUmhvVTdSdy4hQhQ0gw+ENbyLq6EVTtPrF6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B17WHXq4RLsGbmSJpX77In2ee2Fb341tfo6lMh6SZGm9qDRRDdpC1RIohZuM5x5YlG/t8IG5KvGwBgyTIZj4JxPMUr/gydE8OqLnV4V9sxdrJ16i8jt72z+0mRiQY66sPN2u4b1IH0k0467ruK5SIxuqfFqFMTCSEdIEH8Y8GgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KkX+zAQg; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706904952;
	bh=8Eb6CVHvUmhvVTdSdy4hQhQ0gw+ENbyLq6EVTtPrF6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KkX+zAQg4u9JHou4hpFsyJsuIDcEANiaR6FAwe35n3VMT6eVe1/MIDXqyfhTT2amZ
	 MX+22V8TjVaTtpClvaVdJe2woQReq6niv/Y90ZJPYrayU0wjcZBkFtNiYC/2gzHb+Y
	 yM6MPs695fy5HK73hFkBAl39e+5E2KwqNGLaXToYi6lQ96Lg0OeGCw3sqx2Jj0G5pT
	 13+NmiSKIKcDJIEtZA6E6t7X/g5IK6SK2emqULcluGJMALPVCq6gMiQ2To1JnOnkT/
	 yW6m1aimWyrCmokUHMJChEfXmqT4fTni6TQQm4NP0a98uk47zDex8iXOCXAJ1XqTlP
	 JsIpiaTiVtKzw==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0B5703782098;
	Fri,  2 Feb 2024 20:15:48 +0000 (UTC)
Date: Fri, 2 Feb 2024 15:15:46 -0500
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Mike Isely <isely@pobox.com>,
	Tiffany Lin <tiffany.lin@mediatek.com>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 3/3] media: mediatek: vcodedc: Fix
 Wcast-function-type-strict warnings
Message-ID: <12d0c580-788d-4466-af8a-feb5ab3c6677@notapiano>
References: <20240128-fix-clang-warnings-v1-0-1d946013a421@chromium.org>
 <20240128-fix-clang-warnings-v1-3-1d946013a421@chromium.org>
 <20240201221654.GC2240065@dev-arch.thelio-3990X>
 <CABCJKudd3SUy3Qor7Tc0zyJsSAWy0PavbbBFALuWEpBa32pBCQ@mail.gmail.com>
 <5658ec37-868f-454d-a149-467e6de139cd@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5658ec37-868f-454d-a149-467e6de139cd@collabora.com>

On Fri, Feb 02, 2024 at 01:58:05PM +0100, AngeloGioacchino Del Regno wrote:
> Il 01/02/24 23:25, Sami Tolvanen ha scritto:
> > On Thu, Feb 1, 2024 at 10:17 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > > 
> > > On Sun, Jan 28, 2024 at 02:12:22AM +0000, Ricardo Ribalda wrote:
> > > > Building with LLVM=1 throws the following warning:
> > > > drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c:38:32: warning: cast from 'mtk_vcodec_ipi_handler' (aka 'void (*)(void *, unsigned int, void *)') to 'ipi_handler_t' (aka 'void (*)(const void *, unsigned int, void *)') converts to incompatible function type [-Wcast-function-type-strict]
> > > > 
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > 
> > > I am not positive because I don't have any hardware to test this driver
> > > but I suspect this patch is just hiding the warning without actually
> > > addressing the issue that it is pointing out.
> > 
> > Agreed, this won't fix the issue. The correct solution is to drop the
> > cast and change the handler type to match the pointer type (i.e. use
> > const void* for the first argument).
> > 
> 
> Even though I agree that the correct solution is to change the handler's type,
> I think that having a test on the actual hardware done is still valuable.
> 
> We scheduled a job on KernelCI to test this commit on our integration kernel,
> you'll get results for ChromeOS' tast decoders (MT8195 only) and Fluster tests
> on MT8183/8186/8192/8195.
> 
> 
> The results should be available in a couple of hours here, relative to
> commit `49955a84129dbe1f94fedf729690efcf28513828` on our tree:
> https://chromeos.kernelci.org/job/collabora-chromeos-kernel/branch/for-kernelci/
> 
> P.S.: If they don't, feel free to ping me or Nicolas (added to the loop) about it.

Hi,

the results are available at 

https://chromeos.kernelci.org/test/job/collabora-chromeos-kernel/branch/for-kernelci/kernel/v6.8-rc2-3109-g49955a84129d/

(You need to type "decoder" into the search bar to limit the results to only the
decoder tests)

The only regressions I see are due to infrastructure error or broken test
unrelated to this change (v4l2-decoder-conformance-h264-frext test on
MT8195-Tomato, and cros-tast-decoder-v4l2-sl-h264 test on MT8183-Juniper)

Otherwise, all platforms (MT8183/8186/8192/8195) and video codecs
(VP8/VP9/H264/H265/AV1) seem unaffected.

Note that these are GCC builds.

Thanks,
Nícolas

