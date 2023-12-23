Return-Path: <linux-kernel+bounces-10565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8800A81D64A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 20:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E8528345C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 19:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A6C14F62;
	Sat, 23 Dec 2023 19:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="DRvT13IY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42F7179A1;
	Sat, 23 Dec 2023 19:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703359341; x=1703964141; i=markus.elfring@web.de;
	bh=YdAJatdNn222cw6W3QL2m67wBaRz4XfpDHkOgUq/DzM=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=DRvT13IYN86qWWYfaYYHMQGACaB4wgzWoWS3gk3x95GEXcjtp/qQhmP2ddXpxmpR
	 3U1TUhijU+JI2BOr3YuQbPeaxlcgr2ZUrgp/kyMoyG/D3L9EK/kiLjNWO+4xMrA7M
	 XFtoCmHjmcLgRT4z8pmcWWzCxtvsFKlYkv7WilwLnbpoPuzXvSurUbUap5OTUJVtx
	 digFUaZp50o8nTrNc4GPR/GVCvSXZXEpzKHT7BjxiXGjN21dhh1T8tyzc5Vb1HBuM
	 YyF8s+003nVGsfFVSzqDJqMUE5++xPdvly88/TMIGPTgCXm3FNJ+l9eFmApWoEf48
	 z2+jLdCrUJ/q6bvpCg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M91LW-1rJr8V0A3q-006YFy; Sat, 23
 Dec 2023 20:22:21 +0100
Message-ID: <f46f04bc-613c-4e98-b602-4c5120556b09@web.de>
Date: Sat, 23 Dec 2023 20:22:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] powerpc/powernv/vas: Return directly after a failed
 kasprintf() in map_paste_region()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <7be66990-de9e-488b-ad6d-fafd1c7bb34c@web.de>
In-Reply-To: <7be66990-de9e-488b-ad6d-fafd1c7bb34c@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iwQeDu1WH1Hs/rx34Ekzp0SH4cpBbM2mbWTPb1Ujg9sRMV1MtuX
 gioyvZq/vdlkoLQnvzThvnykPLFZzuC+llhzMCsLGNoubqs4RnjZ3/DO3ZaxyH8kiPh86X6
 4tzaAWtuSr+WpILDljfOuOoWFNvHhfMAF7CsWVVqya2KuKYmykyhq4lrLdAu2/6mZucSe2L
 2HMPjzjgQWhXWBRqK5bVw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yZKPcLNQDaY=;mP4Sq/6d+Osl3c8Mwq3xGfn65G+
 Cy5+3xeihr3bxyKux71Trf6ILjj2DIcDIUmt18T/zGJ62znw0jMhZR6we8zwz/6bFPK7bT1ux
 0vYRROAT6T3jA+FNSPbn2lgKAYciOgQGdR5jrgEggtlJR0TWQHSZ1ZI+8UwCO9Hw9a92SQlYs
 TOMBlmpeFbR4IJubUkjGeS0H+ZCphXEKJpBTjPC7Bcb6YtPclT645Gso2flPViTSPWCplrEej
 HpeUWa+ePUK51LU2zj92Qb+hEICLkrFzWkLwERFn4GVjBUbbX0hFyELc6Si0+h7PGejF1sF0r
 ImuOBZY7SQiTsVHFsemFmZ9n5xkl2PDJeteIz6XuiTxwuK6EavKZjBm6DsVnUyz4IE6A9jRYo
 LimvMDPYW7QF8WRmSNyrEen1UH8rD2saHBG36rnuSyFKC5gKQFTnUZVlB3qeVf6evneM0xhHV
 Dvi/07QxLwnO1MbKIan2zaFBQxGf0VSLZTIpmDaBIPdJOVD62d1LZI0WBrJd/NKfGoYHTCzgm
 Q5Kl96pAVli/Ct1DFdRESfDfPDNgHR0CV0XJE/Effb6Ppu7i71TG/aLLVlCh1eNMThstuJk3C
 OGCMCVO6jyacm/4gHq1Ya66c3zU5w/qfKU2mvHqZx/b89i9Xk0g04aKDz2ZGewVSF+9ZT++8X
 5eMQ7FbECCqK+aGDqhgyCW45yXhLHICdVk/QIfISFC6sLzashmKAi7JT7QC9/ZZxhE+VZT2Jp
 8WoAbMsv7esgEIt2EY6FWwi6ANGovAJ1SfWTswYMFjJokwFCklRQ+Loco+PMX8RRZK4KlAG3H
 u2GDnSSQZ5QH56KhGZb2ucnXqlmGGzc9jlwDpSIeQ8PFwlQksvQyQqyqUHG03lTy8RSY44C+y
 RPMvO2rmKoZ9EM5GYzvgz7lfmLd0LRyTXHFrwIgE5ISh5IZsbmL8l6K6ek6xXbqMpDan+JVA5
 QcrSsA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 23 Dec 2023 19:48:09 +0100

Return directly after a call of the function =E2=80=9Ckasprintf=E2=80=9D f=
ailed
at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/powerpc/platforms/powernv/vas-window.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/pl=
atforms/powernv/vas-window.c
index b51219b4b698..2f7d1850b1fa 100644
=2D-- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -78,7 +78,7 @@ static void *map_paste_region(struct pnv_vas_window *txw=
in)
 	name =3D kasprintf(GFP_KERNEL, "window-v%d-w%d", txwin->vinst->vas_id,
 				txwin->vas_win.winid);
 	if (!name)
-		goto free_name;
+		return ERR_PTR(-ENOMEM);

 	txwin->paste_addr_name =3D name;
 	vas_win_paste_addr(txwin, &start, &len);
=2D-
2.43.0


