Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA807563C1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjGQNEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjGQNEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:04:12 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEEDE49;
        Mon, 17 Jul 2023 06:04:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1689599047; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XTDOArih5o6BzN2MYBt+zOEW/UXSiLkO5/SSIQLE+U1Q3Ar++ZsH8Q1LFnqY/0uGNW
    YnHYFAdf7OfQPAQzPofR4pOowM9aGIVTLW7tg9rFprDS6kLRrO3lzGsU39dGl0GS28ku
    eJyWIcZCK33T6OzBkOlOF9AjPeX2878vjZ6bERv1FAckZ5BMbco56IwJoI75CGDLxYcT
    ppAFNlOvbZ9thmxn/tHYzMobdJ4KugklSRH619j/NlOQGntWV63ClPZ6NbhlwFAgEyIL
    haCLdL0yZY7rLG8FAtHTSWIOJwNG7fSg010OZNptbsvbHTndhhiopWpJwMKXFl54WVvk
    AWqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689599047;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=aC+HCap+ve6OrQHjV7mHANk9IXPlf8/jagAitf7Rz3M=;
    b=cCSf//sa3sRIQn0VcCeRQ9lO4bUufCPjscol3P3oq0MFy1Ba6SE0unFwwEwPvatN33
    aCResKf869PqokyXEWYobRyVkHNcqT0bzGRv5Gf3Jakr4twWQjlDUlUCRIiVlrMQxrKT
    lXXiI8X/Fj1X67qmvK5bvqkJSHdGdHAa1mt6UpoYcKqmkqImD3+jWx/3ZNsVvucNfQbb
    euR2mZQhcyPLzJK++vByRcZL85CHZ2vsdJOZLChZawQ2mKOUjDUx5sSC7DdocjBj2Fws
    sk2G3HcXmr2717zzlTQxJjDT8qH2NKVFMATn2PkFsK27eWhdP7e+mqNxpSTHftVsymNN
    GTNw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689599047;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=aC+HCap+ve6OrQHjV7mHANk9IXPlf8/jagAitf7Rz3M=;
    b=b0h8ZapQaYbjYqWolkzMFNfEkNjd7Ub4/ALF9EGtNEIjIcIBZwXMPvkRM2q48xEn6Q
    G8RY2VjEg38wl6j1IhEPz1Z8QdILzoetBJR/UxviX9Fo7z+7wVfys4Wu1B704kk6P9KL
    ckjUKCJ4VH5fPK5db169XZUP8GfV4ce/MwOFZiv9XpGgXu/zjiyeAutaPLnbwwxgBI0E
    ZysTXi5RV8+q14r52T++edo2VUdvmj2Y9lQHSSqWSBITsvDzg0HZsI3AdH4M0vjGbe3t
    sSEuAMl0kW75rRXEaLn2LKXU0nkYIhU4ANWbIALasfrq0FSbcWcVlPIUAwuRn6jQXI3A
    5xwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689599047;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=aC+HCap+ve6OrQHjV7mHANk9IXPlf8/jagAitf7Rz3M=;
    b=mNBOhNvpUL0bSH9Ybp+PvmRlEMwi4me92vj7BipOglvZMVJVs2n8Y95HejSxI+I/iF
    qhbx+PbnkapLN0zMPJAg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8Z2L1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z6HD47YVD
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 17 Jul 2023 15:04:07 +0200 (CEST)
Date:   Mon, 17 Jul 2023 15:04:00 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     djakov@kernel.org
Cc:     konrad.dybcio@linaro.org, andersson@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] interconnect: qcom: icc-rpm: Explicitly return 0 at
 the end of the function
Message-ID: <ZLU8QKDUC_oGwIDz@gerhold.net>
References: <ZLUdXBoMJdSzeZdq@gerhold.net>
 <20230717125534.2455745-1-djakov@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717125534.2455745-1-djakov@kernel.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 03:55:34PM +0300, djakov@kernel.org wrote:
> From: Georgi Djakov <djakov@kernel.org>
> 
> Fix the following smatch error:
> drivers/interconnect/qcom/icc-rpm.c:243 qcom_icc_rpm_set() error: uninitialized symbol 'ret'.
> 
> Fixes: 32846c4a8f2a ("interconnect: qcom: icc-rpm: Set bandwidth on both contexts")
> Signed-off-by: Georgi Djakov <djakov@kernel.org>
> ---
> v2: Just return 0 when reaching the end of the function. (Thanks Stephan!)
> v1: https://lore.kernel.org/r/20230717073429.2115015-1-djakov@kernel.org
> 
>  drivers/interconnect/qcom/icc-rpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index 612390b9eb18..2c16917ba1fd 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -240,7 +240,7 @@ static int qcom_icc_rpm_set(struct qcom_icc_node *qn, u64 *bw)
>  		}
>  	}
>  
> -	return ret;
> +	return 0;
>  }
>  
>  /**

Thanks!

Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
