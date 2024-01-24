Return-Path: <linux-kernel+bounces-37376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B3983AF08
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2C261F222F3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4436A7E76F;
	Wed, 24 Jan 2024 17:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="IwakDZfm"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5362F42A93;
	Wed, 24 Jan 2024 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115744; cv=none; b=L19osUhN+8pdbvqLtQwgKDn5KCQmUC0c1yH72gEfH+UK83uTaUE2L0m42hM3rbDPQwFfScZLFwdJWEbjGoYlYggfFFFoWOOluzY8L0GieMZ3xzBzJRZT0FyGQIdrlRfp8n7Xyc5ZkYKjyDQH5Ja48yV84kxtalPnugLRjm+lkC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115744; c=relaxed/simple;
	bh=wXHLNCaoB8c2KX+O06HEmNoziRnttpcnlBxXvtkvLog=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=UAc7OVjn6VlUCohpEHkCFNRsz0MkCN61Kbvc2RhDtTPqyAEjzALOSlzzcFHzC7fCRdD8Z/IbVe4Kba78I3fkPHU+e6M/VV/wZJHAp+EnztccPU+67OhW502lhSM0QJOwUuOLgu2G2FVWQcdgr/uzl1JNrPtXgj9gjEWArPhW/eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=IwakDZfm; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
	s=s31663417; t=1706115719; x=1706720519; i=frank-w@public-files.de;
	bh=wXHLNCaoB8c2KX+O06HEmNoziRnttpcnlBxXvtkvLog=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=IwakDZfmY7L6gQILVBuuBiQUXfanBrOXZqA0areXs4eLjTRI0dCF/O8jfs3tHQpU
	 onDsvepLbjl09x1JVyKvCr4reXMuieL9UbdewkohAaV1h4naxzHhWQ5AzxX7hfzne
	 bAXF37wwVzOGhAY3goG8RtTZaTtazmHP8BqAOtu+e9pCbxeIiq8yxQpVxoIxAife6
	 HEnpZNP8ZJdtDHFFuQhfp3wnfsfS2pW6vOVs1MhEUeBy/4J8qsLNNOzyDa6wV4KAc
	 6tLzfW+AR8c688FQ5hx/11Yt308mJhL8rRNlZMAXn1LETqo4+3GuCSSiRIYpNKQ6c
	 1FJV8IdHcC7ltQP+Vg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [80.245.72.177] ([80.245.72.177]) by web-mail.gmx.net
 (3c-app-gmx-bap04.server.lan [172.19.172.74]) (via HTTP); Wed, 24 Jan 2024
 18:01:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-08c06a61-9397-4097-9a54-9f078ac22af7-1706115719411@3c-app-gmx-bap04>
From: Frank Wunderlich <frank-w@public-files.de>
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Frank Wunderlich <linux@fw-web.de>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Sam Shih <sam.shih@mediatek.com>, Daniel Golle
 <daniel@makrotopia.org>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Aw: Re: [PATCH v2 1/2] dt-bindings: reset: mediatek: add MT7988
 LVTS reset ID
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jan 2024 18:01:59 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <0d3c2713-6da5-4e7c-8568-180df6e424d7@gmail.com>
References: <20240105162056.43266-1-linux@fw-web.de>
 <20240105162056.43266-2-linux@fw-web.de>
 <0d3c2713-6da5-4e7c-8568-180df6e424d7@gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:ulx5dIeWJcW3Za2njFFqNJJv6ciEdTUHHrCwpcD+GKtnJOHRljDlEEQe6nsrRW8zL7mfz
 BKTmCNEvNAt61YH5vlDMBmy6sMsLWiB/Wn4JYcasmQ7aYjLhtgPyNjmm5b7tslQW2ipa0Pr6KZEN
 efLPRXlqDDmqskDxqBe1J8ZY3sAhRpDe/VNNlx3LZPfotPyxTpa+R2rDb5F1mOCLl6rwRBpoJNS6
 SgVY5AofTYqcYt/lCE1x0swMDP5E4yO+HCF4TdBs27kvAuyDnPstCHt22rx5FqitmhNQrgQapFXn
 Ro=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hKFerlztyOE=;6u6ywOCU1fTGycRtlCIUyUtsGmE
 sRTAUXyl8Ro0jbY88oE1+r7+w0JokzfAu26O55bueT1Qo+aDKpLzVNQKmZh5afFmy0SjUPa/3
 WLZNB2hhpV8IGSDoeJ4nnQMpfbt7V+tx389WM1soB0wgLTo3atB5QyghOGtvC48JJvFUkaEri
 0GAFhAE/K+mSg6bGv5caLsZScVDZNOvKAtSmlW9HMHfqjVuM+ldqMr73JR0L3SGcU6+4Wedu2
 Y02ccqsDRNLQB+WfQTiN5UnbI/oc8nfmLx2EC8jmUPZ97ea0kcvlfgr9blPXrXa3BQvoaJbU2
 IMVjJSJpzJVFvgX6NYExMTw2X7KU7KTLEErfg+D5ZM21IeN4TndBq/FqSBgWngYMWRdQiyy05
 RHE2II+sHZp/XBhZSN/R7gK5pYrwqyl78s8CMSQlu1LGf+2QL+Ck7mr1TdRgV3wuvpB1dgFhG
 Lp0jg4H+NWTON9Y+F+XDI0STjp/4H85gvZA3HexzBnW9wxaZhYJjMgc3yd89TWzadD3fhuV6B
 mQ0iQkTvYYl/JANDLDr7nzv+0sLSMjIbdnTXfbGWHA+r4+nf4nq+5FBhgDokvj+IGLJZrIF3l
 G62GKoDECzTtmwfSti3jg/2e8puqkBdDR9VGzp+qInPDjozW7MB816u6cfgiA0JskEkZFBvMV
 1CSX3D6/lpyJB+vveXFK848nR+LzSahkBUKq63C5cSpLnRAaZkKH7E6InHLyOYtedP0aAUadK
 0h1P12oCpUWNWIiDHDz80zVY4xjleMrEaXuqq53aDAevXlUApv1sE+ApWQeIjJBtmBXoxG4ar
 CDv3F36VdP8r+roDldHt2/wQ==
Content-Transfer-Encoding: quoted-printable

> Gesendet: Montag, 22. Januar 2024 um 09:57 Uhr
> Von: "Matthias Brugger" <matthias.bgg@gmail.com>
> On 05/01/2024 17:20, Frank Wunderlich wrote:
> > From: Frank Wunderlich <frank-w@public-files.de>
> >
> > Add reset constant for using as index in driver and dts.
> >
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Hi

good to hear again from you Matthias. unfortunately there is already a v3 =
out,
where i added multiple reset offsets/ids. Can you please review this one?

https://patchwork.kernel.org/project/linux-mediatek/list/?series=3D817619

and i also wait for 2 other patches to be reviewed before bpi-r4 dts patch=
es can go in:

https://patchwork.kernel.org/project/linux-mediatek/patch/20231025170832.7=
8727-5-linux@fw-web.de/

regards Frank


