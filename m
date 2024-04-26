Return-Path: <linux-kernel+bounces-160273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEC68B3B31
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD68C287947
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9861D15B0FB;
	Fri, 26 Apr 2024 15:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="mTCujyM0"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D64114901C;
	Fri, 26 Apr 2024 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144774; cv=none; b=XQJKDZjRtqSB/1DX+bpgRsBWsUd91yS1+TZG2ZQ9toM6PkPBtA5FPjRkOXEYH61OfpYrLdu2as3DF/S4YjoAZOu8MgiIH23YB933fp0y45EJ8WuDymOt1eb44mSbIvmLdp+fRJ92ugwn4pHq7uh/U66bGfHl1L/D5H+S+8NpL+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144774; c=relaxed/simple;
	bh=vxidtu2EwXjRXAhjK64ieOGkWMabWQIvC6Il/Dcmuwo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Ipnd2nqPKV818/4b2aW75Cmj8dLKjJzRwvQ6JUCAwBI1nW/2SJ8P6BAUd/D91PNajD9xQ4As6IY3XRXw3BTIbLgB/rhLiTKAK5P6S7W8ZBhjHcqwv6C/493ZhSSfVDnRjL1MOcfYNZ+HbuHxhQDYslseKD2JbDzKGfjWcapHl4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=mTCujyM0; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714144741; x=1714749541; i=markus.elfring@web.de;
	bh=vxidtu2EwXjRXAhjK64ieOGkWMabWQIvC6Il/Dcmuwo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mTCujyM0oewNuoXHvx7VcyZ//4b/QOs7jf8jIT8FQU8GhANIY/BzPbECljQmBWLB
	 T0PacSl34ZmmdTKRWXxW4mhYiuYm6AyPC7P/jV/TVkhwLOnrYRQ0F6sKHHT46Bg5R
	 NgeKkTE3WcbTVOS1vKLVgWuPwCa9j+2jVpzKoIuTx0ggIGKZOCwWZabMSVM1NXtgA
	 edK2qlp9LoHEJQQdNcC5nhS3MoNqMwhSz34Xpm51oVV5idNov/46sW+m4l2qdOFcu
	 6pTftFSwGD+P7MPlXFdP3YoOGa2DHk+d7aP7OjdX8SP5bry9/WOhe2my13dXenvTj
	 UX5VIcKSU6DBpaw6gA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9431-1smtAA3783-0169wT; Fri, 26
 Apr 2024 17:19:01 +0200
Message-ID: <0c3cb2a1-a0b3-4a98-9bfc-3bf540c0eb78@web.de>
Date: Fri, 26 Apr 2024 17:19:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: lumingyindetect@126.com, linux-trace-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Steven Rostedt <rostedt@goodmis.org>
References: <20240426091343.1222770-1-lumingyindetect@126.com>
Subject: Re: [PATCH] tracing/probes: Fix memory leak issues in
 traceprobe_parse_probe_arg_body()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240426091343.1222770-1-lumingyindetect@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m6aIXWBUMnVwzLp30Zzzf9uS1KMKRZDZ4MzulBa72/k4CcmUebY
 4s0Ehh5JSYtre7wZPwQjFdzyTXr+67wIFXa7k1ZDRK+PY4TrcKtvVkNLVMOmjswV2tRKNCh
 K+ubcsXJLD02iDZ+iyfxOHzVTCxPt4Ld1k2PB0cJS7eqrmvirwZqan9FNkjmUIJcn32bv4i
 WcNpBo1+W8ledRrG34HTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ClBff8ldaUU=;MeOJKjlOUSdZ4oxpAHnlRDxBb2X
 tgV7Dk6mq79k6D5LD/jIl3g5lsLcMGxX0Hxjhhasha2yrbmJNJrFSjg/VLaFJD/4YCufbmJAg
 4PlCKRNempEXpLyGzMRlNqobBRNXxOuNcY8L+UpUv0k5h67nQqkQ84o+ekHOGG3vMK2EbJrUj
 zLA7ouqu0cEmvEEgvlparnWYPCBNNnC7xSqogsipjGtEXTDDdTNEvUF29gRZ1Ww9avIjZqmbL
 B0Dvkn878Nj4DSKz2dncXqYNL09ZXkjiUnL+ypw6OzJD8J5zRNmYWYjeDDH8R4fx+WYVHyjTJ
 9LMLBV6MbtV4GuLHMInnFbujEk3CpDSTaA8j/0AvbqrhE7MPIu+/LDO28XKkLkTGZ+5GBLlNW
 6bGI1ZrKX1OET0B/j3X6Owkr1f9ClKA4+aySNudwBLgj6IAK9K6fSAzdtqyQPoU8vgkHjuwRz
 hMrWv4/0tisuqRsRg8aRRWCjOU+tmUTxG36L9ppeMeH1x2KWGzXUOkTpQeJSwHh68Z5kr4tzx
 B64HuMtnSCamrNNjhqAz0RvwdE/I03W/bMygxQJ2+lURV5zd8RDhOxhFviSsjdw501gy66Jq+
 6WLHB+xM7C3BoT4BI0252TXx9J0MSk6aOknKgriq4DWCONEvTOx7GKLffP7oiyNuMq0Z1E9c6
 soPiX9UfIuG7zDMl30ncvQ07D/f/kNTBM0uCTWEgJdm71fMw9rBnE301MkVdydE0EJRh3D740
 gEmn/oYu5G68awHk8wS0ef5vxBgjrF3627Exiy9Wk0f2kzilrtXMZ44CdiwCT7WzXsAgcwli2
 3vQ5PVqZsTU/vvJ65fQBfnaDDw0OhMlsaAGEKa/XdIaSw=

=E2=80=A6
> Therefore, the program should jump to the fail label instead of the out =
label. This commit fixes this bug.
>
> Signed-off-by: LuMingYin <11570291+yin-luming@user.noreply.gitee.com>

Please improve your patch attempt considerably.

See also:
https://kernelnewbies.org/FirstKernelPatch


Are there further change opportunities to take better into account?
https://elixir.bootlin.com/linux/v6.9-rc5/source/kernel/trace/trace_probe.=
c#L1403

Regards,
Markus

