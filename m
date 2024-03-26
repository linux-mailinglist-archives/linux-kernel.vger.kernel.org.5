Return-Path: <linux-kernel+bounces-119951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCD588CF56
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0DA1C23B7D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D004512AAFD;
	Tue, 26 Mar 2024 20:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="dpsh2hHz";
	dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="YdNIjf+M"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32E773503;
	Tue, 26 Mar 2024 20:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485987; cv=pass; b=bYH+5zlWNLRYVlc3u2HMrr6R47k0Tk3IIsPLivHeKI/jioxpdZdm0xvnAHEX4o5fodqwulT2mUQJzmc3N6qT3gesS86H66JSXv3n3GxU8u9yvKOt9BpnK0mhv/uOhQ1oqVZULoZgo+1VmdNXSEYXrmWDHrEUxM1bCs/Np1DdGwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485987; c=relaxed/simple;
	bh=f2x2X4qvlZRc+1fqK+Zk/v7NWSHCzkhs3R7wilhmoQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QI+qRqXvbJfI/p5K5/C/Xumm9ttBvN43+1aw8qYNiP61/VCgLCW9wyBNnsL1bRfbLQ1B/aOHn8DwcSq9EtQ5y9ruX5EQbDt1dNtjWzn/AG9G5/sN9Ak//JHFhv6MWgRvjm+B0kzwaapVpI7+NQbJQw1ube85aPyyg5JU9BFso5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net; spf=none smtp.mailfrom=gerhold.net; dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=dpsh2hHz; dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=YdNIjf+M; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=gerhold.net
ARC-Seal: i=1; a=rsa-sha256; t=1711484180; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Atkyc6ACEe+EM/2p3Rc0z/26sVqD7x66Rrricb0henj4pr7JFXjG8ZBZsxP/56zTiP
    7byUSx3aaP/sulLgURtVXs1Pvo+EE8JgchfEOqqlKIO9MS+TLpq3LWYFLlaUg7WO+mSJ
    ObHw6FaGxoY48aIc5FiaOwFoR+pdPw+dN4cg7tYF6fYL3vuNrDHwaMRVv8AG47qS6Cp2
    KYUJuN2B1QwiJCNXc/N3wacCi0j5GoMJ83ao3Dp8nwEHTZydETQbRl4K6L7qzo+HGcN1
    gJKDPQqqGXVz62n1wwZZxMUYGOABHD8vDvwyxdV0epgebJsPD9lSWj6+hplvSAOriwxd
    3UxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1711484180;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Pbom/uplsGQjVCcQowzS3UwrKwYpIwAR/UOVLRl7SJs=;
    b=PwLSQaKbKPnYNh0Ei6LdxQIoRPMrvCwSeqCTSm3Ok9P07wNLl7TaKUshOgOOBgPYpf
    raTvabH3jVeM+QlP83Ft9lp7FGzGGIBjUaTpX7JLh6C+xBUmzlIW1gjoRyp0e461bxpK
    WUrdQwGPE+bDGsIUtP1ccNiVn1ylHcbNX0pupRIApxKu7X++K6cxbSPzgU7fvzzo1cyD
    K/uZekgL+ZomtCqYfWvbvILO6OM9zx7SU5QRoQY2+HhS4sTYvxqNJkMJkdal0p0c1AEU
    WEXVEw7XGt+Qf4VmQsAaRqrzMkJFLbl3i4fHWv43dD4RLs49SUdYPbxTTLlH2kuAoImv
    CBDA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1711484180;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Pbom/uplsGQjVCcQowzS3UwrKwYpIwAR/UOVLRl7SJs=;
    b=dpsh2hHzzYwEStfBd0eC8EquDB7MosbB2zrqQWkWOrhXGkBP9m8Pu5tvv1cdQcnzx5
    h29RaXrZt19hXPvrEjMh8MFQN+4ReLJWaOTliRUCoaVQaJnBitbAQ2a/FASJ97Y2fnQS
    aQAhG/U830zz19s+n+rL1xCqUZgpd7THg0CSB6fvDCn5QKjYJYqXRubaEXlM9DWWFy4K
    k02XqdObt+6fH/Q39QvEfKI6NVhbi8ADqog1/keiupn4IdBEL6+p7czdluqnEkIMDiTL
    hnn/VolPRpOZw5ZyKSYwX4k1Oi0QjYhKeGxCHIOFNEouH7X1TkWr6Fce1ZwFoAa2foLW
    efrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1711484180;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Pbom/uplsGQjVCcQowzS3UwrKwYpIwAR/UOVLRl7SJs=;
    b=YdNIjf+MWeX1Ouuq+NRWddixxoIVOkITHjvgG34moF9/kooZ/fLeTClpe8Xs/Izdc6
    fZbTMQafjR9hh5sRAUDg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8piJ1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 50.3.2 SBL|AUTH)
    with ESMTPSA id Raf12502QKGKL9I
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 26 Mar 2024 21:16:20 +0100 (CET)
Date: Tue, 26 Mar 2024 21:16:14 +0100
From: Stephan Gerhold <stephan@gerhold.net>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawn.guo@linaro.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] interconnect: qcom: qcm2290: Fix mas_snoc_bimc QoS
 port assignment
Message-ID: <ZgMs_xZVzWH5uK-v@gerhold.net>
References: <20240326-topic-rpm_icc_qos_cleanup-v1-0-357e736792be@linaro.org>
 <20240326-topic-rpm_icc_qos_cleanup-v1-2-357e736792be@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326-topic-rpm_icc_qos_cleanup-v1-2-357e736792be@linaro.org>
Content-Transfer-Encoding: 7bit

On Tue, Mar 26, 2024 at 08:42:33PM +0100, Konrad Dybcio wrote:
> The value was wrong, resulting in misprogramming of the hardware.
> Fix it.
> 
> Fixes: 1a14b1ac3935 ("interconnect: qcom: Add QCM2290 driver support")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/interconnect/qcom/qcm2290.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
> index 96735800b13c..ba4cc08684d6 100644
> --- a/drivers/interconnect/qcom/qcm2290.c
> +++ b/drivers/interconnect/qcom/qcm2290.c
> @@ -164,7 +164,7 @@ static struct qcom_icc_node mas_snoc_bimc = {
>  	.name = "mas_snoc_bimc",
>  	.buswidth = 16,
>  	.qos.ap_owned = true,
> -	.qos.qos_port = 2,
> +	.qos.qos_port = 6,
>  	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
>  	.mas_rpm_id = 164,

The mas_rpm_id is also wrong, I think it should be = 3. This looks
wrongly copy pasted from BIMC_NRT. The qos_port on the other hand was
copied from BIMC_RT. I wonder how that happened. :')

Thanks,
Stephan

