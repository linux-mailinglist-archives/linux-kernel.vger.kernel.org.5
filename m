Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767987CF8A8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345498AbjJSMZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbjJSMZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:25:02 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B98FB6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:24:59 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231019122457epoutp04416e7c97e972cb7f51fc4f6c1d9db315~Pgcvipr0g2848728487epoutp04P
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:24:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231019122457epoutp04416e7c97e972cb7f51fc4f6c1d9db315~Pgcvipr0g2848728487epoutp04P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697718297;
        bh=GN/OL1eGZIAJ8SFDXhY9taH9HgfUmStQwTVITOEr3AI=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=M3ACzm9GRqAt2bERV5vlVnuJoLV5V0luIbDVaLD2N+Cvv5csh1JR0ZW03hFLg/5gU
         NS11m2iJvWD9iQds0u5oFh+mDiW+9naGZlH4M1dGfq+E9c/Zt0HooxJIueSaOz6Q1W
         SFMwvMZEJRHUSgRZFL2JrVnZf4AM9NM9RNE/97MU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20231019122455epcas1p4007f86221a3b9a056be84ed55f770011~PgcuCnH8A0394103941epcas1p4E;
        Thu, 19 Oct 2023 12:24:55 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.136]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4SB6Nk2h8Pz4x9Pp; Thu, 19 Oct
        2023 12:24:54 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        E0.01.08572.61021356; Thu, 19 Oct 2023 21:24:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20231019122453epcas1p4eddbd8295bc4bb460aef9233489f80cf~PgcsNhTOb0395503955epcas1p4M;
        Thu, 19 Oct 2023 12:24:53 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231019122453epsmtrp2af52d648f2ad9227045be96eff6fcb86~PgcsLWfOE2486824868epsmtrp2R;
        Thu, 19 Oct 2023 12:24:53 +0000 (GMT)
