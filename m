Return-Path: <linux-kernel+bounces-148008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DA18A7C8C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEAFC1F21450
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A56069E0F;
	Wed, 17 Apr 2024 06:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="rkwPnbca"
Received: from outbound9.mail.transip.nl (outbound9.mail.transip.nl [136.144.136.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD5F29D06;
	Wed, 17 Apr 2024 06:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713336631; cv=none; b=ELU1HgAFkvKILRcAfVTkE+Twxs759ubFlzDK5Cjt5jIyRD1BZw9A2BOBOkV0jCt5m0NmeUAkneHaWmV0JoO9XeeK+nvcUzNeMI1j8GZqdir0skRYG/+fEUK19hZJ6i1WTgQFj18P8bJ/EePqcTTcxvfNxTR6eGV0JeiWFJ07XgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713336631; c=relaxed/simple;
	bh=3HxzvJ6OuwW8NkKZkqYr3vTgSjlJhi1guy2LIVfXoeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u9BXx507s5yIpjQhOP/AHKQs/yr9nAoform7wiRnJUG+kBkY+UPj8nu3WU2xaxvHmtLLzL0LMZ/nYS6HpwJZOo/iEMjyZwiDqCi5rz+a0v+r1Hct9uIOqSJcwhvKc3JSQyI7u+OZFBDZnAflwnhRMmXGxNmF63WSPrsbYIUlRVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=rkwPnbca; arc=none smtp.client-ip=136.144.136.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Received: from submission14.mail.transip.nl (unknown [10.103.8.165])
	by outbound9.mail.transip.nl (Postfix) with ESMTP id 4VKBPB0Mf8zTPNMs;
	Wed, 17 Apr 2024 08:50:22 +0200 (CEST)
Received: from herrie-desktop.. (110-31-146-85.ftth.glasoperator.nl [85.146.31.110])
	by submission14.mail.transip.nl (Postfix) with ESMTPA id 4VKBP917Nqz2ST2q;
	Wed, 17 Apr 2024 08:50:21 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
To: dmitry.baryshkov@linaro.org
Cc: andersson@kernel.org,
	benwolsieffer@gmail.com,
	chris.chapuis@gmail.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	github.com@herrie.org,
	kishon@kernel.org,
	konrad.dybcio@linaro.org,
	krzk+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	me@herrie.org,
	robh@kernel.org,
	vkoul@kernel.org
Subject: Re: [PATCH v2] dt-bindings: phy: qcom,usb-hs-phy: Add compatible
Date: Wed, 17 Apr 2024 08:50:20 +0200
Message-Id: <20240417065020.3599755-1-github.com@herrie.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <CAA8EJpo=nd8ywUzz2e42p7WAyuFm439yvNf6H=MD63LCV0xTnw@mail.gmail.com>
References: <CAA8EJpo=nd8ywUzz2e42p7WAyuFm439yvNf6H=MD63LCV0xTnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission14.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1713336621; h=from:subject:to:cc:
 references:in-reply-to:date:mime-version;
 bh=yitk1PINuG+ZttWDjmHS+5CUubvYDjED2MOpSUGliao=;
 b=rkwPnbcaVbl+/j7vxyR4afo2tfgaVt3k5zO2AvGRlhzkPONCWrLPe4gUiCEe32ZY9aDYMJ
 4j0VAiiYxB+cC3qUwWhoWx74XbrUYLzwSvo+c3hl4EH5bFalLOyLmcs/mOXXppNsGC7arg
 Zl5y3oRs2PMbtBYakdaFuKLA3C7x4zDjczQeOKaE9vLMrDPzI4Ms3k6bOYS1UnQniGcImK
 6qH+0YGNgclTXewTp52AOSWd3jp+MBltoMoRs4thW7+uVPZ/6gWlG8Ac2SJStO0Pyp2XGT
 8LPe2kelD5JtYpH2QsU2YSwqZG7/NGJKQj1EKBsJY1F7PuiuynIgR+wa5RvvSg==
X-Report-Abuse-To: abuse@transip.nl

On Wed, 17 Apr 2024 at 07:52, Herman van Hazendonk
<github.com@herrie.org> wrote:
>>
>> Adds qcom,usb-hs-phy-msm8660 compatible
>>
>> Used by HP Touchpad (tenderloin) for example.
>>
>> Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
>> ---
>>  Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
>> index f042d6af1594..ccf23170cd17 100644
>> --- a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
>> +++ b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
>> @@ -15,6 +15,7 @@ if:
>>        contains:
>>          enum:
>>            - qcom,usb-hs-phy-apq8064
>> +          - qcom,usb-hs-phy-msm8660
>>            - qcom,usb-hs-phy-msm8960
>>  then:
>>    properties:
>> @@ -41,6 +42,7 @@ properties:
>>        - enum:
>>            - qcom,usb-hs-phy-apq8064
>>            - qcom,usb-hs-phy-msm8226
>> +          - qcom,usb-hs-phy-msm8960

> This should probably be msm8660 rather than 8960
Hi Dmitry,

Thanks for the swift feedback. I'll send a v3.
I need more coffee before doing this in the morning

> Note, nowadays the rule would be to use qcom,msm8660-usb-hs-phy
> compatible, but I wonder if we should enforce this for such an old
> platform or whether similarity wins.

>>            - qcom,usb-hs-phy-msm8916
>>            - qcom,usb-hs-phy-msm8960
>>            - qcom,usb-hs-phy-msm8974
>>

I plan to send more patches for the msm8660, so happy to understand what
is the preferred approach, because it doesn't seem consistent.

These are my first patches, so learning mainly from what I see in commit
history (which might be outdated)
It's indeed ancient platform, we just would like to get HP TouchPad
(tenderloin) running with a mainline kernel, hence these patches.

Best regards,
Herman

> --
> With best wishes
> Dmitry

