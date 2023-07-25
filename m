Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3E176070A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 06:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjGYELc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 00:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjGYEL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 00:11:27 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A114819AC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 21:11:25 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666e5f0d60bso2841494b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 21:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690258285; x=1690863085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6yFVEsi6DemosywA0d4g+4gyo9sgA/NzmDnSSDwQNKs=;
        b=lk4/cIBY23JoJcZYtO6BPJz+U6dOgzDrtI/AddYuE+I/IFHF+0VNmMiCxbdim0DI6t
         IPJ1x4awpw4/uLI7cGwYUNC41jT+tdeCpZkWozX8Wxr0k/AFBbqb+Dnd4TsYPtKFMZ16
         NCQCu5kfQNLXOUURvQbjffpqG1adcYt/5wo8yidETbOZphn8bOacxvQvGcVg29LSKBu7
         D+VJ6tLOx+Vu6VoXj58jF1Qk9LDOc4BGQhbdqxdD6oW2MgqX3LcXBEMeupXYulnBkPw6
         Fo8V35yCiev52gcpQu+MdeH+9L97/JqStRCZ9KHlmO9EYSxFLU4Je/40yoG8Su3n+wom
         yZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690258285; x=1690863085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yFVEsi6DemosywA0d4g+4gyo9sgA/NzmDnSSDwQNKs=;
        b=AQSX05OyQlDdcHwK3tS0H1iRugYbd2XpaUNuz0r7FsMqqPmmOmafpEuxyuhxiZEVEh
         jIAIzBsXSLpgIvjg+cxdJ+d+chaTm/USKHlxYlI7rjhNfN8JWN0MwpphNfrIqYG2SNL7
         fmbe6Q9zaaWVFkJvFHXRg2f437QuPZVXmFD0Yt5CETTh5vswwrxDn514VwEqsnJ89CXg
         xq+HmdtfEWGB45qAnrOCYdLr6H8OBLhcEd5StUsMtRC3UKhG6GMpzRJ2HKrZqMOkBfdd
         CycNAYUKBN0o13pe61be+mc7+9SUwiAIxypluurrO9UKq9bI1f9lw/8krEYVmkO3GxT6
         Wndw==
X-Gm-Message-State: ABy/qLbHwZXDPI1QdA5yAzY7Vp4MUaSN0eU/OEo3odKwRzU9hvOramB6
        og4mxc9d1MvTMJh7IjqXqM8lCw==
X-Google-Smtp-Source: APBJJlGEfGQ7zai4fBJw5iC4TD450VqmzaOjEBbpI7dsjUc7F9ZBMXlE4WEWbv4UhPyjm6nAy6pOwQ==
X-Received: by 2002:a05:6a20:734e:b0:127:796d:b70d with SMTP id v14-20020a056a20734e00b00127796db70dmr9905031pzc.61.1690258285037;
        Mon, 24 Jul 2023 21:11:25 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902b08700b001b3d0aff88fsm9729885plr.109.2023.07.24.21.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 21:11:24 -0700 (PDT)
Date:   Tue, 25 Jul 2023 09:41:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        conor+dt@kernel.org, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_nitirawa@quicinc.com,
        linux-kernel@vger.kernel.org, quic_ziqichen@quicinc.com,
        linux-pm@vger.kernel.org, nm@ti.com, quic_bhaskarv@quicinc.com,
        martin.petersen@oracle.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, quic_asutoshd@quicinc.com,
        alim.akhtar@samsung.com, vireshk@kernel.org,
        kyungmin.park@samsung.com, jejb@linux.ibm.com, bvanassche@acm.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        quic_cang@quicinc.com, linux-arm-msm@vger.kernel.org,
        myungjoo.ham@samsung.com, andersson@kernel.org, sboyd@kernel.org,
        linux-scsi@vger.kernel.org, cw00.choi@samsung.com,
        krzysztof.kozlowski@linaro.org, avri.altman@wdc.com,
        bmasney@redhat.com, quic_narepall@quicinc.com
Subject: Re: [PATCH v2 02/15] dt-bindings: opp: Increase maxItems for opp-hz
 property
Message-ID: <20230725041122.7yu4drwekoy6w24d@vireshk-i7>
References: <20230720054100.9940-1-manivannan.sadhasivam@linaro.org>
 <20230720054100.9940-3-manivannan.sadhasivam@linaro.org>
 <169021390783.3607138.9583713600185509839.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169021390783.3607138.9583713600185509839.robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-07-23, 09:51, Rob Herring wrote:
> 
> On Thu, 20 Jul 2023 11:10:47 +0530, Manivannan Sadhasivam wrote:
> > Current limit of 16 will be exhausted by platforms specifying the frequency
> > for 9 clocks using opp-hz, like Qcom SDM845 SoC. For instance, specifying
> > the frequency for 9 clocks with 64bit specifier as below would consume
> > (9 * 2 = 18) items.
> > 
> > 	opp-50000000 {
> > 		opp-hz = /bits/ 64 <50000000>,
> > 			 /bits/ 64 <0>,
> > 			 /bits/ 64 <0>,
> > 			 /bits/ 64 <37500000>,
> > 			 /bits/ 64 <0>,
> > 			 /bits/ 64 <0>,
> > 			 /bits/ 64 <0>,
> > 			 /bits/ 64 <0>,
> > 			 /bits/ 64 <75000000>;
> > 	};
> > 
> > So let's increase the limit to 32 which should be enough for most platforms
> > (hopefully).
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> 
> Acked-by: Rob Herring <robh@kernel.org>

Applied. Thanks.

-- 
viresh
