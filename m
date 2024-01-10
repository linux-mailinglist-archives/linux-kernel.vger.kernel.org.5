Return-Path: <linux-kernel+bounces-22204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD830829AD8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10E21C26074
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAF2487A2;
	Wed, 10 Jan 2024 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUFVSIkb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480EE208A4;
	Wed, 10 Jan 2024 13:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA3AC433F1;
	Wed, 10 Jan 2024 13:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704891689;
	bh=lObChVFu8SVeU0CpWZS6IsckF37c9pF9oZGVe4pxJac=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hUFVSIkb8pTGra0V4ilZBHzmGcdS+r5wRCSoniOe8c2PpqnvKcyIXbzdMFC47XuP1
	 Ak/lEEquN9Rb5/sv4dfqTlSISU9kWVSTB9Er9I+ZkYCkksmo03ySUiJqsa0yTlw21T
	 qXMGmCEAJJbkLa8lx0CBX3qWsFbRavAZY5PSK3HJNffYoe2kjLzx7Ryynkxg5BLrMa
	 PG4caHupbmxWKB8IB9Uq3NVGKyoXKe3C/8MS8YzIkdLv2DI2fuIdqyA/ftgbEAImiY
	 EEEi70eIi+cxfMSVzT8y4Twm5is5hINR40jau4PoCA2vDUwXWZ/C/uxH37B5LNIlYT
	 aAKuIWgZq3lSQ==
Received: (nullmailer pid 1231852 invoked by uid 1000);
	Wed, 10 Jan 2024 13:01:24 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: corbet@lwn.net, linux-kernel@vger.kernel.org, will@kernel.org, quic_leiwei@quicinc.com, quic_souravp@quicinc.com, m.szyprowski@samsung.com, quic_linchen@quicinc.com, u-kumar1@ti.com, quic_kkumarcs@quicinc.com, devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org, rrameshbabu@nvidia.com, quic_suruchia@quicinc.com, geert+renesas@glider.be, davem@davemloft.net, nfraprado@collabora.com, arnd@arndb.de, linux-arm-msm@vger.kernel.org, quic_soni@quicinc.com, p.zabel@pengutronix.de, andrew@lunn.ch, edumazet@google.com, catalin.marinas@arm.com, conor+dt@kernel.org, brett.creeley@amd.com, pabeni@redhat.com, linux-doc@vger.kernel.org, neil.armstrong@linaro.org, jasowang@redhat.com, dmitry.baryshkov@linaro.org, agross@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org, kuba@kernel.org, andersson@kernel.org, anthony.l.nguyen@intel.com, ansuelsmth@gmail.com, linux-arm-kernel@lists.infradead.org, joshua.a.hay@intel.com, jacob.e.keller@intel.com, ryazanov.s.a@gmail.com, quic_pavir
 @quicinc.com, shannon.nelson@amd.com, robh+dt@kernel.org, konrad.dybcio@linaro.org
In-Reply-To: <20240110114033.32575-3-quic_luoj@quicinc.com>
References: <20240110114033.32575-1-quic_luoj@quicinc.com>
 <20240110114033.32575-3-quic_luoj@quicinc.com>
Message-Id: <170489168445.1231814.13885812844445449165.robh@kernel.org>
Subject: Re: [PATCH net-next 02/20] dt-bindings: net: qcom,ppe: Add
 bindings yaml file
Date: Wed, 10 Jan 2024 07:01:24 -0600


On Wed, 10 Jan 2024 19:40:14 +0800, Luo Jie wrote:
> Qualcomm PPE(packet process engine) is supported on
> IPQ SOC platform.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  .../devicetree/bindings/net/qcom,ppe.yaml     | 1330 +++++++++++++++++
>  1 file changed, 1330 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/qcom,ppe.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/net/qcom,ppe.example.dts:20:18: fatal error: dt-bindings/clock/qcom,ipq9574-nsscc.h: No such file or directory
   20 |         #include <dt-bindings/clock/qcom,ipq9574-nsscc.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/net/qcom,ppe.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1424: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240110114033.32575-3-quic_luoj@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


