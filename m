Return-Path: <linux-kernel+bounces-448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FE281413F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACE801C223DB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 05:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31F5746B;
	Fri, 15 Dec 2023 05:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="THr7GBr3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17FC63B3
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 05:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231215052619epoutp021b7d6ddf59223655ad12b450363b6b90~g6ggY0Cnh1798117981epoutp02a
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 05:26:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231215052619epoutp021b7d6ddf59223655ad12b450363b6b90~g6ggY0Cnh1798117981epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1702617979;
	bh=eL9hYEmNDzP5hw9IEZEImZuBabBqahO/D3bSV7irFQA=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=THr7GBr3zww+nZ8fljL6K7Ln3j++5cQTtrx0C4DBsV/LOKTRwasAgdQv8FnEiTqjz
	 2hkLw7n8S+8Jc35RkNuKRI6WoiBdZDTPiEsFlD8XduKeUzIvLT5UJqJ4jweVmfhupL
	 3BtqATTbHulbC26B5N4MaW3TkM2QavTDbJEvqSU8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20231215052619epcas5p4938fc462999af551f8b9191ab99bee0d~g6gf7b1fa0727707277epcas5p4y;
	Fri, 15 Dec 2023 05:26:19 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4SryPN41Ggz4x9Q9; Fri, 15 Dec
	2023 05:26:16 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2C.89.19369.873EB756; Fri, 15 Dec 2023 14:26:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20231215051108epcas5p2c657d2629ed8451ad519644c28e6c234~g6TPpQhPL1850118501epcas5p2X;
	Fri, 15 Dec 2023 05:11:08 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231215051108epsmtrp1c0c8998163945bab413ca8d1c50a1178~g6TPoXwJW2671726717epsmtrp1b;
	Fri, 15 Dec 2023 05:11:08 +0000 (GMT)
X-AuditID: b6c32a50-c99ff70000004ba9-e3-657be378944b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	E3.B3.18939.CEFDB756; Fri, 15 Dec 2023 14:11:08 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20231215051106epsmtip28b912955bc5af8f9bb80aae351fd2e89~g6TOZnKls0775707757epsmtip2c;
	Fri, 15 Dec 2023 05:11:06 +0000 (GMT)
From: "Aakarsh Jain" <aakarsh.jain@samsung.com>
To: "'Rob Herring'" <robh@kernel.org>, "'Mauro Carvalho Chehab'"
	<mchehab@kernel.org>, "'Krzysztof Kozlowski'"
	<krzysztof.kozlowski+dt@linaro.org>, "'Conor Dooley'" <conor+dt@kernel.org>,
	"'Marek Szyprowski'" <m.szyprowski@samsung.com>
Cc: <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
In-Reply-To: <20231214195553.862920-1-robh@kernel.org>
Subject: RE: [PATCH v2] media: dt-bindings: samsung,s5p-mfc: Fix iommu
 properties schemas
