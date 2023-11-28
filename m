Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE46D7FB21E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 07:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343651AbjK1GvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 01:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjK1GvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 01:51:06 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903FF113
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 22:51:12 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6bd32d1a040so5110202b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 22:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701154272; x=1701759072; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uBQiDTGElGC/iQuipJvaEvquIy+irMHsbVUaQJuQwC4=;
        b=oC2BWySdg2uYob0IRI+M8ezMLlQsG62loSyygbvzxmBG5nJmEhjukn/C79pTqfK0Tc
         lBb7noCXoB3E8Plwq0+bNt1ZZ8vyE/uEmmZfhLU71BZoY5PA88uThki8LOQ65aRXtUBK
         iJX6qk8tKWxt14y0QacEem1DFnhJPu798e36yPTRzY10wGdPs4eYS/EXuwa3JlFGukry
         /CUMHa6ZeWl/oMLaCLjiMqW35rlHRtohKSvrsfVsOy7i2aye6+Gj8mDNbjB5hko/uIV3
         XpLlpHulgLV71wGH8Y/HuFI7QuFiue8/M5X/mNFShGoCErYOallx7r1pffVRGqCIMjWl
         xuog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701154272; x=1701759072;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uBQiDTGElGC/iQuipJvaEvquIy+irMHsbVUaQJuQwC4=;
        b=PtfwIYT5YlYMuxnfy7Nq2AJZoM1PXPJszxbyRbZ5R2zE0GF+rh/Q/8xZF+I/aUVjMv
         ofvzVBhd/zo+yI2G8QeP4Q/OWFXrW+TK7JBjo3EEOPoCUM/gaUTFplhr+RGoG4gZaQlj
         yYy0saHhvUE7GvzLphLGbinK3/6v8/7jCYAL7GBiwUZTMTfkF9T7vGoh+ds3Dq3cseGm
         DKCjcGjEahwsFZli7UDBqCn0CZU2y6jf54gQlv1tWz4ZGTgJV4eAX0LOlrUx13qsi18O
         cXh9oaRSMbjXu45IQAW5qrm5eabLLWRdwlMhGcyYKFX3wXDppjw3uOrwn3NyB6Dsyzw9
         c8Ew==
X-Gm-Message-State: AOJu0Yxewe9FHSen5yynMqcCm7nIDz9Gm9VDsjjfZ+tFMftICVp1hcOL
        vx9Y35KayaeGl8yo7lVR4rdj
X-Google-Smtp-Source: AGHT+IEnvI4ydDHNEQqF42I/aL26b1A2O/ZB/+msey5Q3lR6xnG7ljDsBqZEJiYNuUCIne2HrUUoPA==
X-Received: by 2002:a05:6a00:a18:b0:6cb:8a8a:4bb6 with SMTP id p24-20020a056a000a1800b006cb8a8a4bb6mr16162259pfh.11.1701154272009;
        Mon, 27 Nov 2023 22:51:12 -0800 (PST)
Received: from thinkpad ([117.213.103.241])
        by smtp.gmail.com with ESMTPSA id m22-20020aa78a16000000b00692cb1224casm8293437pfa.183.2023.11.27.22.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 22:51:11 -0800 (PST)
Date:   Tue, 28 Nov 2023 12:21:04 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Vignesh Raman <vignesh.raman@collabora.com>
Cc:     intel-gfx@lists.freedesktop.org, helen.koike@collabora.com,
        daniels@collabora.com, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Fix compile error
Message-ID: <20231128065104.GK3088@thinkpad>
References: <20231128042026.130442-1-vignesh.raman@collabora.com>
 <20231128051456.GA3088@thinkpad>
 <50a9f061-e1d3-6aca-b528-56dbb6c729d9@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50a9f061-e1d3-6aca-b528-56dbb6c729d9@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 11:44:26AM +0530, Vignesh Raman wrote:
> Hi Mani,
> 
> On 28/11/23 10:44, Manivannan Sadhasivam wrote:
> > On Tue, Nov 28, 2023 at 09:50:26AM +0530, Vignesh Raman wrote:
> > > Commit a2458d8f618a ("PCI/ASPM: pci_enable_link_state: Add argument
> > > to acquire bus lock") has added an argument to acquire bus lock
> > > in pci_enable_link_state, but qcom_pcie_enable_aspm calls it
> > > without this argument, resulting in below build error.
> > > 
> > 
> > Where do you see this error? That patch is not even merged. Looks like you are
> > sending the patch against some downstream tree.
> 
> I got this error with drm-tip - git://anongit.freedesktop.org/drm-tip
> 
> This commit is merged in drm-intel/topic/core-for-CI -
> https://cgit.freedesktop.org/drm-intel/log/?h=topic/core-for-CI
> 

Okay. Since this patch is just for CI, please do not CC linux-pci as it causes
confusion.

- Mani

> Regards,
> Vignesh

-- 
மணிவண்ணன் சதாசிவம்
