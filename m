Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6927560EE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjGQKwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjGQKwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:52:21 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5E011F;
        Mon, 17 Jul 2023 03:52:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1689591138; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ox+TWn0YjWuCr9ogTPXRx5BLCMQ3yFwQY2Ra598jHHESf5+0UYplUvEAoi4BWpjLlG
    BsjBZMBXNt8EkI7TtS1dFoEtYrILDF5XwvuEMvBwh+wmBCcEv4NCKcYea7N4xj/KuxN5
    kmxTkamuDfzzYml4ko23t751pjljAc6V6luXkq0vxflnJUZ07sipaFBdzcVX/bhByPLb
    wcsUqoJFagY5mxQGU613XNhADpFuuH21Vpl6sl7qi3XM62GLNUfVnHfJUq/SderbFB30
    WQ0Rj/vv8eQPtaV74snQRZ8XOKIgS/T8yE1UadYMAQLY+GP2wzX4m9piFv3i1hl3dPi0
    elfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689591138;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=YYfzMVB1ks/ozCqaRZGCAgoaf2X54ab3g5vvPYZoYkg=;
    b=ZNHyvBjd7TOIHnhT2KGE516JQJ3LPqdADolyXv0JIuBKs25YW5/iAJc4RjlkjrfFOG
    7eYu1MG/ufAjUQ8z+KBrwXljahT5PKETmlDgkJz3TfySqI+cuv6TluqCA02uKpb3JuuM
    gaxWNYlJAS7/JV2+XLQi6jdwMJhqEl8+Np12+ZmmsZ+7ai32kOyMltbdAiLSn4xAjfZl
    c3RVme4DiKgO+E/eo6+d+57GZE0hCScQecxWePeFuyMzNE8u8k8/8SBaOqahH/p9uUie
    E0iYMUsaYL28ilzgoLtDoC8Nes2naWIPofo/Db4Ud8KC3N8WOjJYl3rZEY+68RVXIQZm
    ayXw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689591138;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=YYfzMVB1ks/ozCqaRZGCAgoaf2X54ab3g5vvPYZoYkg=;
    b=Utp816/NmO5yy4i1ZiSkcp+XPWLk2QuGb2RaawgyY5ns19+MFvzUm4B1C3eMSQLomF
    7kIWfX+oJ2vAqIRKOAkWGBpIQgoA2yJ2ESCgvCFr5Yy2LokGriFpUGCpbMrIHP0wxSdf
    727vusGS684tWHh//Aeb9S1mZj9KPJqfAeXfJ3D151l+l1yc4zwleE9aTObSL8GmSq/j
    qP7dY2UTbL8ECb1tj8B309nZygO7jn3M4qkO1BDnqTIDKBDWBIHnsCOHGadCpclrUvUb
    +Cg/sQC0f5CIAbNI6TR91jcHGS2ql+aKiZUGxiLAz4K1Ii7XgdGS+rUthienqAQ0O7jK
    S2BQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689591138;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=YYfzMVB1ks/ozCqaRZGCAgoaf2X54ab3g5vvPYZoYkg=;
    b=FO6XUvjXoaKszkTP/sSE4aHR1pJ0Msi1VwxihSi4NtNrWbWSHNTggS2PVF9yYmqwGJ
    B6/9sHQVwUmvlD2qkcBw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8Z2L1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z6HAqHXry
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 17 Jul 2023 12:52:17 +0200 (CEST)
Date:   Mon, 17 Jul 2023 12:52:12 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     djakov@kernel.org
Cc:     konrad.dybcio@linaro.org, andersson@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: qcom: icc-rpm: Initialize ret variable to
 fix smatch error
Message-ID: <ZLUdXBoMJdSzeZdq@gerhold.net>
References: <20230717073429.2115015-1-djakov@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717073429.2115015-1-djakov@kernel.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 10:34:29AM +0300, djakov@kernel.org wrote:
> From: Georgi Djakov <djakov@kernel.org>
> 
> Fix the following smatch error:
> drivers/interconnect/qcom/icc-rpm.c:243 qcom_icc_rpm_set() error: uninitialized symbol 'ret'.
> 
> Fixes: 32846c4a8f2a ("interconnect: qcom: icc-rpm: Set bandwidth on both contexts")
> Signed-off-by: Georgi Djakov <djakov@kernel.org>

Thanks for spotting this!

> ---
>  drivers/interconnect/qcom/icc-rpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index 612390b9eb18..6718cc648d75 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -206,7 +206,7 @@ static int qcom_icc_qos_set(struct icc_node *node)
>  
>  static int qcom_icc_rpm_set(struct qcom_icc_node *qn, u64 *bw)
>  {
> -	int ret, rpm_ctx = 0;
> +	int ret = 0, rpm_ctx = 0;
>  	u64 bw_bps;
>  
>  	if (qn->qos.ap_owned)

I think it would be a bit clearer to change the "return ret;" at the end
of the function to "return 0;". The ret variable is only used inside the
for loop and always handled there, so we always want to return 0 when
reaching the end of the function.

Thanks,
Stephan