Date: Fri, 15 Dec 2023 10:41:04 +0530
Message-ID: <114701da2f15$1c8cf730$55a6e590$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHcypBR0AxbKGLonVbN0M0kdAGaSgFmSeOHsJlilgA=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmhm7F4+pUg8Z2WYs1e88xWcw/co7V
	ou/FQ2aLy7vmsFn0bNjKarH2yF12i2Wb/jBZ/N+zg92Bw2PTqk42jzvX9rB59G1ZxejxeZNc
	AEtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0BlK
	CmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKTAr3ixNzi0rx0vbzUEitDAwMjU6DC
	hOyMi0v3sxbMk6qYtzaygfGZYBcjJ4eEgInEtnnrWbsYuTiEBPYwSmw5dJQFwvnEKHHy7BcE
	5/maNmaYlqtLZjFDJHYySpz/+hmq6jmjxJz5S1hBqtgE9CXun+oBGywi8JFRYsareWDtzAKJ
	Ev+73wElODg4Bcwktr1UBTGFBaIlmm84glSwCKhKXH0zAayaV8BSonXfYihbUOLkzCcsEFPk
	Jba/nQN1kILEz6fLwNaKCFhJ3N++lR2iRlzi6M8eqJqpHBJdHaUQtovEy4tbWSBsYYlXx7ew
	Q9hSEi/726DsZInHi15C9eZIrN8zBareXuLAlTksICczC2hKrN+lDxGWlZh6ah0TxFo+id7f
	T5gg4rwSO+bB2GoSc+78YIWwZSQOr17KOIFRaRaSz2Yh+WwWkg9mIWxbwMiyilEqtaA4Nz01
	2bTAUDcvtRwe38n5uZsYwYlUK2AH4+oNf/UOMTJxMB5ilOBgVhLhXbC2OlWINyWxsiq1KD++
	qDQntfgQoykwvCcyS4km5wNTeV5JvKGJpYGJmZmZiaWxmaGSOO/r1rkpQgLpiSWp2ampBalF
	MH1MHJxSDUymi52mzRLhKn36UHRWdfXa+m1mkbEdnduYU9uFTlUVpsnsfr4t6tm6CRl+fh6t
	b1c7XpgtKyzr5cK/ZDH/MrXA07VTj9z53nH6eSTv2RZ235I4r4mzzheEP7gbzzC/8j2H3qFV
	a+KKuP72Xpfft6XONdSpo6bmruqOp8uzHDtmpa3OVP8oy1SmyrDo9lEV61jhSWz5Byb90I0N
	Tv2x/5Xi/8MHntU3N7p/1qw4Vrj2SOFh1bJl0y7+4G8QnF72S2GD4vS3++ONztY/bOmKj+hM
	/Hvxm3Kr3rF+w2WBhryFmo3ZvmXfJ716wSR9UOtlp6G43KXiaRNLa52PXLk2XZBt79b1Kvs1
	dE6uSlx5e70SS3FGoqEWc1FxIgDTxQ0hLQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsWy7bCSvO6b+9WpBn0beSzW7D3HZDH/yDlW
	i74XD5ktLu+aw2bRs2Erq8XaI3fZLZZt+sNk8X/PDnYHDo9NqzrZPO5c28Pm0bdlFaPH501y
	ASxRXDYpqTmZZalF+nYJXBkXl+5nLZgnVTFvbWQD4zPBLkZODgkBE4mrS2YxdzFycQgJbGeU
	uHfxOxtEQkbif9sxdghbWGLlv+dgtpDAU0aJhb3GIDabgL7E/VM9rCDNIgKfGSUO7HvNCJJg
	FkiWePP2GdTUdkaJa9PWASU4ODgFzCS2vVQFqREWiJRYO38HC4jNIqAqcfXNBGYQm1fAUqJ1
	32IoW1Di5MwnLCCtzAJ6Em0bocbLS2x/O4cZ4jYFiZ9Pl7GC2CICVhL3t29lh6gRlzj6s4d5
	AqPwLCSTZiFMmoVk0iwkHQsYWVYxiqYWFOem5yYXGOoVJ+YWl+al6yXn525iBEeQVtAOxmXr
	/+odYmTiYDzEKMHBrCTCu2BtdaoQb0piZVVqUX58UWlOavEhRmkOFiVxXuWczhQhgfTEktTs
	1NSC1CKYLBMHp1QDU0L6Z6Xklz2zdu552i9ocyRh4c5FfpHxW44cNp14KKpqbnXB1cS2pNAl
	WdeFFno/W1NiwNGYdzWU10x6eahHy/rciI9Xj/50+b5X6GO81PxbT14Kd/5f9v99bmT20xip
	L5LbetiPyVzQu1xqtzdHfuHzuMVtM87Ou/i6RebXll/zJrarOPj8eBmoVDn/rvlv889m6kmX
	tJWllVR2Hqpd9DY7ccrjdhufJ5MCHh1ZdLLwXH/Cl3ns71ZvOP/j0dpdz86rLTursipT5Ub7
	fRmvs9kpac/38L89dCEoOyDrfh3H4n98t1MVTNylZK/MW9fzoTTntdbT+9n6CZPPvni+Z9au
	qc/OMDxmT0hT226/0POfEktxRqKhFnNRcSIAlfcufg8DAAA=
