Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B590676A4C6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjGaXVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjGaXVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:21:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA9E124;
        Mon, 31 Jul 2023 16:21:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9832961350;
        Mon, 31 Jul 2023 23:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67782C433C8;
        Mon, 31 Jul 2023 23:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690845681;
        bh=UeWtxD2MNERE0o3Lgj+lel/LnXy0KcpgccXB7U/54GU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f2oGgg9S3yIz52yJ7KNAtSVDd8dYYhn20eIwS9yNT9+YUUGJJlSr5iT2D82QWdou/
         z2i6XKFo7XK7rwBoyhAJBVLjPn+/fMFRdRmtJHOwY7tTb/I987iDV88Bhha5nKFOGt
         2m3UpTw0JTVCbVQi6tSHtvyVu6jJh5W7mJHPMm7rOelLGWpN2ausWEuqoZo6iE9Ebw
         IFoqiGwOSdiVSoyR25kCBgTscGEZCqx2plhcLnMHVSRo1RJ5HmNpw4pCRJRcZ0gX9N
         hIPlc6DqKRj9FydH4kMok/z2VSe9RHOsilQpFrdb7zLPqw8Adxv/cAMQShpK5JLCTe
         2fxOKi7k/qv4A==
Date:   Mon, 31 Jul 2023 16:24:26 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Praveenkumar I <quic_ipkumar@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_varada@quicinc.com, quic_clew@quicinc.com
Subject: Re: [PATCH v2] soc: qcom: qmi_encdec: Restrict string length in
 decode
Message-ID: <educjx3enypc4r5pzjb7vopaf2df2s4kzkpqsyecoysxws5422@arrsgt6vjej2>
References: <20230731100311.2506271-1-quic_ipkumar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731100311.2506271-1-quic_ipkumar@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 03:33:11PM +0530, Praveenkumar I wrote:
> The QMI TLV value for strings in a lot of qmi element info structures
> account for null terminated strings with MAX_LEN + 1. If a string is
> actually MAX_LEN + 1 length, this will cause an out of bounds access
> when the NULL character is appended in decoding.
> 
> Fixes: 9b8a11e82615 ("soc: qcom: Introduce QMI encoder/decoder")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Lew <quic_clew@quicinc.com>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>

The signed-off-by list says that Chris certified the patch's origin
first, then you took it, certified the origin and submitted it to the
mailing list.

This matches reality, but you lost Chris' authorship in the process,
please add that back.

Thanks,
Bjorn

> ---
> [v2]:
> 	Added Fixes and Cc: stable
> 
>  drivers/soc/qcom/qmi_encdec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/qmi_encdec.c b/drivers/soc/qcom/qmi_encdec.c
> index b7158e3c3a0b..5c7161b18b72 100644
> --- a/drivers/soc/qcom/qmi_encdec.c
> +++ b/drivers/soc/qcom/qmi_encdec.c
> @@ -534,8 +534,8 @@ static int qmi_decode_string_elem(const struct qmi_elem_info *ei_array,
>  		decoded_bytes += rc;
>  	}
>  
> -	if (string_len > temp_ei->elem_len) {
> -		pr_err("%s: String len %d > Max Len %d\n",
> +	if (string_len >= temp_ei->elem_len) {
> +		pr_err("%s: String len %d >= Max Len %d\n",
>  		       __func__, string_len, temp_ei->elem_len);
>  		return -ETOOSMALL;
>  	} else if (string_len > tlv_len) {
> -- 
> 2.34.1
> 
