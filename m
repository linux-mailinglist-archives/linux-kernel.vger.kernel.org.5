Return-Path: <linux-kernel+bounces-52851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C8F849D6B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5BD1F2444F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83242C68C;
	Mon,  5 Feb 2024 14:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="v2iTjAGZ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CFC2C848;
	Mon,  5 Feb 2024 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707144808; cv=none; b=dSYIuSOPgofA1q+uaX6sgABloiKeqSBtMBB4jj4DlVyFlmWz4431L2DKDs9zaVq9aKyRQNCcRnXoSrLiTagaxELw0W7zpFsdQBEjL8If2Q94JV9TISpLI+vJGEjKDuWZjeOj0/52TxOSr3AA4cJ7cSLoUeR4llzVTPiMBCDvAkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707144808; c=relaxed/simple;
	bh=N5S3QB/YuiwuK74Hpcl5CcJl2TR2YgDRJk+uYMrvNzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdUrzG1PJ3hnWBkfpbbj2v+Vhb5FxfpuJ3du/pgpnO/gZw2kPqxNhO2wDvQhrom6wQwA/U1AXmoCyWr4hudCWC8ysl4ECBo+m2L4i2VwrSb9tWEJigbqgxMqNtow0+6Z4bv7alyMvETV84U98WjHVe7LsqGVR+tcMs1AfbDG468=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=v2iTjAGZ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707144804;
	bh=N5S3QB/YuiwuK74Hpcl5CcJl2TR2YgDRJk+uYMrvNzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v2iTjAGZGi/MpVLUpKPYp/8SRERGhHVyqe3ElC4kyxXzzrPfiPxjPRcAEpJL5vPHU
	 PnjvCeAtUxwFEStbT4Hdgc7f0Jw/6C5XvNxK80Vjdgw49pvPMtpPnD2wPjEH64i6oo
	 o4tGCMav+ms1zfmGy81weTr5FTcicH+nR5IbXOsrGuQAkLHCwoN6af4E9wlB1VfTAu
	 pkSK5se92JKH66V7bMkmlwoUUBbLu/y5Eggh3sIseTlNEkfBuHLTnMXembqsnr5T1E
	 HB4OWzJCN2JicnG2x1eIJgUJBPo2keCn9/nFd5fXRPV/G1ugUDLTy2fobGgmHmSsRt
	 oF1tyzf0z2Bkg==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3C7B537811CD;
	Mon,  5 Feb 2024 14:53:21 +0000 (UTC)
Date: Mon, 5 Feb 2024 09:53:19 -0500
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sami Tolvanen <samitolvanen@google.com>,
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
Message-ID: <e75a0207-1f95-427c-8d72-e6a86505522e@notapiano>
References: <20240128-fix-clang-warnings-v1-0-1d946013a421@chromium.org>
 <20240128-fix-clang-warnings-v1-3-1d946013a421@chromium.org>
 <20240201221654.GC2240065@dev-arch.thelio-3990X>
 <CABCJKudd3SUy3Qor7Tc0zyJsSAWy0PavbbBFALuWEpBa32pBCQ@mail.gmail.com>
 <5658ec37-868f-454d-a149-467e6de139cd@collabora.com>
 <12d0c580-788d-4466-af8a-feb5ab3c6677@notapiano>
 <20240204205549.GA2892810@dev-fedora.aadp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240204205549.GA2892810@dev-fedora.aadp>

On Sun, Feb 04, 2024 at 01:55:49PM -0700, Nathan Chancellor wrote:
> On Fri, Feb 02, 2024 at 03:15:46PM -0500, Nícolas F. R. A. Prado wrote:
> > On Fri, Feb 02, 2024 at 01:58:05PM +0100, AngeloGioacchino Del Regno wrote:
> > > Il 01/02/24 23:25, Sami Tolvanen ha scritto:
> > > > On Thu, Feb 1, 2024 at 10:17 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > > > > 
> > > > > On Sun, Jan 28, 2024 at 02:12:22AM +0000, Ricardo Ribalda wrote:
> > > > > > Building with LLVM=1 throws the following warning:
> > > > > > drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c:38:32: warning: cast from 'mtk_vcodec_ipi_handler' (aka 'void (*)(void *, unsigned int, void *)') to 'ipi_handler_t' (aka 'void (*)(const void *, unsigned int, void *)') converts to incompatible function type [-Wcast-function-type-strict]
> > > > > > 
> > > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > 
> > > > > I am not positive because I don't have any hardware to test this driver
> > > > > but I suspect this patch is just hiding the warning without actually
> > > > > addressing the issue that it is pointing out.
> > > > 
> > > > Agreed, this won't fix the issue. The correct solution is to drop the
> > > > cast and change the handler type to match the pointer type (i.e. use
> > > > const void* for the first argument).
> > > > 
> > > 
> > > Even though I agree that the correct solution is to change the handler's type,
> > > I think that having a test on the actual hardware done is still valuable.
> > > 
> > > We scheduled a job on KernelCI to test this commit on our integration kernel,
> > > you'll get results for ChromeOS' tast decoders (MT8195 only) and Fluster tests
> > > on MT8183/8186/8192/8195.
> > > 
> > > 
> > > The results should be available in a couple of hours here, relative to
> > > commit `49955a84129dbe1f94fedf729690efcf28513828` on our tree:
> > > https://chromeos.kernelci.org/job/collabora-chromeos-kernel/branch/for-kernelci/
> > > 
> > > P.S.: If they don't, feel free to ping me or Nicolas (added to the loop) about it.
> > 
> > Hi,
> > 
> > the results are available at 
> > 
> > https://chromeos.kernelci.org/test/job/collabora-chromeos-kernel/branch/for-kernelci/kernel/v6.8-rc2-3109-g49955a84129d/
> > 
> > (You need to type "decoder" into the search bar to limit the results to only the
> > decoder tests)
> > 
> > The only regressions I see are due to infrastructure error or broken test
> > unrelated to this change (v4l2-decoder-conformance-h264-frext test on
> > MT8195-Tomato, and cros-tast-decoder-v4l2-sl-h264 test on MT8183-Juniper)
> > 
> > Otherwise, all platforms (MT8183/8186/8192/8195) and video codecs
> > (VP8/VP9/H264/H265/AV1) seem unaffected.
> > 
> > Note that these are GCC builds.
> 
> Thank you for running the tests to make sure this series does not
> regress anything. If possible, it would be good to try and build with
> LLVM and enable kernel Control Flow Integrity (kCFI, CONFIG_CFI_CLANG)
> to see if my theory that this is currently broken is correct. I have
> prebuilt LLVM toolchains on kernel.org but if it is too much of a
> hassle, I would not worry about it.

We don't have a way in KernelCI to run a one-off test, instead we need to make a
PR adding a build definition that will be triggered for every update on a given
tree. The results I reported above were for configurations that we already had
in place.

That said, maybe we should be running with LLVM and CONFIG_CFI_CLANG enabled on
a regular basis, if you think it is useful as a general tool for identifying
issues. I'd also be interested in hearing more from you on what other kind of
clang configs you think might be good to enable in CI to provide value to the
community.

Thanks,
Nícolas

