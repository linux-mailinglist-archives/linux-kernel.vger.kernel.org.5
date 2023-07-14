Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF2C753F35
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbjGNPoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjGNPoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:44:08 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA23A30F8;
        Fri, 14 Jul 2023 08:44:07 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9891c73e0fbso413481666b.1;
        Fri, 14 Jul 2023 08:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689349446; x=1691941446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O1pfuLmbVANsO+GIIPDG/ltya7NI3XS+7j/WykH9MY4=;
        b=kxE8VWNZptMyis8Y6oNjtT1fkoRYZsqqlXPdk1nFimzWvp4na66AnmIRnmCExHfArr
         SRtBXyshjwfWnJnbv85sGrx/eTrKY1X9Yp2AojFDzKvjrw4EKjM4xMZV5uMM57vKy4Xn
         EuSDUFQTrkfBTNP1U7GOiYfTvRI1La5k8trs582kVimlps0B85L4QB9zFASgCuiKBBct
         MtmVTDDusBjrUbTj55RuEBnlFBlDjbMSFafS8irfP+sam2bPguRwMBr8+KLesnIdV9J9
         dgkmTjVj2iNNniYGPPfVR4TE3optkIuxrM3rbhCNvK/sv5bYAvfh1yH+qnGcBNwT9+WC
         gaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689349446; x=1691941446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1pfuLmbVANsO+GIIPDG/ltya7NI3XS+7j/WykH9MY4=;
        b=UhinEn0zSJ6RGoZo9gwsBKZ6FSAuOSsaQiI5h3m/XKW5USOHFmXdsn7pUnscE96v+G
         WMbz9W3FGbVYFeeFJg+pSUDmlDIc0um63X55tcV6enF3mGwxJMJWBD6uJZ4tTOs8KFaX
         uje/XJzz7INreT3gf7xjqEr1iSPMzLwM/xoTeuo0tPE8K+EEXQR9n3HjIyCkV8aRQ0Gn
         MYxp+auFuRAwJwkEZQFOcTXV7m/CQgLuchJO9E9u8FHxhT9QQeUcu6LgkN5bB/exH8MC
         CokO65y/8SMOSCuT9x3USYDKLdZvnBHBbu4Dw9O7ixpKppXXIwqZwIh4NA8RkCf3QF0X
         i/BA==
X-Gm-Message-State: ABy/qLYDAW5v2D4VH+SQRp8TMY/eWYDuALZVzGrYFa3HBIv99m55sFdy
        LkluouOq3CBdrK3TVmpRllc=
X-Google-Smtp-Source: APBJJlEGSEbnZvapDgTg793Oybz1YdDATqOaxIjs+W9QdiXYr5yw5nRqBmHADKbFzpDR4DK3qTVFEg==
X-Received: by 2002:a17:906:73d1:b0:992:1005:928d with SMTP id n17-20020a17090673d100b009921005928dmr3784405ejl.8.1689349445909;
        Fri, 14 Jul 2023 08:44:05 -0700 (PDT)
Received: from carbian ([2a02:8429:8177:5801:6621:b535:847b:1c33])
        by smtp.gmail.com with ESMTPSA id c19-20020a170906171300b00991bba473e2sm5503699eje.85.2023.07.14.08.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 08:44:05 -0700 (PDT)
Date:   Fri, 14 Jul 2023 17:44:03 +0200
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     mazziesaccount@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 0/7] iio: accel: Add support for Kionix/ROHM
 KX132-1211 accelerometer
Message-ID: <ZLFtQ1exaa9WTRkS@carbian>
References: <cover.1686651032.git.mehdi.djait.k@gmail.com>
 <20230708172336.79e68a0f@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230708172336.79e68a0f@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jonathan,

On Sat, Jul 08, 2023 at 05:23:36PM +0100, Jonathan Cameron wrote:
> On Tue, 13 Jun 2023 12:22:33 +0200
> Mehdi Djait <mehdi.djait.k@gmail.com> wrote:
> 
> > Hello everyone,
> > 
> > Version 6 for adding support for the kx132-1211 accelerometer
> > 
> > KX132-1211 accelerometer is a sensor which:
> > 	- supports G-ranges of (+/-) 2, 4, 8, and 16G
> > 	- can be connected to I2C or SPI
> > 	- has internal HW FIFO buffer
> > 	- supports various ODRs (output data rates)
> > 
> > The KX132-1211 accelerometer is very similar to the KX022A. 
> > One key difference is number of bits to report the number of data bytes that 
> > have been stored in the buffer: 8 bits for KX022A vs 10 bits for
> > KX132-1211.
> > 
> Just though I'd say that the series looks fine to me. I'm just waiting
> on reply to Matti's query on the last patch before applying it.

I will send a v7 to address the comment of Matti.

--
Kind Regards
Mehdi Djait
