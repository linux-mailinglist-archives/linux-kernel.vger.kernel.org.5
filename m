Return-Path: <linux-kernel+bounces-94372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5135C873E3A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64EE91C216E2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDE714263A;
	Wed,  6 Mar 2024 18:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="cXQsFGba";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="iAXWNih9"
Received: from fallback20.i.mail.ru (fallback20.i.mail.ru [79.137.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF845CDE2;
	Wed,  6 Mar 2024 18:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709748258; cv=none; b=SLdaZl3N91HNxkbNDhbR/YGh+40WTq3PHWaOuuGA8c1jI923JP0UBkjEc6d8ZddZEoKTDJpR8NEDQAmBaqPKD7Ugomwa+aaNx7NOjwPwW2logayO/pdsUQIE2nv58bYEWeQzRc3E/cBdwJmG2sekla/aQFJW5E4OyoZEgwkWhrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709748258; c=relaxed/simple;
	bh=1XM6zSKx8QxYG4iaQLbgEtAjXMdIsmBn9KOjIiBlaHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H4RucpTjVFl74oCpAsLrVoVkn6ga1C8f6Ducdv3aVK9MIXohS+0yna8Pmi2kdQmbr6uCjsNSdrKQS4gHorgrqql/7eE42BZMHsy/b6fSg/DP9ZU/W5FO2PwygKzzixFRkMxsaa6AjRhiE73dkWxPyNI3dTZNIW3JGQQkFidG7mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=cXQsFGba; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=iAXWNih9; arc=none smtp.client-ip=79.137.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=VqtGmFubmMdx/QuIH83X3k2GawclvWnYOe3ClUecCvA=;
	t=1709748255;x=1709838255; 
	b=cXQsFGbashTGdi0+8d0dajSTZ/kQosotB0TfC+A5M7Jv2+k3abrjR83U6MkjKHB1dAapG88nwvcCCKovWp0playN9HdQ0gODMindL97Fs1mYOJP3Jg4UzvZARB4NyHg7vtBQX/wq7nhRzdvc71jNZaLHZlzr/SR05zQo9wvcfcw=;
Received: from [10.12.4.36] (port=37770 helo=smtp59.i.mail.ru)
	by fallback20.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1rhv3E-003q5j-3k; Wed, 06 Mar 2024 20:27:32 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=VqtGmFubmMdx/QuIH83X3k2GawclvWnYOe3ClUecCvA=; t=1709746052; x=1709836052; 
	b=iAXWNih9gUjONAz0FQ4Ah86NbAy8qpOQaPtsWCEqAqRK6QvozsW2U+EHV2YVbMoVcsaOwCHVGME
	ujkvCrCvDEhehbNxOVoz5J98W2jvtccOgFp8tEJY7J67K7DWQjk8XOp7NiTt7QxoWptXbMQWrHD9p
	ByiQJ7kRpOdnhlFcSdQ=;
Received: by smtp59.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rhv2v-0000000F1Va-1dz2; Wed, 06 Mar 2024 20:27:14 +0300
From: Danila Tikhonov <danila@jiaxyga.com>
To: pavel@ucw.cz,
	lee@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	konrad.dybcio@linaro.org
Cc: linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 0/2] Add LPG/PWM support for PM6150L PMIC
Date: Wed,  6 Mar 2024 20:27:08 +0300
Message-ID: <20240306172710.59780-1-danila@jiaxyga.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD987C0EE6E7F0A597D21AFE2E000C69B1FB60C465D22E5E337182A05F53808504049F0544BE37C111F411046492FDDF80652244347E8A8460C8FCBEF1FD3BB67B11AD6A186BD11839C
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE79145AB6E9E75F07EEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637FF37B1FF54E2C7C48638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D897F4AA6A8CCC14A3F5F3F533CCBC407AE9949CC6CDFBED31CC7F00164DA146DAFE8445B8C89999728AA50765F7900637DCE3DBD6F8E38AFD389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8062BEEFFB5F8EA3EF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CDA7BFA4571439BB2AD7EC71F1DB884274AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C30F1327A8DDF03E57BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF17B107DEF921CE791DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C30E7A8B1B1FD51AB935872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A54DB3675F4747B4005002B1117B3ED6961C1A280A149093B0E99897350C7C491E823CB91A9FED034534781492E4B8EEAD4ADCFBF7921B375DC79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFD6E5FA0672843F7182F7520D73D3C94650883FCD0B965DB77379BE37D308936A669E50AE97022433A2A143A52978B9DDB47F12560EE94F35C777010AFA8312B64183ED9D5400F72F42BF32D1DA1046D202C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj9auBsoWJeY+uU6a7Ba86tQ==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C73949814E2244C9C55FE2176750B362712FA5BDF3C6304B9C750CE3BA2E80206BB77BB22C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B485448333635D8AFAF2FD4A3C9FF394F50FA50637E8B29678049FFFDB7839CE9ED2C2511FF248D2A2666371CEF2DF2FEAE9EB77E8478749A5DBDC8F043DCD8110
X-7FA49CB5: 0D63561A33F958A560416A7FD8E464987212A3635F6E9486F73BFADD419A7AD48941B15DA834481FA18204E546F3947CAC84B7EF345C8436117882F4460429724CE54428C33FAD30A8DF7F3B2552694AC26CFBAC0749D213D2E47CDBA5A9658378DA827A17800CE7B687D752F9FE62218941B15DA834481F9449624AB7ADAF3735872C767BF85DA227C277FBC8AE2E8BFC70575558BC73B275ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj9auBsoWJeY9tcyz8zQLd0g==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

This series adds LPG/PWM support for PM6150L. Was tested on SM7150
(xiaomi-surya).

To: Pavel Machek <pavel@ucw.cz>
To: Lee Jones <lee@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-leds@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>

Danila Tikhonov (2):
  dt-bindings: leds: qcom-lpg: Document PM6150L compatible
  arm64: dts: qcom: pm6150l: add Light Pulse Generator device node

 .../devicetree/bindings/leds/leds-qcom-lpg.yaml        |  4 ++++
 arch/arm64/boot/dts/qcom/pm6150l.dtsi                  | 10 ++++++++++
 2 files changed, 14 insertions(+)

-- 
2.44.0


