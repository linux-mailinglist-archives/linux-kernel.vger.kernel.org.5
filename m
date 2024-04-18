Return-Path: <linux-kernel+bounces-149775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4038A95B7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E9D1F21610
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2200115AACC;
	Thu, 18 Apr 2024 09:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="F5vNtqVj";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="EJRlq9/s"
Received: from e3i51.smtp2go.com (e3i51.smtp2go.com [158.120.84.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E51A15AAB3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713431538; cv=none; b=T1wA7gxF9ZiGcMRFvaV2Mcn7Rwtcik1NW5MT7Kr5nBYhuvjle8JAf1mjUF96y99nMNKp78zqTPiKI1Du/j84mlhF8pfMr83ILvRn3M+pBVVZqTGJjuocGEBoJzu8AuejxSeix4GBKblCoBDRn0s+YNaiJznVMPiTdrmLT7iATMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713431538; c=relaxed/simple;
	bh=wCjv6Xzm1cjaoi/YRo8jMzIxyS8oq6XhXdIspfSmHM8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=caiMQ37yrCQ7qcNZv8Arv4pZK7JP2KZ06JrD5hbWrL1U7rtjwyZ4GmpjVVrVQpqaBCtdLzvZgI7RthrqNzoFfrsgqhnE6jV0x1LZCrAxxG5Aob24ZcQ7dc5W7n1ZacZdfGUC8Faenyf0HiJGZCif+u2KhsliEckmLGF1pAQEv3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=F5vNtqVj; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=EJRlq9/s; arc=none smtp.client-ip=158.120.84.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
Received: from [10.86.249.198] (helo=asas054.asem.intra)
	by smtpcorp.com with esmtpa (Exim 4.96.1-S2G)
	(envelope-from <f.suligoi@asem.it>)
	id 1rxNoQ-wSS1uD-29;
	Thu, 18 Apr 2024 09:12:10 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.4169);
	 Thu, 18 Apr 2024 11:12:09 +0200
From: Flavio Suligoi <f.suligoi@asem.it>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH v2 0/1] dt-bindings: net: snps,dwmac: remove tx-sched-sp
Date: Thu, 18 Apr 2024 11:11:47 +0200
Message-Id: <20240418091148.1968155-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 18 Apr 2024 09:12:09.0319 (UTC) FILETIME=[7DC3A770:01DA9170]
X-smtpcorp-track: 1rxNoQwSS1ID29.mDepuQBEoX-UQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpcorp.com;
 i=@smtpcorp.com; q=dns/txt; s=a1-4; t=1713431532; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe;
 bh=SBklWFLQQtr8jhC7pbpaMUNxe5f++YTA1y6M3WTcp0U=;
 b=F5vNtqVjzG0epsvEPuZJH/vGfUfzl6c/u8vGwf+2sdmLkppLWp7sff37W1dG2gX42jLEM
 +hwbHwLc4eOFr1rCIhRIlnWO+nlCcVS8bLFXGUJ9itr3e1AMG8UIGzDGzrENFh/PEQffw+t
 R6gRoIdgLLIoxDrU/avIjikzUQqkQQBSbByVQ4k+aC0zsDkh2qJvCUYaCU+pYD1eMW7fZ97
 Ftgcbk91Wo+BbyG0JrGCP2TIpZ44E6Lo1weua5yuzamcJpfrNxKw7lMUWb9jn+uqxXBgmW5
 3jSLmKmf2pTdU+/+HIqbUPYr0McMMK8JbtP0nOgANACwvQmQyoZPdBloBssw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1713431532; h=from : subject : to
 : message-id : date; bh=SBklWFLQQtr8jhC7pbpaMUNxe5f++YTA1y6M3WTcp0U=;
 b=EJRlq9/sdF5hg/75qNnkbIWori14p/twESBSfFyGSETluX1kx7rKcxH9bQWGQ4nZ2vqmh
 65jjjHKsQthZYLWmI4heW5cl5LJjZi3vOUyUlYibR8aikfFHGV8ZSWQGiz41CcNChsw35EO
 VN32leuKgBanmDlvrQrT7QX0whWY8gfwJAZ297tbUTfQqRh+8IaBSnTCERwehHY7bxw5YDx
 U1rjxRTmMsIAR/oXgzaAkqYdL75PJFAzWSfuOJbkM4zkvgNzsZ2H8u8dVgwY+YkCOaBk5iq
 k39Yddc6xICE54roXpmIJponQm0na3L26P837aJab/7gog9e7/R5UqEzZOHA==

Strict priority for the tx scheduler is by default in Linux driver, so the
tx-sched-sp property was removed in commit aed6864035b1 ("net: stmmac:
platform: Delete a redundant condition branch").

This property is still in use in the following DT (and it will be removed
in a separate patch series):

- arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
- arch/arm64/boot/dts/freescale/imx8mp-evk.dts
- arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
- arch/arm64/boot/dts/qcom/sa8540p-ride.dts
- arch/arm64/boot/dts/qcom/sa8775p-ride.dts

There is no problem if that property is still used in the DTs above,
since, as seen above, it is a default property of the driver.

Flavio Suligoi (1):
  dt-bindings: net: snps,dwmac: remove tx-sched-sp property

 .../devicetree/bindings/net/snps,dwmac.yaml        | 14 --------------
 1 file changed, 14 deletions(-)

-- 
2.34.1


