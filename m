Return-Path: <linux-kernel+bounces-160922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD51F8B448F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 08:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88E21C2114C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 06:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7644175A;
	Sat, 27 Apr 2024 06:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="tNag+jeM"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17A039AF9;
	Sat, 27 Apr 2024 06:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714199818; cv=none; b=LqwVQ9HSmzG5udYoeAVBy99DNyFx9aP/4E/cmc9kGpvmgjnfKteoHic0jU4VexMnw5oj06hVTKQqmjItAO7r7wKXja+wI/XAuacqfd2JChbakLO5V9HKHgAtRhb7iMgKjmlu0euMFQEAmUyLu+fK/nNv0u6HH2pm9eEIWULv6Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714199818; c=relaxed/simple;
	bh=HSKhQc6ckcGem0dz8qIg/OUHhvnOqChu5U7keQ38ZIg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=XdvsgHbl8FFg6/VKTx9QFgS91ikxqdfaUzyDPzzAGJs9lUM8yb4VOjFdmyS250Dm4a3WdAyKf/aBgtWZTxVijuo8AmhmptIk4zHkCz2x7YaD4ILwUMR8OasP7XGg7sIZUOasoX+M5DX9QMflHbeYZ8O7fEvRFJ1oCkZXcEmIX0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=tNag+jeM; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714199795; x=1714804595; i=markus.elfring@web.de;
	bh=Yqjkf7H0JSFQpEQ4/+tdhmqoI63l4XI1RiiuG834KEA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tNag+jeMgnSNOhv6sovKbWDqS3fEQ/CQwTBgBSL0L43jHbzyFZSPtYXW2XX4qKQl
	 NL4Y5ykom1G317bseGi/EL5Bqis8ugiLYTrgbMYSkKfmf2X8/Qmy6E4UlBBvrHuSv
	 U1WGXZrqxbursuTWac+pse/ElyhsU0QJgZq8qPNDlL86xc2HfzikRq9FFBMauWrSh
	 qVNBZ37FTuMtm7V+h3ULXFCgi3BLZUel+kEbvUnKYpp3SRqdLhEe+hZH8Hm9vkAgu
	 0dO9JdzwmpM1IVRUVtwWbqUrxiC7fTqVvZesu29TQq7RxjTnDl9ypywDpkZ9/9X1a
	 Ajf1t9SGoLAwOYhq2w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9LEG-1slqYp1hDg-00ri4O; Sat, 27
 Apr 2024 08:36:35 +0200
Message-ID: <29b2bd7d-303c-4ac9-8638-38959f177316@web.de>
Date: Sat, 27 Apr 2024 08:36:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: LuMingYin <lumingyindetect@126.com>, linux-trace-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240427025720.1321211-1-lumingyindetect@126.com>
Subject: Re: [PATCH v2] tracing/probes: Fix memory leak in
 traceprobe_parse_probe_arg_body
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240427025720.1321211-1-lumingyindetect@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uGlf/lKNskOomISg1g58Lnnv79W7jHlElge4NaHOfwNxFN2r9yo
 HHeX3mGvqhirUz/XKB93Dqn97owdFV70XPcITcCT0rr7VuHp7j4THmyEatGl2ymCj1hjvy3
 Dv2m8ZF+S+cNPbHM/OT0taTlCguhNtVTgnI5Z1Jl4JTiaMwQN8SXeztkQkO5gZxu0LzkBhF
 qsNy+QMy+bDuV0S4X9Lew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LKMQUbkQfbc=;u43u9kSrPjt8jg0ya98W5ZyQT37
 UZ3hghvOW+2yrkFPx5LRpGz/Gz+OYLiwXtjR0QAGaBIhnqdoK3eREVPuRoJJ7FVq9/P+04WbT
 6kZUIjACYlqoAPgYzLTa5Y79dirTWAqUNB4E5eZloQg2GpyTQGzVhOJghx7LSxq+NPcB2ND16
 lFffuWnmSYF6bqURjqQMMTFFcIFZV0B9uLryncE09Pvsz45iRtvpKN+xrBcRFAa6UxwaatMFD
 Az0Vm8/ZBnIV+E9d56Wo06mCFbyfq2vcbcPZCu/u8eLi9BnWMxTn2YLyx8EmEraZKiD/RaDxt
 T2sl95b/w8+DjFZv/OoWFFi05rOvOr6rnc7963dHBglnipgt3QflDAKEV7Zbi2O9PO3vAzHzG
 slweGmHo4OHyf30Cp8PyE633RqAC1vcJP3wg5eS5+OmVvv5x64t488BC8wTcSCt/gv5Bqsyro
 /GmjO2DUGbVwhIynTcYbcmz4iYODHNsTbP2lgVFIW4M6BGAhWkHGKnksuMNxnrMHiCYkTlhie
 2syoLl9bmPk+0KOL2AsVPnPljVMjV7FNI+7iOhwe7W7zvgsxDHztgQZR2zfE8Kz+tjwAb8KzM
 an5YnGxL0Qpf1WtM0iBk0r2q15wljK/DyXfVtmI7hFr9L5f5zKs/gWbxPt4zYug6kfqlq7sk6
 YhAM/ksaHorpkvIjiUkKDiu+uOgbNdcqapiJbbkg/CK++13cuHhHFINTTN+xAyCVVALhzrQ9J
 Xw7eQfWQbR8EH0J69NdhPlCPXOd3h32d7BJULon3r3xjjeZrb4Rg/g6rHW1S1fMvhWnOL/AmB
 NrYRl2JaIvRf0Bn2W5kWYtTEB/iwC688C8CAthp6Hc908=

I suggest to append parentheses to the function name in the summary phrase=
.


> If traceprobe_parse_probe_arg_body() fails to allocate 'parg->fmt', it
> jumps to 'out' instead of 'fail' by mistake. In the result, in this
> case the 'tmp' buffer is not freed and leaks its memory.
>
> Fix it by jumping to 'fail' in that case.

I propose to improve such a change description another bit like the follow=
ing.

   If traceprobe_parse_probe_arg_body() failed to allocate the object =E2=
=80=9Cparg->fmt=E2=80=9D,
   it jumps to the label =E2=80=9Cout=E2=80=9D instead of =E2=80=9Cfail=E2=
=80=9D by mistake.
   In the result, the buffer =E2=80=9Ctmp=E2=80=9D is not freed in this ca=
se and leaks its memory.

   Thus jump to the label =E2=80=9Cfail=E2=80=9D in that error case.


Regards,
Markus

