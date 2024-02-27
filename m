Return-Path: <linux-kernel+bounces-83772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A66D6869E87
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35178B23159
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C504EB45;
	Tue, 27 Feb 2024 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Hb7BBLUO"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B84D4E1CE;
	Tue, 27 Feb 2024 17:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056356; cv=none; b=gmw1D7UVFf7gTHXQzUcTM48x4IUuMrpJuKD27sJGYUGoMATbA7cgRdKsNPwaaYYflp7lxp9Wzdb6KImJI4wgcp+qJDZ8Q2ba+pn1yQ6epnrcXzqLlFQwMXRIvWExdHV8wqSjPvdKI1XETXpZgd1ZnkSWFtKUV+gOvlXNSLzJHlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056356; c=relaxed/simple;
	bh=z6Srg+Vh46wEIB5dHoHRTrSg7iyoYuRE0sA4Shr/40g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5bXN9pM5GQYGcXWWtJGYOkdyVzUMiTsenEzrQRgnpMI/KV7fHmq+L0oAkO2p52lnmDCHWQNEaL8BtKbmFlYkqmUWbn4H+vgpUUjBM31XZ475tSypyJy1yJ6iq2gZ5BudYkIP667RL70Wxrzg+Cripk4sYOLP+NYdk91OBvSaHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Hb7BBLUO; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 2CEE6214FB;
	Tue, 27 Feb 2024 18:52:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1709056344;
	bh=z6Srg+Vh46wEIB5dHoHRTrSg7iyoYuRE0sA4Shr/40g=; h=From:To:Subject;
	b=Hb7BBLUOOdkNBts7HjwLNM+P67T14SZBkaZ8/Ih8bk87WMhHzBfitFq79il1qaPBm
	 jnqjrlaLcLjG24nYxkab+x8N0Cjy29m2TJgfQQckbzcK3yBKJxB2CQGGB9VQo/28um
	 rf8YFmLqnErMCOp4dXSt4Om+QuRrl2EnhRzOUGfKJSQqaLtvpcT3ZtCbcJdaC22huc
	 guo7LkRrM3aF916DIdmQJf9pYIT3EPPOQz3WSOFZbncaDzaMUvBOD8VCSCKFNIxLM1
	 9usLOWxa33OmRBJ5DdmT1xYwWaMUVno31LpeGudu2MripQTsWYQQ6dauQsPIC/EOaD
	 iD2VM267FvsPA==
Date: Tue, 27 Feb 2024 18:52:19 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, kvalo@kernel.org, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com
Subject: Re: [PATCH v8 0/2]  wifi: mwifiex: add code to support host mlme
Message-ID: <20240227175219.GA11034@francesco-nb>
References: <20231222032123.1036277-1-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222032123.1036277-1-yu-hao.lin@nxp.com>

On Fri, Dec 22, 2023 at 11:21:21AM +0800, David Lin wrote:
> This series add host based MLME support to the mwifiex driver, this
> enables WPA3 support in both client and AP mode.
> To enable WPA3, a firmware with corresponding V2 Key API support is
> required.
> The feature is currently only enabled on NXP IW416 (SD8978), and it
> was internally validated by the NXP QA team. Other NXP Wi-Fi chips
> supported in current mwifiex are not affected by this change.

I did test this series with 88W8997, using SDIO interface, 16.68.1.p197
firmware. Host MLME is disabled in this specific combination, I just
wanted to verify that no obvious regression was introduced, and I was
not able to see any difference in behavior nor in performances.

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com> # 88W8997-SD

Francesco



