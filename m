Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38827B1464
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjI1HPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjI1HOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:14:54 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418AFCEE
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:14:01 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-691c05bc5aaso11066004b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695885240; x=1696490040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VtAQFshoixr4PLMOGpQ5x3E+4JvwXvrJVP5lWSHmXcs=;
        b=GI3+uX4Fm/RDCPJZ2JY+NH3noeb5l18RbVYWJcjXV2Mercx3uMRgOH5JKxzvGLElV8
         e5ibjR3IE05dHJcokZ2YZDrx75MYFyAltNX08b7rbKuFwlD4k8mGEf9HEmPvA5cdyhPU
         7UKFTcs5N+HJe8isGPwlpAmZury+YPBf35zw+9ZA7NA6GyqUV6y+CA9VDL2rMflqNRGB
         4pjrHJ40M5qmBTjjJdKZFdMcofWVSz9jcI2OT31vxvB6hkbW02Yb+nDp5hLvUOLWUJlO
         +4URWUN2fAwf7vOW+0mUMMygHnwBWRtcuCcUuROVntXrQIOqUuyfsew2pN5NhvSPUlKK
         tY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695885240; x=1696490040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtAQFshoixr4PLMOGpQ5x3E+4JvwXvrJVP5lWSHmXcs=;
        b=AWBjk9qM4eHkJLNd2coVoLTidHPa/uNJniZSdYOj8jSSffNjjIKzff/7sVZgzTdqIo
         8J2azTK+56EeD1cNBlb0Iot1qZ9xJp3ptGq+66RPPO84ro0X5Q7tYqDWiH0M9ePluypy
         bUb3gX05x1AcYOxQf/HFRdr9ls/PMxI6oT8mIVlvQ8bmW/BB+ff5W3dHOsB0ahrNd3CP
         E8L0Lx4GNhDSwYPZ/k4ucq6sexaTKzo741U8aFEdOfnq83qS+RnYGIiimhQNDgoXjcSi
         bIDZAoAnwKaEbGywQzNlVEqhLGwpJUmD7hDlkl+zYRoNnfSR9V+KWx0LWeB6GZ9y8Izd
         H5zw==
X-Gm-Message-State: AOJu0Yxq1nMmMNJPD1BfbDUhuglhTNDOapq4hXW5NuB4WH/1/eqzptkL
        uOktCeUmTCnJ/5JPVN6VRrtDgA==
X-Google-Smtp-Source: AGHT+IF+ebHc4PI7RDBAqlxE+M8CNQuYhiPegz6Bi2F6ZoLnTZtxR5vgvmHJEfj4gXpYMG0OC++96g==
X-Received: by 2002:a05:6a20:914f:b0:160:83e1:712f with SMTP id x15-20020a056a20914f00b0016083e1712fmr396378pzc.23.1695885240687;
        Thu, 28 Sep 2023 00:14:00 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id a12-20020a170902b58c00b001bc5dc0cd75sm3726200pls.180.2023.09.28.00.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 00:14:00 -0700 (PDT)
Date:   Thu, 28 Sep 2023 12:43:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Ilia Lin <ilia.lin@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: opp: opp-v2-kryo-cpu: Allow opp-peak-kBps
Message-ID: <20230928071358.nwhy7lpsrawlrkf6@vireshk-i7>
References: <20230920-opp-kbps-binding-cleanup-v1-1-65b059bb4afc@quicinc.com>
 <169532249877.800354.7360993815442441183.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169532249877.800354.7360993815442441183.robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-09-23, 13:55, Rob Herring wrote:
> 
> On Wed, 20 Sep 2023 16:03:57 -0700, Bjorn Andersson wrote:
> > Many of the users of operating-points-v2-kryo-cpu scales interconnect
> > bandwidth based on the selected opp. Extend the binding to allow the
> > opp-peak-kBps property, inherited from opp-v2-base.yaml, to be used to
> > specify the requested bandwidth.
> > 
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> >  Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> 
> Acked-by: Rob Herring <robh@kernel.org>

Applied. Thanks.

-- 
viresh
