Return-Path: <linux-kernel+bounces-126232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9606D89340E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69CF1C2345E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFA1158875;
	Sun, 31 Mar 2024 16:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIKPjrCm"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75D7158866;
	Sun, 31 Mar 2024 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903244; cv=fail; b=A4WiLqBkcAWOxpS1ltONPrI1Bp6bnLm6656YTB2QqPLea0wV2csBpTAuGtNs4VNogZ1C7s2EPz2QMLSyYx6MkRtLriyzzcjs4lnzLwWK9UoPvNzIGkW9uG867yRkaTOsDyC3Y89wTu7CxkP2oFAEa3TIX822Ditcrw8uRjBQPNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903244; c=relaxed/simple;
	bh=wYvH7eXjBQHsNCEU8GOf3BJzoOWEU2ZpO9NJyFvqUT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:Cc; b=Vi+kpyVzDFfulK/EPRDE4meYw5b/KuZ6rwBupP0kbFqTUww90JgHaqndkROoZE77eFFqF/PR8DdUUyJa9Cunq9cND/275qAqZvttUEfD3CWPPZYvHKDxJxdoG8Rn5futJtubcWpC8naWdtcPJOtsTKOmHLVVWxJKEfxeoxTsUR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIKPjrCm reason="signature verification failed"; arc=none smtp.client-ip=10.30.226.201; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 9B05F208C8;
	Sun, 31 Mar 2024 18:40:41 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mdg8a3f3sTrw; Sun, 31 Mar 2024 18:40:41 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 0A2FA208C4;
	Sun, 31 Mar 2024 18:40:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 0A2FA208C4
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id F0A3080005E;
	Sun, 31 Mar 2024 18:40:29 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:40:29 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:37:03 +0000
X-sender: <linux-kernel+bounces-125654-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAroimlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 8711
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125654-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 2B36D20315
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIKPjrCm"
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711792677; cv=none; b=JaaBhaOp7veI9BZzPZd6OWUk4p4+zz/wflDXIYYOmx8B+JtFXUuGFTIb/GCba1RpVQ9SuRge8tICYp3X99oZoENVEme3sevVie274SfPcF0sUY3QIJ8UaTf1SjM9EqPSjchSsRxfV9lP+yjzyfEb78J48u4YIih8p2qTelUROp8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711792677; c=relaxed/simple;
	bh=2Q6VY0DGMACrjNS3qT1yPJApGJKAhjr7VSLFZ///1Y8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QIWhVhAbazdKochdO0wPupxKNgs2V13Tf+i7h6jiPVhAm8VgObHrNRI5mqJwWrV6zlF2xy+sl5OxKGXEBBAQ4qcOPojIyNGNFeinR11xNjiLGwZwJ4f1EpFWWIG0hrG+oCi0zrXUg2IJaY/RHFAjxP4mt8xcXMc+++CUTXGRBDA=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIKPjrCm; arc=none smtp.client-ip=10.30.226.201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711792677;
	bh=2Q6VY0DGMACrjNS3qT1yPJApGJKAhjr7VSLFZ///1Y8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BIKPjrCmuop+w7k+pVQ/5GQFzv/kREJ+oNMmkgs00gVX+LKr1itZO/AQn8KxMd/02
	 LbY8k7BsgHrYZSdGsq6OmDswW0zTlFVm0wpq1HfYDqSRLm4VvHsle6oUuBkj0Q290l
	 7GlyVG4MGAmPPhJQLR62zGs2dRxiUd1ovBphkjrFEzbmZbTaKbw7bnT3skeaIf8pzG
	 g/GbJCjFeGqA3oEyixr+X7xiEJwEMaDj19wcaxq3cR6aknv8pbmeJsc0hQFkHzBNmC
	 Z24U7Ouq3TgBabu+kd1eF5f7q/+L4kcdXpmBOxqFcgegX/tZSDW7FCaMx+ZAu0fZh6
	 hX3PI6ZheN7qg==
From: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Date: Sat, 30 Mar 2024 10:57:39 +0100
Subject: [PATCH 03/10] sparc64: Fix prototype warning for vmemmap_free
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-ID: <20240330-sparc64-warnings-v1-3-37201023ee2f@ravnborg.org>
References: <20240330-sparc64-warnings-v1-0-37201023ee2f@ravnborg.org>
In-Reply-To: <20240330-sparc64-warnings-v1-0-37201023ee2f@ravnborg.org>
To: Andreas Larsson <andreas@gaisler.com>, 
 "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Cc: Nick Bowler <nbowler@draconx.ca>, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711792675; l=1023;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=+iIEu1z65nIiaVFud5jDAU2EF2qjq+E//QvstvA1vGg=;
 b=5VSMXsJDe14dfB5oOTmmYLuyPXBP0AEI7kkhlo+yFPQJH9hBDtSPFVLukEaLXfZBrY9t+daDfF0L
 L8uXsXFQCPOI5uioh9DGaOBI8cOkimdx9zSDJ9alHiqMpCCrM+VV
X-Developer-Key: i=sam@ravnborg.org; a=ed25519;
 pk=R0+pqV7BRYOAeOIGkyOrSNke7arx5y3LkEuNi37YEyU=
X-Endpoint-Received: by B4 Relay for sam@ravnborg.org/20230107 with
 auth_id=22
X-Original-From: Sam Ravnborg <sam@ravnborg.org>
Reply-To: sam@ravnborg.org
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Sam Ravnborg <sam@ravnborg.org>

Fix the following warning:
arch/sparc/mm/init_64.c:2644:6: warning: no previous prototype for =E2=80=
=98vmemmap_free=E2=80=99

The function vmemmap_free() is only used for systems with
CONFIG_MEMORY_HOTPLUG defined - and sparc64 do not support this.
Drop the empty function as it has no users.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: "David S. Miller" <davem@davemloft.net>
---
 arch/sparc/mm/init_64.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index f83017992eaa..5444b515815a 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2640,11 +2640,6 @@ int __meminit vmemmap_populate(unsigned long vstart,=
 unsigned long vend,
=20
 	return 0;
 }
-
-void vmemmap_free(unsigned long start, unsigned long end,
-		struct vmem_altmap *altmap)
-{
-}
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
=20
 /* These are actually filled in at boot time by sun4{u,v}_pgprot_init() */

--=20
2.34.1




