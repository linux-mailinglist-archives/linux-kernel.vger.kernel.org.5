Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24987AF8A9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 05:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjI0D21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 23:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjI0D03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 23:26:29 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C868272AA;
        Tue, 26 Sep 2023 18:47:42 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c63164a2b6so18484335ad.0;
        Tue, 26 Sep 2023 18:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695779262; x=1696384062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kdJIQdTaHI0k4LukyVP6v1Fv5TtDAf1OoI8Bd0E9aK8=;
        b=U47/cp4hH+KbCm2Jq2Jyxba1UgQRjLM7ioT6KuVLWLtMgSDTItfSCUe4hcFihgDy6K
         3QHlPwnnAKJtjRMzMYMqSPRNu7VhumxE7p4NC4mB/JlmY6IXepVGQyE5ojn9DfeI4Eu0
         33LHTaTnUmk3PPS+0CZxmV+l0iq6DcTc31igq90c0RTZhIQX54CenEIT68oQ/eJ+NN67
         deAmIEP9SKXAfQGRIVlzAbbDq4FtLWqUwjCBBObKJ8nVy/Lguee/YFUldXxbrn3tv6nV
         9voTu2q0MGlWOzTOe4rh2f4OkTIstqwJ4oWLKvzIdUsx2JTy3uLLKw59WUffs0K7gRyX
         xOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695779262; x=1696384062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdJIQdTaHI0k4LukyVP6v1Fv5TtDAf1OoI8Bd0E9aK8=;
        b=wLTzvfTPl7G3R84TzQmTPeC3pdLCeCclD3rVgoMnBmQ7SxccAcFh0Jd0TqbP2/7xBd
         s2SGlEnJJ/zB2crnBU/1s4uBPldknqNQC4SxAIbvUuNcOk0XiZP0Om246tn4Ya+GRfi4
         gOQ83N9Gk+VGioi9+8oi40OjQQcmSx8UDvF5vAcZnG+P2kQ3ycWx/l04cKQu8kSFVsTv
         Gxb3x7XtVtqkg97ybATW6vXqExdKJq3qiyralwdjwkz7ij+SkPRCpcmtwa9Wb7KXmAYk
         Nv01zNkL2ELSUFYx/FdnSkKY/ipQ0Jw1HRHDgr272YGbcsXeHxzldfhaMMCzBgR8e3X4
         OOvg==
X-Gm-Message-State: AOJu0YyhpltzKQUGuRal6UT3N6vj2soefuVv7be35FZrLHoFXRk9xbG3
        ilcSVRfVrYdLkE4FiA0gd8ya3eFXcK4SHw==
X-Google-Smtp-Source: AGHT+IHNbU5YWvLueYGJ0d4j/juY2IrOftABxxWQl3+rEGkb6aUw/CBCHn1A7vxf+om//IVkt1GxuA==
X-Received: by 2002:a17:902:d2c7:b0:1b7:f64b:379b with SMTP id n7-20020a170902d2c700b001b7f64b379bmr1051920plc.17.1695779262159;
        Tue, 26 Sep 2023 18:47:42 -0700 (PDT)
Received: from localhost ([2804:30c:974:7600:2605:6970:d08b:fd3d])
        by smtp.gmail.com with ESMTPSA id e1-20020a170902d38100b001acae9734c0sm131190pld.266.2023.09.26.18.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 18:47:41 -0700 (PDT)
Date:   Tue, 26 Sep 2023 22:47:39 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: adi,ad7292: Fix
 additionalProperties on channel nodes
Message-ID: <ZROJuya87tMI4Q/y@marsc.168.1.7>
References: <20230926164357.100325-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926164357.100325-1-robh@kernel.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/26, Rob Herring wrote:
> "additionalProperties: true" is only for incomplete schemas such as bus
> child nodes in a bus's schema. That doesn't apply to the "channel" nodes
> in the adi,ad7292 binding, so fix additionalProperties to be false.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

Thanks,
Marcelo
