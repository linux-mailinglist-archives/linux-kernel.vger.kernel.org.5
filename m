Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FB07F9911
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 07:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjK0GEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 01:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjK0GEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 01:04:39 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2A4131
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 22:04:44 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6cb9dd2ab56so3188858b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 22:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701065084; x=1701669884; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+OTyuBSj00HpTGxowPCMZHFCFh0gtzlFv4DUNhcakBU=;
        b=NcDNmv5RGkJuCuAWvYueIFED9469qfyC/NZK0KmFMqrQDUZi3hRp+mFhJ4uzUMCr7z
         um3dSPQ/v9UKdVYsOqA/wz3stagQlmVU3ts66q8IXjeaS2RE9kFSE7iL89g2S2XBWgZN
         tl4EAqZ2c+aRbr6HJSgpqrce8S87s45kIpx+qQswiDMa/Kh5JWc2nEnldBJ6zo60C7l6
         sq/wINj3X7Aim9r6bxDGGAoheeW9CSpeRQAbzsSImuAOVisEoT8Edh3akqC4AgImpcTV
         DgCaQCAspD+BlgUQocpSEgYDyufrzpsjZYL0/hm0R5KZVw1PQD5QbH2iDPS9cfpK3qOX
         q5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701065084; x=1701669884;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+OTyuBSj00HpTGxowPCMZHFCFh0gtzlFv4DUNhcakBU=;
        b=qfykBd+vjijeOhEKiW+f/AVO0gw2sP0KiA83LRcDFDhvgM+OZ1Y0b/sC7LtlyB7beT
         R0fJJ3nXZvHX3iucbvSa5lGyeZY9CAUwkIBozHPSMeVuw8oGhvhwoVIGSsfEfDfOMbYP
         eknv6xeotpl6ITE+hq8pp8eCMmiB8+5a7wmoSAybSfLTnIlRKGxs+brDoiRbBnW5ay0T
         MvKmqvkeX3A05/HJRhJYttfERlJdp94ufbErTA+EYNJulCZ81tdqAv8eGkoZhvcYUzhS
         5i+X7KVbAYOvfNHsBlampdBHPWPpU3uVTXZn1XxGsQwIzlKhE7A1IbWmozxuogYYXgU6
         7LFg==
X-Gm-Message-State: AOJu0YzGRDr7oiHYylbNcLIWTZJlPAHnHGY4k+IkF8DXKPUfXzpuUF8j
        AsQ3PVSwOLGAerfiEQnhVdK+
X-Google-Smtp-Source: AGHT+IG/i+PnOVkzEH5tF9cNXhmaOkhMuwMasrzxUa0Df7G1z+bvbR/u7fIVg0ojsgJH6yM2ZEehSA==
X-Received: by 2002:aa7:88ce:0:b0:6cb:6ab1:564c with SMTP id k14-20020aa788ce000000b006cb6ab1564cmr10324719pff.10.1701065084286;
        Sun, 26 Nov 2023 22:04:44 -0800 (PST)
Received: from thinkpad ([103.28.246.157])
        by smtp.gmail.com with ESMTPSA id c16-20020aa78c10000000b006905f6bfc37sm6460850pfd.31.2023.11.26.22.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 22:04:43 -0800 (PST)
Date:   Mon, 27 Nov 2023 11:34:39 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org
Subject: Re: [PATCH v2 0/2] Add MHI Endpoint network driver
Message-ID: <20231127060439.GA2505@thinkpad>
References: <20230607152427.108607-1-manivannan.sadhasivam@linaro.org>
 <20230607094922.43106896@kernel.org>
 <20230607171153.GA109456@thinkpad>
 <20230607104350.03a51711@kernel.org>
 <20230608123720.GC5672@thinkpad>
 <20231117070602.GA10361@thinkpad>
 <20231117162638.7cdb3e7d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231117162638.7cdb3e7d@kernel.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 04:26:38PM -0800, Jakub Kicinski wrote:
> On Fri, 17 Nov 2023 12:36:02 +0530 Manivannan Sadhasivam wrote:
> > Sorry to revive this old thread, this discussion seems to have fell through the
> > cracks...
> 
> It did not fall thru the cracks, you got a nack. Here it is in a more
> official form:
> 
> Nacked-by: Jakub Kicinski <kuba@kernel.org>
> 
> Please make sure you keep this tag and CC me if you ever post any form
> of these patches again.

Thanks for the NACK. Could you please respond to my reply justifying this driver
(the part you just snipped)? I'm posting it below:

> As I explained above, other interfaces also expose this kind of functionality
> between host and the device. One of the credible usecase with this driver is
> sharing the network connectivity available in either host or the device with the
> other end.
>
> To make it clear, we have 2 kind of channels exposed by MHI for networking.
>
> 1. IP_SW0
> 2. IP_HW0
>
> IP_SW0 is useful in scenarios I explained above and IP_HW0 is purely used to
> provide data connectivity to the host machines with the help of modem IP in the
> device. And the host side stack is already well supported in mainline. With the
> proposed driver, Linux can run on the device itself and it will give Qcom a
> chance to get rid of their proprietary firmware used on the PCIe endpoint
> devices like modems, etc...

I think you made up your mind that this driver is exposing the network interface
to the firmware on the device. I ought to clearify that the device running this
driver doesn't necessarily be a modem but a PCIe endpoint instance that uses the
netdev exposed by this driver to share data connectivity with another device.

This concept is not new and being supported by other protocols such as Virtio
etc...

- Mani
-- 
மணிவண்ணன் சதாசிவம்
