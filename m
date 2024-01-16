Return-Path: <linux-kernel+bounces-27559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C02182F222
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A87F1F247EC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502DF1C69A;
	Tue, 16 Jan 2024 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="jHJ4XdzE"
Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE14C1C294;
	Tue, 16 Jan 2024 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
	s=dhelectronicscom; t=1705420776;
	bh=EK7VBFYYbMk8kVgMxZTPj1kGRPSKxlDAK/5fbH1kX1c=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=jHJ4XdzEPAClJe0sDxzOefJFMXvpEQASvespCnWnasQdHKgEibs52ExZl0ym+I8Dh
	 ES8VaUMg2zxhJ437cZcLgnbZAkzgVOdjpFGovezFvsy2B/bBXbVQqYypqk7l9Qji8z
	 gvIN+UkMy4fQoq8BQXJn0TUE/WaH79VyQjP2RTUTKnIVrabtF8O5Y5B8NTD45MaLgQ
	 KeWv6bqz0rehkQOE++mUgFGnSxxwlElYd5e/NXOOJ9pPjIfT+DF2Jr7V3qppyyKMgQ
	 NIuQkc+UXOJ+gOQzpN3M64l9+JZ9/u/wxdH+G0sCvNddFpW0xiyFq1uLev8C9vPzRi
	 x/4ahyBohQWCA==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <crescentcy.hsieh@moxa.com>
CC: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<cniedermaier@dh-electronics.com>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 1/2] tty: serial: Cleanup the bit shift with macro
Date: Tue, 16 Jan 2024 16:58:29 +0100
Message-ID: <20231201071554.258607-2-crescentcy.hsieh@moxa.com>
X-klartext: yes
In-Reply-To: <20231201071554.258607-2-crescentcy.hsieh@moxa.com>
References: <20231201071554.258607-2-crescentcy.hsieh@moxa.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

In the old definition (1 << 3) wasn't used.

> -#define SER_RS485_RX_DURING_TX		(1 << 4)
> -#define SER_RS485_TERMINATE_BUS		(1 << 5)
> -#define SER_RS485_ADDRB			(1 << 6)
> -#define SER_RS485_ADDR_RECV		(1 << 7)
> -#define SER_RS485_ADDR_DEST		(1 << 8)
> +#define SER_RS485_ENABLED		_BITUL(0)
> +#define SER_RS485_RTS_ON_SEND		_BITUL(1)
> +#define SER_RS485_RTS_AFTER_SEND	_BITUL(2)
> +#define SER_RS485_RX_DURING_TX		_BITUL(3)

Isn't it a break if number 3 isn't skipped here as well?

Regards
Christoph