X-AuditID: b6c32a33-cefff7000000217c-bd-653120163842
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        8D.A9.18939.51021356; Thu, 19 Oct 2023 21:24:53 +0900 (KST)
Received: from cw00choi03 (unknown [10.113.111.106]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231019122453epsmtip2b8d63f8a23aa889a4ac0ea28da91645a~Pgcr0Xg4x1032610326epsmtip2U;
        Thu, 19 Oct 2023 12:24:53 +0000 (GMT)
From:   "Chanwoo Choi" <cw00.choi@samsung.com>
To:     "'Sascha Hauer'" <s.hauer@pengutronix.de>,
        <linux-rockchip@lists.infradead.org>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        "'Heiko Stuebner'" <heiko@sntech.de>,
        "'Chanwoo Choi'" <chanwoo@kernel.org>,
        "'Kyungmin Park'" <kyungmin.park@samsung.com>,
        "'MyungJoo Ham'" <myungjoo.ham@samsung.com>,
        "'Will Deacon'" <will@kernel.org>,
        "'Mark Rutland'" <mark.rutland@arm.com>, <kernel@pengutronix.de>,
        "'Michael Riesch'" <michael.riesch@wolfvision.net>,
        "'Robin Murphy'" <robin.murphy@arm.com>,
        "'Vincent Legoll'" <vincent.legoll@gmail.com>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Conor Dooley'" <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        "'Sebastian Reichel'" <sebastian.reichel@collabora.com>,
        "'Rob Herring'" <robh@kernel.org>
In-Reply-To: <20231018061714.3553817-21-s.hauer@pengutronix.de>
Subject: RE: [PATCH v8 20/26] dt-bindings: devfreq: event: convert Rockchip
 DFI binding to yaml
Date:   Thu, 19 Oct 2023 21:24:53 +0900
Message-ID: <002e01da0287$4352c7b0$c9f85710$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQFYMiMsP3soeW2GlDsie1R9CxInBwIh5MZLAfxxT8OxM7eEgA==
X-Brightmail-Tracker: H4sIAAAAAAAAA01TaVBTVxj15iUvQZr2GREvOGqI0g6MQB7rpUBdh77RymSmY2fs6OArvLJl
        axbG2ulUKyCLsrh0akDAsogZIDVICVsdMAXBpSMoigXL5gaKFdCRAqYJDy3/zvd959zznXvn
        CjDRa9xdkKDUMRolLZfgS7m/Xfby9XEVk4x0MH8Zyrt7i4sqm29wUJH1Bg/ZhsZ4yHiqnouy
        Hw9i6PqPT/nIPNzDQ90NBTiaPGYFaGLAhqGyOzc5qOXsevTXoQocpTZb+cjWZOGjln9GeGiu
        zsxF/WNRqL3qIY5S+oI2raAqCysBZekvBVS9oZ9PmY0ZONXX04RTNaU/UDlzUir7ohFQdT2F
        GDVpXkMVzQwDmfOXSeHxDB3LaMSMMkYVm6CMi5Ds+Dx6a3RQsJT0IUNRiESspBVMhGTbZzKf
        yAS5PaVEnEzL9faWjNZqJX6fhGtUeh0jjldpdRESRh0rVwepfbW0QqtXxvkqGd3HpFTqH2Qn
        7kuKbxu+AtTPfPZXZnVxDoIHnpnASQCJQHgsIxd3YBFhATDrX79MsNSOJwC0HP4Ve1cMjx/E
        3ioK8+7z2EE9gM9zTy0UTwA8Wd7NyQQCAU5sgMWvdzkELsQumHPFwnFwMCIfh215j3iOgROx
        EdqacuZPXU7Q0Gqa4jgwl/CEF6b+nucIiVA4+3IKsHgZ7Dg9wnVgjFgL654VLGwkhtMPynls
        3wXmZ6RhrPEW+Or6ba7DGBJFTtB6ZxhnBdtgY+FVDouXw9H2i3wWu8PJ8WacFZwA8ObYGMYW
        JgAvnE9ZsAuAl8pOzMfECC9oavBj2x6wfuYMYLd4H46/PMpzUCAhhOlpIpayDnYP9C/4usGS
        Ixl4LpAYFmUzLMpmWJTH8L9ZMeAagSuj1irimBhSTb577hiVwgzmv4B3gAV0F73xbQUcAWgF
        UIBJXISelJQRCWPpbw8wGlW0Ri9ntK0gyH7beZj7ihiV/Q8pddFkYKg0MNg/IBCRwaRkpdAj
        Nz9WRMTROiaJYdSM5q2OI3ByP8gBT3q/Sj78Cl8nG0jWCxRHzrdMmpx3qx7Xe08bxypqN1fY
        eBH3sJ/gUernjplwrmHPuXtf93b2HrKkbvwC35uU+VFfgygqMbFl54vbpvTplrO3VpsJXup2
        fdWG6qdbfMlyl5A997O1jaLJYL++78raT44+J3eMV+f6jTeJhROzv6AlxZtXNR4YKmmeiXxY
        8CgkrHbJuQDbzs5rqPr3rpLvX+xNH/nzks1qelPW0ba92GPtqDBsf0a6cffV0LTeD9eXhvFX
        58wGePwRVmRLyNs3e1y9SX55jX6QszIry/lag5u/a6cCrArtOh3pNXN3KEWmn/u0pj3qg9qE
        985801WzNVFW5SbhauNp0hvTaOn/AMjXq7KLBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsWy7bCSvK6ogmGqwdZuaYuJN66wWKzZe47J
        Yv6Rc6wW/x+9ZrVYNXUni0Xfi4fMFmeb3rBbbHp8jdXi8q45bBafe48wWnx68J/ZYun1i0wW
        BxeqWNxuXMFm0br3CLvF/z072C0OfnjCavF3+yYWi7uv/SyOr33GZtFyx9RB1GPNvDWMHjvu
        LmH02DnrLrvHplWdbB53ru1h89i8pN6j/6+BR9+WVYwe26/NY/b4vEnOY/7vx4wB3FFcNimp
        OZllqUX6dglcGccen2AseKtbsab7ElMD41PVLkZODgkBE4l5E++xdjFycQgJbGeUaD/xnBki
        ISkx7eJRIJsDyBaWOHy4GKLmOaPEptZv7CBxNgEdiQU/QkHKRQRCJfpP7GACqWEWWMkm8X3R
        D2aIhkOMEtu2HGQHqeIUsJf4v6cfbIGwQLzErzV/WUBsFgFViY1f7rOC2LwClhJ/vn5hhLAF
        JU7OfMICsoxZQE+ibSNYmFlAXmL72zlQdypI/Hy6jBUiLiIxu7ONGeIgJ4lvZ6+yTGAUnoVk
        0iyESbOQTJqFpHsBI8sqRtHUguLc9NzkAkO94sTc4tK8dL3k/NxNjOAEoBW0g3HZ+r96hxiZ
        OBiB3uNgVhLhVfUwSBXiTUmsrEotyo8vKs1JLT7EKM3BoiTOq5zTmSIkkJ5YkpqdmlqQWgST
        ZeLglGpgcjSvd00viN28cHXTDN752mLnhJ+8fXz17kpjHuuQP5/cJ7fuftNSrJcqZqW9SKrC
        dskTobjXWRsfvJPyiTedLXNT71aGn/7juTqP+vSty66amL8rvLhG8Gmk1N9pKV27eOd9mOe2
        5svcvpoNh9dc3vI+y/iP39ZfquxpPleL6mQNl89k2rT14DGfV/NCM2pUAjNn71ghp+A6fdqN
        6KgFRnnOSf0hFkJzIu9eXSOza13SFsE3n+/8co3Nzb76YMLPFZ/eXOlhmO7RbtfunKPBMiHY
        Q9Wq7tL+6btjE06EMFtVTIiZWGuTLrHuwNTOs2d3h8px3FThmmajKaxd6TX7S34/79HdvjJb
        r10+uS42SYmlOCPRUIu5qDgRAOnI2fZvAwAA
X-CMS-MailID: 20231019122453epcas1p4eddbd8295bc4bb460aef9233489f80cf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231018063729epcas1p27cf2789bbb10d6ef59e20d2e981be580
References: <20231018061714.3553817-1-s.hauer@pengutronix.de>
        <CGME20231018063729epcas1p27cf2789bbb10d6ef59e20d2e981be580@epcas1p2.samsung.com>
        <20231018061714.3553817-21-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Wednesday, October 18, 2023 3:17 PM
> To: linux-rockchip@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> linux-pm@vger.kernel.org; Heiko Stuebner <heiko@sntech.de>; Chanwoo Choi
> <chanwoo@kernel.org>; Kyungmin Park <kyungmin.park@samsung.com>; MyungJoo
> Ham <myungjoo.ham@samsung.com>; Will Deacon <will@kernel.org>; Mark
> Rutland <mark.rutland@arm.com>; kernel@pengutronix.de; Michael Riesch
> <michael.riesch@wolfvision.net>; Robin Murphy <robin.murphy@arm.com>;
> Vincent Legoll <vincent.legoll@gmail.com>; Rob Herring
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
> devicetree@vger.kernel.org; Sebastian Reichel
> <sebastian.reichel@collabora.com>; Sascha Hauer <s.hauer@pengutronix.de>;
> Rob Herring <robh@kernel.org>; Chanwoo Choi <cw00.choi@samsung.com>
> Subject: [PATCH v8 20/26] dt-bindings: devfreq: event: convert Rockchip
> DFI binding to yaml
> 
> Convert the Rockchip DFI binding to yaml.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> 
> Notes:
>     Changes since v4:
>      - Revert to state of v3 (changes were lost in v4)
> 
>  .../bindings/devfreq/event/rockchip,dfi.yaml  | 61 +++++++++++++++++++
>  .../bindings/devfreq/event/rockchip-dfi.txt   | 18 ------
>  .../rockchip,rk3399-dmc.yaml                  |  2 +-
>  3 files changed, 62 insertions(+), 19 deletions(-)  create mode 100644
> Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
>  delete mode 100644
> Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
> 
> diff --git
> a/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
> b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
> new file mode 100644
> index 0000000000000..7a82f6ae0701e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> +---
> +$id:
> +https://protect2.fireeye.com/v1/url?k=33df13d2-525406e4-33de989d-000bab
> +ff9b5d-4b7a223f95f3c587&q=1&e=ef8cc89e-5dd5-4fbc-9f53-24c072471908&u=ht
> +tp%3A%2F%2Fdevicetree.org%2Fschemas%2Fdevfreq%2Fevent%2Frockchip%2Cdfi.
> +yaml%23
> +$schema:
> +https://protect2.fireeye.com/v1/url?k=01ded479-6055c14f-01df5f36-000bab
> +ff9b5d-e828a5719f87a6ff&q=1&e=ef8cc89e-5dd5-4fbc-9f53-24c072471908&u=ht
> +tp%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
> +
> +title: Rockchip DFI
> +
> +maintainers:
> +  - Sascha Hauer <s.hauer@pengutronix.de>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rk3399-dfi
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: pclk_ddr_mon
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  rockchip,pmu:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the syscon managing the "PMU general register files".
> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/rk3308-cru.h>
> +
> +    bus {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      dfi: dfi@ff630000 {
> +        compatible = "rockchip,rk3399-dfi";
> +        reg = <0x00 0xff630000 0x00 0x4000>;
> +        interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH 0>;
> +        rockchip,pmu = <&pmugrf>;
> +        clocks = <&cru PCLK_DDR_MON>;
> +        clock-names = "pclk_ddr_mon";
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/devfreq/event/rockchip-
> dfi.txt b/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
> deleted file mode 100644
> index 148191b0fc158..0000000000000
> --- a/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -
> -* Rockchip rk3399 DFI device
> -
> -Required properties:
> -- compatible: Must be "rockchip,rk3399-dfi".
> -- reg: physical base address of each DFI and length of memory mapped
> region
> -- rockchip,pmu: phandle to the syscon managing the "pmu general register
> files"
> -- clocks: phandles for clock specified in "clock-names" property
> -- clock-names : the name of clock used by the DFI, must be
"pclk_ddr_mon";
> -
> -Example:
> -	dfi: dfi@ff630000 {
> -		compatible = "rockchip,rk3399-dfi";
> -		reg = <0x00 0xff630000 0x00 0x4000>;
> -		rockchip,pmu = <&pmugrf>;
> -		clocks = <&cru PCLK_DDR_MON>;
> -		clock-names = "pclk_ddr_mon";
> -	};
> diff --git a/Documentation/devicetree/bindings/memory-
> controllers/rockchip,rk3399-dmc.yaml
> b/Documentation/devicetree/bindings/memory-controllers/rockchip,rk3399-
> dmc.yaml
> index 4e4af3cfc0fe4..1f58ee99be280 100644
> --- a/Documentation/devicetree/bindings/memory-
> controllers/rockchip,rk3399-dmc.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/rockchip,rk33
> +++ 99-dmc.yaml
> @@ -18,7 +18,7 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:
>        Node to get DDR loading. Refer to
> -      Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt.
> +      Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml.
> 
>    clocks:
>      maxItems: 1
> --
> 2.39.2


Applied it. Thanks

Best Regards,
Chanwoo Choi

