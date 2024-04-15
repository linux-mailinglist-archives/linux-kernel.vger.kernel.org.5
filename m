Return-Path: <linux-kernel+bounces-145570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 981718A57F3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4C7C1C20A89
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C66E85260;
	Mon, 15 Apr 2024 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="k+8pj30E"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D791984A23;
	Mon, 15 Apr 2024 16:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713199035; cv=none; b=GsQnqzfiQ8FQsVG9GEDddFMwyVdwXfFJizEwBzsKL8Mbd5E6EmcppDph6IVjn5Sfh8Rn11rkGQwH+iZ1T7atG8rXMDP9sUubIl4xDuiaZ0t2mms07QuSGtmySR0NYlYRK3zz7a9xENpbex6yhn10EfAJ4TEf0VphzNcetD4gREY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713199035; c=relaxed/simple;
	bh=vhYf6guI1O7u9dAK5aGWMDqew1wEZWHlWA172sd6erU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=mSRx0xO1WjqKvrZ7ikN89Cmy8w0NbjGkCXVn+/+ALkiVs/ekC1UB2L4LINpn2f8e0k5KHNMzAK6LY2CqMZW76b1KtvH7772z/BVgxGDwAGJqIKHQSxgyqzOlVMxtgnbF0jNmcuKtlyum5HloooYGTV/QsxpcFFSUHPp1gEi+/Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=k+8pj30E; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713199018; x=1713803818; i=markus.elfring@web.de;
	bh=rUHFv7hYTYZHryZJN+dw2KYFFC+hUd/h/JV+c50Rk6g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=k+8pj30EHWFTg2vPtZtYGsvdlwlg6dA4NJhjDzZA/dLP7QemXa1OuFNOHHl55xP7
	 D0fbvUIBN8l52Ql7+P28K0C/MUQzd0+pJ3wSXq7hENcpScghA5ea/D3OrdFMOXDGz
	 EEdkLZ3O2R1MVMXfOYuksZ5xYiVWImow9MYCqM3BDBssWSmfcGGYPdo6kmiWgFmDX
	 UItTrGdndzZgHznQDRYgCCgg8jwWf+7q+v/euuSjn5IMR0J1+zXeC9FhPdb98qJoj
	 LQgmtCp+Cp7o+L74NbS7SCs0ryelB+3/P4XiGvOz8IlcmlGcZsSxgx70Iyvxm5iXP
	 DIm8w82FjTZjkUTEig==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Md6y1-1sW0vR3Lsp-00aEKI; Mon, 15
 Apr 2024 18:36:58 +0200
Message-ID: <0f7821f8-63f2-4cf4-8865-1ae0aaf42897@web.de>
Date: Mon, 15 Apr 2024 18:36:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zeng Heng <zengheng4@huawei.com>, linux-gpio@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Wei Li <liwei391@huawei.com>,
 Wei Yongjun <weiyongjun1@huawei.com>, Xie XiuQi <xiexiuqi@huawei.com>
References: <20240415105328.3651441-1-zengheng4@huawei.com>
Subject: Re: [PATCH] pinctrl: devicetree: fix refcount leak in
 pinctrl_dt_to_map()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240415105328.3651441-1-zengheng4@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CXzh8Zjhgjw2ckngfzx4BF0HztIYni+4xFLEUVzEw8AscsoACLN
 rQu7uyD2ZwHoTtPbFAviXKdUY81ROLPmCfibWAfSQTI8HYeCIUUrVJmVESlqal0gk/cDnGj
 dbB3aXgEv2oz0pl5finSlISfesDTqt80AbrMtRGnVzHBwq73zieb8R5xLyQfNE07YltdkJz
 AA+s8fV8EBFrH7xUOesrw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Aujf/A5q5vg=;d1vHN8azuLrGFggQg9H3eCGHuip
 hFRL8CIohEdEgPciT3+yAOGxwW6oNcTWqo2CXNa3KTRivkNUmgoGA+oRyUE9oomiFImZ2yVg4
 XsDHhtQBIZRKzf4WjzLGHseoz1EX6rlzkhkoAdwbrfWC7mbZzJo/YcUKkTzCqu6MZ+rhBy/uM
 c6BNN1zK8QyG+xsIODu9JslW8u9XbUxpXooCVhJ6wgjF28YFhPpIdX15JrjcWtvPYKKbnMWef
 hhx+4KFPwL64aIJt2nBx6fvbl2GnTDL2uGmtsP7t2Q4o/oo51WHsFn5U2URTcsjfI8xTN/aiU
 NRphXf9J4AjM8uY5mDnT+JnZHwbv/tEIR0WF2IHl4DydJD02Cj6g0dtrXBIMlZGxM6KgVW+9B
 t+po9J75Qgr3f3ElCjYCpxuj5v3RJshsg5GQ0kfHe3y1AMPmWWIgSedZqHJRT5v9Mxy2Nf6hv
 mueEE01+H6/axTI5fyCbZuJymyofIimxIVWW5lOyXsOMh3F4lmg+A5RL1qCTGeuAE3rIEwGg8
 NMgL4RPs+OG2Q7ZFeniEQq/QLH3r+NScwakSMZyK6a5p970tWHoOFiO2ZsuTMYeCimYj439eW
 73FN8xHgYBXaI4MD7O7UNXDqsXrl54ZRHWwUh2zygNFqCvTgX912BkG/HkJqP4Irb3m64TOwD
 uA+8+GXO+xu09mI/jLnYij2M4j9484cAHRsle6iHbK7UbA6QM20yvaLESidNSx3VYnupw3hn3
 1TYttaHQa159LCRR7YCsIrT+RmKaiX64SeMn5ww3Idpr+com96B/spE6gcz1f4SqRmnq69xi2
 R8E6PHeUez3bqRQEEwaJuY0q2pFT6L3ByZtqJ1P28mdLw=

>                   =E2=80=A6 Because the pinctrl_dt_free_maps() includes =
the
> droping operation, here we call it directly.

I find this change description improvable.

* How do you think about to avoid a typo?

* Would another imperative wording be more desirable?

Regards,
Markus

