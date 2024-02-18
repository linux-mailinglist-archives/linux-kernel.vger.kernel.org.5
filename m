Return-Path: <linux-kernel+bounces-70529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3178598E3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A74280E96
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB39F763EC;
	Sun, 18 Feb 2024 19:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="v/e7TXsW"
Received: from smtp51.i.mail.ru (smtp51.i.mail.ru [95.163.41.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B88762E6;
	Sun, 18 Feb 2024 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.41.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282947; cv=none; b=mU01sxBoU5NKroc7CuEPxcF9zjBZ1OBKTNuv6cebIOucGHtN+g2dZcmHCylGqAF040Zgubjs56U4jcCTYU9DL90VcDc0ZWhIYqULysgZsV8m56O7+QhPCh54Hf5QP14QpNuNMjeQL75yJJ44v2LUqky6FPIbb/HyxKmgB6cDsyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282947; c=relaxed/simple;
	bh=MPy55ZzVwuk6ZdokMpIXxx6MJ1fFy+bWbM3XgqQNUPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mIzQwi8+QTgRGFli39RkRdlk0efmVi8GOu5shSyHBJMQVdPGQOQLU3DYuOHIDLByCi/edE4pcgoqrYOkh5W/rMeYkZMxKkb7RuDhTCoGgid6G2R+33TsY8CBHruFsjB81mMzRoY4FP79WBG0RxIgTpEvbbpKG3oG9sKf8+HApDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=v/e7TXsW; arc=none smtp.client-ip=95.163.41.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:To
	:Cc:Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=Dv460ZlQ97OmwroioSKtYAU8JJFINtgRb2khYHPg7d4=; t=1708282944; x=1708372944; 
	b=v/e7TXsWNJCkul/YFZrdyM+UilUU1SfxGlhbynObBF7/URhTp+axjp+EelekblltFih7Go7bkcu
	LD5J9OMlWhrfXIMLHqN5BCr7oziPWy6GRHmv85L9HNgxh64lJDxanAAWeNb624+RsMvan6+uph0hz
	SvEBUy57F2b+sS+tAQI=;
Received: by smtp51.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rbmQf-000000060EP-2jjW; Sun, 18 Feb 2024 22:02:22 +0300
Message-ID: <3488e5a4-df70-4ecb-a860-af2e13650347@jiaxyga.com>
Date: Sun, 18 Feb 2024 22:02:20 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm SM7150 DT
 bindings
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 andersson@kernel.org, konrad.dybcio@linaro.org, djakov@kernel.org,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240218183239.85319-1-danila@jiaxyga.com>
 <20240218183239.85319-2-danila@jiaxyga.com>
 <d3a4c6f9-e24a-446c-acbf-75519f6782fb@linaro.org>
From: Danila Tikhonov <danila@jiaxyga.com>
In-Reply-To: <d3a4c6f9-e24a-446c-acbf-75519f6782fb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp51.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9001F8F2F6BAD2021A4088691FB60B4B8D975C14E9881615F00894C459B0CD1B92394FC7D9BFA397E70880960CAF89B404B673AB2AD4824D32C116307F3699030E2602FFE9E909B31
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE74AE62C7A8488879AEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637560334CFC131571A8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8414839C36918184D58A440450CF716AFA8D91C1CAC9AE40FCC7F00164DA146DAFE8445B8C89999728AA50765F7900637BA939FD1B3BAB99B389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8989FD0BDF65E50FBF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CBFD98ABA943BD70B6136E347CC761E074AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3DAEA9A8D61B93628BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF17B107DEF921CE791DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C3677AC51C039AA0BA35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A59B276F08D6B4F3BF5002B1117B3ED696B42F3BCFECD18A6E1A1B8FE1FED62FE8823CB91A9FED034534781492E4B8EEAD4ECBDE8281F904F9BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF4597CC689EA0662196306A66DC0F9619D43E0CF7FD10A0E65544EEC935690B21673DC415E80A8BD934E84B500378195F27ED41A69D94F0FCC6CE93AC2CCEFDBFFAAA099578CB8531AF108DC32EA72A8402C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj3ZJ49a6yxuv9hg0w1JFMKA==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981FC72C712BCB9BF3E9B464708D7791FD718B604B8A66A9623E1A6888D7145A9F92C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

I removed compatible duplicates from qcom,rpmh-common.yaml. No more
warnings. I also followed your advice regarding the name of the child
node. Maybe something else?

---
Best wishes
Danila

On 2/18/24 21:52, Krzysztof Kozlowski wrote:
> On 18/02/2024 19:32, Danila Tikhonov wrote:
>> The Qualcomm SM7150 platform has several bus fabrics that could be
>> controlled and tuned dynamically according to the bandwidth demand.
>>
>> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
>> ---
>>   .../interconnect/qcom,sm7150-rpmh.yaml        |  88 ++++++++++
>>   .../interconnect/qcom,sm7150-rpmh.h           | 150 ++++++++++++++++++
>>   2 files changed, 238 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml
>>   create mode 100644 include/dt-bindings/interconnect/qcom,sm7150-rpmh.h
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml
>> new file mode 100644
>> index 000000000000..604822ed4adc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml
>> @@ -0,0 +1,88 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/interconnect/qcom,sm7150-rpmh.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm RPMh Network-On-Chip Interconnect on SM7150
>> +
>> +maintainers:
>> +  - Danila Tikhonov <danila@jiaxyga.com>
>> +
>> +description: |
>> +  RPMh interconnect providers support system bandwidth requirements through
>> +  RPMh hardware accelerators known as Bus Clock Manager (BCM).
>> +
>> +  See also:: include/dt-bindings/interconnect/qcom,sm7150-rpmh.h
>> +
>> +allOf:
>> +  - $ref: qcom,rpmh-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,sm7150-aggre1-noc
>> +      - qcom,sm7150-aggre2-noc
>> +      - qcom,sm7150-compute-noc
>> +      - qcom,sm7150-config-noc
>> +      - qcom,sm7150-dc-noc
>> +      - qcom,sm7150-gem-noc
>> +      - qcom,sm7150-mc-virt
>> +      - qcom,sm7150-mmss-noc
>> +      - qcom,sm7150-system-noc
> I don't see how you resolved the warning we talked about on IRC.
>
> Best regards,
> Krzysztof
>


