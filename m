Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B444C7FB868
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344439AbjK1KqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbjK1KqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:46:00 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8823719AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:46:05 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77d84f8808dso201150485a.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701168364; x=1701773164; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ody4rvie3s+8GD4mOiQPrgYycVPJoTVFCyOTzD8p7Dc=;
        b=VVcwBs/b2plLhMdowmgnpGeaR/p64jc/3wVcA5V9u1TArYgHpVYDo4b6sqX9UeSPn2
         fMvWBNhS+aPCNenJRkw2pzCBwCx+3ZTv9N/7KDGoyI5dK13I9jVYJs1vM40vyz/vEPac
         jOTof+4QgMyY+hE3B8/La7TxTf42o/BDm39V7K3sxWZcoq/p7NxHJmjEx4aq+gxWA9yH
         Qq4C18MGFL4RFOw+6d3WnyJ56SP12ljjcwZIEAcXU9CcngJFCrSuz07J7vrcLDWOKMti
         I9plXoVv8KhfziDuXQA251s+5TeL4QfYJB4GMSL6raXlBNr9tIA/ap6Y1Kot2QPRAX40
         ENlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701168364; x=1701773164;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ody4rvie3s+8GD4mOiQPrgYycVPJoTVFCyOTzD8p7Dc=;
        b=Yx+fs9fXXMqJWQWEP+ajJcXqL2/lj4oYXnCAjv0yl4r5scK3I9DVO3ueF0phu5mSu2
         bPv2MqMqF6jnNg7l+dPbJKcjiSfE/NuyrzUg3kM6K0cp4jzmnYG6W07tadREx5dYeND/
         qJn/bUMMJNH7hZ65+SmL1TR0DTk52EYLeSehdAx5qfyvosVXkOonjrG2fepsF272KuE/
         JZNxQznRJsXrl7AB8FD+DRDZ1T9bvZJ7C7k3A4KR0lW8NJOsAhjQa3kXN5hwWAJ7l7nq
         ME5jkcxvGXsmlT38pfmIMkya0PYFzmh60F/TscL0IdNSPG9blvLw8rQyvgyfet7esPiR
         ng8w==
X-Gm-Message-State: AOJu0YxY3DYkydSrcJTpH72IddK9FosQ7u6Xns1mydrDlEdpYKC9hyVL
        otruFw+WlO0u75XsHxzWxi8c
X-Google-Smtp-Source: AGHT+IE8SWfZ7GqO4s0fMyj3jKQqECEGMDFDC8TEC7GRCVPyBE185OA3cmNu5rktS/g6Fo8eFgfD6g==
X-Received: by 2002:a0c:fd6b:0:b0:67a:5457:77c9 with SMTP id k11-20020a0cfd6b000000b0067a545777c9mr3755673qvs.11.1701168364626;
        Tue, 28 Nov 2023 02:46:04 -0800 (PST)
Received: from thinkpad ([59.92.99.177])
        by smtp.gmail.com with ESMTPSA id b18-20020a0c9b12000000b0065b13180892sm5074170qve.16.2023.11.28.02.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 02:46:04 -0800 (PST)
Date:   Tue, 28 Nov 2023 16:15:49 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Vignesh Raman <vignesh.raman@collabora.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, daniels@collabora.com,
        linux-pci@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        helen.koike@collabora.com
Subject: Re: [PATCH] PCI: qcom: Fix compile error
Message-ID: <20231128104549.GM3088@thinkpad>
References: <20231128042026.130442-1-vignesh.raman@collabora.com>
 <20231128051456.GA3088@thinkpad>
 <50a9f061-e1d3-6aca-b528-56dbb6c729d9@collabora.com>
 <20231128065104.GK3088@thinkpad>
 <87a5qy88mx.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a5qy88mx.fsf@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 12:39:02PM +0200, Jani Nikula wrote:
> On Tue, 28 Nov 2023, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> > On Tue, Nov 28, 2023 at 11:44:26AM +0530, Vignesh Raman wrote:
> >> Hi Mani,
> >> 
> >> On 28/11/23 10:44, Manivannan Sadhasivam wrote:
> >> > On Tue, Nov 28, 2023 at 09:50:26AM +0530, Vignesh Raman wrote:
> >> > > Commit a2458d8f618a ("PCI/ASPM: pci_enable_link_state: Add argument
> >> > > to acquire bus lock") has added an argument to acquire bus lock
> >> > > in pci_enable_link_state, but qcom_pcie_enable_aspm calls it
> >> > > without this argument, resulting in below build error.
> >> > > 
> >> > 
> >> > Where do you see this error? That patch is not even merged. Looks like you are
> >> > sending the patch against some downstream tree.
> >> 
> >> I got this error with drm-tip - git://anongit.freedesktop.org/drm-tip
> >> 
> >> This commit is merged in drm-intel/topic/core-for-CI -
> >> https://cgit.freedesktop.org/drm-intel/log/?h=topic/core-for-CI
> >> 
> >
> > Okay. Since this patch is just for CI, please do not CC linux-pci as it causes
> > confusion.
> 
> Agreed. More on-topic for linux-pci is what happened with [1].
> 
> We've been running CI with that for months now to avoid lockdep splats,
> and it's obviously in everyone's best interest to get a fix upstream.
> 

Yes, ofc. Right now we have 2 series/patches to fix the locking issue:

https://lore.kernel.org/all/20230321233849.3408339-1-david.e.box@linux.intel.com/
https://lore.kernel.org/linux-pci/20231128081512.19387-1-johan+linaro@kernel.org/

Bjorn has to choose one among them.

- Mani

> David, Bjorn?
> 
> 
> BR,
> Jani.
> 
> 
> [1] https://lore.kernel.org/all/20230321233849.3408339-1-david.e.box@linux.intel.com/
> 
> 
> 
> 
> >
> > - Mani
> >
> >> Regards,
> >> Vignesh
> 
> -- 
> Jani Nikula, Intel

-- 
மணிவண்ணன் சதாசிவம்
