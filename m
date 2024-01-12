Return-Path: <linux-kernel+bounces-24784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 695B782C279
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01C8D284443
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A436EB4D;
	Fri, 12 Jan 2024 15:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LnfkXyM5"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296476DD18
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 15:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50ea98440a7so6774005e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 07:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705071914; x=1705676714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EGj9NLjeiH7VUkvZ1A9N/SV1ZE8ovwzqiFTpfpK/e/Y=;
        b=LnfkXyM5kM+asycsaVdodJIOpTRRCPkunWsI3zOwZolvVW5wZWIjeCUfg0G7JzTz+W
         W9WOuvETy6F38wvY6dqyxUe2lYGILqRAZgy8QY8PXlsJquBhYZN6MCUoDsJJ6orXZivO
         ZP2UKOBnRcXyQmN4XMQlh7Y4TVubzjhJ4PFHB6Em9OiLGNpsggw0NBN2vPXJde1Fzw8a
         qP51Px8IXGUh0U3p/+efVZWuXUT0jsIAaXDACsdmUqymx6G/ERJD5YO90nRWMpvB4jDI
         mUmO3GST+moracvQcJkC0JhQTgc6S4/8vEgEsnpvouvluSoboHFE+A7Nd4f43+VIDWdG
         nuaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705071914; x=1705676714;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EGj9NLjeiH7VUkvZ1A9N/SV1ZE8ovwzqiFTpfpK/e/Y=;
        b=UQL3bkq/BD3Za/0hGMosIZsWxaQEOaCYdo0F0CvQS7e2FnQrCvUIEcvwmcbob8zMET
         PZG+VkS6kmzaL2JySg9DycKFQdmZ+52rEFMHLo+p1/wwi3BWobDnwMdWhKQhBhtAWBbm
         HjxzM/es6axjkzGKMqJjp5tQgzDC27EZIn/H6K8LNe3rpFj7oAEwCiErccRfq0AWl2Je
         k60EiP0VaJnX/gEkAWTKTUW4MOUXR9K5+AfO4kRnW12G82b6+xzeNItMAnDaYB1OcHXY
         gMXMB5h2IB4MrPPfGCdPX9MjICQlHAgz3A66Z6Rnzj765domQ5gcro9GTEHq1XxoZS2d
         Kdmw==
X-Gm-Message-State: AOJu0YwGAXepDilQCMoApitpo9G+qNVzmp/NCsdiopaHo3o18Y5aiF8n
	EhYuaZOX8dp9yt/wjUexhtahmjov3yEQEQ==
X-Google-Smtp-Source: AGHT+IGzSDNM5chFAEAwD2aU3LCcin/thQulwDNGjU0qgujLYpAVeaGN8+isXxzVUSfraMXxDSdOFg==
X-Received: by 2002:a05:6512:3f14:b0:50e:7dcc:ef51 with SMTP id y20-20020a0565123f1400b0050e7dccef51mr624188lfa.120.1705071914138;
        Fri, 12 Jan 2024 07:05:14 -0800 (PST)
Received: from [127.0.0.1] (85-76-114-160-nat.elisa-mobile.fi. [85.76.114.160])
        by smtp.gmail.com with ESMTPSA id f5-20020ac251a5000000b0050e8cd014d7sm526840lfk.16.2024.01.12.07.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 07:05:13 -0800 (PST)
Date: Fri, 12 Jan 2024 17:05:08 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Luo Jie <quic_luoj@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 quic_kkumarcs@quicinc.com, quic_suruchia@quicinc.com, quic_soni@quicinc.com,
 quic_pavir@quicinc.com, quic_souravp@quicinc.com, quic_linchen@quicinc.com,
 quic_leiwei@quicinc.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_6/6=5D_arm64=3A_dts=3A_qcom=3A_i?= =?US-ASCII?Q?pq9574=3A_Add_RDP433_board_device_tree?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240110112059.2498-7-quic_luoj@quicinc.com>
References: <20240110112059.2498-1-quic_luoj@quicinc.com> <20240110112059.2498-7-quic_luoj@quicinc.com>
Message-ID: <FC335E96-9DE2-4BC8-BE45-8DE77AB453AE@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10 January 2024 13:20:59 EET, Luo Jie <quic_luoj@quicinc=2Ecom> wrote:
>From: Lei Wei <quic_leiwei@quicinc=2Ecom>
>
>RDP433 board has four QCA8075 PHYs and two Aquantia 10G PHY onboard=2E
>
>Signed-off-by: Lei Wei <quic_leiwei@quicinc=2Ecom>
>Signed-off-by: Luo Jie <quic_luoj@quicinc=2Ecom>
>---
> arch/arm64/boot/dts/qcom/ipq9574-rdp433=2Edts | 66 +++++++++++++++++++++
> 1 file changed, 66 insertions(+)
>
>diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433=2Edts b/arch/arm64/b=
oot/dts/qcom/ipq9574-rdp433=2Edts
>index 1bb8d96c9a82=2E=2E298c0853b4d2 100644
>--- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433=2Edts
>+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433=2Edts
>@@ -60,3 +60,69 @@ rclk-pins {
> 		};
> 	};
> };
>+
>+&qcom_ppe {
>+	qcom,port_phyinfo {
>+		ppe_port0: port@0 {
>+			port_id =3D <1>;
>+			phy-mode =3D "qsgmii";
>+			phy-handle =3D <&phy0>;
>+		};
>+		ppe_port1: port@1 {
>+			port_id =3D <2>;
>+			phy-mode =3D "qsgmii";
>+			phy-handle =3D <&phy1>;
>+		};
>+		ppe_port2: port@2 {
>+			port_id =3D <3>;
>+			phy-mode =3D "qsgmii";
>+			phy-handle =3D <&phy2>;
>+		};
>+		ppe_port3: port@3 {
>+			port_id =3D <4>;
>+			phy-mode =3D "qsgmii";
>+			phy-handle =3D <&phy3>;
>+		};
>+		ppe_port4: port@4 {
>+			port_id =3D <5>;
>+			phy-mode =3D "usxgmii";
>+			phy-handle =3D <&phy4>;
>+		};
>+		ppe_port5: port@5 {
>+			port_id =3D <6>;
>+			phy-mode =3D "usxgmii";
>+			phy-handle =3D <&phy5>;
>+		};
>+	};
>+};
>+
>+&mdio {
>+	reset-gpios =3D <&tlmm 60 GPIO_ACTIVE_LOW>;
>+	status =3D "okay";
>+
>+	phy0: ethernet-phy@0 {
>+		      reg =3D <16>;
>+	      };

This part looks extremely wrong to me=2E If the reg is 16, then it should =
be @16 as well=2E You should have got a warning here=2E

>+
>+	phy1: ethernet-phy@1 {
>+		      reg =3D <17>;
>+	      };
>+
>+	phy2: ethernet-phy@2 {
>+		      reg =3D <18>;
>+	      };
>+
>+	phy3: ethernet-phy@3 {
>+		      reg =3D <19>;
>+	      };
>+
>+	phy4: ethernet-phy@4 {
>+		      compatible =3D"ethernet-phy-ieee802=2E3-c45";
>+		      reg =3D <8>;
>+	      };
>+
>+	phy5: ethernet-phy@5 {
>+		      compatible =3D"ethernet-phy-ieee802=2E3-c45";
>+		      reg =3D <0>;
>+	      };
>+};


