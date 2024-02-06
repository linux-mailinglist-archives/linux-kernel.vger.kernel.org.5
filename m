Return-Path: <linux-kernel+bounces-54577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F80C84B0F7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02922B23E0D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4D812D164;
	Tue,  6 Feb 2024 09:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pXgSMjur"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B94612D143;
	Tue,  6 Feb 2024 09:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707211284; cv=none; b=Lg/mknpggZDIqgR80spIypJTX+88RqlgdRRHf5nZrQp1dApGOW3QW0FqdTFUl6OYEzTwSg8uPgc53N0meh0q29CIPDxbsMHdMVC5M/JNOOO4Y8RZ0AE9zDPPn9RhAVz44WKaytXtyArfMwNm7hxNieGxk4f/khuDgIsj9X2kh9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707211284; c=relaxed/simple;
	bh=GhYT5UYlUwjUnGnJLzVb+yqrzxe5xuH4W1+Hl/X1RiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TQCWviF1Q/jGogkMHJq9DyG6PhV31FpAcfx5k3BeSIIn4Em+AAmI2XEUbNV8TU1eJa480H3JT22oTifJOI/8uW2ThJmxkvO5amFrkWFM7nar0LB3EOULW4sBIr7y7h7ome1ASVgbfLUfXy9RB4oi/SYbj10qv9ywus6X/3R8O+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pXgSMjur; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707211281;
	bh=GhYT5UYlUwjUnGnJLzVb+yqrzxe5xuH4W1+Hl/X1RiU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pXgSMjurtDcRf712AK1hGeRPnaZ2p6F7eDXIU+By9gziz97HzEwFq2dt6stJnT21i
	 ysEFrzEOLH8X4haPCHn21RwZheEaxr+as95wXW6zUpp0qL8KhcnI7UZcmXFLl5KlAQ
	 sPV4PgspK+x0cEUkKlwDZ2eQg4XlqvPQ0itfxFXdLVZVNfeAxgtiMUqKvBeLTMfM84
	 wtlw3v2tVEFqA6LTiBVTDnqC7+gEjrUN5kjF7X7kPXhgk9jRuWAXQBPYJ1Cj08cCet
	 sr9CahscikPXCEAOmT5GObaJ2I96LI6cqdpD7q+VWyrNkuD87BxbbjuuCX9hQJCVQA
	 Bfw5kj/bQl/OQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 80BC93782039;
	Tue,  6 Feb 2024 09:21:20 +0000 (UTC)
Message-ID: <bec4bde4-4800-4188-8b31-4e6d162cd80d@collabora.com>
Date: Tue, 6 Feb 2024 10:21:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spmi: pmic-arb: Replace three IS_ERR() calls by null
 pointer checks in spmi_pmic_arb_probe()
To: Markus Elfring <Markus.Elfring@web.de>, kernel-janitors@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>,
 David Collins <quic_collinsd@quicinc.com>, Fei Shao <fshao@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Peng Wu <wupeng58@huawei.com>, Stephen Boyd <sboyd@kernel.org>,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <82a0768e-95b0-4091-bdd1-14c3e893726b@web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <82a0768e-95b0-4091-bdd1-14c3e893726b@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/02/24 10:24, Markus Elfring ha scritto:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 4 Feb 2024 09:39:48 +0100
> 
> The devm_ioremap() function does not return error pointers.
> It returns NULL on error.
> This issue was detected once more also by using the Coccinelle software.
> 
> Update three checks (and corresponding error codes) for failed
> function calls accordingly.
> 
> Fixes: ffdfbafdc4f4 ("spmi: Use devm_spmi_controller_alloc()")
> Fixes: 231601cd22bd ("spmi: pmic-arb: Add support for PMIC v7")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



