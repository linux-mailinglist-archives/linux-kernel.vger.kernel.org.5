Return-Path: <linux-kernel+bounces-5179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F698187A3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95498286A84
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5040E182CF;
	Tue, 19 Dec 2023 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="OEadJyxW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE81918626;
	Tue, 19 Dec 2023 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 408709C340D;
	Tue, 19 Dec 2023 07:39:26 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 2DM_gmHPgfgS; Tue, 19 Dec 2023 07:39:25 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id A897B9C3761;
	Tue, 19 Dec 2023 07:39:25 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com A897B9C3761
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702989565; bh=g/cVYBJM0mTrIDAKscMV4//RJwixI+M9CO1ECLAAVBY=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=OEadJyxWrvdK/4xa9av6EaA9Ad+dLk8TSbIH3LDxAbg4tb9ukdFRlhOSsNjrFLpqt
	 TYGJfpKM1bwsGQA+ijXaVyEnNaeY7h9WdSB4wdrvOYSOv7dKdQy+0Sw8Pi2byHNaWW
	 KzqrkSFqEeF7RwWll93BxMQOJUk+mLllzuDaXiMjiY/MiHPwq+J7iUa1JqihdFfLHQ
	 5aHcaqc1ICWs7ATd9NiE4tht3P7l9nYkFr2zVnFJYxLG7vZwad1jaSOlzsqYFcPJBe
	 7N4Jhksc1eQ0pNsWSmMEdka8YHblpN+Q96hYtiosT64LNnnbVXPnMyWtK5O2VjgVbm
	 SpxeGERv5UUvA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id yzoH3CKJ3_Pi; Tue, 19 Dec 2023 07:39:25 -0500 (EST)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 639659C340D;
	Tue, 19 Dec 2023 07:39:25 -0500 (EST)
Date: Tue, 19 Dec 2023 07:39:25 -0500 (EST)
From: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	shengjiu wang <shengjiu.wang@gmail.com>, 
	Xiubo Lee <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
	Nicolin Chen <nicoleotsuka@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	alsa-devel <alsa-devel@alsa-project.org>, 
	linuxppc-dev@lists.ozlabs.org, 
	Philip-Dylan Gleonec <philip-dylan.gleonec@savoirfairelinux.com>
Message-ID: <347346270.284192.1702989565367.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <CAEnQRZAwk-USZqXwLOVuN3iTn7r-55BJH=Sqq5+2Od+DhrK0iw@mail.gmail.com>
References: <20231218124058.2047167-1-elinor.montmasson@savoirfairelinux.com> <CAEnQRZAwk-USZqXwLOVuN3iTn7r-55BJH=Sqq5+2Od+DhrK0iw@mail.gmail.com>
Subject: Re: [PATCHv3 RESEND 00/10] ASoC: fsl-asoc-card: compatibility
 integration of a generic codec use case for use with S/PDIF controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4562 (ZimbraWebClient - GC112 (Linux)/8.8.15_GA_4570)
Thread-Topic: ASoC: fsl-asoc-card: compatibility integration of a generic codec use case for use with S/PDIF controller
Thread-Index: lu32M+7WowvRn2WxYZZGeiz9hy0xKg==

On Monday, 18 December, 2023 14:54:03, Daniel Baluta wrote
>
> > * fsl-asoc-card.txt currently follows the old dt-bindings format. 
> > Should we update it to DT schema format in this patch series 
> > before adding my new properties? 
> 
> I know this is extra-work but we would greatly appreciate if you first 
> convert fsl-asoc-card.txt 
> to yml format and then add your new properties. 

I will take some time next week to do the conversion, then I'll send
it in a v4 patch series.

Best regards,
Elinor Montmasson

