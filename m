Return-Path: <linux-kernel+bounces-29287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3FA830C29
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 008E5B25187
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F34C22EE4;
	Wed, 17 Jan 2024 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="dSrWPwok"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8796122EE7;
	Wed, 17 Jan 2024 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705513245; cv=none; b=uoUv3kSLhhuvt6DqsIYyLNDKPToBxqQXlabHDbjNV044veLoNxHQNMoE4Jej0l/Idg6drVo1WvTrCnxw2jkrsV9E9emVYoefkmJza/X4lL8Ca3kuhqoTp4CatjoNL/GfwpFI03x8vwGtuoaPCfAOhLu+rzlavrzFWV9ZHGofNuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705513245; c=relaxed/simple;
	bh=rJx1rYDQZuvD30dy0a4RC/ZegRq5ZNJx/Z0Ct+LDDC0=;
	h=DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:To:Content-Language:Cc:From:Subject:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport; b=ZetlOVuFI3fszMuH7dkxJtb+sE7odvX1JQYN+swCxf4nGaNFyBFKWAjjKNDwuhCRvh2E1VvGEy3lhZ1/KujjXkMZou1WJwiS0A/G9V2wbhuxRNH1Q+kKxAMGByCWSXITlRUF0uVUHyO+vksrgkqpTMPmcaqiz1em+Yn4RaB++8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=dSrWPwok; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1705513211; x=1706118011; i=markus.elfring@web.de;
	bh=rJx1rYDQZuvD30dy0a4RC/ZegRq5ZNJx/Z0Ct+LDDC0=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=dSrWPwokwz/d+kHIINY2V96gx2bJ9l8rgsVO1K1VocUcAL7V/hjnDFuorsk5iuF5
	 1vrNnSflKWHvSBpSuTn1Z8a3wzyuib2gEmRn1XU+jFhJp/oIYuKsLjQlaAJwSA4n4
	 aUy7evfzRvyp/rx4FXVdm9uHiX+2KoKTD90KN0uj927IYo+Q7dKrdRXdVKZw8yYEG
	 R+zXuXcuKoU8kaKWwicQDKtCdoeaDqjmf30Q1J+HS4McZeaVyQtPjenI2JBS/R16t
	 Uc8T5OcnSTLKe8YBPh4ILaOXTkYpeIoHFryHgZffp6jeU8jujLKeWtoAH7yQe1eCz
	 JH5FOheryPZBC9MJ+g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MzCA5-1rDyYr3VEB-00w7rX; Wed, 17
 Jan 2024 18:40:10 +0100
Message-ID: <061aef8b-a41f-4346-af6e-560c7594b27b@web.de>
Date: Wed, 17 Jan 2024 18:40:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-clk@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Linus Walleij <linus.walleij@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, Kunwu Chan <chentao@kylinos.cn>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/2] versatile clock: Adjustments for two function
 implementations
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C09BDWiDSxoh09TLNFQ2W3BnYJ/zwCfNfzWlMbur2e+atf4cd7v
 G/NgTSAe2930o7l0OXK+oG6yKC6SzaQkKOiz0QBzoKCb2Y6Vas9L+zQ8zuHZPSLCHh+H9SA
 FTNrJ4vRnfDfMeiwcay/eTVqY+pzq5JdWILEBNTYbcTT2uz5ZQdMJtmQxl6QswlxOkW4SIa
 HqHan20J63G3kZIt2LEqA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uJu5C1X92x4=;iMJLVQLh1hzxY4RtoP8i5QPoAZK
 S7Jk5OCfDl0Ipfkwj+/eIuRBYT/5LHWyxTDrGcJgtyweQ8DacY829mJ7lq9BX4UDhnFfXiFBn
 tTvWcewDi03wgNME1y+dLtzvuW/x6Z8KmbN7AFIdvYmvUp0ZP2AXS85SnK8kwO+aNLcb90umC
 azNcZYxQdu9uD2N40VV1RsW+d/OcsprqudRgqDWtKP6ejfQBz+bS5lAtXfgXIlDujlMpD8JrB
 bP6Vj9trSrmrAu1mXACwxKF8JAk8KtUf7XrMwQG/f/AjKM1l/iWXjEzvKb+UWM2/UREwypUYx
 qzsW5ajZdf5mm6QyD08xVLGLC0M4F8yqAn2K8JJUKuLfRRIJy2BQ9zQtG8AKXjZYlr62vUIk9
 K25MKPhohZ5l5nGljtkExUQ92tRCq56tGjcbfnYlHZoErjqs1wsMkeKSgghiD0tS8OUi+JDHa
 XYxlHfIBKWfHvS1fYUrsgxNboIR88fhFT6tJDmIc3X7Y4yRlne0A2Xzy6AsngIEWSZ/fHjrTA
 w+i3W6iP6d86pkpnOVxELW0PgMSdBKgWQ83ktxebfdJOAcMl0OwzxCH3G1BG6YgsjmfMb0Bsd
 tcV/OznMj9cpZW4M8WEUSTUBC5gFDwmqz3/T/d7BPtLw7ESdVcP7mCDANH1LgODKIxSP9bDkS
 GpFV2CLCsAaNZa5r3oIWz37OHZEHRmhjg+71IEI2/5gg8jUdDeBDJDn3ZJg1TF8CJLBDHCfqC
 ovAan16HA2zco9V/J1cVZ1rqkuKbWsZSGQpK77fbFIfkVoXsL0mjV+wOhFY2HlIq2oqCFa1gQ
 SONj+wXdhx4HwrUaYNQZM9pG7to2HtIdBeQyG+KyXnGc+5ouxbghywCJk3UFaOq5fD4Kiym+d
 hmspsjzlkkzVESp7A91NXba1+C/fraEzFH1+WAKAbilBIWJ2Rirbz1J4LSVEprQh/ZkFP96J0
 TfxEKQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 17 Jan 2024 18:30:08 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Return directly after a failed kasprintf() call in of_syscon_icst_setup(=
)
  Use common error handling code in icst_clk_setup()

 drivers/clk/versatile/clk-icst.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

=2D-
2.43.0


