Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2218E79D3EE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235984AbjILOlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235901AbjILOlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:41:12 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFB310D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 07:41:08 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-577a98f78b2so455662a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 07:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694529668; x=1695134468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7IA9vO5OF4PfvbjWyLsSgk3yi/uHzp9q+67eqvoiYFs=;
        b=ccSMZ1+gT7HzhJ83pd8JAaRBvIuyeNDQP3gNephwYBViaMutUkRqgRMNAmj/kQYzQk
         3pqX4mBv9mwWAv45zfyS3u+KVn05SxE7tCqRKNJzEuz+A956jEzehUiAQfvjQhIh4UKJ
         K9SHR7F7DmM5izZL2oNgPgzHbuXQtwCzUHrlLbHlP0a5nCwVKRZioZTTXbM3gehporUs
         hMPv+JA9KskKPBJKDn+h3cHfWw5laaJ8m+HeDM8lxUrvQwQYT85LOMVJRuVajAKs+f0b
         oEjWnkA//Y55uXGoATRNrtFK/AwGRvfryMr3y5vqwxbDs9a+ebgHinicC14q4WcGn9bl
         VaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694529668; x=1695134468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IA9vO5OF4PfvbjWyLsSgk3yi/uHzp9q+67eqvoiYFs=;
        b=q3W8KENZJ1OTX9SI8WYMI+aJeBPY8ppiScOAo7d26XmeOFnWDUT5imfL9lVZG9AWDg
         npW9GG7rWBiVdq9k74UfBPDtVx2wm657VVOBE+IMTMa0oUoD713NDopelfoauqukoIT2
         RlENx+qXtRqaZF9Ef+RNtzS+8+QGWcmL0IkWNNLSGkeuQj3xM3s9gIkPltEQ3rc/Og6o
         IEWqDFLO49D0fAsX3qknWed55ugBGuJsPO0eby+FeiXUwGBz5hPj5p8JEi9XIysSf1w+
         meuHwWPeV2imKyHvrLibI2W+RBqUoKeTdsqShHNHjSoYpBK5+s0GBWWVsLGqyhM+H13P
         xg7w==
X-Gm-Message-State: AOJu0YwSJ3TrzvttBiKmO805clHrEdGKV0sNMuOltJQ/BFj2mAskKrR+
        pzcXRLJqJ3i+MXrgHsH/PMDhLw==
X-Google-Smtp-Source: AGHT+IGI9zf7neD/ytF0XaIRN6SetT6z4G2tT486Bd7sTiE6fcv43FJe/iFhqQFbhtCjZimu2u4lgw==
X-Received: by 2002:a17:90b:909:b0:271:a9b2:5162 with SMTP id bo9-20020a17090b090900b00271a9b25162mr9472055pjb.27.1694529667739;
        Tue, 12 Sep 2023 07:41:07 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:ed04:a14b:64d6:aece])
        by smtp.gmail.com with ESMTPSA id x3-20020a17090ab00300b00268b9862343sm5377469pjq.24.2023.09.12.07.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 07:41:07 -0700 (PDT)
Date:   Tue, 12 Sep 2023 08:41:04 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-imx <linux-imx@nxp.com>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>,
        "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
Subject: Re: [PATCH 2/2] arm64: dts: imx8mp: add reserve-memory nodes for DSP
Message-ID: <ZQB4gMyfJK9sFXID@p14s>
References: <20230911224452.15739-1-iuliana.prodan@oss.nxp.com>
 <20230911224452.15739-3-iuliana.prodan@oss.nxp.com>
 <67de5706-d966-dd71-85c3-c95bc1b72733@linaro.org>
 <c0b32f41-46b4-81ad-9718-5f0856e42cb1@nxp.com>
 <32287c0a-e3c1-e474-3c90-913fe2c79879@linaro.org>
 <fe47a94e-6788-a5ee-e8ee-ca58e4fa62d6@nxp.com>
 <af1959ce-d817-2a9e-9c28-fed8c608a3df@linaro.org>
 <dc402d33-88b1-e828-e6a5-2de060fbcdca@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc402d33-88b1-e828-e6a5-2de060fbcdca@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 01:51:42PM +0300, Iuliana Prodan wrote:
> On 9/12/2023 12:36 PM, Krzysztof Kozlowski wrote:
> > On 12/09/2023 10:49, Iuliana Prodan wrote:
> > > > > Should I test this on other tree(s)?
> > > > You test the patch on the tree you send it. What is the point to test it
> > > > on some old code, cherry-pick with bugs and then send?
> > > > 
> > > > If you have cross-tree dependencies between subsystem, isn't linux-next
> > > > for this?
> > > TBH, I don't know, that's why I asked.
> > > 
> > > For sure one patch is for remoteproc.
> > > For the other, I don't know who will pick it, but I'll tested on
> > > linux-next, as you suggested.
> > MAINTAINERS file (and get_maintainers.pl) will tell you. Specifically,
> > this does not look really related to remoteproc patch, so it should not
> > be together in one patchset.
> 
> Hi Mathieu,
> 
> I need to send a v2 - to fix the dtsi missing bracket on patch 2.
> So, should I keep the 2 patches together or send them separately?
>

Marco is already aware of this patchset so I would keep them together.

> Thanks,
> Iulia
> 
> 
> 
