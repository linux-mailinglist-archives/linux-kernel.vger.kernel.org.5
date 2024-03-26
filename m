Return-Path: <linux-kernel+bounces-119963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A72B488CF7C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F2501F64BE8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0D312BF04;
	Tue, 26 Mar 2024 20:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="ngmyCWld";
	dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="/Uvl4QaV"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8234D1E51D;
	Tue, 26 Mar 2024 20:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711486632; cv=pass; b=bjrWVrw9UuwfyCNHIJerOhtRmuD83X313Hwd9q+d+G2XHl0cVvmSqVc9YabK9+f/vFXR3qbTSLOBZSXkiTaxF7iG4kJUc4Lgw8j4JvZ8TpnDpY3Ihj5xVzElmNfho7W8zzskhotggdYuZ6llZpruNNOlhOmDkmB05TZJIi0Ulq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711486632; c=relaxed/simple;
	bh=ZtadjjEnLI0Oyh5yZHN/h9uEzlNcXQprvGYtgzryMws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4BQO6x1n/bxwb9x9i1GjRU5nAvzNJAQjgyLFUcufEf2DerF/gx86WWSmws6UOSz3ebcX1mh6Q9Ld2Cao2WVVOakzaDFdoa3zIULfs+Us/wGPN7TC7UCGiC0J+PErkluzpgi1C7UPqtcugoPjtVx/wbDOtk3q+wBn9O9yXfV9MI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net; spf=none smtp.mailfrom=gerhold.net; dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=ngmyCWld; dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=/Uvl4QaV; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=gerhold.net
ARC-Seal: i=1; a=rsa-sha256; t=1711486627; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=M2lhtyVfu1Km00AyKzgBlhk+q9Gi6ZZb6QtyACdW8NCdG7ubG1xrKkZ6Begdw0SozD
    qxtTPh6qR96TygrvYc3I1JF+iMcvRf09Wg8SaW4NYn7vP+aPH3wtcifj1ysZVhNMWf4a
    1QxlfP72a2q3iE4mmY6yS+JKyuw1aeuaraU6Cl+Mv2pDUXxVCEuAB27QYKAfm5j2tumn
    rCGA5W1WhAHotg7XCH6/fgEggyeT4O6Pv8AnuitNn5RlMpdMrpw4UqdhGOh2xUSWDU+G
    QnpiSUsQMHQDpla5te3GIhl/KTOFuwe+LNRaYTmqv387nQH9V7ENYLRDMPdD/IU3sfXn
    W+fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1711486627;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=3WyCESPFX/jeAoBv0SUgbR0KTj4t/YtTwCDbEx3hi44=;
    b=MKFZCfaFWfCSHmQ4EDdsO3f1mOCWRTv2NNuchAFmmmEL+V2hX+8KaV9pPUGSAzTfrW
    aJCCE4QcE4cheGTEHNEDV3V1vDFyF+ABfRkUy3CA9uTmH4Mo/HI2v7JAM+X1D4Il31Ax
    7+MmMB0jAIWbJLHo88o7avl9PnBvQubxGQ29ipF9455JMMO41kPBKSFhYGeRWKQRKmIB
    7QmWhgt7CPJziRYujLEEftDgRLuOOP3eEoMGCbOvW88Fpgz72DKiZC2LvmUWa8HKEzd0
    /TaQ2GwU5SGRvx2YBvyHDN+Pm4LZcuSDyHSh+DGtW8ZnpJqHZlgpNJJxTphAJZSv+p77
    FtJw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1711486627;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=3WyCESPFX/jeAoBv0SUgbR0KTj4t/YtTwCDbEx3hi44=;
    b=ngmyCWldqGNscBEejeCUmk+5R4FO+kvbyoI76wk9VXX9Q94mfkDsT1giq3GNsi82dS
    PlgW3bne0PC8qO2lPc0eac0IsELUwTgyZaWTyng88ddtf0qnQgQQUg86Kp60abXYhmR+
    mhwBMUcn2Z2bHHxENOAPnv36YT7awRoH5TFxj5jaPier9krKq3gAj4Kl3Ec5CXL72evu
    QA8snovtqF1qLlFLrEMx3AT6K+cYsXt5sOsDqPRExwwqR20+JgxlqYnmFG011L3xJZrd
    1OZf78qQXQgtBoznyelgPAMj8QiZ0CEcii/SqdBUx3GAS7noDGJqYqbSsBr+k9pIgK49
    /E/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1711486627;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=3WyCESPFX/jeAoBv0SUgbR0KTj4t/YtTwCDbEx3hi44=;
    b=/Uvl4QaVHvco9HIf32MTqks+nSvLQHU/v4e021dPtfRHghhGfuUhuSBkE5XjoBs7Rw
    jxbhuibFfNEC+mK6C0AQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8piJ1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 50.3.2 SBL|AUTH)
    with ESMTPSA id Raf12502QKv7LD8
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 26 Mar 2024 21:57:07 +0100 (CET)
Date: Tue, 26 Mar 2024 21:57:01 +0100
From: Stephan Gerhold <stephan@gerhold.net>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawn.guo@linaro.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] interconnect: qcom: icc-rpm: Remodel how QoS
 settings are stored
