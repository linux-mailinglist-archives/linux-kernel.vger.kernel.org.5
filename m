Return-Path: <linux-kernel+bounces-110289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC04885CC1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BED14285C6B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E0712BF1C;
	Thu, 21 Mar 2024 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQlwQ6TK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D48A12BE9A;
	Thu, 21 Mar 2024 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711036522; cv=none; b=ebNPDoL18CFgsmhtmMfWP/O4ekhxZJo7bG5Ve/znEc9dGxBKcye6iks8UMMXZgAKVaaj5BmdmblTfB3ojaSFrd+vr2faEaraC/rc+dW4x+VfoaCEtiDldxVyvajvyMyd2lWme2G2k2JHwi0bRNgX8UmR5ExdQ22zwDGLNdP0rCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711036522; c=relaxed/simple;
	bh=9xGEAJEokR98uCFDC8ggsj9Yw76O9dv8hDlVN+zQ8Y0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=W0HUb1Fimdq18AXmxsBxrMstC5xzVthEP/8UN5Ll8LEwk760HpFrc3yjZ0pzGdixWN/F30iNbULYxqTyL//8ybbThRuGVc/PHo7zYtmPmGlKOkG2PdQNkHtfxWF1ehBXA/d5VR9ZZ6R7s/D8UwfvgUutHdQ9b0lck3qXYztd9K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQlwQ6TK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA32C433B2;
	Thu, 21 Mar 2024 15:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711036522;
	bh=9xGEAJEokR98uCFDC8ggsj9Yw76O9dv8hDlVN+zQ8Y0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=GQlwQ6TKz10QI5etdiIq1lNYKJ39NOCuITNeNz9dSYmMhjavQdrbVuecJlOIAo3H+
	 kpysuHaM81QcB4ao8Rr8fHM/M75s8xIeCU/wx07oU4cjKHJ8Ts4x0DICi8MM5BtB+/
	 3NBtM6BjWTN9FueEMzJQBt/Mi0/qFIq6L5U6ueC2HyrNNxGgaFjsZXf56UXtxosIIE
	 RDV+7Bko5BVNEAuCKTavFo6tOL+XlXkjg4d6P+YrRBJCS+bIVsjDS+Ug4aauPotwz6
	 9wwmdAbJgysmuzJS76B89ogw/FxnjpwA3+W+J5gyPtD6oNdjpamsl0XwYq1xzQG+Yz
	 ok3wjaTAmj+Hw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Mar 2024 17:55:17 +0200
Message-Id: <CZZJTOX5EAJF.2O804HZ7A8I4Y@kernel.org>
Cc: "Jonathan Corbet" <corbet@lwn.net>, "Daniel P . Smith"
 <dpsmith@apertussolutions.com>, "Lino Sanfilippo"
 <l.sanfilippo@kunbus.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Peter Huewe"
 <peterhuewe@gmx.de>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Alexander Steffen"
 <Alexander.Steffen@infineon.com>, <keyrings@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] Documentation: tpm_tis
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Randy Dunlap" <rdunlap@infradead.org>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240320085601.40450-1-jarkko@kernel.org>
 <4550b40f-658f-4795-a7e1-ac9100c657df@infradead.org>
In-Reply-To: <4550b40f-658f-4795-a7e1-ac9100c657df@infradead.org>

On Wed Mar 20, 2024 at 4:27 PM EET, Randy Dunlap wrote:
> Hi,
>
> On 3/20/24 01:56, Jarkko Sakkinen wrote:
> > Based recent discussions on LKML, provide preliminary bits of tpm_tis_c=
ore
> > dependent drivers. Includes only bare essentials but can be extended la=
ter
> > on case by case. This way some people may even want to read it later on=
.
> >=20
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > CC: Daniel P. Smith <dpsmith@apertussolutions.com>
> > Cc: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Peter Huewe <peterhuewe@gmx.de>
> > Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
> > Cc: keyrings@vger.kernel.org
> > Cc: linux-doc@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-integrity@vger.kernel.org
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> Makes sense to me. Thanks.
>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Good to hear, I tried to write a summary that makes common sense :-)

Thanks for the review!

BR, Jarkko

