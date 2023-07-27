Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861E9765535
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 15:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjG0Ngt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 09:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjG0Ngs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:36:48 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A922728;
        Thu, 27 Jul 2023 06:36:47 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so127003a12.0;
        Thu, 27 Jul 2023 06:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690465007; x=1691069807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xOaiTAn8rGdkF5zlwNwyGQldTdN+p5xKE7WTqru15pI=;
        b=pMLpHBb6BmMtboe1C4sJxIkYr8dNkmU+gKItdL4KdTIAwZPMTR2WEHApDlsNV/exj1
         vy0HrrjjphyqbyWiPKGTuaxEYwpOglO2en25CdqUE9j5dhZ2a59goHyfmFznLDJueic8
         Ftx/ZuOfCZHWqLSYtBEVxldkYBeqd0YopDBzFV/paNo8mbOFGRNRgi9/5tupwMfANpMu
         Df5wCQmmFutdRrUMGt0Ju9G8B7vYQyrMyTlUYpmo1Vx4/K6QxFP5PUyUNLbfG4gtky2Y
         diAvLRVMBLWfPAkZ1CxES0UoHywH5CDidcKxVnCputXmfMZgTGXQesEw+D8ECKrNFyrc
         ZtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690465007; x=1691069807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOaiTAn8rGdkF5zlwNwyGQldTdN+p5xKE7WTqru15pI=;
        b=XuncTDNiJJMMnenuVaL7XM87dP7qbbFITrDHRRc/yffV8+gkRWYJn9e5MgmVk2UyRa
         d6fIlwtGFTND0xFfPMaDEEexFhh2aDaUCss2o0alIwdJhKUaMh/ArWOGzDpHs4fXbep+
         s8SeWTV1jMOgNFSbxQISBGzbh+0pqGPp3MDa6sNI534lDm1LzgdDS7h7syzq64fm6M1z
         lAVajiySOhyoU0ZmmELatNuvIYjodNgQuJ2Iqaj1pf12qqnRhU4IFagzZch0GTV4FUWL
         YItLb3Q6e37VQfMK2i1x44DYw1RHwR0a71dl5WnnpG+68327P3SOe50U2QFImND0Oswn
         TyJQ==
X-Gm-Message-State: ABy/qLZlY4SoZnKS+TLeyMbazxUlB+KYHR0UOL3qd7tGjhSMzWVEv1c7
        nFFgsWHJNqvz3K4XLBONkUg=
X-Google-Smtp-Source: APBJJlHCafwH9S3OPhpqA+8W7Lczg5j327l0RTvLcvMbx0d1mOFIr6oHUvQ+C0fUqmdUivM04gTd/g==
X-Received: by 2002:a17:90a:1189:b0:263:f36e:d610 with SMTP id e9-20020a17090a118900b00263f36ed610mr4812722pja.0.1690465007141;
        Thu, 27 Jul 2023 06:36:47 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id fy16-20020a17090b021000b00267f9bf21ebsm2899810pjb.0.2023.07.27.06.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 06:36:46 -0700 (PDT)
Date:   Thu, 27 Jul 2023 06:36:43 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        patchwork-jzi@pengutronix.de, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] net: stmmac: correct MAC propagation delay
Message-ID: <ZMJy6yt4CL250x6Q@hoboy.vegasvil.org>
References: <20230719-stmmac_correct_mac_delay-v2-1-3366f38ee9a6@pengutronix.de>
 <ZMGIuKVP7BEotbrn@hoboy.vegasvil.org>
 <729dd79e-83aa-0237-1edd-1662a6ae28cd@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <729dd79e-83aa-0237-1edd-1662a6ae28cd@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 09:20:10AM +0200, Johannes Zink wrote:
> Hi Richard,
> 
> On 7/26/23 22:57, Richard Cochran wrote:
> > On Mon, Jul 24, 2023 at 12:01:31PM +0200, Johannes Zink wrote:
> > 
> > Earlier versions of the IP core return zero from these...
> > 
> > > +#define	PTP_TS_INGR_LAT	0x68	/* MAC internal Ingress Latency */
> > > +#define	PTP_TS_EGR_LAT	0x6c	/* MAC internal Egress Latency */
> > 
> 
> good catch. Gonna send a v3 with a check to and set the values for dwmac v5 only.

AFAICT there is no feature bit that indicates the presence or absence
of these two registers.

Are you sure that *all* v5 IP cores have these?

I am not sure.

Thanks,
Richard
