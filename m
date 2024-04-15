Return-Path: <linux-kernel+bounces-146043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365A38A5F59
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 662AD1C20E23
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07007A3F;
	Tue, 16 Apr 2024 00:38:12 +0000 (UTC)
Received: from 18.mo583.mail-out.ovh.net (18.mo583.mail-out.ovh.net [178.33.45.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C77180C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 00:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.33.45.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713227891; cv=none; b=hUeGzcizOd5a4q2yT2x303PTN6RuDUPDl2dCnf2sUdyufTwzrKBixIBKKWGPMQs37ZexTqVVr53C6qQVFx6Cw73qcpyYPWKQbnxvxv5X2ffIn6IVJfZ9/ULmlJbDDhVvWF4fvhLeW6brqmp71hfa4xpr1JMG7q24l97jFmyrSXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713227891; c=relaxed/simple;
	bh=XybDZ2MMTdcokpPlkBJhrClPjnxT/2fqLvH9KOzHy64=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sCwnVmFGxrkWSjFzR0hlXyeh+3zWwEo2McQN8g2T3+1a1N8/XH6yy4BNsmtLRZ7hcJU2EymLXemqDVG836bVTWyOPX3v8N9QBAPT7aqbnPcmJEA9T9ONNAE9X9C71TQCT8pt6ciKW1iL+6DdxZYAGaz85z/jfc+ROggDiasJLXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=etezian.org; arc=none smtp.client-ip=178.33.45.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etezian.org
Received: from director3.ghost.mail-out.ovh.net (unknown [10.109.139.198])
	by mo583.mail-out.ovh.net (Postfix) with ESMTP id 4VJKLX3GYQz1QF9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 21:00:04 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-w7sh2 (unknown [10.110.178.131])
	by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id CBAA21FE93;
	Mon, 15 Apr 2024 21:00:01 +0000 (UTC)
Received: from etezian.org ([37.59.142.106])
	by ghost-submission-6684bf9d7b-w7sh2 with ESMTPSA
	id 3/PYLVGVHWaUHQMArYzXgA
	(envelope-from <andi@etezian.org>); Mon, 15 Apr 2024 21:00:01 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-106R0069717fa12-e9f8-4f4c-974d-fc8acd2e533f,
                    1C060BB0AFB71ED4B605930205BB25055C08B83D) smtp.auth=andi@etezian.org
X-OVh-ClientIp:89.217.109.169
From: Andi Shyti <andi.shyti@kernel.org>
To: wsa@kernel.org, Loic Poulain <loic.poulain@linaro.org>, 
 Robert Foss <rfoss@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240412-linux-next-24-04-11-sc8280xp-cci-compat-string-fix-v1-1-7dbafff36932@linaro.org>
References: <20240412-linux-next-24-04-11-sc8280xp-cci-compat-string-fix-v1-1-7dbafff36932@linaro.org>
Subject: Re: [PATCH] dt-bindings: i2c: qcom-cci: Document sc8280xp
 compatible
Message-Id: <171321479967.1758400.4418500996463350127.b4-ty@kernel.org>
Date: Mon, 15 Apr 2024 22:59:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Ovh-Tracer-Id: 10760225412810082960
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudejvddgudehjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevjghfuffkffggtgfgofesthejredtredtjeenucfhrhhomheptehnughiucfuhhihthhiuceorghnughirdhshhihthhisehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhepffetheduffdvhfdugfffudfgjeejudehheegfeeguefhieeugffhgfeuffdvgfefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvjedrtddrtddruddpkeelrddvudejrddutdelrdduieelpdefjedrheelrddugedvrddutdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpegrnhguihesvghtvgiiihgrnhdrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekfedpmhhouggvpehsmhhtphhouhht

Hi

On Fri, 12 Apr 2024 14:53:25 +0100, Bryan O'Donoghue wrote:
> Add sc8280xp compatible consistent with recent CAMSS CCI interfaces.
> 
> sc8280xp has the following clock list and so requires its own compat
> string and sc8280xp specific clock definition in the yaml.
> 
> - const: camnoc_axi
> - const: slow_ahb_src
> - const: cpas_ahb
> - const: cci
> 
> [...]

Applied to i2c/i2c-host on

git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git

Thank you,
Andi

Patches applied
===============
[1/1] dt-bindings: i2c: qcom-cci: Document sc8280xp compatible
      commit: 32204e57f3fbe8863dc17ba59bdf3f5dd573896d


