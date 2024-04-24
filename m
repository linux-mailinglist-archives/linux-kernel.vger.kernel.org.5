Return-Path: <linux-kernel+bounces-156511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 431758B0391
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7056A1C23E41
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403571586C8;
	Wed, 24 Apr 2024 07:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="QfY0sKM3"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B15815667D;
	Wed, 24 Apr 2024 07:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945422; cv=none; b=PHgMmfbECP0A/m4jtQ2MR//murJXB+YVAT879a2QL0mhiztZVj5HCPw86cOScHwsA30kBiFd54E1Rk9Ns3b2mFSmOnaEXeB2Bk0eTNbRS8P03VYmzQClkaIt04SM/5FUHK4Oneo5Pp5trAQ1vinSuuv+3UBhzmgYnBezVYFa6Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945422; c=relaxed/simple;
	bh=Rzu4SBjLS02QTDYwFVyXfcT/Uwk5T24ZqCQO9sZXhu8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=dFojqek6unmeyUEOPqpVf5rgm9OJNGmtUBM2p7bPyA1WpSuMkaFzWsYH3UeRfcyJvczGy8cgtarV2T4BCimYV94+orHl1baMXz+R/mKei8lKXOnVXaaMtcVJBsSOXbfseU5JKewzAGUDBNowMF1UcLrVdIR3AYsv0nGd/ku2UOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=QfY0sKM3; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713945391; x=1714550191; i=markus.elfring@web.de;
	bh=qRmF7DnpL7qNBRELjA91gY2iF7VctkOvTYP4sr98G5g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QfY0sKM3EYhSmjmxfK8qpL7AyWHN6Du8epO9vSbxeWsUb9vSTTJC7p+X5nRryKzc
	 L0AVe1rUPl1yjHVY3FSVkexy6omOF7VzhB4LiI7ByvoNE8q6PkuKwAU2Fge9xNGRt
	 JBMsB3x/sjuo7YJ9ZulIK1aPALiapZFELSE3N9yBLOLwiRGvX96ocXDf+2SvfjtK7
	 kGQldLKTQgI9fowLE0odP4slUt9X9xXN1dFcBthH/faJhjw5Tdw2M0n54cM9vNH2h
	 1UwhzxwePuBuXcuPiVSVSKTGZwuoc7KOCkqKSic0B6SP4rJtcStUJaom6W9MWKTan
	 8vkFIWH5fKS7DVJzQg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7usy-1s4TAy3Ieo-005YaZ; Wed, 24
 Apr 2024 09:56:30 +0200
Message-ID: <7ed5b3e0-933a-4a6c-a07c-3cdc8a9cc680@web.de>
Date: Wed, 24 Apr 2024 09:56:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Su Hui <suhui@nfschina.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Bill Wendling <morbo@google.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Geethasowjanya Akula <gakula@marvell.com>,
 Hariprasad Kelam <hkelam@marvell.com>, Jakub Kicinski <kuba@kernel.org>,
 Jerin Jacob <jerinj@marvell.com>, Justin Stitt <justinstitt@google.com>,
 Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>,
 Linu Cherian <lcherian@marvell.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>
Cc: LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 Suman Ghosh <sumang@marvell.com>
References: <20240424022724.144587-1-suhui@nfschina.com>
Subject: Re: [PATCH net] octeontx2-af: fix the double free in
 rvu_npc_freemem()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240424022724.144587-1-suhui@nfschina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nT36HYLdKEbIjiVuaW46eZ9S5z7J5R9kXNtayTUk7ufBZ3Y8Nkg
 xsIUZM68XSUdGE//c2dUTeLDirA2xkdIJSysKIuJ3gmxszEH0g1LIe2hh7gWMM2F0V4Roeu
 5G4X3ylMJByMdq3k2jlvmOAMl4QDVvQsoREtzEF/xGWUjvgOJ87HUSTB5GZbYJ5WTfxwmsI
 nDZvhkDhy+mqvY5TG6yig==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vGnzurFDixo=;ASgHWtmKV/3l2acJxRhw44gfzm+
 1xpKJvmduNrAGCUK3fTjVRJdQSqtLjagolnnKRBJudv5CWO1Gjjq+I6mtBB1oDZcWck2j/H52
 6ZSQviJztJT1yRIXQDWSrjqs1yb1MId6jXk8MddVFz2aX2HFa2zSlp9QChnnwbE7OKar56Xix
 BTPnSx5oGcjqEXyQmOVyGI0G5nJ/dRR+pANIRCTtSOyQObvC8NvniKC15CvNaCYmP7O9sv0SI
 L1buLj6iZPCoZV8O6uqQ2ydLqtEl+6r0/7C0LADwf8ctgwLe8i8XKsLcHcN4OlFHp7QJko1Ee
 ZFAAqskYaoe8ULiFBxk6yTpjbnalCQ4Ypm4RzYY4greCAkJk20S+69A2zqrce4IvtB9+H92EG
 1676U0sI16Ujw+tFGMOxH6+M9iQfa4EMmuE/sQajFJ2SFqf4enqWM+RDiav60pse1RtRlLC7Z
 tMDOtTOpg+mms+pCJYinLeqKgaIrN+KOXpvFGqBmNu+2ZLE/akleugm3fdOrR1SiudJTf2V7H
 VZqYTpG9C608zZlyirTT77WigVe+Jt0Q/wQ9icYpPb2EfDD3B5KhhfS8BtkKyGjtfJXLOhuAq
 gcBSYZAk3sy7O4uRnmtei4uQc6GE2nquwblwThHbRKYBHaIYr4PWvzRWbO21BRYkueOfQkYRj
 Ghu5VPMmtOsOKgjyDZD/poiaKPorPr3LUliTZSV4lDMmPUYn0lPh832vBQtimP2AnnHTBXjx4
 l7cdgex48qgceFKEm+IMtzgEyIrp/hhYYGwvwtVNGGYKh6/tKRTbaosQQtSwg3jpFgk6uq3vp
 mCaaYoM3rMCk3UQ5klrykVvBZoGnSbAp54BknvHa3AR84=

=E2=80=A6
> npc_mcam_rsrcs_deinit() has released 'mcam->counters.bmap'. Deleted this
> redundant kfree() to fix this double free problem.
=E2=80=A6

Can a wording variant (like the following) be a bit nicer?

   The object =E2=80=9Cmcam->counters.bmap=E2=80=9D was released during th=
e execution of
   the function =E2=80=9Cnpc_mcam_rsrcs_deinit=E2=80=9D.
   Delete a subsequent kfree() call to fix this double free problem.


Regards,
Markus

