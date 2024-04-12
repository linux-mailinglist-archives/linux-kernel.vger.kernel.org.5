Return-Path: <linux-kernel+bounces-143211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E40708A35CC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09D251C23DED
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CE514E2DA;
	Fri, 12 Apr 2024 18:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Rx0XvPtV"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F21A18B09;
	Fri, 12 Apr 2024 18:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712946914; cv=none; b=beeCDv0Tum0hWc6+cjanTPHVNxBO24feOwOfMF4MLjkd495wuP8CpgpfZYouWfM29dzYhYGhFCGqnjKJ1H1P3b0NySaWHH+C9HZjX6uCX4/vTdfi5p3B/Y93JBuUfHEeMjOnj1k4bLQEWODPq2KsiOo5ogW0AMy5qQ0QVdA+QeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712946914; c=relaxed/simple;
	bh=c7l1MXD6dpbxN4XtNjV/DW5Fsb48MJvPk6BEdWqTfuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jXl2Ll/nmbMEOrSKqxzzBcYZ/d5yQzRwiGLitAfMdCP7PlSUciNMbBt5VWPXzpTFVB7Rj+wA3eg3FE/T7r+EOG8QAG0tgarTA0z+e2HiAXrtmc01lwstqmf1ggpa1sfS9bRpr+pR1MNBl0/I50QSzGPCq/ecKcWRofUe8ka8Kpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Rx0XvPtV; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 08D2087C75;
	Fri, 12 Apr 2024 20:35:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1712946910;
	bh=67Jf9ullWfZC2rEqSESZjk0MezYd/cTr0DLtM3VDZVk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Rx0XvPtVOjA5G4T2GXhO7yzWc6etrue/bKb+h7gjJfNMsBF5TnfCZg+rmcgdw2lQf
	 o+Zg2YVdrZqP8bdrnsnEAPA7enh6zdL8oWoevGH6HFzAsAw6Xo9CQX/bKyJmiMDC8l
	 LTqFp8XAG4TYE/GKGbzSwmzHgNg+csgLN4KwyAmBj7g2qfHpCljZpU4pjvLdBUGmoO
	 Z23HjT7UYMBKB7/4qx8UYgKwDkey5Npg2pi79YuvCRx3rb3jRFwAuFYXqbocwedLd8
	 K7aLRUjzhH2iYmeFRo8fDFi0frgyn79SA6jaFAcE/Cp3y5RejjpvgY/nDBZXYmrW5b
	 73Y8RQd1XBCGg==
Message-ID: <d55fce26-a96e-4653-a463-a277e232ed48@denx.de>
Date: Fri, 12 Apr 2024 20:35:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] clk: rs9: fix wrong default value for clock
 amplitude
To: Stephen Boyd <sboyd@kernel.org>,
 Catalin Popescu <catalin.popescu@leica-geosystems.com>,
 mturquette@baylibre.com, Biju Das <biju.das.jz@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 bsp-development.geo@leica-geosystems.com, m.felsch@pengutronix.de
References: <20240306180435.1033052-1-catalin.popescu@leica-geosystems.com>
 <a5595ba92a3d65a222398824b09d7d37.sboyd@kernel.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <a5595ba92a3d65a222398824b09d7d37.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 4/9/24 10:19 AM, Stephen Boyd wrote:
> Quoting Catalin Popescu (2024-03-06 10:04:35)
>> According to 9FGV0241 & 9FGV0441 datasheets

9FGV0841 too.

>, the default value
>> for the clock amplitude is 0.8V, while the driver was assuming
>> 0.7V.

Can you also document the SCC spread spectrum change in the commit message ?

>> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>

This also needs
Fixes: 892e0ddea1aa ("clk: rs9: Add Renesas 9-series PCIe clock 
generator driver")

Thanks ! Sorry for the delayed reply.

