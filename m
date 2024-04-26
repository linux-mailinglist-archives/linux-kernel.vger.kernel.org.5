Return-Path: <linux-kernel+bounces-160396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBB68B3D10
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D801286D21
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F3A159594;
	Fri, 26 Apr 2024 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="L9AWgeSI"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06CB156864;
	Fri, 26 Apr 2024 16:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714149944; cv=none; b=tx2JS0LUz4y/n7mJvH/FLxL+3zv17hsq7ByjKZm9ZZ9XfIPlJTq6UGEn0lvD3anLP6ha5qmlDX0uvY6b8zfnnHnGb49ue+Ex0sR6Y5gXbt6LKCRo6elgEOWOJDwcKr5c/1/sIJ/Ec9RnN41CJgS738xZK4M0m6O3mMsyqcuAi5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714149944; c=relaxed/simple;
	bh=BWiNAQR0kk9MlwuLqlIFDUam7QNyQFdGCYiRzpErVZI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=iA35YmihamHJ+NdhtPjFmEv0yCZjoWNUODFKxn0uX6DI9HaOnp4IeYlTZlIGQsratGyAdwHyzkAiHv6pNPwR3bALiVyEX/s7FOu6Jq2tJXTXFZGHq5b9KtAPZJNJF2FqKCLAPR3JhY97OHGalm5ahki3909py9yQCSCmVgmVD/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=L9AWgeSI; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714149924; x=1714754724; i=markus.elfring@web.de;
	bh=Ta7iapcZ4MAU6sUXpFC3J1kL+68fZ5RvxKZGHV8GWPU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=L9AWgeSIfNXg4w9sTuDvrY6R4FnGwhv97VenytR2x0iHXzTgyb4W0RL/Mo9JYaWW
	 hOyqZY9Vg4DrsTZo3ROjpbW1YjpnPeLANIfAQvPounSAWV8sw4dz0t7/iqgN0J8hH
	 N7Hypg+mBkbqGmLXZUW9Fzmb2PFpgOs/xf41Zzc8uCgxJY+yLeTz/eSHOmWhlyP6U
	 Y0sI92flOjKmagOCHeQ13twmKtEXgJ9OjfZLfaI8sezWI2GUhxvslERltmnAYP9bk
	 +lCcPw/Ju0dgE3JkIunFEWqoR9kdciEKxNDpKd2E+TwtdofSmMOhWv9aQ6gvxMZXe
	 xyCAg4a0IwHNaZUcTA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mm9Zc-1sQh1g1LxA-00i8ug; Fri, 26
 Apr 2024 18:45:24 +0200
Message-ID: <77a68fbd-5675-45e7-b563-883e5c0643cb@web.de>
Date: Fri, 26 Apr 2024 18:45:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Masami Hiramatsu <mhiramat@kernel.org>, lumingyindetect@126.com,
 linux-trace-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Steven Rostedt <rostedt@goodmis.org>
References: <20240427001843.84a3d367d3654b624c09defe@kernel.org>
Subject: Re: tracing/probes: Fix a memory leak in
 traceprobe_parse_probe_arg_body()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240427001843.84a3d367d3654b624c09defe@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5tA2mW2BCdegRfc+c+UzeRIrphlRDEl2l46CUEVublPggoWf4Pt
 2Ss9IUGmd8vO4yvFmxu3X4nNe1AbONMMyfD7SIr3YQPeh3yYF8H4vvhfg1H/4Wb4PyWt8SE
 8OMWWbsCFpPVOfK7C7jWC7C+KIr2It2LrG8EN0bB/PJ6jZLsT9FHblpaVdphe/qfAeKhwI4
 9Et2Y0hyqRVyt9FfL2tIA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Hln/nMIYN3M=;yIlkHUwArz6DBu4ioTjjDvF5YLS
 keoW/Tq4qS7IMfdbeK/33cTmWquD/F745hBhi9/YlVF2SvDuhtYTui4y7M7+FxFwkGIrbhC2I
 lfhTqf1h55/ZjpQBVwD9tMQADD9arE2iY12z+rxqUdcibepGGjkuedYWAo4G43lzO/AFBR2Vm
 r86NHVEY+WbHSzishInUgp51MI4KcRlVUoK//2aWCl2rUGT8m7kYFv80yw1epb+njgylCXesW
 Kp8vAzO5J766VKhTnNCWp2p1anTKl0tfIOEzq5kaHnZqJSszITCPVuFrhhEJhkOZIVhd/c+ty
 WXUWonX//OtOpnMxfH7bAkPJ8ZpUkuMZT9jrVWqT3ZhLqS3c3CsDVVx459E9VX8VxvYA/NlFt
 pFe+0Oe9z+gMastLW/PX4ND0GBVfp0WnfnYjZyuKqF98d3YSsqRsaK/NNIdadZmwkgxTeCUow
 ct4zaJhFjjZcb1pk89FzUFUaqUUqQwCdxQIagVFNrIl9oF4mNuIEdF1VyU2ZJDgH+oaPDD3OS
 n6mhT65I+fI1NnXQjOstJAQ7eqdQQT9mai6yuPSDdakIcezCppY/w2sPmxHDtRVdwI0RwTora
 JBNt8Uy9jcWrtYfNKDQbodDaG6eiMNSLMPZihn9FZ+Q3vF4ebX9wToudHEWjy0SNzRPZoU0E8
 Fqgn0gC4IAGG5SgZIyOosd68z//+6Oa0lnTHB1NZTu9MI5joD8Wrg+42a3jqdaPsA/+STfQbc
 CB9MOqZxtTj5rrbvpTZLOCurK95G5BM6BB0DWJump/uTKO65iqyUeAnwor+BvRMiO5zYaYP4p
 WQsg7qATY++R+Pr0nejOcAWu9zJJTjCjm4LUAb6KURSgc=

=E2=80=A6
> ----
>  If traceprobe_parse_probe_arg_body() fails to allocate 'parg->fmt', it
>  jumps to 'out' instead of 'fail' by mistake. In the result, in this
>  case the 'tmp' buffer is not freed and leaks its memory.
>
>  Fix it by jumping to 'fail' in that case.
> ----
=E2=80=A6

How do you think about another approach for a more desirable change descri=
ption?

   If traceprobe_parse_probe_arg_body() failed to allocate the object =E2=
=80=9Cparg->fmt=E2=80=9D,
   it jumps to the label =E2=80=9Cout=E2=80=9D instead of =E2=80=9Cfail=E2=
=80=9D by mistake.
   In the result, the buffer =E2=80=9Ctmp=E2=80=9D is not freed in this ca=
se and leaks its memory.

   Thus jump to the label =E2=80=9Cfail=E2=80=9D in that case (so that the=
 exception handling
   will be improved another bit).


Regards,
Markus

