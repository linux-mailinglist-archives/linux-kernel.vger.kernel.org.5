Return-Path: <linux-kernel+bounces-146726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 060328A69EF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61D12834BB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA99129E70;
	Tue, 16 Apr 2024 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="GzkmVhX3"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7C7127B4E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 11:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713268232; cv=none; b=i4wrJIj34WCvQT0oOEjPVqEq302TfUq/2ZY++h5rbNMzuYzGjDqdg796uxPBq6F2Dp5fnMusm2jCXxM6bp8TSzU8UQx7yssDeOHC6FWyXqbWGISED3RwaTAcTlGsAbxgMLew0QfKx80mcf8TGoEYauzHup19+uKlXmClhZCgXj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713268232; c=relaxed/simple;
	bh=z6yCp8A2RnLDBkLpXNPwXaq/ZW8mMLmH/UyxYRY5y5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TKIpRSWE8XYO0gZzrNGdTaez+lPV3YU+9yF2FMA+xR6hIBLFwZuIpY3vwWBlTFl7beedDbr/pu7tDev+cK9zRh3yv1lFz/hc9b2TH5lE+ZJvYnnAO+w2xACGe1Th+6oEssG0jCC7CvATab6LXnE1Ds7h+LDgZSXDx9o/VQhJciA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=GzkmVhX3; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713268222; x=1713873022; i=markus.elfring@web.de;
	bh=z6yCp8A2RnLDBkLpXNPwXaq/ZW8mMLmH/UyxYRY5y5o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GzkmVhX3uhJHoqwJCF8XTrDcUimnut9xdxj2AlqD9ZK7PwkTlSlEVvdGIXPdmxTY
	 H/sXe4XsPFSPiBq7A5f/kLGqJlNQegWq2rFFZfFrDJHfnwZZextihTv3IZMsFvvq5
	 wHtXb2SlJdQ+Wq+aA+kJq8vHhjsINChRnvRAMNqMPuy5QEdb3mnNEBq2XFHdPbCyy
	 wU5+iG3Z8Sz/fiQMXSkqfpJA6jH1+S4WB/GJ8YhR6i1ufvDRN7sktToIazuH0DIzF
	 JxnTp5WrXYmxGH03dM8sg7Cu/g9Zc8cDt0YN3aJvHp4iKjRSoygr/eAPeCcwZUCxt
	 DjklRVhxEaEjQ9qeuA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M3Eut-1rtfzH1vPZ-003Ku4; Tue, 16
 Apr 2024 13:50:22 +0200
Message-ID: <60df00eb-41ca-417f-8b8b-90dba6eaaf65@web.de>
Date: Tue, 16 Apr 2024 13:50:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coccinelle: misc: minmax: Suppress reports for err
 returns
To: Ricardo Ribalda <ribalda@chromium.org>,
 Julia Lawall <Julia.Lawall@inria.fr>, cocci@inria.fr
Cc: LKML <linux-kernel@vger.kernel.org>, Denis Efremov <efremov@linux.com>,
 Nicolas Palix <nicolas.palix@imag.fr>
References: <20240415-minimax-v1-1-5feb20d66a79@chromium.org>
 <fbf22b53-7b68-4e60-99c7-ab38a77a53c8@web.de>
 <CANiDSCuvXvjfhw2mjSef1wR8RiL=9KrDEoh+3o1ed4+8P+AqGw@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CANiDSCuvXvjfhw2mjSef1wR8RiL=9KrDEoh+3o1ed4+8P+AqGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:erpsgFEDzw3lU2+TiQWtHiU0faieFL+3p022YHoNrdra8FXwoCM
 OE0z2LsY7kfeawiB8EsNyrHF3rtmFua9waEdXv45XloHRdxLsk1xBDAT3bD63VHoJrxNdr7
 iO4CGFnuxIKxx/J4itXVpXvPlfyUpkFLk7spsPbRJ6d+F4BmrQLi3FBKwXI8fLaLvujhEUK
 fDAG95jXl6ZZd9MlSPbKQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YPpAdII74q0=;7Yw/E+JgPK1W6ly78FwvzfQVjWO
 oVjtCdY+0oBjOEDSWHAdKGIlGEB8j0r/BHQ3pOXTb1u4pZGmhLKtTqmCPLcbP0R1cDVES527p
 W+9Mv3OySq/yF+FanhB0As8WQTMfeUwqhOvf5UWPYF8iNvr40CI2FlZOZ5nb6uXxYsf2pv62i
 CXXhC8Q2dymv95mt5dKOvnT85h75g0MCqpvdLKxu6zFFS7ssO8yHd9Q6oVx4lgLDHq1rbbu4h
 TFpzN/1A7DifFPw1Os1ejlcsTi+XUGU32AbYXkgz7SrMflncb+gnXGxOlDXpiOswGTywB2R/8
 0giLhLS8wCgWn24YQtbEPpZaddTV+jmGNH8TOnpwYXP7OxTEhNaLy+hI6SVK8eUBMaO3QXG9j
 FRBYs3EAkEnyOQQMl4nm544kznz7LMoPNItu78wqtT7ZCoKCLZ3ah+/iuDtkC914RDvrUmX9m
 NpOEwFoz7B4F7kqSwQ3r+xYtq6updkBbTjCzDvXSUtu33CLkZrxLPC9guiBV982iu3Ay9GwGt
 65rT4Dz2kVZPAVLYJoA+8NYXp0UBE02IOuj3c44+X8o55luPL3PDXzFmCxbDGtzeMxL3Xbt1p
 h6U3jco27mQD0GwZuxovsKJHMTdqkcUQtvXcWIrbzyFH5hxBzk+hkpiGP2HkBOsyYRa8prL8G
 +CixP8GTnMD2A8bw5/qCFxbkdGIPJZa2GASStPckFzP1L856ouDNFYmHsfybSba0C+oiwnEUz
 Hk7a+kNpfRnmsz/DjbooDO3Wpz/8qNTdcaCYLX+7Kdy9SsH55W6uEaJy4MJsMz8yBEqbD4D9F
 FDqw9LdZOb82XAw3zakC/bntC4p8UHhyGpuMIONvIxvrE=

> I think errcode needs to be executed in report and in patch mode,

Adjustments for functionality of coccicheck operation modes can be clarified further.


> but there might be a better way to do it.

Corresponding design options depend on varying development efforts and resources.

Regards,
Markus

