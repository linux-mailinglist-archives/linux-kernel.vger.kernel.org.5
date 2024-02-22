Return-Path: <linux-kernel+bounces-75805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2545685EF3D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAF111F22547
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1AD1755C;
	Thu, 22 Feb 2024 02:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtWhxMyU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64771428F;
	Thu, 22 Feb 2024 02:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708569478; cv=none; b=a1fkasKzrCFhTihT4Lto4jdlFvHXZPW0w52nkTdSh4FiL6kuM2brpNKkZXRqSUyphzRDfL3Nm77PNLdscyDrhkAG7mM+adF4YgcYWS1QPzx6Jd9BKP0R7Am9avFrCnRE4JN1bPVqkMpYheenJ29LrlFm8nsGRyeqXNep58GszHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708569478; c=relaxed/simple;
	bh=VpSH7WVSxh8xOIVjMtllw69spK1nwJejrLyyov99v88=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=aE8bmmd0mpXVZuy8CfbpQTRL3ZV2UCPJ1w1YB1DxqTegYyuHYayEkM4GPfakMp8uKcibShKOG1SA+ykP6Am7BExDbnB8nhDVdsESnzGEQjRV9oEhcu2OsMgkfLU3USOp2HZer2fba6RBoQezOGtkJeTKid/cXNyS24L/8ueqoxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtWhxMyU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3DDC433C7;
	Thu, 22 Feb 2024 02:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708569477;
	bh=VpSH7WVSxh8xOIVjMtllw69spK1nwJejrLyyov99v88=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=AtWhxMyURRBKpAzyO3agWNlorMBTJFKQLesVrouSUVbEcnumHaOqpg+nwPK0iVAAw
	 SRwDAh6kjHQ+tSlhdPprywWiqEbNqeWmlObQK14PrVzXjanSmkPs1sB3tPs4+5FSeO
	 hopc/3yKxMg8FDP7Uxxre+AZOiZVOFoizXbKOcIG/8yYAQVTcGc+y9aGTapCaPysCa
	 DQoznAfr824hjL7W9zAvbCTt7XUx22yW87vy4YYfzNpY2+qgu4hh+NYAVW5mefctmI
	 hTHyKTBuFqIhl5qz1naVFWpsmH1IDs7wzYB5/V+t4TnIJLAL5ag7u0ZtJg0m78e547
	 qHmdA5i35XfRA==
Date: Wed, 21 Feb 2024 18:37:48 -0800
From: Kees Cook <kees@kernel.org>
To: Justin Stitt <justinstitt@google.com>, James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: lpfc: replace deprecated strncpy with strscpy
User-Agent: K-9 Mail for Android
In-Reply-To: <20240222-strncpy-drivers-scsi-lpfc-lpfc_ct-c-v1-1-20c685bd1b43@google.com>
References: <20240222-strncpy-drivers-scsi-lpfc-lpfc_ct-c-v1-1-20c685bd1b43@google.com>
Message-ID: <BE9C61AA-633F-4CD1-BE5E-B01DC947626E@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On February 21, 2024 4:41:52 PM PST, Justin Stitt <justinstitt@google=2Eco=
m> wrote:
>strncpy() is deprecated for use on NUL-terminated destination strings
>[1] and as such we should prefer more robust and less ambiguous string
>interfaces=2E
>
>We expect ae->value_string to be NUL-terminated because there's a
>comment that says as much; these attr strings are also used with other
>string APIs, further cementing the fact=2E
>
>Now, the question of whether or not to NUL-pad the destination buffer:
>lpfc_fdmi_rprt_defer() initializes vports (all zero-initialized), then
>we call lpfc_fdmi_cmd() with each vport and a mask=2E Then, inside of
>lpfc_fdmi_cmd() we check each bit in the mask to invoke the proper
>callback=2E Importantly, the zero-initialized vport is passed in as the
>"attr" parameter=2E Seeing this:
>|	struct lpfc_fdmi_attr_string *ae =3D attr;
>=2E=2E=2E we can tell that ae->value_string is entirely zero-initialized=
=2E Due
>to this, NUL-padding is _not_ required as it would be redundant=2E
>
>Conveniently, strscpy also returns the number of bytes copied into the
>destination buffer, eliminating the need for strnlen!
>
>Considering the above, a suitable replacement is `strscpy` [2]=2E
>
>Link: https://www=2Ekernel=2Eorg/doc/html/latest/process/deprecated=2Ehtm=
l#strncpy-on-nul-terminated-strings [1]
>Link: https://manpages=2Edebian=2Eorg/testing/linux-manual-4=2E8/strscpy=
=2E9=2Een=2Ehtml [2]
>Link: https://github=2Ecom/KSPP/linux/issues/90
>Cc: linux-hardening@vger=2Ekernel=2Eorg
>Signed-off-by: Justin Stitt <justinstitt@google=2Ecom>
>---
> drivers/scsi/lpfc/lpfc_ct=2Ec | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/scsi/lpfc/lpfc_ct=2Ec b/drivers/scsi/lpfc/lpfc_ct=2E=
c
>index baae1f8279e0=2E=2E42594ec87290 100644
>--- a/drivers/scsi/lpfc/lpfc_ct=2Ec
>+++ b/drivers/scsi/lpfc/lpfc_ct=2Ec
>@@ -2569,9 +2569,8 @@ lpfc_fdmi_set_attr_string(void *attr, uint16_t attr=
type, char *attrstring)
> 	 * 64 bytes or less=2E
> 	 */
>=20
>-	strncpy(ae->value_string, attrstring, sizeof(ae->value_string));
>-	len =3D strnlen(ae->value_string, sizeof(ae->value_string));
>-	/* round string length to a 32bit boundary=2E Ensure there's a NULL */
>+	len =3D strscpy(ae->value_string, attrstring, sizeof(ae->value_string))=
;

This could be < 0 on error, and at least lpfc_fdmi_hba_attr_os_ver() may p=
resent more than 64 bytes=2E=2E=2E

-Kees


>+	/* round string length to a 32bit boundary */
> 	len +=3D (len & 3) ? (4 - (len & 3)) : 4;
> 	/* size is Type/Len (4 bytes) plus string length */
> 	size =3D FOURBYTES + len;
>
>---
>base-commit: 39133352cbed6626956d38ed72012f49b0421e7b
>change-id: 20240222-strncpy-drivers-scsi-lpfc-lpfc_ct-c-f54b67eeeb68
>
>Best regards,
>--
>Justin Stitt <justinstitt@google=2Ecom>
>
>

--=20
Kees Cook

