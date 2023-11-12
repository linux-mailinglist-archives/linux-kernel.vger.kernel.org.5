Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832357E9120
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 15:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjKLONA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 09:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjKLOM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 09:12:58 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E1F2D54;
        Sun, 12 Nov 2023 06:12:53 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7788db95652so248660085a.2;
        Sun, 12 Nov 2023 06:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699798373; x=1700403173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nvJBixzQzMXR8jACqchfQK2MdG9o9MRT/I28reCXEIc=;
        b=RLd2wgRj5806ekpVj3kZP136sH1F2ADSX97hHWVO+HRXF5Btj+1J0kIN2YkOCNo7YX
         DuwQjkdHYv0512AXQ3ybUm+FQAqtE/+zmifSdpSlbdAi3HaJ93VelPx33xHgs12KxF+m
         5sbSvNx3+qLdh7g3cVn3J5rtHzLtywPLaOtzOSKcR9/+vcEs27PitBKWE5EaMwotoOID
         mq47E04UTYmOu2CKg5owByo3m/BF2qkaOnITCAQnuzZrc7HPu7CwBVRhrAOPf4/dR1vn
         daW7lFDZ0eYHRSlFx5Tg6FM4zX+LsGs1Cz4FGTFGQZkh2JuNP6QvCKIiqzyd5iolxTvW
         cEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699798373; x=1700403173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvJBixzQzMXR8jACqchfQK2MdG9o9MRT/I28reCXEIc=;
        b=oO0Vzi44psRD8/X94jpIupmZrQuJp57GSyv84odKsKf90IW2qRBnXAUo3DZ8ppcWnV
         Kdo/P1eJ5Aa3IYt19LYutdtuzlODP+BoTnkf+DV2KqswwvUBE6MZPDnDTDoDLwC3UPGt
         BvJ+3g9T+/OwrjVvQGkdCyYQaX2G1a+xKIczkForKhSrwTP7pB1PT3gk1SIIZ6hyFw2Y
         qh/BvQLy4hmDvU4yhgRzaQu1axwW6fJ5eEEFP8OrdlFYZ9cE17iIlWkEnqp4yHXb91QW
         C6OWb2Cy+Qr8dZbK2rEdVPhk0qDulxZMnUekxzY4iLCfMUVG1YJSFMygOqeWsorLNMwu
         HbEw==
X-Gm-Message-State: AOJu0YxuhcCSIXZ5i3R4aTNUW9PAFONrDG+OKPY0b/qns93F7fpU2aGO
        BJPMXzNHBL0g2EIrFBVoN0gG0kVtsli8Fg==
X-Google-Smtp-Source: AGHT+IG6M2AbcQlGKzw2Vv/SlqHMcP56kWW70bv8cnwqGD4u4ncWdfs7LZRfq/v5doLtiCBNBBLNmQ==
X-Received: by 2002:ad4:5587:0:b0:66d:12a3:ec8c with SMTP id f7-20020ad45587000000b0066d12a3ec8cmr3896331qvx.30.1699798372782;
        Sun, 12 Nov 2023 06:12:52 -0800 (PST)
Received: from abdel ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id mg3-20020a056214560300b0065afcf19e23sm1288015qvb.62.2023.11.12.06.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 06:12:52 -0800 (PST)
Date:   Sun, 12 Nov 2023 09:12:42 -0500
From:   Abdel Alkuor <alkuor@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: temperature: Add AMS AS6200
Message-ID: <ZVDdWqcZys+rmjMp@abdel>
References: <7e108db19cd9ad19b6413f65099280c010325a91.1699740057.git.alkuor@gmail.com>
 <1436f009-888e-49e0-b4de-3eab55d9e431@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1436f009-888e-49e0-b4de-3eab55d9e431@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2023 at 08:43:53AM +0100, Krzysztof Kozlowski wrote:
> On 11/11/2023 23:05, Abdel Alkuor wrote:
> > as6200 is high accuracy temperature sensor of -/+ 0.4C degree
> > with a range between -40C to 125C degrees
> > 
> > Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
> > ---
> >  .../bindings/iio/temperature/ams,as6200.yaml  | 45 +++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> 
> I did not receive the driver, so I hope you actually implement the
> binding accurately.
>
Sorry about not including you in the driver patch as I was
experimenting with adding tocmd and cccmd in my .gitconfig and it
looks like the commands ran for each patch individually and only
included the required recipents for each patch instead of amalgamating
them.

Here is the driver: https://lkml.org/lkml/2023/11/11/208
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
>
Thanks,
Abdel
