Return-Path: <linux-kernel+bounces-161427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9058B4BD9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 14:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802E0281631
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377956BB54;
	Sun, 28 Apr 2024 12:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="WBlpdREm"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE14F516;
	Sun, 28 Apr 2024 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714308838; cv=none; b=F7oU5BJWCCgKSVlWAbDTs49piKTj9OGVoC/nG1Bb41G+4fvWMTzPQUB8asmGwHSbvbxlKk/0AgN2dIb/fwhzNNlSMbbLALvih2l9LWuRZlyM0zXVp2xGPVlE7n3UsazR887r+siVdXQtd1DugN5/nAjExLjCg4n19FJISZp+Up8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714308838; c=relaxed/simple;
	bh=PObusAyonphNfE4wWT8tWyu3dftMdnrVBH0CtYfXnJg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WgpijFVrsksqjEy30FESAicRUdFoyeZgE9hQA5w2RdV2xmommGXLhzkltcgQ13ZtxharNrBbK71O8Pn4jC7hO1D5tOqCiRi/V4R6wN/33uiAz2yVVs92SnywqDo1uN3TmRuOCyMPmjMXA1QlU7cKJmpQlclf6TrFDFh8ETOVqNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=WBlpdREm; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714308807; x=1714913607; i=markus.elfring@web.de;
	bh=pytEz1hBiZhR3/33BHamZLo8u9WQHaEHaKOnyS1MB/I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WBlpdREmeF8bEmsXc1pVzXOmwVopIrJtx64k5WaQHpGZD3WbfVqZ911KXlC9IZ3l
	 Y/f1g9xytio8pm6LpbBr57gcCk8relXRPyYE5+AUQkeYV9Dya5OhFAQ6GTQrQFtEA
	 IsZfQ8P+MYqCXUkx8jdQ+GWKcEPIHBQsGknXbi5gUPaolhzTZJyEhYiYk/Zoap4Ex
	 kyvuYMfxjzlePs/99nr/xlgHEu8WOiOadKjsciR+XFe+yUSAp4mbZBEQREwx49KUE
	 GOKRt9T/Kop1DqKRU+lfcTKj9MncgqqCTnSWrUqd6oCrbo3Rvbm+1i1iEpNA7k8e3
	 pTRnJvTthas0RUYrcA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnX5F-1sQo0g1qab-00e9OP; Sun, 28
 Apr 2024 14:53:27 +0200
Message-ID: <63caf898-8072-48fe-ba7a-2e10e5b2d8ab@web.de>
Date: Sun, 28 Apr 2024 14:52:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH V2] scsi: qla2xxx: Fix double free of fcport in error
 handling path
To: Yongzhi Liu <hyperlyzcs@gmail.com>,
 GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Nilesh Javali <njavali@marvell.com>, Saurav Kashyap <skashyap@marvell.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Himanshu Madhani <himanshu.madhani@oracle.com>, huntazhang@tencent.com,
 jitxie@tencent.com
References: <443fb75b-948b-430f-be33-170e6f592280@web.de>
 <20240428113404.12522-1-hyperlyzcs@gmail.com>
Content-Language: en-GB
In-Reply-To: <20240428113404.12522-1-hyperlyzcs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DHaY0Tigrkl34GXVyr7bpiaZ8EZhWqneFXFznlSn8aMn2Z+1yr6
 hN/aKvbBLI7GRrxAz+ybXXkzeJdCQctKZ783I2AIz34mI7R14J6Fm8o5hW5hbpOqMfNaVet
 pkH4+1xpHF38NcOu+ovlH+S+/7BcupE7PoG5dkc8vdYBXqpU4zLqGx/eNTjuGPutv9vu7wS
 1EqJwVPPanWOZoFeXRaKQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uN1xlcZIsZ4=;Kp96PXXBw11iC5UJInr9kZBNFbD
 8uGa8Ndl+XmLvn51uh7YA7tsGevYJHBOwl2no8hX441QxuvSd/LBeQT5OfDYb4rvDvS/obKAQ
 T16xCKTl3ectKG6QTp13MJEIN4Fa0654OiAfs4jB1qkb1+ofUHRLTorC1xzxDMBh6gcAjifn0
 PNbg8LKEdXru+OeOKJREsKIVBiqnjqmIg9R/l98I7GYE64IjVdK2kItcJUeXmWzZ5fgoSLc2s
 Zlyx6p5FVxR4FTHsvGcMt/S6eKyD0CKmfB4L+dOfXuJe85FvnlH89QKTkCYlGzw94WJf1WpcQ
 37lvhIn6AYuYt31IZAJSwLuEm7LjjIlXyXEohRkpXHpG/JTVjhuJU6AAY0XRbIpLQAuDqIRJv
 0w9lQC7w9xUiZ8pkpQsWdTG2AFwPd8QRkbURyDKJgWpmz/0u71G7dv99yAO210t4DPKoEYhhV
 g8xroe8aejAb8oG0Y77XTj8loGSKTft1d6OEBv543PYJrvfmNCLdfwbuFULGZPVQkYLxMmMF4
 PO2Hk+Q3nG1311JD8AXIP4OZDxdVSr/HLWi0WOXDGSAABEAYetgEzwucQ3dsAwELBMtZta3sm
 hli9nsYp8tLj5Spm1W7wVzrQJqUcnhjdhmWehrKvkJ78I6yMn4pAUuY+Jqc3Pr35lfuPHRSsL
 zR4c6rOn6Ax/SYr7k49pdo7ep/YGTT+XjjqZ4YVxKc9l0FZxZBS7wtZWney/5qmb3jYDEDG96
 XVcPmBz0/eDK3IUBCx0Q+SlCyzVhM83sG0hc4prtUnr7okqkhO0THEd/489P976GP3nl2XSAq
 gMJQrl5HyzToEFnrxMb7QVjyuD+MrlkidO8QiMkQEEb5E=

=E2=80=A6
> Fix this by cleaning up the redundant qla2x00_free_fcport() and
> replacing error handling with a goto chain.
=E2=80=A6

Can the following wording approach be a bit nicer?

   Thus clean duplicate qla2x00_free_fcport() calls up
   and use more common error handling code instead.



> ---
>  drivers/scsi/qla2xxx/qla_iocb.c | 13 +++++--------
=E2=80=A6

Unfortunately, you overlooked to add a patch version description behind th=
e marker line.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9-rc5#n713


=E2=80=A6
> +++ b/drivers/scsi/qla2xxx/qla_iocb.c
=E2=80=A6
> @@ -2787,6 +2783,7 @@ qla24xx_els_dcmd_iocb(scsi_qla_host_t *vha, int el=
s_opcode,
>
>  	wait_for_completion(&elsio->u.els_logo.comp);
>
> +free_sp:

* I suggest to omit a blank line here.

* How do you think about to use the label =E2=80=9Cput_ref=E2=80=9D?


>  	/* ref: INIT */
>  	kref_put(&sp->cmd_kref, qla2x00_sp_release);
>  	return rval;


Regards,
Markus

