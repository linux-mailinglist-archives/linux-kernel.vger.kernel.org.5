Return-Path: <linux-kernel+bounces-162401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4A18B5A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2561F215D0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B9274BED;
	Mon, 29 Apr 2024 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="h0/YhDaz"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB24B651B6;
	Mon, 29 Apr 2024 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398944; cv=none; b=fSK0XtiF1odeoLGO0IrJbeud5lxybakyJohiThX8KZ9kjTx0nd4qtEItTyxvVclHEEND0x+lKH9G2m0XAQmh/nrgzAkGOgE7anp6hFymK+uVVcYBKDtoeWSkKG3jlVFKE9REShV37haWnGD/HnVcNJDDOslG32oEn4/0z9QkARg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398944; c=relaxed/simple;
	bh=XSJsf20eNnV7BEcDZzdsGnYbMkeK5RV0qpSiv7XC7ag=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=m0Yp386VGSHTKSY+NyKh3cHnMbnKb0eTtL2wfpUUmzwNbUvDdJ1sggG6ZKC3D9ij4TYfshkAA0nHI7SCNXpzgDasZcvQAf1NB0/OWc0BpDbMwdaukgR9lU3mMPCoU/rbGDsIchtkQBtSP+ULovO/3t+iLIjJb8v5PI8A7zZiagg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=h0/YhDaz; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714398913; x=1715003713; i=markus.elfring@web.de;
	bh=XSJsf20eNnV7BEcDZzdsGnYbMkeK5RV0qpSiv7XC7ag=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=h0/YhDaz25fEFbtdMS26njkuwDuciPI8VpioSVHR0OOLexol0dsf2W4evlR46f9i
	 Ac/7BlEqvcC7XKaCl43wsaZLJepSQA+CvlXe9zNbqg+yOvUhcRE6munMsq1WBVsBM
	 DSjDZ9iTPiZ/JKlzOnWyWfaEIWoom2KPH4I1nIgAEqvblIEVHb914Q9TEUgwIDm5E
	 +Xtu9zjSiJzCD6zzpZ31cdR79Qslo/vw+35K/O8X8vHChkyFZZ8qiCsmNN+NH6rID
	 ToEzjXiMSnAW06nDozoY/m1s3SVxu+Yyst2f0uMpodcghDph7y2bB+HuLP6oO+/aM
	 WrJykArcgmCmpS0CRw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M3m5B-1s0cGA0pLX-0013K7; Mon, 29
 Apr 2024 15:55:13 +0200
Message-ID: <909dde28-019e-4f53-b5d5-a5fe9956dfc4@web.de>
Date: Mon, 29 Apr 2024 15:55:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Masami Hiramatsu <mhiramat@kernel.org>,
 LuMingYin <lumingyindetect@126.com>, linux-trace-kernel@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Steven Rostedt <rostedt@goodmis.org>
References: <20240429222941.12d3b774bebef484e605d095@kernel.org>
Subject: Re: [v3] tracing/probes: Fix memory leak in
 traceprobe_parse_probe_arg_body()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240429222941.12d3b774bebef484e605d095@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V03fvnGC5qRcKCTwAHkHSloSGt/P+kbUlcDGh/owlakpddJI8KW
 PSCqzuEGuuls4kplrjUM6rgYtAszRo2NZZ0c2vAt7kWPJLz/EB25IDC4Jasipa8nq8MQYml
 5wlZUDAsjEOsMKCJCPNXFEQM5yoqwLtc991q85X2YQx2Mq6Aj2aSVbaiLXFOQ61SQY82F4Z
 k9ikhW+eOFzqTsqc3lWIg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:w3epDiW0+Bs=;8ajEl4URGqBFwrxqcgtygi59WkG
 h2vjmIX2M85jI0nuBQMj43UTS+1lVrPOjDoO1j13mt29CKwrDIcGNDIqDbVM41u2/sI00zMGY
 C5SVzRIldNurkZ4GElO/Uh8YM4HsBwl3PxnTPhSv7CWr2L2n2NGOXWq0MFfl6ybD/t6ZShXJP
 2LxUQhdaQL/jXaFaqYEM4CVoQcYXicuzOtm+bTmigdvvJVIvDWiSVrh6srO7wxlVg5syCOYXe
 Ar6wwJvOkn97iEsj4FonuymwN2zk4LVeih/aHK/vN7lF+/XGhnt8lZJz6VaKlJKFl1baoTS9G
 YFIShydCG3F6Dhqwrko6q9pQTQRqXDionRm4ajR/b8H03BXs1bDbssdg1OrJBqc+43s0irvld
 2a0z39JEqBbiYWUQAHxZxmJvQsCSrK8BXYROpJLvlyz/Pw60E4Q2+UYhdI2lbMVYlACxwtoJk
 5hQLREOebzA/YblpEKNyl+Ew7SG0j8hgBW9qD7AnYyQgNqeS0ZwfILXe3gXt0ARnkkUf92q3g
 uvrz7T7gjgSXZA+zcaxw5tdbH05HCrc9krAIMiCbf1d03mw0bKh6ZsM9Eay61BxpvzZc2x5GN
 NXa+lmt9ninWJHMpUIeHvcYS8cizkFf0hbtUFwL+I7oqfAb6XRGK5cuZjMThD0bq8WucQrVgk
 ENdtDka22ZfY3Zx2VYnofmzNRlcFSo12+SzcD3m8933hBiFHX4pl4JoZVzc+CQZnGJzLIq6OH
 vKpYfn1LnDITsmbMGrGKidKxtTFd+HJkzechuCcfcR4TGu0QJzrU+8sonsXqjE4S36jroX0Mj
 Ju4wtuzY2lCeCRDwswSBvt52DMQsTtjajbP7cypjckr7c=

=E2=80=A6
> > it jumps to the label 'out' instead of 'fail' by mistake.In the result=
,
=E2=80=A6
>
> Looks good to me.

* Do you care for a typo in this change description?

* Would you like to read any improved (patch) version descriptions (or cha=
ngelogs)?

Regards,
Markus

