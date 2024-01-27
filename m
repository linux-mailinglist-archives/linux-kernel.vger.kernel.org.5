Return-Path: <linux-kernel+bounces-41232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3849F83EDB9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D83283508
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 14:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5347028DC1;
	Sat, 27 Jan 2024 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="IdZGCCjL"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851C31E4BC;
	Sat, 27 Jan 2024 14:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706367351; cv=none; b=YyYP/2prn4OPr1a7KcwRzh1dO4GmkU38Otbqz0UeGZRXP8bd5yDs5TzKXApAmk+vkXrbp4FnRU8kWycgzjtexhzDQI8mEWooGNmfsP8NO6NxVUL/lg0CBKZ499AerL+INYnMKzS4F8kaZXPB6zWroJzWl1uAE4gCVV4hTNuCqlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706367351; c=relaxed/simple;
	bh=5oTGBMsVoy/AmE5qx0ytIoyZm6Kw/DezMl4EgLexEVs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=K8lIguF/1240DDtx5DIzfB/lEXqJs13mgHKGuJ2QuEn9Vp4bVF2T0uIki7HKHQ/TkkRTS3hJhU+iJ0RRDpjMCjIe51vv5Y0Tmy/4uJ9s6xMlNSvJv4IOpNhPtiBKcjl9bE5GgTOAx6ECsgENqhNzhQne+yNEV++auQ9LKkROZRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=IdZGCCjL; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706367326; x=1706972126; i=markus.elfring@web.de;
	bh=5oTGBMsVoy/AmE5qx0ytIoyZm6Kw/DezMl4EgLexEVs=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=IdZGCCjLmfazUcmtSLsqsWkQ43R2iVHyoPtZl3X0VUGbT9oOHL9/9qpsbHFvB588
	 3OKutBw9QWhLrndD0ItJ9yy63pzyPQaEvAPBNUxD92zEOTVZn8fwBYBsOd3aHQ5gE
	 rScWys2ILPC73S2TxWGQGymRD3NW52YhXvATOvtwjmtr00SqV/A7F7G6bvjgtfrbn
	 Nw2CZohrwvIYqtEg5uPKj+6kCTlAg9UZxABiHxIh9s/ijwVp1C7lXuD1mCOIvGcOq
	 EbAHyW0IKxkw3uEANTV6IvxSMCjdNJyDaE8zYUhXXHZgZnmTlmly+KuoR+FmJ229Z
	 /Ljtvv01tD4vOih0zQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsaS7-1rEojd1hPP-00u4CP; Sat, 27
 Jan 2024 15:55:26 +0100
Message-ID: <d94376b6-12e8-45bb-a9be-4887bb316d35@web.de>
Date: Sat, 27 Jan 2024 15:55:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-fpga@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Luwei Kang <luwei.kang@intel.com>, Moritz Fischer <mdf@kernel.org>,
 Tom Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, Kunwu Chan <chentao@kylinos.cn>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] fpga: dfl: fme: Return directly after a failed
 devm_kasprintf() call in fme_perf_pmu_register()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6vcd10ZQQqZU6BgRQxdXosyK07D6p+07N3r8mPyYUd2TY5RTWH6
 Et773/a2KpVp/IC+I774nwVlQ1yPUO3/KFv6ueurCMi48EkAUR+eTmuPn2GEkGHod/rKqWD
 ch7o79nE3RVJutNmad++NdSOwSVk+lk2QmlFY9FZhUE3dZGPqrMqRtPqde2V5So8rChZs4j
 uUXDr4TjhC4xmGpDfLF+Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LAWx3IAIWPo=;JLeqcNkLoARB1EISitBbSSocVOb
 AT+M8c+Rd7wyNZJLbjMnnCIoDPNDCeMRXVze2CuZ6JmZ/zPyVe9opsOYk//1NgOWT/oigx6OL
 G9xVGNlsJ3IuenoEzVshoblk+3MM9uLcVhh946eYn/vFf2Ga/4+8g49QASSWhxe/jiqFjzbZu
 P4NoVcggljqoZvMwDQOSfxuGP++ef0PifZBRQIvqVUdNIARFiaZ22BmdqvnG30MWmK/ub9vZi
 Hb1lqVD+5jRvCWq27viTnYeZUMoc0Xrpgj5844oMUHfec8BhJvvgY6o19kbFOXGMlQk7+Wdin
 QQoR0mMmWuUvXrAwS9xuuLz5kFFXnLxQWboL9bVZiUUAyw4xBmBUedew9s80ihz9pkIxKSM34
 hur+WNTrsp1W2mtZwwmOip1SyqDaB4jOf5WvXGFraAVLprwnXB6AndFlhRzUNUEKEuqC7mu6R
 KohZNBOLFqR5rVAEtedHbtveoLdULNNlMmESrUhRK6HXDNkQEM0gJQFKmiZgwslLPwSjejcJ6
 smZTj/2fOpSZOSPwbnQ1q094y5D6H7t4YdT61Rrqq1YiLhSemM2f0DNYJpYOIG30bMXfIpXFm
 JjLviA6rjk47/5eBlF1ZCzv6UncLcvJivZeeAMjqX/8y6y2ET3kPWsVKPRYn3dxHce0spqQGm
 yl4+8fCY3H1XNiNJu1ot81JcXz2YczVOf3MDENKXWkXAdxwdbMSPqJS35czyxZaHnULrSOqji
 MPfMcWEBqExH0bFlMPixXbdzaDaDnTRuGMv4TQhDhy4UoIGRSxrSB1P+Mnmo/vt69Fs+LhWBS
 NWvK4G/QKPe7KhZF7feMsIG8odTMafNiOWUjAiRaTvF1jCZ+LO86K36I5odhDRcd+94LVwnsR
 idnkah2Uh4Rcsq1p6l/0dzJHvPhVQ69q9eFtWDaoEy8SqaWrQDNJLQziJPRU8V4N8RBdOp5PJ
 GfiThzazYbdcYi0mUoFYG9BlBlg=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 27 Jan 2024 15:43:42 +0100

The result from a call of the function =E2=80=9Cdevm_kasprintf=E2=80=9D wa=
s passed to
a subsequent function call without checking for a null pointer before
(according to a memory allocation failure).
This issue was detected by using the Coccinelle software.

Thus return directly after a failed devm_kasprintf() call.

Fixes: 724142f8c42a7 ("fpga: dfl: fme: add performance reporting support")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/fpga/dfl-fme-perf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
index 7422d2bc6f37..db56d52411ef 100644
=2D-- a/drivers/fpga/dfl-fme-perf.c
+++ b/drivers/fpga/dfl-fme-perf.c
@@ -925,6 +925,8 @@ static int fme_perf_pmu_register(struct platform_devic=
e *pdev,
 				PERF_PMU_CAP_NO_EXCLUDE;

 	name =3D devm_kasprintf(priv->dev, GFP_KERNEL, "dfl_fme%d", pdev->id);
+	if (!name)
+		return -ENOMEM;

 	ret =3D perf_pmu_register(pmu, name, -1);
 	if (ret)
=2D-
2.43.0


