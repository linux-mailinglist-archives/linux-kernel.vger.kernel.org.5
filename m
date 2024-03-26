Return-Path: <linux-kernel+bounces-118917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9680888C123
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17BC1B22650
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B7D679E5;
	Tue, 26 Mar 2024 11:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b="qDReuZwN"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E42438FB9
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453697; cv=none; b=iae6THijaCRvMp6wBai8DIMPJTlFrD0L64LtWjQXvTEKZ56XiQhb/s/ZWjt+THCbfWx5lYVhZC3U+cMQg2nWMBQkG8b6vH27nirix8UOhkg7QO67kF97W4ZdzMHuAY+WR2BUgm45gqeJ7hUtTisbucVPnDffh5Zcy5K0b37r9RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453697; c=relaxed/simple;
	bh=ksJEpKNewmNmslHJnwfsm7/NFw9UPD2T7IztjcDkQfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ccYxEeQChIyaEMoPyn71J0xbTWDCYfPwMtnqRkAU6XaE+9x0mbfjMpQixRIqMFo7QHPlo7/V8KbFDj8E9QVl+3Z/+3oyEXl7IllDGjWjq6wBm1EZMIVmbtgeXjexT1PWiHUPdQ0kR8e+HegGL0lhICD1h7XEtYUafUb1ddhhkHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org; spf=none smtp.mailfrom=jookia.org; dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b=qDReuZwN; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1711453692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5NiU8SrRvzEhPUZ6dRGyNb0sPUWcZywjTyvLXnPPhjk=;
	b=qDReuZwN3nrUyVjAuIWjRIzZfloFZ4MU7bD1Ew9vB9m6XHRQRwszFsitqgFQ+s10CZYkNp
	idjYvCnazE219txqs1kGPNiTATR1lccgEydGt0gw9po1sogNhQl9AHWyMOd2uPa5qQtUcI
	w78kKhDU/NMstoVwOji1IbcRDD9IQrfYws0i0imJbpGWGnz2JiqTj5FsA/wknze7J7yZBC
	Fii6gJdwa4ppOMfLUL+lpQki/RfBzNbTf1Y+BNurIOfbtZHjKWyULbJzhy/4Yn7xZdKyqT
	CQhrMYTZQPJStcowy+9OR3obWTv+dsklNPeHzjwmjdpFXGGo8JWgWztTUBFggQ==
From: John Watts <contact@jookia.org>
Date: Tue, 26 Mar 2024 22:48:00 +1100
Subject: [PATCH] ASoC: soc-dai: Note valid values of sysclock direction
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-dai_mclk_hint-v1-1-653cbd2d78d9@jookia.org>
X-B4-Tracking: v=1; b=H4sIAO+1AmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYyMz3ZTEzPjc5Jzs+IzMvBJdc0PT5KSUJANLIwNzJaCegqLUtMwKsHn
 RsbW1ABjvwRhfAAAA
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1711453681; l=1310;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=ksJEpKNewmNmslHJnwfsm7/NFw9UPD2T7IztjcDkQfA=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABA8uxXLeHvK+2JawLBA6msgjO
 K2YehwVQKZcf8hjQbFSosobFfeEHYLxNjkH2s6bKWV4l4LdXyOZBhldj7WvzOCwUAAOcr
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:6LBQmZH5u7i/edmEZXzCTwCrpSevs/ZshZxNmlD1thY
X-Migadu-Flow: FLOW_OUT

Clock direction is marked as 'unsigned int' but only two values are
currently used in practice. Note these down in the documentation.

Signed-off-by: John Watts <contact@jookia.org>
---
When writing a driver I wasn't sure what values of 'dir' to check against,
so I decided to note them down in the documentation.

I'm not sure exactly how correct this is: All the drivers I've checked use
these values, though I'm sure some code uses 0 or 1 somewhere or something
like 'if (dir)'. Maybe changing to an enum would help here? I'm not sure.
---
 sound/soc/soc-dai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
index 6f8773a8fc05..fefe394dce72 100644
--- a/sound/soc/soc-dai.c
+++ b/sound/soc/soc-dai.c
@@ -45,7 +45,7 @@ static inline int _soc_dai_ret(struct snd_soc_dai *dai,
  * @dai: DAI
  * @clk_id: DAI specific clock ID
  * @freq: new clock frequency in Hz
- * @dir: new clock direction - input/output.
+ * @dir: new clock direction (SND_SOC_CLOCK_IN or SND_SOC_CLOCK_OUT)
  *
  * Configures the DAI master (MCLK) or system (SYSCLK) clocking.
  */

---
base-commit: 72fb52fb0ac44b6a1edd9bc390e44bce3acccd26
change-id: 20240326-dai_mclk_hint-715cbdb09207

Best regards,
-- 
John Watts <contact@jookia.org>


