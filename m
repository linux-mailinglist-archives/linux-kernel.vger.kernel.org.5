Return-Path: <linux-kernel+bounces-88564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C155E86E379
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3D8FB22CA8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EA63AC0C;
	Fri,  1 Mar 2024 14:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qwGrbyiD"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8052E39879;
	Fri,  1 Mar 2024 14:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709303956; cv=none; b=E1CRLb2sfGdpJ3RzeG040ejdH8sx9Oi8PBdszQd5gYaczkIYrJ10q7hQsBLQAZ4+8js658b2wkntVgNsT8QoPDz3HY2jLD6Ako2QTNF4EKZjh/6bVy6jW9vAzfbT3U+ZhufESlHgBZFk/X9J/wvupxGUm8P/gDiXd363m9h6Rqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709303956; c=relaxed/simple;
	bh=rkisMHBNxL4woYqHRgn2zX3YF+vvPbgLoCprtb5HDEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjST9BzBGZB0ba/ZhwGmnpKFE+Mf9vnD97Z0f1eLBwnLbnk02TLK1mr5FuPI80XnlJ8SnLjltLAaV0j6NHST1L5Ksx66NVmehB/PpGl4OPq3ZPBPGe3IvrmOBDwGLLhQUU+K09QKOfTAM6WySouxBvOMWufuvbpT9CD6To5UXb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qwGrbyiD; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709303952;
	bh=rkisMHBNxL4woYqHRgn2zX3YF+vvPbgLoCprtb5HDEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qwGrbyiD3HL1uxENJtlW1aR0CSg+dtCmKxfw7fKvI86HzSzTqnUVSs/Gu2QrD4FAa
	 f14OdmNBFA9sMQfzEHVbEh7XAtGJgKW9aqiSSR4yPEkFzgszcLTsY/MdKXqcJDl5Va
	 VSP05hlU0O1sP0OWD+RAGXHS3DKe8d2m4YMmgtjLNIM6Qkkp5JKHhe5YYr4hRwJE4S
	 7G76+xf+JhIJ+F93lcOCU1DcdotbJmBLmt0nlPbUr1QScpN7rGUtJn1jal4WdpiLDM
	 XG5WQkxTcA5diXb0YCdG7SvxUoF3m+HqsG9CDYaeTUl4npVtbtFnzdclY1dCSpwZoE
	 9oZBxUyxrEAfQ==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 14B0437803EE;
	Fri,  1 Mar 2024 14:39:09 +0000 (UTC)
Date: Fri, 1 Mar 2024 09:39:07 -0500
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
	Tinghan Shen <tinghan.shen@mediatek.com>,
	"Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
	"Nancy.Lin" <nancy.lin@mediatek.com>, kernel@collabora.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/4] arm64: dts: mediatek: mt8195: Add missing
 gce-client-reg to vpp/vdosys
Message-ID: <40ae06f4-0cbe-40f0-84c8-9b57dfbeb91f@notapiano>
References: <20240229-gce-client-reg-add-missing-mt8192-95-v1-0-b12c233a8a33@collabora.com>
 <20240229-gce-client-reg-add-missing-mt8192-95-v1-2-b12c233a8a33@collabora.com>
 <22e2cf1b-9560-4f4b-b08b-a112e8e272a8@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22e2cf1b-9560-4f4b-b08b-a112e8e272a8@collabora.com>

On Fri, Mar 01, 2024 at 09:50:31AM +0100, AngeloGioacchino Del Regno wrote:
> Il 29/02/24 20:44, Nícolas F. R. A. Prado ha scritto:
> > Add the missing mediatek,gce-client-reg property to the vppsys and
> > vdosys nodes to allow them to use the GCE. This prevents the "can't
> > parse gce-client-reg property" error from being printed and should
> > result in better performance.
> > 
> > Fixes: 6aa5b46d1755 ("arm64: dts: mt8195: Add vdosys and vppsys clock nodes")
> > Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> Can you please squash patches 2,3,4 in a single one?
> 
> It doesn't make a lot of sense to have them separated in this case, only
> generates commit noise for no practical reason imo.
> 
> arm64: dts: mediatek: mt8195: Add missing gce-client-reg to vpp/vdo/mutex

I split them like this so that each has its own fixes tag and can all be easily
backported (as mentioned in the cover letter). That said, the commits fixed in 2
and 3 both landed in v6.1-rc1, so they could be squashed and still easily
backported. But the commit fixed in patch 4 only landed in v6.4-rc1, so if we
squash them all together, the first two won't be backported to v6.1.

Let me know how you want to proceed.

Thanks,
Nícolas

