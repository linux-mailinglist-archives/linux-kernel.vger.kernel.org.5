Return-Path: <linux-kernel+bounces-9620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B53581C893
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C2F81C21FDC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF92A156EB;
	Fri, 22 Dec 2023 10:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Fpn//Tr6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J5OY5nGz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1818514F75
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 10:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 36DAF5C0124;
	Fri, 22 Dec 2023 05:55:19 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 22 Dec 2023 05:55:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1703242519; x=1703328919; bh=Z4Uiq5XLti
	jsD3C4BRWflNc8XSipqHSnhGRmrgjUqHA=; b=Fpn//Tr6h49yBm5LnZ+DoJN6iG
	PBW1lAtIXwf79cblBo+60n+WDF4JFDQDWz9oJ99acAGGFuUDTs8iz0KgwDbDcx7B
	ICLLhh/cAndSAO6aAfTjBKJSG7sfLHTmXezMWiGiVzmDo3JzpfCxTjppxIRHFcrW
	BOehYHYuqP6rtMKqNWlF+Ku6yAUgTljf6P5JA+IZ1/zjqomgXsg+5LYDVxPr+05b
	gynr1L21jVwhw3ynLUu6zkJa12ApAuZ/ZAeClseztuZI2mBPbdR93zLLKwgaCT/8
	xkhbA38I7K3M3gr5wdtp59x+xbTk+j2NxfyAFxmQOUs5qqU+ckApCJ/AWhDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703242519; x=1703328919; bh=Z4Uiq5XLtijsD3C4BRWflNc8XSip
	qHSnhGRmrgjUqHA=; b=J5OY5nGzL5ATuDYissUd1t7YyqXIHH5q01DzDbUrPP6O
	uBUvbgn/4haOPMNhMZ/SFNxmoykZ1kbAHJw+QySCUR+L2tECmxXINriqwh4g/x3X
	lAHdsxjkx23axPJrAHXL4wlspT6N6/2taQ6iS0NMIhyKZgnhJIzXLrFh4Ew/KanH
	mbUcj+Ekk7FaM0/lBmXB12eJOn0dGeh/cvgFzEJoGKNasW2SEtecpV91LrEL9mWA
	5HMFClz9+5ugO9/NIRP+iesAlDt7FCr0IT3Hg4P1kAMAFzTrrsDFmEsXvR1ks/50
	BHkTrh3VmlL5Rzk9IRXWj1mKGOxU2E/iqyIkzKiwcg==
X-ME-Sender: <xms:FmuFZXJ6A5ShJdDx2oBU2L61Mkov6BfzXxaZk8ITetD7bSZDD9kR8w>
    <xme:FmuFZbKqiyoFQ8E2z4J_EB1GRMkVeTWqpGXb-Fh4Tc_rXb3KRODQ9EUISdrXCZNGz
    BrppZRLUQ5jY6pWZ4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddujedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepjedvvddvudeludehjeeitdehheeivdejgfelleffiefgvefhhfeuudfhgeef
    feehnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:FmuFZfvxS0hbJfjhURREBvjVgi75pzL6JqkNnMBnyZZzKTLVXFA_Ew>
    <xmx:FmuFZQb2BAaOx4QKXwjbEw2dfIx0fGxMMcQAbLGnzeqQF53zDsTiIQ>
    <xmx:FmuFZebo8ULNOMXS2QjZ4mtwXcz_KmQjlb9eSWgGMgs8RGiozuVW3w>
    <xmx:F2uFZTNg7IKAy0TSZYK6H82cS2OK8Bp8WPlNGTi6Ky5NYjAIXNVcHQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 82DCBB6008D; Fri, 22 Dec 2023 05:55:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a274ba17-6ab7-4169-a10c-22fcc9e74248@app.fastmail.com>
In-Reply-To: <20231212105514.273e8ab0@bootlin.com>
References: <20231212105514.273e8ab0@bootlin.com>
Date: Fri, 22 Dec 2023 10:55:00 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Herve Codina" <herve.codina@bootlin.com>, soc <soc@kernel.org>
Cc: "Qiang Zhao" <qiang.zhao@nxp.com>, "Leo Li" <leoyang.li@nxp.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] PowerQUICC QMC and TSA drivers updates for v6.8
Content-Type: text/plain

On Tue, Dec 12, 2023, at 09:55, Herve Codina wrote:
> The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab:
>
>   Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)
>
> are available in the Git repository at:
>
>   git@github.com:hcodina/linux.git tags/fsl_qmc_tsa_v6.8
>
> for you to fetch changes up to 7a2ee1576dcc6bbe017a8283fba237b05b13fd15:
>

This is not a valid git URL I can pull from. I have instead pulled from

  https://github.com/hcodina/linux.git tags/fsl_qmc_tsa_v6.8

which is what I think you meant. 

You should probably edit your .gitconfig file to add a section
like (not sure about the exact syntax, you'll figure it out).

[url "https://github.com"]
    insteadOf = git@github.com


>  drivers/soc/fsl/qe/qmc.c      | 658 
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------

This is an overly long line that you probably copied from a large
terminal window. Just for readability, I recommend redirecting the
'git request-pull' output, e.g. into 'xclip' or 'cat', which will
give it the appropriate line length for emails.

      Arnd

