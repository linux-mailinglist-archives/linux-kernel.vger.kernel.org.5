Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E6F7D2B66
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbjJWHev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWHeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:34:50 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15304C5;
        Mon, 23 Oct 2023 00:34:49 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-692c02adeefso2179646b3a.3;
        Mon, 23 Oct 2023 00:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698046488; x=1698651288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNHvNCMF2wxiaTJVyfL70dE/gTs8mPi0LcdMxHhUWS8=;
        b=N/cOS+QBIildcl/Pyf8IkeXCwnH07m65Zl1dsU8aVZNk364oBd899m/B+K5K76GLgh
         ojSfFcb7dxvxwSoOzFKHjMouXwrVgKGQiB2/mQU9lI6LRs2VL7oF6/KGhSa3edf/gcAA
         N6Qidt+j/m1qDGh5QhrDOkvYwY0mgAKGy257a3iWCNbDbossnOBiH4dMW07GC/plIpJo
         QWWy8Lw/S0PDRJq6Nsx2nU6HekIUJGBvZ6BXdlNuT+1EV4UXlVSZ44Mkqj65lN7AFqQn
         zDxwtDa8G2r17OQgQaNS6Mu4WAhmN7QzF6ysvvFzXsHPBjH3LiGiV4yJOgmf6yR6urzw
         mDwg==
X-Gm-Message-State: AOJu0YyDnoWETAZagZc2X0KChAABrudeK2Eodpl4MTFxcon7oXUK4YhB
        8CLQ0WCZnqMe3qYQDMxPFbI=
X-Google-Smtp-Source: AGHT+IHEHmHNly0aQSTqQ2TahHnMt3hTzjw7PMX1w+bLZIabNay0cla7WqZQmrEK2e86XfWJHj70UQ==
X-Received: by 2002:a05:6a20:3c8c:b0:151:35ad:f327 with SMTP id b12-20020a056a203c8c00b0015135adf327mr7117406pzj.17.1698046488298;
        Mon, 23 Oct 2023 00:34:48 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id x184-20020a6363c1000000b005897bfc2ed3sm5205285pgb.93.2023.10.23.00.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 00:34:47 -0700 (PDT)
Date:   Mon, 23 Oct 2023 16:34:46 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the pci tree
Message-ID: <20231023073446.GA593739@rocinante>
References: <20231023110556.6f704b95@canb.auug.org.au>
 <TYBPR01MB5341114CB14098217765790BD8D8A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYBPR01MB5341114CB14098217765790BD8D8A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > Hi all,
> > 
> > After merging the pci tree, today's linux-next build (x86_64 allmodconfig)
> > failed like this:
> > 
> > ERROR: modpost: "dw_pcie_write_dbi2" [drivers/pci/controller/dwc/pcie-rcar-gen4.ko] undefined!
[...]

> However, I completely forgot it...

That's OK.  Don't worry. :)

> https://lore.kernel.org/linux-pci/20230926122431.3974714-8-yoshihiro.shimoda.uh@renesas.com/
> 
> I confirmed that the patch above can be applied on the latest pci.git / next branch.

I will take care of it.

> However, should I resend whole patches with the patch above as v26?

No.  There is no need to send another series.

Different question: aren't RCar systems based on Arm?  I wonder why this
even built on a x86_64 - unless I am wrong about this.

	Krzysztof
