Return-Path: <linux-kernel+bounces-13114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C8881FFDD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 14:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12F2F1F21B8D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 13:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0A611C9A;
	Fri, 29 Dec 2023 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="po3U1yBC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E98311C82;
	Fri, 29 Dec 2023 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 0A2DD9C330F;
	Fri, 29 Dec 2023 08:45:45 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id RDHQVC7hAZsW; Fri, 29 Dec 2023 08:45:44 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 8E1B49C3380;
	Fri, 29 Dec 2023 08:45:44 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 8E1B49C3380
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1703857544; bh=Lyk686/x2Ez5b2w7VD1NWpu9PQmISjz21nS2j3Knoo8=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=po3U1yBCDfCq7u3iTDEhMpY8CICqIY+mxPesFY9awIGMWGOZBSA/zcCmtcejahKEW
	 NxEnYNdHTH3keUrQoK5VIZddX58OzHZF1Hff7Os09Z1MeHnvX14ykUwhVJpfvaEphu
	 2xtN3k4Jbr//2Z+G7Lww8H0I944uvqDPcHqGbqwVRz4rYcmOR/C+O3cMFszFNaU/BS
	 CBGXnjsKjfYSoQysu3xVtrJmDCqOSNfRojHHrAVWVqlSXpcpAkfhfViPUEzCTNjpL2
	 ynpe8QHWMOaX0o7K/AQ+KC3XVGR9c//FwgX16u/rbZpvEm9na8cOAcv0dqSrRfDxxz
	 0b26rCZdsiuaA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id sSUMGHPKYEW5; Fri, 29 Dec 2023 08:45:44 -0500 (EST)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 515039C330F;
	Fri, 29 Dec 2023 08:45:44 -0500 (EST)
Date: Fri, 29 Dec 2023 08:45:44 -0500 (EST)
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
	linux-sound <linux-sound@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	alsa-devel <alsa-devel@alsa-project.org>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	Philip-Dylan Gleonec <philip-dylan.gleonec@savoirfairelinux.com>
Message-ID: <361044647.7067.1703857544284.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <347346270.284192.1702989565367.JavaMail.zimbra@savoirfairelinux.com>
References: <20231218124058.2047167-1-elinor.montmasson@savoirfairelinux.com> <CAEnQRZAwk-USZqXwLOVuN3iTn7r-55BJH=Sqq5+2Od+DhrK0iw@mail.gmail.com> <347346270.284192.1702989565367.JavaMail.zimbra@savoirfairelinux.com>
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
X-Mailer: Zimbra 8.8.15_GA_4581 (ZimbraWebClient - GC112 (Linux)/8.8.15_GA_4581)
Thread-Topic: ASoC: fsl-asoc-card: compatibility integration of a generic codec use case for use with S/PDIF controller
Thread-Index: lu32M+7WowvRn2WxYZZGeiz9hy0xKkRA+mdz

Hello

On Monday, 18 December, 2023 14:54:03, Daniel Baluta wrote 
> I know this is extra-work but we would greatly appreciate if you first 
> convert fsl-asoc-card.txt 
> to yml format and then add your new properties. 

DT schema must have at least one maintainer in the "maintainers" field.
Who should I put for fsl-asoc-card.yaml ?

Best regards, 
Elinor Montmasson 