X-CMS-MailID: 20231215051108epcas5p2c657d2629ed8451ad519644c28e6c234
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231214195605epcas5p1ae2470abdb641ad8d299968fc306ec07
References: <CGME20231214195605epcas5p1ae2470abdb641ad8d299968fc306ec07@epcas5p1.samsung.com>
	<20231214195553.862920-1-robh@kernel.org>



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: 15 December 2023 01:26
> To: Mauro Carvalho Chehab <mchehab@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>; Marek Szyprowski <m.szyprowski@samsung.com>;
> Aakarsh Jain <aakarsh.jain@samsung.com>
> Cc: linux-media@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH v2] media: dt-bindings: samsung,s5p-mfc: Fix iommu
> properties schemas
> 
> The iommus and iommu-names property schemas have several issues. First,
> 'iommus-names' in the if/then schemas is the wrong name. As all the names
> are the same, they can be defined at the top level instead. Then the
if/then
> schemas just need to define how many entries. The iommus if/then schemas
> are also redundant. Best I can tell, the desire was to require 2 entries
for
> "samsung,exynos5433-mfc", "samsung,mfc-v5", "samsung,mfc-v6", and
> "samsung,mfc-v8".
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>  - Fix some more cases of iommus-names
> ---
>  .../bindings/media/samsung,s5p-mfc.yaml       | 33 ++++++++-----------
>  1 file changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/samsung,s5p-
> mfc.yaml b/Documentation/devicetree/bindings/media/samsung,s5p-
> mfc.yaml
> index 084b44582a43..4c3250985ac3 100644
> --- a/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> +++ b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> @@ -49,7 +49,9 @@ properties:
> 
>    iommu-names:
>      minItems: 1
> -    maxItems: 2
> +    items:
> +      - const: left
> +      - const: right
> 
>    power-domains:
>      maxItems: 1
> @@ -84,7 +86,7 @@ allOf:
>              - const: sclk_mfc
>          iommus:
>            maxItems: 1
> -        iommus-names: false
> +        iommu-names: false
> 
>    - if:
>        properties:
> @@ -102,11 +104,9 @@ allOf:
>              - const: aclk
>              - const: aclk_xiu
>          iommus:
> -          maxItems: 2
> -        iommus-names:
> -          items:
> -            - const: left
> -            - const: right
> +          minItems: 2
> +        iommu-names:
> +          minItems: 2
> 
>    - if:
>        properties:
> @@ -123,11 +123,9 @@ allOf:
>              - const: mfc
>              - const: sclk_mfc
>          iommus:
> -          maxItems: 2
> -        iommus-names:
> -          items:
> -            - const: left
> -            - const: right
> +          minItems: 2
> +        iommu-names:
> +          minItems: 2
> 
>    - if:
>        properties:
> @@ -144,11 +142,9 @@ allOf:
>            items:
>              - const: mfc
>          iommus:
> -          maxItems: 2
> -        iommus-names:
> -          items:
> -            - const: left
> -            - const: right
> +          minItems: 2
> +        iommu-names:
> +          minItems: 2
> 
>    - if:
>        properties:
> @@ -161,9 +157,6 @@ allOf:
>          clocks:
>            minItems: 1
>            maxItems: 2
> -        iommus:
> -          minItems: 1
> -          maxItems: 2
> 
>  examples:
>    - |
> --
> 2.43.0

Reviewed-by: Aakarsh Jain <aakarsh.jain@samsung.com>


