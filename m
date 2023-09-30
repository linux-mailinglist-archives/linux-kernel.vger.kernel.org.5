Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADFE7B420C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 18:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbjI3QRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 12:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbjI3QRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:17:11 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B639CE5;
        Sat, 30 Sep 2023 09:17:09 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-690bd8f89baso12289869b3a.2;
        Sat, 30 Sep 2023 09:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696090629; x=1696695429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P87SYNAUx9/KgAQuVKnXUthD0UJfDLOGmA1ZiynjveU=;
        b=ZX4/HN3QT7uFNDKX75IsVmSB7Z52S4156aBfgAEXPXguc9n7Ebc9+uqraPOQbWUhRI
         7tbF8T8yZANm0utLFqnvogCd1uCiiZrhqskkV1PcVGd2meBFZiJm//YBFiwC6+v1mpH7
         w8brhOin+qcyX0zwCEh9wx5xKCXF/VpZFFDr0ibhXpPjLwh5WMq+eTif6fL7a1gf783/
         CzF9I14DPKFpRYh9iMd3IeqrHsFd1rJSrfgdIW2D6qjmOIsEJfd47YERVXt7dwq2l5XD
         6gp53nUEvT2sseqnle4iy85YC8dO6Iem1Fa1uEpuPcqXMuVUlLc51OIhC21bPKvlS+OE
         fLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696090629; x=1696695429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P87SYNAUx9/KgAQuVKnXUthD0UJfDLOGmA1ZiynjveU=;
        b=HCohPahLE8d/aTk7jaxFY9wziGhWi2lT+LipwT/mSAT9TOd1hLGJepBdyPkPZM7q27
         smuSybLqQ7/f4EmGIHe2qx4DSSLr8tXJtEMKB8lHqRS0Ndu3bQFco9LCjyQHM/ydxEZF
         bzaUDGEscaXXdzInTO5UkjBmBwzW6LBRYVp4JqNXrWsJAG2oNgsQZrHd7IduCiQPxiy4
         L1Xl8N8kjQ5TcMlj5DzWsH4c6vLADdTwaypLYNMACYWz5ThFZbhb6v5P6fLdAiQjCzE9
         PF3oyGY+pshOSaPxf685DkbyUmeU268A0B301l2J54qP/vwCx1jIzb+DzMkomGztEoF4
         vsUQ==
X-Gm-Message-State: AOJu0Yw11zqdAPcTJA1gIV9CF6A4OkHDKK3ro/OPzp4At4DOTYCte3TP
        Pn5eYUkVHj4VMFFKo+kLPTI=
X-Google-Smtp-Source: AGHT+IG/nHfN2RCt3nLgT20agqyXxSEmMoss87E168KB70OPzDz127pHStkupxojsur4aAr1BtJ/tw==
X-Received: by 2002:a05:6a20:3d26:b0:159:e0b9:bd02 with SMTP id y38-20020a056a203d2600b00159e0b9bd02mr7289240pzi.40.1696090629051;
        Sat, 30 Sep 2023 09:17:09 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:a90f:2dad:30c1:d923])
        by smtp.gmail.com with ESMTPSA id j24-20020aa783d8000000b0069327d0b491sm7173934pfn.195.2023.09.30.09.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 09:17:08 -0700 (PDT)
Date:   Sat, 30 Sep 2023 09:17:05 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Fenglin Wu <quic_fenglinw@quicinc.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-input@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_kamalw@quicinc.com,
        jestar@qti.qualcomm.com, Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [RESEND PATCH v6 3/3] input: pm8xxx-vibrator: add new SPMI
 vibrator support
Message-ID: <ZRhKAWYBLcBZHc73@google.com>
References: <20230922083801.3056724-1-quic_fenglinw@quicinc.com>
 <20230922083801.3056724-4-quic_fenglinw@quicinc.com>
 <CAA8EJpoW8DJOTVHBu9_+BQs5DtxyJu3xrCfDNyYHn2MeHZHV4w@mail.gmail.com>
 <12887370-0ada-359b-8a4f-18a28495c69a@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12887370-0ada-359b-8a4f-18a28495c69a@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 10:54:45AM +0800, Fenglin Wu wrote:
> 
> 
> On 9/24/2023 3:07 AM, Dmitry Baryshkov wrote:
> > > +
> > > +       switch (vib->data->hw_type) {
> > > +       case SSBI_VIB:
> > >                  mask = SSBI_VIB_DRV_LEVEL_MASK;
> > >                  shift = SSBI_VIB_DRV_SHIFT;
> > > +               break;
> > > +       case SPMI_VIB:
> > > +               mask = SPMI_VIB_DRV_LEVEL_MASK;
> > > +               shift = SPMI_VIB_DRV_SHIFT;
> > > +               break;
> > > +       case SPMI_VIB_GEN2:
> > > +               mask = SPMI_VIB_GEN2_DRV_MASK;
> > > +               shift = SPMI_VIB_GEN2_DRV_SHIFT;
> > > +               break;
> > > +       default:
> > > +               return -EINVAL;
> > Could you please move the switch to the previous patch? Then it would
> > be more obvious that you are just adding the SPMI_VIB_GEN2 here.
> > 
> > Other than that LGTM.
> 
> Sure, I can move the switch to the previous refactoring patch.

Actually, the idea of having a const "reg" or "chip", etc. structure is
to avoid this kind of runtime checks based on hardware type and instead
use common computation. I believe you need to move mask and shift into
the chip-specific structure and avoid defining hw_type.

Thanks.

-- 
Dmitry
