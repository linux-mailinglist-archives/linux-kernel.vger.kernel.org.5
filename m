Return-Path: <linux-kernel+bounces-98509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD199877B25
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF381F210A6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 07:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631D5F9FD;
	Mon, 11 Mar 2024 07:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="r8XyQ3kw"
Received: from out203-205-251-73.mail.qq.com (out203-205-251-73.mail.qq.com [203.205.251.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4165D63AE;
	Mon, 11 Mar 2024 07:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710140788; cv=none; b=ZlcrCCbenoMo5pj13f73pg8gxy9DTt5B8n4Mxs8l3Rvwn4az3kxRJXKU0QX97zZRsDO6AdwXaDPPXQzqNQz8D/zLncEBHnjE1Ej+BbrfZKml9WUpowJ0V7gUU/2ruc12uTIGUEr32W6MLmyJyKfrcm66UDHhnlvMcKWm/1mCnCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710140788; c=relaxed/simple;
	bh=iU0B7oVdYRD3BhveLKih3H4/+mbVUTEDWz+MaSwKAa4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References; b=lgIbWVtJzs1FH/znRa6yhxZOxmtq3FdfjY4t83CKvZ/Nbi/2pKw6NRzZufPgfUnkA778jr6FKP6ljrl/STK7+/RtfCWNRYGs36YTfgjULx1g0B+GX9NuMrQG3GF4bVvOwSbk7h5rBw9JVjVWlh3NRqn9bW4MeiBLF4QL7gAy3PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=r8XyQ3kw; arc=none smtp.client-ip=203.205.251.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1710140773; bh=DqF6IJE/etcDmyhMo12vo/H9b+vPvvKr49SpjwRCc4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=r8XyQ3kwiwDjS5cv1fm4LyqMBPWKU6zktk7JRoevHfH9Tj6H8u1nJDzDKQFelGkDb
	 ergk6kcmEb+CBoE6doRqVyA7AmOUgH93Rr3sULePdhsKx+Y/9AAIs+hVWybGMa2cj0
	 fljVdY78jY8lfskkQKaYgBYIMtztlDLLz0Y3Tq/w=
Received: from ubuntu.vimicro.com ([121.225.188.5])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 1730EAEB; Mon, 11 Mar 2024 15:05:51 +0800
X-QQ-mid: xmsmtpt1710140751t40mlgap6
Message-ID: <tencent_8A7C0C985AE1A1975C25D8DE24010D8B2007@qq.com>
X-QQ-XMAILINFO: MO96tf8oLeWlcKKMCzcDopUHvgcH+0fyeyZywUfPwD6g2nSeDknXIRQf5bqKyh
	 /8BpRFYz4v4OV3XC7fqbVxyQAPLwS1vPXVi1KqSzM96cAeR4YQHhGEooYzNa+8pj1NA7gbyFEi7A
	 G//aIbGWOgEPHkVUhV+HsAOSLVFpJyJTtmEAuy+27iCHPVWQ2dWi20A9Cd3L6Ar5vu6Mxu9Des4e
	 POOAgd3+9/mCGNVYEPNvZIsujl5QmY8J5jl5q7tMZR1SEfQVTuq2tz2Dt8NZ+oDuPzaYBU1cIxQS
	 qE0SfV44wmUmRkOkXdvBFiy5V3GKLsFRF6nn+fK0vcCJridebtVgDIbyZFH8HAeKKjw3VdYmO8yP
	 f/3hBnG5UeN6pyQcxfNaEHIlTq9BUmduL0LI/s5C6xReOpXWEaYmPAWkPGNjy7w6hOVe4dSYm8Hd
	 xwFqKci6XAm4vzHWFAO8+/UiltOJ62Fkv8DOOfuDhfTSdBmfsnQDEqhRbSOEykT8dSOsD83T5gNV
	 SQjZPDa4o9rhEMgt6O2AnbDTe6FN8dlhmCvvYTZVceLX3hp0xALG6mBg+nTX4Bk4H0iwvSvX0taL
	 MKYMhSCHfj7PPuiDX6FM1iA6lpOBRwqTE1wflUAgwMo5Ccz14oGZ5WPeOEy9RSNBVLVF4TNel5EL
	 Erb6drN4XnzR+ovick34UXSLJqlDuzKfI3B3fRvqSOoKLa7NxdYBhIC7NeLpDIrTV4Py2s/mJuxK
	 nlPk21ua2TwNO5eID8cp8TGkDtf17yMTuTpuQLoB//7L85sSr4z4JSeesmZvbYLx3JZZ41+8ZTva
	 Axn59opiO7WU+tZNnPV2fdV2kXoz8he4GB+10PRrWvx+hjsuYj1/oET8TENJRiwOB+X6kk8nDBnX
	 RM666PiaU6M1H707YANRMpeNLY7PEbIuWKIvJk3CSOj5e5eNubU2ikHfU6v4lHt83VPKvSOSiOy9
	 /aW7vdgsU=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: xuhanwu <2433926602@qq.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xuhanwu <xu.hanwu@zxelec.com>
Subject: [PATCH] ASoC: soc-pcm: add a check for unsupported commands to the soc_pcm_trigger
Date: Mon, 11 Mar 2024 15:05:48 +0800
X-OQ-MSGID: <20240311070548.2925-1-2433926602@qq.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <tencent_002E3C6C67928986481018466EEDF8D05706@qq.com>
References: <tencent_002E3C6C67928986481018466EEDF8D05706@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: xuhanwu <xu.hanwu@zxelec.com>

The function soc_pcm_trigger needs to return an error(-EINVAL)
if the cmd parameter is not supported.

Signed-off-by: xuhanwu <xu.hanwu@zxelec.com>
---
Dear Brown

Thank you for your guidance.
The issue with characters exceeding 80 has been resolved.

>	As can be seen from inspection of the immediately
>	preceeding handling of start, we're deliberately
>        ignoring half the values in each switch.

In kernel version 6.2, when the soc_pcm_trigger function receives a
command parameter cmd set to SNDRV_PCM_TRIGGER_DRAIN,
it returns a value of -EINVAL.The function snd_pcm_drain checks
the returned error value and exits accordingly.

kernel-version6.2 Function call relationship
		  snd_pcm_drain->
			snd_pcm_action->
				snd_pcm_do_drain_init->
					    soc_pcm_trigger->

    snd_pcm_drain
	result = snd_pcm_action(&snd_pcm_action_drain_init, substream,
				ACTION_ARG_IGNORE);
	if (result < 0)
		goto unlock;

     snd_pcm_do_drain_init
	if (runtime->state == SNDRV_PCM_STATE_DRAINING &&
	    runtime->trigger_master == substream &&
	    (runtime->hw.info & SNDRV_PCM_INFO_DRAIN_TRIGGER))
		return substream->ops->trigger(substream,
					       SNDRV_PCM_TRIGGER_DRAIN);

In the latest code, when the cmd parameter is set to SNDRV_PCM_TRIGGER_DRAIN,
the return value is 0. If snd_pcm_drain finds that the return value is 0,
it will not execute the goto unlock;

The above is my understanding of the code, please help me correct it.

Thanks
Xuhanwu
---
 sound/soc/soc-pcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 77ee103b7..eba737729 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1173,6 +1173,9 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 			if (r < 0)
 				break;
 		}
+		break;
+	default:
+		return -EINVAL;
 	}
 
 	/*
-- 
2.17.1