Message-ID: <ZgM2naP4mGLKwbCV@gerhold.net>
References: <20240326-topic-rpm_icc_qos_cleanup-v1-0-357e736792be@linaro.org>
 <20240326-topic-rpm_icc_qos_cleanup-v1-4-357e736792be@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326-topic-rpm_icc_qos_cleanup-v1-4-357e736792be@linaro.org>
Content-Transfer-Encoding: 7bit

On Tue, Mar 26, 2024 at 08:42:35PM +0100, Konrad Dybcio wrote:
> Currently, the QoS settings are stored in the node data, even though
> they're a property of the bus/provider instead. Moreover, they are only
> needed during the probe step, so they can be easily moved into struct
> qcom_icc_desc.
> 
> Reshuffle things around to make it anywhere near readable & comparable
> with a reference. As a nice bonus, a lot of bytes are shaved off and
> a few miliseconds are shaved off here and there.
> 
> As an example, bloat-o-meter reports this on sm6115.o:
> Total: Before=14799, After=13263, chg -10.38%
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/interconnect/qcom/icc-rpm.c | 123 +++++----
>  drivers/interconnect/qcom/icc-rpm.h |  13 +-
>  drivers/interconnect/qcom/msm8909.c | 268 ++++++++++---------
>  drivers/interconnect/qcom/msm8916.c | 153 ++++++-----
>  drivers/interconnect/qcom/msm8939.c | 157 ++++++-----
>  drivers/interconnect/qcom/msm8996.c | 517 +++++++++++++++++-------------------
>  drivers/interconnect/qcom/qcm2290.c | 416 +++++++++++++++++------------
>  drivers/interconnect/qcom/sdm660.c  | 393 +++++++++++++--------------
>  drivers/interconnect/qcom/sm6115.c  | 239 ++++++++++++-----
>  9 files changed, 1224 insertions(+), 1055 deletions(-)
> 
> [...]
> @@ -70,20 +68,18 @@ struct qcom_icc_provider {
>  };
>  
>  /**
> - * struct qcom_icc_qos - Qualcomm specific interconnect QoS parameters
> + * struct qcom_icc_qos_data - Qualcomm specific interconnect QoS parameters
>   * @areq_prio: node requests priority
>   * @prio_level: priority level for bus communication
>   * @limit_commands: activate/deactivate limiter mode during runtime
> - * @ap_owned: indicates if the node is owned by the AP or by the RPM
>   * @qos_mode: default qos mode for this node
>   * @qos_port: qos port number for finding qos registers of this node
>   * @urg_fwd_en: enable urgent forwarding
>   */
> -struct qcom_icc_qos {
> +struct qcom_icc_qos_data {
>  	u32 areq_prio;
>  	u32 prio_level;
>  	bool limit_commands;
> -	bool ap_owned;
>  	int qos_mode;
>  	int qos_port;
>  	bool urg_fwd_en;

Side note: There is a potential for more micro-optimization here: You
could save 4 bytes of padding if you move all bools together at the end
of the struct. :D

> [...]
> @@ -134,6 +131,8 @@ struct qcom_icc_desc {
>  	bool keep_alive;
>  	enum qcom_icc_type type;
>  	const struct regmap_config *regmap_cfg;
> +	const struct qcom_icc_qos_data * const qos_data;
> +	const u16 qos_data_num;
>  	unsigned int qos_offset;

Nitpick: Why is the u16 const when the other (non-pointer) members are
not? The u16 also feels a bit like overkill here. The struct would have
exactly the same size with a full unsigned int because of padding.

Alternatively, you could consider using an empty last entry as sentinel
instead of adding the count (i.e. with NOC_QOS_MODE_INVALID = 0). Not
sure what is cleaner here.

I haven't looked closely at the actual conversion of the definitions in
the drivers. What is the chance that you made an accidental mistake in
there? Or was it scripted? :D

Thanks,
Stephan

