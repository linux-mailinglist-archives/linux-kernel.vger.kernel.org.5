Return-Path: <linux-kernel+bounces-18086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C79C8258A2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAEC81C23499
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EE232197;
	Fri,  5 Jan 2024 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="pf/RCNo4";
	dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="Yx/GVOrr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4488231A9D;
	Fri,  5 Jan 2024 16:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=gerhold.net
ARC-Seal: i=1; a=rsa-sha256; t=1704472260; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=RpNkKT0kvh168NrZmfZ8byCMvxzE2cQCWMJ47PzHEiDgESu1bH1BQT9kV2Tt20C7Th
    e+bVI7wnj0UKq9eKtd8LX4STF974htFOS7lmOkfuEJvG3VI5e1AQDk3D+MhpQXzdywdP
    HkEMWsiMxvBMD3QOr9hN6lVwrr3n1qaE75/PuqWX1NSO328SaZHxL50jY+bAWZTQaeQL
    qCIpMPvmiAbeycDi+F7SGLwTOLfXotfeJqGkRB2CjEI4dYPwxmWnNwz0+4TlsR+bwbjO
    /DjUOvimW9g+BBF7Q/8TiQaME57uI2W8PTVsEwRmTNC4JtOwA3D136S3B6+I22Cq3Uad
    tMNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1704472260;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=xfxw1UGsyCARhz8m1xU5KAa5xI3OaZKpqi/VuCOD7Ts=;
    b=kKSbWJGgpuAfC+XPpxIHvyLKElCqkYDzmafWm6vZ4jUyKkUrm/qYJxIUu7y4OG8knB
    cYrHHkOBOdqJwgUpuUOvFb2LGGDq8sDot4Qm/K9YvsswZyYPOcyVLaJCTkPMX6q00C1M
    MjrKKRc1x5DHNB8aSOGBBoC1jgq3Jkt56+IRMCu32DOGSsFIVvZkLfjTA+Nccj/+M2UB
    XyIT86R6msz3wFRbUyLo353rdsPZpaJ/lscqYBiVgUsKrzS+WqLKBazAAtgo+BMQYTKm
    VfXjrrdRABGDQZCS0A+uIQU1Ssi8dmy9QQ3e21oeUtFOFl6qrV8n5I7ptMCv9qLoW892
    vtDg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1704472260;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=xfxw1UGsyCARhz8m1xU5KAa5xI3OaZKpqi/VuCOD7Ts=;
    b=pf/RCNo4/934634XvBWD1XMhiGmleoCDYWCAu+ylnlcJqGW3PD6JL+VJpHySiTNhij
    /bqyKSCYMRp2wxhIs/cJwbXsMyQi8LE36+q0hB/ewteVoAddhQr7K1BdZZYC43yH2v5m
    XkNxKImO6ozJfm3otuCJaH3XdgfcEX6R2W1IyiqkFY3dNQlKlBpWns5Vlxi3zbS0aw0A
    g1ZgJ/3eoeHJs8ViB8hreBR+dohphfRjVjmw/868bdKVEoGMFf0G5hmXNYC9Tl+RHYVO
    hOJ9NyQpVz5Lsbu5lRiyDvaWYEhiCJexpjRnoOMISqBnfvTIFjVYI7nkNUcjHlmSGwll
    dWvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1704472260;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=xfxw1UGsyCARhz8m1xU5KAa5xI3OaZKpqi/VuCOD7Ts=;
    b=Yx/GVOrrI34fo9e5kYUEuXlplSMvmlBW+F/oCgOkOzeSR/UG75xOQyPu2SZDgzIdKT
    KKXwf3JnbgJx9fy8VnBQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA9Zfh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.10.0 SBL|AUTH)
    with ESMTPSA id 58bb61005GUxTk8
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 5 Jan 2024 17:30:59 +0100 (CET)
Date: Fri, 5 Jan 2024 17:30:53 +0100
From: Stephan Gerhold <stephan@gerhold.net>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm6350: Add Crypto Engine
Message-ID: <ZZguvdJTyVgfxm4D@gerhold.net>
References: <20240105-sm6350-qce-v1-0-416e5c7319ac@fairphone.com>
 <20240105-sm6350-qce-v1-2-416e5c7319ac@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105-sm6350-qce-v1-2-416e5c7319ac@fairphone.com>
Content-Transfer-Encoding: 7bit

On Fri, Jan 05, 2024 at 05:15:44PM +0100, Luca Weiss wrote:
> Add crypto engine (CE) and CE BAM related nodes and definitions for this
> SoC.
> 
> For reference:
> 
>   [    2.297419] qcrypto 1dfa000.crypto: Crypto device found, version 5.5.1
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> index 8fd6f4d03490..516aadbb16bb 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> @@ -1212,6 +1212,37 @@ ufs_mem_phy_lanes: phy@1d87400 {
>  			};
>  		};
>  
> +		cryptobam: dma-controller@1dc4000 {
> +			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
> +			reg = <0 0x01dc4000 0 0x24000>;
> +			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells = <1>;
> +			qcom,ee = <0>;
> +			qcom,controlled-remotely;
> +			num-channels = <16>;
> +			qcom,num-ees = <4>;
> +			iommus = <&apps_smmu 0x432 0x0000>,
> +				 <&apps_smmu 0x438 0x0001>,
> +				 <&apps_smmu 0x43f 0x0000>,
> +				 <&apps_smmu 0x426 0x0011>,
> +				 <&apps_smmu 0x436 0x0011>;

The last two lines look equivalent to me: 0x436 & ~0x0011 = 0x426.

It's also a bit weird that the mask has one more digit than the stream
ID. And ordered numerically (by stream ID, first number) it would be a
bit easier to read. :-)

Thanks,
Stephan

