Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD417B04D3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjI0M67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjI0M65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:58:57 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C578F5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 05:58:55 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40572aeb673so80685805e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 05:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695819533; x=1696424333; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XDBxB4K/Dc2f6E7RfsykVyDhFDN+EKOunIZYRlh5xQ4=;
        b=de8DF/OYG/1kvRnNXKqBqgdjpYtV581zHYAUezl+J0O/u3/ejABPRiEssgkB11Zxn8
         F6rT4/OkLTevQsjVAI1hSziWqenB843K0P0/+RcES1c2AAhAcSf5rDtlVp5oE7ji9WA7
         /VuPYKu6KFQLWCOL5FnfX9qSgaBtyHvXa8uXGHNrQukQ0vSmRqIakdgRBODAHCqV5c3W
         ni5c2q+5M8nQq00xz1xUqC5fst5TH5Y6h8zYa1bpLICpaxrrywzA0USF33ivfhv5Y9SK
         pV6Q23bcnPK3ep9ZKFc9J8B+SZ/7CrfEQJ32uT9SXfKE+BvQxRFe0Qov9lxxRu/rgUkI
         UX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695819533; x=1696424333;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XDBxB4K/Dc2f6E7RfsykVyDhFDN+EKOunIZYRlh5xQ4=;
        b=CoKdAPRuIHE+6bMElMHPmLg+48MC3Dmqduv1J/94trIwMSLPJm3VVE5E3IfdPQc7WS
         d03W1CNhS6RrbY5mgojR3fRmuUeoIzBL/cxx4FUUrjpLPK0oCmH2uakeJ8xkfxcMkyjv
         j91W9QHs2wJuTD9sP0z5AV7v/0lLI/OtkO8FxqFdpcoB3Zm5aLu+sDi4D6KHlGkluv0E
         Ypdvt9fr4g38BLNLC6LWJBnJa5mP/nfqCOv0+b/XcKYsw0YSNN3E0oMuXqiIS49Lnj0U
         /7C5ZXQY1yxUPrxVXdJWBxvxGStzrEskg3WO2FoaNynnV7wjBy6LhvwizykNuZV8L5ZO
         a0ag==
X-Gm-Message-State: AOJu0Ywwz/1PiqLsQrWP2LsKvsDrZZjcVtk9KRcq5VYCzSNcMylqZoXQ
        tMc+VZdHoZ58hCaXlNreXgqb
X-Google-Smtp-Source: AGHT+IEDKHA7Ugd7ZSlR7GfH1BkKpWJKecatYW9bH9VwobJzVpJZUVAEALaG7FH/tUYkaetWvZnMow==
X-Received: by 2002:a1c:7917:0:b0:401:b53e:6c3b with SMTP id l23-20020a1c7917000000b00401b53e6c3bmr1803043wme.6.1695819533523;
        Wed, 27 Sep 2023 05:58:53 -0700 (PDT)
Received: from thinkpad ([2a02:2454:9d09:3f00:b024:394e:56d7:d8b4])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c240c00b003fc02e8ea68sm20417720wmp.13.2023.09.27.05.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 05:58:52 -0700 (PDT)
Date:   Wed, 27 Sep 2023 14:58:50 +0200
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>, lpieralisi@kernel.org,
        kw@linux.com, andersson@kernel.org, bhelgaas@google.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Add interconnect bandwidth for PCIe Gen4
Message-ID: <20230927125850.GA19623@thinkpad>
References: <20230924160713.217086-1-manivannan.sadhasivam@linaro.org>
 <f49d0543-17bb-4105-9cdf-3df8c116481a@linaro.org>
 <ZRFiD3EXwZI/B8JB@linaro.org>
 <18635bed-b7e3-4acb-b176-cd9f87a35c7f@linaro.org>
 <ZRFjAIYQQZnbNIdt@linaro.org>
 <09058de7-e207-414b-ab4c-88f0cbde9c22@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09058de7-e207-414b-ab4c-88f0cbde9c22@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 12:40:34PM +0200, Konrad Dybcio wrote:
> On 25.09.2023 12:37, Abel Vesa wrote:
> > On 23-09-25 12:34:53, Konrad Dybcio wrote:
> >> On 25.09.2023 12:33, Abel Vesa wrote:
> >>> On 23-09-25 10:57:47, Konrad Dybcio wrote:
> >>>> On 24.09.2023 18:07, Manivannan Sadhasivam wrote:
> >>>>> PCIe Gen4 supports the interconnect bandwidth of 1969 MBps. So let's add
> >>>>> the bandwidth support in the driver. Otherwise, the default bandwidth of
> >>>>> 985 MBps will be used.
> >>>>>
> >>>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >>>>> ---
> >>>>>  drivers/pci/controller/dwc/pcie-qcom.c | 7 +++++--
> >>>>>  1 file changed, 5 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> >>>>> index 297442c969b6..6853123f92c1 100644
> >>>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> >>>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> >>>>> @@ -1384,11 +1384,14 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
> >>>>>  	case 2:
> >>>>>  		bw = MBps_to_icc(500);
> >>>>>  		break;
> >>>>> +	case 3:
> >>>>> +		bw = MBps_to_icc(985);
> >>>>> +		break;
> >>>>>  	default:
> >>>>>  		WARN_ON_ONCE(1);
> >>>>>  		fallthrough;
> >>>>> -	case 3:
> >>>>> -		bw = MBps_to_icc(985);
> >>>>> +	case 4:
> >>>>> +		bw = MBps_to_icc(1969);
> >>>>>  		break;
> >>>> Are you adding case 4 under `default`? That looks.. bizzare..
> >>>
> >>> That's intentional. You want it to use 1969MBps if there is a different
> >>> gen value. AFAIU.
> >> Gah right, then the commit message is wrong.
> > 
> > Yep, should be: "Otherwise, the default bandwidth of 1969 MBps will be
> > used."
> > 
> > But maybe we should not default to that. Maybe we should still default
> > to 985 MBps.
> Perhaps we shouldn't have a default at all..
> 
> E.g. if the gen5 bus may get clogged if we exceed gen4
> limits
> 

So the idea here is that if we happen to run this driver on a new Gen supported
SoC, we have to let the user know that the interconnects are running at a lower
gen speed and it needs attention.

But I think we can simplify it by fixing a default bandwidth, say Gen3 and get
rid of the fallthrough. And yeah, the same needs to be done for the pcie-qcom-ep
driver as well.

- Mani

> Konrad

-- 
மணிவண்ணன் சதாசிவம்
