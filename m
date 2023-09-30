Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B3E7B3F8A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 10:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjI3I47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 04:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjI3I46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 04:56:58 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36071B0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 01:56:54 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9ae7383b7ecso324675966b.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 01:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696064213; x=1696669013; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rxuoM/kpV0tc8vVOuxVi7rkGgp9aY1zjapqbLz/fcu0=;
        b=nwAgJiUTWmPD1tFHXacVerfkY3k3FyqSgBCdIL4JmOP1uDUVUMLRWUDXrRoVt/FpLZ
         HHMvzy3Xw/2g+G/PLaldhMrqoMf5YROx6fL3txFkvV07mMPitbkpqMaNbURzmyc42rRp
         lR1AEFrqlCGnGuePTWUYdJCKIa7gxndk6e+FxTvxgqZURHClFyMiAimOTsvW+c00aUQS
         D7PZl+GFVbvBJVydkFHi5CID7YOaHDcq8szdZvSnfDMMUDRRvd4DMA9BpkxxjrYIqsjm
         8Qj81SO8LCebUgO2ja7m3NcpyfBTHFANiuRAGKSDgnLazE1mtyi7QAKrpZn7HeRRtykk
         vDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696064213; x=1696669013;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rxuoM/kpV0tc8vVOuxVi7rkGgp9aY1zjapqbLz/fcu0=;
        b=dSHB5V1QTKb1tHB6dEE0s3+7BZQIpoKmf3PvRly9wRd+ByNE7dFXGboncViZ8iFMlY
         +uyN+8KGW4/XZApVG5NcWNiK2KcWvJxNT+PC3GEV8U4lDIEqjZG7ZVGT7qx21C3YEV1s
         79+/6pQFq3fBFree8qlFckWHAwDF1xqwYwDtEm3+SqUdBijF+Svld24vHPdk2nsz6ZjN
         F/eElFjXWfnhWimlQe7lyNXmNNlQW61FDp18RjYPVbHPuAFV5xlBH8Do2IB5YMZ5CC8Q
         E40MmjsLfLucls8gd0QuULwSLHotcCnah5S1QEMuJXAZlBjpPxrbhkS+1PBnv3HRnrzg
         kQyA==
X-Gm-Message-State: AOJu0YwpJ+0V2Ke7KnfUOmle9llk6e/GRtGda3tlW+4GVBRFJkMZ6gUX
        aJKBKl8uPGEgJYG1mJ8+4A6Jey/BUH2onKH2L/Wl
X-Google-Smtp-Source: AGHT+IHZcicP/DlSYvvIIHPd/xN62G3u/iDeTlnMmDiUFbMeZEGgo9YeZZn7dYTfbYQeSWkbSUg6Pw==
X-Received: by 2002:a17:906:7695:b0:9b2:b15b:383d with SMTP id o21-20020a170906769500b009b2b15b383dmr6873787ejm.11.1696064213321;
        Sat, 30 Sep 2023 01:56:53 -0700 (PDT)
Received: from thinkpad ([88.128.88.98])
        by smtp.gmail.com with ESMTPSA id mh2-20020a170906eb8200b00992b2c55c67sm13702594ejb.156.2023.09.30.01.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 01:56:52 -0700 (PDT)
Date:   Sat, 30 Sep 2023 10:56:50 +0200
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, bhelgaas@google.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, abel.vesa@linaro.org
Subject: Re: [PATCH v3 2/3] PCI: qcom-ep: Make use of PCIE_SPEED2MBS_ENC()
 macro for encoding link speed
Message-ID: <20230930085650.GA3564@thinkpad>
References: <20230928184808.GA12574@thinkpad>
 <20230928212757.GA502911@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230928212757.GA502911@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 04:27:57PM -0500, Bjorn Helgaas wrote:
> On Thu, Sep 28, 2023 at 08:48:08PM +0200, Manivannan Sadhasivam wrote:
> > On Wed, Sep 27, 2023 at 12:55:42PM -0500, Bjorn Helgaas wrote:
> > > On Wed, Sep 27, 2023 at 05:46:02PM +0200, Manivannan Sadhasivam wrote:
> > > > Instead of hardcoding the link speed in MBps, let's make use of the
> > > > existing PCIE_SPEED2MBS_ENC() macro that does the encoding of the
> > > > link speed for us. Also, let's Wrap it with QCOM_PCIE_LINK_SPEED_TO_BW()
> > > > macro to do the conversion to ICC speed.
> 
> > > > -	ret = icc_set_bw(pcie_ep->icc_mem, 0, MBps_to_icc(PCIE_GEN1_BW_MBPS));
> > > > +	ret = icc_set_bw(pcie_ep->icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
> > > 
> > > "1" is not very informative here.  Maybe PCIE_SPEED_2_5GT?  (I didn't
> > > completely verify that this is equivalent.)
> > 
> > No. PCIE_SPEED_2_5GT is defined as 0x14 in pci.h. And I do not want to add a
> > macro for just "1" here.
> 
> Is there no other existing macro that contains the 2.5GT/s hint?

I couldn't find any :/

Adding a new macro would collide with the existing one IMO.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
