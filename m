Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476D38126CA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 06:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443139AbjLNFJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 00:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbjLNFJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 00:09:47 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB007112
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 21:09:50 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6cebcf8a48aso6537095b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 21:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702530590; x=1703135390; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HRQN/5Gl+E+Y/YwiwR7f4dgjP1vz1MfNF5W9YJDw5ro=;
        b=muls9IxxcvhgabpJnsNRrjQqVmbLHeRx9Z19ijPtLKdd6DTHqLeN9szmdTQFEwpc2o
         XvWXG/Ug7BQ5NCowzMWQXhdGAqdRSQ36nmPSem1r+rFZ6QjmZjkKoTjzblD+7jb/p5uC
         uRil78WewuDF5wHA3/X+olXRHjfQLDe676duAZpmEtBMxC+uigAe0ZAJn4KR78fAvoNQ
         C7Cf4W7AyFuHOJNjS08euBGaoDXQ4HOkNnYB0mxGQPk+NLfLDFxl9rOPAIQ1BCdCqr3c
         SWA2IVRpgQ3eAtZJ0YE+qYtkrdo430yg5lzdw6mGQGnoXhTAI9aCXdi9xelC674BykLY
         TMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702530590; x=1703135390;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HRQN/5Gl+E+Y/YwiwR7f4dgjP1vz1MfNF5W9YJDw5ro=;
        b=Xz2qDr2FfLygerLynq3KKuB9tW0Ky3FUlU8mUnUgA7ScoUAXNOl+eLt/vQNvw0IpHt
         hdQfZ7aIF0roZXbvIMGZEA/XKj5AyIhfvC8IS5UZ89a/pYxyD1nwivp6NeR7mpsQtjtO
         MbWOolMRIi6gyNInbwjhlX5MXlbczxUovxqSeBoatM4QMHEIrMGh6nI138ymGlb5nN+W
         KecGi6XWymGrQkrmRyg0QCt9ovX01vHjVsWRA9+Lm4g+I5Ol8iK7+ZOen0dpOojfg684
         4coiJtKirPvUNr6+OShXeYovkajSKPd4eR2bkURWtV/xsQhZrRzSfCJPD3DtSeGcEREr
         Kiog==
X-Gm-Message-State: AOJu0YyhIkg5xXo7OiS80B+gARTrT63yzekezlOEEZs9crMZf33a68IB
        4dMPs8nMlW5AdByCHUi5ttwh
X-Google-Smtp-Source: AGHT+IFoiD3gBR12SGaJPAivjdmpPvziAoacTLgEk0cWcQakHmt7CoNZ8PQ69964IUM6048brgNieg==
X-Received: by 2002:a05:6a20:1604:b0:190:3b35:5999 with SMTP id l4-20020a056a20160400b001903b355999mr12233369pzj.9.1702530590210;
        Wed, 13 Dec 2023 21:09:50 -0800 (PST)
Received: from thinkpad ([117.213.102.12])
        by smtp.gmail.com with ESMTPSA id z17-20020a17090ab11100b0028a69db1f51sm7950911pjq.30.2023.12.13.21.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 21:09:49 -0800 (PST)
Date:   Thu, 14 Dec 2023 10:39:43 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, ahalaney@redhat.com,
        quic_nitirawa@quicinc.com
Subject: Re: [PATCH v2 00/17] scsi: ufs: qcom: Code cleanups
Message-ID: <20231214050943.GC2938@thinkpad>
References: <20231208065902.11006-1-manivannan.sadhasivam@linaro.org>
 <b2d6853e-2de7-4e12-85f8-c130d9a745a4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2d6853e-2de7-4e12-85f8-c130d9a745a4@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2023 at 06:42:31PM +0100, Konrad Dybcio wrote:
> On 8.12.2023 07:58, Manivannan Sadhasivam wrote:
> > Hello,
> > 
> > This series has code some cleanups to the Qcom UFS driver. No functional
> > change. In this version, I've removed code supporting legacy controllers
> > ver < 2.0, as the respective platforms were never supported in upstream.
> > 
> > Tested on: RB5 development board based on Qcom SM8250 SoC.
> > 
> > - Mani
> > 
> > Changes in v2:
> > 
> > * Collected review tags
> > * Fixed the comments from Andrew
> > * Added a few more patches, most notably one removing the code for old
> >   controllers (ver < v2.0)
> FWIW i found this snipped from a downstream commit from 2014:
> 
> 8084 : 1.1.1
> 8994v1 : 1.2.0
> 8994v2 : 1.3.0
> 
> I'm yet to see any 8994 production device utilizing UFS (it wasn't
> very good or affordable in 2014/15 IIRC), so I think it's gtg.
> 

Thanks for digging! I was told that SoCs based on UFS 1.x controllers were not
widely used in production, though I don't know why.

- Mani

> Konrad

-- 
மணிவண்ணன் சதாசிவம்
