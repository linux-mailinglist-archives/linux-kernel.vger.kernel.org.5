Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D081C7A1BE3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbjIOKTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjIOKTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:19:12 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFE5E9;
        Fri, 15 Sep 2023 03:19:04 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a9b41ffe12so1218028b6e.3;
        Fri, 15 Sep 2023 03:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694773143; x=1695377943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gBRNgKBo9636s47BGwWVB4QKKZP3PNOVrB6JUSp8VSU=;
        b=H1AWv2Jiti17w/RFTWf9ZLidaYhZCE+eFFSuzPZ+mK/LyQyfZ8ZHEwlLT9mkRiWG4F
         8grW/t4Gw/gxMm2X24JLtEswLrsWu99B7NFAgs/sTmM/RSLW7BSSEAZ2yalr1HQLeIXg
         7TceqEQ8uypJ7F3BGwdVlI9JpYrUBcuYe0IXmY4iFlS0b2wO/l0RZ2e+mwN34wtjJbKe
         G86QVNMQB1ygBYghA/smfNu6cnlOsG8bBcYgBdhm08hIWw2by+mhTBaOqgQjF8PZn+XH
         iZUfeAYpPWOo2eA2o3pwLrEjTU6atltMe/D6f9DLPKdiZhrP0Z0d4WpHK1QoCP0XX4mw
         h0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694773143; x=1695377943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBRNgKBo9636s47BGwWVB4QKKZP3PNOVrB6JUSp8VSU=;
        b=FeyAH+XKQxwAe/jA2J3w5fNjZiyA5GtKs/DF4aYXsRyIptD3bET99no0FyMhoJNtg1
         qVXPm5mW3plHVyLWjkCUK8PZIsvNUQRkYKLtmSkrJwB+0xu7UIXxBZ89GQCNwWIrNw8i
         5xmO7WdD5INlvQAo+iGMOV+b7jmuzaCllHipxYlIhbGKJ49wQVKmyO68zPxoplEMtJl0
         +eWgcPI4d7EDc+WH+2hPA7dg8TM+k8EWfkC4N2wXvbo+ISTMSOSOyaS8xuaksmEqflid
         1XyKrJPKHznFP+9Su4apEYJHp2G6bjxArygFK5WHDT9XvZQmi3csR7XZLG+uoYiZ9puo
         J7bw==
X-Gm-Message-State: AOJu0YwvQ1XXHeQ4vmnQwNQW3dRcmL3WVirv61nWH8cDvlVXDIsTKsUA
        0rgPsnrVJD4JD8bqodHKhKo=
X-Google-Smtp-Source: AGHT+IEvlosv0SIRPQNAginM3ohzzNzp4Xqh9vNKnbfKPM+wAw9tG7sja/ozbim3kIXbRMVW4vCoKw==
X-Received: by 2002:a05:6870:5488:b0:1d5:4fb0:102 with SMTP id f8-20020a056870548800b001d54fb00102mr1339662oan.31.1694773143468;
        Fri, 15 Sep 2023 03:19:03 -0700 (PDT)
Received: from gondor.apana.org.au ([2404:c804:1b2a:5507:c00a:8aff:fe00:b003])
        by smtp.gmail.com with ESMTPSA id q7-20020a63ae07000000b005634343cd9esm2491347pgf.44.2023.09.15.03.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 03:19:02 -0700 (PDT)
Sender: Herbert Xu <herbertx@gmail.com>
Date:   Fri, 15 Sep 2023 18:19:01 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Om Prakash Singh <quic_omprsing@quicinc.com>
Cc:     neil.armstrong@linaro.org, konrad.dybcio@linaro.org,
        agross@kernel.org, andersson@kernel.org, conor+dt@kernel.org,
        davem@davemloft.net, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        marijn.suijten@somainline.org, robh+dt@kernel.org, vkoul@kernel.org
Subject: Re: [PATCH] crypto: qcom-rng: Add hwrng support
Message-ID: <ZQQvlXvGy8p01uJS@gondor.apana.org.au>
References: <20230901131502.1549809-1-quic_omprsing@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901131502.1549809-1-quic_omprsing@quicinc.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 06:45:02PM +0530, Om Prakash Singh wrote:
>
> +	qrng = (struct qcom_rng *)rng->priv;

Please stop using rng->priv, it is obsolete.  Instead embed the
rng object inside qcom_rng.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
